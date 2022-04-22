Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B4810E4AA;
	Fri, 22 Apr 2022 16:46:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636C710E4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw+Gk5ZjtMHVBtst4rw4hbROpYZX67oVrN4pu5b4YO5kVFBZOBJns2nWNafzJv8FApw59DvFmP15Jsn2wsz4QZ05Q6OwOJ1QB+cd2LRB1gBsysflQVyczjr871uZgyVqwc46o3grUWFTNouWWKdAGv0KPJzlvbQAiDkwjou4WDJxkp+W8Hdc+MqzjDJkDtA/chAVOSplZS0+h9udEoR7Sfd30GzdaJ7x2S4H3oN0TawUN2qtuTYp+LJwu+X/ce9rSoANciE9BsKbAv7nYmpWdvue3Vs7rTMSN3Uo6ZuLyfHV9+OeIfzsA5EyEjjFNCepyAUs/wy/AYhR9mh84yAAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Ki2UsAHRi436f9WGX9vYnP1G2Bfxqvs5nM8hUu/T8=;
 b=Pa4yomS4iUXr367wN8TAVmOL0xtEnlWrY80tRBFTutBbxQEO0f5CWHFN39iNjP2MTcT0Agga8Sy2/QuAGGDOTnXZYyMBdNZDmCDbRpX0Yk2Dqxv/2XykeDJw95Cj9jJdYkVxP4GNmVuTXz83nndX3Uy6HkOJmqKNzHl9qEvzSqAeEmOBldz+JAoN2dg0ZA1O4Z+5XdihiBvcVaidaM999K0xLLK1tgWGk00UB8kk6LeMvrR0dDBdq0ch5QHik1QOEPPItjl/tnyV5LaIZOTlewvOZBx+MBbAA8LHnH5UxWp9S3o5J2+Zf2ZWDrjf3gk0m0JUDOOb25N6HRBlWKAKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Ki2UsAHRi436f9WGX9vYnP1G2Bfxqvs5nM8hUu/T8=;
 b=YnpqJjOdQpamJLtsuu6eN8DrZMzGJcxZOxgxIZTMdY3Wv4TrjVdgbgP8ekY+rCBv6zAn+48TlPbF4YSCGjh/iHc6Wy2yVMHPNA/jNZoh5yRpzLIkswUAgXGjGVIpVPJzL5ShyKsaSxiEmEc168dMb+aTzmMhtPtWnlC2w9jEaqo=
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 MW2PR12MB2507.namprd12.prod.outlook.com (2603:10b6:907:c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 22 Apr 2022 16:46:44 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::1d) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:42 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: Reset cached PSR parameters after
 hibernate
Date: Sat, 23 Apr 2022 00:44:50 +0800
Message-ID: <20220422164457.1755751-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44750053-7878-4dc2-0fac-08da247faeef
X-MS-TrafficTypeDiagnostic: MW2PR12MB2507:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB250735836C0F50695A0EE3A2E6F79@MW2PR12MB2507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: al2+W8dzJAaS9aItiPeLGPXN2YCP0fY/sw1EMKvViTh7lnkratsQ0vDdsG8oK0j9Tfgbl2+B3Zwsr+oXAVKUcznSk0eN3Fqfg8PhxZNKbxILGX4qRLPVn58f/uBfrJbtwCkQgWnZIncEwC5zTcUMOuSerkl8ouvafuqlxjdY9HTQjhbw7GIl3/bslVdAQKx6Ygpktyw4QsfT6dzERvSaIqEY86ZPJs4fszsjQcB3Pqi16RHhh+hTKywzL2Dpw2mOMrpZHu0jO0kCdlLave0gNWmcJSoSpismyYhzaR70whj+m27ceNou9/DadRgDmjL1PBZ8moBcFSPOFzTpBE2q8PqC7CQr6s34NKfDngT53o3JMyhjCxAY9DBN0UsA5TzHPKY417sQoQG212SBQNqjCzf086OqwpdKfdh9fGLp6mQxVk4ucnH0csmpbhSjPbi+UWBZilcBz+BdWMbte2b9S1fSuZmDA7pcu1UTrpJXh8Mx+Sh93IG9uzY/qOtG14zR3dWa5NreNjICQh2XuXDQ8Kg48I2Vkgb1iPsbhfSD0rG/dPTZMUag4/IMnLzmg+XC2liP6jlk/HWD/kf2eYPm7XpmGTnxSuDsF20DgoEOORvDoP80hrO98ABw3OELTKAAsTi/UkHJf8BEw1vnjdu46OebajY9kUMkB5WmSXZbM0+TSARpuGdHETHHd3eKlDZ+I2aYhOA8lcJf8I1/RCQlrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(40460700003)(186003)(83380400001)(47076005)(426003)(86362001)(508600001)(4326008)(316002)(36756003)(336012)(82310400005)(54906003)(8676002)(70206006)(6916009)(70586007)(36860700001)(26005)(1076003)(2616005)(8936002)(356005)(5660300002)(2906002)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:43.9602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44750053-7878-4dc2-0fac-08da247faeef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2507
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Harry Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[WHY]
After hibernate system might be using old invalid psr_power_opt and
psr_allow_active that never get reset

[HOW]
Reset cached Panel Self Refresh parameters when PSR is first configured
for eDP in dc_link_setup_psr.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d13ee32a3db..1eddf2785153 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3317,9 +3317,14 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->frame_delay = 0;
 
-	if (psr)
+	if (psr) {
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, panel_inst);
+		if (link->psr_settings.psr_feature_enabled) {
+			link->psr_settings.psr_power_opt = 0;
+			link->psr_settings.psr_allow_active = 0;
+		}
+	}
 	else
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
-- 
2.25.1

