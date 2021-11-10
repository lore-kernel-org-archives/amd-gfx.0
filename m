Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2778961159
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2778961159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F301B6E0A0;
	Wed, 10 Nov 2021 06:23:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F826E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 06:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvFzrNiGqFwDWIrcP8Qg0JQ1BBM302+I0de8x92umoMQTa7NnQpu4Ti8XA55ZJpbEXgtqrSW23pjLpEoV/mim3nbfyJawyaumC12TKBnaWc7v/EwlgoHror6W8MaJTFEDNpbKK9dTDZRP37HUhe/3tLFB+2wr6QqcrlNhv7tPfS9p3SFeQmPII1OAlZ6WkMgmhJ9GfSAdtdgJS4Pr3uVgagOHrTeyt0SpF6PEg+fsVf+WUkjMoUeHy9z7zKM71jEva5efnJU019R7NEMWGZpdNN7jnsKIUoVpQ0R7GyZ7PS4Mcqmp/1XjDvXd8HszSFQup0Kc1UkhbOxxaDUI/WHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaylJbKoozRbuWvQbsiiHA/afWa/t5Unndcr4e7bn08=;
 b=L5eA06Xygj2797hsu2OT8GlVzGE5XL7FDfNgUg6KUS42YlnuOfJEMxYr/3N9i0zpWHQuiuwjJ890JFZKXvjS1ZGJcc/HjkUQDmPY49TjQxmk8wdPUHuI2ozTZhpMXtqZGtoi/fQ2046m9hd9wj6VRq4csaX/JgJyJUm33+fj6knTzpjdFPrr2jesl2kUG6KwA9WFTdg6vhsEj1LRF/WKDRWUeYNTQZWuYiiw1MOTMg93IV+It6pTTeTqNPs7gQDDQvKLdjM1rVAbslADpOSNvIimsf9uDUDgpC4XYHIbKtJO7dBb71NBG/L8Nj7HDzYjWsBBleph9TjWynnxCshoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaylJbKoozRbuWvQbsiiHA/afWa/t5Unndcr4e7bn08=;
 b=i0QQEU3j/7AYUv+au4VwxghzoEdxnrDpSAiqusSIO1NXQO9aunNT9GdPsAoLygQhWbrRysdJ3b51Yt8eEqboZxHwaV+8MHHYos80qVKyzNBWvujfn4FgIEI9lw8aOZyq50y+f18zK2yXAcm/Dz/QAtoFAEpRTmGV0p0JPPQHKYw=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by BYAPR12MB2885.namprd12.prod.outlook.com (2603:10b6:a03:13d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 06:23:49 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::c8) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Wed, 10 Nov 2021 06:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 06:23:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 00:23:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 1/2] ACPI: platform_profile: Add support for notification chains
Date: Wed, 10 Nov 2021 00:23:42 -0600
Message-ID: <20211110062343.10041-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110062343.10041-1-mario.limonciello@amd.com>
References: <20211110062343.10041-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d26ff69-bd28-4858-27f8-08d9a412a85e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2885:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2885B44710E1B0E91FDE0C53E2939@BYAPR12MB2885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbzagE2Dzzavypgh7Ww9o6tR5Z/O1P6ybJRnww7VkfeVap6YTcEXZJ6UpFStPRvHKxv2r9KO3VJyQgx9I0JlDnfzBWD1AzzRmj4Ggj3VIwzV7aYQ4o78dvl+8kmD8Y63ccf6RbcimRoCStO1n3HOzpEvklQAQAMktP7FxKHjac7OnSZeKGjj+dNvNTQWOff0MkRBwca5BxXVUGt4EAasCbJTQSnIL4VsayKw02hQnMcRiEb0OCjrUSUJv6pvI88F7s0wNtRblgV5pZNgfPRQhUxR4duUCJtribRzST2hFaZ7V7+7sohCrhU8iQD02LUj6WnVu/unzxRu2vgkDrG07UIVKkjfoIKGTJWd99CHdrrBYmAh1TJkU4gBgxfYbDd9fZqrDwpDKwvbdWRyY3+IqVJW5DcPC4L6sqb57AAI9Jzs5S4espwpvy8oPys8XpwdJ1yFZqMW5k6rlwsSekZBWlvF0/Z8tGlZNPEK21kzptrORH+JexGT7cZJv7KWVCb2XgwTl5brp4nSJtoy2sA4YWQwsMkUypkllkxmN25JLSatyMMQbz9WRUPAKOE9nJ7XELaicAHHOGGm4YnN/8v/EkV+U1SG2n+xuxd8cBkcZL1I2wOnyxRf1FyU6ORSNHRW3WGI+HsuMvx/1MHZnTF4x41DpzJnXF5CDIA9LZdagKU2uq64nyUShTPY9+TlScph7COjfE8FSXIzjM2cTwAt8NUTXsJlrjJmbbiskIvwmJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(15650500001)(7696005)(356005)(6916009)(316002)(26005)(81166007)(16526019)(86362001)(1076003)(6666004)(8936002)(186003)(8676002)(508600001)(5660300002)(36756003)(83380400001)(44832011)(36860700001)(2906002)(2616005)(336012)(426003)(47076005)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 06:23:49.0305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d26ff69-bd28-4858-27f8-08d9a412a85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2885
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

Allow other drivers to initialize relative to current active
profile and react to platform profile changes.

Drivers wishing to utilize this should register for notification
at module load and unregister when unloading.

Notifications will come in the from a notifier call.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 52 +++++++++++++++++++++++++++-----
 include/linux/platform_profile.h | 10 ++++++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..ca5d962020a2 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -21,6 +21,24 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
+static BLOCKING_NOTIFIER_HEAD(platform_profile_chain_head);
+
+int platform_profile_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&platform_profile_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(platform_profile_register_notifier);
+
+int platform_profile_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&platform_profile_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(platform_profile_unregister_notifier);
+
+static void platform_profile_call_notifier(unsigned long action, void *data)
+{
+	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
+}
 
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
@@ -49,11 +67,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+int platform_profile_get(enum platform_profile_option *profile)
 {
-	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
 	err = mutex_lock_interruptible(&profile_lock);
@@ -65,15 +80,28 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
+	err = cur_profile->profile_get(cur_profile, profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
 
 	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
+	if (WARN_ON((*profile < 0) || (*profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_get);
+
+static ssize_t platform_profile_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
+	int ret = platform_profile_get(&profile);
+
+	if (ret)
+		return ret;
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
@@ -106,8 +134,10 @@ static ssize_t platform_profile_store(struct device *dev,
 	}
 
 	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
+	if (!err) {
 		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+		platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, &i);
+	}
 
 	mutex_unlock(&profile_lock);
 	if (err)
@@ -130,9 +160,17 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
+	enum platform_profile_option profile;
+	int ret;
+
 	if (!cur_profile)
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	ret = platform_profile_get(&profile);
+	if (ret)
+		return;
+	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, &profile);
+
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a6329003aee7..dca9d47e18eb 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -11,6 +11,8 @@
 
 #include <linux/bitops.h>
 
+struct notifier_block;
+
 /*
  * If more options are added please update profile_names array in
  * platform_profile.c and sysfs-platform_profile documentation.
@@ -37,5 +39,13 @@ struct platform_profile_handler {
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
 void platform_profile_notify(void);
+int platform_profile_get(enum platform_profile_option *profile);
+
+int platform_profile_register_notifier(struct notifier_block *nb);
+int platform_profile_unregister_notifier(struct notifier_block *nb);
+
+enum platform_profile_notifier_actions {
+	PLATFORM_PROFILE_CHANGED,
+};
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.25.1

