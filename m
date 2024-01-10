Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48761C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E5F10E7BA;
	Wed, 10 Jan 2024 21:58:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B4310E7BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aix5V9lCb1mvx/NZtpy+endApH4akRgV8HZI+NlsKaZWCt77ehNSi2k1xncvYSV3VpX4ZGyLt33WJfs1CIAk1NWvDKlktq8Hd+9rw3lVwbI17okFCIA3M8uZCaTkenqePhurC5JtmTdPn6aiU1z8KbVNAIa09V66S1EnV4BChdCgjRbfzTmfdvNmcOO49D2hG5r5dUHXeH/GNjotlAUG1AogescFQWlDC+JvSkl0peuqSqaP0h35DDDIvkZDMg25HGiVk/l4hwKoBGKo30+LfSoJByK81gt9eLmI3GIzo+UoTKC/4W0hSJM6cuSNglASNhn4KfzQun/e1qlw/YKUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GngoUDXmgyCO2ojcjN8YiegzpHiyWUx/ItFfJ/qajw=;
 b=fF3WL81YbfQl02aNls4r+l/lFFA0e+BQ19mNVRjOUgwMnKrZQ/pjx9tDRVeUxilJvPvZNZbvxamKpOCqt+CbxzaL4rJ+EaZXhfCrZ4I0kaG4yDWDz2OAUBip1yRC13bMo0o2erbfG91khyO74FxdAo7cFTJMoQ34SqHDn4xmOFy4/nFYFsZh3vMQNU9acWpBUU9VsEKOyIUuzeTinYMfWX4Wh/hWpzlASp3MCuMsSzjDnFvWE4PSXeZ8JkjoJGMZHCBKdW/3iMo31EAFjf6Xi1G4H3SIYkXWMpl6BG3z/JWEgMNcFgGHNrXTCZSQUGKaSFLolCK+Ch60o7ClVDgDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GngoUDXmgyCO2ojcjN8YiegzpHiyWUx/ItFfJ/qajw=;
 b=LbOHkMm63AgernpN32dODlXv3YPvgy/9M5yJBgRILGXZgqaCgVYBBx0zcoSb8krE2jiyP/I9xHUDqwtTFzrcKv7s4lsY5n+tj/MombrMNTId90HDqgwRpHhlL3VFhP0X9mZtHHA6IFjaSV7dWQTuXVHmaEuivmM15vUVSmURjCw=
Received: from CH5P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::15)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 21:57:59 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::24) by CH5P221CA0007.outlook.office365.com
 (2603:10b6:610:1f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:57:58 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:57:56 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: Allow Z8 for multiplane configurations
 on DCN35
Date: Wed, 10 Jan 2024 14:53:00 -0700
Message-ID: <20240110215302.2116049-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d75668-85a3-42e0-e4e4-08dc12273560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKtWTv7lHThIVsVgHIF/6ktUZrfA4KvkQtY3SahH04JPBrWH2AGIkOMkhxixyzuXKNaXoZSnLiETX3Y59vfFvu2LaS1BgR+VBMEbsdR49uiht/C3j+s8/vYaoi+ULYplS/tFnR6qYH59q1A4vXWxZwynk5+lj4EE4p4TPEuO0EKdwsNDO1jJZzXuS1EwIFyVMEf9ZlTH6EjkYpUNDYroFOF8X8qLnfD2jCxYRVtTRcDdI0SuoX8AlY3p5auso/wQte1Ido/v3ttyylnpASbGwvSiK1AQAh49g8med6gs4dcNscjjbI99cFnxEAujiM4sZptUGARNO9SivGjZQ3i6rPf7arhUdF3NXAM5TTtGiLKxO/9RjrY7WPuh3jxyCp4iU1bjJv0ii7HaCx4YYM/1Xf5rCob3Be6VuULPcDoa4mgWqquzO0NX86pnxaDkV5OnaBvRWAYLMpI34Hju1phA8oZZuu7CLCJqvkt/MsVfDpWBVyzQqfYJvYAyXUGrCm252wNnEYfqozWBjAQOfGIrljcyJanCIazFkhuQrLWwkH/5gR1s6tW52s0oL2tKY1is0kog5g3c3d1zjb0wCei4kemKt9/1RhWmgw1mNjm1pwiqf/jUlRSDwiyQdOnddiPP5FcM7iFwzsnyoo3BoNcd0VE3zB4DIZn5krpMiAecG279z80DgGWJwwND1TuREPo3DTRx7APRdNrGXU/OvPv+Nh6tGGn9ncVoVrEKvcflerRchQjrmlrhXie3WJ3yH7FPd3wcI09BmfANdi1TZQyiAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(478600001)(426003)(2616005)(1076003)(26005)(336012)(47076005)(6666004)(7696005)(36860700001)(316002)(83380400001)(41300700001)(2906002)(5660300002)(4326008)(6916009)(16526019)(8936002)(70206006)(44832011)(8676002)(54906003)(86362001)(70586007)(356005)(82740400003)(81166007)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:57:58.7553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d75668-85a3-42e0-e4e4-08dc12273560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Power improvement over DCN314, but also addresses a functional issue
where plane_state remains uncleared on pipes that aren't actually
active.

[How]
Update the check to allow for zero streams to be treated as z8 allow.
Update the check to remove plane count on the active stream case.

Z8 will still be blocked based on stutter duration, which is likely to
be the case for most multi plane configurations.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 475c4ec43c01..a85693caebd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -583,9 +583,9 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 			plane_count++;
 	}
 
-	if (plane_count == 0) {
+	if (context->stream_count == 0 || plane_count == 0) {
 		support = DCN_ZSTATE_SUPPORT_ALLOW;
-	} else if (plane_count == 1 && context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
+	} else if (context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		bool is_pwrseq0 = link && link->link_index == 0;
 		bool is_psr1 = link && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr;
-- 
2.34.1

