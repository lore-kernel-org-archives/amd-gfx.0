Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BACCD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 03:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F768945A;
	Wed, 13 May 2026 03:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sIknqlU+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8223B89919
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 03:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEkbMVbnf8wSfEj8/v22lXHDLSB49AvT7kvvI1SkQo12gKiZlm2Q0y9AnGHWjfrVIjbpiLhwUSe8fUF+t8J/MNzmjpEgIL+2EyWIQKPsaQun9bNlCjMpeqrlF+B6mKZOx0CbhswGSHJUvOWK/nQLdf+OoNf/ZWtwetOZQ0jLJI7Lroa5bvy/d+zew1XUiY1w5+PYdSQG0Yv5h5EYHJyZfN9d0f2Em6HrZuuOOb64pxObVHP5mkak2Le/fm0vNuhxFz1Lf8Yz7SfnTZu2GyAi6nAsydSN84eiLbnCbRuIyu+J1/wO9fIxBW1F/kg0UJ+XCDlNR7jW0jPT1BFJbGOJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zAk7tRiMD0Dk9r4gt2Detrr74KouCcpvVmseIlLGZU=;
 b=PaQ/XnkS/ecOFliwKdDNqDLRQA+8zEy+5YgDjpvd1QHvUrSBSNyHQrgagUegjRCFUBvWk3suyL21zii6DuyNaxl5ctDjdzZKBkzid9vWpqG6v1v6PITSMvlNLg0mvyzXqGDfE7U/GZ1bMRSfpuCM+at+Fx9ZNONbTN0znWPlX4DF3bmojsS/fbeB3oTPvOAUj5p0oBK7NFRHBmlc4shnebfiIgtoxGsGvouJOtNza1JOUn0j4r5Lw4S9kmSTBmCN1iOx7g/UWtusFZj8CQFQYdhW8imcFw57pG15PMD1eQwI83xv2yACxarnpSY2YHwQftSOzOzS7Ierb5sgVfuDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zAk7tRiMD0Dk9r4gt2Detrr74KouCcpvVmseIlLGZU=;
 b=sIknqlU+GpMNxsleHsGGwlnWVrEmKaz0up3NdsWW7x9VuvFpq8VPA04g4JC7SmSdTNsGXqY+LD2UMFvYLNXVfJeEZa3+gBNs6FJlGoW7bH6D/JTi/A7A5hWArkahCKJouugnvQ69p/08pEjcFj4zhl8OulLoHoCcFPIDic2vlDE=
Received: from MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:00:48 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::c4) by MN2PR08CA0013.outlook.office365.com
 (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 03:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 03:00:47 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 22:00:45 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>, Michael Chen
 <michael.chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Support MES suspend_all_sdma_gangs
Date: Tue, 12 May 2026 22:59:24 -0400
Message-ID: <20260513025926.259727-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f4bc9-c342-4e44-697d-08deb09bd525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: djnE5/xQcOqYskSJ/4TMei0wiW3l+mB1xtlel8gPnRUiR8egqyNFv9fILP0An7UmYvWDjiu0S7kBU//qnpBCqQePpt6gzEGfwqM7QGbaIZ03nxjUjUIl8esL26qxq8g1scILX+Gn2kj8JOAmGIOmgf+X6Vl5JMcYXL5y/1pCQmPulI+pQjONuxk1GheRWmKw1Pe5QXRj8owRPeWVhM1IQsXOuAgtT17AP8ptnF+F9jGKgIhZAiq45Yokw33XNZ5NiEssP7nf3e34bsRhT9xqEAoowShjo8c3Dn8gba/V3HbGNOoCOTLh9wzAJJI/5E04Iuh4abEYNMp7VlD0BvfSDOMqr//P9dV/jNyBK0rXo807nATLOvdiSgQsp6f2tOxEHqcPjWlH74oEDC1cdgjZd2q3/LjdAq+mlroFo93F7jZGSFETTELiyF6N6Q2cy1pzi7+PhS1SZ/O+QtJEGvEqEN6uV3bsCsXMSUli46X04cE3XOwEv2QQ/hi7CP0ReqOPxcfsRgjV99K90gaudPUFoMUu2ZJk6lzcpLlHV7BM7JU5l3vybSKQTMs5+srwLGfQsWhpcdsP6hhp8Oga6f/7ZpSriadSjmWHE8xOULDhZusDLtHdEsjFdK7QLaVe47pvhkiZ2PVzL7ZpO5EyXfMTtu/41itmtfCxNQBxJfGZ4M1ZBUCf19/TpT3rXjHVArcesuOzmGqeJrUUig3t+unCHW3u7A8vY4SNc1/bMXjV0O8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Aox4uBJzyF/Dlk2jY0yNM5n9pwhJuhSXVKHnSXxS3fyPxB3/fr8qo5Sry0kkvY1syYA64a25/3ou+85SD6WGMfxKXSCj7QuLb43oUkhJmvCVtrFL67NjOZCx2BMdPsafctbVrmVanTj0FRLlD4JmqrCzwJwr5Rb6vk19VTY5isitujT/GtskRwjkb+F42gg2NbBZ0Ox+H+Ru+PCu1/h4aGWYkRaEa7YjNpNx9o4GAUBB3hwDwbjgWMPyWIxgFPthhbr7ky7mv+oWN1MeiNU9CHdSGobTrXpa28iBoeW97NtIEjifks7BYM2qRA60GZHEFIRaPBYgxF16a0MkSVGjxMb0hEj1FUJ1wOCz457xhe3vLqg469HjezMJujzxBehfEhQEl7tnKxNtA1Yn1+4lsIjaSSPj3oZPuOI/pyVO+xtQT5Kpnb61gK30yzsqgInq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:00:47.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f4bc9-c342-4e44-697d-08deb09bd525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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

suspend_all_sdma_gangs is supported in new MES firmware for gfx 12.1

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Michael Chen<michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 610dc2ca67a2..c9467b26e42c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -312,6 +312,9 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
 	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
 	input.suspend_all_gangs = 1;
 	input.xcc_id = xcc_id;
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) &&
+		((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x71))
+		input.suspend_all_sdma_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 31cad8a5bb9f..93990d4990f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -298,6 +298,7 @@ struct mes_unmap_legacy_queue_input {
 struct mes_suspend_gang_input {
 	uint32_t        xcc_id;
 	bool		suspend_all_gangs;
+	bool		suspend_all_sdma_gangs;
 	uint64_t	gang_context_addr;
 	uint64_t	suspend_fence_addr;
 	uint32_t	suspend_fence_value;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 4217b3fea0f3..b169e577e583 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -480,6 +480,7 @@ static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
 	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.suspend_all_sdma_gangs = input->suspend_all_sdma_gangs;
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
-- 
2.43.0

