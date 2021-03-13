Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4CC433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 15:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CCE64E1F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 15:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCE64E1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB316E11F;
	Sat, 13 Mar 2021 15:47:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCAF6E11F
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 15:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr4OZcvc1bztwWFszmpe3BRY/CtCbBPVk+lwLJnil/A9IiPPvVyyeNHcLrQuw4jA+3Gc113VREnClFP7v5tU1ok06pNAT+ldSVa00/QUwvsW0j0CliNr4W0V5XZH9He+jsHnVp5zFuhw+bhbZRa3jZtbSM9yd3VjW8sxIjHuHrAanEb/8kF23sGVadnaYsMl6HYivEfGZMXxGk4XVJFMjdwK/w3BcDAflzC50tR2pAllm8QBXRZRQuwar+K9KKWcT3etN0MdjPA6yJ9wGkL5ent9Pd1qGtKWA9O1ZfcgYt68x6o93r0kzL/565rZ+du8PE4Zz7/Jm/1otP6EoZXq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba7yb/ACAzLgQPZUr8uHBpOdBn8+Zc8DZk2CshrUYDU=;
 b=hKoY0h1+jrJsyoxs5xNdhOoZ1D0VBPE60CZUMz1RT/sT4mf2MfvY2TVAyEOxtfMczkeGq6mBZsQy/WCKY6YcK/WKi/yCnt5f3E1HC4EHeCCH5a270QZzKCVekx5X7N3b82w+Cmu/r4benkBVaGPoKenAd+AQYYVj/mlXeNVJgwjV+7lefhOd58AmNgKN4wkZGZ5vdmmybQGX2jaaloIkmoL1r0z7PDAu0b8M8bbovM3u5ePRrKJrMRqeflLbz2xKDMevKi3+ZHfRtJkN/Vm9WFrt4QVeOxy5mUtbEoO13aGr3+G+NWoefGZKIVUn1G3ZpN5aeC0TaWZJIt1SSJr9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba7yb/ACAzLgQPZUr8uHBpOdBn8+Zc8DZk2CshrUYDU=;
 b=S+JQgwzU3av8TpTpDv57lFnsDjzTZbPoRcDPXVsnt1DfWVSL7xQkL9sLuMALRUZc7Tr/pVaNs6KyP0ZeiB7X1+cijWVaZ/0X+Zw7wm1mph5/4TQpwlK8fUO40YEyZRtXkXSEpSHhk9xTsjrho/6RpZIPyfgvIERJTaW++EH8t+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR12MB1370.namprd12.prod.outlook.com (2603:10b6:3:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 15:47:45 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 15:47:45 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add a new sysfs entry for default power limit
Date: Sat, 13 Mar 2021 10:47:08 -0500
Message-Id: <20210313154708.19050-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2607:9880:2048:122:94cc:f8dc:e7db:eaee]
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:94cc:f8dc:e7db:eaee) by
 YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Sat, 13 Mar 2021 15:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdebbc51-fbb4-4c66-b157-08d8e6375808
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1370C12952E93F54D8D7A241826E9@DM5PR12MB1370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:336;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTJ0BvCT9S4yKNsQ52MJ7n9J0eHjW/EX7xhl8CrP/9Vp+p9fYd5fRMQPIQAQvpk+uo+r21BeRhENyrt2N5qaoLRnM9WCFurCzuAZuF29sMu9rLU0ZwXNMcAnRqYd3efciOjfMcoglGlq6JCPHmVWyFhaLqUzdEh4tNHumBWO1kMSiMQOUP92P5zBuFoCnHIYhr1SU8gGuFNcgmTJEBhpXEVOFijtAJQnxODxzOKMP9iKPS8MBBeU6hYMTyPvyGWdhYutlSkmBPYV56ftJKREbzWPcq3MYRG+A4JIMb5UDiSnUV/qhCCOxErjlHPRtH8QIwHTnQ12oMtO6LOV9O212UF6SCR5ONh3SZ0ka4AJp+u1wEKV5Mm3H5tt3055xY9NZAit+kZP3VeUwAdFcfOUrbv2Zr1QtrMUcjKZmoyg6InY6gy3/2Hno+iTcrPO5wHfJqUeUQS7vD/Sb3c9w97vc/pSQ1qcWPcOyvXWVmSCIVV+iHyAXX2fWhs+h5I4KN2sevPK/o2Nw+ePKVgLEF7cHygwdVXtzmAyfiHe15QUzM6YZvEMiMqCcpXbgEqrF+XW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(5660300002)(6666004)(6916009)(478600001)(316002)(2906002)(4326008)(8936002)(16526019)(86362001)(1076003)(66556008)(186003)(2616005)(66946007)(8676002)(36756003)(30864003)(66476007)(52116002)(83380400001)(6486002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cPZ8weIPur3uXdvmT0xGe7fwKGT3cUljPrGrtHjKWthL5s2OQQd+dsk6Ifmc?=
 =?us-ascii?Q?nRyNdZzngQNRXBRHkav46yxWs5bIe76yg+zLFPMFUtpbsiqNxIgJnYwMB42u?=
 =?us-ascii?Q?pZ9c7S072yvONBia2eOCfHLRhBe/jiuJDunqKaqhW5oFsJ8WnNkLJZJKJRkg?=
 =?us-ascii?Q?Cr6mMHJ3udAKZigZ55Gi8rHnQmyllA5IPBy0OlyWilHQj6cgM3Zd4XxbaADX?=
 =?us-ascii?Q?L8UeaJhwbG7tiO0gTMSPYyent/3xL5Tz2X34tlwQXN3kbxtADQohU2hz0VqL?=
 =?us-ascii?Q?4roDxIpnQcSeQ8QddI2FQNRvQ5tTXzLnzzZshhJ6qz3NZoDhVJTLCXLvsb1V?=
 =?us-ascii?Q?5/htww+27tVjPykDEEiaBL+Tj1kI86cGlvUqrz/XKrx5ozWTDGA+zVfkW3It?=
 =?us-ascii?Q?02oK/i/sZUzUH0czGr9Kf2WX10RdOie8OlsvElcZwR7N4f0LFUhdbuXeoiUM?=
 =?us-ascii?Q?jG/EK4C1snpAl6W9yZjm1mxbFpA5KVwb4yTX+b6tOgq8xQviQnFY08ewhnvd?=
 =?us-ascii?Q?dYj3shPbPERJk09K0bXPcrMZRMnhQrDhoc3F/w6Ig2BrWSXcNErF1Q00rhB6?=
 =?us-ascii?Q?UA3BOi5j3jL8Yv2EofpSw/Qh2HRXh8PWNUk+M5hslEWLuyTvetgN4dpkcVcE?=
 =?us-ascii?Q?dAUOTZxL2hPw8QrQCSPTaPKBP1ZjjrSCMbg6dT9PZZugeZraisgjhkNvEz7p?=
 =?us-ascii?Q?aedviW/t2oV714bNvSBxcQl28qGbuNEVGy4woO25V6p0P4cC5hXe9BjvXTIa?=
 =?us-ascii?Q?mjjuttvOTwrQU3GKgOvnpHorZFWRile8nflViQYW+G+mfAMXrsk7Zs/2dGBa?=
 =?us-ascii?Q?f6mG0RD5+Ypj9Zo1FViM2C0PRa+mcbu2xIqCp94imzJEzQSe93pv0JigSBQF?=
 =?us-ascii?Q?xSyKoVYpxAVzKUXE1km4C1ahgZ0azLJTuwJe61FVVRWjJVfYx1t/hd9vh+9R?=
 =?us-ascii?Q?wIDowLhyH9JHIAMC3yRhmgcu7t1Cz4hOUnw4yIfD58s690x77i7pCxMqXql4?=
 =?us-ascii?Q?+HsBkQX0B3Q+rDqqFsiD2Isv3tLjK5C/bAuFZ/X1TYkSewYWg6EfZBQeBNQ6?=
 =?us-ascii?Q?iu5GO7gEMZdNUqqALKaQlllEWH/1zPcKmEztuB2Tw5ck9nEMd5n4jmDvKA4d?=
 =?us-ascii?Q?spd1tMgiJGrexndTC4Ck+HcvuH4GSCPfhylNZHE8lj8PELEsvOMQMIWf9nIy?=
 =?us-ascii?Q?whvi/2mSkGwYiF+8sECuREexLrEo98cwjA/+MvLgUYsVQZLJfAc0kFKgzqEW?=
 =?us-ascii?Q?2eT6jwkWQAzUjb4yYSdFP/Sm0hOM1q9RXNXgCwcf0Ct2N95y1NBTbZT0UP/1?=
 =?us-ascii?Q?HlGkKGE0PHY/tuz5xE5W+RokJFelSmpDWq84ofooqils+N1TTtYtQm/BCfMz?=
 =?us-ascii?Q?ql/m1+kXwZSQoCuwp8LQGpLURhhf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdebbc51-fbb4-4c66-b157-08d8e6375808
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 15:47:45.1003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EBuBeVvXVczErvDYjxBl7aD8kzJZ8VD26cI2IFhNpQMwSAYcYA7F1NLRm8lJPslzAPHw/i1W2dafrj/cCfgsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Evan.Quan@amd.com,
 Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver doesn't keep the default bootup power limit and expose it
to user. As requested we add it in driver.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 53 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  8 ++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 11 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 79e309a789f3..dd695817c481 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -288,7 +288,8 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *max_limit,
+			bool default_limit);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2733af2d201b..240bfb05ce2d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2613,6 +2613,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit = limit_type << 24;
+	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
 
@@ -2629,8 +2630,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, &max_limit, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", max_limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2665,7 +2667,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2677,6 +2680,42 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	return size;
 }
 
+static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int limit_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit = limit_type << 24;
+	ssize_t size;
+	int r;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	if (is_support_sw_smu(adev)) {
+		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else {
+		size = snprintf(buf, PAGE_SIZE, "\n");
+	}
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return size;
+}
 static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -2919,11 +2958,13 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
+static SENSOR_DEVICE_ATTR(power2_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);
 static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0);
@@ -2963,11 +3004,13 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
+	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power1_label.dev_attr.attr,
 	&sensor_dev_attr_power2_average.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power2_cap.dev_attr.attr,
+	&sensor_dev_attr_power2_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power2_label.dev_attr.attr,
 	&sensor_dev_attr_freq1_input.dev_attr.attr,
 	&sensor_dev_attr_freq1_label.dev_attr.attr,
@@ -3066,7 +3109,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
+	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
 		return 0;
 
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
@@ -3132,6 +3176,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 5ac683fd0749..25d5f03aaa67 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -171,6 +171,7 @@ enum smu_ppt_limit_level
 {
 	SMU_PPT_LIMIT_MIN = -1,
 	SMU_PPT_LIMIT_CURRENT,
+	SMU_PPT_LIMIT_DEFAULT,
 	SMU_PPT_LIMIT_MAX,
 };
 
@@ -446,6 +447,7 @@ struct smu_context
 
 	bool od_enabled;
 	uint32_t current_power_limit;
+	uint32_t default_power_limit;
 	uint32_t max_power_limit;
 
 	/* soft pptable */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 907e0967a9e8..ad4db2edf1fb 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -141,6 +141,7 @@ struct smu_11_5_power_context {
 	enum smu_11_0_power_state power_state;
 
 	uint32_t	current_fast_ppt_limit;
+	uint32_t	default_fast_ppt_limit;
 	uint32_t	max_fast_ppt_limit;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index e0d288208220..ee6340c6f921 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1034,7 +1034,8 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	return 0;
 }
 
-static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
+static int pp_get_power_limit(void *handle, uint32_t *limit,
+		uint32_t *max_limit, bool default_limit)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
@@ -1045,9 +1046,12 @@ static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
 
 	if (default_limit) {
 		*limit = hwmgr->default_power_limit;
-		if (hwmgr->od_enabled) {
-			*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
-			*limit /= 100;
+		if (max_limit) {
+			*max_limit = *limit;
+			if (hwmgr->od_enabled) {
+				*max_limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
+				*max_limit /= 100;
+			}
 		}
 	}
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1202b9e7d0f9..e722adcf2f53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2183,6 +2183,9 @@ int smu_get_power_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*limit = smu->current_power_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*limit = smu->default_power_limit;
+			break;
 		case SMU_PPT_LIMIT_MAX:
 			*limit = smu->max_power_limit;
 			break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f82dd8a5c773..bbc03092b0a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1129,7 +1129,7 @@ static int arcturus_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 24195b5853fb..3d0de2c958fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2111,7 +2111,7 @@ static int navi10_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled &&
 	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 94a4ea38e5f9..3621884c3293 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1736,7 +1736,7 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d9f60dc714bc..c5b387360f01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1756,7 +1756,7 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	smu->current_power_limit = ppt_limit / 1000;
+	smu->current_power_limit = smu->default_power_limit = ppt_limit / 1000;
 	smu->max_power_limit = 29;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
@@ -1765,7 +1765,8 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	power_context->current_fast_ppt_limit = ppt_limit / 1000;
+	power_context->current_fast_ppt_limit =
+			power_context->default_fast_ppt_limit = ppt_limit / 1000;
 	power_context->max_fast_ppt_limit = 30;
 
 	return ret;
@@ -1790,6 +1791,9 @@ static int vangogh_get_ppt_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*ppt_limit = power_context->current_fast_ppt_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*ppt_limit = power_context->default_fast_ppt_limit;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..3c0d6231b891 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1088,7 +1088,7 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 		power_limit = pptable->PptLimit;
 	}
 
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 	if (pptable)
 		smu->max_power_limit = pptable->PptLimit;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
