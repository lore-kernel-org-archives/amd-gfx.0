Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201EDC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 18:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F5110E784;
	Wed,  6 Dec 2023 18:08:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956A010E798
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 18:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNk691dNcrx6VrGyM/oCP6MoPzxphzZm/BViewHVoT0gUcLcbo4tcf30HVFbywkLaOeHE26KVKuHykZhauDcgSjopPKzVhxhx83XUDMJFVQpQIO0ZDvwwqvEyBWI7fKiw0+YgnMPMjiEZqwWovFnnPLVEZMNNhveNKdlp0WVfy82sBPnew8hqP56MjFsITM6Lv//HY5DnU44s3bC+Fm/97DI06pBMrGBuxeFqSZ9+saKfCOeO2pYxhDJzrj5xaAAt0hnHPxmqVv8qVvcqyI4rn7VX/gtByHPAuM+cUCmhg5480brdu09Md1ELyHOo49QEvdacGLYjF/N4YYY7yeQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uBpiIvzQ+FIf/mVKJ/rNByhheMQeeFkpVgyq7VNL1g=;
 b=ME/5TjgC8RFNw6vi8dyk/S/6bREUiGJvuGaDSG0U60ItTWwsjnVfiyyNsCfGOZfzaksxEe4Ntr/67wvv3an+U1Aj4KPysS8nkSupkkvU/FJe2zeC1LQlnqLN/SLuHWNDUzpssmY9CSo3OtshxVhPVIJAxyQ83eOfSQYbiP8F6x/4p2ucZFvgWHb+r2yFjPUMgQMkWaTmb82LTnDhWxnWQeaMQXRLBMUJIJkWc+WDP5IR6HoCFXMa39jUe8yH049ExspUchgBlso4mnhDaJ4eJs+GhXw1qg9xb+Zh7je7wuSZzT6aizC9iLOqdFEDSEIsZWKA/+6y9tJDD2dxYR16HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uBpiIvzQ+FIf/mVKJ/rNByhheMQeeFkpVgyq7VNL1g=;
 b=0bm1ZIM95Hu2po5VIrmizd+Fv9ncJGnqRvFgKqRElRlIYXzQowTdfy+lihV3WV1PSma/Peso1k2KI806AlLVdAxhK2ojKMFt4+eTreYm/PqPOBnatvgZ8sNhmCB+2z4a+ZnYylTysclHG2gFbnkxyKe95P8gfHh4cdAeXtcnxl4=
Received: from BYAPR08CA0012.namprd08.prod.outlook.com (2603:10b6:a03:100::25)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:08:46 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::72) by BYAPR08CA0012.outlook.office365.com
 (2603:10b6:a03:100::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 18:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 18:08:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 12:08:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Restore guard against default backlight
 value < 1 nit
Date: Wed, 6 Dec 2023 12:08:26 -0600
Message-ID: <20231206180826.13446-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e421b1c-59fc-4910-6345-08dbf68663a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3WY2tYIKIKdp1ng0+aMZu2J6E6j+WDyFyC/4bS8pnJ4NF+0+xiWeFxVPnZ0w+fwQkEXtZDNTCEXsdzkt9p3C2cYlf4KwmM6MicY/JSstG8C8t8uOeJ0HNEuVS7SoVj92jDWq/MFJoTWZ2rbC9G4cOJL+QPkb9KtsFvhJD6gKBnb37SLlCMQFl+fYWUiqQ88cBE0s27JJ7B7MfISjIgac9AytdjTgYqUbMnuVjLgIrmjt+/0l5TyISRTMXBSFvT6j/njsPZSDaiFA0vxW6JAQkbO0GoFo2NSwyBLQHTwUzcOotxyHTxRmm2a5d7oeyYJZpN83ha44sZs/HtYRAOt7SYaZhtcXwope8RalJJVzFNd5FZcn/7Sm103hhTKG/vtAAZd5Z/bK2JQFahuXyPis/Q1I07z1hA6Ubh1hOv9Ngu8FSEjzkzaRzO0x1fq4LqP7Vp1Ch3lS90Mhy5u3iz1Fq6vDZ/318nHOzDUYf2/i28tDtucdf3yPagu4s9Wr53U+tNALF4/fuR54qU46kgcCk44WIBsGlsmV0azjtXkmQfTmUHzFSnDYV054CQ1cGhLEVn/w+G5FmccT6hCt/qjH9pbR7dLCVL08gms9eo+hYWm4joKYZ5OtLIgHm+Z7da/NoJgUvxNKckl3YkRayNwQhj/92pRl6SUCpTxTlQONuJGyk5TxoA8QEqZ7+T2LkLaYp8UHXwIKpEwS8VCi1R200fwX7twHmBoJK2D04EPLNCrv46054rxSqVwweAtHU1Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(478600001)(5660300002)(40480700001)(2906002)(36860700001)(47076005)(44832011)(83380400001)(86362001)(426003)(70586007)(26005)(336012)(1076003)(41300700001)(2616005)(36756003)(70206006)(54906003)(6916009)(40460700003)(316002)(8676002)(6666004)(7696005)(8936002)(4326008)(16526019)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:08:45.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e421b1c-59fc-4910-6345-08dbf68663a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>, stable@vger.kernel.org, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, Mark Herbert <mark.herbert42@gmail.com>,
 Camille Cho <camille.cho@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mark reports that brightness is not restored after Xorg dpms screen blank.

This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
Simplify brightness initialization") which dropped the cached backlight
value in display code, but also removed code for when the default value
read back was less than 1 nit.

Restore this code so that the backlight brightness is restored to the
correct default value in this circumstance.

Reported-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3031
Cc: stable@vger.kernel.org
Cc: Camille Cho <camille.cho@amd.com>
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index ac0fa88b52a0..bf53a86ea817 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -287,8 +287,8 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if > 5000, it might be wrong readback
-		if (default_backlight > 5000000)
+		// if < 1 nits or > 5000, it might be wrong readback
+		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000;
 
 		return edp_set_backlight_level_nits(link, true,
-- 
2.34.1

