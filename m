Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2273C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F5510E61A;
	Mon, 13 Jul 2026 18:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3kDRlMz4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA00510E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOkLN3SFXBCTnR0XuktDFFQH/xQeG+CU9qJIe6LezFcUzf238GZE6yBR99k8rceMbX1ikNOId916V+8UZVDWOBxwEfcDg60i3yRK24SLXFkwmV/VkW3Eqv10xzEZhsnAWjIOmRJzcGIU1Z3r+dbmBEfGKnk6yOxcM4b2pV/xo4ORm2Sr6zaNxdJDQed60idQXXHmG/TsJzidYg2SOBv0nhSsJ6WVlw8LilegfQH6RmJjbo5C+n2C0NyeZc1NvWPvoL8F6Y/nt/RZJhaBnhuFvOF47YFE6zpuD5Rf19NeRM8wqhhCZ6uVU1cHxSB8gc9877JrKSqDtHjj5K9ONyDrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILJjzIBS2EW6qJ/Vh+OUAzsdk9a8UkpieAGL2OYK30Y=;
 b=tBVlDOIrqtl/QGrY3z1Wz196y2+/gnlpD3O5a0ZHwxWxXf4rsIYjIXd2NiEX/k1YL1L3Ah0EQhAvGvMchzZkRxwDgWBPr47yZDTHKbbDj5nWvzBvF4IpI4wpmD0RNtq8VDTqoDzhzIUe68LutO2MPU4DcDvZKPbbQtPEJaiJYVGYal4KgaeuFZZorEhjsJedewgNHDE8wYco1j6WhfONOw9xc3cXiOhcBBzqCUIzoRzOgoRhqHxyIV2dfeGNiFLOYmkqsSxptTNwg7Mk04ocpEZnXSBNL2H3Zw8Ek5128H2ysnSXYmsWJxuTGr+ebMFsZmQRmhqrmG8H0lWjoRXa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILJjzIBS2EW6qJ/Vh+OUAzsdk9a8UkpieAGL2OYK30Y=;
 b=3kDRlMz4OpAO3s7UGIB7OVDLYxefkTBO2bZaUWSy8BkVx3xzq2Mwh6vtDm0ciJT3M3f61a2iBdNH6rvzpqCw52U3FpET17FkRFK3ULJefeisORIENWsqSjg/X4t0uteSrRZt7p5mfdKzIj50UpwPaX9G3zS0tWnBcJXZLLoAsVY=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:24:38 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::5c) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:24:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:24:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:24:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix missing check in vm_flush()
Date: Mon, 13 Jul 2026 14:24:13 -0400
Message-ID: <20260713182414.630372-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182414.630372-1-alexander.deucher@amd.com>
References: <20260713182414.630372-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: ef02954b-bcc9-4c5f-3f20-08dee10bff08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Kf90QkIibzD9MnBu5zE1JBlSRKYsSnfTIT0/x3p3zA/LxWIf5vDxFGDPERLJoMQbkumWhWceirFm9Y5Y97RV9XnSaiEwxKv8C1tQT1ygDlnQVTOI+U5wygIbXQnt8XVTBWzqrxkwy9DOdgBTH/4/p7mwNk8wp5/aYV+JqG6BZMKSfjnSWlLNqEXKVB7L1zM2q+uiSIG0htA/l5/DPPLHw1ezV40cGLaw93t/iA/GuyvudnKKxUdtTSryXloMok7pBDG1nT5FiGs2zmFLzYDGJX9PsTrEbIFnyAyJeMH/gdXSap5cJEAfEGwS87sSDUp2GeqonoyObHxHXFEnNALtVACJ6GGNspH3zvfz1cLoILQUMgGKwwC9IpNpP4IoGPMzrhV5DjbGCchZeCbbz0zFrSfYfcjuh5D9L9+4t/ZhmpYpukcgWmkwPFyWkWzSHN/1bbPWkKWGQYWs8L2YBVNf8fdBG44wrqXrQvk/cDjU1assQm35OdcmzcSEnAYIApa3LVCTbIZfr4KWgeLMlDvML/yy2E/Kn4i+CYtIxVLGIQUqok7ksX7pgACYckO8be1h7DXmsNGIfocXHZDNM+mYTpG+BF159gXhG6PJX9tBTX3QkLzbf3a373lZkQH/5sG8j4uxCEyPrYuE4BGVadozIygQfjmeuZ5pN91clyvmtQo5Uv0ccmW+VX/bUxmEL0LL7UzLaVkbv90E+BzqKSXQJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +jFP5r+GGt4T2TmGX2ekq6wPinSml+TiTU/+YkoHzKIg1FO3krp+lRpKfTVLfTXUh7i6e0rzZc3ALOQc0nd6obRvMm/OQ9v8kpHHphwZaieXh6r422ljkW6MhEn3LzVHm2PmmCtbQ82AWHe2mwVPttaKPOXhF4Nm1vpVUNVzMm4H+WyHJcYmWG3jvVhcOKxe0g2suAZsk5rd2k3ZNNwvDsz5XonfXCe/VVfdDdlbhwOMLW1CKreR7HWJy0ZkMQB99Jr5zAtMTEPDrURSLoevW8COnqUUMLXRI/GabKUzvzio+9sHiMbq1nTIVxW20bMfxkhpu2VDkWJJ2czjFHm5mRkmpJA103uKzREPyGbtmcKfUs6MPT/XT0p9p3+OYDwyD+HO/LqYeU+hkUs3Dz2Fk/ej2poJZUxWoAnJAJ2fa2JOT14kv+J3AlWnMuW9zlvY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:24:37.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef02954b-bcc9-4c5f-3f20-08dee10bff08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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

We shouldn't return early if we need to emit spm update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0affcb9e6d34e..aec8468634535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -811,7 +811,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return;
 
 	amdgpu_ring_ib_begin(ring);
-- 
2.55.0

