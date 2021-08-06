Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CDC4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6E861181
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA6E861181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32ECA6EB9B;
	Fri,  6 Aug 2021 16:37:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694AE6EC2A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQAHgKspyLHeJGHI6VhHXf3iHBg0lPDiLHtNE+502ZGEO9nj+5lwfe/Wy9dgmeO2LPn1zenRpiPvsZ5gLIWmyBB2MbxW1vAFWQGfkHE7drLGw8ROeXH1jX00AkHIbOSbecQFkYGi18IhrEd0vuTTqsrI5TClPlyT4m2ZQxVWcUgVBmYXUJJ/ZQuPTSovJJOmKHkmhIVK/hbT9qwq9Ja3KK4Y8AlbYh7OoR2EIetxVhFqWQ3+1yrQt29wFF3NDRNHEHqQPVRzATvTszkQLU87ctZkd9RlaHf6DG1sSpvQ3hSAxEbFmP4wEWsVtM6s2bkobyf2PFVOryssw2ej8rLTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqRea6wiMXc41BWuBhjsWcKdo1+9YOAZeITvAOMsZpU=;
 b=dlCdU0Svle3h401a+20mq7H3fChVZyVYtHZEzHzo9EiFLMcmUuRmUd+1dKKGjsmqDKb8s7eYnszk982pB0JN4NCjbB4qV0UpqvmRWJOgg40nbWMoRe7NeqAg5JeKUi233fm+4JxTDyDCClpQ4vBA5SzAijfnuk8Ohu9kZhLBcAh7k+o27Z+RLaNxn9jB1h7FFOXcv5J5KB9GBV1TqcWyJTFfVHn8avTH0J1by/GqAZC+Pk9RroW0aynypozz/RIgTiN38SZWYD8VfSfFL9obU/KK9GlWkXxe+nFzMyfep92NIM8hosNv8xjFfuU0XdpRlAkPgmQ8d9eULpUdMG2VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqRea6wiMXc41BWuBhjsWcKdo1+9YOAZeITvAOMsZpU=;
 b=YHOsK409zQPn3ONd9BjaWk+ibRtsk/A57YLN+xEaB6BATa77FCdq3Q0July8P95h7Df21Re/I1tD4jcezZZMrui2w40Gd45vN/eUWGItDF5WAWOv44xiYxrSOBzk2r2NLTlCQav8bwMY6lcEiRlMb4GOo/8yxzLfj+au9tFy0QI=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by DM5PR1201MB2553.namprd12.prod.outlook.com (2603:10b6:3:eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 16:35:58 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::4c) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:57 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:54 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Roy Chan <roy.chan@amd.com>, Eric Yang
 <Eric.Yang2@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Clear GPINT after DMCUB has reset
Date: Fri, 6 Aug 2021 12:34:47 -0400
Message-ID: <20210806163449.349757-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9eab134-5d38-451b-025c-08d958f844e8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2553:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB255368AAE20E2749DC10CFD9EBF39@DM5PR1201MB2553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjVq9IbtbgAKgfsjzWV4stHRRV45Bp4m4ct3lKJB2O4RqOAkcWjQGPj+ts1PdtQuSo2fE6pzDDDW5Y3b08yiP+pyAfySYkhNVVANHVwFxJe5LgQt1cgQE50rGGXgDRc8qLN+amD6VoQvhC+VoqaRaVS8w//KFuaoBFAdO5QQgdy6TdwkcUMYuNbhojwM45jAjMcdd1BQmItyNHtG7WtzJwPErodBXLFAC7fYU8hDIKqLzDzlFvgwEswmpS81YLwPeMOwbMUvmkmVGdYch+32PswbdheMW1M6zkHAsiilQnwtYJGdG4C99NXL/h7cR7o0pNlVzGtPmhOCGURcxmQ7N7ZczM0qpWsFCdXdxPxpL6G59N8ZmiC9o0dDpCeKdly1biZr1avONVZGM4Dh/nfp6uuaKhk92WTy2YD7bGtfFV+rHsMWRYN8lBnyyaiOfjpOnBQm3NW0P3Kgn2XNpcPYpPVH6AthiNUpYv6NynOinkL323G8LrzIKgeCOx8PuTn0hKXSOHk1U18cIdeHBwJlXYwv9/8mQbIhRuYVfOzZF8/athjtk7uNZErhaNfPTVfsqj/+rUZ+O97/owA7DU15sknmmKNRqybcKw9mnERuJ0E8bkWqVfye6Z9wA5DGI62LV/OVqaY7S/qzv3u7DQXD+VrRB5mFWLf0/aKg0oNuscLik3F6m5aZwLexsZGcGrtBePAqhXvPyMw+Bj6101t8Wjqtv4WV2yPUng5j4Zyob2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(82740400003)(426003)(4326008)(2906002)(36860700001)(8936002)(7696005)(6666004)(83380400001)(6916009)(478600001)(316002)(82310400003)(54906003)(70586007)(81166007)(86362001)(186003)(70206006)(26005)(356005)(36756003)(2616005)(8676002)(336012)(5660300002)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:57.9246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eab134-5d38-451b-025c-08d958f844e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2553
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Otherwise we can end up processing whatever was left in the register
if the DMCUB was previously reset.

If DMCUB gets force reset too early from another client then we might
not have even acked the disable yet - causing DMCUB instantly shutdown
if the command was 10020000.

[How]
Move the GPINT clear outside of the reset loop and do it unconditionally
after the DMCUB has been properly reset.

Reviewed-by: Roy Chan <roy.chan@amd.com>
Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 6820012e3b6e..19141bf84a8c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -115,10 +115,6 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 				break;
 		}
 
-		/* Clear the GPINT command manually so we don't reset again. */
-		cmd.all = 0;
-		dmub->hw_funcs.set_gpint(dmub, cmd);
-
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
@@ -130,6 +126,10 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
+
+	/* Clear the GPINT command manually so we don't send anything during boot. */
+	cmd.all = 0;
+	dmub->hw_funcs.set_gpint(dmub, cmd);
 }
 
 void dmub_dcn31_reset_release(struct dmub_srv *dmub)
-- 
2.25.1

