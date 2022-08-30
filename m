Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7222DECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA7210E389;
	Tue, 30 Aug 2022 18:40:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22DF10E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2HrFoUJB0FX8/XrjI4LxinHRj9dzSTXVoKOaKcdMzv9qXRYJgGq89RBh7Z+A9j+hCfKCYmJDADSlBVMaO+nSSn+PdmEJvQdUnDyHkjlzyfwuTbanZhE5fU6BrkudRZK4awE3IghGZBdR6THhrd8wlMMDKT76s1JvbeUhxlK/zMyKEgs4C7c9fQhXAtOqLXyGhj6ovNWBR4j1Pj9vwlIRm+JO6k2ktXrZ7IrfxaKkWNCse8raPhWJQoGsQAQNnPrl1IIK9ovNtFkk0/YojW3dGmf+49HYkQSm/IYNPdZWhfsik97c4Ig4z2v7qST5DUEsVAu62VZHq5N3yt5CnhaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs0rcqLebhqB/G63/HimAeS9vI1VXG7Gzm38wYKBzqs=;
 b=XUZkYBnzcUyUyS1242h580WfbewAqadz8xKGte/0D2Yz2Z6b6AhOzW697HE6Z98AkL4k5xKWDz2HrHCePSB16Ei5qRiuxaf4ZTPNOaJy6YpPjsJ1CAhg72uiFvMf57g/15+LjGBaPsHOXjcRy0lx331538gZHjh8u0Qji1Xk/W1QGk2OlUDdFm/jFtlXz2HjQ4YJ0iI2bf81GMTnK22id1tV/rEhYPaGkhhGPdLE5L1qHYUlADCBaD6bdIaAXoOZQhrt5WUaioPdvQjy2U34oSoOE96vA+iVAJFP2so2ZF2WEhmy3N3NaztIYq1z/8L0dyFzzOOTSU7yj1Xk7Hiyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs0rcqLebhqB/G63/HimAeS9vI1VXG7Gzm38wYKBzqs=;
 b=jy52HjL6EljQiaF14vuDrimE2tAlqfXEjJMOpTPTDXiKMHKnP7dvifpd//RFja033fHpysJtM1WRzUELlttKoUKrjHY6Rso+4KqS9b0i4E88kPMxUkrM+qS1uv63sqohGnUJ7VLsqyEvN8XKzWk1a+cYZubzBX1J+1lIxaLqEA4=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:40:27 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::82) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amdgpu: add sriov nbio callback structure
Date: Tue, 30 Aug 2022 14:39:55 -0400
Message-ID: <20220830184012.1825313-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b70aa9-52e9-4305-8ea2-08da8ab71bc4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1Td2aanPL/uxQ5jOK7mGQ5apGdRcRvFAKB0OZkAlUE8jyqsksK8RPWS8GPCF18CYS4Xow729a9q8HtQMbrwNPjGLwxjvPNf5Z3iLj3/oYPwyen9+BbhHvQtsKGLKq+GvPLc7D4qfgX5XLEdYx+Htb2PNkkN4f6oIhJy2lKvnwq3maqy0PCGR9yJVNL6qS737MMeCWyTGepgz+LWF/OgTDe0q4vWxIkZ3bckLSQemLeOtsPQwjkLDQ3Y8RzXD12klIJbfbpmNEYegTyBW6zkkRWbNFYXAGCDHsosTLwMbrZY8vGzAAEp+QqIK1CsqkMpR3rPLTjqHVztDuL86H8Xf30zt/udN+dmZh089UL/k65mePhtFG4jsmowKQeRwFgAuKDdRZXZIgFpgt/a7yFraljecdLQkM29j2xM/dduDssWqBgA8kiQGMXrqipJL5AaRFuNZlBl9wfYMagJcS3v43ep2Srw77UFtGo+1ytF8SfGIuY38yBKEAb46n4CtL8rOB4JVykKDYqD8wWAewW2nv7gtZr/UJImZHVJMXFVx2vRiLhxmh48MjfX0pl6bq+SaSEeKWIDDe0OhbljBKNTqe02FmqsNnVNh0gAHBoDoY72KpLRCq0fyCQ1QcKdWPz1T3Ck+52It6XBHHIanRzIHUF5HdpwecYpzUC1wA3qBYgZfkW+e/WjV53431koNLJsEobHjfrcdPx//4yPEzmRX7g6LRMxk8+Lb+QNM7W8zWAO5FM9LKrDUpV5NSo1TxpBkIkwh+PlzKZobGuNgOr/Smf5rSGhVVFCigNswm6nyZj450EgBv6KzxKRJnG8MJJn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(40470700004)(70586007)(4326008)(478600001)(316002)(6916009)(54906003)(82310400005)(40480700001)(2906002)(40460700003)(5660300002)(8936002)(81166007)(8676002)(70206006)(356005)(82740400003)(86362001)(36756003)(1076003)(336012)(16526019)(7696005)(26005)(426003)(2616005)(186003)(47076005)(6666004)(41300700001)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:27.4923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b70aa9-52e9-4305-8ea2-08da8ab71bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

[Why]
under SR-IOV, the nbio doorbell range will be defined by PF. So VF
nbio doorbell range registers will be blocked. It will cause violation
if VF access those registers directly.

[How]
create an nbio_v4_3_sriov_funcs for sriov nbio_v4_3 initialization to
skip the setting for the doorbell range registers.

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h        |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5fd56ebc3f6c..854ca8d4505b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2242,7 +2242,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(4, 3, 0):
 	case IP_VERSION(4, 3, 1):
-		adev->nbio.funcs = &nbio_v4_3_funcs;
+		if (amdgpu_sriov_vf(adev))
+			adev->nbio.funcs = &nbio_v4_3_sriov_funcs;
+		else
+			adev->nbio.funcs = &nbio_v4_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
 		break;
 	case IP_VERSION(7, 7, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 982a89f841d5..15eb3658d70e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -488,3 +488,47 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
 	.program_aspm = nbio_v4_3_program_aspm,
 };
+
+
+static void nbio_v4_3_sriov_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{
+}
+
+static void nbio_v4_3_sriov_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
+					  bool use_doorbell, int doorbell_index,
+					  int doorbell_size)
+{
+}
+
+static void nbio_v4_3_sriov_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
+					 int doorbell_index, int instance)
+{
+}
+
+static void nbio_v4_3_sriov_gc_doorbell_init(struct amdgpu_device *adev)
+{
+}
+
+const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs = {
+	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v4_3_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v4_3_get_pcie_data_offset,
+	.get_rev_id = nbio_v4_3_get_rev_id,
+	.mc_access_enable = nbio_v4_3_mc_access_enable,
+	.get_memsize = nbio_v4_3_get_memsize,
+	.sdma_doorbell_range = nbio_v4_3_sriov_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v4_3_sriov_vcn_doorbell_range,
+	.gc_doorbell_init = nbio_v4_3_sriov_gc_doorbell_init,
+	.enable_doorbell_aperture = nbio_v4_3_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v4_3_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v4_3_sriov_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v4_3_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v4_3_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v4_3_get_clockgating_state,
+	.ih_control = nbio_v4_3_ih_control,
+	.init_registers = nbio_v4_3_init_registers,
+	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
+	.get_rom_offset = nbio_v4_3_get_rom_offset,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
index ade43661d7a9..711999ceedf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
@@ -28,5 +28,6 @@
 
 extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v4_3_funcs;
+extern const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs;
 
 #endif
-- 
2.37.1

