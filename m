Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30982C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6810410E3B8;
	Sun, 12 Feb 2023 17:00:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC50110E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvzH1qjkyuZH6NDDpegXRvuOTSV1WzHuonCAHEwvUtLAKss+fxPRqhvDav+QcuHkAfHtvPjy75zmfr73rm8GxibaL2XPgb3gdLsRKaGuCuax4kHxt984CCPYvAZo74ytQHeS9xUfKF9Ox5U25jsL5pGEBlp+2aLPJmx/DtgiNdu7z5CDlNARaMsKhanx0kJMJt9+1vcwKoaxQJCDiJS6+DgzTCe9qBjEd48j7Da8nheyYrlX3qjX6uugh3TkEu/6EOEuliRwYw+/ov34CP9hrFPHs8lalq6CUjTx7XkX0tu6njvN4nxoBdujdqIWwR0dl93X3zs/LK2mnED/zBzcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZkTqphxc22YFqFA9n21Xkfaxh+RcMRolxXzlnjcv9I=;
 b=UvED4v+FLOWWpgGZPPUTJO2lRz90/4nP7uoaxI7DplaI7AIFQx+78mkAotJPlFBSj2RVcmj6b63P+IYyrzXVPFdSFAwlQxqgKRDZknLKxFOzGGlA2cdHK6wS6sR8kxAK9GT7rOp35XjrJVtrE2t/EyvsYKWdIZHeRPejb7/b41LXGYeg2SDxF4E8GSnIf+Exfpmc1XSO3SampDjewGBbCdu0XtIt7CP0e9/CgENxz1XlafQqN6BeLU2i1QgCrr0hgIRbG5IyDSM7IVJ041eRq3+R2WziWc1yMl469FubP4euwTjTgMUcqruKWVZecnWSi/bmPPwNXE889cpPwI7SCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZkTqphxc22YFqFA9n21Xkfaxh+RcMRolxXzlnjcv9I=;
 b=pdDz7NqKdd5U/fpVPNDiPGfTcP6yscgYA5Snuvf0PgGCsg/Wqs+r7AVsx0duI5Eyy7ioRCo9L6Yq246dLDr6eQxtNIw2NR/h3LHzUY2ggSOIkHsUkJHPdUTQCfCGjBBYVrA/Kd9uDAYMsa/EqHXBP71cf2AW5z68zwRaREgToo8=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:49 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::28) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:46 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:45 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Update Z8 SR exit/enter latencies
Date: Sun, 12 Feb 2023 11:59:49 -0500
Message-ID: <20230212165955.1993601-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BY5PR12MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3e9a0f-8312-4ac1-dd63-08db0d1ab126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUmwxCkXcOspuup2bdRHP888qIfTfkWE0Mk9DyYlFhd947D41zMwyvlhL3XsK7Bf3Qio5v6VWdfQHvctwfSMejpqBfn8bZVbfuxYL178YhkAKjI/dg4SQSgn+NerRkHqYeDDdgF3Zxi2FD765vms3UxrgRRtdlC8HQMYpAO5VG0tg8l79duXZNmcvLMzPjJkzL0IpbuZoQ7IImr32qgL7XZZlEFyYkF+dQD1HM6nWr51E9iOnc+15FRJUleQh0okm554DKrqbrwzj/HbrlWQLa3qqjqO3t0TS8ZoooXPkFJHPOgfRT3XBwC0okWuxEmgNARYbfznoub2O1URzas12Cm895FdCUzdqKZBsUKjuuu8jOOif+FqYjLTTr2BnWKEUfXUsDyNLbx2nJpEOks7MjRYRhU52JWDv4flULVeNsrEEc+KSk8/N+CqNa56ljRD+TLT87Zprtvreup4W6fXMOIvAOdbgASxW5WTUnNm8o86DazKBeKt5f8IkSTYEKeHjjgNrXE3sQQGJUewYhps9YXdAjWKlnaZDWN92XTR3QEaj1DJv5UboEz7wG0Y89MiQiDyGSxaMcNXa+BoiB1aflC6827CTGvmZ0nJAyqH8lCP6ZC4Nd8V33o5M3tV3/gIYmxXpWQ6hheBVMGi+iAKRMNw/CtFKcHfc7Ws1h4TeUD6QTdPy7GwJqC331WQoVrriRSek62pdWjPAY95rpbsVRy4UVAY4kihz2xnjRRo1ZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39850400004)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(70206006)(70586007)(54906003)(44832011)(8676002)(6916009)(316002)(5660300002)(8936002)(4326008)(15650500001)(2906002)(478600001)(40460700003)(1076003)(186003)(26005)(2616005)(16526019)(47076005)(36756003)(426003)(36860700001)(40480700001)(336012)(83380400001)(81166007)(82740400003)(82310400005)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:49.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3e9a0f-8312-4ac1-dd63-08db0d1ab126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Request from HW team to update the latencies to the new measured values.

[How]
Update the values in the bounding box.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index a86a3a9fcdb7..acda3e1babd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -149,8 +149,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 280.0,
-	.sr_enter_plus_exit_z8_time_us = 350.0,
+	.sr_exit_z8_time_us = 210.0,
+	.sr_enter_plus_exit_z8_time_us = 310.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
-- 
2.25.1

