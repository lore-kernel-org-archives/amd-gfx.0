Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E8C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 07:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4B12085B
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 07:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NX9/evPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4B12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077DB6E140;
	Mon, 21 Sep 2020 07:55:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7BB6E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 07:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8ngk8X2rioemTt+NNNz9Bwl3wab4cnkc9aqD/FnlCCzPd10ymf6N6JEBFLfm72yYIEjzcgQ/7D8uWX0M7/9tSNeSf2Ai8o7+8y6DYu1drE3KmPH2t3nmvZMTXTSt2K1wuPPzJKALdJzNqAlsexN+iBBPGBkt1R8GkfPyVuxhLobkVF8m7Y4UgkDg1+ujDDAYFd0Vx5fBlnjHYHRelbpttUzrEwC+nqIq68jYzdSPQQBzTDswzFkQ94XGn1QPWEIGp+AovYrDIhV3RgCQkkBC3sCwU7eHPyl7O9XFXwLo7xIbUb0aTd3KM1UKRYKm+J00UTPUYg1cy1Vn5svXU8tVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumr7D7zUR8q8LlimDgxlnlKGu5NA7A67N0m3aDJjXc=;
 b=PClDZ43Dzzec8ZOo7sotcTEkighAFOLcTdrS7OM87hngiWcvsFi+qoomFEbmoKrgW81wFTz5SvPe9YXtRtfos390BTp4jEH4OgqPgbpDIZdIga5cr+sKH+5VO1AYTi1XbFzI8h/xUxRcr6qkdgQJawirEtcFPjoMquKD08pgvAVoMVCCQkQLrhsO08Uu0DlzmzckI8yZv/X4+Q3C7rQLCyFnoxZrL4RztWPXjbnoXWBl5RRb9tjfWthtk/8/PbSttQel0oziV0LBgSEFmi0Kh9IK50nE9OEMpqBwnt46ZhJ6ueg4DYz+F3doox90l1amgeJQFr+2/lda0QVvQnzMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumr7D7zUR8q8LlimDgxlnlKGu5NA7A67N0m3aDJjXc=;
 b=NX9/evPUWB0rCJCtvjeSH5QLox8V/qlQK7zYWLWPuU5x07NogxlMgln2F7fkIZ38syItvPyyU8rJ9u7hNQiQLmwb/9w9R+KipYUknmcPcdYB6gTUoVE0B4df7Nj4pHsU8ikglZhFogtZwOaLLOEVzBtSxAD0eyuJ6u3sDjZJgIw=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by DM5PR1201MB2521.namprd12.prod.outlook.com (2603:10b6:3:ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 07:54:57 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::d9) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Mon, 21 Sep 2020 07:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 07:54:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 02:54:56 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 02:54:56 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 21 Sep 2020 02:54:55 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
Date: Mon, 21 Sep 2020 15:54:52 +0800
Message-ID: <20200921075452.527457-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f093eea-b909-45cc-ad46-08d85e03a27d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2521:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25213E397A2EB7D1944507828F3A0@DM5PR1201MB2521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuTZToHz8sT6juMn439VsoFPJvnzbcOGuJrBst30lzNzTpwOnXLjHqNzLMzmYKm3RadS6m5x1tA7Lznw1sezQV5MKV1NGOvlCQP5+vpE8eMkSAotHyFzkEJknXj9xAk8J7nG4bfXAU/cE872G3H3qk25ex+bpVBt0k/zlNzHMcqIQhVcnfQuBvtOr0DyBGt6wtlmwPd6dxGujn5+JNVu4ogxnmbGRXUtEUHUkXG6YyMG9/3a1IjOkklwpDPS8QAan5DA0R7+GEyED3x2Y/3K0l4TCC0FL3cavXtCOgmlqIay7KeOZ9k4wlZ1YVx5nFHwgNQyUXkVsATL5xGL8q3DPwT1GE3ubQlRzQb9AcYUH64TIpSnbEgkB3pX8Vc08I0xHiAfHZbVSVGZciniiSpmW0ax5UrvsXuHIRrq1ZG7M4FKUxwqQiuUVJVOdoR9Ln/D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(36756003)(6666004)(2616005)(82310400003)(26005)(426003)(336012)(186003)(86362001)(4326008)(6916009)(47076004)(2906002)(5660300002)(83380400001)(8676002)(316002)(8936002)(7696005)(70586007)(70206006)(356005)(82740400003)(81166007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 07:54:57.5404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f093eea-b909-45cc-ad46-08d85e03a27d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2521
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For debug convenient, reuse mcbp parameter for sriov mcbp

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: If1222b2c050376feefb8fed4be58b4b87d36bd77
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c2eb46e9b71..fcb6a41594db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3197,15 +3197,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_get_pcie_info(adev);
 
-	if (amdgpu_mcbp)
-		DRM_INFO("MCBP is enabled\n");
-
 	if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
 		adev->enable_mes = true;
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
 
+	if (amdgpu_mcbp == -1)
+		amdgpu_mcbp = amdgpu_sriov_vf(adev) ? 1 : 0;
+
+	if (amdgpu_mcbp)
+		DRM_INFO("MCBP is enabled\n");
+
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d658d2a16fe..976d4f8ee2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,7 +144,7 @@ uint amdgpu_smu_memory_pool_size = 0;
 uint amdgpu_dc_feature_mask = 0;
 uint amdgpu_dc_debug_mask = 0;
 int amdgpu_async_gfx_ring = 1;
-int amdgpu_mcbp = 0;
+int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
 int amdgpu_noretry;
@@ -575,9 +575,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
  * It is used to enable mid command buffer preemption. (0 = disabled (default), 1 = enabled)
  */
 MODULE_PARM_DESC(mcbp,
-	"Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
+	"Enable Mid-command buffer preemption (-1 = auto (default), 0 = disabled, 1 = enabled)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 
+
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery table at the top of VRAM.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2f53fa0ae9a6..cffa45a9481d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
-
+		if (!amdgpu_mcbp)
+			ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
 		/* drop preamble IBs if we don't have a context switch */
 		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
 		    skip_preamble &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
