Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF91C624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7B410EA85;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAkoTdLE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45AD10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/NnO/qG5+NT/ucnBVEQ96/6E7jpHdVoBNsOepbfY0j2vkA7GyqvEerc/978Z0Utezu6msq9P/sBDX7nyNIoyZNfHX9YSAFiyfGTmC7tdyIHX0UeGQkFddlDz5M3og0RkhkSZJv6rGgiG5C5naDdMhnK5NfywsKwEalLNBTqHASVZUT3rFSZaJN+3z4Qc/FFC6gCEL5Ev4I9YuEnHQtK9oZSvgw0Q3/tnNr0+//5tR1bgYeLudihrKMVgIsx5N7B3KxpGySQ3Ouh2GHXsDJOKarq8wtmL+1wElb7S9LNR1qp81/6YuqtJSPPcM5njw7XNjBeETvsmg5JE52BjNXGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq/VbINKXumC8uoxIZLEy4QfsZFyjrD8YM8N3Fzk/SU=;
 b=uhbROAWFne90IDXfKgf6iAkSnQrnWxON2M+Cw9pfFMyvS1LoKCMFx5yrV5AC4SFGjy5KCSxD6lJvTLYfjOG8qDRYaC++t/JZUIQbvj0AslknlW5nxewPYucoN2I7GvDbrxEypfbWE9C0Kxk8UxoUJGIwo+RMuvk0wslruzGvLebJeKNOWIYrcYoXezFU+RYs0fm/sCLxpc1SZsUUsjXrliMrQfYkv3RdSTT4DGfrTa3MVU/87TH3MPs+SKaILjDzLI4Y4a2UX/HzYzC77jWEECIQGcWK6fmaDvQDVGsC6d2qphC27FFSDZj7IgIlhGXmDh0agdp2KqLBgtEhIbEkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq/VbINKXumC8uoxIZLEy4QfsZFyjrD8YM8N3Fzk/SU=;
 b=iAkoTdLEr3fp3xPvp6BWqi2v+oLWDSga06HCNnMvM/enwFxskCz3VwU+KfhdpGgOUarZeundFDrMlWx9lY+HWlSE95/E7BV7NAjKlsfnWmgWf/9djPiMEjZy7UUyBLWfsER2b0YO37WRWEIU5Hb3EesVlKIPdImTtAlE2R+EVBk=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:41 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::2f) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/95] drm/amdgpu: Use reserved VMID for NPA VM
Date: Mon, 31 Aug 2026 14:26:47 -0400
Message-ID: <20260831182754.1089811-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca08fb0-f198-40d7-a18b-08df078dae71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tWMjfCFgVWnCdjOi+G/syUiKGi2csUfOQlyCzFGW0Qeg6F1rJQ67ViXSWPC8geGUmgnQkO3KaP6MJf1dy6xyFJCoWoMePWFpZ4OvxdGOEBYwEkgKH3zTsQ8q9NMC6Uc1YgsBVPbFIWkLaXiaXM62qYHg6eF3+N9G4uyD9J2AGlOMbFY31r6SVNP3RJPyzolN94gjj0+zPT98sCvPP62PjVy3XKg4ghaJDNcKoICl7V7VU1GBJgySiOdXBVlL3wVgqsnFWiQRb0dKNVEKfPwv1ARkkNg+QtRRu3HCI+mI+HMdX4dmTsGvfyEBLdPoKEsHq3kDjEWk4/fYD6ioF8fArAtZOvcy161e+Vbf7zjaBNRttFP1YJZe1vMquO+7O/boAw9HZtlZUyqfRuZqAbhbTcYUfEufIp/taA7qPN9EltBO3TxpGTFybt2Wl+297lX81i1mtZn0UBXI889yE879RrglkaphrdLgh05mDZCsFwcIl5P7KyXtK3e1iaqrMGngu+ivLBt50tKbhqJua4gR5KB7xW/h7AK1tDKU0lCHdeHJ+g5m8JUhRJ/6TKHRqfJ3sJxolDJApF9Nb27mSjj8huO5ODH4kOs5l+6Bbr2Af1oNXdJmKcl1pwsr79EyUmw2JFvVN4J2j6wg3zKcMRnwzBOSFBDOBxMPun5inI2QOuD/sxFU8Yu2D/Ae/ftX4KYCP9tEpKlFIi00VlMgJZFlkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yHg0GRu//hH//AOPZ2ZuzZQBDx2IQNcjJvFaBaeHqeZKcQMO3/sKDb14DEBBqgENl86N9HnHz65C7BjnuciwQkysmkhPmLrNIuUUpVMs+siZtVe0vs0HViks5oerXb3zfhQNRNx9q7Dj10/uITiFaTz6EDK7cpXSLwJlHSZtc3GiPQWisnLPJ6Bybjgdh4T53bSHrHgBeUH0V7prFVeOaHuj0KAJubSQBqB4vspv5gxLStxkYpU+ZiqdvoLqhVMh9mWNYsA9cuD9nfz4ZjYtqgEXLlfVKLWlMP+J6F7S6kfhG0nVpMeM38e5mwZPJshpcHunjXGjNiRXLCiG2llTX7NkAsrtNt+EdxRrAAuvv12UdYzKna1Qd4c2dTtMiwlWW8UbWMxmkZyZAFpf/uR9qgOSsP4t4Ar2dpqOWyVDMCN/eFITkpHllzhLBZKkAxSH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:40.7947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca08fb0-f198-40d7-a18b-08df078dae71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

From: Mukul Joshi <mukul.joshi@amd.com>

Map NPA VM to use the reserved VMID.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9d550c21f69aa..89ba7cef02e81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -677,9 +677,9 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	/* Enable incoming NPA address translation with VMID15 */
+	/* Enable incoming NPA address translation with NPA VMID */
 	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
-				   15, true);
+				   adev->vm_manager.npa_vmid, true);
 	if (!r)
 		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
@@ -689,9 +689,9 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	/* Disable incoming NPA address translation with VMID15 */
+	/* Disable incoming NPA address translation with NPA VMID */
 	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
-			       15, false);
+			       adev->vm_manager.npa_vmid, false);
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 }
@@ -1172,6 +1172,10 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 		goto uninit_vm;
 	}
 
+	/* Map this VM to NPA VMID */
+	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
+			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
+
 	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
 	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
 	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
@@ -1198,6 +1202,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
+	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid, 0);
 	amdgpu_ualink_npa_mm_fini(adev);
 
 	xa_destroy(&adev->ualink.exp_xa);
-- 
2.55.0

