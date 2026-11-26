Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95A606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Cb9UlLZ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAB111223C;
	Thu, 26 Nov 2026 09:34:57 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CAE11221E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrEjT7UPglSkppTx7vvA9XJEju44VCb160xZH2kMSGKlH43MidTukKuvOBUxXmSvzLkdVUCzrQDnWevm7VAmxEJqEd5kwxUxjJFMwqdI/2RfSir02F4qY82a3UbdK/8hrN9aXxrJEGyFXob7X2tiG3A970ltdetu9jH2qcyGEApcJrrWPvCr4O5Wy9rEhTXvQ1gCTX5YB91r7u89IOdN4NssVF3rkDaHejqcPkr5BbTzUjBOonWsNj2vqEDpGnjxLTTQZcmat7MbfotXCKRuvi6W6PHBrC0MTERdwAuUiTFtosW5FyTKwj8OrsVGsLVC9qI21MZ9jSezo9BamzA5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+/88AkIwRjvFGkyWCPTVNjIBGZzSp66p/4d8GgLrP0=;
 b=zTWMXlUOjeDF3LHMnnIu5LhJ4JRV8xligXRkZFlrasahd47YowVcTaJ2tFu/x8tmXUXpbehRTeG4LqiVzpiZPahdw9vHLD/4kTz/XoUiZd/5OpzQ8+4HXwM9VuEaslcq6tmnqhsWlp0N9ijHrL8L0ppiPiskVDkiLnnDrreU8Amnvi4fvEpr0tAKUoy/ZnkuZwq7Rs4ijsg+5+Y8OksCTWyCAUmODRIkIeJ3ok6n6pzVNsiB1GnKAYMJbj03PM2zp6+ewWI9e+lLFjDpStCW9mDXXBdUXoYiJyJeKdQxQv7j2f5fVohRmPYOZGkigqMbYeDdof/NiYoQHFfhX2zBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+/88AkIwRjvFGkyWCPTVNjIBGZzSp66p/4d8GgLrP0=;
 b=Cb9UlLZ+3cSlvJTrVSOeu2UPtjTWIG9Akp+NMA+uII/n0FtQVcjsPPD2gcLewWtg8WITj1OPwnvT61mj5iZbDldczLnlAcVFn3GQr5waOPy8WklBrTamDlmQ1radqDqGOEZkBBbqHKBz7Cc40gxWsOA4Sc7o7YNeO0V0PD99DKQ=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:44 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::99) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 09:34:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:40 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:38 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 07/15] drm/amdgpu/userq: add a helper to signal the fences
 of a queue up to a point
Date: Thu, 26 Nov 2026 17:33:43 +0800
Message-ID: <20261126093417.192538-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f1feef-4e55-41aa-8583-08df4ba080f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: ceRXd1TP6KfbShs9xo4usXpPXJlFhuxmw0kAGn3tJK3dNqJQFp/Hk67pKdLkI3ahqIzIRECHefZWji1283o01zuhsZEVQnZ/pxhxBJVIka8vaBkV6sjbwWzC8GlxSsjphwK8QVOothVbnfqwK8/mBmgJd9+3vyFDa6DiIQstMccecNMmbmL9ssBUB3ZSg5DXLQi2tpkKhdYqc6T5SJbdBXNRt9v7zRkLSI/zIQO52keba25DTUjvW1Qkr3Wl03W5qUGnxvcvFOlaXZqKsGAXJG9n4RQAfHNlcaDTLF5kZVRyXJdCshOgbyo1COZcCSjwlUS+kfDcD6Vp0dUd+8+bzJI4aOjOl1l3BZvhw4cIRNpTmw9P57/G3ZevbHQ/8ZFFbguc98HVKgPYGnkb9bJE6n2PhkExeOESNe6ovote6LBlVxdXyCUZvPeEfLIeck3XrgEDYjOF2sF25iRbedx9JaeCV3lLsI62+8KrfrQxE758rYKqsvLFDAYPbJtj8+EQNdAOOy2+NIiZzbtbc7mZz+vDHwY+cDNLJhssPQ7dFaBhj+ekiVdmSorj9J2SlArGyyhM90P4gAyH770yOZIPZu4df6umAsf5ik3VMtrjnLzKyJ1CeGVWTXlGu+505IRTV52PW8nTymWwrKakVhw9CSUc2GFEJu+YD3ns1L07Isv60GTt7QUPWlPxGsfOCGQvv4rykZcBb2Ghf9eB8c0YbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJaHpNGs30kKvRSc/HQ1ZVg42mA+5BagFJAmY/mu+4z/KPJAymSYdfGyYFJkmAlijy7u2btdi0BNIpZXLNcV5Sx6SVSTiVDzTcGL41U8l4bwt+g3BC6UBsYjF6DxsuOMvDVJYMfwTXmodZPGdaCKz7rQYvCJDoko33m9CmOwK61x8RbkQyKUQmvZchVRCeKg5Wal1fsYBIJLXzef6V1S4ctHD/DlTWBhdbaN0aCCVnt2Myo+0QLsJxxy4SbMpsp0MlzpzhCshi112KTprvVkAm+MZE7vnefx1zUzyzOb2QKAMATGZfApp3VP2OPA+jntSBaiKxnZ7Vr6HOSrJbhLXTFhCb73N3lpCMp9UwNZnw2JGfOnZ3KREOxLC02vqRgDz9+N0uK9yG9vt9TS0gyG5KHKEFCLvvnnZMZ63eWTj3E3Lv8d0EUXRR8pTH5TEmpO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:43.9748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f1feef-4e55-41aa-8583-08df4ba080f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fence value of a user queue is the write pointer of the queue when
the work was submitted. amdgpu_userq_fence_driver_force_completion()
signals all the fences of a queue, as after a reset that dropped all its
work.

Add amdgpu_userq_fence_driver_force_completion_with_seqno(), which only
signals the fences of the work up to a write pointer, with an error, for
a reset that drops only part of the work of a queue: the work submitted
after that write pointer still runs.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 31 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index dd976a50e053..d20dce32168b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -460,6 +460,37 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 	}
 }
 
+/*
+ * Signal the fences of @userq with a seqno up to @seqno with -ECANCELED, eg.
+ * when a reset dropped the work that would have signaled them.
+ */
+void
+amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+						      u64 seqno)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
+	struct amdgpu_userq_fence *fence;
+	unsigned long flags;
+
+	if (!fence_drv)
+		return;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	list_for_each_entry(fence, &fence_drv->fences, link) {
+		if (fence->base.seqno > seqno)
+			break;
+		spin_lock(dma_fence_spinlock(&fence->base));
+		if (!dma_fence_is_signaled_locked(&fence->base))
+			dma_fence_set_error(&fence->base, -ECANCELED);
+		spin_unlock(dma_fence_spinlock(&fence->base));
+	}
+	if (amdgpu_userq_fence_read(fence_drv) < seqno)
+		amdgpu_userq_fence_write(fence_drv, seqno);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
+	amdgpu_userq_fence_driver_process(fence_drv);
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 0bd51616cef1..0407c8c2575f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -65,6 +65,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 int amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+							   u64 seqno);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.50.1

