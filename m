Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE34C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 08:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6A4113EB7;
	Wed, 18 May 2022 08:32:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85774113EB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 08:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrIrU+9LwAio80KQyWGaE1t3U1XwvIdBUNtpp2cHdKrG5DsRsi315XRL1B8RVumNhUhXYitvdWHbUmi/7QFe+HGVE+cHyk49uMgitgMnhzPc97IQrID/OMID0bH9vdFoHJ2V5m/Oq07HSS0ONlYeU5maMw6ft3l4umx7JpcvsZ1JPYcOcU7maAjen8XKZ50Z7N9j/8TZ0ce8T0ex/jm2q/T3ib0cR3RqpZBjsWvNHA+7/65AI0UGBy/q8YeEbTy6EHs7SU+MH5UkbEykCNbyEqK7Smx3COcQPuFhVpCZfhWxqzeGw4kjjNnAdIFeE/92/qebEfzNezpdMRIUes/D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiLbOZ0OQj08cusMDk+qdifaVGYnis7sRwmyF45YDi8=;
 b=AOvGn8HDPurDiBhVbY1oRiKEVeS59bwfeoO64jp1que8yXtrm6CSfHP9WlvZ0+KQyMhh1UAT18GsXEVG04BeRktP1QFOn/qXQv4AZsJ2OvYFb8VwrELlGh0sFHeMj7GCpLiXNWvDtx4QPUPKQnLeZxPCbH3flfQ1PWdkbVEQkdx0T+nWPAbGsfCnlXQAXq/JLCu9wTE3mIqNuoQ+zintW7YGnkDkAxzhxa1dW/yBEHRqskhrZOXbDSWcAZv+FlO7LbHoh/mru9+nLfL+ERrk2hfUIH/bCXwRmv22vjK05wEC/P9t7DpuapG8Miu/XLfd7Sjq/gi0QN6IAcDl/7NKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiLbOZ0OQj08cusMDk+qdifaVGYnis7sRwmyF45YDi8=;
 b=0BTIQyEnMbEX4S+TyCjhNDWaHXRP90QYxZCQaDCxRYeliqdxGkPND6EOvbp+xjymecpLZs5fcE347m8mhDL6rwx92XdaH2XA2A4S7RuqtXggeVzbvNNKRMwN6zDNtnGscC1E7sccKT9xhMl/j3iu1JpagSDB94hkbft/L9sYaKw=
Received: from BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 08:32:03 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d6) by BN6PR17CA0049.outlook.office365.com
 (2603:10b6:405:75::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 08:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 08:32:03 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 03:32:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 01:32:02 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 18 May 2022 03:32:01 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Date: Wed, 18 May 2022 16:31:59 +0800
Message-ID: <20220518083159.17762-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8cdf00a-43a1-4dc1-c52e-08da38a8e285
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36801F85C45111732FF822469AD19@MN2PR12MB3680.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gM6ELJzyWJr5M6W2KVnlixlWx+ODRfTgStvXReSGFD+4H/NxuUMNRVanDf0rTkUMXpWVZcTz88NoOzz7y+7Lwtz7ciQYhdDulChYA9+7fQ2cuIRZcNizOq+JZTKFhxCLdkOdMS0W+qS7Wud4jgqBxH61LUNqA1clPYw/uOnCm7cRJ47jQKfllq4lNJBHtey0PsXBSsvq/QWfbaGeHmnsOP7n0EGpfTWitW1Gsep2ILk/zoA5surunfeEwy0ZSfUaDsbu3F4woCHtsAIp/LN43akyPB2BJrUy+3DhiqOaPimHERdP5PGkak3crUQPJywqm1F9rLzoGQKBZCQASAef9BUgUxtRriLOscCS/ok2nE1vexbqg6I7TeGcn3ClQKkP2M0kGX6ZJKgxHr3TCil17MtA86FMFR5TZtjCNVHJjYE/t56F+fpnmD5JILthZLDhF/nugF2eqp3WjE9Vdhb5hpV9z6HwutmL/HUZ6FN2M1QFUWp/BNb86wts9mOD7rK4U3oFDCg7jlkg68VQJp2yT0mcXPPQ4gaRCGUI/AWPKZ3mU/8L+wlpPZM538zl2GXF5SrIpid1EPiUBLIB6+MdkkZ+ltgQpayw2jkU9gf6GDlrsWrzO6dLAvJV2u9hN0LreKfa6XUym7qCS6qWmQWdeE5ILMR/opLCWJSdjTDFF69oKRi9fRHKZ5o6oA2EzdY1bu9qc76mHqFyGxoV0o0DzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(2906002)(82310400005)(356005)(186003)(83380400001)(8936002)(86362001)(81166007)(36860700001)(7696005)(36756003)(6636002)(26005)(5660300002)(40460700003)(47076005)(8676002)(336012)(4326008)(426003)(70586007)(70206006)(508600001)(2616005)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:32:03.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cdf00a-43a1-4dc1-c52e-08da38a8e285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support umc/gfx/sdma ras on guest side

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 23 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  9 ++++++---
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 85412e1a04be..e832c5bceb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5372,6 +5372,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		r = amdgpu_device_reset_sriov(adev, job ? false : true);
 		if (r)
 			adev->asic_reset_res = r;
+
+		/* Aldebaran support ras in SRIOV, so need resume ras during reset */
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
 		if (r && r == -EAGAIN)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 31e07dfc874b..12a1f2389714 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -202,6 +202,10 @@ irqreturn_t amdgpu_irq_handler(int irq, void *arg)
 	if (ret == IRQ_HANDLED)
 		pm_runtime_mark_last_busy(dev->dev);
 
+	/* Fatal error events are handled on host side */
+	if (amdgpu_sriov_vf(adev))
+		return ret;
+
 	/* For the hardware that cannot enable bif ring for both ras_controller_irq
          * and ras_err_evnet_athub_irq ih cookies, the driver has to poll status
 	 * register to check whether the interrupt is triggered or not, and properly
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2b80a3037481..930fa3837ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -721,7 +721,9 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Do not enable if it is not allowed. */
 	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
 
-	if (!amdgpu_ras_intr_triggered()) {
+	/* Enable ras feature operator handle on host side */
+	if (!amdgpu_sriov_vf(adev) &&
+			!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
 			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
@@ -2181,10 +2183,14 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
 	adev->ras_hw_enabled = adev->ras_enabled = 0;
 
-	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
+	if (!adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
 		return;
 
+	if (!(amdgpu_sriov_vf(adev) &&
+			(adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2))))
+		return;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
@@ -2196,8 +2202,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 			dev_info(adev->dev, "SRAM ECC is active.\n");
-			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
-						    1 << AMDGPU_RAS_BLOCK__DF);
+			if (!amdgpu_sriov_vf(adev))
+				adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+							    1 << AMDGPU_RAS_BLOCK__DF);
+			else
+				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__PCIE_BIF |
+								1 << AMDGPU_RAS_BLOCK__SDMA |
+								1 << AMDGPU_RAS_BLOCK__GFX);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
@@ -2532,6 +2543,10 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	struct amdgpu_ras_block_object *obj;
 	int r;
 
+	/* Guest side doesn't need init ras feature */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 3b5c43575aa3..72bfac9bf9d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -123,6 +123,10 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry)
 {
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
+	if (amdgpu_sriov_vf(adev))
+		return AMDGPU_RAS_SUCCESS;
+
 	amdgpu_ras_reset_gpu(adev);
 
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2c6070b90dcf..165cdc2d7f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -75,9 +75,12 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
-		err = psp_init_ta_microcode(&adev->psp, chip_name);
-		if (err)
-			return err;
+		/* It's not necessary to load ras ta on Guest side */
+		if (!amdgpu_sriov_vf(adev)) {
+			err = psp_init_ta_microcode(&adev->psp, chip_name);
+			if (err)
+				return err;
+		}
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
-- 
2.17.1

