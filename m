Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4284BD3B7E5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 09:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC5110E1FB;
	Mon, 29 Dec 2025 09:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="anun1PWD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B39310E1FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 09:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPVtLX1fhqWVjpyIqG+Em3vDfGYKNomHrLmk9ypL42DtxF8ZhCop11H/OkOhlICAKDU9gxEiPS9lrFdCcx/wGSTEG630Gwy2t/i9Gj+MSN7HfhiKIWZypVY7Gcc1nL/TKiTykQjB0k+akHQcBVIv6YmearOlUXo8ZQh2NlFvSmbXAJQNEo7rEjmdthA9aQatpOUrZ1r2WQV+CLtFfhlsEmv94F9ILXeOtoLJpHUig5VE/AGN7srHbXT97H65bWAalD1xlPuFlvtxhWanWvJQ8RXTXKD4dfe02sB6ECnEK9jbSQCV0g6FkSECiP4Lxw8FquvF0h2iWwSkocryQzOoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3/T/TKpLCUk25jawSk+IbeKuGcd4qLOZEmbShdCAzU=;
 b=TfJ0zyNSwZwEDaerJflNq9HjVK6HgZ9na1331icvnilBHqXik18LBCwG22p8jL7IUz3Sg7Pzkb+Cixa/vVYq5uifwTsO8r3ODhRn0i2Xp0sk7WBGJaGSkLtT6lpFTpdV6Nkin+FNDmToHOgt4GHHiFPgjA1Ok8BVMDhBwZa//wUW2WnLf2pN+OlhYZ5VQWfFztsiKx6tTcGEkjpDzoVMsBpn0TAoX55Y/KlNoEr+zsPETgBB4DA+duSe0/NB/ZSz85QLQLfPVuT1U7dDkktuc+DpRflxygosqvaNX5VYBnm8i1kQzOruYklxgp0eUJWO8BdCE/Q1cc7bwE7MX9tItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3/T/TKpLCUk25jawSk+IbeKuGcd4qLOZEmbShdCAzU=;
 b=anun1PWDmM5uxejacgmI+iQSbVlANjnNh7wJbRd8QOTTuvtjhB6lBY93hD/ibbgCn7Gv8MN4sHMQIBFTN6nYlkNCCALcoNgacW2idT3Fs4KFe2c9lgeW5ONT6wmZzRs+/auLLEkhTjB13zKF59coA/nXmzQOgKnNNp/6VAfMphY=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:20:54 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::5b) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Mon,
 29 Dec 2025 09:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 09:20:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Dec
 2025 03:20:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Dec
 2025 03:20:52 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 29 Dec 2025 01:20:46 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amd/amdgpu: change the timeout for user queue fence
 waiting
Date: Mon, 29 Dec 2025 17:19:29 +0800
Message-ID: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af5b308-8ec8-4cfc-32c0-08de46bb90f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9HLiAZYPvRD8X3toZxVsr+L9Biwizo6YXRD/Aest2kd5FAp6gq+X4kBhzr7I?=
 =?us-ascii?Q?a+91F+oNQQHFwmAp3LCLJ0OB1Qj4JTMh/af3YyXbSbUr7HNkShc8N9Nt6SeI?=
 =?us-ascii?Q?19E+ZNjzkjlaHXzDoTeidVey/6RGpQr6DXKEMJ16FfRiT16j5pU1dsQa4glu?=
 =?us-ascii?Q?LBe5/FhPwMu1RoFp0I+IBfjQCXzywIjOxUJZbrJZMnRaFso3EVLF8jLjhXSZ?=
 =?us-ascii?Q?OHRsXCU1/L5MkxCrGd+NUezH7oK0oc6WohO+z9YZiaso9G/NaA48TWn1UBQ0?=
 =?us-ascii?Q?c1Lu2XUIDG+NisnBohS0z7fAx4FyxlK+WUKTrsUD6J15/KYtgNv936vefa26?=
 =?us-ascii?Q?dJR823NEBO9flmQ+pvr7PTwag33gRxtE3SAoKXQunHLDVe55sngyKbemf4Kz?=
 =?us-ascii?Q?ua1QiGmAL7BhH1xxpLXZ5WUJzDIp9o7q7gALmxBxdyC2vlNtIJWf/I3z9yli?=
 =?us-ascii?Q?J/4wmWG8Zz63vekG1y6eLd+M4qg3DRh0I9r6HZjGbOsQBIiQi5GJ47BiygWQ?=
 =?us-ascii?Q?2tEQza+xASeNu9bLDfrtmmv2x0ioR/f9yggnCASyCvaAgsG3hZk9ZTzAvsIT?=
 =?us-ascii?Q?D5PD+/UgViSd4tymZ3hopMlieOLMOP1dyxfu8+15I2ayWY2D/gjvCQVV/9Ar?=
 =?us-ascii?Q?8f3WbFUFGJqAj4mAP5+KLQb0wbgY/o7PrhmrULnU787HGmhPsHOYaeOC32Uh?=
 =?us-ascii?Q?v0nua30v7fHfyc9zQX+GK0k+ihef2JrLZ77YdpF9XkohPMs5YiAoy/G4hye4?=
 =?us-ascii?Q?gApvdaz1M9Kkzp988XuiJd+jAKk2PZqRpUA3u4voeRrlQDF7G2aFODAWV3st?=
 =?us-ascii?Q?Dcib7LV1YfDnpT4QJHm5ryg3gAj/DgFqxvf7Xeb46R/u1TCH7lCffjp6x/Ef?=
 =?us-ascii?Q?YsQ8xx7iXYpVVcsc804sW1MLQ8FoAbbDzu2DuO6F0deUyI2HVsM98cvMF/ts?=
 =?us-ascii?Q?QW95zNED5n6BpLtP2EWR6lysxtNtnW/DraIDgDJAErgrvpOJWV1I8dQ9c691?=
 =?us-ascii?Q?DujK4Q4uS1pW0Bbej+ZxE2JPRC03S8KuXk0cBQTcRDbPQrerHn9zJGcinegU?=
 =?us-ascii?Q?jpqPRAvHOCO2cvLJp2TxffmGSdT7KJcHP+8pkNtZufEaRdezUPjrF86iLSGG?=
 =?us-ascii?Q?j+MhU4GjHg5J9jAYPyMbAk2Hs2b3srwkJIQr+gTCXW0ta2C6UzY3ezMQaqf+?=
 =?us-ascii?Q?7CeIKx3I6LqFx5YHMmfJHQHN7WwrVyXFas+F3XPRZq6uyvRoPrNCMR1YK4gx?=
 =?us-ascii?Q?NXVOqTYj4/yao1wcNx+q8Axkmtsm0UUmu8+/C532cANFiTPBv7qby1w4mHYq?=
 =?us-ascii?Q?Bj4ehRLof1ggjXVHW5F5aC3BLJ3Kwuyriay+tCrcPBDGde0qVMbMlcKt8avW?=
 =?us-ascii?Q?wBEExV6Y2RRrN9fuAUadgMxYj7124pNF8SWOkSSTScqOmnxJXmh29yfHnLk4?=
 =?us-ascii?Q?a4dqQ1A0R6Mz98gklZYvCGXXrjNJJyC8KWpU+U6Lol8iTojL8OdhPSPRumBU?=
 =?us-ascii?Q?UVqwLGZeGKxQUn0nO6udrXiCObkE/DjzjZqpZ1eKsCNsCtSvXc2ZjM96/u5m?=
 =?us-ascii?Q?CWYEk31cdOPxbsgW4Og=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 09:20:53.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af5b308-8ec8-4cfc-32c0-08de46bb90f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

In certain error scenarios (e.g., malformed commands), a fence may never become signaled, causing the kernel to hang indefinitely when waiting with MAX_SCHEDULE_TIMEOUT.
To prevent such hangs and ensure system responsiveness, replace the indefinite timeout with a reasonable 2-second limit.

This ensures that even if a fence never signals, the wait will time out and appropriate error handling can take place,
rather than stalling the driver indefinitely.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307..c28332f98aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -371,7 +371,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 	int ret = 0;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(2000));
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
-- 
2.49.0

