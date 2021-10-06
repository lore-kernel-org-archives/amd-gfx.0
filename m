Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC97611C0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDC97611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626986F60A;
	Wed,  6 Oct 2021 05:07:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52546F607
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 05:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5RXwIl7HefUWRPe1+F6rNzv1nxQHU2LuWeicFXzTTY4Ndl3SLi+iZpTKm8qQrfue9aa37dDv8gjKzQjWlJ3BNU03EpwoEEozCQ6moWzrEPdkv4boRCSDFIF5MPXk3uqYhHtOsMi/rxY/QT52CiNL+mE9DG29fswCVz/wFYtsFZy0LtAOwKUwigwIOWcjja78mhFGqNaZA2Ow1DwRPC0MouQzHI4e+Rvj/+veW2/qSAFNqfns/Ha9kBj2Av56HKa/bpEtBTkmxmNUAyYLtw6csFzAv9GKGW/Za0phBkgA2Mb3Hcd/ryLh9FcDk1GPOsuKSegnsZE0pAbKtaIjximiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTciGMv64u4l9NQJWCFYdAhvUmlm5ld5sGHY3DqBn1Q=;
 b=lQobQmeynd943ah297/R2o02L78+6aGT5Tug4A07vxHvkKi9ql3Bw3dB3jvr2N8e/PVJ/fMZnkYQZfYwXmWKm9rmkQLkjmH7UZuXWlpzPL5WqELp3RZBM0/n0qznF/W/eHB89EVIcza+vbQbdeL7Ap0uwqiOeRECZODkbfebUdRG7aTXKxJIWkEqn2wy8z/bKgkC79AL6YcnpbmxqhS7EB4JCrMvVIENmz8d2GzmjORsSeZmzhRuhZwYqUoDYqIK5Zk1Utz5pAPtDeifaDklb1zjfSFKH396vOSNT4C0aVZFKjbSe2gt5ndTPOqGDvSzQinoMxjnzShP1IF1se+SIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTciGMv64u4l9NQJWCFYdAhvUmlm5ld5sGHY3DqBn1Q=;
 b=PZW/MYGerWuLyZkbDi9UR7j+11rLMQKEq9CnM19lXyk/LWle9HapO1mhCVoRmJzEs9ZXwxb6iDgw/0J7D0KZuh0MyRH21dokT/b2XcC/2SpC+WAoBeGFnE7m2Us3JURShHztsrePNaOWxH/6qkXdFBv49OLjEf314m4CeMvuEGU=
Received: from DM5PR07CA0167.namprd07.prod.outlook.com (2603:10b6:3:ee::33) by
 CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Wed, 6 Oct 2021 05:07:15 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::ec) by DM5PR07CA0167.outlook.office365.com
 (2603:10b6:3:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 05:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 05:07:15 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 00:07:13 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 1/2] amdgpu/pm: (v2) add limit_type to
 (pptable_funcs)->set_power_limit signature
Date: Wed, 6 Oct 2021 01:06:54 -0400
Message-ID: <20211006050655.6220-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006050655.6220-1-darren.powell@amd.com>
References: <20211006050655.6220-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3762c3df-96b4-491b-5bc6-08d9888729d0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4088:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40880ED1A12CD1C399E4F3E1F0B09@CH2PR12MB4088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0JfqroSJ20KID5r4J1yjJ4H4n7H4twQwNLZZt/AbhdDBvYWYDglFbJDRJjrh6G9bOaVV47Qn8/8TiJvTcyWowO1CIjYDwwdbdUPATaDNl+HxLgo6ysn3dAxEwIxOy2a01Tdt3j83NVxMgto5wKpyVq6nxFWeR/RQOuDN3IwVuH/VTekvso3YfzqwRK3/jmaIFpVJ3eIfwvoWz/4xZKuszApcBYvwikP5rAcLS5pqTkmR8uGBXnu4Capt3T0a/L+6lO0uYFpTLx4NMY1ZzjJQGxmqFQ0edsDvraEu4VOou/BlSMMLes7sW3fSUctUshLskNBxsKfiMfmkTh12ZjNCKnpETXxdH8w/QWOsTdx0yD5CfCLCtJzUDrU4f169ieX94MQHxtxkXBGQiTpbN5q74VbAMr/ZvDeJ4ycYaTge7ng6u4g7mY2wbS/U2lZylDZaIKPfFESUIJZxDPGoKl5BqbnQZhvSiC2LcIKlNlCTriiWxH8BLgof/d4obo5pGuMBaccZsnrZsjS25GNm+f7twtWlP1LTs5UX+twqRJd3/KfOC2sXOn2frnZK/a/Mx2dCq91MSu0Wo+GNaMj4991EGhBx+FjW+UJG2C+bqX9/f5RncnAH5NVWGQc05mE9dhRICZrGgOiviiMJ6GIwCWwtLr7+bIrscaS44FomuWvy5kB4wpotWgPghbEYIlLEA2OmcIOxt+xq7LHocDXSHyb4Z35yOi+YwDQgL5yS4O0Was=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(2906002)(508600001)(44832011)(4326008)(336012)(2616005)(426003)(5660300002)(26005)(6916009)(186003)(36756003)(36860700001)(8936002)(83380400001)(316002)(70206006)(47076005)(8676002)(6666004)(82310400003)(81166007)(356005)(7696005)(86362001)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 05:07:15.2339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3762c3df-96b4-491b-5bc6-08d9888729d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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

 v2
 add check for SMU_DEFAULT_PPT_LIMIT

 v1
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
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h          |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h          |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c  | 17 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c  | 11 ++++++++---
 8 files changed, 39 insertions(+), 19 deletions(-)

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
index 3470c33ee09d..b9386c55bd85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -978,11 +978,16 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
+int smu_v11_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit)
 {
 	int power_src;
 	int ret = 0;
 
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
 		return -EOPNOTSUPP;
@@ -1001,16 +1006,16 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
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
index 05c5e61f3506..35145db6eedf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -945,22 +945,27 @@ int smu_v13_0_get_current_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n)
+int smu_v13_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit)
 {
 	int ret = 0;
 
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
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

