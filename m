Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632A11123E8;
	Mon, 29 Apr 2024 15:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4usdC93u";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0795210E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrnoRwq+niCrPYYofTgLvPdGqcP+ytKyhcqlC70W3VsZ4DNZbXeJe7O5SvWrGcIHeTaA23iamojQTMD87IoZ6UUpOjuMV6Lc6W5PGC28Y4gUB6O4rIfk3g3ymTqufViaIDh62ynNB9R7olaO358aRoXG2KoFZ9VsA0XyIAxXOLtsIJq+fBFNRci2vrjlS8+SEeU50xsB6fwJkWYnNZOuURXzlIXmRmtzWcicOYvoI+Yw7BEDkkW3IWGSH13+9/mg5xeb+ycYq/32Zvk94FO3+zY4Jla711oLFU6ZLU6GoQr/2+NtlK0b3eAoxmdPQtJwhryHGB3lQiPL1ncJnNrPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUEL1YzV8a/sFpK4JM0WXEug+0JYTHp9lByfCn/62I0=;
 b=AhCe5ABDwbwshY6wdwJyEvFA4vNQ7c3ten4MaSAACItlJbVMKZcnRwUbLDpQgclh6eHVQHK7axivuBWCNk6Xs1JbpBZJytC5Zpl5k0X58pLhzXh8jXlF4oWJPm0jrFvoHEwhJM7aeO4BLl9BYDnB0HiaSYcOaJW//Unzo1J3YaLvSR+E91hG/FMR3ZwMXYg/OGTC15rYkDHo6MciUcB5Q9E0wYY2pfo6omjTCzc5Al2WJh2Hcj1ZNFORQAfi9vwnR3rXJ5Cvr5brtpY0Ejq4qsQbMAojxipAeSyhw8OeUffP2PqHNH+zoOz8UFfZNk32ivbeydUxkzKmuVz7LYbANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUEL1YzV8a/sFpK4JM0WXEug+0JYTHp9lByfCn/62I0=;
 b=4usdC93u+IhNyCYpsktQpTj/YWmUB2FIVxWlq6v/ohBpm+iy4Ol60L9sAq/etmGHtIJRBtk6kWAirAldiiSS6nf694tWBUDW/okaFw6Q7uXgF/yF8/P3rodOKuyDakG5ni9tP0u99SbRTNpwz3dDeJlP0gouNQJ03lmtCFtMZ/Y=
Received: from BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:38 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::38) by BL1PR13CA0198.outlook.office365.com
 (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/mes12: enable uni_mes fw on mes pipe0
Date: Mon, 29 Apr 2024 11:12:11 -0400
Message-ID: <20240429151219.3466531-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 9390f113-caf9-4afc-67b8-08dc685eceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y+lUuyTvHi/clzm6EsctbcFDBGO04SxW31UHi1qfOCN8G8wAq24h9QIXg+KI?=
 =?us-ascii?Q?rhEGjznfgjfCZj1e7y/U2A1RJOr3du6eZ6D6OmX5ZNKLsrBSV6TfOAE0YuVv?=
 =?us-ascii?Q?Zo/tt7VDw9myGs56OGtU1mw6s9bH2k2xGoH6rajFymIIC2Ccn3+S97bfctI7?=
 =?us-ascii?Q?vuTDvGQXw1myT7pXSmKJ1ZRk5LMc7A36fM5JGphTuWond6qiVPqbh6FBtxjO?=
 =?us-ascii?Q?3H3sqbMJnXphk99DeUXZ2T4G0cu8y5RPnTI1MYqOSiUTHb/5b1YYy6SsLTtb?=
 =?us-ascii?Q?+U0aYioq37vshpKiS/nIFnQ8R9rQqGmRSa5OIfn86/1mJeQQBwpVzgBcpUef?=
 =?us-ascii?Q?omDd5hnoLRDt67jv4EO5BvFF+lnhjNsC2koCdhFGK9zt4s23JbeU6yiL1jjA?=
 =?us-ascii?Q?0cEN0hul93DOnheC7gYCXzdqsnDX9UBXuVzDhI44RRnFYrTyN97YJsgRmcPq?=
 =?us-ascii?Q?G7qW2f0lucYz3c3syUqhTo4qE8weS6AptRMWRnrjR4VTM9ebPIC5bQTgdnPE?=
 =?us-ascii?Q?AmIu0ODj7NyMr77y8c5Vz+cLhoaPcaLQGOIRX3f/eWzLP2LnmZgK43aDVNDd?=
 =?us-ascii?Q?/S0zX5h2vL+Mul24se3qF0Hxp/6O2UGSHsKdxIodDzO9ze9YwICzEwcttBNI?=
 =?us-ascii?Q?QOa1kbFmj/O0c0Bar6G+ytleQJRobqZeESkoJi953RfkTnDm2gZf+irrBvxe?=
 =?us-ascii?Q?+4rZgPwtSopSys6uE6nxYv2aIQ+LTOOMxg4kZu89sfVQ4K7BOMUynnwAuGJR?=
 =?us-ascii?Q?wY/GJgh2SlCY9Wd6MX+C0cB7jR2HXvHkaKyx3ZnoJOSMc4Y5cdRGVMkpW4l+?=
 =?us-ascii?Q?fwc4FURnj1aTMRbvomrrTRXT87taOUuIxbyPJ9yigGzU6A83Y45XWXCoWYUC?=
 =?us-ascii?Q?UU2YpNgHkoX7aXzuNfg8cc+lTL3lFoj/k8nHYHxMndqoSRVtHM33GG2XEeue?=
 =?us-ascii?Q?N8mTY+qJKKUCHiEVjj+KrZIuKy/KYqDbZqcUvaHYLioCk+MxguOXNJ8F83Jp?=
 =?us-ascii?Q?h/oyzl/luzHdV373rRcUyQKLYfgXlyo93u95skXkLdSB6SuYDccYS3dVkI7W?=
 =?us-ascii?Q?CqMct45vjWpFU3aREefg5HCSb+s8IkCELxk5r7v7DxLPdAXM5f9D/cKShNQS?=
 =?us-ascii?Q?XcRFDkF2QG2TcMFlu7KGK30a61+PwVKUNVqL+RsN/93KfE3pT0Ug+zcf0VNf?=
 =?us-ascii?Q?AkMns0CuNoaVbCKWWEFHE9Km1GJFqVLWOkM0pnmxyU76uO+sIA+TY6C94aRC?=
 =?us-ascii?Q?0fQiYk+FHp16oU/bvi+EYwpgB3mZang1v79KdtaMinlr/W0WkPSLlXEXPHPW?=
 =?us-ascii?Q?pkEhognPeZMiHK1rtLpQUOcqyigaxFtS69E5SdqG4r8pB/R8FUx4BpKkTxW2?=
 =?us-ascii?Q?bEctDurl0IUhTE+TljuRFUjvs8Wm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:38.6019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9390f113-caf9-4afc-67b8-08dc685eceec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

From: Jack Xiao <Jack.Xiao@amd.com>

Enable the unified mes firmware on mes pipe0.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 51 +++++++++++++++++++-------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index e9c963ac452ac..b60ed178114e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -39,6 +39,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
 
+static int mes_v12_0_hw_init(void *handle);
 static int mes_v12_0_hw_fini(void *handle);
 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
@@ -586,13 +587,13 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	if (enable) {
 		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL,
-			     MES_PIPE1_RESET, adev->enable_mes_kiq ? 1 : 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET,
+		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 		mutex_lock(&adev->srbm_mutex);
 		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-			if (!adev->enable_mes_kiq &&
+			if ((!adev->enable_mes_kiq || adev->enable_uni_mes) &&
 			    pipe == AMDGPU_MES_KIQ_PIPE)
 				continue;
 
@@ -610,11 +611,13 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 		/* unhalt MES and activate pipe0 */
 		data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE,
-				     adev->enable_mes_kiq ? 1 : 0);
+		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 		if (amdgpu_emu_mode)
 			msleep(100);
+		else if (adev->enable_uni_mes)
+			udelay(500);
 		else
 			udelay(50);
 	} else {
@@ -625,7 +628,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 				     MES_INVALIDATE_ICACHE, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET,
-				     adev->enable_mes_kiq ? 1 : 0);
+		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_HALT, 1);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 	}
@@ -640,6 +643,10 @@ static void mes_v12_0_set_ucode_start_addr(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->srbm_mutex);
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if ((!adev->enable_mes_kiq || adev->enable_uni_mes) &&
+		    pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
+
 		/* me=3, queue=0 */
 		soc21_grbm_select(adev, 3, pipe, 0, 0);
 
@@ -966,9 +973,13 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 		return r;
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
-		r = mes_v12_0_kiq_enable_queue(adev);
-		if (r)
-			return r;
+		if (adev->enable_uni_mes) {
+			mes_v12_0_queue_init_register(ring);
+		} else {
+			r = mes_v12_0_kiq_enable_queue(adev);
+			if (r)
+				return r;
+		}
 	} else {
 		mes_v12_0_queue_init_register(ring);
 	}
@@ -1202,6 +1213,11 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 {
 	int r = 0;
 
+	mes_v12_0_kiq_setting(&adev->gfx.kiq[0].ring);
+
+	if (adev->enable_uni_mes)
+		return mes_v12_0_hw_init(adev);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 
 		r = mes_v12_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
@@ -1223,8 +1239,6 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 	mes_v12_0_enable(adev, true);
 
-	mes_v12_0_kiq_setting(&adev->gfx.kiq[0].ring);
-
 	r = mes_v12_0_queue_init(adev, AMDGPU_MES_KIQ_PIPE);
 	if (r)
 		goto failure;
@@ -1238,7 +1252,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (adev->mes.ring.sched.ready)
+	if (!adev->enable_uni_mes && adev->mes.ring.sched.ready)
 		mes_v12_0_kiq_dequeue_sched(adev);
 
 	if (!amdgpu_sriov_vf(adev))
@@ -1252,7 +1266,10 @@ static int mes_v12_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (!adev->enable_mes_kiq) {
+	if (adev->mes.ring.sched.ready)
+		return 0;
+
+	if (!adev->enable_mes_kiq || adev->enable_uni_mes) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v12_0_load_microcode(adev,
 					     AMDGPU_MES_SCHED_PIPE, true);
@@ -1260,6 +1277,13 @@ static int mes_v12_0_hw_init(void *handle)
 				DRM_ERROR("failed to MES fw, r=%d\n", r);
 				return r;
 			}
+
+			mes_v12_0_set_ucode_start_addr(adev);
+
+		} else if (adev->firmware.load_type ==
+			   AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+
+			mes_v12_0_set_ucode_start_addr(adev);
 		}
 
 		mes_v12_0_enable(adev, true);
@@ -1357,7 +1381,8 @@ static int mes_v12_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend)
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
+	    !adev->enable_uni_mes)
 		amdgpu_mes_self_test(adev);
 
 	return 0;
-- 
2.44.0

