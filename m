Return-Path: <SRS0=HyUd=OX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF49C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBA1611ED
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFBA1611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2699F6F58F;
	Sun,  3 Oct 2021 04:47:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9B76F591
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Oct 2021 04:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTqXaAj91ZJh71BUB1KMrT1x9herAKW8KUW9HxT8ufI6DoXSJ/WChwueO3xeJeC0Qhq313iu+z/N+KVNX+VClFDbEPZd3+5rMWprc+Pf/M3Rt8gShrV9cflNfgbiz7TOvwjnyZNtABhNlUY80/R5Yfuh5j2TbGLyaGBiGcgJRdH3jrY+J5xKpMWLWLa1BtNR6xC9SG4tBNLxbLyBgvKZyCo03eUTMuotpDPMINX/+C7Al96vFhF33295zGUHq1RbAGzJwJoZI1iYhG2uYme60zY5j3C3azAAqbMpVl849y+qvEBR2Kgomq65EtFJ4z4nlrJ46Zn/sxA1xfpd3pfZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O4af8elzyAb2qLPNlu/f6Om5n79c3ikYRa4E7xA8pc=;
 b=nqs4h6RYO5qjICEkTFBxdIVgKdmfYnqfjlM23IGebe5YOEbs+Mn8QGexTp4Vt7XgWXgIqwb8ta+rk+ZUHuDyGBK0UuJc6AOgwvMZj6XMzd7k4Vjj0Ky6eUAAW/XG86jijo6rixUyhm3gZv7TR7Yse7sI0+jG3VU0SkurEVfUI29yd47TD9jtrf7LBB2I1aEibO8Ccpfg3lnUzhQNlVYHmWXQYbsENVy/6Pln5STq8LAumzqS5QlW3lsdYcOY91IviXgKjMEFavkVSW2oVrbHIN7CWvLUOrC/O1KU+P7P5a6HUZ5OeqqscD109M9EIGbhD0InF5V/JHIUAxuHXDvgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O4af8elzyAb2qLPNlu/f6Om5n79c3ikYRa4E7xA8pc=;
 b=q1x4xzaqTEeRerDHEJ1EFQ2BDKFBsG0KOJk/+swa1TUyhyhoyyGrCzaQBsiePJwht1xNFyReXblcJEweoXvkZxQL3GXmJWGRLs3h2C755vdV0pDtHOwKc73pN4x2rL2/ZFebVVcy8+vg5Dyy5EnUBRJ+yxDgx/uP327nC7O/NOM=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Sun, 3 Oct
 2021 04:47:27 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::d9) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Sun, 3 Oct 2021 04:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 04:47:27 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 2 Oct 2021 23:47:26 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 1/3] amdgpu/pm: add limit_type to
 (pptable_funcs)->set_power_limit signature
Date: Sun, 3 Oct 2021 00:46:56 -0400
Message-ID: <20211003044658.29238-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003044658.29238-1-darren.powell@amd.com>
References: <20211003044658.29238-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 897e5ec0-ef8c-43f3-afae-08d98628e6d1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4511CAC78C862A32B2499ACEF0AD9@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h558TPUT6MgsaFBNYvGAh5OJ66J98BkV+LGlT8iF1z+bIS4XINvk86ftoW1EZEVjNHYm0S5Mk5Hagxl8dSndEXMP2nvKUvclpZtvHMQGtsnIvKg98lKUdcmlT6hiD7FoSFNVF/e1AAQs6kj/z5y39vvC4XCK/pQGmvYG0Dn5uIIH4lHp0ubsHMFO8KkIhXwaetAhdap7nIZGccxknLilRvuCR26tQUGaMwn+FACjkV7zKvVSbQMKJlxRn+8Hg/cm1rGDMtaN7yter8RvLvvKXoB2Bta0HCAxuRsOpuEuwvi0CYIWc4bF4EHB2Y8WPlpWzazrNcPk449PqFzkk7VSgUi8PbLepgNsZQcVD3jHUqbqF6NMpsVYuKe+vPdtlJw932Jde24yvhyq6H32tKdLpneRSo6OqXjGgfKjmC1jz7/9O1eMqM9QP7iv9SWGwfljUypZGphZsfcFGdTFYQpuKT8bzcP5yK4heeebBf9ho8c2yvxmlHml0TrO6mcOawL+PV6Qc0qRYpL4TAyJ/QsI83jCRf3/nfOrbzK8blQKg8F2dhsq15fNVCtWXzqofWPE0y9fY5haIfHHeQ4hGEpwOA6lTXwDtjwclTuyCMIithYg/EpLLpFkoC76ZdmaLj56Kbr4gEd8Gq1QGfwhb+CmGiBSjJwgL8A4sHmt04T2qxg66ZfdgOiFrxyzFcG5jxdmm4LN4tKVpfQGu5eKi9jkopDPE4kkz/HZiTUfFyQea+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(2616005)(426003)(16526019)(336012)(186003)(26005)(7696005)(1076003)(70206006)(70586007)(8936002)(36860700001)(508600001)(4326008)(81166007)(6666004)(356005)(82310400003)(8676002)(86362001)(44832011)(316002)(47076005)(6916009)(83380400001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 04:47:27.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897e5ec0-ef8c-43f3-afae-08d98628e6d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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

 modify (pptable_funcs)->set_power_limit signature
 modify smu11 set_power_limit signature (arcturus, navi10, sienna_cichlid)
 modify smu13 set_power_limit signature (aldabaran)
 modify vangogh_set_power_limit signature (vangogh)

=== Test ===
sudo bash

AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_show_power_cap.log

cp $LOGFILE{,.old}
lspci -nn | grep "VGA\|Display" > $LOGFILE
FILES="
power1_cap
power2_cap"

for f in $FILES
do
  if test -f "$HWMON_DIR/$f"; then
    echo === $f === >> $LOGFILE
    cat $HWMON_DIR/$f >> $LOGFILE
    RESTORE_VALUE=`cat $HWMON_DIR/$f` 2>&1  >> $LOGFILE
    echo RESTORE_VALUE $RESTORE_VALUE >> $LOGFILE
    echo 120000000 > $HWMON_DIR/$f
    sleep 3
    cat $HWMON_DIR/$f >> $LOGFILE
    echo $RESTORE_VALUE > $HWMON_DIR/$f
    sleep 3
    cat $HWMON_DIR/$f >> $LOGFILE
  else
    echo === $f === >> $LOGFILE
    echo File Not Found >> $LOGFILE
  fi
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 ++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  8 +++++---
 8 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 8156729c370b..3557f4e7fc30 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1008,7 +1008,9 @@ struct pptable_funcs {
 	/**
 	 * @set_power_limit: Set power limit in watts.
 	 */
-	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
+	int (*set_power_limit)(struct smu_context *smu,
+			       enum smu_ppt_limit_type limit_type,
+			       uint32_t limit);
 
 	/**
 	 * @init_max_sustainable_clocks: Populate max sustainable clock speed
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index cbdae8a2c698..2d422e6a9feb 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -197,7 +197,9 @@ int smu_v11_0_notify_display_change(struct smu_context *smu);
 int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 				      uint32_t *power_limit);
 
-int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n);
+int smu_v11_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit);
 
 int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index dc91eb608791..e5d3b0d1a032 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -163,7 +163,9 @@ int smu_v13_0_notify_display_change(struct smu_context *smu);
 int smu_v13_0_get_current_power_limit(struct smu_context *smu,
 				      uint32_t *power_limit);
 
-int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n);
+int smu_v13_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit);
 
 int smu_v13_0_init_max_sustainable_clocks(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a2a2a8398cd7..faa78a048b1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2342,9 +2342,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 
 	mutex_lock(&smu->mutex);
 
+	limit &= (1<<24)-1;
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
 		if (smu->ppt_funcs->set_power_limit) {
-			ret = smu->ppt_funcs->set_power_limit(smu, limit);
+			ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 			goto out;
 		}
 
@@ -2360,7 +2361,7 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 		limit = smu->current_power_limit;
 
 	if (smu->ppt_funcs->set_power_limit) {
-		ret = smu->ppt_funcs->set_power_limit(smu, limit);
+		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.power_limit = limit;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 3470c33ee09d..aedaa4bb15c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -978,7 +978,9 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
+int smu_v11_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit)
 {
 	int power_src;
 	int ret = 0;
@@ -1001,16 +1003,16 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	 * BIT 16-23: PowerSource
 	 * BIT 0-15: PowerLimit
 	 */
-	n &= 0xFFFF;
-	n |= 0 << 24;
-	n |= (power_src) << 16;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
+	limit &= 0xFFFF;
+	limit |= 0 << 24;
+	limit |= (power_src) << 16;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
 	}
 
-	smu->current_power_limit = n;
+	smu->current_power_limit = limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f6ef0ce6e9e2..eba516428f1b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2144,11 +2144,12 @@ static int vangogh_get_ppt_limit(struct smu_context *smu,
 	return 0;
 }
 
-static int vangogh_set_power_limit(struct smu_context *smu, uint32_t ppt_limit)
+static int vangogh_set_power_limit(struct smu_context *smu,
+				   enum smu_ppt_limit_type limit_type,
+				   uint32_t ppt_limit)
 {
 	struct smu_11_5_power_context *power_context =
-							smu->smu_power.power_context;
-	uint32_t limit_type = ppt_limit >> 24;
+			smu->smu_power.power_context;
 	int ret = 0;
 
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5019903db492..59a7d276541d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1241,11 +1241,13 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
-static int aldebaran_set_power_limit(struct smu_context *smu, uint32_t n)
+static int aldebaran_set_power_limit(struct smu_context *smu,
+				     enum smu_ppt_limit_type limit_type,
+				     uint32_t limit)
 {
 	/* Power limit can be set only through primary die */
 	if (aldebaran_is_primary(smu))
-		return smu_v13_0_set_power_limit(smu, n);
+		return smu_v13_0_set_power_limit(smu, limit_type, limit);
 
 	return -EINVAL;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 05c5e61f3506..58d837d9a414 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -945,7 +945,9 @@ int smu_v13_0_get_current_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n)
+int smu_v13_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit)
 {
 	int ret = 0;
 
@@ -954,13 +956,13 @@ int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n)
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
 	}
 
-	smu->current_power_limit = n;
+	smu->current_power_limit = limit;
 
 	return 0;
 }
-- 
2.33.0

