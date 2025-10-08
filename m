Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E01ECCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3DF10E88E;
	Wed,  8 Oct 2025 18:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCHPE2cO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F0F10E88E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh2XsnUnimCHv301pNSwGG3DPr+eh/uCxDfGA8Rz7x633Lt4uJY+Ra8wUPlEC0L1QvBPwc5Laqqr9AMxpn0AR2DbbTLdAz6f4TumUts9O4Pv5vZQx4ttyTPcSIUW013k+GK6Q9xRaGRSQCp3e881208RZ/1/aXmSvkJ+XnI5kZNNZSo41Rr5b2KZWMPo1hE9OAuyzfbqbmas59eXybLR8FPI9D7HO1t2pbjVncYuo+MxI9e33/AA8cC213I1ggmexeMdpoaIU5+QC9EfzkL/ysY7jXZyhT4wcilv7QNgBz9BOydRqoTNFWOML7hgx/z6UFGuj8FOWXlbU4/03IIBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AAIjN+X8k5oVf8JqzBfvGjebFNpAOtZNGpioVxPlgA=;
 b=jSL4SnXrC0OIbInGB2b+evht3+HdiMYj87Q6ouBjVjl4PPL8QJWFP2hnt3WUgq0hkwGvDXhpnLq1mg8LLvVTajHMkmIZtIEnnt7juKY+6x3wxCMImNqxwybfb3yPbaqxUA7aCYf/nx61VL/DAE3JgBUIK1C0X/7k8S3+TcynupZC7bpqsLAwo42LW6EwheNhG5IHMk13/o3q2SLcPEutBVzrVX6l8/McXI4H1i/PtdGprK3YUcZqVrAh6SnfnirZjSpR5qZEHqJpesImQlS0bKPDvI7U6Fep7TvRjxfEpTzX9tsxI5/KEaNduR/0+XfolY7wtRI/OQvOSak8fap8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AAIjN+X8k5oVf8JqzBfvGjebFNpAOtZNGpioVxPlgA=;
 b=NCHPE2cOtEzWYvtKJCJIFLrrt9eef+PnAfe6ppmBFR9CVRNwwTEWGTzR7DvFqSXL6RuDh9L39xGjhqXqsTsYCnjbgEbFYCkz++giOHtvfZqQX5njyV4bXX3S3O4a2xyahNbeVuKmKRMfzXebu5EeY5MXXi9YhK71nQ60ANwvo5g=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:23 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::42) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:53 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:53 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Sung Lee
 <sung.lee@amd.com>
Subject: [PATCH 20/22] drm/amd/display: add additional hdcp traces
Date: Wed, 8 Oct 2025 14:47:14 -0400
Message-ID: <20251008184839.78916-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c198546-bd61-4e4f-201e-08de069b65f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLfSrz4eseBs+01jVqStsnqrkusGSJuJ1T/Opfwl9VcpAQjI6M2jHZttURvg?=
 =?us-ascii?Q?QifmLd4nSE7dHqE9Rreea0ypw1337q0FNws+qt1wTj2oIns9++YluP7ggvw1?=
 =?us-ascii?Q?LJKxPtPTk6MDzw89TY1KDqZP8U3wVK5JFba4zyYUlrhdQvoN+w8l+riIoBFS?=
 =?us-ascii?Q?bKISo17H+JKAoexkWpLo9mfArfaMah+/LTci6KEBBDHaHZ+zHjUsszsHJOfY?=
 =?us-ascii?Q?1VgySb1YOLO+7q/kC6DlNeVCCg23b2F8GvX7F8tg43ndjlsbFgQKVr9/yiUb?=
 =?us-ascii?Q?QL++VgHNhRu4n0fiaiC1aMhG3bDnTO5ZU07ZvlRM4OMoRNiwUBnvLTwVuADV?=
 =?us-ascii?Q?YtWXjSvZCY4VWXDwXlVvfcMCkMkgokHL3nwTPqkSGH2ebygY3D28tRCH1XDf?=
 =?us-ascii?Q?9uhlo8GvBFX/LGqMeGExxMS6g0WQ048vV5mH9sTu+345Wipm+0rZhCbPCR01?=
 =?us-ascii?Q?tuLPSSEOtKtme1qCsloFY4VwEIQAAIImQbPHaeL+0X4I7zqaUzHapE+h7vU6?=
 =?us-ascii?Q?iWEXHjZH5f0hINRFv6bt0+XVL2eba1db3O4ZPA/llaB8OUhPTVW4waSL2O8Y?=
 =?us-ascii?Q?3hUniZNPhgEaXi8+O7IfTVsDLh/llScMAzeOGFV5ImgpI+doEctnVtsEmMtq?=
 =?us-ascii?Q?FhBkCcMsolPGKZtg+UnGKYn4KzX1/wobHzCbP0M1WWEbyProJw08PtdoeK5i?=
 =?us-ascii?Q?8Sg3SiGOPR3gPJbnx8Eh2GjT3ORA4OFt4Yg86TLNrqiPjPu1bwTUmIA1oKLh?=
 =?us-ascii?Q?a/7RIm7qKPG7Sk3b7TSBTFQXYSg/3UoWeb0T2SbwTjZnFAoabCmdLoG6sF93?=
 =?us-ascii?Q?D0xUfwB7+fPjN+BsefHEKGR5ugUTizgPKuRHVCX68d2Tpr5xsExX8YfSYNBU?=
 =?us-ascii?Q?1LWGsZEhtbErSjwt4S+E91WigXo+7sibHOHTJQdQzooe+ggSz6fg4KC1EODR?=
 =?us-ascii?Q?f2agc9kQX4G3CtVeAsmNJQGs6a6I8UOrd7My9ue0mjOLqscJJKEMf8fZxcbo?=
 =?us-ascii?Q?qGKAjW67VF5QyC/yOe7CI19rSWX4WLAxrxd1RlbUIzgKqeNEhWqjXLlRtZCA?=
 =?us-ascii?Q?bqF1b2ekIpWbPTSCu5uN95TQwcgydM//mMPqFXWEvoZI9QKKmHhjmO/U4O8q?=
 =?us-ascii?Q?fd0XhtLTwNDBuhIy7dtKUYY8irKeYri4dhzxkuck2GpVZF6ZgdgAhgd2jfMV?=
 =?us-ascii?Q?drzzfjZiwMq6XN6/gQfbQ4rhMJuGPEJqL78HKy5lgWOaevD0FFhhKI2W0tUp?=
 =?us-ascii?Q?mtSRWBSn6xvs2TRqdlI85ZwZi4cwMIpdAZrcoKA5ocPJRdXtjzHg+gQ9L02d?=
 =?us-ascii?Q?VnFh7bZUWSsfHUTa7GAuBKVpyF4b+29g+divJdHwIXkxCSOwWausE3A13Ius?=
 =?us-ascii?Q?WRXFqDWjwhqlKwYhm3HyaDUBYnD2HN3/8Y+4X5W+ZSLTUdttd3svhoMfgsfs?=
 =?us-ascii?Q?IgK7bqFj8KJ+uvd6/hei/vPHJZCTK29SMPd2HbkGWNtX1zmUSnvB9on3ekHd?=
 =?us-ascii?Q?f5ENmjOm8KPRnw+HN3f+qk1UC6WdJmrQWNYl43tqz3G0kAwzGXsum29qbnDB?=
 =?us-ascii?Q?J40yDFe5Ru0HNdYkkOg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:23.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c198546-bd61-4e4f-201e-08de069b65f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Current hdcp trace only tracks hdcp errors. We need to expand the trace
structure for more tracing information.

[how]
Add following traces for hdcp1:
- attempt_count
- downstream_device_count
Add following traces for hdcp2:
- attempt_count
- downstream_device_count
- hdcp1_device_downstream
- hdcp2_legacy_device_downstream

Reviewed-by: Sung Lee <sung.lee@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  6 +++---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  2 +-
 .../display/modules/hdcp/hdcp1_execution.c    | 13 +++++++++++--
 .../display/modules/hdcp/hdcp2_execution.c    | 19 ++++++++++++++++---
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |  6 ++++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    | 14 ++++++++++++++
 6 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index c760216a6240..ca402ddcdacc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -354,7 +354,7 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 	/* reset retry counters */
 	reset_retry_counts(hdcp);
 
-	/* reset error trace */
+	/* reset trace */
 	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
 
 	/* add display to connection */
@@ -400,7 +400,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	/* clear retry counters */
 	reset_retry_counts(hdcp);
 
-	/* reset error trace */
+	/* reset trace */
 	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
 
 	/* remove display */
@@ -464,7 +464,7 @@ enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
 	/* clear retry counters */
 	reset_retry_counts(hdcp);
 
-	/* reset error trace */
+	/* reset trace */
 	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
 
 	/* set new adjustment */
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index a37634942b07..b883d626f1c3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -508,7 +508,7 @@ static inline void set_auth_complete(struct mod_hdcp *hdcp,
 		struct mod_hdcp_output *output)
 {
 	output->auth_complete = 1;
-	mod_hdcp_log_ddc_trace(hdcp);
+	HDCP_AUTH_COMPLETE_TRACE(hdcp);
 }
 
 /* connection topology helpers */
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 8bc377560787..1bbd728d4345 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -29,6 +29,7 @@ static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 {
 	uint64_t n = 0;
 	uint8_t count = 0;
+	enum mod_hdcp_status status;
 	u8 bksv[sizeof(n)] = { };
 
 	memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
@@ -38,8 +39,14 @@ static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 		count++;
 		n &= (n - 1);
 	}
-	return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
-			MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
+
+	if (count == 20) {
+		hdcp->connection.trace.hdcp1.attempt_count++;
+		status = MOD_HDCP_STATUS_SUCCESS;
+	} else {
+		status = MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
+	}
+	return status;
 }
 
 static inline enum mod_hdcp_status check_ksv_ready(struct mod_hdcp *hdcp)
@@ -135,6 +142,8 @@ static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 	if (get_device_count(hdcp) == 0)
 		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
 
+	hdcp->connection.trace.hdcp1.downstream_device_count = get_device_count(hdcp);
+
 	/* Some MST display may choose to report the internal panel as an HDCP RX.
 	 * To update this condition with 1(because the immediate repeater's internal
 	 * panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp).
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index bb8ae80b37f8..5628f0ef73fd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -48,6 +48,7 @@ static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp
 static inline enum mod_hdcp_status check_hdcp2_capable(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
+	struct mod_hdcp_trace *trace = &hdcp->connection.trace;
 
 	if (is_dp_hdcp(hdcp))
 		status = (hdcp->auth.msg.hdcp2.rxcaps_dp[0] == HDCP_2_2_RX_CAPS_VERSION_VAL) &&
@@ -55,9 +56,14 @@ static inline enum mod_hdcp_status check_hdcp2_capable(struct mod_hdcp *hdcp)
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE;
 	else
-		status = (hdcp->auth.msg.hdcp2.hdcp2version_hdmi & HDCP_2_2_HDMI_SUPPORT_MASK) ?
-				MOD_HDCP_STATUS_SUCCESS :
-				MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE;
+		status = (hdcp->auth.msg.hdcp2.hdcp2version_hdmi
+				 & HDCP_2_2_HDMI_SUPPORT_MASK)
+				? MOD_HDCP_STATUS_SUCCESS
+				: MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE;
+
+	if (status == MOD_HDCP_STATUS_SUCCESS)
+		trace->hdcp2.attempt_count++;
+
 	return status;
 }
 
@@ -201,10 +207,17 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
+	struct mod_hdcp_trace *trace = &hdcp->connection.trace;
+
 	/* Avoid device count == 0 to do authentication */
 	if (get_device_count(hdcp) == 0)
 		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
 
+	trace->hdcp2.downstream_device_count = get_device_count(hdcp);
+	trace->hdcp2.hdcp1_device_downstream =
+			HDCP_2_2_HDCP1_DEVICE_CONNECTED(hdcp->auth.msg.hdcp2.rx_id_list[2]);
+	trace->hdcp2.hdcp2_legacy_device_downstream =
+			HDCP_2_2_HDCP_2_0_REP_CONNECTED(hdcp->auth.msg.hdcp2.rx_id_list[2]);
 	/* Some MST display may choose to report the internal panel as an HDCP RX.   */
 	/* To update this condition with 1(because the immediate repeater's internal */
 	/* panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp). */
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index 1d83c1b9da10..26553aa4c5ca 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -31,6 +31,7 @@
 #define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_TOP(hdcp, ...) pr_debug("[HDCP_TOP]:"__VA_ARGS__)
 #define HDCP_LOG_DDC(hdcp, ...) pr_debug("[HDCP_DDC]:"__VA_ARGS__)
+#define HDCP_LOG_TRA(hdcp) do {} while (0)
 
 /* default logs */
 #define HDCP_ERROR_TRACE(hdcp, status) \
@@ -131,4 +132,9 @@
 		HDCP_LOG_TOP(hdcp, "[Link %d] %s display %d", hdcp->config.index, __func__, i); \
 } while (0)
 
+#define HDCP_AUTH_COMPLETE_TRACE(hdcp) do { \
+		mod_hdcp_log_ddc_trace(hdcp); \
+		HDCP_LOG_TRA(hdcp); \
+} while (0)
+
 #endif // MOD_HDCP_LOG_H_
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index b51ddf2846df..46e52fb3a118 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -230,9 +230,23 @@ struct mod_hdcp_error {
 	uint8_t state_id;
 };
 
+struct mod_hdcp1_trace {
+	uint8_t attempt_count;
+	uint8_t downstream_device_count;
+};
+
+struct mod_hdcp2_trace {
+	uint8_t attempt_count;
+	uint8_t downstream_device_count;
+	uint8_t hdcp1_device_downstream;
+	uint8_t hdcp2_legacy_device_downstream;
+};
+
 struct mod_hdcp_trace {
 	struct mod_hdcp_error errors[MAX_NUM_OF_ERROR_TRACE];
 	uint8_t error_count;
+	struct mod_hdcp1_trace hdcp1;
+	struct mod_hdcp2_trace hdcp2;
 };
 
 enum mod_hdcp_encryption_status {
-- 
2.51.0

