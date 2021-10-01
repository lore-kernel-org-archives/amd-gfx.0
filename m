Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB956C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AE561381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78AE561381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2DE6ED23;
	Fri,  1 Oct 2021 14:41:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0536ED23
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQyiegASzt2Pu/Nl75sFjBCBXMt6y0NmaPOm8ig7SZ7OjTn7gXnZdMuSIDoJnI8UAFrAe/cEfnoqUUnN/1o3M87FdrVl/vKLq9D1aP9qbtR6f59xrp0Sp4xgat4KmvhXl5Iq/IwQlhc0yZD+cZVSRbco84kpTEb8HHhniwS+xWqMigp99bn7udEUepPF4rlRO1slvEK9bTy4ILqeyLOgqikXjgj7y30zuq4lZA7C0RICS/2HoG+OFsASoSi7bjBvdd41Jt0ZX3B6FyCRit2j0UflnYNC73e45h7r5U1rtG8TsjMFaSjyikhpAkZgL3JFxxHUUJY5mq7NZls3hVRSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcoHulgjXiY0jYn0UffahEKBO86B7ZAtud9LLXsMdBA=;
 b=nqg2tyvI7cKa6guoEH0DLhBk38l153AUmzpUJcqvuAIon8A+DJyOze+O1YtZ8Tw05W/YL5mu7zXMj77/jSnGVdze0BRh3y253xDXrWkTTKBDT/Gd3JA/1kz/f5nKL7SbSdbJ0bbsWD84PJ1D8aRqiwH31/3RckF77a2E3nKRlINesPYUP8PqGnidZw6cft+bzmJOyN9TFwn6Lwwsjlp5bVxlkFKYbpcYuNz941gkvQbyzo+wKIKJ6KOCMAk+CXCecWqxj91oCu1uEnbEKA55NvQQG3RHI8gDvrf1NcmLTcllkBPvrKF2Lu8aDVbs7wg6P3kzNgDG9HsG7mj/pCs41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcoHulgjXiY0jYn0UffahEKBO86B7ZAtud9LLXsMdBA=;
 b=1P77Zx0Bc3bhq1rmAtRVxiu4lkRCG04iX8uE18zpv+GNpsS6aRQkhZB9YSft1R3ize9xoOHW6Kqg3kjal1pXiLbwzBFk7LLOszRI3BnAOxBBtzK2HIUdbh+H1krJ5tnOwjj5yWcUp4nNozcOxw4jH3Jw2FjvgNFCfR1cSWp0byQ=
Received: from CO2PR05CA0067.namprd05.prod.outlook.com (2603:10b6:102:2::35)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 14:41:10 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::7a) by CO2PR05CA0067.outlook.office365.com
 (2603:10b6:102:2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:09 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:04 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Skip override for preferred link
 settings during link training
Date: Fri, 1 Oct 2021 22:36:09 +0800
Message-ID: <20211001143620.192679-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00bb17e5-45c6-4e0a-b20e-08d984e9822b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34883C73D52D9FC41FBCF5EE97AB9@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZo58DJDTHEr19Z2K1IAvTUFyOhoVkJVxE/+HUdyYKxiIZkpNLaXG+boTq76qJmdphnoaEfZhkGQtr8ehLMLmcwQXaDCKO4/CqAtIeI/WX6oWdXsE7SDjJDUKQg2s/TW+/lsNr4OIXcBkFTFkWXX8ALUXNc/lsZ7gYAeWIC/tOkEXOkbgMXssgt74ZnudKCJWyLX433AlkB8R0921gfDEKaa2rt+5r4KrRx1l067j+TbVCr1qghyOPRg6GbX28ETcfBfATJViO3KGo/OdCxOtnNPSZDGsjfGZpY3oc4/iXsfWbX+K+aPxasEy/hX9dLHbJOxGRuoVpeGwiJ1+REOdce8nnu6zT7izR/0qxeMd3/VzMXLI8n4fwG8kX2IUcBEM5t6c1/08Ml6Qm2xwDV1X0f+fp0um/KhrAoss6UR/p+gb/Su8mt5jB/V8MG6ZM0/nLPpHtBW7wagSUsV+FvyYq6vNkBqyu2efBGEF6AdjLusod9bMv2PdhbAzM1JROZ5e812r9+ij5sjoT8Tvq+vV0+rRolr6MmD4+Uu+F9G9Gw3BVxTean+YZleAvIsMt9vKNQHZ2Sv+Ptv9GEo7DpvqtrxR8pX1FMQ3S3ujDA9KCMebQuqcJT17Gog9c2cKvxZQ3Vqdul2httoVQVAnHtNW0UoUT6EoEOgqQvzUhNdN+M/MJZOoAQL1gX7JCfpvJIQHH8qj9ZQjkOl8fODX+wvON1nd8b6motYkUaWTKvmtt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(316002)(36756003)(47076005)(8676002)(83380400001)(82310400003)(1076003)(36860700001)(70586007)(4326008)(70206006)(44832011)(508600001)(7696005)(2906002)(81166007)(2616005)(8936002)(16526019)(54906003)(6916009)(86362001)(426003)(356005)(5660300002)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:09.3997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bb17e5-45c6-4e0a-b20e-08d984e9822b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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

From: George Shen <george.shen@amd.com>

[Why]
Overriding link setting inside override_training_settings
result in fallback link settings being ignored. This can
potentially cause link training to always fail and consequently
result in an infinite loop of link training to occur in
dp_verify_link_cap during detection.

[How]
Since preferred link settings are already considered inside
decide_link_settings, skip the check in override_training_settings
to avoid infinite link training loops.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 029cc78bc9e9..649a9da338a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1645,12 +1645,6 @@ static void override_training_settings(
 {
 	uint32_t lane;
 
-	/* Override link settings */
-	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN)
-		lt_settings->link_settings.link_rate = link->preferred_link_setting.link_rate;
-	if (link->preferred_link_setting.lane_count != LANE_COUNT_UNKNOWN)
-		lt_settings->link_settings.lane_count = link->preferred_link_setting.lane_count;
-
 	/* Override link spread */
 	if (!link->dp_ss_off && overrides->downspread != NULL)
 		lt_settings->link_settings.link_spread = *overrides->downspread ?
-- 
2.25.1

