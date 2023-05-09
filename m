Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C81FC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076AE10E400;
	Tue,  9 May 2023 22:08:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB5210E3F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj87rA5qQMO77/jsM92dAxLLWlFy7HLJ9tZQDOqkEMHG4BaIJ6TK2G/2esm9qZteJtGyyAV1IlLr/PJatXAklIokWLOyP681bUnpkSuKwwjLCNJEbPCNdHvJ3ZCElJGv3oi4kjCFtsVxn7O2aexGTApCmjdRGcxLWC1SNWK7zvJPelvhxg950Wr6O/bNiWyiKfSf0uHgsDvm1cq72Esda3VLbkSQIpIvWU298XWSFSMh7BTcieYCAihZsCMw7aihpMxEdxE+EBAcEQgqYxGqVzQG0dohBey5g4KvwrA07ZEVzSWqr1g/9JaGu59BdBpB1jl2M98puR0oO8eB/f7OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m1gRQebX1uaFk1ufQ5TaTX038o4mASBbtU2uSjbIkc=;
 b=YZh7BY3vofQ+GKGOFROmMaUP8UfrHduQ34MsfoaiVGqUkaqb1TyRNCVDKtF2KiKxozqiMc8uF/IgiqXlQCW1oEE/fgnh/ydVJp3x8KEaTNTB2vhYDe0R7OqN5Que5kCw0WCnig+ZZrn6R9hs+/96X3dLrULvxQ0ZsImGXPgI9XUpWtNaxWbM4F74hkJJBTkju5sNGhWmZzqkB2eQ7ZvI8LDYsZeGaezPnDgtvZclNzbXfzhP1EoSwwwG9QKCBoUBQ9ut6OyqS0qIgHy+wNBunCWclaQWCqYVVtdJcT2w/GxhKP+IOEQi8xf7tihktG/5k9x1biQv25UA5RkuPlFbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m1gRQebX1uaFk1ufQ5TaTX038o4mASBbtU2uSjbIkc=;
 b=g83ul5K3J/D4p9nD/BY8KtzOM3tGhgLopHhL487IvTuRGSxxEE+ExVVgIYVHxWpC6O2s1wLe0nguAlSgLZnrm1786mtEN8wKBSG2kBXJCHAyvj12SbQIpeq7yijwVYmARieI/aCoJ43HqAa+osleKkrMW462D58lsGDxqRR2T8g=
Received: from BN8PR15CA0035.namprd15.prod.outlook.com (2603:10b6:408:c0::48)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:08:34 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::61) by BN8PR15CA0035.outlook.office365.com
 (2603:10b6:408:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:08:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Use transient mode during xcp switch
Date: Tue, 9 May 2023 18:08:16 -0400
Message-ID: <20230509220818.475582-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220818.475582-1-alexander.deucher@amd.com>
References: <20230509220818.475582-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: af8a566a-fa18-456b-e31b-08db50d9eea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L35Y58hRLP45J/9Y0U/3p+X8584s90QMXDOtZF65bbUKbxNWzN1mYnEmHlSbaoYA0mBnTbmEUTGGQkZs1CC9C5aPisPdbRa3aR3J0bz7QCEYiWmH1u+j3gmZupqjPuS7C9ZURcEDObxP4xFEMAmEXvvpiqSSLi5LEcfAUjJCbACSv0OG2e5pkxFgkTttwemNl3N7PlyWVooK8zwHCIFkKSJt97on+aKcYa+CG+cr5eE+ELMUisTy8P2zlwfkCbJmnXeJfUSAlGm/owymNdRxPlDXoahG9bBf33h4XpUZqagcJcb4PxwlbhbEFP8WC9fv23u1a0R7sxC0GjHY119QHizoIjynJQIHHIXFdY9L8sy4hW7c5mDLu1yI6Rrm4c5Czc4kHy9bZTLZnmok/072skHcyO/RrMK3b3PDYhToMejWcIUiO9b1OZ84fWi8gWkvJOo4gxqqyKlH+bSyBxeuKDoSXQagY4ewH33BD5EGU+hw3Zmcrn5Xt5Turrlv8O91aDU0iUo8qwPu8s0rFUPp79NK9CjuAL/TP2bnRd2gQNvhpOCTt1pUvG4JViuL4LYeH6YqanWc4Y0rIw2QJb3TOyEZWdJZFVN2O3FgLuTM9xaWEnf+hZmgQmI6spZ2S42iYEiSPQxm6DFfc2AfnO8zFoYeNIsKgmwywU+Shv0NaximjzPv90RYanl0pwri+KgQIxvDDZc7ESw9XB8b3QQ+MJiPd7jgjkBoV1sMesIksYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(82310400005)(36860700001)(5660300002)(36756003)(4326008)(316002)(41300700001)(8936002)(8676002)(6916009)(478600001)(70206006)(70586007)(6666004)(40460700003)(54906003)(86362001)(82740400003)(47076005)(40480700001)(1076003)(83380400001)(7696005)(2616005)(336012)(426003)(186003)(16526019)(26005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:08:34.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a566a-fa18-456b-e31b-08db50d9eea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

During partition switch, keep the state as transient mode. Fetch the
latest state if switch fails.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 18 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 5b999e5334bb..e8aa4d6c6b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -139,7 +139,7 @@ static int __amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps)
 
 int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 {
-	int ret, num_xcps = 0;
+	int ret, curr_mode, num_xcps = 0;
 
 	if (!xcp_mgr || mode == AMDGPU_XCP_MODE_NONE)
 		return -EINVAL;
@@ -152,10 +152,22 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 
 	mutex_lock(&xcp_mgr->xcp_lock);
 
+	curr_mode = xcp_mgr->mode;
+	/* State set to transient mode */
+	xcp_mgr->mode = AMDGPU_XCP_MODE_TRANS;
+
 	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps);
 
-	if (ret)
+	if (ret) {
+		/* Failed, get whatever mode it's at now */
+		if (xcp_mgr->funcs->query_partition_mode)
+			xcp_mgr->mode = amdgpu_xcp_query_partition_mode(
+				xcp_mgr, AMDGPU_XCP_FL_LOCKED);
+		else
+			xcp_mgr->mode = curr_mode;
+
 		goto out;
+	}
 
 	if (!num_xcps || num_xcps > MAX_XCP) {
 		ret = -EINVAL;
@@ -183,7 +195,7 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	if (!(flags & AMDGPU_XCP_FL_LOCKED))
 		mutex_lock(&xcp_mgr->xcp_lock);
 	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
-	if (mode != xcp_mgr->mode)
+	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode)
 		dev_WARN(
 			xcp_mgr->adev->dev,
 			"Cached partition mode %d not matching with device mode %d",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 9fa6f0ea2061..1d3dc7d68f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -29,6 +29,7 @@
 #define MAX_XCP 8
 
 #define AMDGPU_XCP_MODE_NONE -1
+#define AMDGPU_XCP_MODE_TRANS -2
 
 #define AMDGPU_XCP_FL_NONE 0
 #define AMDGPU_XCP_FL_LOCKED (1 << 0)
-- 
2.40.1

