Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F9FE9413E
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 09:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAE189A5E;
	Tue, 30 Dec 2025 09:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htkKbp6y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C6E10E892
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 09:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/j3qlTsO01tx3rKbtWuVfPztfyqueHZ9K0jsKL3eWrYE7RlOW92pedZK02UE7UJcfPvMAN4EXGxe5QCnexu04Ob34nq2h4EVhdFOgdATj64QjdBGRM/UJb4tU5ysRC05ZKgz0FKcU/osDo6v1hF0nesgPMEt69/rvKd2H5GPdjC4ZgUQ4t4ARqQ2OdtoCCm0OPBCc+QzoYu2mVcBMevtbGG2TeBeIe7C7Nc8ng+s/lfl9uTrY0rr7dt0XKKtoHQvcENVfgPTIQ9y3XE7Z/rHwyL0BVfXKOndj4AOdowNdQHKuVrnJBoDPLjYHvG5cUiVSbPfYf1kOY5NGOvaQTC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QkK3VhhA8JSWt99K7OQ8htQ/Y709TYe1LW+P+naSp8=;
 b=irEaR88x0rNVXb0V0wVYXftr8GSfmY5OpYAVZjjNHfQgaTChR3usNipw4fKT3wsSHz5ET+BmZrZVcRG70xjNrpqciazhfR9E8ydb6KHu6X+Zdn3jDJMvERr63/T5/9abGLbIDTQnVvYssIjkBAUelC8IOfzhEuHcYmgp7MgLpnTIydGeSuo5vUYlaL31jqaM2Ur+p4Gn/JDZPlEbOHBkdq8/yKZYZfc/OntO7rYdpJerLM8eiHAvpOrtK+zrRbSOSRf/Jpfj0DKP538hGNYLCgIrl/kV0VHZociLiRW//ANNXi4WWaInyEvl6aDOkv4Gx1iiQiokCrnJwfcjmDPFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QkK3VhhA8JSWt99K7OQ8htQ/Y709TYe1LW+P+naSp8=;
 b=htkKbp6ydso+xI5W3z/HDVRDoxNdHwmWpl8IfiSfphI9NrHgfZGMcke7Jsa0IPcrr2dLDct8s719DFT4N6WPyIuk8PA/CdVx6TOxGSWox5ooyNjywvyn/MVc3/+QSgXTfokHCH4x150FC1iCFbLTSQ3aeO2GE/vydLsO0FCOIXU=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:51:49 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::a1) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 09:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 09:51:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Dec
 2025 03:51:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Dec
 2025 01:51:48 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 30 Dec 2025 03:51:42 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v2 3/3] drm/amd/amdgpu: Schedule user queue reset on GPU privilege
 fault for gfx12
Date: Tue, 30 Dec 2025 17:50:42 +0800
Message-ID: <20251230095122.3587835-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251230095122.3587835-1-Jesse.Zhang@amd.com>
References: <20251230095122.3587835-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9c489a-2209-42e1-34cd-08de47890d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtxQO0xpS5alnv+PelyY6l7zrnGIQIZKw7pxZ8N6dHvSVnnTvqHmSW6pbsrT?=
 =?us-ascii?Q?b+8JCw8n3BXV8ynwJJZjwc8EtNVVDK/Mj0RkAosfGrdIZbRMlGOpJxMq/NLA?=
 =?us-ascii?Q?kZ8A/FCP+pLGjyHRJ9x/uj4SxS8DKWoE0arlNt+9Swn3FfJ00RiNjrKwUzDn?=
 =?us-ascii?Q?OGHosWIv4csb4cH98t0BZMchjs1Em3jnSjshORl0Xz1ziDpVfTNXijB0IjU2?=
 =?us-ascii?Q?NNstzZn7coBUGZuZlEBbOMr9WhYZZs+Zx8D7HiivCue5po5Ki9Pu1jGnGL3D?=
 =?us-ascii?Q?YseHWLNXd0PQCWZv1AJ+K2UhpzTj/w3cEQJjejUqAjnrGESD3LELCV401U77?=
 =?us-ascii?Q?l6p7hU9BdNG7OotNCA2kWHR7lEmgw6JohT58XA1LUlcVBJmJ6aXjY7krFDDS?=
 =?us-ascii?Q?17qHlp6lrJXZHhvQzF274zPaAg/PZ0jnxcdn75oHhiAYJUa2liGkntzxY9Lh?=
 =?us-ascii?Q?LUV1u81fdOaRN1vkhIq/QWclBU6EJQMk4otqD17zdQcYZ3RDREPEXIDJ5EFv?=
 =?us-ascii?Q?1V5kVKkBn/a+3TL+M1gZvxqHscQ5kZbxY0s0nQSHJMQNMHd7wDTFDUdcZ7qm?=
 =?us-ascii?Q?sQqlamIqT8zeORxNDLzJKzmt92t/tzR9ItdJ7FsPr7XzEd9zmzmejei75/b7?=
 =?us-ascii?Q?aQsscuvAcTHoekWf05oA4Aoxa2KpUeib44nGqWxM6ytCWz7DP/M0RQZtNPUa?=
 =?us-ascii?Q?Fy8d7ow9+RmP5Lv40WO2krO+/oRNyBbVQyhYYonoi8W8smobSVexLvnVDiPE?=
 =?us-ascii?Q?27pBsFQAkBRRDnFNkL8x/J9NyexqK9prz877mwGSGoJQcMLHcXj/XAUeXITA?=
 =?us-ascii?Q?9kUNkuo7418fPyUE2yES6CzbBPOem5GXag0tmcOzu2iC2+4C72Al9n+z2ioo?=
 =?us-ascii?Q?q5gX2NksYfGjV7CtjC+bPPlfCf0RhSoWiqkvbaBAFiaxCDxzjeqlHOBPTPbU?=
 =?us-ascii?Q?2AdNgwKnj8fund/vuZ8YT//eH8BjmSSIKZ231AyCwATm7+M0PzLp4ssFNTBg?=
 =?us-ascii?Q?t8Vol1d5T6ef1S/cixcSrJtMcCnE3io40gbDqWGoOBvsEpE83BzUlzEz6Taw?=
 =?us-ascii?Q?6m4sxkkaFArmNoW2qaVfLT0+Xn9eS9YwZowrWiZgGflxGmTRcHXie10+xPz4?=
 =?us-ascii?Q?Svcf4SJjLvKI12X5s819ulJbEATzG5dH4A1urVo6+NRJhnb33rNk0+BMKI1E?=
 =?us-ascii?Q?aar+5x/w1Om2O/17YHRDJFrXANCaLQDY95V09Yh7khQmCR+F5gZpN7Rr99km?=
 =?us-ascii?Q?jOMOyT75Z7hPnW+DabBsLDMj86UjFBuq+ldXlUwNU5+qtC2H0eyZZUbMOFXD?=
 =?us-ascii?Q?XAAXHAvEolZDv6O/cTRXBHxHccuxtickrCsz4TrlJRmqWohlXj9UcYZIFEK4?=
 =?us-ascii?Q?fr/J0UjY2GZ/QBFad0gU6ioztKU9Pzn2v/XiBWrcp+Zes4iVIzuxDHxPoEu9?=
 =?us-ascii?Q?7yxDMJZu9LyA0YgU8hWMi8hhyRkNAFuL9LYyEOQX4mox0PTEYiixorreZFsz?=
 =?us-ascii?Q?SK9BJr/L5FhfPtoAd8D/MLRqyuhDiV48pngpW7iV+L2UGdXVjNrsK3Kutvvy?=
 =?us-ascii?Q?qoQxd4zeV6uwHwXFqZg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 09:51:49.2770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9c489a-2209-42e1-34cd-08de47890d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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

When a privilege fault occurs in a user queue context, the GPU may be left in an hang state.
To handle this gracefully and recover the GPU, schedule a user queue reset via amdgpu_reset_domain_schedule.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..4162d30947ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include "mes_v12_0.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_reset.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -5030,6 +5031,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			BUG();
 			break;
 		}
+	} else  {
+		/*TODO: schedule a user queue reset work */
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+						&adev->userq_reset_work);
 	}
 }
 
-- 
2.49.0

