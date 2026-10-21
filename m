Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1E606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LCH5wSCa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3805D10FD6D;
	Wed, 21 Oct 2026 11:10:11 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFA810FD6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljaq04l9KSeHFZ+08CwEbp2uAyEouoVPh36TCPP98Y+mRdGD8GqG3f1WZ+Dli38U4tB8ndjPtNzDxiY1K4D5ZrSoQBphDCliXprKKKB4oWDP2Ecstv18XHy6y/oQkYzzRLcci+qLC2LIWiY45yXv1yiOQ3WqCiXe9NwOF3o5tSFd4OzbeHopSfPWwFg4yXHocHXUoiqf8OR8S+dSNNN8tw8I7K7tsHZcJni4qCdJM+HCI6cM9Z14jbxNkIQoIs6P0oNCQ015pVnAftjvWgwiZgrZ5zd9b0jHafn1GoqQZkIt9+TayqjneFofHN2clgBwCQMeF9NQdZtVyV4jWLBV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qr38c1W4HpMxbJ1ZA23nGU+tIDa5u5mVCVxZKu4ds8=;
 b=P0F9Az03JwYdbZqun1pQxIReVscpnkrauF4eOHZirkibtou0mG+N2GZ5EmD4qqFK3OeW0Xu2LHCvbj2zFsh+yJL4jUSiYu0y+VoL7Ig+JaBbAKAqoS/8DaWwy977PY5kMbFnstRPiTNNrA10Y75I1gQNReVgyElKJF6t508CKJBXZ/sIPDIbW2y7cDejWMqYRw2Dq5CthelUsauEBu3Mjj2QV2gHN5wL1u7enbET6GHRvKa89mDlxK/w6w4PtU6tEh6zLQ/YtFKXQir/B3uTZmM5bHrMrIig03/GEj1Le0ZU6RpLAKxJGC9XP9jmADs24OnEhbaL6VSoGIa5FUY6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qr38c1W4HpMxbJ1ZA23nGU+tIDa5u5mVCVxZKu4ds8=;
 b=LCH5wSCa6VdL15wKcdpcehXouzpBMuIZ9rIE9Z2UsJa0TEM6gXDyauZi0fm1mCIqtdljACb+RZTirky+J1FfXkC0iUdXkXy0J2dwzDPVf+rDY5zse6YzIr5tOWq9WvdWdFIEApS0JjM8zZifBdwG7kjlIc1DLUqmpAEuMZ6P7fA=
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:09:37 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::98) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:36 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:34 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: set device-wide PMC enablement indicator
Date: Wed, 21 Oct 2026 19:09:58 +0800
Message-ID: <20261021111003.3371005-8-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 60694b67-8da5-4a8b-9f95-08df2f63cb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|5023799004|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yWtGXNFPhMZ1b42DmGSZ3FYMPU4ySBfIpBrvS1R59EbSDJbPPspsAlDsjocFeIP/jvkUb2Fk7shTlDz1Eh2t/6MVjkHGCnSAne07IwX73E5W9mn4NjRCAVTO0hSGPpcj7kwhsuC0F10vmBVnciP7X6tkcHLlSeVAzW5PX4gof403KxNbbgnSaosFGRk2LCDQ6s7Z5xgSxWuKY1BzGDrHYI6cCCFNDh4wZagWHEF+qS9A8n4arY+5lgX011P/5aCQbG6uRITlLy2BSLA0JEYRkh2jG67aOpAT/LEN4C3m/t1nxiT3MG8YF4pIUVGxHhF/Y9uRb+urDB3mQiQMAtPS50BqoH9HNfs82IHbv/1FmX4V/i8lysvmXHRpALcSMNn/7yiSQia3QY0gFh2tQ2im1Ixp4JnD0841QsVaCjT1JyPD8LgJI/K1Cxa55JRg7u1Jl2dsgnbPfiOAp1Jh4b9zNAPbc95/oyYRemsr+RmeP12oFB732PbL7730lM/6IDoR0Zv89vxiJ7TSJEVsRt5XvOR4IU0jiNyqwBDGfUhUiuNZjL6IoOpb67KwdUI1eAepBuLGkrmb9x8Rr7mxbBu+Cb2HvA0IE1QQXkb1SScmjKRbXpG5IqYalG1IL9Qe6rG6k/Lx5MHCc0q7wlZIVvqiv7Ot8z40b5Q6H14UqTYDeCDhNkmeMYj5Xfoga2wK+6mo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(5023799004)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VMSVmQvmZUYdLhGWCPZ60vaZKXwQ/YenSofRqt/Ug+W9aak/hAvfAoKt82ayt/qATnqzv4DvkAvSuH1tu3gQBqxt2kZ6XZxZ94ykgqGi79I5m8UJyhpqtFSnKQQpkXMD/yevKJVe1tewKkGMvgSwjC7nMS+ypq8bhxyYsjGsXlIYt1aJ/uvj0HrfCuXqT0/ZDZljTxpMQuKP0N447nLmR/uS6cDxFtJEg+TND3dfpGXsfqHF7Hu+sFZkdDcj546zgH8YYVtlLTeT0eGJHDtq4NdbVnf9abxutnDBYe0P66p9VmVGhfhkgPa3jsFgRm8GMg3dAwk8xP8JsupSt4WffdtpplJ26crLdMPpb41nuXewI7LFlgxeOpkWNCwxjXrog44/ZbwQoTpXJd/J2UGwbXfqYzV8OhNcRtXG486h0TQ9QlT3hKAxRWGDMXXJgoio
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:36.8736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60694b67-8da5-4a8b-9f95-08df2f63cb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

This commit introduces a new function amdgpu_profiler_set_perfcount
which sets the device-wide PMC enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 23 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e441eb171c1b..f10d6ac49bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_set_perfcount(drm_to_adev(dev), file_priv, false);
 		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 6464af0d1b10..254fb8d77d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -77,6 +77,27 @@ static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
 	mutex_unlock(&adev->pmc_profiler.lock);
 }
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
+				  struct drm_file *filp, bool enable)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner == filp) {
+		/* set device-wide PMC enablement bit,
+		 * new created queues inherit it.
+		 */
+		adev->pmc_profiler.enable = enable;
+		ret = 0;
+	} else
+		ret = -EBUSY;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -120,7 +141,7 @@ static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 	if (ret)
 		return ret;
 
-	return -EOPNOTSUPP;
+	return amdgpu_profiler_set_perfcount(drm_to_adev(dev), filp, enable);
 }
 
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 048ce84f0ef2..532aa7881191 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -30,6 +30,8 @@
 
 struct amdgpu_device;
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev, struct drm_file *filp,
+				  bool enable);
 int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
-- 
2.53.0

