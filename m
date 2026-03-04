Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E6EFCE37
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 20:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BDC10EA99;
	Wed,  4 Mar 2026 20:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pd70enPl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E30710E1A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 20:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqMLsuLgEzdPtccVfDa6L2JiC1bc9KW1x6CQE5LLOneuDrLGo4ptRfq73UFZMJCWAKqx7kjsdg52/ko2im+UYKBbyQtr0W9yALCVarNjsMVcTZRo3Ql0PApPjrTvhe/7RgVX3MJUQLpnFuGF3kW+MIBF2Wv94ayKrFnIAEKXCMMoySQvvMmSuptgldx44LMBxc/l4SBYWhZHSROld3K6t7zH9RrLRBr9KjtsWV+t0mkcZixOC/gQ8gE0Atu+530nK0P+nDJak1aNUy/wtF77gSeK/mNs5vcL8jc7r6SewNcc9CmSGBjESzAyDDZuorQYTEnetcA2VGeYdgZSlQlIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reqZN7D8Eys/h0V5inMnUWkR/4Q1hEJ47ocOt267PTQ=;
 b=vjnuwvRDmiz4PUf63+N96gFHvHoYvlss9/MxJZ39dSRyB1r0RRIP0daP4/VHKLb6xYofGdeOLx8AhmK32QtWCvF1sivOtJGACJ18l5eHMeGg+7FtQwNnF9zXunaQQZ66JffZUbkh8+YSKRKFL8JRAYpijsRfUw0CPtYPU/GBYmpmKJ9q71xOi3ZgxV09eMKEclSpsbPr7K00dPJZWqA36R7tb6Q4mgy4Do3X6pWyyLDJUxzitry6rdN6THvRXh/tG4aTUDQMSoESqhWbOaQI9tT+HA4XsinO6Ze8l9NKX4SoYtJBViy5UClEJvPMQPrljl12SGpNPSzxc6MrFcW3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reqZN7D8Eys/h0V5inMnUWkR/4Q1hEJ47ocOt267PTQ=;
 b=pd70enPlmlxfFdvrmEteQEm/JTDCVM/zd1deiMcyOiICb3h871LReb+AVXlgV2qh83wovr9W279h937mPHk6SM6DZQEs1UZa+7qZZmjnptmmApPvO3UP65dTHsbzcuer4T49c7XAaNtKDRomqrX6Hs6kkDs7EeONO6WnGhPMgsI=
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:08:05 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::22) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 20:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 20:08:03 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 14:08:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL pointer dereference in device cleanup
Date: Wed, 4 Mar 2026 14:07:41 -0600
Message-ID: <20260304200741.1096953-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304200741.1096953-1-mario.limonciello@amd.com>
References: <20260304200741.1096953-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 05420da0-fd62-4933-7229-08de7a29be58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: 2m8GiMNTsPpTqsclP8kVLevRFqNEN3r3f8JNLCFnNLNorDit8quB8RGhguHOdON/7QgRS/HrzLbckZfO0xLeOUw4mxbLDfgPkP9xcbv5f7xWGtnuP6K8mqmeSw4ZHJozikelQTxKc9QS4hR3tc7dDzbLKIM+uxdi1VKZ70/K38yuy7euzzX3dROlAo4jgNDb5oSFqV879M+QudtrNNM0Gyuc2jSBUQ63/KntH1RVKESezGDjkH+ivNLhNP4ggAuj+WK/Zu1v/CLmiHvLFu8k39nnSnFqYdpXYvrHlwXkLPqFRUICYsgCPZtkntSAfosxq7bkvh0NBR2PsW2P15CnVllUZFlcqFaZdavEqhO3SBTZxTpDFediSdY5vZW8yl8a9VipssaGaaEsofTwFeGX65ZyXmNxSEBT/U80SYBFgDVKMAjrCdpS5b4T8UmQlaR1No0gxATuuIEBIUcsW8Re1bGBZHwg7FX1hm9WZVF1HDYPyOkP77yBwD2qHV6AlieZUAjLoOoN+PtiSsXw3zgcUA2VjZ5OaRQ94R1dgx/6ZMkISL93tUsf5KFWPT/tnru2BP3k3GeqCpi0jOTWtRSee3cc/xD2ZIq2dUntcOYd78K/m4RRyxHM8jDXzYhTddYrl7P22/Tjq9i6dFLMzw1pV2EEzAKSN2Gwm2E4+SD9CjAFpJ8/aAD7lIR66bDHXa/EGgfuxfiG0dvCHQcY2SgdVfBnbPpFfiN8i+rzf+xAojYeMO1tD6bc1aj1C6H0NtY8kP942JIAQ8NKKA4nOevvBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LX2bMURkOEj1lpSu5xVsH7eIndKkY4RoeLqtlWoAV2wHoY9xuKkRqWWXIYHIZQbV9GB26InWsfDZg+VsZE2kpyT9URREx59agGvSnxU7qFHgBENKcQ2oc+TojAdx4iExaYcOKhivBnDcW/SSLYMLnY896ZXLgDDFVqJcb1byHjte9Jl6uvHe6R3AnQDDGueYWjyzmUrn4Em+t53XzU4pdlGnCTEoAtVM0h13qpYh6LCXS39stVFMicZJOyP2vuntx6S/VVgPa6AxpfIxi2GnUxkLQlKXXOWQ4CAeUvTmlDqVVoLzcTsZ4YpPyL+q/dKbbpWDMpXGNwz7hp+rdzOpkbA+oIOHKX9JfPqQEuH3FIKkLVb9dalxWb/pXe+8czZfVyoJeoClngK5vfcW6pKRo8VSZe4LdJhR3e7Wzk/ouODdlEx4HXIOrcGp/zyNj2Ww
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:08:03.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05420da0-fd62-4933-7229-08de7a29be58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
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

When GPU initialization fails due to an unsupported HW block
IP blocks may have a NULL version pointer. During cleanup in
amdgpu_device_fini_hw, the code calls amdgpu_device_set_pg_state and
amdgpu_device_set_cg_state which iterate over all IP blocks and access
adev->ip_blocks[i].version without NULL checks, leading to a kernel
NULL pointer dereference.

Add NULL checks for adev->ip_blocks[i].version in both
amdgpu_device_set_cg_state and amdgpu_device_set_pg_state to prevent
dereferencing NULL pointers during GPU teardown when initialization has
failed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c24369821e47..258391ddee7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3258,6 +3258,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
@@ -3297,6 +3299,8 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
-- 
2.53.0

