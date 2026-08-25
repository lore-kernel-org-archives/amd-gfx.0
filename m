Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184EEC61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 20:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE2410E199;
	Tue, 25 Aug 2026 20:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4294jtn+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D38B410E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 20:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uorJJXc+YiqZAihMBwK9o7jGo2yHcB/5xiTxStacbZSc87VPgLMZd8VO2+62R1h/HRMuXq9ORKDSGTRoqRValiMyWKI1Dv9MGDFruCDTdcYnUlsbEU5ax34wqgrfYgM6gpKqriHURYNNo2RklPEufV8ZCpFvnt+ZrX4AetfD9TrMKgZU6etCWIxmQ/hFij+Rjco44jEbYtDYw3JSj4uqBM7HPD7h+m+EjDk6ZD1KMTFf3CFPGEb7LHZ5DWYG1iWCx5VYzkOnnw2tsYYc0a4nUXRuN74P7FLw1uB9+tggYaL1rww+SN2WEwS1ga5pngJYh9NQeF1IznP3/kWqNhcxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz3XdjaqYuTV8/0v8kRymgXOACVIup26SdU1oTE6sEg=;
 b=e+Y1uhHbeBXG2Mj8fVzfZEhePNGWT00ov2HjVtC76PXqny3ztnG1zYGc+n6XqbXMBMPiATPc4m5ovUJkKV2LizwsnKd+ZFU36mKkgoKhO98Z1Mcfj/6nWzdSfVAAEHhRWR7x5/V6cLdTvsOlJamZo/0xvbpjOCKgcuUjkeoacPAXGPfY+ac5+bQvh7K8mWCSPEbv5AHDFxUyVhlf+YATOxz8s+5VDxuw5adg3zYpvC8Mj/283V8XvkmvGmjmT37GfxWU5cH8twioKrzbXsmtYTcNsjlEEVh9DlZ88nu+oUGLzvxuWSRitaJlHvnhPFM6eXyZCsfEyHiv2kBKREywWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz3XdjaqYuTV8/0v8kRymgXOACVIup26SdU1oTE6sEg=;
 b=4294jtn+3nCRZxlvTXJSznccCr7G42yWQgsAIVDV77I6an9iu+kRhOzPBnStdd1yiHugoGU8FGuQesmL02pefhPdHdaRS1zuWQH6ZhGjZFqvqVsyJbadRQvotEjYTGr3DTWWGtW0JW+TzSHNT+sDk7x0GvuMUK6/AvA1sfTBrUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ0PR12MB5635.namprd12.prod.outlook.com
 (2603:10b6:a03:42a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 20:02:52 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 20:02:52 +0000
Content-Type: multipart/alternative;
 boundary="------------NOrstSWoQ50HOLztywiHL0jw"
Message-ID: <6121d230-de95-4a19-b38b-0b6b5e122318@amd.com>
Date: Tue, 25 Aug 2026 16:02:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: gfx1100: KFD leaks process VRAM after CP fault during AQL queue
 abort; device unusable until reboot
To: "michael wizardsound.com" <michael@wizardsound.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
References: <SN7PR03MB72594F097881FCD1633872C8A2AF2@SN7PR03MB7259.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <SN7PR03MB72594F097881FCD1633872C8A2AF2@SN7PR03MB7259.namprd03.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c0805e-9df0-448b-e1fc-08df02e3d894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|13003099007|6133799003|56012099006|10067099003|11063799006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v6r2wes0LTqfRziBJQBVXIuI8H800bzFzi1r6gMb3hm/qncp30cAgHklF+rWzoAJCt4Hk+jXXx8GkIszznKAKQ9N1yxPCZi8frkPF6F9Fnw9guOnDsWyfyCKDOXCWu7vkGKxpkg1Q7H/mKQ6VwmPvzqgRpH0XOER8Q2rwtlGTmUmAXiQb49nNnUmGtlNxSDYNbJUdek/NfuhRGGunviVhwBB2ZSZ5nk0OV9jwTOg8BIsbySVY8c8K15VJKai4ITQ96xsD1OYFho9C6/aNsTU513INgQWG4s+aozwzCXah61hSUAornCIK1q8cLD4ijxRXJ6xRQvS7iztsPb6iV9gBx5nJ7JTtgOOMkudQBwoWQbfwWqjwRtX0KF+cdr1dgIz1CDG76U/BwOzkBSFnrl0uu+pT017kSJ4qZeZnJga6p4ghaiKKv1QUnVAY+MPGz1snZe9HO59aNttCf2ieNX4ZrCokV2Jcf675lVV/2inKBsXa+Itr7MeJYojXDiwIbb6EZDrlMTTW0+JmRQl0w5ZLXqrtv4LbmVK18RiH1KnKsaZ8v238IkD5d7GHn/6jyl+xUyiL01lvmNNwP42TJ3a9saTiVhYlo4CxlO/Xpj7yOKQeuYkfN/FGgvr8LYH7Xow2NNZ0JspjAL2wU+Y/OSWC1JzNj7IO/AHdhV3PjYUeFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lMSWtMbk1uSEV0ZHh0RDVWMmw5V3Z2c3U1UGcydTFUMmNiclR5S1B3Ynda?=
 =?utf-8?B?RXU3aGRWMHhwd1QrcGRYdEEveFNYWC9MRHNBaW8vekdzaVRRUUIramlpODJB?=
 =?utf-8?B?bkVpZUNsb2xnWm9GV2dpK3c2QkErc3BTcnJaeSs3TVowcmVaUTJJaVErUzNu?=
 =?utf-8?B?U1huL2JkQU1NalhPYlNiNE13RDRpK1hyQjkyc2lMSEVPTjY5V1ZOWndJdE4w?=
 =?utf-8?B?QmVGN1BhdGlxOVhSckFlVmt1aCtoZFdwWUUrQzBlSEpDMGdmcldOVGNldXN3?=
 =?utf-8?B?RUY5SFVmZllKSU1Fa29CMTBJNmRPUC9oRXo4NlMyNVRJeG04Qi85YmJvLy85?=
 =?utf-8?B?VXlvYUlGSWU2Vk5jdndsOVdWelV3dzEzNEtlcWZwS2oyejE4eWJZMkZCYmVY?=
 =?utf-8?B?a2ZHcjhCOHEwNzFNOExtT2dqb3JhVDdyZHBzY0h4VEhRdm0raENRMHlycVlz?=
 =?utf-8?B?NW5IN1ozSmhKWDBkcXhmWmdOd1cyaG8wcUNLSmVMSS9uTFJLRXcwaUZYLzlQ?=
 =?utf-8?B?QWlkd0laSTd2azdLejBKZ3prTU5ubHRMc2tTcXlxbmpKNitaL0xxOTYzNFoz?=
 =?utf-8?B?RkRLN3dPdUhDelRJTG5JdGdnM3paRk5JSnBqNW9nall2Rm1SeXVOYTZ6NFEy?=
 =?utf-8?B?cXg3Nm9lYS9wdnFzdjVtVGM1cWp0YlQ3R1o2UXE5RHZDWDZJYUZJSWVVZ2V0?=
 =?utf-8?B?NElpVUZ4WkhIc0R1TEJVSDBubitWcjVPVDBjTEl4Mjg3NTVmS2tta3lQejUr?=
 =?utf-8?B?QUVrVEFvcHZqd3FRaWZ5eGhPcGh6bXZzQnFTcDd5WGs2RjFBRFFJakhKSTBm?=
 =?utf-8?B?OGY3eDQvdklUc3g0dUFDS0ppc0FWS1lUK3B4bXNTMzZEZ093ZzNrSDl6bjRh?=
 =?utf-8?B?SGtYRTREMDBMaEdWZW1USWNMd3M2cnR6QWdpOFU1Z1drbGZBZlFkRjIzWWMr?=
 =?utf-8?B?dElhTmZrN2RPZ3BKb0dGSjZRbFJMNnRQVlkyMTYxcWRYTWVZTXJiZVdVNUxK?=
 =?utf-8?B?NEkvdThwV2tOK2ZOR0l3dERYYVU1Q2RzbVlER3VRNlBVMTF0S2RNRXhFUUtn?=
 =?utf-8?B?SlMwcmxaZXF3YngrRzd0WHJGcWZteHlVRjh5NmlqTktmdmVkYWFycmpXeXpJ?=
 =?utf-8?B?enl0dmtrQ005TThHblFXZnBDdXM2bmV1L08vbzFqUWYvb2YxM1VkajFBMW8y?=
 =?utf-8?B?RE9NNlozd1RZaExCVU5KOG9GYjczcGhpMmFvNjVQZnJpSDY0VTJiTnVodzJ6?=
 =?utf-8?B?SHh0VDVzcFoyNlF0M0NEVWlxRk9JNW5RZXhiZFJGS2N6WnpTZG9uNjBiaTVK?=
 =?utf-8?B?clBCWm41N2l5VG1ORkRJWUlRcFFwM1hHVWxGYlNOUVlUYThrdyt0d2pUcjAv?=
 =?utf-8?B?ZnQzRUxqZmdWOTZNZlREb1ZZbGFKNEN1UDYwdXkxNW5qWnBQajZFdndUdldV?=
 =?utf-8?B?VTI4S0p2MFo0a29CRTJjNW9Yby9uZEpueTduS2x1SHJlWEw0QWxYaFFHM1hY?=
 =?utf-8?B?V0p4QjN3TDA0cGhFcEhtWGh2YWt6VkZjWWpOWDdkUDhLT0Y5dCtSNFlvV3ZG?=
 =?utf-8?B?VWpHV2pZbEhvSmZQL1N5ckowZTk4dE9pUlMxQUdJbDVFNVBQU3ZzMTBmazdo?=
 =?utf-8?B?cnp4cUxRM0RyeWRKMmNwcEYyNS9FbFpLMExHYW5xRHBOeFNlOUNyZ3gxbGs3?=
 =?utf-8?B?SU9jSGo0YUd5ZzRCcHF6YW1NYWpNWFRUazNHcG1FUjB6YUdQazB0Zit4dWVW?=
 =?utf-8?B?SklTeVZMRGROZVRmM0JwTTI2UFZVY1h5Nk9LT2FlODFlbTBLRmhjTXlHUUdu?=
 =?utf-8?B?NlhmdVFCcWg0N2w3TmhnWGxYODU0QzZlT0c5d3dkaTBBMmkyWTJLRzM4M0Rs?=
 =?utf-8?B?Sys5WXp4akNHdjM5TDQvcTJ6MnVzWnkvNmx0ZmFEWmhvQzhXWkc1T3NwN1dj?=
 =?utf-8?B?K0g2NWp6Z2gxMW9hczNnMVNOVDF5Y3U5bXZDQldmU3hZNnFOVm9pUDhndHJG?=
 =?utf-8?B?b2krcDZudnU2UUI2SXRxbGE2aHpmaHlRMlFvbHI0UGJFSkg2OFltZmRzWU5E?=
 =?utf-8?B?UE9FMFM3Nk51OFNjaklTWW5KcE9qdjRUb1lKRnJiTTVZS2NBN1lVeXFJeGZ0?=
 =?utf-8?B?c2tuVkF1L3dtVWkyQnV5eUlJQzR0UGhmNnM0ek5Bb1E1WE9mQ2N1azU3THBp?=
 =?utf-8?B?YnVoalRjdXBreUpUa2tRbEN0UjVDaG8wMk9PWlRmRUlOU2ZZUGdiM1BwdVI1?=
 =?utf-8?B?UmFka3VuYURFK0xnZDB0NkdiWW1ROUlUK05YRjlBMUgwenhvNFVpbGhwQjFX?=
 =?utf-8?B?RmZITC96TkNxaHdnL3JBS056QXhMUS9Ld0NMeGVKN00xWWE5RmM3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c0805e-9df0-448b-e1fc-08df02e3d894
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 20:02:52.5618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpwJ6e8l3+nGqN1KIy0GDW+63emXpJNW9ExElYyDp45nzHAZxa1dwFpQGRO1UrQSNOfSi7ZQ6M6YyfFE7sPzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------NOrstSWoQ50HOLztywiHL0jw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNi0wOC0yNSAxNTozOSwgbWljaGFlbCB3aXphcmRzb3VuZC5jb20gd3JvdGU6DQo+
IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdl
dCBlbWFpbCBmcm9tbWljaGFlbEB3aXphcmRzb3VuZC5jb20uIExlYXJuIHdoeSB0aGlzIGlz
IGltcG9ydGFudCBhdGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQo+DQo+IEhpIEFNRCwNCj4NCj4gSSBzdWJtaXR0ZWQgc29tZSBmaW5kaW5ncyBh
bmQgSSB3YW50ZWQgdG8gc2VuZCB0aGlzIG92ZXIuICBJIGhvcGUgdGhpcyBoZWxwcy4NCj4N
Cj4gT24gYSA3OTAwIFhUWCBpbiBhIFByb3htb3ggaG9zdCAoa2VybmVsIDYuMTQuOC0yLXB2
ZSwgUk9DbSB1c2Vyc3BhY2VzIDcuMi54LzcuMTQgaW4gYW4gTFhDIHNoYXJpbmcgdGhlIGhv
c3Qga2VybmVsKSwgYSB1c2Vyc3BhY2UgYnVnIChyb2NtLXN5c3RlbXMjMTAwMjE7IHJvb3Qg
Y2F1c2UgZmlsZWQgYXMgcm9jbS1zeXN0ZW1zIzEwNzEzLCBydW50aW1lIGZpeCBwcm9wb3Nl
ZCBpbiByb2NtLXN5c3RlbXMgUFIgIzEwNzE0KSBjYW4gcGxhY2UgYSBtYWxmb3JtZWQgcGFj
a2V0IG9uIGEgdXNlciBBUUwgcXVldWUuIFRoZSBDUCByYWlzZXMgZ2Z4X3YxMV8wX2JhZF9v
cF9pcnEgKCJJbGxlZ2FsIG9wY29kZSBpbiBjb21tYW5kIHN0cmVhbSIpIGZvbGxvd2VkIGJ5
IGFuIEhTQV9TVEFUVVNfRVJST1JfSU5WQUxJRF9QQUNLRVRfRk9STUFUIHF1ZXVlIGFib3J0
LiBBZnRlciB0aGUgcHJvY2VzcyBleGl0cywgaXRzIC9zeXMvY2xhc3Mva2ZkL2tmZC9wcm9j
LzxwaWQ+IGVudHJ5IHBlcnNpc3RzIGFuZCB+MjUuNyBHQiBWUkFNIHN0YXlzIHBpbm5lZC4g
YW1kZ3B1IG1vZGUxIHJlc2V0IHN1Y2NlZWRzIGJ1dCBkb2VzIG5vdCByZWxlYXNlIGl0OyB1
bmJpbmQgc3VjY2VlZHMgYnV0IHJlLXByb2JlIGZhaWxzIHdpdGggRUVYSVNUIG9uIG1lbV9p
bmZvX3ByZWVtcHRfdXNlZCAoc3RhbGUgc3lzZnMgY2hpbGQgZnJvbSB0aGUgd2VkZ2VkIHRl
YXJkb3duKSwgYW5kIHN1YnNlcXVlbnQgcGVyLWRldmljZSByZW1vdmUvYmluZCBhdHRlbXB0
cyBsZWF2ZSBELXN0YXRlIHRhc2tzIGluIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5h
bCAvIGRldmljZV9kcml2ZXJfYXR0YWNoLiBPbmx5IGEgcmVib290IHJlY292ZXJzIHRoZSBk
ZXZpY2UuIENsZWFuIFNJR1NFR1YgZGVhdGhzIG9mIHRoZSBzYW1lIHdvcmtsb2FkIG5ldmVy
IGxlYWs7IGl0IGlzIHNwZWNpZmljIHRvIHRoZSBDUC1mYXVsdCB0ZWFyZG93bi4gRnVsbCBs
b2dzLCB0aW1lbGluZXMsIGFuZCBhIHVzZXJzcGFjZSByZXByb2R1Y2VyIGNoYWluIGF2YWls
YWJsZTsgcGF0Y2hlcyBhbmQgc3RhbmRhbG9uZSByZXByb2R1Y2VycyBmb3IgdGhlIHVzZXJz
cGFjZSBzaWRlIGFyZSBhdGh0dHBzOi8vZ2l0aHViLmNvbS9PaGd1ckxhYnMvcm9jbS1oaXBn
cmFwaC1maXhlcy4NCg0KVGhlIG1vc3QgY29tbW9uIGNhdXNlIG9mIHRoaXMgdHlwZSBvZiBi
dWcgaXMgYSByZWZlcmVuY2UgY291bnRpbmcgDQpwcm9ibGVtIGluIHN0cnVjdCBrZmRfcHJv
Y2Vzcy4gSW4gdGhpcyBjYXNlIGl0IGFwcGVhcnMgdG8gYmUgaW4gaW4gdGhlIA0KZXZlbnQg
aGFuZGxpbmcgY29kZSBmb3IgU09DMTVfSU5UU1JDX0NQX0JBRF9PUENPREUuwqAgVGhlcmUg
dXNlZCB0byBiZSBhIA0KbWlzc2luZyBrZmRfdW5yZWZfcHJvY2VzcyBpbiBrZmRfZHFtX3N1
c3BlbmRfYmFkX3F1ZXVlX21lcyBpbiANCmtmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jLiBU
aGlzIHdhcyBmaXhlZCBhcyBwYXJ0IG9mIHRoaXMgY29tbWl0IG92ZXIgYSANCnllYXIgYWdv
Og0KDQpjb21taXQgODU0NDM3NGMwZjgyZWRiMjg1Nzc5ZjIxYjE0OTgyNmZlMmMyOTc3Yw0K
QXV0aG9yOiAgICAgWGlhb2dhbmcgQ2hlbjx4aWFvZ2FuZy5jaGVuQGFtZC5jb20+DQpBdXRo
b3JEYXRlOiBNb24gSmFuIDEzIDE3OjM1OjU5IDIwMjUgLTA2MDANCkNvbW1pdDogICAgIEFs
ZXggRGV1Y2hlcjxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KQ29tbWl0RGF0ZTogV2Vk
IEZlYiAxMiAyMTowMjo1NSAyMDI1IC0wNTAwDQoNCiAgICAgZHJtL2FtZGtmZDogSGF2ZSBr
ZmQgZHJpdmVyIHVzZSBzYW1lIFBBU0lEIHZhbHVlcyBmcm9tIGdyYXBoaWMgZHJpdmVyDQoN
CiAgICAgQ3VycmVudCBrZmQgZHJpdmVyIGhhcyBpdHMgb3duIFBBU0lEIHZhbHVlIGZvciBh
IGtmZCBwcm9jZXNzIGFuZCB1c2VzIGl0IHRvDQogICAgIGxvY2F0ZSB2bSBhdCBpbnRlcnJ1
cHQgaGFuZGxlciBvciBtYXBwaW5nIGJldHdlZW4ga2ZkIHByb2Nlc3MgYW5kIHZtLiBUaGF0
DQogICAgIGRlc2lnbiBpcyBub3Qgd29ya2luZyB3aGVuIGEgcGh5c2ljYWwgZ3B1IGRldmlj
ZSBoYXMgbXVsdGlwbGUgc3BhdGlhbA0KICAgICBwYXJ0aXRpb25zLCBleDogYWRldiBpbiBD
UFggbW9kZS4gVGhpcyBwYXRjaCBoYXMga2ZkIGRyaXZlciB1c2Ugc2FtZSBwYXNpZA0KICAg
ICB2YWx1ZXMgdGhhdCBncmFwaGljIGRyaXZlciBnZW5lcmF0ZWQgd2hpY2ggaXMgcGVyIHZt
IHBlciBwYXNpZC4NCg0KICAgICBUaGVzZSBwYXNpZCB2YWx1ZXMgYXJlIHBhc3NlZCB0byBm
dy9oYXJkd2FyZS4gV2UgZG8gbm90IG5lZWQgY2hhbmdlIGludGVycnVwdA0KICAgICBoYW5k
bGVyIHRob3VnaCBtb3JlIHBhc2lkIHZhbHVlcyBhcmUgdXNlZC4gQWxzbywgcGFzaWQgdmFs
dWVzIGF0IGxvZyBhcmUNCiAgICAgcmVwbGFjZWQgYnkgdXNlciBwcm9jZXNzIHBpZDsgcGFz
aWQgdmFsdWVzIGFyZSBub3QgZXhwb3NlZCB0byB1c2VyLiBVc2VycyBzZWUNCiAgICAgdGhl
aXIgcHJvY2VzcyBwaWRzIHRoYXQgaGF2ZSBtZWFuaW5nIGluIHVzZXIgc3BhY2UuDQoNCiAg
ICAgU2lnbmVkLW9mZi1ieTogWGlhb2dhbmcgQ2hlbjx4aWFvZ2FuZy5jaGVuQGFtZC5jb20+
DQogICAgIFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZzxmZWxpeC5rdWVobGluZ0BhbWQu
Y29tPg0KICAgICBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXI8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCg0KSSBndWVzcyB5b3UgYXJlIHVzaW5nIHRoZSBkcml2ZXIgdGhhdCBj
b21lcyB3aXRoIHlvdXIgNi4xNC44LTItcHZlIA0Ka2VybmVsLCBub3QgdGhlIERLTVMgcGFj
a2FnZSB0aGF0IHNoaXBwZWQgd2l0aCBST0NtLiBUaGlzIGZpeCBsYW5kZWQgaW4gDQpMaW51
eCA2LjE1Lg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCg0KPg0KPiBNaWNoYWVsIExldmVz
cXVlLCBNQkENCg==
--------------NOrstSWoQ50HOLztywiHL0jw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2026-08-25 15:39, michael
      wizardsound.com wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:SN7PR03MB72594F097881FCD1633872C8=
A2AF2@SN7PR03MB7259.namprd03.prod.outlook.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">[Some people who received this=
 message don't often get email from <a class=3D"moz-txt-link-abbreviated" h=
ref=3D"mailto:michael@wizardsound.com">michael@wizardsound.com</a>. Learn w=
hy this is important at <a class=3D"moz-txt-link-freetext" href=3D"https://=
aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdent=
ification</a> ]

Hi AMD,

I submitted some findings and I wanted to send this over.  I hope this help=
s.

On a 7900 XTX in a Proxmox host (kernel 6.14.8-2-pve, ROCm userspaces 7.2.x=
/7.14 in an LXC sharing the host kernel), a userspace bug (rocm-systems#100=
21; root cause filed as rocm-systems#10713, runtime fix proposed in rocm-sy=
stems PR #10714) can place a malformed packet on a user AQL queue. The CP r=
aises gfx_v11_0_bad_op_irq (&quot;Illegal opcode in command stream&quot;) f=
ollowed by an HSA_STATUS_ERROR_INVALID_PACKET_FORMAT queue abort. After the=
 process exits, its /sys/class/kfd/kfd/proc/&lt;pid&gt; entry persists and =
~25.7 GB VRAM stays pinned. amdgpu mode1 reset succeeds but does not releas=
e it; unbind succeeds but re-probe fails with EEXIST on mem_info_preempt_us=
ed (stale sysfs child from the wedged teardown), and subsequent per-device =
remove/bind attempts leave D-state tasks in device_release_driver_internal =
/ device_driver_attach. Only a reboot recovers the device. Clean SIGSEGV de=
aths of the same workload never leak; it is specific to the CP-fault teardo=
wn. Full logs, timelines, and a userspace reproducer chain available; patch=
es and standalone reproducers for the userspace side are at <a class=3D"moz=
-txt-link-freetext" href=3D"https://github.com/OhgurLabs/rocm-hipgraph-fixe=
s">https://github.com/OhgurLabs/rocm-hipgraph-fixes</a>.</pre>
    </blockquote>
    <p>The most common cause of this type of bug is a reference counting
      problem in struct kfd_process. In this case it appears to be in in
      the event handling code for SOC15_INTSRC_CP_BAD_OPCODE.&nbsp; There
      used to be a missing kfd_unref_process in
      kfd_dqm_suspend_bad_queue_mes in kfd_device_queue_manager.c. This
      was fixed as part of this commit over a year ago:</p>
    <pre>commit 8544374c0f82edb285779f21b149826fe2c2977c
Author:     Xiaogang Chen <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
AuthorDate: Mon Jan 13 17:35:59 2025 -0600
Commit:     Alex Deucher <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
CommitDate: Wed Feb 12 21:02:55 2025 -0500

    drm/amdkfd: Have kfd driver use same PASID values from graphic driver

    Current kfd driver has its own PASID value for a kfd process and uses i=
t to
    locate vm at interrupt handler or mapping between kfd process and vm. T=
hat
    design is not working when a physical gpu device has multiple spatial
    partitions, ex: adev in CPX mode. This patch has kfd driver use same pa=
sid
    values that graphic driver generated which is per vm per pasid.

    These pasid values are passed to fw/hardware. We do not need change int=
errupt
    handler though more pasid values are used. Also, pasid values at log ar=
e
    replaced by user process pid; pasid values are not exposed to user. Use=
rs see
    their process pids that have meaning in user space.

    Signed-off-by: Xiaogang Chen <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
    Reviewed-by: Felix Kuehling <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
    Signed-off-by: Alex Deucher <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pr=
e>
    <p>I guess you are using the driver that comes with your
      6.14.8-2-pve kernel, not the DKMS package that shipped with ROCm.
      This fix landed in Linux 6.15.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:SN7PR03MB72594F097881FCD1633872C8=
A2AF2@SN7PR03MB7259.namprd03.prod.outlook.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

Michael Levesque, MBA
</pre>
    </blockquote>
  </body>
</html>

--------------NOrstSWoQ50HOLztywiHL0jw--
