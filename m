Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA8DC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5583510E70E;
	Wed,  6 Aug 2025 02:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H7aYoCGS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1F710E70E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdM55Afz/MrbAOa9yOwPbVxqgOPT3VFPRk68vUdAH6IkgKDRb5Tp7FwTgck/IfdaIgRiY3be3OQFDj22vLmsh4K09q19hZzuXdnv+blb8Nf6DSTqZstWlBgjjETUkCXw2MbE+drSosq5YRwdH9KlQ/pOCIcuNxmQ5GR+OncLaMQl3yJQgZcWakU8KLFB85alYo9COMlFmMf64Eb5bWlH90x106p5r3yd0eS612eQvUmysZAkKsubsPFYgruUs/KrdeaElTUCE9M86ai4KHgchmFDp6/jT8yCkqCbJ34w14glcW1HWRopCSKi2DYuCiQ1AD21FrIfI2Hl1uKrGv9quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=xQgTNvtiz9J34P6tEs3ePFJ9wIS8l5rgJM3B/d56fJaPPQ9SB4eu05st00XfX0bXLAhj/BXobrzCrFNaFd4ye5ysHnVhXcSYoYaIplPZ0lvwwGS9Q6TLr5JOMY896U/oxIRqLPg198M7oRO1iZb+CX5AFnvdfD3BLfSJBwrPlv2tOBzuRRQpfddS8MKbEac2tsXnlAIh4hbo/J817ROxjdVhvHIy0t5kirt07OHcyxK6xeqlePod8DfBFTnG2NE5ZzJht18xsu2KfvjDkxsPyTzCyGowcpD5UHUpHG/l36Nq/GA8kJLc4Qp/AIpa38KyjHt+nS9MaukzECTbFfpMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=H7aYoCGSzuFocsh1EJB+kPl/W/STxKd9QboFED3285H3ZCtU9lZxT0Y4lUSG+LKjm6dR/L1MK1Bae/BLcaGmace1hfUDf9CMGLkObh0l7zBwUWN/NEbNNJMl4AEEeObdtVg+5J8+mE+h+hvfJEv5cj8eq9fUM1vP7tIuLkmzMuE=
Received: from CH0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::32)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:29:38 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::8d) by CH0P223CA0001.outlook.office365.com
 (2603:10b6:610:116::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 02:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:29:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:24 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:29:18 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v7 10/11] drm/amdgpu/userq: add force completion helpers
Date: Wed, 6 Aug 2025 10:24:55 +0800
Message-ID: <20250806022816.1050823-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: e600fd82-acda-401f-ad53-08ddd4911703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWdkT3lQSEhlOHdSSWI4ZXl3TG56bXZJUWo0SW5YblVzTlcrRzRxajBTOFdO?=
 =?utf-8?B?bWVkWkpVQ1ZsM3FtcjZPVmQ4dTQ5aW9tS2U4VTZleXNZbmlZaHFlY1lNLytr?=
 =?utf-8?B?V0Zvbm52RTNKWlhvL2x1dGd6a1d2cEJES2l3Zk1rVm9FR1VyWWVDaUwvNllr?=
 =?utf-8?B?UDFZcGtwTlZWNERBQUQ3aXE4UVdBY2d2MHRWRFVFSXJuZXQyWTEzMnVlTFNB?=
 =?utf-8?B?VzBHVUNCNlE3c0ZLOEVERkJIRFpkQzdNQ0U4Wk91TUM5WjZKSDRidHZDSk1i?=
 =?utf-8?B?OWpoSDBNNU51TlVja1o1OWk3UVJVekR0emYwZUt5SytJYnVrME9IYlpVaEd6?=
 =?utf-8?B?dkhpbUtEOVdiQ1NWeVpmekpGcVZaQ1hLVjNIaDc4Q1BKeVpBOWxrcTFCMUxi?=
 =?utf-8?B?NnZCd1RqY2YvSHEyanhueFJFZVNKaDRkOU0xN0NjSmhTdUR0T3VZbmRLY3hR?=
 =?utf-8?B?NkVZcFJnRFRYZis4Mnp3UTRidGhmQXBWVGIzUlNoZnR4YVJnendEYUhOS2Vo?=
 =?utf-8?B?NGQ3WW9KdWQ3Yk9IV0dmbHhCTytKdXp6N1JtbG5oTVdxZW1USVVnYnI3YjFv?=
 =?utf-8?B?aC9ja0pCenVsWWR0d1JjVDFyaHFSZm1SMkdRcmFubUpLVzVxVkFYVzMzZXRN?=
 =?utf-8?B?VERvVjlVSFJRY3U2WEcxaVNkK0FtblViMFh0T2tNc2YyeU9tVGNMSkdDSEda?=
 =?utf-8?B?NjlFUUlxNXVoR0J3SEVRVjlQWHNma2QyT3AxeG4vZ3pscTNhdmt3ZFpqd0dy?=
 =?utf-8?B?elhZUVM2RHBtYXZ0OFFrWjcrTXNjTXNwNGtNcWJvaWJXVUliVnFFY216RWRz?=
 =?utf-8?B?eHd1SHRLc0tKaHZJaTA4NlZadzJ0U0E4LzJ5azhSSUxzUGpiSWF2K003WEJx?=
 =?utf-8?B?V3JiNzVINDNLVjE1VGJzcTN3MnZqSEZqOGxWQVhQNFVFZmNES3JOZjhBSld0?=
 =?utf-8?B?cVdaQjNBeGNOemtzWHNOV2c3OWsybHIrU0xvYnZoZFJjYVkrREpySk1DbW5G?=
 =?utf-8?B?SFBGaHFkUTR2MTd1WjN3eEtlajVMeG1LazY1d0RmZTZyM2RnY0lNWnR2dk9o?=
 =?utf-8?B?cXNrOVhqSWtwRmQ3N1lDRWlWKzBnUGh4dVVOWWdUbHc5bm5ZQlptUjF5c204?=
 =?utf-8?B?SFpEeDVvL0RzTnd2UDVnSVJuZWdabXJtWmlSQlBZTU55TnFRTDk5MHlSOXFn?=
 =?utf-8?B?UGc2QlBXNXZwclA0SGdESGdneHhJNm5SeWF0YUtINU9QTnFZY21xSXd0UFdw?=
 =?utf-8?B?bGI5cGxMOHB0VWdycjRSOGZUeXBaOFRWdWl1S1lzRWd3RU1QUmZRYmRuYVUw?=
 =?utf-8?B?alFtblk0Mmd1SUNpbkY3RExZSTZVc3ZRM2ZyNHJsRVJBZHc0L083UWF2Zkky?=
 =?utf-8?B?TFlNM05xaVBWaEp5QnFHeG80T0YwNUMvRzVyN0lEYVM5N3FHMFgwSnZyRnVw?=
 =?utf-8?B?RjBNTHpFZUxCaS9LTkE5dzdlMEo3VStoZFgrT3JCRml5LzErTi9CeDFJaUlP?=
 =?utf-8?B?NUhKQjF1aFhiMitoRFR4RHdjbGpSbzNDVk1leUtXUE1LUG5iOEpDc0U5ZHp5?=
 =?utf-8?B?ZHozNGdaeldhUGV1TWU2eW5hcEV4WVJvWk1mZ0FONUd2bjg1WXNkUysvc1pF?=
 =?utf-8?B?R2VOTzVNdzh1WEFZM2pJenI0Yy9ZQlZYYU80NUR4QmlVclo5NlM2UDBJSkN5?=
 =?utf-8?B?MnJ2SVVqRG8zaGlPSVVBb3lGaFhBNkFWc3RTMVZwNTlLa0lhaHFtRDR3Ump0?=
 =?utf-8?B?RVVJa2t4QVh6c3VnZW1PU3ZQVDhJQnAxOWlzZ250NlJvWlRWWG9jcmdCYzNJ?=
 =?utf-8?B?SnIvV0dmYUtNbEhZc1dQR3A1REVtdGdZd21aSHRGTURveTB0RW1JZDdzYUw5?=
 =?utf-8?B?OXBGbmltWWo2cURtOSsvOEI1WTUybjhKbHZFd3BGZkJnNHNOSUZaeWtVbmNW?=
 =?utf-8?B?TmVLdUltNk9ybGxZUmdhekkxUnhiQUl5V3ZNWE90ekZReDdHVmF2V3FiMFRB?=
 =?utf-8?B?WkJadnc1ek1WYTh3NzM3UmFCSXh3QzZFeGYrYlNCUE14cmJvR3IzMFlVM0Yy?=
 =?utf-8?Q?HhQyk3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:29:37.7115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e600fd82-acda-401f-ad53-08ddd4911703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

