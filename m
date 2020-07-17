Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF9C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2737320737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vuJLbu2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2737320737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E576E6EE15;
	Fri, 17 Jul 2020 17:38:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0C76EE15
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka3LK35SLTrZ4CfCzZ5NpdNXU/HoCrnfDqK17c10FDtt2cn0rR730CSjqw/hVOXldDgDg8XYDOZmc4axDRJ8Ea/M9nWrYufbFGC1r4icX2TyYkzd98FpkQ/hzr1lwglbSYjKpLpavwo/+Ef/8QoRPB2q8wVohVZW2p/kqGAiAOO0deUwnnwtcPZ00OPWkEE47kC49f4FJ81CzsNWnAZlxyJhzyBow2jKmjr45CT8uSIcao8Vqi0IeziK71Rmwj6U1htay709R8yHuT1zNUuEjzMeCyT3wh59t9n2ISbsdU9M8J2f0cwxS/G7oaLQIE6V3/FRNKz3Cg+Yz7XzoYz1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LxdYIvu+sskzEXUsH3Mmu/nDOJ7jBLr9NIcC5isfMw=;
 b=Bqd7TX/KFvuh6KIlHdl7+TnjkPG1HrOJJN/k6il5A7kCq6IjrRlty2gJcAMVFiCuXAn7bv+0KXhbMgt5Bhbite8evgrhoGOllq+AxnvDJSXwS4V0MnEcFqsciYSU/UcfIeBKpcBH0Jmz0FXxQ7IzTSdXsV+zbcI92EeF4XIHo/HWrsOC+e8Uis3Gv4yMHUQfURT/UrJwHQEuAFuJXjvTkzUSpMD0ZL/RexVOpkQpiEi6RRGKmTPPtQBDBxVetSVUTVzdnARaBc1NGqzurFTXzKzz/FnfZt13ybY6VSlL6WzJcap5hFsKw0r04qBrSKrVDgFGS5Sxqf+uQyrB0eJh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LxdYIvu+sskzEXUsH3Mmu/nDOJ7jBLr9NIcC5isfMw=;
 b=vuJLbu2CGTBTOci2SInCgvJ7PGxP+4HcLJLGghV1Ex6XSb0jfonIkzKMbJHh47pq9mk8+o8rok0bNAGFh1Ixd4bX6f2ZDvpzNQsx/yp2CEMdRDAkp+qK3PnJxSgqFlN2HsiICmHhuIb56iYT3OoAJeKVKwVywQ71JpkdlJoHTiQ=
Received: from BN8PR16CA0004.namprd16.prod.outlook.com (2603:10b6:408:4c::17)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 17:38:17 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::5b) by BN8PR16CA0004.outlook.office365.com
 (2603:10b6:408:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:15 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:14 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:14 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: remove unhelpful 5ms delay
Date: Fri, 17 Jul 2020 13:38:02 -0400
Message-ID: <20200717173813.11674-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(2616005)(36756003)(86362001)(186003)(8936002)(2906002)(6916009)(26005)(8676002)(4326008)(316002)(1076003)(54906003)(6666004)(82310400002)(70586007)(47076004)(81166007)(426003)(82740400003)(356005)(70206006)(44832011)(5660300002)(478600001)(83380400001)(336012);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c32fe3f5-306a-4d25-1c7f-08d82a782fa3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39629D2086C29C5F8CA2C123FB7C0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2ymxKUKp4H20a1AJmH7WpQRiDVRekpQMOkqoM+eHdvyqDgwyT5c66Q5LRFEkHcxOd8HGgJjRQA7zbk8zW2xuOFn0skZR/vTOsQqyb+TM3udcGqLLhqTs39f3smzPBsUMA+oCupTdGAW6N93CCdkkq8CWbT/j4MqwVIwB8XR2lkoJvT4nA4VOvj1EAykcnwFTa6BI8DjdQ+W/y74lPoVzzOQSg8iiiNsexX8ELXeigKFfFYqM3Lw41bMHLpE18o8SnNrZOlJA+3aIOVSVVbY3AodPj2g9IPX6zNf55ah7XjFLOqF09KM796uOahsRuq2vYjlY5uMZiUg75Toc0YaAroK2pVHbQUz7OYE0mIHuYE+SSoYyUm/LD2wXmcv354oXZO+AF2yR4TvZ1I9zp2klg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:15.6156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32fe3f5-306a-4d25-1c7f-08d82a782fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Scaler vendor confirmed the 5ms was not helpful so no point in keeping
it.

[How]
Revert 5ms delay after setting training pattern.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7ae6d903cf04..31c0b35bab67 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1104,10 +1104,6 @@ static inline enum link_training_result perform_link_training_int(
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
 	dpcd_set_training_pattern(link, dpcd_pattern);
 
-	/* delay 5ms after notifying sink of idle pattern before switching output */
-	if (link->connector_signal != SIGNAL_TYPE_EDP)
-		msleep(5);
-
 	/* 4. mainlink output idle pattern*/
 	dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
