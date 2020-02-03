Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C8C3524A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 03:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE69720721
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 03:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qb7ve4RL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE69720721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5226E167;
	Mon,  3 Feb 2020 03:18:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42736E167
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 03:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9VWVEm6ol1iUnbZaYYR4z8ixgkm0FYZC3I1kiOVv2FE4nA12ipovU1wnfBI+K7f2Jykw3SgYz1pw19muruAzNvhBXS9PA/Sr9zKrCizbMUYLAc+22d7RfIUGfMsGyiu9SV3FYctACl4fI8NmM+qNO4V/RmCyocu69AtWhX1c81CnKovVUU46E4bt1dh58id4NGpU3/Pt+V1vnjLUd9Iy85AOdJkV5JEUNrK4BkNEMy+Z4jqDg+ojREGro4m/oV2Z8Lh9Rep5nESOwq9IVloCdE5z5BKOHALp+BlxgtF6iY9QW8UyM1GN2kajIiWuQbqx1nOCRxNvSqJzxbkq1YiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVGd+pLcD42GoOf01j1zPz/gCgel9gDwmvnNVZ4lVsc=;
 b=N10GQy0Dbr1otKAL5Zeg5wGoKIGvE4PVYfZGFdT4j/a0KWA1ikii7iwFg8T3W3QPf0g4hbU0hcDFOZtl2f9Qail6mbFhZux4yhGgEgl0chPDytyGAHxTjF7jz7WOj83KQ0VzN0tic56eUFa6oeYBfB8U4qlEOE+Zi1370eshN5aWcmjd6zgt9Z/TOmjwwzV962f175ki6A73wUcdb8I7BPHWKjBInM7JA1AfY6PJTl0580Q4YG8llJo46ApHW5WOtrM8PfGJc9BZheI/bgF1VVlErk0MAwXmBW4r2aP1v5cazwGx9HTi2qxZHTwLfZlfUgwAU7Y392vSv+mblrqdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVGd+pLcD42GoOf01j1zPz/gCgel9gDwmvnNVZ4lVsc=;
 b=Qb7ve4RLOXWA0vf1rzn3D9I9uwBBuL2ete+VSgP8FN//O54TWEnolMZfDNzoE2RULD1hKDMvQpF0QRIEt++RilIyUkbBJ9HiigMR7rJkRy4k/R/VpnM6Q18QWv/QoNGbqOITwDzEET7s4d1RRg952sl63GEw84JyA4q+XYlGB90=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 03:18:15 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 03:18:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/navi10: add OD_RANGE for navi overclocking
Thread-Topic: [PATCH 2/3] drm/amdgpu/navi10: add OD_RANGE for navi overclocking
Thread-Index: AQHV1tB45jeXx+6cBUq6RFoEnUPe9KgI03uQ
Date: Mon, 3 Feb 2020 03:18:14 +0000
Message-ID: <MN2PR12MB33445DBA8D7E2E291CA76AC2E4000@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200129181752.609344-1-alexander.deucher@amd.com>
 <20200129181752.609344-2-alexander.deucher@amd.com>
In-Reply-To: <20200129181752.609344-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3b01e8be-c6a1-45ec-889c-0000d0930493;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-03T03:18:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69cc1f72-4932-4547-78d1-08d7a857b51c
x-ms-traffictypediagnostic: MN2PR12MB3712:|MN2PR12MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37125A1E81C4D9FAAB435174E4000@MN2PR12MB3712.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(6506007)(53546011)(966005)(8676002)(52536014)(8936002)(110136005)(45080400002)(26005)(5660300002)(55016002)(9686003)(33656002)(7696005)(86362001)(71200400001)(4326008)(2906002)(186003)(316002)(81166006)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaHdHA/DhjR4hliP1+un6MOOA699t2vylkatDQooT+Q8j6/1RXkkiw55IKjILRVKkWtQbbO6TmwpvEh27klnVeLBSvS9NBS79FGpESwl0qO9B2YaQWdpNmV6ZEvb7nbDxRwHkV1fDECjzRoS879gIA4sGL6ZE8rzDEhlT3NfgvXPnKRaaMmPan3g75iGHLiznQARUgKfhIky3Q2a1RQUjN8oTMq7ffRFGQHhrwwad0JonY/ZaYCXRWQ/YkfNEOrX9/Bh7RbyUdp3xqsaFXh8X97VYQCqHFrLEc4YXFzRC1vrfV9WIjxnC/B6SGEyLXRAqk4g2o+bT9O9AIL6zbNhn0gbUNT8zFWHA7qE+1fAA0Zr+t/2jDdnE8a/KNizDJfrMhyJB/LS64I9mbqIP3YFZaR1W4rptkzrxtNO21Pp7ZPbSp/LI+m3g/DE6Qc1MB6smOxUpb7Kh2nf9Zru7N5LFLfVDFtJ8LfBfSiG5zLBhChzgpJYgbr0FfEVZ7ChDLLnn2CeKMEwfugIjqyjOfpRhA==
x-ms-exchange-antispam-messagedata: dJTaAsujmeB3nMEVw2LSzGMxvp7XOmoimo1HoebzeLhIy/Mu+i1jmojkVHOFzMS4/kxRU+UMm8hrF3nz1fZwHsCMjYZC+V9QY8Jjy3A2hsJx2+mt6G4huOaqprUK9UxDK++rB9+Oj/Vutjs3sgvVMA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cc1f72-4932-4547-78d1-08d7a857b51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 03:18:14.8458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RI1wnrt2831kGDJ6ARF+JdU7CLklIP6lgk4WLAKOk+/FHLn+wtyLhIKyqwVZfHl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 30, 2020 2:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/navi10: add OD_RANGE for navi overclocking

So users can see the range of valid values.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1020&amp;data=02%7C01%7Cevan.quan%40amd.com%7C0e007c1c61d74ee6f6fb08d7a4e79680%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159186942374776&amp;sdata=5NRVbhuOdaAqKBZorF5%2F33np%2F8aoNa5LZsmMCyrazJY%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index c8f09874c2ec..d2d45181ae23 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -737,6 +737,15 @@ static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_tabl
 	return od_table->cap[feature];
 }
 
+static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_table,
+					enum SMU_11_0_ODSETTING_ID setting,
+					uint32_t *min, uint32_t *max)
+{
+	if (min)
+		*min = od_table->min[setting];
+	if (max)
+		*max = od_table->max[setting];
+}
 
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf) @@ -755,6 +764,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	uint32_t min_value, max_value;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -867,6 +877,55 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			}
 			size += sprintf(buf + size, "%d: %uMHz @ %umV\n", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
 		}
+		break;
+	case SMU_OD_RANGE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		size = sprintf(buf, "%s:\n", "OD_RANGE");
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_LIMITS)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
+						    &min_value, NULL);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
+						    NULL, &max_value);
+			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_CURVE)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+					min_value, max_value);
+		}
+
 		break;
 	default:
 		break;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C0e007c1c61d74ee6f6fb08d7a4e79680%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159186942374776&amp;sdata=pkI2xsrGq0EJNMaWU5r53%2Fv2CJ4p1ngxeaqHulbeoFo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
