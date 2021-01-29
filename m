Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E2C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EC664E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EC664E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797E96EC31;
	Fri, 29 Jan 2021 21:28:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58686EC2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLCPbg99ba2xHTl5qaew1S71dpQ5Bb1ezwLi+3R+8B5z3TkGxxYphCseRny3S3IrHgGRdOfnvgD6glbBmfBTvoOmw71ghNK/MH61pMaZewUsSKe99Uyyjzvh+M7IeriQ3TSswqUu+im9ktr58eEyYhnEBm7UGqdNqXCHXnCe4ujLexyTdEE6tIspeNGf6rbKwYZc69dLUheIQMnY1lDEYIO8seJeBIH+Ge8xxrR6VNH1aQq5Fh++9iLP2RKN0uhJTFhHTmIDOX8+HTE0UZ3k6eWhvYtTSQSdSUgU0GKS7Iem8owWQa72poTH8EaIwkjGrCaT9c1NNkErJ8Sxs6Iwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48kGwIwtI3BaBqkASv2BMlsjITimdmqLKj+lsqT0Ps=;
 b=g5j7FKAi/Ib6JqDy57ST7dA5qvnXL4heafdBNdOGenFc6CrabLYFbx4F9bBAllDUeq2qhJdiZn7ne6YwWUKLBPMDPOxQiEpGC9bme2VweF8CGXKfR8jwTp4r32/es0ygk2WTQpyIDIY3E1gi8nOD58w7JB4lxs6RUy5WjFPRhE3mwhmzyZa13n+fyjlJSuBFSvnAs26O8zyqy1+GQ6ltgqfwnQORksTTnb/zLPzhirGT9GYl7bH5MRVXQazWZms5psj/O9pIrMg54GjMEWZNvzbOQ/WGJVg2lFxpbPDe4HygmzTfGeV77gckpbPHbREyBPmwTu8zI/1rkCF8X9KDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48kGwIwtI3BaBqkASv2BMlsjITimdmqLKj+lsqT0Ps=;
 b=ZUEmNvaEL1joNRCDOXdwubwuQEWw7TU4Pf9sRe3WBnPfXi4yHTO9UpUMZCVsKiwRqb7FrMxHbemVENc3B/8f7z6xRlDRUZUNd/b72rSyJ41nIGiK/pFWbQroDv4SgnmmM94pnqDOriTozKzO9C93kaIrW6Jr6Kf8JoaCqlp0LZw=
Received: from BN6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:405:6f::34)
 by BN7PR12MB2612.namprd12.prod.outlook.com (2603:10b6:408:29::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 21:28:26 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::20) by BN6PR03CA0096.outlook.office365.com
 (2603:10b6:405:6f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:24 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:17 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:16 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/27] drm/amd/display: Fix dc_sink kref count in
 emulated_link_detect
Date: Fri, 29 Jan 2021 16:27:39 -0500
Message-ID: <20210129212752.38865-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5d732a-b05f-4dfa-d062-08d8c49ccf54
X-MS-TrafficTypeDiagnostic: BN7PR12MB2612:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2612D5E341869298F991F76DEBB99@BN7PR12MB2612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0luxGoPkLzGnokfg70OnVGvgrgh7e9UG06CbfPdwsjC7rCef8MubfFBryGHnG10cE5qFJDt5+Rp1+KfpqhvT/NSPYQWYBuK9sxwXq0RDic0NqUxM9LH6fp2R7U+5DaWUC6suvPgZUXRBLCD6KLN7/cA87jziylk4GLiSdEuLJ1vMl6WTopcsdNNqQD1qyg1WdZlD2Bg3Z3lTfA2r+z5R6mSXDjwbHsYzL6NmI9LTTD87tBjGJSd/uY/dcqZ3Mn642kOAlNyLU3XRR96uc5EtyK3Z+M47/Z45bSuc547sZQs0beceEapTF9Y4BC8t5HNN8tqQ34b1MF3OYC8Ue2jyDPqwzNuJswzxRjl26U2tmf/Yist7jTY6k6nmtRCJRBTgjnUat6K0nUnlhXZLLwZndQPvACoNHuyE6jef/biAEkVDIuJ32DxmJr0w2ozGOrtYJwalOI2xURJtgW96TND8qRDrZK3YH9QWMauy/IvtooUBbYIm2q22PUqlfJxmlijHvrpyTYx2naK4SL3DqT/J37EHsIaZea1PuUZKHW/3SeaYHdSwiawd2mX59ABkeEF87U0LEFRjVjdoJqzinTct5Zu+D3PZnttyvWz+aSdm9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(83380400001)(86362001)(6916009)(8936002)(36756003)(6666004)(186003)(26005)(356005)(8676002)(70586007)(5660300002)(4326008)(82740400003)(81166007)(7696005)(2616005)(336012)(70206006)(54906003)(426003)(1076003)(478600001)(82310400003)(316002)(2906002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:24.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d732a-b05f-4dfa-d062-08d8c49ccf54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2612
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
prev_sink is not used anywhere else in the function and the reference to
it from dc_link is replaced with a new dc_sink.

[how]
Change dc_sink_retain(prev_sink) to dc_sink_release(prev_sink).

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 67629ab0db61..f9d48ce1420a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1835,8 +1835,8 @@ static void emulated_link_detect(struct dc_link *link)
 	link->type = dc_connection_none;
 	prev_sink = link->local_sink;
 
-	if (prev_sink != NULL)
-		dc_sink_retain(prev_sink);
+	if (prev_sink)
+		dc_sink_release(prev_sink);
 
 	switch (link->connector_signal) {
 	case SIGNAL_TYPE_HDMI_TYPE_A: {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
