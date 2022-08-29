Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B326ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 08:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8AB10F0DE;
	Mon, 29 Aug 2022 08:18:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1968410F0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 08:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXX+h4j1aQhXfTJiMF7TuxEWrmmNOAp3Ha9HC+xZ5kBKAaTbZTcWv3yv75gIkHSTYHl6DaXSL6rCpK0lR0fWy0Ou2t8tA8Epuu3Dn73DCgeR/8y69lfg4cynPM8+vZaiRuco1mOrGVTx9i3VA3T6SCGk1HsZp7ZZLgwGuwEGyOyyXRJ5PTSqn9gocJ6XX7G1Ao4EK6pPcQjwNWvL3NGHB2hrocaCFyf3ycDH1PohsThotW2LlEIwr+ZlGUhXemnJHxJaSH8nKzU40sOjk6cKzoZzpaSYsrGwU9meYFavi0Ap7Z8/4X+DyJm3oYww796HQ4b6QR3gqajdLiXIAir6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLtz486J7BaPq4UNqS3axz6BKvM1cwPMRyWN0gjj0Ic=;
 b=CqV2CbMJhOEET3/sOshBwYbJRaFexwn3OoHCBfiUJ4dbrQQ1BOzcQ/MafcHqy1KhdhcbOD/AAOnQIj89IyBz4fFJYyWRK9TPubMrK/mhP5cMDMXTSws6MGoKr5gYIRWZ/focnotqnMCSJ7eB5vjZiawhFIk0owE6gN5a2yEpNhFfXOGLpF70C1d9lPcosBxIFBtDuiAw744Qila5qHpY//zBM4XdFFxRynU5PnuprtSboMcuJVqS1UnGxoWetUJco/h5g7R/2x7TO7sYMq0mqtbKm+f7VBI7R6JEJxAiToppuO/PKRnIEbgFO5Pw6xj30p/UsCHIly+4XQmjrCx9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLtz486J7BaPq4UNqS3axz6BKvM1cwPMRyWN0gjj0Ic=;
 b=gaqREWls9qDRgbuuU/Lqcgj3Da0O/uOGZ9ZzGwiR7Ne/zzKBEoC9tabyyycBzo5sTQb2cdmUBWix76g4ryeazz/v/q+EYGCABr/jsnUmB49wZBKBh3lm0OnDmDqYlhUO9MAUx0ZudQck+LIoSLYHCP1A0gMKvOVUnrp1vjvoIc0=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by BN6PR12MB1236.namprd12.prod.outlook.com (2603:10b6:404:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 08:18:12 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::c) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 08:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 08:18:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 03:18:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: Move HDP remapping earlier during init
Date: Mon, 29 Aug 2022 13:47:51 +0530
Message-ID: <20220829081752.1258274-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb3a3398-5049-440c-2022-08da899703ae
X-MS-TrafficTypeDiagnostic: BN6PR12MB1236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2L9eq5ge/JYcu3giCZvgHisqWejmXGOGg61jqd7Qdo3dxBLFSZQcV/EnSbhAquWMDTXuz3jCihtL5Pf1tRfo12l7fEaFluOXIQhDKyBlRlYTQP44d+BOIDw2EyIsZjDZq3wt8C/tjvx7KtY52ob1AC5nYH0W3aNK98FRrpKjWUqcIgty/4ET6lQH4Jb33sn13/+b/hDZ92dco9QZn3ipO5uWop92woYEr316LiGxn+KqKvpcecXbQCbBvfWO0Jc7Qzp5aIlngxzm5jJk60uJ9mSYl1JEAx8iH9JXPscwh69RWF0k/qSrLUsGAalP3zq6q8F+ad4gfrWN2RZEvcRUDqHorqSTGpMXuomPRzDhKPc89zAbbyagL2IitbVDPhCqh97ZWzBlJCDNYPIffhq+3YMgJVLDEY8ixUE1zsAZdoZBTRvBm8gR2hdSnZQmJzPvvMMqt5I3DmnTCc/1kFOVebrXmDNFIHM6xL5BhCCHInjGK3AdGN2w6gsR/BKNRahhn8GEtqcCTI6lKX7NpepJJre+BBb2lAinfRSv5DAngKGOr1aLTxeoiPl4h52i0fErUd7DEgN5MZB4rH5XxyIVJf/nQg2GJ5z/T1qHjONUeQTnfWsJMnz0ZO/RlyyDoHTNekOWrfdvpVitP2DYffihM4sL1hYIOycPYEkd9cA1vtFpJBMH0BiAwbByxLkr0oNHUATllisK/QZALHFqJHuvZc6xy42Xg3XqGlr+eUxrMOvwImIuV6qyJdMiR33q10SBj+jQWaCNrBW2lxkjRqDfqOXYwVkO0gyCTQLZ4ZNhix5K8xL7N3qMjdWmDRWvjvf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(40480700001)(36860700001)(356005)(40460700003)(82740400003)(70586007)(81166007)(70206006)(8676002)(4326008)(966005)(478600001)(41300700001)(8936002)(5660300002)(54906003)(316002)(6916009)(47076005)(426003)(16526019)(336012)(2616005)(1076003)(186003)(7696005)(83380400001)(2906002)(26005)(44832011)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:18:12.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3a3398-5049-440c-2022-08da899703ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1236
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
Cc: Felix.Kuehling@amd.com, stable@vger.kernel.org, tseewald@gmail.com,
 helgaas@kernel.org, Alexander.Deucher@amd.com, sr@denx.de,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HDP flush is used early in the init sequence as part of memory controller
block initialization. Hence remapping of HDP registers needed for flush
needs to happen earlier.

This also fixes the Unsupported Request error reported through AER during
driver load. The error happens as a write happens to the remap offset
before real remapping is done.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373

The error was unnoticed before and got visible because of the commit
referenced below. This doesn't fix anything in the commit below, rather
fixes the issue in amdgpu exposed by the commit. The reference is only
to associate this commit with below one so that both go together.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")

Reported-by: Tom Seewald <tseewald@gmail.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: stable@vger.kernel.org
---
v2:
	Take care of IP resume cases (Alex Deucher)
	Add NULL check to nbio.funcs to cover older (GFXv8) ASICs (Felix Kuehling)
	Add more details in commit message and associate with AER patch (Bjorn
Helgaas)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            |  6 ------
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 ------
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  6 ------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce7d117efdb5..e420118769a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2334,6 +2334,26 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_prepare_ip - prepare IPs for hardware initialization
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Any common hardware initialization sequence that needs to be done before
+ * hw init of individual IPs is performed here. This is different from the
+ * 'common block' which initializes a set of IPs.
+ */
+static void amdgpu_device_prepare_ip(struct amdgpu_device *adev)
+{
+	/* Remap HDP registers to a hole in mmio space, for the purpose
+	 * of exposing those registers to process space. This needs to be
+	 * done before hw init of ip blocks to take care of HDP flush
+	 * operations through registers during hw_init.
+	 */
+	if (adev->nbio.funcs && adev->nbio.funcs->remap_hdp_registers &&
+	    !amdgpu_sriov_vf(adev))
+		adev->nbio.funcs->remap_hdp_registers(adev);
+}
 
 /**
  * amdgpu_device_ip_init - run init for hardware IPs
@@ -2376,6 +2396,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
+
+			amdgpu_device_prepare_ip(adev);
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
 			if (r) {
 				DRM_ERROR("hw_init %d failed %d\n", i, r);
@@ -3058,6 +3080,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
+	amdgpu_device_prepare_ip(adev);
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		int j;
 		struct amdgpu_ip_block *block;
@@ -3139,6 +3162,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_device_prepare_ip(adev);
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b3fba8dea63c..3ac7fef74277 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
 	nv_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
-	/* remap HDP registers to a hole in mmio space,
-	 * for the purpose of expose those registers
-	 * to process space
-	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
-		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	nv_enable_doorbell_aperture(adev, true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index fde6154f2009..a0481e37d7cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *handle)
 	soc15_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
-	/* remap HDP registers to a hole in mmio space,
-	 * for the purpose of expose those registers
-	 * to process space
-	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
-		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	/* enable the doorbell aperture */
 	soc15_enable_doorbell_aperture(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 55284b24f113..16b447055102 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *handle)
 	soc21_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
-	/* remap HDP registers to a hole in mmio space,
-	 * for the purpose of expose those registers
-	 * to process space
-	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
-		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, true);
 
-- 
2.25.1

