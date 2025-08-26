Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF6CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DAB10E2BE;
	Tue, 26 Aug 2025 01:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TS/T3g9H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FC910E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbUPlfwvUXiAAxgujcTHcflE2ONBIVmqJIX1XIvyxYw0I7U+23qRxmxsXa9X/yPchBul18G7+1T/URACGEDMiLeXDBsDMNR9l7t6hDsscMt6ED8ek/oDGDOkHzzmJ6R0gXhu+5qJ2buwRedgDvgA9po0m0qUTmT7lhfZ5Ly4o3cup3sfaHvAyUaT5ZTTHhOGC/DkqqgV2rVomk2GSWpII7iQSYmL/Bys5b+uY08DOirayYiv3vwtrrEtkqZ5IWeajJt2HjWnVf9Ir3VAf9fvMU6lWbxW+kNpjkGcrNhPyxzHQx7GrbNnlhzQZF8UQG2uEMkoTZ4zwmB2FO3qEXCt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=h1Px3OZFzkgMeNRg0DUopndGwCZ4vC/LTmsejTHzCJfaHZ9ibiCIMb6CuFQjXQ4dQg1Zu4yzpgI6a2qutJ7JiBBkUniEsngrZbiFrQRmpaZNj02KObxGxLPAxFx8VrjRU6GAsiQr1oW+vvgiKEO2IY4ShN11UD9gRyM1ZnpJD1rwbX4Ak1dospuG63A9jB79+WGW4jgDI6Y/FG/vrRWOdmrpW/AFkOxa/QbDHaTTsZ/xfnXxqw1JasO8medUbzfTv4A4N0lkfp3fzB0roLLcmlqgAP7R0z1AHVaXLA0AQ7f9H/r0bPyYklLeOlAYmwM030vQr57SrtdzZZWygKJWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=TS/T3g9Hr9tnJUfq8zpKEznqXqj0n6HWv9R3zmmuEcoxkY07pCCzHWR8lASc+0T54rD0P4Z6s+omG0vxGoTb3vN609krHaOIB2qmK7AeFMViHPOZvNEKj1rb6q7CuYQ0eggKw2yx0ZRM447bXsRbXnY51qwPEJaEf2XKRrmXDBk=
Received: from CH0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:610:e5::31)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 01:47:15 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::98) by CH0PR03CA0266.outlook.office365.com
 (2603:10b6:610:e5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:14 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Tue, 26 Aug 2025 09:42:13 +0800
Message-ID: <20250826014648.1711926-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 765abb13-429f-42c5-a93a-08dde4427b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GHo7wEeN1W0MHkriXlNdBJqI78wrVyEhB1g4RE9yJ1Balok8ogNwQJ5Z+w0D?=
 =?us-ascii?Q?PeKEc0MI+CxAx+/KvIeWYemlrlemrdhMfOAI7vH8SIb2g5ZNvUCsAJ+of4wr?=
 =?us-ascii?Q?Q/6ook9tgfi3xxK0UAscPopEXST/O051+VBZ/BjsrREY91B/O4z+bfzTGHoi?=
 =?us-ascii?Q?fi0kV+nW7Ofwphutlzx73pNFjOQbnJYmF8oUVNaVwTc3bF5C1zbgsHvIB8Rd?=
 =?us-ascii?Q?1b2exIDMQ7vbN5vJRQF40Oyi/TKPESXxvM4pLSJPPbFnxx81m8i0ZxW6IYAP?=
 =?us-ascii?Q?6nhqq1C+ab9OoTr9Qx0xap6uMHFz6lJCWAYkag0bzEc6CjRKWYqaUOTgepnh?=
 =?us-ascii?Q?5YtxfrSNllSQHg4pGaV/JZR+hFOccmnQldNt4k9gvw0xuf70nuGoq917pNDw?=
 =?us-ascii?Q?VSZvnUWlXitcwa4MBu2FOMpC2L7vSQ9NNcAcic2yZpxJR5webCvU1bPCTA6P?=
 =?us-ascii?Q?dpgwM4/2IJFd16ZzZ7jl1BW/wCNZnZJpz1Z7XxDxR8QehQ0LZqHtUFchbphO?=
 =?us-ascii?Q?CguNWDCe6RJ6oysqCCEnO/rp17PC7LBwkSt4kXHZkYaTu0H9NgJ2MmWlWBs/?=
 =?us-ascii?Q?oYmfM0u8JZ2sboHVLk1PQDkuOktfaH1bPQgCpj1jpRPJfcRCrn3893eFvkPi?=
 =?us-ascii?Q?4UywJSlwJ9B6TrwITLqPDTSEpS3u3UaTZSt4ioJ9ciQWUoR3oH9Y7wnMxck9?=
 =?us-ascii?Q?kfXDtg8qb2lMvp2RGiEs+LOhju4DluXd1HrsPchvX3CNriK2wcZp9x9Qjy57?=
 =?us-ascii?Q?8ZwYnlk8xUZNKgz2A/ucgYVeu7x0kC+eZ/rhL2aS0M/UPs4DoWz2mx4Htpaa?=
 =?us-ascii?Q?I9MxYb0nRyu6iDoF7aSlwpIkMpxnVT+sgUFtQ0dfsPAM9Aq1oiaVZhR4QAIv?=
 =?us-ascii?Q?icw1xSHeq7GsO4LA/5oe4dSwVl1Uc2l7miZfYfldFn0Jhyg+DNHCqzC0c/tR?=
 =?us-ascii?Q?feZRsRsbzaIpaMXKnjj/nLBaUCrnPDBodDG5fTAg9c8vjgM1nqYW+LAbkCIX?=
 =?us-ascii?Q?NqLtq2cRDsuSsLY4aWYSlPbYjhAI+4zh0cTz1gU/SHnGYdgcxsXPKT/LdQnU?=
 =?us-ascii?Q?u1ptC72fp4NMmbRp0AOhLlcosF85nnmb3w2Cv3BWDcN7Yuni21twlZtym5cI?=
 =?us-ascii?Q?ipL7zwkZoFsDWVmCcVrSjtNlm7hZ1zarVNZCIJSbzUW/jLLjnOgBGjEjizif?=
 =?us-ascii?Q?/eJNXQBkvzin2CWUbvCkbSKmD+S44ucMIdVdx/P8hwJR9I2a2rqPIpyRP7zh?=
 =?us-ascii?Q?1C78ZlRhA4zU82nFZ6hms5wXiBq0mL0/5LUMnMtjJ6lxiSNCP7JKXwx8yaeK?=
 =?us-ascii?Q?7+l0MEJMtRPTiTnIZn6/FVgtJ8IZQoN6/Dap+uXjuCH+BtC8M8FMG7aENU1D?=
 =?us-ascii?Q?IXSZH9pFQiTYlOP3Nd5ewsyKMzgW1uXz8qRzuxfWDtbFsiiDqxrgGXLHql3n?=
 =?us-ascii?Q?bcz+vLIDQNPWv+xfCvKkPTRP0X24dfCqf0IPPw5jUH1hj8Zcs86+kemSFkEw?=
 =?us-ascii?Q?iEs2wkRD7VC8DstkRsWBQYedFBXh8J9IMyyE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:14.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765abb13-429f-42c5-a93a-08dde4427b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

