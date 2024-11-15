Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0CBD6DDD5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAA910E38E;
	Fri, 15 Nov 2024 06:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDq8CmMz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A67010E38E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usl9nQu+HBQQAC7ofklwHbDqdVYMRtHf1iIQFzqoDROhovSogdDsYdawlaHdnJES7dPJSVhIf2eNAapdf/xpBEFaJIca8db6ABu4eANK7WNfmu/q3c4QMs2n9wbFIxPCULbucwt9YpqjDxLZyzz4Hb2NqZ9v2t3cthxm3BH6sR6BS9HVG3PUWUG1R6jLngfOx6l/gUTOEIaSnD3WJdBQR9r9AWP5kZKg6Rk1JAdzv9OsbNpI+K+G37Vp6fWLYsrOAKIsJRmwaZ+9PeXjnnD6xOo3YW5CmggH9Gr1WrIGQn3Pug2xl4ay7rnf2JqyG0wCRUSInr6TNgMoFa3/7hJ5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDXyB/pG8HcWteacqaN++8dE0wMWdNcqeo7DBwZj/Jk=;
 b=bnr5B/TJHSgWUQWdguaThBlVOgSsMcvgezm86liyJUe5lioZby0EVdkOAn8rs/uhGVRcG+qBznQEiqVnBb8DV3E1Gsct1GjLOAIha9+VKU691OR8/v0/tGavFGKoSshuljmF7qznoBY7w2eSDwVM8E1OPUzQqM8vy0YBWMb/cCuXnl9SbaxecAyUQOYLhA3CsiuknozcNp3miUxvXjE8M0kVnFK62qTT+1Rm8QYHvBI7k2FfiupGWLOOhJWxM52IQeLgm2DW9gbvnBhkZAINSfFnVxRl7Axizu/0udIY1nGTtAj4FojkjnZjgSgFNaogN0Fkq0HVJ58VJ0vS1RBYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDXyB/pG8HcWteacqaN++8dE0wMWdNcqeo7DBwZj/Jk=;
 b=SDq8CmMzHsx4gSNiafaQTPpg9KWVDV65SGe1//awcfjdMym5d4i9gZ37zisH5bVC70IYy9sdruaBTFG1Kd4JXFugb7JNfLZqxDWgi/XZj6ED5raazz/GCEP8VoTpNUTwHkO1ONZ6inNHgZQDUVnnCAuHPtgW5Unq/9/qfNr3VLc=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:09:40 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::61) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/5] drm/amd: Disable interrupts after
 amdgpu_fence_driver_hw_fini()
Date: Fri, 15 Nov 2024 00:09:20 -0600
Message-ID: <20241115060924.1805-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b1e24d-4796-4ad8-867e-08dd053c1771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BvmmymPTuacYvPcN0Xtv7ttDC+WkGblVAZWAlaEFNoLhma6MDQiS4Vgo5pLt?=
 =?us-ascii?Q?Hbq9N6Imomt5eoVzjaT6t40AD1eGXxsUsS2zRyOXdXb2lGwJS6J89NN65qpw?=
 =?us-ascii?Q?FnkQlK0tGcWbkK+pWxgD+jUW6tZ7/rW3Y4N3x+ZqxFsreGjHj4A8osG0vZKz?=
 =?us-ascii?Q?nvPC+4NfikkKtMxyK3rONm2DW2leLImjDh73N3zMopo8DBaMTJOeO4fmMmdS?=
 =?us-ascii?Q?ka/6rREgTYEhQoJGLMAHmEXp9SPJBPxx75aKe+rLOMrD80AeSYY5SGrOE/t1?=
 =?us-ascii?Q?yQO4KQjB6SygfetqTWDKHGq1chQ7U5Ydemo8ClyohIXVTNYBUoVVAOTM4k58?=
 =?us-ascii?Q?+MXAkePjM3VRRTNNHNvUUoUog1Y/w3ZIkeDhVwU9jP4+UQDWm9I4O3pYJw+F?=
 =?us-ascii?Q?o3mOYYmX3i0h4SexPvFuozXRLF74epWjNNiCM+lQUDdzI3X/ut2oB1GqfcfN?=
 =?us-ascii?Q?j7POiD3MpfIULBBRnqyPw0nYIvHKdg5bBYa5kMkhSDUTm0IkBpaszmi6x9GX?=
 =?us-ascii?Q?rTkl6kwyioFI9yegPkzsY5EJSRCKUiWOqKqB4qtGnMKjly1arvB19zo0SlJn?=
 =?us-ascii?Q?CagsSn8pd1HtEi5I8cicHGzIDB2hN1l4ai/FDYgRGuSyxe5i3uYqhOuOy2Xf?=
 =?us-ascii?Q?DKgNR4PYyWDcV6CAMJrL5DvzPMFs0VoAGLir8rz66CWCQUCthvmr9psS+EAl?=
 =?us-ascii?Q?0SdzmVGj6Loez5Y7FTrq/lJTMP+ZLD3Yv6p698sA7m2fNBiP61WT4D+18ZEv?=
 =?us-ascii?Q?ndgTxJ0znhEoABgaAK+f9sT4d+2+lbfMItZDay++gMmXE2M/qgqn85K5kvcs?=
 =?us-ascii?Q?rW5yVBuHTEWATBb+WXHf32pD4/zKt/80eiyXFSfvynDx/aDaoD2xorrTIeck?=
 =?us-ascii?Q?ym4C0hxt5cFeMOhVqBA1TsqUle1V7PdGQiXlZt6/joTW1EanQGK/FIXSlYz9?=
 =?us-ascii?Q?pUoNHWyLqZb+uHOQjN5KcQKTTz7oNW4KxmaUwe/WVZk4nGe8K4r0Bldg+pZ/?=
 =?us-ascii?Q?LjDZfhmRZaizY7pX6OQofrpUTBlEr7iEyI6Mxzl9MAKb52SthYZ4Qtgr76A7?=
 =?us-ascii?Q?alPTWOaTAm2MWmQk+kCgwTeduJquLTRNFQ3ch1d15D2zo432zcirLAbaVzQc?=
 =?us-ascii?Q?bkdVsN68Wfjj0f4B638BjUStG/yWpKR+UjXroCVn2UROSD8nZy5kDYQ9s/c5?=
 =?us-ascii?Q?V6fy/sh2fkT/5boBVCxE7qR2ESN37PErPKxRvrpjmKD4wfP/1rwEMyqrCJiF?=
 =?us-ascii?Q?LqcjAkj1pUyHxU3AwFatHT5FqNzAsyI4zjIRlZX0bzTSxWcMN9ZoqUAT1Ktg?=
 =?us-ascii?Q?27e1UfPsnxAq744L8PxQsFXY5Zc+5wziHTm3+nvRU974eBSJvBuNEnYLSgF0?=
 =?us-ascii?Q?iKyvpvhXLNj/RnKR1Hww38FExIhZQbVnThsFjlOcqU9bvM2uKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:40.3002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b1e24d-4796-4ad8-867e-08dd053c1771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

amdgpu_fence_driver_hw_fini() internally attempts to disable
a few interrupts but this can fail if amdgpu_irq_disable_all() was
called first.

Push the call to amdgpu_irq_disable_all() later.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d61..71b783b4abf39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4655,7 +4655,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 
 	/* disable all interrupts */
-	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized) {
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
 			drm_helper_force_disable_all(adev_to_drm(adev));
@@ -4663,6 +4662,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 			drm_atomic_helper_shutdown(adev_to_drm(adev));
 	}
 	amdgpu_fence_driver_hw_fini(adev);
+	amdgpu_irq_disable_all(adev);
 
 	if (adev->pm.sysfs_initialized)
 		amdgpu_pm_sysfs_fini(adev);
-- 
2.43.0

