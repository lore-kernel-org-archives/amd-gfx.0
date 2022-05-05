Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456FAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E455F10E443;
	Thu,  5 May 2022 20:04:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59E710E443
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5kdUUYIYwmDkr8M/7xia0rB3VnQgVTfXHykfLGh+KfpJ0D36IQgiKpdbNax9zCHhqsOmMBIKi3oDFdT38ylAihBNY8WBsBxjnKchXBj9zoPIZqRxk9m4zqYlk4lbFdS2BeD3qIQiUQvZCDXdz2K+FBlxeyFxbxI5GsVkAI/etfiqAVuP58eDZ15RwAxxFOkavqTNuKAwGfKbnZt0fJO347VNJjNyyk6l5nMAdGTylsftT3cfKEAduGlQg48gKPRiu8ckl/mqp1h+DHZwlj1b4AIp+plI7zjLoUmzipx8hmrdFAlswNwMorAibibxpBEZkN2ufX/NH0AV5/rYz2+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp+paLMS/Krd6XmLugy1Zk5EmDyAOBefG/puhmx3Ev0=;
 b=dhmixX5vH9kxaR+lPRCfz+npkqVOSvipjEhGDZrxML67UBQMVN64/0qkDtERPlv8SmeDAFWkSDzUFH0tk3iMybhehpsJe9uPTb5PABP8NHmGCqBtwHPBA8JW0VPJIy4WOkZNLENIVDF8gD2ufE76nExOU5Z6aY6oZ3FqDAk8pwZFe284A1GuJJUO9DQAjwewd642blbE8FHNnXL3eqKW3QvRCbKhHuI+GL+4rxTPLVzq9UXmOGYIuhhd4RKJ1BnINJFNc7xrtsjOelJ77ozgXdNZroDDkT2PYjYpKKo2vATQJy8NHrFJ+I2CA5boKS9uKfL8isPIACn4qXbuqtCJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp+paLMS/Krd6XmLugy1Zk5EmDyAOBefG/puhmx3Ev0=;
 b=cKijazJTlkzkMpSj1V7EOsuNT1O++Ix1tguc0Mowt0FtG5G1NqdkiLioCCDL55Q7flyrfxgw66SUz3RUwUXD37yOYPQqkQ5xEUBISjOXTj24l1lZGYQKGfuAOaJ4OUWSwxe6/SgERRqBjngaqJxURbMu6k4Li9OjWuqc+LZIXnU=
Received: from DM5PR08CA0049.namprd08.prod.outlook.com (2603:10b6:4:60::38) by
 MN2PR12MB3358.namprd12.prod.outlook.com (2603:10b6:208:d2::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Thu, 5 May 2022 20:04:28 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::1c) by DM5PR08CA0049.outlook.office365.com
 (2603:10b6:4:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 20:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: support memory power gating for lsdma
Date: Thu, 5 May 2022 16:04:05 -0400
Message-ID: <20220505200406.1293467-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b26f03-7f4c-4014-ecaa-08da2ed27618
X-MS-TrafficTypeDiagnostic: MN2PR12MB3358:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33583910FE568D1859AFC01EF7C29@MN2PR12MB3358.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxwAxxIBy0zHERPuVpUe/6dmGMHRQW7S0FdzuvJKOJGDt1VKBngKofKeBvaONR87MOzWOYHeyz0gPPKeVOiVfcLGLN/6OaCvZFsUaMaSXEHYRiFt53aFvF5ddrhhiZ4mkLxprQyOGEg8LVVHSQvgk5rItHjke8eXwU/9JTCe+lCmUz1czbpJvJQS2QYRpyP4AX/TdO2q0Fe3ACz9U3K2elS4Jp1Jc0RzPgSnEH9EEXemPY0RkGdbvPJBMDiaKCG1R5NVUe0NU6rkiwEIRJYnfXg0ReQIJvJa0KQZjTUj8nglrdmaspXoW1zWMW49jc0sLM1AzEXbeGi4960GUuJPvLXJFhdheE4RdqaFDHS7MEfDCUwaTUBtR6/C6qebrq4eZuT6JfggxNE5Cu9MnlaUj0iU6yzVv4xIYjNNCYAFiFbxVgrZKX2vNqqaX1eVEjWEWxf7bPLEopdZfoGl4JGUesIZ9mQtlyAGwZ/ShUNgpM0i8ANMVbk06EIolviCdGOxtnX46O+LjEu47Ww5VNl5T3aDyyUPmVR4dBcIREJg4lyLBgMfm7B3uM63fpTuG0gAI7fGMZprXtP92BtlO1JL/Uk3VkVQ6PNWo9N2G+MARi9NDObEfCnuYENfOMjI3BC+/+IP3SVMrBGt8Ueab8EAS0LtjYl6VtlU8+U2rWeiRhmyGiW55jFUebUDGHbP5302sw3LjvHcnmiIE3bfhYA1Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(186003)(1076003)(2616005)(47076005)(426003)(16526019)(26005)(7696005)(6666004)(81166007)(356005)(86362001)(40460700003)(82310400005)(36860700001)(83380400001)(5660300002)(54906003)(508600001)(6916009)(316002)(70206006)(70586007)(8676002)(4326008)(8936002)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:28.4763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b26f03-7f4c-4014-ecaa-08da2ed27618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3358
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support memory power gating control for LSDMA.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc21.c        | 12 +++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 9a29f18407b8..7ec7598e7dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -34,6 +34,7 @@ struct amdgpu_lsdma_funcs
                     uint64_t dst_addr, uint64_t size);
 	int (*fill_mem)(struct amdgpu_device *adev, uint64_t dst_addr,
                     uint32_t data, uint64_t size);
+	void (*update_memory_power_gating)(struct amdgpu_device *adev, bool enable);
 };
 
 int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
index b4adb94a080b..1a285b531881 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -101,7 +101,21 @@ static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
 	return ret;
 }
 
+static void lsdma_v6_0_update_memory_power_gating(struct amdgpu_device *adev,
+						 bool enable)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL);
+	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
+
+	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, enable);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
+}
+
 const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
 	.copy_mem = lsdma_v6_0_copy_mem,
-	.fill_mem = lsdma_v6_0_fill_mem
+	.fill_mem = lsdma_v6_0_fill_mem,
+	.update_memory_power_gating = lsdma_v6_0_update_memory_power_gating
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 741ed3ba84d6..3303e02f85d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -676,7 +676,17 @@ static int soc21_common_set_clockgating_state(void *handle,
 static int soc21_common_set_powergating_state(void *handle,
 					   enum amd_powergating_state state)
 {
-	/* TODO */
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	switch (adev->ip_versions[LSDMA_HWIP][0]) {
+	case IP_VERSION(6, 0, 0):
+		adev->lsdma.funcs->update_memory_power_gating(adev,
+				state == AMD_PG_STATE_GATE);
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

