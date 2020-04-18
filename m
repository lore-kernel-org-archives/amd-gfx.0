Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F7C2BA19
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 04:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E8D21D82
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 04:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B69LxZEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E8D21D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A516EC5F;
	Sat, 18 Apr 2020 04:11:13 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760089.outbound.protection.outlook.com [40.107.76.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA12F6EC5F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2020 04:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgWTYL+aY5Y05p9bejLoQHqLKn617eN5UjIVn5EE6LSnMAz2+F8H0MBySSKb/8zOhmz4xTbGm7H72u7gsezauoOhySrVtiBWESXB3QTa4gYa08NM0vr9Rq9hSo/nuukKZoyGeqlCTc5moUJSKP3G+vkXyHDEgzFmj4phFhuef1t6EhAa6+tAMqNuZvYUntf6qQnn3c07bMygr27wIfzpD0Qni2AJPms7R91c7IL3KZ/LqG/CfSzzi0EQaBBAbGiyOOX4tq6dpRJJ7r6/+VGTJLxhDYa9E0deJvPbqkx7cpVeIqjhf4bg3c59KmL/zubab5Ptmg7dWAqWIA7cFD5Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DchsMVGS/Tr6TLJVcxb9kGv6OjiSeIB7rsBznWKxNT4=;
 b=BaWEEUg8XVDpEQGkr4nZNwzjocd3xj8pgCeTUc5qBNhHRlj/NfYfzsE3tVaS8+DNN44yZ+PZC0/UKEw08d4QCnjPsdGa6ssl48bZEOl6GATk81X/TQewGs3WDnwhOYgHuW2+aIykm2v6m7tJNqzswpJnWCZUSdd5gm4ImB1KTA0wZzl9NYNApYye6JXlBJ77eZR70hWPf6fnub9t5FM2E0xDtGdB2H1oCanOspc9PIV/tTSKHTtcsxjKq1veu6JmtS0AEEcf5RXe2Jsw8oIP7VL+TlSV9WnhLaebx9BepzRJKVDAogVyILkDbGCxSTz/mZe7FOOtXErzlfZburvoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DchsMVGS/Tr6TLJVcxb9kGv6OjiSeIB7rsBznWKxNT4=;
 b=B69LxZEM4zexo4W0g7shhml0q08GXlICOKUOFRLi5GtFFDNJiD62yhjYUAuI4Okws5MCqUM3Z9sn7zUS1EQ6Gf+lliK782AAWBsudzJIk5K98uPZ4GizzTafCT0mNT0coz260Z3a7GdG1JeEsGzH5Oso5EOMJL6e4kcXD2Kxw6k=
Received: from CO2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:100::31) by
 MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Sat, 18 Apr 2020 04:11:06 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::5f) by CO2PR07CA0063.outlook.office365.com
 (2603:10b6:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Sat, 18 Apr 2020 04:11:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Sat, 18 Apr 2020 04:11:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 23:11:04 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 23:11:04 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Apr 2020 23:11:02 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for
 gfx/mmhub
Date: Sat, 18 Apr 2020 12:10:49 +0800
Message-ID: <20200418041049.21504-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(46966005)(47076004)(82740400003)(66574012)(81166007)(356005)(110136005)(6666004)(1076003)(70206006)(70586007)(478600001)(5660300002)(7696005)(26005)(2616005)(186003)(4326008)(426003)(336012)(6636002)(81156014)(8936002)(8676002)(316002)(2906002)(36756003)(86362001)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae573b2-2c93-4b33-c8a3-08d7e34e8422
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36319C26D5EF99AEE50A131BEDD60@MN2PR12MB3631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-Forefront-PRVS: 0377802854
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S+0KXzYcCy2G9jvXT3gSLd28yjg9k2NGCHDSmSTAzrfqJNvpU2/z8Xu9E8l06oOlULMXxF1ZgHRU9YSwRTGs4QP9ZUEVxd1yBsFpMPpK7qiB+2eomKaaSKKOmj1nQ/V0Ugc52unBhpYK2ewq/SNTGF5FTmDRC4qLlrSFxT26QCp499rfmswELBplToualbQULRtFmpyhU2Zfrnla7WQ4Q42wD/vubdC1Yz5O9Qp2HUi/mbn8QNtzUt7/nJZF2nN9zrkqeX2d5I94hAf8Lmr9LfkKkBYpSEqhzfnKn83iCKx/tA926dKmn85IYIqVsv+6hKPhqdqY7vY+pHngsfA4xMCD96ZrjuU4Q+o2dUbVET7IAorQyIV9CoJzYsFswCtwev6Vz29w97ICjczSJesRqxGrTfJ0QLRD0fkXsP2pxbQZoxHJD3661zMguf+hF78oaRytAJTsMwe0NeSnc82ZSm88FVJOYqLok/saGxtCqL123TDwOTiONnVJzeHWxWTcPy0mrmoBLpVKMKm2yzBOe6Br9Sm28flEnYs4diztfY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2020 04:11:05.7912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae573b2-2c93-4b33-c8a3-08d7e34e8422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prefix RAS message printing in gfx/mmhub with PCI device info,
which assists the debug in multiple GPU case.

Change-Id: Iceba7cafd5aac7d0251d9f871503745cc617fba2
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
old mode 100644
new mode 100755
index dce945ef21a5..46351db36922
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -732,7 +732,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -740,7 +741,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -752,14 +754,16 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 utcl2_router_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 utcl2_router_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -772,7 +776,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_2m_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -780,7 +785,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_2m_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -793,7 +799,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_4k_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -801,7 +808,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_4k_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -816,7 +824,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
+static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
+				    const struct soc15_reg_entry *reg,
 				    uint32_t se_id, uint32_t inst_id,
 				    uint32_t value, uint32_t *sec_count,
 				    uint32_t *ded_count)
@@ -833,7 +842,8 @@ static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
 		sec_cnt = (value & gfx_v9_4_ras_fields[i].sec_count_mask) >>
 			  gfx_v9_4_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
+			dev_info(adev->dev,
+				 "GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 sec_cnt);
 			*sec_count += sec_cnt;
@@ -842,7 +852,8 @@ static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
 		ded_cnt = (value & gfx_v9_4_ras_fields[i].ded_count_mask) >>
 			  gfx_v9_4_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %d\n",
+			dev_info(adev->dev,
+				 "GFX SubBlock %s, Instance[%d][%d], DED %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 ded_cnt);
 			*ded_count += ded_cnt;
@@ -876,7 +887,7 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 				reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
 					gfx_v9_4_edc_counter_regs[i]));
 				if (reg_value)
-					gfx_v9_4_ras_error_count(
+					gfx_v9_4_ras_error_count(adev,
 						&gfx_v9_4_edc_counter_regs[i],
 						j, k, reg_value, &sec_count,
 						&ded_count);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
old mode 100644
new mode 100755
index 396c2a624de0..bd2d2b8d1f42
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -690,7 +690,8 @@ static const struct soc15_reg_entry mmhub_v1_0_edc_cnt_regs[] = {
    { SOC15_REG_ENTRY(MMHUB, 0, mmMMEA1_EDC_CNT2_VG20), 0, 0, 0},
 };
 
-static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
+static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
+	const struct soc15_reg_entry *reg,
 	uint32_t value, uint32_t *sec_count, uint32_t *ded_count)
 {
 	uint32_t i;
@@ -704,7 +705,8 @@ static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
 				mmhub_v1_0_ras_fields[i].sec_count_mask) >>
 				mmhub_v1_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("MMHUB SubBlock %s, SEC %d\n",
+			dev_info(adev->dev,
+				"MMHUB SubBlock %s, SEC %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				sec_cnt);
 			*sec_count += sec_cnt;
@@ -714,7 +716,8 @@ static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
 				mmhub_v1_0_ras_fields[i].ded_count_mask) >>
 				mmhub_v1_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("MMHUB SubBlock %s, DED %d\n",
+			dev_info(adev->dev,
+				"MMHUB SubBlock %s, DED %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				ded_cnt);
 			*ded_count += ded_cnt;
@@ -739,7 +742,8 @@ static void mmhub_v1_0_query_ras_error_count(struct amdgpu_device *adev,
 		reg_value =
 			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_0_edc_cnt_regs[i]));
 		if (reg_value)
-			mmhub_v1_0_get_ras_error_count(&mmhub_v1_0_edc_cnt_regs[i],
+			mmhub_v1_0_get_ras_error_count(adev,
+				&mmhub_v1_0_edc_cnt_regs[i],
 				reg_value, &sec_count, &ded_count);
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
