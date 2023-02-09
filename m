Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC6C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 13:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0536710EAD5;
	Thu,  9 Feb 2023 13:43:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ACB10EAD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 13:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO8Em34KCoB+kkvKfNjlITqf91LFwsj8DxPSXrjXffa2TKZKCTr+sB9x4pdB1Pn86geQY6YEEfA0GDWq+qWykBE5hGASTjJZEV3cGyAS5QGqN4oGGT0jC7AgFP5zikk1ihYu/CMkjp02z2xSBRvqFCB7aOBkYsHR+cK+a9tXGV7YjkrRkCNZ40rXJNaRP1ChL7BZjewgEzjTRbkMBlep4eSPwpSxtQFV/ke9MqC1ZElal6MfFHfj1SK6TNmKYaJTTQkPz8rHAEJXv2UYsa0i/0nVVf3Xl4e+skDJD7xBRvW+L6T+Ns4nO7G898LWGelkAthLqeVPVBQLrafoVin/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X2JyNi6q/oquu8MWijTWZ5qZHueZM6gydwMJVeXUCs=;
 b=e8TGNhG1hIDTX5PaLl3sfwsGUmI2WL+YoSDbwiuiwZHrXmUWc+cSEwR1N4WrDObIyztmC9euQ3nCDlrhrADAfpxHTr1ce6uwdVz2/C+ynoMM/LtYniEGsHu5ow0mRo+L9yMjn/FAd7j1wpU2MoI26i98nv9OJp4HPqKI71j5ma2WxTqIQ281xZ/7ktvQFyJjqIRokuycegj/kaj2wLOOZmLH5HpLigFI7CJk+pt4EX7RMGVCrXQ33cLZA6Y2Yj6gj8ofYYzUK7X26rv3m1KbMd2xt3kgTWvAr+zivrBCcIUYykvWE2QHw81L6UbhujZOx67+JIOTt0emlqk2n0CIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2JyNi6q/oquu8MWijTWZ5qZHueZM6gydwMJVeXUCs=;
 b=axSusE5kdY7USFh40PZKvbsxT3lxaRoyimw86c8JEsmz5A5Os/RfnOVFMxDpJIBsv8VmjQhCt1Wn5haKnmYarxIyNL1LldpCJfs1zMcielnqX2FPikQADBuhHv6weAf7kA6jmWEDbJUusSP90DBoOHT3cRRTFyizGQh9GOOdg7I=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 13:43:20 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b1) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 13:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 13:43:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 07:43:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Date: Thu, 9 Feb 2023 08:42:59 -0500
Message-ID: <20230209134259.572460-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209134259.572460-1-alexander.deucher@amd.com>
References: <20230209134259.572460-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: c05a1679-8733-47d9-2c00-08db0aa39b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kwwxe/BuICWe+Oqe9cj/VuuCl4WoGFB1MlrahwdXoeqwLUe+zBSElW1C13VoKpsrtu++VST4Niky33psLu1UYWIAb6x925jFkMAO9WZW7HlJm8s2lZNB/o6RucgfjqWTgtm3cf0jtVe4l6PvLCIKEOGvy4x7oa0z17VqaqP12JhW6Nu7lOAYZV3gYos30yv1jRRxQIGs8Z67ys8xu9doSOuSrTOXHnBcNo+4hZnR29/P5CsPafL7QB4Xnibv5wvIF2xWhbgbYDZtaWWJoHSPMEKWPjBmVskgkjzBH+zV0OUwCv0tfwbOFJHiGoNe6w7qoKYqvZisdAvvfntnYVt8SCnj+96osyfy5PENvbTHxz05v7+OVJ2p72IXCY/voiAuEQKgitPIamfcTQnKfTmk+9+0sAt/d/99a/jGuWo+arENMNpDQMjfyORnKUoQi+HEGfsWYHLkPFYX7xTrtwMRL0oxP5+VEvGJ7Q9dm17qobyeh98IVapJ9dtevWRWyfJDmG5FXFx02xxXi4XZxE29Za/xTCw2E/JPw4PSSdtd4z3YEdIGRPYByCV83D8k/WcMV/jHf54DhdyWgkYeb9IrQlbNVoS2kh9b1wj2GpDxDGW+HSNbycviY/WgYrAVgzvGolbH9GPEWQyOqxF7WHvCR0pb8lNGwe2H61+P0zGF1EY4HKl3SsICFHe1hsxyRX+FILtibGm+NIUYy0qydZoK01JChKgpO8TbwEPDeeb2WTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(40480700001)(5660300002)(8936002)(36756003)(2906002)(41300700001)(70206006)(16526019)(6916009)(4326008)(8676002)(336012)(426003)(478600001)(47076005)(6666004)(2616005)(1076003)(26005)(70586007)(83380400001)(86362001)(316002)(186003)(40460700003)(356005)(82310400005)(81166007)(7696005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:43:20.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05a1679-8733-47d9-2c00-08db0aa39b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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

Use fb_start/end for consistency with gmc code for non-
XGMI systems, they are equivalent to vram_start/end.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ba4a57d8e6f..bf06875e6a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	/* AGP aperture is disabled */
 	if (agp_bot == agp_top) {
-		logical_addr_low  = adev->gmc.vram_start >> 18;
+		logical_addr_low = adev->gmc.fb_start >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
@@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 			 */
 			logical_addr_high = (adev->gmc.fb_end >> 18) + 0x1;
 		else
-			logical_addr_high = adev->gmc.vram_end >> 18;
+			logical_addr_high = adev->gmc.fb_end >> 18;
 	} else {
-		logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
+		logical_addr_low = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
-- 
2.39.1

