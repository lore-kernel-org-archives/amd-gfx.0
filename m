Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F72AC54EAA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD76E10E8C4;
	Thu, 26 Jan 2023 00:35:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC9F10E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyAqXyNHTvzxLBlGt/66rWuMYMYkx129NYxddgZZjvUxOOOLiT/bnlGMbrxBYnG43MtsAjywNrV6Bb8n6WA4a3UTTtCywDKhwFMsQWm/H65GFZIFW0yWbm9LVfN/B+OfB7JV37lLXLh12eFRVn+fLwop321E7HR+1YhZKpAywNyl1plpuqK8hLKC87Rstrrd2m2am4A/kqzZLFKq340gn2R8o4i23UcHEJsPdYcdEGwKD5e8z15j6713Y0Vkf4+gcptK6kKyJ/LlTYC+FAvpwUwn68CsOQl43rj0F9exIcdsNTR+QXTXPpiKPn4OXB5v3C8o4735AqeY7/x1L2doAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG0uUEBerQoNJ47yeNUSqT+RHnOvyHN8bjUkbJMgkw8=;
 b=hfslD5/fQgq0mBagBqDsF/TUH3zQlORZny07f5pxKTd/9L1MvxFM0R+7iBvsKdDlMBqLZK4rtJZ8wlquVPfoZ+QnoioJsj2Pv6YAufTRIq9njL8y958zAOeSRsjc7mAzM04idy9TCLVMrK2AhC4DLC3MZ+B4RShhaBv4Mr7bd3PiCfX2rU4ZJdiv+y+Qukje3rybNrQ4/Z+FKUmUUghduI+X/sDC4tlTyLyvMh39AjYodU2M40zZf6WLvkIK6NHQmAiOX6SzxjqreMSApWp4MJve8uvSO5m44164s6S6o3EWrqddygO3CvmbS0SQb/6IeSXmcfADj8nSD8+zELG0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG0uUEBerQoNJ47yeNUSqT+RHnOvyHN8bjUkbJMgkw8=;
 b=VmcaNyphjFRaDbUMx3wEvTHT5lerDonFb5UXhIIVkQF8kdP4AoKnJ8etD5inHiaah9SdzMP/AsUehONGCu+c9tMZk8clxMy+RZIsUfd0VTMx9y4y1CdqM2ixo9GChGjfRgiV1aNyZI5yGRuOTSOV73mjeWqSuIOvyvoNsscxfbQ=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:35:19 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::ca) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Thu, 26 Jan 2023 00:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:35:19 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:35:16 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Fix only one ABM pipe enabled under
 ODM combined case
Date: Wed, 25 Jan 2023 17:32:22 -0700
Message-ID: <20230126003230.4178466-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: fe29687e-e5fb-4c23-c80b-08daff3533c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8moltzd3ETrRSC6zm15tE6hBkMX6fEtkVWMloeUK4J/39nBT4YaW4d4D9N/io8u//hX2C4zgmdJf7hu4kjKdQHqanDnoTR5acIG4fnxzFDCF63tr2209Y4OtXEDZPVX2+ll6k61R8DCa6ZyQ31BQLsviGVXR6znIuhUOBrXR8Ccr/40vby8XjXAP+pEgjVmDntfD5IFZYFuaNICgiXACIbNITrbHMD9sbEFGvDXJInT/mTbIIx7UvD3449V0tio14zzdNP6Dit4/Mq8FxJxa+BZNyLqzi/j1aSl6EitpvS+0uLbOEAsq0/09T8HKWKCC4gc3cNIBZBJklcjvMp3QJvqbT7zIYy5tJZ8tOpcRO8OCTEgkrWszEuF6SCBBoQxHCSbWQqwV4BX1iXVLJsEm2oBSTSTRst6Hu/ar0t6h8zcviPHEhK1dG+O2EBnz7ZXVQ9/GCP1ODMqxjO/n7mnzJuAZQDzNIHx1sDS5EFkqPijkHWptjgPKXud3X/1J9uIwc5MSfjw644FdE23KVn9asuFY6Om1gg37iZroW5A82OcciJUjfq96S5bT0+cy1xjbvrFKmK9IMR3kGBXIw0XALgua9BXzNrz8JKz8Hh3/S6PKUI+t4Virzp1PRWpl+ArZbKgas4axzcHCjxUCxLELQAWyDJ7vD5r3iZ3BtNDnGpabkAPqKBnihi3w9u6kIdwlN/cllUs5ODMlmOeR5z8yRwrO1Vv0mqjrtL99T1IN6RLMNIgd5OH2zygUVj5YmXUfoeGYpGW5IS+X7UGrdNEKbQ859upU5j2wSJnmIk5SuIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(26005)(40460700003)(47076005)(36756003)(82310400005)(186003)(36860700001)(316002)(54906003)(426003)(7696005)(1076003)(83380400001)(2616005)(336012)(6666004)(16526019)(5660300002)(40480700001)(356005)(81166007)(8936002)(44832011)(478600001)(2906002)(6916009)(82740400003)(86362001)(4326008)(70586007)(8676002)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:35:19.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe29687e-e5fb-4c23-c80b-08daff3533c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Leon Huang <Leon.Huang1@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Chun-Liang Chang <Chun-Liang.Chang@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
ABM set pipe before updating ODM status,
it leads to incorrect ABM pipe setting when enabling ODM combine.

[How]
Call ABM set pipe flow after ODM status update in program pipe sequence.

Reviewed-by: Chun-Liang Chang <Chun-Liang.Chang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 916dceecd3de..cb8edb14603a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1777,6 +1777,15 @@ static void dcn20_program_pipe(
 			&pipe_ctx->stream->bit_depth_params,
 			&pipe_ctx->stream->clamping);
 	}
+
+	/* Set ABM pipe after other pipe configurations done */
+	if (pipe_ctx->plane_state->visible) {
+		if (pipe_ctx->stream_res.abm) {
+			dc->hwss.set_pipe(pipe_ctx);
+			pipe_ctx->stream_res.abm->funcs->set_abm_level(pipe_ctx->stream_res.abm,
+				pipe_ctx->stream->abm_level);
+		}
+	}
 }
 
 void dcn20_program_front_end_for_ctx(
-- 
2.39.1

