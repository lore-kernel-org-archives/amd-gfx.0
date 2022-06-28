Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DB1C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 00:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14D910E826;
	Tue, 28 Jun 2022 00:24:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F1410E510
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 00:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7Dpjtrf17aKEfdGATHVrDUZTUX/HGvlqQNI4i+6jUgGBPUKAsRf9C8ial7EqfccpbM7pb7ZFiY4F6z1eDsXezv6d8vimiKFWCxKatv1kMf9TreMjESTwX7TDsNptlyo9JnnB334z1zTv69LHnIF9dbQVU3oZ/rfiAG9RyvTRujW47o0HHF6wdtZpfMwDlDS0zBChkYUGGJT4WMy277LkPySIPPTPxY3y+Ym8yF7PaHAg/dUHN1oDIsYtzjrcoxRr0/2scj9kRKb+2DCUcOwgakeqzus8sw2us+AHeovvzO9mC1Gjp8JfQ9t3SvzlaQ+P2e5dFbs/9d7c3ETgGxkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ris+NSf4kOSJzO3D68MSV7XzmcYZwx43dZabUO46pPs=;
 b=N/+hUcztoLEPgowk/IlP6WdxreCCxCZzNNlAWqSwd9YaPmaOfB3FtI2qfy7to6iltRBrl29PvYjWcE9bBSwDx7RD/Pukgu6KETZNDxS4wJFHEIno/iKRNQrj0ymBPHm67KxuceGeVAgrRRY9nTrVajUurgSMXyKO66Wt8Dnzf4C3lqPrhyeRWoXim650dX5nzWyMIhMOpyWxn8zflKvJammyAo8/Wy1orDN3pwTeAwUIKHLmeO4StmEVPmtl9Z0gKh9yMv7dVcW5IAdpm7gPoAK4eD77OYJCQQJCwJZgx7Zj53BHC2y0lLLc+mVxWKbwgYvikY0LTCWQ5IdvO+HkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ris+NSf4kOSJzO3D68MSV7XzmcYZwx43dZabUO46pPs=;
 b=Wye/v17iSYoldTcS6HWejEBOqBrD20DAoD4B7CkTl7io3Uzi4UWiRqbQZEfvLSzPW8a3WrB9m31A3dyxRjg4Qzxq+8uMCLdQNuectLrOoSGb31Si3k72migqeRoM5GWXFt71pN0dsNJ6Wlf5jDNzB5xWKfas1y5Ybpdk0VuE/AA=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 00:24:01 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::84) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 00:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 00:24:01 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 19:23:59 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add debugfs for kfd system and ttm mem used
Date: Mon, 27 Jun 2022 19:23:47 -0500
Message-ID: <20220628002347.3982-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628002347.3982-1-alex.sierra@amd.com>
References: <20220628002347.3982-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1576bb2b-d85c-4519-5089-08da589c7ffa
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD52ves5WuSbUdBsKkheiY5IRVWr17WUnX/0bEw1CKk7gKkUoTdozmzgu8nfLK7zpD25zCo2boVNNoK9Oq6fDKDexpd5F/Ib3cphKRMJETgj7OtesjK9i+SMi6JDL789MkrRCOg7GT2bO0AyOo7iCRmjZK8cZsOQULEaXMojJIaZEmqpZswv8hUcIiFo4JX+GqCxRP5T8RzFSjk6hNHFZc+Y3Y7rWoOdc7y98Phq03o8a4dN9boEbInkOxOZM3tyk0XnpmVSqkDl50xadNW1D+BFcA1EqOyVVI33boXB1dlSoqZA2rA7hDxsTg/Sc/zgxRBw0ySJtx7UtVG3j6rX9nQPc8v4uMZdfqZDnqWaVVqeukkG8FQYLo1x8orgJ9WQySyZDitqldQnZYVvccLx+U+uUd4pZwibqv9IMOxka/bMeGDAab1WsVmilo3yQ6poyd0PIfjieccCeUxQJdCxqgEd7gLdNXoYP9kRa9UEEOhK4/nQC5XU9ilQ2/6AdIn2r1mZnoGrBI/lnsOkha5RrQYcNgmtiYty9ZncN9Bh5verciofieDFg8EclDX8YbzNCpMUcy1egSCSAFgGHmPdDJcoXpVDSTaMBhqfRe5BfBZUvfsllCUQO/GuMsnJEr8Y6hsnfCogeo71FShmRaZfryXx09RkowLmmy52IEwcXCHe/Vyvhn5DrnPAUmheVxXxTHttD+l3ylf2W4vhJLQ+uQEBudVgLnYcZ+9o/QPwwgHTM05EnyqEcDzaUI67ZZG6TQr5C558B7QOioPueDuPMcBZNatWszCrFcjIY9BUdhJFNbN+ModmQMw4VvOOSteik/7BKLKmu0eXm1DHYAl8IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(40480700001)(1076003)(356005)(6666004)(478600001)(44832011)(2616005)(70206006)(41300700001)(86362001)(5660300002)(4326008)(47076005)(336012)(70586007)(82310400005)(8676002)(7696005)(26005)(8936002)(426003)(16526019)(186003)(316002)(82740400003)(81166007)(54906003)(36756003)(6916009)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 00:24:01.0350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1576bb2b-d85c-4519-5089-08da589c7ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This keeps track of kfd system mem used and kfd ttm mem used.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e6244182a3a4..53cdf7f00b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -172,6 +172,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+#if defined(CONFIG_DEBUG_FS)
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
+#endif
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9719577ecc6d..c48557b683c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2935,3 +2935,22 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 	}
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data)
+{
+
+	spin_lock(&kfd_mem_limit.mem_limit_lock);
+	seq_printf(m, "System mem used %lldM out of %lluM\n",
+		  (kfd_mem_limit.system_mem_used >> 20),
+		  (kfd_mem_limit.max_system_mem_limit >> 20));
+	seq_printf(m, "TTM mem used %lldM out of %lluM\n",
+		  (kfd_mem_limit.ttm_mem_used >> 20),
+		  (kfd_mem_limit.max_ttm_mem_limit >> 20));
+	spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 581c3a30fee1..ad5a40a685ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -101,6 +101,8 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
+	debugfs_create_file("mem_limit", S_IFREG | 0200, debugfs_root,
+			    kfd_debugfs_kfd_mem_limits, &kfd_debugfs_fops);
 }
 
 void kfd_debugfs_fini(void)
-- 
2.32.0

