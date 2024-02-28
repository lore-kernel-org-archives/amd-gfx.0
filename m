Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7BBC5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 04:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23AF10E8B1;
	Wed, 28 Feb 2024 04:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlToexQD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1416310E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 04:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/uA+7cXOFCs/+Z0z/3mbPVsINewF4wp8FxOs3pqCQraAIeEno6wP4oe9AfoqhvXHmw//9O3rrQAZzRoYEQl/IDlV6DY7K2RlxERxo9eqQlxdXIQ05S2JBiu6RPbUCh/xQxadvMJSz9dX2c617BPTGjWFPYHDPe7DZaSiyoHzZrIIV2Lg9qKNj0c0OIjscRjDvkwJL/ZpT79uydWfQ8PMN2iK1/uSFlB32ObJts33KaeJxUqfGGL7+mkPINl5p8UcBy258x/F4XfA652vvXdiDAFRSVl7JRRrydDo9anc5NJpG9cnJLFqU4zWXwHSyqGktgE+J7tkLRh1h+HZ0g8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9T4mOqcny40gFuZ10q4a0WHKfDOh/LaCsEUL4bTSsg=;
 b=kwop7NArO0hOQq424O4l6UB2BgGRac/2jgEOXWecX0YY36L/OzEAfQq9Bgw3CC0bQeLjUjhs7hIiyXpNFAOw1f0fVDOFVDRRNsOU7WC9U8xLNO2ngNNLZmnIeosUysnDJleyN5hmx+LehDrm7p7HR8ANjcaMcg0eyCr+SfuVdt7mtU4EbLPJ/dGnFyy8SsXtuc9+5a/oXMU761oyFWsgEPyW0BRoRL8U/8FEF+vkFj+ivdpyNlzIjEfJQGKa/zCWORHhuZCX9EvdotCwowQ/aERuCCvZAEXwCTx135b3HZ6qsi3bce/40PLk7mltPXFIx8PtEK6dMOzahmlDyqToBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9T4mOqcny40gFuZ10q4a0WHKfDOh/LaCsEUL4bTSsg=;
 b=GlToexQDInVFQmCJf2JbxzeqhTMz2nvwQ7cZ2GXFAV+Rg0nz0X5+NCgIApMNT40yW8PwLHojlg1SmC3j5WwpbFr217Lo7Kb0jSrqC0ICit2oWuOFR1H3cTA0bliN+gE57TYzVg/1v6h0Yp81sY3GK2L7i/VzbpRf70kvS8J9yp0=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 04:01:14 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::e2) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 04:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 04:01:14 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 22:01:11 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Skip reporting pcie width/speed on vfs
Date: Wed, 28 Feb 2024 12:00:50 +0800
Message-ID: <20240228040050.2100853-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2967c96b-ea85-40dd-a6d3-08dc3811e83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TC3yEl+34eEGeTWOy0VjzewXbDWW41hBFc5qwDYPWGkalpE7RdSA8opoKfPaW1x0oQkPFO/bBecMHsIG0LPYqxDsBHmN7WTwcw6xaeq6zclPtjuAMOxYtdwHDix0wIDRDjKVXxaz9JmM5GXnF6BrCok2NJx5lbdVE4Io/lRmRYvJ3e/mpItdNR7hFawnziQuXb+yxJEMOg84J5QLtXo33IgrDfDCNUfPYUdJqx/ME9phFv+CWAeaD+rrcnSu7or+CkCTh18qyRECsSR4PQkzFDNKVBli849q2eu4meqB6lVSoGlaXO/u4Ro1mYwPrSQLQab2FU6My6lDSAryP31Rp2+/hw/u491CvJN5TgJL1K9rRPySojJHQ7P0sx9W5z5Ut7LWjEKUayfQQJ6iVVNG5Mozz2L1JkPCRTc4ofVQHxjHNnnOVKtuWXYr/ShKOhGDhXeOVXi6cR6cHoxdaDgfahnf+7q7HgN4ByWM/bqW0WRMl1XCPfbe0h1qI3v2O/3cXNt4ybm0TKcq1vCiNXtzzm2pSs2EHTOMyVfx62w9AL5I3KEjusvGYrOkWCtD2ih2s3N8giovsOwZA3eyhq/6/C/7iNB2sl57GV4rQbtQBJaN2kGwr+sbFJte/iYuGZXsRtmsZkOx+14GI6g3DjHoLbCTUGD1nG3kkcFUxaPo4uTGpiea7YodEq+sd1nNp8TJr5vNkffubX5MqPKFMkAH5jtC/PcJE0+IUvpQz4y1zmCgebIxnJQ/6wqb4KmcmL7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:01:14.0849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2967c96b-ea85-40dd-a6d3-08dc3811e83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Skip reporting pcie link width/speed on vfs for
smu_v13_0_6 & smu_v13_0_2

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f1440869d1ce..f122ef49106c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1747,10 +1747,12 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = 0;
 
-	gpu_metrics->pcie_link_width =
-		smu_v13_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-		aldebaran_get_current_pcie_link_speed(smu);
+	if (!amdgpu_sriov_vf(smu->adev)) {
+		gpu_metrics->pcie_link_width =
+			smu_v13_0_get_current_pcie_link_width(smu);
+		gpu_metrics->pcie_link_speed =
+			aldebaran_get_current_pcie_link_speed(smu);
+	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2b7a60b23d6b..69c64bc6e2dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2229,14 +2229,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
-		if (link_width_level > MAX_LINK_WIDTH)
-			link_width_level = 0;
-
-		gpu_metrics->pcie_link_width =
-			DECODE_LANE_WIDTH(link_width_level);
-		gpu_metrics->pcie_link_speed =
-			smu_v13_0_6_get_current_pcie_link_speed(smu);
+		if (!amdgpu_sriov_vf(adev)) {
+			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
+			if (link_width_level > MAX_LINK_WIDTH)
+				link_width_level = 0;
+
+			gpu_metrics->pcie_link_width =
+				DECODE_LANE_WIDTH(link_width_level);
+			gpu_metrics->pcie_link_speed =
+				smu_v13_0_6_get_current_pcie_link_speed(smu);
+		}
 		gpu_metrics->pcie_bandwidth_acc =
 				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-- 
2.42.0

