Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B4C60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1B4C60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBE86EA86;
	Tue, 21 Sep 2021 18:07:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB236EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJjz0KLDM2h1An+wbwVBcZnG7rUaUFjW4vQek6Din1NRSoNOAxuTedj0ql8dulMF8yqgj8K5b7nFBgI+Fp8GK6acEIqoQzxe33bZuDPN+kO0D22oRoVDlR9XC3seLJTUerr7ur0y6esIrx6tOH6WOx2O3BDljoDSY8tTNVzSIMo80ovmqZ9cOyqWogw3gDmIHeorC77KHGoU5Oio6uEInpvf8gnrKrfAifR8llUfiEyjTM3lHjxlyhSy3x4pmNHpriKSPpwCxJY4H5BuxCBbw/Kl6TbsQlX1PiIrnTRfmLZTslW9lpxu3ejz6DouHvKwMaAOUIWIcgh+k+DqYX3Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NOPfnYa/UZe/Zlnmf1zK9WeldP4Oa0edJoxEONQuYKY=;
 b=C0dA5oOHzWIhL4mojpCZFt86CDH5iEQuJxoo+QQWDSsANy3TA46wOJdxr78lGO+t8hTita6b4p6x3ZHszubRVTP3iMaB094Tz2OdZrBrQB8k6gTPoR72eYkmuAksbIXH2a0EVUTvJxELG/2FA98L3JuaDLT/oi2LOKnzIWb1GCG9cbvTP0IaYAmbAb+oS+BKC1zEnvGVU1LERLvFGq4YkMSFdZlbKtUoyIbqEe4nkj8aY1f3474aNzex+34MSZe9fPyKSvxoJS7Y/9dQT4X+TJW95bW5NV1A4/sP5i78UoLlcDRUgkByB0AexWWiUFaSIiXytGQ788m7N89U4UhEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOPfnYa/UZe/Zlnmf1zK9WeldP4Oa0edJoxEONQuYKY=;
 b=oltOexPs1Fdce8PMdro34WGk3JXYGRFFCsEl27V+bv+UZDpDzJwbw+SQGDwxpkG3QAM3P1+RFn7w/qnyukSKO4GjI8TtpxkvOQSLVBybCAZPh98X09Z3T0DG5+bwq4FbevYuVUnPc0dBoSm91HgF3e/Ia+jVpcztgBlkYN7ZQuE=
Received: from DM5PR11CA0013.namprd11.prod.outlook.com (2603:10b6:3:115::23)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 21 Sep
 2021 18:07:50 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::69) by DM5PR11CA0013.outlook.office365.com
 (2603:10b6:3:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:50 +0000
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
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/66] drm/amdgpu/gfxhub2.1: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:35 -0400
Message-ID: <20210921180725.1985552-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d651bb-1038-42fd-dc21-08d97d2ab94a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5514D8A574B9CD6B2C51A32AF7A19@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEU3SNRAyJVbQBJpj1/P0N5IJQPnjYRW7eA0S1W+4GFvDpHZOjOorKSQT0krC9raMUqoaYwMlYkOez7KJerWYyNupXc/Y4qAORA6In2Mk8VIFQYWGXj1VlaziTrlnuE4mCJjsR20dsN4c3cRYRrsrBjPL5Q/b6zmkHofpS9OoF85wfcKX/6r07Rgi6WLBcY/+5sdizspn0HZakSLVq2meGy4SgO7gUHlUYPcBH6M3kVvgx7h/FsGVC7e/jq2HArNMJ8YKAVR/QSm+Z2kQZx7X0NoZE62jSvWjRvltPvZonih2nnyM57v7MYl57aI6pmF3WhSR/Ew8PzeFNC3z9wsRtPyH5bfr/7FbO4kSZySoL+7Zwha/wGD4ZQ/CHWFw24ZQYGppTc7HZGrjXcnUXBfctg1VsYsPE2CBrQtMk6tHhdrr0KipB/WaBnqdzDqYqbD0KYvjU61smmTlhPcDf1L+G08cizJ6oqYXmt1Ro6yco80fG5DQnU9o2ptCNsTB5oZ6nG4JNNtjTbe9Z4JGaN5gZgKTJ8aHSaNWP9FtfjCVSEmhGOLk09yDSYEFoyyiuB5gK3BHNRkmH9LEFFIMoPTSQwJzwhPeTuzYzSIK5xPdn9pjgNVGsi3y2nPC4ozKLTwi2wt+mDbkFpXG6nJblEYQ1N6zDuV1Eeg7mWvaa75AdUz40eB7M3xOZGcIrVKi+jTdBLnIPavGFbpSNeO3iDcMiB7TLH12a/dvadtUoT8pn0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(2616005)(7696005)(8676002)(8936002)(6916009)(186003)(83380400001)(356005)(316002)(5660300002)(47076005)(16526019)(26005)(81166007)(70206006)(1076003)(86362001)(336012)(508600001)(36756003)(36860700001)(82310400003)(4326008)(70586007)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:49.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d651bb-1038-42fd-dc21-08d97d2ab94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 1a374ec0514a..149f3843e0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -506,8 +506,8 @@ static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
 	u32 max_num_physical_nodes   = 0;
 	u32 max_physical_node_id     = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[XGMI_HWIP]) {
+	case IP_VERSION(4, 8, 0):
 		max_num_physical_nodes   = 4;
 		max_physical_node_id     = 3;
 		break;
@@ -544,7 +544,7 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		adev->gfx.config.max_sh_per_se *
 		adev->gfx.config.max_shader_engines);
 
-	if (adev->asic_type == CHIP_YELLOW_CARP) {
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 3)) {
 		/* Get SA disabled bitmap from eFuse setting */
 		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
 		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
-- 
2.31.1

