Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF6FCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B624A10E5CE;
	Tue,  2 Sep 2025 08:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G2WwWe1U";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7062810E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK9wvyXwhSF89bWjOeXBgC4em0sRne+ueNfgZW2UE9TiETpCrfgk0FqyDRoy35YnPbCD5Y8GCibLhs/5mjjluwkdRPe5Y/4bt04DM1oAUnFqO0Q6xCDLkgbJi7iNLKZuTTyjba8EGCw3ctQvxBUWsnTkFqjLnDD8BpxwOXZu5RpkTwqxYDKWZEqK9iLiMq/cVWdofQLIETfWVeixohy63uxGa+dhMXVY/1QWokvI7pqRJJhGepbi3MtoSkG9gPYwxFbiWfztzPKbuFFzd7oE6oVzrefbnZ63hQEYmbgea+Y1Aaia0sEZr9w5F58uSpGedqj1rAIoh9bOd9mIIaGkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=RImhIsB/B2X9v+F0ddZxhS4kOgnjNds5qGJyDLPw93JlXCqGWmkJBQchTqzFphkrdhMcrjXxzWx4oDHs9JXZdSxQ2DZxFMTp04VKzPw5rI/MhwecdnHQDS+caLEZ/oPaWuFH6hWzIL2MfxAGm0wuuzTpTJMNrQlnBrEvuV1GXl9RTBhbXpeT5gCoqHiiE5dZsnXOxfWEV1jukidfrrnQtvEqUAIzRUCEiB6ljALvVm2UKDPEPrfKjUnl9+8xtHYSwfVr82HyL1U4w63953Vo1nanpj8vlwxtznm8OY4tI4LUS3FjwU8+2lecSTV8vDcX1LoHnh17a4FLNm0G2IHOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=G2WwWe1UDLVok++WcmAT2TDpq95MZQF1+TdzwXqA7M+s4LHphbxTJy9IcQ7QCPCdX33D2Ety5g+CeXEXA0BF7CEwJzrM5fpJcbSWtQBTjPOfvn2zWf9M55SBkeGn4BpHVBKfErR55S83lY4BLvSmUiISLVeiAEdSojaH2E8RstQ=
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:08:14 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::e0) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:08:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:08:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:08:01 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 08/11] drm/amdgpu/userq: add force completion helpers
Date: Tue, 2 Sep 2025 16:04:09 +0800
Message-ID: <20250902080712.2515811-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: dc55c9bc-a137-4706-eda3-08dde9f7dd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3QvbkRtWm5hWGl2SUk2ZjR1TGNDcm4vMEJSclVtUVFQeU1sbGYrVURMV1dM?=
 =?utf-8?B?dDRURlg1SHNrMHBlREtVa0ZoQTJSa0NTOHBnc21Ud045UGZDd1Y0cm5yaURo?=
 =?utf-8?B?T294dndPeGFIYXhOWUYvM1dOcTBJbTNKSytsYzdDd2NmMHNQeUJjaWN5RFpm?=
 =?utf-8?B?eGhVODUrSUdxTjRMWDFHeWttOWlNM2hYWCtqdjNMTjBVMXZQNUdmcUkrTFRF?=
 =?utf-8?B?M0NwcWU3V0JGUHI0S0lBaGlCdXB3TklUQUVGR1l5QWZPMnRhbVFacDJyUDdL?=
 =?utf-8?B?Y2J0eWtQYjZ1dXUxQXNlRWRJSVZ2UjhaK2Z5YVJZQmRKZ3ViVGdxQlNEMEh3?=
 =?utf-8?B?MW9DUDB3Qml0Tm9IRFdDbUNYOXVmSm5aUnRmRUhRUDJVNURqQ3dvMzZIQ0Vu?=
 =?utf-8?B?UXFNLzVwendCYXhnYkFWQS9ZWm1XR2xxa0EwZEk1Z2crSFVXYVZqRngzaUc2?=
 =?utf-8?B?UDB5MWd5SFFqazBLK2dTbG1xeEJZU3NoYUYzMWhvV1VXdEhuRUlWT3RmTkx5?=
 =?utf-8?B?QlAwUTRTS1BnU3U3SFFjQXFXYVNPUHlCQnBGNmZzUG42Ti9iTm11RmtLb2dP?=
 =?utf-8?B?WHRDQnhjVW0wNFpuSHdXWWFrSmVHU3ZjRGdxMUFpbjVxNm03RVVIb21iREpx?=
 =?utf-8?B?MXFsWjZsUy9OSloxbXpmOGYyMWtwZjJpWFJ3Z010QnU5bGd4YXZuVW96SFM5?=
 =?utf-8?B?NXVmWm1tSEE2QkVNQzNYUUJkMzVUaFJPZG9tdjlSRlNoK2pNbUcwcWV6bGpr?=
 =?utf-8?B?TG1RRHhQQ0E0RTNOOVI2aEJMYWVhWDlyd1BjcEFmNDBUa2JPT21sV2dwMTdD?=
 =?utf-8?B?eEtReXFkWWd1Rk5lalowVFdZU29CMDg3L0lkVmxPeW1QdUIyc2dYVVVIZFVP?=
 =?utf-8?B?a3U4YWxzeENuVm5YTXZDeFVrL0dFMjFOZHU0RkNpSGRweDNXMVhNdVV4UkRk?=
 =?utf-8?B?RnVML3BTYU1vL0dSMHZtNTRVeloyOUg5a3MyNHk4RmhpTFpaYXJ2TkhURDdR?=
 =?utf-8?B?blorZzNqbTI2aUNtVTFydTM2MWZSVFNWQXZYN2QraXYxNWx6M09oemtRNDBV?=
 =?utf-8?B?OXMzandKV05oV1BJVHVEU1lZTE1wRFIzZkZiVlhHRGQrM1hTZGtXUE1EYWpI?=
 =?utf-8?B?WW5vNDFMS0R2bVVCZnBBRUY4d28zbzVCQk5GZHpYek40K3IxVStNOXcrV1h1?=
 =?utf-8?B?bWRydFYrL2JDTWxqZlF4ZUhtZDBkbE8yR0lhalp5L3NDS2NHb1NNTTZ4SEZi?=
 =?utf-8?B?cDUwK1BFR0p6UFVuczZTVUdhQVJERmhBTTl5Mzc2K09xbGpFbk1PY0hzSUt4?=
 =?utf-8?B?UXl4WEIyQWc4aEZQYWRDaWV5YzFFQk9jdjhJUE9WWTJLbGdhWnBoeVZNRHFN?=
 =?utf-8?B?QVpScVJQNytibURHdHRCbGhpZkVyMGU4QkVheWVOSTBpTENSUEZDbkdDeitr?=
 =?utf-8?B?U2hSVnZ4OXJzaENSeVpncWdUdTljeVA2UmF5M1VXM29jNGIyY1hMeEd5MTAw?=
 =?utf-8?B?L2ZJVmRrei9sa0V0NUxFUnpaNE9pcVRtaFVSUDlGNURGZXhpLzMwai9rb0pl?=
 =?utf-8?B?VlBHUEliRGEvT05CVkp1WUpKUDRNbi9TaVlzTi96ZG5Id2VOaXNjM3ZNWXl1?=
 =?utf-8?B?aHBrU3kzSnZIQmRuQTY2MEYxa2ZyRCtxZDlIMWJMVEY0ekszcFQvL1pMYWZQ?=
 =?utf-8?B?RytWMTZ1NTBjZ0VhelhVelJINzBON3VOaFNObnBQM21Uc3pNcE5tUC9KYkRV?=
 =?utf-8?B?YUYzU3cvckRYRnJmbGtzcTJraGJFY3pSV2N0NFZySGFhMnloYk5EbnpTTE1E?=
 =?utf-8?B?SjZCQVU0L056V1hJVzlVbkR3ejNsK3RyRHBLNDRYc1JhR0Y3a1ZWOEt4SmFL?=
 =?utf-8?B?cXhkekdQbUtPVDErODBSeXY0dVVpb1IxVzFvcDQvNkwzWUx4aVhXNUxKZ1J4?=
 =?utf-8?B?S3M1ZDJhN3g0anJzUWsxamZVOEREM2lmK0dDVVc5NkVzay9MM0pLMy9VUUFu?=
 =?utf-8?B?aWZWYjQ2cFJtODZZTWhhN1RKbUZrbkxxZGp1MUlFRlYxMzM3emtPbWJONGk2?=
 =?utf-8?Q?Yu9UgE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:13.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc55c9bc-a137-4706-eda3-08dde9f7dd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

