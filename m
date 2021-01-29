Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE331C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8403764E0C
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8403764E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012406EC34;
	Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2526EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhgvLVbuF5O6Ct+SWdK4KT0BK8lY03C331l03UvdQA0N9Fb5IlebR+jw+Xp6n8f6BiX54dEv1y8TQjui0qnJZ5geW0c5L2mNOYysPc8BeThz8UUysYaDYDmxNJZrKvTy36aSLJXrRLDbJrr4s5d4gwapvJaGmXCfscJiAz2VoOqortqUIAEwi4TRCYaWwMlz3hg9Q+qlFJcf2wdDNERjAD0MJ1BjEkdeY9R3DHJOlDG08DwV0jVm+NFVZqxUgfiBc9pb7AjduM+lp4Hd82Qx9xC1TUdxselspz8UakarRiszCXz/DnF85PnqtEjjPAFeu1g8Arv3akC21G8M8QCeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRZTgzIkSRUWIS8jEjZuOWuLDWqh2B7Fie/+1ADWGyI=;
 b=Sz4wVOsy8fZXOw4LYPRlpg9a3JQubyEXFUZHJI/8aSK+LDQJTtGxdUrnkk7Mlrr5GVKutUYfcbbaZR/0EcMdoK4IIXayWZufgoNqA3uYQjZFmXoztJ5e7bZWymUCB558uKcrM3jyHYTnhwmkmQTuaYAYwqO7jJmYq23WJT9gjfa2uQG4TiahKfTyxGmFGfC9LYtahBHqT7BP8g2/kTmeNM3vGsi7FD9wBv6uWYxNjFQVh0QYiA+S4MaXLm1iq15q9lhBrtH1Ru+RZxe62e8ER9sMSO7UTzd0I4QINWJSSDS/fFNM2u5Oq7gUlXfY4Q5cxyiOUMuvIYD1JBAtLCNE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRZTgzIkSRUWIS8jEjZuOWuLDWqh2B7Fie/+1ADWGyI=;
 b=15F0ecY6o7LgdelLkQ6LgW9EHPhGeq1CyQBdK7opcua7yJFWmNGqc2utfDRtni7oU5LTxzrCOI35tL335jYXcstYgvj24eJBj9YA+J7wwm3vcEUWlVr9IRuXLryCmylln5dSRBvngu8wctlg2rZ1IgMyEwzVO3yOJa1+dgv0XTs=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:39 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::fd) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:25 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:25 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:24 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/27] drm/amd/display: Decrement refcount of dc_sink before
 reassignment
Date: Fri, 29 Jan 2021 16:27:47 -0500
Message-ID: <20210129212752.38865-23-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67fd6d4-61a6-4014-6493-08d8c49cd768
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431AB4F3DBFB67DFE4BB23FEBB99@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lzQPjWn06eytTcnhaQguVFZfYSwrHmcf5Wv5GRu0sGuOFqpi6Z3a7vZd4oI3gdncLNElHu0f6ZhXlFOB5rdvic855O7BWqvqst5DZlxqre+G7mJc0kuxjt5Xf0WuPPEIe5EqdU4NKDyeZbrxuHazipKJNBd1VxU0bu50A0pFaLjBCR7a4NJMjnsKXOQNXT74NfB2hN2/tuGSKEKTtBp1hNvA/0G834ulUWQiUJuebLRxUwMq/T+cvs1C2S6vAwdGYpUCPtZR1A87+2l5LVvFqHaPkAE20BnX1iWhbalvoWt0V0eElICpqdjQ1FWGM18zgVXKET8beIU9yFgDLbmdssBSeIWNNz8YGtzgDi+jdJ+AwpXi9Yb8rrfTZl0ndi4UGwSWn6k3H7M0pVQX7kWY6D0d+CSywY2hqtL6arV8aL7ZJ2pAru40EOYQWU06qJKiXnBzv5LGiITAVHm19wCg6NhZKoonSyqV2B5iw9J3qopMKz2F3DXHTkFTswIUrrBFj9HL+KwyeLD4GGzQJQc3Wp1AErvQc/lQC0QWYMjDeI3PW3/G8L4QmJCM0KrJR0ST/8cDIKguALAs9VrRSHDS+xvcMxohXn9S8Q1XoTcYC8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(47076005)(4326008)(83380400001)(8676002)(6916009)(2906002)(8936002)(82310400003)(36756003)(26005)(336012)(426003)(2616005)(356005)(6666004)(86362001)(316002)(7696005)(1076003)(5660300002)(82740400003)(54906003)(186003)(70586007)(70206006)(81166007)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:38.0370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67fd6d4-61a6-4014-6493-08d8c49cd768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
An old dc_sink state is causing a memory leak because it is missing a
dc_sink_release before a new dc_sink is assigned back to
aconnector->dc_sink.

[how]
Decrement the dc_sink refcount before reassigning it to a new dc_sink.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3a44a86f870a..e11139ca41d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2331,8 +2331,10 @@ void amdgpu_dm_update_connector_after_detect(
 		 * TODO: check if we still need the S3 mode update workaround.
 		 * If yes, put it here.
 		 */
-		if (aconnector->dc_sink)
+		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(connector, NULL);
+			dc_sink_release(aconnector->dc_sink);
+		}
 
 		aconnector->dc_sink = sink;
 		dc_sink_retain(aconnector->dc_sink);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
