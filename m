Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98C6ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0526B10EB6E;
	Sat, 27 Aug 2022 02:51:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753A510EB6D
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h47utiiTx55UBDp9dzfhZ14cIjqFV3xjyG+cDMVdoksIw/zKcmFOWwI1ct4o55X0onbfrz71V9E2KsqWPCStPJmvMTcCPrlXPCDCDr9ZP7FwLNq2m9/pNaxtWgjV+YGdrj+8XiP6qvjVQiJglxWAKYLz7Okmmmg63wykpxTsaYB7OmNzUQtsKrLXW6wcD9Pli4xkKK5KmI1bY6vCLZtyoSdgMruOdkpYgiXieeUsRSpnqhQTIkvojm8jXxwD+iLpwxJHBEjB/r1vibXzHrdJruajxbNCmGsrBofifERGGDF/4Y3dOL0WsI8HVlwxcCQI3UpS70sxj2b6NwUvdirtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FeJOR7xCmH+m/UUg0l+Fn7MeYEfDPR9WOXd3/0Rgvs=;
 b=OjQu3nPwdS6xeSKd6LP3fydZdefDunEcqsSnX00iy4+IpFz9OzETVb9Rdjou7zQDXVrNywVfS429bwzIMPM2AzqIGm7stBsBsba9ZmSzUD8ROwc7vwOfZik4VhIJau83+hTTOLvlIFfOxW5swzfPSihjcxgT9Odj+RIkm83XI8AMftumeZKtTJHujS6FowAEftmNaptSrDTtSyBgZ7h9D34fol0UHqqbSpWqVMjSsaZj689cstr/ekffz5UYMtm0H30k5PNr2WNHmXcGDgyKhiguESKn+gNiwfS6UPGzZ4Z9xlupZz2ZGlYKgKBqNcHkbk8H1Jya4jILh07OlTP+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FeJOR7xCmH+m/UUg0l+Fn7MeYEfDPR9WOXd3/0Rgvs=;
 b=bYJREHgUTP7fvpAkmGlP4UVA4dg7RB+uNbNizBDvOCnJJyFbQ5dz0rriUwtaWUPfgHXG/UMKX98ca3utN3jDxMJrxD3UuzTbtyhSRbBGrgbu14e/UDtvnuIoeLw1fYkY5s8gKqY1Wr9Mf8KfDREqyuCEHx6dTouOB5Sq/rhNZH4=
Received: from DM6PR05CA0045.namprd05.prod.outlook.com (2603:10b6:5:335::14)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:18 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::72) by DM6PR05CA0045.outlook.office365.com
 (2603:10b6:5:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:17 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:51:16 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:12
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: Allow PHY state update between same
 states
Date: Sat, 27 Aug 2022 06:50:34 +0800
Message-ID: <20220826225053.1435588-15-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33db2e36-6299-4865-e28b-08da87d703db
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmcZRcTf76GjK3YZjezljWyhwMq1T03atFzw9k8eoizuWnBx6hJnUWlfUEUNatvIORTbUpUe4UjW6XksDID7Cpswc+99sl3iCiAKoIPfiH/0bIn1FS7XzroKPUIerOSSkmJT6nWauwU6XN2SiFZMi+umZ5gW14xpNWTkP9p0PkNFONfWFLl3rTmpUmwRXVMtFXF9GW2pxwZhT1NQdfJRbUDGdFNwwmdV1ZFAaK++zBbk4DDFhfSbbcpJxeMmAVxxoYP4xGhflkYKvGX4n1nAExZI9r8eYXP/BjNs4h/MdrVQ3x0B6lE1vK4G+rukN/INtYIPzsxtRzA8VdHwiSdDkrZe5sQ5VvUFFidHzPuChwR/ax+lhMvWJ2KI4H7VA/Cga86rYzB2IFrhc4T1c+6k0KI6NtRSI0kFD1ksvjFklXaY3A5blKvN5msSzoG5tgr83ACR+HBmxAcisVIS8wIGqGXjqhlysbyoeSMOTyUU+BfL5U325VMaE3fF8NkPkA4wKUrLdgB/bYQjbbz0Mi3bFRCzk9kQnj/hYRZiDUPjLG7Yl5EM+vLZOyJXIRK9AOiM/py531IgdS5ua0LYHlyFhB4Y5D+otKYbfJe9OFdJ0FeW9yAvnJq05BeJf90SP23MAKVmJpfEECg56A9rqrBZZs2Eawgw8Wq+MU7617Zoj5lB7N57zaagOzE5OUx0cRabMWOw3P3wwLq2cHfFu4k2FVAAjgH2cMVXnHDFLpPS4KWMN3hjDfl5tPoZKTSlcxspavJbnscduNQ3B+lG4Ri6ugUH8/BUoYGsWjsZxNmbZyFIfTKu0OC1uis9qNlYn+dxbd0Y3BueqAjKeuNumnH3ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(7696005)(70206006)(26005)(356005)(6666004)(83380400001)(81166007)(2906002)(47076005)(1076003)(186003)(336012)(82740400003)(426003)(2616005)(86362001)(70586007)(40460700003)(8676002)(36860700001)(4326008)(478600001)(82310400005)(6916009)(54906003)(36756003)(8936002)(41300700001)(316002)(5660300002)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:17.7713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33db2e36-6299-4865-e28b-08da87d703db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
In some cases, there are calls to transition from TX_ON to TX_ON, such as
when using MST or during resolution change. This is expected, so allow HW
programming to continue.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b7556111ee44..63648e2056a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1224,9 +1224,6 @@ void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
 {
 	enum phy_state current_state = pipe_ctx->stream->link->phy_state;
 
-	if (current_state == target_state)
-		return;
-
 	if (target_state == TX_OFF_SYMCLK_OFF) {
 		core_link_disable_stream(pipe_ctx);
 		pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_OFF;
-- 
2.25.1

