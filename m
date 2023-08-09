Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEFFC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F9910E453;
	Wed,  9 Aug 2023 15:07:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0E10E453
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXyADLnbRU8LfeR1b9UlsI+xx/yBeDEFs0VRaQBrYMFvp0jwD9fQvFr+j2UNrne6xCUvIAUiHl1tee0Rd1zLDKSq8YuaL9GxKKuwq2l0IqwE96Sp8c4QtdTDXXo1c29+yn7MBrgZwfmytbSAFcuc2FBoX+UKX4RLoLo6kr8duSaFOe1LpdqfatWO1UbH4H81NqWaQyL56LQrhXJqHKGXoYI8T4LOpeTMPgahT8cUsG/zgnK+vjJXzV+NNWwZ7igC5mBFJvu2akhvNqquMdma9cC3BmF6MBfMgk/7p49Lb6KhKUfsmnigpCRUuaRVNacRm/qDMBex0EZnI1Vbez4fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LztwETkV0WHysRgJS110nIcKePYHCYEGucZ2CSw3jyw=;
 b=USyg2olA/+DWqfC90wvIMyLouMxGJR+DSNLoQJ7qMMYKg+nX7MSVEyJPhuXYvhzqRmGeMHA/K0LVtwaNsdjsoOEMPc8BD0bD/pAW4FlxonCJffwCZQVueRxaH5PoogmMkls68Kimm9/I4vufC4Exl6Y+QkP5PhubBfsfD15jLZRSn9fs0wlkcK+Lo02VjygbGomOYM+7HxB3kJg1gtahzjuEibKK6i3pGxblL4tNhxKrVzR9KR2OW/JZOanVcxC0G0icimsQamdj4TVe47E3Y3XADU00W2Cdtsczh2YR6OsBd/HI4QdtJ8FCV+EWxDF7Q08SEl2GC1cULhPTh3Fz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LztwETkV0WHysRgJS110nIcKePYHCYEGucZ2CSw3jyw=;
 b=WdL5MsbGFDP9QOTF64obeQesWje615ylPYZK8zTDj+yq9LL+dQ0q8MqcHiDvUioWzfNSjilSFVJXlEN7CfFOhAGATUD5nrbvNdZ7u+7gc1OmIMwvb5MMWa/i9SMF1cJ3ucW0Lzq5105MNvuzxpuELtSQxB49ZmQjjLFI9LJURvg=
Received: from CYZPR05CA0043.namprd05.prod.outlook.com (2603:10b6:930:a3::25)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Wed, 9 Aug
 2023 15:07:11 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::c7) by CYZPR05CA0043.outlook.office365.com
 (2603:10b6:930:a3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Wed, 9 Aug 2023 15:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:07:11 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:07:06 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: Enable 8k60hz mode on single display
Date: Wed, 9 Aug 2023 23:04:53 +0800
Message-ID: <20230809150620.1071566-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ecc402-cfc7-4f28-f9eb-08db98ea4ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9NfC6F/IDHuSZk3ODihY0+nOBH62Bx5A6munbOyn+F+TZjggIpgV9MuZM/meUeaJVtN3M4+YtimcddorHkRlyffv/T8RZjZJmY0KKi9ppufwY0irQoKJKME7TVEfB4zWED52jyc9ri0U5RmTJ+qOOxraPcqM1oLexB9T6x1VxWHUHV7pk7sc7CK3+mIx+NsFGcfilhlvqJUg8rfL1xA0RrgmansIcsO+sKs6g4sL4AJAjF96VeTC7ZkGbP+AMkhnmhQkjL5iivs+wvPNJdb0w7k25msYZJ/uNY3a5rL6F2qc7MSsgn9IfqgmDQf4HazrnqYBXUtZ6HX1br/FMrDC8JWLCjqAX1AZSO/UVwiC+NkmqdU5toWF1QMTKlvgcCW0HKSkb9Fgj9FhUkdkPYOuXIyL7QASiXMEaEjVwzPzp8FeK64mwCZHp3EAPcRLwCXjhckn2xqpdD3n822Gu4PytPwxXv+ikHqTOYbt3FykUEzXu4P4+I099a/TRjQr9SwTaM9Wbh4nGSKNuDqqgVryghiGk+xR1MGaHsDwr6YgFu+3FdzFfxUu/UJLIIVj2rAryldwvPLORq9iMkuOB6FwiQLZLTnGui80J58bB+4d5JMm5EA7KzVEyvGhmQCYv+H/NLtB+zz5cvF1YqUXfX48pkiWO1uO6EP61Ad7ucjk6IZNhUJOgLRgDNrMjQKBLHE9R2wZmLc7aYVNr3pG+DgLNdgvBTjlLO5WJW9D/Ouvhjz1bGi7f0HYrC93+hpN348gZWcYS5cUXX6gW2GxKGrQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799006)(82310400008)(186006)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(70206006)(316002)(70586007)(356005)(7696005)(82740400003)(6666004)(36860700001)(47076005)(426003)(83380400001)(2616005)(36756003)(1076003)(26005)(16526019)(2906002)(336012)(40480700001)(86362001)(6916009)(81166007)(478600001)(54906003)(8936002)(8676002)(5660300002)(44832011)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:07:11.2830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ecc402-cfc7-4f28-f9eb-08db98ea4ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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
Cc: stylon.wang@amd.com, Nicholas Susanto <nicholas.susanto@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]

8k60hz compliace test failing because we restrict it single memory
channels. Workaround by not restricting it on single displays.

[How]

Adding an additional check to DCN314 to restrict 8k60hz mode if it has
more than 1 display connected.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 5e9459e26469..4e09ba4f2806 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1689,7 +1689,9 @@ static bool filter_modes_for_single_channel_workaround(struct dc *dc,
 		struct dc_state *context)
 {
 	// Filter 2K@240Hz+8K@24fps above combination timing if memory only has single dimm LPDDR
-	if (dc->clk_mgr->bw_params->vram_type == 34 && dc->clk_mgr->bw_params->num_channels < 2) {
+	if (dc->clk_mgr->bw_params->vram_type == 34 &&
+	    dc->clk_mgr->bw_params->num_channels < 2 &&
+	    context->stream_count > 1) {
 		int total_phy_pix_clk = 0;
 
 		for (int i = 0; i < context->stream_count; i++)
-- 
2.41.0

