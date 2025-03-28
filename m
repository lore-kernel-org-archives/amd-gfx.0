Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF09C36011
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 15:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9856710EA53;
	Fri, 28 Mar 2025 15:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NABO0KTe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFA410EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 15:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7FlOoHkxrSquZBhlH2CRGGruheb22EPrx3d9CURmXK/o/oqdgZS5J+ZWmTLOxol1eR0tRwZX4D6X2/9n/CPz3Jab1m7wSvkx1Xd7/3pvKXmHWgzSuUlm+kK8nq33MrJSR4nlhUmCyw9Lf+i8ShLee81NsQPXNJ1wewCGtQA+bzYxEfhU6kld37emUIqLxgLOIxG5x9d6EnnkX+V4sAE+RSFMSkZfdxdTo4rm8jTT6gBBdpvOApn1p2WqeK/HfhLjlR6gG4Wzeo/YMirolWugrZPaJnnsCqm/DR6E9Z99fl08trUbDY+M5rwey2RV+3GqyQx/xkbik8rZ4zCL/27pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXUGunZMWrEVN/fD0bFBdHGGQCMl9n5kZ6OFL10kuHM=;
 b=MIBiief/1ovx08R4/5O7DJiywCcjCKPgwFbeWUjQ576O6VqiqRd2xs/bj97fJ9PU13VWdAHqPxvdKRnXLSOFV3hHHLRcG5gYVXqlp4JSdb1koFi7/1NvlpUtQxVRWEQxo0o2lsgFvCtAciUcU7nykRBABJUG3bHk4wYnB0ROez46AtEzYACOHu23LEINfi+Mpm7QfIGNzimF7E+aOTEIJpH25oiZPF6Gj7EctUs2FjWHI5ETc79MUDlPOLZtomoDjkhpcJ85eMt8U74lxiVxNaPKRzv9ov0dkrqGGXD41Uq9LfJ3CtHTFfdVfvQDS1RcgVvm/PDpqJAuyh4T2p6cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXUGunZMWrEVN/fD0bFBdHGGQCMl9n5kZ6OFL10kuHM=;
 b=NABO0KTe4xfGL0ylwV4SGOj76aBt6iKj9DoqQzSbaUoZOctCX8d8FK7bLkAlD7IywoWphl3sRUzg2i2uHlUkPNaFYV1vnFpmFaQv+fyf6nHZgry5ab71pusOz0czUYEsNnwlMBmWEcVbn9Hu1NDQ7opepP1pdk2kE7ncCduiecg=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:47:48 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:47:48 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add indirect L1_TLB_CNTL reg programming for
 VFs
Thread-Topic: [PATCH] drm/amdgpu: Add indirect L1_TLB_CNTL reg programming for
 VFs
Thread-Index: AQHbnzENzEm48GIRkk26Hq4Zw3QJobOIsMkA
Date: Fri, 28 Mar 2025 15:47:48 +0000
Message-ID: <BL1PR12MB53177247E0961071409C7015F1A02@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20250327155753.252423-1-victor.skvortsov@amd.com>
In-Reply-To: <20250327155753.252423-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f37c1093-2ba0-4ca1-a43a-f312e5bd755e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-28T15:39:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|PH8PR12MB6867:EE_
x-ms-office365-filtering-correlation-id: 7ec0604f-6e78-45db-0e02-08dd6e0fe425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fcFy2qpJqfm3ShjlUOAGGKYpq7SxZ8crC4bmXFkjmuMYNKmF2DNy8AjyiJg3?=
 =?us-ascii?Q?NgDwOJ2n2pzyXB4PqnwY7vNC679kGQjohSStAPXkQfAkHwd6D6+d9Mz+0F3l?=
 =?us-ascii?Q?mVQQvu2GveZKJ3ShxBWgTGsQqLgv+0l7dVy62ed+PLuZbtDYw3GjHdd8Jsb+?=
 =?us-ascii?Q?+MiAF6Na2+pKC6ikFYnxYonWYI1pH1WRjTqM6GNkfylTwBGyFDilYt6Nk+wp?=
 =?us-ascii?Q?3gSvQ6QiHaVHeL6MNb6BUidyKAKt94XcpfAZGyUvtWX3lNtRo2wFexQ1nLrK?=
 =?us-ascii?Q?6DXmLiu7pV+DujInyptY67uCaHzU6eckKk/ny8LRkh4BomSVQ/zV5uzNjY2R?=
 =?us-ascii?Q?kBO66Sh2SjwQ6IljSGkpVv4TJKL9wP+OiHXJjZhdOTy4Hn/tGtGl53ePtm2w?=
 =?us-ascii?Q?gm1bjMEtPfPFzDUsT3YkUNF9i7kcPAxIjvGtryQaLLoa+XLlbWjvFAeuoAbx?=
 =?us-ascii?Q?2rsSwaeBxUrEKZofx2YsOntOVj/DeGrSJhebGw32n3LeGqpMIzJk0J+Lk7Z1?=
 =?us-ascii?Q?MljHU9En9zln2yS3FYq+gYwdk+UEmqV5nx++tBpNzp/DpWFGTnfq7W9EObvy?=
 =?us-ascii?Q?hlL4DSmlA9HKRgde3zPIUP3X/N3yKG21AKcQce6LawfE+uwJN+58iQ8VZ08S?=
 =?us-ascii?Q?X71TAG6bSsboM2wTIcYmnZWzSShARaO0ktKPwHNfSmbuSwZV/waE+FQDryMj?=
 =?us-ascii?Q?YQCR7qHthQ1EarCiqkGFgSQ8hevJjDHpi9dv0Zh5N/Pdoc5WerMBWkcVuz7Z?=
 =?us-ascii?Q?d6NfbDv71c0cQTGAVgnXKAM23Kf8TDh55QBLD78rEw3LicegyXHVycgclk8g?=
 =?us-ascii?Q?Ojl0XQmnic0Hg00yiHRNBVDghKdVA7wZDetDWm73bX4cILd13IilcYhzQ+OX?=
 =?us-ascii?Q?DtoE/bJR1vEAOTOyUTlaVZ7VbGJXI+dd+oE7sxs1eZvzkkdQsBMmoFs2TC/W?=
 =?us-ascii?Q?RFilssnrn3cvoea8fQI8l8SG++TsxOPbXBzKQ5vZ1zAEoMuKZC0aBul1ZRq4?=
 =?us-ascii?Q?vSu9MKEnNy1gyZgEYNrOYh+G3Tq1ddhVDUfjIVj6DhQ+DQYVxQNxBmIu6HQZ?=
 =?us-ascii?Q?tt+7YrgEZcAmHn7jDQ6tgwqf5fQmSStOZ29zsiOCkKwXQD9iGjftJPnAqEbL?=
 =?us-ascii?Q?sOZbsYSC2p1ylmOQeHlpTSLQ7L+vKnS+jNkFSpYUP7rFX/5QTno5dgI7vZoW?=
 =?us-ascii?Q?gS7AgqoIg8Bb0GbIwlwi3cBbyEqaLtVmpNUC6uYnZgwwSqbxLlHLXDpPbVwP?=
 =?us-ascii?Q?wJTajsyL/5SJgiYKlnDCn3mPBHxj1413w/euQWKuad4/d5oOJjOxGd1q5vYK?=
 =?us-ascii?Q?TgeJxfIUqx1do5zPT4YEPKLAO6z4HNwR9XaDLi2fXF8PDZgMBlFtR2XvHfIa?=
 =?us-ascii?Q?+qmTt67PKqvh7MXTH2sjdK7RTFCOYJzM+PoudxBOCHt4h4KzE46g5ZraSGGT?=
 =?us-ascii?Q?11iSzQ9X0UUxZGt/4qlPmm3QB09ZlvrP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sywAkeMFDnnVZc6vSB7vRdyG+a2TkVPYnDNCuJFNfK8dHatZO9WH//052erp?=
 =?us-ascii?Q?sC6jE6ewQIt8TPEpo7A6XZmDpsxqadXz7p9KgKI6a4aUOv8p41KS+63a56aj?=
 =?us-ascii?Q?/i7lWX3jZl971AGyxFUoAvZmi/39fTd0OWagJxKQI/4IsN+NMSTwma+1M88r?=
 =?us-ascii?Q?p0Qm4XY3rfOPS2w77rA5T3Y2hYVo9INQhFrsnaQJRuNb/qwOmwjiVWl5eeE1?=
 =?us-ascii?Q?a2tYp255DgAnT0eMINj9vaWdEP18Efy2oagDw2Ll1FIMDK3F2h1OqMd3CUOa?=
 =?us-ascii?Q?+MtXcQ3YMW0gCVHDczLcZBsVfNqzx6vNzw1mB+g+1v6pE8bYlMGNYjQihali?=
 =?us-ascii?Q?vRIIc4aP1pPzDK5IeV8d+xTqjoqiy+vgSnItIoHwgNriwrOP6uACnRG7FLHx?=
 =?us-ascii?Q?Cv1aQcop+mjHVZIF/AIzzxaO+tSek151RtRxFM84vmPUzndLdHaHWRt/vILY?=
 =?us-ascii?Q?5lQINh1RFRPjjk5ABSLIwZ0c3rzLltSUPfumalCu9LGCj2DfWIDAc9rc8kYy?=
 =?us-ascii?Q?/7yyCwz/7yeO6XrkBlJau7vlmypynV6n6k+PlZGROkVb6jrGfabDf4iGx3hS?=
 =?us-ascii?Q?Gug2vUeUiiGa3xnZlTxfTJcGXwzGXpINjzUcinsxgkpN7x0EEiVOimatVFNS?=
 =?us-ascii?Q?j2sifKxQqhSydm4FizqDS/dooiS1sGlqoUgJfHC2wkulS4jLRnwg6M/HNvXa?=
 =?us-ascii?Q?EesqxQHDEODRCAV7X/awe6XjAuR6H1C8xUa/IvSaCc62y5u/fP66FpfUkJie?=
 =?us-ascii?Q?JHSF+e4Lz1mhNm8KSt1EO9mVKdUVJ51JHQoiuBGOFDMRKEfGCzg2zhJxd8YJ?=
 =?us-ascii?Q?nYZTFow8IBAjhMGM1Q4tm5iKaDaaY9xaeqf4q0KtTxt/s0ygUqt9eO371/oR?=
 =?us-ascii?Q?S87qZyfzGHa3u41BS2z77S5KhioK/IqolyI+EJQtyR8p+pGOZnUDnddx9JpS?=
 =?us-ascii?Q?GUcm3jONi+/wsLSNB5N5qv1XaoOwOM27bNCRyARRRQk4qGIvwqrrvrPson8V?=
 =?us-ascii?Q?BwdXxvgnDpNq+FQ0DVWVTG+xTGUNc/Nv6wnnhmIBwjaC8d6U7P1B+IAzq2Ji?=
 =?us-ascii?Q?y/4dzY9xFuAeKDd5pOaaI3+AfHrXHfmvfryVMyoE7Swd2SsK2LizwnAdhvHi?=
 =?us-ascii?Q?V2fpBGwy85vamQEtMo7zeIifnv0qH/DbLdpATSG344ErWCrftVZPksZFTIh7?=
 =?us-ascii?Q?bx2Trqwsr491WPhSoUymwEWyk/OJlwjISlsNuf3AZnoVNDfzceJQVkSeIC1P?=
 =?us-ascii?Q?X/w+WGAVNKy9HCWkubWypgu9eqZRxfy7dpC1H+sriG2dRbb+G22hZbzcaHLP?=
 =?us-ascii?Q?QrA9L31UQ0dJFpKpMSgH8blhcfLf+sk6ibQ2pjn1atOjSMYcUYGn0HJ84ekw?=
 =?us-ascii?Q?yXGbBciIUwYdkHgwkh3KLYrrDJ7IZdAtveb9ZbJI4pRgWqYgmbco09zy+s+G?=
 =?us-ascii?Q?hpAsS3TVVFHVTbGwzrgzUSw4h6SSnKWuDRo/FCYqb4ufL8pTRuXaeXu17na+?=
 =?us-ascii?Q?YlFUioTjmppZ7lgOWE7qz8i8K3Ryk47dla3Dugj9WUe4DRtr+HGiJk8AImNx?=
 =?us-ascii?Q?RjCIkg5VqJMN+VA19ls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec0604f-6e78-45db-0e02-08dd6e0fe425
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 15:47:48.7396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wb3sO1IKOhwQKaScmkKT1WD8/6TdWcnr5vbmV8vDfs1gQ/V15XtlVJY7spxiWh4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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

> -----Original Message-----
> From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Sent: Thursday, March 27, 2025 11:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rehman, Ahmad <Ahmad.Rehman@amd.com>; Chan, Hing Pong
> <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Skvortsov,
> Victor <Victor.Skvortsov@amd.com>
> Subject: [PATCH] drm/amdgpu: Add indirect L1_TLB_CNTL reg programming for
> VFs
>
> VFs on some IP verions are unable to access this register directly.
>
> This register must be programmed before PSP ring is setup, so use PSP VF =
mailbox
> directly.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 12 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  9 +--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 63 ++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      | 20 +++++++
>  5 files changed, 93 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 8d5acc415d38..dcf5e8e0b9e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -107,6 +107,7 @@ enum psp_reg_prog_id {
>       PSP_REG_IH_RB_CNTL        =3D 0,  /* register IH_RB_CNTL */
>       PSP_REG_IH_RB_CNTL_RING1  =3D 1,  /* register IH_RB_CNTL_RING1 */
>       PSP_REG_IH_RB_CNTL_RING2  =3D 2,  /* register IH_RB_CNTL_RING2 */
> +     PSP_REG_MMHUB_L1_TLB_CNTL =3D 25,
>       PSP_REG_LAST
>  };
>
> @@ -142,6 +143,8 @@ struct psp_funcs {
>       bool (*get_ras_capability)(struct psp_context *psp);
>       bool (*is_aux_sos_load_required)(struct psp_context *psp);
>       bool (*is_reload_needed)(struct psp_context *psp);
> +     int (*reg_program_no_ring)(struct psp_context *psp, uint32_t val,
> +                                enum psp_reg_prog_id id);
>  };
>
>  struct ta_funcs {
> @@ -475,6 +478,10 @@ struct amdgpu_psp_funcs {  #define
> psp_is_aux_sos_load_required(psp) \
>       ((psp)->funcs->is_aux_sos_load_required ? (psp)->funcs-
> >is_aux_sos_load_required((psp)) : 0)
>
> +#define psp_reg_program_no_ring(psp, val, id) \
> +     ((psp)->funcs->reg_program_no_ring ? \
> +     (psp)->funcs->reg_program_no_ring((psp), val, id) : -EINVAL)
> +
>  extern const struct amd_ip_funcs psp_ip_funcs;
>
>  extern const struct amdgpu_ip_block_version psp_v3_1_ip_block; @@ -569,5
> +576,8 @@ bool amdgpu_psp_get_ras_capability(struct psp_context *psp);  i=
nt
> psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcp_id,
>       bool core_override_enable, bool reg_override_enable, bool
> perfmon_override_enable);  bool amdgpu_psp_tos_reload_needed(struct
> amdgpu_device *adev);
> +int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val=
,
> +                                enum psp_reg_prog_id id);
> +
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index df03dba67ab8..b6ec6b7969f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -146,11 +146,13 @@ enum AMDGIM_FEATURE_FLAG {
>
>  enum AMDGIM_REG_ACCESS_FLAG {
>       /* Use PSP to program IH_RB_CNTL */
> -     AMDGIM_FEATURE_IH_REG_PSP_EN     =3D (1 << 0),
> +     AMDGIM_FEATURE_IH_REG_PSP_EN      =3D (1 << 0),
>       /* Use RLC to program MMHUB regs */
> -     AMDGIM_FEATURE_MMHUB_REG_RLC_EN  =3D (1 << 1),
> +     AMDGIM_FEATURE_MMHUB_REG_RLC_EN   =3D (1 << 1),
>       /* Use RLC to program GC regs */
> -     AMDGIM_FEATURE_GC_REG_RLC_EN     =3D (1 << 2),
> +     AMDGIM_FEATURE_GC_REG_RLC_EN      =3D (1 << 2),
> +     /* Use PSP to program L1_TLB_CNTL*/
> +     AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN =3D (1 << 3),
>  };
>
>  struct amdgim_pf2vf_info_v1 {
> @@ -330,6 +332,10 @@ struct amdgpu_video_codec_info;
>  (amdgpu_sriov_vf((adev)) && \
>       ((adev)->virt.reg_access & (AMDGIM_FEATURE_GC_REG_RLC_EN)))
>
> +#define amdgpu_sriov_reg_indirect_l1_tlb_cntl(adev) \
> +(amdgpu_sriov_vf((adev)) && \
> +     ((adev)->virt.reg_access &
> (AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN)))
> +
>  #define amdgpu_sriov_rlcg_error_report_enabled(adev) \
>          (amdgpu_sriov_reg_indirect_mmhub(adev) ||
> amdgpu_sriov_reg_indirect_gc(adev))
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index d6ac2652f0ac..bea724981309 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -109,10 +109,11 @@ union amd_sriov_msg_feature_flags {
>
>  union amd_sriov_reg_access_flags {
>       struct {
> -             uint32_t vf_reg_access_ih       : 1;
> -             uint32_t vf_reg_access_mmhub    : 1;
> -             uint32_t vf_reg_access_gc       : 1;
> -             uint32_t reserved               : 29;
> +             uint32_t vf_reg_access_ih               : 1;
> +             uint32_t vf_reg_access_mmhub            : 1;
> +             uint32_t vf_reg_access_gc               : 1;
> +             uint32_t vf_reg_access_l1_tlb_cntl      : 1;
> +             uint32_t reserved                       : 28;
>       } flags;
>       uint32_t all;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 84cde1239ee4..cc218f6e37c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -30,6 +30,7 @@
>  #include "soc15_common.h"
>  #include "soc15.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_psp.h"
>
>  #define regVM_L2_CNTL3_DEFAULT       0x80100007
>  #define regVM_L2_CNTL4_DEFAULT       0x000000c1
> @@ -192,10 +193,8 @@ static void mmhub_v1_8_init_tlb_regs(struct
> amdgpu_device *adev)
>       uint32_t tmp, inst_mask;
>       int i;
>
> -     /* Setup TLB control */
> -     inst_mask =3D adev->aid_mask;
> -     for_each_inst(i, inst_mask) {
> -             tmp =3D RREG32_SOC15(MMHUB, i,
> regMC_VM_MX_L1_TLB_CNTL);
> +     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_l1_tlb_cntl(=
adev))

[Luo, Zhigang] amdgpu_sriov_vf() checking can be removed as amdgpu_sriov_re=
g_indirect_l1_tlb_cntl already has the checking.
With this change, this patch is reviewed by Zhigang Luo <Zhigang.luo@amd.co=
m>

> {
> +             tmp =3D RREG32_SOC15(MMHUB, 0,
> regMC_VM_MX_L1_TLB_CNTL);
>
>               tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ENABLE_L1_TLB,
>                                   1);
> @@ -209,7 +208,26 @@ static void mmhub_v1_8_init_tlb_regs(struct
> amdgpu_device *adev)
>                                   MTYPE, MTYPE_UC);/* XXX for emulation. =
*/
>               tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ATC_EN, 1);
>
> -             WREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
> +             psp_reg_program_no_ring(&adev->psp, tmp,
> PSP_REG_MMHUB_L1_TLB_CNTL);
> +     } else {
> +             inst_mask =3D adev->aid_mask;
> +             for_each_inst(i, inst_mask) {
> +                     tmp =3D RREG32_SOC15(MMHUB, i,
> regMC_VM_MX_L1_TLB_CNTL);
> +
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ENABLE_L1_TLB,
> +                                         1);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +                                         SYSTEM_ACCESS_MODE, 3);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +                                         ENABLE_ADVANCED_DRIVER_MODEL,
> 1);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +
> SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +                                         MTYPE, MTYPE_UC);/* XXX for emu=
lation.
> */
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ATC_EN, 1);
> +
> +                     WREG32_SOC15(MMHUB, i,
> regMC_VM_MX_L1_TLB_CNTL, tmp);
> +             }
>       }
>  }
>
> @@ -454,6 +472,30 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_devi=
ce
> *adev)
>       return 0;
>  }
>
> +static void mmhub_v1_8_disable_l1_tlb(struct amdgpu_device *adev) {
> +     u32 tmp;
> +     u32 i, inst_mask;
> +
> +     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_l1_tlb_cntl(=
adev))
> {
> +             tmp =3D RREG32_SOC15(MMHUB, 0,
> regMC_VM_MX_L1_TLB_CNTL);
> +             tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ENABLE_L1_TLB, 0);
> +             tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +                                 ENABLE_ADVANCED_DRIVER_MODEL, 0);
> +             psp_reg_program_no_ring(&adev->psp, tmp,
> PSP_REG_MMHUB_L1_TLB_CNTL);
> +     } else {
> +             inst_mask =3D adev->aid_mask;
> +             for_each_inst(i, inst_mask) {
> +                     tmp =3D RREG32_SOC15(MMHUB, i,
> regMC_VM_MX_L1_TLB_CNTL);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ENABLE_L1_TLB,
> +                                         0);
> +                     tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> +                                         ENABLE_ADVANCED_DRIVER_MODEL,
> 0);
> +                     WREG32_SOC15(MMHUB, i,
> regMC_VM_MX_L1_TLB_CNTL, tmp);
> +             }
> +     }
> +}
> +
>  static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)  {
>       struct amdgpu_vmhub *hub;
> @@ -467,15 +509,6 @@ static void mmhub_v1_8_gart_disable(struct
> amdgpu_device *adev)
>               for (i =3D 0; i < 16; i++)
>                       WREG32_SOC15_OFFSET(MMHUB, j,
> regVM_CONTEXT0_CNTL,
>                                           i * hub->ctx_distance, 0);
> -
> -             /* Setup TLB control */
> -             tmp =3D RREG32_SOC15(MMHUB, j,
> regMC_VM_MX_L1_TLB_CNTL);
> -             tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> ENABLE_L1_TLB,
> -                                 0);
> -             tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
> -                                 ENABLE_ADVANCED_DRIVER_MODEL, 0);
> -             WREG32_SOC15(MMHUB, j, regMC_VM_MX_L1_TLB_CNTL, tmp);
> -
>               if (!amdgpu_sriov_vf(adev)) {
>                       /* Setup L2 cache */
>                       tmp =3D RREG32_SOC15(MMHUB, j, regVM_L2_CNTL); @@ -
> 485,6 +518,8 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device
> *adev)
>                       WREG32_SOC15(MMHUB, j, regVM_L2_CNTL3, 0);
>               }
>       }
> +
> +     mmhub_v1_8_disable_l1_tlb(adev);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index cc621064610f..17f1ccd8bd53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -858,6 +858,25 @@ static bool psp_v13_0_is_reload_needed(struct
> psp_context *psp)
>       return false;
>  }
>
> +static int psp_v13_0_reg_program_no_ring(struct psp_context *psp, uint32=
_t val,
> +                                      enum psp_reg_prog_id id)
> +{
> +     struct amdgpu_device *adev =3D psp->adev;
> +     int ret =3D -EOPNOTSUPP;
> +
> +     /* PSP will broadcast the value to all instances */
> +     if (amdgpu_sriov_vf(adev)) {
> +             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
> GFX_CTRL_CMD_ID_GBR_IH_SET);
> +             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, id);
> +             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, val);
> +
> +             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> +                                0x80000000, 0x80000000, false);
> +     }
> +
> +     return ret;
> +}
> +
>  static const struct psp_funcs psp_v13_0_funcs =3D {
>       .init_microcode =3D psp_v13_0_init_microcode,
>       .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_state=
,
> @@ -884,6 +903,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
>       .get_ras_capability =3D psp_v13_0_get_ras_capability,
>       .is_aux_sos_load_required =3D psp_v13_0_is_aux_sos_load_required,
>       .is_reload_needed =3D psp_v13_0_is_reload_needed,
> +     .reg_program_no_ring =3D psp_v13_0_reg_program_no_ring,
>  };
>
>  void psp_v13_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.34.1

