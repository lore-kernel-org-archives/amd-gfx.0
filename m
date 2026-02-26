Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0532CFC592F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 11:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D3F10E8DF;
	Thu, 26 Feb 2026 11:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fj+ROeKG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7468810E8DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 11:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm2ndk6cXCEl9kdEeYxeqp3vkEzExCBL7ZZCJqzkET4vIaK2JplQ+0mfNYhRE38uf1foNzirkVtlBh72b/wMd+Qf7bYl1YVwRttFH9A149kYzua4eCMJwbGgVuWK2R+zNDd94uFj5kI+z5TRGMzFbyGIsMzDef+8bTR3Zln4EjqVQp2pYMPVLWGaCBMv4WuGqtJtCYVpWoJp2XU+ljJdPg5RdzrnUq99PakOZRnywevBjEH/NQ+Y83rtXwmlRtEPlnL1gYFar+kzrBNZDv1FwfcBt6C87TqaQ4CiPovuRmGuaBP1lrVrkg7hMyZe9B8ke/2cag9FDnYd0qOCfs+Omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t+5anwIkhbHc8MYBddZG8o5XXpH7exJyoN+GdUZR4g=;
 b=EhVYOYZkLDQJO8ws/YQrbAl+EleRvXqobT7R1qe4d9i4T564ppvPNryehqVekjHkE3lme3trgZ4ZML60HdY5DA7MaRfe/2mrjZHq0nA7oxqoS49mTo0WEuvb/AM+tk3U8UrdFSDwQ2YAr/LNIAeeIiH32y6Aac1Zgt0tjMJQUsMVRVdRRtDWQIvy1Yx+gRK6m/OdjyczSWmXdipadVPBjA6b4UfCN3iCMqsbtVWLTky3Idw5AzyoB18Cm+JuzG5iljEdbou0e9KQubKs1xVn94CxarXLrZWqP+skOZOaZHT0wVXe73K5UxkzpMD13IiTeLynqhOTnHsWSbrtYOGCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t+5anwIkhbHc8MYBddZG8o5XXpH7exJyoN+GdUZR4g=;
 b=fj+ROeKGZyB8y3xHAXdEWMLUARw7oyOo+nzVMNPfwXyAgsoxqHJvuHOlH8gCj1vWRvDh2ZGF4fgBcl2VGmdAKHTbI+dMOy7AZ+izTxSOb4UKbAm9I9LmxK6vh7DFSQVDhtUYwz8fbV/ei3oA9DcsaOOXj/wg5HqvWAksTe8AEDY=
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Thu, 26 Feb
 2026 11:50:18 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::2a) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.8 via Frontend Transport; Thu,
 26 Feb 2026 11:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 11:50:17 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 05:50:15 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix static assertion failure issue
Date: Thu, 26 Feb 2026 19:49:44 +0800
Message-ID: <20260226114944.610238-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7e84eb-5fa8-431e-c8b9-08de752d3624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: 95aNMUWAYqFzXWuw1e+iB+4v6jMVFh27jD3dY6VshOypNAEX5o2FsGcfi0VQmL4i1iNwQXMcQ4YzgtidIClwvt9/CgCX6fiGNlTD4HlaJXodXirT/YSTmHdgiQirrcwCLdkSEP6Q2YrnOsJk6d2cPAySRo90ILAF0M5m/Vlm3MSGwwMIX7shYikpgdsdIHUN3LbbBYrFfyuzLtXR11nklzzUE7lnetMV3Yh95zMbhXfzWy43Nqb0sRbtgCuotsn/Teuy3R41/QDuDM0rJpWei/8Ag7+PG/r2qrzPhqu6lKtneldjml2inMcvAjqo4SI5Dbi5kR0lJFu1WjnVziVNTeA0rzzpdPzQqDeW5VGpIOaLXJVTUztqdTCwGu8wibUv6vI74vkXpSPi07aaFjHpVpeFfvlkuOIaCIOxY2S+3jArJS1Eoy5GdH11rlysobdfm0+cxchO2FkGfjYrYSbTs+da7VqGBhvavtiM30mWxAwV3VpWW/iAyP9W3WyxzwqBFoJsUnICSvcxMfIf7jMLJgkcJDLqhrC3rd58Le1BdJkYrrS0P781+BnYrlbtXuSLWLFkKUoJC+nhIRYfHcX8XEGLsDryDa8aTozZtQwn6MSm5zNEBI0k72pTjxPfuiJqEhHH996N8oroLiDbWQ9SXvCQQIDrZexfgQqrbtclR1FKzvgBTUcN05ru+h48ZK/g0iYjx6FGkr1FwGW33bRPpVuxfVYdfcd9d/ElrodMT9/dxv1mrLxZC6Ymvry6Gy0ioVnBy6TuNGxYtSAa23qPPbCoSoygTgyNmc8IN9zEN5Gdi9tpITA3hV6ouqhsvxd3Fp6fcbxoyB5pVgTvyxsdiWpzGSLO4BJUce2X5l+zuvw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /OKLPEZvpeURT0XihyDG5AayAE40eZSNEaTp5jZu19JWufJNVddV3poABxylegWxlSoDuufU4Z5eEH5/vMjExScJgDI0V1HR19TUzKL++IFduyhy+L3cgldqr7b23OCAjmPCXmKAEqBfDXAUB7iZp0Z2CuiEBHorKEKvhQj8bAXOwTS/3ZZkHbhbg1I+cBe4PFWi+kxT84ADJx5pr/VKhRT4ISjadI9loQVHglFDDT9jtQQ1DrPj/sWjZpjta6G2T8hl76CoEgLP1g6T2NaxkgC+eqnnBCDQKl1lge1DK/QDm5U+ZHt6zOWDZ5EcGypLyOTW4K2g4x00kOMj465s26KfpWaoxfHBZdviNTB4VKGfXpObHplgt6IK8fcQv/dOLS4FXbexLkAQvnUpiw17cD2QMDRFqVMTqa0LusJgcgce9adD6+BjcWl4WUvMXa1k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:50:17.4236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7e84eb-5fa8-431e-c8b9-08de752d3624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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

Since the PAGE_SIZE is 8KB on sparc64, the size of
structure amdsriov_ras_telemetry will exceed 64KB,
so use absolute value to fix the buffer size.

Fixes the issue:
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:2: error: static
 assertion failed due to requirement 'sizeof(struct
 amdsriov_ras_telemetry) <= 64 << 10': amdsriov_ras_telemetry must be 64 KB
 |  sizeof(struct amdsriov_ras_telemetry) <=
	AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:40: note:
	expression evaluates to '115616 <= 65536'
 |   sizeof(struct amdsriov_ras_telemetry) <=
	AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,

Fixes: cb48a6b2b61d ("drm/amd/ras: use dedicated memory as vf ras command buffer")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602261700.rVOLIw4l-lkp@intel.com/

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h           | 5 +++--
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 4870c03627df..a841f342a3eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -476,9 +476,10 @@ union amd_sriov_ras_host_push {
 	struct amd_sriov_ras_chk_criti chk_criti;
 };
 
-#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (PAGE_SIZE * 13)
+#define AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE 4096
+#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (4096 * 13)
 struct amd_sriov_uniras_shared_mem {
-	uint8_t blocks_ecc_buf[PAGE_SIZE];
+	uint8_t blocks_ecc_buf[AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE];
 	uint8_t cmd_buf[AMD_SRIOV_UNIRAS_CMD_MAX_SIZE];
 };
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 3e8b500caec1..81553230dca4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -63,7 +63,7 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 				ras_telemetry_offset);
 
 	if (cmd == RAS_CMD__GET_ALL_BLOCK_ECC_STATUS) {
-		if (mem_size > PAGE_SIZE)
+		if (mem_size > AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE)
 			return -ENOMEM;
 
 		shared_mem->cpu_addr = ras_telemetry_cpu->uniras_shared_mem.blocks_ecc_buf;
@@ -504,7 +504,7 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
 	memset(blks_ecc, 0, sizeof(*blks_ecc));
 	if (amdgpu_virt_ras_get_cmd_shared_mem(ras_mgr->ras_core,
 			RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-			PAGE_SIZE, &blks_ecc->shared_mem))
+			AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE, &blks_ecc->shared_mem))
 		return -ENOMEM;
 
 	return 0;
-- 
2.43.0

