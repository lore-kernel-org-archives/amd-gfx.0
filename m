Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D1C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE7110E02E;
	Wed, 29 Jul 2026 09:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8hLshGh";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E99510E02E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 09:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLopS3fP0IOqIIEdFlyvdyo2BmT+2Kswl73YAY2eY9g9fLIiC5RHJ/BXCdbmLHsOSPryPV3xHofzTGHHG/pKEi2intXK9MmGvQorhWmsteFmsQwa23cY3HbgRjsQpehfCENVCKMQnsiOvYC2eFO4R+SC8l+MmsoDm+M9nmjSZ2i9v5g2d/gbbLzvjuViM8mekQyjpFZxQPxosoB1IVpK44e6brsWyryCJOwj9VkmMleaDt/W+JFeBm4xF5IN6FSJhY/5jEhMyARyETQbxii8BQyV0VV5FAVbBfIDKzXgnOskGpu45cFUpvhsWgO2SlcYhSmzdF/dJm3BZI+xBWy+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3sxb3e0XpSmDdZwr/TNXsU1myoZSxGvgG7Q+zOTGDo=;
 b=NCjl0N2FXvwxMTn2FKOnSZRqMHS1gF1Vj2J9hYa//GFQ7k45fpkcrvp3HRvzI5Byx493HWLK7jjACI3OEqzb3auCVonzYwEOSM1Z1d3jqvWLXw0GzMqMAhfemtisYX3hHtc0bKceVJmVA4ffQoN8JAcqbqx/ScBnX6WOmbBIQvcSX+VfjVtBD+z9X6Ee88nSGY372czt/rwxlHzuVcQfHytINCBZ7s7x9QtYgrKTcclSmWGRXAj9eVYB1t8l9E7GP5UhZuYDygLaQ3ZM6XnjDkcLSJAFkznQHY5jyyktq2YfJDMqrMiLQKa8jTPWF+/ECgvVVYsEiF761f7Ys0mh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3sxb3e0XpSmDdZwr/TNXsU1myoZSxGvgG7Q+zOTGDo=;
 b=U8hLshGhV2UHAqHpeHOkiwPfKTVmqwJldVPKABlN2/3JyaQS0QntVgPScLvuBUs0oa02hd/gAkuUGeCNO522Hr0C+tz+5W8KstYDVJ4s92HMlTEFevGQZyPLbos7x2QlEpu4+RAJCF0NMXq311/UxUgVTWaKzdRhhXlAOx3ms2o=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:59:43 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:59:42 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs
Thread-Topic: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs
Thread-Index: AQHdHzSxgS2B2OpX4kGE/HKLVSNiKraEQ0Iw
Date: Wed, 29 Jul 2026 09:59:42 +0000
Message-ID: <MW4PR12MB68033E5AC6B7E0B151310CA98ECA2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260729083118.3658560-1-kevinyang.wang@amd.com>
In-Reply-To: <20260729083118.3658560-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T09:58:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SJ0PR12MB6928:EE_
x-ms-office365-filtering-correlation-id: 1180cddc-947c-4a11-5b47-08deed581cc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 2IEJjwBW4EjVCbJ5BpHCitMpZvvztuJ944ZLe3YuboH9EqfgmosEvFybZ0zj2aHN1GJl9n/bl7RXiP+zTXaP4l0UZT8ThdL5LLBxd/beLF5qondm77FWE+icZQKyctG4QcK3LxxWglyTCTapcCM21Qp8NIzl2cjwvQZMVhdInSPExxLLfGbEhqhZbArK6tzj/0T1upcaHDzENOp9cl2g+WClym1IJuET7dmkFNrB2eivCFuWxXCC10XkRGIF1tj/8AD/ZYFkgJHGPG5A6GFwhRFX9cd74NXiQob6jjzdwdn6HAHBkg0qHaq7jKOpgd24QVvOWIb/Lp5b7EZNnjj3BX+P5+vw2cHNxVP3eZ9MiHKTuf2Zxj/w4vPfzreDiJS3pnBz23IUxEwaTnOSaPION9m1b+KGrOeqmmxYt7X1NZFkbh9+tB+OqTJxztqVklebhk0EPn+gnIyD7MPK8M0VREfjfp/caydy35oufOQNZnrifSP9Wuawi9E4//5T5IqAiYaTV3yWyxo0rFhsmL/P9z1+O1rwjYrO/eKjQG19IsQA4lOOEldKd47BtMSRy+HPK9HYqbVbsBptMClcyGHBYRUw3hLPJxYqcaNnn9RuyiALpQLlDVebdHvynLg4iryVzxx3tXem9aacHmdRuYwoANin6dLO8LMMHuZdVUN3SpeQO1IU8shrMYupSmwBmkAsUAivIX5PPVVbgqnqKq31jAk6z41+xC0P97CIYMTV5Qw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zfCkIGvoSLIDce9MhAynlQzvz6cRfmakZc6pIwxcjLLz4+voNBbmR4Bff6d?=
 =?us-ascii?Q?Ysj0YkyERB41MXM/TTiBITMdFcWtHgDqQMHKBq957y3j/uspORdO1JZspNNx?=
 =?us-ascii?Q?kwGAc6bp3E8TFgXMmsdWSEbJbzVnPvMWEpz4nOymteqRpS/7Aw/VHEmj90GU?=
 =?us-ascii?Q?JYf884EYyLPlTOGknUOSkYbIwuCFngWkqD8dfgWGxohxElFJqszEnX4Pl0MR?=
 =?us-ascii?Q?B71iI67HeNM671fBCMv8t/QESwpfaQHREh8x4gFG8VPoViKbto5dxmAuDpOo?=
 =?us-ascii?Q?KzZrxLN7XxzhPyBLnVKrV5LVyDZSIpdI2jtKUMFeCv9VVNeGnVlpbzwaeB3I?=
 =?us-ascii?Q?KJgUsP7lhAwzoaGuka+KXkBLtzOAZYXdzUMiXdgoAh8X4Qbt1SqAUTa8/8FG?=
 =?us-ascii?Q?FTIDg7EX0GR0BR5JHZnEVxG1kXxMPxxrXcvHvEcGB9FIyUUigf30X5ks8sO+?=
 =?us-ascii?Q?esex7ABhebHaflA2QuzdjP1oMNLJT0QN5eGABDRtlslo1WJlfa0VpshuZTJa?=
 =?us-ascii?Q?BpqjD9AwGscyPBzMy/gKl5ul7Xq3xSNFV7yagUsp3MbNmoJd1+qonDxZP3j9?=
 =?us-ascii?Q?hbkIm0eT5xHigGdXmzhSgXGfu+ZINN4XvuBCHgrST0Z1k15TCHGtjYo95x1q?=
 =?us-ascii?Q?BDTl9LXDDdJ1y0Xe4DHMndfBZAmVNXA5JhPIgH62xoJduWhu7x9+dPAtd8kE?=
 =?us-ascii?Q?ZwkW0NIkdNhqEu3NyRbwc9ce2hEEECiSKgblzdVhxf9Vvnnj64FRdE1cHHct?=
 =?us-ascii?Q?uZI8HCZiAZMcY1+aNp3nIBmMp82SLSGpROqvaWo+Hw+GUJCdP3mRXZ0dx6fO?=
 =?us-ascii?Q?di/TPoGSHlHQTugsagk3FgOOftjjlchqtqitpRAa0z2J5CP/cMUC5NMRVWvL?=
 =?us-ascii?Q?Dx4Z3XwFJwIpTGzDZw9VxjQF+IcoA93L1XL81JcudUz0gkAYziHroULRZYsX?=
 =?us-ascii?Q?z7lM6zEqlUMdPnhw8YgaLQlCn3gpV0uchvacXkxnAyJS2GhFi2jTWrxwxSjE?=
 =?us-ascii?Q?ad0S5LSkZokYhOnyHhg7Bz0AHW4+SxXUiP1g81n+qyHeEI1vbRe82e2SjwCP?=
 =?us-ascii?Q?egQBW7c+qTMFWmkdPQhL3C8PNuYLe25I0Wc/PGf4zsn6AWKYX5CWbtemABgw?=
 =?us-ascii?Q?zq3XIWOPvLXjF9OFgIOx2PgvOLcU2Ftj+LimjA+pWLWMmQNumOfucNcS+Q9P?=
 =?us-ascii?Q?ZVNVrhtpwDJW6VJG7JtcyGGdvtU6fKC1uwyOgOHunCvoF/4nBEIF2+txFmtB?=
 =?us-ascii?Q?ubqHH2k3NiFTb6sf9gsZntLFahnbO0xpp9hLB1lUuItX5PQHMBm/HsPx9B7m?=
 =?us-ascii?Q?1eHkOsSL0n/dTMgWNEIRtBZPAhi5wrZlWDnDXUriffUyBabBSrdLOxb4wqh8?=
 =?us-ascii?Q?l+qHgr6mGPJuiB15fCmDbp4TSr/8wNLUN2zKlZOi0we0juGS05gONlIb5wA9?=
 =?us-ascii?Q?K6M/vO4rAC6n1yWo0peGREW8yEVuqfMvoJLUXLRS/lA5ZXFWtU+o9jQgZfxm?=
 =?us-ascii?Q?2E1prZk5jahiZIATX3fLkCv/8qeMxk2EAAWCNaQvQnGp+dC5pVfcN7HMi3+H?=
 =?us-ascii?Q?n5adTd5wbkJcYWm6Jyw3RMp/O7U2dJFS1VxQHilH06UO2rqGcM5R/PqcrS/o?=
 =?us-ascii?Q?KRlO6He3g07r0P+L8VToTt0CAASryk4s2sWA5GDhVRQHQ3uq+O3RV63TH3XL?=
 =?us-ascii?Q?w/bY7XnmkvqlV0ji3CTQTzhRSd71v8wPuMX4931JUrVE67VJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1180cddc-947c-4a11-5b47-08deed581cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:59:42.6728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAHq49r+v0KXwfBYlzDv1MndNlHSSCyRHXGPcavgZtPa8Ye2vd4xTbHRuBxbMGas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, July 29, 2026 4:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs

APUs use firmware-owned DPM tables and do not support replacement through p=
p_table. Generic callbacks can nevertheless expose the sysfs file and accep=
t an upload before resetting the power management stack.

Treat pp_table as unsupported on APUs. Use the same platform check in the g=
et and set paths to hide the file and reject uploads.

Fixes: 289921b03fe5 ("drm/amd/powerplay: implement sysfs of pp_table for sm=
u11 (v2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 8f59ea12fe0e..c3688b3b12cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,6 +1183,13 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *a=
dev,
        return ret;
 }

+static bool amdgpu_dpm_is_pp_table_allowed(struct amdgpu_device *adev)
+{
+       return !amdgpu_sriov_vf(adev) &&
+              !(adev->flags & AMD_IS_APU) &&
+              !adev->scpm_enabled;
+}
+
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
                            size_t size)
 {
@@ -1193,7 +1200,8 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *ade=
v, char *table,
        if ((!table && size) || (table && !size))
                return -EINVAL;

-       if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_=
enabled)
+       if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+           !pp_funcs->get_pp_table)
                return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
@@ -1717,7 +1725,8 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *ade=
v,
        if (!buf || !size)
                return -EINVAL;

-       if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_=
enabled)
+       if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+           !pp_funcs->set_pp_table)
                return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
--
2.54.0

