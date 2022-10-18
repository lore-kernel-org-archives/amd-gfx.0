Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC8AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8517110EF2C;
	Tue, 18 Oct 2022 12:28:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF7D10EF2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOJMnQ6Xw11QJa94wIoUoOtMjkp7DHns8H1TCp7JwTgSGVgDzUlC3g5psorJviXA0xqbPk0bBQiiccPMDzWCffxQaEllANqg9jFi9nR2YefJgQ0m5tEVepgq3hgnJ+rhgJgl0jSH9r3UwvwpcuDduxIGEt0MxEzZGUSUuXM9PTeRmIiyAvp3e/qo0NOEQJzlztRusGiC382zirx9/p1e9PlacS/SxF4Yg6VRDHH3sqmUcWdjtkKPu2yRPH/0z4AGSsrlkrFHwIihPIcoNXovP7s/k0hP1oY9e5qdMGM97sh/NjW86v2JjCzYz49mLrpaOjkmynx5xnnOCIUr2veEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+VWl/6axa9feevcewuITs3HEtGkVvU+KRlSbAdvUlY=;
 b=c5afuImYdbrfxViDoR+bMeptthZsEMjxtCllrsQJZ1m/kOjYoa3gcOhfoLZH5wOG9CbEQmUC4+gTWddvHho2cjxM+NPZpWpGdfxoMpj3Jv80hXUZVNMrIn5WnlgDKv4oidVTsLPDnzwcMwNiLUUlvR21nldFvQkSQ3dq1zFwV+daxLhU1mHqM+3gYuzmwsSvNQlpvp85CEUdQCmoyg0jViq43rHu9f44rleK4g6byNLH5kzio4dCJ0ySPYEbENQNNjADQ+Kd5pkNjypSfPlXXp87ztrJTn+doeGaVhvEOuMDlpZLmFTMO7y+7L61/Da8TLnD9Ca0IV0O8dk/2KkG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+VWl/6axa9feevcewuITs3HEtGkVvU+KRlSbAdvUlY=;
 b=D3b0OeqkVJLqwMKtkIWk2ZE3NIqYXjcwj3MKqXXrK0/hbE6b7ItpNDn0GUcy1nGOyY2Q/bkZTA/PSBEdo7emJQ9gHuCvYnDWvBjFMI2GW1gg4oZtnYIZTp9decNgTd336piSrOGcAPiJt1c3YZuFj26RC0fmqgspFfYr+UEKWwo=
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 12:28:38 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::11) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:37 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/12] drm/amd/display: Update OTG instance in the commit
 stream
Date: Tue, 18 Oct 2022 08:28:23 -0400
Message-ID: <20221018122826.1790114-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: db46558a-554e-4024-fec3-08dab10448c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N12jsxUClkKjRWC//YFGMI2OZP5iw9Ck3Kt8uveHnpKMwjxUmikTJWBLeWlea5zPQF9u2Hol/GqO9r2DiYo6nNOPsg4xmVib8du6gR8ZCQeKSMZZa0o/dyFeE09aKtkKqxDXifaLufGv7GJK598bcB4TZ3lLHXXKYID4D0vjHL9/6KLBkP5eF2jewZN090pCu5i1HKMlwwZlttNfjlKo4oK4SddLozhS92y2ygGQ2TxVfCDBMBgdF97LuBS5fh+7m+oMuerh382y6KWYcWzDD9HfHJXaLB3XjUhJMHhoM4Lk3XABSMUwMWsDaSfIAIoJYXAoy4rDtj69db/JJaRBIu1Yqut+rpDHIyIXI4Yn4Q0NsQVhtchaW8tf4zHs5wPkf0+hSqQ0TAZs6BLY4XRYgT1dpkx/5ds19khmvdrV6c/n3hDDgz/ijzI0REHNzTL2Xp4rEPXxEGX8//mCA5F7h2wDakdZDEJPINdqrQB6cgbBlozlCbJJ5e6/HKnSdcLTftcWE0hxM9mFxiTOBt6z3U516edx9cKcqobNxcW8xDV4WU50HSa0OJbeOOcLKWboRDCVuSO3YKDFnni90OQgxLNaowG8eYOitN163UcSWr/xKK0vD1foLhGg0Bvqqblzoa69c5GT+uE4jsq+QgUsjqG8A3fHdrh4W3KUa2GNkHxroUnl/ipBLVvkphMqqXFIJZNVg0B4cHFeQ5jxVdceMTu3SxL5Arf2zf2bwBVlwv9pEBfB9sZZoGTbN9ljBFfV49q2/63+dZ08JMrYy1K7PWFOm5DVhMAYPHT0tD7Y1RJ4MMEXJrwIcd7U8TnDUvlE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(86362001)(36756003)(81166007)(356005)(82740400003)(2906002)(336012)(40460700003)(15650500001)(5660300002)(40480700001)(6666004)(26005)(1076003)(186003)(2616005)(47076005)(426003)(83380400001)(36860700001)(478600001)(316002)(82310400005)(6916009)(54906003)(70586007)(70206006)(8676002)(4326008)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:38.3679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db46558a-554e-4024-fec3-08dab10448c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OTG instance is not updated in dc_commit_state_no_check for newly
committed streams because mode_change is not set. Notice that OTG update
is part of the software state, and after hardware programming, it must
be updated; for this reason, this commit updates the OTG offset right
after hardware programming.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d568387c4bda..b7afada35b24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1949,6 +1949,12 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	res = dc_commit_state_no_check(dc, context);
 
+	for (i = 0; i < stream_count; i++) {
+		for (j = 0; j < context->stream_count; j++)
+			if (streams[i]->stream_id == context->streams[j]->stream_id)
+				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+	}
+
 fail:
 	dc_release_state(context);
 
-- 
2.38.0

