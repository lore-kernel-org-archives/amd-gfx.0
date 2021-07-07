Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BDAC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B79619C5
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B79619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0929B6E819;
	Wed,  7 Jul 2021 05:00:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1E56E819
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 05:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocg9splvRmMa0g0cOizSizT/ZHR6smgaggq0coLMV3/ftfuqnaiodg2l9zXGCjoJUUUaNo871320C9i5avu8CBiPFoaujE9tYoIUB12SKaxBlFUH9vyT6PM/qQP7NdgGvQjsKFIVu/dGJL+csZ0bAcyxvAU5Uo38lEFNJUNbWVByewEQhaIuIwKbqoakPf+K4DYNVT9GO139tqePgzzQXzh9VqTIgnScZd6i5eTrYiwWWgajbPZCfocLyBxEyu3ToQCTps7NK4JZHg14/r2dQhgm3DSiPcu4Xv6v/A8z3G9+GXG21rYG08eBBUXslDfkMYMSCGwYptvQ/75QrSKxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnERT8yheyXI4RwcctltL90ju1H/XQh+ABhBdiQVb0Y=;
 b=gTL/5m1KSwEl1tK5SM99Tk11QYIp8qKa9bWkgpQRCXuIdnxn3c8RIUxzQbi04KwYBy3cPi93Nx/F7liwCPRFUbD3ZUG5eovv6OInYqe9tztFs+yHFgEsS3o1QyqlbbfO+aLRi+1GVv5OMvQfqvRBr4E+uhiADKpxos9kW6LviYnOGm7XHOJnYzoE6Z2H9l3E85DzLnpd5FE80wWvAfCHSGt5YUWcckBfw5pa6sLktZ3xUfNVLUj6JWIlYQzTPlTxpHWxdakFK/s947Ah+DY/xH34n8Mw8osHI2oBOgQsF1rZK7Mrk/j0oQYA9ss0LM2dG3gXCV07LcK+LmCqUQX5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnERT8yheyXI4RwcctltL90ju1H/XQh+ABhBdiQVb0Y=;
 b=al8N4eGUgiCZucFuQg5F0XoF+LuZMgivRg9vfNemF3r5povTCJRaokqjjTbaNNV1HGUSQuRF9pXphGbJjZeK168JuBc36WYNlgZ8UtnZxHpolpB9by3YUW47MRLEUSIBqXRyYjM3gtftbKVQG0g82C3gLjvkbc7KiYWSq7qdZIM=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1361.namprd12.prod.outlook.com (2603:10b6:404:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 05:00:50 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d%10]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 05:00:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
Thread-Topic: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
Thread-Index: AQHXctO8eO3+zz3rikWNHMBJksGbBas29CGg
Date: Wed, 7 Jul 2021 05:00:50 +0000
Message-ID: <BN6PR12MB1283470B08AD87EFBF233069F11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-5-evan.quan@amd.com>
In-Reply-To: <20210707015647.139127-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-07T05:00:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=76500cf3-83c8-49c8-b334-f7091c27e530;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd44c487-c8bb-46ca-aa5e-08d9410430d7
x-ms-traffictypediagnostic: BN6PR12MB1361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB13612D4B4D7B46497C2BBDDEF11A9@BN6PR12MB1361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QBKkp4dqU3uPp2/M+ruNZ0xAL4od7MlVAD2w5Gtc9SGxs+IWicPw6z7EYB5fOJO4Wy18gam/k0igLukuJZH8x5Kne6mxtTXNJb+5q5pC3B7GsjG4omkyIPqzQIS9Wsl1eyhxKdPK5D4CsJUZ9vqHuYhrlj10UwbBUYelKOgrOQIMvgJ5YtfZ08sbAKXGb1dDN3E+DtTnSbHTuBU6dJg85kwRve6vJaF4mX2Ljh8Appq/237qgNqC61hIzGpkMivcTtUKgXE1YJsd98WFJOqOU3fcBFXFSg4IFoFvf9wO3NEcQbP0gv05SojcVxs1TW31sQX8ePEp2GTGdxLIcedZtK+AsWbQvlxrzl1N1+3+nz3/cU4tup/43T6u0Bnobh4Ibky7W7oDnXBkrLb70Z3Sm1zba0IUpSDZwOyLFKxiCvl/K1gHPGcEr1G1u6V5/WQCJ6/T5rYhNl0h91+XUMaIr4MYArMSYQooVfHE0DSmjy+fyh6Z2Ttp0ItpmyrTY1JJZ1Zn8PZkXOMRDyckwz/Li3wnKqP/8cgsvF6t8TrGtmQRjoVTM3cEFuMSNPP5i+QW1v3JUbsxZPWe+VHwfbNTcoAgbWYYYdEYZIkWRGMgsf6wUbBfH6fuq4s7ikRVv7fkdI09nz9zWKtjngMRg/ZpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(71200400001)(966005)(9686003)(45080400002)(55016002)(8936002)(26005)(478600001)(66446008)(5660300002)(186003)(7696005)(2906002)(33656002)(30864003)(52536014)(66946007)(64756008)(66556008)(76116006)(66476007)(316002)(53546011)(86362001)(83380400001)(6506007)(110136005)(54906003)(8676002)(4326008)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A3iuz+8qITjy+sTM/1vyatZHVVDwW9XAZ7b11jzJCYvDk/apQmtK3SkhOuyZ?=
 =?us-ascii?Q?sDf4f2MUMFQO62VT/4ZMNIw0WK7zFZLjiYhx2yojURL3sVzjmKCydmNgTE55?=
 =?us-ascii?Q?8wDuyq0Xk99sEfwWKvHz6JRvbXFje/vo86/6x7krps54/0cxo1YM2ARcf6ZR?=
 =?us-ascii?Q?kQKcmg9K5V59kLKORXsGU2/X6REIZkS/hAcrM+zdthyNuaPZEA9RMvk/nxoa?=
 =?us-ascii?Q?cTD5KsMvXPCdvJV3/KlDwAERyY4HO4OTn7EwJjldJNXjn6VkN5eEHrRaOO2O?=
 =?us-ascii?Q?WaQHSs56q8yuB5ZD97ppfB9wRV0UkyoANaW8gO/ne1CIaI/E6nOpxa+byadE?=
 =?us-ascii?Q?Bu5itW1kmh6/JVAG5LfBwJoO8enqBAkukVCBiAtO/BK4Dyf8/5lD8R5hOPli?=
 =?us-ascii?Q?szSqTpIro1vtdNcM/YnUi66ULyvPV9x03pdcifLnCxY0ivD/LF/59XtAFTAe?=
 =?us-ascii?Q?VqnGiZHAxqmYbgNuOi0X8ahfb+V5B0sGTtgAFjI8ejwZ5Dy+nx8nhwjKKUgh?=
 =?us-ascii?Q?bQnIFXLiBc6PPndvDxYt17mEHPCqAkLfXx+ffVkUQmy5Ol0+hjnpkTMZ1R34?=
 =?us-ascii?Q?9huVaP8mDlGboSfZUURU4ENbml03VxhL3i+0t20RXGYEpJh1UYjhGdBZVLKG?=
 =?us-ascii?Q?x+9D2aCiISu+YcXzgJC9PaGdS0RxLBERQr7eZt41eTiQnCffQR2jOfmfLNkk?=
 =?us-ascii?Q?jzoWXdZlH4bllC0B1JghMy/SwuLbCqO/vN11xi7A8M4tDTfpm5IpcnZfURWI?=
 =?us-ascii?Q?CidC0AhxuCCv0+uIF+8rAWSf5yLR30dakK42bnHrkfij2cNtVCwkBng0YMKS?=
 =?us-ascii?Q?zOBQGqgA3cWQfioBjiYKRaXWHkEw8lr7hqVQj0g7281rFMK7tsM1OtBOIjt/?=
 =?us-ascii?Q?3uyXPIYhtiPgVaY6f4NAaCgppJ1cIEG532fdkCo11K2AaTw0nGYRR9SohFlJ?=
 =?us-ascii?Q?hLhKPnSoI0QbYkxKXK+Uob5VVKudFzna+tRCbPEBfiwx1jL2S4fHUfrh5y3H?=
 =?us-ascii?Q?smd0GOB0DpbgkUluV0HwhpZlKiOHkl2NoNpx9mrnvOHxq/z4dRXrC/9rq+xz?=
 =?us-ascii?Q?WBN162tLIGengLb+gy3jamwOdeMOx9XzvOJaUwJHRvdXwORlypDQlHoT6IZ1?=
 =?us-ascii?Q?nEGNgn2Rc9Rm9uUYjjxISoB9UF0VXtVvqUOr9D2jPBreMe/h7uyzAS0C4PrJ?=
 =?us-ascii?Q?FtCMhsIf41Ovr4N6Z6dXqFVHRYIO9gFz8nSXWca3pKgL1VQOIlQQ62Rg/SON?=
 =?us-ascii?Q?YUtYJXDl9HQ9PHRoiDYx0uomNfFRVVg/6Um+VKURftmmWxqKThB+WJgj9zlo?=
 =?us-ascii?Q?lU79ERVZWCHukZkgBipAIVf+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd44c487-c8bb-46ca-aa5e-08d9410430d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 05:00:50.3691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdMsR/f2beEheUI8BnwlR0R+CtLPWfqo1sfWbF5+vD5+Uq/yz7orGag0byovilRi7GifOd01+oM7QGou6/JrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Seems 255 and 100 are used multiple times in different files. Is it better to define them as a macro?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, July 7, 2021 9:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate percent-based transition

Currently, the readout of fan speed pwm is transited into percent-based and then pwm-based. However, the transition into percent-based is totally unnecessary and make the final output less accurate.

Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 ----
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  4 ++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  | 12 ++++++------  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 10 +++++-----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    | 12 ++++++------
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++----------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++-------
 10 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 769f58d5ae1a..e9c98e3f4cfb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2469,8 +2469,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return err;
 	}
 
-	value = (value * 100) / 255;
-
 	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
 		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
 	else
@@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (err)
 		return err;
 
-	speed = (speed * 255) / 100;
-
 	return sprintf(buf, "%i\n", speed);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..aa353a628c50 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
 
 	if (!ret) {
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
-			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		else if (level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
 	}
@@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)  {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 6cfe148ed45b..70ccc127e3fd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -70,12 +70,12 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -214,8 +214,8 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -227,7 +227,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 25979106fd25..44c5e2588046 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 9b46b27bd30c..6b4c4294afca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 
 	if (hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM != 0)
-		percent = current_rpm * 100 /
+		percent = current_rpm * 255 /
 			hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM;
 
-	*speed = percent > 100 ? 100 : percent;
+	*speed = percent > 255 ? 255 : percent;
 
 	return 0;
 }
@@ -257,8 +257,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -270,7 +270,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0791309586c5..cbe5f8027ee0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)  {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 43d754952bd9..eb007c00d7c6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -129,12 +129,12 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -147,8 +147,8 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	uint32_t duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -160,7 +160,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 15c0b8af376f..96ca359c10a5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6555,12 +6555,12 @@ static int si_dpm_get_fan_speed_percent(void *handle,
 	if (duty100 == 0)
 		return -EINVAL;
 
-	tmp64 = (u64)duty * 100;
+	tmp64 = (u64)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (u32)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -6580,7 +6580,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 	if (si_pi->fan_is_controlled_by_smc)
 		return -EINVAL;
 
-	if (speed > 100)
+	if (speed > 255)
 		return -EINVAL;
 
 	duty100 = (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DUTY100_SHIFT; @@ -6589,7 +6589,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 		return -EINVAL;
 
 	tmp64 = (u64)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (u32)tmp64;
 
 	tmp = RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 54fb3d7d23ee..94c15526ad21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2565,23 +2565,17 @@ static int smu_get_fan_speed_percent(void *handle, u32 *speed)  {
 	struct smu_context *smu = handle;
 	int ret = 0;
-	uint32_t percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent) {
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
-		if (!ret) {
-			*speed = percent > 100 ? 100 : percent;
-		}
-	}
+	if (smu->ppt_funcs->get_fan_speed_percent)
+		ret = smu->ppt_funcs->get_fan_speed_percent(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
-
 	return ret;
 }
 
@@ -2596,8 +2590,6 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_speed_percent) {
-		if (speed > 100)
-			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0cdf55a0dba2..f0ae0920c07e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1191,8 +1191,8 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (smu_v11_0_auto_fan_control(smu, 0))
 		return -EINVAL;
@@ -1203,7 +1203,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
@@ -1274,12 +1274,12 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -1320,7 +1320,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
+		ret = smu_v11_0_set_fan_speed_percent(smu, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C5b919ff74f95497e2dd108d940eaddf7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612199755775085%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mbcHvnH3%2BLgMVnXY72XKV%2F%2BMScHA%2FXYbvVdALV0oq7I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
