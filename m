Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6679FCCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C2F10E87F;
	Mon, 19 Oct 2026 08:34:36 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBBB10E880
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibigOkJxXvKF3cUqy6twhf1XJS81aiu/DB6O7bqeAuiAVEo6p59UnpIknn03l8HP/yK9+hJDwtmjiXwXJnjuygOrXhypS99UZ79UzhsWiNxOPCp0N/xTVjuwzG6Cugv2cHWSNye+zSQkB3gp/HH8bP59ZXt+ZC+gNTtjmo7/FWr/+HWiN1axzU2gyC1XaxbTerkwZsVOtpmXAVqjJZjI11hJm2BSf9u2KR6FcsYO6xZCv9SbrXNoSRYisECfSR2eKazs/wJDtue+luFkqn6YIplDCuGKr3CeG5qM9axF2FV7xMP07Wug4zr6eSWyioRYvaBypelyb2Y9yZHJpIGisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKsEq1pQDc3657WEc5N1mQfG///XYrRavsNPKUglZus=;
 b=JSwR/BURZ+UyrTP/gSxkQttljqVisk7ZS4k9WktxG0S4NDnJxnws2W+MTncEgGgUQaxrS2UYPwnFeV/cSUR9rvJ7CORTmoo6AtmE3RpiDkALg2xneapXDhYZVN/s9wXeB0xOJGa+kfHbqmZuZR/9LWLIex+F4wUHvgPLXjC5HfUvh1LEANS/ltMBRtFsAlk0MugJeAOyCNxjOCro6uRjs4lT3pujFuSY+F705eVQONWYN2sWGM7al+BWyIc0lbdMk+hFH2WdoxDTWKE6F1ff1DAN8yvgqHvg6Z2+g7w4EWmgz4yCiZzLbqDBVxMHLzXa7aaDA3ws0GFiegb+o+50Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKsEq1pQDc3657WEc5N1mQfG///XYrRavsNPKUglZus=;
 b=r7VYRrv48+iyATL93SMD9sxIwkmsGcO/gkmny9Bxc9ozySbrXonWfrpeITw2IrO3p2Ro+3nWyh0L1cZvvWKuO35aBqSNQC/iR7H2MqIu3E7hT0pDqTMrtl0e+dYd+jJ+WJHipSOEnhMjClKRadBVSX4L8j8zrFTYMzziQANRibU=
Received: from PH8PR20CA0002.namprd20.prod.outlook.com (2603:10b6:510:23c::6)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:25 +0000
Received: from PH1PEPF00062F26.namprd02.prod.outlook.com
 (2603:10b6:510:23c:cafe::7a) by PH8PR20CA0002.outlook.office365.com
 (2603:10b6:510:23c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 08:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F26.mail.protection.outlook.com (10.167.243.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 11/13] drm/amdgpu: add a debug_mask bit to disable the engine
 reset
Date: Mon, 19 Oct 2026 16:33:11 +0800
Message-ID: <20261019083402.2033724-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F26:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a0799d-f946-4498-05ac-08df2dbbc822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: g6cxDQjyQ0XcnomNKC/AwwrzQKMlmdpgcjGQrJf8WAS+y+XmBn8bd/QBHf/xqfWzcX835G1sNMqG1GU86SCHCB5m7+IF19y1Nz4nyG6ekjngNMmzgmXEYaMTXxI0AnHNUiDns13wUfPHl8ys9dbiEPYCqJU7iGbxVRJtAgDFac1EkiqtS28E9oVb20r5Fpyw3fwiNWZtfR5LftBS9EXVGATDl1l+kN9XzR+lWsJk4pCTzVtrF2UMm1IwLhKOkdvtbJUmGhegMKLmDrhu6LIQO74GBagGy+GeXyRfBIiLJ2kcfj4BS9rO2ZXXTYb6gP9P739bjGD8mVuVenBruwJUqDndU3CjZI3qk8OID1Ifi600efGhG2Pp4is/ZT667Bc0LZlB+qkPq+h3JH9sIKKkSTcYn48+JROpDiljKPEOkoM4Rf1m/1QAtlyG+TeS7pT1BMqwxNEodgwqPoj+ugKkZozm/J0XHTwx2pBrWl3QCuAOPM1R1EplpW1MeXBXtYL6G7llfXbDN1TOLjTW2I6mk5u9RwesKFNiPPLT77QHixG4ukBr2gc9p+b2DC3fVbWUWyCSuQssTKMyxGtMjYDxjRCpvYnJmnEAcShYZki+0qaCPqUGxP8DbwvsJh/BFhvzuqiMJMQdfHaBnGa9MvCBezgbFgQW3OHsCWmTWpPZhgLESn6LCsfY2u9uSIneT00NXcfY2oWCNJBEepx2hCbXWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UTpI5+vlm8Z5YmE5kpt5O8p2yGGnxP8fe8CMZdZSXmoKffLaq5eF4tyFzeZLfPYwhAl1qpNf23e6KD3x7LHs1cKvJjqcOxJtb5BcQQqIiIGyvRChQqCn8/tIs4BjoyjtaujlZPGU1AJQkiKi/ne2MfWQO7IwUBvcWztk9rSd97kIq4VQOZMVoXt7QEELhwapGrh5SFfexSxB6EVqRYaaQMeOPAcTycWk37yFMfD8ZtbVUxiNBx2LttOVJPRd2Riaw2XI4zuFY/ubQpQe0IetFt3qn+curwUABnH2ydT3NLt092F1DMmUOKpHdIxyXXeUXsAb49GbyFhfzmWDYpCQIZ3YnLLODWWuioWWjhK9wSlqptuJ2FdGm+Rl4TUolWAOMJXyffZ3R3TNEnLjx6+rZmVlfxSUuIml1ESQtpcjFXpoZiuqfeYPQyhiEz8gWEzg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:24.8576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a0799d-f946-4498-05ac-08df2dbbc822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F26.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

Add amdgpu.debug_mask=0x4000 to keep the IPs from reporting
AMDGPU_RESET_TYPE_PER_ENGINE, eg. to test the recovery without the
engine reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da99fa2f1b87..69ad6be01ef3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -951,6 +951,7 @@ struct amdgpu_device {
 	bool                            debug_enable_ce_cs;
 	bool                            debug_hibernation_thaw_resume_gpu;
 	bool                            debug_disable_ip_block_soft_reset;
+	bool                            debug_disable_engine_reset;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f..43d3e7b7ef03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
 	AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(12),
 	AMDGPU_DEBUG_SDMA_RB_CMD = BIT(13),
+	AMDGPU_DEBUG_DISABLE_ENGINE_RESET = BIT(14),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2341,6 +2342,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		adev->debug_disable_ip_block_soft_reset = true;
 	}
 
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_ENGINE_RESET) {
+		pr_info("debug: engine reset disabled\n");
+		adev->debug_disable_engine_reset = true;
+	}
+
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_SDMA_RB_CMD) {
 		pr_info("debug: enable SDMA RB command switch\n");
 		adev->sdma.sdma_debug = true;
-- 
2.50.1

