Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0FF61546
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D0FF61546
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2116E2D1;
	Fri, 19 Nov 2021 19:44:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795426E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS8mjwXXXTh7vL3WNMlPcsHk0cdVspz+VNt89t1C1OJPQe7/Q4EKJyJ3zEql8ZnJyG6dYxFCQEIw32YnaSAY+5WtX9vjF/+S15s59befXA2xWdX4xEQCKjnKZQ3bjwBNik7FWs/PoXDZb6lCznhaoXQKaG8+O5HJkOvMvOifR82xPBhAeognVTJD42kaspB7xgftxKmUrbH29F1JReAl2gnciGU1g+owE7BXhs/8IXLtj4tBvL8RF+GEuACZ0japURcBVgTZkpaYbrJn48cBWdgffkKfDYaZZqN2gIO/GAxnDZRThjdxzXslHwxn/ee9zEPaN9FTBjjyoMSiwei7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTJwI2sj4sH9Sf2ZmBGGasrkJ+fYOThviKkjXUJAOJs=;
 b=LW5ITBDab7C7hFX99zRUKMDf7WZOGRc7fngTPt58i1xAsP59w6DycbK5mgMcFwT0Q9L+tRQ4o81SrJhygxrQXHA54IErCBruTQ7MC8VG/lv789akb9AOFdv18yXTr9B9lmxV6LYRYtCs7kF7dxHBjTJWeqAOWqfLzhfpi4sgY7ioR6fFAbDti+pe60LzqpZT8UqwItqOcGw81s1LM+/0mwJ1Tq5h2P912poHfSFc3aY20M/VycJ2lAmrlbCfe80FMtrKTvn4qOYxnkH0uZYrpTSaVuAXotX/OAOLAtIBoIImifBbQUQSSBmXIrsuRmSMjIhYLcaohm3cDFQj0ZBOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTJwI2sj4sH9Sf2ZmBGGasrkJ+fYOThviKkjXUJAOJs=;
 b=EcElnV6AC+M8lp/lusvSa6QQtQ1YbgsM5grYDbGC2R+Be7in/6CbIQsmmv/44deGhASRgUnkSeRDF+qt5PUbb56FMaets64MMnzB/fMdt3xLxO8fkT3RlWVIpXyxLIvkoX3B3z0dJgvDXzQWjMiWhe3XM3UeUrPPHg9zBJ8WZC0=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:43:57 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::47) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:54 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: fixed an error related to 4:2:0/4:2:2
 DSC
Date: Fri, 19 Nov 2021 14:43:29 -0500
Message-ID: <20211119194339.97573-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db28537-d016-4d70-006b-08d9ab94eceb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:
X-Microsoft-Antispam-PRVS: <BN8PR12MB321737AA46D854033C216CF1FB9C9@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFl6D25H9iAIPNz42wmmMvspYBgoZ5o+usstK+ZnMP7ah7MY+0RPGOkvqA7NdsoKYsxCVr5OSBl+42alqVMxFc79TUHhTxJquuk/N72cXA/6eaCfQmqDjZzDA7/UjKVrcG0+ytzGsJLPDWh372YvaJ7+xw/5lQNYyomrwDcj/KN5JxKScxtLERFmeYUXc3LXpBgm6RtfTR82ZkOORQcvdbaMoBzbsztOtM8wco1nHzwzODSWSuGA2ClGP8GNyml1VFIi5U3F09BvVeK7iWH2z+Bvxh5ub4rgA+JrQmSehWMEvUkgtOTerK2VKKfau1Zh294XeyYItEnf7j9C4nCVuk+Qv1ndArSndt7CtF8CAb9dBlVK5YqTLaHzGeTMCFTspbAB/CIqDANoyfaqJYY0hkVxnXtFVvaVUBIPIzdDg8LEEGz6KFdrNcDS6U8qZwD1gogB/ZDgoue3UJorbPLuuKqBbODNCFwDoNU09Coi16IPYATNIqIA2i3hNW5Unyp+TjJBYJAQ6YTqiAiaSxw38NkmPVxnbPO1wcz3xb1rm2KVLTFyvSLzxo7MP4OUXgZ+A+sOGPNxkApnxhCBY804R3eyHMfqkFWD0lsrOWOcS5oZ2Fkvu87YCuf9MV4OBWmZyQyX6Vm7MSmHzkUje+hurwOX7gKi0lNPC8MWo7HfS+UFeu5hETbxxsPRJ+rzT/Mz7BBMmRxU7nFEIh/ArwyMjATmBipzZYqAIVkjUl0M1jESqhgfZVHWw6QSvdnOrSMdTfbWj+1cXlppyo2TmTokjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(36756003)(16526019)(5660300002)(44832011)(70586007)(47076005)(356005)(81166007)(36860700001)(508600001)(1076003)(8936002)(82310400003)(2616005)(6666004)(54906003)(2906002)(316002)(86362001)(4326008)(83380400001)(26005)(336012)(426003)(6916009)(186003)(70206006)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:56.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db28537-d016-4d70-006b-08d9ab94eceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, "Guo, Bing" <Bing.Guo@amd.com>,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Guo, Bing" <Bing.Guo@amd.com>

[Why]
OPTC_BYTES_PER_PIXEL calculation for 4:2:2 and 4:2:0 could have error.

[How]
Change to use following formula:
OPTC_DSC_BYTES_PER_PIXEL = ceiling((chunk size * 2^28) / slice width)

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
---
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 31 -------------------
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  4 ---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 28 -----------------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  1 -
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |  5 +--
 5 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
index 3ee858f311d1..122ba291a7ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -61,16 +61,6 @@ static double dsc_roundf(double num)
 	return (int)(num);
 }
 
-static double dsc_ceil(double num)
-{
-	double retval = (int)num;
-
-	if (retval != num && num > 0)
-		retval = num + 1;
-
-	return (int)retval;
-}
-
 static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
 		       enum max_min max_min, float bpp)
 {
@@ -268,24 +258,3 @@ void _do_calc_rc_params(struct rc_params *rc,
 	rc->rc_buf_thresh[13] = 8064;
 }
 
-u32 _do_bytes_per_pixel_calc(int slice_width,
-		u16 drm_bpp,
-		bool is_navite_422_or_420)
-{
-	float bpp;
-	u32 bytes_per_pixel;
-	double d_bytes_per_pixel;
-
-	dc_assert_fp_enabled();
-
-	bpp = ((float)drm_bpp / 16.0);
-	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
-	// TODO: Make sure the formula for calculating this is precise (ceiling
-	// vs. floor, and at what point they should be applied)
-	if (is_navite_422_or_420)
-		d_bytes_per_pixel /= 2;
-
-	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
-
-	return bytes_per_pixel;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
index b93b95409fbe..cad244c023cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
@@ -78,10 +78,6 @@ struct qp_entry {
 
 typedef struct qp_entry qp_table[];
 
-u32 _do_bytes_per_pixel_calc(int slice_width,
-		u16 drm_bpp,
-		bool is_navite_422_or_420);
-
 void _do_calc_rc_params(struct rc_params *rc,
 		enum colour_mode cm,
 		enum bits_per_comp bpc,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index b19d3aeb5962..e97cf09be9d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -60,31 +60,3 @@ void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps)
 			   pps->dsc_version_minor);
 	DC_FP_END();
 }
-
-/**
- * calc_dsc_bytes_per_pixel - calculate bytes per pixel
- * @pps: DRM struct with all required DSC values
- *
- * Based on the information inside drm_dsc_config, this function calculates the
- * total of bytes per pixel.
- *
- * @note This calculation requires float point operation, most of it executes
- * under kernel_fpu_{begin,end}.
- *
- * Return:
- * Return the number of bytes per pixel
- */
-u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps)
-
-{
-	u32 ret;
-	u16 drm_bpp = pps->bits_per_pixel;
-	int slice_width  = pps->slice_width;
-	bool is_navite_422_or_420 = pps->native_422 || pps->native_420;
-
-	DC_FP_START();
-	ret = _do_bytes_per_pixel_calc(slice_width, drm_bpp,
-				       is_navite_422_or_420);
-	DC_FP_END();
-	return ret;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
index c2340e001b57..80921c1c0d53 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
@@ -30,7 +30,6 @@
 #include "dml/dsc/rc_calc_fpu.h"
 
 void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
-u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
 
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 1e19dd674e5a..381561ee0026 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -101,8 +101,6 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
 	struct rc_params rc;
 	struct drm_dsc_config   dsc_cfg;
 
-	dsc_params->bytes_per_pixel = calc_dsc_bytes_per_pixel(pps);
-
 	calc_rc_params(&rc, pps);
 	dsc_params->pps = *pps;
 	dsc_params->pps.initial_scale_value = 8 * rc.rc_model_size / (rc.rc_model_size - rc.initial_fullness_offset);
@@ -113,6 +111,9 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
 	dsc_cfg.mux_word_size = dsc_params->pps.bits_per_component <= 10 ? 48 : 64;
 
 	ret = drm_dsc_compute_rc_parameters(&dsc_cfg);
+	dsc_params->bytes_per_pixel =
+			(uint32_t)(((unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1))
+							/ (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
 
 	copy_pps_fields(&dsc_params->pps, &dsc_cfg);
 	dsc_params->rc_buffer_model_size = dsc_cfg.rc_bits;
-- 
2.25.1

