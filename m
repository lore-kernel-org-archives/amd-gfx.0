Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331E0CA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEEC610E9A1;
	Fri,  9 Oct 2026 15:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y5zYrKLk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9394310E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUkCWizgH4AN+6FkjHgGbdftSZMi0Z9NfL3bo/3wcGSDTvqbqrlmwzAPiaCkANp7x0puAFSYQAnmuX85treoec86cgAT9RiA4jazI5FimpBo99rXSsUW9BLiFxRHZXpWeoqUgZZtrs/FM0CEkSkkqtHzbEMonmteunkptKSBj2fID7N2C7qX1Htn4fXgVzFKnJmiCQ092oqogMqCYOm3Dk9b2v8FIDxLQzd2F/5d8cZEntmOQWGT9lk9HQD2ztAqDDcMpwcgcfTqc1tkci4S3F5rXsC1Csr4toYdypg4CKqPg6HZB97gkF2QW2tztL3/yHNCY8utPWG4d3iY9zuRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb7I0IJHlkLbh01iHgE1UbobnHqkxcKWCNNjdotauMY=;
 b=kAtBm8VoWI55bFtmxYNeiY/bOY+fcc1Q+Dkd6wBssIbJuxTAi68hDa/HbECI2/ZzJdLGRp7YCWJcPEzzfLKLXtKC0Jz6JbRcGEOU19MKwALojrC0TI7dO7z+MLUMOG6tZWRzXbsHXyEiM2Qdst6WwMCB4vqBU8741vnY+ERwxHj9f1TLE71tp6YuUAqrU/g5zD0wKeQTn/F3vfxQCgqFmiZgUXZsICFmgv33NfEBT7X53PaVbPadFBdf5HajIwk4ljSCy8l0C1WwzpVO3laZxTiOVW0FBoXJhHnEivTXNzuifToXXDPaBT5i0+wm+8MTEzUeB38GYqPnFV+/TwxkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb7I0IJHlkLbh01iHgE1UbobnHqkxcKWCNNjdotauMY=;
 b=y5zYrKLkFncE9FeWgjcLUpN2ziSgADAX0Jq4Atyf0cmvWNr9l5oIpIvJ1LK2T0U0qpImgDDlaxSr+zlMRWRXnpqBKVUMBFfie3VxPsPysN0nxhieh/Y3GLrffH/XPrgAu5qpotwntKF4YmDzyml1ZlzTDUef3wOCXbsu5jtEtxU=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:02:49 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::48) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 15:02:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:02:49 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:02:43 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy message
Date: Fri, 9 Oct 2026 17:02:31 +0200
Message-ID: <20261009150233.90598-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c056367-9be0-4d1a-f030-08df26166272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|18002099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jFvlMfM7s9SF1RRFD6fVhnpT1T7qHEI/TVVmS70cM5kiEe4IIVtmeMYUcPDtE9hCL/oRSqInqZ0E9nWZFnjki9JZlK7qBjaNNPPAJLEgsZogf2wEbR/HcOd9n8TcSghg//Vt5j2cuOyPRU19SxT2P6nQKW/XVjSPC2xJK3/xPi3xWHg8FYAukHFKxM/t4VMJXQtmY4+rS6+8/r8gr2w54EfTGGcdsp+qBavQtRSshDA55K97pGeE+qsVxLfBxgQkWq8FRIkJE7JBliaha3RtSeoKkntbeBatG8R2OS6IVWiAN+r7+WvrWKvUIX+NqCD46UtHaIMXi1lFWIjSXoKfL2+ULBVJ1BJJ34RiicVprf3uQDHmB+1TnNI6ELsqfDsKoovNvgaMdhAUyxz8NLnHgIALKzAReczcVZlZUIs05zHQVepyPSa/VPVLHgUz3YsCpD5knzWSsw/+JM48kLAiUg/v8wqQYNe9lJ3ch2BfnxjpseXqjP1OzC/dAaKX0pL8ah7Id/ambvohTA1u0gt8d9MRMp1F7iV9skp/0YbagE250gcnuYdrauk2PpxwbwfezVaxtZBz5d0sWrc6p/Mez8sYOHLVF8ZD1VJzP/1Mf8ph6HTLunBmf8auLQScvRhYZ1PjzjZ/Ndda2ePtK6uVgdRsSfpsLBd8us4SGYVEchQCq7oawidnHiMt6LsJRXeXVWj98oOhWHXQP/LhNYqG0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fuNOJksMnlPfm67JtUiKBtTntbUvMNPRSOPSlgm9q3M6Yl6iGUdIx//ZCyFLj9i4urjwMIqgDEbc1SjwNzeS3PqwBZ5qjAgfBrC+KACtapiOI9sGNXTi1JdSiZhOmSeI6z1gaorMN3dMOuTARmClwrMy3F73F7EkJOHW3mWLFfZngIe5VJOsjcIB9Dl1a1Bt12aLETyFaqrA3nCbNH0mxs19ibljFXAwH+X1L1yU6RBLppkUUeyA5CkePHPIzY9TNFvV/t7ODRZlesFM/N/ix/wGoNE6I2sj2lnATdUz5cmsj9eQ+jk3k4DmEkNCVnlnRTNREiyXmMcoB+rihi+8m7ObCmaPN/GPXyra4+UlgENU6p+B0Qs0oxMH7CjmHuz7J68OwNkyTQbizL/Nai/1kyRaHJxmQWQcVaSbZQhdTXjCnbQqNaKlknXA5hv1sLVD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:02:49.1711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c056367-9be0-4d1a-f030-08df26166272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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

VCE 1 and 2 always output feedback, same as for create message
we must provide a valid buffer.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1f7a98cdce5a..39d87f3df9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -558,7 +558,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	const unsigned int ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	struct amdgpu_ib ib_msg;
 	struct dma_fence *f = NULL;
+	uint64_t addr;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
@@ -571,7 +573,17 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	if (r)
 		return r;
 
+	memset(&ib_msg, 0, sizeof(ib_msg));
+	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
+	r = amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			  direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+			  &ib_msg);
+	if (r)
+		goto err;
+
 	ib = &job->ibs[0];
+	/* let addr point to page boundary */
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
 
 	/* stitch together an VCE destroy msg */
 	ib->length_dw = 0;
@@ -585,9 +597,15 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	ib->ptr[ib->length_dw++] = 0x00000001; /* destroy session */
 	ib->ptr[ib->length_dw++] = 0x00000000;
 	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0xffffffff; /* feedback is not needed, set to 0xffffffff and firmware will not output feedback */
+	ib->ptr[ib->length_dw++] = 0xffffffff;
 	ib->ptr[ib->length_dw++] = 0x00000000;
 
+	ib->ptr[ib->length_dw++] = 0x00000014; /* len */
+	ib->ptr[ib->length_dw++] = 0x05000005; /* feedback buffer */
+	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] = addr;
+	ib->ptr[ib->length_dw++] = 0x00000001;
+
 	ib->ptr[ib->length_dw++] = 0x00000008; /* len */
 	ib->ptr[ib->length_dw++] = 0x02000001; /* destroy cmd */
 
@@ -598,6 +616,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 		r = amdgpu_job_submit_direct(job, ring, &f);
 	else
 		f = amdgpu_job_submit(job);
+	amdgpu_ib_free(&ib_msg, f);
 	if (r)
 		goto err;
 
-- 
2.43.0

