Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20790C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D566E60F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D566E60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884E86EE7F;
	Fri, 17 Sep 2021 19:26:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C09D6EE81
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awwAZuWZa5oxWa6/10HcA3XMjec8smWf9o5nrt48FUWrr2doLmjqp/rHJD172Ls6i3lY8i7rgGmv2fwk90nGLUL2JWRdpFeQM0XMsVsxwtk7613ogeJYcvURcQdVISXCmcV1Zp4k/GaBV5iur+CdERvhze3ygx/Te0eBSAfm1tPhaxc8GkJ9qOd/VVf6CPiphYwC5ABaEskP7QSfEXD210EkRrGHHSfeTXbwRu89IN1t+smn2uJh5Od3dVaT2Zcx5u9BuI+qzcV8P1wy/c9g8rYrLp1R4RBbuLYcUmW/AtlJCGlXMXd64VAOVF77j5FL+TBct8SVEaf6n5PX23iKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TwjqvB7hEpKutxGh5EwVz79XV6asPGNLPBFy7KC2EME=;
 b=j3umL9MzEfBd3twcD4p/mMwkvyZSBYWDHlt0v2a6L67fqGz7qGhXIhMg7LvbcUVhqaOxrYWypqybgCUzpZ5xZhbzYGL13ZBdAJzK8m+lZlL0kSIG2AnEAUOBV/EWkJXZAYirC7t+8u14Q96sX37VzBnFV1wY/QGAIRHgCRnOe+BHCsNFAL6zkmv+0Sa1H0jqN0oRpO3ExbqYEyOWzngEnoDMDqvrM+Fnyj0zDKCVBkBy5fSqaQYFW+6wR7TlfIAthrpvdB6DNzTS6BvEP0rDZ3bbZFi08mUw18I/RC8L994ECpQGGhtDBj9RyfkiBiSjUgicnQ2OekDl5M7rPkJsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwjqvB7hEpKutxGh5EwVz79XV6asPGNLPBFy7KC2EME=;
 b=N1qBQDUe6dVY86KdqTEjBhWA27+rwsgTFPHOgxRWKDseMLuEBrSr8DCiC7rsye6CNKrIxSeUOi2H9h6SOTKQ3+9VcHyR99JETLeHXP+VGN54hYR0GcoU1ur2NVNwfQC8Mw1rIUT/G7B1C6+Rylavm3sTqR5FjVXld+jnuAO7rI0=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:26:00 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::ad) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:26:00 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <jimmy.kizito@amd.com>,
 Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 14/18] drm/amd/display: Creating a fw boot options bit for an
 upcoming feature
Date: Fri, 17 Sep 2021 15:25:20 -0400
Message-ID: <20210917192524.3020276-15-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7843a1fe-ee06-4231-06ae-08d97a10fb8c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966DAC92E34D6670F1DACF098DD9@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ei/7qDJbKZTtIdgEgeA3oXJDp8NuIUrHGKtdsHxAX2I5SMqQG9MkQ8F4qMLpFPpeLXP2B+Fou7EaMCGxwY5DJfGW5dau/yGhDNqRDATcbOSMrWHNDZS4QFBGjy1bnmRjmf17jKTEQL6Ei0hFr6kK6iqCNEIO0p4YgXPuAtfYRatmx2W8vgO6icZ0kW++84wO5E4CpxFDBvJIW6EY1b5PCmg6YYnzcWOYJQaOo6HYG45B9m0yEl3pZmzbaGbEihU5ssb3ALuiRSGIh7g2RKbWh4gIg2fpsHioR4ZiI72w/KI+wr6kBkfbOt/7hWgClQog8oswP+AKO3cICmYnyPuSDrPDhxK/1RbCkDaI5QsJmlXBnjXUziZB3W6XFXAkh+HRPf7LOVC4w9vbNz0usszj8cz/Om/ZSCfLw3vzrxbr/ObaKueV3kfv3GMqLKe2GNOUmqomYHyy0ckCxOExPp8h3VuXDXTUSB+6HI/bC7bFVCMrMaa8dYe19+h7Iz/rlgZ5jbPHkKXfUGm4qKTgJ2MAG+o/f4Ohiumkp5gfFSvT6W4MHefotSq9UeWrSRXmfuYJzOJl2gOHRnCPrsLy8h/nT7yy/+vZKw7MQSCVIYhTozCexFHNV+jgtWz43ielETsZStNW7mIXzrVqPYtTcrv0oyyKJeGpHZXhKCuUwpUqFhlxG45+yVYSU838X0ehelHQ72talb+phDzHwVUHhlKr+AZtLoeS178zNQhEsMoA9Pw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(2616005)(4326008)(81166007)(54906003)(1076003)(26005)(70586007)(70206006)(426003)(508600001)(336012)(356005)(5660300002)(6666004)(186003)(6916009)(2906002)(36756003)(47076005)(83380400001)(36860700001)(8936002)(86362001)(16526019)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:26:00.7509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843a1fe-ee06-4231-06ae-08d97a10fb8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Need a bit for x86 driver to enable a FW boot option for an upcoming
feature.

[How]
Added a bit in dmub_fw_boot_options for an upcoming feature.

Reviewed-by: Jimmy Kizito <jimmy.kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1edc5bb4d668..1b377364ace7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -372,7 +372,8 @@ union dmub_fw_boot_options {
 		uint32_t reserved2: 1; /**< reserved for an unreleased feature */
 		uint32_t reserved_unreleased1: 1; /**< reserved for an unreleased feature */
 		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
-		uint32_t reserved : 23; /**< reserved */
+		uint32_t reserved_unreleased2: 1; /**< reserved for an unreleased feature */
+		uint32_t reserved : 22; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.25.1

