Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 06:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEFB89F77;
	Thu, 10 Feb 2022 06:24:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586B989F1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 06:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtR/IYp6yDrsBfOi4t42Us92QmE2yirms+sJPHbMwyjVFyfwpPEfjr1grtoMfykkZ8aGxk8edUCIvnVPl6xn5GW/zk/kasUi1p6fwNb1NwyjFmoUnhb/kQFppwquouOHTCUqX7IBLNJXBF/wUWWpkEZenm5V/IrNM7WTuBgstk9++R28kgzBnlxUFocdkIax3ScWqRdAMPWM45CMRCGe/n0ZEgCClK9gptevQ3KM675EctHeofV8ln/1dwwH0I1V3Od8nG1gm2Q1Xs3b8616y1xVux1jdS7rlETDDUyflydij6+Qwrv9O9e2F8UUnKHVWY3b0NBdZN1bSEElo1vPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtYMH72PatThH3hmGmrdRUazmr6+x1Dajm2zxHMLILI=;
 b=HM9Vc3vDf9OhL7FgbXYVfwuR3L+LKY//DpGEKTtwP2tytui0uSEFIFJFMEpspfF8m3LXx+ln97JtVsz+Zj/AVw/2I2zT6aRYL9l19sD8ZqVKhLANs0k23F4Jr5BZpZUWDK8ZcRPDUftWtDmu8GFY0IQXbSduUguZ/EJgQ716kDBk9K/dwnySWQ2Nfu/Kzp8DgP7xaPNrNeMymn66tqdvm0OZ7Jij7EOc8JQReQFNGMjccK0tSABHTJxq9PxaAU9elKVboFUJSbbQh8V1m/EUnvOi4E69cj7tKVO6cfj4cyurOYInoAxDf0j4gRRjTHXUMAdPdjQRMhpkiEQ8JxDSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtYMH72PatThH3hmGmrdRUazmr6+x1Dajm2zxHMLILI=;
 b=2aZ1gBxkbL1IppItT95nsZ8neZhVe1U+Y8WgZkczLinFW1nwCT3o7RUeH2pgaTs0y6p5fP47PBaP5FMZpXmMtYZTwCTlUzCVoo8Ts+M2GH+dFmWTi5MSHr3PFXsJEW7/oPcrfKJCmnPWxmx6xphy/3VqS8WP+gWaFzbvh5WQ3e4=
Received: from DM3PR11CA0020.namprd11.prod.outlook.com (2603:10b6:0:54::30) by
 DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Thu, 10 Feb 2022 06:23:56 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::97) by DM3PR11CA0020.outlook.office365.com
 (2603:10b6:0:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 10 Feb 2022 06:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:23:56 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 00:23:53 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for GC 10.1.4
Date: Thu, 10 Feb 2022 14:20:15 +0800
Message-ID: <20220210062015.3798430-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc23e69-0470-4b28-33e7-08d9ec5deaa1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2534:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2534697333637B1ECF794305FB2F9@DM5PR12MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4Jj/4LyNMjRyDNooVhr8cTC7CIXLvYx2nvfYZxol9wpsC4DzC2VehpIVkpBLA8F1pfGIWMdwH3NqP5EEBIBy1XsR7FuKo65zjpBjkewbKQpfu4j7yupnkFVgyu07tQB4YmkIcMneXlTBMU6cKHmGk7LYekxzB8/t7iET8VT67WY9i4iGB9mTC2AQKsWsnGITvWEoDPQvncByQ4vB/CIF9Ue/N3aXeu8k7JeyzLURLeBMm135PQNu0V3ulGvKkaRGiz1jyHXYFvXml9dMfq82wpAlPiAnsE+a0+LyqqaK42RM6Y0YORRqk34QzQNZite18ChxzsiIMlkVhRPEFf9w9Rpzx63x0xJCAPVNLJGJJDlAC7OSlaTZxtx+MnYc8ZYwaEJ4BEFNcKV3qROOGAAEBpOl0RqubGlVdoOk5bcGvttZo5wDyCBv/e2RLhB3UflQaCUQn2tESeMjMJJ+CkjOKz3p/aj0sAL9YwvHA02pmGxpf2eyq/pQMAKAXB3Ru2rDjEDmNwv0Uy+MTtnq3c3vPcWF43oT9mdU2FMXvPUr6yKbwMQlNmgDfikwJ2YSafeS4F8KVhTZLwQC2rhPvykJdVqIA3gYd5YHEY+D+0SOtrnOQqZUxiP6BZpyDOYpSLOAiJx3q70nsp3uPB/+JP+LQxMtEbCNgN3sfnzZkX9ieZxxrW3a0NgpLl9oFj22U4xzdjcwsPv8SPHQQHs20tgkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(82310400004)(83380400001)(54906003)(6916009)(86362001)(70206006)(40460700003)(70586007)(356005)(47076005)(81166007)(2906002)(36756003)(8676002)(7696005)(26005)(8936002)(316002)(4326008)(426003)(336012)(186003)(508600001)(1076003)(16526019)(36860700001)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:23:56.1088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc23e69-0470-4b28-33e7-08d9ec5deaa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add basic support for GC 10.1.4,
it uses same IP blocks with GC 10.1.3

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 4 +++-
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 2 ++
 8 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eb4b7059633d..cd7e8522c130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -674,6 +674,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
@@ -709,6 +710,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
@@ -910,6 +912,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 1):
@@ -1044,6 +1047,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
@@ -1243,6 +1247,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 4):
@@ -1264,6 +1269,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 2, 2):
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
 		adev->flags |= AMD_IS_APU;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f2806959736a..9bc9155cbf06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -137,7 +137,8 @@ static int psp_early_init(void *handle)
 		psp->autoload_supported = true;
 		break;
 	case IP_VERSION(11, 0, 8):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4)) {
 			psp_v11_0_8_set_psp_funcs(psp);
 			psp->autoload_supported = false;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3d8c5fea572e..8fb4528c741f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3641,6 +3641,7 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
 		break;
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_0_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
@@ -3819,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		if ((adev->gfx.me_fw_version >= 0x00000046) &&
 		    (adev->gfx.me_feature_version >= 27) &&
 		    (adev->gfx.pfp_fw_version >= 0x00000068) &&
@@ -3959,6 +3961,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "cyan_skillfish";
 		break;
+	case IP_VERSION(10, 1, 4):
+		chip_name = "cyan_skillfish2";
+		break;
 	default:
 		BUG();
 	}
@@ -4565,6 +4570,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 			1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);
 		break;
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4677,6 +4683,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -7658,6 +7665,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_NV1X;
 		break;
 	case IP_VERSION(10, 3, 0):
@@ -9418,6 +9426,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index bddaf2417344..c64e3a391c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -881,6 +881,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 1):
@@ -1156,7 +1157,8 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
 		return;
 
 	adev->mmhub.funcs->get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index f76834085b34..5e9ab31fee6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -902,6 +902,7 @@ static int nv_common_early_init(void *handle)
 			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		adev->cg_flags = 0;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x82;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 81e033549dda..45e10d5028c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -264,7 +264,8 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "navi12";
 		break;
 	case IP_VERSION(5, 0, 1):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
 			chip_name = "cyan_skillfish2";
 		else
 			chip_name = "cyan_skillfish";
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 9624bbe8b501..bb6e49661d13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1411,6 +1411,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		case IP_VERSION(10, 1, 10):
 		case IP_VERSION(10, 1, 2):
 		case IP_VERSION(10, 1, 3):
+		case IP_VERSION(10, 1, 4):
 			pcache_info = navi10_cache_info;
 			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index dbb877fba724..7f1746289989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -110,6 +110,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
 	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
+	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 1, 10): /* NAVI10 */
 	case IP_VERSION(10, 1, 2): /* NAVI12 */
 	case IP_VERSION(10, 1, 1): /* NAVI14 */
@@ -307,6 +308,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		/* Cyan Skillfish */
 		case IP_VERSION(10, 1, 3):
+		case IP_VERSION(10, 1, 4):
 			gfx_target_version = 100103;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
-- 
2.25.1

