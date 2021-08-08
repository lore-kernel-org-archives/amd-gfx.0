Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5CC4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389B760FD8
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 389B760FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8411089D4F;
	Sun,  8 Aug 2021 05:33:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2783F89D43
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4kjdIEiQQrYxITIJPfZh4OnFslMDie1qdiv2q2Bp/rC4CKo3PQYSJZNrBLq2jJ2vE1ahzjtzVV9szHV2c+ck/CtXSBxnMs+Ea9vUPIOG5ZopUQcl/1dmjLTt0S3NyBcyCLx8EbXLwTQuM3nK+Ha60wnoiv51NTHC//n0nGTiKhQE8EElblgbvn83QETEvHiOmlDFdIWTY6MfCHJ71uCvdLThfTYSoQm3D33XcnyxpajLms6wt5+nhG9zlknxE+0qfRvkPVOOlprAj27urC8LIfFcV/xuZtVP34+VYG7gbtcv0DmCovV+G/iJRAfz8jFr+Wl9UcbkdQZiNU2/rueWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcPI6k0cMDpy8nZDqj+brHnwwIx1+IV1bCRSTFWSMIM=;
 b=gIsJdoFnUiNEDTHZh4oRIxwwycfGZBnYJGVkwOFvs9KB8ZgkrKP/8dNRJlkUWG6JW8R8LK6RjUZ/x8tduA9do11IITNa1liNw7KrcHsu+czZopZiD7Y36aBDgPAKy8jHyJvgKTKtlRoRGpzw++UNo3nzjoJciPGPKvpNIJFxkpg5BdesnmmiS9kf9MW08kf03VdY119gmk0pOoF2Fjrl4tW+oAjoohAdZUHhR3M3Vw56wc7fquGLpafwvXdkXTjJDr6VsuSlSNjvJv1gD16dp20tnrKYHQf8migJDQAdApiUK9ZgElj+UsBio7DAeD1nrBFrUuMjpKddU3YEqtPB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcPI6k0cMDpy8nZDqj+brHnwwIx1+IV1bCRSTFWSMIM=;
 b=ntrnuApCPvsIfsbJmoX3tGS5VgwJnmtynmQsmbuusNux866KTY1geDclW+siVlhUXhS+6MMfc3VhhiMtChy4Zfn3ZXFy5Txh9hZBPUw+ZcZJ1OTZpxXE6G9TJXxFoIt0BYkdKj1+Qjiaz7NmYu3gU3XNAckvnhiZaYXAowm6irA=
Received: from BN6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:404:121::28)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Sun, 8 Aug
 2021 05:33:27 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::23) by BN6PR18CA0018.outlook.office365.com
 (2603:10b6:404:121::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:33:27 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:33:26 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 4/4] amdgpu/pm: Replace amdgpu_pm usage of sprintf with
 sysfs_emit
Date: Sun, 8 Aug 2021 01:33:12 -0400
Message-ID: <20210808053312.3423-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808053312.3423-1-darren.powell@amd.com>
References: <20210808053312.3423-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e5bdab-eee1-45f6-8d6a-08d95a2e0c75
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2841063F99E40D3DAC843028F0F59@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuMv0YZJHiJ27iJFQYQlBotZ+MN89A/riv1yVOsZuTI19/MxtNRv5svPjz3VHnVH5nnFKvtKq+sIfK5229qVw5Xs06RY5fOLdZCDijB2xAW2e8cdK7kFtjSBu4g+07Vmt8sk+joEvaCVeMC7/Vb7FdGZl35kJz6JlYnASa5WlR4YhJ0oLyWpwYlGjRxC41Fsl3umMQmrpOFfAoFnSDvFg+iMVzaLYxSlASDnWJpz1TNVWTjc/AQS+NqFGK6kYsDpdTV8IxG8S8J1Pt7ULTD91AH1+uIBbQJ5qGMy1yZglOuIa0U92QVT/CoVMs8gferfQLkGtU7VQhfoHKGwpe98TjU/1LG6oCSerxon1jd7TSg3mNjtP+K/jrTz0O9D/hahhIIYZnuXF1g//CLYG2dCp1/IqQp8URjw2mNzXUsmvbB8dL9zk49RzjOgiHfoWgTg9QjyuChG4LzGU3GFPH0pBUGmWyG1RgjarPQHzx7q1XKpIGEphaDz9JOuU3YxfUABn9SX1dZlGwvRtfYCCf9B/KC4m0HxGgRJtkO3bxRPmsCGXSpeVJzGJlR6yzzxaci0Ul/5tgCCMgIs3qjdwn2gTNMMhPKZicTCfwGF5QWVlL1/22wIombbWHi2k07LfetmJk6UaXjFtEviRF3Ya8P8iYkG2SAqQzfPu6CAK9ljM7Yz4FaOZqSlfF+hx/mgDa0Xvlsv6xO4w7x1MgEmuhSApOYTcc0Lvrr1DAOpU32xQgqpch/T6QL20ZNOULA+Rq/vcNa4hY6lZ4auQ1eLyUduxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(86362001)(83380400001)(356005)(36756003)(70206006)(34070700002)(6666004)(7696005)(82310400003)(16526019)(26005)(70586007)(336012)(478600001)(36860700001)(186003)(2906002)(82740400003)(81166007)(6916009)(8936002)(8676002)(47076005)(316002)(2616005)(1076003)(5660300002)(4326008)(44832011)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:33:27.3222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e5bdab-eee1-45f6-8d6a-08d95a2e0c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
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

 replacing printfs with sysfs_emit

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pwm1_enable
pwm1_min
pwm1_max
pwm1
fan1_input
fan1_target
fan1_enable
power1_cap_min "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 769f58d5ae1a..4ee5d4d6aa7e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2379,7 +2379,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
-	return sprintf(buf, "%u\n", pwm_mode);
+	return sysfs_emit(buf, "%u\n", pwm_mode);
 }
 
 static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
@@ -2424,14 +2424,14 @@ static ssize_t amdgpu_hwmon_get_pwm1_min(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%i\n", 0);
+	return sysfs_emit(buf, "%i\n", 0);
 }
 
 static ssize_t amdgpu_hwmon_get_pwm1_max(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%i\n", 255);
+	return sysfs_emit(buf, "%i\n", 255);
 }
 
 static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
@@ -2517,7 +2517,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	speed = (speed * 255) / 100;
 
-	return sprintf(buf, "%i\n", speed);
+	return sysfs_emit(buf, "%i\n", speed);
 }
 
 static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
@@ -2550,7 +2550,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%i\n", speed);
+	return sysfs_emit(buf, "%i\n", speed);
 }
 
 static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
@@ -2647,7 +2647,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%i\n", rpm);
+	return sysfs_emit(buf, "%i\n", rpm);
 }
 
 static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
@@ -2729,7 +2729,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
-	return sprintf(buf, "%i\n", pwm_mode == AMD_FAN_CTRL_AUTO ? 0 : 1);
+	return sysfs_emit(buf, "%i\n", pwm_mode == AMD_FAN_CTRL_AUTO ? 0 : 1);
 }
 
 static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
@@ -2899,7 +2899,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%i\n", 0);
+	return sysfs_emit(buf, "%i\n", 0);
 }
 
 
-- 
2.32.0

