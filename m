Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F3CC7EE29
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 10:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F2C10E364;
	Tue, 13 Jun 2023 10:46:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0926210E367
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 10:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCgK3vJvVB2EG/2K0tM97k+TW1V5iGW42fuuUWI5cqfrUp1rvCQw6CvYrB/qCt2CBhxPDIL3DsKS/AZ8WrxiItdG3QoEXP3gwXf6/n09ZLSL7sr5mSQvezu0ympJW8MlXnifwFTwtOroCIFi3OBe56JeHGOh+eukR7ij/iLzLD2z/cQfk5EjNXKxHq7N8gmYgHkJhF2G4QSPzCZKb0nVE1h+WRFyrpJ8NGkDrOO8aWBwpT8TeWPQiQ7GQsyrUoHDQCeKz5K7uhMhrR1T1lX6rqDSCoOz3NBz97eWDE2s2nL2ZDlt1RthvubKRa21f7uDT3RXIEZhHh5bNXws0bn/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRq0F6/CvQ4vb4dEaCx4BoHbLSvGFzWE+/mRlFA5H6w=;
 b=WFCuBMEQ/97mreqoDR/2f2B+xiL0l3njjFQvxy9qgNNb4ld560e1UsvD9mBplCFBT/CzyyQ5GRzayYJwlb18ZzDnjYF+MMqF3R0o/4In46TYFvTrBvmQQ/a4xAarqcOKj+jYVXtZXzDZ/x00rGkenCgZem3DYWthlFwxT7JT/mD4gTAnZA8NwoZKLoxOFtwVbjkkpSXyfgFj4fBr7WeBWpCdzPRqSh6NLsbXdj32QhbG5kXJCPkWh/76E6Uv/I8PsW07Tkvq1kXN10xc/9l99sDxr95hAeflUONKu8ErhFMckVAlsWq5NAxxbM6TnYVN2+0ONiv2VwN8zWRabgWnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRq0F6/CvQ4vb4dEaCx4BoHbLSvGFzWE+/mRlFA5H6w=;
 b=AaqQwIEBObJYxq1ep8PXKSseoU2tiHrstRLdViqeQ5XBPk6pLPEVYXQ7BcfJF8LPFT1BrLBJClor23/FHNGjeobF4n6OozLwPg7loofhR7ANJ5JFiW8LIs2kny/IkbaxRDF0OqvHXpeqUTG3cjumm2hwBMxnqkIATMWiuFJYphk=
Received: from CY5PR15CA0241.namprd15.prod.outlook.com (2603:10b6:930:66::10)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Tue, 13 Jun
 2023 10:46:39 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::6b) by CY5PR15CA0241.outlook.office365.com
 (2603:10b6:930:66::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 10:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 10:46:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:46:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Release SDMAv4.4.2 ecc irq properly
Date: Tue, 13 Jun 2023 16:16:21 +0530
Message-ID: <20230613104621.1545379-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: f15acaa6-d939-4a3b-7746-08db6bfb76ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFtJJJSEQGvMv9UyQKBpLGuQqi73QyJkBOx+bNL65TFJADhJIf3TLv1T8n7vIoTabJ4KuVdge5o5o2uwes3NlnNFZrFUFN1f1Xobw7XRbPy0x31Kncvjg5VhJmzQ3/eS2H5jqoQ1JDab4N2u/wXB18FWc/aUBilGBLZZ4igl/PDeWqgfPFWmAN+1Epzzb1oAKlPkrwSfiENlbUReaiZJ+waMNj+4/iIqC10QmSS94V4IoIgPjNFt2QkxgDhTR7BD9Y0vLdbn9mp788tiJ069YWC4gGrJ33xD6wRdnGrxe0W2PjP8Nh9BNP7sQ8uXGduEIR1ZJdlIsGePLUAizGVTZWnokAi5adsUkbdaBH2Z7izrCq03f0LTsjyPIfeuysODzlqVSo6ElsJ4WfEQ5cpLR9MXZymMXIxXlFojbA9FXHYYRdzSk9Baceqly29x98i0hnjJyV7E7ndM0Arayu/c1X1o2a2cZV9bJ7ogt1c6hJYpY9ciyeTJIXhsy9/olsPkYrLj+TB895uEYOiwrvPUwNjkDdX0ceiKgge2fYTsgPoY702E6Rquw3WuQsfBch/XNT9WlHVeR780pFXrGAqm8HgWy5qgWYfTmpnBZBQllS3FxuuxXVuzEcHKbmtsPvKRil+FIboi8Q2s0rIlSlZZgSjxlOLkpEJo/LkjEgM0eK+IOgFsYCGDLsEzpDLT8qWDYtQ9q7zPN153c5bol5N/pXaKgL1fyjUSeRDl2nTOW43AlO/0SbhiGc9ioiDCRl6F04+lzDko/mOkKEGnkiLkPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(70206006)(70586007)(8676002)(8936002)(5660300002)(41300700001)(44832011)(4326008)(6916009)(478600001)(6666004)(7696005)(54906003)(316002)(1076003)(186003)(26005)(81166007)(40460700003)(82740400003)(36860700001)(2616005)(16526019)(40480700001)(356005)(83380400001)(47076005)(36756003)(426003)(82310400005)(86362001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:46:37.8357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15acaa6-d939-4a3b-7746-08db6bfb76ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Release ECC irq only if irq is enabled - only when RAS feature is enabled
ECC irq gets enabled.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 8eebf9c2bbcd..77ebf27981e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1434,9 +1434,11 @@ static int sdma_v4_4_2_hw_fini(void *handle)
 		return 0;
 
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
@@ -2073,9 +2075,12 @@ static int sdma_v4_4_2_xcp_suspend(void *handle, uint32_t inst_mask)
 	uint32_t tmp_mask = inst_mask;
 	int i;
 
-	for_each_inst(i, tmp_mask) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for_each_inst(i, tmp_mask)
+		{
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
-- 
2.25.1

