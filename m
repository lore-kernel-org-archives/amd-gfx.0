Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5B510E1B1;
	Fri,  9 Dec 2022 03:48:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBE010E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBJqYggelTBvB6ap+N0UPON2Jl6buCQ8mQsh4Tkx39zQSqafvxShkcOvdBuqbRK3OD/eJ4GqoFfmeisb87Z2JDrSNpkYIlJ38SbY48//hgAAkiJeAwdBkD5oh+/RFNjRcD8OfFv2sDlFGKyZzGOKeaUs8T3kRbj222pbQ9IML6FcJcoHrERuZi4snvkVV5Z5wgHw68bqzmtFUENGbG7ilonaT8KsZCV7VlzVaayIVbLrj8GRDaVX+wk1E2HZRAYhxfr5HI500sJ+nHa93/+qNksDcw7bHLaut3uYv/YeHf8f0ZUnW2SismeUbv1gBXK7SjyMw3oNkJr/jrD4cGxpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ/LHQbgmVHYcYFrUjeXneZfz88nPooYY/uQiIqXgUQ=;
 b=XPtH15pKyLJjAA/dlj7b1KbeVnsHzGkpfKBhTKsTwLGJPuZuQm+u9jYzjtREqLP9r5A7PMYn2zSKI5INk9wRM6xirlru+vOZGuIYWyORnWOoBFKjxfV7gy9rEdLWVUGBIgp0dApVwbgsciRDrPR6h4wTymRofuMG7oAQlUwBGG26biEFfY1KilHHYgYVP/ze1nOPF6XVWLGwhCaa1C2NvzUxhT72PkT/ck6DLgVU2QGgikKJZxTC1EMR/eghcLyO/ArhW72c8JSgLiVZca9v/9eNZ9yQc3iYbzBPw8wOU3YMwcYClD9YvaJj+qtLGb/liPgRc8PuF9sZWL9BdseOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ/LHQbgmVHYcYFrUjeXneZfz88nPooYY/uQiIqXgUQ=;
 b=uy/9A19/qTFQ5azbEaMlEMbTdfwgCl6iqI9E9Ywx6cDzZgapOVl08HFmQvKRExlLEzvsMMFGlRs0gKihpg4PKSuLojwJZmYqLkn2XPktz9Skwx+vtOYU+nXlPoJ9KnmTZlA2IcrOIo9SALpP3z3Agb6KMQUZ53HE/CB9hMyRIHk=
Received: from BN8PR16CA0020.namprd16.prod.outlook.com (2603:10b6:408:4c::33)
 by MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 03:48:53 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::67) by BN8PR16CA0020.outlook.office365.com
 (2603:10b6:408:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 03:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:48:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amd/pm: correct SMU13.0.0 pstate profiling clock
 settings
Date: Fri, 9 Dec 2022 11:48:06 +0800
Message-ID: <20221209034813.2373727-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|MN2PR12MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b4c570-42e5-42b5-2c9d-08dad998473d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CnUndwGLRTefAcVARThpeT5cl1Z6OQhxD4/LrHuDHGarWWEe3KMc3F+DU9cct0O4NcKul3CtBN7Km2jRe6zMccJkpSqpWQp9TXj7oRhEVDP+pUH2UXTDRn1qTO9q/WfkIgz+4Nq42goDES7EJV3fJl2+XRkDSRi/PLXaZYSAb3Vh9H36OigXBIa3Gu1N0WuPXqnLoY48wEBcY3QoeMuwPZrIjQNtId9xOi2oco395IhouVl4qoYOoJ9nF63fasDjKDt1PBAFg1eL6JUwlZp2ZrArkIYha5zlpbbOqLzHYrF/oCIsXNhoBV5KbZhkaHmbcJtcOMB4c86NNw6632Uy/FMd9/xmVjE75LOej4chmBmqNqcSPZCLtNiXX6MGwmfzGAADOb3DRZF/0CzBlWqWx3FAuOh2psWiPCZSk8QCdQi3Gp02J/bM2hSQv9DaKUYeGC1w5Z9YXRzPSIRMYu4AyZlaFu8y6cTtBvrPA2URQRRH+yPiddEbQgS+4/yuxsvSS03cSk5W02BlKsY4RssAhIS26NxWlKiAdlhgqSUrvvx4ltjxuBtmI99OWI+tfQq0zOMaOJn7wvfIi14tCti78dqiBFZyt6yetK4AYVAqIcCDeM+hDhe6ArPODfyXIDennjRjpY5A5IJQztAL+J+XE+tUB08Xo/U9BYcGWCCFFArJ2SJ8lxkZekwUcUhzUxuKL8wk+a/C8dYzZZmxKBHdGiiuSqqcf+wgOSekzRvdEo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(82310400005)(7696005)(6666004)(86362001)(26005)(316002)(40460700003)(54906003)(6916009)(82740400003)(4326008)(81166007)(356005)(2616005)(8676002)(70206006)(70586007)(1076003)(186003)(16526019)(41300700001)(426003)(47076005)(336012)(8936002)(5660300002)(83380400001)(44832011)(36860700001)(36756003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:48:47.9013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b4c570-42e5-42b5-2c9d-08dad998473d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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

Correct the pstate standard/peak profiling mode clock settings
for SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic47b18904b1fa021588b6d4b599f1cf0fe4b7a58
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c2fcff384bab..4adbab62e9dd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1305,9 +1305,17 @@ static int smu_v13_0_0_populate_umd_state_clk(struct smu_context *smu)
 				&dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	DriverReportedClocks_t driver_clocks =
+			pptable->SkuTable.DriverReportedClocks;
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	if (driver_clocks.GameClockAc &&
+	    (driver_clocks.GameClockAc < gfx_table->max))
+		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
+	else
+		pstate_table->gfxclk_pstate.peak = gfx_table->max;
 
 	pstate_table->uclk_pstate.min = mem_table->min;
 	pstate_table->uclk_pstate.peak = mem_table->max;
@@ -1324,12 +1332,12 @@ static int smu_v13_0_0_populate_umd_state_clk(struct smu_context *smu)
 	pstate_table->fclk_pstate.min = fclk_table->min;
 	pstate_table->fclk_pstate.peak = fclk_table->max;
 
-	/*
-	 * For now, just use the mininum clock frequency.
-	 * TODO: update them when the real pstate settings available
-	 */
-	pstate_table->gfxclk_pstate.standard = gfx_table->min;
-	pstate_table->uclk_pstate.standard = mem_table->min;
+	if (driver_clocks.BaseClockAc &&
+	    driver_clocks.BaseClockAc < gfx_table->max)
+		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
+	else
+		pstate_table->gfxclk_pstate.standard = gfx_table->max;
+	pstate_table->uclk_pstate.standard = mem_table->max;
 	pstate_table->socclk_pstate.standard = soc_table->min;
 	pstate_table->vclk_pstate.standard = vclk_table->min;
 	pstate_table->dclk_pstate.standard = dclk_table->min;
-- 
2.34.1

