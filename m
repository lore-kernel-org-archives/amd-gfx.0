Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD64FC48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AB110EE57;
	Mon, 12 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6nmeQkK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4D810EE41
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPGfOq0NfgqOPzSFmgsA+I+T34fqnK0ruUGcidIuWvN2B5yCT/JEgfecN2165ebCglUCUurfJ9CD4EpUx8hwlGqUCqIuslmzoXyALGQ7zaVfu4emx5Eocw+MthcCWAL3Jd7J+e3gO0sPhFqhJYF/AOIS7BB0Hu71oQidni1Az9n944bcDwDU/MSfRjWaEH9f7lUiYES5BAGACqvAIYHa0RZVDAOmp0ib7l4JR1G6a44ImIAaFggBl/YkqxITO6HvsdYGsqcTgpgEXaBVqhlv3fOfBqBAWAGtSxTcTf/G2LnJUKIqNCklKTi18az3RNS5nOMv6oLsAl3qEq63beMSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aun7rqhlB+97zFzGOMgt0YI7qLil1GRZ4icWzhC2veY=;
 b=d/j6ubq3K0y30AaQdg2/j1CLgNEWT8c2zS5NmVQf0YngSVukZ9Y6XXfKlQMQSXRfxir2/cQgUmxg0n84I7INxmJASIJNbnNrg4PUnZczeYkNyaaz56kxes0oMLOtyL1T0QkRj0QGSlqG3WefL/cOZhBqOzXXcu8w1tO8uH5R6JLcdQ2eRU2DJWd8nbiceVYeroeK306xWKkYNtzoWcIr09CYV3etUyGSALFh5eU7dhDEsqjHvr+37yJ/f/olBH4HcF5q9L8Xlb0ISCGo2dYQMKehRV1N4EdImT0ln+sncQQS/defOK4HfH3/HRpoL7oBrj1yu+YheiOr3MIHL1GHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aun7rqhlB+97zFzGOMgt0YI7qLil1GRZ4icWzhC2veY=;
 b=j6nmeQkKw1teWm2XjeqOCo7DavPMZNtYb4THOlrYWzmB+o5JPVgqMYs0q/3cWpn3CmTlQJC547bbsEc5dycv7KbuBMNyuMaxEwmx4x8dwMj37lwXc3VlatgVzHd5pkXVPGZU9LuiYHkrjJNUiAlnhOYl6chB//AduVqcuShAXag=
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 17:59:08 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::9c) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/psp: handle TMR type via flag
Date: Mon, 12 Feb 2024 12:58:46 -0500
Message-ID: <20240212175849.433812-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4a57c9-ca53-43d3-86b5-08dc2bf44f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PptjRYZCb3E2F8ld81Y5SFx8ujZsPlQYZvqlpUU4Svz8yxGGl0M5NKMSzGf78py+19PkRjhwslxa3E4emPtYckbsurY0kocgnGfwZ2pPllaWKAW3xa1i65F4qIc7VhPKiRc0u83KIfyhC0PDRhKfd4e69A1Ue4l0YNd48uWuALYoW4AwVUgv75nNY8ZjoTym/Chxp96V3y9sY/zt+jssmP7FvAZSlvaGeX1eRKNHCYkM5lrsdcfdD8gsZX26HCnzrYYe5Oy5Mv0+ek/r3uhcbJV0mwl7Gf8sONsWhzpw3K6yrKuHThFFifRAIHHPIBnNx1JTBoZ5u3T10fteLmfiV/tpkfJluxpTA+zVyA/KcFe/ay4qWJWBx3V7k0dokJRxMxVWIKpX2CPqw5Hyr4u+JtSuYNuv+hKkFQWV8Uqo6Rxo9AVgU6g353vFC0KCXUJdEjZUwrC84RMIOcGa/bqbyWcVsqx5/Br1vpF089eflMwb6ThPm/G1JaTnojxPPESE/LfW8BWX911fw5zvQpfk498hf82tmxHt167yMnF0AUAM3Xl+k6anXafw7/bqvv/dJ1aFCOiUDEGWo0mCMhbpIqjAgovf7XyQvtPfOdy3GAk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(4326008)(8676002)(8936002)(5660300002)(336012)(426003)(83380400001)(2616005)(16526019)(26005)(1076003)(36756003)(82740400003)(356005)(86362001)(81166007)(70586007)(70206006)(6916009)(316002)(54906003)(7696005)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:08.6659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4a57c9-ca53-43d3-86b5-08dc2bf44f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

From: Likun Gao <Likun.Gao@amd.com>

Add flag boot_time_tmr to indicate boot time TMR or runtime TMR
instead of function.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 ++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5e1cd4a46ab5..00a477a9e606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -233,6 +233,9 @@ static int psp_early_init(void *handle)
 		return -EINVAL;
 	}
 
+	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6))
+		psp->boot_time_tmr = true;
+
 	psp->adev = adev;
 
 	psp_check_pmfw_centralized_cstate_management(psp);
@@ -779,16 +782,6 @@ static int psp_load_toc(struct psp_context *psp,
 	return ret;
 }
 
-static bool psp_boottime_tmr(struct psp_context *psp)
-{
-	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-		return true;
-	default:
-		return false;
-	}
-}
-
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
@@ -2256,7 +2249,7 @@ static int psp_hw_start(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	if (!psp_boottime_tmr(psp)) {
+	if (!psp->boot_time_tmr) {
 		ret = psp_tmr_init(psp);
 		if (ret) {
 			dev_err(adev->dev, "PSP tmr init failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c24b1d7462ee..ee16f134ae92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -364,6 +364,8 @@ struct psp_context {
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether psp use runtime TMR or boottime TMR */
+	bool				boot_time_tmr;
 	/* flag to mark whether df cstate management centralized to PMFW */
 	bool				pmfw_centralized_cstate_management;
 
-- 
2.42.0

