Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBAE95A60
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 08:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F2989E2A;
	Sat,  7 Oct 2023 08:54:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2243189E2A
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 08:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l72fnFWZF4S1JBLfmpyCL+6X7W7KLstQelH/33etblf6qu3PkMJFiUg2xNJck32MxOBilsUTg0uY0s0ZMkQMsLyCaGlQQjcmZru1AiGgOMI7waVyxYs4OLOrWb7fCYHI14rD+SwoSY9FDzkt2ztNk9C8cnqNMQ0BMU9hk65g5642eIzGG0c52Ikc6okrWekRGzAq7lf068bTHNn2gtplpFVsi4a9Mzzspi7QnVvvLdzi7FeQ5MKv6zsfOt3timsckF1STIDZ40Fuink3AVvySBu6RT74T2Pcl9Sajnll0ybVkyz0OEBXdyk5gvGHwh95vTmPw0one6uWTSeqPaxniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqC5jTNRPoTYP2QxpXG2AX93/2D6+8qERn0f91Ahb08=;
 b=Pf6el/Qns+w69//2i5atByJn6MP3xNbU2D1BYvpZGcrzQQ7Ck13+rszfoXW1tAQYxZp9mm7m9jPOQ7ZK5U2Y7o5l8ntArp6A3k25fjOPDShQbXrrOhd0BRkjxmVwHXMMkLb3z5TFjsbFXJk9Pw4zls2/rW7sIhfMgmYO5OkfC2LuFWZb1dQ/QEPkofCfj8PgJcA4JZD2qRV949JtxaTAuaUduzGmXOmUbgqz/kGEtni0flKYcJVaQ9SUPu7ewNpIW/g29uD1y8FqZFmCpyr65Vr8sxdApV12gAvOyWFU9oXGytKJ+ho6u8mR8VPPuCWkrtPf/xkhD6+C5sNr4gFTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqC5jTNRPoTYP2QxpXG2AX93/2D6+8qERn0f91Ahb08=;
 b=S6Qy4uIp++/pqdpCbLwXXtJrxE+gFRgmRwKT2kWZybFXqcEYFNycnWJ4nLUpzOAw7PM7ulLSmTJ9F3C2nJmuNY1j3WqvQh1KapxouqwqmjmOkv3HvVF+ZJr/zIGFq69pCAuuqkSQIWi35Wnx3/quPt7JcEIosXKI/ft2ByuL2nU=
Received: from DM6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:5:15b::16)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sat, 7 Oct
 2023 08:54:22 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::2a) by DM6PR18CA0003.outlook.office365.com
 (2603:10b6:5:15b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Sat, 7 Oct 2023 08:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 08:54:21 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 7 Oct
 2023 03:54:19 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/umsch: enable doorbell for umsch
Date: Sat, 7 Oct 2023 16:54:02 +0800
Message-ID: <20231007085402.67350-3-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007085402.67350-1-Lang.Yu@amd.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 68601e4c-acee-4188-e408-08dbc712ffee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LTWu2BA9tpLY07X9artpoI85Sdk0sr//NonGnlYb914JwhxyXUPcGxuVLO3ZpV79bhO+lAi9IeOJBOOFj9gHVkD5xXQiEB7BkId+jSYN44MA885TeZfiTK+Bbbs/xM9aSwtsOYDd2ppSSjUXjUnQLYgGDR3TAfKKRiYwkja5ilj+yktEkP9ik7qRAFb525IZ/dxmDpGyeOnGPS93hxIlaJT1KmrTvFlDeaC8kbjMKGbymzw/0G3+uS5qWG1YExFvhYbhxN/rvf9k6klzaS/vZ8i7CaNXz7aVMBYa0VV88TqPS3JmskFJl7CaCN02xQPwFq7wjhfXJoJJ5VF7tJoe+qourb41x7NagrIlyuuEpoUlXdXlIL2Hz9fzYOmgIsP0zvMl1OlbHLnnJtCo+EMcsPToPWZYr/S+u7fLucEOGCIoiUuIOAwk1UEQOxlVP5aXpev7wxf+GbapkRF/J9lKmNLTBkWPtrZIYrqov4fmWovsSRgkkSU4XgguTeDxHSvBauQQ7u9aNmTaSwOZjU3OWsB+/0Y22hsWgLJGWTfn/T+MHTwt9DgjGwawBUZB3Mx4DV30xtj9oHRw0trmliXwPs/fsiS8EyLoTlVtriohDczZd9uukAh5VZIPYCnzC+wXSYQi1Z0aVRmP0/bmnL8RX875BrEdsy8+gnY6RJzF/QXbfoP+/KztNd433gbkbG3j5br1lgINujzCBf44ctKsj/Z/sIgsibEhc+Y/nFNQho5RH5IJ3H7dyCsFZ3Lt64nL9TnjhsUSp6Z1SDEbtvk0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(47076005)(40460700003)(316002)(41300700001)(2616005)(70586007)(40480700001)(82740400003)(2906002)(83380400001)(54906003)(6916009)(356005)(8676002)(7696005)(6666004)(8936002)(81166007)(5660300002)(4326008)(36756003)(26005)(16526019)(336012)(86362001)(70206006)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:54:21.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68601e4c-acee-4188-e408-08dbc712ffee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Program vcn_doorbell_range with vcn_ring0_1.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 9d89c4186989..4bd076e9e367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -554,7 +554,7 @@ int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch)
 	struct amdgpu_ring *ring = &umsch->ring;
 
 	ring->vm_hub = AMDGPU_MMHUB0(0);
-	ring->use_doorbell = 0;
+	ring->use_doorbell = true;
 	ring->no_scheduler = true;
 	ring->doorbell_index = (AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1) + 6;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 7e79954c833b..17c73aaa1e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -217,7 +217,8 @@ static int umsch_mm_v4_0_ring_start(struct amdgpu_umsch_mm *umsch)
 	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 1);
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
 
-	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell, ring->doorbell_index, 0);
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-- 
2.25.1

