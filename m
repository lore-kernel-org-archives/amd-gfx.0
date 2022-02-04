Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6683CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C36410E4F3;
	Fri,  4 Feb 2022 19:04:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E39F10E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz/c+q7vSHH27t7jzrlBrc4ghQ9uy7L9fx+1kJJ3sa6id6wFJ4gy8oFrx9yIzZS+/SUVMncY8yux0ZjFrf1ESoHBcwLvaaYD3ECxCTyWAQ8Y64hdLVDIagnVWgwzeWaTpzMImNciDqCsNn3tuYixLo33d9M2r5txz8hlETw/40QI/URhjvLTZ61vV1KlJW7OhcE7+8NyskAyUDhvjdikekTwGmbBlpYBW915FDN3yOIZw01ea770qV5xLaqYJziiiiCjGAEibzR9c877ZWTgJIeHfPFxkv5/9WWq9c2c5XX4ni3NbOEVjsQ/NTQKZ298UkAHJunytgiDg2EzrYV4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=IMqSgr6/KDgpIH2AYXjmQGuAAjgoEUsxvI+cSP0gKnpIJ3vRwUfApMKwx0upwyZJJpzCoVULwVlnFADp64awoMi+dMdmpWpITRZSfietzX9Vm3pLqRYUqEVtM6xyYWgdrJkbxkzGCm3wuDOKopdpWd6PGgkj/xk+OPPXCnYcD2WMbTJXQLJIh19CmS/2X+UC7mvEZlzIk8y1LxmQwL+vcB5ZOutr4JWggVLtldQsV2rrnOe4rSTxHuGxRTPBVWKjWWr7pH7cBjU8+kuxjEe+Ho9/QeEEpQUdyyRUz8L6VtdViciJLBx3jFLQVqPMTlkpo2c/V5V4xMHqo2jNxT5xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=EZj1ku5GwgsgAHIt/wbp8NyOngzI3V+8c5sDqXnExTTVe9AtmHQ0GmZdCRXOUs6Gq0QM4a1O/CDyVRXScKfkffc5NFRtN5viBnrvENPwmq8Of/fHL6LDL8+7njK2MWzuJgCOPzpfqpOyWFXGdh5EkZjsbdkqfJSCV5wjEcYMMYU=
Received: from MWHPR12CA0061.namprd12.prod.outlook.com (2603:10b6:300:103::23)
 by DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 4 Feb
 2022 19:04:26 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::db) by MWHPR12CA0061.outlook.office365.com
 (2603:10b6:300:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 19:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:04:25 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 13:04:23 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: remove static from optc31_set_drr
Date: Fri, 4 Feb 2022 14:03:49 -0500
Message-ID: <20220204190357.94538-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204190357.94538-1-jdhillon@amd.com>
References: <20220204190357.94538-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706b95ab-2f69-4724-c8e8-08d9e811298f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3659:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36590687B182334517BAC959FB299@DM6PR12MB3659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcMq3I3aNMVXr+v4yM6z1kwv1o1+poHWr2iaeR+ICYJQpssmskavjqgmrLAFzczwYxcMfRZil27kaVL8LbxHxvd2LK4KD9mhbjPKDEFqDjJ9rv3H0+KwhVRIqwVt48hlh1zI4ji6GNAfNjYM9mJ5Kt9Ce35i5xHWSMY4Kob853FYfFXJ8AmsUN4ESj2W9KK2XsJTKA2GbVHpbLZXm+R35jbGSgrpzCTCcBuxF3DEoSJA2VaBZ3ZXchjGCqppzNRaxuX7T/hCvllsjCpfOWYamW1zqJ4CoPwFCxjynYyoKRE1t7Hvb5476bsO39LGlAPJ/wpbc19/8h3yEVPRUpUY5x7OJfXPZ0GUKaukMA7rzdg9jOf8heqUyA1f5U0zcA+nx1zl8KSouR3Twe0QH82yqM/bk3VvxtDHW81q40l1G0DLWMljWlcrlaWL93CPba1JnwaL2w6ElzgunLw+tgROIkyulfLiRCLru/Wb0csvU0U8vk9vlpy7Q0vfazybthokqHDJYAuxvrU2puLLzj3hTHVjKlPHE0Z7D/+Uoz1qM6t6MHSW+7PzmsyYz0mKPQ8Xqdv3c7sWX3FK8UUYPTReWzSJiQ2UzYD7dmpJregYLfCZAFCzMgs/U9Q1EWblNNpUIiHMqAXTwn3OilXcB8VWCfpK1Qnhs+Iuk4IJXW0xRlJjxvNrwRnCOKzUsSoAdENvIVUe4a0PEZcOEpQjofxmaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(82310400004)(40460700003)(36860700001)(81166007)(54906003)(6916009)(316002)(356005)(5660300002)(70586007)(70206006)(2906002)(8676002)(4326008)(336012)(426003)(83380400001)(8936002)(6666004)(26005)(2616005)(16526019)(1076003)(36756003)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:04:25.6981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706b95ab-2f69-4724-c8e8-08d9e811298f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

remove static from optc31_set_drr

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index e8562fa11366..8afe2130d7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -161,7 +161,7 @@ static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static void optc31_set_drr(
+void optc31_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index d8ef2f0d0c95..a37b16040c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -256,4 +256,6 @@
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
+void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
+
 #endif /* __DC_OPTC_DCN31_H__ */
-- 
2.25.1

