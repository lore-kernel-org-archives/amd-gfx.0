Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA7C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E06510EC60;
	Fri, 11 Apr 2025 18:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="baRqeQjy";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15FE10EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBQpn6S2R2zI4HplyPTHTV5iw94xojXYM9g4Q8LB2LwTBBEMIFVQiRG7VHWoH7pRX6ydPyJMSdw/chjkha8CyS5/nat4ru2PsumxOPzvzpJ4nXXd9iTGqrO2AfwrenjH+eApDDR7j+7c5bfu315nP3/v4JgsMuSKGidk9QvcN7Iio0uE8nDij3CtVDquvNUF+gzySPlufYOu6acXLPYTO8XzYBJUkXQ59W8TnYILsUKIj9lJaUXbB0e76Hs8uTXO8dUWAEOugGhZNYbZhs8c+2+sOiRAnENlPPZI2fMKxy3OfsSshaqCvSzfs3EoMgVhuipfCgHwKCtr4qunDxfRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOsSvRx0lKgBuRpu6xP+Uy0zDgDBmJinLmAnbB6mkeI=;
 b=cZZiAlbVIugMT/18jtMoVkik84itDuhGAJQGVeTVQWFgKp+zMkINt52uqpR9H+pU/KegXuLLtsdY1Oscg0gA2QnM/BN0NAqrhGkmdVaLGmTpZRWfwJJaDsRdgEmRXH/uXT4nV9ygF4B+A8dt3uAnZ8fq6m3LdAdhitMJgbeUoe7D/yvkUCDBRAtsqsTMUAUE13POxSnER0dsrEJK+wCsY/Fj0LyFp/uCklAQionJBAMEgPEB445F88sVSkgh+yASOqOptuWZ/RimKIdm2DMfdUY92O4hI01N094u+znYtINTtRpNKEy/sSNAK20EYWrHaP+uWZzPznMqvmmDRnb1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOsSvRx0lKgBuRpu6xP+Uy0zDgDBmJinLmAnbB6mkeI=;
 b=baRqeQjy9J5wm8suPM77s1qUaodfceaYsEsTxoOB1Mj8hvOyzgsmhRSFG7Dn0RkZXFkyqk7PpXD7LytWL81PTDvKFAjCgkpy6HFhUelE2l/nu1gR1hauBjEXD8ghlLoHuUUHTdMnFptgZFCbr8UGRA7mK3e7LI+3Lv+xyiafOBE=
Received: from MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::24)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 18:48:41 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::45) by MN0P220CA0030.outlook.office365.com
 (2603:10b6:208:52e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 18:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/10] drm/amdgpu/userq: add suspend and resume helpers
Date: Fri, 11 Apr 2025 14:48:20 -0400
Message-ID: <20250411184825.2890189-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8557cb53-74fa-43fc-e582-08dd79297a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQOO6naDeP7ApD2CpR2suLj6/hUsz6014dQxp5rQ87foz0qrUBII28Zth25d?=
 =?us-ascii?Q?qY+Ti95BXCeZO5zUzsTWQCqc6IvrCnZbAWhWK7GmAZLsNjcLo5yIK5pPXiyj?=
 =?us-ascii?Q?LGBBlTb4lqUedMllkFE5iNs8MVROh+k2EScJcjrdt6WwG4Irqd/olxC9S8BJ?=
 =?us-ascii?Q?FWuOfwATwrGjhnqiA3/LwI1Ot3AuslXNzB8mJ/bs2fsQtktwWrXo5pG7PBCg?=
 =?us-ascii?Q?Kbo6xfNxMf93Sk5KpdjPUp/8JdDZZ2Hi4GT73i7Kf2ZkUDg/AK1YqA0LSVk5?=
 =?us-ascii?Q?naOG3zFXomwHeW+5PouWURXJhZlHrhhNUlkDM3t0hRPaxy9DoHaCp1EZ5AbN?=
 =?us-ascii?Q?PmIMcl1zOQrbY4KKDbSNmqpGrhi4yLHna4aw5h+oSz9C3vMdDkODK2rwg8jk?=
 =?us-ascii?Q?zZaaFzOX0kJNQhjSGny6lJMj3MVjvmar5KXnGavw3YvaPtj93BeyDyW3zYQs?=
 =?us-ascii?Q?0MLEYkIyDrwFAM2QzBKX1kSe93RN03+io7HOozIpjSLkB0s8wbdSgOsvqOG+?=
 =?us-ascii?Q?ICn2n/1yo1E4k3NV4H7S0RxR0TWRt30cdVDE4e/lB/Z5TQdk47/d9UrRD/9i?=
 =?us-ascii?Q?Xozi3VYcrag/tPmMbAOmNnJzXiJBUxUM+6bdc67ktrFtTduYLk7qz3txGNeY?=
 =?us-ascii?Q?A1UGVjkgqwDK3UT2yFrQz7vkrUn2k/75iLcSwWbR2RJoVpK7iEMmeFBMdIDj?=
 =?us-ascii?Q?YqXohpnGDX4MKdu5pPI/VRshQK8Fkvlbx/GjF2ziq+jow4pv3E5VEFEd6n3g?=
 =?us-ascii?Q?3LAxrds/IB6Js09RcmurcAPM1IgPH2+++gUWRM8/w9Xihc/dIsSywGPiLLtB?=
 =?us-ascii?Q?HZBvr4w+NQswbvWbVgW2RnPd4zuHI/R1OCtJaO+/KXvqNdyfKracJbsbzNEn?=
 =?us-ascii?Q?mrG0mTeljqhn9WMSR3sBZogXEcWrWtCwFqy9c4whGfgjc6Viz2Vz3scZzRfA?=
 =?us-ascii?Q?9q5NJxrLVvtosHOd9Lzg8b4cdO2aBXdF8v7Z9THvSFAdHDn2EaEUz/BH8kwv?=
 =?us-ascii?Q?m35qKmv+WPfUDxSnktG02M7TtAomwJU/iKNz7hsIZq9NEWxQXmYmmyvJ4MDZ?=
 =?us-ascii?Q?C5WkFqSAI12FsdSgD3Mw5BlvOnc5E8eClz582JK7hKbH6PaMrQdHjPD4Q1QJ?=
 =?us-ascii?Q?ScPBg5veGlw+juMtoDVM1JdimwYcGuwCOX4+yXseeThfNzLbUnsd/F+mYJgb?=
 =?us-ascii?Q?hQzzqfgJdwHPrTJmub0FnAow5fe193aH3tRb9zIIqFqVO9nxIIrNu4pnw0E/?=
 =?us-ascii?Q?QJK9DtuYNZ9BipQ648NCyjd+IIUxsxAxvkPqtWkgnL5QZ1RaTNxfF6uIyfHI?=
 =?us-ascii?Q?xTDDq1DvjDsOfxX+muV8GfrmUJfpaY/g5a+xUadUEaQaIUqCovcVvPPH2G9q?=
 =?us-ascii?Q?83dsJVSEncQhVF+x64LtbOM0NFtEBX6KGEZUJNMStJdoNf3JVYvvXMq5MWIy?=
 =?us-ascii?Q?9/FkVEPu/Qrrn8GaIzpSgFmrnJzj6rbtULE4Z88Be1FPcK0qY2lFRh61IJmL?=
 =?us-ascii?Q?a3d7U/4mLRdfiXB+S3TvvgNjTtJIfgoO/Y4U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:40.4279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8557cb53-74fa-43fc-e582-08dd79297a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 41a095c12f956..f5c2489baae43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -681,3 +681,42 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
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

