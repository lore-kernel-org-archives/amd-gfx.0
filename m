Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF96C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 18:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5D510E166;
	Mon, 31 Jul 2023 18:02:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C89810E166
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 18:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+u7T+HwzdnkAYCX5R1FhwtP7jhhs5aYqh98vLAuVzkaaajFwjm6grFzhNaJp5W51lCUxLowIRafT1Y4w6ppUeaOK3QVoQTzsILmLeOhN8DCiDku0Y67WNesPWiVqDV8CR5eeaKjOjKoiEcMhxxUOlgaJuQXtI36X1XZvblypYn3YFWbY1z84294OKxIck24WW5NL9wNfu5ytfIRAQkFg50I5fCqB12rzHOakesh1bDNQ01Xg7y6pWoyrZbxrel+7F4JFdugYJ4OMX5NMRqU0Ivgd+vIGLYxZrwgpvlaSPWONmn8jY9XfnDn4v6RFLqFgr4va57Zzc8mitqWIQSsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My5a+kspwHe13pPy9dIx+P6QydnsKrxoZBT+7sMZ9WA=;
 b=i6n/WsnFrEB+YPbNLwF64w18lWAjT6mlwkJq2LS+XDF6Q1DScZkMso7GJ0WGhgvZJD8Gjj6aQ4cVMLSBnWYbhraf4qw4Ezcygnk0kEAfZMMG61reiZmi3jfOK7FDpVISsg7JinpSngXVxyMy9+OtgpXmpSxO+vnXuy7S6ICHm1ccOO5eP0WlVDgYP3ZlIyfFDBCS1GBL7raV/s8TLHlNXqn9fLyjRtSDjsFsEHEHa+clGDW6l1vOgPXNdxg7jggYuDnT4GiCGBpZAyaZPpWDfeX/cDhiuCz+6Gjysa/L5h3h3T8Puvge0CTrH62m86baGfDIkFTDyYeUKVXXtYcx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My5a+kspwHe13pPy9dIx+P6QydnsKrxoZBT+7sMZ9WA=;
 b=tfHqSM8TnvW0qvCA5lkPNJq4UEYLCUD8BIGAJ8SEMqqde7VGLjYsu5iZQL+U6gwLxx5wckOd44/GgexE/NLgu27ifz6WTmVaS1qzb8/6YhXYcAoy0zQRnPD/rqYUryORwzYqpiFUSF8eQisGx/ie7lz3AC2Fb/uOmqI5dgXRgDs=
Received: from BY5PR20CA0036.namprd20.prod.outlook.com (2603:10b6:a03:1f4::49)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:02:29 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::dc) by BY5PR20CA0036.outlook.office365.com
 (2603:10b6:a03:1f4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 18:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 18:02:28 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 13:02:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Don't show stack trace for missing eDP
Date: Mon, 31 Jul 2023 13:02:14 -0500
Message-ID: <20230731180214.18121-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b038c1-9f6f-437d-56ec-08db91f04dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9hZueNz57GvDaK7FxXCS9zd4epjMjmsSBUWHBCeKHkx/NnON7YnTvAce88FCJMez98Xe39DrWSh5sL7kR/dLdl0ujkbKaCP6fPfFE7XScHE7E6lqLGkWA2aAFPSmBJY7NT3yPRZRDmOv2fUHwI/Gt3R5gPS0SduDWy5HORcuiB3B3CQOIaekUyMTr1EJ3/rb1IUy87KKzQd/N5KXPw7+qwcaM1EaUUdamPIHVtMEAeIgBsr6Tmhr7w4+pFNlg4RbFyd5+quIDIwbttcUagkkCF6+406j079guB8gt4FVSFuQODzg92ve9GMWywVmdxJraO04mHTH5SrNAqzAC3BwmWjTI8GwQRqUUtf2dTfB50wdUlJ+TcRvb4p03hJzuuxl79rki8UJkQsvsJCId7iKB7hNyuc+cks+qISp2Q/877usz/4Zzvsny82fAFahyvoVLytwHU9leSn3DZhE0lwYxtwNM9Kvg1myy+79kMZeMZJbcsIstaXyBY3uudYeM01W+Hqp0u9JEHl46KZnNMhJs3RarNIxA8DEfa0OYaDwddpQJ2pbZnPnX3NuUAQ83WDUEE4ikOlov4TAwz6rpLOTFp0zTgYY3AO+dNY1p3Ixg5J9qZr1+0GpSRWSVn1+lC6KufVHy/1BMNkL3i6Aoi4au/1Lf0J5T5qA7UANflCddWIYFNyLRuKejZ5pmo+zCY4SSwyaSMDLK2akmheckhl9hYyBe1KrZ7OBQ9Otv9+H/3NonoOuCsApY5myawNB0EkNv6Xwu9l6tut3fxO5gytPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(86362001)(8676002)(8936002)(316002)(5660300002)(4326008)(6916009)(54906003)(356005)(41300700001)(81166007)(70206006)(70586007)(82740400003)(478600001)(2906002)(6666004)(36756003)(47076005)(36860700001)(44832011)(7696005)(26005)(1076003)(83380400001)(426003)(336012)(186003)(16526019)(40480700001)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:02:28.5545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b038c1-9f6f-437d-56ec-08db91f04dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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
Cc: Mastan.Katragadda@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some systems are only connected by HDMI or DP, so warning related to
missing eDP is unnecessary.  Downgrade to debug instead.

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Fixes: 6d9b6dceaa51 ("drm/amd/display: only warn once in dce110_edp_wait_for_hpd_ready()")
Reported-by: Mastan.Katragadda@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use DC_LOG_DC instead
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 20d4d08a6a2f..6966420dfbac 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -777,7 +777,8 @@ void dce110_edp_wait_for_hpd_ready(
 	dal_gpio_destroy_irq(&hpd);
 
 	/* ensure that the panel is detected */
-	ASSERT(edp_hpd_high);
+	if (!edp_hpd_high)
+		DC_LOG_DC("%s: wait timed out!\n", __func__);
 }
 
 void dce110_edp_power_control(
-- 
2.34.1

