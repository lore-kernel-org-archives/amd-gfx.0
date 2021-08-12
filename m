Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB8C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80E860F91
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A80E860F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273D86E1DE;
	Thu, 12 Aug 2021 06:17:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EC26E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXoCFk4HeCBsYqnsg/yr+vokxNIJpaz3IjzjwbJ6CPj8aiD97eWkjS5fWou0cei9KST3lgqs+lsY6ZbbZbgSx9AYUSPrIA33OTOPf8gI2b12VaaU3F08Y9HqSILjOSk7bndaukIRxf/cswGeFEHwOJTrbydCmrbWFARWqOoQFgRBTzSkTU0ypM1h+QrspWGIxiv8tA2yP20KlCZWNHosWoj2DxWVgbb8o+kVXgKH4bOC1CdoN2wd82meVHwhaMKGPeBoGz3Jm4+t7UfFBobkePHXpYG5Re6mEt98QvqWQxV77mDTuyXqhn7GhCvuvAferT+f8i5Rwku4zxF0tjNtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwBv8FMciVJolwdIVp8dGCa04aOVBF+llVB4NZA/Uz4=;
 b=caGkjfcXMmLfRHHb00gl3MVhwdRUib67ODxaU/qOAGhIjbz+fgbyjQ5sVC5N6BFEfKxdQ8KpYm8GRWNrxDBr5nrVYI7yv0k5INWnrAEGYo78c+m0eIGrNUnqmKllJlyV8p98cyqqibkjxAMu+AMlL2x+n/Dqa6yxFHBCJ7FAbkId7LYofZRL1MyPbd74weLUf99z45ksrPVxNhzOcMzwxQJkXxFY9UYdmd0RBJqWl0sTZ2qBTawNvEzLnmNhfeWl8SaG4h+Kr9EPn9kpi1sQZzVrtaL+ZIorxCJIIlovAWFdio82+aMBbrv/MLg+Jef97G9YK/UySX9eCqxUgysLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwBv8FMciVJolwdIVp8dGCa04aOVBF+llVB4NZA/Uz4=;
 b=39Ge1qd1GgHp2K1qjk7URo3d33Q+dO6fd3jIkSy3MV4H47WumcY+n7nqg+4fgUaYpLkyTZ4tDs99C+Cyo2x46mwxwur3wyYyN1VcCF5eXf9Xs4sJmIozvRTmMPM+eeAC5TprzfPI8DSvo1rL0xMBsYumK4rzOfAdo1KhFrb/AeM=
Received: from DM5PR07CA0047.namprd07.prod.outlook.com (2603:10b6:3:16::33) by
 CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.20; Thu, 12 Aug 2021 06:17:04 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::af) by DM5PR07CA0047.outlook.office365.com
 (2603:10b6:3:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 06:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 06:17:04 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 01:17:01 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
Date: Thu, 12 Aug 2021 14:16:53 +0800
Message-ID: <20210812061653.1286150-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812061653.1286150-1-kevin1.wang@amd.com>
References: <20210812061653.1286150-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e97d07-3f7d-477a-698c-08d95d58cdda
X-MS-TrafficTypeDiagnostic: CH2PR12MB5003:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5003234863EA144270A14CDCA2F99@CH2PR12MB5003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DNngEinVWofh+mup8/U2uq32XBlhnFyVibKPjIOoV7z68OZOvYmmICsHseUTQF1B/eSLPrXaWmgJrQ6lawZmejuoaKFAm5ksZbXqGVJjcubFP088rChMVuBuweAhvXxzfG/XZOExvqOUjyUGydK5tejxZS9Z8jxmCKyk71JRHQNeBjnL6ZVVDyuJgvqbZff8wiSVZa9nnQBsFwmLpGhzUXn50mrgOog4lPHyBg54p18Q1quVytI7ALdUtknUYbsSDHTdR/02tfqLBhd8EAK0oQj9dtsOi4fZifA9Vh1Pf4KL9vlTIbGJhHmybXInJxjjFLREiRRfV+M0O64yAR9Lb3AoZ7PTk0P+B937Uovxc6Cr0fghTT8T59GFiV3zw2vIqv1F0JgWJUW1KqJ39BCepN/EiRBI/UXIdu8ARtv5avCkHa5wKZ4jNitoz/V+jVhpgCnPN/wcK4uohgxTW9wURVMdUj570n0oRrr5ojXdvVzs26F1jw/wC+DF0o1ztcYu1tPTvAlJmZMCH/yBQr1d27d+kH/CUY9Rc75OsddFucTD6kKHzIt+T7hcYC2E1tOrGUoMq0ftUPCgoxbPpKrHZT0c/4bx6tfGAY4x/g1mvVVlnxoC+XNbvE+bHqvz24nhlifBZnqC+Jdxw2JChQcL+drON0nihwWlArhR8tF/k++mnkxVCxCtNGDVzCCWGKp8cf/uQgP1o9Pjuej8+24gcRiqJK9gOPH7luD06iJBUmfYAVNZBS+EqF5FjISePNrtsn4cz1QOD1jmjJ+Az2pow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(4326008)(2616005)(356005)(86362001)(1076003)(7696005)(5660300002)(316002)(54906003)(82310400003)(186003)(34020700004)(16526019)(8936002)(83380400001)(336012)(26005)(426003)(2906002)(8676002)(6666004)(47076005)(70586007)(82740400003)(6916009)(36756003)(81166007)(70206006)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:17:04.0864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e97d07-3f7d-477a-698c-08d95d58cdda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
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

v1:
1. change return value to avoid smu driver probe fails when FEATURE_PPT is
not enabled.
2. if FEATURE_PPT is not enabled, set power limit value to 0.

v2:
instead dev_err with dev_warn

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 97cc6fb9b22b..a9f1a2dfbb51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
-		return -EINVAL;
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		if (current_power_limit)
+			*current_power_limit = 0;
+		if (default_power_limit)
+			*default_power_limit = 0;
+		if (max_power_limit)
+			*max_power_limit = 0;
+
+		dev_warn(smu->adev->dev,
+			"the PPT feature is not enabled, set power limit to 0");
+
+		return 0;
+	}
 
 	/* Valid power data is available only from primary die.
 	 * For secondary die show the value as 0.
-- 
2.25.1

