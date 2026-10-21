Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D969606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gW/R0TEV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD00B10FD6B;
	Wed, 21 Oct 2026 11:09:56 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900C110FD6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYsaoCiyLtJFNzD//Ifp608MxoL80VO5N3bPXY5WLiJNx6GI/Ujdx4P6dN1tdTPLb3DaFwap9Xwf2lB8hDdXRLnubykS0N/nxcyYtbdKDzda5giYDWU6SyMJZtIcH5VnUjmJYmsso1AXNxXiosCFdhPRmJsEjF5538UdgJy/uvPYz4CfLzAPcL5qplCu5EVYE4zGFOVQ8X2WJiknHJG89quS93vg1P8/lCxJlWYSSAtca9BiXjlpgb96CIJSxqFldCutgXXbOmEU94GQ0iow+tUiMOzu3MVFRVCOyxfp7wUPMGvOrkZLQFUZ69g5SEO/NhRR3mJaYyZm4me1nrfUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK/DUfwbAP/WTwV2IOq9cj5IjbCPVAJwHsU++il7L5U=;
 b=isuXpPNhoVS4EGYTjNSehaTp5Cjo6qzeaV4UhyRp+hMitHgYO8SXkUWupNV4SZLacpVGiOSnXOytEJvmpEvUczgMT3Tr6FH6hSJABlk5WzIxntngKgmEdSRPXaeFRnfVzvkSvAo1kEdS8mdeZh9ulfyStnie6hYc7ofbXjhhQkq7JH6JVrlc8Z2KiX1+z5ungDwH49TBSx1iQRrkFPTC10iRdtfT/E5pvcnk86V/nEjUQnwFtKdxE4dsZJDggQC7snAYEwVOgysEPecQYQJDlXQvqhcK1+J/hk/xrJ3M73GOWfIAfMzgQyDf+Ck5TS5trO3t8br9DINqudke3SpjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK/DUfwbAP/WTwV2IOq9cj5IjbCPVAJwHsU++il7L5U=;
 b=gW/R0TEVgSUE3uAuFIgZ0zfv3YHSGPzJkPRIfAKu3Bl74Fh/cwE+wz7QtMeHp7C//oIx+qXfNHOqNF4RyxBdaziMhyx51jAB4H+4eEQDiASXk9CFfi7UZ9uMW4hiZ0Yw/SG8Ps09Ij667tr2UPqQf5nNGc3nAKp9Z3cFq6X94wc=
Received: from BN9PR03CA0610.namprd03.prod.outlook.com (2603:10b6:408:106::15)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:09:46 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::36) by BN9PR03CA0610.outlook.office365.com
 (2603:10b6:408:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 11:09:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:45 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:43 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: implement device PMC handler
Date: Wed, 21 Oct 2026 19:10:02 +0800
Message-ID: <20261021111003.3371005-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2932fb-4404-4a5f-a7d7-08df2f63d05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 150GOraEvGsUXQR4wd+G6gv42iec1d65zBTviVM8JgyjUM9y8FEETKRl6Zskjtl3cme8oblZzBxEOmLJ5HDVcrUK0gHjKYsQXylY39HQPKbEdizV3g2w3T7IVwtH++UeDjuCAYUxF9KsQw5hlABIE0YY8n2fJeg5JxGx+8rCaRvL+HQmevDQC+x5nLN4PNL2Nts2J547bjNGvRXleM0Oz0RRzt8lIX6Tg0qm3MF5F8JFpXgq7GuF2lCcrt49MbSIgzP0r9HHRMTzjGut/MaTWaW2WmR6J56M62HkIZQExcJWMWPF7v12WizENKUk43UcuQfDsJx9RC3aR5O0tsiv3NtrUF/N7sJMx4VIemqxo5Sqd1XuFQXqA0w+MEn2GRv1rEC9galadJCCuh1gVSAgfNKuL29RsvWDn+lkTSV2DMXOyFEShLzZl93vpb7VK2IUxM2db5ekf+9BmYiOU1kAtgmrg12STTwpoEX+nEYqCMVsxUGSShGKmauwtOXaeBA/+D5tnGDb8evn29Ecj+q+07n8OgvauXz7crZkj9JGqmCV9jAhsezecq1nLWCsgfyzq24kaS/j4e/eD2+YLy/r0BZlgS+GeamraDwptguTXQS/dIGpovMIP3mejRG0f/8lRX/EKZk2w/bXbvnXnAaZYUFfkZRYteSNmgVyLy6bKgmFSxz0tUb4S3NUzZc2FDLdkj2vDDHs7Ew5k7QrSzw7MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EqmntlywxREMDcLdnI6+w0gAz/Smq3uxZIxaSMSA/YmwYLyDQnCnHhjgTXRYDDm0LbOMTU7YYMUSExojgBH4wrYWfKUcOArz8MPAHoXY3WcO/94sgX+BcoovowdT9ZOO4mM5OKkyoG5nvONJ/a5SLPTwf3QlGxryXspgFYD6i8jSgY7lC8OHGfBGrb2YEgudwoJZYSxARHoF/lhTdCFbwdIByDqRP57SaCCdyY1NlziyuddMokwoWEnr2ZhbZmvqgs9oRCJwXp5RgK+4hRDvFM4nygFeAFFjC7HbfTINparMZSXusbmAp5TyWhJC2s/cn1rGIlMfHvWUW3lULSMOcHwB8O1HodeKy+4JcmLjY7x5zedW/17Foo+CaGXWLAg395MXuiImdUKYET9ljoW2l5imYdssDoMPH/K2TNvNtOyPlhrR7IgwtoDekBo6Eobp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:45.3399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2932fb-4404-4a5f-a7d7-08df2f63d05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements device PMC handler

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 68 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |  2 +
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 254fb8d77d80..f40c848331a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -95,7 +95,11 @@ int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->pmc_profiler.lock);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	/* no racings because the device was reserved by pmc_profiler.owner */
+	return amdgpu_set_perfcount(adev, enable);
 }
 
 static int amdgpu_profiler_check_access(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 42039d3aaf77..758f3b8c5c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1510,6 +1510,74 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_userq_set_perfcount(struct amdgpu_usermode_queue *queue,
+				       bool enable)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r;
+
+	/* IP does not support PMC */
+	if (!mqd_funcs->set_mqd_perfcount)
+		return;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue->userq_prop->perfcount_enable = enable;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "Failed to unmap user queue %llu when updating PMC\n",
+				     queue->doorbell_index);
+		} else {
+			mqd_funcs->set_mqd_perfcount(queue->mqd.cpu_ptr,
+						     queue->userq_prop);
+			r = amdgpu_userq_map_helper(queue);
+			if (r)
+				drm_file_err(uq_mgr->file,
+					     "Failed to map user queue %llu when updating PMC\n",
+					     queue->doorbell_index);
+		}
+	} else {
+		drm_dbg_driver(adev_to_drm(adev),
+			       "user queue  %llu is in state %d, skip it when updating PMC\n",
+			       queue->doorbell_index, queue->state);
+	}
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+/* set perfcount for every queue on the device. */
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EIO;
+
+	if (adev->userq_halt_for_enforce_isolation)
+		return -EAGAIN;
+
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
+		amdgpu_userq_set_perfcount(queue, enable);
+		amdgpu_userq_put(queue);
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		/* find next queue */
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
+	}
+
+	return 0;
+}
+
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 828421ff51d5..6e5aef567301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -180,6 +180,8 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
+
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable);
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
-- 
2.53.0

