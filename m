Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A71CC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBF910E4F3;
	Fri, 24 Mar 2023 06:53:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F309210E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArgCz7I9SOt2iEL/A/Gp8TQYjUii0AKqE1aum8T7TvWUm/nTfkuHb6IQb1NZKJzEBpbc4fPuUku+lTQ5CPboXGhxD2b8FvF+TiNdJUG5juz6Keh7a8w7C338mqXKOTeS7ch0pWfvmd0GrXvYxlWCp6aoSNNfxifvXzbL1HKTMwwwIbg9oCTysIGe0sauvI2mDO/ftg5Hf3zlLmbc/hvx3Hh3Ov6IYyiJOvu45wM9QJfjwbWaqjOKQ95Kw9n+g6B5J5sT8crhh/OjQ5mzOzsPOUqQmUbXAwRzkKSS4MQwgwMSBTJhTi7TUrnqRMAlpRd/OXcAA10IR+7TydL4OtBUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXfg+9yJJu49iZ2bbK7O/62kwVwlsYu25RSaBas3RNQ=;
 b=ZyE+xa8jQGQukhOT+9bQEMYJjcOZDvGz7TiuGwen9iNRuzs+EKMUNomT/oIe2UxfKFVcNHXxg2WXpsX2wGNCROeP5vrMnEPrjbw9wVQUPhmobK4tvVa+LsLnRQrzYI7ReaAN1Yti5KMKGEaNZUndjW8lT/xs2fm9KT13iZ0GWu9vQPXjhHf0YLuLeFjkD/XAMRrpthkwH33E5O6GqIN5twDkPypDogBtjfVq/BXwvn5EyAFzSYuB89wdiBUO2s0nuMxbcCgPgU3e+sBOTUGuBU/69A79Wdy8botsxo9m3vEhkvEX+VAarlgiP3bVdiJHFXiBp1n+M+jGzlSIDqmwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXfg+9yJJu49iZ2bbK7O/62kwVwlsYu25RSaBas3RNQ=;
 b=Kz+eD5qKo8mmODin6AInu2w5FYGklFRBoEPB0LT+ErjWdCe3OEA1Em8Wjfl7XbAHKSph8WYj5gtNZ5LLLJcgB5wAJLuXNas+nuNFDmGuVTMC134ZaJUu1TWKmlJFD6M12GFBMl+W6w7svliKrvd/5bmdHvDcaw4WwQ/lW1XptI0=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:06 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::5a) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 06:53:06 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:01 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: Only keep cursor p-state force for FPO
Date: Fri, 24 Mar 2023 02:51:06 -0400
Message-ID: <20230324065111.2782-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: b642765b-5f05-4b2a-a011-08db2c346c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21punjtys5beFl9D+nNZgUvelIKM95TnJMRBeud3I+I4ACGhdE4hvlNIoqhW9l8m6zeLTH2z8ARouEUee+v649iEOjOkZUkvOZNzJq44rgVeOlMgGgc1x/ilIoS8nEjw4U0dXRIkaTFkl2gA0CNTNxgt1wSeCnKUrcRXoDBDvgHnAAavwbI18ILvnl+9XsYvKZH67xeSh4/qwKDGbj8hXWc+/lC3PWDYZtcXw0rGpN+PFg8PW8VW86v5WZoYMUH9es4OU6PsBzheLAGFxqeEAQyuLxvetkM0hF3JxjlFPwuNj8WY+jwALvSASQQbiJLfDETbpyHWOHbcoW/+pq0SGvcRw/p5GLZmmzY3bm3K5NcZaRXqPDGQ2j7BAS6WY9oz9VjhICgq0/pn310KtfdxFGsnxWm/tMLnl77U8JROt1k+iuOQ4dkfk1de2fzV6YXsj3eBJ0p7bs+m/OWsUvelYNW9a1TNjeDDHRAgLvJ2Si0yW5b6sztejwXVnCZc2Upg/80wMzdoTYn8Ga1ponc9tBx/bL+Yj9lh8FajcPZvoJs+HkTzqWVCUURWtq4QhcMuprDDRexD/xcK77caWwZrhQ6GA83UXC0xPs2DXFDk6RJW3td4z/k+WPSRAWBAGhhjEFda0ferIICRXYK1yfUIJ/+LATKIt9G2yKlrzf2T8+7evhWyff2MA4H0/9PGnSYNZ9ppySl3x8WvKqpp2N92PFHxCCKfxlWCaCC869pNhxk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(82740400003)(81166007)(26005)(1076003)(2616005)(16526019)(186003)(83380400001)(40460700003)(336012)(47076005)(426003)(5660300002)(8936002)(4326008)(41300700001)(44832011)(6916009)(2906002)(8676002)(478600001)(356005)(86362001)(70206006)(70586007)(40480700001)(316002)(54906003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:06.6436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b642765b-5f05-4b2a-a011-08db2c346c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
If transitioning from an FPO config -> FPO config, we want
to keep cursor P-State force disallowed. Any other transition
from FPO config -> non FPO config should unforce the cursor
P-State disallow

Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b2919104ffc7..b3824287c224 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -591,6 +591,12 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 						pipe->stream->fpo_in_use))) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, false);
+		}
+
+		/* Today only FPO uses cursor P-State force. Only clear cursor P-State force
+		 * if it's not FPO.
+		 */
+		if (!pipe->stream || (pipe->stream && !pipe->stream->fpo_in_use)) {
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
 				hubp->funcs->hubp_update_force_cursor_pstate_disallow(hubp, false);
 		}
-- 
2.34.1

