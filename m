Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B831C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C61A10EC55;
	Wed, 29 Mar 2023 20:26:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4EF10EC51
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfw0zVVGEBUKn0z+TWum88kugcXk05nuJRw3gHWwAspA+IhlGy+u2Yr+FDSzWKE9WD7VshIMXnSakz/Yv3tJiiCDjhmSU+mtZbDOxRL9Sqg9z8YoWURosW8ioxhgx7ZSJxtqlwAxP5QmRHYhA/b5Yua/lXBlxl/dGs0oN+boYLTXkwFYTk6pdfY4kOpE8wzEiAezmqiuBKkJwPBbOmJFEROjcG6ST6C/HN9tLgn3FF/WsBRBZ+D1Bqkv373+C4dMptblkDm9MS26UzR76dU+uclHKVNtdPvMspZKahuRdkWJqvimIJLq5Jnnt3+pCca1DKFdf3wp2rDOwRZYM28f2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSzWP52QPacRJdz0RCY+UL8j+VfQZg8Qe5B2+7H7EGo=;
 b=gfTCLSI/jh8pOjjFVvc31NJDL+pBn2biGahXy3cQVRuGjEk+OVT60eCRFas40qCXB6Hf/2VlYWw7l7DsJIoR1JIsqKrM0MLJXfn1kM5ID7ur9g8dj9r864uleGkgozrBJtgSNtldwXnarx1N6stqsgGBbjGJ6lt00r0EwG6KR+/+pFpNdpYEw/LUHfL5530bhxmGPM/dA/Q/nbyh505J1omc8zxj5v4jMSY6vJYEFfG6ILjGjyByszeFLb/6Dg9z90gdkzVACW//aoflZYk+peXbScGnfwlM/rbfl0tmawZbL6NqrvrEToJei8Y/FBOiMVWNR3F42ZaL97ZbSuCL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSzWP52QPacRJdz0RCY+UL8j+VfQZg8Qe5B2+7H7EGo=;
 b=VOLRu7uj2j/wpy5kYChgQ1B1unaYIyB3V+1P+k5LQ9uFMz82D+s92ZKOeagpsDxPlJZwtDalpAkcxGWHH+7q0oQD5L8aJuIFjRRwuueA9mLjgGYLj3UoLywkk/FRaBdk6bmBaeZlxq6CNadUeBgpGmrvEU8lO2VksUpJEb6Y5xo=
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:01 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::8) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amdgpu: switch to aqua_vanjaram_doorbell_index_init
Date: Wed, 29 Mar 2023 16:25:35 -0400
Message-ID: <20230329202548.1983334-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: e18c0e15-a033-479e-b55a-08db3093d05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG1YjD/5OxpQpf9WkuCDtE4bsSz/r0Xct2t8MWQbPTAo2Vi0ElynbbdfgOlEbdW2llL1sIC7Y9Ec3NKk9GNJUxZtXyuUvIAwT2FCs6sn8EdMoZY/WwS8043RYVhB0o49SI1VXVTEbvJ9E+8rk91w1tyVCw1sbZrblwSqx9udTAi0JlQyL9HB5iDd/PZ8ERfxUPmYyIgKAAF3shNu8t9ljulDinmL5pYRnBAk8yZSTty2oZ5KeLayOFNSMdgl//1bqCMA3/ohTKG8TjW7V5x5AmOcJl+vfr6osjdDJ35n0DfdXmuJn0gOOGmw8zOJr1bTyNErFMPKrhmMG0UJQy8XMicCcXveamQN7jieMK1mJQGHVxH6PIrygUA8ITTW5D/dturO1NGQ752mBk6evhnCRSRvfALTuH9i8X3OUjxptehKJQGaZAVO1tldCSR02k0c996s/yA/dbAIiIQv0RWVHz4mdUqOP8Bl1ha8TlX/UffnvisspASWxBqi/F68EIX7/HRdRBgaNzqSTZC+HKpBIxetw1gmQy1IG32WNeSK37L0v/ggkQqRnj4NF6CiG4XLm/YcWkO9X/BQzTMHSLfZMjSPMDI2g7cBmKKHGDhtRH9O4DfnItVnl6xjdU3p69WK1aa7ylgbEjp557N9RA8hVJJL0YQQ+zQ2fSqxN15C+7tWwuFD4PyrbscizQSa8r4eEaDcoMkaZ1EszOz2RlCQSUh5v4PH2D7B05JVbW4E7V8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(356005)(8936002)(40480700001)(81166007)(82740400003)(70206006)(70586007)(6916009)(8676002)(41300700001)(4326008)(40460700003)(2906002)(5660300002)(1076003)(26005)(6666004)(2616005)(82310400005)(83380400001)(336012)(426003)(36756003)(47076005)(186003)(16526019)(36860700001)(316002)(86362001)(54906003)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:01.6207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18c0e15-a033-479e-b55a-08db3093d05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

From: Le Ma <le.ma@amd.com>

New doorbell index assignment is used by aqua_vanjaram.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index af47fafd2e77..6800a85c5966 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -861,6 +861,28 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 };
 
+static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
+{
+	.read_disabled_bios = &soc15_read_disabled_bios,
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
+	.read_register = &soc15_read_register,
+	.reset = &soc15_asic_reset,
+	.reset_method = &soc15_asic_reset_method,
+	.set_vga_state = &soc15_vga_set_state,
+	.get_xclk = &soc15_get_xclk,
+	.set_uvd_clocks = &soc15_set_uvd_clocks,
+	.set_vce_clocks = &soc15_set_vce_clocks,
+	.get_config_memsize = &soc15_get_config_memsize,
+	.need_full_reset = &soc15_need_full_reset,
+	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
+	.get_pcie_usage = &vega20_get_pcie_usage,
+	.need_reset_on_init = &soc15_need_reset_on_init,
+	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
+	.supports_baco = &soc15_supports_baco,
+	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
+};
+
 static int soc15_common_early_init(void *handle)
 {
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
@@ -1104,7 +1126,7 @@ static int soc15_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	case IP_VERSION(9, 4, 3):
-		adev->asic_funcs = &vega20_asic_funcs;
+		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index d8a2a6c2c6e3..9cc2dda087c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -115,4 +115,5 @@ void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
+void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
 #endif
-- 
2.39.2

