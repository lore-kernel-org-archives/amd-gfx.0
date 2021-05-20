Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84B0C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6821B61073
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6821B61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE906EE9C;
	Thu, 20 May 2021 03:58:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAD56E8F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZZEmerPplBBAoj++lCy0FfmzX7/Woe314F/Z/G7hsRS8aosqHwgvgtNh4HEZCVLxf/y0qRMa74oS8hCsSFApb9eGAHm+yVIiqjavW2y0omrmCSPzpe29qE7wHlwWaHurXhOrbKy80rvjwOUEHAV1aN6/XwB+68hcAq7vSs8+CPqYOJC4VWn8LXS4Vaw/H4rSkp42OIJUw23r9Q6/o/3KncOBqKjLjCB29kdmiOODSCLMeOvekY0CLKtE+IBSc5//mtHq+/ryaeWl9L75E+Tlakt6FG4lAQ7s+moY5Hgjsnyv9w+DV7oM1Hm1qStm83y3qLF+euy7JFwbZbdowgg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1Kcweq+B8v80gdzEy/jbydhNcsWig8147g0as/vdyM=;
 b=jvUmgRae0wwnaZlVuZLKg4Qvk4VinvCXVshUpUE2xpy1qmnZ/wkM15QNKgqCyM5owShjlgdsG8WwBWnPxSZt17piTuNcOSz4QvjH+ZznSRxuiKvj4NKkjPiiswD7wjlw1P8mDwTLyBxMvkkgblAm6tqPdKkJPQ0hfks+HCIkY3X3h330UAafrXecN9v7TPyJzy8Xf5ezAeKsA7OrxO/u4XxxH/l3AiIH8KEnJDjiF/f5hZox2zLLpJLC6JtGH8X14n8yA8FajRsI3O15ontHJf1O7E6u7cAvBaSo5B12YYDtcCrFH755m1rU3dUaspW1O/RTvyRjuuAaHKF+EmAQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1Kcweq+B8v80gdzEy/jbydhNcsWig8147g0as/vdyM=;
 b=MqMwGqvmRdPSDXAORziYKhutWmebEGgWddnHinY67mq9yi/mwgF0elJBm2wperUt+toIO9EzSmdYhmlxvf8n21kNz3WFtIFqOoxlWor+sSeZf1V8Dwsvx59zXLM3zPoZTAXiUrtdWWmOQcJQTV9rQtlhT+DWRD8ejcpwpa5X/9w=
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
Subject: [PATCH 3/5] amdgpu/pm: modify Powerplay API get_power_limit to use
 pp_power_limit_level
Date: Wed, 19 May 2021 23:57:20 -0400
Message-Id: <20210520035722.4877-4-darren.powell@amd.com>
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
 Transport; Thu, 20 May 2021 03:57:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1a80d5-88e4-4263-f25e-08d91b43731b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1612E85A67D55FB900066427F02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcvwxkKdm9gHfr6r+EzrMB3ViznxCEDTu5ERluBkIjMB8tzPPnu45RN/ZLYspVp0dFQiHTV1e4ZcmsugEoJTO8fOc3zMltRCkj6Aip9wVYI/a6TF0q/UC/G/Iig6dRdgIL9Xo0Uq3yDj34hsUvFyhJSMzLBLXJ93csZEIbLhwb+twu5+QPK4/n6lyyvSzNbzs0MghNPqwhxwihHUhFiqCBEf+yypx42JpGZrzfie5xemLmqC6q17Iiu0jSwNkEf0OhudfYaXL9OBf/UwbnGMfDl0rrn0whCaBUmPcD+fCB4O/TyAG4nADqwkChfWz7Ku0Uky9zKgAybMbMS20d3ezcOB9F/T4nMYCsAS7mzRYk/ZeXWlZ0rK27H8xJbyQiip+BxSA88W1uY65WZFYp4G9GbWg5L3hHM0mxTtdHZSB1ReU+GnkSaTZrbHmFKZau3RlUH3LfJX1zOQnCn+zvrDbjBvVtRWPa8W/+qt6/eFNMC13IwxdrGgiJS6bONRwUPOGrYby6ULleT3X0/rnsZQcH6YgcrX5O81DFq6EhKQTZ2QV+Gy6TVULj1zC9jBcaShEjcs0Mf+Si58esSYzXRSe5A4GsPvN+5CJYUizuTtZxoPZBlzbAAn4cGsm6AUoB/LZgxFFI/Zjw2wQGCF9srofKcSl7e3Ip8bvGhlbkC3tJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/P7hCszapoVx8Y8m984ah3UUVxc0W7Lsz8cJuqchS5euO4p44AfEHMxTQf2c?=
 =?us-ascii?Q?YVavsFbGiCgXELXCr5r6/+7jg8EzWI/oDcuYpQrRzGNKC5ougy8xZpM+NhcS?=
 =?us-ascii?Q?37UkNcUbTJCZrnhlGMzwKX+dLGVtTJfvZU5f56tBlQW0i6Q4k01YjIpObaPm?=
 =?us-ascii?Q?CtQVdhzQHwTpH3nC/yeLKgPeBE1JhauYL8sLnRlDZ9cgARrmmivMT36iHIMA?=
 =?us-ascii?Q?JACVkmxD+j6ZuqqKDg4qVwyT+xh06HYFywhyIlA0hJDb7iojhz7s0m1kz5MH?=
 =?us-ascii?Q?wqX26AHA0NsL/mYGo4lZSW8UIjaQpHhCSuOOi7mZU9xrLWyId/ZJLKeIAgmk?=
 =?us-ascii?Q?zc5p53XS1y7keCkEodhUbeGhKWizAyiGSQ5o1pFgEJLh6XYdEiJ8l67AuvUd?=
 =?us-ascii?Q?sicRZIgm3AofwlaHn5BcQnkirMC3oyzbNofCt9qtVI+joxgUQfUfKR+UOF3G?=
 =?us-ascii?Q?bfoKFBm1qsGjs1C0Ogek/LyBUdQArlcWNtoRZ+rBLQ7gpPf8uygOkpbJcH5X?=
 =?us-ascii?Q?zqQKkFmof/5RiuBqy5auE1GHZT/jRZthnyBMzCvvBeSNPJ2OzxSu+cImNK2O?=
 =?us-ascii?Q?Tu5HjHoJUhaMQGP6r4GKBsksUQGHX81haljNXH/jJ5r0lgxTs63+Bu0C7TXx?=
 =?us-ascii?Q?nXm0SSKFq/j6Vj3HckQcFAfqJxSX0iWM0sa3a3KaER/R0mZsfWYAoU8vSO6r?=
 =?us-ascii?Q?5c167vCYJJYkY6bY2dOItXFoF8XRDHK+dA+FDoKYlXho4a46U9yma/GVQCIc?=
 =?us-ascii?Q?pNSU6zeeaFls6V2K/kR4Rmnu2ehFM8GkKvYXBxR9ifPY1ygIDUGlAh2Pnkzg?=
 =?us-ascii?Q?/eYTsS58rE3CrgtKsureerQI0j5mlmOx3bQf0kYz8pmsYKp3XtKMYd6ucm66?=
 =?us-ascii?Q?ZqneqMElEz1tQjzf77YAYLUdGw0BOLw84OpPpBTbJOWmJSQ1hTlCq4SpqhEp?=
 =?us-ascii?Q?B3eaLhQvAj9QUIILyb6at7CrLQHRPnVrZ8gqUiaOWR2jcdBs+Nn9eqI0f2l4?=
 =?us-ascii?Q?DWR2kFmxQrOYxQGUJL2YunsEDcgJ35iCBFV2Sd+XKqPoSPDWMVOSzhx0r8dG?=
 =?us-ascii?Q?r7XX209cfbEm0EVPBC2yWkAY9KaPwnrGyqRKdikPpafOL8gA8pYCWLUSL/MW?=
 =?us-ascii?Q?OefKYCLrW1NtOEftgOUCsqBKhg3KmdSFaycAGXJwLGIps2+95UKNweAjKJIP?=
 =?us-ascii?Q?9fi8pKpE5LwRbLJT3QljR2ziaI5I3pY/qj/IjsUJng/iXO2eqSm4CZZixNWC?=
 =?us-ascii?Q?KEjeCLnR1MtbgCTJrJvHQx/TPjLBXF18o2e78P/jEoIVGREjUjBTglJA9IOY?=
 =?us-ascii?Q?6elsBU/n3Qa+lBmhdPr0EqRC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a80d5-88e4-4263-f25e-08d91b43731b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:55.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsqQlDxgkEUAp7MrbIbJNkoNpFnZkYG/H6NytH9bBM22P5+iAdAnrkrr9Tet4z132kXDDOqw2S1dC9MYiMI+8A==
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

 modify Powerplay API get_power_limit to use pp_power_limit_level
 update Powerplay API get_power_limit calls to use pp_power_limit_level
 modify pp_get_power_limit to use new Powerplay API
 add new error return to pp_get_power_limit for unhandled pp_power_limit_level

* Test (non smu)
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  9 +++---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 29 ++++++++++++-------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index cf98b9afb362..606c89eb206f 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -302,8 +302,8 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *max_limit,
-			bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit,
+			       enum pp_power_limit_level pwr_limit_level);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bd5af70ac739..6130318dd993 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2720,7 +2720,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit;
 	enum pp_power_limit_level limit_level;
-	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
 
@@ -2741,8 +2740,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, &max_limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", max_limit * 1000000);
+				&limit, PP_PWR_LIMIT_MAX);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2782,7 +2781,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, false);
+				&limit, PP_PWR_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2823,7 +2822,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, true);
+				&limit, PP_PWR_LIMIT_DEFAULT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index c73504e998e5..833e2d3f8f41 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1035,31 +1035,38 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 }
 
 static int pp_get_power_limit(void *handle, uint32_t *limit,
-		uint32_t *max_limit, bool default_limit)
+			      enum pp_power_limit_level pwr_limit_level)
 {
 	struct pp_hwmgr *hwmgr = handle;
+	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!limit)
 		return -EINVAL;
 
 	mutex_lock(&hwmgr->smu_lock);
 
-	if (default_limit) {
-		*limit = hwmgr->default_power_limit;
-		if (max_limit) {
-			*max_limit = *limit;
+	switch (pwr_limit_level) {
+		case PP_PWR_LIMIT_CURRENT:
+			*limit = hwmgr->power_limit;
+			break;
+		case PP_PWR_LIMIT_DEFAULT:
+			*limit = hwmgr->default_power_limit;
+			break;
+		case PP_PWR_LIMIT_MAX:
+			*limit = hwmgr->default_power_limit;
 			if (hwmgr->od_enabled) {
-				*max_limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
-				*max_limit /= 100;
+				*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
+				*limit /= 100;
 			}
-		}
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
 	}
-	else
-		*limit = hwmgr->power_limit;
 
 	mutex_unlock(&hwmgr->smu_lock);
 
-	return 0;
+	return ret;
 }
 
 static int pp_display_configuration_change(void *handle,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
