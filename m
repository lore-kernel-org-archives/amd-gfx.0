Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDF1C44503
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36E910EE0B;
	Tue,  7 Jul 2026 15:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KteoHKt1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E16810EE11
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOT0g5nAV3FTsdNYlyIIUv2g2RW5cjozUQntSaGtjvuYPqGTlDlytccEy+6PjJ/GFTN1ax86jrcMgh3DX0hpvWcT4ZOVDE5m+DAITnuCWOrUD2SiveWREVrjF2BAlfuj8ZTN5wnPrmhkaao98yCrLz8XccZau7s6UVTOOhiqKoixedDgamKqN9Jv2SbpPFLQk/08c3dYErTn7xvUy2E83Fqmc4W1VvrTf7xUudADR8xz2Sv0LGQUlJup63LNSC0tKHRKlJD9Pv4noYmtjkdVhWisho3G7XCeNO+HrWv0IwqBsiAewqn2Pl4ljDH0z/ysdoEfqMspcLCGbD0d/LIxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTrX6GAb1C+00SLd1s/14CabQAGK1eXxumA7K7qEqWM=;
 b=oqztvWkarMARH25DsKWjVCgD03TSw8C+OpuKXnXspRZ2A4htUR0ByqgWc4OH27UvByfzZRUtwb24WeU9B5EGwrOHQ4KbinazD5BTK5wDcyddD3h3ted+OUuTf8HDdqbI3FTmjRFIP1ccdNqvgDZjUybFFGNrsZQAIEhKtjz3EiPIuH1FPu984YjHgMg86IXu0xureLjpy3GYbEuSJHaOgksRuRLgiP6tESXeHAiHNp4HP41GBc1RiRi8Z0fM5em2F6xkTlRrN7Y7Jl2UcDdY2QFsMPUNj/cDqs1lCBS69dGAHyGWU36QrU1g3h/IlsAYtbpiZfJXt+hqEuFfaw0Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTrX6GAb1C+00SLd1s/14CabQAGK1eXxumA7K7qEqWM=;
 b=KteoHKt1CMGEFFw+gLyyOggEBqEfSi0eIxeDGedGvX6GITNK9OInig7rOX0auRD3PwzEEl6pwxo3wYJLpAT0L7v4oGkW4301OI6hgt7l5dn2fNBDbukBeSHhL90EB0WLqpXj38CNdGv7rHAqiYPT2NHl3YlaTQwof2XR6XHCZVM=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:25 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::34) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:23 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/30] drm/amdgpu/mes11: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:48 -0400
Message-ID: <20260707154203.2603209-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: ab472f0a-b431-4e3c-590a-08dedc3e5746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bYiKGkrlgAGHuX3jox8gAHSD/ErNIXYJlE1aU4DVOAmhGPRZ/6X+gh+aF9qecZt10wHHGW4JpX+8EjAdYT2F1paZLxnirtiAba51iabRiLgupCjCTc+PuilQhVX2lMQ/X4unfzVUxirqTotiYn2zxST4KaZ3tbI/4KcFVwf4KYTLKYD2b6KtA67W16ioBL5bFsyx/2igHc+F0LXBdoc0PO2VXDnoCWEzpWb65Y425V7JK+vZNvZAphO9lbQC4Uep0G9/AYVxGjM0etreAkrkronN4C9ExhBIy27NB7Ui31rxHq0RR40gW1CurO8vL0atP794ulUsrJO+wGEdfK8UxSEb6tf8GOteYrGRBnlES8Tgq5Nz9uYcbnMCy1ziuWfxIdsjKjvBbhobE0kp/TPRalDBajf2QEiXTXO+XQR6pGlQpsYS33aHRZ8oHkS/DdAoGiS3vsOUtCdvWzBPexwltJWH4PWT+TqJpUKs1MCvf00xKxl8K97ZmcC9pcERL8lN21NQHJnGRDIIhtAeSSVcy5upPpg+9P1DU4RCsucnuZrre7HUXYsS18PpFnc/QLMqD4EIhs7ufr439f5DAA6tEKifeuVay7p8PHS1q3bFM4wulEGzVPCvktiY/roSi7lnsjiUlUGB3TbmiB/j66bisBJ1rBaW/t3F4QiHx5Q93cIPlkQ4qQHS3ij/Gk67bou0E41ZEf6Vxir3ebgzcihtzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ArA+rXMm45So3a2daOKp/TJ7aYx9NeskjHjbh6BJjVLHuqqITrkgyw64+9VJ5kEuLrvN06Q5QLGplybPPbby1KNi++sjkg06Bh4zdT5KyvW14nyoQbf2z1GmsgMw6Uzx/UWEUgaKsim3tZ3QHyxhS11QY1aJQzYDtfuBY2R7viPpFS3vGSYTqpiYrQcdswH8f7PWxuTAdJ4CX8UQWASG2G8zA+FCv5tlaDhZGaHUmpVxbQxT5oVE8pAREXjsPhpV2F6wD6W5oM5hWOkVK9fzelPwkSUHbM5XaCxAwZBZyC91VOneR6XY23vrwXQxQAr/lqGNpDz7NQOHfKcLzYP+5RoeXJxHXC1W81BWhueY3TRhOcVhtPfcei4SV4qRHELsyp4nIe99unlB1cc9AtLRj7gNWBb9ojTO5KGsF200GDcuvbHmmdo/C+oFq+xAA2Jt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:24.3069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab472f0a-b431-4e3c-590a-08dedc3e5746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 72ca7302bbfbc..ee5229ae3d75e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -86,7 +86,7 @@ static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v11_0_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -97,12 +97,15 @@ static u64 mes_v11_0_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v11_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v11_0_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -294,7 +297,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
 		return MES_QUEUE_TYPE_SDMA;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
@@ -1544,7 +1547,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		WARN(1, "Invalid MES pipe %d\n", pipe);
 
 	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
@@ -1627,7 +1630,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		return -EINVAL;
 
 	if (ring->mqd_obj)
 		return 0;
-- 
2.55.0

