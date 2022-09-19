Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8EECAAD8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819C310E44B;
	Mon, 19 Sep 2022 02:03:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7513510E44B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b900n9+SS1zPxCx45wPdSSHViHgsE0qXRS4KtTMDidLwR/tu92Swk6Q0eOBNkmjt5O6JAV6IjHiJz/SNxUAd5GrrqCWijE7n85zfckZrWvWRbmPkbuaOBgTAng9bKv2bnY4FXosY0fV/pP1LLHwtPHWzVH2o8xtJE6ESVFmJcX1pKL0IRbh9a73K1AMNSLgYQwXn0hGX+WApB41nsYe3im0iQiAMehMk4j+Acrw7Dz6r7atGY5iw7dnGvC73HmB6l6pc5kuA49pYNpWMRkVuLAUW/YfdfYOUiXJvHv0eTFNrQCD1ftM50XzwvMrn+B1CNGhc0GRJQzOAGVXHGp/9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqfjf0xyOWnh6AY7QhvaFiiZ0/A+6YpYc/fi9y/W+Ps=;
 b=c2EO9t10fVCctqtC4qLVmK3Zp0jq1/Lx11m3mqFU08Pzk7K6Ja3P8/fa/oux1JVfEtvxPwGl+RLvoKahbH3QFz3qB1pHDpg/9XMQAkdWCzyPToRyFEs+DmYTIm0QUi65oXLpacu0N8dN2olpqF4k/U+NgwPMZbM0iJsA1DR9Jo6bWam4kHd3gADrErN1uNA4MkNwrkQmoZPv1k97Tu+VbRZWuAhswd1dj1o9zv8AGGisHfMeVGfXdWu1FD8A00t33GBpLaPf6bJlFBekiDsFpvSb/rvNp0EWbMod6/v9vAyKCrY/vlzt8nZAgg7hrrlWx63BHKfiDEiJ5xJwFi6WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqfjf0xyOWnh6AY7QhvaFiiZ0/A+6YpYc/fi9y/W+Ps=;
 b=iio8FjdPK2g+aikXblEHPRNr0IU98EQYHPu0LYHjMece1ZaOy79Fs+mD5mnxoaPad9lRw3lFLNfClPw2WwOxwybPaLa/GPRJwmZqWGyEbSeHFjIEuyIKGy5veXwkFCNuaFIxZT2vcvCVxh/6RAOFrfWJm3ytqDaG/Y/7NF2SV+U=
Received: from MW4PR03CA0143.namprd03.prod.outlook.com (2603:10b6:303:8c::28)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 02:03:34 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b6) by MW4PR03CA0143.outlook.office365.com
 (2603:10b6:303:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/7] drm/amd/pm: move SMU13.0.0 related pptable settings to
 smu_v13_0_0_ppt.c
Date: Mon, 19 Sep 2022 10:02:48 +0800
Message-ID: <20220919020251.7048-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: dc025165-47e0-43c0-128b-08da99e32867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoP4a7gN3p3ISy99zrRgQAqXHnPVQJrMYIVv+MwQOyL1h1mBzGWQf9GjWUf/rHVVlUbBGdEDqqQ+CZaOJG9xr2eD2wp+7l2i7bVVENa8D2fodi39I/X/H6sNJ9s+l9Pu9yOpUEaiOY3xls1AL8ly91EeT2sMQwkUoxn/eic1IW0FzUXPAb10sQ9qH2gccS0A5H77a0cNfRpAf81OuOZ3oUsaMtbu13YcO1nNakYiYSJRl6nagmW10iDCxDHEJOftxLJp/usm8+hb8E8tVRu+ZPKtMmLoudiboj4xlsJTwdHIgi5+KjM6aRUFf946HNqeXHLfGPlddtv9yd05k62XdU6sZ4gQvA2/s0giIS82zzb9njkYKRLoHnQQ82B+JmFcWgVKScEsNvKbWDptXAulUtaITVlyvuMLKGVbhbGwzw7SFOLC6aRjDGVcy8pe7VcI/g7esG0y+j3/KRjppSE+qTmXYRXWwzIhoIWQOFN9f+Du3CDqshRyTTrx3ysTGpNUg3bIO4m4DJF6eCfs0z+plPhmA8X0VeERwGvd+GR7VuOWpoC+iGM2rAiFnzBE3kOI0ZGjHOUmo7PCaqGELcVrWy+ZEjsHnwl8puzyrcuMQBL4rI+BdtY2cc9r66UMhe7+qm/iftLcZpPno8EtnAfs2f9JYM2UklPRQ76s0sRyJbsinMevOEFuGYTYN41bNxguhNv2mQIkvqogOc7kWt5KYYExG+VQVs4KuqgbKTUUTKerct6SYUX/W2UKk/tPCd6Q7uSwK1E5+IyS1kryg7/EgEGB/cf7Jkt4sUlKQt/jZfuwbMnXkhHCOHi6yQEwJ72t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(40460700003)(36756003)(86362001)(82740400003)(44832011)(356005)(81166007)(2906002)(5660300002)(478600001)(4326008)(70206006)(70586007)(8676002)(8936002)(316002)(6916009)(54906003)(47076005)(426003)(336012)(16526019)(186003)(1076003)(40480700001)(83380400001)(41300700001)(6666004)(2616005)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:33.8941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc025165-47e0-43c0-128b-08da99e32867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate those ASIC specific settings from common helpers.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie3224b8719d48c6e6936b738df379959bd1df4ad
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 610f9b68ef73..7adbdd3cc13b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1027,7 +1027,6 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 static void smu_pptable_source_init(struct smu_context *smu)
 {
 	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 		smu->pptable_source = PPTABLE_SOURCE_PMFW;
 		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1d454485e0d9..fd405e2420cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -377,9 +377,12 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
-						&smu_table->power_play_table,
-						&smu_table->power_play_table_size);
+	if (smu->pptable_source == PPTABLE_SOURCE_PMFW)
+		ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
+							&smu_table->power_play_table,
+							&smu_table->power_play_table_size);
+	else
+		ret = smu_v13_0_setup_pptable(smu);
 	if (ret)
 		return ret;
 
@@ -1753,6 +1756,12 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_0_pptable_source_init(struct smu_context *smu)
+{
+	smu->pptable_source = PPTABLE_SOURCE_PMFW;
+	smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1822,6 +1831,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
+	.pptable_source_init = smu_v13_0_0_pptable_source_init,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

