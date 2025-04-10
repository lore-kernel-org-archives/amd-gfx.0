Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2444C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951C210E384;
	Thu, 10 Apr 2025 18:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCrUJU/+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC7610E37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh5NUrq6DcwTWGBpXyaClslNzEWiVQSimOQqr7IKfGJqxEhw5yw2ilkWayr2TCow7k58qgAFM8zVyFSAO4GmNOYxkuL51z5PqeH2bynpmecCXZpPyLpXgwhvIHaWp/fjl3KhIXbaPaYtljbfkBDuqei4DvVE8gLSb17rM5Om6VpTHqwXho8ooKuw0R/rZfsMjCDwmKjOoIgMJzWgJTGBipsmYi8kgnKOLeg+kHJ4pgS/2goi2xWtJAYkhQMlwb97osxoO8TdGVDztzFrR7pAQ7zYWGMdt2CE0wrwzFafuOFgFWWGuJQKjF8zNl4scaniSeiUrbwrof6cbVat5WqlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc00mtzumBZMT8qYGvOSs+uUMKayOPVoBs9OThrm0aM=;
 b=XMLGAkoMDMqOt3cUOSO0Ie1NUlOkYNgeEQ5wg5jbw3UypxxrgmNra9HWxnjrxSnTYPWdMgo/VoSqTjQTn95P2USVq9cdvEULFaU2i88ijLBdO3GLk0aZU4QDgquED7tMN7rHpEyZXpCWM3Asqo4K39RWEckUS37KLHef8LUH0Rac1f6Ntx+PcI67LVXT8Uigs8RbKhPqSzwfGX7IiKJwGlznMKVwJwptcZwr1cil18vOkJfkKu5qhZW2UtOxHrmqPpcqoIW6nKVjb00/rSdaPDl6YJPHDygIyqOxYeTtPzWRyZxqUZS/+5gd6YeUuuWsws98nHP90M4EQQNB/5Y87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc00mtzumBZMT8qYGvOSs+uUMKayOPVoBs9OThrm0aM=;
 b=fCrUJU/+chAPv6P6nFDxlfApHBFb0jzv0KqeYnYrLrcuqDjyku2sTamTOAnYtV2Lw/0/bX/+tDB1m2bTMCtuRbmXgjklL01d58vRAg6eJxDDD5QU6CO+wTFUikL2DhHZI/SyTvPRTJJWM8qKdNb2pAJVp8kU+YrS7luedYcOXD8=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 18:11:57 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::b) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Thu,
 10 Apr 2025 18:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/userq: add suspend and resume helpers
Date: Thu, 10 Apr 2025 14:11:34 -0400
Message-ID: <20250410181138.2287932-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: cb967b95-04b5-4e8f-bec8-08dd785b2e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twGOW9ghLLh7Sfwfu7OrdPht6v2XE6iaxWPc/xLt/fTcp84IY7RgiqZ/C00p?=
 =?us-ascii?Q?u82/rxY81AmusBNuTBS6fCBjPCkz6KGTGm98NUgU6T+9tuCxslgnktMFc60C?=
 =?us-ascii?Q?UYN8KNQ4xEbxtjkbDIWYzfUE/26AUPaAbK2MqjyA0B0ZBEPgRMe+rZHPiMmK?=
 =?us-ascii?Q?LhBU3Fzxfh3XA6iNjBxU2azyZV8vKzNsNySlizivZqg1i4IR6KKtJsMXxsBe?=
 =?us-ascii?Q?Su8Or042qgi2AlxojyUju79hDIFsIkkftwABAvMYB5MeElk/rgeLIJ1pNqjK?=
 =?us-ascii?Q?k6cYoQn6Ln+qtgRBCOj+g9B2hRtwnmEhWRqwFLPq21t5fgrKSbjwfPROvOnB?=
 =?us-ascii?Q?m3LH/yIihaxgM2doVL/foB4vw9ytdK/RfUTZ/3mE9SJKfhgu8gdtKtObutDQ?=
 =?us-ascii?Q?+17fmPwXXN11vhk9s3DxUAr3OY7+jNt107BMoWFZk4Fia3KcMuvu4vRVWiWj?=
 =?us-ascii?Q?Lu+aN+fyik27U8epFSMeorEkwA9O3txpBqevs6HComn1eac/0PwkzxHiKYkB?=
 =?us-ascii?Q?kyvmlLbBmHiVTxR3j36tmzL8wJJgT7s0fiQBNeuZiNDETW/C/QX+0Q1unT3S?=
 =?us-ascii?Q?m5p+lCgF9SuBysysqthalNGIndt245seyr0hsanGND4rhL4Pao60rOHeZG2/?=
 =?us-ascii?Q?AyvJO2rf0DOo70s9Gk+5uyiOWo2af4Cm8rsP1Ow5zW7L4rtiOTm0Dfo8u+uQ?=
 =?us-ascii?Q?A2VSX63d0OgyUBtdJPs/Jy2sM8LfoXBkeUyf/DLWmqgWlyhMEYlxC123aCEF?=
 =?us-ascii?Q?OvZFfLKRGG+6lmijFmia9x0KmDwikym3oRJdS4zOOECa6g2hY6+w7s1HNQr8?=
 =?us-ascii?Q?7pqFXsnYV2DCRBZ6c2rhd883M+IrZ7+m0p2y1j7OtpF/M27iIbDnCGphpUYs?=
 =?us-ascii?Q?AZt/wVgJ9rYLd39nzbR09lj44DNUwsIsArfrb75UA46iy8MCAmhYpMU8SpN+?=
 =?us-ascii?Q?ceU0FyoIl9tRd8VLzXgxW83lwBpT47Hf+pp7aYaSH60FLp3mwlyfdqgS2Vdk?=
 =?us-ascii?Q?ItakZ2jU1blAEYTj5WqWVdQ2AEcXO1VaoGflAZUUwS6WoOxIUp6mJIFkyqte?=
 =?us-ascii?Q?bdujlG95X2hP95k2TaMSsp2pjh5ElzWU8ovcA/gaUNYHD3adeBJ+G2XeHq3J?=
 =?us-ascii?Q?c3yv1hgP450J481s81kbIdZvvvFxh52dWD9QleZXKYSUnmd9JLNjvq6psz3D?=
 =?us-ascii?Q?3jILs6wbGcFggK9HOt5f3KiSxGQMDMZrtly5y+Vwayc1BAHrSRUagH+L1yf/?=
 =?us-ascii?Q?jh220CmRVnyZVjdky150jhPsIHm+AYYe9cHf58kkUvx4ADt+gDcIBF56kTyd?=
 =?us-ascii?Q?VKOQhSDwKr6Do97JwIsSdFwiqsCYxUDlwLRpmSbiWSSYdlLdq8278hdmU05X?=
 =?us-ascii?Q?UZN7Dh5dc063eQfc35HrR6GcZ5nHBiz0ouuW8poxkDo8vTeP5FpcNmyrYj7Q?=
 =?us-ascii?Q?IZ2e0tWAiLT4sYNX2DE4dSISZIzq3yfty9MZHXAzEazMmD5KM8OrQrA0xFJt?=
 =?us-ascii?Q?XPYMTabTaw6O8HY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:56.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb967b95-04b5-4e8f-bec8-08dd785b2e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add helpers to unmap and map user queues on suspend and
resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 6157258092cef..48e2df6bdf63f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -680,3 +680,42 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
+
+int amdgpu_userq_suspend(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->unmap(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
+
+int amdgpu_userq_resume(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->map(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index a0cf6978f2ba8..381b9c6f0573d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -111,4 +111,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 					     struct amdgpu_db_info *db_info,
 					     struct drm_file *filp);
 
+int amdgpu_userq_suspend(struct amdgpu_device *adev);
+int amdgpu_userq_resume(struct amdgpu_device *adev);
+
 #endif
-- 
2.49.0

