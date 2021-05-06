Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D81C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 20:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AC661289
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 20:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AC661289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2906E157;
	Thu,  6 May 2021 20:02:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4634F6E157
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 20:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j83zchotszHhNuMqZUXM347sbhHYz16QthpZP1p4IC4kJyR/w1d/n7lWeAkWEgH0ROieFGIPSEe34zU+xd79DnD9mnvCr6lKeTLJ2RbQkEnxPbJ3rJ4qZwSfgUSDp+oJCgBWONlxPXB/XygA/MEMh8bostWs1Wtvhr8AS5R0g0jUr2wCeOH/ogr0Gg2d8udJzAcPQy7OufVyTULieANYdK6zJ3asosacDzZr2A1cDq8LEsFNrRBolHga57l347uIyz0Jn0BNNHFHqsMosTtHWuixpC5m4uCg2wzrKoR7ltibxSK8RDLscrm3wm6KNT+/CgzGSJHFrzi1B4aHDcx63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksy783AAnwoa4UGzdxvtsu2URH6/rcMWx4a0357uEwY=;
 b=a7HdHdP8LtHCB4+fTr5rA2YvT9qt6tSMd6CJVRGt9aORDT8CJnUrRlM4JBW4/DOLW2bbh/cWBH0jqMYiiSzgwdgvPBbJKHF1VsONZwMtdaR0CumLcpsUaNfsQmBEdfybrh6OIYbuK24BCgnsTakhSnfNAjdTYGrxuZ4VLT0JuFKMPNGTiQvXOEdUxwtWwPXdCJJPahrMTP1Ej5l1oElwaW2Ye4vKWEkchq6yFB0dwO8OlGLHSidmGMT3LE0AxKzX6Qzvwa7QyjBQab6f4cOfSElqspgtBzfegR6f0CUnysfoRswkLgp6OEZ08TMeYuID7RIefYv5EE2ti6/p4bopEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksy783AAnwoa4UGzdxvtsu2URH6/rcMWx4a0357uEwY=;
 b=glcYgDX3T4xcw40QjCmZnv8em6cApa8glBbLiEMl3IzznY1u71qflpp9+Ygjwa4KmApfc0e0UkLyHal/gEeLO72GNW+4gOHaB0wrgmtqxG+MK+sF32igbpgK+Uhc35DyxIYhgbeFmzJHQb9Pwg+SAp+Q2zSai4H9mcSXpDMpoUM=
Received: from BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 20:02:23 +0000
Received: from BYAPR12MB2760.namprd12.prod.outlook.com
 ([fe80::bcd1:907d:8cee:5085]) by BYAPR12MB2760.namprd12.prod.outlook.com
 ([fe80::bcd1:907d:8cee:5085%3]) with mapi id 15.20.4087.045; Thu, 6 May 2021
 20:02:23 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable TCP channel hashing for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Enable TCP channel hashing for Aldebaran
Thread-Index: AQHXQrC1p/1k1huvYESOdxpKhX3w46rW3gFw
Date: Thu, 6 May 2021 20:02:23 +0000
Message-ID: <BYAPR12MB276032A015062200B3A3178C8C589@BYAPR12MB2760.namprd12.prod.outlook.com>
References: <20210506194724.9964-1-mukul.joshi@amd.com>
In-Reply-To: <20210506194724.9964-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-06T20:02:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=23b83015-8202-49b4-afa6-d410b9e5620c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:4cac:828d:28d:e9c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f21618c-b518-452e-c76e-08d910c9dd5f
x-ms-traffictypediagnostic: BY5PR12MB4917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49171729CD6E919470747E6E8C589@BY5PR12MB4917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fimaHRpJf+bp7UtIXCIzmR56AT6goqigUUzIFQtFruNzViMAQ0VgNi5PEH4cnbxJ7+L/Kn0zFbo/DtOp7iohZ1fB7UGvMXq+a1M8klV2mzb8vfJ7z7UhxMFMmj6mxfSiPlGMcCwWHgZ40WgSLONwSYdqBWmjDCp213VfgGuV9EElyJ33G0cyXzTu27nZCoiKt7NnN5WpbHgYW97VFgtl8lQ1I4T5+EDjAebhuUzWsjWW2DDwypkTZircBo7KPhwSjBOMVmOTYnPs9v9rK54Oy6TrhuIp2xYxs4O0dVN928lgQhk5NAObi1t9eF9DPVAkvPcqyEvsHNmHUOeIr6YovZFoqIvwP+PgZtJU9O8DVwYcEUmCRdoi0DHgSYZ71aoBrLZZ6W9doUzTsm6AME3w/vV+rAR2WJtVFCNthWI06fhLDUDPfPWu7/s6YfGHLb5/dEl6ibvwvCoNlOsgPLb4bATjEPJjApNQ2t4fzwGAo+un8XSKB3sWTv3/TQcIs7d9+QklQ4Flqn5aZ3HofuuF0JhzPIfkxnK6X6OqEW+TRY4i+PW93YIAv3YfN7m6dUe7PZit5m5OuYNmAPu9u9yJXSRaVvqAPLAQOEbkypRF5E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(33656002)(38100700002)(7696005)(8936002)(110136005)(71200400001)(316002)(64756008)(52536014)(122000001)(9686003)(2906002)(478600001)(8676002)(66476007)(66946007)(86362001)(83380400001)(76116006)(66556008)(6506007)(5660300002)(55016002)(66446008)(186003)(4326008)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wmNZUmukAAw9M9xhck4AZWIj+uJl2SzaQSc6cnTbHWMgBTrLhD8R87IGZDBa?=
 =?us-ascii?Q?PXgwz2M1En7/mmIqJI8F8V45n8uoL9Iri2YKZcuWV2Tmxfl85U+3U1l5nbT/?=
 =?us-ascii?Q?xpNwP3rSzJ6FDyGQ0y1+2/22U9qzybPto+5jqyzSthSFYnufgCxoD+vPfnX8?=
 =?us-ascii?Q?wQ/svq/8QQzd92wuWkfFQn1AxWDYAoAi5QTVWJQ91aOFwUPMBqzTXrf4LA+x?=
 =?us-ascii?Q?H2GAkKT+8cRaq2AnHczA/LampE68E0exNhWB7lvBP+5wAeBZDbr1pkv6PNQ1?=
 =?us-ascii?Q?Nq96r+YiFKbUHG3SScy/bkwfB5YBEq/eXtxxn5+Q1ytjzoH0XNyT2MgDpo+L?=
 =?us-ascii?Q?8bygDMCe1k269v9GjOW9nPj7PSNlmOTU3fPQ7/TYKKPNHnnF4dRUI38U65BO?=
 =?us-ascii?Q?PsGA54MZRpPlWNXJzYEN35WbWqJ9jIN0LPPmLwSBEyxZcgqjFniQUkLQi8fy?=
 =?us-ascii?Q?qZG7ZsDzBML/8KTdQu9ueyHgbUuQF3ZNKqsu13587CAsyuUyzAwfmxv9wPcD?=
 =?us-ascii?Q?G+SsYJmrSOvhnbQRRpqKtswmxNu2WTmudfgkzYZ4Flk9bXaoxQbiTHqnTbCh?=
 =?us-ascii?Q?EpW0jSrEc+7vQ9WjWDfEzCO0C2rche+fQJPKsOUORJ/ahHMiIOp89YDaPU+e?=
 =?us-ascii?Q?a+8hBvc3bk7u1jl4gZZVKzpwvSvPIv/AJk0g1M+d+re0tM0YxoW34BBlHNOV?=
 =?us-ascii?Q?HNNsm68UxpDGsPJQBaf/wy2iL+1yeOR5LoXxaYq4coDbkYK5GfWRvcwOUlZ9?=
 =?us-ascii?Q?MZgl/3FlrzTvbtdg7jdvs7tSdFSPUHLfvaR7yKkPKFCQCaDXDlWmM4v4q6nw?=
 =?us-ascii?Q?DxPdJ7d05R+2OSMOFPGTRGkDLX7dUJTIfqjChfVo74pI7vITFXIe+N9Q/j7t?=
 =?us-ascii?Q?9x7rZvUuLaL814Pqj6pMjtjjdlCoyPR0sQMx3SwqLswy+5YU3mMnptFafWQ9?=
 =?us-ascii?Q?I6RqBqQv10Mg69FeoU4UiQy3d7Sm8G4Q4XMGPTjp+SlDRlHMUEC6mD5bgMKj?=
 =?us-ascii?Q?7lHNHRebp6QtzIBW8ybjj6zcqsc0I/uD1SvkYNUYcRlxdvQuNllyOikRYBLv?=
 =?us-ascii?Q?r+J7bksi1XVloHJ0KrmQZUljk9FZWFtg80K3JnSMcEsL6UcInrXPf8o76Gf6?=
 =?us-ascii?Q?v2LNLD+ixlTx/VCavftZyh7YhQzG7jww6CiNdd5+EAj1U22GSN7j81dzKFY3?=
 =?us-ascii?Q?ChStc/8L51OIOe7AAKvf4vAvvU8tgnaWaKlQcTheOaBpEiWseZkz/qDI573U?=
 =?us-ascii?Q?X4UtU/Pf8zl8BWgiESUEYRYzBf1s9C01rTPf5Tj7v7y7ta92kl7UgC2R5JIS?=
 =?us-ascii?Q?0R/1GQH6RXsi/NRsA3K0h2ZYAixJJgDQLHSexh+3Q1ofPkRAJoIHsIIHTAWO?=
 =?us-ascii?Q?JKqxqvUtQyEwenPysh3EgbrH+XRC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f21618c-b518-452e-c76e-08d910c9dd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 20:02:23.6299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ufx8T9WRsu4VGcNgobEasjlDRVzACUdvFH8c7pwpWcarYYiSqMpMd5gkpmS2TSELX962UYZGXbtW/QnQZk95bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com> 
Sent: Thursday, May 6, 2021 3:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>
Subject: [PATCH] drm/amdgpu: Enable TCP channel hashing for Aldebaran

Enable TCP channel hashing to match DF hash settings for Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |  3 ++-
 .../amd/include/asic_reg/df/df_3_6_sh_mask.h    |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 0d8459d63bac..36ba229576d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -219,11 +219,11 @@ static void df_v3_6_query_hashes(struct amdgpu_device *adev)
 	adev->df.hash_status.hash_2m = false;
 	adev->df.hash_status.hash_1g = false;
 
-	if (adev->asic_type != CHIP_ARCTURUS)
-		return;
-
-	/* encoding for hash-enabled on Arcturus */
-	if (adev->df.funcs->get_fb_channel_number(adev) == 0xe) {
+	/* encoding for hash-enabled on Arcturus and Aldebaran */
+	if ((adev->asic_type == CHIP_ARCTURUS &&
+	     adev->df.funcs->get_fb_channel_number(adev) == 0xe) ||
+	     (adev->asic_type == CHIP_ALDEBARAN &&
+	      adev->df.funcs->get_fb_channel_number(adev) == 0x1e)) {
 		tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DfGlobalCtrl);
 		adev->df.hash_status.hash_64k = REG_GET_FIELD(tmp,
 						DF_CS_UMC_AON0_DfGlobalCtrl,
@@ -278,7 +278,12 @@ static u32 df_v3_6_get_fb_channel_number(struct amdgpu_device *adev)
 	u32 tmp;
 
 	tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DramBaseAddress0);
-	tmp &= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		tmp &=
+		ALDEBARAN_DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+	else
+		tmp &= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+
 	tmp >>= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT;
 
 	return tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..22608c45f07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3937,7 +3937,8 @@ static void gfx_v9_0_init_tcp_config(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	if (adev->asic_type != CHIP_ARCTURUS)
+	if (adev->asic_type != CHIP_ARCTURUS &&
+	    adev->asic_type != CHIP_ALDEBARAN)
 		return;
 
 	tmp = RREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index 7afa87c7ff54..f804e13b002e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -50,6 +50,7 @@
 #define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal_MASK						0x00000001L
 #define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn_MASK						0x00000002L
 #define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK						0x0000003CL
+#define ALDEBARAN_DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK					0x0000007CL
 #define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK						0x00000E00L
 #define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr_MASK						0xFFFFF000L
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
