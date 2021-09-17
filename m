Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4F2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B8360F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79B8360F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65206EE80;
	Fri, 17 Sep 2021 19:25:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1663C6EE7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP3mcc61Jfke1bvzprbUkQt3zSLpdokwpO+JcmG4e1gt8xwNTUbC4QIJV/YwBTGYpgD7mLgh4ryYiXnOHK2RjsSJLT7YfqyXhRu7oG3CGrpsl+rlJhuhCJwkdCy0xweO8ls1Z0EMKVY6mD75TrVjt1JIMZMVNKPfJn/CYm0/8W2bxyPZ8sskwMGYqtXgXKzX5nfdCXsQe7iGPMVX1ZmAU13ruPP5RkxvXpd/Dq6ZBfbouu0pG00zSk8PDrZQkfIb186whzAPRhob+J21BNh0KDsMNWuSwqn8SrOZN7X7h8RxJhgV5LEubU6ixP3mUkkquWHa+e6nilOA4TGlUFQNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=X+9O13F5y+LyqQYxLpJQRfxRwsMX+tJ/o6qki4NjRek=;
 b=KQBlVAcoSGnJ9vhalWlM6p4t0x4/+BE4w8BQ+Bwt4XUVTKDL/c/zR4UlcxH4EBurm4dhWV4NLTIOOcXQPqlq1gK4dFvyUc+0DxYV3LMmVK8FELDhC1COVp6YzLZ5r7BKw0+dFUXdwaMRQlPYPjLJ4911fP4ryL+g3eX1TovhSAuTvc7X5Qh9V2WN+Xdo0+h6V7EkX9hJnIeJuVacox/iPZtKQr4Ez1Py7v4pb5A616psfvlf1T2G0n6YAFjNuKK3vARYAQxT0hlwHiFW8GCsy74rTbnlv/H8o927xUhfbO989S/rCVdT6Rpn6yqf9Px4HNY++0uIfTK11y/pYHfGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+9O13F5y+LyqQYxLpJQRfxRwsMX+tJ/o6qki4NjRek=;
 b=LWv3Tdx2zJ7+ZS2lfGL/xpsgfml8mpn3Hi3Pl/ElFxGJW9ay+qeRyD2hUE0QEYHAL3kBw5eeFeYJ5x6Pgp43L0npM8dvFlo4brI9OeX1Q102uTg2KFlnlPpJ/CjEZz2XYgbDhDHnvyjd3NiIBZGLjaxPO2vxa5isWlhkV3p3t3M=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by CH0PR12MB5249.namprd12.prod.outlook.com (2603:10b6:610:d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:51 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::c1) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:51 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 05/18] drm/amd/display: Fix link training fallback logic
Date: Fri, 17 Sep 2021 15:25:11 -0400
Message-ID: <20210917192524.3020276-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3415003-9210-430f-39c7-08d97a10f5cf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5249:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5249EE22093A1F892D49895398DD9@CH0PR12MB5249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGLSFl4vSuZ8pnpSfE3XptHpzX0C1UMD+y3ipU1KzgJfC2Tu34Fx6U97Iim29oFFO7ZKIKdmkxsCp9XTgHCTvnJ+AGoCwHxcvVlXgowwa5VhuVcjJ41fIYDVFOxal0k8Vc8VI8etXngZc7lL6VNxSTO6n6rif5J8lu3ul0zI0AKLosvS4+hVOu2clYaD2OIJGgXK/xWJjYhhEE4iMhx0VqnTX8W7DjFhJX3dLEtVYVaM/LIEOu/UX3y+WLSoK7cEqVE8/EL8s7TAEdaoMtwZNiZG7NAlViHQ5qOfKm/TPj//+B/MX88p661bgNAW5LDqGzLMyuvbjT0sGSVLLvd3NDOVhqeDtKobOmX0K8dAxuvkgCeKzjzhjSmj4QlXpqCtOjF9MQ7ktzglaayydudr9qIamC2Pc0fMkgbTwj9E2IAIXCICiKBe68yj42rtxfqP+VOGxtQgJODLQG/uxLw4nf26vbpp7rdRBkCaqC8AOOXYgsK7vmhw03MaKAC6o/i1RrVbN5Eplzwfkl0JvNdKpfrI/M1jpi05eEznHlIAnYUUibLhqSukQTQQnO/z1RRKf82rWS3fGYWsFR3ueItG3Ai9l8pxycdujvbdNLw0Laq9KBKOCd393YIMnMLqRsnAXeCPU1PP2JdryQOCPxiIHlCVXaghCkoklTrd0VdXsz4N2ielklw6Out4vn4q6RldslYW8ZqEtzjRae5BJ0FEcceueYM0pCEq5xFQq7hhT0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(1076003)(5660300002)(81166007)(186003)(4326008)(54906003)(426003)(16526019)(6916009)(336012)(36860700001)(47076005)(26005)(83380400001)(8676002)(2906002)(8936002)(6666004)(86362001)(316002)(36756003)(82310400003)(508600001)(70586007)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:51.1265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3415003-9210-430f-39c7-08d97a10f5cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5249
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Link training should fail if stream bandwidth exceeds link bandwidth.

[How]
Correct fallback logic and use named variables to make intention clear.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ac4896ff912c..c96a8694236e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2441,12 +2441,16 @@ bool perform_link_training_with_retries(
 			if (type == dc_connection_none)
 				break;
 		} else if (do_fallback) {
+			uint32_t req_bw;
+			uint32_t link_bw;
+
 			decide_fallback_link_setting(*link_setting, &current_setting, status);
 			/* Fail link training if reduced link bandwidth no longer meets
 			 * stream requirements.
 			 */
-			if (dc_bandwidth_in_kbps_from_timing(&stream->timing) <
-					dc_link_bandwidth_kbps(link, &current_setting))
+			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+			link_bw = dc_link_bandwidth_kbps(link, &current_setting);
+			if (req_bw > link_bw)
 				break;
 		}
 
-- 
2.25.1

