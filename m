Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E80CC28B2F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 01:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8259410E033;
	Mon, 17 Mar 2025 01:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sicl6mfD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8773710E033
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 01:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFmEwrLxlTeu0A+NYD0bMxh9PE+CjmhKPn6FnEpA3e2Y5tOgI+ysiLi/CuR3IsKEfNjdMC/dVbCH6W4LcF383spUf+5HgeTAnEda5bVcYFWnldpdJwAqM2DeQoNyclZfr7ulHiiovK+x5xCLqcQ/VCZ85dEUQo8U+C/H46WCIZZq6ojchmHfWafxZOCzV2FQ7mCJXC75vIkJBYSaqMZHafrSrOlGkx5nzSH2/B3r79eiDC/Gf0IrtFCUAbiynmPFnKfJ2+BnSFhrMg4u+dpkWOWEkpcbYahhvXvhGf4gzr2ayLMGlzgElqRcRRWKIOoymznyY8ya3rEK0NfJ4r8REA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kPxec4eo7Cs423yRWe+4ZpkrzEUcYXoG7kVSakekSs=;
 b=Uoxz2UinxVPoKSH5MipgdQ4glY9aWwV9UpBQ3uJKc1R0NZnX4yafyIHqOO0VoI7p9jFudoat4xSuomap6v9PZ+jmSvo3XSI/MVk7ozo+llWD0oqethV3xDMVqq0ZXcBPF0GMcreoiGpZvSAff9znlQyeNjg2F6gFTF6bdlHp9pNzphSzyAnz+Mm780pcfiGlAL5ipy0DlBXyGG7W7TnCAem+T25buZYAxhewpCVJB7FSuxQjFAVHnMXk2xcEeVvMjahMF9I0IJjdeps2MFs58y1iy0/bTg5eEbNbhNeyznWuCDMl+nw9+GPzoybZspv5ELzkuFdNFoJsnuqQuSLfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kPxec4eo7Cs423yRWe+4ZpkrzEUcYXoG7kVSakekSs=;
 b=sicl6mfDieK4WpQTpO/q2frVonYQC/IbSov1kJv6NziQ84WNwsYnsyWL44axQZBEx4lecgXmDrHJ4yjtVl2A1fDwJKFgjXVgMPoCCxgAlMmC1qRXeidqNHzwO+5s5hahITgA83iqPmgK/tYHSi63GGovHTZzS9xbImQwmhNnsdI=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 01:34:22 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::2c) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 01:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 01:34:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 20:34:20 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 16 Mar 2025 20:34:08 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jiadong@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Jesse .
 Zhang" <Jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix SDMA engine reset logic
Date: Mon, 17 Mar 2025 09:34:07 +0800
Message-ID: <20250317013407.3804268-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: c16678ef-0289-46aa-50d5-08dd64f3d7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zsjZyTTHPILc7UPhPfPIIwmrd48onw+szWG4JkQZ8HWBqTNCs5I8haP75wes?=
 =?us-ascii?Q?U5kiRWbrb0AHJMxV3ddJEr+NbGYNAef5ffgqia/9pxauF/eexIbTMQoSf/2O?=
 =?us-ascii?Q?QfHfYoAAQaX2j3cBwADlbKERe4MXAvl3ck4vUY+P0v7zrDoN7D41WoTr5TWO?=
 =?us-ascii?Q?hGNvls8PuLTYRkh9bPfl6KKN9hgAnp/VCfBWaO1A6BH/7aSRYs44W++22nig?=
 =?us-ascii?Q?FTy/B7JoPvVHRomus/lF9dSf2Luyw086aDfzLylhiFvEks6bXVQm3eoz6WTi?=
 =?us-ascii?Q?Sp9gYg6THAH2D0QHfFSLJ2vsOkcnYTCEXAxx6MLhJHYwVdlvwv9oRymU52aE?=
 =?us-ascii?Q?/SD/E/Zi/7Cf+8IaR9oWTcgFNJg3Ev1233KnhINhA0SA3VWlg74j109h/jYD?=
 =?us-ascii?Q?xW9FhRqxT5hydRyKf4FnDt/cAMMBMtDYNxkH5py77h80exijG31KUvuZVmo/?=
 =?us-ascii?Q?gMQWssAigz9gijBS00I1D2nreKqwYUml0pXTAEdKVxq/atTDwmM2qlDkR1Oo?=
 =?us-ascii?Q?fbthQvUjIRb+Ngv70MosoG3Zyonsnt9bYLndZ685wEfgCyM2gDsayNhfe7zw?=
 =?us-ascii?Q?XsT007iV1dsGIlADagXRqh3shUzBN6aMf8KxHZRxEc6+1CqwIUC04b9cqOCj?=
 =?us-ascii?Q?GdGXivcj9kzw/9cMN6U1kJPrl8l0OpiAXFa3COEEyEGb+Bd1+8L+atNCsgZo?=
 =?us-ascii?Q?5+9+Tc9JNpr1mSAqkqHRcu4BfNyR377Qo2p7U0Nc4CBnw1T/6q8xA4l5E2XF?=
 =?us-ascii?Q?ueRNxktFVmvRDAIx5SsDe+LP6tAtxWWYBtLYbnzM5+7gOpd8kaJa42M+vAl2?=
 =?us-ascii?Q?nfVYJHfx6hYvb0O2iqqCqZtIqH9MPzFqm/1BeHqfAbdqER5iHKmPoIJfrxh8?=
 =?us-ascii?Q?gsGeB4qUx0yQE98RZQ95YlaGVcm60ujFmWu/w+YEDEZgryyuQnuAvRVNPJQd?=
 =?us-ascii?Q?DbHaOviJPTuVjQc0g0Y44XexV6OT8ux7EUzQQ5fxALVB4IKUpRga4VWYqS06?=
 =?us-ascii?Q?RG5OylSO0ieRNXiNAawkTPY+E2ji/vNdBM1+MnNujcWRGd8/eaF7SU3gBuYd?=
 =?us-ascii?Q?05+bmHD6Mb12uLONM1+tHY7iLC4I8Fy1T08upQViVa+861bRtxMTgWZ3y25n?=
 =?us-ascii?Q?k7N4PYaHvNHT3KQQDLkJA3VakVyJMdZyGrZm2knwMIUOX78S0cy/P28pe7px?=
 =?us-ascii?Q?IVFWITM2nuJtg1cff6jrTGD+Yk32LhPeqjNIlDua8lsgYMAB+TqDCKYtGsxf?=
 =?us-ascii?Q?LT2FkxTRm7P/QbNsMynBQ4xkd2a9VSC0hCvem7J2XTlXDj7cE2DNoR2ICHvD?=
 =?us-ascii?Q?v7lhz8bVCxwyPybzBMYbk9QsXfID8/nvxHgQRl/c9K82pbItg68zDotmaNhO?=
 =?us-ascii?Q?5kYlnD1TGTbR0O4eR+ZBnifyMBCURzSH5hLLvNCRWYciie0QltAIFhhRlI/j?=
 =?us-ascii?Q?BlxvrsRHgE5mDCxhwbkr4XTGZRFGAyd6qg25uIOMrArMDz5vk7zQnXaRjmLi?=
 =?us-ascii?Q?Drcxh36HpJu5Gkc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 01:34:21.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16678ef-0289-46aa-50d5-08dd64f3d7d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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

The scheduler should restart only if the reset operation
succeeds  This ensures that new tasks are only submitted
to the queues after a successful reset.

Fixes: 9b5d66721b66308a5 ("drm/amdgpu: Introduce conditional user queue suspension for SDMA resets")

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 3a4cef896018..1334c209201f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -609,7 +609,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	 * if they were stopped by this function. This allows new tasks
 	 * to be submitted to the queues after the reset is complete.
 	 */
-	if (ret) {
+	if (!ret) {
 		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
 			drm_sched_wqueue_start(&gfx_ring->sched);
 		}
-- 
2.25.1

