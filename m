Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE21C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 11:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A300210F420;
	Wed,  8 Jun 2022 11:51:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3AA10F41E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 11:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0AnOQP48PGAGvvuJv3FGEaACnbQ4j+ou10L7VfQx8OqZjfgQ5B9x+4zf3YUNLfjTbHizwloSMWuhzGSlUq0kCpw8r+jz54dxZdhqoFkLtetPiU7CJssY13LOeknoigE1kJhFpEZX5XRF5VVcZ/OGjQ0BvP5lh0Hst+mCCfzxPoAf7dC9JG/0TqQEmX9W2FObfoAu+ZHOTTZyElPXdAIA763YeoemrhpMg6AaG9DTMPKntE2e/3v04C5nsgt6p7PFqTwBgWEdmg60Uajjcmy7bM2Vr9WUc9bp4mjlRm9y4S40g0ygtW1OekZ9GDMfwGvIdsS1zuqVQ/e/TFjbzDPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo4ZPXTuPBoIQTWmEAnpg7VOWxDHH3zXmztkzMaNTZQ=;
 b=d6HakFY+/Y90/8XAKc+Hi+7/MQ7pyGfpw6kYDOrzO+HqAazMT6GxVfTQ5MZuYxOBrHx442EFr0nHayc1kZExRAGNNDeL9PCLsZFRS8UezkhVvPs7+5IlYZHErX9+EpDyvayNNe6RXjp1FihBdyW+7NJQwO42C7GCtMZe61kUi1MbUjU9/3BnRdrlAJvOqIB0gzfsAwy3jstpmQDvVekd8jNDWnhsB0ybeE5RTVvPZvUQPCVc8OZ6qWlsyLYvBMArESSOwL/cvPb4tYHnVkxSxahmHnA3zOPBgV4D7avfvETWL6DJe7U+7IbkCwN0oiSgfzxX3LsJnd/W0WaDR5y/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo4ZPXTuPBoIQTWmEAnpg7VOWxDHH3zXmztkzMaNTZQ=;
 b=tA6ctG43Wgc9cEUIo9eq5irSqi06HjYwN/8yBsqthX2Y8ywnsGyF76vJLWGfX8WgdweV8vIUVGNcBguryicS3KTEkqFOrMJ7ECbj7SWhc9LP8GVXYy2+lQMFI5uTXm1SlkF+UIYtzYenVg7nVvonLvHs5DsCjre2z/03G3dUY/M=
Received: from CO2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:102:2::19)
 by MN2PR12MB3712.namprd12.prod.outlook.com (2603:10b6:208:164::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 11:51:21 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::9b) by CO2PR05CA0009.outlook.office365.com
 (2603:10b6:102:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.9 via Frontend
 Transport; Wed, 8 Jun 2022 11:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 8 Jun 2022 11:51:20 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 06:51:19 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map count
 goes to zero
Date: Wed, 8 Jun 2022 06:51:10 -0500
Message-ID: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ca4107-f352-462a-ac51-08da49453437
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37128578E096AA7E319471F9E3A49@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvHM2I094yA2ELyGwSsftB7Gz5roKMTMi4rjSyTdWi6DUazOmew26KLAiKRQYh5dZITZdE+mziKrd+clSgeXFIgwAA6Q2wcqs8vslMktx2zioCqix+ePwj9lm06ZWPfVIIaS6W1rbKspfWUD2MDURtzt1/xZgLkqG6tYG+c5rLGBjNw3K3sMP7j9l8axvpqeGxB8aDOJwqca6IFIE69DHaaChPqWILR9lT7aoLnOEHL8h2sVZMi2ch5/MmNNZKJgy0mk9lzDbYPxGDVNL/w0KwC7UMCvv8Gj+iLd/E/c2CSlGZnN2uj4PhjnL7b5oCZ5vRVAPmuKWEuzqUCPoHzRw8tgSP/usjyiv3Pp2QIgeaRGmx40ju6Kh3Fg3MWdbfOSc+BRASp34wN8cd6Mv8e1xCag4+WsyRqIFOgCBsLCw+eQazcRa9aRB6Qv48+ftVrvhKOr7xXgDWlP0ps2giO7knTW893iAEDuWL5Ne06dj5B/gIR7JODxH2OyftSMG4/PI+tDc/RJ4e1VhRdH03h7oKGxAyUyQQKL1hdadx75u23YQrvc1xPz3dvhked/m3w48ttoS3PjpTFS4nsSRKR5L2Goe8+s4zK84Jh0pPitK806kM6lDUnKK8bW7tIH2hDTZPgr3O71wkAiEicR66tGaRqS2cdV+SL22hhSCEJbC1VRnH7IyQ3npNZuqgcv/oBLtlG/CZ4ylKovzBhB+i+xUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(426003)(336012)(6916009)(70206006)(186003)(2616005)(16526019)(86362001)(1076003)(8936002)(508600001)(26005)(7696005)(83380400001)(82310400005)(6666004)(5660300002)(356005)(36756003)(70586007)(81166007)(36860700001)(316002)(8676002)(4326008)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 11:51:20.2106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ca4107-f352-462a-ac51-08da49453437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In existing code MMIO and DOORBELL BOs are unpinned without ensuring the
condition that their map count has reached zero. Unpinning without checking
this constraint could lead to an error while BO is being freed. The patch
fixes this issue.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a1de900ba677..e5dc94b745b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1832,13 +1832,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	mutex_lock(&mem->lock);
 
-	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
-	if (mem->alloc_flags &
-	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
-	}
-
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
@@ -1855,7 +1848,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	/* Make sure restore workers don't access the BO any more */
 	bo_list_entry = &mem->validate_list;
 	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
+	list_del_init(&bo_list_entry->head);
 	mutex_unlock(&process_info->lock);
 
 	/* No more MMU notifiers */
@@ -1880,6 +1873,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
+	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
+
 	/* Free the sync object */
 	amdgpu_sync_free(&mem->sync);
 
-- 
2.35.1

