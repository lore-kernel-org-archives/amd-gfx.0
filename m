Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959B9C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF2F10E459;
	Wed,  9 Aug 2023 15:08:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC17F10E459
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI4jyOIl+dRP18DreDWtEKNk+NahwanQKxiIECXR8jDSOe9vCuJ18PsHVQZXwH7CPHk+nn2/2EC2BandWRlt3DMmpKsW1gW6dYwvywNegp2SnIeDIDeZBvZ9OwF9DV5kfYP4q0OsPZkDSfNRozhDG62AwNXkhC51SiU8VXcnXxPDvAbEgVYCo1BFO7FehRaWbFgIeBj3vBeKAFUw48U9jK+6EkiMUpukwfImPJL+mHvzQmTDohpngNH6GSCNraH+srCE3WBgAj5loT1CkyRQHgm79w8OWdlRU4sfVpIW+V0kI9d1N8PqDpWNu0488VTIo7KLRMqSyjTZo5Y2fWeYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX/ofO3b6+Ee7PXohI9SAK7wj8sA6C7TTkwxxq9+sDo=;
 b=JmQWIVYxlbZlryZOto7ubwmDIq//YpPgozmru9utSfSBv+hP6ENb1cDuzzdXNuvgpdLO80T9+ridXSGQhIDpifUkw0x+69XzUu4diWdJoGs8EB4oh1kbi4J6pAVpGC8MK5M6unZjL4JgMDr1pSBEYFQOLUBtCrzZ2vTgTmIvCa4Wy6fk8BQB3DLPyqvoNvpMwistDdd75uJeFnvzjSVSDQ6BMiJiKtYIhib6xDEtGUIVnevgaXrP9J/aGzU30VAQRKZqN62wHcw1Ib8Y+5PJ075mK02BNj+ZDeBi37ADrusm1KuKph5dJBDc1P+rzpBrFH3IezjYcKmKSpVXiPgCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX/ofO3b6+Ee7PXohI9SAK7wj8sA6C7TTkwxxq9+sDo=;
 b=FYO3hw7FjExd7SOgNJ3ojOAXDkzJyRtY88Hs62Dxq4GOV2BvzKqqhmxFVA1PkT49YEZt90ZMKu65E+bUPb7pU6LqaWguKLj5eRyxFac+2TrL29hwTrZxcPSUDppDIhAe1TgJUlpk8fyZoL378bBGZ9drcLt7qaSx4lRxFK1lnsE=
Received: from CYZPR12CA0021.namprd12.prod.outlook.com (2603:10b6:930:8b::28)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:08:45 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::d3) by CYZPR12CA0021.outlook.office365.com
 (2603:10b6:930:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:45 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:20 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: avoid crash and add z8_marks related
 in dml
Date: Wed, 9 Aug 2023 23:04:59 +0800
Message-ID: <20230809150620.1071566-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b9aadd-e6b2-453c-c093-08db98ea86aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47N0dewbxyfWxo1o8PUXuX8cvzmNOzAEXpfPXrREuh0elfqyp2DSFQ4L1yYqW0iXhbj+A54EbHJL3PqiTQt9s5+4F9CsHdFNnXFwhdMtSBARScPu1IixAq29BYBO6S7QAvuUVVv0VDpLhs4uli168DaKEIyVbyi+TEX4aVPBaTdyOgiLGEVcu5JMywoUgrbV6GvWCk7emGDbwEAJ2PjKo+te79/0nNxfRPZZT4sNqwM1N5VztLa7RWk3AdxkPZOSdktw4mMxI3GB9cbc4X4PSaO0QdSilZFsj5Yk6I7XjXEn3VdmsWf4mM4FvmVn+YWVgL5ZczJPdMwe/RwM8ybVFPlDJe12LsFamoN+g2G9EeWQMpOPi58aCSvk00mEYaivE47T8kTS6XfNwSwcYZnWV/5LYKZyvdIhn+FJMhTRYq62yvhoyQJjPojByePFGnWgDRRa3n1CZN38sAYWjwe9eTa+b7pXa8oIt9uacR6KQLp2pri0bR+pwJ8vVpaSfXCQptnTsU1jhuAMxxpxG/4ycwMvFDWf/qUgLV+zojm7j28rbh+dt8cKjSXDxTk2yd5+l90thQlQJ0yfHmjcn4lrBmMfC2EoDHbVvndq/dWP/OfywHEvWaQ7fYEXRFAAukPf2AfPsJF7zEVgNGiLfigsxlwSO2yVx0rPleZW+Uq4/CStlb9f7Oz+/lo9HtC+hjvv7cEa+xTquZ2+Bb3a4A9tm3DrEbcH4VJxleKJJAwfmk0pxFsh3wdO9Kq2ucDo5xAxxNM/Hc59yk/YR47lqrNkrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(1800799006)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(54906003)(70586007)(70206006)(6916009)(336012)(16526019)(1076003)(26005)(6666004)(478600001)(36756003)(47076005)(83380400001)(36860700001)(426003)(2616005)(41300700001)(44832011)(316002)(4326008)(7696005)(2906002)(86362001)(81166007)(8936002)(356005)(8676002)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:45.1226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b9aadd-e6b2-453c-c093-08db98ea86aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
add dml1 used calculate_wm_and_dlg function pointer check to prevent crash.
add z8 watermarks to struct for later asic use

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h        | 2 ++
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e6220ecf1d7d..88c0b24a3249 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2063,7 +2063,8 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	}
 
 	DC_FP_START();
-	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+	if (dc->res_pool->funcs->calculate_wm_and_dlg)
+		dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 	DC_FP_END();
 
 	BW_VAL_TRACE_END_WATERMARKS();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index cdaa33707f5c..82de4fe2637f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1781,8 +1781,8 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 		BW_VAL_TRACE_SKIP(fast);
 		goto validate_out;
 	}
-
-	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+	if (dc->res_pool->funcs->calculate_wm_and_dlg)
+		dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 4e09ba4f2806..1c1fb2fa0822 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1740,8 +1740,8 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 		BW_VAL_TRACE_SKIP(fast);
 		goto validate_out;
 	}
-
-	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+	if (dc->res_pool->funcs->calculate_wm_and_dlg)
+		dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index aaa293613846..f5677dbb4e7d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -49,6 +49,8 @@ struct dcn_hubbub_wm_set {
 	uint32_t dram_clk_change;
 	uint32_t usr_retrain;
 	uint32_t fclk_pstate_change;
+	uint32_t sr_enter_exit_Z8;
+	uint32_t sr_enter_Z8;
 };
 
 struct dcn_hubbub_wm {
-- 
2.41.0

