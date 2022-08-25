Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA92C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 08:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671D810F554;
	Thu, 25 Aug 2022 08:58:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753D110FAB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 08:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKmkt0D3UP4yGLErXbL1ovNyi0ogv/cfyDnCcrGG29Fqyt29yC/2/3wOTllN3NJmuWbMKEdgiO1aeA0BCtPvoTtdaSL+iiTPn/mypciqflS7OmZrUvqFEeOxYDMj8EtGts7TuURtaNrle6A3imyCOna/Y/KBmIrzzZLDmiRCUX9QoVmohdMZaVHyUjwdsoXsxktNuRtgj4D6FVVOU4smdyQhn8hjsDyac3OxFqke9KNQwA/Jh3soIW2foS/kO3aXXjuxW+XqMcuIILVDthcELgLdXbxdEIhb0/1brg+7ckqPU0FEqox4C4Rd+h0uukKxUyAcDTfbQrZlnzZp+OmIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL3Syl98nYaFImrA1TpamWihW6ydzrohOFiDhCybdsY=;
 b=B4z9Ky24prXWCV9nzer3Jn1m+hcfXwCv9flej3bCCJz/SIP3K0GR/u4kwjGMH4JV6OY37QHpml1Ykg2ehhQGzFvQGnESR3F9qVdZFSeq6PsuwGN7kw8zFrVqhf8pmov7uNRYo/RDc5RiQc85TD/ya3A7Wf+iX3m6mMroqAzI7/vzAodOD9PaOv2qcdr0AaD4mLaEgcWin5gqotwGx2A6nQI8QmdNhoBVjrP+nSZEJEvgRNeu1RqhWDkYIGaXHs/TijEWwW0vmzoSXR0yVGrgDiLkX26pyW1PAJrKXU3Bn8/cV+Lz3PzKxa3mxGrB5J81RoyqlQYn9AymQcVy/OBlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL3Syl98nYaFImrA1TpamWihW6ydzrohOFiDhCybdsY=;
 b=oQjUYjijdbfodK5vNReI9ku8XLiL8WsLf2ZeBojkIgg9Jjvco/8yfOD5+hmefiy1a4OdaBY1p1ExJtZn8/rlHiOsNaH1m0sy+IYufhFbklYMaotyJ4FRAlEJzM6ffhivRJOOz6E/VVDN8ctYB46S6y24XxDZ1vq+jY7DvQsFLYE=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:58:41 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::73) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23 via Frontend
 Transport; Thu, 25 Aug 2022 08:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 08:58:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 03:58:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Date: Thu, 25 Aug 2022 14:28:19 +0530
Message-ID: <20220825085820.1228641-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf891ef-bb5a-4fa8-92cd-08da867801f4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBxjUM+yMOl2mbupYqhiYKC2D+S/fKgXcf9m2OXEY6NLEg05BDn+FKh4oriMBdKdT9nyhsNcFySFnsKx4k9DuEOgk7idwA5Xlp6IyGA6We0v1zWObfJ7OZ6SmkuYPZWj5lmaM73YaLI5mv/76lRABFcqVVVNNF7L/v2Yo25rRtlrNryc+pME0pYGor8ZhjvF48dp/2iqHwcN4jvwC3YJph32EzE+1pW+Ic9DpS7avMY6hrqtdxzuF9X4DFxtZovKbw7rRlX/9+Dq2dW+/Lpl5s0N7mJIC2DnQHn1Kf4+qxMAZ6Miz6+mezBEmhWAojysqgCv2xcSwjI6oegQiupfU5JqWeDi6rldk8pWDfkXnchrBmMbN+loWNwZIQxr70ayeOz71JyYfatIjAHt8ODX6sO+NNvHHqCwS4SlOyTBIPH6WreG3CPQX9mubeCU/1XOdL6oXbY9MQRc53sOrlJaPHGagilsCjy7+mZZaw8Qlf9QtpGPRyWUvUi0b2OiiHil7hxSqp38tdzSqTZgavKOoWAia0yfxMP291+ropi1CJ7eWw7S7XfQux3J4j0790MxLEdEN9JMk+QlrMeUkGWCIr29JFwaiQiPGd9vTJDJF0l1x1OSx+VungROmDXawqZUd95C0a6KYTi9F0wZf+gO+EBW76MBTBziFhk3AamZFIZXYR1mCyN+GObBM2aglEd+QpyUevXNGdy1tujFZ1NcShsZyIKIx3PYg5ir1iFjiWHUmiG992bXMZBYRigVN1/zzytF+woJxmUtzuTsjTeJ8c3I44GEPtEg4LJntoT/sb1wNLgLLXta1RpeDyjGpW6TaSaNdVEM5ZSB5N71hYoy8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(40470700004)(83380400001)(2616005)(1076003)(36860700001)(186003)(16526019)(336012)(426003)(47076005)(36756003)(70586007)(6916009)(316002)(8676002)(54906003)(966005)(70206006)(4326008)(40460700003)(26005)(6666004)(44832011)(5660300002)(41300700001)(8936002)(478600001)(82310400005)(40480700001)(81166007)(356005)(7696005)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:58:41.2568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf891ef-bb5a-4fa8-92cd-08da867801f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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
Cc: Felix.Kuehling@amd.com, tseewald@gmail.com, helgaas@kernel.org,
 Alexander.Deucher@amd.com, sr@denx.de, Christian.Koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HDP flush is used early in the init sequence as part of memory controller
block initialization. Hence remapping of HDP registers needed for flush
needs to happen earlier.

This also fixes the AER error reported as Unsupported Request during
driver load.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373

Reported-by: Tom Seewald <tseewald@gmail.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc21.c         | 6 ------
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce7d117efdb5..53d753e94a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2376,6 +2376,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
+
+			/* remap HDP registers to a hole in mmio space,
+			 * for the purpose of expose those registers
+			 * to process space. This is needed for any early HDP
+			 * flush operation during gmc initialization.
+			 */
+			if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+				adev->nbio.funcs->remap_hdp_registers(adev);
+
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
 			if (r) {
 				DRM_ERROR("hw_init %d failed %d\n", i, r);
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

