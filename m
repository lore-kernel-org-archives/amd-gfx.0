Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFDF10EA61;
	Tue,  3 May 2022 20:09:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2892C10EA33
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZmTwztmtJx79RkhrmhKNVvl5rtbsCJtDmEhqMUbiFrLgIIPiObZp6z/JidZ+PFqKZLbj/e1PzFP1AhFT0kNtbzVhShYCj3TfiXvC/yX4SSMQFpdfyBHAAdyHCpdl1OOBDMuxPTdHq+9uLkeiuMXyQeAsS4mxywytVFPAv4t/tDkEhHAT/PIIn427jDd8YjmHsQSn7jkHn2VBeNga8nJ8l7QKF9RPpm1u09WHvasDG2JSSKe7ST/HtSU+BSq+7Oa0fHBYoU6HhhIgHZxgl6ohd15oDOzT+C+Z6FSCzaA+Y8x0GHUpTNq3zAi+1DGQFxsmR82EVdQQChEOun3CoiATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIamdpz/0dnKQrG6wtxajSb+LfscOrbGzwt87iPIAmc=;
 b=bBEXDmMpcgNxLj3F+XOa9bHzuZv5j49ncFJMFf+oxfC2AdWRx06rV9IvLq0SBekg7qnqTTw6gua6EI3LaDUJAQiXt7BXt4aRtw8uZ9ecPXoX77rlSZTIdk0bMeu2mx83B+0P/pEGUmzd/tcU5QL/7sdZEY0z/WLIBjMY0/TrdzxYQ0/DUCRnXR2puyFzRMM8EaEqKDE+wS7s7fidObvHtgOsoxwpPqer6kMRqHAaVerCkk5pgDROVYJRUGuMaI33POfffDboPqYpEkPfvHmCWAIMGcL7QZXTrsEcf6SFkhubM+1gHv86azjmX2aN95XGHcENQuKRml6Ai39eazdQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIamdpz/0dnKQrG6wtxajSb+LfscOrbGzwt87iPIAmc=;
 b=VYJdqXz2iwY46vrFb9QCPIoX5M8fo+61OnlQF86zKcjs/QIwznsxxQAr7iJN0/9T61EmHk6eyobayCh//G6ElmZsryCyXpETy1/DX+ClkGqWt8a6v+JJj9YdB7ir9Wr3I+XJwwVXAJzqCO8Rr/aanwolyUk5tkjGI3BjN+rvkd8=
Received: from DM6PR06CA0038.namprd06.prod.outlook.com (2603:10b6:5:54::15) by
 MN2PR12MB3518.namprd12.prod.outlook.com (2603:10b6:208:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:09:22 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::25) by DM6PR06CA0038.outlook.office365.com
 (2603:10b6:5:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add SMUIO_13_0_8 func support
Date: Tue, 3 May 2022 16:08:55 -0400
Message-ID: <20220503200855.1163186-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a029d54a-1bd9-4b11-fc40-08da2d40d02d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3518:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB35180C18F766B609A41EABA9F7C09@MN2PR12MB3518.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StmQCqOXTr7GCppeitMF4WeK6dHV6RsKbqomRkCubZeRJ224CGe7UWaPdzLZjmkpLxpP03SSMaArGQ2NQ79GX4OCoreGHtt7nedtSw+a2Z/nNXDG0H0g9vKjHMbEnPEeLPCT0og1bBIybh009f+lwhMxRe/UmrfTpeznuu+O2/CNvp0iEUtmzU4gLmOApYUZFfKIovJEmeFb1Y83glCVxZwij1StkwSdi6X7TvWq4KDH8F1uyv7v2DLsR7IMVygRhwRYwxNPikRgaQPtJCs6+8QIXmazD70y0wL7sP3mPGEzO5I+QglPqcCVLp83cgmZGdu/iSdyvy5A7gKhItpa9/nx1S8bbEl2E5Su9dqvCfPjXNh5FaEt/pk5VY7Od6XopfNVha8bTC4uNQBcXN+cndazLuS2GLlwj6NwW4urwZ7c4Rer1u1CoKVW4HmJZAYGvbbQsj+8Gn2PWVsKHbRXX3LX6NwwQt2kgYTHMmuuczfaj5KLLKviH6fzIHzAfILLiTMnMT9QTXnNVDyJaP+pV5DaYAOeJJMeSCB5sf5QXhqPCLMIGDdfkUmurSh+YkqqWB3VRV6TDzmjIcNnfh/LfKezzN/L0bnVxnE+ImnkFuXC+9tf/BcKHXWS1Uw55vznulgGa1RQ63MeninQTW69QX2ygAIgu5b/Qj3iQo0MRv0R9+/de/xsvsQKAxKTfDIW6WG4OtB4url0uAJaL6fqgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(8936002)(40460700003)(82310400005)(186003)(83380400001)(5660300002)(1076003)(316002)(70586007)(8676002)(70206006)(6916009)(4326008)(36860700001)(47076005)(426003)(2616005)(16526019)(336012)(26005)(81166007)(356005)(7696005)(6666004)(4744005)(508600001)(54906003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:21.8771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a029d54a-1bd9-4b11-fc40-08da2d40d02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chengming Gui <Jack.Gui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add SMUIO funcs for SMUIO_13_0_8.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 45383c1b4dc7..02583b34b996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2270,6 +2270,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->smuio.funcs = &smuio_v13_0_funcs;
 		break;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 8):
 		adev->smuio.funcs = &smuio_v13_0_6_funcs;
 		break;
 	default:
-- 
2.35.1

