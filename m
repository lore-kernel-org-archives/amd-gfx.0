Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC5CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51C410E7F2;
	Wed, 20 Aug 2025 20:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R4b9hgMd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1E010E7E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLGUinaEvWVxVE+i1CT0Fzc9oerirRyGAjtDxFwPj/u4j1e3a4l2Vp86o6oophnlCTBtdwRsvLoNdrVgbnRYwar1EuuTsTJAREnsA6ODPW7OLUMr25Ec4Sg25Zd8NyzzmwIZ3Z3xtasGBJUGQZ1GbiysdtQJuGEB85BF8551BL7HuDSrCsGZ1H6c3BeEWFmcNk93s1a7mP9WH0WTZtFWM4GVeeCqBqSrnAREu6Cgw4nVAGMzfydtigHJjtp3un9lBHjIlh3p+rb2JjwnLgcNKxaPV/I52vZac6Hj9cnBjtcBkW/xrf5puUxvBAdvYRBu1JgPORJHkz9OQKb9NrkhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdDAFQCSA92TOja2mw4kHegoLxo80/kpJYO/uAurMnw=;
 b=n7YvGCW1L0Ex4dJo/CBO8dR5MPq1JaagWpdBGwhayNwYM4zbqUTk2wkeGJP2SMm1WLdcE+4otFeTtn1XdI1P50l/xAn5NMs0uC5bUupJP1f+toy920vK3zL62zdcFE78o1T43O3mR5iy/sIniCvyVPoSyFoB+R4jGbDPuIxsV9A7/Uq57JMuQs3jS4pNTjwl9IRkgGWoeUO/rsHvI6hswjWnQlELovkTa7lR4ZLVHQV95Cc3LP/aBfdAaOcJ07QE8L6c/JE62OfflyfROmz6tm6Z9bEQ4C2+CrQCeT9f7zxcjIwfxkxQ0auGCQZPLV5eUpUvK/D+p2caI34ovZfzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdDAFQCSA92TOja2mw4kHegoLxo80/kpJYO/uAurMnw=;
 b=R4b9hgMdxQhpOugbFFjIRQbebry7rkhq122qxXdT1RUSsOUV+oVRSJ0meP0uC6bRsVWhapp0ykpI1VxLF7VTz2SnYOS4bde3jAzfnK4n2Do2XbCZxOq2T7E/IALWN7rYEYcWQl/t4ThlCSGcAZdXDT/+/M3qygrF2iXqDxwC544=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 20:21:14 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::a2) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:12 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>
Subject: [PATCH 12/12] drm/amd/display: DC v3.2.347
Date: Wed, 20 Aug 2025 16:20:02 -0400
Message-ID: <20250820202103.1122706-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6c9748-e177-4a4b-aa02-08dde0271c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zpXPQ4Sxoch/i79Z/4qdTHuAVK7ndOrJ7kh/4cJlRD4Thd+olShD63cPYEA?=
 =?us-ascii?Q?ZnW2Y1kZnjlBXsmvMUrOmDBXvUZDR18fSYvbziQmgEqohqlIfQF5U6EbE0Ft?=
 =?us-ascii?Q?ZfK1x4KQ2o5e1HXBA1v+y4J8UyKqMCFA54MzSEl1/EUAhZJ+pX84ljDipRGa?=
 =?us-ascii?Q?PAqNNkZr3vhbfeW14I7TthfQnCQxk2hDm66r7viiBhqCjElXIilHNZm8DvoP?=
 =?us-ascii?Q?egGQ2RYK3CQ1N7mxDI1Rn/eIzpJTX86P+0dkAmZqOE8rUIqSQtMbbU9xnhEo?=
 =?us-ascii?Q?7cNbUY+W2jKBDD2kRzJ3tx8HRWeIKBxRLr0evOCsR0xmwMGDNJDergpmWGv1?=
 =?us-ascii?Q?PjeMmVqJHSLMejNlfRoyBsrMANi5F3MlsXlergKg1bAPdRXW9eWA3kf1w4O6?=
 =?us-ascii?Q?BJSGNdh3m4Esvtn/nU0tXUR5ELhKYZokRXqeU7Ibx6vvDx5e5D0mf/506t5T?=
 =?us-ascii?Q?rEmKnvSb7JWKpw4Grn8yth7T49DeFBrYQ9Bw/HWLXXJ3on0in2XCIbFYXLu5?=
 =?us-ascii?Q?JSHMvNJ3ItOkrZSxyQw6mRtPmDYu6+F7c74eIijsV5JluJez1nyTkhhMqiJF?=
 =?us-ascii?Q?2NYGPEcQxDnSe2Zv+y30fOCQwDi71RDhpscmMdtuQqLeRm8WxfT2oqFfp8uL?=
 =?us-ascii?Q?OP4lSsVHh0E5v6NexFPReoDuZQkiGBye9z8grIzyMHPulWjxaqcfMZvJOj9X?=
 =?us-ascii?Q?UxXVi3HD01FG6Kx9QIek0LkXtYn49NRXPa0au30vHdhRDuFrqj6G+7hUuoK5?=
 =?us-ascii?Q?tEhYgr+q2EyQDmkEFD4gPDFvqsJteuCOLhaNCxtt9ZqiCR7Byd+9WdxHJ7rX?=
 =?us-ascii?Q?2JmyyqwPNrvFTpD1o5DiEi2issCE2XIiYVD5sD/IGViHAlltRGOKvngM7Xqg?=
 =?us-ascii?Q?CNgBBg+IaaMa+eEN4PwgcmiB2wvpFOrNA5rCX5/9C9K8iAm2DUrS1ilS2q7M?=
 =?us-ascii?Q?UOyyG+GIRIB66hu9DhxGrqiYPUD4LylqAaN04QOKBPlqkVHQVgYOduNpegCr?=
 =?us-ascii?Q?R0pyt6o1FaQGBozkBEL7kSLx6PPs3oeOEmmcFcaqT6vFrQQp75LbFeOKypWE?=
 =?us-ascii?Q?Jks/vqmLLtmjUMz1/SojRENGzxIJP4AUV68raVXDEujXDtyvs1Bv226J+OjQ?=
 =?us-ascii?Q?uA5Qt44Ceb8k8J6HPnAxUrvqiJbxlsadnVz3JdEnvYCd1VSU/a+HDEUUnJrP?=
 =?us-ascii?Q?hCcPh81e9vrPFLszSnsXhKnTMZ+vVZ4bqtC8QQbA5NQ9kdQdFXQEhge9O02N?=
 =?us-ascii?Q?H1MOQt7pncDAxuy0GEs1XYZMfjbWCgoGn042fRy8yi9YocogM0rwTUeU0Wq1?=
 =?us-ascii?Q?OLzlKIl0feIhJDSvLoX8kNuNTN8VfgysOEtsWN+FxbEQ5/Sc8ewRP59dNj/b?=
 =?us-ascii?Q?RzMawHvZK/ORvCM8WyIG5Ap+7VPOaihNsEBbNk8T7KO4J0GVPFbJpuACX2Bi?=
 =?us-ascii?Q?ayYdOIn8Cqsx8jf3QxmpFtLuupWlaeO5Ty2Ei4mhcmvl8sCw1Luws49MQEou?=
 =?us-ascii?Q?IjF1mWjO2grOXPlrDzbbQUHBQIL8RCmczLn2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:13.9197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c9748-e177-4a4b-aa02-08dde0271c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

From: Nicholas Carbones <ncarbone@amd.com>

DC Release v3.2.347

 * Firmware releases for multiple asics
 * CodeQL fixes
 * Fix for double cursor with 180 degree rotation on large resolutions
 * Misc bug fixes for DSC, PSR/Replay, DPIA etc.

Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviwed-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3431dee6389d..274ab744a331 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.346"
+#define DC_VER "3.2.347"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.50.1

