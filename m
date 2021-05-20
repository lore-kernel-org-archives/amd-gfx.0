Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FFC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A9160FDC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A9160FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6F76EE63;
	Thu, 20 May 2021 03:58:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8EF6E83B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4kUt7TXYWCqTY71spPmsj3v37KGesbIpFMrMPJkqux7qANaOHpxDrb6LpQYm31l40v8RzshVZ5ji6B3xRrJnMkEb00amJzv3RJC2+FA+umkog8W2NmlWqWQoWiaoiFEk6xeQpHtqB3sM6b/uefZ5Ui/oQQaOAUFx0gjotI6KhaoteQ3EJ/nLRFHYj2FuAyqaE30uI8ugnflrvGLyomTXsisMiTXO0977uytZdhfasSntJ8x9JeLWjfdgZlsclEfBXSP8V5vB1H23sXFGj/jkkXjzCaTCf+0hSX00lC4rQZF2WrjwYvN3j2mI6XREmAS6Pwnd88Gh52UiUpV3M3lEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=817/TxcsAXFiwXwWuUvo5SIpiSk/Y6W3HsFU865ytO0=;
 b=jQ/BUwpHKcbEy4gYa2pfiKN1ehLyiubwjVTAcctiSsqsUUtbaNF19UEh6HYPZYwPZCe4qoylxHrpBQrz1T6sPuGS7oWofFcHOHWvxMRGDpx3M2kdtsgwPNmxjwU+MOqOlfofY12R3KstuL23eOP70quO/lnlN4yTVzMslrrbwFIlnIh6xTEGIHS1c/MXuLdS9mNFhM7eowqPyFEESgDNCDlOHx+ir6Z1/SY2IXRIVbTRu/LqcWTeJbg3xLX4fS5WIss5tFcJpvOiXm2BoQP/KftsRC2dk4AJiKP1/fESPAwwuuGnZDoVsr1Gok21H1POz8kSUafkwTNiyY7DJrQ0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=817/TxcsAXFiwXwWuUvo5SIpiSk/Y6W3HsFU865ytO0=;
 b=B2a0vx0ev504mQtWj8gKRCRCoTCgoy2jSqatlpZ9yJdYr6eDLHaZAzmHwFhMoWKVvoi6Ih6x0U+TQBsBZT/b/SCj7Bl8wzpyuIxvH8lpMEMia1xXSa1YPrgmLaJsh0DEERFoOq7nTS4sTAiyf/vJgSZiuXHrq2rvXdnaKUN8+AI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 03:57:56 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:57:56 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] amdgpu/pm: modify smu_get_power_limit to implement
 Powerplay API
Date: Wed, 19 May 2021 23:57:21 -0400
Message-Id: <20210520035722.4877-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520035722.4877-1-darren.powell@amd.com>
References: <20210520035722.4877-1-darren.powell@amd.com>
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dapowell-ubuntu-200400-1.amd.com (165.204.54.211) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 20 May 2021 03:57:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bfc044d-9fea-40dc-33b4-08d91b437393
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB161287A767E93E0173634E0AF02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cd+xZgeN3BclVGX6HEolqSlwY1B/xI92aQpwNS1fdAyZRYlH3UtdNldFjrjZnkQiXTD+U1TOktigaToCRi/E44ng/i3sojaTiXTtUeI6OgZPvOWHFb0+c5XJMJpR0kjkd/yh/vZsA7yXYl395w+tbCrh/8pzGG/ePp3vFpTF00QFTiiqucIGuRO8dCPJ8yiL9gFG1wmMWsNWm7CmCVRQZ5KFOOkQXJzs7NbvUYHTFtVtefX0Oq1F5OwNK4TJdRZECyVo+3U/LJvdNKR9yMYwRbzU4ioDQaNQl9MhkTgSSmFoZblTHE1YvqEvmb1cwqzzgcOpPiMrO7VJJEGJTwI1xns5lZwrV3vCIGd9CkEemLen7h0+fhYvrZQFjIz0m1N0QOnfr3AuE4XJsWI5ECxPwZURH81p66BJo4i8OmEO2S5NaQW7njG3xzj1QgxP4P0TztIKnQl41Ep7iB6lYhy7tnw7x11Rn1x6WNRTFVRXQ861maIXtw5MgFH0MIedXe5y5pIqZwk/Y3nj+lwF3qT3jt/chc+s6LmCOxk+BAGbMWd5bK7Y2mex7U80pdNk+4cfY2DT/X+WUOPOMsG/djRXawSspYUZLaPKf9256Pej5F0wMqTens6OdgoRMX3+JQz9Arj0m1uznSOn2JGGYkGd5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Gm6PmrMWCqMALJCds5jMl84pBuoB8yQd5C/vCx7IN/zbpGC5DB2AmF8xiM8?=
 =?us-ascii?Q?e3btYVdP6Cq5y7EAGyYxrvrZL1ioDcYFkXfv5soPgbZYzgcCnEfHfYTPPdZa?=
 =?us-ascii?Q?d8XoC/mVmRgAXsHhp0twdfiO61fYYqvYfEMNr9fe01gsgfAH/DEO3IitUZs5?=
 =?us-ascii?Q?w7nJeczeVCsCwnBb0vGUeO2g80FTW+M41/aMp3QUBMxBn1LyHpLVsrDAsJfn?=
 =?us-ascii?Q?C5TyaGIS+xxs5MZDcPe36Bt5E64n/TaIo5g/P1CEav3+6mXnTGHJKzJrBt55?=
 =?us-ascii?Q?mWlrtZ7SNBzaHWIEl5orV5cFawg3VhxRgqTiUm/TGgBgbYsF3QkGf5NKQ++X?=
 =?us-ascii?Q?RWWN6cOTKjT1YI/oEe2CZNBkHvxenz4DmTNm4eChcVpspfvcM/dE+JklI/Aw?=
 =?us-ascii?Q?Rj7Fz4HwLKofaNo+vfXGZ8SSKHd10TSThzG//Q52BgpKB33DAkE/aYIMVANM?=
 =?us-ascii?Q?PFEjrb/QFz9x6ke9K/bc0mDaBAeJJyFvLugQoLRG4pztR7RTtDmMJrf/KdIq?=
 =?us-ascii?Q?+G4SBO8Uqxx4EyR2jb/u6ijY69gW0xNRHACzXOObZ6fH21iB6XfVTxz/hq2B?=
 =?us-ascii?Q?uTcDi6qQJj3rDBgosDdIMQ94rKaAZgQROrKfaIsaq2LoyROGSmah8+qAjsQ2?=
 =?us-ascii?Q?zdOEVsoEU/calSkl8Wu6pv/A4fRAOucs5kx14AjNO41x6HDwDQ9HntFY+1tw?=
 =?us-ascii?Q?y9geMIILhtI8NWNx9jyzFzp4zEBpETg5Zbfw9GxO/us2cIsx9EtbgZ5ngByO?=
 =?us-ascii?Q?ABBWsIhmH0mqMj6PfrqAUaH+6xIO/YWW9fKdq0sBEg3b+DsvwF+4g3NcWHmu?=
 =?us-ascii?Q?QpAINGIHkw0Uz4PcpjDCqc2xyPI9WvOrhXA50uD2jnRjmt3zPDVnEyXHXXDv?=
 =?us-ascii?Q?/BoGG7M4DSGGFxLjyIzKtwOsK96ZP1dJDaUVIiijYyxVd8P1Mbm3GZarVFe8?=
 =?us-ascii?Q?JvTNpY/t7adf8h1hCnT/ksJgrtjPY+6CmGtSDlwcrjoTpHX1AzxZLxjYQjXX?=
 =?us-ascii?Q?wKgeIIXp6mJfT5Bu+MAnjxGw9Z9xOEWHzlhRPLZG4wH65YnaRF1ye3ELReA0?=
 =?us-ascii?Q?WnmhmuIAfF+P1ozdtcqGI4wpQ6D6IcOShRlbYmFiVz1IB15TqIgAYFeXT7EQ?=
 =?us-ascii?Q?bp6a7nqVyTh7vzxMPxVYVqkW5zMfiLJNQCgHBRvVup1qjVBib8Z07zSsXIAx?=
 =?us-ascii?Q?3XmDOycn5OSB+pKvOqKOOcecaaI0tB8EXAoWKeZWmBNnWHqYaZSZnzNt9ub5?=
 =?us-ascii?Q?kPMngNUshIgJUGcd7uszkpZ+bMA2+Y3EghPTD1Pao1q4YGBoWhNOtwWeb5Wu?=
 =?us-ascii?Q?3FLOixxHqUHEaQ9QoZI/rpGJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc044d-9fea-40dc-33b4-08d91b437393
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:56.7620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH973lRVqjTquPOHdZ/zV6N1yEC8+GZi6yFhzNjCiy/QrY9CZS3njyHUXlu2Ozxt8c6o17hBaCD3MI3GmOJE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 modify smu_get_power_limit to match Powerplay .get_power_limit signature
 add smu_get_power_limit to swsmu_pm_funcs
 simplify calling functions to use Powerplay API rather than direct call

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

* Test (VANGOGH only)
 echo "=== power2 cap ===" ; cat $HWMON_DIR/power2_cap ;           \
 echo "=== power2 cap max ===" ; cat $HWMON_DIR/power2_cap_max ;   \
 echo "=== power2 cap def ===" ; cat $HWMON_DIR/power2_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 48 +++++++++++------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  5 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  5 ++-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6130318dd993..1e8f9e8c13a2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2735,16 +2735,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_MAX : PP_PWR_LIMIT_MAX;
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, limit_level);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, PP_PWR_LIMIT_MAX);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, limit_level);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2776,16 +2776,16 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_CURRENT : PP_PWR_LIMIT_CURRENT;
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, limit_level);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, PP_PWR_LIMIT_CURRENT);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, limit_level);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2817,16 +2817,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_DEFAULT : PP_PWR_LIMIT_DEFAULT;
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, limit_level);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, PP_PWR_LIMIT_DEFAULT);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, limit_level);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 6bdd112d64cb..3fbc5f7bf048 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1260,9 +1260,8 @@ enum smu_cmn2asic_mapping_type {
 	[profile] = {1, (workload)}
 
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
-int smu_get_power_limit(struct smu_context *smu,
-			uint32_t *limit,
-			enum pp_power_limit_level limit_level);
+int smu_get_power_limit(void *handle, uint32_t *limit,
+			enum pp_power_limit_level pwr_limit_level);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e192192e99d0..2815e932580b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2166,10 +2166,10 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
-int smu_get_power_limit(struct smu_context *smu,
-			uint32_t *limit,
+int smu_get_power_limit(void *handle, uint32_t *limit,
 			enum pp_power_limit_level pwr_limit_level)
 {
+	struct smu_context *smu = handle;
 	enum smu_ppt_limit_level limit_level;
 	enum smu_ppt_limit_type limit_type;
 	int ret = -EOPNOTSUPP;
@@ -3002,6 +3002,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.load_firmware           = smu_load_microcode,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
+	.get_power_limit         = smu_get_power_limit,
 	.get_power_profile_mode  = smu_get_power_profile_mode,
 	.set_power_profile_mode  = smu_set_power_profile_mode,
 	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
