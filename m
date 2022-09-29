Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 16:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B534C10E62D;
	Thu, 29 Sep 2022 16:47:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E61810EB14
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 16:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHPj14fQ2sjd9q1/qh+wqGeEaSUN1iDb3xNFMQQVr5i0tEzh2nZi7A+ci7djaFiuv8nE8s/Jkaz4XSKVYR5qZemx1+VeX+SC1xjZT5OBqiqnyBWGolof2KA07Qca2n4FZQ2rQJaP3xrfll3HKCV1/ERQqGeOApjt1wGqinRG4oylZq8VfzV4m+HLPUZ6BdnZ2GvlNox0cZjn/LKiH7637HoHOS2WDHyAGykXT2aoWmKaTvPlC9SdGyms2l0s3GkAYDfpX5mLtmf2IvA9owYdOUDMYOG2w5aMHfmtPuYSvy9cA5+jdHUE060q+kQVuUlDbR2ySCQew5QP2spJxSt5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X3m/r4cffuoE1GE7PxYGvYxWses8JlDlL7WQknSaMA=;
 b=hwjmfXVNL/o3/W5B0nmIAZC5INrcUBGpnUa5iYsp5mXc018chIBbKGv0YSM92dB8PmJwbwoRWZ9jA+onTBJVij7NXD6DsOsi+xtkmP6xKdVeDGNJl7t5nr7uHxY7DWCe01DHJ9sxxpOzcmNHniKSR6Oh0VUnwVQQdR9GfxYQfYjO3ljc5pK+ezPnKiVi/ZjPbGj0CBekt2vwalo6aboIOj55iEPVvYRyorhASyYu9mArpIhqc7ue8WDdZQJW2f6j0jBBxQP3fu0J3M8bylU6AsivPvmaW8hL0lmf/a/L3WEVutztbxkrtF7IECqbHpBLYow8AiMi+rTzZuHPExnegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X3m/r4cffuoE1GE7PxYGvYxWses8JlDlL7WQknSaMA=;
 b=4I+7iWsrNsE90nku4DWFTpqgz98keN0YlHKtVAKBzri4r/If8RmcuOyZVNpUlROK4TL5dklYcVobn/ZUpm5th9Nlyanip3zOwUuI1jHhJDsH4osckCIX/toT1VZO6aO76AcwlpwZv0u6H+Q2ZM9HYwtAxw+MgRALj7HbDqngp2E=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 29 Sep
 2022 16:47:28 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::32) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.23 via Frontend
 Transport; Thu, 29 Sep 2022 16:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 16:47:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 11:47:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/1] drm/amdkfd: Track unified memory when switching xnack
 mode
Date: Thu, 29 Sep 2022 12:47:12 -0400
Message-ID: <20220929164712.26962-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CH0PR12MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6fbc62-e50e-4b98-5005-08daa23a4b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ac4Z2idMhyzm6lLZzG205MIvaKTgcfPYf9EXn58FWBHpbDU11W9FICycRtsKXSi4pkE9vAXPPgrAwRHiceSyC3UXLHRHlhB81P7s6OjoSz/qK0CnZZk63I2CbwBqQRtwtGr1t0XRrDat/pcDw9ubRXi0SaBIB5Xe4IJBAYTaKQQfaNFHl0AaHSqyFx3bIHGzRjfVh4vDvyYYMM+XkdooXljLnQ6nCfK0M5xu+NHgb0DZGWP0h4zxZqpYhZF0Kj76MuU4JO+5Gz/+pTQXOJTr7j002g11G0FX9qiFiotbNWvecTkl9crevCesh7cB81XPjWxwYGgiy3i3SOBh72LxOO/H/6u8y0R3i5E1eLtBcn/OhCuhWmtOXgLjIdgtaMrzEqm1uTeFXazPq1peFVIBdDDtUbXtHi9wAXTFvaGSN45K1ck9nP7Yhu2A1qtjqkze0+6z5OQjbMyG3ja6MrN+6xm0cxsyajy8MFX/CPgDNLPxYuEJoYVVd5QFPMo37mpAypCGG1e1DJjR4iO97v/VLAN4fkHl/9Uqs8QO6sPWR/zztOhUYA/04f66GWCEy49rESTLX1zGIsFQwBU6Sp3W/R9TySHLjlZNLIVrGeb8lWhdF8rIzC4ZWy/CaF3+VK8xTgOyjbxmmpFLLnk1iasAm1lJiNtxQdObaMORo38ng0EBA/5Q1mL66xKm+Q9iPBYXjyNhyefjVcNTdbAGLh/Aj7/Wds0D/2BNINjowZNhvg7gmgYg1az++sLGh57s50NjA0Zq7Wg+UXLlVs9uWUtio2U0utclMb8lc3MP7SY4HQfm/ECuBLVz3Neb5dc01Jht
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(316002)(54906003)(6916009)(5660300002)(478600001)(4326008)(36756003)(41300700001)(82740400003)(6666004)(2616005)(336012)(7696005)(26005)(186003)(1076003)(16526019)(8676002)(70586007)(70206006)(36860700001)(82310400005)(426003)(47076005)(40460700003)(356005)(86362001)(8936002)(40480700001)(2906002)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:47:27.8250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6fbc62-e50e-4b98-5005-08daa23a4b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unified memory usage with xnack off is tracked to avoid oversubscribe
system memory, with xnack on, we don't track unified memory usage to
allow memory oversubscribe. When switching xnack mode from off to on,
subsequent free ranges allocated with xnack off will not unreserve
memory. When switching xnack mode from on to off, subsequent free ranges
allocated with xnack on will unreserve memory. Both cases cause memory
accounting unbalanced.

When switching xnack mode from on to off, need reserve already allocated
svm range memory. When switching xnack mode from off to on, need
unreserve already allocated svm range memory.

v6: Take prange lock to access range child list
v5: Handle prange child ranges
v4: Handle reservation memory failure
v3: Handle switching xnack mode race with svm_range_deferred_list_work
v2: Handle both switching xnack from on to off and from off to on cases

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 +++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 60 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..5feaba6a77de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
 				    struct kfd_process *p, void *data)
 {
@@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
-			mutex_unlock(&p->mutex);
-			return -EBUSY;
+			r = -EBUSY;
+			goto out_unlock;
 		}
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
+
+		if (p->xnack_enabled == args->xnack_enabled)
+			goto out_unlock;
+
+		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
 			r = -EPERM;
-		else
-			p->xnack_enabled = args->xnack_enabled;
+			goto out_unlock;
+		}
+
+		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
 }
 
-#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_svm_args *args = data;
@@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return r;
 }
 #else
+static int kfd_ioctl_set_xnack_mode(struct file *filep,
+				    struct kfd_process *p, void *data)
+{
+	return -EPERM;
+}
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..f5913ba22174 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 	svm_range_free_dma_mappings(prange);
 
 	if (update_mem_usage && !p->xnack_enabled) {
-		pr_debug("unreserve mem limit: %lld\n", size);
+		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
 	}
@@ -2956,6 +2956,64 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+int
+svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
+{
+	struct svm_range *prange, *pchild;
+	uint64_t reserved_size = 0;
+	uint64_t size;
+	int r = 0;
+
+	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
+
+	mutex_lock(&p->svms.lock);
+
+	list_for_each_entry(prange, &p->svms.list, list) {
+		svm_range_lock(prange);
+		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
+			if (xnack_enabled) {
+				amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+			} else {
+				r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+				if (r)
+					goto out_unlock;
+				reserved_size += size;
+			}
+		}
+
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		if (xnack_enabled) {
+			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+		} else {
+			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+			if (r)
+				goto out_unlock;
+			reserved_size += size;
+		}
+out_unlock:
+		svm_range_unlock(prange);
+		if (r)
+			break;
+	}
+
+	if (r)
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	else
+		/* Change xnack mode must be inside svms lock, to avoid race with
+		 * svm_range_deferred_list_work unreserve memory in parallel.
+		 */
+		p->xnack_enabled = xnack_enabled;
+
+	mutex_unlock(&p->svms.lock);
+	return r;
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..7a33b93f9df6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,6 +203,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
 
 #else
 
-- 
2.35.1

