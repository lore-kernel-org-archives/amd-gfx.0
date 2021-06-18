Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F31C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC20613BA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC20613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA416EA4A;
	Fri, 18 Jun 2021 17:35:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AF36E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEnervr7rcSpf1zN8zTuyl+pEAXsJ4BW4uLVTiyssdCTjmW5YV3jbWn59cWycCPBhI7fCtOKfqsDUU6ZaMr83lqHecBoAb8nwpOTKps/JsSn5L61EMI9sAoWIAro+f3nelk3TMorie2g5Z86GKVYBNlanTct5OinyDIMjb0CnZzP78QBlT0iWbgQYe/UGwU2bAzVDkvMwuLsRYKkEHSnj9GUJAgR8rc4Q/qZ6CiGs1KF5RFnlwb95+RLbi153b/ZKr3RyN8z5oi9gRRK3bnt6qsatIbTJlwlawYxejbWefn0b2SfKqALuDQrqZwm80t9YliYe1PjRAe5EVVQX0S+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAJWoQD38eUT4XPHXphAlkeCTUUoovNb8sr/KyParMM=;
 b=Jx01d2jb65DHSTDhJ0biXyrd/YsjX5kOTvuCU6ED7JLcZinW2oPYRvlXV8QKELEp1UQ55Gy6MLVfRaHSfmlJe5h60FMcXc1KBQR4ig5fNF7M5qa9gmyO9K9QFjY9rlTu6xhAmpG9pJ406ncLwZwzhqPBSyRzHRgoJ4Ci3DmAZjSM9JRcnqyL0Ica+mmE+B+tId+uADnskhVwN0laltYBU8J5Pm1FIL074lsVDW1mm/Ko9GMF2+NgsVUGv12C/kOfQHUSA07pFUZ37+nCkv3/JW+1d5SH8gxP7AAfyKrsLTrhfO6t/NfKu60/NpTagDYe03vKNjdiXJ0bjCxslOYDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAJWoQD38eUT4XPHXphAlkeCTUUoovNb8sr/KyParMM=;
 b=Tz5JoGVPj4ruU5FyGRzPu+QaV52GByT2sQC8namM0Ofrh9NdjUOppbUTwCcTrj7qL8zkKiLTspKETHMWlqAp1bmgRExK9Hu91AvDQ4/c2wDa0If8pp1fE+ohXnsKxqXf63LKUtEUx5P3/wcBvE6QI14u5mMs1gnKqX37+3Gyt4w=
Received: from MWHPR10CA0064.namprd10.prod.outlook.com (2603:10b6:300:2c::26)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 17:35:31 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::1e) by MWHPR10CA0064.outlook.office365.com
 (2603:10b6:300:2c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 10:35:30 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:29 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Clear lane settings after LTTPRs have
 been trained
Date: Fri, 18 Jun 2021 13:35:05 -0400
Message-ID: <20210618173514.430647-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b7653b-f0b5-4a4f-955e-08d9327f7876
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:
X-Microsoft-Antispam-PRVS: <BL0PR12MB250047737DED9E7CC10A572AF50D9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7EgZcAQg+xtGmyVGqbyaRdUi/a79O7Kd2ZTHFEYDXL3i752lArj4Y3Kuyv5oOX0irj1yjF2sN5bdCVxs+FY3hksMq8QNYfuQCL1ZwI1ihwKcbI95tyByWTkgeJQ4jRgvQw+QSa5oiVbYWU9pIPfJ0MDGaAwZbMvaGIMWj2leYQYVLibfFZkdp4oAomH6LQO2WMorkli82kxg4XbuRqAqBXX91QHKKlIK45P9R4Da6oyb2qXs0qDeyLsx8cbzbwkobIEsOlSIi7Leu7DEWnmtkuJkY4zMTv2LroCAgS8VslKsC0twxZr79M+bry1Z+D944Zp0v1lkPogAS1Qbn1ebrlyvC2on3+2KzlEP5YiUtxc2ql4de/wWWtmelpO0O/FLdlB4sMP6ojuiKrSXepyO2hapz6nlTkqb5uetCZp5LSqaoydo6Qvx8D4uL2K/lOnzwnmfRpFuTcYZUfA66mqz7jenfe0uvIbNySISIRhh6zwwyJ+VNZM5yQBpVkYucIoLwbTq/adaYloRWYVsvYJgIO6QRwEh1tdyPryUBntz7LudgDcgWjp7C1QqY+ix6NtlY/1eNr2cgh1QKMEivjiVnc1mDTzDfoTMukaOtRzU++REE9wDhXoIwRxvh/11UDoKa8HpnqaIhh1212i/fYSG5iHGDnVpXb3yD2lSCpacJJSVvtrf/JVOHA+ZbBQjCh9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(70586007)(70206006)(36860700001)(47076005)(82310400003)(26005)(2616005)(316002)(426003)(8676002)(6916009)(186003)(2906002)(1076003)(5660300002)(356005)(81166007)(86362001)(7696005)(54906003)(83380400001)(82740400003)(478600001)(6666004)(336012)(4326008)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:31.1369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b7653b-f0b5-4a4f-955e-08d9327f7876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
Cc: Martin Tsai <martin.tsai@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
The voltage swing has to start from the minimum level when transmit TPS1 over
Main-Link in clock recovery sequence.
The lane settings from current design will inherit the existing VS/PE values
that could be adjusted by Repeater X, and to use the adjusted voltage swing level
in Repeater X-1 or DPRX could violate DP specs.

[How]
To reset VS from lane settings after LTTPRs have been trained to meet the requirement.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5ecbe525b676..4326ac577756 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1664,6 +1664,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 
 	uint8_t repeater_cnt;
 	uint8_t repeater_id;
+	uint8_t lane = 0;
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, lt_settings, DPRX);
@@ -1694,6 +1695,9 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 
 			repeater_training_done(link, repeater_id);
 		}
+
+		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
+			lt_settings->lane_settings[lane].VOLTAGE_SWING = VOLTAGE_SWING_LEVEL0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
