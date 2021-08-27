Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E14C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3F660EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B3F660EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC6D6E9D3;
	Fri, 27 Aug 2021 20:45:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B22B6E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4fIg7/Sf6+OWV7lnHdJbjaaMrxAHMONxkz/iq1hAeuvbyxqKdxN8K73aX1GBTG9Rtv9cJ84sYHDr5/6JZFE3f0jOU7Kj71cP8ZcNyXZ/MFIOVDczUo2F6UAseqVosEY3MQJZb1DmmZoanItvXTtjtyMwSMeCe7X2yASan0uHCjLNuG/eZK2c81Bic61bv5sduMEgJd0jekyhi2Vuod1cKWh4C1CJHnx3UlgZy2Cq4eDT2E5xowI4/fA9NlPC47ZQgbqbbZeGk3wNKpD3/F9F+x9OmfODaMymbDBTS15LvnQ0rwGqDfPDqxHaXsqoWe12jbLWynE3Guon4ktXAGewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwHlA7Fql8iy6JADw+8uQaQ9Fj/HtTmVqUbKmUvycWE=;
 b=FYn/+zS+NGbx421uCOFFs4rd/75dfAw6bdXtgpQkis412e2JfawDHe1CZdCzSB8Ay8sbulnCAfDTuQ/WQnSIL8z/vl13/1SqQqkPY1POGFxod7I6QiPCBOjS9f0Y/jXw8TQJWg4BRaJLFk3D58QH3pRZhll+WfBxLgc/H8Jn6mA6/LF254oxEYxA3/O7IumoCjf86m5ik0oGP6dj2Wuw1G+eeSXpscB1LGiAawjSYHR4PpzC7Kv4S1i/5W1/GWVLyXGFxVmDDjm5ZXTZmN5lrEdF7Di0aXUcbELnxH/ztiZuPR0YtOwqPgCCaAC5crt1EcHKY510egsc4UM5PUN+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwHlA7Fql8iy6JADw+8uQaQ9Fj/HtTmVqUbKmUvycWE=;
 b=JnWxGgciTayuNL3YoARmlLG+4XXNyxNjdOYArF/UkHJU6Pv4znM0Nqa+ac/IXSkv7mK86WWmNHTuMiBmxDNeNmgJSnXPji1ViseNn6Ih5wwhpOFSc0ma2LQTxNZhbudwmkOoThlxydTYpQCykGZefI3vwPReDbQaeWMEt5q7X50=
Received: from MWHPR11CA0013.namprd11.prod.outlook.com (2603:10b6:301:1::23)
 by BYAPR12MB3448.namprd12.prod.outlook.com (2603:10b6:a03:ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 20:29:25 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::f4) by MWHPR11CA0013.outlook.office365.com
 (2603:10b6:301:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:25 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:23 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Nicholas
 Kazlauskas" <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 02/19] drm/amd/display: Initialize lt_settings on instantiation
Date: Fri, 27 Aug 2021 16:28:53 -0400
Message-ID: <20210827202910.20864-3-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086cffd9-a4eb-47d9-2fb6-08d969995cbe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3448:
X-Microsoft-Antispam-PRVS: <BYAPR12MB344892D4CEEF5CAE4141C20AE4C89@BYAPR12MB3448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tAVyandQe3j8dIN1xynK3YkshER1lRXLEaB7bBXNj3ITjP86aS7+uHSPiIJUf54fJ9qVWyTERIrlerHebkjrRUj3XVaTK4u5yPlLqkTLHKdEUp22iddUI9T5lrevTEMV9/1tCqd7D76TpqJwrQQ6c5ThKCOo7RcZE6JRCR5/QvBm63nJLLpjSjGWXEuFOr5/XfisgQbwnC5YUawSrbjlMkuV4MVnJH8aqseb5rydEJX/9aGLpWPuQWh8qkr30IuAmMkGTp5ff+TtZeekyq7UG0rCF7opElW4LHJIUFwvsbbcIGQSB+qBUR6sXDzp4xBo0Qh0YPKc9LRHWvFezK6tfzr8OuLL2qgZdDfNylTK5bh0KzUpQduAhSBakVEvuW8ZbSnu5Gk7D5yCoyJxodPcW0ui/eTC6J2lvQwaRjOEr9gcS3U5gA5/QaC1DzM2/qMpTtN+Kxf0HUw9Zoicw6Zvy7UDR+8H98BsmNopvbc9fLt38udaJ/Su8rZQASY7EOXqvVAPaFXZmnmRTdt/b5hJ6n+spTeKiWB97fdcu/6Sf8AK1xcphMxdJuVasyKvMRhj8uCuqzSZtUBAIIDbmYU0YDkheEKKSgcobmTqkbF7RztKZelxmeTtoXvccDhfC97FTKTL1/mjm2Zsd82CpuSox6APTmNeiDHNDNRrgT52CjjemRlB12tc9GbknqX4Ppf5sxHBcRQ2XB49ZvVv540PUnTrr9lVrIZNvVPV9EzcyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(70586007)(36756003)(6916009)(54906003)(336012)(6666004)(508600001)(426003)(16526019)(83380400001)(44832011)(2616005)(4326008)(186003)(316002)(81166007)(8936002)(36860700001)(86362001)(82310400003)(5660300002)(26005)(356005)(2906002)(47076005)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:25.4937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086cffd9-a4eb-47d9-2fb6-08d969995cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3448
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
lt_settings' pointers remain uninitialized but nonzero if display fails
to light up with no DPCD/EDID info populated, leading to a hang on access

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8b35cd9d4c01..20bbde8524b8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1561,7 +1561,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	struct dc_link *link,
 	const struct dc_link_settings *link_setting)
 {
-	struct link_training_settings lt_settings;
+	struct link_training_settings lt_settings = {0};
 
 	dp_decide_training_settings(
 			link,
@@ -1707,7 +1707,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	bool skip_video_pattern)
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	struct link_training_settings lt_settings;
+	struct link_training_settings lt_settings = {0};
 	enum dp_link_encoding encoding =
 			dp_get_link_encoding_format(link_settings);
 
@@ -1944,7 +1944,7 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
     struct dc_link_settings *link_settings,
     struct dc_link_training_overrides *lt_overrides)
 {
-	struct link_training_settings lt_settings;
+	struct link_training_settings lt_settings = {0};
 	enum link_training_result lt_status = LINK_TRAINING_SUCCESS;
 	enum dp_panel_mode panel_mode = DP_PANEL_MODE_DEFAULT;
 	enum clock_source_id dp_cs_id = CLOCK_SOURCE_ID_EXTERNAL;
-- 
2.25.1

