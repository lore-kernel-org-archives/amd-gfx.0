Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23034C369AA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809D910E393;
	Thu, 10 Apr 2025 18:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IO6aNWaU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E2410E390
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRaNSXLFGUgopgve32jGGMoWMeqgffTi44tg8GAF7GToKoKG+OkpX0C9b+/Pl6uMM6/oue7thU9KOKDEB6HyRR+E/KFOoml00dpD8Q+2cCFSwEDgDkqAzwuWysBteoaNWKC/ZDhGDi6h6zRblYljP9CZ6nCGzDaqMmOffyhkn3a+8LxG+EbXe/iVDUhmKb9JKdOutJmQ31Uvtmw6WGMYorJL+ZpLlq6haAyBbKTktLZSUzvLxfGbc4ZX2a2dgJvMmJTUON3JutkwNxF0TuHY4SEBpaDn1HHW/CXQkIh08Rtx3Ywdig2vGWkl8R8hIc15oUQWALxSu4OhsMjBILUQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87VJoL2db6y9XUggg7dCar4crra7YvJTImRKLNSvxMo=;
 b=w/Y0zi/wnk4t40R/gO+pr6TgaaaXcEv+t4RrM/jxcJDm4pcMf+K4Cr4uZo04cV7JeS4/JCH4K8LyjFXZJVoFBD/u+ezfYrlFkn98AtobC0vsxgGomMeV49Fkl8kOuYloLY67ZzLPDHa496pwnFidn7ztWbmn+cbvSy4Ivc+EiPcGpzLyDVEYCeUPfSVlRPhW2/8GG0JkRc6NO3bAmngyuPBVUloexZ7a1131JVwsvFBRplztPus9zzk0qOpiGG33CUY3nq0/8q6hj87gilzGLVdxOE4k4ID8wMaG4atx4a2Oks7b9TEMujJjtiXuXGuXEFs2gf/J5Uwqta5ttBJRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87VJoL2db6y9XUggg7dCar4crra7YvJTImRKLNSvxMo=;
 b=IO6aNWaUL9xT72H/kR9/0CqKZAV2l0rjqx+Gu70uSfFzoOLMiDZZbDydN+u39xcAPInnG7TlS0jeIKFaJOXMR1IaR9Kjtsu9zcFob318b1QmuGiLUZCALG8tBF4DlX/TeP+nQtEg9mzNl9ifRYRrhbO2DH5s6XgYz/JK6+F7TMs=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 18:54:17 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::29) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 18:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/13] drm/amdgpu/mes12: add conversion for priority levels
Date: Thu, 10 Apr 2025 14:53:53 -0400
Message-ID: <20250410185402.2352109-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b8683c-f230-4911-14c1-08dd7861180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZcTUEY05jq8MsZQbpByLPccLzXCQwIDczpvS1UYsP6VEUrTSuojL2qzmUxM?=
 =?us-ascii?Q?3R0bth1+IWnU5tprFX2kQCw0t3tjhjaNcPsgU5VyUjTsA/D9YnXv3cjNQ1rv?=
 =?us-ascii?Q?Ce8GgQOVT96Z04wgn1/8G0MhbyJjjPdl3TSOzyzJzxB+cwTgXJG1TnEPRbo/?=
 =?us-ascii?Q?DoOk4zWlJwpHMEuvqxpz78NnkL2GWXSwvkPHao8JvCU4wThPnwjIBBTxU4tG?=
 =?us-ascii?Q?Q+IPi6e5VqXQWssIW3pWNjAxPeDWnsSoCNDav/GTyQGfo+L/fqQ57Yzbjg/d?=
 =?us-ascii?Q?RqVIzk0UrJufAKnRODqg4OzzxkOG5fYJvyMIjPLM8MBkH0LOckFir+TxP3ld?=
 =?us-ascii?Q?XvcwmywWEg+cQ2RGgxrnt48IxBSJTr0XUwG9c09OWWAY63+TXU/ewk4poIPB?=
 =?us-ascii?Q?M9H8h7CjZsHKxQIp9zf9HuMSw7aFcAScEfN+44PPCfVefa2UyFmBVdXvI4sI?=
 =?us-ascii?Q?SODMpPuznBJYLHkj2EJYK5r5ZCgMlo2LtUmMIrPUb/sEtAd+s5+lM5bq1mCK?=
 =?us-ascii?Q?xVeGYV0JRRTunFmT+rPOEHutpsDBngqTin5h7ER6ioH1rDnUJmitwbly8Lwb?=
 =?us-ascii?Q?shWSLWY4ABdT/t+am0kvUWi3m3dEZ/tyDo6NUKWBUHS+ld9DbdMd7PosBn6e?=
 =?us-ascii?Q?3/YpUX/wDATvv9mJgu+BWi76ksxLYM3DqqsaStmnNZDKOPiu6ZHosDuyDIcK?=
 =?us-ascii?Q?dUoN/lUEkHrK2O2bBOwwjckRZegZutCsresKnrVvVOK3cFaBI+ojUS2adPto?=
 =?us-ascii?Q?oG+GS9KkwZWGLAHM89bQV+dlMZOEsKGqVu2pwxPeKhnjqnkBlSYjdrKowK7w?=
 =?us-ascii?Q?tSZJNlZzIK4fOo0WCGGj2AOm5bBHbabO5eYfl4pun2GbOwc9I0zk0mTNfpiE?=
 =?us-ascii?Q?foYHRPzKbLKakovFbpj1OJRU775YigBJgx7mrU9kyac/QTfjfpEy+JSygjqF?=
 =?us-ascii?Q?L7tDD8XvySuTsub76n25/H//+d77jiXow7fmoziKMAhETxHzl7/mbMAysTt8?=
 =?us-ascii?Q?ZzJpkr60JtYg/EhVZx7/UR/RkhobkJtUVW7Kuir/o8pgG9/liTBT/qeQU7C+?=
 =?us-ascii?Q?8RFr7LQF+f8WN6yShVxJzIryvIyYmYE0AjY8HhFXNu9jjIM1GBX7jvAuXfJs?=
 =?us-ascii?Q?LaJt4ZLLf+ZfxS2E5nH+0XF+HYFtN8A+4WrPjlFYRmXBpJ3MHSbERoq6w0W+?=
 =?us-ascii?Q?BdYwsYD7BhF8pI9WwR3Vo9WXroRf63bmZLtGBVmHucC4DHWz44J14u4W0d4w?=
 =?us-ascii?Q?+27Y4Z9Fgc3kM3vJaioNjPbM4XdLVouSPmnON80APVpMzk7hd/04DpODqNcN?=
 =?us-ascii?Q?cO9lYh3voDo0+nEuvKbU0DkuTYi/bnjAFzSZPvmB0RE7gHbVAuGfJlAqzVRE?=
 =?us-ascii?Q?sdc250zAPYsjWQnPpCLJRlMc5ifEN0prYR4NTOJdfjA6vUbiBB30UFei0wOn?=
 =?us-ascii?Q?rRUqnJFayO9TN9AmF4QbbkhiAMqiAElONE0UcbQMYTH0loMA41fvjYZU85BQ?=
 =?us-ascii?Q?OXUpfXzawhVhBzA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:16.6653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b8683c-f230-4911-14c1-08dd7861180c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

Convert driver priority levels to MES11 priority levels.
At the moment they are the same, but they may not always
be.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8892858cfd9ae..852b8f2a4e387 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -274,6 +274,23 @@ static int convert_to_mes_queue_type(int queue_type)
 	return -1;
 }
 
+static int convert_to_mes_priority_level(int priority_level)
+{
+	switch (priority_level) {
+	case AMDGPU_MES_PRIORITY_LEVEL_LOW:
+		return AMD_PRIORITY_LEVEL_LOW;
+	case AMDGPU_MES_PRIORITY_LEVEL_NORMAL:
+	default:
+		return AMD_PRIORITY_LEVEL_NORMAL;
+	case AMDGPU_MES_PRIORITY_LEVEL_MEDIUM:
+		return AMD_PRIORITY_LEVEL_MEDIUM;
+	case AMDGPU_MES_PRIORITY_LEVEL_HIGH:
+		return AMD_PRIORITY_LEVEL_HIGH;
+	case AMDGPU_MES_PRIORITY_LEVEL_REALTIME:
+		return AMD_PRIORITY_LEVEL_REALTIME;
+	}
+}
+
 static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
@@ -297,9 +314,9 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
 	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
 	mes_add_queue_pkt.inprocess_gang_priority =
-		input->inprocess_gang_priority;
+		convert_to_mes_priority_level(input->inprocess_gang_priority);
 	mes_add_queue_pkt.gang_global_priority_level =
-		input->gang_global_priority_level;
+		convert_to_mes_priority_level(input->gang_global_priority_level);
 	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
 
-- 
2.49.0

