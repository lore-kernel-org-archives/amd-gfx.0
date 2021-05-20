Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B594AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD2E61073
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD2E61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D6F6E83B;
	Thu, 20 May 2021 03:58:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81726E83B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APz82LKY/gXEMiGNVqUXtZbmR/b5OrpzkoNvYn1QFAXmG9lTtJ1S+jKwwYL7xJFVvoYAphsxoaalTqBiGKHOKuWKWfkR1JmbVXPtMNxUvlJtYaPDtTcY9sDHs9A1AaChdkxXV+SKR9Y8bkPl1CRrQxvHfE/9562CMvn90sRowoI+p/A1pIX+ZzXcH8ecSB+aAaXP+4ZvZ3CqhASZkPlxopyoPKihr/R2/d+JQH52Lw+QQxk6A1tx4/+/eqQidl2Jjow2CFuWA84Ch/tw5KUIgu4XHwBSCKCi1igJLbyDn4Eth4wl0FS4/yQv02xfey5sU8SJv4z7uFLkbYI42QVgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx8QUEXwutWkNeH2c2NPjY/nM7XRLKJQ62MFRiFMH5c=;
 b=jalCESclQqIvrGa8T3WtG6GkeBoF8BuhkmXhfj4bPyUPCgijDL0cIQuZ0Dhgs09q9W6zdKQ81uvgClap+EkJpc6dIXE7v79rGkvN4UpN1FG6uHeC4FvGlGcLEauorhRbDd5hfKiGKYToMqBFA4mHt0haCwb12rGt9Pf9WRUoKW8x0mAg8o3hWRwLRAOHarR+8C9Ek67Tgvie309ufYmpPQr0MMM7G8UqLmNMZDtNyf8bXYoKznIl/fUlVSXa3wEEkYSUHOqeif/kCqRCVcqo6GsHRyxDGaPx4b87K2qOePy+QC0Vq+zzqia4ggN1vbGSXB638yTv5fm7sK/7mwthYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx8QUEXwutWkNeH2c2NPjY/nM7XRLKJQ62MFRiFMH5c=;
 b=LlmjhKQz3HJruuJce1X+V7K2f4/13qPv8w+lgXMkDh2zOLH+9iHSQ4yPq+LvqwAuMixFLoJk4cE6MOqLypfLrlxqZTmgljdZkBBbzilfsMz15Y97DpKqQMOKuVtaV7RnIhdJST9Ud/nRiASLSxniXIEc5wDYHr+iAK7ONPTXH1Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 03:57:55 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:57:55 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] amdgpu/pm: simplify logic of smu_get_power_level
Date: Wed, 19 May 2021 23:57:19 -0400
Message-Id: <20210520035722.4877-3-darren.powell@amd.com>
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
 Transport; Thu, 20 May 2021 03:57:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0c6587-f076-4970-d435-08d91b43729d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1612FB1061AA2054DB4F0B12F02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiIFYxykOiq09xY79PrprFlewvchpM0mkj8KGpgoRTFIRmCH9TAzgqvm7C5Vgd6fuMxozVnMqwfbWYu5cns0A0AVPEXtiySK2avP1lhyClfgqOflF/Vaaff84VLibtTgvIz3WCp8gJRIa3l3xpIij3+AbqZbXUFz7m+mIYmbH2dNIVE8BfwXmyCs/kQoQz1OCw4gwt8L70qqK4K0ZZ/uUZi8yTvBgJvl2W9jWk7MZJhSucw1uT2AbIKbhu8rCwh2sF5X9qtb9UG2M+boy4J7VrUe72b8jeE3P7Q3qN8QiZJ3y7FnqPlqSapTuLycVTK/Gf5LOe3uqSN9+dGr//phA6J7mL0wXFdt2FKc2XAc6/h5oxLulSd+xGmpOKRtOdPse5qqa99Dz+pmNFvAj2i9EBZ8TTrUHcO4nE5M31EexuGjUrpKVo6G8LgmYEFmem8cY7PF8LMfOs3om27AhLEd1vanIPX1r1xwVMo5VG5GMPExs8wvELXoKCL2eb1isu1POZUndE4SiJrouid5BC0JYyzOoD8/hlADZg3wy/U+4iA83iN2Ho5cDRx43xkmvUGX836ldxDujNI4rNsWG7CMBas9iPmuvmNS7+dbWgY9SmPOJL/mMGwFT7Z2gJetJM4edjyiV0RDPXVcDimPVMQygQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wp4U9Q8Rfq3XL5W3qSaBIiwAF9kadF/OVQyUzg6NWOW7nzUGl8Wewwwb8+S+?=
 =?us-ascii?Q?q+5Hqe1nNJR09bFXxg6dLOlt2DBQjbhUXDQGf+sg5zh6idjjev2qCyI1jp3M?=
 =?us-ascii?Q?419HeTh+m066E0sHTa9dwbhMauuYWYqgE3Yyne58OU75kdI5AWZyjPWrMVwA?=
 =?us-ascii?Q?atJGXi+51L7aIX6KZFgJLE759mZSiD+4uTcFUKvtJjnJg4g54leYwNe5l7LU?=
 =?us-ascii?Q?tbDzOl5p064XwBjIxKUXk8ipo0lSE9RWAYqjIP57iGkxHMHGrJ15EbpZDNEk?=
 =?us-ascii?Q?N5JB5+bIMtJpOrVMSO1WRsZqSN7gBWy4gsbWP1o6S5qmZZjkm7sJX1XzkphK?=
 =?us-ascii?Q?2O24Ivh60bocwJeqaLY0IP0/1mK4evykTWGkBNYvC3j0izNrGele0Zn/czU9?=
 =?us-ascii?Q?CSrutfIHaNPheonSWOxtG8d2vqFaobQNmquEtLx7TpI6DpYi5ZS3YgCaxAk1?=
 =?us-ascii?Q?mtmSH9LWm7OdppqZ6DAed+Cm7aUICcbGizaSZ3TrM0eNS9bmrV/vsVGjfIRo?=
 =?us-ascii?Q?2Y+RbHHewj5RIJqfd3dyJdzbXgSiRvS7koWC6n2DulMVm8u+/AQzFLWAXSXV?=
 =?us-ascii?Q?nHK9e7X9nc5PNu7TN23tpFwd0p+TgioQRcm9XJq1WaieoY4kD6li6dcQ2bfm?=
 =?us-ascii?Q?ZYXZGSgzKllMAKbn3r86AmyV4rn2YA2J86zjLJq4UmOc8wH/iLtaUv5bLamT?=
 =?us-ascii?Q?K9pkD0/YUe7H1vz7Z2CjB3V/CgRiKRrW2/vNxBmmFU//aDjcFnu+zUTh9vLW?=
 =?us-ascii?Q?CwfW3odS8U55jQC+bMoZyYg6+VcJ2vqZHBqbvVSckTzNuFnowVK3zntaS8aS?=
 =?us-ascii?Q?jwIVqHmDsVjt3GS6L1ChYF3FamA9SQ7YMdwE6fEP7HxLUjURR6Rvcjv+Kng0?=
 =?us-ascii?Q?QkvQFXmlcDE1xkEgYj8J3EM60BAbXhSkhyinjCEaQinnxxjAC+oFBZzZB0vD?=
 =?us-ascii?Q?pV350BW8erMItK0UfoIQfOhqZUarE+FjUflCFLElFVdaKLSy3JDrv9SBBLD/?=
 =?us-ascii?Q?SQ/9B6JyzTnJPGa+D66PXBRLRD5pYai+zcWGC6xF3wyk1WKCpSxtODowVNhQ?=
 =?us-ascii?Q?ttPgfBbV+pziLreo7cJaOUPDMRC2Das1S5q9Mdr0k2+RqqWHOB1wMOO60i6C?=
 =?us-ascii?Q?GtiwLvzG09RGlcas+chwAiEW144Sbc8tUFRdw/a9IQ3q5OVkdPvccCnXq/wR?=
 =?us-ascii?Q?AUrFKnCe0P4BhDRP/NIyQxmeTcWUwEGWNrpioawtQp2dZcUff448kS6xo/P2?=
 =?us-ascii?Q?Yykmapj6Mo4twiEgFkaI8lDRP23xy6tzMOPX/KAaEtaQgZG3G1fKBD1mYAdA?=
 =?us-ascii?Q?AvT+8JZUDa3/B8MQDM3zIiwy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0c6587-f076-4970-d435-08d91b43729d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:55.1009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grvpDb0p8ozZB+8do7WyAixTSjYveq+BOrTpuvAwOWz6Bz+lrLmNUzxJb1XiZr6S5nG9JPByRtgENg/Yz4IwEQ==
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

 new powerplay enumeration pp_power_limit_level
 modify hwmon show_power functions to use pp_power_limit_level
 remove insertion of byte field into smu_get_power_level output arg "limit"
 modify smu_get_power_level to use pp_power_limit_level
 simplify logic of smu_get_power_level

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
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 11 +++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 ++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 47 ++++++++++++++-----
 4 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e2d13131a432..cf98b9afb362 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,17 @@ enum pp_df_cstate {
 	DF_CSTATE_ALLOW,
 };
 
+enum pp_power_limit_level
+{
+	PP_PWR_LIMIT_MIN = -1,
+	PP_PWR_LIMIT_CURRENT,
+	PP_PWR_LIMIT_DEFAULT,
+	PP_PWR_LIMIT_MAX,
+	PP_PWR_LIMIT_FAST_CURRENT,
+	PP_PWR_LIMIT_FAST_DEFAULT,
+	PP_PWR_LIMIT_FAST_MAX,
+};
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 13da377888d2..bd5af70ac739 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2718,7 +2718,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	uint32_t limit;
+	enum pp_power_limit_level limit_level;
 	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
@@ -2734,8 +2735,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
+	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_MAX : PP_PWR_LIMIT_MAX;
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+		smu_get_power_limit(&adev->smu, &limit, limit_level);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2758,7 +2760,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	uint32_t limit;
+	enum pp_power_limit_level limit_level;
 	ssize_t size;
 	int r;
 
@@ -2773,8 +2776,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
+	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_CURRENT : PP_PWR_LIMIT_CURRENT;
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
+		smu_get_power_limit(&adev->smu, &limit, limit_level);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2797,7 +2801,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	uint32_t limit;
+	enum pp_power_limit_level limit_level;
 	ssize_t size;
 	int r;
 
@@ -2812,8 +2817,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		return r;
 	}
 
+	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_DEFAULT : PP_PWR_LIMIT_DEFAULT;
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		smu_get_power_limit(&adev->smu, &limit, limit_level);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..6bdd112d64cb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,7 @@ enum smu_cmn2asic_mapping_type {
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level);
+			enum pp_power_limit_level limit_level);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..e192192e99d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,33 +2168,56 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level)
+			enum pp_power_limit_level pwr_limit_level)
 {
-	uint32_t limit_type = *limit >> 24;
-	int ret = 0;
+	enum smu_ppt_limit_level limit_level;
+	enum smu_ppt_limit_type limit_type;
+	int ret = -EOPNOTSUPP;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
-		if (smu->ppt_funcs->get_ppt_limit)
-			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
-	} else {
-		switch (limit_level) {
-		case SMU_PPT_LIMIT_CURRENT:
+	switch (pwr_limit_level) {
+		case PP_PWR_LIMIT_CURRENT:
 			*limit = smu->current_power_limit;
+			ret = 0;
 			break;
-		case SMU_PPT_LIMIT_DEFAULT:
+		case PP_PWR_LIMIT_DEFAULT:
 			*limit = smu->default_power_limit;
+			ret = 0;
 			break;
-		case SMU_PPT_LIMIT_MAX:
+		case PP_PWR_LIMIT_MAX:
 			*limit = smu->max_power_limit;
+			ret = 0;
+			break;
+		case PP_PWR_LIMIT_FAST_CURRENT:
+			if (smu->ppt_funcs->get_ppt_limit) {
+				limit_type = SMU_FAST_PPT_LIMIT;
+				limit_level = SMU_PPT_LIMIT_CURRENT;
+				ret = smu->ppt_funcs->get_ppt_limit(smu,
+					limit, limit_type, limit_level);
+			}
+			break;
+		case PP_PWR_LIMIT_FAST_DEFAULT:
+			if (smu->ppt_funcs->get_ppt_limit) {
+				limit_type = SMU_FAST_PPT_LIMIT;
+				limit_level = SMU_PPT_LIMIT_DEFAULT;
+				ret = smu->ppt_funcs->get_ppt_limit(smu,
+					limit, limit_type, limit_level);
+			}
+			break;
+		case PP_PWR_LIMIT_FAST_MAX:
+			if (smu->ppt_funcs->get_ppt_limit) {
+				limit_type = SMU_FAST_PPT_LIMIT;
+				limit_level = SMU_PPT_LIMIT_MAX;
+				ret = smu->ppt_funcs->get_ppt_limit(smu,
+					limit, limit_type, limit_level);
+			}
 			break;
 		default:
 			break;
-		}
 	}
 
 	mutex_unlock(&smu->mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
