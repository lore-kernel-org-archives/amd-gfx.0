Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB38C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 07:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8184A10E032;
	Wed,  8 Mar 2023 07:46:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D6710E032
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 07:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSwZHPlbEH9LFv6QH/W2NFmW7ZjfDJTBgzLIfsTaAVtj4U4ESYIMsJs4WP8Um1ZhRoyI6/zBZXvRXc8/r1EQWUTyH2MT83nV0xlL+Z/dh+ENLKgtIcM8FXCVcYcN/UB/jCwsm1v8qzhE11xZbM70aCx241uSpUNOnTA6dCcqRCr6O6eiJEeUFMzIvX7bgXgqvs36jqg34ltO9lyUvoxPSC6jP8DmdXZiCssFY7MI3UOIW7qLxIhq3kOYZG6xbmztPK4E6SORpvFxFNVil96mdoE7Yoc8vbkVZhYIGmf1XdY91JB8CtcJY4zCPxy4Ked/ZNnII4Rj3hwI3uv7Q4Xttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTC9l+j3G+NiTLj+qc/UpPUSen4n6IGqQOEfCBivreU=;
 b=c4W/XofCZ2PaVRdQ0fWQqruWOL1RPcBESOiI1qgSAi3lqe2cElTyr4Gr1lqPG1di9bB7TbJl0L/4WC4C+dR4SAnTVh0+7UXShuPi9poyD4FptKFSk2aMPoHmDQM1rV81q13GxbARlU9d2QyxO1WIOE8SQSMHFewQWeJqREaBEnFg8LlRbuAe8YKd+d5A6T3FmL1Uu0uvllwSdPIP811xEiFfIOWXZyxxfoytEGo0lMxHrMOw/9Amnwxfz+mkf7H2HtZhFxZFujNcAYiogruqnqQdizNj/Fo72e99bU/XEb2q0qQySIp88jbze2QMpORsMqyTi864FNdg5mhzft7Mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTC9l+j3G+NiTLj+qc/UpPUSen4n6IGqQOEfCBivreU=;
 b=1wHuyu0SQODxfDsqYFw3Jap7yXkwaYGhXWMxYXr1JPP4p+P8yn2gurbpdhNiJ71ggew5ubEjNrkEgMug6yYJT/JtKxAjPbwTRGxq/lDdMRo46bpVhVplxgTHk+gzhaYeoIxcbFcX3Cd5hx/w0ie/IV9irNVrUeuIuDchqSnog3o=
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 07:46:48 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::81) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 07:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 07:46:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 01:46:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 23:46:46 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 8 Mar 2023 01:46:42 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Get prange->offset after svm_range_vram_node_new
Date: Wed, 8 Mar 2023 01:45:09 -0600
Message-ID: <20230308074509.264478-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: e97b3370-3809-458e-a640-08db1fa945f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmHV7jySyy4SrVA84MvxK1A6ecUrkczZB8oEPYrYw6tXs82O5Ouh4ur7UYfzDKS4wFvAealOc82sg3Q7BYPNZSR9n1yWnXbPw0HqUwtgZ++EWADyDYCRXAu41bD1sDUz/llgUsVTdUvfvC1641YY1Uw4XzQCJAFRqYT4T7zYqesDpT8oGMu6jAHBpnTQOPsPFk2HWgs5zTjZY8I6Tk0U0aVvPrthR5VdqGz3XLS2ywp6tHZ4yv3VMKmuo+Zt9ARsPX83MdQT6FM3wwxqYa8uJdxamOI3XKb1uCNyGJ/Euozqo9lW5eENA0zg7XviYUdF7EiSGS6oOReOjMtLeZdbtNDhvtHYTcyld3okr76RgSGT3q7zfAXcloaxXXdrSacGLNYGmdxSRvk1xHNI6Q58DZFBfkUya0zLmANT6g4l1WmNQmSiwJVpnA7ewzYWaxbuOmuV/tDXn7718+2/I5f2sDZ5kg9A35qkYOT4irqdouNOOU3SJykuOjnDRQ+Sbj+j/OgHzLz/E+upAwYd2G+HSThg5udxMBaaLc8Vq3F6jySy2DPsYOUgppDt0LYnSfmKA/chwEd6cA2rnPI1gcZHZ6zoRiHU9ckrMo/C6/qY64v/pnZtFbln7mVaeoHt6Bsqd25CN8NbMVyUKCm1zAK+t9OBE48uZ8HFu1k0VzkkFTR+UoK4c+tPBRe0Q+iZPv8npY4FTiCir8aRpImr91ploahtmvZzRLkMvVvEX2LFh/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(4326008)(6916009)(70206006)(70586007)(8676002)(83380400001)(2616005)(82310400005)(336012)(81166007)(356005)(186003)(36756003)(36860700001)(40480700001)(82740400003)(26005)(54906003)(478600001)(6666004)(316002)(47076005)(426003)(40460700003)(1076003)(7696005)(8936002)(5660300002)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 07:46:48.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97b3370-3809-458e-a640-08db1fa945f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

During miration to vram prange->offset is valid after vram buffer is located,
either use old one or allocate a new one. Move svm_range_vram_node_new before migrate
for each vma to get valid prange->offset.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd54a00e7229..15791490c23e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -310,12 +310,6 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = scratch;
 	dst = (uint64_t *)(scratch + npages);
 
-	r = svm_range_vram_node_new(adev, prange, true);
-	if (r) {
-		dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
-		goto out;
-	}
-
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
 	for (i = j = 0; i < npages; i++) {
@@ -525,6 +519,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
+
+	r = svm_range_vram_node_new(adev, prange, true);
+	if (r) {
+		dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
+		return r;
+	}
 	ttm_res_offset = prange->offset << PAGE_SHIFT;
 
 	for (addr = start; addr < end;) {
-- 
2.25.1

