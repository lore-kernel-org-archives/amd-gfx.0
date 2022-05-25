Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E8AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE8F10EEB9;
	Wed, 25 May 2022 16:20:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394CE10E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haQbHFnz7Zy2u7dkXjxxGylBCNakJoXPjLbaSqqadEBfrmiJen5if0GFQEakuNwU4LnlpcLukYqyD2gDDTTX4vQ2zx1bS9IqPJHcV5vm7FMvUFKT8gOCxOTDQAd0KXJ+6zhcDVGf5AaQTugzqQ+hgChhe1TH/MWxVRVUmMdmtc3f79UD6Y08qUmdIpTxGbqkFSNi1hSq+zotzBFSxq8LUMgHCVk2cG3VcZXjiIMK3IAiibc0qnVzCUTAPDY9JZ0JHzBVkEYfMH6ex5P5Q3ond1xq64ASvajAOTvJ9QTd17AQpZLV1K0atgRBRFDKY2xvRac0uOeEDVBdG7/fJgbbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQu1QSskUXgRvrfLigqxqbzKmmWX3f9oy0MdseSQQ/I=;
 b=fOl+TWLxPSHYkqc1/jGf/HD2ZiF+gKQfzmefXv/27/Fmiy0cbTzYF29uPp8yxnA81qiL0Gby2CNNcNyMac4O4hBKF2aviKWyag0Lq6YwPRcoyLMuCgG/Vf0Zn2W2CG0gXS/2zKy0q0TYPsMstzvZ/eHmVHVHcXKYT66r1qP+dNk4XfYsiZHneb94WWkrOTWcUZEkceXM7LPpE6dbs3VUKywIyhERrFqnuXuGL5+FKXlDeG9pupzCja6y+vRWEG/B9csVGuPYRyMK1NWR6fR/f5TVul+jmjQg+crK2REHefZG5+lFtQTnX/GgzFTa+0fj1uit7UGwr+C9P6Ec2l+HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQu1QSskUXgRvrfLigqxqbzKmmWX3f9oy0MdseSQQ/I=;
 b=N66X4Zc1LUEhOpcAYKq8q9Whl2rQfYE6otcaXp3TQ1KqnmcQnmlvB7WlQyc7PKgiFoc5IzMSJkWDZ8yWA/acVX7SsM0AH24tM2KTaT7yYV8qbDEzKcYTeGyG7l3Cf4kdU4EzNmbIKAL4ui66KgBzKSyFvXLBjSZ7wuoIQWD+2+I=
Received: from DM5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:3:d4::30) by
 CY4PR1201MB2470.namprd12.prod.outlook.com (2603:10b6:903:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 16:20:14 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::85) by DM5PR05CA0020.outlook.office365.com
 (2603:10b6:3:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/43] drm/amd/display: Add guard for FCLK pstate message to
 PMFW for DCN321
Date: Wed, 25 May 2022 12:19:16 -0400
Message-ID: <20220525161941.2544055-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7942ad-8c6c-4dd5-24e6-08da3e6a7329
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2470:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24707074FB1F840FCD7FC6E8F7D69@CY4PR1201MB2470.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtqNL8UXfVm+fMdTkqOANofM3l7Jxdiqd0nFKLR/nfEQ7SUXpFx98TjToww78CrJoytimyd0qmrBckS3Eqg68rExbd143uwAcY9lsQBYjnqCoNGBd8eGcKsHIvS8r18iO6wNMxeO3zZLPm7xhgkM12UpWtXKzh3MLItrdMEWLJ9uSBlzkfrUo/KDw91lsVOF8EzSRKfmiI+8CRjN7oFTN1nYYYAstEarjKQU3t2xHanwtIt9HQSgU1PXJ8ZPnpAmPssneKQjxpGV5pBJgEYSlT9ajMNHcLS0Pt9slNUJIf3qKEdmbFut1C8eff2WIL+vFfoNz797YTO+zddFzE/wEVeL/pJVbEeDld7U7oS1MN/KKdNkkHHySGvwQk9pRYh5w5QZwEU0QYUvT2vprnZQTafHxckCrLciWwkgkLV5V1v6USwqtmLlU78C3YRJrcNLlyiPVefnq3JZtPrqzKIHxiM/00wfGKZ1RqmAM752BixY8uwpaWupJNOAkVmg55ZZoYDmKuUJwijWzOIUSaZf97Ba3SDFK/8v15MaXKPjPPj2qdkty7JXvIMmuxMD4ZUicpo9IecjjUJamamTYE5EkTXP4ZDsCsSfmA8tjvwFtWtTkvbCaF7xgovbmmthc7yYHcwUqA+oUQCz94AvXChqFXt3iChkV7U6sy9+S/2mHvmP+XcBRn50EK1khBuf/Ce9DRrrIEKlKxYy4sWTLLq35Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(54906003)(2906002)(6916009)(4326008)(36756003)(7696005)(40460700003)(82310400005)(86362001)(316002)(15650500001)(356005)(36860700001)(70586007)(83380400001)(426003)(26005)(70206006)(186003)(1076003)(336012)(47076005)(8676002)(508600001)(16526019)(5660300002)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:14.4940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7942ad-8c6c-4dd5-24e6-08da3e6a7329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2470
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY?]
DCN321 does not support FCLK DPM, and thus it should not send messages to
PMFW regarding it.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 419cc83b3d21..4ff12b816614 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -346,7 +346,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 	}
 
-	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support) &&
+			clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21) {
 		clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
 		/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
-- 
2.35.3

