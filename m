Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3106CC7115D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 10:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FBE10EB41;
	Fri, 20 Jun 2025 10:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLJwxpv+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5CA10EB41
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 10:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STzf0v6b6PAcuYViC1QeuQqDDj567frkCjxlW4OxHZBc+QTuvJRoTs78+l9v0Dk+RBH91jQuv4kroIldjbKculvXHePHVyQx34lWRK/XNwpAfFzjq534Om8/kw6FspBeidWoBPZcK5lujjaTHNVmvY6Ny4bhdgUquENrJjxPo2FVgqE8Ffo3kDPvdt1+UwoVYN/0P1WIvexpFbpJCdR94s0UGTk1fN1YDNbtLfPF/ArzKCKxbPlRfI2kfdVF53W30qByrvNN+FuZFoaBEKFCOELMtaiO66a3Wb9LZkvf8GVuZn2MiDzfOrYoBsvShqK891BSFvZW4DA+1jA390X4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/chqzdy+pSX58Y7Th5RuOKKpl5I6GRABIgz5H7FzzM=;
 b=zOe55w13jRVgErSsO11wOy0rMMscjScKH9bnrD+QXDZkmL0zYS2mWL9VqdvoIp79JZ23HOfevwESdHhN/8Bc7KF8PDHhgk4P7Zrpl7eWJBOKZyd9lPZEnV9d17L4y/KngZmtYfc5xaZKH64XtAyWtgpFuOrdPXKGAjBuTpcNB9HjKRJkRpItbeoNqeTpCF0h5diDbKjLCF4rg3oWIYC+qw/7HQMjKT44Z671OKcvozd/HMZF9ElquNZcJmD1dZnDLv0qW7qEofOq2WFhyPU94k2oiL0StGecWrtiE4nm2uCW3hVA9xLTrQ62tS0aJqBDg15yEzcOX83xszjPtViP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/chqzdy+pSX58Y7Th5RuOKKpl5I6GRABIgz5H7FzzM=;
 b=HLJwxpv+h4ucGkDOmYvCe5o4Oh9zPnDQGLS3PRLwLLYA+cS7KfX7+j+b1xKsQEko6h6Gm8Y7gXtr0X4nYfXLCDQh7wPu5txl4LVhXjfCthZxBX8T/K6gUD8rssXIrXZs0l0vN6r+Bmu9lkvmsbB3saE+dNo14Y1QoYD2d/Yfif0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Fri, 20 Jun 2025 10:39:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Fri, 20 Jun 2025
 10:39:31 +0000
Message-ID: <c9ee4d71-2db6-4636-8376-a8dc53b29dd2@amd.com>
Date: Fri, 20 Jun 2025 16:09:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>,
 Mario Limonciello <superm1@kernel.org>, bhe@redhat.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
 <20250618092625.GE1613633@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250618092625.GE1613633@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1b1c47-ac48-4fbe-fe45-08ddafe6bd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rkp1OGlrYThsR1VBbjRLM2N2U1N4WFNubW5ncUZWVnBTajcyT2RhbzBsSGxi?=
 =?utf-8?B?SStHUlV1Zk9jMlJSQVZZTTllbWt0R2tOUVNUQWhoRUpWVFgzR012bnd3RFVW?=
 =?utf-8?B?YjFJV3VTSmJYbzQ2Mkw5Sm1VTVc2d0NqKzVtNWVCa1dOZkZkSXJzN3NPVFlj?=
 =?utf-8?B?N1ZnUzd2b2ZGdU5LSHRlU1M5VFJxUmttQlM3NjNkczVQazhxN0hCbFhUOWFh?=
 =?utf-8?B?K2dhbmw4Q1hZM0JieUJvMEgxVzdzNEFOL0NiWnJCb3FpWkRTOUl0bHdUWG9w?=
 =?utf-8?B?akRodHlCUFpuREZaaW90UklRYmxqTTBlV3ZRWkozN3FWOFN1U3A0djlZUHgz?=
 =?utf-8?B?YVFGYVJWd1QrWmtTOGtGc2d4b1BzTW1LdlNqSXFUaGJqbHd6RDR6bTF3QWF2?=
 =?utf-8?B?dThUZTJpT1dRMDhtUVpiZno4VkhQcGpqRWplKzQ1dU1pNWFKWCtrM1JkWkFl?=
 =?utf-8?B?aEF5SDdocHZJZTlWdTQzQ1Jna04rUkcvUkhqWG1Ld21KcC9rTlM2QUZOS1Bm?=
 =?utf-8?B?RkgwWkt3c3JQUUtoc1FacXlOSlA0UU9pV1hvbGtOYzhubmk3RFVpTmV6OWdt?=
 =?utf-8?B?M3ZiSGF4WExkdURCOXpGSmJrQkhEZFgwd09JOWZZTVJsZWh0bEUyQkxTQkhB?=
 =?utf-8?B?dTZCTFFySmNrcUI0TUdqQ1VRUmxzbGdiSmpjTTRpVHAzM0IrZ3gwYmY2MWZJ?=
 =?utf-8?B?Y0pWQitjako3V0s1TUd4b05hWmNxQTYrR21jL2pqa1dEV29qbjNLc3VQU1BS?=
 =?utf-8?B?Vk5GQm9uZ1g5eDZGVU5EeTk0RDA5a2Q3SXAxRGMrdUZqK3VWWlB3a1l3NEs5?=
 =?utf-8?B?K0tpSFdyVzJoTnFIMDI3dDhNYmRDNHZvV2pPWmJad2k0dVdOa3JHWktXVHYy?=
 =?utf-8?B?QmhDNXhiRVpNYzJKU1lCWTlmUmxZRjVIY3R5WElEUkZUMmo5TFdTTmQzc292?=
 =?utf-8?B?MHJCamRFd1puYWF0eE8xcGRhRnQrS3JBZmk5T0M0WHhBYjI0MDlxUnZSOXZC?=
 =?utf-8?B?UGFxSmpCRUFtRE9RejlwdDdzS01BN21KTGhBTi9SbjZrYmNZTjVJcXBHaC9X?=
 =?utf-8?B?NjhPc1pmNGtieGpSLzRxRndLRmxNeTI1YzJ1enlqZkVlRWZpd2ZDMm9YaUF5?=
 =?utf-8?B?YkUrdWZ0WDFuMzBxM1drTjR6VTdBS2tIbnE0d2xmVjRUanpFd0pKL204cFNO?=
 =?utf-8?B?eVB4ZnZQajNiTE0rZkN6SFBKUWQrOGJkQmRqNFErRXJ0ZzZJdHNiMGRJQ0pI?=
 =?utf-8?B?TVppdjF3OHczbi9US2dkQ2FLdE9SUngxMWdRVzF1WVRmelNtKzE5TEg2QXZt?=
 =?utf-8?B?K1BpMCt6dzJ6N1A4dWtSVVY0RmIxWWFBanlvVVQwamVlN3p0QVVGQ0YrOEQ5?=
 =?utf-8?B?NHZ1WVAzbnhwS0pKN1JmTXlVeXpxbVBSSlJ6NnY4OHF4Q0Y1UEFjeVNneFBt?=
 =?utf-8?B?RHF5WmtRb093Rm1jT1JDS0luSHBNMTAwWkVFaENZUnRZVnY2Q3plSjZUdVhk?=
 =?utf-8?B?MTJMeUxyYkZOY295ZnBUV0gxcE9UTHBQV2k5YXROa1ZIVyswNE1aMHBYak9W?=
 =?utf-8?B?cVd5cVYrdVIxNG9ydER2L2dxK214WUtzb3dNK3FlWjdya2tDRm84RTg5aThn?=
 =?utf-8?B?Y0laNWN2a1dsYnpETE9ONXFuaTV1TmNJeGtObDcxRkFLRmRZaThBY2VDWmpT?=
 =?utf-8?B?QzBYUnAwT21oREY0TlNyYmJTL0xoUWhqaG1jTWdGNG9HQkduaUJRR3lUWDcx?=
 =?utf-8?B?QnZtd1NkZ1pWNHdGSGFLenpRL2pJamlZK1pwY2ZacGM0a05GeGNPVUdBYVhj?=
 =?utf-8?B?Zm5CTFRUL0JCTzhJblI4RzFHNk5jeHA3WEFMdlpXQ1ZkRlF6MlMxWmpCRWZO?=
 =?utf-8?B?UTNxVVQ1SzZWV0trSXkvNkFtWE1KQVNlRGlPL1huNTRwaStOMWQ2TlhuOG9H?=
 =?utf-8?Q?EpSRQ4uemA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1KMEtCSVVDWEt4RWVoYzhpcnNQcTM2dHd5MWxkdDFJRmZqbjdvc0IwNExj?=
 =?utf-8?B?VkpzNkcyZm5jQmxERVNGcEJ0V3c5M3N0Y0RhcnR6a2RPem13SGRJMnpGR3Jt?=
 =?utf-8?B?R2MyNGhNTkZCem9uRmQ1aHVNNytpTU1JYXJ6TjR5S1R1emI1aElNbkczR2py?=
 =?utf-8?B?MXFYNWd6WEJmMkZYQlVFaTFPT3hWNTMzTm45K1pBMWNrSlhRRGU4U3JETDhr?=
 =?utf-8?B?dmZpMk9HM2NjTTU4ZWJ3MU1pejNuNW8rMzV2WkxybGZmRklyWkJhN2FkT1Vs?=
 =?utf-8?B?eERPQXprSHBIMEVQRHkxWWtneDhUbFF3blUzKzlMMjYvQW8yYkZMZkhNUyt6?=
 =?utf-8?B?aks5cG5sWWZNVDR5bU1HR0wwVytKU0dQVGNNRzF1VU1EY2lENjZlVWZra256?=
 =?utf-8?B?UGxkWDE0cHNKNzBhTC9nUm5MMUY1TXNIOFFVVWU3QWNmcldDZzgrZENEYnQy?=
 =?utf-8?B?WnorREJybW5JeXdONUhleThCODVER2J3aElaL2U3cUVSTSttUjg4Tit5TUpL?=
 =?utf-8?B?UkVzTUVzTG5mdHVIRzJxM3VWTFNvMFpHYnYzTG1FcHJyZUFCTDBaTWtGRjds?=
 =?utf-8?B?YXU0VUF1MVJPYTNaamFsV2U0Y0w1S2tvakNQZ2llaTVFbDBHYzBkb1UzdXZv?=
 =?utf-8?B?QU85aTQxTWZsSkRnL1lvTlg1N2ZLQUJhTGFOcHhiVlZyekpLVElvRnE5WG5F?=
 =?utf-8?B?ZzYwMDNkOU1CaG5IbWRaaWduODN1UEltVjJ3MGoxSnZNWWpXM1U4Y0ZETjdp?=
 =?utf-8?B?azQzRFUxd2pNNlJWeDJIYWIwazZRRGQ3V3ZFRFc3NmtKNGNudXdBN1VuNXh0?=
 =?utf-8?B?d2QzaEsrRDRLemJjQnNiRjJJVmJ6bW9wMjMxUWwzNVpWaW9GcVpQa0hGWkFr?=
 =?utf-8?B?V09BbktiS1l6RjNKditvejlla3RXUjNFbTBIUFhWcWVISEExdEtUVXluOXNY?=
 =?utf-8?B?cElHTmxONEx3NE0yOWh5UmprU2hWNXNQRWMyZTV6UzFuUUtzM3E2TmgrSEx1?=
 =?utf-8?B?L1R5UnlNdktZMXk5OEJSQ0svQis0bWg3L3lTTVlKRW90TkxwZjdnQ0xTd0xH?=
 =?utf-8?B?VjFMQUU5VWIxVzRGdlNFOHBxR1hUT3VPK21hcFc1OTNIVURRRE5JamQ4SE8y?=
 =?utf-8?B?RWVra1VndjNKaWRpeHBaWENOVngzZ1gxbWVnU2ZLQ1lTeWZlMjgvSzRja2RX?=
 =?utf-8?B?RjdxbkE5TmZOL0FCK1RIeFRRWDFQdDJ5N1VZQmlOUFM5VEZNcTBxdmRIbWRN?=
 =?utf-8?B?M3FxbFVnbVc1eVVaRW1vWXU5WmhuTkE4cmhpK3ErMEh3NWJJbEo0eGhack9v?=
 =?utf-8?B?Z3N4VnJzWDVnMDFkRWJIME5SM2RkSkF5aFNZSURqMWRCQ0Z4QktVRmp2b0pT?=
 =?utf-8?B?cFl3MGdMUjhVMGdzUXFYMGg5M1VOcGZyTVhrcUUwL2VTdVVRRlY1bElyTi91?=
 =?utf-8?B?dGw1U1gwYndwYzJlWENZaktYSmhiTHcrL0dOKy9OdmZWRCtSTTZPMnI4T0NR?=
 =?utf-8?B?THJvNUUrNS9jSDB1SWZha0k1Q0FMNENCWTd5aUM2eUE0enVZNGtkOWh5eVdr?=
 =?utf-8?B?aytObVBSRkF0WnkvMGhmTXAwWjhya0F5OUhiRDE4QW9CZTA0MFRCQTJjMk5P?=
 =?utf-8?B?SUZWaEc4bVZxMFlzYTdEcis1MEVzL2hVblpQenRpVFFoWDcvWFZSejdiM3dt?=
 =?utf-8?B?Zk9zSE44bXRKZjBYOWRsWG9EOHZYakFhN0ZrdCszYXZiSzlrbWhQTDFxQVhw?=
 =?utf-8?B?TnR1c3BlUk9PYzJZZDB2QzZqQ2ZWaXNVY0ZpS0x6KzhmWkQzd2JZK1VpclVt?=
 =?utf-8?B?TGhzMVlZZU92TzBEdUxXaythZlVRZWNwc3VTK2YvbGJhNDE4MGl0NUlQSEhX?=
 =?utf-8?B?YXNGQkl2ZGJuZ1hkT0FvU3pkVDVXakNsMjZBSGt3RjNJbFJaT1NhZ3BtMjMz?=
 =?utf-8?B?T3kzOG5YbjhtaEo2YkVjM0dvSFNvd0k2bzNSVVRqRmNlVXpYRHZPeVg5aTZM?=
 =?utf-8?B?V2NhWXZVT1BTRjg0QmpWL2pSYjgxa0ZIcVk3dGpyVWFuUGp2SUFXZlNvdFZi?=
 =?utf-8?B?TVY3OGI3THdBSmVmRDQvLzR3Sm0zVWgrYStXUmN6eVFxRGNNeXNZZlhISllQ?=
 =?utf-8?Q?exY1vaWDfIpiq64ujbPj54pkl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b1c47-ac48-4fbe-fe45-08ddafe6bd47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:39:31.3493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31D7GNQUY6aC+9QIJy/I+rYqvlM6VD2rCE2jRKuOeI7cdqZ9CHzMNWOJEKq0MDiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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



On 6/18/2025 2:56 PM, Peter Zijlstra wrote:
> On Wed, Jun 18, 2025 at 11:12:32AM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 18, 2025 at 10:51:23AM +0200, Peter Zijlstra wrote:
>>> On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
>>>
>>>> How about if we reset before the kexec?  There is a symbol for drivers to
>>>> use to know they're about to go through kexec to do $THINGS.
>>>>
>>>> Something like this:
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 0fc0eeedc6461..2b1216b14d618 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -34,6 +34,7 @@
>>>>
>>>>  #include <linux/cc_platform.h>
>>>>  #include <linux/dynamic_debug.h>
>>>> +#include <linux/kexec.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/mmu_notifier.h>
>>>>  #include <linux/pm_runtime.h>
>>>> @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>>                 adev->mp1_state = PP_MP1_STATE_UNLOAD;
>>>>         amdgpu_device_ip_suspend(adev);
>>>>         adev->mp1_state = PP_MP1_STATE_NONE;
>>>> +
>>>> +       if (kexec_in_progress)
>>>> +               amdgpu_asic_reset(adev);
>>>>  }
>>>>
>>>>  static int amdgpu_pmops_prepare(struct device *dev)
>>>
>>> I will throw this in the dev kernel... I'll let you know.
>>
>> First hurdle appears to be that this symbol is not exported. I fixed
>> that, but perhaps the kexec folks don't like drivers to use this?
> 
> Bah, so first kexec after a fresh reboot into a kernel carrying this has
> the thing failing.
> 

Could you check if passing amdgpu module param - 'runpm=0' - helps?

Thanks,
Lijo

