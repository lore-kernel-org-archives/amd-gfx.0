Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4FC43460
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09349613BE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09349613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CA96EB97;
	Tue,  4 May 2021 21:48:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7C76EB97
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 21:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzUgsLjYtcZJ3j2McBxAILpaYjZ6QK8zxMLZMwwIJ6AjUnz2iWN/BkJ3H9Cn4TE/R3OmqN0X13W2dIb7ygs/MGWcjp8WT+3n9RCyrRwwRGUuJ5cf/eCT48QJGKJbYpQ+EmU8H+RLyAiHUl4mWGINg2rqTGIvSj7EIRnCoI9JIZWTnLF186sZ8BBg7UhgLxdRdzFuvEU9rBqICmQbbIkKnk9kfLjchZlQ6dLakc3i6Ih30AIgAOIkeJ37OElrS9y/UumSmyzKAboW68esqHOQbWJDPExcQiB44TeWEy/BauYf4j38MsJ2XvN6kkSiDKjV6CF6Q8agnwKfHrZtxm3czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wImF33z/FEOrN39RGQk3tnTnWc8Z15rDHKXFJd2xLYA=;
 b=PKpkS2dkQRVLJrohAUrR1KZo/w+hso+UUzBwI79OWvX98SWaYzbNiPXTMM1pvE6q8t/ZblCIAQDdMpwbyI6zxT0aToM5GKGZdWY+TuQm5rvoIj/xUCRhMHi5LB58VHelxsYFGLzdInGG5D54a5QZmBpEffNlxGX4ja5bT58ZFn/9W7J1DqlkNKqiQHf//N+Vu4Z4zw9iNHfbmgDbjA6+HQH1JyW4fG4KslUWwT4TC9ovC6qDRL0nVnURVewXZd+F4Mn6VtKgbH2JMZu9QXjoRoK6jltN/HayYC3qlyfRJcJWOjp7cbq4tlOs5wTSyxwgroLJqHZAH5Uz/ft0CKUIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wImF33z/FEOrN39RGQk3tnTnWc8Z15rDHKXFJd2xLYA=;
 b=SxYcKgbK/Uo2wBx8kgu668Rnu5Lc1Yv3+twUSU1IJz9OXUoGeH2PIBgEq8750YLb8dr3M3kvUAzBT+CCLNiqgm31d1qgB33kWltZIG3r25HQLbYlA6zQREQgvoy4Rdz3rR5qJ7zVTTjyhqtbxAZ+bYS8pAf7lyI9JxTjosIF7Zs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 4 May
 2021 21:48:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 21:48:23 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Export ras_*_enabled to debugfs
Date: Tue,  4 May 2021 17:47:56 -0400
Message-Id: <20210504214756.3816-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210504214756.3816-1-luben.tuikov@amd.com>
References: <20210504214756.3816-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Tue, 4 May 2021 21:48:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4058128d-3840-4abc-0c52-08d90f4656cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18676DA09E5DFEC4A23DD0C6995A9@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2JlAVfEUcdNLL3ddJjV7e3G42SZoqdatKZcyxFtT3LhNp1/nEcYUoEutlbWsi7PgAQqcFjXJ/oQEdJ4P5XL3T7v5cdoLMLrzrFAGxWObJVw5c5urOLOEBTOeLjQTJK77sqHsLcw+980miFXr2+GNb4LZxsqi1jxgQhefurtxsvis/ipvo/K46LGuMqkPs7lQ7Hii/wLctAHtRv86OmDuKe0tACHbnKcvp5HJegswtRDa7A5tiofJ6lFIejcGQYfxW0xa0Ms/jdG5agMHcHKP0SaXsWDlL28GVVq9rYe24K6T25mNcJbg1fluY8C/FuDhxQAgyD3NTmYZSjYthY6qde6ZLDASDG4jPkxaRCZVv/+3+WlWYO2nXvBwnV+LCxkqDBeemM+iOf1I5JtsSshYrtfBZTHzhvLKpmrCLmbF1CBoYMEI8SMaO6fmBsDxnrd8Vfxfv70G8YyEWmaTfJqs2quyiXXS3IR5WNlef7DiiFJRy54sMChwcDvOvgDHJj5jLJRn+IkE7401UbOcNpl/JOAl7Q2YoSHic1C5c0OOWxjKepQ1AS6L2RGnwYJitoniVSaIX0JzQHACpANebm8K9tUJMeYqi3ORA4NGYKyIDIeMBhJkiFAFmMZH7c3LgKODTBMw1HekqwXPM7UEiZGJIrgMzbv6n4NjoQIFNGTaI5EH+JNcG8Xt0FoWRk1D0vd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(26005)(5660300002)(86362001)(54906003)(316002)(2906002)(16526019)(478600001)(6666004)(38100700002)(44832011)(36756003)(6916009)(1076003)(8676002)(2616005)(4326008)(6512007)(186003)(66476007)(66556008)(83380400001)(66946007)(52116002)(956004)(6506007)(55236004)(8936002)(6486002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qfn9JRMOXeVDohzswZDJF3uzpkWJDtZcgkdEiQ6HPTKdaCqEsf349zzIztQR?=
 =?us-ascii?Q?f/3NIjMWG+cPeBbxic5ewwBhNfJc12E7GiHuYPuSf0N8F2eufxQoxl3tAmHq?=
 =?us-ascii?Q?kQW10OK+zr7CnRfvTfQxsQ7wIDbffvtViZbBo5Zx9wu+q+D4yKnQOdXkGMY0?=
 =?us-ascii?Q?SW1p4qtAG7XTPB9bke+8H7Qtp770GLPnuHGXIbC5abWLKMbBw2p8OUttkL9k?=
 =?us-ascii?Q?3nabiED+Z77AmNHQpSe39u+6vi/6p9/K1J6wgHQw7JCIZD2MzM0U/RkzNeYD?=
 =?us-ascii?Q?UVm237Mwj08cc3R4SgZemXm7TdJiu7xBQBFYnyuJrHzHP2va8QearG+VPeF+?=
 =?us-ascii?Q?0TqthLtEK1IV+ZEfYa5IGLEMIgoa5RLuI+LdVUpTy12taLej6ty0KHKkOo5j?=
 =?us-ascii?Q?21UjBhRS1YWWkXxZDyPjbWTVk9JyqEOn/uzrGWDNXFy/ppx/3F1kavPx1om+?=
 =?us-ascii?Q?8eqKRp+XOST/lYl4LivhPcVoTEC3JLq1A0Gjo7BaBxE+7JdEHwgxeVjevQnc?=
 =?us-ascii?Q?KVdOlM8env+9BnEnBEdlpW4bZHv9kTZhr5XtCy06cSDVquFKIFYTkema857l?=
 =?us-ascii?Q?HBv0oHZphLDuNBqCPSSf8c45HhnZ9V4V6aMd2uWa43KgFjpCdTxYCD7ZRD8E?=
 =?us-ascii?Q?LjeMejc0AVvT0cAA636pzV3qIvdGHBntG2q4Kr5S0SQumvA2q0NGSMHFa0TT?=
 =?us-ascii?Q?Zan3LnXupTLKXnFHJ4jsDLjDC3eVwkWu8Gg6YtLfdMNRE+shkhDyKdAregMg?=
 =?us-ascii?Q?tC49OXvZhpYPTaaHGUpScyIy89N+OLQrGCiHiN++gWNQ2lEDtpyHRaRd/jmU?=
 =?us-ascii?Q?3OKwXddrm/ugzDvkkF2zMWOeVelAuQyjWUR5V04+K1FcL22Fm+admerHiXQn?=
 =?us-ascii?Q?zeCZKmJRImMGnLkmkVOlWGkFA+ov8LhH9mSSTvi3gbG0pWN/3GrYjQSrt25Y?=
 =?us-ascii?Q?5qvYiaL8Z2hyRMhHEV0ZXvuBpZfVIa1QN8tpkWbEnvEQbDk08/xIhtVqOKBa?=
 =?us-ascii?Q?UN1J+lO2nZdzNPk1/u3kWJD7FyxZv7a/Le0T5KnPrtmVUU9QMTzmHQ6OG5wa?=
 =?us-ascii?Q?Pdlsc3MO4i6HrWzZKcyXgzeiB/+x2+8/7Xyawi1Aw8PsjQW+BSgSdn+eOF9h?=
 =?us-ascii?Q?uh8g9i3JdYvPyD7pP81lcVeGpEWpNMkUtH8Pp5NWry0dv5bboYh+9LgZG0nu?=
 =?us-ascii?Q?ysRIef7onUweAmC7J4OPREfe2gKJYcSH894wiMJBONka1d7MZLO/Rer9zoGP?=
 =?us-ascii?Q?D8Wdb+nBpP2BLMSnK1BuWP73HyeiQvl0YD4sccD8UsJ0Pef8UVqeL9cIyzfI?=
 =?us-ascii?Q?wbrQdiEjyvSFgzalV/sgpRR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4058128d-3840-4abc-0c52-08d90f4656cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:48:23.0719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNshVD1dfyuvsq2GUDamJb/YMj/wAUGiOgUtJzEoiKkGwfBNdyls4tU0taNt94mY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Export the runtime-set "ras_hw_enabled" and
"ras_enabled" to debugfs, for debugging.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 737f9d5371d1..293a74e8bdce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1299,8 +1299,8 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
 static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct dentry *dir;
-	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct drm_minor  *minor = adev_to_drm(adev)->primary;
+	struct dentry     *dir;
 
 	dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
 	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, dir, adev,
@@ -1309,6 +1309,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			    &amdgpu_ras_debugfs_eeprom_ops);
 	debugfs_create_u32("bad_page_cnt_threshold", 0444, dir,
 			   &con->bad_page_cnt_threshold);
+	debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
+	debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
