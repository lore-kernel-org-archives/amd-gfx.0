Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0752DC77B73
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Apr 2023 18:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A1610E1E0;
	Sat, 15 Apr 2023 18:27:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5601010E1E0
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Apr 2023 18:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1uEaKvuXwMhXEusEp/w6xHzedz4yXo7Xdnu/szWzSK6PbY8SIS82uXu/cvCgFkn8Fpev3xyBEEF9dIDzEz2av6MI+/a9iR1XPbZ3TWjrr0dJHKT+JPSBax1k9GjwAvjkMy+n5IlbHK7WHbO6GGyQuGlP72c3ljvIf1oL2hSFcad/W8WoV3+GBwOIXYptj0M/bYP9osHko5VhhYvCQbxQpP6iM5/Jb7czOWmddtd2yPCZcybGR++4O2LyJ5rewHaaObss/8yz62Q1glxqGHOGFymqgfOCUStcrvXE4XYsueypwD691lVuHqDsZok2WQlTS2Ap3rYWTSJIjZcPAep5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3nkzj+26wbfBuW418VtyhR6r0yluOZoMJoWGsr60WY=;
 b=EAfrW1n/1MK6BeLiGUV6pF0v0Eauff5dko1FZINMu2jvWMgF1NoPalA0LqTMnNjem4cUslbnV+s8og9xsYCloyKBGaomVNR68E35IqpPMJcQ82CqaM1FMtNbOfSe1na+G1/uC+UZLIjRImF+x3tHyTBga4hEf2m5jlaj5hVQ6UP40BzdfQCUApS1a78qdsR5X221DnPwroTDAN32kaS/zjoURem1YTwIO7smsFwIxFx9aBZ7U4OUKgfjS7TDyHqpNcT06DmgQRghcpNCSgdNpf6Z0DzC7g+3BI0wrwkraML6QYpnrVxS7odBtBWlpTXuuxfZlBT+OUcPLKIN1wX+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3nkzj+26wbfBuW418VtyhR6r0yluOZoMJoWGsr60WY=;
 b=Q7x31dRveC06c60szxPq/OKopMsW/162fgTuNODKuI5SDcJWQ1bICmcylFsZ86klUIETBaO5dH5u5jrvMutiNKZb7rb18yC6nXghcHguy7TCI9Gv2EnZrpO8DpjLv/QBAhQmya3vycrzKALypSGBnynBuQ+Uip3H3bQ/dFCuL+4=
Received: from BN0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:e8::26)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 18:27:27 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::7b) by BN0PR04CA0051.outlook.office365.com
 (2603:10b6:408:e8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.44 via Frontend
 Transport; Sat, 15 Apr 2023 18:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Sat, 15 Apr 2023 18:27:26 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 15 Apr
 2023 13:27:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH v2] drm/amd/display: Check & log if receiver supports MST,
 DSC & FEC.
Date: Sat, 15 Apr 2023 23:57:06 +0530
Message-ID: <20230415182706.3341057-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: e35844c0-ed5b-432e-7580-08db3ddf1038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWBNvFHgzqHb+DRcvzEuOK2ng5jt0sG71ZoY5F1kUKwOWWaFz/RhtfT8cuBqiJMnMfdq5rkNYP4Df+JfFadmLcZUdGV39CXX7HbeHAm6KN20l/MnhJxNPWVi3FoRKkWxid7qMkLOOw0kLmpvAGy3Hu2Z5Mx/SamVnC3fQe7gQfMN8WuIgB0/umJo4CwGLBLNwz+JOQdVeLhrYXCxQQwvsFqc57LlH95kblT9TD16U25uyTY/XOOAo2Ah29k69yMT6Th5MMcm19PldxU3wYggY34VSeVSZxxYUzOWRYo2LlygC/JsyL3Kd8MT98j/NSPW7umk8TYZBbmwMrAt/XGQZVNfeArnCJxh34jQunwPcUb2GQTn4jA+mkPqqFwbWI1+5tWFAnWSsja9VuBciE3jn/OEmW+o4pp1VzBKyFBL00NxSPBFuMc5B+2W50P/GogTB6OO307IMCUMwBBMJdPRZF9gygTu3m84KEibPUf+PV7UmGDN1mXSTdeFdhYFrWSgpAt2esrsYMBefm6e49EbT2N0rH7UlcpQZ0D4NOCY6QY70NaQ7TrbnXwWKJlmBgCsTinsv7P108MLIZaCgkPty+nlN5RQ/j5WILPOJHWr00g4wpI5yj69SdsgU9Ct3yDyXlzZrySNdqwKC6LLgvQf7jzD+CsGeQnos6bkrzC8MxKq6Ceo9Cg56QaYUiQmpfYDGL79OI870zTyuwhDYQ2nUkRYi8aNmuabrXw+JRPOMGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(5660300002)(7696005)(40460700003)(2906002)(4326008)(70206006)(36756003)(70586007)(44832011)(86362001)(81166007)(82310400005)(41300700001)(478600001)(356005)(316002)(8936002)(82740400003)(8676002)(40480700001)(54906003)(6636002)(110136005)(1076003)(26005)(336012)(426003)(36860700001)(16526019)(2616005)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 18:27:26.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35844c0-ed5b-432e-7580-08db3ddf1038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After reading from receiver via DPCD, check & log if it supports MST,
DSC & FEC

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

 - Added %s: to print the function name.

 .../amd/display/dc/link/protocols/link_dp_capability.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ba98013fecd0..f93fc35a1a50 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1554,6 +1554,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
+	bool is_fec_supported = false;
+	bool is_dsc_supported = false;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(&down_strm_port_count,
@@ -1696,6 +1698,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 
 	/* TODO - decouple raw mst capability from policy decision */
 	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
+	DC_LOG_DC("%s: MST_Support: %s\n", __func__, str_yes_no(link->dpcd_caps.is_mst_capable));
 
 	get_active_converter_info(ds_port.byte, link);
 
@@ -1803,6 +1806,12 @@ static bool retrieve_link_cap(struct dc_link *link)
 				DP_DSC_SUPPORT,
 				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
+		if (status == DC_OK) {
+			is_fec_supported = link->dpcd_caps.fec_cap.raw & 0x1;
+			is_dsc_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.raw[0] & 0x1;
+			DC_LOG_DC("%s: FEC_Sink_Support: %s\n", __func__, str_yes_no(is_fec_supported));
+			DC_LOG_DC("%s: DSC_Sink_Support: %s\n", __func__, str_yes_no(is_dsc_supported));
+		}
 		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
 			status = core_link_read_dpcd(
 					link,
-- 
2.25.1

