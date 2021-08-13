Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F8060724
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42F8060724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17DE6E578;
	Fri, 13 Aug 2021 08:48:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A0C6E578
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 08:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWDnJz+2Vwb594oFJQxJj9NoZwd6urGPO8vd3Z9v0BgYYuKwwiu9dgRs06lKKdjFK+F+CsZlVK/q/gJaN5j9ZrscKNVDD1+r49oLhmC0prTNoZUgWzW4R5noYJLyX6kPSPc6wcdtHFkSGAd8ZKHGc05eYKfFp9VWrfhayUXVMcrrkwzga9ODBzKOZmozQWG9l46qF7pVDu11kf+JMqdTmbQDlmg9gAKY3JtO7aZJ4akCeZXPk36b6XuWE0kzHcVK5H1Wa1s/oOcuQG6aLr8VuKJy5hjLIgXrN+dFnNb+y9MzIAs6z2fiZC2vQvdrYjgWYN0RXKGTuTvOL/l2Zp0bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2FJ1wcEdFxCmp/YwRgvUN8JQOH4DhgwjtjLndo7Iro=;
 b=H9qabQqKkS/nUKgnteHPKuTntdFcznAf0zqL6REuPIsPzg0zL9tVVtSF+/s8nei4d6QFayRbkt4xuqFvUfB9ycKRBYrjOmX1jnlaspM48ZarIwAC9h6YVb1abxV1ct4KGgJ5jCmZEszo2pb2J4EIMkSirinHb4nMW+UewrMUBnSzH50IRUIdpqeKjU8E9YQWGZWpfZ/uH4U5Fl5xfWq3v/OB/WoV86foM9FvXNZBkESRjxP95aO5JGJYpL3zEWuRacv58R/dfvx9Bnclu3LiAczMXtGznwSAHX7JewDZ1loqs2QJRu/bBIsvpOrfv7gpZMnWb6+iS6ZIMrHS7DQ/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2FJ1wcEdFxCmp/YwRgvUN8JQOH4DhgwjtjLndo7Iro=;
 b=G78oqrscgTjGBUIFAG+NokY4nVJBrBodpmUqnj/Zks9ZbDJI0ZQjTjoRRmesEJL54KZQMn8dXcxNC/4e5+CrDDJ0oNTYelBSA21S1OeaEJv+O0CuQp+kQT7MZsTTp1owMMVQSgAWr25as7XLnAcN+XE1sDMfkosUZ24uxX4+hBo=
Received: from BN6PR2001CA0038.namprd20.prod.outlook.com
 (2603:10b6:405:16::24) by BN8PR12MB3156.namprd12.prod.outlook.com
 (2603:10b6:408:96::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 08:48:20 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ac) by BN6PR2001CA0038.outlook.office365.com
 (2603:10b6:405:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Fri, 13 Aug 2021 08:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 08:48:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 03:48:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 03:48:18 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 03:48:17 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/pm: fix workload mismatch on vega10"
Date: Fri, 13 Aug 2021 16:48:13 +0800
Message-ID: <20210813084814.17213-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed5b9f7-2701-4cdb-375a-08d95e3719a9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3156BE27BF32661AA2AF3A1F8EFA9@BN8PR12MB3156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsdSjyi5/r7j77AFtGmCKlcLG0sBn6KbS0HCI2SrkNBF/WTcNy8e9TFMxGbH/AqYGPEr6V6yHydoVoD/Mh1risAXBbyas03wgCjaNzUHonUAWpeIHH49LJ2yjtfHqKq489g5QBDDnfWfVTsAluzAZaEiw01Xd3VUtjWDwxHJN2gX1Qw/ihwOqYnggnwM1YAOXEag2soD/Uu8/PrKhXEELBF5s/PsjVTsyFTeMcJHtek310xAc81LQX2vPe8n9hhqPWIJbZabBiWhkGMnGB4kM6G7gknZhzH97PAPBDAg68UsM74AT2AK+d5vCtYeByNVYxvUfjoG0kP2e5uVXGvAHybice9AxfITzJk7PnX2KErL0g8aRO+XqcyqWxlTk6773eJDm5B0Wh6iORBjVXxkHmof5MH/ImILIhKLoA5iSMoJad8PopMBmmGf2P8ecAf+XGFU0mjYlh4LLcvKltimLMkq5u0quj4l9Kid74ZzvnhjZozmkWTUoh/jgytacYP2R+sAdBdu3uiwC54hz2UjMLkjZz5uOpUe57/aE7apIM5t/2dMj5n4YYFKtQ61EVruODhWTzX8umiatJVfrJenL2KNuAKBFKAA2R9PQMmxtXy6ccMQ7PknzYp6xaiI+6FkjV50C09TAhLpXHjT4YEpA6mKnQl2DgZvjdPgyuRBNTd/j6W0bNqotqtHHU0okXmapJISVkTBvyzvxiT1HydDVGWUPB7b1SNywUK54dPoWcPyt5Ft2ZMCm6j/JPh2GXPgpYAeYPo6kvrO1nK1pOvkbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(83380400001)(186003)(5660300002)(1076003)(47076005)(426003)(336012)(4744005)(26005)(82310400003)(70206006)(8676002)(4326008)(6916009)(8936002)(36756003)(6666004)(34020700004)(44832011)(2906002)(86362001)(7696005)(70586007)(82740400003)(36860700001)(356005)(478600001)(81166007)(2616005)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 08:48:19.5938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed5b9f7-2701-4cdb-375a-08d95e3719a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3156
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

This reverts commit 0979d43259e13846d86ba17e451e17fec185d240.
Revert this because it does not apply to all the cards.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 621a49f86b0c..a9bd8265b508 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5164,7 +5164,7 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 
 out:
 	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
-						(!power_profile_mode) ? 0 : 1 << (power_profile_mode - 1),
+						1 << power_profile_mode,
 						NULL);
 	hwmgr->power_profile_mode = power_profile_mode;
 
-- 
2.17.1

