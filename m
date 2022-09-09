Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCCAECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 13:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C3010ED35;
	Fri,  9 Sep 2022 13:12:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BED10ED35
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 13:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM5GoqVt8ddDHiRqJZvtSF9Om9/VktB7xvJ8gz1mHF1GhgOXj7PbA++5oiCzDJSQFG0XcB8lXC9blKvHrNFxpDQ5+DhUXUAQP9vfLmQ3SxIXdj2dIhRC3S4ZqDFTmP+SgJjdlCLHtKV4b5T3wcGZvwA+8sn1hnQNUb5gVoiTW5Yy8rW3YekKuEMN3icpj/EXEhNmVaD25kA1k+1QNXHMIba2Ho+ggwnzIS4ZdH8lrRLEMU0tk6OvJzxmH5ITUl85azE+eW9I13S6cCXFo38moFWaTZYZasnHS78i9SuJwkLaZ+rSUEBiLis0vQKPKxFOJb8Vfhojbps+vfUu++A4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55YzeTPGnL5UZxi2dFe2zkaW+S0682wH8yBvheICZbA=;
 b=BrAgsaSq6Tur62/cttt3jgOLn7RfW6IlErvkBCIo1aAJg0KcUutXH/v+LCTiE96Otq8fB3oILHFDbVvgFCYfbI3L+Em4v/BrfGWd+XVasNeu8xDoC2kyJYpDXDCCaoSblnCanN+abOnheh0m/fNH0m67s7I71WtE/aICJk+9qnW7EvTW+HD3mb3vZmUPQyjHcdLP+S3wc70HyXLjvMm8eZL7PsQaONDrtpmFMU+S8TTThmfbvsB3kb/JPRSDhDib5qwNcMJ40RDYanLb4B1IPMYR8YJLgV3hyQDfHEnwYcWX8ExHQ/Jg9+XAlGheADEjXVXdOmetx8fcobAa0Ttsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55YzeTPGnL5UZxi2dFe2zkaW+S0682wH8yBvheICZbA=;
 b=kCtzzCOzgD3v3s3WCWRZ2a1F1gFp4q9qgYQDu+w2253yXEXO+8agRiKE+R5pdxcnB/NAWmiIcOQViN+phMGZY/7X2GV4nSINkfL/n70KHNU3eqnBAP1ylYF820qd9AEiM9zwvBhzqn37HkDS/oagdMsqim5Y8DZmUR2L5AsM0hE=
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 13:12:37 +0000
Received: from CO1PEPF00001A62.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::de) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 13:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A62.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 9 Sep 2022 13:12:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 08:12:36 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Migrate in CPU page fault use current mm
Date: Fri, 9 Sep 2022 09:12:19 -0400
Message-ID: <20220909131219.23677-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A62:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 34965142-97ab-4683-8b31-08da9264f78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6vyuYcXAC8BB1kZ/d86bypUQ/68ofLRdQ0ulOuBqP+/O1r/J71VAqfvs/HFXoEj/AIfjt2npSfO+vXdlR+j80yH84n7Gg9USHD7i1wgl4DEN25YGY6xFdcQtA4BqdOmfS0HVS2NdG1oXqOYgqKeJJ+hzYKxIyWdattEFIbWB/kb4T8Zj0UaJ5AqdPJuugwa6oSKTZ03Ofr2QPyiZoMH6/i/Bp+DXdFfhuAJs9zhd0/vjUESDfbQWdLDTvZcNRAKfYJ37nopzASTuIGcmOp38tbjgAE163tkJM9EKl8wSOEPLCEHrmeLmot/6vMVUu5DuMusSeGCe0CrjsZ7q2E1thmNZe2ZsNo85SGfzpvPfnvILHoS2iJgSAYS48p+ITQBM4TBnyvE6u5lEUGGTKrBDaQGeryU09Zx4VTQY+zUlG60K8r8cEeze2PQ4WiB//dyef6ZNw+O0bVlGl3FfiHAcaehjwfW6mkH+RaudB23HCBOp5vpgdivmVPu9T5rtGDTlCSWTR+oEKd7SeeZ5KBEqd+8l6maPxb6a9SAWp0vwzLskpxxFFpcPOOlGUMwNXjJ9PZX+ht0/m2uT5tl+YSdjoa0QGvRR937uGAgRyFYTfDNAPWZ3otr8PxS6IaISkaocAgqoyhHUawiFnj3zP3V5oRSsvfbry7mwm0z8e02j8tboPyI7lSfEti+P3ABfx4iRIbc/DE1XJgFvkfRu0gjD4+sJLtxASwkz57yksvj8SUOY3u7J+HxgXpZPYg+UKXI5/GlcqB2GoC0R00b916Rav17iz9HRimjH19/iK9RxHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(82740400003)(478600001)(70586007)(70206006)(36860700001)(86362001)(356005)(40460700003)(54906003)(316002)(6916009)(81166007)(8676002)(4326008)(8936002)(7696005)(40480700001)(41300700001)(2616005)(6666004)(47076005)(5660300002)(186003)(1076003)(36756003)(83380400001)(16526019)(82310400005)(26005)(426003)(2906002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 13:12:37.2236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34965142-97ab-4683-8b31-08da9264f78f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

migrate_vma_setup shows below warning because we don't hold another
process mm mmap_lock. We should use current vmf->vma->vm_mm instead, the
caller already hold current mmap lock inside CPU page fault handler.

 WARNING: CPU: 10 PID: 3054 at include/linux/mmap_lock.h:155 find_vma
 Call Trace:
  walk_page_range+0x76/0x150
  migrate_vma_setup+0x18a/0x640
  svm_migrate_vram_to_ram+0x245/0xa10 [amdgpu]
  svm_migrate_to_ram+0x36f/0x470 [amdgpu]
  do_swap_page+0xcfe/0xec0
  __handle_mm_fault+0x96b/0x15e0
  handle_mm_fault+0x13f/0x3e0
  do_user_addr_fault+0x1e7/0x690

Fixes: 5e5bbf36a2c0 ("drm/amdkfd: handle CPU fault on COW mapping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f62c4561f0f4..1cfa4fcd28b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -947,7 +947,8 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		goto out_unlock_prange;
 	}
 
-	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
+	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
+				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
 	if (r)
 		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
 			 r, prange->svms, prange, prange->start, prange->last);
-- 
2.35.1

