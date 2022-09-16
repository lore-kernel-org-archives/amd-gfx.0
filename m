Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14249C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A507810ED75;
	Fri, 16 Sep 2022 15:05:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F6A10ED6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg4nLDiAMjScX/OGHjHcSmPBu2wXKMusUWh03lOcJTfWD9bOKrNUK6TJ5JbAQnG/7eUy2MeWicWj2/fNNSZVVsMmnQE2GLa6XM3F8NB+QI5MOtLjxkSWBFIXQtmk8KPlPU1NMJY8TiIaDxQ2vbVuITSWxGukW7odsEvLVTDXQYb+sUzNDeaV3nxgTWjG1OyL9iuHuhLZT0MLUbudvSKYB9AwDMlrYaNfXG/tX4B/uc/le6FLwYZ+G/QEdUuBUV28Y47mXFPU/Z/seQh1TBmDtUQ+Kol8eyIDwYI6wFhJNYqIjBZZGy2QfjDNZ5H4yrI+G3s37+z1HwE1Gr1mTtxjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmM73gYM7UrI45RYxurALW0e/9utItHkLhwawye1hMA=;
 b=BBHbD8dbxezuQRdZUgBLcLIQ845ezQa8AWSvThdBD8GT7NU/MAhLPpuCXN+sSSucj5Im/1Oi+LClyDh2fjt+i9jUUyUCDDWDrzaF7qORqaKLEWTBVzRsbCsptdKzsKs3P+YUQZxproVrAxSgsKKHx1IBxl/Iv36ewBw7NaNl7BYfcxK5IbZOS7iQ4KRbmbAO/96j3dnET9A7V56m1fdqfQxNXrjRu+XWyFAZA290OT9ubOcpvyFgkhYIvmzEuHIB4L8xfxem28UrEvOGXdHJp6Spy7Vo4APO0FzGwPV4oR5ke3XnRHBkVyGhHbOtRhbqBHvDY8L+3zHNoCWA+rVvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmM73gYM7UrI45RYxurALW0e/9utItHkLhwawye1hMA=;
 b=YXvTlSEqptti2hrtjA4lVeAZWfd8aKzX//DD/G7TgeS8FaTzKMMk42JAl+RcXGCRXn/kZkRZ1+itaLNmrS0KaFZNSS5hhwNi8+OKVrHqX1jlQOi0kXk7oermhLoJOt3MGSPyDFaJmcbH7nWcw/HhnWn+aoUiVT4OJH8fH3Xvl3Y=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 15:05:26 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::86) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: Use vm status_lock to protect vm moved list
Date: Fri, 16 Sep 2022 11:05:07 -0400
Message-ID: <20220916150510.31321-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: d3082976-e6ff-49a2-e57c-08da97f4e2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkjXIqh4OzYoHz1eHIHQKt5IIi7vVtoJdlwzhtjeXX0EVYhr8G4xykJMA3T2Wcyx648vwAGZreDSl/0u9ooFiOYDDGhBXsV9T+1H6XkocoTwO2z34F8yLaNiupJrQd2qgzPQUqBzQVi71rW/bSP3RFq80u6QfiRFDekLbfkC4txy+KBFtcGY/m3B/3+mlDhXKpEdgbQYOSmqTkHIuejtYujSweR7F7rlCd2yzzXN6JI8hDOWhMZPyreQz9aRfeF2DOrAs34YXCk6s3iUIaUqBBPtF4HkepoCRba0nYC5UEGUW/VjD09bFmdeZtRpMDHxsLcVujvYTa8PHDBRKdjyWJAzUgQ5E7NHMGPQCIe7E/2GBTraIOZdHDlbEMnpm77RkISfBhFA/z9bO7XPiDGE5P5eXBLeU8b56AZRPVfocKmSeGTrhRaBD5v2Up/+riyJffrSGJ98A7rObLizvUWwb0Tskiy1/QHoJqiFf6P8HVqti/VPDPh8olmtvqVUOeEVIiopw8Mk+6mhy7/V4w9R5X9GphCCDYK9HtluS1pqWrJ62HqWnqgXTThnAEXiD4FJjQ49t6JREWdyFPYcMinnk8zlOJxdK2+D2ETeQPRybkibMeSmX8fBtO44QdUoYRnYCrCe2qA1eteltFpUA5EshREg9+3yE1+ioCWJ9DJnT9oP4PbTOCkKW3CaWaZlEHQacgkALLFd9dK1hmJI0sHvyardcaF100+W/HuMe+jQgikMuremGvJlST7bHGghK+mQ1h789vigYXl4Hn4er4QEV+u5tw49DfvK5/rHD4XkklcoV/Y8NsfDBXuS73Ijb+fs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(54906003)(6916009)(70206006)(86362001)(81166007)(36860700001)(356005)(70586007)(82740400003)(83380400001)(186003)(16526019)(336012)(426003)(47076005)(5660300002)(1076003)(2616005)(82310400005)(478600001)(8676002)(4326008)(7696005)(316002)(6666004)(26005)(41300700001)(8936002)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:25.8725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3082976-e6ff-49a2-e57c-08da97f4e2dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c3412709e626..d5d170de51ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -198,7 +198,9 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -1287,19 +1289,24 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm)
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
+	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
 	bool clear;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->moved)) {
+		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
+
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
+		spin_lock(&vm->status_lock);
 	}
 
-	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
@@ -1396,7 +1403,9 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
 	    !bo_va->base.moved) {
+		spin_lock(&vm->status_lock);
 		list_move(&bo_va->base.vm_status, &vm->moved);
+		spin_unlock(&vm->status_lock);
 	}
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
-- 
2.35.1

