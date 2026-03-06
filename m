Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CCFFCB61B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F60410ED5E;
	Fri,  6 Mar 2026 15:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QlBpOx+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D2F10ED61
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIC8tvx7gFg0aCcS5lSvsfvuI1AfyTXO9TSdXKlGOi2+wcSzTjgM7lrDS/qAeYlPOj4W4Scg4gF8E/hjfNZOv1Q3wipvsgnRL88S07OG+gvOah0s4tN8uE7eVCMFRh5MhCFBA2K+19nEyqIn2pJ/udrtZ3gCpIDleuaCrYo5PneCjt/qZHj4b+GL/ytQ22Ay9XwCLWRDhhP8QVaD0aEL2VmmkfYAwMcvCF+psDmCctbg+QQXcNxs2yIfc1PWlWSw10k5cYhDoTrIzG/GpLdRTrooIXOZKEd3vG7Y3OzFGO3553zzQ5OMvlZoZfSpgwaknQAOguE1+DxRr4f+XXQSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXi/Z5U/SbBONKBzRfa0JSDWd4vlnrXn9ymmJP2fy/A=;
 b=ivfKPsBbxO1I/q0OGtpea2KCI6d72K85AA9apEvvBoG5TeNVoK9leg0RQphuZ0CVSVXnZMPRySCMgIIPJar1fO5FHqw13kiv3Lx+mYaAgOCLp+2WVoiHpWIuFjDXZ978hhKty1Towx0yio0fSsmRuLTJAnz9wMRr97zQPdL02x4Gu8lPoHfOPZZkotYHcUOahBq3ivHuZIGH7kd+c8ymxrMhC8lbhpAbr/1Loxrn3Rvmt8cTciE1OzjJhhLTniiXVPajXI5dTB+WncWjf+e3P+OJ5SNzqeMKmYKlGCET2DA18SMk9pUKlRXsPwuYXHRawaG8v0Vgd0w8ge4otLvxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXi/Z5U/SbBONKBzRfa0JSDWd4vlnrXn9ymmJP2fy/A=;
 b=3QlBpOx+z+LNAA6UbKkVrBV7kTlExTiTL9x5tCoov49gy43wniDt1IW1xOnF6I0yC1ECWswmgmFrPInvpPIZRxnA733bkX3FOAJB4m5a/lHvJJKEveTZrfaEi0T5XCOECyWSG41d1Ahmz0e0en5l+ZBydExI9TPKTZx8JbIspaU=
Received: from BN9PR03CA0881.namprd03.prod.outlook.com (2603:10b6:408:13c::16)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:21 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::bf) by BN9PR03CA0881.outlook.office365.com
 (2603:10b6:408:13c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 15:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:20 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: use common defines for GMC 12.1 HUB faults
Date: Fri, 6 Mar 2026 10:40:02 -0500
Message-ID: <20260306154012.22525-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 859f4660-6317-4fc1-28e0-08de7b96ad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: 2s/7vZ3GR7Rr9xe0K4diE7AZTjcZM5XOC4AEenOrCwGOE7xmU2ZkMfUjgZyMUENQmiLA5zip/TDTAUTYuCTaj+azbvu/jUO5gC+MJHigx5A5T88rxtGAazJMEqYt9A4jevOZUCZHYohnXezmfxRGOYR1lgo8/bNoX0esSST/MctGhEsQOhh23W0VuF/9KC+SR+a9Jfj34S/G1Sw4UXYcQMSyhjmm8QW6AokVHzy3jlWJOct0OkNTFFMaF5dr7bChqqYWtAlc46XVLIuk8hNC563Wwh3Muv4MpPlnblBJRboHaAED645CI7WvFtlGaG6pUmg7Ia3HTJ7Ko1XpCPJTYBWFS3ybFJSCoY6g/we/yjmPV8L8f7v8M3C4Vu9ycHqtnCW88MjA3NBUxmgnwcvK4GVQUgUoqC52vUbiXt7G3vdGm7RSi7bwHcs8kpWcbNfsIzlmlbKVrXrTyUz41a9JjxvIkA+i5Bi2PGquyqgbg3WSOIlf1sw1Gy9L+7U8uRFkX7xJTUy7AdPlrNWavgX7f2yLvIJmmFgLDij4KkrbzC8DsdV8g2w+M53L4Y+VghJdmidXpNwU0gtfQQF8NLpJf1Z4q5+GPIV420U7pl8Juug31t9oCfkbUF47pvDgZemefK8y6gCm54zIAHeOd+OvB0gi9gmHT8qnIEozrfKyQjfUyNURdo9QGg787QFH1D4Xs93qrknkCrmPSlmGnzHgmLJD90Vhm3pcWA+2LoxWICvmKqLvdjrQov97OrXrAtZNAm+khkxUsYp1I8NSCj8Nxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pP4KXBcWv0xe7h1qRzNN/aRN7KNJRS3BN82cXjoNunu2j4+adIQJ2FCiVEALg5nyg8beNaQUOCg2SW8DRaooIlc+ooxJ4N63K7Eu8dyrg4rMjhA1uxOETWXBolNInpAmRBP7M+ka0EwTR03K8Hg8Ypx1UAiyNlbDHRpYyQvS/hTONnmy806SMXYeCItHOGpH3459kiAcqlf0ZYlL0yTCKIah8DnO7gMYRcMITUhmIPDwRTcFx0KALKJ7/uCh9sfYED1b+/C8ChaUNWCltwI9TZIapvZSbxf3lgRX/PLUMlul4Z3j7b9gqeRYhnMO1EVg52zo87Q7GdIkWGwjJGMdSlYvFKAYcj4zLQOkaHSmG+Mctz6uefEqRmx/i24w/OcyD3BKN6/+V1oVuMHJtS6q4hP1x259TlAZnbyaMbZuCe1bj9HWaMDRNiHpAqTQg7NT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:21.5458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859f4660-6317-4fc1-28e0-08de7b96ad4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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

Use proper definitions rather than a number.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0e8a52d965738..b9fdc3276e816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -94,6 +94,10 @@ enum amdgpu_memory_partition {
 #define AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE 0x20
 #define AMDGPU_GMC9_FAULT_SOURCE_DATA_EXE   0x10
 
+#define AMDGPU_GMC121_FAULT_SOURCE_DATA_READ  0x400000
+#define AMDGPU_GMC121_FAULT_SOURCE_DATA_WRITE 0x200000
+#define AMDGPU_GMC121_FAULT_SOURCE_DATA_EXE   0x100000
+
 /*
  * GMC page fault information
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index dc8865c5879c8..c49112d8300e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -121,7 +121,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 
 	if (entry->src_id == UTCL2_1_0__SRCID__RETRY) {
 		retry_fault = true;
-		write_fault = !!(entry->src_data[1] & 0x200000);
+		write_fault = !!(entry->src_data[1] & AMDGPU_GMC121_FAULT_SOURCE_DATA_WRITE);
 	}
 
 	if (entry->client_id == SOC_V1_0_IH_CLIENTID_VMC) {
-- 
2.53.0

