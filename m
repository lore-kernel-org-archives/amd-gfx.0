Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97777C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E2311202A;
	Thu, 28 Mar 2024 04:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQTiABfL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5995E1120D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvt0nL8n+iAgivYccdkVEhvL7WvayeQPBPlUsy2QtXl2aiWgCj3LJ5lxlYuH/1IqO6SFyM9Do1xswrjV4UrCqZ8/4tINNcqjVIcDPvhCrPVqNkeG+cjo18wo7ecOXr9LhrR62vQzmTyRci0e6vUCDHpQipiq/oht8Os0WkzYcT60KFxGFR5Rh/dczpKfUtkaI598ODO5vXzp0rrxxOsIIGYYo5i6BPYnqg18DQV8IhqmYxm9ZN87hhl/Ac2Wea8r/NGSFXDFeFOYGMGYR9ibnQ9IU2AQWiCcFSD1mHTGe4rbP4Ui5aFgeejepd31JQRWB11mq19YWwcdnAARGHGfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJR2B/IF40B7cyCiPZg9zrdEf2XTjsRSP1sYKQ3ZcfY=;
 b=PGpMLSm/5molZnBHZ6rmSYkeCIoQxd4FzFMgVEyT3WGb4jZTfV3+VtcYr53WagsGgKkPFTNYb/2vonpUAX3rp32ftCw5Fwj8fALYRxMh4IReROtXhBNnFC/Ar5nmZFFAVsKMaQxHtKXxsiA4EweIHC7BZ3HHaZJVKxjZzYQEKZbJxJB++sXXibDGKpZBqkh8lUAOyQgbaxQ7KRi9f4mc4dOC5KD7LMk4en5KYCQ6sP11zueynfw21TGt40b6jfwB+TFibHjeC5ZuZ1VCB945h9CAPdI+4ZWJEv6fItLSjk79jaCI3Ek5Lbx6lbz6icbPzG57F+BXNoAFQUVEJ+i4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJR2B/IF40B7cyCiPZg9zrdEf2XTjsRSP1sYKQ3ZcfY=;
 b=WQTiABfLbsSs6jFD0NSYrRkLAVaqdCpjdnIArrjjh9m3bOid/qNBQdmbPLAOmiGBrJkyTzkLYOjpPwgTHKB7ufjfcj1bmOVhuVub6yirn3kgR38517BZMqs64E1lkzEiJGYf1AG9IUCEzz9q18YxLjpus5rvDfRqcHlOOa3FXtc=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:21:13 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5c) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:21:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 23:21:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add smu 14.0.1 discovery support
Date: Thu, 28 Mar 2024 00:20:53 -0400
Message-ID: <20240328042053.414131-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328042053.414131-1-alexander.deucher@amd.com>
References: <20240328042053.414131-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d433a9-8c66-4f89-9f4c-08dc4ede80d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ3gp9N8285clMywsXgNy8d6hMewemJ3jt0l+bOxKFtTSAEDF0zCnOG+fhof9OpJ48s25tpAj2qKr2/1rOU1byQ/XNkP3Q15++dkCXqq0o76exGHXvJVpmr47LE3F1zreTvMOn13nWv2IHWaWyVgN+HhF41xJtrBSSZfQs+I0K1AWWMcVWDbCABJPGDxsE6UUZ5w2DdEpx3TXKqqbMXBli5L/p8Nj2KFkzYAwV6KUyj9yazCSBbnEiOJCOI66e3nuTeMRv3ntug0cQBrAZb2FzdWut3BBd18PIbxAZmDkgv3zGPr6c6ikslwFX6dpPP2/xFCYQvIp5I8u1sYQszWPa8uwUbkf5OOITSPY8zYt62pt44FVOS0P3Q0rFzF2WgFs9YwMPLXq2iP2kfIHKDahDnr3vdG3swfRjp5/h7ACqg0XHV5k3oThXKIq9NIsfTi6cSECPewr+c14N0K9+tCkIzrfODegYSsr0v8jY23m7Pq68elZTqdHvl6HIDXB04zEKQd3mXxjiE/ayIRHb8EretGPgnO6QKn94Ac0puFsYas2RgZxfw+PGT/KEjGDE0i0sNZetf/m8AJICQDvujOkV2p34xZqifcHMT2E9H64bVmz24XLX2mMV581wtxQoF0hWU9TBqO7NL1IhaSJ6mSBR0xVEeOc5p+9DevsV1Brh8h7ZW78X51oWo8sqA8FqHdj0LeKCU0R0nwLxj281XkSI8b0dUjMCp3LxgjXkoF2JeR/NRunRMRqwWGn5N4O2oB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:21:12.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d433a9-8c66-4f89-9f4c-08dc4ede80d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add smu 14.0.1 support

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 362da1413e1e..07c5fca06178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1905,6 +1905,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-- 
2.44.0

