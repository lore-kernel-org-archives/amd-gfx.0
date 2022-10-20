Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C68C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 03:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA6A10E2D7;
	Thu, 20 Oct 2022 03:48:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1510E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 03:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evXLYGkWJVxk/rRX0krtWwkQmKyvzNw5BjyNNN2dFb6xMdqM2Z760kEtcRij7FLmmn77ZqEJmw60b7zgNhlP2pUh/P41Fzfx3MocqFi853dfkLARGbgA6WRVIhAD4I+g1You215wMdwZVPL7Yzl+ABgDR5jWG7/64jt8ycP4BMR+Vob+K14M+5vkPXPnen7z98g9tsLOedbDUzSnCNmgvxvaTJ0P9MdlJgTbbddWUTSrueJ2w/0UsTUGy70MG5wnCpE+NUiHjKZtTMzBoZ4daPnmJ8b/YM/je/1u4BaUyHWdi8xozY4BmLoeNjRerepPZJ+vi3X48i+KGwP4sjZk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbj6riU8nW0Fz/gtssGLEzlDEXYtuCqSzChQu8E5HVE=;
 b=HT2nBpoIJg+bcLtn3Sn5qiw60Etpe6YKH6OrZtGB70mPV757pQzEvS9/J8nXLnP5BSbDgxfgcynSkYldQoOQF5V2ztCFHpVBPV3XuJZDdEXythPZ0Cr+VPRsrl6f4zCnBK6P0ZJkFUmdOACQ+M6f3lET3NOgwnLbI7ZTLq9za1RbzV1Th5lmernePXj5GKZBobMT1MqOz8hdQePes/5eMEqdkTO+gXvj/T2IJE0XqttVU45Ou9sTSrufSl74uddUsw8+NcE/FWcBFIOLYXhvNxGhgUHWGqUG/ZD6vtAQ+Oj5pQpWi01f2TE8R59Xogowl5jtAKTmnTobfvZlvusOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbj6riU8nW0Fz/gtssGLEzlDEXYtuCqSzChQu8E5HVE=;
 b=m3mahvpgh6dCaJbAX6LlAB5OOrdDEfYiONZ35vogaTWa3sHkKCnHSeEsbFI2D29C+E7uWD8/R/BZIBqI+YDze7dh8bc7BuJ8wL15KS2GxrMJkHO/V0hUdSOlVqVhVvEpUrJw0pWZJ+jEQSby5j7efJ0Blhp8auTkSKBclc40p8w=
Received: from DM6PR07CA0089.namprd07.prod.outlook.com (2603:10b6:5:337::22)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 03:48:28 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::de) by DM6PR07CA0089.outlook.office365.com
 (2603:10b6:5:337::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 03:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 03:48:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 22:48:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix sdma doorbell init ordering on APUs
Date: Wed, 19 Oct 2022 23:48:09 -0400
Message-ID: <20221020034809.506525-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d36d74-6774-47c4-925e-08dab24df2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vM+b99VoMVrNbTz4s4vgXM28nfY0MhOOM0TT9bT6UP1xL2ApGKXqWw7W1+nrnA42nla6/vc4wcrf5oOwOuYPqdoOG/z1fObPEtVdrElg3KscpgJtT7MRC7xAxzg/qCDp5j1wrf/0cC2md0t6pc/IeCrbC9QklRzU/xPkrFZoTE220iKti1Bax5iiZs+qjwm5CdaItOwx1knqKV5FfSPmJTE1XnLIOPAaMNmTa0I8JCZIszp/zFLLXaOetQzkZKbXrF1yyOsBTXjRmkJoAKVdGp6AjKPOFNMZVRy5YEgkTZOgPfrci8um5MWvj+924Tm8WxnsuOdCgBW70FqhkBJznZUW1iDNGtO2Lk7/yO4brB+vkRh54goXxmJ4xSl/TBtFIimEVC0Y+Zsl0/ubHJE4bleVQS18HjdHc+i6X09pnJ81Hi2TqiHz8niipGMuBzITq+OWBjkIgAugu9PxQHEnC+qQ0AAkqqSOay2N+hjs9fE1O4IydY7+Pid8caPJcaJnxMU4BcUF+pW51HXDuTic4xYiQKBIJX9dxgnZu9+ngjV2VNO85Ii6ju+/1wNEEud6dAA32sIZI26IfDr9oDgrWZ8340yHz77WvbyRy91jBoTmJswFhmDgpcmrCD5Js0fdcSUSL8zX7y5YEj+5IFfMGO8wve8Xq0lKxmhdpb0ZUtdL5jPA46r7HUeVUVwRFzZ0sfp8waIdbgk/vFkakYkEIgUc9kdplpqcLPZmFDl6ZAilesYQ1JB53ymGzkJzXK4uLkmL6LRZLc5YMkxWIXwkvpVFAhZ5NSNTNBdpP4Df3KE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(4326008)(47076005)(5660300002)(81166007)(426003)(336012)(54906003)(6916009)(82740400003)(7696005)(70586007)(2906002)(8676002)(82310400005)(356005)(40480700001)(83380400001)(70206006)(316002)(478600001)(26005)(2616005)(186003)(16526019)(36756003)(86362001)(8936002)(1076003)(40460700003)(36860700001)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 03:48:28.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d36d74-6774-47c4-925e-08dab24df2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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
Cc: Alex Deucher <alexander.deucher@amd.com>, skhan@linuxfoundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
uncovered a bug in amdgpu that required a reordering of the driver
init sequence to avoid accessing a special register on the GPU
before it was properly set up leading to an PCI AER error.  This
reordering uncovered a different hw programming ordering dependency
in some APUs where the SDMA doorbells need to be programmed before
the GFX doorbells. To fix this, move the SDMA doorbell programming
back into the soc15 common code, but use the actual doorbell range
values directly rather than the values stored in the ring structure
since those will not be initialized at this point.

This is a partial revert, but with the doorbell assignment
fixed so the proper doorbell index is set before it's used.

Fixes: e3163bc8ffdfdb ("drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: skhan@linuxfoundation.org
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  5 -----
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 298fa11702e7..1122bd4eae98 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1417,11 +1417,6 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
-			ring = &adev->sdma.instance[i].ring;
-			adev->nbio.funcs->sdma_doorbell_range(adev, i,
-				ring->use_doorbell, ring->doorbell_index,
-				adev->doorbell_index.sdma_doorbell_range);
-
 			/* unhalt engine */
 			temp = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
 			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 183024d7c184..e3b2b6b4f1a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1211,6 +1211,20 @@ static int soc15_common_sw_fini(void *handle)
 	return 0;
 }
 
+static void soc15_sdma_doorbell_range_init(struct amdgpu_device *adev)
+{
+	int i;
+
+	/* sdma doorbell range is programed by hypervisor */
+	if (!amdgpu_sriov_vf(adev)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			adev->nbio.funcs->sdma_doorbell_range(adev, i,
+				true, adev->doorbell_index.sdma_engine[i] << 1,
+				adev->doorbell_index.sdma_doorbell_range);
+		}
+	}
+}
+
 static int soc15_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1230,6 +1244,13 @@ static int soc15_common_hw_init(void *handle)
 
 	/* enable the doorbell aperture */
 	soc15_enable_doorbell_aperture(adev, true);
+	/* HW doorbell routing policy: doorbell writing not
+	 * in SDMA/IH/MM/ACV range will be routed to CP. So
+	 * we need to init SDMA doorbell range prior
+	 * to CP ip block init and ring test.  IH already
+	 * happens before CP.
+	 */
+	soc15_sdma_doorbell_range_init(adev);
 
 	return 0;
 }
-- 
2.37.3

