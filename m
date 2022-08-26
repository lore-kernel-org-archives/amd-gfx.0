Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DEEECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4941C10EB62;
	Sat, 27 Aug 2022 02:51:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794FA10EB66
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG08i2yJEnHLcU7d3PzPYlb3T9ChWPP/7kBwpxt5TdJpHGsYBZNOJkFr+qjNu6wKF+UnjrmXztZD/2KHezaYYhBZPgQI6xt/qhrxki1kd5Lok7/8J14Qv+RiPfR7780GgoQPfUNOuvJ7YbK0A+P7v4tgpei1om4xyCZHvl4mUxMhsEbrlsPZWeRn/7txLMh/t5haKy9FqejqUg+46k/Eci5ZdfuBGkzbFKkxdndXZ4qB4IKj9/vkjyjSmr8jdyp8F2XKLJJRn9xaBfMNLLGJXx2JbIqw486nmtz3ihyo9H+M7eEV/0m1C3TJOq2zZW9iNOEZsWa/zdJSxTJO3yrbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKHmttuQzskciWgZDMjW0GTtAjuON64k/Ks7sTg8ZB8=;
 b=C+ydsaY+jiCaH04ff4NKqV5Pz7KQmck0sQO+OlnZeF4h6SJ6lp7Fkvs/3dF4BoIJIPvkn5dxtWqItLgBQLqVYyAKUqy5DVojM7N0WCs3pHX6GAeJvr48WhtpFvroGryqe4ySfBUdgECnilA/G7DSfrVePZTrqDUzRhhHanh607ciFiMH8Dii6V8OPztVuAzPeN8C/tgUMZABWXqvPTab3jJNIRH8EPo3Y6rruyClzg1mtzedQTda4qTyZ/PMsZLJs4VrV3iIbGwNdVsKsIZpD/6iYLJR0ltRF7kv1Q/HCNRO8RVr4FVwPfSDjyHhNPIZaQgBdghmO3t6+Wh5AZAcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKHmttuQzskciWgZDMjW0GTtAjuON64k/Ks7sTg8ZB8=;
 b=hFtvy209guGcJs6lj9WREvj0W3F4GMsz0S9SPc15+pHuucUVvKXWT+wfew1ISeXnvgqJ3jJ/r9nHNP9+hR5o2yU/thg+eFu1cvBb1BM37e6LqVwIpU+/L8/nEoQ4HhXpov7ONq5lV+d0ZDDSuZXU1105rScJnmBRmE2XSXotT1E=
Received: from DS7PR05CA0077.namprd05.prod.outlook.com (2603:10b6:8:57::17) by
 MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 02:50:52 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::49) by DS7PR05CA0077.outlook.office365.com
 (2603:10b6:8:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:50:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:51 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:47
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Remove assert from PHY state update
Date: Sat, 27 Aug 2022 06:50:28 +0800
Message-ID: <20220826225053.1435588-9-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c7c736-b7a9-43a4-7a86-08da87d6f4ab
X-MS-TrafficTypeDiagnostic: MW4PR12MB6777:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwURPMug6bUaIUbUSwD178ST5NPFekQbJurzVcTzIaQhAuwL4b6h5ohmnFYnj9cpWh7A/U2fi5trnVNkLcIGEBzXXEd+ayfS2YCnHMQHMdsVQzH5106I7TqlSrO7DO1kbEKZ7D4J6Jy/FQ5RCnYBc/GpnmMN+FlA67qUxLsuXaq33ApG0EjlcCGvjCRlEHhCu5tVWqxyq1T7hb4wV6M3Ipu1xQ3mBoeaXZ0wY1t76sDsoiA3TnSen7zPmPj3J+KvoCM8yomdfk8+FS6ghYRdoIOv5TdC3Luoua6dXZKK1MeeQoWQ1yqfffgkCq+4NB0ETlc44lAboB3U9G3wdBxzf2r4LlfvAtFDwDNsSAHMgoCCxGZpOAtKZMdy8OWKpJ4u8ab0T//9z1jvi2sLaEmC9GUpEB8kRkhoMDuW0cokCeag4+nUf/K/r1CnmIgbvkrpspTHvO/Uyihdoo5eQZLBj0+i58BGMCupG0vKDTmVgp13eycopR7DWyGxJkAfny5tcguZckHlHG2SrvOLQBCPkzp8177qTnzedxnrD3D9O2FG9NCM8PFfaA5jkEmZ5imXdooSP37+GmOjU0lG4ju61BnHrvbgTBAbZdL8PxKo3qLVrgP9jL7Ggq2aIKnZdeI2EoLKexO0mqqD8KiikJz2M1Ffb99MSpq2fG59cpA7Clq/bnWfAu6cl/2e6ZLH0qGn3lmwlBmu8JkDClXFY320kwAWaF2v7FEWlTD7Egw+w4Iza5Oo+1DiBL6q7Oiwni3W7/kmGmo2gHM2kKVgyO1+aVZg4ox5XvLWr8WbrSYC1xo1iLUy0wspwxCZEw1S9RHkkVpbzULzLrNQE2kdI+sLug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(6666004)(41300700001)(4326008)(8676002)(70206006)(70586007)(478600001)(86362001)(40460700003)(40480700001)(36860700001)(336012)(1076003)(186003)(2616005)(83380400001)(47076005)(426003)(2906002)(81166007)(7696005)(356005)(26005)(82310400005)(82740400003)(316002)(36756003)(6916009)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:52.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c7c736-b7a9-43a4-7a86-08da87d6f4ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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
In some cases, there are calls to transition from TX_ON to TX_ON. This is
expected, so do not assert. However, these are redundant, so return
prematurely.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 3b1c6603ae0c..b7556111ee44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1224,10 +1224,8 @@ void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
 {
 	enum phy_state current_state = pipe_ctx->stream->link->phy_state;
 
-	if (current_state == target_state) {
-		BREAK_TO_DEBUGGER();
+	if (current_state == target_state)
 		return;
-	}
 
 	if (target_state == TX_OFF_SYMCLK_OFF) {
 		core_link_disable_stream(pipe_ctx);
-- 
2.25.1

