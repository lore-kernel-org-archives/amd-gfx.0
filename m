Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575EAC531E9
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 23:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA07810E33D;
	Thu, 19 Feb 2026 23:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HlI/1f7j";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D28110E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 23:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+54PfY3JMCZUAMYyhb2iJXfs33EQbF5H9UyQ+UsFxOSxqbgjHP9MXLHmWdp8TRY6GV9qAIOdrYKaMTIBQUtUtfUCQoHGXo5gtLQmZfIpJMf9bE1S45MJKRzRbOXjvrqUKTRyjLxSdJ6L684g1tapDMpzr/wNCkPuFC94QT7uzIxbRxFBEpbbJ7BPzzBiQ/a+mWnFj5JN54etgp/Elik7lwMvTVoMlCxR6gGaDy+C0koXHsxi+FafMgRj7OWPaIqSud71pKQ0P2JUPkjRz72iUqQWDllKgbB6pmC4aRrfP1ApmbFhF24RXxTv8lDI4sdynq1iEGapNGlXAmqizWdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcM4sUveYdml1DEz0lndjWHCMh4cePj73UJawKL/rZs=;
 b=B6oU+GnQnAjkfJJFNH6lFN3D2dlAARAPbjNe+Y9DSx2P3wrb6hJJ3vOUzw9YNKlHDz0tcX0X0klAmSLWtn9UEGFlrNSIFxfFI0v6sVBdNc9tkL37YsvCWq2S4HpsPEqhA08o3+Dzq4DpEXAqq2K3FmOg8D62yybTKzMoQLaaFX/5WSe79hfIsUhHFL5am2e+qNT6PDeUMN6C26FOeIh9BQei4puV9CQwH1+M1HxQxOeKDDH6dzoDMZGG0/aHlk9t8/D3r7uyYCT3gd7epbv7ake+Qm3dA6wgxCMXgalV9buq/NJy5O5Gelmv+3+r731zSdbfMFyKUarYuLh2pHspnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcM4sUveYdml1DEz0lndjWHCMh4cePj73UJawKL/rZs=;
 b=HlI/1f7jM7nrRMUSAFAqnBXc+WaTt+ltBDw9YUME4cBnrWz7zq6P/ddE6waFv0a+so/I0H4a92Mcbw4jFUsc7SFKTvsRxm5DIeHXtv/y8vna41ofB/76o7z4Jcug0WHugrbx23xt7Yos94qVf7dYGyTs8Lz274bf/NmOrGxnt24=
Received: from CY5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:1c::32)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 23:24:48 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::22) by CY5PR10CA0018.outlook.office365.com
 (2603:10b6:930:1c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 23:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 23:24:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 17:24:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 17:24:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: look at the right prop for gfx queue
 priority
Date: Thu, 19 Feb 2026 18:24:32 -0500
Message-ID: <20260219232433.31453-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219232433.31453-1-alexander.deucher@amd.com>
References: <20260219232433.31453-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b867bd-41b0-4354-0a3a-08de700e12d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SiINks9EBxo1S/ix00gedgvJawaxcIT2yvDVZ4ysKs4sIK8T7nxgRUfWpzSU?=
 =?us-ascii?Q?/Y8WFIs30pqkWw1+DJvQWxKRFSwOUgtrQJZ5dwJF/Wwj1XpGDc/+ku1Vr9Ho?=
 =?us-ascii?Q?10BggdRFZ2BxQRtexO27v2JLAcF3XPNLe68VGKW0pb8ppM9wfjxRenaTUGTO?=
 =?us-ascii?Q?ZwpeWTsUiIXCpD5/iJmaEEupE35gtqlF4v+j4rITi4uI9C4CoweCAwQJm/nL?=
 =?us-ascii?Q?Mcq9DNrK45XvkI8OWJNtTDvlvnpg/ZT8zUkfdxnNaO405knn5Wu1HEvwkaKC?=
 =?us-ascii?Q?PU35Mp7D3wu1IQj53imS7nkvVW5TsyX0gj/7yQh4rOdVar4i48QKMEW5lhiH?=
 =?us-ascii?Q?CWsC36/3TmD0RiUB7B5y9PGNWAi0e8u5adS+9hnw2Zdsmy1Sn7ZSuKluqqg5?=
 =?us-ascii?Q?kBeFcEXuLppKEK2Yr+N7xdDBk4a7uqATx+V+/2+4ELqb9bhyjGXXFKQyIaUw?=
 =?us-ascii?Q?nzk+gMwqP+nU3FZt3y3AyfxVL7NKSIWGhO/8/8wSoWbH1MrjWrVS+G5b3dG/?=
 =?us-ascii?Q?44U7B0LxA5Ku9iXZO40G1eBr7TAD5UtWv0yh6BDbUh0UyFZdr5nLXrFUhiYN?=
 =?us-ascii?Q?Lt0pPNZNSndDi4eATp18u8d325OfLNJULHsKAk9L6NK4j1pJJ5O7uSjwN3m/?=
 =?us-ascii?Q?EffvsDsnFXNmsKBjBPk1qbiQxsOwpgmMgFpPYf6GEzCzPDKv8spYx0TNaJRd?=
 =?us-ascii?Q?uIsF42pJbjRKq1wkFTdjDnUjXX/QzwrQRIVGRUeSKUmefzguP/UGZDeMGZel?=
 =?us-ascii?Q?jn3bwuh8dAG6Yk2FuU5aASRFhmNtiXM50407yhrXS+6UkoC0rudBWPRZE29F?=
 =?us-ascii?Q?MOQDjYuKrsMawFOHi++h+Ak5fj6djL3bNn0w9JObKN2YWKasmMeAao5NznXu?=
 =?us-ascii?Q?EmelLXAAJLXznt4/GZUQla2g0CWKAO2AUHoG/YtAhGAttaL3Y1k7cyG9UySN?=
 =?us-ascii?Q?S2skZ2a1hKVKtxO1d9YMAV8RcPl1J79JTebpTboHlthxqKMtz65kiKzaA+D4?=
 =?us-ascii?Q?ebhO2nHdBTDT6b7/gXGUH8SfKQO80HDmxIbwMWq2UH5tdIjlKhfLq2BtGYjG?=
 =?us-ascii?Q?sQ6Ap0PxndLsLh0w//fCjLnxuW0fmqZFwZroFBWQFNs5SlStgRmzA1i/a4Kd?=
 =?us-ascii?Q?EtQVhxPnlQ/B9pPE5+DJuXWwAtLjfQxUX/hYi+UMCM6gIx/wJOKUFwGGmlAt?=
 =?us-ascii?Q?u8NgMjz8WOpns/t4nUfvAEh8XYADQfVUYlWU56/UbFsKXkMPlMw+AuEU9A/m?=
 =?us-ascii?Q?QP1dUlDvp6agC59cRYkgMfr62MRpcef6y3+9FBfSnNPmRMlBMCkM2tylmICx?=
 =?us-ascii?Q?hF3rAn6u0S9obGLGwS+HvlpndAiScC9cWI0VfiXCV5Ljr+/0Bpx2IyBItSZd?=
 =?us-ascii?Q?L/sYkL/WbRTkBL/P/9hrqlUxyg9DxW8rga5CG25O+SeMlfGldchQCxMlQtCC?=
 =?us-ascii?Q?G0cnh6stPnHgznT2KmRQtT6k4NyA0XfReTkV0uu44/5dR8ptEK/RNxZtpLBu?=
 =?us-ascii?Q?C8V9Y+QZKcg2/0hZBnrhAwUXIvCSMxKEVK3vtsc/XIfNKBfd0r+yh8s5QL3N?=
 =?us-ascii?Q?uH2njE+7dmnBp38TYoBsxXd45JrRlCQtTA1KJS+1Ds+L+Ht1M/8IvAzfEbry?=
 =?us-ascii?Q?uyIY5L2V6LwomPTDxJuWA9byoo7vsQFiqU38AtKhW2rZ2er/awRhtSUmis/9?=
 =?us-ascii?Q?yHXTrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OQ07gs6xv+eUfDlnE6efXw8b0GqdgXARRYrQ0VCOUzHCrKD+Czf/Pb5qr4HntlG4fyyod04rnQnKM5P2TLguIP/b2EOGDmPYJkEHSIzWk3fCHlYfK4sTSDedQh8nWuaf/QFJFD0CmUyi9EWc/rCqn5i+q1sq7oYQw1IhROmX50OwzydMIdAfSK35vi+69DdGsYqtUUdGVpxPJ0l5YU9rUUlIv3RUxf/r2JrtrYpgSYctpgG/gqLkv4GM7RSFTHPM0loTaAhCeq5GnRTWBtVWiK24WulKBAFoelLLe4gJ92owOEy3TW2aBzFsL2qbhnJqzSSFcxizYKdts83dVDfACI9e7eMMfecKu221vlcuZADeMuPbrBkiI00ikpdVKs11yHGQQ+i83RP1HTvPG9o2FbQP6N0qE9a4JBwSA7JQZRAOrOqemhNJmJcI+Hic1KT4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 23:24:48.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b867bd-41b0-4354-0a3a-08de700e12d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079
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

Look at hqd_queue_priority rather than hqd_pipe_priority.
In practice, it didn't matter as both were always set for
kernel queues, but that will change in the future.

Fixes: 2e216b1e6ba2 ("drm/amdgpu/gfx11: handle priority setup for gfx pipe1")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 98da86ceaa041..8d32671ce4a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4101,7 +4101,7 @@ static void gfx_v11_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority
 	 */
-	if (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
+	if (prop->hqd_queue_priority == AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM)
 		priority = 1;
 
 	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
-- 
2.53.0

