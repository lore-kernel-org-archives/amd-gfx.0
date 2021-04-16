Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFAC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940A361166
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A361166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1826E0A1;
	Fri, 16 Apr 2021 06:46:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3307F6E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 06:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOzFRHsuUC2DVQW0vaYbRZeYitzzl0UNQOiZdq6XwMOcatjrc5mJUBaLo7fxhjtpe5k6h9j171Faiq+gTs8GQK0zw9k4L7oJ663as624ZxA7R1xgd6mpzjX+oXweaSvINjRvP4hbkIgYSpsWbGTMwPSDCwKX1HeczDolTKYJmHaHgaByvjl3ZHlDmaDgw8Fv82YaZi+mRwMVJKm6kTjZmqQaVXo7/EEXOZZ42WcFdpWBTHPCjUo9t0fDT8LVtc7xkTeojsGOWVXOdeyRabDo6If6XzS3ibBaVyTvbKxb4pNBscBr8//35+k8zt5S38NL/YqOs7/ni8l6zin0pYZSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75QcMnor5aukB02I8sffRITrOS9O4xrh19ek/QHfgNI=;
 b=hA78Wg/5jty3UzVOH4orVTwgDIk/jp/OoNkSVxd6EF0NNyBBzx08et0cnIs5UZ/OWuU+1k0VmqY3m2bMsxZX77cRUvnrSpsGUHoc4BSfPGOOt45Y7uoVVO8Nrqx8qiv6TmwvmPobp4wlo2UyB053Nke3yGvq60NOCnm0rrgTWmn4NwSIwM56JAMJUqz3WCDXdrRdvcC8rnxq+D+QgkA/f9wegp8AM6ejFPGuJtds0k/a/brmvj5XsF/dtleP63fSk7oHh7XxAAWUtnDqq7boWl0v4vqfaC2EpDzSvAa+fpst4jEJZpaeNsAhMyJmjLT0ENk4MlDaPHV9ztwwpAbCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75QcMnor5aukB02I8sffRITrOS9O4xrh19ek/QHfgNI=;
 b=eNTO4vTHgF6UAv+8kske7i2gnZrmb/5SiS6RIunn68FCfa8EfPDOehK7dKPoJuhtWtOotgvw7pf8Jg/hGFG2arCjruh+FJ/yUKeEGbagtEOia77552jaRnyvQSxKaME+DoKyM7Vvboh/sDWmZA5VK53KmyazGdbQ6MbAtdNLtlk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 06:46:36 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 06:46:35 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Dennis Li <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: correct default gfx wdt timeout setting
Date: Fri, 16 Apr 2021 14:46:09 +0800
Message-Id: <20210416064609.14167-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To BN9PR12MB5368.namprd12.prod.outlook.com
 (2603:10b6:408:105::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR04CA0044.apcprd04.prod.outlook.com (2603:1096:202:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 06:46:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf2558b-31fc-4174-3b18-08d900a3608c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51953CAFA0B629FB7AA4AEF1FC4C9@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn5zRzV2Ja9ChM0Yw85ioL0saxq/8IeJNXvwY0/GTcRBbqHxjQv63ezdCxxgO7KP3Zn+Vz2B5PtUmVMc5POlLuosJ1awMfRbyGim+b2d9EuOVP6acTmDn5A2kRJlEwjvNMHD2nh7LXIsyI3BUjcDmlOgao6snsEoBe76kPy6hUNGFkYIH23aIPyJahAh0RUgzkU5PDQJxSoYlXaoI4BfhgemM72XZrI2OJIa1QOdNsnu3A9ITN+jyO4raDLBnikTVkVe92B1saWDcKISuR70O4io5FdVgdp62Qbooq3SpZa+l4HWR/TJXKZ7hnBFjWKewLKOPKr7xygfksyUY4WggCEHxlvcHiyHpltbuP2j8EWGWgGVqIZBCrLtv0w5YvYK4LJ3C8O72VNqN8xgjjHFmwBsZFj3qDfsjw92ezb9jMXG83Vl7trFpP4mEhzqhe2GCxDLfKpnIECFOHhvVtoyAUp5mDoPHyUln5+XJtfC8JXcmA2vnNUFHWEcYodij8xMbb5ATPUXAA2tJnvk1sQZM8iRiLt6T1RgLgfxAlGTNa6xI6WxDranonlpA60Iuy85g0hXZdEW+EsFG23ivvbf/z8DUUyahYr9MA6tinUoiTSjL0fuCv36KSZmaMBrUEHXn14VSiyeCma3FKikM1hzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(478600001)(6486002)(52116002)(66476007)(956004)(1076003)(66556008)(37006003)(5660300002)(86362001)(7696005)(2616005)(8936002)(36756003)(6636002)(8676002)(316002)(6862004)(66946007)(16526019)(6666004)(38350700002)(186003)(2906002)(4326008)(26005)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fdNpC0bZMpJkIcLEZoI5/BQ9TK2hyoR4fZVTMEuSjl7sTKbXZI3f3gARsSKA?=
 =?us-ascii?Q?OzKxBdyuqlnEkLFXoWjmd+LGiXFzF11OIU2PyJpxrVN34ixkdEY49CVRxxMc?=
 =?us-ascii?Q?MNuR9inyX+wj2cvUfLvfC1U3Ypja46A1BBrs7hHI8QWc0Vx/KxYRrSY/eP0x?=
 =?us-ascii?Q?Biq869U4MjZmWkOoPt/jcQ+jETNypwh/vRNGpu90OD/q6gMGj07z1RaDu/Mz?=
 =?us-ascii?Q?iZIMDze1yBS2EcXfjOYG4i1FSnU/maS3DZ1ZUDO8aXb9shcXCRoGV+0GupWL?=
 =?us-ascii?Q?QV00xoJRxpqI95isZLGSrMHGsbxeKzQ6eLz+vnv4vzcubuUQBIdrDB+22Byp?=
 =?us-ascii?Q?l7e2hoOW4gQ4cfG5k6CP1gppaDrNG1zO1NQDw3nmT6eTQlvbpIL6E7yzby1a?=
 =?us-ascii?Q?wncaqb7799qrncjdftoghhgy6PiVAfShHUpken0MhUTzkmwE5Kh+XMRk6HTt?=
 =?us-ascii?Q?gCggl83sksbJVzBj7xBIZklCNiDlKfgCOSADGY3V0jFsW1T+vuD174H4T57F?=
 =?us-ascii?Q?7Z67AD420vgfzQ7wLsPRp+AuhkYKantphELGHZ4NDjZoPYScTt6MCnMJ8nXN?=
 =?us-ascii?Q?HWmiUO7oGkCx9LiDK8iH/7bItxSFQiHWhNyTWafNhEVMpraliqx5qArr/tQr?=
 =?us-ascii?Q?aSeVdpdKA/htNyLgpPeqVhLwAJf+ITXhh0CtGqrcv2jrXyE56dsO6++qVGVk?=
 =?us-ascii?Q?tT6Q1QCr7SYTlXZghKKHOAQcj1E5ZdK6zZmOGAUFPQPUFkyFJ6/XTaUYZNhf?=
 =?us-ascii?Q?CNe4dK1tiP8Wm6XaehbPV7Jv0/T0PfCiLprhBA/zIQE2zirbyRBehApD36wY?=
 =?us-ascii?Q?Z0OH/J0gbOJzSoEFEXM+DTn/BK+s4BsXo9fVwTTJ6iW+mYaPqz7lTH4VkqDO?=
 =?us-ascii?Q?G+YJFlQ4pTAFqYkP8RUirEPbI9mG8QDDu2X8l6UQ0fjXolr37pXSSuxWV308?=
 =?us-ascii?Q?0Xc4jmbljRIi+hNepQXziwymT/xBVcOTAK37zfvvtW5x2YpmNYoMjh4sWH6+?=
 =?us-ascii?Q?1zHglYTefaPvAKUFrnvnla48cpN0ilzjoOWnw6YbFehnSxcJizpslemxRyuk?=
 =?us-ascii?Q?DlcXyW8wVBlu/Eu9LdFbjqlMt13E0LJagsf6pxPhqRhoj3EonZojn+PXmRqc?=
 =?us-ascii?Q?Rzp8rMn8yLauxQBdmpJyHiA8TEqf746sP/rMuUygQDX22vu3Dd4c8kSG5WjU?=
 =?us-ascii?Q?WHr2I2TlT+I+RMoIWB4cPfecGrPQoJVLdutYzTuVReuSRmRkcqcP8+x1roKJ?=
 =?us-ascii?Q?fK50YLa0CdG/4K/0Wu0sseMGSC9+SJ1g8FC7BraU2H7449/pRd+xSFXQdIGS?=
 =?us-ascii?Q?jHuPPN0+T5Pk4ZTjIlo0Lr+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf2558b-31fc-4174-3b18-08d900a3608c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 06:46:35.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOqaC+TG0fOr6bAIU/WjEXKZJUnCEZzZeUqPFZ9gRUt/OVaZXlx8CKz4F4ETKrUxdlIxQIhOqLG0MwcORIUiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When gfx wdt was configured to fatal_disable, the
timeout period should be configured to 0x0 (timeout
disabled)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f856a2e82f94..7d9b954bc0c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -189,7 +189,7 @@ uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = -1;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
-	.period = 0x23, /* default to max. timeout = 1 << 0x23 cycles */
+	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
 
 /**
@@ -566,7 +566,7 @@ module_param_named(timeout_fatal_disable, amdgpu_watchdog_timer.timeout_fatal_di
  * DOC: timeout_period (uint)
  * Modify the watchdog timeout max_cycles as (1 << period)
  */
-MODULE_PARM_DESC(timeout_period, "watchdog timeout period (1 to 0x23(default), timeout maxCycles = (1 << period)");
+MODULE_PARM_DESC(timeout_period, "watchdog timeout period (0 = timeout disabled, 1 ~ 0x23 = timeout maxcycles = (1 << period)");
 module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
