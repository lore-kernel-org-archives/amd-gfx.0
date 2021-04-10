Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF327C433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA6761029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA6761029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D5C6EC71;
	Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0206EC60
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abUv7Pet3QNwdlyB+bSemu4ItngcGunEeTMrJ/Kj60VuNHAlpZBvILJb3WhV+HZKycdwpaTsBdtHJOD5/RxGYF0oUzwEnxGYuuCe272nucCUUFQlFfM65wTOfwm+pscOED8kTfpsNhzzv/CJjy+bmvtFuoFoaiUMF3/H5R/rkduiNJZj2EwWRKuDaphS8NmndvX1VNlXdacyArupVmEZvMUak/NQ4A4SXIdiikAx1+qsHKP5VgXjGlI/xFMBCvR0q4WW1R0f+p4/Oypwe54VA9viooDpqKb+lbjbtt61gQzuM+1IvEiXDSLAiR627aFF4mLyMFlQRtaDf8271lpEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VD2SYM4/k+8bDRaGBhuwtlRw3UB48F0pSULTk64c3s=;
 b=MJDjFTc2wj7ByPzkGXj99RVqpIoawR9Y7KQ5raAKCtQeuGeuy7R90GwM6WKK7oHUPBqqg9kyvaoVhhLZqkoU9BgwXrGySyAZLyJCjXP8UAGmqE9G3dWVA5OSoQq0Iv6DVjftq6g3mB9CqMKpV9YB9EtJWkHg5NXDLFnNp08IdVLr0DilE0prSznJ5LxS9D9gzppTAJBWXp9I3fskbqDM4YJJEpBlWk0USKBZMxyL7+6TGjdBLYaNeg1rrkqknePHg62hQh9cBpTkdS6Qk23YzRkQmXlbd/bHCS1nZwnJRrMUPBZ33Ptt/7Zxf2Pnzg8ZCdpBk+qMBNimxNx5JJFQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VD2SYM4/k+8bDRaGBhuwtlRw3UB48F0pSULTk64c3s=;
 b=TQpUoz4NFnViTnHMqK0V25f+4CMI3WQmIpzZOXuNpul9ZUBtlSOa85owTYInp4snyNKZ8Pkv+8iJKPzgB3dnJd8l5s1l7xxwdPYi3eU7qly6IYA3AwOm9ZjDXNxDdTB6R4enp54RHDj8c4w+glxwoQCMzC/BRqjJvrh7Ai9Opvo=
Received: from DM5PR18CA0077.namprd18.prod.outlook.com (2603:10b6:3:3::15) by
 BY5PR12MB4002.namprd12.prod.outlook.com (2603:10b6:a03:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Sat, 10 Apr
 2021 02:04:49 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::c4) by DM5PR18CA0077.outlook.office365.com
 (2603:10b6:3:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:48 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:47 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Force vsync flip when reconfiguring
 MPCC
Date: Fri, 9 Apr 2021 22:03:52 -0400
Message-ID: <20210410020401.1100228-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe872844-2b1a-41b6-4cd9-08d8fbc505b9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4002:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4002E253EFFDC11B6A37FEEAF5729@BY5PR12MB4002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ag59T+xGNjhDYihQfi/iAqxSecccAarg7mvDvqBIjpz/halruusNIztWbAvhGd6K2gFO5VmR4j39uR10UIPyLKG856L4tVD+xwJa95B16uIrYlYuune8jmMlrUkrm3uj0tNYRHmO5UV9y3sZiaW640jivQWiaRT5qucirzsf3IZZXOz5ihwtWnv8pMzrqECrWOLyqSEHmngaUJwf0cCmqwlI8YbKbyn4MZWaqRj8h48FpSIGlyB4dfxOGtd4+qbDFHp8+AoV2SB5+Uulg1nAK6YC/yTyYTlXFFFi7wdAS+YuX2IvkAm//x4sI+UZ3aGzHo6XZgVV1KoxAhzyLXqn0bDUINh+Cag042UtwYx3imthCZFITKSJ2I6y/r49GcnuGpI6IPLBr579GVcB4ixWAhuzMGHHKJaMMTFEBkj/u2Amx55lT8OJMRFv+b7zLufOKjPGMWAlnd5RYoR72KwG8S33hpUuCza+CtjApDVVTlZfHk7kNT7j6J6XjrOI1LB17yVJ17cE4bM8dK1bfIdXA2VgUlLPDzPLc2YHxrkdN1BsySb88vFdu04lvsQUxG2ZIW3J12gBOddeqjy0zqIVgIAFNC8qSwJAKxA+zLUjLIAO5XbyYD3kRm2h2TLsnLxVV9pgTvxqgxfyQXvBZf92Z0eTg7nyswKY/XJDk/fdLo12mzN0rCuOERl52Z6bAiDI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(54906003)(36756003)(6916009)(47076005)(70586007)(82310400003)(83380400001)(426003)(26005)(2906002)(186003)(1076003)(82740400003)(70206006)(5660300002)(36860700001)(81166007)(2616005)(7696005)(316002)(356005)(6666004)(8936002)(86362001)(4326008)(336012)(478600001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:49.5124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe872844-2b1a-41b6-4cd9-08d8fbc505b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4002
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bindu Ramamurthy <bindur12@amd.com>,
 Anthony Wang <anthony1.wang@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Wang <anthony1.wang@amd.com>

[Why]
Underflow observed when disabling PIP overlay in-game when
vsync is disabled, due to OTC master lock not working with
game pipe which is immediate flip.

[How]
When performing a full update, override flip_immediate value
to false for all planes, so that flip occurs on vsync.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e74027a9354e..497e44ca98c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2683,6 +2683,10 @@ static void commit_planes_for_stream(struct dc *dc,
 						plane_state->triplebuffer_flips = true;
 				}
 			}
+			if (update_type == UPDATE_TYPE_FULL) {
+				/* force vsync flip when reconfiguring pipes to prevent underflow */
+				plane_state->flip_immediate = false;
+			}
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
