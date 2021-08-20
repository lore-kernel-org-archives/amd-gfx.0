Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E9C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 09:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3643A610CF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 09:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3643A610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC1C6EA47;
	Fri, 20 Aug 2021 09:01:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1CE6EA47
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 09:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK6Z8/p5Nq2xiozNcft7m+sXV77Qqugo4PtipaY5kGkOuhftPfu9SOmyHPIPtY0GXIkEFPx5NxzodjXFkAvUpW0IIS6XfhEMCJec6FxPE/miD/Q+WDsFkZ1lfWzGIFz2cGT2WFSWpLm5wh04+N6QwHufTjF+d1YfcK+cq7IE01DYZh8DeWTPC2VDmyLB5RC6NnqJa8NjXAffYhVVGvIlu6b4ZT5AOiPRo8gZm3tpWM8PxPTMW6SZbdDsJx0YAiQCvUxgcI42Ngy1/sGTkAQj6pUktSqSlQS3PIqpxabsUW8uzBRT9UI7zgWo/asvmD33knCOrSnUP/rpdMMRr0nhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dq9v8KaY06FtDjbM8Odepv54BFLo2t84DQze+7PBrc=;
 b=QGoNh/m/9DnsptbBj9vIhixXRUICWt6iuaRqwsVZs2OGSzK8EwzzMYhk2va4Q1rKEY5KXTZNGskKM/TZ2UqYW23DZUDdnoEJGDsAqHm/6ff33YksTRQZZgaCpgC4pxNMA8PLIb5kSTAq51OexGTfQQF2T1t2IikweKcYS4dn1KH7Tj9np0M9stgp0gggUdWNvpvqsp0H1Bqgwek6rFAEChiiIJGO8sFG5nuVZjp/oQVdcIYgmYST1SDmQPdfvCGhFKuuDIdwii/IvchHZP0XgkPgFQ+Tw/4upxa4UkNRxHLo5D4HBLfA8cxermhyybCrRqHXFXvqNNVzcWY1r8w6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dq9v8KaY06FtDjbM8Odepv54BFLo2t84DQze+7PBrc=;
 b=SJHdcOQLBo+oYRILCp9uikeBm6RrwHam5X+5lAHgza7hhdabcp02+PX2x/yQuJMyCpjCyqniGOKZ9aIPnqfELJdpnBuK6a6uDbSpchG9sGpZgfYM6tj6ndyvEpH3ckfyaexVXpASYDBxwMHZztr1W5LFGs/g21HNgtCqRwDd6DM=
Received: from BN9PR03CA0324.namprd03.prod.outlook.com (2603:10b6:408:112::29)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:01:49 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::d3) by BN9PR03CA0324.outlook.office365.com
 (2603:10b6:408:112::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 09:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 09:01:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 04:01:47 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <rui.teng@amd.com>,
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: a quick fix for "divided by zero" error
Date: Fri, 20 Aug 2021 17:01:04 +0800
Message-ID: <20210820090104.19153-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ba2cb9-32a3-4b2a-020c-08d963b92524
X-MS-TrafficTypeDiagnostic: DM4PR12MB5072:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5072EDAD80CF996DCD9C6531E4C19@DM4PR12MB5072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhfMHfn4fYcjzz/6HYbIgI5blQp2oKGMTeyuwSqpwS4a04lPLo+jnzHMF+FOYIHZrW92BgUBJ7lbXpcp79RjgQJrhaCHiUM2kPSoZ9dje8gKoyy7iak3fe2likO+CEOHeg0WAKpvjLAyNRnPe6iYhCBYD+NUsN1VfsOXcsfyxCXVFJxS0vjTOJ7w8etxtmS5PWnB8/ekI7cR+W6/DaxkolX/mCfrbqFSAtwcaEAS4XHaEOYFcVTl0QlfhBAPj5EyTww7L1czbaPUOaWsp7Yx4aYK9/zNzDcbpO5s+r8NZ1aHsSGgXbhmvkPFg3hjnI6KxxQzuLg5AF7jGcWYTAtApTKLPDeFlUIegPHWtY195wCo9Seekwydkn4GxV95opL7c2eMiV7rArY9NRufIm5jb7gJ6i/hbxT6F+YOrdxztOpIxKeiLKMEa9goHKlGswk1vEs5ZTUwpNU5ZCEaJhwOUY7HaZomuMl+mCSMKJ6AZGhO0E9p4Fu5QYAPRUFDiKoYafi8l9r9zu8diRA6drGoL/9C2cU4FvxzzFDrQ4ihjyIaapuE42coZZbVNp+PIcanJE3hl8nWtbkLuGHon8vKqWGNcp2FwrYyrqHjTIdlpkvEqRuX0+9epKZfoTPtF6sJXDu78qSliN7PN/iNHvrFow6kA7xCCRg0veSqzjI7YVkgEf2RZPRw+8FlFvQeHbL4fm0ksrrNvlfbTTD86RH0Eos+JKbqC4vBzPy8Va+qsHQtTJ1HAmIAVvLRYcW7i39Ykr6ihvL6c+MOdBHG2LaSHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(83380400001)(70586007)(26005)(36756003)(44832011)(2906002)(86362001)(1076003)(54906003)(6666004)(6916009)(36860700001)(316002)(5660300002)(8936002)(478600001)(81166007)(7696005)(82740400003)(356005)(4326008)(186003)(16526019)(82310400003)(34020700004)(70206006)(47076005)(336012)(426003)(2616005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:01:49.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ba2cb9-32a3-4b2a-020c-08d963b92524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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

Considering Arcturus is a dedicated ASIC for computing, it
will be more proper to drop the support for fan speed reading
and setting. That's on the TODO list.

Change-Id: Id83a7a88f26644ba66c4fd15034b4fc861cc6901
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Rui Teng <rui.teng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 20 ++++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +++++++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index fbf71fc92b16..273df66cac14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1227,8 +1227,12 @@ static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 
 		tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
 		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS_ARCT);
-		do_div(tmp64, tach_status);
-		*speed = (uint32_t)tmp64;
+		if (tach_status) {
+			do_div(tmp64, tach_status);
+			*speed = (uint32_t)tmp64;
+		} else {
+			*speed = 0;
+		}
 
 		break;
 	}
@@ -1303,12 +1307,14 @@ static int arcturus_get_fan_speed_pwm(struct smu_context *smu,
 				CG_FDO_CTRL1, FMAX_DUTY100);
 	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS_ARCT),
 				CG_THERMAL_STATUS, FDO_PWM_DUTY);
-	if (!duty100)
-		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 255;
-	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	if (duty100) {
+		tmp64 = (uint64_t)duty * 255;
+		do_div(tmp64, duty100);
+		*speed = MIN((uint32_t)tmp64, 255);
+	} else {
+		*speed = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 01b9653c39c7..87b055466a33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1306,8 +1306,13 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
 	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
 
 	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
-	do_div(tmp64, tach_status);
-	*speed = (uint32_t)tmp64;
+	if (tach_status) {
+		do_div(tmp64, tach_status);
+		*speed = (uint32_t)tmp64;
+	} else {
+		dev_warn_once(adev->dev, "Got zero output on CG_TACH_STATUS reading!\n");
+		*speed = 0;
+	}
 
 	return 0;
 }
-- 
2.29.0

