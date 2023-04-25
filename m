Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD90C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 06:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1DC10E68F;
	Tue, 25 Apr 2023 06:38:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EBD10E697
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 06:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFX5PfxJBLkO+UDRNPad2Hbow1jelg2qX28tmZ2RvHh0mFcm/Am8ayXcj+NoV1GKkGG/TkkYL6l4xA+O+NbRsh+6uea27z+/ZY9EIU3yTbA51++iqzO9xzRko5ZHArNpaalvwv7Sd86NtzTNESLMRNcsVF9m1BvFmChZq5cFzpwii4VGzpmOglY1on4zQHWDT/uP/4I4c7FnrjeBp4QwGAfuR7vXH5rS3qG9MVWWUVExHlehn/a4ZyxZcahjPPn3ri4AsjbEwxH1FetWtewmpePV2fMq1Q5rJW0TKiwpYxJOC3ueCGE9NEBJfiBI1eFA01z+p65pByNxFSxs66a1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHrC19BRd0s1NO1Ul9Xuubhn5cYsmHaYceE2yvotofg=;
 b=grE9RW07qpvkAKyVpFqvszKYk7bv9V98T5osp5UWRp7uPELFZM6yetYzaRmkLiHrPwmCpRDiqt/nwdjVqyjAImUMe8F511n8jyXZMKF4dANrk7j9VBwQbJ/1pZ+e6TJctFIOEHGqn5lNbbEy13PYkC7uluc6Uwyx0trUAtVWS7HS1U6JkWNua7VxZo1/Kou1fViWPH7+b3+KiBGGnnhN4BGBDWCnJ64rlCFXz9s2ZWV4tsNBfazVSbUiFXhf5uxp79e/al+6bL3JxTw52o7jGHoTSy3AIyrkovgn+YZCaeDUfWGeb1a5YNYhFHH/cg7uZClpOIMvBlyaHWdjF+FudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHrC19BRd0s1NO1Ul9Xuubhn5cYsmHaYceE2yvotofg=;
 b=zZlVCJebnee1MWb7mNCNR8ejtlHHmr8RuCaVJzH5sSjvVqVIRv2PFIrfyV9IlxolGOLXEtamqmPhYj36DoHjbTfnU+GIUgeOOoqD9Iejcjejpni+Eyjb1878xdEtflj4E/OneQB8jy6FKy/8smTLcFpByoF9j1HCBze8REO2WrY=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 06:38:46 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b1) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 06:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 06:38:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 01:38:45 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 25 Apr 2023 01:38:43 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is not
 needed any more
Date: Tue, 25 Apr 2023 14:38:35 +0800
Message-ID: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 684e9125-64ea-4f3d-c74b-08db4557b8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mA+Dnz97mQkQnVjqAv9muMg2/ud4oHXk0h2ain7B+pVu/C4flk9Apcdp6IygJbiE7cTl/8g2vMMi1CasmFzpz/gaSX5TKkEmaUEaw9RvoL5fEs+1sbzaZEen/mrHZrrTKbxyP1h8pfssHPbfzqACMCxyjrWmz814WAdbfAFVTd7Ui87ZLKb8LZNlaIe+aH8bDJa+TCubU4IG9pmH/IsJHKfm36yAbMTuTBp1IId/6KY7SUVu8Qx6ZDjlmahQDa/Dqw+i7PoP1MHoKgwk4M76w9D2WADvQxIwQo1KUdoTx27m25YLCGaw1qjaE5/2d2U8Wp35uRXNW7gbCutwGHyAJGJ3pkCyegpPaBLe7VCmeB5tN9BoKFhSMPNWgzkqwa30HMYH8wcCr7/WmqaZ48SpHHvMhGqEMcJ6hfRFP+QO1saPG8v8yVcSzFcplMNqx5RaVf02zK4QxgoLfIaqyLi+51vRiAN9k9n18YO8GdL6NATZ1HNp4I1HqDqZ7Dpm6UYFRpsFiGmMF7Cu4/wDEHhHUjJWZfGoNkiBgV+7d7+penTC9IXmfgkS6Q3rucoDJBTkqoazhapAaWpKv5T8ALx71C6M9Wdis5apj3aWvYUdffAQUeRo53JK+S08Ebj123/yAWjl3ceRyaHsVMLSe2QdswcvBwB153p+u9XFq0HyC2i1NGE1T1VY+n2iPQA6k7mkXO2/4K1rmTYhAz1NpDRqQacfZq2TJU5oLnucyBASHTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(40480700001)(426003)(336012)(2616005)(36756003)(83380400001)(36860700001)(47076005)(186003)(40460700003)(356005)(82740400003)(81166007)(70206006)(478600001)(86362001)(70586007)(8676002)(8936002)(54906003)(110136005)(5660300002)(7696005)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 06:38:46.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e9125-64ea-4f3d-c74b-08db4557b8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gfx.cp_ecc_error_irq is retired in gfx11. In gfx_v11_0_hw_fini still
use amdgpu_irq_put to disable this interrupt, which caused the call trace
in this function.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
[  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.874375]  process_one_work+0x21f/0x3f0
[  102.874377]  worker_thread+0x200/0x3e0
[  102.874378]  ? process_one_work+0x3f0/0x3f0
[  102.874379]  kthread+0xfd/0x130
[  102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 --------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a4c4769e607..e9491aec3cae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1355,13 +1355,6 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	/* ECC error */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
-				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
-				  &adev->gfx.cp_ecc_error_irq);
-	if (r)
-		return r;
-
 	/* FED error */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
 				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
@@ -4483,7 +4476,6 @@ static int gfx_v11_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
@@ -5970,28 +5962,6 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 		WREG32_SOC15_IP(GC, reg_addr, tmp); \
 	} while (0)
 
-static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
-							struct amdgpu_irq_src *source,
-							unsigned type,
-							enum amdgpu_interrupt_state state)
-{
-	uint32_t ecc_irq_state = 0;
-	uint32_t pipe0_int_cntl_addr = 0;
-	int i = 0;
-
-	ecc_irq_state = (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
-
-	pipe0_int_cntl_addr = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
-
-	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0, CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
-
-	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
-		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i * CP_ME1_PIPE_INST_ADDR_INTERVAL,
-					ecc_irq_state);
-
-	return 0;
-}
-
 static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned type,
@@ -6408,11 +6378,6 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
 	.process = gfx_v11_0_priv_inst_irq,
 };
 
-static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_funcs = {
-	.set = gfx_v11_0_set_cp_ecc_error_state,
-	.process = amdgpu_gfx_cp_ecc_error_irq,
-};
-
 static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
 	.process = gfx_v11_0_rlc_gc_fed_irq,
 };
@@ -6428,9 +6393,6 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
-	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
-	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
-
 	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
 	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
 
-- 
2.34.1

