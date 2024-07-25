Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C83CC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC3910E85B;
	Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhZNBU/w";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFBA10E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdOTn7A3RTBftysuv18vnDZvO2EERBTsPLOLul32Hq0yWWMFam86ipK+s8WDiVSBJ9WVFsBNGkKvjI9c2NQJ71SzWSV1joLp7S/UFnGQRUZCJgyqvuh/qVHzc0HgpnBRGjNqD7k8cI+Ue6nlZesPy2ixc7GChmOOXGz3786Iv4SSQRJ2eKOB3MShznpO6uFJJrASzznPgCodVyTrHxwZ8SZQ22MSlWtefvg3eF+Lxwhc1MCS5Bkmy/ZFB2v0nI+yEBPFK/sCO+K4YWuefhlcOkxAqp4DzYbdmLWqmv1N+FxlDH0i5374xy3iArWY89EH63WM5hShQScHmghKosq/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHlwXCC1H8V3+Ixo2uARZNljDO8ieJpeNOjB6zZEXqk=;
 b=ds8SqU4q0WCS4dHjdGYarH1HkKPsSvpKSSpfahds0JfglixuNRUOt6mfnAyZ18GlPrDj13Fy+ZJpWfrRSDyNHQPog1vhysegdnq2Xx49YtpVWtAnedTqIvTZQyNAshfeIoRDZpGyDD/hNjMhkT2tX1ci6VjG6NAludlLuIrhrMgQTkcdp5TqXrdxY0adI8fPff9Gg8lLRMi2rG7P1b17+XMyodTy+Lv8GdIkNz5Ysg1x/NNGedms/hPFsUqwHBuOOhDjKLAdKKlcoYdHoR6DcaoQbKNYA7uZVT+oN8xkjOBif/6pDFJ3EFIVc5NdEPro62vzFTNY9T8Qy4MNIGKrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHlwXCC1H8V3+Ixo2uARZNljDO8ieJpeNOjB6zZEXqk=;
 b=uhZNBU/wLdeMKY4g+0vxAniW9DBdLQKBJiI2GmNHXWYVAoEsEMEq/Aq6k/st9+999HsYM6TGy4FJc2K78dYaCvc48olbuL/KRBJiu3/dTt1+E+lLNdxAZl5yL5hmbaBIs8eiA7m9pNznqdeR6eWxTmhd13MTzuXYTmjKEbJaK+s=
Received: from PH7P220CA0097.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::15)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::d7) by PH7P220CA0097.outlook.office365.com
 (2603:10b6:510:32d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/53] drm/amdgpu/mes: add API for user queue reset
Date: Thu, 25 Jul 2024 11:00:08 -0400
Message-ID: <20240725150055.1991893-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d46578-ecc7-4745-0860-08dcacbaa258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kTbGv9lJndVyIogZXj4VIxoqAT8gUTjy/k5oiVcZNtSC/BANGp1Tm0ESau17?=
 =?us-ascii?Q?Uxaehd9D9I2wT+/4HHwz9xhWFvqeaMtksYJ/jZvyaLCHX79LJbNTYnFB06f2?=
 =?us-ascii?Q?tUMoXvoo6NljctDgJad2R/lqgBXKaAXtttWns+gEKATFhSwuax3dd1Nn9FNO?=
 =?us-ascii?Q?vC9bXdWW6bDuYqCzm4s6SUgSbLgiwsS1aW+bR/Ch/1clDTyjZZrJWZbmRFbn?=
 =?us-ascii?Q?MUdq6oSp5LRf0Fv+tw11zGDcd+xAVIdteqOFYF73BS7lsReg4fg/LmEN9wow?=
 =?us-ascii?Q?0peuM4FBw0yjpolCJ3CU3L+HejcadjmKPZI0BReujBjfstb9qDAWYktIfQuP?=
 =?us-ascii?Q?nXtcA7USEy8+AyQxwCj/MKDH1u+DCRHaTo3cXO7xkg7sutqsXCD+nWFWk7oY?=
 =?us-ascii?Q?68N0y5bMCIQqofosU19OROYvWhTdadbrfAGzbsP4GKQhUtx2Zgyka7OiuR/g?=
 =?us-ascii?Q?vlQNaguWXWL3qdZfRThavQWQ/RslxJIvZiavgcteP0Fo5qtuedJWbWNAhm4w?=
 =?us-ascii?Q?kFgC+Zdm2Hq/2YmMpcMhqJbX2J6KxlkHSU5Itpy0LXCsea+tYHBUgld4BxNK?=
 =?us-ascii?Q?gWrHMEbfgt0zcMBGeekt6bmAwJ6awFGUa8TvmS7uOao7uQ0D8aiA3WbMLKEJ?=
 =?us-ascii?Q?A4adA7grzWJCsWbtJdf4lv5byRFfR8PEhfd8qaDxhNBdSUBrahG7NWzk72d1?=
 =?us-ascii?Q?n2r1vXZkN602+8nDxVx7kRvabyGsaZatFOftHRPOKdK2bm/LeOtwq6O5JkaH?=
 =?us-ascii?Q?P6KsbZKqBzMLzgTuJBn7GsI4X3aRSPFm26JdAiDkaBCm5/89sNJ1Yqanc3WW?=
 =?us-ascii?Q?vXUeab7u5SnWHbnr/hLPLGS43VI7uBq4/ZmC/RTAclkhFVBvmGmP+vemGlHV?=
 =?us-ascii?Q?J4aaGocZIGSzdWORnguwtO+gW2VhNCSHJl+XQjcDL7oIdoEKw9/89TlEgmL+?=
 =?us-ascii?Q?S8GYB1lAxD8Hpp57sp6frqdweiaEJ9ZfkvuXc0S13zf/IOSxbquXtmJmMVnu?=
 =?us-ascii?Q?Ba5uuXN909k+ITcXe33FUJ5FIoS139v9mQ1576IGNUiGElGLa32bghrMlEaE?=
 =?us-ascii?Q?ZgeMey9PGnvT/B1oKpEiqiHt/kXJYX021xRqStbg0ckHEdMjZUpNyQWrfPdw?=
 =?us-ascii?Q?UlWdXUuLRgg/tSx5Ahc28eg5nGtHQskkJXgtp1VnV16mtJN9B2V5bcanMJpd?=
 =?us-ascii?Q?W1mAm3VLFbJ9SmRfL+1XK3LwjMaKodboszpTkzIObriYeD0nn//i2aSkKgNj?=
 =?us-ascii?Q?WZG+S3AYiFw7uvI10VLXaYqxiP9+WoZUp961tPb5H0oVRICEQiAdhGk7ssnt?=
 =?us-ascii?Q?hG/IdZ1EFQtBxgFErye4DfFznsEwLNk304SbqLRRhI0vI05C3o1KfS+sTLZP?=
 =?us-ascii?Q?VkZlrLnY98t0u02rYRAycLJA4O/uIpmUqrlLOmeHMYNEqwUjbEuMnXC1YIIe?=
 =?us-ascii?Q?+VfrXsIQwilOvFrbxufhRyXGEiEGuNyk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:16.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d46578-ecc7-4745-0860-08dcacbaa258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 ++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1739aa11cbd2..b3d6a9fa6775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -774,6 +774,49 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 	return 0;
 }
 
+int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
+{
+	unsigned long flags;
+	struct amdgpu_mes_queue *queue;
+	struct amdgpu_mes_gang *gang;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	/*
+	 * Avoid taking any other locks under MES lock to avoid circular
+	 * lock dependencies.
+	 */
+	amdgpu_mes_lock(&adev->mes);
+
+	/* remove the mes gang from idr list */
+	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+
+	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
+	if (!queue) {
+		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+		amdgpu_mes_unlock(&adev->mes);
+		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
+		return -EINVAL;
+	}
+	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+
+	DRM_DEBUG("try to reset queue, doorbell off = 0x%llx\n",
+		  queue->doorbell_off);
+
+	gang = queue->gang;
+	queue_input.doorbell_offset = queue->doorbell_off;
+	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
+
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset hardware queue, queue id = %d\n",
+			  queue_id);
+
+	amdgpu_mes_unlock(&adev->mes);
+
+	return 0;
+}
+
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4456956c325b..771b63db1846 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -248,6 +248,11 @@ struct mes_remove_queue_input {
 	uint64_t	gang_context_addr;
 };
 
+struct mes_reset_queue_input {
+	uint32_t	doorbell_offset;
+	uint64_t	gang_context_addr;
+};
+
 struct mes_map_legacy_queue_input {
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
@@ -360,6 +365,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
 				  struct mes_reset_legacy_queue_input *input);
+
+	int (*reset_hw_queue)(struct amdgpu_mes *mes,
+			      struct mes_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -387,6 +395,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    struct amdgpu_mes_queue_properties *qprops,
 			    int *queue_id);
 int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
+int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring);
-- 
2.45.2

