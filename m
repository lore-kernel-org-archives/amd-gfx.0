Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AEFF417E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48E110E4FA;
	Mon,  9 Mar 2026 14:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qk8vLiQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB95A10E4FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+H574GG8wzR8NJ2FgRv13D6wOlVbW/ZQ+UMlNXijBBpSVeXt3gk7FDGSUe/KmNik6fQL94CBedAedyg6fGXZoySjt/P+0o7YNn2pA3OYpo9ABUh1piys2nAKgzu7ni9OvWVChMQMv9H24SBsl6lw+ahIy1xT2kkQMYY/ASqi+vHHoYC6Pcpr82eDhNwOsxL3nVUWCV7/2XhnrmTq4pqRTzxpMeCNTVYS4KBFlG39GKg6CjQa/wxW+HFl8EfZ4P1Up+Y3HwylFQYKPTQ4c3mistlhHceEdzaNiUrzmPJe5fT2XX14+mMjMvx1M1eyDhpepOGuFb2Mb5MxYpaLbj4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs2mqZVKbtJ/UZteLXH9pZFQfJbvM70FDmXP98iSkRw=;
 b=uK35Q/mNVkz0KpsGHVYEHRFIUkI7famCtPcckCnuIPToC5mM8FpMlIXoLbKkRK0U36jPUf5IzPhO/3aCqR9Gn/ji19lzv2JdxXZqt9u+rC+iuVSztq++pXFSDruv81I0a66oJHlNf2W0QgBa7gmgpoE91/lXxrV2H2/Zjg/wyCn6z24GIBeqo5uTaFHJ6v7F18T9DSLx+Ay2l2glTsO7ns3v9ZQ7JD8DQ12+Gxx9Js73a3BwwrdY9IHQcaEg34BPWaMi8toW3GoQ6g9Rhjof7RGIkn3m7wVOST02ES/u9pzsKNdpa3M2yiIqTA8zCVdE60uQt1ZN4Ai+oIWjS3Is0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs2mqZVKbtJ/UZteLXH9pZFQfJbvM70FDmXP98iSkRw=;
 b=5qk8vLiQkqrB2ZCCS4kRFCwT168zwXjuHDq3rNrw5ZOAcbd4R0Mv+JK/VrXn1KNamE+o3iLrommqcnV4HcIOuieTHazoV20aHXiSrvv/x7wsdqE7s96VxdYKD4FXZodPNRduW5t12A2G7e4HFZitZrSIbgc3G2DokIdaRZ6ujnE=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 14:26:40 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::95) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Update queue properties for metadata ring
Date: Mon, 9 Mar 2026 10:26:16 -0400
Message-ID: <20260309142621.2843831-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: d53eaedc-4293-4058-3168-08de7de7e0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: A7OJcSC3htxBpm/gOOf5qGPW06xA+rwu82oZI8idPqBqNaIX7vcSrjko+rDNlcQavEHI0opkHAO+WKXxDdJmSy2NHQhMrlC/5aD7jzSVBWrlbVBbjD89lre9F5ZSehsYbzLj6xt/qRn6LmT1bsqr6QNjUArl1PGVyvJSCxjulCL6LU/B3xc0J0xPcLutGYY+MxVA/QHkuE88HLkOryEupmwveWsvLx1nWkP+XZjLtGQP1NsYA8Wu+E76cTck2S9jsze8lICc+LvPPYJ8OHL9zy3qywpBTMWG77DhFUv09YCmRBirzT7IwpCNNcXWY5I1tGcvU97Ii+KZWd/RoZAyc15akEASL0E3d/nrNPJwj8FLcV6qOlknwxN60Nzq0xzSRpGdvcSO2zSvaGe/m2WLRq6t+CLP3eb7j8v2Uo9NJvSfAJdyOD7dcc1ISwqL6hIXy7vD4CdohqmTb/9DpRG8tKTOYlP+n5srQ5mIwrixRuLKcu7L75QPJYouGnLO9kZ9ezu6j7pEsAAOuWw/sv4CYwnPpz9PqBb1XMJ+Od7Jq3VF1ze/WXwwHXQqTyOh6DUMcSeZBnjiFy3Nuhxy9igbhm7cqc2MxWYGf7hKnY8SnNHlR1AoSafQ1yfhYwTIb5kXl7299YBCYzLVzph29hqvrllYol0UiEbFTFXbw707Y+TKy+M4KQKoR/xBl6n3d65Cf62+40m35bZNHfv2sjq+E2qB0bvbldyas7rc1ICHijmPZE1g21QPMgHtO68oVL9thWsKu8bPMg7bkHVDoFAc8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIw1a+tWSRJcZ/zHmpjK8CuktJ8pM03OSjI+PZM7vv/UmOwNY/Kxg+QhTIadEc1gnDeYcSW+Bq7TUHlLunGS1+4BAh+7sovROKPZSUOfvt208dPt5Vp5ae16esOY/YA5dRmXC3qcfPV8kmbEyGmFEQcK6bzr20Utx+ImH+vtds6Vnsrg7VzfFIbF5IkVY7eUBrGTkrpQYedYT+IrLyWG7s33yNqYeHpPKtiUQX2GENgFbl0nJ0JS6PXGQX1FDseQJH6TrZp5C2DFOlrHkiB7rhYcQqz5nvnazjStzOq1E6QJweH2PZo+tUyFF0e/7mo0++7nRba2Yy0qjyC/xgitSn3RfGrgdiV7TIBJIiPR76QgesvLUAKDEBCxSDDCCQeNq6zTEXQnbhHx9ig4GOWtpmSuFBRk1iseHClIDh4OW3CPm9joqlQ8IacpsxsZmAQk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:39.7871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53eaedc-4293-4058-3168-08de7de7e0f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

From: Philip Yang <Philip.Yang@amd.com>

Metadata ring and queue ring is allocated as one buffer and map
to GPU, so update queue peoperties should add the queue metadata
size and ring size as buffer size to validate queue ring buffer.

Fixes: c51bb53d5c68 ("drm/amdkfd: Add metadata ring buffer for compute")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6c1404d4ed06b..9295d0f9dce48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -590,7 +590,8 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 			return err;
 
 		if (kfd_queue_buffer_get(vm, (void *)p->queue_address, &p->ring_bo,
-					 p->queue_size)) {
+					 p->queue_size +
+					 pqn->q->properties.metadata_queue_size)) {
 			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
 				 p->queue_address, p->queue_size);
 			amdgpu_bo_unreserve(vm->root.bo);
-- 
2.53.0

