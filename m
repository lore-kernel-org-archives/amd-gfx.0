Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4521922D5A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4521922D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4B86E453;
	Mon, 21 Dec 2020 04:16:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114D96E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 04:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfFqEmoDFTDxK+MgKSu2ErNSU9cEXex1g67Mz5FPxUr2tyUnDHeM4xn+8lGpE6VSBr4poGT9p1fnAuSUXxS9Ob41OIfzMjOAfljR3RnQaS+hZTh9R+JnEeAjyD+yA3XqszSqr7aa447UWZbhvhyrzMO/QFi9XIRo3UhrRFSPD8GXo9sb1V83Xhn3bUO6iRqxqVfqluDGgHkDE67zKgrrnFXtYv/xRNjfpJMvMnXFlEU90FohnRvrA2Q24pPSQVw4a7osf+yJIZhcjzuoQh50DgcsvsOQRUAHPNqhp8Zu0JnDAQQBcHePCNzXtyWMi9YnTgSCG6RqcIDBUlWdhFaNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqWNNPzEuWlXOvla+9ych4Y/keC7EuBOeCRU8cnb+K8=;
 b=jQsKFXGBawxi3vWzGENDK+axI+3oQaCr5Eznz5b3IoMJiPIQ+/vIgO1ci4qzWZ8aJkitAR+9dc9drYchSe6GXH1mdo8gXHH3/9kAd+vWqac90ZQwCvgOypZbAtRe28poXMTAATh+2Ac1jIOMC6pFIrY4qXqsLla9AQ6aht2h2DVEB2DTzlGjQe+xI6CGwRBwZ8Rmg05hie7dOvuJmW5cWUGVUmAIkr8jONQbwmXgPJVPeY2JOkfN92OOS4tiPmLy4mBS/tc/x4QF8lErMO0wxe7KGJ5wYSizjzAwC3AqHOawXPXTkH6cQLDE6yc8D01BiYGP1HD97AzMnUWda8pNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqWNNPzEuWlXOvla+9ych4Y/keC7EuBOeCRU8cnb+K8=;
 b=htYR/sa8F7rrP+NUgx20kB+R6X/Wjpz3Y1HUVDtOWmZsgwC38h+Q7zZl4qM5ZVOhtAFDqY1TtPHFEbbxXQScv9yJDDc9KsiIZhNtFZS09hAeeZp0vc9a/9sqg/6BLiCjaF2jVHRc1uEEEA+OYfolCNLkyeaS9WiDzQOvlTSFuzk=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 04:16:09 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 04:16:09 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/8] amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon
 fan functions to use API
Thread-Topic: [PATCH 3/8] amdgpu/pm: Powerplay API for smu , changed 6 pm
 hwmon fan functions to use API
Thread-Index: AQHW1aDF/EFsx4yVy0SLXo9qVBCGIaoA80AI
Date: Mon, 21 Dec 2020 04:16:09 +0000
Message-ID: <MN2PR12MB3022B97176328209BE83E924A2C00@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201219004831.13527-1-darren.powell@amd.com>,
 <20201219004831.13527-4-darren.powell@amd.com>
In-Reply-To: <20201219004831.13527-4-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T04:16:09.491Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [111.42.32.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa0d1537-1057-4d2b-58e5-08d8a56724f5
x-ms-traffictypediagnostic: MN2PR12MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3551E46ECEDFA6E47B703461A2C00@MN2PR12MB3551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGNKvBbmchkztYbTeF5En4VtiV8UrZiFfDOFUfscikQUccKqWfxS2SnANma6qDgbOKspMyV2s1dWwY7/4lN0/lkSdrJg45CuL35iT1Riebo/ZliLEEdtdGMgR+IXaq1vPQX95tcmEW6NtMcCPbrc+CzSieZZ1TIFX6qc/tQSWW7pykNtdByj8mJY9Mxc8NHYoD294trRcy4k492LVngGTBmF+JQ/DMgrgqr+c4BOaoyBgTAMJqh4d/nQbeUUZ/KJDGSE6/Lk8sPlq9gjQmjRdGa8P5GPTP/GYvR4NUWeb1TQDmwxJVOnFVF91o9kok0Hp55Ugz9cdcwbHvQqTMDteruY7QDDslTcfTSu8xL2xe7/MKGRjSocpfMPmywmQ8bGyHaLsMWrNXXu5G6KrpEpiWSs6R5Tn8EVoWvjdX00Tx0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(91956017)(52536014)(186003)(966005)(30864003)(76116006)(66446008)(64756008)(33656002)(66946007)(66556008)(110136005)(45080400002)(478600001)(8936002)(86362001)(4326008)(316002)(66476007)(83380400001)(9686003)(5660300002)(8676002)(2906002)(166002)(71200400001)(26005)(53546011)(7696005)(19627405001)(6506007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?klg5QBdmGyaCYYzjgJWcd9lrDnLygbLZheB+fSN7fRqJIYlMKIQVRiAuzd?=
 =?iso-8859-1?Q?mxNxIDFLmYmVYQfJD7vG+SrsQSQYaRTSqehX8f0Hqi1flplM7+juUnyOTi?=
 =?iso-8859-1?Q?wMIrK6Fve0OUhLpwWIvKXr3W/SvcQvxlde5LI/p7+9PU7N2bfqkBUHLEbs?=
 =?iso-8859-1?Q?NYDLL12rfz1cWRvDuiNveuPjCyma4lI66ws6jviVJCqHbMSMMdh/GAC8kH?=
 =?iso-8859-1?Q?5+/WlWTbqYEy4ZsiMFKt7e5snIMFWOeu22UDhm19abUeGR8v5MzZ552DM/?=
 =?iso-8859-1?Q?7SJ6dcN5Rvw9c82MIhBAeJG84AqW8BHvZ2ZCRzAl3KCIcYaZLpFq46UVmv?=
 =?iso-8859-1?Q?qPB0d4hnes9ud+/gpb3+qPZdC/W2KImIvy2/WQuCyHGmE8awS99K9wgXm/?=
 =?iso-8859-1?Q?q3hq/NkkH+mKA49fgHG3K3xdvuwEyHJwX8DZmxoiHCeyFpXPZ4WLDMUUNg?=
 =?iso-8859-1?Q?tZN1ZHDU3De1WnykgoZrz+0ttQ/HII7S+mZAcadMScflHZ/9hmlFdeje+6?=
 =?iso-8859-1?Q?ehS/+XALSqRRFR6yjncyfMmE7Xy2vEVLddeb0KMDeEQ+J2mmnBSoFxTrTx?=
 =?iso-8859-1?Q?seAqsd3/NKyjM7/HDCA+nhNkctZO09gKqI+ckwtuBW0zRioCIcVRnLivu7?=
 =?iso-8859-1?Q?58LoYBxUGK7iK2Ox/B5QqyQSzbQPsURtAZKfNaDYig2ciLvNdOLi9XPmhy?=
 =?iso-8859-1?Q?95rpXkRXzSs3peMtitqooEgVEj+PJOSzB4Y8bms56gVdOKuIQeUGZ8p2kK?=
 =?iso-8859-1?Q?n/7waTYMWR8sG5B3i43bewTiM+TnkiBuilwOB4klKPtVNyZD+y7xfmA7I0?=
 =?iso-8859-1?Q?5bUjLOq/4OjE+DaF2tinBUExTaY02Uy+0zwpwP7Q3ef2lOPAaf18wtl4Ja?=
 =?iso-8859-1?Q?SwHkMhktBHO6TWr3Sb6plnYBRF8n/Z/6OCv0ZC42ekcEakfPtE+3EaEDYU?=
 =?iso-8859-1?Q?72sQr0HOjzMoTj2vnyCZesYd3svczAqsbX+W60Zs3Z7+KzK6KbeFZ6XzVL?=
 =?iso-8859-1?Q?WcxzV/HLgAw5BwWy0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0d1537-1057-4d2b-58e5-08d8a56724f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 04:16:09.1969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/WFbnInKrk173Cata62kyiAuhNTGAflj5OSCN9clxDCBPMF6/5D+hrIiI7Da6EU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: multipart/mixed; boundary="===============0992461015=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0992461015==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022B97176328209BE83E924A2C00MN2PR12MB3022namp_"

--_000_MN2PR12MB3022B97176328209BE83E924A2C00MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Darren P=
owell <darren.powell@amd.com>
Sent: Saturday, December 19, 2020 8:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 3/8] amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon =
fan functions to use API

Modified Functions
  smu_set_fan_speed_rpm()     - modifed arg0 to match Powerplay API set_fan=
_speed_rpm
  smu_get_fan_control_mode()  - modifed signature to match Powerplay API ge=
t_fan_control_mode
  smu_set_fan_control_mode()  - modifed signature to match Powerplay API se=
t_fan_control_mode
  smu_get_fan_speed_percent() - modifed signature to match Powerplay API ge=
t_fan_speed_percent
  smu_set_fan_speed_percent() - modifed signature to match Powerplay API se=
t_fan_speed_percent
  smu_get_fan_speed_rpm()     - modifed arg0 to match Powerplay API get_fan=
_speed_rpm

Other Changes
  added 6 above smu fan Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerp=
lay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 87 +++++++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 33 ++++++---
 3 files changed, 55 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 0008bbe971d6..b345c29147b9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2349,18 +2349,14 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
-       } else {
-               if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
+       if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
                         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
                         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev)=
;
                         return -EINVAL;
-               }
-
-               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
         }

+       pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
+
         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

@@ -2389,18 +2385,14 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct =
device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               smu_set_fan_control_mode(&adev->smu, value);
-       } else {
-               if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
-                       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-                       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-                       return -EINVAL;
-               }
-
-               amdgpu_dpm_set_fan_control_mode(adev, value);
+       if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
+               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return -EINVAL;
         }

+       amdgpu_dpm_set_fan_control_mode(adev, value);
+
         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

@@ -2439,11 +2431,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *=
dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
-       else
-               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
-
+       pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
         if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
                 pr_info("manual fan speed control should be enabled first\=
n");
                 pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -2460,9 +2448,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *d=
ev,

         value =3D (value * 100) / 255;

-       if (is_support_sw_smu(adev))
-               err =3D smu_set_fan_speed_percent(&adev->smu, value);
-       else if (adev->powerplay.pp_funcs->set_fan_speed_percent)
+       if (adev->powerplay.pp_funcs->set_fan_speed_percent)
                 err =3D amdgpu_dpm_set_fan_speed_percent(adev, value);
         else
                 err =3D -EINVAL;
@@ -2493,9 +2479,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *d=
ev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               err =3D smu_get_fan_speed_percent(&adev->smu, &speed);
-       else if (adev->powerplay.pp_funcs->get_fan_speed_percent)
+       if (adev->powerplay.pp_funcs->get_fan_speed_percent)
                 err =3D amdgpu_dpm_get_fan_speed_percent(adev, &speed);
         else
                 err =3D -EINVAL;
@@ -2528,9 +2512,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct dev=
ice *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               err =3D smu_get_fan_speed_rpm(&adev->smu, &speed);
-       else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+       if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
                 err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
         else
                 err =3D -EINVAL;
@@ -2621,9 +2603,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct de=
vice *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               err =3D smu_get_fan_speed_rpm(&adev->smu, &rpm);
-       else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+       if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
                 err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
         else
                 err =3D -EINVAL;
@@ -2655,10 +2635,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct d=
evice *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
-       else
-               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
+       pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);

         if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
                 pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -2673,9 +2650,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct de=
vice *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               err =3D smu_set_fan_speed_rpm(&adev->smu, value);
-       else if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
+       if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
                 err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);
         else
                 err =3D -EINVAL;
@@ -2706,18 +2681,14 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct =
device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
-       } else {
-               if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
-                       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-                       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-                       return -EINVAL;
-               }
-
-               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
+       if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
+               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return -EINVAL;
         }

+       pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
+
         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

@@ -2754,16 +2725,12 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct =
device *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev)) {
-               smu_set_fan_control_mode(&adev->smu, pwm_mode);
-       } else {
-               if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
-                       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-                       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-                       return -EINVAL;
-               }
-               amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
+       if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
+               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return -EINVAL;
         }
+       amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);

         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 6713f28c5fde..9f739d1b18d5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -657,7 +657,7 @@ int smu_check_fw_status(struct smu_context *smu);

 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);

-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed);

 int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
@@ -679,11 +679,11 @@ int smu_set_power_profile_mode(struct smu_context *sm=
u,
                                long *param,
                                uint32_t param_size,
                                bool lock_needed);
-int smu_get_fan_control_mode(struct smu_context *smu);
-int smu_set_fan_control_mode(struct smu_context *smu, int value);
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed);
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
+u32 smu_get_fan_control_mode(void *handle);
+void smu_set_fan_control_mode(void *handle, u32 value);
+int smu_get_fan_speed_percent(void *handle, u32 *speed);
+int smu_set_fan_speed_percent(void *handle, u32 speed);
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);

 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 5f33439782c4..acde0e831bb8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1896,8 +1896,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool en=
abled)
         return ret;
 }

-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2100,9 +2101,10 @@ int smu_set_power_profile_mode(struct smu_context *s=
mu,
 }


-int smu_get_fan_control_mode(struct smu_context *smu)
+u32 smu_get_fan_control_mode(void *handle)
 {
-       int ret =3D 0;
+       struct smu_context *smu =3D handle;
+       u32 ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;
[kevin]:
after change function return type to 'u32", the return value of  '-EOPNOTSU=
PP' maybe not work.
other patches have the same problems.

@@ -2117,25 +2119,26 @@ int smu_get_fan_control_mode(struct smu_context *sm=
u)
         return ret;
 }

-int smu_set_fan_control_mode(struct smu_context *smu, int value)
+void smu_set_fan_control_mode(void *handle, u32 value)
 {
-       int ret =3D 0;
+       struct smu_context *smu =3D handle;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-               return -EOPNOTSUPP;
+               return;

         mutex_lock(&smu->mutex);

         if (smu->ppt_funcs->set_fan_control_mode)
-               ret =3D smu->ppt_funcs->set_fan_control_mode(smu, value);
+               smu->ppt_funcs->set_fan_control_mode(smu, value);

         mutex_unlock(&smu->mutex);

-       return ret;
+       return;
 }

-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
+int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;
         uint32_t percent;
         uint32_t current_rpm;
@@ -2159,8 +2162,9 @@ int smu_get_fan_speed_percent(struct smu_context *smu=
, uint32_t *speed)
         return ret;
 }

-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_percent(void *handle, u32 speed)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;
         uint32_t rpm;

@@ -2181,8 +2185,9 @@ int smu_set_fan_speed_percent(struct smu_context *smu=
, uint32_t speed)
         return ret;
 }

-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2564,7 +2569,13 @@ int smu_gfx_state_change_set(struct smu_context *smu=
, uint32_t state)

 static const struct amd_pm_funcs swsmu_dpm_funcs =3D {
         /* export for sysfs */
+       .set_fan_control_mode  =3D smu_set_fan_control_mode,
+       .get_fan_control_mode  =3D smu_get_fan_control_mode,
+       .set_fan_speed_percent =3D smu_set_fan_speed_percent,
+       .get_fan_speed_percent =3D smu_get_fan_speed_percent,
         .get_performance_level =3D smu_get_performance_level,
+       .get_fan_speed_rpm     =3D smu_get_fan_speed_rpm,
+       .set_fan_speed_rpm     =3D smu_set_fan_speed_rpm,
         .switch_power_profile  =3D smu_switch_power_profile,
         /* export to amdgpu */
         .set_mp1_state         =3D smu_set_mp1_state,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C5e2363bd852d4f676cfe08d8a3b7e638%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637439357534767356%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dnc=
J6EcwqNogU9oiPX%2BbA99o%2FST67HR3r7e4cMiKZiY8%3D&amp;reserved=3D0

--_000_MN2PR12MB3022B97176328209BE83E924A2C00MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Darren Powell &lt;darren.powe=
ll@amd.com&gt;<br>
<b>Sent:</b> Saturday, December 19, 2020 8:48 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/8] amdgpu/pm: Powerplay API for smu , changed 6 pm=
 hwmon fan functions to use API</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Modified Functions<br>
&nbsp; smu_set_fan_speed_rpm()&nbsp;&nbsp;&nbsp;&nbsp; - modifed arg0 to ma=
tch Powerplay API set_fan_speed_rpm<br>
&nbsp; smu_get_fan_control_mode()&nbsp; - modifed signature to match Powerp=
lay API get_fan_control_mode<br>
&nbsp; smu_set_fan_control_mode()&nbsp; - modifed signature to match Powerp=
lay API set_fan_control_mode<br>
&nbsp; smu_get_fan_speed_percent() - modifed signature to match Powerplay A=
PI get_fan_speed_percent<br>
&nbsp; smu_set_fan_speed_percent() - modifed signature to match Powerplay A=
PI set_fan_speed_percent<br>
&nbsp; smu_get_fan_speed_rpm()&nbsp;&nbsp;&nbsp;&nbsp; - modifed arg0 to ma=
tch Powerplay API get_fan_speed_rpm<br>
<br>
Other Changes<br>
&nbsp; added 6 above smu fan Powerplay functions to swsmu_dpm_funcs<br>
&nbsp; removed special smu handling of above functions and called through P=
owerplay API<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 87 +++++++----------------<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; | 12 ++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 33 ++++++---<br>
&nbsp;3 files changed, 55 insertions(+), 77 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 0008bbe971d6..b345c29147b9 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2349,18 +2349,14 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;=
get_fan_control_mode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_ru=
ntime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_ru=
ntime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_contr=
ol_mode(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
&nbsp;<br>
@@ -2389,18 +2385,14 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_fan_control_mode(&amp;adev-&gt;smu, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_=
last_busy(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_a=
utosuspend(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, value);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;=
set_fan_control_mode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev,=
 value);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
&nbsp;<br>
@@ -2439,11 +2431,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_contr=
ol_mode(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pwm_mode !=3D AMD_FAN_=
CTRL_MANUAL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;manual fan speed control should be enab=
led first\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);=
<br>
@@ -2460,9 +2448,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *d=
ev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value * 100) / =
255;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_set_fan_speed_percent(&amp;adev-&gt;smu, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;set_fan_speed_percent)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;s=
et_fan_speed_percent)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_percent(adev, value)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
@@ -2493,9 +2479,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_get_fan_speed_percent(&amp;adev-&gt;smu, &amp;speed)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_fan_speed_percent)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_fan_speed_percent)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_percent(adev, &amp;s=
peed);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
@@ -2528,9 +2512,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_get_fan_speed_rpm(&amp;adev-&gt;smu, &amp;speed);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_fan_speed_rpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_fan_speed_rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &amp;speed=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
@@ -2621,9 +2603,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_get_fan_speed_rpm(&amp;adev-&gt;smu, &amp;rpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_fan_speed_rpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_fan_speed_rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &amp;rpm);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
@@ -2655,10 +2635,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_contr=
ol_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pwm_mode !=3D AMD_FAN_=
CTRL_MANUAL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);=
<br>
@@ -2673,9 +2650,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_set_fan_speed_rpm(&amp;adev-&gt;smu, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;set_fan_speed_rpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;s=
et_fan_speed_rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
@@ -2706,18 +2681,14 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_=
last_busy(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_a=
utosuspend(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;=
get_fan_control_mode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_contr=
ol_mode(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
&nbsp;<br>
@@ -2754,16 +2725,12 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_fan_control_mode(&amp;adev-&gt;smu, pwm_mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_=
last_busy(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_a=
utosuspend(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;=
set_fan_control_mode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev,=
 pwm_mode);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 6713f28c5fde..9f739d1b18d5 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -657,7 +657,7 @@ int smu_check_fw_status(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);<br>
&nbsp;<br>
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);<br>
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<br>
&nbsp;<br>
&nbsp;int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
@@ -679,11 +679,11 @@ int smu_set_power_profile_mode(struct smu_context *sm=
u,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lock_needed);<br>
-int smu_get_fan_control_mode(struct smu_context *smu);<br>
-int smu_set_fan_control_mode(struct smu_context *smu, int value);<br>
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed);<b=
r>
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);<br=
>
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);<br>
+u32 smu_get_fan_control_mode(void *handle);<br>
+void smu_set_fan_control_mode(void *handle, u32 value);<br>
+int smu_get_fan_speed_percent(void *handle, u32 *speed);<br>
+int smu_set_fan_speed_percent(void *handle, u32 speed);<br>
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);<br>
&nbsp;<br>
&nbsp;int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 5f33439782c4..acde0e831bb8 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1896,8 +1896,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool en=
abled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)<br>
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
@@ -2100,9 +2101,10 @@ int smu_set_power_profile_mode(struct smu_context *s=
mu,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-int smu_get_fan_control_mode(struct smu_context *smu)<br>
+u32 smu_get_fan_control_mode(void *handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">after change function return type to 'u32&quot;, t=
he return value of&nbsp; '-EOPNOTSUPP' maybe not work.</div>
<div class=3D"PlainText">other patches have the same problems.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">@@ -2117,25 +2119,26 @@ int smu_get_fan_control_mo=
de(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_fan_control_mode(struct smu_context *smu, int value)<br>
+void smu_set_fan_control_mode(void *handle, u32 value)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;=
set_fan_control_mode)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;set_fan_control_mode(smu, value);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;ppt_funcs-&gt;set_fan_control_mode(smu, value);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)<br=
>
+int smu_get_fan_speed_percent(void *handle, u32 *speed)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t percent;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_rpm;<br>
@@ -2159,8 +2162,9 @@ int smu_get_fan_speed_percent(struct smu_context *smu=
, uint32_t *speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)<br>
+int smu_set_fan_speed_percent(void *handle, u32 speed)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rpm;<br>
&nbsp;<br>
@@ -2181,8 +2185,9 @@ int smu_set_fan_speed_percent(struct smu_context *smu=
, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)<br>
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
@@ -2564,7 +2569,13 @@ int smu_gfx_state_change_set(struct smu_context *smu=
, uint32_t state)<br>
&nbsp;<br>
&nbsp;static const struct amd_pm_funcs swsmu_dpm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export for sysfs */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode&nbsp; =3D smu_s=
et_fan_control_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode&nbsp; =3D smu_g=
et_fan_control_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D smu_set_fa=
n_speed_percent,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D smu_get_fa=
n_speed_percent,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level =3D=
 smu_get_performance_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp; =3D smu_get_fan_speed_rpm,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp; =3D smu_set_fan_speed_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .switch_power_profile&nbsp=
; =3D smu_switch_power_profile,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export to amdgpu */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_mp1_state,<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C5e2363bd852d4f676cfe08d8a3b7e638%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637439357534767356%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DncJ6EcwqNogU9oiPX%2BbA99o%2FST67HR3r7e4cMiKZiY8%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7C5e2363bd852d4f676cfe08d8a3b7e638%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637439357534767356%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DncJ6EcwqNogU9oiPX%2BbA99o%2FST67HR3r7e4cMiKZiY8%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022B97176328209BE83E924A2C00MN2PR12MB3022namp_--

--===============0992461015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0992461015==--
