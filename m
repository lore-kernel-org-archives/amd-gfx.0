Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C741DC7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1999210E3EC;
	Tue,  9 May 2023 22:14:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D9E10E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSVXQPhGwF1gpile4dYwZNyvNKqM0D8UcUEQphsyV+GnO9n61PtVCABcQ7I8O+/xs7ADQVFMNVzJN6OymnyeZDd4zmbazXpB3NPbV38KIDPyQ6RXhAe3RODTjChSmR+B4wqgcIf08qdqEVQlHm2Z1JNk2dCuqJyCxk09ZxDOMI/1D8Fajb5iIvMH5bGskct3OwnKk95/Z94E/qxhJKSSpzI8Q8BvStjoOftOc91hppMjv+ZAfgbPj9bQ6OO5ixgRsCC4bQMViRpTROS27IiGcSVaPv2d9GvO3chtKjzvGlqf0BSThMFeYO6qA6AlCeXQxO0sGVVHONY3bB+1Sb6DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tddxDUWqWLU+hEUwHwHDe7dM6rcMe2O5Jz75JljJiyQ=;
 b=U5qJeR3eBKdkCGqLVyaqCHwVTIIFf1tKKy5KWXicKfGFucjn0vAQ154PysR3dcauYNQl5smNBoqkDUE4AKtnuDUzcooCy8l0szbS6DC4iI3CPUlmXSI2b5FavwPDAEQs1rvRqE7H33mNwHecedibAPwiK1VOIRAR9WIPdhM6tKlEgNAgYW83PsYCyrPEKReXsGR3Gf267ghICuWgejBLgZiYf5qLxZ3ZM9XYZMS18iCsYZp+nWrcYk4r8fvRwdsM+sRfsb/SXgymXNzNIRr5cDXCwUVPTKbzHmrjB/8OFhGQyiWzcXJv5JzBLBSpogCbUHi/Z3sW+nGNaR3xXLztyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tddxDUWqWLU+hEUwHwHDe7dM6rcMe2O5Jz75JljJiyQ=;
 b=42HkzeGbWW6O2kDl7Qz00ALg7FWgjhtT2EQCY3ix7aojrjT2KIkO8WvNccKnUKf9Jszg3qpxV8zOUtl0P0DFiWx5UdW9NlrhxNb60pcAwoIisBAQKqnL2miAR+/zO1RUMHk6oFwJU795QJ7rL5W63ZtKmyr/Yz/LXVPZmd3+KBU=
Received: from BN0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:e7::7)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:22 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::25) by BN0PR03CA0032.outlook.office365.com
 (2603:10b6:408:e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amdgpu: Add utility functions for xcp
Date: Tue, 9 May 2023 18:13:55 -0400
Message-ID: <20230509221408.476829-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d31ca93-3387-4574-46ba-08db50dabe22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jgikbeWu7pu3j1FNSVq3Ba9sLbRSb2aAUJw1YAyE3u/ID56KHD+7uJqHsr98sO0TR8AYYlhSfxmx498MzMaxvUg0qepaTeSSJtrSpUusW0oa8IqLJGYw6ovL5lzbQyDqxfjmCVjpfMsnxs+n9CJs3Cm7xKRtNWwO5uiFHmv5OSzRKZLIWQ+agKLH1NRI8h6Ujtev4EhCRg4CG3j7+FmAdi1CYjwOWQgb2Y7/ZP0V/EGtvtWy/8rgvGJEGbFsvBo/4nxUrj1jjxakslQoIp3IY0cC+VYocpWovuzRmzur6Io3KX7GphvArQm9HKtIUHHAsA5lSSaYSBX8NH5vzzjdQUEA93SLJDRSq68PCxzh+M7AychSZhO4eRUiRlYsn0MTDgY2Ywp8/p5gTn6XbnJYFIXoziymcposMItYYFvr/D+KlpJmTjKR3oPFtPiYSwaufVyrQkZx4KNbzS9lim5jzjuhuTxmVgHw1X4n9NllWQkGg/Sb5Cl0Huq1vXHvp5tvexGRhwszMaLyb2CKE0F+zWTJmRVRYfzYlM8IN3iYQb6jn/gyapOhmOdIgQWZUyxLeXfTuV+hzf9ZKuZdDuDfzvyqa/tXGGC1HGz6arTwkJqbYLA0gevRB73eLvV0xMu3b8SanVzoW90Cdc38WiEmup17G0k1jmRIDd9PBfmszZH8mijXYNS48UxVkN/iABA5zAAlGhDwINbhNpGvbK+svDGCMfBfZbYwnkcoLz2niM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(4326008)(2906002)(6916009)(70206006)(426003)(336012)(86362001)(2616005)(82310400005)(5660300002)(8676002)(8936002)(40460700003)(40480700001)(70586007)(41300700001)(478600001)(6666004)(54906003)(316002)(82740400003)(186003)(16526019)(81166007)(26005)(1076003)(356005)(36860700001)(83380400001)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:22.5754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d31ca93-3387-4574-46ba-08db50dabe22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add utility functions to get details of xcp and iterate through
available xcps.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 12 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 31 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index e8aa4d6c6b62..337d558a3145 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -256,3 +256,15 @@ int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	return id_mask;
 }
+
+int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
+				enum AMDGPU_XCP_IP_BLOCK ip,
+				uint32_t *inst_mask)
+{
+	if (!xcp->valid || !inst_mask || !(xcp->ip[ip].valid))
+		return -EINVAL;
+
+	*inst_mask = xcp->ip[ip].inst_mask;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 1d3dc7d68f54..45d590d7fd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -108,4 +108,35 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
 			     enum AMDGPU_XCP_IP_BLOCK ip, int instance);
 
+int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
+				enum AMDGPU_XCP_IP_BLOCK ip,
+				uint32_t *inst_mask);
+
+static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	if (!xcp_mgr)
+		return 1;
+	else
+		return xcp_mgr->num_xcps;
+}
+
+static inline struct amdgpu_xcp *
+amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
+{
+	if (!xcp_mgr)
+		return NULL;
+
+	while (*from < MAX_XCP) {
+		if (xcp_mgr->xcp[*from].valid)
+			return &xcp_mgr->xcp[*from];
+		++(*from);
+	}
+
+	return NULL;
+}
+
+#define for_each_xcp(xcp_mgr, xcp, i)                            \
+	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
+	     xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
+
 #endif
-- 
2.40.1

