Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE58C43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C98310EAB9;
	Mon,  6 Jul 2026 20:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1tbZLb5R";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C36610EAAA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEuKZ1shQFi9lbXK0x/ttD4Cqh3NOu4JJyyc2zsIn0ivzosdRWE8PUsVlmENelUKPKQWNHN89/wxARBTnfSQ9GNDJcbebLVb88cJyacqihuD8qmW/PEbpVJHMR7ieJh1x5rH8Da8y7GJqVUDVajip+Weh2++zqgMegiQ9vMVFoHLWK1u1FR/RZCgJ6VJ1wqN34vZZYyXlD/whTwcfWJlvOgUkIdZaXBCyo6Ne79aFnEVcSakICkkEDI70sfpyq8pu7dIChjqj4DE0anV5lRtLMP1zzylaqW2p7wQuJGZlUvY6jP4+tT232ayOg+d5wK/t5twlve0MSd1glpVynFm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLaCU63WNj75FccXdBKVxjuQgWjPsD/Tx+ytK0LFz1o=;
 b=xRpfke+AL5qI1yrJHmcElHIW4bTN4VYZrbybAkv3uUqre0igx5yFcALha7OXPk+qf0CUiR4fB2YA53qmrPz8vswj08tEDEIjzjXNu7OgbuY+hBkEZYRV4ynLg+D0zZLM6w2CcN/dd1elyJwV7XYWFLQc14uWtO7+ndKa5nd3KHhwT6B5HNZmd53h5+flGmTze5SZvfbLu5TCaudEGLyhtepX+4REJ2Kdk+Lrbyiijcog1644L40KRUd1HW2s293YaH0BwhkUhW9sUi7JEAO9vXFdmmFS36OHn0x3FxoTKqJxawaRaGbp50vrCx8fbjWCnDbBXa3+8FaGsAQWWUQZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLaCU63WNj75FccXdBKVxjuQgWjPsD/Tx+ytK0LFz1o=;
 b=1tbZLb5R9a+9OMSOG52gtDgJpdjzm3Q/n5b3Ixc9gm9cKqQcFnxyN1Dj0CWK9h/jjLJ8HGkLu5DlbxOt4JjC/ID9CTIuAB/2LOfpdEKqWPp75IbdwHVMERgkikGoBJdXHV11JpbyqOpTFNzhMWZD6EBkO/ramPEL1bc7EWbxZ3A=
Received: from BN9PR03CA0862.namprd03.prod.outlook.com (2603:10b6:408:13d::27)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 20:06:12 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::74) by BN9PR03CA0862.outlook.office365.com
 (2603:10b6:408:13d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 20:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Mon, 6 Jul 2026 20:06:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/sdma7: don't do MMIO in MQD init
Date: Mon, 6 Jul 2026 16:05:59 -0400
Message-ID: <20260706200600.15071-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 777d6ac5-cf04-4a63-8343-08dedb9a0709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: rtTnDfteNgiG0v57oUOrDCPEYGNaXiscgW2cZN0MzRXJ3ksO7juRoDnBQU9lMCmqzbjE97wD+eDvpOHA0XzxA3U4/mSadF4LSDj9o+fy74pNZrQykJDaS27ByNsCOOFYyvje+iDfVLo9xCh91ik0jDVGZiZ0UnJ0vQ1uvxA+NhK1RY4VZ0WqKgfJr/P8y3+B5WP9I5ua41WVsUjiz4Wvf+wX9+gZviXqP3EfMHJmaSY6ODTkics5P/OvzEC51wk3oKn1kUidyKZo42SAwOn1fUBCSIK+bVZNy/ZnznHEMyqZ7647EttgxOCl61TU3CZSkDSOTMrN6x5CX+cPaJJLlomNYltLMWESg5sCl17/Zq1SHLfOJcxbY3bW67B105YctyD/qq/Owur1wT08InwyMtbe+aJOIwkEGZ5EoP7U9kuhnwxy8uvpJHZKgfCFG53PFTJRwcVlIrTwwe6ipQAT0xN3SpY0oLfk6RxxvIVzkZ1gS7Jl1ACDhgsMob9haWyjMpDLsF4aVjY+BwSxHXX1vodCKBz7qA2XBcVXN58iHPGchMGzgxORn7xKK4/UjuMXxJkE6UXVYSA66CL+LELzRQ+tuwZpzxSqX4ptU2I6SVzOPibLYjdPvmWZPqiv6nQbdhj7tTzgc4wXCNfu5UWnvcbW6kDhdzjL9KYWGWxIToA3u8LCNAQRVU/t1MMp/grkAc83KwPjHTAuceDqUvU53g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l8J6lJezERdnt+RvJH/JZmzDWK6KqM2IviaBV0e0pmu5wgFchMVmXM/1+37KbS9lc/vaM+rHxNa16mxWsfnCNwHIRg7uizDHxHdk8pDKGPxjrXJzopgNtsdbOv0EoK6WbLkIK524UzKE243kyxfGMaP0u24Ne01IF2cCHFqxXtcRlCmc3eXYIlJcvR31xLxGfcwAjlwZESYf2XYWx9KEfiSZjOrgOKxHsIo1QtHOYobSKVOxYhBeIiREmp6MgYvesro0cRO5KGkYdE1B7MiuP9RlTVgxUAakJhCcSRvRBaia1uieFC40A6+iVKSc5IkO42VElSLHj2c/adajI8hrsPylimFursspoBhHwNUMK7OaE4HKWVEkSH0lzqMdD/1e+NcAQmK/KDbZzx9AuptZItFsgHRO5MCoqcDdNGUv4YWd/WLpRqZhERF7hPrLCerO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:12.2294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777d6ac5-cf04-4a63-8343-08dedb9a0709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 69cb89298a3e0..b3dbcb39d97dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -878,8 +878,7 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = 0x00000100; //regSDMA0_QUEUE0_IB_CNTL_DEFAULT
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.54.0

