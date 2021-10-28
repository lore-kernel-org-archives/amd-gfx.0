Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE82610FC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBE82610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660FB6E989;
	Thu, 28 Oct 2021 14:22:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1C36E989
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 14:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeaxMQZOZxbcarz/cXEqfk4PosqrOwdqfa/FeNdAb69Wafc7gRlO/m1YZs9V9BdVksZ/bdSBdC9YVsVUArD3yys7lfGJwzsD91U0Mkvi0Gr5vTu28ulF+HiqsbaZ1MFjpnEGa/m7t49eVcoF+6L35qbWdmjRsRwZSilzGD/JGJNZmiNQ59Ced6ys/pBA22HuziTeQPuOR3SrhV01CxlPt6GCL/nQ7pNGopNRIB7sxV7+nGbN7C6ZfjksU4PGuwkb8uawED/if9vDCYIVYCwLL0hlFqd/9B6IMyT+WGyD4cniT/soh4L9iO7/hvA83xVuZtrZdXX/yKH3RGbpxrSwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5GnCxim+Nvhl7ScRqSB266DZ7RTw4SYExLlV6MSH/Y=;
 b=Oy2Xt7EN9Z3R0CzRiltDjZ0FEmt8BW1uQQJjEaVN7wJBHGkANeSd78zMwM4AF5uepu5KPfzBHyPFGh3Y/yY/exqXNq7DShRe/gIyaYnmzHYXR7R5aMnf/BGidaoIjU58I4VG+k8ssW7WTyjdwBeO8bqN2Ar3XdIQnrchfL1PIBjKoD+EG/4c47rx9qv4L1xBNE0wH8793/DKbjsEfSDxvoO/+JGnXowzT10xAgWRlxgEgL11lcWU6c5s9tSYsWObMj5MTFTLA5JHS6qOs2Z5Qy2pI0EBFXjgYqozUxJlz7+hmbWe58ZJN1+oSMyo5fGW2Ejmtc5ZcUGYJ76R24JnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5GnCxim+Nvhl7ScRqSB266DZ7RTw4SYExLlV6MSH/Y=;
 b=5hYAk7a4y9dVp8+z6PT+0p12mbLl3o7m+10DnndutoaV7Gv/UWRGLzYy2xPelo3q7my8J+0wP/LIbBZCKiNeKA5ldxzgtuCzR2MM1Sut2v59vCFWW4+plXVgQ4AekyiQlWFQX8da+E09oLD5Z6b4qIYJxXIy0fMWLQcUnVnVDyg=
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 14:22:02 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::10) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 14:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 14:22:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 09:22:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] drm/amdgpu/gmc6: fix DMA mask from 44 to 40 bits
Date: Thu, 28 Oct 2021 10:21:44 -0400
Message-ID: <20211028142144.210568-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b292ace5-337e-4f99-e2ea-08d99a1e4f82
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:
X-Microsoft-Antispam-PRVS: <MW3PR12MB45063B0A8DD337F1EF71542DF7869@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KVq1m5PoP4zzCRcEgdF9nCw9/yJr46TjtQmRjTLGldYC4IdxuE/EFlngL0uAL7aJA/FMowJxnAGJNsiYUVEPo/kdh5g5H/lmkhNmJ1Z7zljFaGWJKyRL83yN4xZU2rXI+OIoy6Ci2BTVsDOW1noKAt8U7odIEfqmMYNL9GLvRMPZRxw5uLStNVkgD1ZoGe4Z8Jkeo+DaPtPrm61DgZyYLO4YdU2OqYXYhxxZxLbL+50SXQX+/AlNogu1SczeytcDlirMtyrQmgXusngsGt1Wj0sGelSFswS8EGqMiQnQ7O+NIcqOYPDRvo7ClPvBFkfKhj3Hc1WU5nN3iHFe7YYx6MyNLhhdTqLa5s+swSes+IZbUKJCyZkISUENaz4Vki66S2PB74rYHtJ1wXuIWCgwIdHhT4U6zw56Y++FT+lFncqIhJMMCINrMUyV7fxkgKzsqYUbDYnr3KeIPMUpJ7OoEQewbCDuq2YBuFe8q9V6EmHXE9PS7PaQakIuJUysnYICbum41w/F5Nh7aLXCrC7Z8PSEnvW0oRLI902Ylb4BxP9uMMdrNf66nTroa82QI2vYKSgmTOH4K5Rd1nYCjigkmu9NZbqQHcs54QlauowFxWYmDXyoJ5Lmj9T/Khsg/qBi4Ur+evNQ91CXHiTmvDxfpHPKbrmOsIBBI44XJ9zmFxaOcGZz8l2z7DsssFna59h2YsVFUje7eUyKUxd2T/kuS5jrFrw4PSn2MyA/EEi/fc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(8936002)(47076005)(5660300002)(54906003)(8676002)(186003)(316002)(6916009)(16526019)(36756003)(83380400001)(4326008)(7696005)(70586007)(70206006)(6666004)(81166007)(966005)(26005)(82310400003)(86362001)(356005)(508600001)(1076003)(336012)(36860700001)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:22:02.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b292ace5-337e-4f99-e2ea-08d99a1e4f82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The DMA mask on SI parts is 40 bits not 44.  Copy
paste typo.

Fixes: 244511f386ccb9 ("drm/amdgpu: simplify and cleanup setting the dma mask")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0e81e03e9b49..0fe714f54cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -841,12 +841,12 @@ static int gmc_v6_0_sw_init(void *handle)
 
 	adev->gmc.mc_mask = 0xffffffffffULL;
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
 		dev_warn(adev->dev, "No suitable DMA available.\n");
 		return r;
 	}
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(40);
 
 	r = gmc_v6_0_init_microcode(adev);
 	if (r) {
-- 
2.31.1

