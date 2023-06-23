Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3709EC001B1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839B710E6A3;
	Fri, 23 Jun 2023 19:41:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0155D10E69E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW6IIFm8IrDWCr9UekDk0sQyRPLtl/Auguq4djETAFKIUaPUtSyc86xFZN1OFPkrf4v8lNRH/nIKOj9BY1wz65CObfazuR8kw7hEOeIwLJ8sLlMYjcaAJxrfz8PdtDL27h7m0o4840l5kCVWglK27mIO0ECZO0HxbaMsJthnK4He7872tkPMfa0iQ2IBPZ3ny0abBSsKyJTQhulZB7nmKfyNoCag/WNvbK2tgedcJTIfj055BQboQCwNx4dyQokoYzyUaWQA056PHqJ3DZXpzNs6bL8fQrm2mlM0ZuhNWxB4gvZNTbcCe/wRbo3XuUAPW/TmDMAOJluGi1mHDiWkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq/f97z9QumZXbdY1wpRf+KMi6SOwGmdaRziTDu9hzs=;
 b=f46cLdQjM5A7J0pbNC06Jbk3/yMYhnvPossvi2ph1gn4hDMJjmXMo6GKrK8PIaGGjuBANgBrQ1M3sYYIsE55O5o4P+QtOhDj3wTKF3yYP4QiOseL5a76ma2OTGjBmqwci9in5YsrgUoa/K5KLAb53KKJNQB0Os7bnn9AzuWK5GmjPhtaj25rYxuALzQS3Mb3MJ+bCrgCFBAWWxfV3JJX9fttVrmB+iGh2aHIOOT6IvgpTxozfYGXwDszAxvUyIbMaj96qtUYgSqnqlRaYP0DJ/q/Xvaolm6eqQcGMXQbvdN4EMtfkUrrWZ4BZ4IBCJrcyUH7BkHyVHOtTD2ooYrPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq/f97z9QumZXbdY1wpRf+KMi6SOwGmdaRziTDu9hzs=;
 b=jrOykGMiblspqpgjaixu2ohsp+VfImuphRFKcOQ7Cu9JZd05VDGv8DOiz1I9JL2bEFAo5z76TYthMkccNCV4lzrN0FqXgfTrCXxuo16TNCxOT06IBzoLiwb5NAE0AbJ4zFyMiIGdF9s9XlAHRoQUrsWsiyrFtNI9dcaGvuUTndQ=
Received: from SA0PR12CA0019.namprd12.prod.outlook.com (2603:10b6:806:6f::24)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 19:41:04 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::3) by SA0PR12CA0019.outlook.office365.com
 (2603:10b6:806:6f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 19:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 19:41:04 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 14:41:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amd/display: Set minimum requirement for using
 PSR-SU on Rembrandt
Date: Fri, 23 Jun 2023 10:05:20 -0500
Message-ID: <20230623150522.32494-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623150522.32494-1-mario.limonciello@amd.com>
References: <20230623150522.32494-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: d6370774-1b25-468a-44f7-08db7421c84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vCva+kvPd/LiDUqkTH/tia576hhDkXUbABhH/i58uAFjqvRGJipYcZJhrulYzDWQBzRmU/eha+PbYnH4fPU4P6xi2ICenULFpe5N/dtgUb8pDR48h+2CALNNqkoL1bYyWuLWX+ux9a/rzgLulCmd3xhzHC8Qyt1cB5TBjbxSMviSEhrtRa//Q5MAMHBnRfb16SZNdY2T/KpkZAmsOpCgUVf/zr5ROmt8iULz59zUZ+WBeHllW5K+FZwjTi0/9BuWvLytGXrZ6ZBxTzZsU2Ke25RJmWX1+h+NUHgHQGRDhv9pxXLjtOOfqLIXZEdPFy3xydFKkIGAaRxLIrveJpn683+dcS2rUFpLrevezw9Tqq6/hHjDmng6asiPB7cIRc9v5Q7L4H0ZxiLbTE7wTz5psrbO+3EJ6QNx73iRUmECbj1pYnoAjNS8pGpds+aG4dkDGeya3xNM412vhQlF8TsB4+FleWI30eCWy53tnvggujaUtV3rNg/2WNIFMsYdxyLvzsGKYIfFCg8vmC0RYWdFqcHuV+Q0Hh+1JR4QkbVSff1xPjGEPD32uVBXjrKlsp1O4gVeSQ9etxOz8P98nCxPmvzuYQsVjiUxzCRuhW/MoTkmyShx2nEA+eSj12HeP36YyAU2TY6Fmvw+DAxdajC9i/Z7PO59iBRNwjX2MgRULUxe1BsT5vsGNZ2XzYUbaibP411zjlX4hnbWnNYlySDg00541l8liR6QMM62zWUQ8NrkV/PP45dpTfX5MbqGeZT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(26005)(47076005)(1076003)(8676002)(36860700001)(2616005)(83380400001)(336012)(426003)(40460700003)(70206006)(70586007)(316002)(8936002)(6916009)(5660300002)(41300700001)(44832011)(6666004)(478600001)(966005)(7696005)(40480700001)(4326008)(54906003)(86362001)(2906002)(36756003)(82740400003)(356005)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:41:04.5707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6370774-1b25-468a-44f7-08db7421c84b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A number of parade TCONs are causing system hangs when utilized with
older DMUB firmware and PSR-SU. Some changes have been introduced into
DMUB firmware to add resilience against these failures.

Don't allow running PSR-SU unless on the newer firmware.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
    * Fix a s/dcn314/dcn31/ mixup
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 10 ++++++----
 7 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index d647f68fd563..4f61d4f257cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -24,6 +24,7 @@
  */
 
 #include "amdgpu_dm_psr.h"
+#include "dc_dmub_srv.h"
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
@@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
-	return true;
+	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c52c40b16387..c753c6f30dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1011,3 +1011,10 @@ void dc_send_update_cursor_info_to_dmu(
 		dm_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	}
 }
+
+bool dc_dmub_check_min_version(struct dmub_srv *srv)
+{
+	if (!srv->hw_funcs.is_psrsu_supported)
+		return true;
+	return srv->hw_funcs.is_psrsu_supported(srv);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index a5196a9292b3..099f94b6107c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -86,4 +86,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_check_min_version(struct dmub_srv *srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 2a66a305679a..4585e0419da6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -367,6 +367,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_supported)(struct dmub_srv *dmub);
 
+	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
+
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index ebf7aeec4029..c8445d474107 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -302,6 +302,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
 	return supported;
 }
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 58);
+}
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 7d5c10ee539b..89c5a948b67d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -221,6 +221,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9e9a6a44a7ac..7a31e3e27bab 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -226,14 +226,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN314)
+		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
-		else if (asic == DMUB_ASIC_DCN315)
+		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
-		else if (asic == DMUB_ASIC_DCN316)
+		} else if (asic == DMUB_ASIC_DCN316) {
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-		else
+		} else {
 			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+			funcs->is_psrsu_supported = dmub_dcn31_is_psrsu_supported;
+		}
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
-- 
2.34.1

