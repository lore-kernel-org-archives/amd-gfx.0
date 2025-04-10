Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30152C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7978110EA35;
	Thu, 10 Apr 2025 18:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYZuCcQ1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B95C10EA07
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUauPmyHk2bFs3u2CIUloBOZjgZ7FxyBDBvcH7/gK2tL2+47wrlPb0MMBGnoxFA5O2o6hvfm2bU5UpECkgqTUWdH7NvB0MmwdQk9VSTLVP/wAeyW+KQ0/9RNMviD7f8spAbOaI91Uf2UqjR3AIQlxrRCwTb9mTwm0biYrg8QXuvIzWa4amXwSz6+aVadFrovwKZrqdQwrLLjVe3XP45n7j1vAoklge7PW4/gdMIh+fi2Dhkz4+1SJzNBqUUbU0aOY5Wuc0Jr8+ErxuXrXKauiByP9IH/NHOdC4HsHEC3Ru4MSbrhPyYdUpb6roZUZs+v5LP1Ki4vVIXBmQ/e9x7WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUxtoQOGox9STCiL7/D0eNVIaqvr2Tm6O71KsQ75Ss8=;
 b=RG+eYZiC2uSemUurzmU+/HzFYXsub1ed4GAyfqEaWTA6KOIUYcvHYCPFDunnp0vh+UcQH6Q9QZeAaeX/wNYNCoUhkJgj30BdYuhAIwhOzVRPGb/r2S3hGAWE6BNyrXqV4bRSUXYMwuu6WHFMObkpj2cB90nIEGbvF6FKqdCfpGmkPwIpyRiXdHeY5af9Wr+P59AWBFWiGLp1lF4PANCr7QR+7rr6mKDXN+U+Ypll99wVbgBX9ObfwvtGGK8qkIGIsMyX+SSnnfsV6dg5qCOnB53OTR2P4Uoag/Z6H08mSIcZuqWsR+96Raj0nJe/qfwz82/9m9+AXue/nSscfEHz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUxtoQOGox9STCiL7/D0eNVIaqvr2Tm6O71KsQ75Ss8=;
 b=ZYZuCcQ1JjY7zDPTUypabh1LAbEh2z42Pv7KPXaotHFP+J2FSnv2dvUYpJqv1F0WF1eDTkviYIS0K7D0plAwBjSNgot6WugNkRhcT2mLRVUtUBhDkm2FaVi0aYIx5EUbpUEUsnV6Zja6vxP9yf4uODP3+HvhJKQSZpIzKO9Os0I=
Received: from BN9PR03CA0903.namprd03.prod.outlook.com (2603:10b6:408:107::8)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 18:54:21 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::fc) by BN9PR03CA0903.outlook.office365.com
 (2603:10b6:408:107::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/13] drm/amdgpu/gfx11: add support for TMZ queues to mqd_init
Date: Thu, 10 Apr 2025 14:53:59 -0400
Message-ID: <20250410185402.2352109-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: d93a659a-8726-4ecb-21fe-08dd78611a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMDwSpeiIvmhdcoy71rjkMct7sNAsKGWZzAZWKm//U7bFtTAATxa2Ddkf2hc?=
 =?us-ascii?Q?P5O1S/10/tdk+jXTTqU3cK8kmrXhH4V2OFjshLCjlSL7KB5n9O6GebIsigwq?=
 =?us-ascii?Q?XqrAVo2V+7sWUXjklftmNlmIPowq+wuHVcNxEVHc5u10+GfqZcmB2dnkhHS3?=
 =?us-ascii?Q?DOCYAOPG+9ZKtI1jHhcxmn+V0mXK9t2nqt6cfNYhog4xO3ZsenLmCNP8bBPY?=
 =?us-ascii?Q?Ny2fr2PqV0qwAGtAuZAPjkuzXd7AVTqWBEB2EUpCkmnBjWdLMeaQYUZG09mS?=
 =?us-ascii?Q?OjLSyD+6uLAThRrfIyW7maXOEx58wIhiyvLgUUBAMcUcQbwlK1QrT56qGv+f?=
 =?us-ascii?Q?xEwLIknt62uOudpEcIeFT45UjhlbY26vOmObZ67A/UNlamZhs39xHKyur8kC?=
 =?us-ascii?Q?DlfaQHhRyG4jf0Zj59E5LEMn7tHIiV5pgZDzpbAWtW5z7WK91tG/DnYeYGML?=
 =?us-ascii?Q?jp3OrQ/FKgq42XQSt5Ww/eJBl5sreYMnuYe942HKg66rGqoWtiusxqNKGrF3?=
 =?us-ascii?Q?YFrPPpESLR9jyIQNkla2tLk0nlwujCMvuNwpnNPqNHmT69S4B3yN2oaRLofE?=
 =?us-ascii?Q?te92dxRtIYAASuy+WvNT7Ia2Zq+lVpZuMOmKWubpETpG+jJhKVeFLwjj6Cvy?=
 =?us-ascii?Q?WIE5//lzC+YYP7uKTV3YcGSvOOhvJb/McKFhUVkb+Ej/wCkxeTGXZvIa3ug7?=
 =?us-ascii?Q?AcVw72MqBZYzQpGPUksBVchCyDYQ+EAf5gr+crwbdU9skIyGwJWFo/ak87XL?=
 =?us-ascii?Q?2XQ7dcONk0MgDyULmaBUZikag548VGdovmuKCeJn96lyUkVr8RCOlCPRanhe?=
 =?us-ascii?Q?eiNn70GM+1o5ZRZlNUsoL/TN0BerZNAIccC7xZMNavz2RnQRWCtBdIupsHSe?=
 =?us-ascii?Q?wdQy6/ISaEeGLisjhSuCK19J4d3hmXLcAG5wjNu9YzXkqfuvaRwKhan5kRzq?=
 =?us-ascii?Q?1Tr0iiJ2c4ZOXbqiK3mslW0hbo1BmcmaL3RCTPRMr4K7GUOMVAVe63oB6wVg?=
 =?us-ascii?Q?0tyINa0pBHvEEwZ+LDCYuzLz/K6VdpUoSACY3yandnRnSQNp1VBwDPozUrqu?=
 =?us-ascii?Q?poL4PLCfYJ7stmwrJVxic/KatucTVIsRqkJVJgeqDr+ZorgwckLnAP4Y+H0l?=
 =?us-ascii?Q?D6hTmt3vruut7I0Q63I3Dbm4IMPMPbg7LhhrfGbOaneGX3Pf3JRMKffaSwO1?=
 =?us-ascii?Q?zLU4bjavCiuPoKd2m967TmBwFWoLPUwYMQQsc+Ah+9kEcTvHZRr6JUOXylyy?=
 =?us-ascii?Q?wR1kbQvj7JAMO5/CSHFZXhufH6Z/tq/OXi3tJKvoFEMB+UXglRPauUiZYxdZ?=
 =?us-ascii?Q?6ClqihpADKLNCcLKev+JhAu0p0P/ga+ZUsjH7ODDW1XBwe+xNnKfBecpJmeM?=
 =?us-ascii?Q?uTme8oUtHubwbGCyruCV/6w+1Rf0nsg5vmwH1aKrlGImlgZbPwlnPO78at3f?=
 =?us-ascii?Q?zDPG6LINtzDlqXNejjAFJZLjUwNgS1ZrYZ1Z09+9T62IUKmXzneWQfaNoMzm?=
 =?us-ascii?Q?tzXi9BXOfeMfwZqB5YJCKkbzqk+s9oIRTglZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:20.4476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a659a-8726-4ecb-21fe-08dd78611a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
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

Set up TMZ for queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 91d29f482c3ca..b204d0e6e816d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4114,6 +4114,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -4268,6 +4270,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-- 
2.49.0

