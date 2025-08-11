Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48789C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BF310E409;
	Mon, 11 Aug 2025 10:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whqEGAgb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C5E10E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf0T4fzANF+UFsjjxTjBQVGVvsIzhadPnZuYZO21IesaYiXvoSFjlS8Vh3yN9QzQdra8ZaMX0RMa6e6rc2EZExXlMB5wpD/rR+x/iiGJub1UZEGIkeQTlfNRQlD/gtl0ce/nmUB+ezaYexmTz4pn+qMV0nJhcMPzBvo1pHmQAYlHDcRXef/vqJxTxx7g7mAc+W0lxnQB7atKRCB4jiSVWQgem4nph6meOi1idPfO1RfJVfFEC3fdlcLoHMKIZNNWP32lV7/ToHUwDQk4rd3CXuOSOT/7J2G9VJ17bcSXU+wHZu4j71u37eznSxJ0Xgwvik7wXRLjqaqDZw0CioqeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=aLsA2dANtyfr3l8VN1Vwq5PhdsSzEpIUO8md5Xx4pJ664m+12GsWnSOSwptB+VAh4dALLDLD/OWe2HDhEPGjz/gYhkoRj7yjCQtk7+Szqcnahkdxi27jP6FbOYcnFbBi9NTa4voubAGEkYvRy09ptTjm+BDSr86TCKlmg/1hg6GRIraA7s8NsHRgo9YQSB4kJAQmO6FeupjiMvNCYDUdYgLl3jMkxgIdGvEtdCVf486glKjRx3X60YOyqrvpNoHDAQb5dzZ4+TFyej35aOaH60fqtpQqXNCTE4f7xEUn31I4rD6LuJ1lAoGwX/oi4SMZiFHJ+8lnBpPyqf3ozKRHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=whqEGAgbCW2fOEn/mcH9jm1kLizUnG5VWcjmYBKsGB7ccWddnQXHL0vwig8C9FeeXagESX4QirOBoi+Tft6HUUv2rjdQvYtVMBS4JqgtSOB5ZvsDqw1yaMZZhHYIOSkEyiP8Wd9feVnFDp0jds5ellKPVPxen+Tro/6qx9pxs68=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:00:33 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::2a) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 10:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:32 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:26 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v8 08/11] drm/amdgpu/userq: add force completion helpers
Date: Mon, 11 Aug 2025 17:56:55 +0800
Message-ID: <20250811095937.1978747-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: feaebc35-f6da-491d-b966-08ddd8bde928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yzk1aEZKZ3VrdHRvSlpLL0tEa3E3eFRKdDZ6OGxVTnFpd296SjQxN3ZpVzNI?=
 =?utf-8?B?WkdRSXBZbUNicGNiaWUvc2taNHk2bUlpTVVnN0RDSHFPQ20rRk40WkVzKy9q?=
 =?utf-8?B?WFhodEpySVMxR3lNSkZ4S043QXFZRGVSNWQxbmNQL0Y4OFFhZG9DSk9YSC80?=
 =?utf-8?B?NnBVa2ZvQmdlWkRER1B2UHZLekx2b0JMSkFLcmhEcE1NOXhzWDFEeUNjVEtU?=
 =?utf-8?B?VEtWRDMxbVF6RmVydWdzMmVlOU93RlhyNThpcjdkVnVFWitxSUZPRm1BL3lt?=
 =?utf-8?B?YTBvY3A1bmJrQnlZREt6YU0zSTZiK2NqbjN3RHozVmFPRy9NS2djK0lGUWMx?=
 =?utf-8?B?b2xKUEhsbFdlaUpFc0h3VjlmLzJNNDI4dGNwK1lSeHA0TGNWcVlnYlJmZjA2?=
 =?utf-8?B?K05pNFFjRDBPZ3BDL0lKckVmVlJtZnM4eU5xUmhLeUx6TEJ0ZGNTRDlSSTYv?=
 =?utf-8?B?Q0Y1dzJZZ2Z1YjFCNmZ2bEdkRy9wOTVPaGlSdEdiSDJNWnZ3TTdsV29JQnlM?=
 =?utf-8?B?dmhCWUREZUQxZExFdGZXUFg2UzdiZmx1YmplYjVpR3RDRWgzd2haWmZlSE10?=
 =?utf-8?B?a1VtWVNhaXAyd3JpQ0ZwWEdwZG5RcFlxMVB5QlFFcWRpUVh1TTQ0UUR6T3pj?=
 =?utf-8?B?U1RMbE5ONjI2dE1WUkZMRGx4QlZlUU5rMERWS01MdVo3UjlnZUI0Q1hicXoy?=
 =?utf-8?B?dTMxcGszUlBIVkx3Njh1Mm1jQW5ZQ1JOMlhyRkdneTQyQXRPYSt0VXVXZ2Fq?=
 =?utf-8?B?cCtRalNMWklDNXZzYUZVbUlvRUljbWVic1o1dWN6YS9FWC9MaWpiSG01Nmpx?=
 =?utf-8?B?TmVST1lGWERjZ1RzclBYN045Z04xTUNhL0w4M3Rma08xRzlScWRIR0hxdjN6?=
 =?utf-8?B?RUpvQzZTQVFnUFk4djF4T0RZd05PMWs1NDRLS28xbUZLQkp6ZmNsRUtISzhE?=
 =?utf-8?B?TEhoVzhjVXJBeU5Ma1NLRmRCVlhGUkY2K2lLREhNeUlZWWVzbHQvN2xLcUp6?=
 =?utf-8?B?TklxTkNpZHZmTnBadU43NVdSaHB5c2NNVGtFc1ZiK3k5NDZyK01xOXhKR29n?=
 =?utf-8?B?eVowU0tsQUNaZ0EwelJMNGN2TXc2ZW5DTEpPRkdxY01GWnh2VVNYcmZPZDZY?=
 =?utf-8?B?VTRLcUxlQ0UwSmxtYit5Wm81N0FnZUhVcDZZMEI5ZVU0elVkSzUzZGREWjJI?=
 =?utf-8?B?WHF0Tkk3UlNoS1JFMnpYQVZna2duR2U2OXJteko5Tk0zTjBadUMyU2IzZHZZ?=
 =?utf-8?B?WVlMS3ZCZTNpZDJORGRFNzZmdlJZa0tDMDh4UVhQWm9FWUJwb2xuUFNRc1pZ?=
 =?utf-8?B?U2ZkRGhEaHBXaStDQmpaejBLSmZTdnYxN2VpWVBkSUcwczJPbVErN1p1SElE?=
 =?utf-8?B?MUlaYkI1a1R6WGdtMWpTUXJ4ZlhiODJ3SDlVK1hqNGhnMjdUMkFnTGQwTTN5?=
 =?utf-8?B?VVF6Vjd4VFdyaC9ycGp2OWJOaFBwZlBCYlJTeWJJT0lwKysvVndXTVJ0UGRT?=
 =?utf-8?B?aEtpS1IwanFPOXBlVHV0MTFrbVFIK3FxcjltNmhiYW53RGYvcGFOYUlVZGpY?=
 =?utf-8?B?VEQ1bysrS0hLRDZjMkVkSDBidjhUTDZVVStnSUNteHRnUGNrNm1TMWtTb3ly?=
 =?utf-8?B?bGx0OUlxUzJTVENlY1g1L0pPZlBvVzVhZDVLODR6WDNOSkxycVpCWkdqbEt4?=
 =?utf-8?B?MnNMdktGcE1wVVdPYzNtZENNVisxbWVueFRtN2c1UXRNWS9Gb2w1K041VTI5?=
 =?utf-8?B?cForMW5IaXdOU2hJNnd5MlJ2dkF0b3BqdnRRMHJUSjhTK0NpNDBoNGNrVlpF?=
 =?utf-8?B?WWpxRG9EV0JVaGdKUzdzNFl2ZHdIMFVlb21YdkhIa3d5eEhMTkVuTElrVXJv?=
 =?utf-8?B?TWR4SmtDTWoySUo4eHVKWXdpZWpWTjg3eEN6L3dQamdCQUtmOElpeEIzQys4?=
 =?utf-8?B?NkNJajliVkJYb05VdUlEQmlMaXVpYjcrUkNXSWRsWUNBTG9BeWNkLzV4ZUJN?=
 =?utf-8?B?dkVIM3VHOW9VQWYwSFcvNUpiZVFzeXM0bnVXdGd3ODBmMlFTTlk5YzVRVUd3?=
 =?utf-8?Q?nJJ8P9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:32.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feaebc35-f6da-491d-b966-08ddd8bde928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

