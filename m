Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4C103E18B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3B310E828;
	Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DimJCs/l";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87DE10E830
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8zYUFgadEDyUE0gmGSnJvSDhRnkJ2KyS2DRcd4Igy7TDhsTcDrR6wJiE/RePAGfJJ8f/P6wzavtnAnV32nbUtUib3bqChs2O1ptiL3Ulcik8jBzeZmhbM6zJSlXQcATmSxmTN1o+th+MxXcOf+AQvNNofGr03lUjq168EmzIrcB5hRyPv6xmhdJpyOJA4qSLlIB4iF0i0cr/nP1jRrrpHilhZxFA4DwFluVr9EImEAe+UIyticaX6+Y0s9eMET/bQp4apISnfYZbeAAChNrsRDvR1eLx26nAcDjXOH+IosyINCRH9I59M7gD+LK7zqikrvvWDF/nPOniYOD6A2XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc1QjarCokHFyODsuu9fNVIPJk3Vm3+pjORnpWr0cZc=;
 b=MUF15QZwmPR6p2H1n0IVlnCc+dOnIy/Q9SZ7JY3woDacX/EyOJVrv+YeynZMqHO2r0vJMMoKy2BuU6jTfnibxN/98pUnzXaaIxUIP9E61+Wxp/H7ekwv+MDrvZCChz0BkQWbLPYr4qX9BqGTkhlLMtG9WnYP2rAwRL4Spr0pt4fxTwp0QVD8NEvF0rxy1fN5XLALJ1cQN1641PQGYzfKFWkfpTtHTi7aMGdWztpIYQAbKlfHN52bPZL7laZl2BA8POuvZg1+/EvuyGWwctANNgDBgrDvZ+8dBRyx+8ZtqC/RO/eEZJydeFipL5eAhWazvDLOHEQRriqEz1IwF5TwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc1QjarCokHFyODsuu9fNVIPJk3Vm3+pjORnpWr0cZc=;
 b=DimJCs/l1LRgDudKq2RtrlbJ3WNb0C5rk4YYsO2M6dbtnszZUt6LlswZe5Pnun6VMwfco9UdnO585ueTnxfIxQG9+yvC8fYdbwNkRmOQIpJ4Bp5ahWQhtKbx4G5RSK0Rfg9B6HtgfEHWyG2AHK7fnDzVEcA08LvEMYm+FQttHDY=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:09:03 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::fb) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/16] drm/amdgpu/gfx12: rework kernel queue priority handling
Date: Wed, 18 Mar 2026 10:08:35 -0400
Message-ID: <20260318140837.582776-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 69147603-9767-4453-7880-08de84f7e8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fQ76Sb5dXQ85/uCRUMh2kIAvOsCy6WwNxMRVqDGOJw77UX5Z+Ti6wTDl69jSebnanOW+DbWw0UTMk4RKYfDUbLy7MdW2FhxSS4Ch+A2X3e1QqAh46IWZuDZp/72p6LHjCg7zw4y04Vboa3zPSmb+pPTNIBzUexCwicm5XaC7EaY5/BJSSkAYg4vE8nymcxzxYRUTxmeapN5S3ydFKHnZxHnIfeThhfhNLblprQEig8Y2NCzB3I/dcY3kr6U6fRVXGIykpvgrXK6EvKhIlatk/HwFjGKsvJroBVVnAv7j7/53vylC37S/cnkDJpG0R8kGBobPHaipuSU2bdGy60uNSzZwSVS2QPgXcHC71SQ4ivCJkZrOd0Wwhl+h1B2Hmq6ypZ7EKXftv7R9fg8jMZF1uQPlKMEslvh5FTzwgQTmBRfKdetn9FEtzUv4UhsUgYrBHK4ZWJJZmrKtr6r4BWrWbZVgVP5VGKe9xgurnmO9NQ6cjMPuXz8L5XvcXvCzEsdRoyy3KPD/VF6Q0LliMDx2htPAf0QZEiMkFccSmEV9HPI/E588ww5bdG9thLkqCk1zCJHQtPBfxT+5n8DKR3nthj0BzadYueuv+96nz+nHZnfrz4din3JJMB0PqFPIp1WhEmNoJqV86D52r2ZZ0x8oJ1LV5vrmUStYDo0qWPIq02aQbbnJxpA2p5LZWOV1fEDUJYhMwSdnu/rgMumQiAoIwc2oKmjjF5Z4pEzVYSCg4xkk1XfxaAu0zXoXt7gn9SUm27GPOaw5SMjWE/O+DQX5wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wsMP7Oa6eubOJ3zexljD2X/4eyqXUH3QdRGsM1NYOFB+v6Oc7tYP+HjTQb37iDvOob1DpuORl1Cm9AL2BQbthaTx1nb7FiOf4egxSExrjTc0ZOFnvGeQ45c7tVFeq2L2qqj3NJIfC87+pq96KUIktyQGdKDzaNu55S2jXW4Nj2adKkMUfL+ElWfnWdh8lVSt4uQxhAnhJRw5lkWYlOZ3JKXIlHO3G/zgszfUORCS764tfd3HAwUWEXqB9HzcFk9UGH8dVkqKhICSgFI9qLsgvjWiTY/ndRZ/3MdOKR5Q8yPTNMSxCgZGghUjMTZEq/MZYzFuWAFABUE1+CiSbz0yeMlNJ4+T+YVRDsjzFHX0COQ9P2CdvC+8ebWcS9Ac+ryyL3iAbQIv6SBUIFVowmfn4LUcNQWMnzOnf13Vi9RPzll9MpUw+WxH4cc/lOQRe304
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:03.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69147603-9767-4453-7880-08de84f7e8de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cd7b1ab2233f1..66d058a40cc32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3003,6 +3003,12 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set up time quantum */
 	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
@@ -3270,7 +3276,12 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	mqd->cp_hqd_active = prop->hqd_active;
-- 
2.53.0

