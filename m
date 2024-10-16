Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F76D20693
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 02:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE0810E0D5;
	Wed, 16 Oct 2024 02:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MIb+bO/o";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA82F10E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 02:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noGoEpxUGHQUNBepbvz74RxipqYFn3hqwb1h/a+fbSXjE16o9wdImDbX4OyQpOgk/9sj2SVEC/qwi/cLskPuzzybz5FBIZxUM7LCUP2KFBnTl635BX//qmOZwKLjqQnDmxSq7vSt6XVMsdKgzjFmUDYhheI4Xt6XTrMP5O++ltyZHTl/oD1ximFZIyxAXw5Zqr1sIPtv9RZE7Lww3PyfM7ZHDBk6rFewRi5TCoa2ywXdadjJxOWNzZUXpIDBSONf0z9vUViwK5k4chlPSI84Y66N1pUyFLabmkjmfXL+YPCGZJyswuBIwzJLZ+0o52Seqd1t3FmZ8NVOYuaBW2ASWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNz0PjM0j+KaK/VTZp7e4qfxZsm1FCCOPd6Kx/nJZlA=;
 b=B1WD5FaDCUSeRz6WsmM7ZFsoalWfx93b8aT8iq6Zp8aEhU84J8dbKhzKy5caxO5J4jh7Fsimhm6wdTW+VpmpHJ/jgDx2E0SPdkEPr5HrGju29ojGRj38OE+ECCCgm8YFVvgB6eSNpPuGIRXPWSpykvGUOYoO1OED8Y7GXx+XNVsKinbkBBzDfqbKJWPsB77X9B+rFF5YKD8Fl/Uf69EwGaX7/fNG9smwxhy5DE+FKem2dh6R+jzzU39qq7GOnVyUBx3pph/zikwPBB9ycME0jLGs1OWxZlbzmqSQmIjKXqDifALwTqBvryfOK41Tv9OW9llEGIwza1siD+I/l4lbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNz0PjM0j+KaK/VTZp7e4qfxZsm1FCCOPd6Kx/nJZlA=;
 b=MIb+bO/owRC8b7aaE5pjzz9XuHmF496GTNpynhlmhe/w/iUY+Y2SlNOLppjnbQSW3Vc6rDsrCsQh2RrFgX21No69EO6mk1eyXTTrO3IDc7/BBWlcDMYRLcm5EguvM9MlF4GbGVr5XUviNLLxtPxYQwf7xqbZVSnYOucmA2+Xe1k=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:59:05 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:59:05 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
Subject: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
Thread-Topic: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
Thread-Index: AQHbH3RwL4WAWHxFU02nDZ9qQQOJdLKIrmrg
Date: Wed, 16 Oct 2024 02:59:05 +0000
Message-ID: <SN7PR12MB69328B4538D6D15775646499E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20241016023558.22970-1-Frank.Min@amd.com>
In-Reply-To: <20241016023558.22970-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e80087ab-b5e4-4842-9d51-e0e58901a45e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T02:54:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: 5be2634d-396a-491a-148c-08dced8e7f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XDoB+AaK+06AjMjHb5VYn7AvsHudGIJsf9EGQmg+04b5JpCiPC5zJCNRiON/?=
 =?us-ascii?Q?2DmzRCOC6tF8+5J20Lgg7BbzMl+S+AVp/MY/jkebZN90mdZ3cMu+bQDfC4Os?=
 =?us-ascii?Q?jhSVCdxcdjcX0a5twDxq0b1duaWfWvE4rTTlEnxS9Yl6ab7p56DCrlqW4H5f?=
 =?us-ascii?Q?AZ0P7RSKj1KFAHMJ0sRnxk7HGwXuHosis2QLe1lOqq2ICkRkVi1z3f0G7xNw?=
 =?us-ascii?Q?RWgdtcX1YTVAOkHA4Ui+vrxfswBMp4wkVHnDcwYW3wb9K6z35SLS+vtZBCyP?=
 =?us-ascii?Q?D75vkGuug1MoObH1tNUpnO8BqU9+tFmkOce2QSfGFJjAiT3AikLyOx/R9HdS?=
 =?us-ascii?Q?zqcXYaUzLBZpxt63Usg/9mAWhjIUTN3V+dhUDVACNpxlBI9HiIjAcaNROZDQ?=
 =?us-ascii?Q?gKnyX0AjlISvwUUljJCq5+DWhqp6vxG9cq8pi07s6QuQXVjtslCDqeHwoRa3?=
 =?us-ascii?Q?7Y/mlnIwfE6kA9U7Qk2K5fPBVVAAQvYU8dkmToCMyALOVipEmMH1uBeCFJUC?=
 =?us-ascii?Q?zt+efrs54cvO1JkrPdw4/Nb7GxUVGGMissDJZ0UVq6HzRsNIhzsIrC4JIpEL?=
 =?us-ascii?Q?uW/nJeKzlUiD5OFskc8loA5v0edyyfyU3wD0jDAouZAH1NoEjCc9rCB459HD?=
 =?us-ascii?Q?OG2lXdxPKXReCXBBCNRjPE6Kd+ePc/mR6WNHlqNHFsnVLGtBBa5uxRWO5c9k?=
 =?us-ascii?Q?py+Zd9u/J5dheazMUqDndp0EybAenYbOFwJcCrl/eM7pe+sd9FLxTuoJjoUX?=
 =?us-ascii?Q?VAAZ0XJGXD8cWHl84g23sdxWOjYMUqbLbkyVyu52iH2TdPbbU9Z/xJbipRyx?=
 =?us-ascii?Q?CZNrrT1bKHMU4AHGq4Dacmo/Luym86K6UTooIYW4hOsve0MI77AKe8D5vM3C?=
 =?us-ascii?Q?Rl7BSWs6uPHgI/T5X9e0bbkyC2At9wiZtCn25ulVnlvlAuJjirVb7V83Z8Pg?=
 =?us-ascii?Q?EoZRmpmw7CN7MjtrpUhnAXUAsTd2TXX647tvoV/53KXKYCIEgLHdMSGeXZ0W?=
 =?us-ascii?Q?DH4d5AiNxARrbMvHERkr+6ARcSaumQPekwaknobYCbugHd3cVi+gFyF1nqiz?=
 =?us-ascii?Q?ysgSTeiuDV9VM8g/B+dFTol3FiYa1loYKA7Htktj4rzkTS1uT9vOxM3vNJvY?=
 =?us-ascii?Q?MBI//QwlDj9D46ic3IGZFX38ClbGbJXqqb+f3VLMvNKiHJQVj2TG4XJnuW3O?=
 =?us-ascii?Q?baU00bW5jeuNHcIq+yhJSAfxu0+SKZejSAhuyBGQtqxtw0P4nVAjZOlYaJYp?=
 =?us-ascii?Q?4pr8qliIKFdWjtKznJsTDbPB3IV5oCl9cDhbZMvfo46EjNafTxcgE24VAPMx?=
 =?us-ascii?Q?o+lMgikqvjK0oLN4jlMUPDucBuFVKVwxDQlEaK2h+Q5sD0V4yzGOaUD6mJLt?=
 =?us-ascii?Q?q2Fj1AY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OVVgfBkpP9rbhE500V90WwVcLv7t+CEvAstN3vgH9+lKRw2NJ2SkiQNUgB05?=
 =?us-ascii?Q?5WkHaEzDyOLV2RGNh4xBn1k/jFfJa/KBCBFXaq/TMGz/DCAvoKWx4sNb7s1x?=
 =?us-ascii?Q?6lXXHDrxhze1txxoCMVEr9k+Ui6f/V/60VuNT877DnxiBKRfUlwYQy/FTzhb?=
 =?us-ascii?Q?tjf+X3er5xgwy2Zt2N1HZiJPqj6yu3Yg9GTSgZL/GZguQc3mN7XimSedLT9K?=
 =?us-ascii?Q?KNVk5nwZ+WcgYY+k5fM1IaxmY58KnkcTjuQP+ZQcj1IuXKDG9JS/Pa2RSLjI?=
 =?us-ascii?Q?1zk+7ydY/2by6eMAXigXNNOnnJOYdkjVqm57qGnG4SroGBTXRhPWERjVu5wj?=
 =?us-ascii?Q?sLdy5M4TJzrcsjfg2VfI/YgIGSK2kAmv2Y37sMgYHi/J9Y6TMJryFzJxGu9j?=
 =?us-ascii?Q?XpFWfrloA6TvT0vVYKmFqtBjo9HSvpWBqg0UAhknvQkfhOzTFZOf0L/SjkNN?=
 =?us-ascii?Q?Lva2ZAEtswFkL3p0fFmGDjir4OGEIkSiO0ff6WXEV6VQXvFoKoSnOmgg0gaW?=
 =?us-ascii?Q?zUcTIg5v4l1mn6I9Gy1uzE2BrtWkqj2hw31HmSLH5pCjwpjSuMYNiQWH4PiF?=
 =?us-ascii?Q?ldaKupr29WN6Zl3muCtq2kun4Hyyov16DPM6yoBOU2bFR7huVX0yi15GuorL?=
 =?us-ascii?Q?KdpH182l23j9mTdY6I5Q/GrhSHenSMiAGTHg86+QPI3FyNoBcLMPYzBXKcuY?=
 =?us-ascii?Q?RNh+22fFLUqe3WLk8J6XickLMNzk3s73fBqXF5ydRZUUKQv6fHpuqkp6QVJb?=
 =?us-ascii?Q?PRN6KrNY3n7cDvOjxLUCCwGKagNPINkcinEn0Zcozr04XIFGlh+3MTRSperi?=
 =?us-ascii?Q?KruY+byZBYAA9ByR5QfGfeLjp9zXihUIwc7BZcqMhn0Rtw1dxLPCaIx+PW0/?=
 =?us-ascii?Q?ydLOGdh44zmOtqQce92/V5SoDxrOLrKbeSQedFXHj8Q+AUSnI+UFtgpRkgE9?=
 =?us-ascii?Q?i0nyDgGMbhJSQfr7QOr5lYrwF+nfjizMTBJNR/abgSvxFez0ERYrvXZgmdBe?=
 =?us-ascii?Q?n5G16UdSzrqfx/jIqwLCsUe8RNWtw6s4AUbcMi6ynUX1cPcqdalxlHHJ1Ims?=
 =?us-ascii?Q?Muio6hGFrnmCJbsrr5pSieVWNzeuwvjdZUWB6xQcoBf5MwjApmZhhyI82n36?=
 =?us-ascii?Q?aCw9VDOFk6G95+y1K/P9bNuRJrP7u91U0EVHdebIA7xvkq095HmDdhtm2jdH?=
 =?us-ascii?Q?GdmWXtzosTD3iWA9Z/5zlnrQhzqNiCzYIVX8+WnwDQhRECXhfaI0GklRQDVK?=
 =?us-ascii?Q?/5kh9vHj683i5sLcY+H1UxhBg/FF8eELpe36NY5lBrJ09/EZWFtP4eePAXHG?=
 =?us-ascii?Q?rsX8ZCqH2h47bKfke2mKrJ0+y7HvMZS20TVOQ1k3M/7+OwmPgIKiqMzLMQFh?=
 =?us-ascii?Q?rEJFvmmpBzee4GtA+jAYPY7zWZL06bkQgvV353QTVJ5+zVD8hkpzHlHWDF41?=
 =?us-ascii?Q?qpSUVOIhCKByItPow+7SHXR8jf6fDKzGMF1NVyv+4iW8H7cJolbLU1QZLIw5?=
 =?us-ascii?Q?+eOsXlGuDaqbjNur7CDWsM6pRqR7ohFIizXzC65UKh9Km4sQHVTghoXCZpYF?=
 =?us-ascii?Q?360Qx8o98s//DI5punU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2634d-396a-491a-148c-08dced8e7f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:59:05.4080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7i41sSmQDyWllqKeIcmHOBhQR7Bq8xUBbJ5oOKq2hMvz9y69uO7DCAW0f/tXCLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

From: Frank Min <Frank.Min@amd.com>

There is random data corruption caused by const fill, this is caused by wri=
te compression mode not correclt configured.

So correct compression mode for const fill.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h b/drivers/gp=
u/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
index d8cf830916b9..18e73057e6ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
@@ -116,11 +116,14 @@
 #define SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift  8  #define SDMA_PKT_COPY=
_LINEAR_HEADER_SUB_OP(x) (((x) & SDMA_PKT_COPY_LINEAR_HEADER_sub_op_mask) <=
< SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift)

-/*define for encrypt field*/
+/*define for encrypt/compress field*/
 #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_offset 0
 #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask   0x00000001
 #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift  16
+/*sdma6 use bit 16 for data encryption*/
 #define SDMA_PKT_COPY_LINEAR_HEADER_ENCRYPT(x) (((x) & SDMA_PKT_COPY_LINEA=
R_HEADER_encrypt_mask) << SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)
+/*sdma7 use bit 16 for dcc compression*/ #define
+SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(x) (((x) &
+SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask) <<
+SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)

 /*define for tmz field*/
 #define SDMA_PKT_COPY_LINEAR_HEADER_tmz_offset 0 diff --git a/drivers/gpu/=
drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index a8763496aed3..9181579ae6a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1724,7 +1724,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_=
ib *ib,
                                       uint64_t dst_offset,
                                       uint32_t byte_count)
 {
-       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_CONST_FILL);
+       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_CONST_FILL) |
+               SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(1);
        ib->ptr[ib->length_dw++] =3D lower_32_bits(dst_offset);
        ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
        ib->ptr[ib->length_dw++] =3D src_data;
--
2.43.0

