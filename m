Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9A1C47077
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 02:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01E910E0EE;
	Wed, 17 Jan 2024 02:00:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6477310E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 02:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co9El8PHbmqr7dzPMwJubQWUOXXVt3GxXadGZAh/s+hK5/TmTbqUFazu42kT6HBzWw0huXc+Za8Cs3TjCC14QYmt8H5YCPdi5/9i+u7jynp8nPBGp858uFw9hVMIuKmOsfMXCqu1lT9lfI4J0fY4/LK9rJiDg1ZxneVJrnwFS/qlvUINxqgRAbSdVQBZuPVZaoSDMqZCL0g+g4ObN4Rhj//DHfZaX2LmNDnyIwzNqMSoEQErSBRatFNpExIgtFW2ggqPJHDhxy8GLPCjy1XlcoBaAOyZj25W5E9OHqOpd7J1Azog65EuXtmabuCqpsre7jgd4GNZHBsauBCCx9BzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQuj+HQP+JLjLNGqRuLb4ra3w+COs8DYucYHG8N2yQw=;
 b=cPStk08Mqi//lXSfh8X7M8W34O0deTnpuWzAoGg0GTNGbdwHymdM3Mgr6Pry8Ho5mON6XDsChrOtbygH0QDf5GDw9xak3xJksI+rfjcaQjSG1FVyaYLFhvzKIciz19oPt8E4ncl13ellfAhJr2A/pSZgp0QCLNclr3VP+O91N3U5BBNiPoglZuDjHjgrCu4OOb+3YUSSwFU5E/erJrDi2//okLo0iItcbSEEOKVxtGBzsriTRCpKLMkw0sr6PTI48HyYXKeB00jUyVN7IG6iNfTYa4QDgHrptdxn/984F5h33vG+LzrAZfCcTpuRywNQ7YRNd5UTAu6OgQ/QQuH0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQuj+HQP+JLjLNGqRuLb4ra3w+COs8DYucYHG8N2yQw=;
 b=2A342cKkw0dwhDD5I9fcNeY/4FNyTYDikO9wrAkM4s6k2/n+wZOi3AbLr0OcFAYGiR7RH3V8xCBJSmMnuxKzX1D5ZCwHr1anV3VSxkOXXdoDcXi8TQ9dLXoRjxzkwlpLxIIumO1Gahx/H96T1xbiLK3A+8aDqswIggfslDeH/cE=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 02:00:09 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::f9) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 02:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 02:00:09 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 20:00:07 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: Add set_power_source funciton for smu13.0.0
Date: Wed, 17 Jan 2024 09:59:53 +0800
Message-ID: <20240117015953.915067-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: f9906e05-0dd0-4bf0-5662-08dc170008c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvwUm8XeXn5EROslKUJZiZEH428s4elrk++4LaQYd7PWG+/HEFn/PGT7F5IlWRC5ppnBodCxjGTsawSmYWMIUyqAbggi/0F+Od/0t7sO3CNAM4KU051DT1qo5dAtKxS9zt9em/AfILFJhcbY1CJfFWIYUMIWC/r8hW/x1owSpWDOFrMYVA2rTFAPN+Ul62ANDnlKQxnPjl/RGX5zn4/a9Pj2GE+SYPNl4m7jn/1a/aIXi7b1ceDQ5pZ6M7PHMyP4zEZOl00fTUmafGMKTwA8fDfB2kxued5Q2xB6Hvz7IBaIsPgJXD/vTgU64hx1Lyt9gcKAgX4po5ZqB2DH1nExH/oAytJRMigPlVkWBTv6utyIvAniDR4WEC+LIGHwB3zjTZhtxHzseW4aJCTbovprOiOnawjZYlJj/FNGnnjBDAswdv4ZUYtIhKdZQbclYz5mmtCn/Ufeka2NB0VpT6G08WqHTJ0SSWV9bUQP6PofVqcPO1o3jqHT8YaUKVCzVWCoT1AttT+CQq+0CT8yXjOzuulVFrw34i4hcmjJc82/0kcMY/TlHhKa+VF0APPijyawkAprgbjZsmyTSgVOqcBOsnjygBLF/Dze9ty1mvih4a4K1xIKa3CJ7Vur3gUMqPAx8kzdOjLgxQlo8bcQMoOpAIMWr58v/hCK9LuvmLyMuagTGerOLytp/S/oW25UqgSo7fhcOsELrR10CNftdDwo5smWHE7ALB+CJUxOMFMiS6V5Sst3WC0MDc1Sbkq83yYXCsIk7glR7M/u3P1E+7VdKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(4326008)(8676002)(4744005)(8936002)(316002)(70586007)(6916009)(70206006)(54906003)(40460700003)(40480700001)(478600001)(2616005)(7696005)(6666004)(1076003)(83380400001)(426003)(336012)(66574015)(26005)(16526019)(47076005)(41300700001)(36860700001)(81166007)(82740400003)(86362001)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 02:00:09.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9906e05-0dd0-4bf0-5662-08dc170008c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, Kenneth.Feng@amd.com,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add set_power_source function for smu13.0.0

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c01d5f5b80f7..46ae5d811bea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3020,6 +3020,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_0_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
 	.run_btc = smu_v13_0_run_btc,
-- 
2.34.1

