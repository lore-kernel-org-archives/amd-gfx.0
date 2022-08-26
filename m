Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC49ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B42F10EB8C;
	Sat, 27 Aug 2022 02:52:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E9510EB8C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg0Kx05AyorBEwk0Niil8VKhK6AyYhfVg00+bWtDuzYjUXrhTiqSRB2bbbH4qtbbM3PqA3szHWOnHFGs+U8zKziAPmHk3nYaQXa/IIez84vQRm0Gg5kN7m4DSMVCKA/ta0K+B6SGmDnP8a6Yh/VgPFVvh8ORVfNXxjmjalXPINMKl4JEIj7DZlknUMRL5unLAtChDHGUeeZH7NurTtNGNpVI5o0viL+5kclBd6gxXiMGEfYAxvN+7KwSDUj8yheeVaahmB2nTE4ifbrN5RqR6v8aw+gHsDAJe7O/GKrxUtkh+yDaZGSAQg9odwkHlvg2YGaTr9mo7Qux+aHTBMDZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XRkFsN5vLiKlX3aQPCwVdzeszZuz8JjFvGdPhWbbhM=;
 b=ognJZqKClnWKf8vAxUz5baxhH725tOARnp5KsWJLZKaxN5ErQJxgbLELc92LT8cTKti44b7VIk56UndGWczVBGuNwiKBCdWTIFmCzjBUX/hQTXjkth79Wq8tGbWZcVevvG/wv6kqTMwW5DoYFmS4wz1fCj4nUrRDpoFLwOqpGZjx1Z7b3S/GhxRj2idxJ36ut7Ifzdhhf6rzlqVv/yCqj4k9au29YWT0KEtxOfySYNXuanT1UIv0FZ8Ff/lDepMRKn2ue7lS/4T5sgtac5DozX5cA3pDBSUL8C0vPjhrhiGakIou0vornh8i3YBpkyos+0DKzljqfDGkU0LsFlJYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XRkFsN5vLiKlX3aQPCwVdzeszZuz8JjFvGdPhWbbhM=;
 b=yiCSUVNGKg5lsB5kVSaoW5x/NH3MFq8okSBy9CAYr1sWA8+7sbaQTN1Gl/Lmg4Wzx1H+aJTCiv+6NKOnFdLAP3+UdVcATSLPEfTXMKx0Zb2OjBxhej8yDOuE1lNgb/pSU87dSpnT1TANqiJx56YV0rXPtF/2DzrzBEErzt+2o/8=
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:52:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::38) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:29 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:20
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: Revert "program k1/k2 divider for
 virtual signal for DCN32"
Date: Sat, 27 Aug 2022 06:50:45 +0800
Message-ID: <20220826225053.1435588-26-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826235e3-73e4-4ec1-51a8-08da87d72ec7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3844:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJSTjSkxhc/WF2cPWtGvd8WQLTSQN8uU0UDlylyik9I6K14HSoUo8NtMlfwbWtyws4m+WdfymOy79EOMsVoVSZn2nsPw5ylDWGcbxgz/06CpI8jWkwC8cPyPStNtiQtLG2DUIB3utGbCa2IWY1sy7qkTs1XK/Fvf5GHF/bXz35zDQUI5fudC5IROkTCsMVF6bCBlCRV3QPhmiwdMDnBOycAQaje9wCaFWgZBq+oPCAhBJHURPAjAjgSNu9rptcq+DkyWzejuZ2gcKzjHLzY7pTFYVHF54sRU8LTlhMtMFL8s+Oo8mOO0CwglWtB42vusmTjoQywOocYVeOMaR+pkF0iCXjIIWfMHtt8jOEInGCE0GnIl6C3gVitNMgCdFavJHz3oDYQXiLirYdXDdl0IKmK5HBB+RUoEGVMDO00bf6s8E8t1cGrN6I+pJmMX+yqcByksPLr+dE9RYNwR+RLDQrOVrzAhbXa4ELaRF55Kp4eojWEHDnw8qoA7dhlQZ+L8JfLuhisY+Rpveinnuoc7NjRxLYj434kaMWXJeh0faPrfSrZ459RBcNjpYgSMPdPfyOwLgkQtudN+BAGHgpsf4b0bRBvInl5xXmtinPS4zU1ZnAPpXOE0cerIGfOQgfnYb1SfsOt/Cnft9tz5+VXkXGky9QuVkJujZ92IaCdQCafDNV6yHIbB+f1SGtc5t/i3l/jLXxxK5YiED/GJ1RrEvpAnjO8E8R9SrD3ftvQIpgrcRxQ5CPEiE3tA7V1fAJcUM8hCEE2p5MqsFs5UPohiVk87srSVpP0PGQ6VFt9bGz3cJKBt+218b6gljjlzF+aGXdSbDVOpwOagcZp1+zapdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(4326008)(70206006)(186003)(316002)(6916009)(54906003)(70586007)(356005)(40480700001)(81166007)(478600001)(8676002)(41300700001)(86362001)(426003)(47076005)(2616005)(336012)(36860700001)(8936002)(36756003)(5660300002)(82740400003)(7696005)(26005)(2906002)(1076003)(83380400001)(82310400005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:29.7941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826235e3-73e4-4ec1-51a8-08da87d72ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3844
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
This reverts commit 9dd9c085ae3b since it
causes a SubVP related regression: "Switching between windowed video and
fullscreen can intermittently cause black screen"

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 2d428ec48e24..7717d00b60dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1157,7 +1157,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(pipe_ctx->stream->signal) || dc_is_virtual_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-- 
2.25.1

