Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52908E73151
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0A810E20F;
	Mon,  2 Feb 2026 10:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohWnGsH2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0B610E20F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 10:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqRW+iswge55EA5ddGXoIA0J8PFsXd5RK4m5XQBnysTgy1AQugadmsTl9IXMKNZg+N3X4YSv/hhSdJKPBcY+/FCI5fklBoS1AtIqvhtR5iYouAAal18OQhBGaxD+sDYJBQ8Rvr3J/eVks3Nn4h4EOteAvirjIgin6iDSHXA2Cm9bYo9iN7y50farD/j+b4i0Mk+jcWp3Rj331fA/qRn/F98TJ7KHwmbskeQr2dyWO8reyfneiijB0i4/U/IEtspzXzIwMPDoacTeJbZgsKfGqwBRxGJd/dZHa5HsjU7pD/VqkJDENMdNsKBXgCUZVrhD3KCw68Plp14YnP1sETmtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY+woAQqbr3pOcXuFD1MPvCS1qub5Bwpg5Oq/QVyIy0=;
 b=k3iA2ZUeL4ZU+hNtbSJpQNBGvxq6CqoukHm/w2xyPG7gZp9BfK9UnCrTKiwr1/stSkzzyS3uM1HvmmoUMbe9oJuJ4SFS2q+BMriaeb36QZsjODbk3o5J/2Ude81pKF4qvd+umQCONO6IuAS9X/dCV5tPCA+hfOcEZ9LkKKSmy3/+vuPe0Nk57mphlkMXXxl4G3rKdmHmClhpFGgkgtTkYL9AueWTVf7p98OvG/h7yKM5LG4NLYeJolcqOOQ/vGnogf6BQxWPrNchLmD44HknWb5hbESDn7MVV9nT7zEWr1DpQL+t5XKr5H3P3jBAFMcS6cRvBrcgmDH40GdKKqIARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY+woAQqbr3pOcXuFD1MPvCS1qub5Bwpg5Oq/QVyIy0=;
 b=ohWnGsH2zM0CRNvKAflrAe7MOLXEFGwDNCci9aXfnYQFJLSp+4LsCTdf1SObIHrCseBn99brXlcbgU2rrYb4QLKE3efeP9eApH7yQyEMzpDn2DyC6YCw+idF59lp0echFT876Vc1W9go0p50Ywn6rul3o2pttImMNelGS3vIAF8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 10:18:40 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 10:18:40 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Remove buffer allocation in SMUv13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Remove buffer allocation in SMUv13.0.6
Thread-Index: AQHckdSg30/Lg6T1G0CoJPpgM3fxG7VvNuTg
Date: Mon, 2 Feb 2026 10:18:39 +0000
Message-ID: <DS7PR12MB607170F3344A3ACD8121F8888E9AA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260130103825.3099276-1-lijo.lazar@amd.com>
In-Reply-To: <20260130103825.3099276-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-02T10:18:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN6PR12MB8544:EE_
x-ms-office365-filtering-correlation-id: d711084d-c283-4049-cb05-08de62446f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aDjTllIcv6XxC6X6Mga55+KFTZAaIG1A6zP6RrbTLqAdTsbIgPYSqJ7wbiSd?=
 =?us-ascii?Q?h0V/Lonst0Q/cUy6PyDVqWE8MvN09PVoaS6BeWXy4lCCatGkSlgmF75jfdVG?=
 =?us-ascii?Q?Mp/J3uQ2xuE0+akqFDkYmmhJkvNfCRhqmGP4oOrcKitapXRs6wdvu0Up5M33?=
 =?us-ascii?Q?zQQV/EiY/Fy3eH4P1lzHElVBqnUcrd1tibg3CmfO3vXHmL6K2lH53iUN8xZg?=
 =?us-ascii?Q?q5fVmtaPmWjjkVVJL1SDKF3G2pKBy3r6hrbWQHkf2ApLs//6hg6p1AhZjBMa?=
 =?us-ascii?Q?1iq7y35MlJB2ayPE3EWnkK5N3oWDAgXzyWmnkkCUIP0y8Z2+Ah5Uql6t+J+T?=
 =?us-ascii?Q?eLRG7b9Cyq5x6ExlLr45acM+CQGgqfuQaz6607Eq3pxxh5T2jfFHTPU+h3P1?=
 =?us-ascii?Q?q/PuZA14m6rkvOImWjUYCdYdN/unGrZgS98nvTwsCd/QgvPi//Gms2k0oW5k?=
 =?us-ascii?Q?+SrtnGuhM3+/CHXW9Gr4AnHxVu2n+cupe6bqkeztEknsgjgaL6IxeIfZpGhL?=
 =?us-ascii?Q?UBPTYIPGqb4izvzvm6UNBC2EduBMp9ga1i+S6TOQ9rjHSCJHEKbJkqZy9qE0?=
 =?us-ascii?Q?7gt0IXj8rRqYV/khGOddg1Ov2LnzhTOim1jpZu0Fp8D+6XD65jfol9HDq9+l?=
 =?us-ascii?Q?Y2K8EvAnYwYBgdQtx3+8SL4Kk6vqqUZqWIJbDYSDDDmupBQzFNIMgju7DIla?=
 =?us-ascii?Q?g5pC7SG/C/O6/ibjbaFKh2iU+bKXnWnthi9Aw2qTjL0Cq/hBeuGGCjhtToVO?=
 =?us-ascii?Q?7NtoQYF6H+CtzAn61CIOJ/6vdC6FCUYVegBDejlpcs7mu+wJfEr8xw0kLVn2?=
 =?us-ascii?Q?rPYH1vsgH8B86X7l0nd8CaL+Kw51oDRUSBEFXlKUyCykWH1B3ho8Rys7g2ga?=
 =?us-ascii?Q?w83P6SgLCaUy1ogzBXtSF/Im20FtTx4/rL2wzSfughAEZnvNDl4zdVAbTSOa?=
 =?us-ascii?Q?T0+gZZyLMJ6Un7SOwAs46xbDXBtftIbeHH2Xi/+ghgHBH+fH1pYnR2fpWhKm?=
 =?us-ascii?Q?xrcpB9jf6dJcTbFWS6Z4ZZqjpTlRpMqwEKcepNQ4DaPp6Vbk6Po5BaYbzCVa?=
 =?us-ascii?Q?24rI+heikcC/HvuufG/DR5DLmkaAbqfWd9ycHdoUladUarpfSvpdXCX6Dr3Q?=
 =?us-ascii?Q?xEti/Lp4AvG+xVtG+0IZyx/yCxSIgXVoxxS5W00Mk3PkLwTla5qGkULRZxCy?=
 =?us-ascii?Q?qqB50w6eMr6Ft7PI8zBthyBvwJmcLMa9EsyyfWlmb/3KuWamQ5WUtRRzdRuN?=
 =?us-ascii?Q?1ih+AgGAvOqIMZnlZm41nf9vhlh1u6k8SnV2UILxbTuYzQqmqou/nJYc/ZFz?=
 =?us-ascii?Q?qUu59XQJ9Q9bVrLdzHfIdbprQ0Yobh4zMre01th2ro7UpiYfDmoz/GyiMZsV?=
 =?us-ascii?Q?yF6LmBqNc7VtGXClSDSNxOy7dsG8cmFjydudStwXUKwdmdat+2n9KFOMcJYS?=
 =?us-ascii?Q?FvLgacIc0oxTAiXQ+Nx4ldiJRhep01mhnr8B4z4Z9EIjyvUJp5ymvURSF50v?=
 =?us-ascii?Q?xYw2G/lGBnxx1ycY3vOS47qVeUhLQ2c+/hdcBykJ6sGt62yYJ31YIiTRWl/F?=
 =?us-ascii?Q?hs0qtnRSLOTs22Frk7tRkYUDoAClWRPgpUMNXsxEx5i4kpadkq9TgEC1AMpl?=
 =?us-ascii?Q?2e8Gh/4VPi4duwd/9LWNuXU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5sUYuBPjOrO81My6hMgJ3qKDK9ngRToo4RzzrkzOwmHAwpms82npxjAgOIT?=
 =?us-ascii?Q?kfw0uO6azcO9Dlq55wkZl5ljMIaG8J6w+5qGzV48wB1Vm+eujvyP0boqrTxD?=
 =?us-ascii?Q?qrcru/U7nAh2ZLQI7HIqHf3wgU5MUFTUNreTVn4MRxmBdSwwPoY9lVcIuOpZ?=
 =?us-ascii?Q?dMoSLUTknaZNvCcw/sUnPDwCQ9iNAKBS+d7/tY3T4iklVpspEmpmmv/NT4Om?=
 =?us-ascii?Q?zPJXLXN4R6GTkYkr+l/d2cs2hUnOS4bZlIq32CbQcTZwY1/cK9uMk+Yr+LS4?=
 =?us-ascii?Q?XjGSqNyAafGDbFu9EiddhV8PPy0pZmCzPMiPc91fshm06GRnFe1pE1jB4ZAG?=
 =?us-ascii?Q?q/aaXSIY+IecXATiSG0C9/Ru15Cq9/NXwbuETHRs6yEwriXJWB19DeNtG/o0?=
 =?us-ascii?Q?70tF8oKjwHO7HGOtaG2nfrWok3Ofw3veyOr71LMmYhpRLRrZRBPMyhdlIBuT?=
 =?us-ascii?Q?ynBu3l5qCu20WQaeaLnSZf6+LzVfqxSA+L9zFZ6AjKkPUAZsMevbr7IRI0Ci?=
 =?us-ascii?Q?BDxQtAaIRYSfA1tgJFEPXiwIVS2jPn/SoetW8h1QzJZvve0q9cfjXZFlne4j?=
 =?us-ascii?Q?RgpYUc4ZPusjZlEAEO5BiTHyh29c+XqAfbfTRxUDmjfuJy/JLcatqSw1qyIz?=
 =?us-ascii?Q?koJTrkw4OsRv4Jcll2czDBBIOCfQO1INqxMmsawDuGjekUPjqwZBBXNYbuLV?=
 =?us-ascii?Q?Ow1DnN2k4d6u8ljcAizI0eZcbpVslFctVNLDhz5sgclPzsZnufk7ulJ36MZu?=
 =?us-ascii?Q?3YEOYfPwC/PEYpqifQlhO5srT1shklUjUm1z636YxMaMyv5CDDZIA7x6GI6E?=
 =?us-ascii?Q?FVYm+BIZDZRN1EyUztyk4ErzmffahUEYK/mdc05PNsean0Eh/AXIzCpfDy0e?=
 =?us-ascii?Q?E/KPatY0lXh8mJju4Bm8hpZj+0at6piahKw3hyQ/8HVd1zAFA5eXy7Y3JWKf?=
 =?us-ascii?Q?U6EynBuZBHT6cr+1LO5+EpABPJ1fIBsoaacfNmq4IkQDIzJowhXxQz2p6OvN?=
 =?us-ascii?Q?mUznOLttFD6BMotO/QLvbXfMhsccOdmIOPNw3XoypizBbrEWIv+lkcN4eG27?=
 =?us-ascii?Q?ECnHo7ihjY4olWq8wnZQ/BRhEs1Q5psz4parQZZHqml3ES/j9DNOacG+2V2b?=
 =?us-ascii?Q?SYmuXO6AzVecjYf909jpXc8xlvv1G4zsNdjoLesAGhSO8kUAM/yGHLiqPMQt?=
 =?us-ascii?Q?8CD1cLgWYxbxqazpjwnAkaymxiGR0WoU+eU8VByR8mNaMn1ki6lu/ibczJXu?=
 =?us-ascii?Q?r5sZsTUEYzcl1XXkkIz/UyxGigqd8EeiD8Dfn3/VFEPjayaf0B64eqw/gZmC?=
 =?us-ascii?Q?TI00vHD7PlUUnwviJjsO68194zmOUsqx0Vxr5jAEsHq3bocJZ/vGqzsGDL0A?=
 =?us-ascii?Q?yN0+jHcXY+Oqu0nn468HHbxHcBTH3UHAZYR1hegD6s7GmsuhRIBOUyJkteF2?=
 =?us-ascii?Q?YnLz1laPsaxTjHkSCEpwcWj7pw+yzXqNK+0bQEwYBYQCikuMeLOk8Tav39+X?=
 =?us-ascii?Q?0pTnwGGg++/6f+JL5pcekCuTAdLHRNx5d0DXhB1M//4NuKUHEjIkeRqJ1cmk?=
 =?us-ascii?Q?oRmVAZKf1fSpJ8Ee5GPWO/5gnrN1f7Cmh4KCR62caxKMnEfYWjLQNxu9bvRN?=
 =?us-ascii?Q?1SgwMFpeApc5EE0E+P/QdnAJ/kQEkGs5WAOHVEp+izQHbdyshHCTzO1nTAX9?=
 =?us-ascii?Q?Xfttutcg/AhgJqAREI3JjYafGi2BUfqoRh/88LFTRugL6HDj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d711084d-c283-4049-cb05-08de62446f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 10:18:39.9245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFQrdWUu6xorKIv/jlWbZP5+l2/5NR+V2r6a+s/Zfss9cc4qPYuHm0K8s7TQugFfOJDhweFrJS/uyFfBIJ4W1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, January 30, 2026 4:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove buffer allocation in SMUv13.0.6

No longer required to allocate temporary buffer while fetching metrcis, ins=
tead, use metrics table cache data directly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e82c43c851a..379f3c80cadb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2563,9 +2563,10 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct sm=
u_context *smu, int xcp_id,
        const u8 num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS_4_0_3;
        int version =3D smu_v13_0_6_get_metrics_version(smu);
        struct smu_v13_0_6_partition_metrics *xcp_metrics;
-       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
        struct amdgpu_device *adev =3D smu->adev;
        int ret, inst, i, j, k, idx;
+       MetricsTableV0_t *metrics_v0;
        MetricsTableV1_t *metrics_v1;
        MetricsTableV2_t *metrics_v2;
        struct amdgpu_xcp *xcp;
@@ -2585,22 +2586,20 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct s=
mu_context *smu, int xcp_id,
        xcp_metrics =3D (struct smu_v13_0_6_partition_metrics *)table;
        smu_v13_0_6_partition_metrics_init(xcp_metrics, 1, 1);

-       metrics_v0 =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-       if (!metrics_v0)
-               return -ENOMEM;
-
-       ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
+       ret =3D smu_v13_0_6_get_metrics_table(smu, NULL, false);
        if (ret)
                return ret;

+       metrics_v0 =3D (MetricsTableV0_t *)smu_table->metrics_table;
+
        if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
                    IP_VERSION(13, 0, 12) &&
            smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_xcp_metrics(smu, xcp, table,
                                                    metrics_v0);

-       metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
-       metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;
+       metrics_v1 =3D (MetricsTableV1_t *)smu_table->metrics_table;
+       metrics_v2 =3D (MetricsTableV2_t *)smu_table->metrics_table;

        per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRIC=
S));

@@ -2676,21 +2675,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table  {
        struct smu_v13_0_6_gpu_metrics *gpu_metrics;
        int version =3D smu_v13_0_6_get_metrics_version(smu);
-       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0, xcc_id, inst, i, j;
+       MetricsTableV0_t *metrics_v0;
        MetricsTableV1_t *metrics_v1;
        MetricsTableV2_t *metrics_v2;
        u16 link_width_level;
        u8 num_jpeg_rings;
        bool per_inst;

-       metrics_v0 =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-       ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
+       ret =3D smu_v13_0_6_get_metrics_table(smu, NULL, false);
        if (ret)
                return ret;

-       metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;
+       metrics_v0 =3D (MetricsTableV0_t *)smu_table->metrics_table;
        gpu_metrics =3D (struct smu_v13_0_6_gpu_metrics *)smu_driver_table_=
ptr(
                smu, SMU_DRIVER_TABLE_GPU_METRICS);

@@ -2701,8 +2700,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                goto fill;
        }

-       metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
-       metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;
+       metrics_v1 =3D (MetricsTableV1_t *)smu_table->metrics_table;
+       metrics_v2 =3D (MetricsTableV2_t *)smu_table->metrics_table;

        gpu_metrics->temperature_hotspot =3D
                SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version=
));
--
2.49.0

