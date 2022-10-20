Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E413C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708AD10E437;
	Thu, 20 Oct 2022 15:48:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CE910E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhBtEoUsh6L0+k7Z7nZe/AhyLLkQ+7O59NgubhafwWzzha3sdBY3TSideR5eQmKLrh1MvoLpeou2tZKW4HOR+w6HhlmF0gv+697uhtiyAypTQf4kw0Wx6ZIQLV/Bfr+e07/6OEHZRQYyId5JAYCUio1e2Tc0zIGZiiCytuteWtNkmqrIb0iFZT5uLLuk8Wnlq3o9rvD71bHIEfWKGQNPXV27qpwW4vf4r3Ik1KBbGf5QynGElS2IePA3XLRItljZZWZfORDroFkp42Oc1OdP97R+LphJc8L4XO5ZLlRYHytXpYzzkIlB0URjzI/1zeBtZgBOIp1feE/bw/Le3VzF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6thqgYY25rOa9FzWoOV28oRtL4uobBvUHBjuNfNI9iE=;
 b=ADQdKKjDNKQtCtenHnubrTcpaeLcLp0oquyUFVmTi2LLBkGlVkWqdtzMJoWE02ZidaUgmQqyGTaxn7vwSQli2cLH63FfK3AJAADAO6D4d3tey7t26Zy+mNppE2RQQz6pqu3jDxgkuBQBf3l3cgPCbaLnstCLjdEL26fail05FacuqSus8hdjvQbDWlwdUaZSdSi/qQ3AwLay6jv5SALew4ykgWb70ffoAyF7frxeM7gdgdJggjJDpMAtxl2EfEts6cDEt6L09r5zc0HVkOo8KikdGpuw+xzn1IpwaY0+dTiRsTeJXQ+qXDhTgrbFsmXeG3wgwx/Sf1tIR+BHKmU6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6thqgYY25rOa9FzWoOV28oRtL4uobBvUHBjuNfNI9iE=;
 b=BMkSOZ3Ss6fA02F3DSZSndtRAEv4xC27kG4EH0MoJ/BIcvaVtTwnivWxA2ucC0hJRSGJ+XzMM4IJ+M7LUsHNQJAcFmcBur+xfu+RoZfUKrx7iQeUHTlrWPwFBBLX6zU4rEKHaOfg1KFma6QE+og3x07CzjC8XVhYpMqO0M7xpbM=
Received: from DM6PR08CA0057.namprd08.prod.outlook.com (2603:10b6:5:1e0::31)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 15:48:02 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::4f) by DM6PR08CA0057.outlook.office365.com
 (2603:10b6:5:1e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:01 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Set memclk levels to be at least 1 for
 dcn32
Date: Thu, 20 Oct 2022 11:46:48 -0400
Message-ID: <20221020154702.503934-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b31a5f-6440-48c0-2349-08dab2b27861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMy1g2Wdtc7GPM3huU6UG5vdBJ+/BuIY85tQ10kDKAaga3gpTqjfsPWX9h/AGnSl2LlWgePxBN0fkvlGSpdJ/ofulg2y/hro+hpDRU4MBhzZxTk2kznhwUMx/JJmAaCd/Tj47L34560V1YYKJg6H+SNioBEhFF8NXNbf7TQlil6znLopLvDXN9xN1i6Vl1ulT3NDt7vWR26lLUf0U1VP+yIzxgdXUzYXmLYm66NqDUXaqNyrB9Gqh0K1Jt3cYYTvQiiMgqXdq/bCVSychjBmcF3YziDqxK/fE4jrAFrwxTzfOA95qZhGjiCm1iSr3wqC+6URtkmzzQ9/F5DH2zsrqMyr3QLLH7L+nIz+gqTE1+CyzD657nMmBI+KAJlnRSgfrggpK8cbVRO2Cgje/q1p6GCGP+9unCX5xT+n9nChcw7+HxN6nAL561YWVaBsALmhvC4RnhXJ5tHXIQujm5eu5IHx6Xe8VPVcgwVFbV8CWdjsu5pXvHAn3sIJy8oBs1C1tlTOqDGIxQ4i17JGOnOQb7s20sDccmJDK7LeMZAzurxCgKwWGyLeG8Yag/TJWL3optJSlcLIZnObJ3OAs+rWQwLgEc3HCBg6l62gXFsXHVZZgskYFMp2XUroinG26hfK6rR/eaFhAQ2yJS7JrzLRjAhc50/tGmfyMUZdxlZmj9eWHv5DTRJU1iVBB6VURQPr/TJy5SBpNzJcUoCg2Mpx+XGh1xIHxtzEuJpMRzL2CYOj5w7xUaZmjDqYYD0+3Wud4SnMKlQH1ftJ70YurMJOinZcmDqVAAXeyCrnxwb7Uzr3lkzVtlziKSJ2cQyQ380D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(316002)(6916009)(6666004)(70206006)(8676002)(4326008)(70586007)(7696005)(478600001)(2616005)(5660300002)(81166007)(356005)(16526019)(1076003)(41300700001)(2906002)(83380400001)(186003)(47076005)(426003)(8936002)(26005)(36756003)(40460700003)(82740400003)(336012)(82310400005)(36860700001)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:01.9120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b31a5f-6440-48c0-2349-08dab2b27861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why]
Cannot report 0 memclk levels even when SMU does not provide any.

[How]
When memclk levels reported by SMU is 0, set levels to 1.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index fd0313468fdb..6f77d8e538ab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -669,6 +669,9 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			&clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz,
 			&num_entries_per_clk->num_memclk_levels);
 
+	/* memclk must have at least one level */
+	num_entries_per_clk->num_memclk_levels = num_entries_per_clk->num_memclk_levels ? num_entries_per_clk->num_memclk_levels : 1;
+
 	dcn32_init_single_clock(clk_mgr, PPCLK_FCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
 			&num_entries_per_clk->num_fclk_levels);
-- 
2.35.1

