Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17966C52CDA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BAF10E853;
	Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUgs3k/s";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BE210E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4iZiaWbbYUVxuRtZ8KJTCVMRwp/WLbces0weUhHQUBBS7zDkN1XiKARP2cL0zUXMZLqOFvS+wDdspm2mqaHmki4Zy7WgEYWl2hH1V4ltEfFd2oP9AILdG6T3HjPo3kp4SUm/YXqhiPK0TG/n8n/5FoSZKVaiuAhjKPf/Rn8z2Xkvp9ByT0vtb+xKOFLLL9THIPwHPDpgJKjFZGTRq4BVKkntpJ6LZfmSgBml+DvdacddjrGwwGtAh9PF8yzNnLUmJM4Fwn5vRF8UjZvfmv7ZvjYCfCu2Tx3xj5kJY8eBo17Ou9dxPhOc+EEJYn+wHGr30MxKsV0vEJhqELJ1V0FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y6/w7bSspfZ+rElKotvIzVqPJK8A1a/8A43dr2pwEw=;
 b=mld3+joqPSKqHvtaqvqiHIBTPpJSK6ROBJXHhLjur5q5fuxx4jWVY2LL/ZnuHISskEMedTJ3hTlWxw/Nv1mscOmMp1B4FfVve6awDfQmkwFjXPAI/DFvzCpE0Z2DPrIHM1KeX1MVf6SLd2Dr3TbMtGiAEXb7bz/tULzULF708HvsJMncNKhJ5u5u7oiJS4zeYqfOWNvyGmMoJwpvcf90fJI/BClzlYo6O3ziTQwBQF1Dz7hRANDg0pAGfemSeUk3pNKM99sH8ZEY9l3OctsNzyn4aJsz9J9Se6r4EtA/HiQBfpNCZ3ikhg00i6f171f1PZCwJiMeepmqjIyTZ7A4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y6/w7bSspfZ+rElKotvIzVqPJK8A1a/8A43dr2pwEw=;
 b=TUgs3k/seiEFnWBQKUX3udrgdLKCE2G7Bl1Q+8WJYLLbnDTm5VcgB58GJx+JXegLE0sYs2J/44V7UZ8e4FKAGLxJLeDzTmVKw4eZGrbSPivsF8TzONQFnbGtpygbINTaSrfyIMRzDHvJENes0t0g2XMBZG9YmAtSzxS+SeB99MI=
Received: from PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::22)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:26 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::2e) by PH7P220CA0044.outlook.office365.com
 (2603:10b6:510:32b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/53] drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for
 reset_hw_queue
Date: Thu, 25 Jul 2024 11:00:30 -0400
Message-ID: <20240725150055.1991893-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 252f68ce-5164-43fa-2505-08dcacbaa80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tZepVrAmjJq25XZdYL36GLPB6bKxoEv+Xo1pPpwlmwZT9ylLpkNSsvZ9G+Pe?=
 =?us-ascii?Q?48gMC9txwlLAa48WjTN50BcCrN8dZtMbuF7mWBZAfgY8STaj6bEh4md1mp8J?=
 =?us-ascii?Q?BXQVFs2K42Reofdrzoa+m9FeXqLv5KnhmUOFHsG+H/r/cEfs+rCtQQkIrHNT?=
 =?us-ascii?Q?HT1nMVqEi8YJ6McTLbn7u5iw2ECS2p5RSlTOSQeiFHeOHSX4n0HL+D/rULEl?=
 =?us-ascii?Q?ZqqY54wn2KC/l/A9F49pP+h3mn/KzUoYLe6lma3X8lahbzE1lcmTRbmXU367?=
 =?us-ascii?Q?N95qg/LGPlpsrB3mQ4ZRXYRubeMOA0gtZ/yMg0+cLdwNALgL5LWX0LOTBC54?=
 =?us-ascii?Q?2GRxVKEeC1ylYv5bpIXWTKTMp4RebHIROrAUa7gATVVH0tcvte8+HjQbvf0l?=
 =?us-ascii?Q?yWPW+3DMF7eo89HQDwZbnyvhTutdlrF21goc57xrtfPOzInZ1EoSpU8PUE0K?=
 =?us-ascii?Q?nQ+CvzDmW+4icSJzTfGQTxGkhmM1AchmQ13pQJQPWbLfxTHRVlkjCVUQBg3W?=
 =?us-ascii?Q?u8+Z90+xo//mYUfmsVmXxtcQ9HjUe5KUqpwk+oZnuZ5wWuJ7iAZ6hga2eNT5?=
 =?us-ascii?Q?FxdQitBD/Lfjr6cOP7uo46HgiwJ7P1kTvXq1TigbeMUvVoQMA7wVE2Y+yfDk?=
 =?us-ascii?Q?erzPXbHhFtmZoH6bWR/y3XBwwaJVUib6XVrFtxU2mtyLTx1QtvH0Q3OQb+90?=
 =?us-ascii?Q?jPxwwZMxH3f0cYrxw1rL5+KxplXgvLhGfJMxI9ODcHwbDC48mOqpTSqMmtQC?=
 =?us-ascii?Q?Yezb036H0LyPBCSO5wKMkRZ64XRIHkczAj+Io6XB7vc8SMaDNNVb48Otjsax?=
 =?us-ascii?Q?lgkB1mR48jtr4vFjYJh3USXR6lYvwQgzLCFmEI6rOQIwlsofzvOPhtUq1Y5y?=
 =?us-ascii?Q?uSyutI3Ty3ZJ8mFK2//elc8za34vZQxkvMsG1w9bR1i82oEzmSxmaLZOw/Ij?=
 =?us-ascii?Q?QYPhBBwz12j9mKqQj9V0VmhastBSWergZJLNMvYTcD9jlueFsaB9hxdaQnuy?=
 =?us-ascii?Q?Nbw4Y2m9eib4pwLnj78XHRxFOu/Ab8fkt04yOyPaiBfvjU2ldGR/4l+5bWoB?=
 =?us-ascii?Q?Y3AvHEE2Kmiq7MWYAzt+O3BukWZqLNzHA+LOGBVgxb2PxZcQUkE9ovIoDR10?=
 =?us-ascii?Q?d+xD/X5mPs4xnUpsdtPnyQYYCy8R1uEV7pIWb3nidSWaL9Z4Pp9K2E3OMVUW?=
 =?us-ascii?Q?0mftsfSELOGPY4dr74d/igYtJe8AGtIaqWXBy+Hanm5p5OUY5p1SzO6mLl03?=
 =?us-ascii?Q?M9gb1+/U2Yvq8ZQVGjQx7+FTljGUwBNGKEXUnLCUZ518wH9SDC8LA+mQuic7?=
 =?us-ascii?Q?MTmppPdgz2aZObqHxUSKhtEWHdP1fLouf8oEiZWAKbTeMuGIhmx2Rsvy+I/2?=
 =?us-ascii?Q?nWsARbgbBb+baOEWrNp0+McNd6ZYLGjkxs0qtW0oKtVYE06OtE28lyiBxBkI?=
 =?us-ascii?Q?IOL7IyEdZh0JCKIKU3gyqPvOqtswZVM1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:26.1820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f68ce-5164-43fa-2505-08dcacbaa80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Add reset_hw_queue in kiq_pm4_funcs callbacks.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 86d3fa7eef90..6fe77e483bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -138,6 +138,10 @@ struct kiq_pm4_funcs {
 	void (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
 				uint16_t pasid, uint32_t flush_type,
 				bool all_hub);
+	void (*kiq_reset_hw_queue)(struct amdgpu_ring *kiq_ring,
+				   uint32_t queue_type, uint32_t me_id,
+				   uint32_t pipe_id, uint32_t queue_id,
+				   uint32_t xcc_id, uint32_t vmid);
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
-- 
2.45.2

