Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFA3C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3885710E325;
	Mon,  3 Jun 2024 08:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/x+tFqa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F182510E325
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqAUDv2zeq1p7Mg+cIiTJZA5o0Ok9gNhO04RELTXkkZn+PmpQRvbEHkPLoWmOhUpBCZY+HU3u+CGvoCyR8WhJItxenSNib1wHV+V9NrNhCrbEfJLG+RDR2McNHi/KU3eH8aaXVmvRPbMmqIFZR2N+wt9M520qGf2NX9dqrrO5EDZwQt8M6ufs93sRFocEhScggSyqNUqs79rHyuCE18BhSUMYlsuJSrVUN1Bzf5+9DZLUt6qbI/yVcavGOVPV8Fw/+GSo1eyw8an61wn9ynHcnG8dsediXIF8gYk1iUkHimkGYVFbOo2K2h/VR+13FNz4fbQ3fXg6NZt4Z1TpVZ3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdJ2r91FLNxPz7ncBj0BRONQ6PYqP1fQDxyr4/noUN0=;
 b=AfrLNZ9L2Jk718KU9BZi+MBX3B7k9FcerX4296RPfdUZLQmoKt0LwSkvvVVoIloWC65hDhxSmEaTjiYihNZsR8QwgLPu/G+9p988IW6MoWdtEHDAa86+0kfRFRZI1fFhwVE9n8XYYz3EuXEpA3+VgnMNo6FW0167ePAG/wMDcAS0BX0RcBl8IIRkq6kmgps/eMfnSTLzlG65m9b4Lig4oKDt1J9b+AfcbG4sCpO/ZrE7aSiYAUqGO8eJZEohswLTaCTOHO0UifaJL992n0D/3iQNRuSJ5tC5zbcmDgc26hf1Rtbi8+pKscGZqV/tTyLFwGBAG+2+fJFeodfM3imqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdJ2r91FLNxPz7ncBj0BRONQ6PYqP1fQDxyr4/noUN0=;
 b=3/x+tFqatV/HeDr+BAtBCmJtBtDR3CdqScQR+Yw5I5vp1B7QC22JkW/aDyv4lliu94w0/8NaORHzt7trOqbCz1QWrU44qBu2owoVdCAoGLCxS50xCXf6AoY0U+MTNYHUEYnKj2Cy43YpO58K0IspHpLlKUukjG+hdZBvPeZBCqw=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 08:48:50 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::b4) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 08:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:48:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:48:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:48:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:48:42 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 08/12] drm/amdgpu/pm: remove dead code in
 aldebaran_emit_clk_levels and arcturus_emit_clk_levels
Date: Mon, 3 Jun 2024 16:48:41 +0800
Message-ID: <20240603084841.2570129-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 1415843a-2e0b-4f5e-6738-08dc83a9fd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rWx/BJJMLwVh8jtVWCb502YWdvX2Zp1oE0IuprhxVtS5HJqAnPuMa4rU9tcV?=
 =?us-ascii?Q?2zvZt+5mtNJ2kAVaBbIB3TP+oWJROrqOim2uL2txAOEpi4SPXqB0gSLqyzfK?=
 =?us-ascii?Q?LqfAmiH+u7onSyuWpP7fmGx11Uqbn0B3mFosBUziW+p7aK00LLbd4yb9b7L/?=
 =?us-ascii?Q?BdlXBC0HXmTEkpyWcrM25SXJZzk8Vgp0uMSdnKeJIwmeXCH5umIQ8cE/FWXS?=
 =?us-ascii?Q?KsX22+VN9L55eO/aOCRXbBkMQLYVBILzgopi1ZCduEa4Hel4T4BWHoRdR5I8?=
 =?us-ascii?Q?8+JsR2tYn3CFEFsqTAlhek6s5YPvhN9WbC+oV3oXdetVwjxznFvxVRD2OqgD?=
 =?us-ascii?Q?xMCsKtMsdxi2yrXFAKl+fsyT/ZDTJZ33X32flUvjKSN7hBNYuwpPIw+I4LD4?=
 =?us-ascii?Q?tnQ0A/czU7tigJ0Fgjf4+dyvlzevaDU4gFQxP4nEi8YPMHJ+SZnl3nwKFCWd?=
 =?us-ascii?Q?V5X0Hv2VfyBenCAmVJn/nYE1nxBlVFnbmblOwkohNK1MEFg/qWdKkOROXCSR?=
 =?us-ascii?Q?ZL5MmbKFEJk8A0Hpyd37OShlO/a73zsyO/8J2Zm2PEe47YNsTWmSOLevNwwE?=
 =?us-ascii?Q?jm5A2Ol9LcoIb51sZbykyqTx0f8nE1pzQisHJWuJ/ITg/6RZPqjO5J5p+EiA?=
 =?us-ascii?Q?cLvY0airtkaryGb3KEAot7SECoF+UHfTd18+fAqGRgpdXUIyMm39z1SiVuAE?=
 =?us-ascii?Q?TKRH+5a6se6IvdhxwICrwGMgl1XhWgBTlEFutH10o7CWPDa9eeQQPcZY1U4d?=
 =?us-ascii?Q?IfJ4F+upkjaTwLUw3zVMygq9c8NoREiNfnAxuULd3w1dACkEe2SYEnJEcftP?=
 =?us-ascii?Q?wN+N7YUzAu+9IUxzi+vJHvW+/5Zc99CnL7qmxaVN36YnDmYJlCSLo3XpvhOj?=
 =?us-ascii?Q?GpqgV2sASvP5k4LybymOudgwtYqjSRNnfyWWxDlhBlmsaZXGgxcmRczX+vPC?=
 =?us-ascii?Q?u0IgDjmTqr71EC5LSp4TpJzcfKg8RNgVn0iRoqu0U5tXzlEQXj7cvGWs1yBB?=
 =?us-ascii?Q?tjNFPo0B0pzKaNNKGDaivY53Z8OEm1BCXOqa7BYO55YoWPfLNDrBwUiUOtKB?=
 =?us-ascii?Q?O0v3FcqdVoSimICMo2ankiryyhiNff+hEeFr4HkztrbCeSOINWXiVP09QcA8?=
 =?us-ascii?Q?4rGxaNL/oruOFPFEHLEDskrLd6/iaIRlDn2vB1yRujwDHP7Wsute1l0zHx3+?=
 =?us-ascii?Q?UdYn65iuBpti5DRZ+W+08762UbggjZxu5elL/5WHFktZlHLzAgho7wI+l9at?=
 =?us-ascii?Q?OHRUfZVTAV13xdLg5ZrikTJuLDRV6r1SV9wGd5IfutUV0+jJkSpCDGVEnyd+?=
 =?us-ascii?Q?0SI82EmSad/E7tqwqu6HEJrkNs0rKINEgLJloH6J2DOVHWCFJlE4MdPukUPy?=
 =?us-ascii?Q?XgsDJEbcJbKVXZZ+xN3WE1vcI4HM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:48:50.0383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1415843a-2e0b-4f5e-6738-08dc83a9fd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

The value of type check at the start.
The switch governing value type cannot reach the default case.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c0f6b59369b7..f31cf8ad025f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -937,8 +937,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 				smu->smu_table.boot_values.lclk / 100);
 		break;
 
-	default:
-		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 825786fc849e..35eadd7906ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -919,8 +919,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 				(freq_match) ? "*" : "");
 		}
 		break;
-	default:
-		return -EINVAL;
 	}
 
 	return 0;
-- 
2.25.1

