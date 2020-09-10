Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7658C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF9C21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GE9jiNF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF9C21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043B56E938;
	Thu, 10 Sep 2020 13:48:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9411A6E938
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQOmR1YiFzUthM2xM/UxKe0AQz+Lg3eKnmY5XXzeoS1QyX1OkcJgZ2s3ohD67tpL4MPbM52LJ82Tq22jeQA3mij/nM6pHFhzg5BgqUsSipkOkGc0WpYJQX0f4VMoMZ1yuTQ6TCEp7aOJ67N8yDq5id4NJBJ7jevvWd0PZ+N3zWiYwXMSke11d+6lffxF5QRz6zfzdgvrkLg+pEcnzideUhElDfaxEYKOeq6WO+OZngkoNnJyP2R5ex4znKi4uCeLS/1zboxJcdxIe0PaheMY7V/KBO4RQWXs4eN1s+kSeaFDo1odkbpHZZk8U5z1EnlcO/Izs27O8hYZQ1UUYU3qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxsJSWBe+KoVu3oOfkI2YFB1Mf0U02Mc7NulX0PhUqk=;
 b=iZMpZ03z8TmDiqfdka31Tvu8hMKhOz/qkvKa/OmQmbtxPExxKRJ5COVrzaxN2XXn9+zcuNPETZAzZncA1zwWKFVvfsL3+lNV45HWk7yAGWrZc5ukNFL5JcQ4J7+kMZBIkF8cRiqueg9uNBDD8YWUl0NKCQW6oX6oLiB6CX7eUBGozIke5pef4FtQ4krjqMHRO4vryd9e5E85i4nxajteFrlOba8SAZsUOdOlJ4Ya5iNlpO+neV22UZ/gfb2jqjVZp7qWnAGS+WelTHLIP/3gS7UwxQl3nyFqoPAb8UQhnVjqD78bvFcxnLWSEKqJpl/voEe/ylGcnt0z+Gdwj857uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxsJSWBe+KoVu3oOfkI2YFB1Mf0U02Mc7NulX0PhUqk=;
 b=GE9jiNF8Gf5tvC5GWm6i//zK49w0lANuko9x+xrXwL77TI1Tw8budMuxigs8Q6PMWbC0oJNmO6DODjPbskoZmlhaYzXwhjx5zs8DXTcYBHUI2kjfxguKy8NuwPXoDWQ7lxC3weaRMEebp9BqDdMUPRvg7v8bk2AzK655W6Sk8sM=
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by BN6PR12MB1540.namprd12.prod.outlook.com (2603:10b6:405:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 13:48:19 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d7) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:19 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:18 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 42/42] drm/amd/display: update clock when non-seamless boot
 stream exist
Date: Thu, 10 Sep 2020 09:47:23 -0400
Message-ID: <20200910134723.27410-43-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d482fe-fa1c-4eeb-6706-08d855902d52
X-MS-TrafficTypeDiagnostic: BN6PR12MB1540:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15408FF92F1A071BB2F642F68B270@BN6PR12MB1540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPH+aoF8GPmlwQCYxqPof+h5hXG2Qm1ddizd9u+mIrEoswV3cPQ4vlgz13VLXQVW4nsxcZNXzhyNb4WOKwVY3hg2D5v072Bn+SgVySqtFORJrNzgvL5wkWMMrTAmXs+JrzxU+AgMahxXIJRqRVIy48IaPboiMTLVVOvVqKK7xZMvmkutBZGFDL++RPNeBWrFwKOyw7ggg+lyc2dSxbO78mNstC4UfK91ZbKGTqCLYjvUXgFDQ3y3s1sSJLn1XQniHxCO8C2WX8WA/7nZq5q4rDdT6WRZeCx6RtGA8KAioMCwLl8m4W6UDEG4+iEgDatsDOmU6HIX74hrVy2gw3MnDK08kVj69jgqPDYmkO/Qf+2cD0R7b6y24rX5yMT0O8MnqSK42+2IPGVoI3FQuyWyGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(54906003)(4326008)(186003)(8676002)(36756003)(1076003)(70206006)(70586007)(82740400003)(81166007)(426003)(15650500001)(47076004)(2906002)(356005)(8936002)(6666004)(26005)(316002)(82310400003)(7696005)(2616005)(83380400001)(86362001)(336012)(5660300002)(6916009)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:19.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d482fe-fa1c-4eeb-6706-08d855902d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Seamless boot skip porgram clock when set path mode.
It cause driverprogram clock after unblank stream.

[How]
update clock when non-seamless boot stream exist

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f01610df8045..83ce55edb3aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1286,7 +1286,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 			dc->optimize_seamless_boot_streams++;
 	}
 
-	if (dc->optimize_seamless_boot_streams == 0)
+	if (context->stream_count > dc->optimize_seamless_boot_streams)
 		dc->hwss.prepare_bandwidth(dc, context);
 
 	disable_dangling_plane(dc, context);
@@ -1368,7 +1368,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_enable_stereo(dc, context, dc_streams, context->stream_count);
 
-	if (dc->optimize_seamless_boot_streams == 0) {
+	if (context->stream_count > dc->optimize_seamless_boot_streams) {
 		/* Must wait for no flips to be pending before doing optimize bw */
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
