Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A231103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7BB10E826;
	Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYXgW9tm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F12F10E826
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN2GNd0o+BUC7qMHAFZAbmZBW8WlbkWyUw2o/j+mLYydRGXoFyz4kvFWEXbX5pGOH2GtOMIPnk2dwxEDVyT1O4w4ec+UxxpytyV/GtZVULqGgE3qTubX1tjtKAhUiDO+SSqcwxUsFv0b5KMhw+jn8xS4Bui/TdteNN0bVaQpm4OO8f83GoTQshSKjXnSUnkouxdgNuKIxRqQFB2ogYLpdEqIle5P8QKIQ8cMCD/rGhPZuKNgrhzt5GyezwrvQh/R/er6cTnI6jbq/H8jet2ESb4SNEchB6V07GkHCe3ZpAbl3/z+ACazv1y0fNLGrSXUN/R3/pKQ4H0VJAYgh6ZeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLYTigwqlsBne5PwlW7mDs3LoTHZiewF6fYlwpX2Xa4=;
 b=sw/s7OTXu4aZYcrRTxZJOHirrJrBFrezYaG3wmXPx/946jYmU0gjViit4tzYn7vu2oIdJIFXYQktfOvpyIWBY+UrhwPA6aH/ItdVYn4FG1CHUo2BdNjprckvqourCn06nCKE7LcrNPAH3NYsa2y+xD6bj8uFHdv9qmkVDDXmQUzFoh91r+c+foe4i22Pw5atFB+d83csQjROPCoIDZmu54YQLAH8NG/JvUN6mvtvCb3X4EGYbcSsq37J9LFMY+dyUAkG0ml5bv1HqIUMX9XOdrb3+lnb4+Qd47+TJwFqIAJvR7lvl1wknhVtAZxhi1PXvhrYNeujYLzCpQXMpQtyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLYTigwqlsBne5PwlW7mDs3LoTHZiewF6fYlwpX2Xa4=;
 b=UYXgW9tmxvlnnpnt9/yRGPKya9nMHhM4dOkQC2lvR/PFUgjNdC7VwnfOOocwgy2fqM1Svjnp38TOePUWYqjFRBNyJkhYSFKK/RwANVUAwLKfnMHi7ESBG1eqdeDCPSl91XyWhdxb22F18Z3qAr02Yg60tEt4Kh5VMQfpxYeZv20=
Received: from BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:03 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1d) by BYAPR11CA0107.outlook.office365.com
 (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/16] drm/amdgpu/gfx11: rework kernel queue priority handling
Date: Wed, 18 Mar 2026 10:08:34 -0400
Message-ID: <20260318140837.582776-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: fff86537-ceee-40b5-0a17-08de84f7e895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7u2wDJNgd+TkHnNQqE5EXWIOZT8AAwtE0GrdpxGSGr/3hUTN3tjEyWojtSlUVLhZEqTi3tn/qw0DMHxp7amngPc/6A36pZx6nImnuUbka2Xl+kaG55ob4RGHu+iQkFj3nob8BoQdIQsgXBKXcqQP1eStg6cIB8EBPuh2xONEIcNCv2hlCqwpe74tPrjGTCosLmS68YIPju4Z1Z6kjEKw8pD/04GwFlGSavJa9kjdtPWTYCzOErfBbq5YTzTgzOaUaeFk93KrvG2ABZ83T5CzH6RSQnbMXNvBDjKArqOa/tyJ9G9umD9whldFsUCt6mLaA3gcO1U77uNY3KnwqhWviP8zXDW4E5oAOxW7ZCVGCPzPhycRV7r9OeFqFt6Efh8OO25NXUy9X93qvBnQy0+1E8IieG5smYO3j+YHTiZx89W614RGn+nGURWsVfSSye4MTJw/88sGR7lEemnMVXheP/oPjjxHTMhVQ0omLz6mc06nuw63cyQRGVxb+hxAtPmuFq63jI26yMY8gt0zBR2ajAIxRuwsfxflKCNsKbV/oZlY6mUvw75HpkFsO/64slWOinOyXUgA1yqwpvTf8QlwXMVLMXlP2Xbct/Ki9kClQDSVLrZwMxkaGRMU38xKSoJHwfj9SrsoyoGVzU6gfmc50xXqulct5uHI1OTPL9K2AsbcV/vGWtw/cUxXJwEoiaush7dCGYjE80Gl8fQYrbmrabd8B1iqhwbx1z7ZbQhDYV+WH4gzAb+rj8N5ZAFn6PU8l1szNyk8lN13rfVq12UZDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y4dO44bMGXnuNGdO/Czk/0CMA2+xMoPxC+h6baVEoWQEg4QEgNrvxsFaXNTqHWFgGoG6F/njt1ChS+vqXVay1xGG5C1iJ1/Iv6olhQUWtyatVbqlzuH8pYa//IGEF3eZsieG+cEnTDXlBEVVF2HmrZdCYVNJXa8TWkADvAYJJNbDi/LNQ3oTfwCfMLT0F9c0IQzSj8i6SIMDrMKz8RhEdT/RJmhk+ay29key4jvBALhbce1n67UoUDPZAwHBUYLFRiV8NlqH9w3d38lz391ss2BeCdQSHUGgZH46FdAAMt3s5vMKyn69Xi6RHDkVEOVGA8ZDJ4zkVhVPJU8hHEAUI53OXGBDDpRh3sJa2mHW2iT1c7zRGWft5rQpeUW3jAGAc0H71Qp709SvLQd6iarqtsOEn/U4MDnGXn9ml45Y189pGR7Uk4ExjxyWgRuSv/Op
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:02.6174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff86537-ceee-40b5-0a17-08de84f7e895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 121290f8b4930..6426270e9eb55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4130,6 +4130,12 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
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
@@ -4400,7 +4406,12 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
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

