Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EF9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 03:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E1510E3CF;
	Mon,  9 May 2022 03:58:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23F910E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 03:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3lD0JHSPWH0GtvDT/otslKQPPtNdZSdv+a+g4e+uDfzkZgtt636oc+14LlndxbvjkT7VCH43VbdWvxUTYLzdFlcS9q5drMFadve4+R/EMlC4k3RZMRzkIa277VlxrEBTMvFSeHK+TRfQvZnkGYMVRTKeYzsgvm0ePYZTc+Jtcc/XmX2h5ZhfbRjp+fuUs1GMO35YK3ZYRopxaw2cttZMrPtj1LjUhoT6axekCk5/61eJkQEejwaD/XcUsJBUZYafKb3khLhjoIeaX8JaMl1QvuVFOQ6mM9n4BmqLaWu0b/G2rDHOJ6gAmZhf3dsJvRoq7XJOzTYBkB8bc+slcMj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJVtdfB9dchzwGZRdLlvzIKL8+ovZwlq+pTzT9wx23I=;
 b=Glv/tn4hVmqU/RX81uI/9HkwkDbC5ioJdqkWY9Rqk7vvj9Wram+hlgbx3HWfuVnXnHRAGJ81KWtfWUgXNakQBPMSvnoqv7znpP66ZO/gfCyhCoTUEKeCoZQ2sTzQ5ZZ/i3ElV9ZbmMd3mmswHJ27Ui7ZHP0n2KE6mmK46LDOGzeUGHGC8k1sj0mgBW4Orpr2vIWEyN2zeTuW2LC2EJgjsRiC9FoFuNW4o7ylLrYWaiMlT5wr8pa0lAWIHHzq76hUe3B8s0/1kpkRl+n0Qhq+80IwIppiXW8gOdXOZpQvS3j+bAovC9ZzY+4+xdd3+UDroUOadBKs+4lcPY1vyv9xDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJVtdfB9dchzwGZRdLlvzIKL8+ovZwlq+pTzT9wx23I=;
 b=LMlEdlbIzaoF03vn5/JBeghmSfMqdOMbfutuvySRCdKd9Tt+oDoNLQJsi241c36wWQxAX/HTq9q3wEms5MrkpDKkeZbgJCyqEXNHS+sP4st0BuwPCHm63YaQZa6wg3tVAU5J3yRuTQKhlqyJAVa1jFcHSCC1T0aapr42FHB2G+M=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 03:58:54 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::2f) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 03:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 03:58:53 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 22:58:52 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 1/2] amdgpu/pm: Fix incorrect variable for size of clocks
 array
Date: Sun, 8 May 2022 23:58:37 -0400
Message-ID: <20220509035838.17410-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b375878c-c81c-4237-8098-08da31703c01
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51548908967BB460554B4034F0C69@CH0PR12MB5154.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbycNPw7Y2CBSp13fRUa7Fea+uDyCN0W0rM7xBknoaE97C8h9tX3l1dV+6BAtV0fqjxVX9yrRe6UJAYIS7aEmUhzz1iqXqj1VTKfol8knFsC7Hpn2/RGRxKUE6DTgNAZ5sfg92u3uBouVA2ya4iEtMquWVE8QIGILsS41bnq+pFXiWgAW8Imn0RcUMOLgWcC5eGbtd6lkx+wiWrOKlz3UsTXCMMpTOWIEDQa3PjqA+nSDeJXh9yy0F72YrHqAsM2NoYPy9UiDM8XsN9NGbd0Pm6kNabtCGQrzOUvKlnvQX4dvumioHhJQney6xKCVurzMayU/L7DINkyjlSDzrKNi59hi5f3qq5a0cI2q5tuI5XKEIA9VXJ+iyETBO7rSQjsvuCEbiL+zVHC0QyXbrRLMQVsbg5nEvFm+9ldPs/XmtvWf1iz3KkJ6Jp0En9J5gxJHAt8jXXrKP9+wXMjvt3mclyOfrhN+MnctVnwbmK2DsOpQk6n6AKLw4liqQB1zGWIy9HtpqwameGJyrX9jzyECRY8fYdhWltG7CpDe5B7iREw5ndktKPUbI3zTA1MD4y3rG+TF09P6sZG5WsYXKOs6FWgrznR1ftSF1NXqA5CMjUFy6VgM/PdpjyRzCA+mpTPzg9wKC/IycMx1FOgkcauZ/3Lq89en+uJrZvTvpOoBbIRUk7rEvMv05zXuDj9a86uY+jvesZxm2yIPhHqFetJ1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(47076005)(426003)(82310400005)(70586007)(336012)(70206006)(186003)(16526019)(44832011)(36860700001)(8936002)(40460700003)(2616005)(5660300002)(26005)(83380400001)(4326008)(8676002)(1076003)(6916009)(86362001)(508600001)(54906003)(7696005)(81166007)(2906002)(6666004)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 03:58:53.8551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b375878c-c81c-4237-8098-08da31703c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Cc: kevin1.wang@amd.com, lijo.lazar@amd.com, Le.Ma@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, kenneth.feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Size of pp_clock_levels_with_latency is PP_MAX_CLOCK_LEVELS, not MAX_NUM_CLOCKS.
Both are currently defined as 16, modifying in case one value is modified in future
Changed code in both arcturus and aldabaran.

Also removed unneeded var count, and used min_t function

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 9 +++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 201563072189..bdd1e1a35a12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -573,12 +573,13 @@ static int arcturus_get_clk_table(struct smu_context *smu,
 			struct pp_clock_levels_with_latency *clocks,
 			struct smu_11_0_dpm_table *dpm_table)
 {
-	int i, count;
+	uint32_t i;
 
-	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
-	clocks->num_levels = count;
+	clocks->num_levels = min_t(uint32_t,
+				   dpm_table->count,
+				   (uint32_t)PP_MAX_CLOCK_LEVELS);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < clocks->num_levels; i++) {
 		clocks->data[i].clocks_in_khz =
 			dpm_table->dpm_levels[i].value * 1000;
 		clocks->data[i].latency_in_us = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..6a4fca47ae53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -549,12 +549,13 @@ static int aldebaran_get_clk_table(struct smu_context *smu,
 				   struct pp_clock_levels_with_latency *clocks,
 				   struct smu_13_0_dpm_table *dpm_table)
 {
-	int i, count;
+	uint32_t i;
 
-	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
-	clocks->num_levels = count;
+	clocks->num_levels = min_t(uint32_t,
+				   dpm_table->count,
+				   (uint32_t)PP_MAX_CLOCK_LEVELS);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < clocks->num_levels; i++) {
 		clocks->data[i].clocks_in_khz =
 			dpm_table->dpm_levels[i].value * 1000;
 		clocks->data[i].latency_in_us = 0;

base-commit: 8bb14fbec5ae45c31cbefe217db2418cc683612f
-- 
2.35.1

