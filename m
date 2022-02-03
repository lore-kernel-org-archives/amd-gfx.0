Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C2CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABE310EAAE;
	Thu,  3 Feb 2022 18:58:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4819510E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndzw99uC51UDL+PKYSjXtWhoJzgyWxDXIxGaiTqkI4614D3EmZjq7Hd8NqHcfS2oAJAjFwBdRdNpE7iGcasL837JDU29ybeYOVGRwI07UeVr/g/8AlIlxaZ6ag3HLEgHLxhz0GCsJwdaU+aXq5OwBurfrC9YL0cd+nD9QaNgiVF5Y3Df0peFI5OMt/4lhn69CEIc0A6br7tqVH67FiUQEosUd82CiM1zNwuq12fbv1S2i7422RithwJXoeVp6+yoGyQKabT/5m3+CYW7Om9zH7hUlicg5vWJ+s4XTsAoBVqxfV3c6EXTSQmJ5H1ao4f1djQgMaKQnXLTA662GExFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjcqfj9rAHfqW4HNawiVUbefLXrrRxNNPLnPnBh9uzg=;
 b=iu+ufM8JnXMaYNzF4ANqzMjB7fHxvndEXvoHXhEyScgbm5Q+L4LlpBiNlRc5GsfpOFvCfP8eW2Db8r82K1waFN6R3F8Y/wRSmdSWNCrvFGjciBks5qun8z+aBRdQhoKw2tWn8l0NKgnekjdYjX0mIup84c2PPVDMM37YqpVlRDXK+hmJfQNlZDwMNCAnfaAJ6oGYyzMHXo895QO4mko1P8xirNM4WQQFX6h5xVVAbkp+NQW0jtJwHXDXoxYTQgH2jHEuGX3GJZxQFV4gLQCDnb2ePLPUR89KbrtcG90fpbR2WiwmOioJ3pV5FTumyV9tvdB7mz8TIGn5M3sumSvUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjcqfj9rAHfqW4HNawiVUbefLXrrRxNNPLnPnBh9uzg=;
 b=FWSL0A/EiPfSA/Y+Tvfi52mWchtV57JbOwkg8YNCzBy2fIomaPqWcTdAyRPztuRX96EZXZmcM0lXAbawkFJwy1DZyCMlMsQchlvxcU5xAo105SeihA30hcJKFqevyhfFOg4OE6pr3TlaBMHxzldN2EUB0vn4kqwPe6gKssyhhhk=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 18:58:21 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::5f) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Thu, 3 Feb 2022 18:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 18:58:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:58:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.0
Date: Thu, 3 Feb 2022 13:58:04 -0500
Message-ID: <20220203185804.1473979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a672ad10-5e1a-4e70-1ed8-08d9e747256d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3757:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37577D40B81EBDAE7A857049F7289@MN2PR12MB3757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkNEMMpBGC6n5w/Rz7N6AZ2VqhLX4WPk9RmkJ9qEP15N/R76Olr5YoPmmLtuE0wRQ2FOiWxVxv3y6CwbmjyL3/6yzr37wWml9ZPeVT7cYv9x0tdFPJ6IKtW+cdj+4k95C3Mr7rFDyfeSaXRBShi8FtJkXVpT2EJ6Srw1/KPCljY+KEE9togmDpJgPS8I8gEFGuqP2B8PwqrK1thNtRWuKkeRrdPTa4yyse/AkVrJnOnzSFweINk60myuYmVn5yv2XEoWSEpA3xE0QTeCqRVpx7RSksSXY43waCX8EA1mwYPDuw/L6mOri5X9YIpjid2JNcdlZqes4jQ7jXetdasogpDUZg1BY3iVhmhhMH1Oi426blcNJiy+XP3jnZpYGFa5NKMYn+dcedxjln5NNndKHQNXzsf6O7NhXNoURaj4lb7Wa8IGm5X9b7XQe/MIW0Z37+vDC2/NRClWqxgytgHzJUHooFuSzUcJvIvlsaKPx/dyG4H+trbu5jK3q20cueQB4ih9tmCfbFEYFKOQCGxPF0JsYD1aDZ2XkaEZ2WcidkOBLieu4pQpPHMtnR7wxd/AO2A0Q9QoCWRuQXE/MI1SlXXLVh9XAqdbX82gcGcpgiJD1GcIHqN2QN4rRQmi1FjwtxItZJ9sKFQCA4VZZLUqhK0+il8h4TTMecFzSBCYBngZxNNOjxoISroAe+PhtGvr7knfTGzyI9VE5UsPcK+HINWh1fisUpYQTztq45gCQQUUDtEJVC1t8nMf5DplPkMaCheaEjwTKQKIGcnxx5MkAIoDGjl3Wq08QpVTtrjgDnU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(4326008)(26005)(8936002)(356005)(82310400004)(70586007)(70206006)(8676002)(40460700003)(966005)(508600001)(336012)(83380400001)(16526019)(7696005)(6666004)(186003)(1076003)(426003)(5660300002)(2616005)(2906002)(47076005)(316002)(6916009)(36860700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:58:20.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a672ad10-5e1a-4e70-1ed8-08d9e747256d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes hangs on driver load on DCN 2.0 parts.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215511
Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to allow for multi-display pipe split")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index fcf388b509db..d9b3f449bf9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.34.1

