Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09781F417E0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D5C310E50F;
	Mon,  9 Mar 2026 14:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCw5emW0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F68710E50D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGfq0j9AxC9aWJ9owj1Or+tapOQ38a1RxDo9GfUihdXC28wd0uIlLI3NSwjELu2UebFblTZ55WUOdCw189a8jlBWRhMv6iAChbDngEAGsaMGlA6Pklug9cB5aJlP0GBzWo3EY+uNX36zdIMWGd//bNr1dq22yHUWnfJWFWvEcr0Q1w8UuUMjZ526ClXZ0XmBlL+3z/L0XnNommZHgm+8OjwUy7DTbh4BN84+xkjp4CFAJIJ0tuqO9lQTX7PvGB383LpB1OKapId6b8YsszDXRyzZvsmn2UfqV6brjwZrUWZtHlvZ4MggugBDn02HjeLZ1s0U8oYhijuTNxt5p1s+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ8AqcVZy41GPEGQrKl86VMC/qto8zMgjYoRiaPtfj0=;
 b=ry7J4twfw2Ylt4A8Team84fXhNMMqWhJZxHJrDKNmQxKuMV263EDeCLrui9KgdYBhU8grqFGH3wC4xerT0Tm+CP5LUiAyY8C0VsBLTa/zz7wdxL6QGVErjgz4ZRtSe0RUbUQzvPL1CIzs8uJF4xy+7W7Zsr4w0/2ut/pQSzp47YelVYHSraY7+H/b/MG+TeRX+CJ8HzIjDjzvr9FlyCjNn43hfH/RWl7+8EiJIbJ820o2RhhOfOpSY28WBbX8UopwrHbTOBzoBRNBd3TBAFcxWLucYsJEWjOSvrtxEokCcL5IOHeoKOYSsXTTAN5iwMxkVcLn2Q8E1dpA0xBVuGmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ8AqcVZy41GPEGQrKl86VMC/qto8zMgjYoRiaPtfj0=;
 b=cCw5emW0bv+T/moIU8MU2vRV6wL4uhuPBXgsX5xYhFcWLrO2/T1mwPJaR0PBybhbQPZUhlYZsIQ3EKk1wKThMpz9SJ4yAtclQ0Z07etiDRDnyI0i2E9d59cblINmf4CT2XD8RqMFuke9uqLVSdxAA5wucHzGTVZ6e+0AXIwqRM0=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:26:39 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::f0) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:16 +0000
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
 Transport; Mon, 9 Mar 2026 09:26:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Revert setting up Retry based Thrashing on GFX
 12.1
Date: Mon, 9 Mar 2026 10:26:15 -0400
Message-ID: <20260309142621.2843831-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 85234fbd-05ae-456b-7c94-08de7de7e092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: olSOMQAYy7mtAcXESK8QgG9wKbS/E3aRT1cN7fcsDmiCnLPQ4oBolcpz4ebF8dsEgwGBlufTYh+4BZEd9YkTLUC/WPqfmUFInM8RMs1IKj7iMKNBBPchEMVsq57QLabFHjKXCtYnGAGaOvE11+iiOeGR6Yu4NyA/7hSfjzGfcAgMOOw+sFeYPdClhNHqLDrygDLvsaCI31/XpFFXoALScj4NPfStSla1MaRNW293q+8F48UxmaYyk0fbNX+WZSPSnfP7MpM8JWhRD7cvyK63eOA+S92MV/8koJcaMHMlUNxTJlzwQ55ULEdgCom7nuac7zAzEdny5EVeMrKz8wa9p5BLe6Du2T9mYuK7AJQcf7ayARuaAwCHkbsD1F7/0DYx63BFMtu0sxWVj24tESzSNUZYDevApI2keUBSGcB+tOCTBW9HwFkgsLfTGcf9sl3RogETHSd+SmbjGQNUGCWxWNxKbQhxFErJI9LNsl23e3+hR8wJ3u7seSL5JejXqexKYqyKTMPE/6nTW6WC/TuEw6yLIMkDScf5O9PkFlPwwKzE1edp+d7IhsNM19kCzG7HDJFe9hPsy2DBhf4wRtpeS2eoStRRSpYJE2YS9M/sQMH+sWjx7njMhHllSwCbjyqpW0xYLDW0QM9HWLXEK2y8d45ai/Cxy/Tp/IRA1cH2p39jF/JMaNvM7HxJ4iWpfk1n0UUDMYFIzpJSDOwHQD9h7+JlACMvA9dOuBAGAX+T3L9hqfDr19UMSvCglnrZtGwVMFG7ORRWbUQM2tpRWei2Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cXxPiJr6OFdsdcneV+PQsMsDcpL9GkJPvfhp95VOQ7cMZvtZ5Of6HMfKKxg6gehQiD71ycV5avpQyxPLJrYL2wtnqhYoL1O+camcbE+5ADQky6B2gPJsUCzRv1oSd7KtLyoN8GQkGp2usnxpj1ARJ3QdO9QrhsIKrvg203sZnXOLyFmdre1SikUkl60aaxDPjzEGKausQ2bFtHcB5ok18C515zBGN6PXjxqC/jOLYpKyEokrHeEKULv4J5z1e96pVSbinHn7bAAMUMueyxc8DLwwg1kHHqZpZ9IVWjOys2OgcPxjUaSAzuZhuFpEmNERWj2IvRocsjTL3uvy7l6TS3zqxAEdKUTaUFpx99aizooXDb1G0UqjKwDu12f1Fcnquws68czPWj2gsbPyw9NPnvFMhv8a3FfXP9nl4kn2sHVxTy/adJHo/UEVGYIPoUQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:39.1121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85234fbd-05ae-456b-7c94-08de7de7e092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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

From: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>

Bug found with retry based thrashing mechanism. Revert to the old
thrashing method.

Signed-off-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4e02b62cdbb33..6f2240f0ac524 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2631,24 +2631,6 @@ static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPG_PSP_DEBUG, data);
 }
 
-static void gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(struct amdgpu_device *adev,
-					 int xcc_id)
-{
-	uint32_t val;
-
-	/* Set the TCP UTCL0 register to enable atomics */
-	val = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-					regTCP_UTCL0_THRASHING_CTRL);
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL, THRASHING_EN, 0x2);
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-					RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x1);
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-					RETRY_FRAGMENT_THRESHOLD_DOWN_EN, 0x1);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id),
-					regTCP_UTCL0_THRASHING_CTRL, val);
-}
-
 static void gfx_v12_1_xcc_enable_atomics(struct amdgpu_device *adev,
 					 int xcc_id)
 {
@@ -2697,7 +2679,6 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++) {
 		gfx_v12_1_xcc_disable_burst(adev, i);
 		gfx_v12_1_xcc_enable_atomics(adev, i);
-		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
 		gfx_v12_1_xcc_disable_early_write_ack(adev, i);
 		gfx_v12_1_xcc_disable_tcp_spill_cache(adev, i);
 	}
-- 
2.53.0

