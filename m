Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D6C05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 07:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8235810E69C;
	Wed,  8 Feb 2023 07:26:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C5D10E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 07:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRhTt0n2dexNsqFpSswyntzfG9bpRjDfi8JVfBgffmTciDLFU6o+5bGLvscbSzbHRSdbx3Pgc5hTO4FBwc9QfB+3zv605eetn4MpWoyziOv+LZzJXFa8ll+vJGcl6FcLVXfFDxLL8j6KMLoNgQpk2X2s2m6rZO0EZRg1vC+tq3A0Yu8f3r1h6xxr4WHQ8PC44PQWbn58waXJXI/r/jYyvn71UFFIxoajAy3ZFL+Y+It20xLEDd3gl3Kkdt0yFmkTbea7vZsfKmFBaV0PhLA4eHjxB8+2msRr2gOHoFJGy6XZjuSJ4gpGjihJ3Oaak/be28pTAbliz3TBAs1ak3aMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYCakBk8xPKbsyhvaOYg2gTZCicX0ZOICIxo0YAxjy4=;
 b=ZW3gsCEozk5pkCW5GRvFIT2CaHR6nWpOvnJxsleLXSJfKBchI66BDwyJKmNazzEX4Qm21qDvBSkLQDsrqQaT+bBlYOjek7AxaStLSTfxsizo91kjcHwtB7F+eMGj4w9HzQ/GXSHwF3u/zhSebksQK2DJfMPjYwHVR88Y3E+AIeRwZm1WEHrjEGkWddwnaswPEzQJ83DeMb2L0IOoUXk6Cpw2Y5TcBh+jwabl+GXRkRnuuMgynBN+6uVUZ7cl0kPT/p8DxvLUvd9lkkD3eRNV2kP9o71J4GuB6fK/9g4i7DZCP5xDYgbiwbdRYXH3fC2ZI9GXidNXNClJNaBLC4acFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYCakBk8xPKbsyhvaOYg2gTZCicX0ZOICIxo0YAxjy4=;
 b=HNPJeZKrszwLzMe2hwUohlc/y7uqBfMwPkFaUFcUppWj6OoV/QDBr2EX9dWJ6+0cssoUZuqnqEpA7fzIT70v8lTEzrXlGqY3d5BKIfMmP608tLnQohJrrHczkSy86rHg8arOhNOGwuyAIp4baLToPiFOaU+NEPVWjB8RoBGIjew=
Received: from BN9PR03CA0785.namprd03.prod.outlook.com (2603:10b6:408:13f::10)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 07:26:07 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::1f) by BN9PR03CA0785.outlook.office365.com
 (2603:10b6:408:13f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 07:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:26:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:26:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 23:25:51 -0800
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 8 Feb 2023 01:25:50 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
Date: Wed, 8 Feb 2023 15:25:39 +0800
Message-ID: <20230208072539.4150546-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 190667d7-6270-4ef6-df2a-08db09a5be8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cyk7uXTav855U6VIy3WWdWvvJgQWu/3axASo4Lf6kgecAC9yiBKjX61JFxqU1uXxTCF549ja5UP/75xFXXWXrMKgrE5JtfzzMXIFa7HwApTU/5Sk7kYXirKC6tqoHIzGr6OQHFGLZXGBOddoUSmS8KBFfJ/XsXKahicaCV9cQfwh1/pTCXCkgwpTAOa0YOAHeqX68kO0R7bkUXzB3D6h21lQMx5ksJTTfrrbRSdPWNRSpGPaRRQLwxZPMxrjLrCpmcYOYr89g+Mb21V/16ywvMa00AzX4iZwURp72NR0x9Koe+Dz09MTCzcIsxYYJQwW25jpfT4nKGhFv8Wr7mrEc4AKfDpWjmZUToFEcQ5rPjZKTbkAnqfbT66VfYEUKB7pcoKHkui1o9hPsNPvCNmvHbWUsIbju/AXwQK5mjPLDNOxZXHB4QhDAtEhyLX/E1mF0asRJ8O86Q+gsjTqoa/k9uhlw6ouEq0GHS+A1YQOsTYkQj30lDkLPADVV7vImy1pffxjtXZBDBg32GQUCMGHUzyjGwWZFvaOvSidS3zNrhSujPOe5mAyfLGgiC8b4i0D9C+oKBzQUGq9YRuFyZeAR/+FaGa0Frggiluw+5HteAe8BMvjRpDZd9DonJku5my+chtoBeLU8Zdra3pbtiUlgbINZshiNo2z+OzFxDExeogndxr6BafpLLFClk2d6FLTGIly+q+34cC2NiwFC7Jv8NJutUggHYCxdndDlW55YnA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(81166007)(426003)(83380400001)(47076005)(44832011)(36756003)(15650500001)(5660300002)(2906002)(1076003)(186003)(82310400005)(26005)(8936002)(6666004)(41300700001)(478600001)(40460700003)(7696005)(86362001)(82740400003)(2616005)(40480700001)(336012)(356005)(54906003)(4326008)(70206006)(70586007)(6916009)(316002)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:26:07.3679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190667d7-6270-4ef6-df2a-08db09a5be8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tianci Yin <tianci.yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[Why]
Variable adev->crtc_irq.num_types was initialized as the value of
adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
the num_crtc changed due to the display pipe harvest on some SKUs,
but the num_types was not updated accordingly, that cause below error
in gpu recover.

  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3

[How]
Defer the initialization of num_types to eliminate the error logs.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b31cfda30ff9..506699c0d316 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4226,6 +4226,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	/* Update the actual used number of crtc */
 	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
 
+	amdgpu_dm_set_irq_funcs(adev);
+
 	link_cnt = dm->dc->caps.max_links;
 	if (amdgpu_dm_mode_config_init(dm->adev)) {
 		DRM_ERROR("DM: Failed to initialize mode config\n");
@@ -4714,8 +4716,6 @@ static int dm_early_init(void *handle)
 		break;
 	}
 
-	amdgpu_dm_set_irq_funcs(adev);
-
 	if (adev->mode_info.funcs == NULL)
 		adev->mode_info.funcs = &dm_display_funcs;
 
-- 
2.34.1

