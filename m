Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560D7CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F259010E503;
	Wed,  3 Sep 2025 08:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wWhny1cZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6234610E503
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgyrRZXX+B9EonXycTo5Buc07tb4IhoBuXslyK6vTJrSKWAfWZKVE87hZViOrjqpkSbAbKBw72C8ROP3SufQW7TyWlvuqlOpyG80t9dgvM790wb9l6kCjrC33Ty25SuBDQEzQzQMvnkdykjKXx2eqnp9V8wMYSkZoPEMV9k9fr7Qb/yRPdolrn8mujjg8utvt3guZV9UwdEXNaDdyfgUqvo9RJfjnxi73U49pWNJVDkfsM7/EfwWfti/k1L2RDoqFko83pj7/kUZWcs2PdlbkMNrnn3gF2aqp0AOHb6TnYxV11gDauT6BZmQDZKQgjEs+HJytR0gXaDG17ovYcGwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=lBqMHC+XUYk6E9/9voT9RL1pQHISJjA1/FOHYbbMR8lP025As466BcAJCsVtrbo2aA/naxxH8WKfkSTuqsuNGByRSPIfIMf78eWAA6OFuT8XlsK/GEr6VsPPjdnQZPlsxcbaiuDB+oK3b4Ef5jgwLbCYXKsdgGiOfNaljOA1H7gqOu/aM66+qNbAxoof2rLMb2etwoqtmFkMkzMBxa4W0zjH0OYPRY4GzMAJM/6UfLO/10YdMETwdGeJ5MCj9Z2MsYr80tn8QT+G1AhUgPOj9+oTnbSL+AqFv35Dtf2pxP0H5LdGLdGZWkHDZYyDU5A58BAlD1IHvaHwwfAWMcY65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=wWhny1cZIXE+H+/hrRDmkHanCrullqU8+qNibOukcqR53t1vfhzjAmp7pFyDJ+BtT5fnqZClSSRibPL+OGEZLveNqOD8MKutlVwslCzf0laPH4Dq6hMHYR2NDaYqoiBZuCOHgE3zgEpf0kBLEVzY+MVlF/VhcCX/DJHIZa/Y5Uw=
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 08:39:35 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::ce) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 08:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:39:34 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:28 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Wed, 3 Sep 2025 16:34:21 +0800
Message-ID: <20250903083914.2604482-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fc2581-3253-4d56-d8bf-08ddeac5698c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?quk0sb+X+pef/cqkCsY9K2VBZDPCQw52yC7ie9sW8Sl/aQOND6rd46dC1sER?=
 =?us-ascii?Q?k8s7uDf6FJaRvyFmCudjrufjkx9E5NQQjz83s7dlT4OsSqJnQOPoRDC4PqhS?=
 =?us-ascii?Q?Bxmbyc3/vgSFVeB5/rEULQD0RoZelnLiM1dq/2PU4eZ3hdC1X2FBPRcbPPWH?=
 =?us-ascii?Q?Yzb304PiLYXpuJs33ooL0oDkppmrcn67jZ5cAE/Th3mLoq2FKSlEG7H2awE3?=
 =?us-ascii?Q?2Wo1RPHBUdAbvZgBrs+snMEAZyKOR0dxuHn4Vpx8p2tgF8huXZVX2JNES+Hw?=
 =?us-ascii?Q?oQrB7db9zASPxQMHt2Fokg/bYXRV0gIPjVCENU1vAWYigD9HjzSXvWgqRW3S?=
 =?us-ascii?Q?Keuc3ThokFG2PD/OuHRwXsTU71cBXJc6Qj6HQiqb1KI5iR9gfZYXNV2KpRYy?=
 =?us-ascii?Q?ey0ZYbAOsDwAf1nX6+8oXuh2vNlKtdRR81nm3ka48NECUd+f0Axz9qsggdGz?=
 =?us-ascii?Q?JxcFUg3DuvykvzZ2BElq/So5+TWrhh7o8umQRt14iI31ZGOMeKqfuh5VdN62?=
 =?us-ascii?Q?rIDw2b9DPifRrjYyWXZbs3aYTEOAQdfTgUaFG6+E7UvmE6TW9oc4w1YnN6KB?=
 =?us-ascii?Q?nlTTRJdnyN6ok/ipQNnqK1IT7Kdcnhsxdb5t5pP3a+hc6zVI/BdFqzZUmZIm?=
 =?us-ascii?Q?tyAwvsyc03k53Ur21a6O62JleynTmvCxPsPCyKDeAT0siRO2oXIYUeUtTWl7?=
 =?us-ascii?Q?393IEY2dKgj53wRMOzvFJRJ66ZSypyqoCMe9ClZlALiE1i41dA3UDM7TAOpI?=
 =?us-ascii?Q?xAmB0EKYglsc1l7cTEPf9gypKVF38SkTr1/xLRi+Kc3ZtkmP3B7um2kIFjFA?=
 =?us-ascii?Q?W/qH0IBc/9Jbojq+b8W1A5kI6t1+pJFhHTXOZTPuudzcEwHL9yTs+YPK4/3J?=
 =?us-ascii?Q?InM1aH1H79XPH0RIyXf7tSqdTy54Hv/LuZjBG3GF7Zs9FpFrf1Btzb3uC77o?=
 =?us-ascii?Q?TXF2PRY7G8iVtPNQLSUdC5TK/hveTPxiDQviRLsCDbUUAenvxeuUQKRHR7jU?=
 =?us-ascii?Q?68A+54K1x1dGatVWlORO6N2EPk6x6VE/H58JzA6Tn1P4T/FOQ/d1Yr9o0kkd?=
 =?us-ascii?Q?TynvVaoE8I880WSqz87YB1Pc7QfXTlVca1mlBetB/7pTr+Y6sj3EJeQZWaLy?=
 =?us-ascii?Q?8m8DSX4FjBeVBBQ3HoYCef2Dq5jp47/KfOHVwUp9BXbGYmdZ+by2iS4nfM+6?=
 =?us-ascii?Q?a6navQwHazS4S88SHYcMnU3YJVsUPMtjDNiFMbhmvLQ4sDb54KKvcH8UaOAb?=
 =?us-ascii?Q?Fqw5t/CqURLPkkQO+l25MQfwr2tafOhkzEYh76JJa1hdRhWGdAQAB1YCwXST?=
 =?us-ascii?Q?cxZWMWifnWsM/fywXC0KmXyUGd92u+x8Ff5BMEnIECOpHL/ouNeVOOVg794Q?=
 =?us-ascii?Q?zsIApml/1ZTk3T0eHosyboHPmlXWBn6n6/c/0IjtqsIH+d+T2ENKsUq+dxV7?=
 =?us-ascii?Q?gG0C8rWr3xoOHmnVg/TvdR5Nhsjrix7sgZKmi1lvBTrXxOz1zENxFu3OF7oS?=
 =?us-ascii?Q?AWU8wNYXAV5TDMeG3xF91Vtgt38D6rzG998C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:35.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fc2581-3253-4d56-d8bf-08ddeac5698c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..24c61239b25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

