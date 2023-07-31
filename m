Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EE0C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 16:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B8610E2C8;
	Mon, 31 Jul 2023 16:08:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6F810E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 16:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJeGuXunwzITgJry/O1r3VymuCwG8PMSe3Bt5V2wSBnCH4dMau/zuPTl23LQY2aWgYBPM6155/j4EQD1Aa7HkmK41PLn4lA82stHTMSO6RXV1ITaw43maudMjXtHGRnTXP3WfGKlFJsusBsVLjTQ9tSLjuVx01sKOkD8D/Bf093xW0eTQbS7hHgbbJUQrYWOBAvjYGcEwbta1O8w/DlGD51020L6nPGSJtOPDlMrFJvHFLAaNW02N8IqiAYbdI7vex+TQLE7RrlOg1+OKGAyfQBUE7hMOklmrXTbqNZUtdnmOi9HZpNqAcIgQXTCQJImUUoshYF1QNoyiFN4LSzmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5FIepo4PSG9lMXuM7U1zDh8tJ0cpkSsCalZxyVFSjs=;
 b=oet3q6zGpASop4g4WN/apHJWH8yDu1I0XHKG5aheevMNxhTzwOJ8MbiEde4JuCyf/TOei7LxtJyHIjaMw0AVNJ2JpPcBEm0qIeo8q7T/8Ln3L/HEuxNzbXlJQQin8A59ZfN43fcvkw2CWy8deEdGC6OUGTNQgsmHihBp5qOTBBTWNmk7QJiRroeN60bke9HGHyWxwiKEGWwCJK03kn9mWhtJvdScUKTHLgRLpHYu/Nsa837I8Y0KvvIPmdPP4I30dEJ1rtAoOgowiDUPsSIsE/lXWyBbf+mtbmVahf4Wy1exxWDOu6PkpAWN+QB0ZhEEDioNbb/AxfPfLSu0JHA3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5FIepo4PSG9lMXuM7U1zDh8tJ0cpkSsCalZxyVFSjs=;
 b=WADaKFRHX5yw13roVSuDUCBHsSatVvEWNolnaiWRlz5Hzoe6BZKH5O5t3l5o4UkAxslGhDTgeHTYgV8h8R96Nv41aMvos26h3koUdgcRVw5+JEkg0r/TWXY7hu0eG8BfmMlheRaCmhyt8/FaKx0vqs3CLDYLtvxeLOYJSF9UgE0=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:08:54 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::6d) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 16:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 16:08:54 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 11:08:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Don't show stack trace for missing eDP
Date: Mon, 31 Jul 2023 11:08:24 -0500
Message-ID: <20230731160824.1992-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a31c8c-bb04-46da-b95f-08db91e07007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWibf1UhL6xZGWMvbxpNlLlDzXsPv5FYHRc80U64jFaa37m76OUXTodCwaj+JksCv8TgT+pTZkiBWfmetO3orWwUdHcPBs0OEA+Hp9NJkbM8N2ifwVQRo+pIQ201cNc2ucWls/U1SuBB6bKj9fYCsdq2NbHmC58hJfV3R4DAVfD6MtEVqHw/RbneOhHoYw8tSVQ8GuRIVOxg1jc0sXvoQGh+SEHbSR0MSVmH+k8SLb7dgwQCR1M7O0Ssme6CZlfDLOk4HM2dLhozeWggn38OTIhDHYzmVytwjud+9WWqKs1VesnCE5vGZGm+B3ILG6VbHnyOfUAW2uu/rtkmVakW0uyQn81fVaQkrvHUZ8ppy246DifqdqvaHqhf938S1XC96uFBPthWXJlUWoKLgc/ktK25St1k2x0AGbcE6vq3F33hihbnTjUNLTSkqSFwaRuooWaXeOHbdLgBbbzckscDL8fkGqTknlwHCxNHqtMQQSW85iZE/35xdTtoe1ZsK7mchNw8yN9TioTPmasn0fVwPGvZFNsliGlpBXvlv5kXd0mSJ1PPAQLROTnHgcRQc29Nj4adrWjE+Cu0ceaFpwUAnMXwahCFrQNDn+4uNl5FEsrXga6H4NtY8ipz0EBbvHJ8Jovo7O1/sPjO0AkvkH/xAoXfHs9LLtFrKv1quG57GavdGM10N3Ty+CQ8IOkEMOhegucs701/YohB/uN9sHpo1M8pYWvumsmpvUFbrrho228znIhEWVkdcRUylBpmms9XLIcLA2QqW2uvZ2zYc1uPdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(478600001)(356005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(40460700003)(6666004)(7696005)(2616005)(336012)(186003)(26005)(8676002)(1076003)(8936002)(16526019)(44832011)(5660300002)(70586007)(4326008)(2906002)(70206006)(6916009)(54906003)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:08:54.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a31c8c-bb04-46da-b95f-08db91e07007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
Reported-and-tested-by: Mastan.Katragadda@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 20d4d08a6a2f3..3ce3d3367b288 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -777,7 +777,8 @@ void dce110_edp_wait_for_hpd_ready(
 	dal_gpio_destroy_irq(&hpd);
 
 	/* ensure that the panel is detected */
-	ASSERT(edp_hpd_high);
+	if (!edp_hpd_high)
+		BREAK_TO_DEBUGGER();
 }
 
 void dce110_edp_power_control(
-- 
2.34.1

