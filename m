Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E733FC76196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 09:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6580310E289;
	Fri,  7 Apr 2023 09:37:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F04210EDB4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 09:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDSCElehasz0m+tWwLNSYmRs5Fbk/n2deiCYlKXOChc0mDGRus25OWow/6vHy90K6ZawzrgJ0YzHs+4T1+b9PCMNGnM84oZ3ZPb/6TgemOcxEElDRXmSjlUqnuI3g1SCVAP8g+i6Vr4nzdAp2Q7sOpG8nf59jysL0LJMXmUMkT5Gu1hJ4rLXux48orIb3hpey3nX0/Y8L925gJNQ1WDLJbOUYOsIM36wGPJflEtLZ4TfIF8ms6arsYU1/NLk3e0jr+6cqhRjXgUG7WmUWN8RglN0vJB/rq16jh63aOFVmY1Oru5x6Xq/KEKtDXqiYQAqS3bApS4hm1/JAkeJNqGnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVnjhLf8wRTK0U4SNAwdt0titd8ZtNBqcWUQbV7II+o=;
 b=fgeNYVGPl4HSdD5AZv/UFpsgN1oVL8KVmhWdgOjMpgM9yp0pes9sK9lrrmhCcYEGBrahmI6FW1BuKwVl5LiPkujWctxgot8uf2934OFksy2KSFphbeTvWQSsoUN1sEElrg3VjI6AjXOJ1gaMDHWnIFCNE0fL3KwaNn+03Pd+obGjBv+3XBSRQLYg5gYKBpaoAQsuhm2ZVjx+sDEkgXjDk2n7wWHTKHn8BAo/w6lAvUoGFX95J3JnRWjgHlRDX9YnPsMSQu6rYIgoTjkiQrnbk9jTPyHZebPuky3Of3ktLz/q2kpY5p7mRWLRoSP2YUbb9Fc1yOedTvgS1hiriTmDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVnjhLf8wRTK0U4SNAwdt0titd8ZtNBqcWUQbV7II+o=;
 b=40RJV67uzjnj7FoGvbhogf5RWZnGT8wOgol8dYE05dTXEsTlxwlfdizJG14pPbiPXJE8MYU503vpNw2jaVs3q9bSx1Xcq0BXscEdVlkWsNvz2wjjbQ/rAN6FtyjUiZU17ccri3sDbfYuit7kt4GI1mneeffTToTC3/Q2aJ1Bol8=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 09:36:58 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::8d) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Fri, 7 Apr 2023 09:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.19 via Frontend Transport; Fri, 7 Apr 2023 09:36:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 04:36:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Li Sun peng <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add logging for DP link traning Test Pattern
 Seqeunces
Date: Fri, 7 Apr 2023 15:06:38 +0530
Message-ID: <20230407093638.1133162-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a903328-ee98-4b34-ccda-08db374ba219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mc8j8enpybFyADO7vxdyd03LSyYVzDe0UKWn9LRrGN9CXBH/yhTLvGP9CuPvipSee56JVF5aXYzEeF+66wBeuUiHDT0X0SiRXVl63Z+LCgeANif23W0KouXJWmQKrP3JL8sJgBqKooS2XATco80l+PmZUbFPw4MJYY89p5Y9gT488Ij5gB/n34+JFvjb1yrisOuO0bHuWiHMM/oMFfhPB+dclL9Z3m3rixod5kRENyhtUgJ+v2KkdmrLqLC4h/6GAq4V6OCKGkkcHpzZqAebQJ8qugzshtME+xcpeSrQJ0NWd+ICXh2vnmQDiAoIv1cbcuXTE83FmcCyZHH9V3Tkj4oZO2Qe2yEl+HDWYgnw9y43Syc5T+TI9y12ytl5ZSlvjmTwjMHcf4JTnjBCCEtB36v8/Jpksle07aHFCNYvafn/0U6uDsXgDF7GmyF9voJP97Z1IRl3vVvw4+Pccw/KPwCXRaiDkU1s/Ymcgq7rY98NuEgPAy2A+3S3fND+2kocru9Wz2KcWt2Jj8jtxzy7/y0hpcAJbXrq66pcQ6CYpLnfXgTS6427icRohvlyCG3avqYXTPEniHZSV3Z0kOctEUzwCy5gLfG3TOOmPEtFw0voMS0Z+Ic1DVqjGWYrtktaLEKU4MFYUCewgFDwVTFXRTfzVGszRDWxVlaThVOWOixNilc9W5l3hTdjfN/UHEEKsocAkQXat5cJI5PiDUARAKIRghVL+Pyi0AhcX12m5KY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(7696005)(6666004)(36756003)(426003)(2616005)(40480700001)(82310400005)(86362001)(36860700001)(82740400003)(356005)(1076003)(26005)(81166007)(16526019)(40460700003)(336012)(186003)(316002)(6636002)(110136005)(5660300002)(8936002)(41300700001)(54906003)(2906002)(8676002)(4326008)(44832011)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 09:36:58.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a903328-ee98-4b34-ccda-08db374ba219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add some more logging for DP link traning test pattern seqeunces
for better debugging.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../display/dc/link/protocols/link_dp_training.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 70fc0ddf2d7e..c22397d71da4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -213,27 +213,43 @@ enum dpcd_training_patterns
 	switch (pattern) {
 	case DP_TRAINING_PATTERN_SEQUENCE_1:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_1;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS1 DP training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_2:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_2;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS2 DP training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_3:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_3;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS3 DP training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_4;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS4 DP training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_128b_132b_TPS1:
 		dpcd_tr_pattern = DPCD_128b_132b_TPS1;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS1 DP 128b/132b training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_128b_132b_TPS2:
 		dpcd_tr_pattern = DPCD_128b_132b_TPS2;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS2 DP 128b/132b training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_128b_132b_TPS2_CDS:
 		dpcd_tr_pattern = DPCD_128b_132b_TPS2_CDS;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using TPS2 CDS DP 128b/132b training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	case DP_TRAINING_PATTERN_VIDEOIDLE:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_VIDEOIDLE;
+		DC_LOG_HW_LINK_TRAINING("%s\n Using videoidle  DP training pattern: %d\n",
+			__func__, dpcd_tr_pattern);
 		break;
 	default:
 		ASSERT(0);
-- 
2.25.1

