Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6201C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F72260F02
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F72260F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3020B89206;
	Mon,  1 Nov 2021 21:29:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E17889206
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 21:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je8tAsqC7se9vAasKSY+SPi5dX3PkQRb33EsUrOSWeQn38W1+QN7MeoXZJAlYzENYGkyE/Vbm2DYBL87WG6IfZyY8izLrXPiZ5lrdcaAEhz1gSwtvLELqY8aZg6o93vi9x9crJPdnL495nafNS1klXAOVWDUpFcjlsdJl1RyGe4Q6mn0ETvAw3pOnaXGLusEunlgm1oxUWgIgUtccAw+0A5Mj898nT6Hp/G1NRikrH8nuo8qCufMcXsljnYqF2VcNgyRoVlHRh2d16yY0T7TsREaQtSkUdLBb0+3hzR28/XFhNJW313UgttaRMlKGEL7+BwnjsmJloDeTbK4/dzJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IoE3/kRzbXV8thvpgO9MwhCHZVtHJ1mo8kdSr/zxTA=;
 b=FmF2oWTpeBZ1/iEFLti+6J21cHFnao0WsFSY16CK5vkgn1I2vx0ovX7OE9NjlOQSlpdPcmfdTAeMzO1hefKBjHex6JJRWfg0lUr3Ogm78tXPeclzpdJnTVqe2DKnk5J9+J1UQj6wdUZ7viq2QAU0K78Y3Xedo4HTzY7a7Fo4XFTS/5Jx/cz9ablAX6B9CuRiKHToLNTdL+SzmWuDKx1ZOS+RfKklRN3xWg0rWZcKT01jNfoHppBh1E4E4b73nQCh5gYYeuRVV6ls1lyOtgsnbTSkv+pqaubYGRq+fRG2XoT1kNmoAGaedQMAogiUhwDannoLxS79UKD9U5LA4kpgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IoE3/kRzbXV8thvpgO9MwhCHZVtHJ1mo8kdSr/zxTA=;
 b=fIk4SNrl0CmBdcPJxhdGlTwgYT/oBBqZBP3HRIroH2nZ2zNcoAaubbZPLyqqhBSuzbpNC3QztseuPWlZub9sp5GQZtdEQxTfPHS7WXfsNZn0wSfLDKPla7ZugM6gu71UF4b2VPiB4PMqeJvu6+m82m4hCLId/NtTJJ92qObc7ZY=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 21:29:54 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::cf) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend
 Transport; Mon, 1 Nov 2021 21:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 21:29:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 16:29:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amd/pm: Adjust returns when power_profile_mode is
 not supported
Date: Mon, 1 Nov 2021 16:28:47 -0500
Message-ID: <20211101212848.20449-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101212848.20449-1-mario.limonciello@amd.com>
References: <20211101212848.20449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0797e82-859b-4b68-30fc-08d99d7ebedf
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-Microsoft-Antispam-PRVS: <MW3PR12MB457165318190D9DC1C24328FE28A9@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUrzahryPrS4azJaP6Vd+5yEbMgOHJRtfKwpCg0lXZD6iojb4ql2D+zsurZwY2PbPjRq77oqBao+ZFFxa9RYrcnTb0W+wxjk7MJUp/PVS5Kmd2UIm36S9vvcwGB3wD5zkvGajhkjBL35pxZpDIIMqDAMKTE9oAqGWXxbkhmId/ycvSPiv4z7jQIvWfSTXdzo3pMnzIds+lXG8fC6VKH+SGrHJYyO2wZSYEnxATH0F0982GVqoBrmgKH227SjgFKw0T7LCxaRO8+Y6lY05saOWOseO90zKy11iyQ9HcKTWdPDAXcJNbnnJvwxiGknZq0up2vNmVeQdT3+3QWpCV+vGvTtkgZlg21VhaKI7vlOSkqJ0ZwSzgYAQRPj+jfu2NzW5i/UYuWwmlFu2uNLxnvvcxJWojMMxN/5BZwGYWGIVJxfhLyharW5F8BHZSlZndvjUsG6WMHWyVK2OJ+MuEATu178zUJNOhO/lxD/u6Tu3EZwDe7trpTqRTHeAkM4BEFM9BTzs7KUgCrZo5Da2iMhv0UsWo25b0DryBePRJi64lYiIPnJggoTZnqwxwuBozPDa7N8UNcLJgzIRTkpMVqbrKjpzbyBpBoFGB25z3FBya66RDRiqSaZcV+F/ZO2oqkgcs68io/C6dUa3tUx6MJYpXHk52LjplNT8gUlNqQ1hgFNgThkJJyHfelvhiXNV3LM0UsdvmneRQEPmY7ygBM5ADKCyfmab+/DNFadwEp5i00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(5660300002)(36756003)(70586007)(356005)(7696005)(81166007)(8676002)(4326008)(8936002)(47076005)(2906002)(70206006)(82310400003)(6916009)(316002)(26005)(336012)(44832011)(6666004)(36860700001)(86362001)(83380400001)(2616005)(16526019)(1076003)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 21:29:54.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0797e82-859b-4b68-30fc-08d99d7ebedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This better aligns that the caller can make a mistake with the buffer
and -EINVAL should be returned, but if the hardware doesn't support
the feature it should be -EOPNOTSUPP.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * New patch
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 978007664e71..79e565121206 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -877,7 +877,9 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 	struct pp_hwmgr *hwmgr = handle;
 	int ret;
 
-	if (!hwmgr || !hwmgr->pm_en || !buf)
+	if (!hwmgr || !hwmgr->pm_en)
+		return -EOPNOTSUPP;
+	if (!buf)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_power_profile_mode == NULL) {
@@ -894,7 +896,7 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = -EINVAL;
+	int ret = -EOPNOTSUPP;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return ret;
@@ -906,7 +908,7 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		pr_debug("power profile setting is for manual dpm mode only.\n");
-		return ret;
+		return -EINVAL;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.25.1

