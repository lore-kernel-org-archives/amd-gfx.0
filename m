Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB69C0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA08D10F325;
	Mon, 29 Aug 2022 14:31:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871FC10F2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwvWhdou/2yJUL0ReBp/WVI9+F3/ck3gy3nKYgdoWE2el1lUF0DRXKIuj6pUbPCxiHHDSHQdB/UrIBl9la8AE/z8ZgME7SEsUxft3DvANrPUlZFC865VGdI/MjgURuSXVbYoGXdcN1ddd0i7OUOP4o5KF1CohIrn4LBc+ZxQS9AjTAf6/aRjrWbTzJ9nsFOhPY9Pm9yTjNvvfzgLpJNyY5RIqHPIxJPe7mJHR1Ty5mNtkaP3F60xpXcBExxBlQeXxV6TN4NNnZiXwFfvLrwzxxMbOx6+HL5gNktQWhGW+7wnpI9we2PPQCCWiPvgxxxCRWJgN9/pcsABfuymIy0E5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g6qVyltDv7R1r3jPxiLygsaDsmLlJFg0pPWxMGJco0=;
 b=mtlOLHuPxpm2Jsgt6DJmsmALlOnfErdRIMR1KMLovCOpOCqMTvhPINDVc3C0eaKfzAtIKNt2rZlVeuXiL+DMyMB19ttFD2U5n4HgZ3SsXSYi95TVZdd1qmShKaDHF07Dm3qMvS3L2Afhpvq5m1ruAeCVsHvBHTbcwJefcpdNUOYaLeGSl82DiMyhxr5Pqlw2GfOp4wJrzLxOACG2xiLklkFaegK06HV4ehfPdMxeJu9hmTPHhHZBL38NlD8jl49Im/3IMnJ0eGmTw+A4EdWrEQ1J2mTwiCGuPti5fuNS/qMrqvS3D1V7vRsrzyNnX9JxJbcTHBCN++CCbKZeJ25hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g6qVyltDv7R1r3jPxiLygsaDsmLlJFg0pPWxMGJco0=;
 b=IUoI9vvKVvb8h50qc8oNDXzIPH41ft5UQwsVpBMk0CgQ/nsG9RBXIMJmnzfLUOl2tI116Hl9uMHxnH2+Y3k1dxEk5DOkRrKNv5YQSlIMDrgIZ+9A9iDN8bAImiOwlg/q9G9gB30gsUVe9zhHOqspaD2kuBy65AjKJB5nsqL4hbI=
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Mon, 29 Aug 2022 14:31:18 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::65) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:12 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/29] drm/amdkfd: add debug device snapshot operation
Date: Mon, 29 Aug 2022 10:30:25 -0400
Message-ID: <20220829143026.1509027-29-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c3337b-54de-4b1c-2d3a-08da89cb22be
X-MS-TrafficTypeDiagnostic: MW4PR12MB7383:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REmKqTG6KyvO8aYAR9sUSn5Dxkt6AhIeVd3R1uBcrfQcVUP56BXAr1eYRFbbrtwH/giOqWwggNB79ejIyZ60hsQPEORxE/r0a1b4JVB9GNsbvbEmCO89sETMIxuyRk3wglGKVb3luRby25mDVZFiC2BQ6KV1zHk7pzxxzxk+FFTrgEk16oYdUoOTEUohBt4TTbaMKuDrgGteMmvVAJ6b/UFDxn57pa8jA5HrQz/StfnQ4BFS55ZLJrcn4sbvAlXEvujwqlvoBwrXxLrv0Q8nJYLgPPIlNRSokoBz1OFtF80j4dzZOjwJTWdLT0Aq4LsPGg67jnI+364CnOlkOQqAGLbdJYeNbmoo3+xI09eYWUlq4XkjqZLmIXQvZuaF7bDPQqf90XO9psKLJH6UuxAJRx9Iy4DdwAX3qNnig+p/lP6pM03Dhnt5e1z2Pq7lFYgNgUkUwKwJMM7oWkhIIGlnhICxNZCiYnLsbFto/IZTSVApRuXiBxA34CYqQRu7Lr+cp8TwpVlNpKclObP14QIWcCidpz1ANeVGAcsktJmA00jsKnvtZmmZh0i71YK4VbmMTpobfFyn1PuSvQRJ1kxuAUFK2tIKu5BGcfKXdC98Qk1+ebzqaS7dgnx46htfOx4LbdW6RjCGcNg3OYs0WWL3MY6Y1qay7e/u3nE5F3uWJa1SbBSHByfseuHHHEFaONUX21LZ1ku2xNcpii5UeAcJtBLJPup7ew5stl8dnrOSNmh/0r503s6vT9osj8UNC6SyZmQC0Yrr+FOvbOc9fvSlOuWAoDyo2e2JiQ9NvxToU7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(46966006)(36840700001)(2906002)(26005)(44832011)(82740400003)(6666004)(2616005)(82310400005)(40460700003)(40480700001)(426003)(16526019)(7696005)(336012)(47076005)(186003)(1076003)(36860700001)(83380400001)(6916009)(8676002)(4326008)(54906003)(70206006)(316002)(70586007)(86362001)(41300700001)(81166007)(36756003)(356005)(8936002)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:17.8726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c3337b-54de-4b1c-2d3a-08da89cb22be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to queue snapshot, return an array of device information using
an entry_size check and return.
Unlike queue snapshots, the debugger needs to pass to correct number of
devices that exist.  If it fails to do so, the KFD will return the
number of actual devices so that the debugger can make a subsequent
successful call.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  7 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 52 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  5 +++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index eac1813b4b78..090fb902086a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2937,8 +2937,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->queue_snapshot.entry_size);
 		break;
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
-		pr_warn("Debug op %i not supported yet\n", args->op);
-		r = -EPERM;
+		r = kfd_dbg_trap_device_snapshot(target,
+				args->device_snapshot.exception_mask,
+				(void __user *)args->device_snapshot.snapshot_buf_ptr,
+				&args->device_snapshot.buf_size,
+				&args->device_snapshot.entry_size);
 		break;
 	default:
 		pr_err("Invalid option: %i\n", args->op);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 8590f7b21aa7..68b98f57b7a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -862,6 +862,58 @@ int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
 	return r;
 }
 
+int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
+		uint64_t exception_clear_mask,
+		void __user *user_info,
+		uint32_t *number_of_device_infos,
+		uint32_t *entry_size)
+{
+	struct kfd_dbg_device_info_entry device_info = {0};
+	uint32_t tmp_entry_size = *entry_size;
+	int i, r = 0;
+
+	if (!target && user_info && number_of_device_infos && entry_size)
+		return -EINVAL;
+
+	if (*number_of_device_infos < target->n_pdds) {
+		r = -ENOSPC;
+		goto out;
+	}
+
+	*entry_size = min((size_t)entry_size, sizeof(device_info));
+	mutex_lock(&target->event_mutex);
+
+	/* Run over all pdd of the process */
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		device_info.gpu_id = pdd->dev->id;
+		device_info.exception_status = pdd->exception_status;
+		device_info.lds_base = pdd->lds_base;
+		device_info.lds_limit = pdd->lds_limit;
+		device_info.scratch_base = pdd->scratch_base;
+		device_info.scratch_limit = pdd->scratch_limit;
+		device_info.gpuvm_base = pdd->gpuvm_base;
+		device_info.gpuvm_limit = pdd->gpuvm_limit;
+
+		if (exception_clear_mask)
+			pdd->exception_status &= ~exception_clear_mask;
+
+		if (copy_to_user(user_info, &device_info, *entry_size)) {
+			r = -EFAULT;
+			break;
+		}
+
+		user_info += tmp_entry_size;
+	}
+
+	mutex_unlock(&target->event_mutex);
+
+out:
+	*number_of_device_infos = target->n_pdds;
+	return r;
+}
+
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 58a5f14d1258..d8c0c54fffa3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -80,6 +80,11 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
+int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
+		uint64_t exception_clear_mask,
+		void __user *user_info,
+		uint32_t *number_of_device_infos,
+		uint32_t *entry_size);
 
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask);
-- 
2.25.1

