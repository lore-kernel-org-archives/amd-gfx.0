Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D18EC6FA89
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD8310E80A;
	Wed,  7 Sep 2022 18:12:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA90110E469
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rik9sHTT4lZ7cwTRSRCvgr6rCO1dTjdpjF/WzhDK306qKRGFAIi08+lhYOi5vB/GwMJHgfnfbXdHbLBCwpqElB0V6Zbayyjjun5Tw0SoJvxsDctq3ICQ+1fZbHR3SSI2dpTMO4ULT1LuUJWShN+4mdM0VEu8RXlBp7Yg8nN4ODa8WXMVyu+wF1JY0O0m9CpCVnHgfk2TLwLZEdSaHPpdS7K31Pkvh3SLwqAEEUAfhprRC6bh1yzdQHKPO3axKn2EXbfMekcI0BUXMRSp33z2DOUyNtzZiVw+i31MP2nZVGy/UOTFtLywi12Oadd6PYE4ARAzEYLYNolHXtDvoaEVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLXfWonsCjyp5xRnGNyvWUDvvzSWMSSpGoJUvbqCDuM=;
 b=Rhzn7uPMXP8lRRgrHNFMkSmXqndzLLwrPrcndaI33Xs3soVcnZykj66T0+M6RpkbnB3yE+ev57F1OeK/jiBzDUsnWu9enBVh4r79kuDGKFJAPra9//KLGyhDZ2fkpBIE+CuuL93SJLIy2cJCtEzqqtMQyj/mrTt4VU7SRMDmpDmfCTEEaHg9auaFsEAN+z+5+L7mde4R57qmXpj+L0ZN/ohPMHY6wZnERobmJLvrZc99l/JGrQhWAcnqRjmY+N3qvVkBI9zdtF2BYKwKnwXH5aAOdSCdzD22ZHFXj5QXRD5yLN8O22VEvwHPWZ8OlfVP3VN2wTxQe5h1Yy6EIBJTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLXfWonsCjyp5xRnGNyvWUDvvzSWMSSpGoJUvbqCDuM=;
 b=BNTkNf94dWITAdf03bpD658UqJ6pVKRGkjLQKFtqYU2ElT1uyrOEKCjZd7Uv3YvPwMFkRrtlLlCmY99XjzT4opJm5Nxvv5OQ8UST0Kbcw+JzswMyYdBh3dz+tOP44PuMua4kfJkBp8YH5Z96q5gSREtjUpBx5rOUhMh7UWB8nYM=
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 7 Sep
 2022 18:12:26 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::7b) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:25 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:24 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: Relax swizzle checks for video non-RGB
 formats on DCN314
Date: Wed, 7 Sep 2022 14:11:48 -0400
Message-ID: <20220907181200.54726-9-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a16c12-b472-446d-65e3-08da90fc84be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IMiQDoGfKQNDPa4axthKNBTshY6dJAzduvHC3KLQX+RSfTB+lfvPC2Jb0HU7UDXgISAHNfMpSNbiKuMNK2iLu0vkQ4ABwgB0PnQ+0OALcEVZR7VZ8YMO30/Yoo3T7OtaL+N1RSXvX7KQlRBV+j0PcNEPpEsmY8Sz1vtZqqx2qpSNxmr8yO7aHzpPGkioWIJRNM36HPzRWFaZAPZyYR72p2Hzpq13oGA+XravqVFLSeXbM47dVXdZmwRE45mnliJBFPd1FuRm7k8qN9+2yV0Br1hyksDO3cNsXQtT1SNWeOiOGQNt3XFa7ouXYxxX7dlZC4NzbOIg7mlFluhgI7PjMjaX/rCTU6rlWPuVw6CFyWnAL8YMS2pw8UklEnHlSw6CpTU40/7HIOB9Ju9MtfINQA4zHKAH3/U2+1Q5CUD6XC2FPGlD9T8EypLmvLuVyIj7XoNiE2uUEyDJoj/v/7bJFzEIACnIx0hBmKH2OWd8fxDbz15uon8BXFdgwEkRNda6RG2v30bLfozn8hvVmfSVSVaw+KcgfHjgwHmvHfiXJN4RP6sFWFdczj7rbxrn3ZLs2RzjVvANFfVVHd8nuVisg4td5ElyFeLcwKmiV8b99kdxdeaRzFrRN7Hhsqriq9GMmpnv/nSxpxDtsa+y8dSEpN1LQmC2N97Kbq3iJulr0125PCFEF9f3GlBwZHKs3JdNBfVsKHBH+P2Aq3HYs4IEdEl1Di/flkhZOS+HXoGPnULrQDV3j89PFMhcSJCNp7LnP3U0z8keX+OOdNxmv3T6GvK5dAlMl60YhozW9nCRpnENFoTiFEPDoQwy287ZoP4MElkZz2E3u4EL7FY7qv++Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(336012)(356005)(54906003)(316002)(36756003)(82310400005)(186003)(1076003)(426003)(6916009)(2616005)(40460700003)(47076005)(86362001)(82740400003)(81166007)(8936002)(8676002)(70206006)(5660300002)(478600001)(41300700001)(70586007)(4326008)(6666004)(7696005)(36860700001)(26005)(44832011)(40480700001)(16526019)(2906002)(83380400001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:25.8637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a16c12-b472-446d-65e3-08da90fc84be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
HW can support the display swizzle modes for video, and those are
preferable over standard or linear for decode use.

[How]
Remove the check for DCN314.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 9fe4dc32fbe0..2829f179f982 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4071,9 +4071,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 
 	v->SourceFormatPixelAndScanSupport = true;
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
-		if ((v->SurfaceTiling[k] == dm_sw_linear && (!(v->SourceScan[k] != dm_vert) || v->DCCEnable[k] == true))
-				|| ((v->SurfaceTiling[k] == dm_sw_64kb_d || v->SurfaceTiling[k] == dm_sw_64kb_d_t
-						|| v->SurfaceTiling[k] == dm_sw_64kb_d_x) && !(v->SourcePixelFormat[k] == dm_444_64))) {
+		if (v->SurfaceTiling[k] == dm_sw_linear && (!(v->SourceScan[k] != dm_vert) || v->DCCEnable[k] == true)) {
 			v->SourceFormatPixelAndScanSupport = false;
 		}
 	}
-- 
2.34.1

