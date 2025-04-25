Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23EEC369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415BD10E98E;
	Fri, 25 Apr 2025 18:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="492IlOqo";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E3F10E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkomXRL/hZzbBxLw9Vvka7/6KwySDxquT6KbaixkjxmkuqtdrQEDLOgDgQ3a+13TBkW+8JkuLUiywUXqVf/fbu+fAfLqoPMS1D9O/iIAHH34VBfQP+StjFAO93fbOeKpAGH8wcc4V5Tf/fFLwf6/oTozRNQdctbWH3ALsiqdX7R1vSKhLvjS2QAyOD44W8MLjckSbMPzoxFJ9sMRpxPtafPu6Ag2WWVpQml8H6xtM3GOZa1RDIlGmobMEnBY3ZwAfCtrtKm1fG6ixImPhnYxNgnZ67E7jOrwHN3HD5Ym4daF/0rJTurHlwGVb2GRhU/nIzh9vN3VdaifflmcNz5Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FQxKn+mPWiPKGHEMgEXFSELTIcob0cSzmf76M1nJO4=;
 b=AaqL1TRM8c5sKYdaxJIkCJqvONHCpVdt1+IZSDJdIh/v0BYZvIMb9xTO4fYWQe6lHdvbSVkS8P6bPOoZEmYr30Tfl7rMwKKRv2/RNtjjvvsbjYLhZT/Guyopc5W+D1d1jRkXpWx2OIioxkyk161TwGiWM9BrK9ysqFgAVIthMR60fSuKtKf8O1kpdSGh7H7qkOHYqRLu7is6KlAuzk16lxreekTOwtic6zskn+vzNygSTsUWsg5NNLKfYX0sv+K+2IyEULy5USvCZQfNRz3T79a41q2mDJIauIkCSHNcNDOo8YS8byDr68GYclbvCzrF3Wyr/SekR3D8nDvd3h/jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FQxKn+mPWiPKGHEMgEXFSELTIcob0cSzmf76M1nJO4=;
 b=492IlOqosRr9P9j6ouS7lAKC+eKHe1TLQWe9ZW6isVyuysYVVzv9YDU7tNpiHOJRN5AO39lwy/aY4nDOyDJlFS18iy3RqrP0ZEL+6I115OYBoD/7a3sSV+2eHF9vBpXJKVawMdtoNNtKbXm22WowYXq+uG4P2nJInWx9u3tS7fg=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:11 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::f8) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Fri,
 25 Apr 2025 18:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/userq: add force completion helpers
Date: Fri, 25 Apr 2025 14:38:52 -0400
Message-ID: <20250425183855.165199-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f553c53-2837-406b-e189-08dd8428786a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6VO9nLnfAICi5MrLozIjt66LTIrcGJagg6+hMv451u9iJH2EGFC7GOjdrIzq?=
 =?us-ascii?Q?6/R+V2V1ySsEdq69Qd75Q+Gx0ODnhTGI9XKHHME0KsqiOkbPl9KTU3pYg4ov?=
 =?us-ascii?Q?I3OPr9RJ7HBAl9FOEOEP9BCd+Nz5vauqRO8fIEKAyeR77aoxG+Hh3+gm6uA0?=
 =?us-ascii?Q?AxBBQkOEaR6Sf9y3S6qKSx+x+IhhPcWR/U25RulYkSLv/btvVVWf7+UxZfXr?=
 =?us-ascii?Q?ZsElSrjo0bhw5h3hTdrbUwCQGHk5GFBooYPHxodP1bq4hCB/ycEAF5vQsuto?=
 =?us-ascii?Q?IZngW0R35XN/t1SZMHZN16mstaDR5d0Ao/JV89YSu8bzA2HYw1bZ/V+lTcv0?=
 =?us-ascii?Q?2+awwlwGGKpGxr2HdnB2hAWG1mFL8IyMz2Vaw/k0TUY34jmMahby9t01D15H?=
 =?us-ascii?Q?IEUHSMSRGssq8EJ1lWF2u29bPuFWJMdPWAbON/f28MlcbEFkWkGDL+IlpAxS?=
 =?us-ascii?Q?fal2Vhku2xPT6DGRawROdrZIE4wILBjuWsplGDLdsMV+wP8G8lEpaKLUuw2/?=
 =?us-ascii?Q?zMKnPYtyEUJXkDQ6MW761YvOe1t5UEVlv5aRXxQPqSckrFgPvqH7ucsHS6kI?=
 =?us-ascii?Q?W8BXi/RK/LVbaJCfT4ywUX/Y9DsV2kWcj1Ys76MUd8CQZtOWdTrcnHzsR+7w?=
 =?us-ascii?Q?BBM1lYNqSal91hrGv/HKzQU+6G2orq0STH6T5uXWypkM4unrJA+Vl05jnqvg?=
 =?us-ascii?Q?j7C4rJ6jfK3lEhLgn7ZGP+dTmH5HEfOEGqvItayKH0ejDbCZ18pH+EtDf40K?=
 =?us-ascii?Q?UoU64VvwvKWJTRnfbBlVDBGxFnG2no0TunS7KLW1W9p0pHTns1y58MdqoCZc?=
 =?us-ascii?Q?dsbVEAESXcm60fSMxw9jFVWNF+ch7OYSuW13zFIrXSkETxzUZYeq0whPGR6U?=
 =?us-ascii?Q?TU9B//OiiUZtvihhu6FcZr3FcnJ5Id8fS2A1N1XTRh3mGC6Td33Cg/Tj4Uts?=
 =?us-ascii?Q?B1leX9w5uvWXTXYXUksPZ3jDD4Rn2cM3K27RHZ8jcuMk3XYXmAChTAmQHD0r?=
 =?us-ascii?Q?cVHXcEKgDLvkCruiyLZ+WtrkSGz93bNN9vw9T2rm1LugQHi6u2wQhOuozC1C?=
 =?us-ascii?Q?1ogCDR4Wv22cMOp7+zhYT9bTrAzUo4PgTQ78QIVcSVyvMJ2gW/NLVl8r0ErR?=
 =?us-ascii?Q?sFl9Z7uX4u+lXY0//wseAt/CmxqD/emVDuEPpcFdsTxm26uzt0NFVWml19rp?=
 =?us-ascii?Q?mgZM8UjB1jhEj9xt0pGdczcCBCAGAF2r1fbtzK5vhdc4cCI9k9Ou4I2aX7KY?=
 =?us-ascii?Q?Hw19RPaqzpFxg4qBnCX+xSlBZVlR5ZjpJ26QGevozXbLcPFcX7ObV2aLonGd?=
 =?us-ascii?Q?E4+kswMJpTL2TzOwROTrW/DgMVZiEP4KhE76itEeh7AEIOCzeD3oMCtMO1Ni?=
 =?us-ascii?Q?djQIBo/cPeaLPALtDMtp2MdShJGHicRKQzlCY+aGqCoEkdefypNBzFeEOK5b?=
 =?us-ascii?Q?O8HQIhoudckWoGquOVst8qJA5Tb31b0pl6XCnQB1N6DpwTG/kqBH+9UAAs6Y?=
 =?us-ascii?Q?4DLY4NaYT9FU3QQPynYY2BYv6oJO3GerzGhr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:10.9526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f553c53-2837-406b-e189-08dd8428786a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e7..3494ac9e9e9db 100644
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
@@ -408,6 +416,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
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
index 97a125ab8a786..d76add2afc774 100644
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

