Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B4C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8470E22EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8470E22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A82B89C3B;
	Wed, 13 Jan 2021 03:28:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B429D89C37
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYHXo8bSKwODYZVWyOb5mwa+fhlz6hgF1fva88aHkMo0sK2ynCeUsa0nD8xn95hJPADqj8oI8Iyjr2lSeY02wDqxISbaDjC1keAjHFunRaDZYFXd5mcIBNQSyTwZL9nnd1vRXlVpuuXfagP7cMzycw1Q2DcpHjAMWgroL6qq74KJAmFhifU8S8POEcXhn+zuWFNgkf58aCSi/z1RIDRni9HHi1JwI+AJc6JIK4aBAnE1zmy89Y2GIyJz1MaB8+rajzSkQyMm3vCo0Y/NxH0yUZFZXOSgGr0R05T8CQAVxa4974fG/vYNuBunu+zAqGCWkw9DUnet4VZYX5c0vUrV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCFSlYO6jS18kS1VUgUHPE1tuDY3/NirS0xPUmL4hXk=;
 b=l2cdHoXUboetH5cnFsHghDctaihRi03z8J8VqNrZ5mHH6GgnXLXih+pCgqRF1TGyd5uLnmr21gXXecnriFYWJn9osRStw9wZNVuVqNqVESZl2u+BR1Ea493qXs+hy5oWkz6xQmCZJrGhLsEmCOPo1NVNa6orhlBKBpfTuZOL1uBfkZaRUAlhxIof4ZkFLGKWWpq/sIdrkhw53ILZ0qIJgodASoM0GoyFwPvKyuePkkFKFwUU117b5XXTX7wZ6hcKEp+tj/rLNaYeqw7rrFAbvpxMz/BWmsoWXRsMEoftfcK7LQPpvyi3wbogO66ZR1GqJ9rRGcXPkA0nxzuyCauKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCFSlYO6jS18kS1VUgUHPE1tuDY3/NirS0xPUmL4hXk=;
 b=BZsH2NvktGIoEMueNd9lvuVD279JePu5+PQndJTv0glY3Rl0F903mIEvwZl8vHFcQbWOtKJ75ogRMS3JQDnjgiWjBsz/VreGlu1Lrq8Axc40Ci9kJf9tSN0aEd2N1vIZv9rYSFCexuhEXGxPktDNzlFXTRZma8sphddkWVw4o/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:06 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:06 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] amdgpu/pm: Powerplay API for smu ,
 changes to clock and profile mode functions
Date: Tue, 12 Jan 2021 22:27:24 -0500
Message-Id: <20210113032726.2475-7-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59b3a90d-7888-4b03-7b57-08d8b7733e31
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38171A29704FE4B803883D58F0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41Zk4cK+RNiVchETllGLdzDky3zvMU7MQz2rKB3RmzbZMH8IDBxG2H8D7ssvLKcl6zXhvDvL1w72r+Dy06Cvs0V9TJ+QbTSFHFDNPQtM8S0EV4NmEWXLvLmaK7eOsnP3yzoYtn3z6ESO7VkgnM9S5zmrLDnEZuo7aS9d4R5l5A3O+7c0/m/HU9J0Nq1u1b56GSjipRgEHutnuF7Qhsi1c8Nh+e3keRjKZ3mQWuEck4qokX9rTasDaK4F8AG5Xr7CuZiGbhPW7bUAXRZDzkHffwehd+5OLrlFT/MUxrL5rzKP0UiI1kB7Xx2G6tKmh3Dj1+qXLng0TnAs6VK0j/sNVikz68ATLB8RB7CRpungeJLYWKfaoHfaqzjou1FrKtlbb//OnlUMan/0lsJ14FM7xGSuD16q/8+uD74lO/Nc350z4uhCC2sVeNc60K5GeVGP53iUULhCYCkyopEOhuLOXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(30864003)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VX1zLUBwB5ZYhAgA/9x4eNZfwjK5YNXF6PHlq5CTtb0GprRTd4Ba2/vC6a98?=
 =?us-ascii?Q?F8h46Dlz1a+7pwrdgoeTJ46Uq/Fahr6MqPb7swVVIJpbmNEsTPqKghN6RuH1?=
 =?us-ascii?Q?XPp96CUiWuhbhPBVzPoyM9X6/xdQzkydH1cGbz7qw0a619PUCf7fNylMCGKE?=
 =?us-ascii?Q?wM0CZaWjqI77droAHQgRqcKi/T4wEqdvmZ7/hPJwt1Qg/g+3tF1ZjLgqy7IY?=
 =?us-ascii?Q?mkzhnFoChSEzsn/421sPMiL9j2MjeyKOSiUDUXj33nWDQj6oDjtPm/zI8UmE?=
 =?us-ascii?Q?4F1N7JKJONE8n2SvkInRawv8k6uYLEjv5ABqupzpe4WycNGKkjIPf8ZcuxBu?=
 =?us-ascii?Q?x9g3f3WwqUR2spcEzvKASGFGVSY/ESvNc3UoynuP7kUcgDYREziCbcmFDklW?=
 =?us-ascii?Q?yVPytiLlVRN28f4VGcvCBlFD9gS3uXzZHIZeL2KRJC04VhJWIXtPM2tOFNGu?=
 =?us-ascii?Q?qMU9k7xu4prUH+DABcWyZok2I0sux4NjU6CGsfqS+7n9R6ZmskKjjN0jOOdM?=
 =?us-ascii?Q?3rIgpTqpWqaLma583pfeD9VQgNbwTVGWGyIeBdnCUcplZPIQJUhugnvLjXH4?=
 =?us-ascii?Q?0fVcmSDj67r1N2A8evs8IDyQhdsBG4krujxb7X40UkRCUOtZAcXHA1jLoh01?=
 =?us-ascii?Q?LXAVS/Puj5nrrghVXDYuM/fYS9YEAlQID9zz5ztF1p1jxLkt97B6Mi6XSsms?=
 =?us-ascii?Q?Son1/nQ5Kg3Y2gTp6WZXiuNsvyP8woHYxvZ8NuiYMRD1K4ZixoYELYqHBaUd?=
 =?us-ascii?Q?ATMVI/u/qTtF4KDG0pxWHv4y7T0BBJYD+Q09VqTuqfFmZdSufxR3dj7YHLJP?=
 =?us-ascii?Q?gMATislbMxBtjcDoZCk9wowae6a1TmusvAq0k9uI43CWkvVoFLsbxovvSuTv?=
 =?us-ascii?Q?HGsirufi2O9k5aKnrZB7datrBfCohh5SdNnn3KFjhkI7jgqigYear+P29i7E?=
 =?us-ascii?Q?J3GYIShzctAkZWhrcOO5v8XFLkSOONHOW58lUPF9SaABYLvVgfeRBfc0G0lz?=
 =?us-ascii?Q?0Cyl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:06.5087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b3a90d-7888-4b03-7b57-08d8b7733e31
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Lfs3YgLUsEng748OPnYTzn5h+mBKwLdwqLf9QS1dFKhbWq8RfwSkmIRWxJ0/NNPEb8V1eH9YTa3/mdfafJOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

v2: fix errors flagged by checkpatch

New Functions
  smu_bump_power_profile_mode() - changes profile mode assuming calling function already has mutex
  smu_force_ppclk_levels()      - accepts Powerplay enum pp_clock_type to specify clock to change
  smu_print_ppclk_levels()      - accepts Powerplay enum pp_clock_type to request clock levels
  amdgpu_get_pp_dpm_clock()     - accepts Powerplay enum pp_clock_type to request clock levels and allows
                                  all the amdgpu_get_pp_dpm_$CLK functions to have a single codepath
  amdgpu_set_pp_dpm_clock()     - accepts Powerplay enum pp_clock_type to set clock levels and allows
                                  all the amdgpu_set_pp_dpm_$CLK functions to have a single codepath

Modified Functions
  smu_force_smuclk_levels        - changed function name to make clear difference to smu_force_ppclk_levels
  smu_force_ppclk_levels()       - modifed signature to implement Powerplay API force_clock_level
                                 - calls smu_force_smuclk_levels
  smu_print_smuclk_levels        - changed function name to make clear difference to smu_print_ppclk_levels
  smu_print_ppclk_levels()       - modifed signature to implement Powerplay API force_clock_level
                                 - calls smu_print_smuclk_levels
  smu_sys_get_gpu_metrics        - modifed arg0 to match Powerplay API get_gpu_metrics
  smu_get_power_profile_mode     - modifed arg0 to match Powerplay API get_power_profile_mode
  smu_set_power_profile_mode     - modifed arg0 to match Powerplay API set_power_profile_mode
                                 - removed arg lock_needed, mutex always locked, internal functions
                                   can call smu_bump if they already hold lock
  smu_switch_power_profile       - now calls smu_bump as already holds mutex lock
  smu_adjust_power_state_dynamic - now calls smu_bump as already holds mutex lock
  amdgpu_get_pp_od_clk_voltage   - uses smu_print_ppclk_levels
  amdgpu_{set,get}_pp_dpm_$CLK   - replace logic with call helper function amdgpu_{set,get}_pp_dpm_clock()
                                   CLK ={sclk, mclk, socclk, fclk, dcefclk, pci}

Other Changes
  added 5 smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling in pm functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 348 +++-------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 113 +++++--
 3 files changed, 142 insertions(+), 334 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 068a369866bd..e71356e9afe0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -874,10 +874,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_MCLK, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
+		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
+		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
 	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
@@ -1011,8 +1011,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * NOTE: change to the dcefclk max dpm level is not supported now
  */
 
-static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
@@ -1029,10 +1029,8 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_SCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_SCLK, buf);
+	if (adev->powerplay.pp_funcs->print_clock_levels)
+		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
@@ -1078,8 +1076,8 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
-static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		const char *buf,
 		size_t count)
 {
@@ -1101,10 +1099,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
+	if (adev->powerplay.pp_funcs->force_clock_level)
+		ret = amdgpu_dpm_force_clock_level(adev, type, mask);
+	else
+		ret = 0;
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1115,35 +1113,26 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	return count;
 }
 
-static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
+static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_MCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_MCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+	return amdgpu_get_pp_dpm_clock(dev, PP_SCLK, buf);
+}
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	return amdgpu_set_pp_dpm_clock(dev, PP_SCLK, buf, count);
+}
 
-	return size;
+static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return amdgpu_get_pp_dpm_clock(dev, PP_MCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
@@ -1151,67 +1140,14 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t mask = 0;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_MCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_SOCCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
@@ -1219,69 +1155,14 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_SOCCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_SOCCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_FCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_FCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_FCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
@@ -1289,69 +1170,14 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_FCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_FCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_DCEFCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
@@ -1359,69 +1185,14 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_DCEFCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_PCIE, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_PCIE, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_PCIE, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
@@ -1429,38 +1200,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_PCIE, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
@@ -1647,9 +1387,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_get_power_profile_mode(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_power_profile_mode)
+	if (adev->powerplay.pp_funcs->get_power_profile_mode)
 		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -1712,9 +1450,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true);
-	else if (adev->powerplay.pp_funcs->set_power_profile_mode)
+	if (adev->powerplay.pp_funcs->set_power_profile_mode)
 		ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -1971,9 +1707,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
-	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
+	if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
 	if (size <= 0)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 739d645df7ef..3c0b6209ab6a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -662,19 +662,16 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);
 
 int smu_set_power_limit(void *handle, uint32_t limit);
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
 int smu_read_sensor(void *handle, int sensor, void *data, int *size);
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
+int smu_get_power_profile_mode(void *handle, char *buf);
 
-int smu_set_power_profile_mode(struct smu_context *smu,
-			       long *param,
-			       uint32_t param_size,
-			       bool lock_needed);
+int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size);
 u32 smu_get_fan_control_mode(void *handle);
 void smu_set_fan_control_mode(void *handle, u32 value);
 int smu_get_fan_speed_percent(void *handle, u32 *speed);
@@ -748,9 +745,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
 int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
-int smu_force_clk_levels(struct smu_context *smu,
-			 enum smu_clk_type clk_type,
-			 uint32_t mask);
+int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask);
 int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state);
 int smu_set_df_cstate(void *handle,
@@ -769,7 +764,7 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
 
 int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0d657cb518ba..dbcf853abb47 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1452,6 +1452,18 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
+static int smu_bump_power_profile_mode(struct smu_context *smu,
+					   long *param,
+					   uint32_t param_size)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs->set_power_profile_mode)
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+
+	return ret;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 				   enum amd_dpm_forced_level level,
 				   bool skip_display_settings)
@@ -1500,7 +1512,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		workload = smu->workload_setting[index];
 
 		if (smu->power_profile_mode != workload)
-			smu_set_power_profile_mode(smu, &workload, 0, false);
+			smu_bump_power_profile_mode(smu, &workload, 0);
 	}
 
 	return ret;
@@ -1571,7 +1583,7 @@ int smu_switch_power_profile(void *handle,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
-		smu_set_power_profile_mode(smu, &workload, 0, false);
+		smu_bump_power_profile_mode(smu, &workload, 0);
 
 	mutex_unlock(&smu->mutex);
 
@@ -1639,7 +1651,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count)
 	return ret;
 }
 
-int smu_force_clk_levels(struct smu_context *smu,
+static int smu_force_smuclk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask)
 {
@@ -1664,6 +1676,39 @@ int smu_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:
+		clk_type = SMU_SCLK; break;
+	case PP_MCLK:
+		clk_type = SMU_MCLK; break;
+	case PP_PCIE:
+		clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:
+		clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:
+		clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:
+		clk_type = SMU_DCEFCLK; break;
+	case OD_SCLK:
+		clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:
+		clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE:
+		clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:
+		clk_type = SMU_OD_RANGE; break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_force_smuclk_levels(smu, clk_type, mask);
+}
+
 /*
  * On system suspending or resetting, the dpm_enabled
  * flag will be cleared. So that those SMU services which
@@ -1961,7 +2006,7 @@ int smu_set_power_limit(void *handle, uint32_t limit)
 	return ret;
 }
 
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
+int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
 {
 	int ret = 0;
 
@@ -1978,6 +2023,39 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 	return ret;
 }
 
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:
+		clk_type = SMU_SCLK; break;
+	case PP_MCLK:
+		clk_type = SMU_MCLK; break;
+	case PP_PCIE:
+		clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:
+		clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:
+		clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:
+		clk_type = SMU_DCEFCLK; break;
+	case OD_SCLK:
+		clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:
+		clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE:
+		clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:
+		clk_type = SMU_OD_RANGE; break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_print_smuclk_levels(smu, clk_type, buf);
+}
+
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
@@ -2070,8 +2148,9 @@ int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 	return ret;
 }
 
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
+int smu_get_power_profile_mode(void *handle, char *buf)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2087,24 +2166,19 @@ int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return ret;
 }
 
-int smu_set_power_profile_mode(struct smu_context *smu,
-			       long *param,
-			       uint32_t param_size,
-			       bool lock_needed)
+int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
+	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+	smu_bump_power_profile_mode(smu, param, param_size);
 
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -2582,9 +2656,9 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 	return ret;
 }
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
-				void **table)
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
+	struct smu_context *smu = handle;
 	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2660,5 +2734,10 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_df_cstate           = smu_set_df_cstate,
 	.set_xgmi_pstate         = smu_set_xgmi_pstate,
 
+	.get_gpu_metrics         = smu_sys_get_gpu_metrics,
+	.set_power_profile_mode  = smu_set_power_profile_mode,
+	.get_power_profile_mode  = smu_get_power_profile_mode,
+	.force_clock_level       = smu_force_ppclk_levels,
+	.print_clock_levels      = smu_print_ppclk_levels,
 
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
