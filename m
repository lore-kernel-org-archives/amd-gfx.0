Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E7C282DE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D5710EBD5;
	Fri,  7 Mar 2025 15:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+ociojt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3961310EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDJVtiHf+WT8jA1qD2YmX0KPq9kZkqMUCVs9jD/kipMpwiF6WBgJNrTsfBBl9YtGHHuHelS85pwl0J3xfUkExAFB0LuM9V5mfBbRfOefQYGrrsuiODr7mZJloAuQ05EBk268sYxORQvCFHb2ZxL8Y0RjeUDDchzHVCWjOCUC1C0+f7NXjCmjts/CiB3pe2+2C3mScxFNPmmQYd/FMCS5DJndAYzlXLoV/Ee/LGnsVwAZaSwOOaiScuOEReDMDiRe9tTxVW53rqhKU0LxIMJt+KdgI6EX2yOBqSkuhdrEN63RJs21LIDti9YXh1u20ni/bWfnLxtKVIHnQ8ZTk1brqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vADAkEkdsVJ95Ns/ZPgLXgiXMHlWeJng7nZvuCryYGQ=;
 b=AQhcaD/5TJEyS7bEM2fuDsRF6OuPfl/xnfYKKJKNlCeAmW6rH7letRGyM7qgXFc4TKK1SAM/bBtslope7mGAyb2iBeEBCTE0HJs/Z40gWqxlPpTLP0I7g17qZzKwP2pPWEdnuVdE3VVTHSGdTffIk2oiHN4kFPBO5NbKMvT1m1LNJiwUhX2dFEiBMNJzN/v2qogpU+eWx14zg3PDrLn9fUxDQALXcJ8Nqd+3a8cK/uEFwo9AW7BUZsbYqhiKBD9wi2F7czRxnicDAUfDeFSxdyohpVmvr/icPwSN814HQ18o+QVdL3Cisyfzp4+exmRBasMgLl1lVePcNqiirVoQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vADAkEkdsVJ95Ns/ZPgLXgiXMHlWeJng7nZvuCryYGQ=;
 b=s+ociojtL/OQyIZ7pup9070SiQa+1XM2JOgO+SLcLKSiYwGuX/Ha/iLUwTjPaSo4b4UzTfkEBjBMsyOAyuniUUvR78zz5jtTPzFo+ssLjofMMj92nxNmy1VyOKWMniw+d/KtlpDkNayO8FcJ04Cf/seDOZJhyMYrOh8JWgJTlBw=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:16:22 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::7d) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is set
Date: Fri, 7 Mar 2025 10:15:59 -0500
Message-ID: <20250307151605.946109-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f2bc3b-a280-4546-05eb-08dd5d8b0532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?er9Ko4QaOOgtDW9X+IWyh/LpSuKfJYK4wqYwqT/1Z26YcfK9jZ1pAvU+yZpw?=
 =?us-ascii?Q?uRei2WAOimAEPTD82zM5F05Kd2gy2jWM70lWjQnaGMGrLCwDW6gXSYRcK6fy?=
 =?us-ascii?Q?6cEtZpwh+Q3NI92zN9SKd3FiQ/mlHe0X5LUzCXrYdvzSvCxHXabDHQOZke/O?=
 =?us-ascii?Q?Ww7+FeC9IW3Njnm5uImxWQIZ+P1ppf4u3QyIJgcon+pDi92OQj9dbQcSVrCf?=
 =?us-ascii?Q?y33gZ5dINC4qTnL8TPgFilNjIdERQ5VcUpt4ol6rYg1D0Dt5hqruLunLVhI2?=
 =?us-ascii?Q?Y8DLJiTCPg29B9ZBzhxna7f/gVo+WwF+VWkkZfT9q1DVWZw1zJdzaDIrgw4O?=
 =?us-ascii?Q?NWfu9FMNJK/LHFysN6P4c4f4sxWPulM7fOxB3bmy6kRlTOxDPGQY9MKwkBa2?=
 =?us-ascii?Q?6qZXFaZecawL0RfNZJuZ7fczQJ/OoOA3AAkoCP+YAj5zXXsBYWl9ewWZNg8l?=
 =?us-ascii?Q?17QBwSVPiodPY9YVRsp9FTrEowIIuYMdi9/l+YWK0UXH3dc0RNbEmnaccxOE?=
 =?us-ascii?Q?0HUCUgMbL2qEDXoCko/+H6TIuYEK6L7xFIbPqaLyn5CE095wbvKVjNwQVVlm?=
 =?us-ascii?Q?SACfKmCcUPOycICorPr1lHZmpJRbTEnm2/Pe+gfJt7qNHwAmRNTV9NmzuUO4?=
 =?us-ascii?Q?whkeYl+ewd/huNREspbfaIl+J0Ht50p5FoobsC1HbH6V58hqDutv2F5mn1Ih?=
 =?us-ascii?Q?I4F1Nv0IiKIXMTQKdct5mW7sdF+zh6YLA0vy/qQv5n+otn7pGrr3SRe3qVOt?=
 =?us-ascii?Q?R9RaDJqxONcfHBbgxiQhvyT5/7e2fhcBMskyhS0SXevzroY/lzVV4NgRa5PS?=
 =?us-ascii?Q?e7F2D3ZZ8Y1/xCKjTemtWxb0kJvIN1rMvK08VxBCom9W0LXC6hJQ6DuF3o0H?=
 =?us-ascii?Q?suSss9lid0urwx6VHqRSNu6zZEn6agbLNKGtmX6lysiPU5zN7jyCpsT+Ir+J?=
 =?us-ascii?Q?ePXOnubc8gn4Y2+1FIJPqPW3UHhkmwdCV7I+QqgxQxlsCC478FpLKIbapdP+?=
 =?us-ascii?Q?CLCZn4ikdYcB/0AMFUADaET47IozjeejNMgvYPnIENYuOPuSczenattPTPeW?=
 =?us-ascii?Q?nDid66sbjofR7ptzM1CCZyBjWWLOjhCYFz7GHTX/jT6ooz5nJOz9BNHoCba3?=
 =?us-ascii?Q?A1hbzaRvVHLAgE06Y0q2zlG40Csy1TyZYW69lwvf9X8h3OonBh1dR7DSvDO8?=
 =?us-ascii?Q?hdWUj5SbnAiOgYQiTHfTvtan12f+5qMFzrNtXnN6jl+zB9ZoKYkq2W1EGEdE?=
 =?us-ascii?Q?7JFoF4UX902577lrv76jCip3N2hJKUaqlo56bXOkXgyv0Zg68ucns9GOvXKb?=
 =?us-ascii?Q?MP0MFxMjgoy1pF90RzzpgvMiC5krLRjwk8kJzPWAPWX5UFvKV7ga5WCkARMN?=
 =?us-ascii?Q?iw6M31buOY5M8vXPB2sHoBeSkmRNq2n59vccwp2jtkgs18B9bNh6BM+5a/Nu?=
 =?us-ascii?Q?g1q/zpLPpXZfY/eWsXqMdwxIzT+wO480AwYmT+qZrji2cVVZZvYgnGqQwwKS?=
 =?us-ascii?Q?0dyWN1O4GymdNBA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:22.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f2bc3b-a280-4546-05eb-08dd5d8b0532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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

Make all resources available to user queues.

Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5913c5ba85ed0..e585e8690edf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -156,21 +156,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 * Set GFX pipe 0 queue 1-7 for MES scheduling
 			 * mask = 1111 1110b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0xFE;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
 		else
 			/*
 			 * GFX pipe 0 queue 0 is being used by Kernel queue.
 			 * Set GFX pipe 0 queue 1 for MES scheduling
 			 * mask = 10b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0x2;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
-		adev->mes.compute_hqd_mask[i] = 0xc;
+		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-- 
2.48.1

