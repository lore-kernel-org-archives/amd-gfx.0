Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0322AC2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 13:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB5510E44D;
	Mon, 24 Jun 2024 13:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQdy/XS9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D81E10E46E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 13:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh45Rqiwd6IxphDIa3f8Hg0P8kd77rx435sLrTT9b8yhPlCi57lhQVVOMYfIhHDDZORDU5bPsJUX3edncvyuR/vuZl68veJGcy5eQ+hr7QMSENZelZ0Dp3NbVrdFc0Cpk7P6p9CWbyHuEBnPZDixRX80DcbElditj9ZnHdgIDAKe5Rg/KLLpgCza9+Ov/BkqXbs5COyPemlGeD8iShTberFQ1HWAMpso/dGWjaBC3BxxrwWxK4PfE/XWBldTCyVRSF5ciJcFXctpf+E6dv6SJE7OY/P9kDzhh/6ypfddfL0rLHp+iBdnsIkli50/K9/wzlCLwunvi45Ljl1qulOGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3VMH46hNJPRzsfHxMmtumZHdUNnO7/I2pDu6Jm/e5g=;
 b=hNbo1a5CPOk07xbDbpTyQPnCFqLP62bRYTxm+ASz0b1HQIjuscYKsQlxS/jYjsxa4nGMrKfYiu10SWANmiyr1hB90RUeL86/AlHOtX6V7yXqWFs64mJbSj0CHklfwbNKyEmR8NSS93e7s5SvLvFsVaLj9wslYazIWqZzbl9V8SewbLGtYDGyDfd6lngqvHxqKRpaE4E+ygVXA92H11CeRYrVdxcW3I7H2F2O28cNvcRpOziQDaiH8wZ4I4Wp/lQEyuXxV+5joS/2bXTj5f4AkHoDgjHNfL2nHGOrr+QCW5HnmMRuMeFNZW8jvCNoikHrB1SRHFPAAQ6kp6wGdKJ2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3VMH46hNJPRzsfHxMmtumZHdUNnO7/I2pDu6Jm/e5g=;
 b=pQdy/XS9LHYVlmZ5nCvCccaT6InOeEH/eNNTeom6JLvRSeeMh/VD4axK8919Dd2qklSSHP+GSOqUL978g0Oxkr3lBMy07MkJKmqO1L5LlbC3fcVnIrX/yf8T4gQArlLnLO1VV/NCqLozgiBKfMUnrZ0FnNQrddC7UGOjzlHdPMg=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 13:50:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:50:57 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov in TLB flush
Thread-Topic: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov in TLB flush
Thread-Index: AQHaxhbDpkVZHza63ken73MwMeDCkLHWzzgAgAAc9ZA=
Date: Mon, 24 Jun 2024 13:50:57 +0000
Message-ID: <PH0PR12MB5481151188FFD142CD5D8281FFD42@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240624091318.2487733-1-Jane.Jian@amd.com>
 <0cf4b8a0-d36c-4cbd-ad33-f74c2d1eff29@gmail.com>
In-Reply-To: <0cf4b8a0-d36c-4cbd-ad33-f74c2d1eff29@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4dc82fd1-b0f7-434d-9c34-603cffb5fd79;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-24T13:41:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: 8d67d2a2-780f-47f1-49ea-08dc9454acc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b46YicJDWdWiFnxfS2MMayCXcLkSznpdBjfVH4wvYkxURxwNvVGT9gag/O?=
 =?iso-8859-1?Q?wc1Sr8OqIpyEWyItFzkiP0xJZr7KX1fa0NBQzgYcgmhwRRp0XmJqHQm/c3?=
 =?iso-8859-1?Q?ksuGKe5vAWnDfPRrYekcQmocq+bgLS5jf6gTU9NVXKB7rgkQN46tp5HdAt?=
 =?iso-8859-1?Q?tXLAuPs3OCpu0MTMlWgTT8STzFZQOJ2NnVOgsZ2HA+vvniuKCi/lLTf7DP?=
 =?iso-8859-1?Q?uQMtt0wFZF/nB4mrRr0Svr0SPQBErEZUQy998mswBd5CLB+LCiQ70uKZTj?=
 =?iso-8859-1?Q?j2gsK0aWhQnvaHy+N7vFhkcTO6/ZZsRGeHclV9yPbto51HuRBESAavINEp?=
 =?iso-8859-1?Q?EdjZfqH78Jn+L1U07EYoF9ZQ8nJNiBvKI5unpylyPOfg+1u3Lhj5v5QEQj?=
 =?iso-8859-1?Q?5prdeX7O+KGmLWwxnaVCNZgE2k6ubLRHEqTU86dSMNABkFxZTsgLHL+BZV?=
 =?iso-8859-1?Q?kxRN61KA0lQI6GkLq4wBcITrOQEU7msD/bKm94ssN9eBiSsFwBbCdReXvz?=
 =?iso-8859-1?Q?07tcyOOCvWMkWZuTM+LcuzHRjfpUQJ1xVCTziVkPnFSrxsFw+t/qAAPGpE?=
 =?iso-8859-1?Q?PapYn22mkooGFCR8BWzsF/vW8+wwHmf9y8uZU2cImSaNxwA5aR4YH7znIM?=
 =?iso-8859-1?Q?KpQD1he35P418lFaFvkQvgiu3cI1sqLuZ9diK5gQ7l1LtEt451Fo0qvdz0?=
 =?iso-8859-1?Q?nRj8AaujNeKScW7fkzg+DhOmsMND8a97NdaWVh6yweVDRi+Y8oblLmDcVU?=
 =?iso-8859-1?Q?mhNqr8V2RtyKCSoScscIyxHVBEOfd+2l1r5igYxW05Xcdx+B4qbSiuBfkz?=
 =?iso-8859-1?Q?6L1I0Oem1ocks8CXkgXAsF492cE6gMEeT/d4UqWmuSNv3B9TJ9ozpOSF53?=
 =?iso-8859-1?Q?vAF8Yw/SMBmHB6cXJmXtZX1NpLF79cIPdTEyJ8ai87Z+ccaGskJqfNuFQN?=
 =?iso-8859-1?Q?Emy6jORaL7D8/YF3iWjrISMYYoQPMGZpa+t8TdOcJ2JVGtDEFAJdfDbC7J?=
 =?iso-8859-1?Q?+EYeum16p3BOtsnQcv1h9iAq59JsrA4iVZhRQQBPkcpIu6XeJf7z+cofQy?=
 =?iso-8859-1?Q?H6xmmz81wKvrXdyIgj3E6yPlDZVjaUX+KXmzRG6j7rPVdDGtqeAPKnuAOY?=
 =?iso-8859-1?Q?lSiiYK3ez8X2rAmu3CrGK4Je2J55ADf3X3DYu4R6WXCTH6ORwPsmK5XnjE?=
 =?iso-8859-1?Q?EY/F+FIElxRxODhOy6E2dF2YdzSyNIs2yTvHLUszjIj6GMe4ZnpYgFyMIz?=
 =?iso-8859-1?Q?FJu70E2YZunEt7N8wZvvki3wiI9ksQsSgUuPOmVMIH/m8NcBwh/YfEQ1YP?=
 =?iso-8859-1?Q?E4sEY0S75O5wqc2SeW3wTPMZoaefmck3HETSLanrF1qbHitOoWBDyt4eGI?=
 =?iso-8859-1?Q?vMnhsZs9P+8USYFpndwjBTi7mzqnCnzAcw6FYnQTY3WfG1y1lqtE4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QaaoTyfAnE7thbqEXe1/WAvL9pOPdvWYebpLcwf158qYKpjpSoo/huq7mu?=
 =?iso-8859-1?Q?OOH90dE0aBG+L6It5Ary6GlAxgQcyIbP6Q6BCfwkMNvKi0RWbaf8k7aJoL?=
 =?iso-8859-1?Q?Ej0WqTe9fPm+3Y722nAASpjWhx/7e7UShbRp0HqxIh7IDtjP1nFZJBTI8h?=
 =?iso-8859-1?Q?MH6YU7vdan4zsoLyugdZhl2sQSZ1cbPm3aGcATRuoJXuDznpScXaN3gRrK?=
 =?iso-8859-1?Q?iJdwc5I/2PV3r9PDNPFoXNHi+FDcy89jrrAL74Pq/vnKnERKJ3+J8CToQw?=
 =?iso-8859-1?Q?CBy5bRlfVbLz0/wBcaIWIwhBX7/Ow9qruKiorQgv7e1ZHdv5DkDNz/iU3I?=
 =?iso-8859-1?Q?W5Ag4qmK+xGUVYkhZ8xXV6luTwNSWj80QMPXXtUzFqOfRVtiXb2effaJ8b?=
 =?iso-8859-1?Q?5Uy3+wqpKvc1VhGhkV9bWfVYHobdE+mtuog8dy9uvxonRV1mrjkQUOSdy2?=
 =?iso-8859-1?Q?WrlaZR99xdTVpo1MiktKSebgMXRG8T2AbdjJ6EJbiQLFxWlv+2JKhnXH15?=
 =?iso-8859-1?Q?yPwhUzi0uRkEcCMfaoHXJFBAu8lN9jNkvldSTRD0VPwL3R2kzKZFSyWzDu?=
 =?iso-8859-1?Q?GfpCdTSjgUXMysWhCr8PEwJ5xozroujV7Y6/nVLK/lV2fPO+N23XesydHC?=
 =?iso-8859-1?Q?lThXg/Pm/qQMjjoPQgdE9GYgkiAjSP7agil+qpoZTNVEdnMvRyMRZE5txv?=
 =?iso-8859-1?Q?YkJnNfCCB319FF5eDe6JxqyjJJcOupooz7NkxyA5TuE9uHE1dwSAPB3hjw?=
 =?iso-8859-1?Q?ICBWC4wnn8y3/F1AoyUBnsCWER8KFmd0/43AqBs1u+hUGQ2ZLnhlGbSH0s?=
 =?iso-8859-1?Q?l9z8Gba7sJcdrMuKj/Rsj0w3tMfmT7NTpmLEDW5eW9yF1f1C6ct4Xo4nOs?=
 =?iso-8859-1?Q?quVBap1aZYS/D8wn51glGiAS4D9kST1OQoIabtCeLVSxZfnAGRnTi0Go86?=
 =?iso-8859-1?Q?tNsBnoqrZUmCoULXqaI8deXlIVdJBjX4XGUNt9z3KpA04Cg4gSpoYN9a16?=
 =?iso-8859-1?Q?t2fsLOv/lo5vmN+OkX0bM4zwD2Ds2PZU8JtipJ5mvYrq/cgtUI921bewM6?=
 =?iso-8859-1?Q?EGxmFjH2kUti+40DxtgtUx2JSqQecAk11Xq5TPCJXeK4x6NFhGYs3ZFITo?=
 =?iso-8859-1?Q?eXuO3A4AXLTPFLNx7Y2Tm7ymskBwESlAPvbTId9134uJA/R4JvXdj9KIka?=
 =?iso-8859-1?Q?OOYyrCicG0FtoxWlkexqqBJti9GNIDMtfdxK5QdMVRUADMWxYw1SvqIRD4?=
 =?iso-8859-1?Q?Mz2uFsms64ajzzs7n5mwO225EqWOQFJ38+sbn2BR5Ywo02Ft3wKZh3vt/8?=
 =?iso-8859-1?Q?18/T/Rjscr2jbPCojsg8AG32nFUybdhmdzCLGiEy0O3R9qzfd5n7py2Pre?=
 =?iso-8859-1?Q?Pn+QAqkCx9IhF83Cdx/7a6kSVXAw6Yxj1xVRzLPURZpbh+zk0RXDIfjnU7?=
 =?iso-8859-1?Q?Bv7kinxpAhaU5D+2WoQ83HW+/HI02aOgA8LivC3sxBjlW5ntp413sqnioR?=
 =?iso-8859-1?Q?y4hx0kRus6zIH6FZcRZQf95xOWxlwdGRLyKLo5Ob2MNKCXeTwHNG8ITI9w?=
 =?iso-8859-1?Q?oEqgZz2RjgOjNPdw8qCbZx8Dndh/xxxDgcBrnFwgSh51gf/PvpriCraDOM?=
 =?iso-8859-1?Q?epu2aVAZiuUFs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d67d2a2-780f-47f1-49ea-08dc9454acc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 13:50:57.6288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znjOiY9NtnDahg+GxNLsqSeMFgEoXIb/MJMfDPrQ4uVz1pDtnEum2tt9IUNfG6ppyZACARNvPZJgmVuS4IHxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Christian,
I want to explain here that:
1. add the normalization func in the asic file: this was modified according=
 to previous Lijo's comments, he thought it would be more convenient if fur=
ther asics need that way as well.
2. currently we only covered gpu flush tlb path since blocking issues, late=
r I will submit part 2 that covers the normalization for  all sriov read/wr=
ite cases(not only KIQ code.

Thanks,
Jane

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, June 24, 2024 7:58 PM
To: Jian, Jane <Jane.Jian@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chang=
, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to read/w=
rite under sriov in TLB flush

Am 24.06.24 um 11:13 schrieb Jane Jian:
> [WHY]
> sriov has the higher bit violation when flushing tlb
>
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod
> higher bit violation RLCG will mask xcd out and always assume it's
> accessing its own xcd
>
> [TODO]
> later will add the normalization in sriovw/rreg after fixing bugs
>
> v2
> rename the normalized macro, add ip block type for further use move
> asics func declaration after ip block type since new func refers ip
> block type add normalization in emit flush tlb as well
>
> v3
> declare the new func in the asic specific header
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  17 ++++
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h |  28 ++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
>   drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
>   drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
>   6 files changed, 130 insertions(+), 66 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 083f353cff6e..070fd9e601fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
>       const struct amdgpu_video_codec_info *codec_array;
>   };
>
> -/*
> - * ASIC specific functions.
> - */
> -struct amdgpu_asic_funcs {
> -     bool (*read_disabled_bios)(struct amdgpu_device *adev);
> -     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
> -                                u8 *bios, u32 length_bytes);
> -     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
> -                          u32 sh_num, u32 reg_offset, u32 *value);
> -     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> -     int (*reset)(struct amdgpu_device *adev);
> -     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
> -     /* get the reference clock */
> -     u32 (*get_xclk)(struct amdgpu_device *adev);
> -     /* MM block clocks */
> -     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dcl=
k);
> -     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ec=
clk);
> -     /* static power management */
> -     int (*get_pcie_lanes)(struct amdgpu_device *adev);
> -     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
> -     /* get config memsize register */
> -     u32 (*get_config_memsize)(struct amdgpu_device *adev);
> -     /* flush hdp write queue */
> -     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *r=
ing);
> -     /* invalidate hdp read cache */
> -     void (*invalidate_hdp)(struct amdgpu_device *adev,
> -                            struct amdgpu_ring *ring);
> -     /* check if the asic needs a full reset of if soft reset will work =
*/
> -     bool (*need_full_reset)(struct amdgpu_device *adev);
> -     /* initialize doorbell layout for specific asic*/
> -     void (*init_doorbell_index)(struct amdgpu_device *adev);
> -     /* PCIe bandwidth usage */
> -     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0=
,
> -                            uint64_t *count1);
> -     /* do we need to reset the asic at init time (e.g., kexec) */
> -     bool (*need_reset_on_init)(struct amdgpu_device *adev);
> -     /* PCIe replay counter */
> -     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
> -     /* device supports BACO */
> -     int (*supports_baco)(struct amdgpu_device *adev);
> -     /* pre asic_init quirks */
> -     void (*pre_asic_init)(struct amdgpu_device *adev);
> -     /* enter/exit umd stable pstate */
> -     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool en=
ter);
> -     /* query video codecs */
> -     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
> -                               const struct amdgpu_video_codecs **codecs=
);
> -     /* encode "> 32bits" smn addressing */
> -     u64 (*encode_ext_smn_addressing)(int ext_id);
> -
> -     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
> -                              enum amdgpu_reg_state reg_state, void *buf=
,
> -                              size_t max_size);
> -};
> -
>   /*
>    * IOCTL.
>    */
> @@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
>       MAX_HWIP
>   };
>
> +/*
> + * ASIC specific functions.
> + */
> +struct amdgpu_asic_funcs {
> +     bool (*read_disabled_bios)(struct amdgpu_device *adev);
> +     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
> +                                u8 *bios, u32 length_bytes);
> +     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
> +                          u32 sh_num, u32 reg_offset, u32 *value);
> +     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> +     int (*reset)(struct amdgpu_device *adev);
> +     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
> +     /* get the reference clock */
> +     u32 (*get_xclk)(struct amdgpu_device *adev);
> +     /* MM block clocks */
> +     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dcl=
k);
> +     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ec=
clk);
> +     /* static power management */
> +     int (*get_pcie_lanes)(struct amdgpu_device *adev);
> +     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
> +     /* get config memsize register */
> +     u32 (*get_config_memsize)(struct amdgpu_device *adev);
> +     /* flush hdp write queue */
> +     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *r=
ing);
> +     /* invalidate hdp read cache */
> +     void (*invalidate_hdp)(struct amdgpu_device *adev,
> +                            struct amdgpu_ring *ring);
> +     /* check if the asic needs a full reset of if soft reset will work =
*/
> +     bool (*need_full_reset)(struct amdgpu_device *adev);
> +     /* initialize doorbell layout for specific asic*/
> +     void (*init_doorbell_index)(struct amdgpu_device *adev);
> +     /* PCIe bandwidth usage */
> +     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0=
,
> +                            uint64_t *count1);
> +     /* do we need to reset the asic at init time (e.g., kexec) */
> +     bool (*need_reset_on_init)(struct amdgpu_device *adev);
> +     /* PCIe replay counter */
> +     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
> +     /* device supports BACO */
> +     int (*supports_baco)(struct amdgpu_device *adev);
> +     /* pre asic_init quirks */
> +     void (*pre_asic_init)(struct amdgpu_device *adev);
> +     /* enter/exit umd stable pstate */
> +     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool en=
ter);
> +     /* query video codecs */
> +     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
> +                               const struct amdgpu_video_codecs **codecs=
);
> +     /* encode "> 32bits" smn addressing */
> +     u64 (*encode_ext_smn_addressing)(int ext_id);
> +
> +     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
> +                              enum amdgpu_reg_state reg_state, void *buf=
,
> +                              size_t max_size);
> +     /* normalize offset to keep in lower 16-bit */
> +     u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32
> +offset); };
> +
>   #define HWIP_MAX_INSTANCE   44
>
>   #define HW_ID_MAX           300
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 2c9a0aa41e2d..7cdd4b9d08ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -29,6 +29,7 @@
>   #include "gfx_v9_4_3.h"
>   #include "gfxhub_v1_2.h"
>   #include "sdma_v4_4_2.h"
> +#include "aqua_vanjaram.h"
>
>   #define XCP_INST_MASK(num_inst, xcp_id)                                =
        \
>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0) @@
> -1085,3 +1086,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct
> amdgpu_device *adev,
>
>       return size;
>   }
> +
> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
> +hwip, u32 offset) {
> +     u32 normalized_offset;
> +
> +     switch (hwip) {
> +     case GC_HWIP:
> +             normalized_offset =3D offset & 0xffff;
> +             break;
> +     default:
> +             normalized_offset =3D offset;
> +             break;
> +     }
> +
> +     return normalized_offset;
> +}

Please completely drop that approach. This is KIQ specific and should be ha=
ndled inside the KIQ code and not here.

Regards,
Christian.

> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
> new file mode 100644
> index 000000000000..8d1b7a89cb71
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __AQUA_VANJARAM_H__
> +#define __AQUA_VANJARAM_H__
> +
> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
> +hwip, u32 offset);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..19e4429db37c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>        */
>       if (adev->gfx.kiq[inst].ring.sched.ready &&
>           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -             uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
> -             uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;
> +
> +             /* Select lower 16 bits to write in local xcc */
> +             if (AMDGPU_IS_GFXHUB(vmhub)) {
> +                     req =3D NORMALIZE_XCC_REG_OFFSET(req);
> +                     ack =3D NORMALIZE_XCC_REG_OFFSET(ack);
> +             }
>
>               amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>                                                1 << vmid, inst);
> @@ -979,6 +983,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct am=
dgpu_ring *ring,
>       struct amdgpu_vmhub *hub =3D &adev->vmhub[ring->vm_hub];
>       uint32_t req =3D gmc_v9_0_get_invalidate_req(vmid, 0);
>       unsigned int eng =3D ring->vm_inv_eng;
> +     u32 low_distance, high_distance, req_offset, ack;
>
>       /*
>        * It may lose gpuvm invalidate acknowldege state across
> power-gating @@ -986,7 +991,18 @@ static uint64_t gmc_v9_0_emit_flush_gpu=
_tlb(struct amdgpu_ring *ring,
>        * release after invalidation to avoid entering power gated state
>        * to WA the Issue
>        */
> +     low_distance =3D hub->ctx0_ptb_addr_lo32 + (hub->ctx_addr_distance =
* vmid);
> +     high_distance =3D hub->ctx0_ptb_addr_hi32 + (hub->ctx_addr_distance=
 * vmid);
> +     req_offset =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +     ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>
> +     /* Select lower 16 bits to write in local xcc */
> +     if (AMDGPU_IS_GFXHUB(ring->vm_hub)) {
> +             low_distance =3D NORMALIZE_XCC_REG_OFFSET(low_distance);
> +             high_distance =3D NORMALIZE_XCC_REG_OFFSET(high_distance);
> +             req_offset =3D NORMALIZE_XCC_REG_OFFSET(req_offset);
> +             ack =3D NORMALIZE_XCC_REG_OFFSET(ack);
> +     }
>       /* TODO: It needs to continue working on debugging with semaphore f=
or GFXHUB as well. */
>       if (use_semaphore)
>               /* a read return value of 1 means semaphore acuqire */ @@ -=
994,18
> +1010,14 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_rin=
g *ring,
>                                         hub->vm_inv_eng0_sem +
>                                         hub->eng_distance * eng, 0x1, 0x1=
);
>
> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> -                           (hub->ctx_addr_distance * vmid),
> +     amdgpu_ring_emit_wreg(ring, low_distance,
>                             lower_32_bits(pd_addr));
>
> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> -                           (hub->ctx_addr_distance * vmid),
> +     amdgpu_ring_emit_wreg(ring, high_distance,
>                             upper_32_bits(pd_addr));
>
> -     amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
> -                                         hub->eng_distance * eng,
> -                                         hub->vm_inv_eng0_ack +
> -                                         hub->eng_distance * eng,
> +     amdgpu_ring_emit_reg_write_reg_wait(ring, req_offset,
> +                                         ack,
>                                           req, 1 << vmid);
>
>       /* TODO: It needs to continue working on debugging with semaphore
> for GFXHUB as well. */ diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..3a1fa2797f02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -78,6 +78,7 @@
>   #include "mxgpu_ai.h"
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
> +#include "aqua_vanjaram.h"
>   #include <uapi/linux/kfd_ioctl.h>
>
>   #define mmMP0_MISC_CGTT_CTRL0                                          =
                         0x01b9
> @@ -927,6 +928,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_a=
sic_funcs =3D
>       .query_video_codecs =3D &soc15_query_video_codecs,
>       .encode_ext_smn_addressing =3D &aqua_vanjaram_encode_ext_smn_addres=
sing,
>       .get_reg_state =3D &aqua_vanjaram_get_reg_state,
> +     .normalize_reg_offset =3D &aqua_vanjaram_normalize_reg_offset,
>   };
>
>   static int soc15_common_early_init(void *handle) diff --git
> a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 242b24f73c17..01afd1a24e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -210,4 +210,7 @@
>   #define WREG64_MCA(ext, mca_base, idx, val) \
>       WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) +
> mca_base + (idx * 8), val)
>
> -#endif
> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
> +     ((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) =
? \
> +     adev->asic_funcs->normalize_reg_offset(GC_HWIP, offset) : offset)
> +#endif
> \ No newline at end of file

