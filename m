Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D8C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3488410E5CD;
	Thu, 24 Aug 2023 21:58:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036E510E5CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuCYcpiJ7/t8dmrBGpHLjghYYIZQF9/oHVGdzNnX7ZcarF1dKI2hPWQZCg/cIozzaBzbbyiNNRcr71WiMlYaFYgM46K5XMcPyA50iT27W/XauTU5exmdCZVS3p/ThEaQ86NT1DWh7AkZvbqAD1nKWhG4cGIzIqrKHzh7FZ0czPy1g464mh8ij9uX+d2zVsrYL2fbubEAhQJMKO+sCzJNY6HinLGluv0wxSbJd3/a9TuHtVeqftKa8w1puxD/6cPUqkHyrvjtt3k6h8uIKD4gdCCH6zcZEt4d+kzc/Ihn4osbD+WzMKwC8YhwRxG+U7+AQ4cHnS9c5pzJxTDSMFHtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMOebg6dtIDwbXQaXTWcQ0Y5BEYpkJjvH0bQviVSnos=;
 b=JaY2LDa3sAdxdnq3uI7uU4/0GV2AtGQu1agcTENocyqGEH4D9fGJXXTnDKn0WPfefLbhVanGR20VRI6emehtM+71LYBYp70T0uN9Yto9WnJH62CjY+Vf3M1KKjNUnVzfc9Qi+PjtXxJDpUgEhHDG2xWjxaCvFZdTPljReFOqGacI+0610mbcy8uASM+acc9aCKOApgs3eqLRv5p8E27a97LpO9yaT7Jwm6/fjSxFwuSFn1U2glFwLlgXiJ5P1qPlP58LzaxfAUSizLIxwKh0EAmnqM7FA1gDHRclG+fXue65i1kmMFVzXrSaeazpbfRtw9TVAXJQLNO/OCL7eTTJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMOebg6dtIDwbXQaXTWcQ0Y5BEYpkJjvH0bQviVSnos=;
 b=Cve8DtrhMvwgM8QnBdWbY4PxKUzxbvBwGB1eLFwxv3bFCzY2XUCct2PE4Q+RWgVh0im43sF1ly6lhix9/vCs69uVmLz1YdIhUL+32I6ngbRRjjXSFsPHWetYBqXQ/0yEYH0VJqgA/xhw72GW53rc2VcTOGwkR1cW2H3mZT58l2Q=
Received: from DS0PR17CA0020.namprd17.prod.outlook.com (2603:10b6:8:191::27)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:51 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::86) by DS0PR17CA0020.outlook.office365.com
 (2603:10b6:8:191::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amdgpu: add UMSCH RING TYPE definition
Date: Thu, 24 Aug 2023 17:58:24 -0400
Message-ID: <20230824215835.2740115-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 51608228-b4a1-4f13-8528-08dba4ed4d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JiP/iyp9anYeG4XjveGAdC1RMuLT6uLHbopbzNg4tN05goUzFg+DrSDNyN361fuiKRTxleO5LJ19oSMlGWssmXhl87DmyIn+xAz9ZktY+JnQSxvSCQEqbVAG1tNh32ExAvFegCySuZKBtRWXtmpe8DK5TsYfGEFL2AVmx62u5Qbc1MdbxYAXOAbk27T4TPNENwyhbE5ZsZy6L81+BzDWhBKeJMpNGiXqi2K+RMI4UtWAB0SIUn4qfbFDkkVVuT9H0CBpgQzhupk7UBKWfoieT7yvjzS9cSlMu3UyAgDb9YC+yRwk1AGV+/LUz1MvcFefYCTa1pds1xMimrDzTp2R6XzeYeI44gBwVPCHphc6ymXkIE1YBIYbZ84Oc0iktRktD5SxqX2Dal4dsoSFBkPhyn6uplJ/S3yeS9iqiMEz+aDH7Jx2o9EP5jZQEUkhdYxMKJbUm3h1Hon5dNDitKMZ4WJaiwmWK14CJwyu9Pa5ww8VrEWmAAXZoq2V4/hSGqcgRixJCaF30dpoL3TvUWvQVjKXwWEDdvTfNzGdyYk30A4tmSfIXhCmqIpv0P8TB+mhmYUbfzsc93BDckNHJhazpdD2FKnuvjmkpGt/jqTz6BhXc5/LLa3DN8gnycOFPj6e+ACSLISJleScQMk2cvFoBuK6peAf39IIuxyPAfLBkQGI+ha46g4XVLV2cstZgIgCW/Dl9GJyIWguAv/GnlCN8knlu9247jsSqIoiEHHvZYB7hOI9GW3dfs/n+gKK5tL5en0Alv7b/R8ubsBZV9baw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(5660300002)(8676002)(8936002)(4326008)(426003)(336012)(47076005)(36756003)(4744005)(83380400001)(7696005)(36860700001)(26005)(16526019)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(40480700001)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:51.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51608228-b4a1-4f13-8528-08dba4ed4d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add RING TYPE definition for Multi Mdeia User Mode Scheduler.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 09a7e93744fe..7f6a14e2282e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -80,7 +80,8 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_VCN_JPEG	= AMDGPU_HW_IP_VCN_JPEG,
 	AMDGPU_RING_TYPE_VPE		= AMDGPU_HW_IP_VPE,
 	AMDGPU_RING_TYPE_KIQ,
-	AMDGPU_RING_TYPE_MES
+	AMDGPU_RING_TYPE_MES,
+	AMDGPU_RING_TYPE_UMSCH_MM,
 };
 
 enum amdgpu_ib_pool_type {
-- 
2.41.0

