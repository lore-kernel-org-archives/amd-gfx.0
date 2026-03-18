Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C9103E18D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C238E10E831;
	Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pe5zlJwx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8C710E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsQGXMMOoyvx+02PMnDme9LpdfXQnwlbGpplZBMY6K0WAq6u3OJhPzvkUzlt9GhErONxu+VqpoFvBf432EGRH3FwmFiOUPW81xXnBT4XSdhov8NjbsjdGBVNN62EucMMN5WTqQZU3GNXmH+67ISjI+UEWJUPnsaCoE8JAp91MLJCA82hUB/iXHxt+csa25grlw6ESEOk1Fpi5edeERkO4ojB/+WAd/X1g6vnYFeAV9R/0OdxA1Pdu3ZdGFOWcHl26E4+uRUjLzUTh4o8IiQJAuVBpIuSc66w9qszCN2r6rioMk0QloqkHVagWO2uAVaVAYL3I6JZeKWiCNBGQH1Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHtdx1tOMYmhMCCXML0FCNnb/T1sYWPPeaDX81YDJ7s=;
 b=JEZtoJ7hfB+V2BZSPUX1cK2oyqVTAm/mGnXawEgMvbmb/VPjeMLODWsGCK1R5Pu1TrnCnJ0zA5Z4M7acYkckSy+uU4WIlTUCuKwEEyAmncuUGFPFy7WgpKtdZ/6iqbs+tt9JZcxu6MkYPI48CxbAVkfoqWjS4l1uFzR1srzaEebIDcewieuumH8nok1oNjQ+u0jotv+lAO1bzUMJDbneL9DzHqYFj9phnpt3SBnNhVMHRuW8QUFM6w0B6cCp+TLejKjc3nWHCLvGHb4N6Y/oLsllfGGTDPpt2G8PcRCr78EULNFVFgU/NWMvpCZbjKm1mdTMEMAsmwQ9IFXo8BI4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHtdx1tOMYmhMCCXML0FCNnb/T1sYWPPeaDX81YDJ7s=;
 b=Pe5zlJwx8Um5Y0c9ZyM/Yf2XYsMqWF+GXohU22arvW/Bblkigv/mWzCaa5CWvPck1ztphXTH+vr50Ax4pxsl08lhoj30d3xAQljXX090nDbtW5iShjsY8QNvRoxF9VsOlloOSi9nNxfknUFUtNhh3aiCmv+0xzO6/u349AxemDQ=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 14:09:05 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::fa) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:09:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/16] drm/amdgpu/gfx12.1: rework kernel queue priority
 handling
Date: Wed, 18 Mar 2026 10:08:36 -0400
Message-ID: <20260318140837.582776-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: a478c961-39f0-40da-af8f-08de84f7ea4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lul+qx/zkkGRnGjYyS5pNUaoExlFrw4rzrgkNE4RoMJ1x3KsmG8ISXVDI4WfzCqItogtaRHOB2Ui3rmEkxl1j1wiYFYFbnsRYJuapS1HStI6mAdy3XvS+36U9HP01dR6Lke/XRcnl99XeNlf9Bnyg0dfG93ev/f5x9WpK3IAwLdEzMWyKeFspjJzucozsccoU1LIzR81TpN/00F9dr7Y6uvEqK6lkAH5Ya8HJ2vupg70zkCt3C6PjWNQr0bqim6XGCUw5jLCuynh1p0L4zxHLQXCfYiockg1qw9F0+Mf+zSE/a3XCYPk9ec8fUe850JOE5kqp2U6WTwiHGRTpIHfGqz2SrV6QmRWq6/AFE9aibbFVJqQ6uO7/kpxbIo9hIafKUr7Fh23QR5gHuZtYUitv7tfIkkdzt2j/KS3aA5WV+Jzb3XvP6zdQDarhb+wAJH35h17bJkFjdxAg2vkBzzzaH+0Z8XTabX/aiUI/8JaqqnyNE3+XLfUqa8YldAdJwpdiDg9sthIgfoZ2zGC1/IAtyKEI+3gbdmqfCV8VViXf3VNhDKcjM5GdpXSr0tvIravWgli4/dkts1ykPcfviHq2/be9K7G+S8MlXfuJcSYyNEp60pQHpUoLODTM9tB7P0RUuH4a5IZJRbgrKL0u7+oddTwXKWw20+2xwOavhcUHfEZiZ6RQT5DcmoIb0HEcCiyf9lEdN6eQt23PgvrXoJZa4GST5KGU5PZz+elyzucGbqf5Mq71B3ooaosyVSLZ9zPUtnkFQQKkDdOm9TF2D/X0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWtcXnXcfKfEusFigCYFIgFu6KEANfP4WDObI0Dp5v8lueNfh7cRvhjyG+li72M06hIr/dBV96d5WoMdTvNLQc8tw6Ph84LQSmihMw2Ji//E/ixUGKIAfJgnUWY9ijrFq4a/quzq7M9WwE6XEMhD8XLDEmTv5u6GyKpw7YLrpQg27TZ5xL0YSXnVANLokBy5H7rC2YvFycfwnl260UeLRl2xXVRz3fcuRd12EqHhCfifYZ3e1OleDB625NbNX5+HEyKvHm6iHwT9CtCQEw9E89d0kAIKnT7+cvEadXXKtQJ0Omh6aaYec6jio0Q07fohhbgcqiZiNmEhiKMRZ7KG4SW0LFy+N74wMNlnvdj4ae6XiM+J2Zy/EqhqwXNx+XYojOEp18Y+0ERs9leZj0RrEAiztJBrl23k7Ws+hqML72lv6J5dM1ewvCTntmU4zW3F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:05.5561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a478c961-39f0-40da-af8f-08de84f7ea4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 98dc6582b7aa6..2fac3f99da644 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2248,7 +2248,12 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
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

