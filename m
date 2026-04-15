Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A772F43857
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA3810E71B;
	Wed, 15 Apr 2026 16:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5ZY71q7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9728C10E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTMt+15oMAyoRZebVPmZs0uei3tGTUe063plUmzR38ryi8drDFGM8xDAQWrpZbn4HQANB7cmEe+EG98dHuaWF0j9vtSI2r9agftmlcObLY+T+nzROvDwRE5TYtQ1S6LwdhoNOHWDYxsDba+Ut5YJBlJo6ENnXTDWUpYkfvAOeGOhGeGM+Rxq6OwpdORfqi+phesNb5P9DpQV9LU8wkFIargmBYNHxUUTjFPToA7smEODEGDUMIBOuWvER//vdbMiBZrl+MZPWpzcWklLrpCKR7Uxn+pVrFHyunrc0aGnhVmIS79rPeoANipa/ESyV9JLOaBORJUSTPAX3UM4ob2IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViDMoovZVKZ++rUqxeTIm98tarAB5c5HsYl2/jc6FaA=;
 b=EPh+pM5WF3PKiWngvI/R00RpBaDRAbnwMo58bJU5bMC7Xyw6j5pXgcI4Dcv2p/5deO9f21ysA+MfAvrZxCftQJ/ExEEQyvjKCiI1ws9lf3QXo0OQqVAwjOCps4Jz0z6roqR25tB65HqynmSq4bAoePs75knYdFJVoCGQWV5djjZi7ffrQr3JRRsl+gb8FgxiJW+bUCLniAXd0FuMnOVJL2goXCiPyZPrzbfIFrbJsNiUkQn4+kI8/VK8h/linoo6WJkDAOmvDW735n0fU/CZyCICxX6a6AGMC63O7uDypt7jyE4JzI5SEaNiffnEardvbqckGJpkmwioJCSAcgeKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViDMoovZVKZ++rUqxeTIm98tarAB5c5HsYl2/jc6FaA=;
 b=H5ZY71q7NVnTMS1xbhEpFRp7poTTh6naUiZOpS4a/BZ1gIKBlZHjVfNC5mGBuUcAZTpFfXsGbweC00Rhb+oqmrMfZfIdPSDDqSjMIbOjQQ18NHS/mWVPUzl6DTMX3213NCNyBBDoGjNQyIY0tHzOAyFXC7JL+xmA+AgsiDTnh6Y=
Received: from SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::8)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:41 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::ac) by SA1P222CA0195.outlook.office365.com
 (2603:10b6:806:3c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 16:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:41 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 04/10] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Wed, 15 Apr 2026 21:37:05 +0530
Message-ID: <20260415160711.261553-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baf3b4b-1292-45be-ef8e-08de9b091f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FSODQJJv5CTht2iQnZu2thtNKoaAyaMKWrczIe+67+RZWDg+LyM7X+oqaNF5GKklRb/4nlnl+JD8P1uJDjb08HGKG/PnEaMWxkQZ/v0+dnyZevWXyf2oWOfCwpmgp3vMdTzKd5OmXuRDL37eMe3TOZq3P+pmozNIYWW0CUKibkdVYaMBlK2XgIpMcdOGGGMT4lDliML/tsFI8raVGzFYk+ZUJq3QuvGpBr9TrHZo5wp2fkukw3gW4yGemnxpOrzmGyoI38ENIaXOKhwqWarJDwbcMxjfhvbBgyg/JjdP0Y6y5x4qnQNU6bYPNzezagexeWeCtFCcQ8NMLe6xpFRJicKWjLAymW/PIVxWHyNj7lNODVV1jdur+5AYyaaQgG2MVJTBna8r5RBQ5W+JNrkfuskf+8xu8xgcwermI1WosAjmRFrOPkVkgQdRqYpCIguHU7NKs3tUaqNIoi2WWUSTpWtO6espIBy/k+Ln/aAFREmcYepVhWvYJKEiYLFisE57kxFR6NDB1RaXOOtxb/+FK+hxEVkinxhTRdH8Vym8nXAg42mQPcIAEcGNJt9UtTWZblQLNP0yx1D1DnRZeqQozg4J0OXhxqv8tbuB0yrm6p4K1M8vKJ/SmGzCykjAzPs9YwZGkUdDRn/2PDBlBVT/yXA8Z7zLcu6pbHLghWQuEjhuMTZ5WGeQRzoBn9OGFMgO+rqAFVnu5pUI7TdBGVsmJ+tWCLfqMZYuu0nJW0+4u4VTUk97vQNtcQSmsr3Os3NRYbKd1N0663xta08qRhQBtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xvokZcEVpUzU28EBBlThCcYpfD07lnY2mylhY4zvgxSQjViymos8+ZCUjYm5mtLQXik5CFpvCyUD/T7GXlYye5h2qnHzrhUJrr/Iz3pkK4Clnqy3b5JiMbDr/mZKOBrMHdN+X+ByaEfNjA4JIxghhITYMK7Cem4v57n7wmzMweIWjQonzv4Kox3g5Hk+hUjGwdcuGjXg3201kJubOg5IxkKOaf41bccuvBx0dvUa1KjgXUEO7HKN2eGFfvKqmgh7Dc6Mjd9zRZvDoa8jQ5/cRgK9kX9yeLFckj2amqqeqSFa9i0s2P4UjZO4x1+aiVWWt4wCRrrH5uYccKvXfty7zlK/554OvnU7GmIhUrNyVhauYfuXOLF3ifHEMalPO7/LL8LO6PZ/HE+e4NrfDQE/7AB7GMr99lBGofYPyUy0DkzTnj8yh20dTaoFXF0IW8kD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:41.5636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf3b4b-1292-45be-ef8e-08de9b091f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

Queue USERQ_EOP event records into the per-file wait-event manager from
the gfx11 EOP interrupt path.

This wires the first producer into the WAIT_EVENT path.

Use the doorbell offset as the current queue selector for queue-scoped
waiting. This keeps the initial wait path independent of a separate
logical queue id definition.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 00e9a265c9a7..d3c2cce44db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1319,6 +1319,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8ce039eec2b3..725c33ab5c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
+	struct amdgpu_wait_event_mgr	*wait_event_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ff43902a9c48..20864d12ab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6546,6 +6546,10 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
 					      queue_key);
 
+		if (mgr && mgr->wait_event_mgr)
+			amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
+							 queue_key, 0, 0, 0);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

