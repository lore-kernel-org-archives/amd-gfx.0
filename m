Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D0EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 06:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9875D10E49C;
	Wed, 12 Jul 2023 06:58:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835EE10E49B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 06:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6KYAodQRPTjR3FUrCCO7Y1k0L4FWF5ePm3HPyMbJE3K4KkwyITAVuEYARtiWM/snZP6jCkmW39wu0fYcIc+J6GJla1swQJ6geoZIvu89IlfuxVuXLERlx6i6WBP6MgLVQ34OEQT3eeX/0qBNmSC5bgcOb1jvh29yppfa/PmWDwss26tpTr3FZXhAkJHEjcOJZQYzTIzOeVoGXz6IIc4KgQChxwDgcpa3Mne96QNu8Kt9yqUZcdgHOaN9eP4eWk/HvQ0g5QNBi+EmF8fiAG3bGA1b0rJQIVGrYEnvgagkYVFcG6TTz7gxVVyQmKRxKsN+QYBJa5dqftCidUYS9E38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww1PkQGa5nQPNULNc1XzMFwIxHNQcDWVbo9OWKcourM=;
 b=EwTIgMqwLG5RTs6toP4UOFO+V4ARqM8Hjpkj3ZBNRt8OvQ8qOD1Q+KJ9unx/5No+MrQcn14V+ZKxm31KigWhs/WQxUNpiykLmVPEwFq0B27EjQQtdz2J9Q/RY8+HL6oZSwoRyvqh//r2yxQiGlgzScqfyHp26dEIqF3DqniaG1T1Iy0vfm7jaLi/4vg0dhNR+5gN6PGJHdyWzfbRBTyYwjtpCXHcsv/AH6Ws6cz+w6MaE885HofUtSsSb6ZD4RQMsOOzKBwfHwA5GrW9MrfEkAy0bT3zhdmyW+BqTBOMxmeEbYGVJ4AlZCXCcjENSK0mpW/IBqsn0SE3E/2nxE8MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww1PkQGa5nQPNULNc1XzMFwIxHNQcDWVbo9OWKcourM=;
 b=iNWUwJAyZn2YLFESdCP0aJcAVX4WGb3C6HIkdTskvz2zcX3v3JJXr7cCQ9yfQ6KC/RnGR+NzjAh6MdtYaO/gJGcwK/3z9p6y6mGwlvTYvHvN/w2hXltlM+nat5ZUP0d8Ct5+wYHl7cumuBbg2dbcq37nf8Lh2/IqS+qOKMHS6qE=
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 06:58:42 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::75) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 06:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 06:58:41 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 01:58:34 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rename to amdgpu_vm_tlb_seq_struct
Date: Wed, 12 Jul 2023 02:58:21 -0400
Message-ID: <20230712065821.260061-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 887ad050-bdbf-46d7-4919-08db82a56d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAIGwtvtAP+xTgLI9LjhA1y6N6vV6pAkU2mSIXM4wssRqeFSmDMym7C65Szw8Vc5CgfEy5mWkxF0Y/P/CU1/wTB+f3PDWiGegKVoTWLsIQ7c4lOyInH5DB0HcWEOJVTEn7ZNVLAs4jfIWOvw28+erG7cVPWnpYmx0JN/6ABChatugAGjZWieYXmRrdztGK41bcAepCjyfJYfNAaygYXBPxjdJK0/0Q2O6d4Dq62LJM31pOJ13zorH3Ngdiw10i2H0xGIBnqJ/xrm+E5DxMd1ukw5jbCufXHVduRb5rj8WvZ5UkItcNU7eYyQs/NH1H+7rR8ECoD0FuVkC2mP2kbTKW51eswOjj60GAyR7GmN1zZJHx4TCvXOkTbx/scNATBRXnvyV4ZdDgPckvf2yOlIRpnx/qpcPb1sezYy/iX3Zw+eCYbuZGGaIfGCc5QeFMBy+0vWetl6h2nWqADJWpSbBkmQY2BmB5MIcITwdi1nXxiX0GkE6fPDT0837w0BEo6N/kqf+nVlnc/vskH+sUgsu620z+6fqHydR3FNzcxMSrcRbVYUwBPB5lnvf4gcp5zRlImE5ZJ4OQmjjMWs7R6nqfnsb2C68laaJD0JYYjGaufYTV3skaM+BwHnBhXI/VCyUO1kkjhDmVeov5pV7TqZaDUjtcD5L+XIJpnD82aju/lxbEByS2WJyJdKBw4K+/iYfZiobS5UlBohkJoiDpmhXk0Hx76zjEt7M0E5T4oTadppt+ji8BAN+mj3j+dRak/NngAlkEsU7470uR0Bh64Wag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(7696005)(40480700001)(966005)(86362001)(6666004)(36756003)(336012)(186003)(1076003)(478600001)(26005)(2906002)(40460700003)(82310400005)(82740400003)(41300700001)(36860700001)(83380400001)(356005)(81166007)(316002)(8676002)(16526019)(8936002)(5660300002)(44832011)(70586007)(70206006)(426003)(47076005)(2616005)(66574015)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:58:41.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887ad050-bdbf-46d7-4919-08db82a56d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename struct amdgpu_vm_tlb_seq_cb {...} to struct amdgpu_vm_tlb_seq_struct
{...}, so as to not conflict with documentation processing tools. Of course, C
has no problem with this.

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 92a84e7b0db85b..32adc31c093d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -111,9 +111,9 @@ struct amdgpu_prt_cb {
 };
 
 /**
- * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
+ * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
  */
-struct amdgpu_vm_tlb_seq_cb {
+struct amdgpu_vm_tlb_seq_struct {
 	/**
 	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
 	 */
@@ -833,7 +833,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 				 struct dma_fence_cb *cb)
 {
-	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 
 	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
 	atomic64_inc(&tlb_cb->vm->tlb_seq);
@@ -871,7 +871,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;

base-commit: 50db2d96b49b7d6cdb12e71e4204cf7180d3bab5
-- 
2.41.0

