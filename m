Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF5ACD5BAB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5F510EE0F;
	Tue, 19 May 2026 18:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ym+6HP7e";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471E810EDFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOTG1NzMOb3+oY6DI6fu1zE0uQLV/W0zqh4bvHgBSy+4I4Uj9EyXHaT/hH0NFFH79tzEqc7OMAvhwWvHdBT6oNvTK4FwO2YKjxy3h3Wjr+/NrYDEYizZMSxoJABj5Okv+gwaxUB+jUHu14bQhr850XJ/SxCDF+31gNPqkFanDTiEF2vmBV3EWQLOWk3rWAI3UQ6zrrwaE3cs175j+I2kTr6bNjNQy1hnfVkROXNofDRLCR8XzQ4W+mCeOuyyN5fpbZ+jHbozJNzwCs4aHCM6yS0VTz5Sxy5aXS6VpQeKnjg0diTsUQaSJBTJSGiKK8iBxYR3Z3Izf3z2eDOYVf3YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS4sivLn5WL5eoBl4lGRcEvWHVajgel7SH3pQn7Dbck=;
 b=mOt05gs7Ltwa4r+C+Jmhxv1rVEgChcujQ87hMmRTVObFf5XJshz6LhbD61NN2k15QzpCMwFl77tQ6GnPNoNiBAtLifcovws+S34hM+x61Jp79mfqwKOOlPaoN9G9quwfNG4FROR67YZjFObNk6M+DNEqQo5OtTzS93OGKtc5TpKQV1UszqXU9Msej0gm+5NgpXlXDzmI93/2m+Dd74J3/i6nv5AJK8OKFUcJQAV4AOKMLW+PAsvcLhOndcfhniBXp72YvADrnK7y0O7nd7OeAIdGh8X+TLGxz8AtoJCU0aZ47zyXYqcspW+3DQb2xtqgk2mn9a2dB9M0uKnXdQ5Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS4sivLn5WL5eoBl4lGRcEvWHVajgel7SH3pQn7Dbck=;
 b=Ym+6HP7eWGG6l93K3TZS/nvIEDlO5H0v81q7Sm04jCi6UCZAjFOYJNh0kQ4vZ3KVICPwQfNNYj4V4tOuFgbydVASPAq2fZFtOXOpcPPoFoZtDwaHKQCsGvPGajTYRhitOQhJxng3TZ/v+LbJTTjOgYlWNFKCVCysfxbeQiU69TQ=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 18:30:02 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::ba) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:30:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:30:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:30:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:30:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit()
 handle NULL fence
Date: Tue, 19 May 2026 14:29:51 -0400
Message-ID: <20260519182953.21967-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519182953.21967-1-alexander.deucher@amd.com>
References: <20260519182953.21967-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbcba40-ec79-42b9-4814-08deb5d4a3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: N6o9NGm68oEm4j5evGgIKIf/K9nVyI4nbsrFmXQ17Ke6nJ/m0s8WeKn703BRCVVnzvGyfowKUZKMWjfioW/TdjFCnT02J9avYQr8sLqH5LDqtEwxUMUmPS+/FixXrjmt8fyPbwxw9eL2sGRT0SqVFhlzjpCUrD1mRdxgH3MiHIn38MqSCP6dJpFOQXNLfpz/NkTuPePEwEBo4WbrRLhUGVDPlu3yF7fz4XjwhIPpFPKlvc7LU8J0jCGdm+PNRFkX2Z4p63t8vf/gsX27SVnooBjKTMCLEaw4UNC8EmLn7Y5jsVWEu22dvcUMrc/B9OYHLclYAXLki41MVh83XmDkf/6uMG69m/6eQZw+v2CMukDcaAuAd65E9pYrTAcHC+CXPrCm3+4/YpwBvLkQRgR5It6Zsk+29EIyi9TGwavsbp/5rnpYW08sx4/TcWm3HG5N6RDD1lm4dOrKvN72I8LagW02zZrK0NM52Gs5PX9uGAxbA3YuRum30Sj/in/iLouRJTH95e/iPiKQ9971/ZcHVZOEFlwRtDq2pAH3oW83aiV1t50syHib+RIP4JUghpYyuCTeTv7kKmLMdnnUzjMvFb0cpmkUgRKKJDEj1vYlElMUpF0ynwJaEoA5v1QarQnB5QaNJZR5QQqp0bj0Db95FDsAhfU2+QyAekAzIJMQOewqJlYdMSlDBTPiH3V7QrmvOZE0gWuGDm14pUvWFcZcpAK0YZNq4TxahsJgshhrIiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rb1g6FkmhGYQXOX4NviPzvh4Apyxa0JH0EyvOtNKp3o6WA0VKC0nKpsl2T2sBzgRK13dCQdRuI/04u/M6HLIx8+o7E/MvI1fsCxwLCd++mf1zAohAd+k0h8SFaJ0zLXYhsz4rR+EIYaBoAsOXxHhwLSBohXOQpj7AmuUKYWr3dnED7jgCMWyZsJ8w0juxmdGflK1baLXEM7J75SuJRYCOtQBfg/MGNTiPIOQqKKNUJAKI/7jaF43RUKUaF3fbuots9ndTUZwdDkMq1FDiJw0k65A+1psKzBAaBHCmDqHjc0xbQD0sj+6DiglaMFWsV187xVOQTNr21Ydqgc0ywrufySQTT7xzOAa6px3jpqbpE04Es6DcH5BxsykQyYKfsEswxdvbI2uhV2t8j00SH3o3vOYTRpGCmbgGxS8a862QXjn/zPUNiFpov1DyToNaqre
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:30:01.8729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbcba40-ec79-42b9-4814-08deb5d4a3dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

All the guilty fence parameter to be NULL.  Will be needed for
future functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 733e9b668ed8f..8569c1c637a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -750,7 +750,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 			is_guilty_fence = fence == guilty_fence;
-			is_guilty_context = fence->context == guilty_fence->context;
+			is_guilty_context = guilty_fence ?
+				(fence->context == guilty_fence->context) : false;
 
 			/* mark all fences from the guilty context with an error */
 			if (is_guilty_fence)
-- 
2.54.0

