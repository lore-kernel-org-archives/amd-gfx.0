Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A22C2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cQ51U+T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A22C2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5F36E11B;
	Mon, 25 May 2020 18:13:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056AD89C21
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B15BJcIDrX49meELX2N8GMPc9/q83ROD4OxkFrVxbLITr9ie0q5MC+g4uflWHuVmR6fu5x3XXng2EiEPHYE5tVnP24XCyj9ueBQmDsJcNuEmONtWulY372A4qI9XoLmSzUBsbYS95lao+atz8uBdlA9Hux3cTuou1d2SBxq4uoUD/2+mT/M+8NJr6pQWX+B6E663JxrIKf2mOie5N4gAk2jYK4K/T3e8M/vZjZEzxklY0K5TnWgMpQwbj/I6S4THgG0hf0v0p/ZfxDxfR1CCsj3zT95SSNqNY/n0b59DLMwcbOHQ1Btiei9ctOy8Te60ie9dmk919DLwSCcm+SyhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWYHoPHM/ryHTQBkBYD5cS5Ogcr08xTS7Wsg5iUyNGA=;
 b=MnzcpKz0GAvYZ3xO9pztMHUtDNeJUGQWa0iBUt/DaEt1klIb8pwcnQB+cuh6aEsHHmIkvtvR4LCTyyiZwXSYmKpiLdBef011Mi9CFGrdAvjRdNoJQAkLPY7Cr1wITG4JiUrIs4PjRyb4uuhRrtn26egeysftdsDfalq69QHmtU2jePdKj5mls74ZuNaa6SvApqw3jQ6qS3YABvulFNvbBVVzN2OKsXvF8yuzoQssQwgV+7GoEabIqsVmNdXcWO0abOxsejDuMvp37d9bfXspznOpc1DBjmLpo9rolXdUKWV5e2OoP2/pm7kFIHlU3RonEcwI2Pp81PBhTF5YecWfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWYHoPHM/ryHTQBkBYD5cS5Ogcr08xTS7Wsg5iUyNGA=;
 b=cQ51U+T3+tsfVhr03PlQRhktn35ecDAEBF05ayBRONwaEBA6z+humFthM2oaRRgmyXK7EdacMMBejkqU7+XFTINHL1ajmvEkR1jsmDJ9rSi8RLS8FKqwM5gECE3orXwOL5Yz11cD+3Jterh45bWXIYQFGea7W83c0Mh3SzV9Tdk=
Received: from MWHPR21CA0055.namprd21.prod.outlook.com (2603:10b6:300:db::17)
 by BN6PR12MB1441.namprd12.prod.outlook.com (2603:10b6:405:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 18:13:18 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::42) by MWHPR21CA0055.outlook.office365.com
 (2603:10b6:300:db::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.2 via Frontend
 Transport; Mon, 25 May 2020 18:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:15 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:15 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: enable plane if container of
 plane_status changed
Date: Mon, 25 May 2020 14:13:03 -0400
Message-ID: <20200525181306.3749-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(70206006)(70586007)(47076004)(6916009)(82740400003)(6666004)(26005)(5660300002)(186003)(44832011)(8676002)(356005)(316002)(82310400002)(2616005)(426003)(54906003)(36756003)(81166007)(8936002)(336012)(2906002)(86362001)(4326008)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c709409-5fc5-4e79-00b5-08d800d74cc5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1441C984B9896EAFDE0F5C95FBB30@BN6PR12MB1441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JG810CcD5wBhJpQFqySrC6Ll+xJLswl2RE7lcyrzZ+l2DqkOqq9H5WkaoDQL7Dz/KAQEfRyhsN4sBJ8AeIOTq9lsDVAGqaIm5CfsZ3GWnsBZN8HoppAwXdVI6EGFOvCA9hHxFGDe9i1k0yCL/ZINW2/kq2j812zNtBO5SMOZ6eyrdFjc46RZ1xcFVcYNy0v/chEnPHQu2PDXGdLYWfGRxRCTjHvixRTpSj430xDcDZyNbTC5Z30NZwofHUwQKBCZ6ApK42t+g9M9qN+HabaesAsDZn0pIv3pIV7xVO+xE79WnDp4G/Hs0hOnlbXahXvAH7Eemt16HG9gWScTtFWTRzAlYGmjdAoM26nVlN6o4yxlFNgVdxmJIC5So6dq88/zCfvxH5IrqCoVnxb0vaw8JQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:17.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c709409-5fc5-4e79-00b5-08d800d74cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Hugo Hu <hugo.hu@amd.com>,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[why]
We hit an issue which driver reallocate a pipe from desktop bottom
pipe to video bottom pipe. In this case, driver need to re-enable
plane.

[how]
Enable plane if container of plane status changed.

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 223e314d26b4..13183bd7ea0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1160,13 +1160,20 @@ void dcn20_pipe_control_lock(
 
 static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx *new_pipe)
 {
+	bool plane_state_update = false;
 	new_pipe->update_flags.raw = 0;
 
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
+
+	/* Detect plane state update */
+	if (old_pipe->plane_state && new_pipe->plane_state
+			&& (old_pipe->plane_state != new_pipe->plane_state)) {
+		plane_state_update = true;
+	}
 	/* Detect pipe enable/disable */
-	if (!old_pipe->plane_state && new_pipe->plane_state) {
+	if ((!old_pipe->plane_state && new_pipe->plane_state) || plane_state_update) {
 		new_pipe->update_flags.bits.enable = 1;
 		new_pipe->update_flags.bits.mpcc = 1;
 		new_pipe->update_flags.bits.dppclk = 1;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
