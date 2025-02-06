Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0C4C02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B2310E8D4;
	Thu,  6 Feb 2025 16:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Bx+BEVq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2809310E8D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPIJvviz+u+9Y2fN16XZY9cAdpnjOunHadur+UyzLp9k3aRL4m/PffOaeEL60pQy4ceMq/LQlV1KdinhsRXUhpzz5NMbSoeM/u0SLMkbiOO1FJ0wku7ILy4a7Bec3pPjGAohvg1tqWqFG+erP9Ggk+P8COKyVLCGLlm7DNmSYcUIqBvU76tvgHFo9A4GlRm8Ls1gc7M3z9nv9l8HhaiX1uPiGzlAbNtUy4oGC8T/+VyG3Y7ys2Qk3pA87in7mSixBM4PPxrMuUYqKsgbFH3ld9dQcmvJLMhy64j1ZCxKn72UqC0qIzsP97RbI2a+Tp3iu1bQByeiSNGRpNrIqLO5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7k1kE7FnnCOkNJcTh/2MB0qsMnxvLWiCk4TEiYQxw8=;
 b=s6Xzwbg9lKxSaG9fWQo+CjahCOOhin7uRMOWv3YTNuFXyUc3x4FJLxRxUOYvy8k5XM2xobOAG1RqqYGBG13VBzZO6F6aDPr513Rlxj5SwquYJ5BV9WvZv6P7ZG/OPdzUSqbDeepvP8VGYN4RqI9v7G85G3iZm7zPagPbt9XLKWWcB14SNJyhQPcTMxjPW4zonnbPtMvcqBTQ34tW8BD0cFMu5To54rmiB28lGyoGmGK8n3PpqJtRBcbFCici18Oi+Wnx6alU04t2eDDJSMKHGBfV+dJ/cCrzuEu4u1vamyk4+DXPymhDNdLNRR4qh9t9S9C3tBgLE7vMZw/InPQUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7k1kE7FnnCOkNJcTh/2MB0qsMnxvLWiCk4TEiYQxw8=;
 b=2Bx+BEVqVGw/QfUIf18ombnzR65TvBj2wt3xk/lNcNkL1sstPNGXJzhXZZnmbOVpOyEhfNgFgj+C4uGCaQSFyEG4UgKGNHqb78nKp7Aj8Ksxy0sJFb836y7UjWt5vu8qPbl/XtABR6kvKv1FbS2iBX73AWrhi6+WZvcm3QOzm7M=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 16:38:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 16:38:00 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
Thread-Topic: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
Thread-Index: AQHbcmFlMLeEKLD+SkWnOHSKwOSgPbM6bvKAgAAVNACAAAHiUg==
Date: Thu, 6 Feb 2025 16:37:59 +0000
Message-ID: <DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
 <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
 <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
In-Reply-To: <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-06T16:37:29.9030819Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8782:EE_
x-ms-office365-filtering-correlation-id: a1454afc-4291-49bf-4d56-08dd46cc9e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bgzBuBvjtg0SRIYvVdF5NeJTgIDbK4hvIio47XfapTkTpLr4fe7cozerW/3f?=
 =?us-ascii?Q?mOSLxU0Q0NXyTF9KxyiLxCuek8cxT+/IpChpdI2ng/p3CryjUIWCKO06ZfYD?=
 =?us-ascii?Q?rZplMZQSKJ7jfSwEEF6e4aipU1gR6g1rBmq8Dxb03VHBpqnYnQNEn9XXj0AD?=
 =?us-ascii?Q?4a3a2YUHwAESW0GqNHyVssHrmZsDF3fs0U02MbOntnENcX6SbTgO3VuJvMYF?=
 =?us-ascii?Q?vSCIw8JH1tCziQzTz4jufrBm2R4xhkFx5piSz7t/sxejkIoI9LjAwFH+rcnZ?=
 =?us-ascii?Q?HV2jvN3jl6rPV9tSUMegzQuWtx/46eb24s4SXKxUdeAISAf9lZrKEV+UVcAO?=
 =?us-ascii?Q?hHlnsEPlxhZ4/4iV0bGK9rZ0ivtbDUn1+JXilLBmIzgGE+yXwOHi+hyBFind?=
 =?us-ascii?Q?uUWHDorquMfTseUrY7mir0h8Exsv+uJsA7MXMCICYCE1blr8GcYX4wpMPvb+?=
 =?us-ascii?Q?5WDUhCsLXR5vIAtNFi8Dgae9FmOKTnxZiUOxN5fyPTy6ycCKtbGNZJf1wHV/?=
 =?us-ascii?Q?mNpeVqMFP5Uacca8L5U3uEQVoGfZfMY7TbQOCYW4wPv4EWAYV6oisI8/KRUT?=
 =?us-ascii?Q?aTNV0FED3+fISkBA+q0t2/k9BmAYj89h5cfYwbY7TA1rV+Efuk4PAIM3R/+u?=
 =?us-ascii?Q?1LAqBvOdHKEF5bmJsrUt+oUGzh+oNKZl+fgLUPewBKeN4be/mGaQ8ikagrDI?=
 =?us-ascii?Q?L5MCXJctfYeLWNqwrLzHp2KvXiKtUw1HkJSo78kbm8QNxM97pPE6TktUfaCt?=
 =?us-ascii?Q?PmSpo8+XdtFT8xfmpkETuOMQ+W6O+YvpLHs8JkRu9JIfU6rOdLfsL8NEVeqm?=
 =?us-ascii?Q?vSIy9XXF+SuTRgr5L4HvCKuoLFxUSyNB06BNS0fIfKjHnusBI24gm3DOLApy?=
 =?us-ascii?Q?/P9caRHhWpnOaTaGNkM3Nu3Ylb1GLwLoB9ylRceXd1RRnoPNIggtgAhmrEKx?=
 =?us-ascii?Q?9rnhQ+qu1pfNuChd89mwc7VMaHUbUl1Nd9pv7SaX6UKum3aozTYBWQR9aDhf?=
 =?us-ascii?Q?AKFOyvXmpsS+uKpwhPhwAOzsy1Y2L4ufEXRuinvGtqbd00Pt3pdDfvIHyB89?=
 =?us-ascii?Q?iu97isFlz1hVOHJKxfPdOJv0yro8YXSiHr3xqOAyXRKF7Vi272fIEdHy/cjX?=
 =?us-ascii?Q?Nbn9A8jrguVN/MwnltJmT8+7i02I8JsqVIlOPzRqSNHukyg8dUWbrblr3w5f?=
 =?us-ascii?Q?Ej3GH7TNnjSiJeqizXhDn0t3/f8H4gRPi1pGNGX08IdL+vsO1ZM6bus9BYxp?=
 =?us-ascii?Q?CXI3zlVu5B0b+Y6D6x7+/hnrk7nng+cuWhmh7xCLfVOJYfcmfS/bi7+Dz/Wm?=
 =?us-ascii?Q?B8wjrpmsl4IfP76O8VM1yns0pL84T5dvbFDX/+8i0yJo/EfbrqxJjxxo6ZmY?=
 =?us-ascii?Q?0M2+Lei8NyQcIzFuqfjmrQcdHJ6oQfTeoCnEj/PHWVl1EMFChvBtcTq2k50W?=
 =?us-ascii?Q?cU4rO7lF3cVszwg/CBFcsyE8lUbpV2Ke?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3g/GbdymJJL9jChUOeEwC7FWV71UIQs663QjTYgbk64J0yKTu066xkHuuJNn?=
 =?us-ascii?Q?WhtMw3FWeTdZiRHf9GrrpXQLy+M/9CbLkeAy7iLzQ0+Wy04qoPTixfA1tTHf?=
 =?us-ascii?Q?leg4qteuX2nTnu+sepnGuN7SG9x82RZIowh7ejF+9Far8vBtGewnjcvP5+a0?=
 =?us-ascii?Q?5EMQ1eby1ffz3Mr7rOt+IXggMeVySZtSf6tA68zCOYL59ZY5REHjS8D/qLdm?=
 =?us-ascii?Q?Px0GVfih0zzt7f68boipen0ZNRuY4/vMEpTNt6qjt1myPaEp6SXtygbA0wtL?=
 =?us-ascii?Q?C1C1XOR/Fsy5f7Zy9tu3GhbJMoIuXo2DXg+qCvPxznchs8gid58E0vlUY5Gi?=
 =?us-ascii?Q?ltCS+HySAlgQY33qKl2k+PaHiIjJO+om3McfmqjYYdDOpnhZ/8Kc9FElv8AT?=
 =?us-ascii?Q?vqGauintuqsh3J3L5qk5bpZCSPcIeBzpN+01WEmgafrNsAkvMv1r5nRbRSqu?=
 =?us-ascii?Q?0PjBTuh6CQHXjdLrhkyXzilOrpCO1g2lEFIzbOb/y4lUqlsZe5u2c52xW1hv?=
 =?us-ascii?Q?QlpUpRI5YpDd0ylzJWA4cog35HIYyMWDcb3BS2qc7PtoM6RqfiTyhG3DhSA8?=
 =?us-ascii?Q?5HhTfh8t4+PS8RD/LAeRFLYQKaOJyqmjFK4Z7OEnzvrPRKwl5C0Y9rzRi6BV?=
 =?us-ascii?Q?rWQ7lqRUAy70CdGdnBQ2cRYGgC3zaefTScjbMlayV62LrIUDfyD+gMeaSpJL?=
 =?us-ascii?Q?ZcRPdcG65dvrlxz5vyoTXwXFd/KB2/Flkuj/tICvHmS4VePWgbU5m5znltdV?=
 =?us-ascii?Q?13/X6EFVBsHd5Y9rMG0xOMgBnrBIal+vc8LWQH9+gGFg4NYjUOdgTSpT0d+0?=
 =?us-ascii?Q?9BmKASBCxql8aBPmvkfKNVmOn3Ap823SBJtp8qDA/CawJl1kTqoHZCEeXV2j?=
 =?us-ascii?Q?1c+l2ehcsAX6GnZxfrXuV1bBZpR+xcEGa8mjqjq/4/9Yy5dCh3ffnz8S14Tz?=
 =?us-ascii?Q?d2yWPLvLV+wmnxuW48BzdSlXbfiX6wKZH12+97kfSxtQM6gfr8tWyOR+W62O?=
 =?us-ascii?Q?kUvzQkcGiUe8U0DO/ZHIjazWf2Ptt4lgpJHJteykUsSu4FYadydxC+KJfDa9?=
 =?us-ascii?Q?MMYCEZTWrIhSXQV2qWbSj8hBlP/nUaQao79mCzHIq85G2N01Etll5VeiLUDm?=
 =?us-ascii?Q?+5S0qdMo4RYhU8j4UlDYBmhwMId5pL5Fajw7L/nhTgr/QjXnpDmwG5gq+b10?=
 =?us-ascii?Q?gNWG8HiapjspyKTR0keKQJZ2tKgY1h7+19G/huKAwDNqg0JqgaEB90Mf+qTy?=
 =?us-ascii?Q?iaLRUJHlshasPz6njhgVCWDgwvnStLh7Imux2mmy1MhGoVuIEbtQeZoMfOOi?=
 =?us-ascii?Q?XvKLpHbvWIbKhBUA6bbRywuVbFRuo6bkvtKmOaR4rlXL2rXxYp9voFEXW6Mz?=
 =?us-ascii?Q?cYLXRzx7YB3iftWsZ1ImqIDrvv+V5fVsQ+uf4p9daySjP1T2PsgGbt7xGylU?=
 =?us-ascii?Q?cUeR8Iku7cRt1SyZI6UVSHaBMrWnoFMdv/RX6jT5aMf/NrTW02sxBTL7oNfh?=
 =?us-ascii?Q?mL655yxapLUhmRyW2WTKxLNQMlQGYsfbIn65H+kfCcBPF5ZsP2gKSDtX4dyx?=
 =?us-ascii?Q?z01uYl9nU+8JOPbrXXnJZwd2Ia3eSXKhpKUMcDvx?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB78048C1038DC5F279EF24E2A97F62DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1454afc-4291-49bf-4d56-08dd46cc9e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 16:37:59.9839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMc/z5SVTo9v/0GiVjQfXs2ezEcaBTQ6YRT6FxMMPoOvWo2rDgQCDHx/E3NqjJSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

--_000_DS0PR12MB78048C1038DC5F279EF24E2A97F62DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Yes, the problem is that. If a node has 2 XCCs, it should report the L2 of =
each separately with the number of CUs sharing each L2.

In this, it appears to loop through and find the first non-zero of all XCCs=
 of a node and not based on the first non-zero per XCC basis. It makes a di=
fference in number of L2 instances available.


Thanks,
Lijo
________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Thursday, February 6, 2025 10:00:38 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology


On 2025-02-06 10:14, Lazar, Lijo wrote:
>
> On 1/29/2025 8:50 PM, Eric Huang wrote:
>> In some ASICs L2 cache info may miss in kfd topology,
>> because the first bitmap may be empty, that means
>> the first cu may be inactive, so to find the first
>> active cu will solve the issue.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_topology.c
>> index 4936697e6fc2..73d95041a388 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache=
_properties **props_ext,
>>                               int cache_type, unsigned int cu_processor_=
id,
>>                               struct kfd_node *knode)
>>   {
>> -    unsigned int cu_sibling_map_mask;
>> +    unsigned int cu_sibling_map_mask =3D 0;
>>       int first_active_cu;
>>       int i, j, k, xcc, start, end;
>>       int num_xcc =3D NUM_XCC(knode->xcc_mask);
>>       struct kfd_cache_properties *pcache =3D NULL;
>>       enum amdgpu_memory_partition mode;
>>       struct amdgpu_device *adev =3D knode->adev;
>> +    bool found =3D false;
>>
>>       start =3D ffs(knode->xcc_mask) - 1;
>>       end =3D start + num_xcc;
>> -    cu_sibling_map_mask =3D cu_info->bitmap[start][0][0];
>> +
>> +    /* To find the bitmap in the first active cu */
>> +    for (xcc =3D start; xcc < end && !found; xcc++) {
> It seems there is an assumption made here that a CU in one XCC could
> share this cache with CU in another XCC. This is not true for GFX 9.4.3
> SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.
In KFD topology we only report L2 cache info of the first active cu in A
XCC, which could be XCC0 or XCC1. It is generic for L2 info in the
certain XCP/kfd node, and not specific for every XCC, so it doesn't mean
the L2 cache found in XCC0 can be shared with XCC1, it only means there
is L2 cache in this kfd node.

Regards,
Eric
>
> Thanks,
> Lijo
>
>> +            for (i =3D 0; i < gfx_info->max_shader_engines && !found; i=
++) {
>> +                    for (j =3D 0; j < gfx_info->max_sh_per_se && !found=
; j++) {
>> +                            if (cu_info->bitmap[xcc][i % 4][j % 4]) {
>> +                                    cu_sibling_map_mask =3D
>> +                                            cu_info->bitmap[xcc][i % 4]=
[j % 4];
>> +                                    found =3D true;
>> +                            }
>> +                    }
>> +            }
>> +    }
>> +
>>       cu_sibling_map_mask &=3D
>>               ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>>       first_active_cu =3D ffs(cu_sibling_map_mask);


--_000_DS0PR12MB78048C1038DC5F279EF24E2A97F62DS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span dir=3D"auto" style=3D"font-family: -apple-system, H=
elveticaNeue; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Y=
es, the problem is that. If a node has 2 XCCs, it should report the L2 of e=
ach separately with the number of CUs
 sharing each L2.</span>
<div dir=3D"auto" style=3D"font-family: -apple-system, HelveticaNeue; color=
: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: -apple-system, HelveticaNeue; color=
: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
In this, it appears to loop through and find the first non-zero of all XCCs=
 of a node and not based on the first non-zero per XCC basis. It makes a di=
fference in number of L2 instances available.</div>
<div dir=3D"auto" id=3D"x_ms-outlook-mobile-signature" style=3D"font-family=
: -apple-system, HelveticaNeue; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);">
<div dir=3D"auto"><br>
</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric &lt=
;JinHuiEric.Huang@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 6, 2025 10:00:38 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topolo=
gy</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 2025-02-06 10:14, Lazar, Lijo wrote:<br>
&gt;<br>
&gt; On 1/29/2025 8:50 PM, Eric Huang wrote:<br>
&gt;&gt; In some ASICs L2 cache info may miss in kfd topology,<br>
&gt;&gt; because the first bitmap may be empty, that means<br>
&gt;&gt; the first cu may be inactive, so to find the first<br>
&gt;&gt; active cu will solve the issue.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 +++++++=
+++++++++--<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 16 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_topology.c<br>
&gt;&gt; index 4936697e6fc2..73d95041a388 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
&gt;&gt; @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd=
_cache_properties **props_ext,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cache_type, unsigned int cu_proc=
essor_id,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *knode)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned int cu_sibling_map_mask;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned int cu_sibling_map_mask =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int first_active_cu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, xcc, start, end;<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc =3D NUM_XCC(knode-=
&gt;xcc_mask);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_cache_properties *p=
cache =3D NULL;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_memory_partition m=
ode;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 knode-&gt;adev;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; bool found =3D false;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start =3D ffs(knode-&gt;xcc_ma=
sk) - 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end =3D start + num_xcc;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; cu_sibling_map_mask =3D cu_info-&gt;bitmap[sta=
rt][0][0];<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; /* To find the bitmap in the first active cu *=
/<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; for (xcc =3D start; xcc &lt; end &amp;&amp; !f=
ound; xcc++) {<br>
&gt; It seems there is an assumption made here that a CU in one XCC could<b=
r>
&gt; share this cache with CU in another XCC. This is not true for GFX 9.4.=
3<br>
&gt; SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.<br>
In KFD topology we only report L2 cache info of the first active cu in A <b=
r>
XCC, which could be XCC0 or XCC1. It is generic for L2 info in the <br>
certain XCP/kfd node, and not specific for every XCC, so it doesn't mean <b=
r>
the L2 cache found in XCC0 can be shared with XCC1, it only means there <br=
>
is L2 cache in this kfd node.<br>
<br>
Regards,<br>
Eric<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; for (i =3D 0; i &lt; gfx_info-&gt;max_shader_engines &amp;&amp; !found; i=
++) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; gfx_=
info-&gt;max_sh_per_se &amp;&amp; !found; j++) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (cu_info-&gt;bitmap[xcc][i % 4][j % 4]) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_s=
ibling_map_mask =3D<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info-&gt;bitmap[xcc][i % 4][=
j % 4];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; foun=
d =3D true;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_sibling_map_mask &amp;=3D<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ((1 &lt;&lt; pcache_info[cache_type].num_cu_shared) - 1);=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first_active_cu =3D ffs(cu_sib=
ling_map_mask);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB78048C1038DC5F279EF24E2A97F62DS0PR12MB7804namp_--
