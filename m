Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2053C636CD
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C42960C40
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C42960C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8486E075;
	Sun, 18 Jul 2021 14:06:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52CC6E075
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1kBeEQcGw2M6HVEgCY2wkfqyvsXo+AUroT3+ISApjtlxx7joALSJpo3lr3Vh/hY6XivBU1qVY5cTMxJohgxlQKCM//MpiIDr+q543QiSq7lyPBw5iMYwY9S6pSdC1nDx+qTUlee8zY6aQ6EAFMTj2MewVWrYJBa0xtL+lyus2QupyQDafDfEGrH7H3/N4IjarQwC9nA7xlxD4yYX8pYCfVttyz8T0fcxEDW+APxW5H+/20tovp/fet+mnYIsSTfhanVuYmI5UlbZ1gwq6lgxXQh6pARnTXsxtY2M2yUockzUzrjtNsJ5erHR9D1XXsbZw4fEOvn2+bA+mPwUntPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5WLwRwkLAhJ09sWK7gUXLRrThcyjyLH8Z/JNvoQBic=;
 b=lNOaG/RLElGOT9MNjAzJu8xsnZ0/6Sgpybs7laLAkeL1CjcdgjO074JPaESNYH1GVQgXA9XZNHQaKhD6Z0gBYEGnWjizAGjntpvunZ7E31DzuRSzrlC00BVWuftB3m4qZls5p9aXLYAQLbRvKqkn6anY2B210LYoRw5+89FO86TilrsyuV9v2jD4thhyC4emQPa1LljHwoTtRB0qzM0kq2aeMaVOXol7exkbnhkN3gr0qZ2UVVUg50Ev2h+XeSVoBq87bUqczd2OyMKywmxbeaPv3ddLkPwqRbNVZm1YxQHBK9X5oterSiUkHW2dtdIvU1tPRAIzdZuOwbGQyWMYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5WLwRwkLAhJ09sWK7gUXLRrThcyjyLH8Z/JNvoQBic=;
 b=WDCwcb366n7+gbP9HCUVod1iIgVQw+Fvs+wFnKDUrl1BTmgGmQlEtmpambwZC0MPQosEIKPqlM/RNirc1hmpo+aouKasg1n1s/OaMszV0r4uA8Gp2kTW1w91P3kv+/Txgc1Kmup7KZ22ZWRpAHLO3RMeAyd1ar5NZw48IVg4fsA=
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:31 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b1) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:30 +0000
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
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:30 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:28 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/32] drm/amd/display: [FW Promotion] Release 0.0.73
Date: Sun, 18 Jul 2021 10:05:47 -0400
Message-ID: <20210718140610.1584616-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63e70143-1764-4cb4-c5ac-08d949f53e1d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16842D4EC7A37F6B4E55CF7498E09@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuGALsu7iPSdJqkbS/uEC5r/tcx9BqGwybaiLF4YLN4CIwhn0IacauEveISivJIHFLKYo1tCdF0Erj4QJkxzCCjf+RPRs4dhn4JX8NZLu0zcjVsw1cgfuftMn6y3eOHkjADazzOsNykW/vQr8o4nqPBgcTL4NT7uIaxiT5SkpuCFgwFRa0dIrUDv4POwQGjAusQJM53iqHPxO6XwpAqpKJ838CqpzeVGi/0ZKC+zI1qQ/mn4vERLkfWuzkI1dMSBCjn1+Ru5ByKm11zolcBjTI36zdWfb+ignvJZqTbut9VtD8pPVRo+YY6tFW7do7al0yISUD099GG/02eT2oC6WPfYuU+MeuY/XZLoBEKKXuebjKZ2hyozao6/N7oyoGSvRPfzF4L8tBZov36TcZNda77Wu/rnPJbUHbgbOmtkmSoFuOEGIOg37oVZpAPI45BXjUlk85xpyjyWQ2TB/YU5+tFlvWJXcqgX87MEaGn3LtylakvBYkY3jzstl115O7UOXMF8rtqSMgZptGmYyLiVnWuXYBaF2GD4YCWLQz2FEI9wYMNZofcUxcK+A9/keualM3J8KtGBA/A3yTak8OZsd/Mr2iDBDo/k6EIoCfPfaui2iEpsNoiRIUGEUX2JhJRevEJQQWOPHzZb3MlSmiCmID3Rnu/ZangJ0Ui3b3y26boa3SeFjtNOtS8YQcEMcQd/V5jTlyLF9Z49NjYIzmpulayRaDeStV+MV1sVxO19x5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(26005)(83380400001)(4326008)(70206006)(82310400003)(2616005)(478600001)(6916009)(54906003)(47076005)(70586007)(426003)(336012)(36756003)(36860700001)(5660300002)(1076003)(6666004)(82740400003)(2906002)(8676002)(81166007)(16526019)(186003)(8936002)(316002)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:30.5870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e70143-1764-4cb4-c5ac-08d949f53e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add reserved bits for future feature development
- Fix issue with mismatch with type const

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 53e3d7d573ca..cb1a86246673 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x2fe298ec9
+#define DMUB_FW_VERSION_GIT_HASH 0xc761b9efd
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 72
+#define DMUB_FW_VERSION_REVISION 73
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -365,6 +365,7 @@ union dmub_fw_boot_options {
 		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
 		uint32_t z10_disable: 1; /**< 1 to disable z10 */
 		uint32_t reserved2: 1; /**< reserved for an unreleased feature */
+		uint32_t reserved_unreleased1: 1; /**< reserved for an unreleased feature */
 		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
 		uint32_t reserved : 23; /**< reserved */
 	} bits; /**< boot bits */
@@ -1447,6 +1448,10 @@ struct dmub_cmd_psr_set_level_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad3[4];
 };
 
 /**
@@ -2500,7 +2505,7 @@ static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_out_cmd *cmd)
 {
 	uint8_t *dst = (uint8_t *)(rb->base_address) + rb->wrpt;
-	const uint8_t *src = (uint8_t *)cmd;
+	const uint8_t *src = (const uint8_t *)cmd;
 
 	if (dmub_rb_full(rb))
 		return false;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
