Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2487ECD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EE810EDAA;
	Tue, 19 May 2026 18:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NU8hUVWH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C200110EDAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9gFAjFTKZJdQtkPPSSn+HwpDqOtggILYgDd+X+GIXO2fjAf8VdogK8L8ARFb0hKJ5t4teX79qXf3i5u0Nc8x9CaKvQ9UAN3q1OS4FPqpR+/HL1iNIQDkp1eVhzwTKzse/HvwyJXkI7++C/aURrKhXtjZgkaUD/lcFYeIuZ6RlQ6nSaLW7/Kpdu55H5S4kMBgvU4v5IPO6mBNCKI6Tw3kKDufxNAizUuts0zoM9Vk5FtVEvte8mFqI/wSlh6ylnWEZpZNsQbvwqxWP6QZn4UHfOUdGJQa1WXrACoS1jFxItkc97Jbo3xCLruojzyVKe1nkEg1MNCXjETEG7Zxjqi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRN/krGKWrnhUN3khdbIyooQSlWCYYayzaUfhFV6y58=;
 b=dafl2nF+zi+rRMpIy+uyxwGa5wLfCLsXjb9dlILujKUjiLLUAbKnAspSVnW0j9mM2CeFdWeZwz3vQfdrmdgfk40K1IFazVcQUslf2ulfo1MMa075g4bW5USB4XQffXIV3EwmIKUZywvBEftKG1APdAi64EFpxUg/N5bW1eACeWqN+rxwjptWbQ0pLeHJphBuCTQMNEmOpa4YbF/FtOSbpJohdLPjSd9wIZVQ3bq1cYOU5fHRCK9Wgaa7xSgVfvaw+O6Q6sR7sluCmNzt554ycPdbBH/8LoeR1YOD8H0MnPbdPEs6AwzVLquPy+D9rl0hnU3xm4/baG+OCYsZguw2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRN/krGKWrnhUN3khdbIyooQSlWCYYayzaUfhFV6y58=;
 b=NU8hUVWHfecHXChU835EaJMAupWcgy7trn5LJDgRABTPRhm1S1iWqL/oHdCGYeMyjODZsAeWYKmd+DNEYEW7AaGnYosZDl3yv+QtwelQPnAi2UJjBrJ8EhAghEK+rznMj2cD069Hvk1fmQPQlly9sks0jJB4QJ/bAaHbfxt/oFI=
Received: from SA0PR11CA0121.namprd11.prod.outlook.com (2603:10b6:806:131::6)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:30:03 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::cd) by SA0PR11CA0121.outlook.office365.com
 (2603:10b6:806:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 18:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:30:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:29:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:29:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: track guilty fence for queue reset
Date: Tue, 19 May 2026 14:29:49 -0400
Message-ID: <20260519182953.21967-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519182953.21967-1-alexander.deucher@amd.com>
References: <20260519182953.21967-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5df03d-8932-4081-5e2b-08deb5d4a2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: lUqDUXYek1rpNiKC73I1wadbukCWiIcZaKZocSgJzSMPyaj+VPmU8ULnZ5v3vg5j0uscbwhTd3VfFZWLdPkiPF6DqOPWo8pIS2zKRQOox+gmIVKJXK+sTjd3GIKvli2dHudjuwBpF5YMYyJ43CPAH/Z8YEFTy/S0SAxwXnMYK0iTLwJeUUpCAA/XhX3BBV2pO/yTSkfliVuE2Bg8BkyCk8m2SQjtzDjDEx5JNjOBxdFjWRmu/hMZ4Ssn64El9I/dXUr/+aiWpcGN8+ZdHLXYSxTujvKpCiMxuW9yRwlpR3ROb2/EAqnDSJGbQB/7l1N2v85nf3HhgXVuqTJOv/1WSCsIsiviUywX0i0yVrfswPNNzMdlrJ0JIv8f5Fx5Y3pkpjN0MpqHvGJym24cNmWAzgaBR8nAHoh78Xhp3YVxKOfvvzQrF9HlW3r+SwfRPKCg+tL29ud5kQRhtYDwbqZ+QV84N4kpQSi4L8WabNHT95fePtd0GaoUEdXm0pKUsy2k5KT2BvFFlLGSldtYX01AEwEsdeLsTItdPaj8kuFnaODutL9HktcC3HV8a+jMYvQej1kho8X34PIusNUTsoZB5LipPtqY+o/7q4dbees8iTGnIGhFp83scgmzQcVy9/f4odSD6FarEYJG9lY6t6+hM7WrIm8RgJODnG80aMg55pbDysfxsY11QnjlbSWH4AY8ydDkNLcsEurmqfPG5pDM8h+ePF4n0hDg7a2N+WDkJbA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xo471Ab8cRToqz9+sr5NLqJ9jtV6w3+WShgyFWoGq/zSvicIrQpAACF3cYvAlR8TdEJS4tYecqqOBPynaKjIzTdD7ImeKzwRCac3OQ8/660qr2/h4BLoRPNX5lH+F/peGh5BEztJ6/KUOAOgW8QUFH+EwetaPFjAst+PO9RfILPCzLxw4vU2XSMDJ7nj6S4UBpCO5S6Xo8PzPNyfYk0TLcd+k9II4gFDWz66HD+PzGH5lEW+1SoUnlBWio3NF4eRho6rxBawCbohShtvoIKaj6wd9oUXnE07Rtq671JpQJHUMt8zZ8LKad9QXwUE/kyeuZzbs29eg05LuI6aN2ivjBRWUlliCtiixEK9jnTwaHWt/WDrq8+eLQVvO0AKxz8kBmQR+IKy9nLDdYN++LCfyLkDhdeBxsikgBp3fRYm92b+JWkYSB/C3rTrKzjJLrIY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:30:00.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5df03d-8932-4081-5e2b-08deb5d4a2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

If we've already seen a fence, don't backup the
ring contents since presumably either the previous reset
was not successful or there was something wrong with the
data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6a43c8494fa8c..a7a6db0bc6940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -803,6 +803,17 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	ring->ring_backup_entries_to_copy = 0;
 
+	/* if we've already seen this fence, return early.
+	 * ring->ring_backup_entries_to_copy is set to 0 so
+	 * the reemit helper will return early as well to
+	 * avoid getting stuck in a reemit loop.
+	 */
+	if (ring->guilty_fence == guilty_fence) {
+		ring->guilty_fence = NULL;
+		return;
+	}
+	ring->guilty_fence = guilty_fence;
+
 	do {
 		last_seq++;
 		last_seq &= ring->fence_drv.num_fences_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd70106..9276a3bb69de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -314,6 +314,7 @@ struct amdgpu_ring {
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
 	bool			reemit;
+	struct amdgpu_fence	*guilty_fence;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.54.0

