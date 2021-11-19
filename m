Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A381C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 22:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413546E250;
	Fri, 19 Nov 2021 22:30:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33086E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 22:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDs/8JRUAOFl49rUmh7eKg8TzHTjE4VHp2/rNzN2fAiWy81K9hyE+GBc1T16zTHKhSWIi46P+Nozu2DcYDG851Gg2S07vW08pZtYWbv9BiRhajHvsMVnSRi22ax/TmmvFagad5CiJpY3clQuoyPlu2u6BQ9NKN/PvEPbpNKJiZSdS42DMsELQDiYaOBTZxKEGgcN87wXR90Ymh7YdJfGofsdmrp+UwRP+R+6iPxc9AnYyBpbyNpUpNBm+gQMhkbZV9FzSE9cOOv4qLci7W9LERKihei9xLdojDt84gnAB4v9APIx3olRmENYuGWvhGqgM2AJKg4SAqlxIBAhMoc9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpGiODXMNGQukyj2U4c26FyQQ9sOyCOKR6tbAxIxnIg=;
 b=MBEOP4zGeeAp+vV/X0j+HTBU+oOZ6hQCoiNv8JrAxGNR1MamBmo6We6V0BWvwefctYGre5WnEeQFldCMBniU4P/dkwYKVzegZHLvAGKFjQ3vZsrD7N7Kz2hk5kCHgWmqmWOFSjpRqDiGPpKWUzJCCnSsRcUvnT7qUkUsOcgQJ8X43LjYPJwZIpxbDn+Ibun14rZQadVjFIoZEto4UzU9Tjm11lbqBsWcBmtDlG5wQ5upVM/crxab9tQhTov4uAS1qF7Val4PatFspBM4lXi5ddN2ofVjmyvMxz42Fl5sI+q2oyvHX6zP2f4LD3mtlBHdaosJWcjVi2jebhOhQNiIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpGiODXMNGQukyj2U4c26FyQQ9sOyCOKR6tbAxIxnIg=;
 b=sIBbquo50SWBwQTwvlpEYS/XqNjG7WLXJspGMGxX45bPQkbWjm20JGuwWyMWEWOgEwHlHOm0NkadFpvmu9DKD3Ym985Y51spW7fYvRdATA234XwWJfGHDFx0pvNMpzNYz1a2GTtoLfyqqmDOPFkIs1yO7SYX8oRUyMj0+OpV3ck=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 22:30:11 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::a4) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 22:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 22:30:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 16:30:09 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdkfd: handle VMA remove race
Date: Fri, 19 Nov 2021 17:29:40 -0500
Message-ID: <20211119222941.18053-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119222941.18053-1-Philip.Yang@amd.com>
References: <20211119222941.18053-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb744b3-e6d0-4672-6857-08d9abac254e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49199C95B29F7D027BA93D0DE69C9@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJknBPcyXdO3d2wzVFcGKFZgqIDo/8O4mzaG2PaPaVGlV0q/u6XWoDwhwctHg5+EJGMloyrYcF0FEppEKfcQSBzN3vXvw96jNKD1fmLWKVixXXSzcsVppIO9oe6CWxXKuSw5DVYe4vNf+xtVRaw6AB1KPK4UUpttjguNUbswVnFVzDLwuy8nmnzkIe5eWXUDPMNLKoNHv+Ew5gzu2A1/2vgSfyZ+ZUe8oJnuw88bnEzS8BtoP3FvU1pOCkMBHNAO9dGs36DuvpdqBfTSHPF1gldFFNzgB4J2cuLacKFuVv46gSB05/QGS/IspPV/jUid2PR5YjK6Jz0WX5a82atOtpo67S3mLztJRjGJmSKp8qG2DwXzspPA8QXeKUGLZ6krTQSUPuU7aJlZTX4lUid6/ls7NnjmwRTwtDBg9KwbWyia0jZh0crohfmrsn9g28Il9jkwaY//SaSrmBUi7o6BfEIDNIi0FSXqBulcvm0CcfJdzkFRXBYuMgsMiXKrdkwrUILssTRI25r9fTXNgD/rIYPyPJsaRwQ5ZJQrYgOFGZG9Bx0aRQYs2w7P1M4vE9S7seRhP1slTZRTNVFjeRAzISGLni7hHlY/OpFJU69FZkuQz6muIu7G9flXjpAMZkuvk6UUF0MMqdv52OaLAZ279KnRaA7Hv7PBDLxWI0K+deV5Fvk3jnC83LwpR5z4CjslDXcCCLq8tcrkV3VZG/+g6WtvXUZBsZ86LhQpD5py3bM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(86362001)(1076003)(82310400003)(4326008)(36860700001)(5660300002)(70586007)(70206006)(316002)(36756003)(2906002)(508600001)(7696005)(356005)(81166007)(54906003)(426003)(6916009)(47076005)(336012)(26005)(186003)(2616005)(6666004)(8936002)(8676002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:30:09.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb744b3-e6d0-4672-6857-08d9abac254e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VMA may be removed before unmap notifier callback, and deferred list
work remove range, return success for this special case as we are
handling stale retry fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5fa540828ed0..65daae9e4042 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2548,20 +2548,13 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 }
 
 static bool
-svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
+svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 {
 	unsigned long requested = VM_READ;
-	struct vm_area_struct *vma;
 
 	if (write_fault)
 		requested |= VM_WRITE;
 
-	vma = find_vma(mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
-		pr_debug("address 0x%llx VMA is removed\n", addr);
-		return true;
-	}
-
 	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
 		vma->vm_flags);
 	return (vma->vm_flags & requested) == requested;
@@ -2579,6 +2572,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
+	struct vm_area_struct *vma;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2654,7 +2648,17 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	if (!svm_fault_allowed(mm, addr, write_fault)) {
+	/* __do_munmap removed VMA, return success as we are handling stale
+	 * retry fault.
+	 */
+	vma = find_vma(mm, addr << PAGE_SHIFT);
+	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+		pr_debug("address 0x%llx VMA is removed\n", addr);
+		r = 0;
+		goto out_unlock_range;
+	}
+
+	if (!svm_fault_allowed(vma, write_fault)) {
 		pr_debug("fault addr 0x%llx no %s permission\n", addr,
 			write_fault ? "write" : "read");
 		r = -EPERM;
-- 
2.17.1

