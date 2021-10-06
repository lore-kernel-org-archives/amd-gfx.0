Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A0AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517E6610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 517E6610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FCB6E4A2;
	Wed,  6 Oct 2021 14:32:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25BB6E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1r4LddKTj4IQvE1woEFx9lc0nuPffto49VikbTtk/wSEZ+Qg2z/JlarqDPLeTAa8etJlIBJN0/fzFwyj1tV/PpcF0vqH3UFXPIcazEtrt7WLCuI2CLQtUYantbVRRYaCs0iAKHfHm34HyILglfp+izgnGh0PnKX5Fe0iFJt/yIMqt+HQpnydDMx3Qt6Ad6ltwefvCDQwEhcK7TxQq0hUrLV5Wa3gtTKoKs/Mgt+r0BWhP8/MSG8hkqic6vHQYUG+6dVvs/oacdjZ8QqDiU3WoS79+bMcdqTN/hlJufhvQ6Au+bcMyywV5QJYbjB3JNecp0PsFdBfyiHNbKHTbQLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdU7dFR1HV0nbUqyK+/0mtMn1LVhSqeitclbslqxDgk=;
 b=BY4mnUCLxiSjHNXPXbjypoOmfDo+eRxrL4vhx85U1DVymiJsvogt/IAeGKbnXnR6ZbCfaw/toFjGz4quyCs+lGT4kwzemPOeDZLc8OfZmnsDsyRVaGDz7FqgurRCXmuw7TMQnPlqv9/06bnRgHz5sw/XVelp86BilZ90xX/toUww5GdqU25SAYP8GGFyZ0+/GZBNRRWhs24A0j/yXLubsFyg7eczBiiq5ff6QpmvBsfRsWIsbtqqq7aPHGswGSeiGyxf+UmH6TZGalLKc7PX/Qd6wJH4csqYF7arD/B+o0xD8yH6IalhrHuYNnl2Dw5C89ml8x+zREon0NktX24Gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdU7dFR1HV0nbUqyK+/0mtMn1LVhSqeitclbslqxDgk=;
 b=5PZgtPmBy2CC2BiRRmvye+0Dlq0hpG16LPuPatE6n9BbKVbFU5a3SCbg2wNpO8qBSzqL5XyZGhTEWDNYdbD69nVKCX7Fp1sEOA7mi5Y22Iv7NymxWts538urxtnITUSsoNeqER0B9cix5Eeg9f9h+cFFQF4jH5smIzTVBG9Am48=
Received: from MWHPR22CA0008.namprd22.prod.outlook.com (2603:10b6:300:ef::18)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 14:32:28 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::90) by MWHPR22CA0008.outlook.office365.com
 (2603:10b6:300:ef::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 14:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 14:32:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:32:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: handle partial migration cpages 0
Date: Wed, 6 Oct 2021 10:32:08 -0400
Message-ID: <20211006143210.4954-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211006143210.4954-1-Philip.Yang@amd.com>
References: <20211006143210.4954-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810efadf-6464-4c8b-e6cc-08d988d61fbf
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5453:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54530045B5FCC469A22F8FDAE6B09@SJ0PR12MB5453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W7u9PophmbhaPeoS3QibIK/RINiPwpcbKlPyJY7iOiyatq4CEG7r2eXGrJdRduhrSg6TU0IAX9G+WMdivuarYA0XGr008tsLhAIDNOY4TgXuWXi+P4zj3mcgcJQRd+3KbF1HoX8Zh2RNCbNCpPC9jHPPW7lAormBL3hP0dEjOOcBO/VGXLExH6sQ58MGv4OdZ/SAiKB7d7VwZW+BLwBTM9UC7fIcO2oaLPe5LS+N0CP6KusCmaJyeWF5H6BY+ERZfDUy3hEkHQmnH9RjeMlixldcHys1fnQXtJnTH80fufHwngFEPCTpFiET0dPrhnn3yH8Kv7Uin/Q7R7UCSi/Lr1YpwYoeBYQ1Y0k6i61vpQerInyiwtWI3Z6BKKt+S0eTsbuG9cCMz5xWVETppFmq/fL/+hhFY68VjJVocjSn2T3rX1qnp/LkVPSBSQhfuk7Wq4+b/ysEN6QT/NWcrIMPVB4Luz5S9CTstJAkVDBsn5jBfaNOfXX0dC3x+jejw9VlwlEBjh0xRtGXaq9+VqFnOOXvMG/qSauPXscs79S3pY4nIkvYGvxTruDMz5Reyv28x2RmgvQRg+zXZraPbLbU0trDnSEYJpUxK+hBIWAHvSkseD5hzLOtaUD/hv+0BnlC2a/fAbBBYZeXwwuvB4Xbb66B9PdBFQ1zvrSyzKaNyP5uHmy43LkvOG39ysyg6EZDzi4u3p+yIHxjk/twNPzP2nOzgVG7ySZkV818PKPeGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(83380400001)(81166007)(36756003)(82310400003)(16526019)(47076005)(356005)(2906002)(36860700001)(186003)(1076003)(426003)(7696005)(4326008)(70586007)(336012)(6666004)(8676002)(8936002)(316002)(5660300002)(26005)(86362001)(70206006)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:32:28.5245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810efadf-6464-4c8b-e6cc-08d988d61fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
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

migrate_vma_setup may return cpages 0, means 0 page can be migrated,
treat this as error case to skip the rest of migration steps, and don't
change prange actual loc, to avoid warning message "VRAM BO missing
during validation".

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 48 ++++++++++++++----------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 069422337cf7..9b68e3e8f2a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -409,20 +409,25 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			r, prange->svms, prange->start, prange->last);
 		goto out_free;
 	}
-	if (migrate.cpages != npages) {
-		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
-			 migrate.cpages,
-			 npages);
-	}
 
-	if (migrate.cpages) {
-		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
-					     scratch);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
-		migrate_vma_finalize(&migrate);
+	if (migrate.cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 migrate.cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", migrate.cpages);
+
+	if (!migrate.cpages) {
+		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
+			 prange->start, prange->last);
+		r = -ENOMEM;
+		goto out_free;
 	}
 
+	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
+	migrate_vma_pages(&migrate);
+	svm_migrate_copy_done(adev, mfence);
+	migrate_vma_finalize(&migrate);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -636,19 +641,24 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out_free;
 	}
 
-	pr_debug("cpages %ld\n", migrate.cpages);
+	if (migrate.cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 migrate.cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", migrate.cpages);
 
-	if (migrate.cpages) {
-		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					    scratch, npages);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
-		migrate_vma_finalize(&migrate);
-	} else {
+	if (!migrate.cpages) {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
+		r = -ENOMEM;
+		goto out_free;
 	}
 
+	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+				    scratch, npages);
+	migrate_vma_pages(&migrate);
+	svm_migrate_copy_done(adev, mfence);
+	migrate_vma_finalize(&migrate);
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
-- 
2.17.1

