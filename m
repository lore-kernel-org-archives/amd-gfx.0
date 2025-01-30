Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B0C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D84710E91A;
	Thu, 30 Jan 2025 09:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bF5x5I9s";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84F410E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb0kzUzSTt6tp0s0Y2o2APMFUH3iGY/9IxDlddI8PbHOJub/yA4RAh9+7zt1galc8BEStM2S8Wln4vmTsvxBEoNdGl3JaTpcdTMrFf5xGfzdecdETShpfZqzpZ4g+pzKFzwQIEYxc2xFtf5eNmFU6hQO8pDM/WsClFlCxW4jOzwUCm71WZjRKz6Uqp+s8cmivx6+5a1u/+c9qt4f+dFCiZmGpDnQVhD/WYaif2e94+qGf3umXgAb4awtuYn7slNJmBPr4uRPJJcfN899Oq/2Yuyo75wsatyf1nQRIqtRzl0RLs2tvySroiSkOBXu7IdKHI4NTW5g5yYbIKLuapz3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmxiDeYJOq7JdYJcshEw6iqpEhCza4iSkfzc4lUC/X4=;
 b=SXQKxcSWb0OgATo+/qbgTTAMu3ToZs0aKplkmHbYp/Xsb0TrzRia1F82LZo/MH+A75bxYtuxSZ8l4Ofk/HWqu1HI0XyLIrbQRhGrX9KfXgxiE1Ab7r06Qth2UcAOI/j5h5flXL2rkS3n7uvhxVxcZGJeskyIHUphZOIY8I3Z2pN1J5UNa+ZYcDKJxrmZB5mdP+7JHpAHmFepe0rb4jfoBmq7Au+aNGEDTyJMXlkHLa9kmUpEj1hJQgvB9+vqRXTYUMSwC6/C8GKPfTfeSD9Aq3wi6PdIUvSH+vV4mUmmsi5y31/g0FFpbwyh1vpFn20LbWZMwnZhA9S3oXej5VDWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmxiDeYJOq7JdYJcshEw6iqpEhCza4iSkfzc4lUC/X4=;
 b=bF5x5I9sH2AzQe+yjBTnzfR8fqlmFuMw6XgXmd+yIccARRCmUiCLiNa+wYV1Yi/NOGicyF8GaIEwWPOjrVSrGZunE3OMoKNvlJPq7RvUEEIIjvWCMPluWfv7zAGGI2APaVO5dRJEi22U7zNa2XzH7Xv3QCjDUIwOYR9QzpDTyS0=
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:52:57 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::96) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:52:56 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:52:54 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 05/10] drm/amdgpu: Enable devcoredump for JPEG4_0_0
Date: Thu, 30 Jan 2025 15:21:08 +0530
Message-ID: <20250130095113.534630-6-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: ed211580-57f6-4ff6-6195-08dd4113dfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW9zSW9kemhQRUF6eTNLRDFjOSt4NmZCOWZ5eDhyTm9QOHA1bTc3UWtEUTZp?=
 =?utf-8?B?ZzhrS3RlRTBkVkE2NzBQd0J4dFpPaW9MVVJLdG54RFBzMDZNdG1iVisyU0Vt?=
 =?utf-8?B?M1NUVFZ1NmM2djRKN0NLSXpaZEc2SzdBQVgybGF4NjE5dDdCTHFJZHV4NDlM?=
 =?utf-8?B?V2gzWXEyL3dzVjNPWEtzdW5DeFJFQlFGL0FXT1UweEh0Ui8zaXhPSkROODNE?=
 =?utf-8?B?WVlxdHR0aXZNbURpTWpub2wvWlhBWjZ6ZHQ3MjBjWFZoYzZMU0lldzlERFBs?=
 =?utf-8?B?UUtzZzZ1NXJxVHloVnpxcHkzQm9iN05NczRqbjkxR0M0RUEyS3hzdU40cHZk?=
 =?utf-8?B?emNCRVpEb2hsbWpIMGxQV0FZRk81YnhpM2c3TE9mMHN6d3U3NzQrRE9RSmov?=
 =?utf-8?B?TWkraEE1WG04NklNNk5vY1krVVlIYTB2YmxPazJlMEt4TXVMSndIYmFJR0pq?=
 =?utf-8?B?Sjk4d2g0RU1pdW0zeWNsdWtZd3MrRUQwclp0VFlsNGhDaFJ2V3duNjFSaGR5?=
 =?utf-8?B?cURVNTRnMjhHOW9jQmlUNWdTUHVjTEF1Mmd5Wmw0Rlk3ZTZSQ3ozVEpUSGE5?=
 =?utf-8?B?KzFqOTJlRHNBZnp6NWNaWUhGQVZwWGNWc2l4TXNYQyttazhrT1ZPUnBuY0xB?=
 =?utf-8?B?MVNzWTd3WGxGcG1yUGtHOUp6UGlSbnloNGRBOTl2TVczUzAyRFYwZXZUa0FY?=
 =?utf-8?B?Y2JjMXJ6anRQa2VqOGRaYXUxUUV1VTg0RysyUFVQZ1hMdDhYNC9CcUQvUUZ4?=
 =?utf-8?B?S29RQ0hqY0lkc2kxOERZTE1yRzczZU9HbnZLKy9sb2QrT0NrdmtoTlBpNllm?=
 =?utf-8?B?elFSN0paMnNqVHFnUWZGdU1xTWpQY3ZVbTB4NHJSSmRNU0E1ODU1cVVFWTlX?=
 =?utf-8?B?cWNxTmIzdzNoUHptM29PMlBTU0xycHZwOFIrblVsRnJxQUVuNDczYm9WZWhI?=
 =?utf-8?B?TkdWcHR5TnhSVm1wWldmVGtNWnhnNXpiNzlmZFVqdlAvRlRPclpZbzVWQnlZ?=
 =?utf-8?B?V3NtVmEyS29KdjdvUTBZUGt5QUVQSlRuMEJpcGhrV1NUVy9TenZUVE9TNnNY?=
 =?utf-8?B?TENHVGJEVThhbHBJS1BvL2I4Um5sZ2p0TUhNbGU2RHpmKzVoRTZSVWpIK3pV?=
 =?utf-8?B?MTVFaVJ3WldDR0RWOGVYMXhUZVV0NjNQRjYyNzZSUDZra1JhYmtlUlpidFEw?=
 =?utf-8?B?WkRkcEI2bXNFaldVZDcxb3VFU1AxRFZVUmJiTE40aDNkdlZNTFFBK2Q5V3cz?=
 =?utf-8?B?V0dobm5aNnFUa1BIZkNlZlJaWHR3bUcra2RBcVpOOFBEYmRVVFpKb1k0RjFr?=
 =?utf-8?B?MDVadCtIMG9KYStWK3liT3A1V2hJWlpsZFI3WDlRMVkxTjZQN2xla2szR0Yv?=
 =?utf-8?B?V2hKN2VMNzRFamdOdjRYMzdzMzhrbWE3SEVjalZGaXZoOUFjbWZsUVkvZFZ1?=
 =?utf-8?B?TEdJMmplSHMySzFYemhsdWxPOENEVlB6WlJ4M0hoTndhMC9iOUxybm9ZQ01I?=
 =?utf-8?B?U05NUW9SRkFTOTkrOXBvekxSSVEwN2VEbHlIczdEK2N6cm1OUlpiMWJhZ0to?=
 =?utf-8?B?dGRnN1AwKzlLcGdZQ1puQWN6RWZoZ0NnSEczOThUbGZBc283RDc4dExiWmFO?=
 =?utf-8?B?WEs0K1FuaGdtNU9kN0RjUFhvTGdXaXlSWC8vRzBGUVRWWE9CN3YvMkNRVEYw?=
 =?utf-8?B?US93WTlOa3IrM3FxanpERUZBTHQxUjFKbTVjaGk5cjZzdTRVd1A5c3pPcEFM?=
 =?utf-8?B?d1ZiOHBqQW5QZkkyQ0R6Nk5SZkd1TlYwL2VMM1JZS1FDakIvMXFqR0F2S0JY?=
 =?utf-8?B?aVVYQm9XYytJMUg0WHZzU2xDVDBYcStxbVhRajZjSWpKZG50Z3liZmlFZnJq?=
 =?utf-8?B?WGkwc1lEeTJxSnVUblhhaXo0eVVRT3RVUFZLUDJQYXkyNFAydGNUbnd2M2V3?=
 =?utf-8?B?K2NtWE90cXZjYnNPcWJVZG8yYjdUNzVsYVh1M0dJU2FzM3Z1Ty8zY0RVL0hy?=
 =?utf-8?Q?94Uy9webLjX/EIsE4v09k9rAFdo9Aw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:52:56.8724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed211580-57f6-4ff6-6195-08dd4113dfb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

Add register list and enable devcoredump for JPEG4_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0aef1f64afd0..b0666090f52c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -36,13 +36,28 @@
 
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+};
+
 static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
-
 static void jpeg_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -123,6 +138,11 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_jpeg_ras_sw_init(adev);
 	if (r)
 		return r;
+
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0, ARRAY_SIZE(jpeg_reg_list_4_0));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -717,6 +737,8 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
-- 
2.25.1

