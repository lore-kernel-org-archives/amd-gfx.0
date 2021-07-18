Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1FC636C8
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7FF61182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7FF61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF41F89DE3;
	Sun, 18 Jul 2021 14:06:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04389DFA
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf0/GEpmK0UWCYhBMGTK/rcYVvApZ1vXIyE2Hs0UpNL3nnqOg78JR6TFPdMwhJGtPshTD6maDrSYX5rD/saT3UrY6T6+T4jxRfJKqaqkYfaGbPBh7qPLdgnMbUzHQgbNGcmtHFsreymsfcN2nk2Iy9vM4rvjCsRnJQB6Mle6KiBUbrsDQpN31pZfU3dZ0p1bu4IXHX6gARF6NZ1VEInjgwdmDx4PTua0rwZJH21Y98r49pcMROLb/JVEmj0HtTyskLO+FJvKk/UNY+CGTzFGhXaqtnVGbx/i+1jXxMPeQgwM9CK4BVdQA1aUiC0C9cLLFF9h8X7yJrA7UPGVptNj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6ebtrRztXExub7znjL6Rl2CmGULAISUbfXuJSRKMlw=;
 b=lEzTcpqBCw2GTeyCl9GHaKaUr5nUabym3AtLdNVIhEQnvzyzAV/5EutgR5vciLwXy+7ounxViioH+Jwi95pB4wkOTjWqO+i4PTJb66hT8ZFjn74jvfzZl6Iw9u448mfGVSMTaP/AtxSdDlQUROU0ifXnPwqe7KpMOQ0B+ZHN2GnXf/blHhqdpeF24XBCKC2d25d+oh/CeLaI6MbefdABnHBdeHM6YDJXZdrvznJxwuzLfJcvqXioSEg47Euzd4yHiLaTOqbsiWH0LBhFI/3SUyN+EEceOG/I+qSDQ8Bfp8LrY/5quzSpipmsB1MHmrMo80vUDKYRYLWW30X7y1S0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6ebtrRztXExub7znjL6Rl2CmGULAISUbfXuJSRKMlw=;
 b=IogPnFQdohb7Ksf5H2WZ8lKoOMvNdrVXHt6o/dRggssLhP46WcnNkk4rXda1RMPnV9Dhhzgg2iHIfL0+dmpAPTSzJ1Ds2484L8aWK3P5mEjA5N922PHYeIpgOLwIUOBiI5/f3C8MPj+AR3VSUV6ulCUQbkGE1mtDKub7Czpr5fs=
Received: from MW3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:303:2b::13)
 by SN6PR12MB4703.namprd12.prod.outlook.com (2603:10b6:805:ee::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Sun, 18 Jul
 2021 14:06:24 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e4) by MW3PR05CA0008.outlook.office365.com
 (2603:10b6:303:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:24 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/32] drm/amd/display: reset dpcd_cap.dpcd_rev for passive
 dongle.
Date: Sun, 18 Jul 2021 10:05:39 -0400
Message-ID: <20210718140610.1584616-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4942a31c-bc00-4073-ada8-08d949f53a79
X-MS-TrafficTypeDiagnostic: SN6PR12MB4703:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4703BB9EBDAA3F7C56CBEB8B98E09@SN6PR12MB4703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 968H8g9Ml75bQKCY2TCtfxqCaSRosC+XGsHfinRJNdzjEro8PEm+gAjjmqMjr8TEEQVsm4u1hqEyfmGC5rrjgpbdONRFB89qtDtwd+WF/i6bZm0OSFZUU5Gtt1aNz2fmiUXwAldcv6zuUKAFqFZZXWNHVmHVLhudfysywtnkMuYuROymeglFevamb0KcluNX+trDBXk8W9hnA87SxWz6rUR1NWI7JJwCkrLSYqasYFNWMY+PRQmFs6FdWYDfnm/f1AnVW0ja7I1RfwVzOWyesFhpbeQpR3oWQRNSjeZuZ7icQm1Xp+ilOxJprhpHN8g+1rCwkcUGIOJ8eAcM4ujCT1QOBBXzJeYEN0ByLs39RSJeuOnM7r7nkaFe2YCJLc9w4jbMKWOVrYLBnun5kZtBpgXMZ4TPm9583LqH40iRMvGsIRwk8ro0DVTI7RUjXIncW4VAztZneP5lpEP7CQehwsxB6lQLpkfxsl3D2Paa2AHmpO1en79v3PZ/0hG1dCMteQKkcPJaUaTj6POmZxJg7w+ex3WDc7cw98zgnC93DgGqcYxbdfCRy5+Q5T3eRW0644mW9BisN3jydfO/zpvbndnP8cRnzxlMlQ2rYp1fuENpHfYk6I7Tg7dNy9OdfBtJgaRGtXwnhhR46cNCCrmI4Isa86JX2nLLHxAVgKIFt+5MnxW0sWjSG/E+aiB2i9kfjx/6kMtPseEFARs6swfBTKA16EU8FKpPauwjVKwBpfs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(82310400003)(86362001)(47076005)(8676002)(81166007)(6666004)(36860700001)(2906002)(316002)(356005)(83380400001)(26005)(70206006)(70586007)(54906003)(36756003)(508600001)(186003)(16526019)(8936002)(4326008)(5660300002)(6916009)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:24.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4942a31c-bc00-4073-ada8-08d949f53a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4703
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
currently dc has never reset this dpcd_cap.dpcd_rev.

[how]
ideally  we should reset this before redo detection.
change the passive dongle only for now to reduce the impact.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6132b645bfd1..655b48c5ef37 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -541,6 +541,7 @@ static void link_disconnect_sink(struct dc_link *link)
 	}
 
 	link->dpcd_sink_count = 0;
+	//link->dpcd_caps.dpcd_rev.raw = 0;
 }
 
 static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *link)
@@ -742,6 +743,7 @@ static bool detect_dp(struct dc_link *link,
 								sink_caps,
 								audio_support);
 		link->dpcd_caps.dongle_type = sink_caps->dongle_type;
+		link->dpcd_caps.dpcd_rev.raw = 0;
 	}
 
 	return true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
