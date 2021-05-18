Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F75C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA416124C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA416124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16856E88E;
	Tue, 18 May 2021 14:19:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB206E0B9;
 Tue, 18 May 2021 14:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAHTxk+IQSuCqaKlWGpTJxjIpeI2GqNX2XZOMZGhRTicpJ0M/xj1oTzi5tCQ47lGDzeyryTsVuGjuFlJcX2W68jP8xvjktcaDqeerXuGg94F73bACi0XXU2Wtx0AyX0o/uCE6zSnH+y2jMjYmxRge6u+j2+CwZlIscBUtSmgWN0womwUe+Z1ZBr56LzW1ejOONAEBQt1Usv8uQwIboo9/r93WxROvSTGNayPkz6sE1bmfTQNQApZbpzVrAmwSpZGtzzwbvxHN2WUiBpJDx0GvZgywplynlrPwVRO1e5tKhL8MuacHfuqAfUdUMbkS3kVhXP1l7/pa1tWa7U918pJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSvxssJVJN0EnPiIe6VnBaTCcePcR7S9H9OBjP1+DXA=;
 b=Cacv81u39A7yEwpDGgaHX/cNF8r0sZA/nEG11vfK1anXO+iI+n8eoFG29bBTHHqxpAmPok9/xRnA1ADktBQKT4MAbvnnqxrRKtvF3p8xM9YRWHPOIu3vYnj2RGukEcKkEtoAiP3NJoeEWMUNsPYrCztkOR4g5zwcd7R/YW7QnksYhlB7j3hC0MSYa3Lf9Mk272+tUKAllTr+da1z92L3ZRTk/qKqDe1QffX12u4USUALtnyk16ohVMdHB5NhOkk6ef0JyrC6IaCPmC9n7mnGKslCeesfR1+hfC19E7oymmvFUz5sMytV9cOJ1BjBT/2w0totYO4XIInfYo3iQuszTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSvxssJVJN0EnPiIe6VnBaTCcePcR7S9H9OBjP1+DXA=;
 b=wj53DlmCCKjnlFGE5xFGw+W9vbptjZhsPXUWTFYO1X6Z04CUKdqFnj0WTiVbuk2NvBf/veLV0b4zMFz7qGgn980AgjYiiCa1liz3oWsRQMFNN/jyxrGu8ZiyVJfwyI2U1POxg0rtBDm5lO3t+NSGI058TQZfXyz4WVn5QfphbAU=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1904.namprd12.prod.outlook.com (2603:10b6:300:114::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 14:19:29 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 14:19:29 +0000
Subject: Re: [RFC PATCH 0/3] A drm_plane API to support HDR planes
To: Pekka Paalanen <ppaalanen@gmail.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20210426173852.484368-1-harry.wentland@amd.com>
 <20210427175005.5b92badc@eldfell>
 <e51a3067-a0b3-16e4-5996-bd8527b7536b@amd.com>
 <20210517115726.4fc1c710@eldfell>
 <5f6abaaa45bb7f77110d9f87c9824e3f@sebastianwick.net>
 <b0834be8-9023-0fde-f15d-8c44f72e7702@amd.com>
 <20210518105615.212b84e4@eldfell>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <9d4ec9c3-6716-7c80-97d5-dd3c5c50ab51@amd.com>
Date: Tue, 18 May 2021 10:19:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210518105615.212b84e4@eldfell>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Tue, 18 May 2021 14:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3265cd10-e8f5-44c9-5052-08d91a07f2f3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1904C6273D2A1FE492C1DFA98C2C9@MWHPR12MB1904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfuH4HqmSGTOS3cEuZJKPaMgIBJ5xbWvLsYzyA9TKB/1t9rLaPiGmQfH0lQpjwlhAgzHur+t6QZL5cfd2f5Lb+gDZYy3XCqRimPpvMV5+ANlQcdGuS1Lwu1FVTOszc7InTh0KZLSuJX6RWh3PlzVLcB2JIE1Q05nAvospAtCGzHhLmpMhUZ5++FbmViVbcDSZ7dlQ7VZhGbZmraxy6EJd9pQmNikHYSdqYNIkzB8u1Vy5W5fDTJr9lxacpeU33M7bkdIxQnLTLw3At6t0pWRvffuBJp6cow8qbm4fCNFu9TU7lBjmEszLKbWkJUobS8xmicS253LlESwXzOP4lCeSEqx80cCLidkZCiwDKZpVLZQJg/YCFusCxefadYSpr0KoYetZJHUPyvDvcESpNhhOnnw/vjBHdl8wtmAHOSIrKVpA8DEZwqPV8bEIswmWJDR2WjCJGkKqETAuqrksHlQpq3797O/ohQY5Ttz+sn1b7urHVn29sWxV2QLCqXFEMpWgBXS8+A1pP1k/cynHry13xzZJUt+TQYORRNJS+GMv9TDy1WzIDNJqWOf6+R/RKBXFsu7iS08t0ew97VkP0kVb1+RRS2WJkBZzDK5oZCQaQTk7/WbBWhlmBLOM1fHP0VwRs0FcXhEstO056fKRDnBKeXiPN1ZY1LAP4i0aDeBOWeg7HQdAYdVywN/XMLm49wt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(31686004)(26005)(83380400001)(6636002)(66476007)(2906002)(36756003)(44832011)(2616005)(4326008)(53546011)(66556008)(16576012)(316002)(110136005)(38100700002)(5660300002)(186003)(478600001)(31696002)(8676002)(16526019)(956004)(86362001)(66946007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0lOTmtLMnZ2ZlUrUkJyWFpMaGN6ZEFqQmlCTVJlaGIvVXVyRjU0QytPVFg2?=
 =?utf-8?B?WW9PeXAvZCtCMlU3eEw5NzR5NGg5MGIyNjBTcmlScXBSSHNkYTVtZ3hvb2sw?=
 =?utf-8?B?NmJNekFBZEpMUHgxQ0JoYXVqWGsvTXdLWHlMOERLRXYvVjY4RG9vL1RBSTlh?=
 =?utf-8?B?ZUhQU3NBVFJBVWhhK0Z3TzZpbXk5Vi9jZEJyOXdnQkpEM2FQTW4zN0g2aXdQ?=
 =?utf-8?B?SkhqajZSRFVTNmFIOUVhQWZHMVVVYmxMQW5iOG0zSjA2SHB6K0tsMVRLLzU1?=
 =?utf-8?B?V2hkSGZ4Yzh4eVU4N2Noc1ZqellqbDFmRTIwNVc1WVA5cks0Rm91djQ2WjhJ?=
 =?utf-8?B?R2h3QytWUHNKMEdXNXF4aG55WFlTTm9xZnNoQUVpYTVSMDNlZHpjOVhNdDIw?=
 =?utf-8?B?SHRZUU1IbHVyK0pOUlMrMGtkQ29uSDFKcWpBdUZyS1Z4V1kyalA3OGlsV3dj?=
 =?utf-8?B?Y2NxUGs3WmlpS0xVNWxaZWVXK252VC82V0NvWVdsQ2lGOGdTUGlqWjVTQnNm?=
 =?utf-8?B?QXpFYkdxeUNXZytvYzM3d3VPZVA5aVhtOGVuSWFwSUhvTnVxR0M2U0gwb3BP?=
 =?utf-8?B?a2NjVU8xbUd3d2hKQTRtbUZjYzJVZFJpYkN2R25mRy9PYmtjVzNsMlNyTVMz?=
 =?utf-8?B?Q1UvTjhydDlkYzJFTlAzSlJCNk85TFU2OXBUaE5IMWJlV1VRSHJQWTdia1RH?=
 =?utf-8?B?aGRUTDBncm5ic0psVXZIQTdEbFl0NDl4Uy9ZVTB4TjExK054WEpkcE16TytJ?=
 =?utf-8?B?d2ZUMDNSRUVxVjlFeFI5a2Jrd3VrOUhuOHRzZXE2YWR6SmJHNTN1THpLM05k?=
 =?utf-8?B?Yjh0QUszZnRLMHQzMDRUcTg3cWYzN1hUSWhHeDBNR3VWaFhodzJ2RWYyUmhH?=
 =?utf-8?B?N3JNaXR0MGVPS2hSQXVHN0FSNnNMbVNNdUtia1pjMXB2alVvUkZxcEp0R21K?=
 =?utf-8?B?SC9sNFpNcUJ0cGNwdzR4T3lNYzdtclNEYURpU0NodTdIVkh0UUVrWUI4VUJt?=
 =?utf-8?B?TDlyWlNiMUM1SjJZNFZyZ1hFMmUvNmRwb3lOc2lDb0hXR0ZxZ3J4Wjhwb0NJ?=
 =?utf-8?B?UGRKeTdxYmdMUndFemNrL2NYRjVIMVNSSjRXcFZlOEx3Z05vMGZGK2xUSmNp?=
 =?utf-8?B?WmRCYUFLNEpLMmFiVmRjTjRTdDBzckFLOUQ0Z05vcndEdVBjV3l2N3Ixem1i?=
 =?utf-8?B?ZDFQTWIyRVVWK0RONVdQM210dnQ4WlM5L1lKZlIrWXEwbThaVVduS0RWOFov?=
 =?utf-8?B?ZGRISGdKZjB4S2xxdE00b3FjODYvTE1VZFJ2cmV6TFd6cU9HaXNqU0hwVzJi?=
 =?utf-8?B?Wk5nZlMzNjN4QTkxaXUvL1N1K2VMZVQwbjR1QmRzL1BBTUxTd1dsVnBrVkRm?=
 =?utf-8?B?V1NDMkdVU3l0NG55VFJsT01YK2FZcjNhTG56ZGU4MzluVVc2Y3h2aXdITDlY?=
 =?utf-8?B?RSs2NmZWNnpSenNySzM1SUNjcjcveWFBcmp3OHhTWEFBUlhpT2g4T204Nnhq?=
 =?utf-8?B?YzBlaVJMZTh1bVRZelBTdTlWRlh0QUV5NUxCQTNyRVlmK05TUlpKZVBBRWRP?=
 =?utf-8?B?dFc2WmFMbjhZOGdmWTliYlVYN013TDVzc3l6azRib3pDb0tDNDgzMWp2K2pU?=
 =?utf-8?B?dEJkcVcrMVdtVUlodTBDZVNQN1kwMjlQQW0xclp1TGlPVk94cUJaYnZiUVpm?=
 =?utf-8?B?UHZXT01ENjZDTThrZmVyMkREaHZkc3FveXExd3liRkFmTjJ1bFNqQm96SDhp?=
 =?utf-8?Q?/CzANpS9oxYjOm6ZyilSXkxdY+1zNVt/VNVfAXM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3265cd10-e8f5-44c9-5052-08d91a07f2f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 14:19:29.5230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR52blZ7S6P350+BkQ+jSb0QygNqMJ1NHHu1fX4Kla4Rw7mL6/uDYQlwjGcmrpzybsUSgMYUYB9dNakoZiKokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1904
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
Cc: Deepak.Sharma@amd.com, aric.cyr@amd.com, Krunoslav.Kovac@amd.com,
 mcasas@google.com, Shashank.Sharma@amd.com, dri-devel@lists.freedesktop.org,
 Shirish.S@amd.com, Sebastian Wick <sebastian@sebastianwick.net>,
 hersenxs.wu@amd.com, amd-gfx@lists.freedesktop.org,
 laurentiu.palcu@oss.nxp.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDM6NTYgYS5tLiwgUGVra2EgUGFhbGFuZW4gd3JvdGU6Cj4gT24gTW9u
LCAxNyBNYXkgMjAyMSAxNTozOTowMyAtMDQwMAo+IFZpdGFseSBQcm9zeWFrIDx2aXRhbHkucHJv
c3lha0BhbWQuY29tPiB3cm90ZToKPiAKPj4gT24gMjAyMS0wNS0xNyAxMjo0OCBwLm0uLCBTZWJh
c3RpYW4gV2ljayB3cm90ZToKPj4+IE9uIDIwMjEtMDUtMTcgMTA6NTcsIFBla2thIFBhYWxhbmVu
IHdyb3RlOiAgCj4+Pj4gT24gRnJpLCAxNCBNYXkgMjAyMSAxNzowNToxMSAtMDQwMAo+Pj4+IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPiB3cm90ZToKPj4+PiAgCj4+Pj4+
IE9uIDIwMjEtMDQtMjcgMTA6NTAgYS5tLiwgUGVra2EgUGFhbGFuZW4gd3JvdGU6ICAKPj4+Pj4+
IE9uIE1vbiwgMjYgQXByIDIwMjEgMTM6Mzg6NDkgLTA0MDAKPj4+Pj4+IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPiB3cm90ZTogIAo+Pj4+Cj4+Pj4gLi4uCj4+Pj4gIAo+
Pj4+Pj4+ICMjIE1hc3RlcmluZyBMdW1pbmFuY2VzCj4+Pj4+Pj4KPj4+Pj4+PiBOb3cgd2UgYXJl
IGFibGUgdG8gdXNlIHRoZSBQUSAyMDg0IEVPVEYgdG8gZGVmaW5lIHRoZSBsdW1pbmFuY2Ugb2YK
Pj4+Pj4+PiBwaXhlbHMgaW4gYWJzb2x1dGUgdGVybXMuIFVuZm9ydHVuYXRlbHkgd2UncmUgYWdh
aW4gcHJlc2VudGVkIHdpdGgKPj4+Pj4+PiBwaHlzaWNhbCBsaW1pdGF0aW9ucyBvZiB0aGUgZGlz
cGxheSB0ZWNobm9sb2dpZXMgb24gdGhlIG1hcmtldCAgIAo+Pj4+PiB0b2RheS4gIAo+Pj4+Pj4+
IEhlcmUgYXJlIGEgZmV3IGV4YW1wbGVzIG9mIGx1bWluYW5jZSByYW5nZXMgb2YgZGlzcGxheXMu
Cj4+Pj4+Pj4KPj4+Pj4+PiB8IERpc3BsYXnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgTHVtaW5hbmNlIHJhbmdlIGluIG5pdHMgfAo+Pj4+Pj4+IHwgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tIHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfAo+Pj4+Pj4+IHwgVHlwaWNhbCBQ
QyBkaXNwbGF5wqDCoMKgwqDCoMKgIHwgMC4zIC0gMjAwIHwKPj4+Pj4+PiB8IEV4Y2VsbGVudCBM
Q0QgSERUVsKgwqDCoMKgwqDCoCB8IDAuMyAtIDQwMCB8Cj4+Pj4+Pj4gfCBIRFIgTENEIHcvIGxv
Y2FsIGRpbW1pbmcgfCAwLjA1IC0gMSw1MDAgfAo+Pj4+Pj4+Cj4+Pj4+Pj4gU2luY2Ugbm8gZGlz
cGxheSBjYW4gY3VycmVudGx5IHNob3cgdGhlIGZ1bGwgMC4wMDA1IHRvIDEwLDAwMCBuaXRzCj4+
Pj4+Pj4gbHVtaW5hbmNlIHJhbmdlIHRoZSBkaXNwbGF5IHdpbGwgbmVlZCB0byB0b25lbWFwIHRo
ZSBIRFIgY29udGVudCwgICAKPj4+Pj4gaS5lICAKPj4+Pj4+PiB0byBmaXQgdGhlIGNvbnRlbnQg
d2l0aGluIGEgZGlzcGxheSdzIGNhcGFiaWxpdGllcy4gVG8gYXNzaXN0IHdpdGgKPj4+Pj4+PiB0
b25lbWFwcGluZyBIRFIgY29udGVudCBpcyB1c3VhbGx5IGFjY29tcGFuaWVkIHdpdGggYSBtZXRh
ZGF0YSB0aGF0Cj4+Pj4+Pj4gZGVzY3JpYmVzIChhbW9uZyBvdGhlciB0aGluZ3MpIHRoZSBtaW5p
bXVtIGFuZCBtYXhpbXVtIG1hc3RlcmluZwo+Pj4+Pj4+IGx1bWluYW5jZSwgaS5lLiB0aGUgbWF4
aW11bSBhbmQgbWluaW11bSBsdW1pbmFuY2Ugb2YgdGhlIGRpc3BsYXkgICAKPj4+Pj4gdGhhdCAg
Cj4+Pj4+Pj4gd2FzIHVzZWQgdG8gbWFzdGVyIHRoZSBIRFIgY29udGVudC4KPj4+Pj4+Pgo+Pj4+
Pj4+IFRoZSBIRFIgbWV0YWRhdGEgaXMgY3VycmVudGx5IGRlZmluZWQgb24gdGhlIGRybV9jb25u
ZWN0b3IgdmlhIHRoZQo+Pj4+Pj4+IGhkcl9vdXRwdXRfbWV0YWRhdGEgYmxvYiBwcm9wZXJ0eS4K
Pj4+Pj4+Pgo+Pj4+Pj4+IEl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBkZWZpbmUgcGVyLXBsYW5lIGhk
ciBtZXRhZGF0YSwgYXMgZGlmZmVyZW50Cj4+Pj4+Pj4gcGxhbmVzIG1pZ2h0IGhhdmUgYmVlbiBt
YXN0ZXJlZCBkaWZmZXJlbnRseS4gIAo+Pj4+Pj4KPj4+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyB3
b3VsZCBkaXJlY3RseSBoZWxwIHdpdGggdGhlIGR5bmFtaWMgcmFuZ2UgICAKPj4+Pj4gYmxlbmRp
bmcgIAo+Pj4+Pj4gcHJvYmxlbS4gWW91IHN0aWxsIG5lZWQgdG8gZXN0YWJsaXNoIHRoZSBtYXBw
aW5nIGJldHdlZW4gdGhlIG9wdGljYWwKPj4+Pj4+IHZhbHVlcyBmcm9tIHR3byBkaWZmZXJlbnQg
RU9URnMgYW5kIGR5bmFtaWMgcmFuZ2VzLiBPciBjYW4geW91IGtub3cKPj4+Pj4+IHdoaWNoIG9w
dGljYWwgdmFsdWVzIG1hdGNoIHRoZSBtYXN0ZXJpbmcgZGlzcGxheSBtYXhpbXVtIGFuZCBtaW5p
bXVtCj4+Pj4+PiBsdW1pbmFuY2VzIGZvciBub3QtUFE/Cj4+Pj4+PiAgCj4+Pj4+Cj4+Pj4+IE15
IHVuZGVyc3RhbmRpbmcgb2YgdGhpcyBpcyBwcm9iYWJseSBiZXN0IGlsbHVzdHJhdGVkIGJ5IHRo
aXMgZXhhbXBsZToKPj4+Pj4KPj4+Pj4gQXNzdW1lIEhEUiB3YXMgbWFzdGVyZWQgb24gYSBkaXNw
bGF5IHdpdGggYSBtYXhpbXVtIHdoaXRlIGxldmVsIG9mIDUwMAo+Pj4+PiBuaXRzIGFuZCBwbGF5
ZWQgYmFjayBvbiBhIGRpc3BsYXkgdGhhdCBzdXBwb3J0cyBhIG1heCB3aGl0ZSBsZXZlbCBvZiAK
Pj4+Pj4gNDAwCj4+Pj4+IG5pdHMuIElmIHlvdSBrbm93IHRoZSBtYXN0ZXJpbmcgd2hpdGUgbGV2
ZWwgb2YgNTAwIHlvdSBrbm93IHRoYXQgCj4+Pj4+IHRoaXMgaXMKPj4+Pj4gdGhlIG1heGltdW0g
dmFsdWUgeW91IG5lZWQgdG8gY29tcHJlc3MgZG93biB0byA0MDAgbml0cywgYWxsb3dpbmcgCj4+
Pj4+IHlvdSB0bwo+Pj4+PiB1c2UgdGhlIGZ1bGwgZXh0ZW50IG9mIHRoZSA0MDAgbml0cyBwYW5l
bC4gIAo+Pj4+Cj4+Pj4gUmlnaHQsIGJ1dCBpbiB0aGUga2VybmVsLCB3aGVyZSBkbyB5b3UgZ2V0
IHRoZXNlIG5pdHMgdmFsdWVzIGZyb20/Cj4+Pj4KPj4+PiBoZHJfb3V0cHV0X21ldGFkYXRhIGJs
b2IgaXMgaW5mb2ZyYW1lIGRhdGEgdG8gdGhlIG1vbml0b3IuIEkgdGhpbmsgdGhpcwo+Pj4+IHNo
b3VsZCBiZSBpbmRlcGVuZGVudCBvZiB0aGUgbWV0YWRhdGEgdXNlZCBmb3IgY29sb3IgdHJhbnNm
b3JtYXRpb25zIGluCj4+Pj4gdGhlIGRpc3BsYXkgcGlwZWxpbmUgYmVmb3JlIHRoZSBtb25pdG9y
Lgo+Pj4+Cj4+Pj4gRURJRCBtYXkgdGVsbCB1cyB0aGUgbW9uaXRvciBIRFIgbWV0YWRhdGEsIGJ1
dCBhZ2FpbiB3aGF0IGlzIHVzZWQgaW4KPj4+PiB0aGUgY29sb3IgdHJhbnNmb3JtYXRpb25zIHNo
b3VsZCBiZSBpbmRlcGVuZGVudCwgYmVjYXVzZSBFRElEcyBsaWUsCj4+Pj4gbGlnaHRpbmcgZW52
aXJvbm1lbnRzIGNoYW5nZSwgYW5kIHVzZXJzIGhhdmUgZGlmZmVyZW50IHByZWZlcmVuY2VzLgo+
Pj4+Cj4+Pj4gV2hhdCBhYm91dCBibGFjayBsZXZlbHM/Cj4+Pj4KPj4+PiBEbyB5b3Ugd2FudCB0
byBkbyBibGFjayBsZXZlbCBhZGp1c3RtZW50Pwo+Pj4+Cj4+Pj4gSG93IGV4YWN0bHkgc2hvdWxk
IHRoZSBjb21wcmVzc2lvbiB3b3JrPwo+Pj4+Cj4+Pj4gV2hlcmUgZG8geW91IG1hcCB0aGUgbWlk
LXRvbmVzPwo+Pj4+Cj4+Pj4gV2hhdCBpZiB0aGUgZW5kIHVzZXIgd2FudHMgc29tZXRoaW5nIGRp
ZmZlcmVudD8gIAo+Pj4KPj4+IEkgc3VzcGVjdCB0aGF0IHRoaXMgaXMgbm90IGFib3V0IHRvbmUg
bWFwcGluZyBhdCBhbGwuIFRoZSB1c2UgY2FzZXMKPj4+IGxpc3RlZCBhbHdheXMgaGF2ZSB0aGUg
ZGlzcGxheSBpbiBQUSBtb2RlIGFuZCBqdXN0IGFzc3VtZSB0aGF0IG5vCj4+PiBjb250ZW50IGV4
Y2VlZHMgdGhlIFBRIGxpbWl0YXRpb25zLiBUaGVuIHlvdSBjYW4gc2ltcGx5IGJyaW5nIGFsbAo+
Pj4gY29udGVudCB0byB0aGUgY29sb3Igc3BhY2Ugd2l0aCBhIG1hdHJpeCBtdWx0aXBsaWNhdGlv
biBhbmQgdGhlbiBtYXAgdGhlCj4+PiBsaW5lYXIgbGlnaHQgY29udGVudCBzb21ld2hlcmUgaW50
byB0aGUgUFEgcmFuZ2UuIFRvbmUgbWFwcGluZyBpcwo+Pj4gcGVyZm9ybWVkIGluIHRoZSBkaXNw
bGF5IG9ubHkuCj4gCj4gVGhlIHVzZSBjYXNlcyBkbyB1c2UgdGhlIHdvcmQgImRlc2t0b3AiIHRo
b3VnaC4gSGFycnksIGNvdWxkIHlvdSBleHBhbmQKPiBvbiB0aGlzLCBhcmUgeW91IHNlZWtpbmcg
YSBkZXNpZ24gdGhhdCBpcyBnb29kIGZvciBnZW5lcmljIGRlc2t0b3AKPiBjb21wb3NpdG9ycyB0
b28sIG9yIG9uZSB0aGF0IGlzIG1vcmUgdGFpbG9yZWQgdG8gImVtYmVkZGVkIiB2aWRlbwo+IHBs
YXllciBzeXN0ZW1zIHRha2luZyB0aGUgbW9zdCBhZHZhbnRhZ2Ugb2YgKHBvdGVudGlhbGx5Cj4g
Zml4ZWQtZnVuY3Rpb24pIGhhcmR3YXJlPwo+IAoKVGhlIGdvYWwgaXMgdG8gZW5hYmxlIHRoaXMg
b24gYSBnZW5lcmljIGRlc2t0b3AsIHN1Y2ggYXMgZ2VuZXJpYyBXYXlsYW5kCmltcGxlbWVudGF0
aW9ucyBvciBDaHJvbWVPUy4gV2UncmUgbm90IGxvb2tpbmcgZm9yIGEgY3VzdG9tIHNvbHV0aW9u
IGZvcgpzb21lIGVtYmVkZGVkIHN5c3RlbXMsIHRob3VnaCB0aGUgc29sdXRpb24gd2UgZW5kIHVw
IHdpdGggc2hvdWxkIG9idmlvdXNseQpub3QgcHJldmVudCBhbiBpbXBsZW1lbnRhdGlvbiBvbiBl
bWJlZGRlZCB2aWRlbyBwbGF5ZXJzLgoKPiBXaGF0IG1hdHJpeCB3b3VsZCBvbmUgY2hvb3NlPyBX
aGljaCByZW5kZXIgaW50ZW50IHdvdWxkIGl0Cj4gY29ycmVzcG9uZCB0bz8KPiAKPiBJZiB5b3Ug
bmVlZCB0byBhZGFwdCBkaWZmZXJlbnQgZHluYW1pYyByYW5nZXMgaW50byB0aGUgYmxlbmRpbmcg
ZHluYW1pYwo+IHJhbmdlLCB3b3VsZCBhIHNpbXBsZSBsaW5lYXIgdHJhbnNmb3JtYXRpb24gcmVh
bGx5IGJlIGVub3VnaD8KPiAKPj4+IEZyb20gYSBnZW5lcmljIHdheWxhbmQgY29tcG9zaXRvciBw
b2ludCBvZiB2aWV3IHRoaXMgaXMgdW5pbnRlcmVzdGluZy4KPj4+ICAKPj4gSXQgYSBjb21wb3Np
dG9yJ3MgZGVjaXNpb24gdG8gcHJvdmlkZSBvciBub3QgdGhlIG1ldGFkYXRhIHByb3BlcnR5IHRv
IAo+PiB0aGUga2VybmVsLiBUaGUgbWV0YWRhdGEgY2FuIGJlIGF2YWlsYWJsZSBmcm9tIG9uZSBv
ciBtdWx0aXBsZSBjbGllbnRzIAo+PiBvciBtb3N0IGxpa2VseSBub3QgYXZhaWxhYmxlIGF0IGFs
bC4KPj4KPj4gQ29tcG9zaXRvcnMgbWF5IHB1dCBhIGRpc3BsYXkgaW4gSERSMTAgKCB3aGVuIFBR
IDIwODQgSU5WIEVPVEYgYW5kIFRNIAo+PiBvY2N1cnMgaW4gZGlzcGxheSApIG9yIE5BVElWRSBt
b2RlIGFuZCBkbyBub3QgYXR0YWNoIGFueSBtZXRhZGF0YSB0byB0aGUgCj4+IGNvbm5lY3RvciBh
bmQgZG8gVE0gaW4gY29tcG9zaXRvci4KPj4KPj4gSXQgaXMgYWxsIGFib3V0IHVzZXIgcHJlZmVy
ZW5jZSBvciBjb21wb3NpdG9yIGRlc2lnbiwgb3IgYSBjb21iaW5hdGlvbiAKPj4gb2YgYm90aCBv
cHRpb25zLgo+IAo+IEluZGVlZC4gVGhlIHRoaW5nIGhlcmUgaXMgdGhhdCB5b3UgY2Fubm90IGp1
c3QgYWRkIEtNUyBVQVBJLCB5b3UgYWxzbwo+IG5lZWQgdG8gaGF2ZSB0aGUgRk9TUyB1c2Vyc3Bh
Y2UgdG8gZ28gd2l0aCBpdC4gU28geW91IG5lZWQgdG8gaGF2ZSB5b3VyCj4gYXVkaWVuY2UgZGVm
aW5lZCwgdXNlcnNwYWNlIHBhdGNoZXMgd3JpdHRlbiBhbmQgcmV2aWV3ZWQgYW5kIGFncmVlZAo+
IHRvIGJlIGEgZ29vZCBpZGVhLiBJJ20gYWZyYWlkIHRoaXMgcGFydGljdWxhciBVQVBJIGRlc2ln
biB3b3VsZCBiZQo+IGRpZmZpY3VsdCB0byBqdXN0aWZ5IHdpdGggV2VzdG9uLiBNYXliZSBLb2Rp
IGlzIGEgYmV0dGVyIGF1ZGllbmNlPwo+IAoKSSdtIG5vdCBzdXJlIGRlc2lnbmluZyBhIFVBUEkg
Zm9yIEtvZGkgdGhhdCdzIG5vdCBnb2luZyB0byB3b3JrIGZvcgpXYXlsYW5kLWNvbXBvc2l0b3Jz
IGlzIHRoZSByaWdodCB0aGluZy4gRnJvbSBhIEtNUyBkcml2ZXIgbWFpbnRhaW5lcgpzdGFuZHBv
aW50IEkgZG9uJ3Qgd2FudCBhbiBBUEkgZm9yIGVhY2ggdXNlcnNwYWNlLgoKVGhlIGlkZWEgaGVy
ZSBpcyB0byBkbyBkZXNpZ24gYW5kIGRpc2N1c3Npb24gaW4gcHVibGljIHNvIHdlIGNhbiBldmVu
dHVhbGx5CmFycml2ZSBhdCBhIFVBUEkgZm9yIEhEUiBhbmQgQ00gdGhhdCB3b3JrcyBmb3IgV2F5
bGFuZCBhbmQgYnkgZXh0ZW5zaW9uCmZvciBldmVyeSBvdGhlciB1c2Vyc3BhY2UuCgo+IEJ1dCB0
aGVuIGFnYWluLCBvbmUgYWxzbyBuZWVkcyB0byBjb25zaWRlciB3aGV0aGVyIGl0IGlzIGVub3Vn
aCBmb3IgYQo+IG5ldyBVQVBJIHRvIHNhdGlzZnkgb25seSBwYXJ0IG9mIHRoZSBwb3NzaWJsZSBh
dWRpZW5jZSBhbmQgdGhlbiBuZWVkCj4geWV0IGFub3RoZXIgbmV3IFVBUEkgdG8gc2F0aXNmeSB0
aGUgcmVzdC4gQWRkaW5nIG5ldyBVQVBJIHJlcXVpcmVzCj4gZGVmaW5pbmcgdGhlIGludGVyYWN0
aW9ucyB3aXRoIGFsbCBleGlzdGluZyBVQVBJIGFzIHdlbGwuCj4gCj4gTWF5YmUgd2UgZG8gbmVl
ZCBzZXZlcmFsIGRpZmZlcmVudCBVQVBJcyBmb3IgdGhlICJzYW1lIiB0aGluZ3MgaWYgdGhlCj4g
aGFyZHdhcmUgZGVzaWducyBhcmUgdG9vIGRpZmZlcmVudCB0byBjYXRlciB3aXRoIGp1c3Qgb25l
Lgo+IAoKSSBmZWVsIHdlIHNob3VsZCBoYXZlIGEgc2VjdGlvbiBpbiB0aGUgUkZDIHRoYXQgc2tl
dGNoZXMgaG93IGRpZmZlcmVudCBIVwpkZWFscyB3aXRoIHRoaXMgY3VycmVudGx5LiBJdCB3b3Vs
ZCBiZSBnb29kIGlmIHdlIGNhbiBhcnJpdmUgYXQgYSBVQVBJIHRoYXQKY2FwdHVyZXMgYXQgbGVh
c3QgdGhlIGNvbW1vbiBmdW5jdGlvbmFsaXR5IG9mIHZhcmlvdXMgSFcuCgpIYXJyeQoKPiAKPiBU
aGFua3MsCj4gcHEKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
