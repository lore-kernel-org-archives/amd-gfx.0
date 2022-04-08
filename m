Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B7DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E5F10F150;
	Fri,  8 Apr 2022 17:28:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C9310F150
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJSqFFfGJXxSGrtz/7XU+leERGsKl03lv4v+pzAsBwyf+zBUXXU8PfeQa4WInAlBEKZxiA3zFvqWwCWy7inZvo7neQbl4BTWir11Vof4XJH9O6ghtTpAvY5dhqiZyDm1ttkHthfaj6bp8obwFdnmymnNA7x75VX5j54gH5mnIB5CxkflyiaOz1NX26gSt97OHHx7hW9OXt1djo9fSoXMqeYBogCzuR+bqzekSJZZDsmvzR1rBsnJRuP5l/pArhftImV4jJrmvd1M8ctuJrT/Lo3dtVBuyRQ1i1CbwI/oawYyQTueNiEqFlZYRUDFIIc70A5qtkUxm+VSVAotzPjwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKZOxqoW9bXvJISMZeZMIDfZSORQ7hTHAGkZecYkchI=;
 b=gLA8qJLB2+542ZAcdTwZcCs+gcuchhq0BXnTjsFJD/qJU1SJ1mCQyWBlRXQb3eaU/r1dxj1N12z7ne0iee4XLtdex3jsc0+MIi7bcHd8z/fxSyBrfs6iMdOP5kDu6ocOmPLfD0KDx78xGNq1+N8QlIjEOz3HzaJ72Ce+6Po0wsXWg91GZWIjB5MUAiRX/qcYa5A0/yv+/1ndGEN5iGEb9G3xcwkLsxyNuSEPy1ayt0z/0iLBi5TilgalUr0w02R8iBx49q2Gc1jxXo4ZU3PQpX/W3iAjsELrCfM4USru+AoJftCyQhvi9EggUdK++wjVAmjw5+Anl+4+QWA/1cUqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKZOxqoW9bXvJISMZeZMIDfZSORQ7hTHAGkZecYkchI=;
 b=v6zAkgXsxOKAAAh8+XGKSM0P7Gym2mVPDKt8VMSexxAIFEdiVz4W4B0npMjN3S9ZNco+zHf8vIBJDxriR8vOK4gUhXfcJ/YE6Qsu1X14DMWj7xHmYGnLK6z6Vt/RX+jnFM0GSHs2AbA0uB+QmwwHKoC+cQpSAbUggwg7ulCHYuU=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:28:02 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::a4) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 17:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:28:01 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:49 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/20] drm/amd/display: implement shared PSR-SU sink
 validation helper
Date: Fri, 8 Apr 2022 13:19:11 -0400
Message-ID: <20220408171911.601615-21-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45bb5674-20af-4d86-5a0f-08da19852214
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0143:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0143EB729B28973B6352BC8FFCE99@MWHPR1201MB0143.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2w/RrYRQ13IPCQHSmc4kYzn0so9u2EeJb31X8YiLS2EMrGTjapp2UCN2fDzUfVNK37G3NOaXG1ZIO9Fw+EsCuCSdqw5zNwUi/62t7d3Y4LYfcrqWwxgjmsXSFo5GLw5qXaVqEHxbI8ZTqu8vL5zy4r9F5VsoNB3IiMY+y/BopVUbeoFI99EKGgBWYvuWOBs7/bQRY21MpbFSH2kib0K5BkY+mZVmFCjCgEGVov2/iMq6qqwqjqZGVkdPKzaifydt2+xLAvm4gIvPdZElRpB/MJ4uMIquyv92wwi1Ar0/HIQAuLjZvKNy1kGo7aS9OpcI/J65tI5j8Mi973plO5xkT35uP51EnUEFOdNdwbxiF8S22kRYB5FLUuik3sHFUcU2yujzmJzsQsqfUtqqra8Xqmm3ls6oTBjHmhW63rbOewc6LUNRtCWOOa/DPjZkFEopYHXOb/IdVo9ezZEMFZ1xvGgjDPWz9hWFM9Ug5co6gsB5E/nBBQvk2UbcWX4N7uldoQRYKySjelCItSXuTlkXHT1Rq277uch/rK3X4cXHyzKvXZ6THS/l1X4tVIACpfuCkyaxsINrbffCBGCZXtS8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(426003)(8936002)(336012)(2616005)(5660300002)(26005)(83380400001)(508600001)(186003)(40460700003)(6666004)(16526019)(86362001)(6916009)(54906003)(2906002)(356005)(316002)(36860700001)(82310400005)(81166007)(70586007)(70206006)(36756003)(47076005)(4326008)(8676002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:28:01.8356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bb5674-20af-4d86-5a0f-08da19852214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Tom Chung <chiahsuan.chung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[why]
creating a generic helper for AMD specific PSR-SU sink validation.
Moving the function to the power module to reference it across all
OS.

[how]
- drop PSRSU specific sink validation helper and move to power
  module by reading PSR version and other PSR caps
- call the new helper from linux DM (amdgpu_dm_psr)

Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  9 ++++-
 .../amd/display/modules/power/power_helpers.c | 38 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.h |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 0c923a90615c..13b1751e69bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -27,6 +27,7 @@
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
+#include "modules/power/power_helpers.h"
 
 #ifdef CONFIG_DRM_AMD_DC_DCN
 static bool link_supports_psrsu(struct dc_link *link)
@@ -39,6 +40,9 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (dc->ctx->dce_version < DCN_VERSION_3_1)
 		return false;
 
+	if (!is_psr_su_specific_panel(link))
+		return false;
+
 	if (!link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP ||
 	    !link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED)
 		return false;
@@ -79,7 +83,10 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		link->psr_settings.psr_feature_enabled = true;
 	}
 
-	DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
+	DRM_INFO("PSR support %d, DC PSR ver %d, sink PSR ver %d\n",
+		link->psr_settings.psr_feature_enabled,
+		link->psr_settings.psr_version,
+		link->dpcd_caps.psr_info.psr_version);
 
 }
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 2b00f334e93d..97928d4c3b9a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -784,3 +784,41 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 	return result;
 }
 
+/*
+ * is_psr_su_specific_panel() - check if sink is AMD vendor-specific PSR-SU
+ * supported eDP device.
+ *
+ * @link: dc link pointer
+ *
+ * Return: true if AMDGPU vendor specific PSR-SU eDP panel
+ */
+bool is_psr_su_specific_panel(struct dc_link *link)
+{
+	if (link->dpcd_caps.edp_rev >= DP_EDP_14) {
+		if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
+			return true;
+		/*
+		 * Some panels will report PSR capabilities over additional DPCD bits.
+		 * Such panels are approved despite reporting only PSR v3, as long as
+		 * the additional bits are reported.
+		 */
+		if (link->dpcd_caps.psr_info.psr_version < DP_PSR2_WITH_Y_COORD_IS_SUPPORTED)
+			return false;
+
+		if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8) {
+			/*
+			 * FIXME:
+			 * This is the temporary workaround to disable PSRSU when system turned on
+			 * DSC function on the sepcific sink. Once the PSRSU + DSC is fixed, this
+			 * condition should be removed.
+			 */
+			if (link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT)
+				return false;
+
+			if (link->dpcd_caps.psr_info.force_psrsu_cap == 0x1)
+				return true;
+		}
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 2a9f8e2d8080..1a634d8c78c5 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -52,4 +52,5 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		struct dmcu_iram_parameters params,
 		unsigned int inst);
 
+bool is_psr_su_specific_panel(struct dc_link *link);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.32.0

