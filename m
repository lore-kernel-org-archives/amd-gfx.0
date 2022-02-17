Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33146C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 17:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDFE10E279;
	Thu, 17 Feb 2022 17:07:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87CA10E279
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 17:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKW3GXIVjTRo6+Zhh429llJl3ODSeulT2c39JrE4JxYpDpUYn2LFvGw3TPaqXg8rdJPL3UIxsvqyEQWNsYiYDRDBxiHk1kgLqJ9XLsid8RkhS/ZwGYCEWcLbN8eFIbXJkCYdCXMP/JCT/fl3N+re8zMwLRdgaZcG1K62jsD08dNuOXwNv7i/bYOtdvP3ilE15JET4LpVthZQl1cBz22O0XPmEvhfG9i+wlvXNBiEiWNFB+pP+bhHjUqOe43NoK7uiqvKfOsanQ54Xas1ezwnNZjifU/OVZN95Dnaat1NEM7hcP6INaEIJyCL+qxk1BFlj4PAnC1XVTWX8w6dUOIzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EB/RGe6FwbUXZrDoFtQLXRrJjfuLN7sr4hBwrnP8B4=;
 b=jGE8X62lS2Llt10StSV9aD1FxKDE0ibruZjLCHrRpmFEW/SgWwaIQEAgw9k7s+2HIsKUofX8PFbiHtBN6VpQa9ta8XcXY8G6hbcaDxvMfrv5pHlobLz1g7JLfOGwdxrXf8ZBXdDeJW+M3bwxsT6IRxZv4t05WWXKh0GIwyU/U/SW3EIarKiu+3+muYhfySPtB5ZApan0M2/ROCD4uj0r2qF4XdtQxUerR7EJgfAay9Zb5BK6JBkzDPcOWhVdEUt7AlNoono57Xcz+ZMiAwd4JzNPFPa4FCa00RKQM7V+6psNoMjsoaKAC6JgPCy2+2O/4C6E4dqEfvsO+LfC/+urdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EB/RGe6FwbUXZrDoFtQLXRrJjfuLN7sr4hBwrnP8B4=;
 b=zkm9wM6u9x2cwSuDibMp5SNSzN7YqfjNKeaw/Y7GJiYSn8ruvesdDh4zhf3uFxa+YwiWGowo9HZWsiXm9LHKrcN72HerUQ+2064VgfK8dAG4iaoMVZkIOnl6TDJvxurgslYTjAJVysM+G3Wrgc3bWqC0NyIlX3I27eH8K3y7j7o=
Received: from MWHPR04CA0045.namprd04.prod.outlook.com (2603:10b6:300:ee::31)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 17:07:03 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::7) by MWHPR04CA0045.outlook.office365.com
 (2603:10b6:300:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20 via Frontend
 Transport; Thu, 17 Feb 2022 17:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 17:07:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 11:07:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for nbio 7.3.0
Date: Thu, 17 Feb 2022 12:06:50 -0500
Message-ID: <20220217170650.298221-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ed7bb8-0279-4ad4-7d29-08d9f237eb29
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4101577BFE5BB40C5814D874F7369@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3US/j8xkesVYPfeLBMt1uuGUS1sJ+hyLPW1z8SfjHTMZKLT/+Lvi6SzkYGoO4zxU0ZbzELoARNBLJB0E2fk5NdlcFczHY1SBpYBGnHkA7m/hqfFNzw02EzOlvF03o9t9pZJKtjEgg/1k7rQF5/fXwyl+CQTXVrircnTtYAT2gQ8bPIUBzrloB1RNubwivDghHCczF7wqab7tPhr/+/YkgM4gYPzWGGClodqWxG8fSduV+/77gbe7adYW2e79lg8f6Sb/ArCq/4M/n7Wa7txdD73dBCPQd48w+O3sjIGry/OXXCvt7c3X09YWAVrMCqnoxk/sNlmainRi4J95gt/ET1fKd+YsNZDsBEdN2iNOlpyRd4kM1HAsbWJtWGwlspDUf92B11IPQwpwsDAilwOHJItES6IIkE8Kb0sDOjuxadgDq2Jp+URhB4mEZgGbUYZVnbqva/yrW7KgyN2jkm5EIA11BCwt29rQCh005FyVSXyJ2lqZKcsRZAVIJyKdjn1uM79aRVy7IvuWpoHOgRGHPFxCa4BabhmOTxPnpky55Nbf/tkI2it/j+lX+1qDjWuNavqzC726yqQqgbIGHvRbRD9VeclkFcLUgdffis9TkB+L2DX0p0utJVM83wISVZvxR7AK1MHh0EMbZM/vocJXpGc4Bi3NyWSxKr6vMLRmjxvZO39tdLo7E+e/gCYnG+xBoBy9tng1rzTxVmZiDoDzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(7696005)(508600001)(70586007)(356005)(70206006)(6666004)(316002)(81166007)(6916009)(54906003)(82310400004)(1076003)(86362001)(36860700001)(2906002)(16526019)(40460700003)(186003)(36756003)(26005)(8936002)(5660300002)(47076005)(2616005)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 17:07:02.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ed7bb8-0279-4ad4-7d29-08d9f237eb29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds support for nbio 7.3.0.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index da4541e6b23c..016c3dc4c303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1826,6 +1826,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 3, 0):
 	case IP_VERSION(7, 5, 0):
 	case IP_VERSION(7, 5, 1):
 		adev->nbio.funcs = &nbio_v7_2_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 44f17bbfeb6a..6f81de6f3cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -61,6 +61,7 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 3, 0):
 	case IP_VERSION(7, 5, 0):
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC);
 		break;
@@ -79,6 +80,7 @@ static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 {
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 3, 0):
 	case IP_VERSION(7, 5, 0):
 		if (enable)
 			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC,
@@ -262,6 +264,7 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 3, 0):
 	case IP_VERSION(7, 5, 0):
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
@@ -368,6 +371,7 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 	uint32_t def, data;
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 3, 0):
 	case IP_VERSION(7, 5, 0):
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3));
 		data = REG_SET_FIELD(data, BIF1_PCIE_MST_CTRL_3,
-- 
2.35.1

