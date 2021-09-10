Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 03:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F9A61074
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 03:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04F9A61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B627F6E969;
	Fri, 10 Sep 2021 03:18:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9B56E969
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 03:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSJrqhesX4qdOdz0gTm5A/sGH8m4vPy4pysNinLCs0ngCTAtWvQrv4PZFlsTWuAJ5sXGk4TKreBRI4qNyUQdQIzik8AWe8VzyTuKgI15VGb/uyDl+/MmrBCwFMhr7q91z0LuW+GCEXp1+lVrTYQCZXTNx3CmOcm3SBIHL2XPKVhWXiFByvxrmFTlCqxlYgLNFkyfVfFAlnvopNXKrvLrQDKIrsv9LGSvUo2xtmwGzuaqUyHHwja96NUMwp3a1JbSa1vTtVxTqweIQCmz/W3b78HXJiwjZ+QaRYEINOPfr2jdcYTHl4y/ST7jYzU8tnqeVvIRPJ/1Rf39JhI5Gf6zdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6/JG4pLuDYRxaZ6guCDtftws/ngsrZkdxmfO9kSyX8w=;
 b=WMFp9vWtQe9r72SM10DTxJp6+jLFU4e7dPGYewn7Jx+pXkQ8BKHwD01E4jtUgol0lgvCIZQnlw8GTlyGQfrpK/J8b/AJn4lT7OjxZ5wZBvrVgHmSTvj/sPBTZbSA3FmN4f8xjetRmrCMIUZzs5siiB17JE8Tw79wTaYP8RnONAnkHLAkIeLZgkdSQg0M79fXorg64lgK++1KFMI9qadA5rtnJyK09bFmL6vSF1lkRO2idJxf8B+I3mz4F/X18fPyNy3hz5bJfQKhHumWVINlLMc+kuTnyqP9d9Q7Kk9UE3uRw16TSnfmeeri7BAkCj3tGEw+Y3paKWRWqp2JJJPcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/JG4pLuDYRxaZ6guCDtftws/ngsrZkdxmfO9kSyX8w=;
 b=Zba1eBtBY5PiYA2FDzFvKNR0WrYWeHhTCBpUvd7tbDkIjCYsItyUJP6z99THVbXzZIfWnYmzhJEIB+dNap6DiyUOzVqkLtSlujITS2xewRRhFHn1Aw4fzIGHQpB0jVUEh0R3FP1VosiQnCOQvcCgJL5bPBIcpAATRujokNoPrqY=
Received: from DM6PR06CA0094.namprd06.prod.outlook.com (2603:10b6:5:336::27)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 03:18:21 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::db) by DM6PR06CA0094.outlook.office365.com
 (2603:10b6:5:336::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 03:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 03:18:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 22:18:14 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Evan Quan
 <evan.quan@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to sound
 driver
Date: Fri, 10 Sep 2021 11:17:58 +0800
Message-ID: <20210910031758.724964-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b4c6559-ba6c-43ab-6a59-08d97409a45d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55206F51EE3079B4972FAE0AE4D69@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOCZtdeCWRUu3/iDb6BD14RoYLD4N9nGAoUxlhzUGUUANZbaCiB7ZviCmGaZ5TL3pVgXYf0RaPhVb++8PeEXvyWPuNVmmKvOKHyvfBS66ANQIR+o17ByzZkwaS0pTVp3B0rTx7pWhkTXvdkQHCvyVFkbaAQYXhK8jzBO1PDT7V+jZ+qKFXToonJLUmyX2a52HD9maazQRKbNFPssgTMdMlXIfeX7NRbrXbTIxfR7ntJfCm2ZGY/4zDPI1i/RN4gFHT8HYs9fSTK6+HamifpsdfihDA2M6f4GoRfZh0adN6LXTSRh2z8vv16/6hGhc8VMvCEO80IYuhwKLAEGGpvWL0Ulvbcwrw/fqj99cfpZr3fJWz75YuVLfPOWzPfNBR7LLhimuB15YISBTk0ekxdspvUNAsKTd2l7FstNOlrNuvPYZV94411GTkEvcXf+MCwTxUIX8Em6SVmNnq7Gnc5xYJAlcSKd4cfGU53qEvy7EtBRlh0p9/JRZBSpQ8cgBKkqgMIPNj3F51pyuGN/yqRJ0DJY6+hhmpfzCANisrGCZHq3C3jK3AFFRBVdaQ6iHTWXXp1wFOUh+sr8BXEHhBB04M7rhtVM3uTe8jVVZV14f3CFNBiIjfTmVq9doRbINyU95l9IDTtca4gmNUJKIBa5luHEZB/ZFrj3sV593v9C2SJ1MlGwLf4SUkysmrxGNhsnxaPmv+5jCM+dQ1BQ4HzT7v6Vyhf3/o5zoHdzOTEO2jo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(82740400003)(44832011)(81166007)(86362001)(356005)(47076005)(336012)(82310400003)(186003)(16526019)(26005)(1076003)(5660300002)(4326008)(7696005)(36860700001)(36756003)(6916009)(8676002)(8936002)(478600001)(6666004)(2616005)(426003)(70206006)(2906002)(70586007)(316002)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 03:18:20.9426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c6559-ba6c-43ab-6a59-08d97409a45d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
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

Current RUNPM mechanism relies on PMFW to master the timing for BACO
in/exit. And that needs cooperation from sound driver for dstate
change notification for function 1(audio). Otherwise(on sound driver
missing), BACO cannot be kicked in correctly and hang will be observed
on RUNPM exit.

By switching back to legacy message way on sound driver missing,
we are able to fix the runpm hang observed for the scenario below:
amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded

Change-Id: I0e44fef11349b5e45e6102913eb46c8c7d279c65
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 +++++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 21 ++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7bc90f841a11..bcafccf7f07a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2272,7 +2272,27 @@ static int navi10_baco_enter(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm)
+	/*
+	 * This aims the case below:
+	 *   amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
+	 *
+	 * For NAVI10 and later ASICs, we rely on PMFW to handle the runpm. To
+	 * make that possible, PMFW needs to acknowledge the dstate transition
+	 * process for both gfx(function 0) and audio(function 1) function of
+	 * the ASIC.
+	 *
+	 * The PCI device's initial runpm status is RUNPM_SUSPENDED. So as the
+	 * device representing the audio function of the ASIC. And that means
+	 * even if the sound driver(snd_hda_intel) was not loaded yet, it's still
+	 * possible runpm suspend kicked on the ASIC. However without the dstate
+	 * transition notification from audio function, pmfw cannot handle the
+	 * BACO in/exit correctly. And that will cause driver hang on runpm
+	 * resuming.
+	 *
+	 * To address this, we revert to legacy message way(driver masters the
+	 * timing for BACO in/exit) on sound driver missing.
+	 */
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
 	else
 		return smu_v11_0_baco_enter(smu);
@@ -2282,7 +2302,7 @@ static int navi10_baco_exit(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm) {
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		msleep(10);
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 43c7580a4ea6..f9b730c5ba9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2361,7 +2361,7 @@ static int sienna_cichlid_baco_enter(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm)
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
 	else
 		return smu_v11_0_baco_enter(smu);
@@ -2371,7 +2371,7 @@ static int sienna_cichlid_baco_exit(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm) {
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		msleep(10);
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 69da9a7b665f..d61403e917df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1055,3 +1055,24 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 
 	return ret;
 }
+
+bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+	bool snd_driver_loaded;
+
+	/*
+	 * If the ASIC comes with no audio function, we always assume
+	 * it is "enabled".
+	 */
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (!p)
+		return true;
+
+	snd_driver_loaded = pci_is_enabled(p) ? true : false;
+
+	pci_dev_put(p);
+
+	return snd_driver_loaded;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 16993daa2ae0..b1d41360a389 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -110,5 +110,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
+bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
+
 #endif
 #endif
-- 
2.29.0

