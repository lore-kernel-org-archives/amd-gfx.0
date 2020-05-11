Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55FBC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40815206DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MSHHKDjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40815206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93596E53C;
	Mon, 11 May 2020 19:34:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3510D6E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 19:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG+gts8BWWHxsZSQpwihyv863OhLRxGMUsBiMIN0R+3VQwW6nmh4AS9XwsaswaIcaDFuOFGFKVsEqS9agOGdYk1vVsD6wnlGe8ApUGVIcu++e7uER/gD5DkzhjRaPY5MeA1NbjDX1BKPZugDUEo8RDSI5uuVH1AaiAoEMgtxhfDlsbufcK4bPHHNI5YVB/neEl6xqg9ZhLSodVCWdw6lQUidIFOCX6CDS1HVEcO7i7P6tujIzUA4vCIHxqADHnY6LY3jtfm4ZF+QOjpoN/lSy0G5+NrNVX1uXNfHSDG05X5q9g2YlW7YNwEuEvBlZ+/7fYmAcQXy7T/JdBFRGWvllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pIc6iLV+qkQXJGZnUkNKvdpXZsWlK1rS4w0ccD4exE=;
 b=eZ5rDnWKNjZodFW8FR14EJoR8T40jlMrdYhMCuJd0ysZDnm9tF3oaxmYB1vAOh59mTIie+aenj47dIWpiq27YEYRULDPUxQuBQzBKdOMQA1A//boLOJOfpc18zahj0Xgz0mUiJijD6Nncbjj4ei7441IqHQ2ProQi7pdtbCH69EtjPhT13ITgCB7Zo1jXm9ITC0BIRSh5XI2khLZHhVEZSLfI6+vWnUq1+2l82pZbXJIM8uo11h0TxAb2lmwnEnzxJkfwTD/lPj1fEyTZt4+1h3xd+nz7q2VA7KAnOR2OQLRdW8T/AMTA5MWc7sv92Tob0OlR5crliaM8/+oUrnuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pIc6iLV+qkQXJGZnUkNKvdpXZsWlK1rS4w0ccD4exE=;
 b=MSHHKDjIStAG1FS6mrygN8+Bmr1I4GkYLLEsPIbDOuJ40Fx4BD7iu1Ilch+t09RaypaxaAAwERFvgmCcsqht8YDk5GKKtXoh1QnjhQf2sifPoS0+/660vIiXTyr2xDmf+jnLsXq9dWQI9CKqlH7AreyIEvgr5FHvsTJnbyedxn4=
Received: from CO2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:104:2::13)
 by MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 19:34:53 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::39) by CO2PR18CA0045.outlook.office365.com
 (2603:10b6:104:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 19:34:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 19:34:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 May
 2020 14:34:51 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 May
 2020 14:34:51 -0500
Received: from leo-VirtualBox.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 11 May 2020 14:34:51 -0500
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
To: <bhawanpreet.lakha@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Update update_config() logic
Date: Mon, 11 May 2020 15:28:53 -0400
Message-ID: <20200511192853.11150-1-hanghong.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(33430700001)(2906002)(2616005)(33440700001)(47076004)(186003)(26005)(356005)(478600001)(426003)(110136005)(316002)(1076003)(4326008)(7696005)(70586007)(81166007)(82740400003)(86362001)(8676002)(36756003)(336012)(70206006)(8936002)(54906003)(82310400002)(5660300002)(15650500001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce781d1b-f62d-42b3-ddc4-08d7f5e26086
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01914953D3B4E8BF96CD5F82F1A10@MWHPR1201MB0191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfwdwItRB4HSRgDnQPQYYM+dXBBFuMvorbj50eyV5LxGFvXF7AeZiVnTC+Qg0hNuPdLof5/jdkf/i1N7O0/reHPpAOePE6eUPrfRUBHpDL8hH1pQjGNgvwhaauTs2MR4klp3Fa0hKdu4w7DrOqREGTdGJ66B2FsZyo2mtyzzCaNFAMM7+doDV5R3IPFdY+ONILmnNJE2ivAcNrGIeDL692Bz627D7dZkFh04mmLkfXYCH7TkThAIGABqOjCEPHzoSV2/T8Sw8ZRqjC78U8kKF7m6WOzKu5suL8pV6eASgzXU4NO2Vvic1s/ujZDrZwdbI2JN8vfnd/Gjl/ylSPekbV31UtfaOWEc3+WCv7f0q47phaCB5SzY0h1apwBvC0H6qKyM7FHLHWQzoXl9jVE4zHA09PqGNWxrhZUjEaIaENkC9V+0So52vu4uRLZe8EK4rnN/NqmxhkBXEXRvMOZwu4ni5QrJng83ahHP3rUa8h0bC5x3vu+M61lFsT1mjP+PnCpP/73Qi3dgrjTu+LRn4e9/CIkdYdB/7Z4HgKPnD+n49AmjQuijQlxJ2H9u1B+r2cM0/yfp33DtgpnY2slydg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 19:34:52.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce781d1b-f62d-42b3-ddc4-08d7f5e26086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
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
Cc: "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For MST case: when update_config is called to disable a stream,
this clears the settings for all the streams on that link.
We should only clear the settings for the stream that was disabled.

[How]
Clear the settings after the call to remove display is called.

Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 78e1c11d4ae5..dcf84a61de37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -398,15 +398,15 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 
-	memset(display, 0, sizeof(*display));
-	memset(link, 0, sizeof(*link));
-
-	display->index = aconnector->base.index;
-
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
 		return;
 	}
+
+	memset(display, 0, sizeof(*display));
+	memset(link, 0, sizeof(*link));
+
+	display->index = aconnector->base.index;
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
 	if (aconnector->dc_sink != NULL)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
