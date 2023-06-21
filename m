Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F30EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 07:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC4610E091;
	Wed, 21 Jun 2023 07:30:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE10910E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 07:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj7FNK8rCViVao3DCRybffcVbgbQ2Y09ABdnNpnRlfwf6/bGQOp5yoXvXs2kHWr8U4NecRyLHFYvquZ67yV0730lHp3kTwlcKa3mKdIsTTPmOLnE3vPKW7h2E4IT3MNZq6ai5hfa66v4b2XgDRo2aF0SIPQ7ayuzjmuJ+v0kCWLNM2YRr8A2xxBFMC6VwiB7qsHBEq7kTpfLFeTetxJU0/+RTqBtq62wXL17x6fJzSTIl5Uiql3yNkILIfjdG7FD8Z3TAp4jmS7wqQBVMJ9aZTS21/j4DnbDdEQkEdB+N8gVxBJxRGcJ9M3nUeE7uWAXHgI35WwNo+gGvi2tDhPlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/48QAqYfme1Lu3YCpiownhBGZGkJ1/8U+RDyOgyhiTI=;
 b=h3ZL3u4bGM6izhoW1BeVM6OVo4Zw3APlnAPE/JHEOY9HRy9DDE2wFWqGHQmKq06PyE7rOkakBAjT+No+4zsOqoaOUCsXihdyV4mc/w27BEUwSKL+Y63A4EmTmq7y7Hy90HNeGnzpDHl3IPnBqpluV/4VvMfrEzNogJRx5eU9biDEEdYPgrAAbG/MfJfUCkKUipLo/SgWqcARH5NsEw5x9A9/9N6eE0WjcOORxSqZutn5MHhXmFFqxqxtAq62cdjit/Z5KVyQKY0BOcB7w5FZ4P++azqxd66Cwx0Eo0a6yJ62oQle8GsXlu9ZkzCzVnX/hF8j0DrRH3JePyNYC8Kbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/48QAqYfme1Lu3YCpiownhBGZGkJ1/8U+RDyOgyhiTI=;
 b=oDAhkuTstKAG/F2BSuY/rLMK/KD6lmwFuJJ/i1zkKY5S+DaFJk6wf0SkBmBI2YLJm92mEK3lyIjx4Pbfo5hL6h9AE+b8oWBBL4UakQ4ATSOS7HDWhflwyYYH2qSSh86iCzTjisNdFkiS8dfAfnmLE7J5izuW078btKtCEb3P2jo=
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 07:30:47 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::af) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 07:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.38 via Frontend Transport; Wed, 21 Jun 2023 07:30:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 02:30:42 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fulfill the missing enablement for vega12/vega20
 L2H and H2L interrupts
Date: Wed, 21 Jun 2023 15:30:08 +0800
Message-ID: <20230621073008.1262837-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: c37dab41-ca45-4948-8768-08db72296dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sIAhkwbMT3tmmxiIkYG4iVEFISOSQ6dyZUYWU3yWeF0E03NrgPBmzJvP4RPOsesqLA8F5a0ElncKY/WIeWPT4AORMmhpYzLm9DkuykEl0bTjcAYYX4nXuPdEhPzvQ4xeM+L2hdBlH1uJtLK6zPka6MR4pa+sHsUb4Ffrh128qL1+DktoyUg0JKt5nmKWZUoXxSLHNnCsjrKOjcS7bLm7wxcg/HwICpVgUSfg0uxMHSUxn4wU2Wg1+cqD0bq8+vbAm44T5L/TPa2Hmuok7GvdrKn8Jt8EDlByHphZngEFw/mbmSH027orPihO8JVfvhjowoh70pWw0g+WbndIQABoski3msez8ksrW6y4lN0cTFucvQcIFYw176haWg67twROpY35gry4Kj6JYz6Hkh/+RRPJGflrN7lGu2AiLHdqoxRbc4IIpvxkytwrhEJDlu2Si27bueACuQa8iSQE9USouZ0N8j1SrRt3uY15QXla6X2YuG478EpYwm/cmo2oTY6WDNHVRzPZdzznQNdYzVuKJEGnoRaAJiuq7EtR8tDoWVZu8/c/yJgNiq52txDnBm7G5ayWv3b45/CyjcVQt57s58tj7J088JzrXdnq199wZaRfotT28SZcKipbgEgVaQb05Rs5569rt1CDAbzT6mMNdCMY/UHXMAGlV6jrCV3KSgaMvV7zDHrLc4Z9B9m+vq/s0Tmr6gVy48oeXqrqvsVyweRnkiQZ/f0iXTOZ3FVnSNY1Y/1r1pe59ani0cGNbSH5I9ZTh+zJNikFaqqaxOhtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(336012)(1076003)(426003)(83380400001)(26005)(186003)(2616005)(16526019)(36860700001)(40480700001)(47076005)(44832011)(5660300002)(8936002)(8676002)(41300700001)(2906002)(36756003)(6666004)(478600001)(7696005)(6916009)(70206006)(70586007)(40460700003)(316002)(54906003)(86362001)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 07:30:46.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37dab41-ca45-4948-8768-08db72296dc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature mask bit was not correctly cleared. Without that, the L2H
and H2L interrupts cannot be enabled.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c | 4 +++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
index ed3dff0b52d2..ae342c58cd3e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
@@ -192,7 +192,9 @@ static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
-	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+	val &= ~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK;
+	val &= ~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
+	val &= ~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index f4f4efdbda79..e9737ca8418a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -263,7 +263,9 @@ static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
-	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+	val &= ~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK;
+	val &= ~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
+	val &= ~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
 
-- 
2.34.1

