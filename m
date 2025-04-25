Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36A4C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C2D10E993;
	Fri, 25 Apr 2025 18:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jttU/A4A";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616C010E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoOChPJpG+TJHd+UYbprue4o9kGsdScv9hk3qY/FPiQz/moLbGP1yAEDyYjLjW1rJ5EEGg708In5t5Ea8+jUBxalG5HRrHWaM91bWuM/RV00JmTghUF7RmO8dMD/SnyZKdnVxnsgc2Ujv5r0G7Ps048K2Ak1VoB5P3K+HzFwMxUnIGEyFX8ieMKwtqLaqG0J3VREDvA4+8ZzWizyl/Kfk9jys04m2gWFMmZO5qVMmnco8jwzY0ur26hrUdY9PuxcK9Y2NV+MHyyHBvzIS3gbIjtEWXAErFq+SFj4/O8ExGSXTq8nUFWZK8SsZFOi1tgVbiokAh6wV6JuW7Uskud+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFSiGj5w0QZFzBH8rLGhflxqjveAgn6cy0xsFmwV0JI=;
 b=wPPE9fE0GxThdMzFAUlpgkH4tESrjL4hdMIWF7c40JUwebkBlUcHfMTuKa8sr+Ods8VSH1ePV7j4mjI389SiZ0Y3zRlqce0ltAhOBoU+0FHSHMlKwrMf3tpzvwn+dUIwXtKkIPFoAT38pVVbMmnDiYXjSomxoGycCskeKIL+iA3LDET1y7+BF2sTjn5f1K3jbYw7wu5idHed9GjW30gccuG9BzSckdKMzq/MsYBCzS+cuj1k9Zg1c+U3gBXzP+kBqCcNHjg6BaWehwKBV2CPPaZ5owE2MmRVJmiq0gdW2cHrM1S4OvgNA0lbFnEecnqfB5Xak1iY92AwlBycbndO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFSiGj5w0QZFzBH8rLGhflxqjveAgn6cy0xsFmwV0JI=;
 b=jttU/A4ApxE/PdkM0EO2UgmEtaFpcwnPmjqz7eVYlSxZmsbD/EpspxsH2WigbGaA26YpOfyCBpEcayBYivBAPqaMxDZ2NLxKUPf63W68WXnB/bSgqdrleYiBdyAAlOo5hMEz9shh1UGMuTdK7aYqgX1UT0yNXx+LZBMoYNGT59E=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 18:41:44 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::4f) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/userq: add callback for gang setup
Date: Fri, 25 Apr 2025 14:41:23 -0400
Message-ID: <20250425184125.166270-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e97653-9d24-485c-e29e-08dd8428d3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XTUTohKTts87lA5EpiVc5k+VL6imS89drN4W5UTOQt2KYJTxq6pfkcDxe3Gs?=
 =?us-ascii?Q?1kjU3HQ/uLgRIvFAL9x99qN71fuzxndoEh4WkAht+LyLeVLDfFIRNHykISt7?=
 =?us-ascii?Q?V2XTo7HxTPrqTruqWjWAnV7NXjhTLTUpNNvMaunA8uITu22gX1mGx37sLq3S?=
 =?us-ascii?Q?e3f7dAzjK2ngS5ftd2BxsgPjC1RyvBm6FZuAHLERga/spN6q0A2q6kbvfjTG?=
 =?us-ascii?Q?1MCLl7E8gwY0wsx1bTshz0hbtv1AIqmbvElwAE0YGU3YhDys1T8VxN2Q3fSp?=
 =?us-ascii?Q?dpkpv0Q5B5Rr9b8Zb1/c3Iu2Uxh0FyxAOtT+PYIRge4BmOAv8kPayRBKdT1q?=
 =?us-ascii?Q?+tmiRQIKOdUIgnqQ1rPKRRm3xSivJbGycPaJaqfGlanADA0H1oPgyYh8rEyo?=
 =?us-ascii?Q?Uw64EV2btCPdrhDPRMoiX7P6NG7Mqj7+8ORLUEaKOYIR3JqSxRgsDF/RTvLI?=
 =?us-ascii?Q?CD4u8wlC/9wT7UR7CktP2F2pTePzBgVjt7xfW8HkHxZ1k3K3ShlYl5sjblRZ?=
 =?us-ascii?Q?Az22ATS3iBM3QOChXgEozuWVxIWFOs/zMBxLYmdgLi7s0/ZBJ3nkMQRmBG1f?=
 =?us-ascii?Q?2B2DEe/8g4W7wQyQ4Fn40gl0H4nrJtxIMK07D5/7hPgOK6EwWcVWpGZgx0DK?=
 =?us-ascii?Q?07+4a8WP1srfky9I+qeoC0ZM15FPQJRkv8NoYaBQFdUvWXDutRP5xrvtNrpP?=
 =?us-ascii?Q?wH1XnPl1K+a+2hSOVG6g1VHYwgZb383DaTI7TVXcapw4VmX9E5MK6KiVPZXT?=
 =?us-ascii?Q?1fOop3La307+kCBaxaFQq1GhbmIejwgubUFGd4y/DR10RYBR9RSYTIO2vUa1?=
 =?us-ascii?Q?LPfkxpvljwLVL7FT5v4Z3ZtTdhkukLwVCnNbWrux5rbeEtOLvQ3Jk10I5hGf?=
 =?us-ascii?Q?LfqcV9oIvfkeF56QkVzcEIR9+2Ll4N8xVzYvmKLEa7fPi2sOpNdeYWK3pcF0?=
 =?us-ascii?Q?CDy3HvunfZIzabqRkYDJW3MInyNAxX4XQ45Gx0uy15uP8ywFNTwwH2nIZ/iK?=
 =?us-ascii?Q?tlj1E4pxmAKzyoih9tCeDlVsUWKcw9NA175SwVw9IvRQxbEJOrhKKCiKpwg5?=
 =?us-ascii?Q?prg5klL+v1tVvz9kMbXjm8IucmSA7DIOkINOz2DVrt8ChBbggdSzwU8umCel?=
 =?us-ascii?Q?vZlmrLGdDHr9ReraqDANTxrYARspuaug4FC4rKfBuaSrHJUYegX3ij9oFRun?=
 =?us-ascii?Q?1H7RQYzwA8YXILWG6sckzilg6dGQ0VciPDiRPx7utG0tGXhVMBfrGDk7JmfV?=
 =?us-ascii?Q?FIyesgRrEpJ2urAOI2epvYQHAjgaimT2ERWkPEPbBzgF4CFt1XOPnSzY4X8o?=
 =?us-ascii?Q?zR1c/lvv0RdrXKn8Qz37hGcO1r2Bnk72G8XsB9U4m44ecAJ7bDkiFArL71Rp?=
 =?us-ascii?Q?doRmB6Ux27NieSuDp7YhcK9hgFCcajI4/2lA431vfa+r7mnGxUbkmx14XwQ6?=
 =?us-ascii?Q?tHuKekVnSjCqpH+Mz78q0SySwU9wcYbo+5LvEXlA2ITFq+liCM/43jBnnWjO?=
 =?us-ascii?Q?tuZN523GLRf5ouMlE0ON/GgOGWrwuMcfOAye?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:44.3855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e97653-9d24-485c-e29e-08dd8428d3de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

Two queues can be ganged and will schedule together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 35a08ee59d893..ca11f7748d031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -80,6 +80,9 @@ struct amdgpu_userq_funcs {
 		   struct amdgpu_usermode_queue *queue);
 	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
 		     struct amdgpu_usermode_queue *queue);
+	int (*set_gang)(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

