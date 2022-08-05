Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015BDC25B07
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F61591EB2;
	Fri,  5 Aug 2022 18:00:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F5AB93EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHX9c21Y2mpw82arTJrfBfQ+sCqEDyBfXDWoq1TIKFBlkI5IbXmv29oqnJi+ZRsqOTYmWOb++BFG3xb7ZA5ueQIjcOssilOPwC1q80vdY4HRZ2dII6YKKCOepRow5UTC95jgFB/OdhBZV3+8m5askNN1QemCPhG1vC7sIzImdqwDn2wDGQCBYTdx2HJGtz4XcBB+LnwyT/fdpUyGr0HL8YfOekGlQHAIFd+Dpsg5PhcS83hfsyvN76soLvUzO08NRMLK2kPu660crELsFtwGVNPINApm5qA12WyUyPWNsrLX8P7bxPFlk/Xiwh5siiLI8axQQuoF+A/ZVdUVUezebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki7CfdNZB0MAcArp34XrEYxF+WlC6mtdaxwCf8S+7PI=;
 b=FxgNOlIghz/MUQIeNx+fWgckIDb0+gNYSihuMD+dTVG2N+e5pAjQgfJorRn1UTFUskOHS+3bAISfxSfZ+jbHYOzMRCGPXy88wtF0KpT+5y5Rlboh/YNpl6iB29TGn7dzJ7IHbqV2glZvlvVs/Chpc5CLon2UFFfUbRTiWuryhkbU3iGGmkSVTbU/2qKwTwLuRcs4dJylym1DINcnLSRnSVuQVfZVyHNRKi0POinsjRP/Pw7Beh2IGewflceZMivp2ZRgblN9swi9b6fMhSbJerO98+LijYrSQGOh+6vtHvZtJ7CwzC4Bq82x7cqiU2vMWDzEKC4CCFRsos00ecPm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki7CfdNZB0MAcArp34XrEYxF+WlC6mtdaxwCf8S+7PI=;
 b=m6hrd50nmW9ieG4LS4vhtlWVpD2IUhEhOU2WF66C4MnbpeEpD7kPR0xsHVYLUUVoL1T16DOQBP/GSJgXAhPuRxxibfffhjQ6y+WIjIwwGi8E911jM1+4fKLku5LfXo7Lm6i5jdt+Z6tbeaXpEnXl3sQrwMSEYFDrfsgBsZ4zteU=
Received: from MW4PR04CA0328.namprd04.prod.outlook.com (2603:10b6:303:82::33)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:00:28 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a1) by MW4PR04CA0328.outlook.office365.com
 (2603:10b6:303:82::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:26 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/32] drm/amd/display: Document pipe split policy
Date: Sat, 6 Aug 2022 01:58:12 +0800
Message-ID: <20220805175826.2992171-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf43b7bb-22e8-4891-df70-08da770c618f
X-MS-TrafficTypeDiagnostic: SN7PR12MB7130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laxrE/R7q00T6yDwzYG5/txqY8IhpGE6/VbAfN60zYQzoRItApq5v330tJ4FB05GC9+98oGoNZHHPhPW/xVyqgP3Jj4L/KGGr4EogmVfbwKx1zbDgBkHhcV2Zu4MyjeB9Y/ogpuBQ2LLf75IoZzvLca3d2yPdYWDsMpzXaRN5FPDNMgGnU2rwgA6WZCDzdxctkdKV7dOR0Owq1T6hA8+E81zKSHcqOD6MN4RPSfWQx4fhLYS3O/3Z0ckvYr5ENL4yrkgnJwV4WB7jWNCeG8lgRSZDlOhqQ7AFGh2JdN4xUb0cpjISOerv1FRlIbddfbXbBxwmNiFdEjJuEEirMchx5DD/DXjQqjkYDz+5+5UGEkG+Loz3RcujkqokD7MsRAeeGgSqEwJrfoDB0hWGPZDKLCbhZK8vfMvcfEb2a/s1QOUStsQTE5gRRX9+tq+gSr3qvJx0D6cWc6oYfqBEcQUwS/9Zso2AsOBtGn63xfKd3i85StyBvU6RZvSJkHGNUSIbHKvoY8P5B5+yv/EhULD+DvN31GdFUv9CrO6wVZ3Q1Hfe+BqXG3wfwZy69H9LYmep4vW4I77xgbFvdWC4Nwy0ZIjgeHueM7yTh2Dz4v62fVE6oe4MR6/vMTFjRnIOSlfxvXZC3IL5g5YP2huCMB4Q2GXGpRu85zHJCBuUn4gzgE3mj4NiEq8adItQBWJc0OmbQfXndTfy0WQ1o1F9rWyoRXYxWHCoIFqISZFynNWa4cqrQEAqQt17YIy2tZo8WY+DTIuzpdO34Xs/YPpbh1hZ6DzrIVipnPpmlDlHsANCXDNOMMoH7OL0dJRPUVQtRLx/4Ypsn0DWmQgsxEmKPrmnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(40470700004)(86362001)(478600001)(7696005)(40460700003)(41300700001)(36860700001)(6666004)(5660300002)(82310400005)(2906002)(81166007)(47076005)(40480700001)(26005)(2616005)(426003)(83380400001)(1076003)(356005)(336012)(82740400003)(70206006)(8936002)(8676002)(4326008)(70586007)(54906003)(6916009)(36756003)(186003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:28.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43b7bb-22e8-4891-df70-08da770c618f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

In the DCN code, we can find some references to three different pipe
split policies but no clear description. This commit adds some
kernel-doc that explains more about these options and a little bit of
their impact.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f2accacae85b..07feb8551436 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -385,9 +385,31 @@ enum dcc_option {
 	DCC_HALF_REQ_DISALBE = 2,
 };
 
+/**
+ * enum pipe_split_policy - Pipe split strategy supported by DCN
+ *
+ * This enum is used to define the pipe split policy supported by DCN. By
+ * default, DC favors MPC_SPLIT_DYNAMIC.
+ */
 enum pipe_split_policy {
+	/**
+	 * @MPC_SPLIT_DYNAMIC: DC will automatically decide how to split the
+	 * pipe in order to bring the best trade-off between performance and
+	 * power consumption. This is the recommended option.
+	 */
 	MPC_SPLIT_DYNAMIC = 0,
+
+	/**
+	 * @MPC_SPLIT_DYNAMIC: Avoid pipe split, which means that DC will not
+	 * try any sort of split optimization.
+	 */
 	MPC_SPLIT_AVOID = 1,
+
+	/**
+	 * @MPC_SPLIT_DYNAMIC: With this option, DC will only try to optimize
+	 * the pipe utilization when using a single display; if the user
+	 * connects to a second display, DC will avoid pipe split.
+	 */
 	MPC_SPLIT_AVOID_MULT_DISP = 2,
 };
 
@@ -622,6 +644,14 @@ struct dc_state;
 struct resource_pool;
 struct dce_hwseq;
 
+/**
+ * struct dc_debug_options - DC debug struct
+ *
+ * This struct provides a simple mechanism for developers to change some
+ * configurations, enable/disable features, and activate extra debug options.
+ * This can be very handy to narrow down whether some specific feature is
+ * causing an issue or not.
+ */
 struct dc_debug_options {
 	bool native422_support;
 	bool disable_dsc;
@@ -641,6 +671,11 @@ struct dc_debug_options {
 	bool disable_stutter;
 	bool use_max_lb;
 	enum dcc_option disable_dcc;
+
+	/**
+	 * @pipe_split_policy: Define which pipe split policy is used by the
+	 * display core.
+	 */
 	enum pipe_split_policy pipe_split_policy;
 	bool force_single_disp_pipe_split;
 	bool voltage_align_fclk;
-- 
2.25.1

