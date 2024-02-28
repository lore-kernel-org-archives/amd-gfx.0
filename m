Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5418BC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA98D10E3DE;
	Wed, 28 Feb 2024 18:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xouWwTw2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DE910E3DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5APtnlgVj6CR1bGsmz7/ztwg53RasbcvabBuCK5SdEcH2a3k+TDfHfP0V5Oj0+Lyr0CdJ7QFWl+ynUkWRjvfFo1L+AZMWD26iMWZ4aJOSGVWoLm53PeEKPrHboGl9+hxyNNp6CUjW7UpNofHNKS8ONAIzI/PPwp0N+DZn2+kGuwayDHw+a7D93K86d8YVVpzC5CTrLZY394Ak0VUDeDCk781Nkp0auR414kGMUCtTjEMCgwxpAeD3UzUUupQIp2zNJQdv5jzjGI4WXb4OwJbDIVjXiw3w+puilzrNetNyydRe+S7feUg/rjxu/MYPWV69fa7p8eIeq/aVtEJ+nGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONHe1Lok3CiSLsvJxudFj22Ldo0X8BTkQgUc/TUbkw8=;
 b=CS5S48aYXcKVi6S2qOzvSCf7IxBbTiBIBAZeK3XFArjnu84QOgkCnv6ZD6AyzXZ3alI6v4cBYjDG0IxFxDebEvLZkvXlK/14SheYZwfr1M3aKynNLUOx2HslfOfEaBVFp6xvP9L1Y7mZtysvYJVFUFMctEznXhqtTW6oKUFhoRMJC547WDwYfRS4BhR/EDyRxbxDlT/hiOQiULOJ+gXf5Yefehrk9zY0YuJMRT7R8wU+m+zsQrykb4/5qaN3FIh48/uoILVmzlm+w7lThMOrnzPTAHFhwW1LablVuy/QjAKeBFYzuBx12TDqXB/ocrWF905Dob/px9r2Etw8T6lcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONHe1Lok3CiSLsvJxudFj22Ldo0X8BTkQgUc/TUbkw8=;
 b=xouWwTw20RBey0sx1OD7mbgEM6648NghPIJP6JUqyj/SeLUYdzsSVfEfKp4XE/5krnt/DDv/QPzpeQlqkBzgJ18ik8bHXhawFC0aa5BnkDdgcSLU6a5ATRHcoFEFeSrMVsUmMEEkq+H3gTBlU5mwu45GQ7FGslBrDlB+eqpxf8Q=
Received: from CY5PR15CA0201.namprd15.prod.outlook.com (2603:10b6:930:82::10)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Wed, 28 Feb
 2024 18:42:21 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::83) by CY5PR15CA0201.outlook.office365.com
 (2603:10b6:930:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:42:21 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:42:19 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/34] drm/amd/display: Fix function banner for
 amdgpu_dm_psr_disable_all()
Date: Wed, 28 Feb 2024 11:39:13 -0700
Message-ID: <20240228183940.1883742-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9e114e-7b2f-406e-84e3-08dc388cffaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ntv3SLdg8FG5xUYWvLAE4XjFezAT04beLswxDlhpmNdVXx4uf1FI7eAFm6NWhN133SUtLDLGXLR6wJmDAuudDgxJFGPQU77y2U6FATLcOu4qmKlmeqsAVZR2A4NOVbmjJv6X7ax75LM5d6LD3bg8zPUbd7I8T4IzV6ks00tnccAxxjALNKSey45qd2StfI28eiB1MM1UktdsnxDP1OeLEgKWYYbPgRsAyoTunQLkRxjcUl+kJqKGqbtuRUyCYT+mzaeBH66pC+KpRJF3tBvwW6Y5FsCml4pDJZ522hN0j74AA7hNB1erTq9eRDEDnFk9gtaKct27A079MiWGQQD9/VnyYJKOK04gU6VXWL9VQDbJCduifaUVBvppZqUPe58chAdIwb3ZqjmuTgyXSBemUBF6Htw/35tYP27vJWKv2R5iTwWkMr/Nq1ArKdbK8EjA/F2GcAEskB/SJdhVbt1uATZRhk74Zvk1yYGwjAPukkSG174YkGZqqiB1jCsIC8NVvsjNgbZk9vmgr0FQIipQN5guD/XvccgglcwBjnuUE4j1NP2eXgGN7GUhsd7e7sreO8TGAYorcQYccj09n+VcDtbHVDQGjqQTZvOLr50g8OUmKG99fB6rVDUv5AKdrR9BeLh8kupXBd904gh2GF88/vkQeCAiED2BKXp3UGu/5Q3Qv5VbqAYLbEuCyv5eod2w7CurYWGMqwwQBl97EMjhvcF90Lew8aIwRP378M28pkps2AFlI+0uNA6Gje035zEx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:42:21.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9e114e-7b2f-406e-84e3-08dc388cffaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

From: Roman Li <roman.li@amd.com>

[WHY]
Incorrect function name in function banner.

[HOW]
Correct name and brief description.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 1f08c6564c3b..a48a79e84e82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -210,7 +210,7 @@ bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 }
 
 /*
- * amdgpu_dm_psr_disable() - disable psr f/w
+ * amdgpu_dm_psr_disable_all() - disable psr f/w for all streams
  * if psr is enabled on any stream
  *
  * Return: true if success
-- 
2.34.1

