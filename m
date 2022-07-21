Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC94C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0EA2BD7A;
	Thu, 21 Jul 2022 09:52:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72778BE3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpQuAbGqVPaTbOmqXczfRiI/mHg2hLHegKNi8PyvBKzKmF9Cvj5a5QzVVYcM2IV2gvCjdNT5QK1fCe+kqGxvTnvtkifcAKZcRIGjN7Ls2fj10iJAEoFki3i3D2OrgPkV8qsk0hZAuOyOhJhw5tb9Mc3jgFs4tI4714palUPdrL8HwC8nZh6m5bKLo3ENaZNeVvLVjZ7or47TIw5etKV0Qqv+yyTT2+ds1VqnEylx5DT/roP668CSTk/xD1YQ1kaiks3ZWjun7GdBZvmRCjl/4wNTyY0PUa7XE0LtqpESSztSCw+p8eD/SF1VwdIE7eTsYSx/fmUhaPu+9unyG6ayxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSBes/mlBrFI8gJjaMhi4DYCZKxwT763eLZa2nY7o14=;
 b=M478VxtWvLNBMfKLGGQazftthYXASNG0cQiFZBth0BlL3r+HGdyUORuTqasaIkZIpDyDkw0ZHtkOvVZafwXrzOSXn8xtqEMCb8BMNQiWD82BbgKYhU5/CJadjTHb/CFyEYIoXAmynwlpqSRSZRJsWb3iEaVtzf9MswYVOy5dsyM9cZs80E+Lx+covAn2a9XFXOOd1X69SrewSALaSOdS9rj6lgoluRLIBV3rvGGTiRBN49dnopBuDUKvgY4vXL2JvfOCFbWZH/SK+u5MkKIdJJlMjDmWpJy/Ea55gOHzY6+iU5sMVYr17ODlOnUvm9Ms1CizVGmG4bGLZy7uG/lnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSBes/mlBrFI8gJjaMhi4DYCZKxwT763eLZa2nY7o14=;
 b=crmcsjg9tvpCHqEZSxozz73ETj9lXyxyoP+C2s4BnDUojcKPjBmXE+xe7m1MCG32cbPtHMFvAlTd9Q32Zfz5YMaIGKRb932jPhRhizKMANFcx5X7SnR88Iy68/QGEGXx6CDauu1GN1be2mJS6JBUo6IWMblKWJbBr6p2fLGLyQw=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 09:52:22 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::60) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:21 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:17 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: add sriov nbio callback structure
Date: Thu, 21 Jul 2022 17:52:06 +0800
Message-ID: <20220721095210.37519-2-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a63800-c29e-484b-9f07-08da6afeb589
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsDjzAHqvfVDP7wSnCYCE9lf05NuEVFgOEJNSKZy+W1C1b9AZQRS1h0qYTWgcXylCqVgEEZoTYNinbobCMFb/JoaG9GDWmsNkp6h2si1w3HWk7wFz6IbXCifZpU+iqYBY3/xQxP4bS94NHDeGtCylNGPnT+mIA56kllFpV29KX/LoYmicFqNIu2O8dnBFi4e+YKABByLrE073f5smu5ykbMClTg3JUtk6Vr2Wo6cJs4oSSQnfcFoTR1EWKY+ChQ1QsJ1mNf8bx4X+de33822ZI/93wqk5D9HfU+zGR6zCjlPG97s2cndwcETRmbtIvGBr8AlVOH6PdXY0MMcq1kSKWinMNtHU60upucTh2ZXFJqzk4nCIcNdNBKyTW1hnE2oCZHc3CJjbYrH92Ga/hZDqA/IWQ/wyZlI3qdAK/S43X5kjeZUM/HrXV7ClMaiB3/ESmPd/4rlCUobbeJNdxjyNOwIg+5FPA4csZOpjRDqSbOHjFN3lAaYx/7ffm/ieJe62umtlp0T0lTTv5aDJhoG6c9lj5TnpNRuWqkQAT+HlH2vccVfRK+Eq0CFhImh8XFLxOU/K8YJXsEVco1OqQuRKEHS4bA+y8atlfKPhC40MpMVVBKIsbt0LAfrYDVOAwqlJ1uqCpY6IDewnCZzcyQJ3bN84Uu8JMm69zMRSPiu/d2aogfrkIATXS22tOfimccb1wqxZOuc+QsT/bGZXfOUVV5DJichu93XrT/J43tZATA+v0c+0FJkdT5ptXM28JzVtsX/wrfZTT36Dfhh5U7ytlv0FUbLF8h8ZPbPzu+o1fmOgbizbBpcNGV/Tx2xwCbg1hglVZwW285B7YRF2k6xwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(81166007)(83380400001)(1076003)(47076005)(6666004)(82740400003)(186003)(426003)(44832011)(336012)(41300700001)(2906002)(478600001)(36860700001)(40480700001)(26005)(2616005)(8936002)(4326008)(5660300002)(82310400005)(356005)(6916009)(86362001)(40460700003)(70586007)(54906003)(7696005)(8676002)(36756003)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:22.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a63800-c29e-484b-9f07-08da6afeb589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
under SR-IOV, the nbio doorbell range will be defined by PF. So VF
nbio doorbell range registers will be blocked. It will cause violation
if VF access those registers directly.

[How]
create an nbio_v4_3_sriov_funcs for sriov nbio_v4_3 initialization to
skip the setting for the doorbell range registers.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h        |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 242d1847c4aa..f559fda2811f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2232,7 +2232,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
2.25.1

