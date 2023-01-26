Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F07C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66AD710E8C6;
	Thu, 26 Jan 2023 00:35:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C39010E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq5RAIkrjcVSZfXcRQYDIQVq2w3LmoPPKpB+DMkFFk3bl4NKT6hiaEhzuDWwCOEmPVfy7X+kMfaz78xpSN3nh7RorIzPi0cGrwPwJoJ72upmF6uo+aVQ/dkBfCBkKMjCGev/ktRZuRR7zVrKu7BP9cSUuf4XMj1Z+1LkDO4428H9UHOh+o7LU9iD93HrNlzonlLha7KzeCqsip1xxVGdTCg5Jv7o9BYhUSHIJA9wBZ5JNDySRD5dFZAwHVc3hy7PmVykNdhTfi+4WeWjKA1BBIBlSvIyOxSwe9IsZTDMKFYfY8IPXqa2SRAacn8BkpWIkyvoeurK6WSkPCXIFkhgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auU6XSLLELzb6xgVL8vH9zaTAXYWQsIEATcikWtOqzg=;
 b=D5+Vxs5htZM2zCrB6q3PMHXA6EeAjZZhmRccPBe35eKuCS8vrE3FbBaWs9FVcdoTG6eSJNq5eVMREDMnPN2CtTELmNa3SbRZuqW1Lg1M+pwQJ72YO0czLrlzTCyvS5lbm6q+zPoVGUq+cBtrII9wMjvkNtXsZsLi3+SL/vrRP3vciJUWsjeFMnanwmfGQ6d+bMNuQOMOArMlgPQDgmGoDIocw+qvBnURwp/UOqVrqeQsjnLDudM7I0J/hBNilGplzAnFop3uJXfqmSdnC+bFbMPZh6LsxHSGLVOXx2alwu2zXLto7IKt1Fd4jDc89wwWYspoEszNM9a7mLBSSRwqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auU6XSLLELzb6xgVL8vH9zaTAXYWQsIEATcikWtOqzg=;
 b=YgAZDBbFpCvTpnhxH8RxsV5DRIgMPA270WXAib+WTlDbv/YHilOYUI52AM1V1rqNSK+6TWgj6ugqV+xo6WM9iNu5KuK8JoQc/FQ1BYO5aALbuaalgPZtR1ng+Z+TTlgzUxHU0B5ohrncj1CQUVxxM3qK0/SGYF3DJe7bujFNrz8=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 00:35:35 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::10) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 00:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:35:35 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:35:30 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: fix FCLK pstate change underflow
Date: Wed, 25 Jan 2023 17:32:23 -0700
Message-ID: <20230126003230.4178466-10-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: a2191579-3802-4d49-c5bd-08daff353d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAPQpjq8nFyXxE8Fdyok800CXHhVLIWOs0mnnLNNpKkmU93PkN1iBoDxXwSXK4FFIrd839Btlm8/eEfPojYxhR8q7j/rE8cpnYXCgKHlCkjHaoLlBQgqR5z7nqqj9/c6DeFvhd2j34VwTc+SR0vF92cL+iP07T8HGpP+q1v8hC0fXk0XoZgv9jkOC08dBkQdUQQ/l9N6qwsfHxRp3Whj51aljr0uwL7gnP8HMwhyo61eQ4EUoKChEyQGnPn/A1DIUqk+u8sUotO4U/UT2E7K8+ENIXt6tIKmET+gIRzEFnxq9cW9O8JFvYn97EzV9FpqXFQ8xkpgBXtK5ReJpQKLT9KmWpLG79emKPhTJpeWJLVq4ABjOtrD/dteGkV3SyiMnVVBtOoEOd+Om0PjAbO9y9MvQPSWVHTBu93IQnOzzKwy2ZVXtcqtlxEKX3he1zWw47exHPKiv1tQpb9CdNOsR+BuObHitRTNH452anvWtGvZBGLx2fHjVvk9FbubYCn2R/55SpEGSiW4w6JzKCkDzcpIMIIJSYGNopzraEIcN3SSEcbmetRwoCtDpZV87e85nDvme92gQUc1G2gZi7ts2wiPYzLtOagliE83tZT/h3TctPWXoixI1ImouwxfyQOzj/IzvX7SDSwABwdKVg/gnCBLHdJC+4N77mBmn8wrHXIA7iOpzBDBppq1Q+uJvEgUJEK90MjcfRuyA6gstNq4Pc7PI8B2UvdLaZfc5FCh59g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(186003)(16526019)(2906002)(70206006)(8936002)(8676002)(4326008)(6916009)(70586007)(41300700001)(426003)(83380400001)(7696005)(478600001)(336012)(6666004)(1076003)(26005)(316002)(2616005)(82310400005)(44832011)(47076005)(82740400003)(54906003)(36756003)(81166007)(356005)(86362001)(40460700003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:35:35.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2191579-3802-4d49-c5bd-08daff353d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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
Cc: stylon.wang@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 wayne.lin@amd.com, Alex
 Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
Currently we set FCLK p-state change
watermark calculated based on dummy
p-state latency when UCLK p-state is
not supported

[How]
Calculate FCLK p-state change watermark
based on on FCLK pstate change latency
in case UCLK p-state is not supported

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0dc1a03999b6..28e9f3644bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2126,6 +2126,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		 */
 		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
+		/* Calculate FCLK p-state change watermark based on FCLK pstate change latency in case
+		 * UCLK p-state is not supported, to avoid underflow in case FCLK pstate is supported
+		 */
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	} else {
 		/* Set A:
 		 * All clocks min.
-- 
2.39.1

