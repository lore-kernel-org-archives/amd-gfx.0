Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A46E91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6855610E284;
	Thu,  5 Feb 2026 06:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZPJdElS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E2E10E284
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7N2DsJIVMGyfkSswioD7x3xv0kKuOiXAHxXi8wcACjsqUL0f5Sv2PHotr2SB6ooqWzihLEEsMSiGXnAelg6RAvig6+0AsZSstMUvLPXssKowzJbiSk/ro2ji65Gu5H+P2MkyZdXu4M0QMBYUX/IRAbYUBLM25pBsLfJCqsSGjwbqG/YCn+IadE/ObkQeshcYQEGDkDuuaF/4qq7PNbh8NLA6EfTC0/MISm+h151Qv07Hm2272rx7rPGgHfO1uo8ZyjqzFXoZJFhvd93xaHbExcXDpuH2MCGQ99jg//wDYqrLu4ZAl30eeWK/KbwZBQfgCbpTJLEYCaCXVQP3BuNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoNpignzHxd4VJaCqWUkvGPUknfweipibBEOTFtsWXE=;
 b=B3ndK6+7mmYAWlulfX7W9YXGBS+FRquJrtMMKmwx3ux1Nn6h68SAIWmxge5qUTUCwuXzuOOerVi0WgLZTUBCodrdmCrgB6+c2XaM1K54q8lpEfDuqf/RVl5LRIZp3NL27xfLf2mazUtu37BZJ8VBF0ggP8baTHweJGy85qwt/aOHCk3JqhTyfYDKC9W3TD0AXLirH4ufDJ0E+dQhpQfx7Im7z3CqHJp3zBqC65ekyViEvy33zYssu1wGaVAGddlXxPH0jNFLz13rlztBKBiqa/KSaPb81x7bPvBMDxiKSJ1fSFjyj8G/4gDFYKk1/8BV8sWp6tqMqXXAZBTcjeRPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoNpignzHxd4VJaCqWUkvGPUknfweipibBEOTFtsWXE=;
 b=5ZPJdElSUjX0efww4LGw8aNAJgvcf8PkhNJx45q2lzf0xotdzr+/4i2ZUDWXms+q8HIPJfuvYwtWk7IauM2O0SIX2lo2zhBl7XJl2ub3F49lU3iu+ZyV2HZ6pMm6RCE96PKQ9kUQYHJMbEeBPgdmD9at6hIdJOfriUi2Aze9AVM=
Received: from PH7P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::14)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:51:44 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::d6) by PH7P221CA0044.outlook.office365.com
 (2603:10b6:510:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:42 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 04/22] drm/amdkfd: add kgd control interface for ptl
Date: Thu, 5 Feb 2026 14:51:12 +0800
Message-ID: <20260205065130.654921-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 411ae8ef-a828-41d2-9573-08de64830663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NvcgtS9DPAAfcikm0JD6pXWsiScK1kXg0VZf/vgYFNO3R2lMFpStj9nmJNQM?=
 =?us-ascii?Q?aiTtKiTk7VP4bPlrpQiM4f6iuY20mB/d22igUV4uhtYQsFc3C7qcP7d5uFLd?=
 =?us-ascii?Q?zkmgkP2ERS0YZvsGRJqnhiJ81O4yttUd94mKocM5ss3DiFVWSiIy3rgyttd/?=
 =?us-ascii?Q?cWzbhHs8BfpTNunb+tgbzcWuILcxawazYnhqUv48u52CebQxQGzdJAw+eEon?=
 =?us-ascii?Q?aIpvsANJpa3UkEXbqK2STOwMJpig/OiIMlE9enla53wtNeKlBfZ3UGzJYUYP?=
 =?us-ascii?Q?dZnl7775G/LhcHtWZMRTqpROJ54XTcoClFBwPs9Eq2nzSyB/aBx+8hZ8duxA?=
 =?us-ascii?Q?/09eVzrF4pdbW9e2w7rv1tcn6ZR8FbC7iizV+xTardEcAk84ZAOeDInvdEcR?=
 =?us-ascii?Q?tLlB/6KcVXhKhAAJ6xZxuLL+1bMpjAEhafHFvT9e6GwWnGkV0WDIQ6gycGZm?=
 =?us-ascii?Q?6IDnEACjGFfceGcYOENnTqV32kftGH8u9jcNaZmuMfjBJ+oS8Mb++GkvCazv?=
 =?us-ascii?Q?3B0Nht8tcsM+hX5SmMLfTpgXY8Kr3oeURej8m9fI03vOYLKEewdfaqEE+EnU?=
 =?us-ascii?Q?NLMMDcn2/g9iJmkPSxo50lNQy+j+QOI4sXpj6Zw2FJS41Onow/dV8UaR5aaY?=
 =?us-ascii?Q?NSzmdPqyBGPLLxmBinWaC53eqgOCfCDbELHlg/pUcZj79hZ1/rpYqcDIgrBH?=
 =?us-ascii?Q?h379UP0tYvP3piiaM9SOU5qMOZ5niPsqQr/qmEr0tz9LB2M/RADSjFUBfWcF?=
 =?us-ascii?Q?dPWqqSgpX+KcFhXwd0f7K+v7Rcbxj2HuCL2wuM98xnfaytjoDxIyMS+LGN3p?=
 =?us-ascii?Q?QnebTTprDGZt2JkPZtfkhE3bKHnHWs10QWeTTVZBacN7oT1iPIveOAq9DYAk?=
 =?us-ascii?Q?BLOdwuSDLP+uOqLmOOUMr1ND5WiUosw3SkvOTcYmNMtZqDyz3GzjWjdmfnlJ?=
 =?us-ascii?Q?rcB4JHMeXTqqmw0v4OdTOLqICbhyNaojK9SmHjZHoTnHrsUryGHzONg+5syc?=
 =?us-ascii?Q?XtHKBQj7dQ/3vQfrLuYydL6gGzZGspo3pB2aYHp6SfhGRleBR2Mkn7DM3lPU?=
 =?us-ascii?Q?SzOV3hOhOqXGxsfsw6pqyC9bJ+U9tvSchyrD46JbIuX1sve6qFFWiDc/gHWM?=
 =?us-ascii?Q?dV/GUt10F4d3KB9K/GrK+uQkHC7/xo06u+R6mdMXxV0aPNh5Pru+If8Vaq5u?=
 =?us-ascii?Q?aczmYF3yIdNymahW7I6DbtZCDDubd70J2CjYPoBNYPIwq8FHWJXruUzfGuYR?=
 =?us-ascii?Q?TbbWVXbe4ONlmLcnnDifFpKhMze5lmFeayI6g2ZYWLIdNk43y2PZoBiVer7b?=
 =?us-ascii?Q?YVI5pk3x0b3GCH98yB4pihFY9BK/GHrGR7+3OgjyR/XOOMix8VYqbwK2mLn6?=
 =?us-ascii?Q?b6k0YDCcdybzXrhAAps+vHB/GcuzooufV1KSPDUehno8Qiqw0XP3yBa0txlF?=
 =?us-ascii?Q?g576/RTgv4lvyk4aCG3zkj/bHkmALj5A3KvVmW84jzE+rmkiTlLgjF3uZTok?=
 =?us-ascii?Q?uUO1oyGDNgsr9Twpc0Rpf3uAbW9rNCkRUfSoEkzNJXHStZ4u1TK68R3oHzEZ?=
 =?us-ascii?Q?B54itpFGITUqqFlpsKjcXpa8d6Yt3mzvCcRf3HvmTvcxXXA7XK+drpIQMvEG?=
 =?us-ascii?Q?4isIw/YzUlBFyF7tvkUeqNs8IpMVPx5sGMT7GvvT17WZPePsUo2rw3Rfcap4?=
 =?us-ascii?Q?iGfLDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HcajuTQWWiR+Bg+hfb5vC2nUAcW/DcpFDNQIV3M1wchHY7Y4V5w2AiQBZLn6oGLXnedo0RacT/wDoekSeJQGL96S3StqRtbS5Wi3HLYhXL/hp+Ap4u7kJ+knTx3YZb36XYvHvu/Eql9Rp9F2ESvxKzwD79RD2RSv2/4Xv3Qte16xGRxYU4Fw3C362QHI1mvA3TwDyWJ+ah0S7Xik0yyhl5A9qSw0nCtpsYzyByMgN2ZzyJq5Xa8mUhfa/PsZB+HmOgW2wTkgLRqWWXzZ8qeXDJaLQHUa4jieB5+AJ0JLR8U72Kl1hp7gIMy8PzUmr8zEDN5d7qacxUJzLXM3DH/02ntMOTeXRrAVEr8c9M9tT1l8Tr7GRCWOZbbco1qrxinujh4ZUDP6xno0pOShZjLpsq1n7VzY9wo9FqXyox86XxzVR+5qpxzo+iQm1NmgisZP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:44.3473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411ae8ef-a828-41d2-9573-08de64830663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547
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

Add kgd->ptl_ctrl() callback so KFD can query/enable/disable
PTL state through the PSP performance monitor interface.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 89a45a9218f3..f491fd2e4ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -520,6 +520,16 @@ static uint32_t kgd_gfx_v9_4_3_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 	return is_active ? doorbell_off >> 2 : 0;
 }
 
+static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
+				uint32_t cmd,
+				uint32_t *ptl_state,
+				enum amdgpu_ptl_fmt *fmt1,
+				enum amdgpu_ptl_fmt *fmt2)
+{
+	return psp_performance_monitor_hw(&adev->psp, cmd,
+			ptl_state, fmt1, fmt2);
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -555,5 +565,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell,
+	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 9aba8596faa7..295ce9364362 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -333,6 +333,11 @@ struct kfd2kgd_calls {
 			      uint32_t inst, unsigned int utimeout);
 	uint32_t (*hqd_sdma_get_doorbell)(struct amdgpu_device *adev,
 					  int engine, int queue);
+	uint32_t (*ptl_ctrl)(struct amdgpu_device *adev,
+			     uint32_t cmd,
+			     uint32_t *ptl_state,
+			     enum amdgpu_ptl_fmt *fmt1,
+			     enum amdgpu_ptl_fmt *fmt2);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.34.1

