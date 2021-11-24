Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FD7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 18:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A3D6E161;
	Wed, 24 Nov 2021 18:37:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A086E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 18:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjaGGui1BX1A2keBsSwOflyfY8RqwefhAmzuwOH8YIgphRJMNbsGHWn3z/o42IW+MJTOA1jhOt9ndHIsU8/sQ7iZ8d6I7uLv6Q0JXO+lHm2pjU/zYRidEYNF/Viv258H5mtO7O3HW/Tec89plFgEIvfmnA3cWK0tWe7f3yRRIrO2450BKbGXa5/A1nBZ8njadnAqgXFiEu3Y120E8juSvIAAnvtt1aHOzKTNFxrvn5kPvm+WjAPS2If51NFCSndY0QYw/lHxQg5J/MAsONiYxvlCg857cevVMTjcWRc+YgRNT16lmlIK6a1nxWeEaUA6N/w0Y17XmTlUXvPhsCM/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv5uEWcdJ3aN6u54vMfD8nbcTTwLgvPrmMlyP953uT4=;
 b=fQdLl1cH9RMHRqvLM3HrqKJZdt0MM03VuSqfA7DxX9z9Nd80CVpzwqqi9KcKXJGDifgHNlnzGucsq+AHdPHx3rQbfA4A07E84jnAyTDxCP29I9iXcCvx6CBsUYyM7NNOzPlCQhzf5GZcx549ysKjzkReDKE4V0MbtlioWDkJhafn5ujtT7dTIYDLpjoUz4RKk2vvqCwcYE3j6/cOV/XIzzv3St9NImNam/0aSLGF9M0gABUDp7uhfbPwSRsnaAoHf3ERivZzD63DCtTULB3vLi2K+AMaSLD3sn8+5naDjXjvb48snMoj+mUQnHwh0970g8eWPEKcvFRdbJ0sSgg02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5uEWcdJ3aN6u54vMfD8nbcTTwLgvPrmMlyP953uT4=;
 b=Ld727LUhbz0vEQuIQ5AIMrHarnerqak7mA+/0WleMYUC/OwMfuMehrHXML/2mZ1TMu58mtkbygc+HqLjG9X16ySdNsdve+R15tMYxgXgwpehbBRdS7eLddM0YLliiHOd6TcR/sVDSmanxNEUOOWtIY1/8+9UOHlxpip4qCWErnA=
Received: from DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18)
 by DM6PR12MB2713.namprd12.prod.outlook.com (2603:10b6:5:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 18:37:37 +0000
Received: from DM6PR12MB5007.namprd12.prod.outlook.com
 ([fe80::4d8a:b0b4:3943:b8f]) by DM6PR12MB5007.namprd12.prod.outlook.com
 ([fe80::4d8a:b0b4:3943:b8f%9]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 18:37:37 +0000
From: "Guo, Bing" <Bing.Guo@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix 64 bit divide
Thread-Topic: [PATCH] drm/amd/display: fix 64 bit divide
Thread-Index: AQHX4VFtA+Nlf8hXQ0yAlfDx2mp0VqwTAeHA
Date: Wed, 24 Nov 2021 18:37:37 +0000
Message-ID: <DM6PR12MB500765C224BBCDF9FBCE38FF8C619@DM6PR12MB5007.namprd12.prod.outlook.com>
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
 <20211124163612.2728640-2-alexander.deucher@amd.com>
In-Reply-To: <20211124163612.2728640-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-24T18:37:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=66bbc727-3904-4355-be19-4641f2cc4030;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b4ee35-ebeb-40df-01fa-08d9af797d56
x-ms-traffictypediagnostic: DM6PR12MB2713:
x-microsoft-antispam-prvs: <DM6PR12MB2713997DB7EE29CF43EA777E8C619@DM6PR12MB2713.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:98;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNB/ksToC8ssvyGlSLcgvBBRwXK+PXsVJ7RyKf9u/fA2jfNy/Cv5In6XoOwNCf2gNIzS+cuwSqntc0tgf2qIiasMO3YU9B9t5ESnUD26gfdklmJEznYxmmOEj8iPneXla3Wkq2U07tdEBSWoxWrqN89UW0JJvZIVhrGCQqQMVLjYNV1EMjsGW9nc92R8NeL+NGKK/No06Fjfh6U8NeM/HRvDLW5Us+0MitWHiu5M4syUzj2Hx1+Tzq3r8ds7pT0FfHS8m21Xp10fY3Vw3e0OUVBbaFR9KzkS37VlQWO1IomTWCTEMZZJWL7DCEFjaH/D+mj3/knWUfhxkF4TQHz/nRZnzBEQS+/JB+zsp8O5KrCMdS/f+/FlPeAw+5yIZii+xqezFYvCg7eAzZ+OzJsaDuJhP5kaFw1uOgNRPSUBf+xxwBvImnWaapZZdHEu1BpcXh3sYf93mGQ5x9RwvsZzoNr+OfAKLgEY4zv3CSISUW6rlfLAejRPa9QTyOFp0UDO/l8GDXqPB8viGPNm5Xym9RKMoTweXnzf0d3G+b60HHn8ao5AI6B6qDCPZf6NQx5NiIh2vwmjO44NenkNoaY/9mtvtPzuk1HoLJKAQHjMalsRZE5WRwbD2CI4tGy0hJ97Qxy5DU5V6BWoSVMVf7nF9zyzjZR/E8+l/MQ/SPj5tCZjQdJLCy5KZLNYZzZzZZauqO+fjDs7V1bGJhVxDFByxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(66476007)(64756008)(52536014)(66556008)(66446008)(508600001)(76116006)(86362001)(66946007)(55016003)(5660300002)(54906003)(4326008)(8936002)(110136005)(53546011)(38100700002)(8676002)(83380400001)(6506007)(9686003)(316002)(71200400001)(33656002)(122000001)(186003)(38070700005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2wLxtXzw0MbTuwANujspmNdsHESrDB+oqrOOwDLwQTNVXfanqYteaBV46Vj?=
 =?us-ascii?Q?tS4C0/0mf5RU74R7s9hP//ZWSB6zv1JSCGbckLpZH39k82EYO65OiZ1twxk9?=
 =?us-ascii?Q?w2lrxAMpPaFrhQzRG8Tezc5599SyzfNHGA/kN41ma33bQWJrRMfKRvIkiSFv?=
 =?us-ascii?Q?bUryMDqfXiF+qQTSmcmsodmOQasns3midi7ONy53pRj3Byq79ACFO3do90gH?=
 =?us-ascii?Q?2Jrl1/7alqxgSaVea1OjVh0/FoEvKYM4MgKpSthdwETUqfk+V2WwxaRmCpUR?=
 =?us-ascii?Q?ZpZflnHCKBzd1yVEy2fBcyRtMIJImnpquT5fETpMIu7eRow6rE/nnGL3Omwg?=
 =?us-ascii?Q?lIOL5D39Q25LoD45xUGw/dlr3joRoDCXVq0fbexevf7qD4R5RC2OmkzXuIGw?=
 =?us-ascii?Q?KzeH5QEhQRA2972KxZc1qDvWc6IlJ/j2UeRvqd4QRPSbWZ3sEYu5uuuVZEO+?=
 =?us-ascii?Q?gxs3IBLxq75K52YVeSyAf3K5BocGE1Xi2D2DVAjgEBIhI82ouXersx7jDoew?=
 =?us-ascii?Q?Lo9vQNHVsMBLE2VpybQGMWsYDUkUIrY/Q8BM4zCKa66oTCiW62XByOtHj17Z?=
 =?us-ascii?Q?njyYu24Fdeub0zQJ6OmLMNlmgle7H+2wGyNNeG4JkPMTfakn1Effwv0tAg/M?=
 =?us-ascii?Q?6iOtJ0y91A0lekHtBoTeLpLzzaj/Jjy7i/mRHbhQh/+6JH/L6mJGioBLMScH?=
 =?us-ascii?Q?MdOeNBxciYvhySzPwendw0kDEiiMqbuqSUfdNitL+ZuJc6s+3gcbGeTkZzQj?=
 =?us-ascii?Q?XmyJtI7DnnfOPBnCY+hgNiAL22s6cvF44YLHMqrMaodO7QRLzlqkcrfO+U3i?=
 =?us-ascii?Q?Q1JPI9GCrVhqNB+e0ItWiVoyHI00D8CAACY5RO6y8gyptdqEhxRVlkV8RRXt?=
 =?us-ascii?Q?NITulUIpsScK2L3xw9JZPOhY/uDsZCleZn4pFVORj7+XRNae+wmFJQQ3TPk1?=
 =?us-ascii?Q?Noe66vhBZds5boP6s5wr2X/kIq93yQeIt6x8BKGSdeaaVf8soZfXWuq8PyM5?=
 =?us-ascii?Q?5Bs3KErmkPFta8/EMxgsAaymwsfP07hv0RqDYdberzEsCHMuGUJF/2JKcREi?=
 =?us-ascii?Q?x39pQnNiX7zRc8e6erIf09YPZ+wRErVyYvr49PSeaUHH0Lcgb9x9FDCikfey?=
 =?us-ascii?Q?5ZEQX129emlw5+oC4uZhSo9wqR0WnX2twgE21qi8R+wAnoGp/FYZfHr+5wXx?=
 =?us-ascii?Q?N6gT3Sms0OPashoeNDSPeirEiWs/AS00i/5ImxMRD32j/yFAVt+VZtQfhC1L?=
 =?us-ascii?Q?tuChl4awU/ybRxtNFldvowKymLQsszsXuSmTK2I2t+/PVuOZ0Huhvp9hfnrg?=
 =?us-ascii?Q?rzuIXp/26LCoAQuHoc+ZhCDdu+vPB+5BKmIj8kyA2i0Obx2oKq1H7YMV97y+?=
 =?us-ascii?Q?e6N4G8bJnxyWWzt4vqO6vSEb7xXmZ8MjtT82XCN5IBRK7HqWCeoCNo4DV7sH?=
 =?us-ascii?Q?snRK2HKf80k4ISQ2Yfil67DDwUujSm+5MA7QtmjjZEiQsiIXJBymnEHT7A5V?=
 =?us-ascii?Q?IlJ4TGaCbG2R6jykPUwOv06/WIZOpF23PqLplxhJa3VDPfaUSeS7ElkWzkjB?=
 =?us-ascii?Q?c9CcENhYT9ZmijZxOzWmHUMdediVHGrUtu50RBbm3Jl4cOg9pThS1L94J1rB?=
 =?us-ascii?Q?A+yIT8SDHOnhzgVL9jJEWbA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b4ee35-ebeb-40df-01fa-08d9af797d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 18:37:37.7232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2ZA8afDiMsSUqQKdvA2Ym1DabJa6TjbSu2WQToCk4e5oScDIegyRgYaJ/bxrevE39iHEsI4sBMTmIxy4Jw28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2713
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
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Bing Guo < <Bing.Guo@amd.com >

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>=20
Sent: Wednesday, November 24, 2021 11:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@=
intel.com>; Randy Dunlap <rdunlap@infradead.org>; Guo, Bing <Bing.Guo@amd.c=
om>
Subject: [PATCH] drm/amd/display: fix 64 bit divide

Use do_div.

Fixes: c34f1652a18c4b ("drm/amd/display: fixed an error related to 4:2:0/4:=
2:2 DSC")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bing Guo <Bing.Guo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu=
/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 381561ee0026..7e306aa3e2b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -100,6 +100,7 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_co=
nfig *pps, struct dsc_par
 	int              ret;
 	struct rc_params rc;
 	struct drm_dsc_config   dsc_cfg;
+	unsigned long long tmp;
=20
 	calc_rc_params(&rc, pps);
 	dsc_params->pps =3D *pps;
@@ -111,9 +112,9 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_co=
nfig *pps, struct dsc_par
 	dsc_cfg.mux_word_size =3D dsc_params->pps.bits_per_component <=3D 10 ? 48=
 : 64;
=20
 	ret =3D drm_dsc_compute_rc_parameters(&dsc_cfg);
-	dsc_params->bytes_per_pixel =3D
-			(uint32_t)(((unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 +=
 (dsc_cfg.slice_width - 1))
-							/ (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
+	tmp =3D (unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_=
cfg.slice_width - 1);
+	do_div(tmp, (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
+	dsc_params->bytes_per_pixel =3D (uint32_t)tmp;
=20
 	copy_pps_fields(&dsc_params->pps, &dsc_cfg);
 	dsc_params->rc_buffer_model_size =3D dsc_cfg.rc_bits;
--=20
2.31.1
