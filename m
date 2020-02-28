Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC7C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D203B24699
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fb0kvupv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D203B24699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4BA6E065;
	Fri, 28 Feb 2020 15:15:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E906E065
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 15:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOuOHzsmc2/RpdscfCQ3KQGVMWOzGv9kJ/nDWaPWxzPWT23ePiVy4d7gE2HXPiBCy8pevUU1erFpsfmjDK1Qs5uD+GhfeX8Xax1T6CPl9O3Mufn6nEQEDuvFszeXBYKHxIvHitcOQaLkyGz0w2OoO0+UkZuB9CCAe44gYpBUiXsypSupNQ+hmCra8fM18ip/C3ZH6+yn/9x4Y7bDmRPY2efx3WRWzy+a1GkxFa9UYYHqSRdA8wV2xDOyDFmMQbz9jA0Z7JiW2CzaCGkFuMp6T0A4UNPrrO05ZMBZycYE05tdBxS2Y6ljnfxW5FWWGFfMAzwj350HDNV6XFPnVpQy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTRL4KrXXO7l32AH5V2H2nh4ducb3r14LrU9L3GDF0Q=;
 b=lLFnpVUwjcUFzL20uVbCtvG+YgS1jD+N6MgUIlYkVWaDB9ydEkKQinhP5XJ8EyMHpzJ+usrqs0kIZJ+ngYlpDjmpPZHRsc1BcMKm/XVi10IjULS9rw5pNYOETnRLzN6W9EY2apTen50n0/bd6QE2LnLwuGUBwhQ4rZ5H4FnVMso24ySeWh4jcAkOS4CHnF2oCZAeoJ1J8gac+xdjpOcs5CZsSCkd7Zt07rzGomTa/eVmjlHAy7HCf82vQMUkl8NOaT11amC4KZJa3lXjRmRwTiQ1YphwHw0KsTm+LNPr6S2iQgOIOobsx3h0TUB9UxSfQKF0/MtrGLp7Nqjg0z8ffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTRL4KrXXO7l32AH5V2H2nh4ducb3r14LrU9L3GDF0Q=;
 b=Fb0kvupvli+zad4QneLcvFVa1ku64Y+IRBw4WkQ+rpAIaliEOdshjgm7W+cmRL2Fa+JLNLzuye3NkswouGoec4R9ENAY4BH1sYMVm4Wi6NAQHxLmWD/9Vw5ZJp3IMPvRN9d2P0dNICG2h8bhOzXqTSsG0Ey8Czkyd62kDiOLABc=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Fri, 28 Feb
 2020 15:15:27 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 15:15:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set
 arbitrary sclk value for navi14"
Thread-Topic: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set
 arbitrary sclk value for navi14"
Thread-Index: AQHV7eArCD0AYYPZ0kiX4YuUhgzLh6gv9QQAgADC9wU=
Date: Fri, 28 Feb 2020 15:15:27 +0000
Message-ID: <CH2PR12MB3912B467956CC1067B20B7A3F7E80@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>,
 <MN2PR12MB3344987021D34B09F348FF1CE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344987021D34B09F348FF1CE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-28T15:15:26.702Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36c89dee-b723-4b6b-25b0-08d7bc610aa3
x-ms-traffictypediagnostic: CH2PR12MB3992:|CH2PR12MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB39927296874DF27DF36D5853F7E80@CH2PR12MB3992.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(4326008)(45080400002)(9686003)(316002)(478600001)(8676002)(52536014)(54906003)(8936002)(55016002)(81166006)(5660300002)(81156014)(110136005)(966005)(66946007)(71200400001)(86362001)(2906002)(66476007)(33656002)(76116006)(26005)(6506007)(66556008)(7696005)(19627405001)(53546011)(186003)(64756008)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3992;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAo+Ca2lNspRMjqCGk+zMn2TFVKBsA4GMUnj5oPb2wvGPwYH+yy1IeE+iEeTXsgUfFPRq1XTKIRM4DdG1SxfxHCno6BSosWNyg7IpZMS+eNeqfiTzfNzyjW+C3m/0DKq+ecTrJue5mo+LpHWT/M7Xt9GYDAOmYpSA5v7HqRUT6Lob8E4pDoRzgnoo4zG9raqpdvF/5c4/6Eufh65kvaWQL4RYeNOer1PZUzwBC6QOoPuWEMfPu5mQ+8FpRUd1ljiUeIBXnBnl/Ps5HorCNEpVruu/MCVqbE8Ro+oplxxt4/KlPDG9l1d8ztnrK1wtedFmo/Hi0I2F1Krh209n1ZmTG/18CqebnYKQ/cbL/5HgXqopCOoyplrqf2KIpxta/M8WW8/UdiKas3QdXx8mV33RuJVI2zxuytP/ff729RAfVgzQ/m5avlPI/qH0sHE6QqLudvyJD3gA5k4Rb9lB75FDuDIKxzDtOI0hKvikaOXo6E=
x-ms-exchange-antispam-messagedata: XR4Jp/UITo35rP/qA8JbYi4VVIk8rGCP63lEsT2V/lMl7bL9M/JkjGrevXRPbpqa8817zgcTALBPsA66Kr3wXWTwDTkvyorCXOiaGpJK9lsbf1WvwWwf0lDIW7DuUdTKu8w7p4Scjgr/2LXHZcY0tw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c89dee-b723-4b6b-25b0-08d7bc610aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 15:15:27.1358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHyvX21X5y2KrLlps8E1zKWDvj1+idSI6WDj5IKvOTwHua3bnsL5pqDALwZMfXEIMtLqUBbdQyWmW7H0sSwMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1823444135=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1823444135==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912B467956CC1067B20B7A3F7E80CH2PR12MB3912namp_"

--_000_CH2PR12MB3912B467956CC1067B20B7A3F7E80CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Please also revert this fix:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-drm-next&=
id=3D4e261b86437af7481364a5239c62cc3c5ef0ee38

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Quan, Ev=
an <Evan.Quan@amd.com>
Sent: Thursday, February 27, 2020 10:37 PM
To: Gui, Jack <Jack.Gui@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@li=
sts.freedesktop.org>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; G=
ui, Jack <Jack.Gui@amd.com>
Subject: RE: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set arb=
itrary sclk value for navi14"

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Friday, February 28, 2020 10:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; X=
u, Feifei <Feifei.Xu@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set arbitra=
ry sclk value for navi14"

Revert this commit and than add debugfs interface to replace this to meet t=
he specitic requirement.

This reverts commit 3107269204f8e18f389080673f7848b420970aa5.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c    | 42 ---------------------------=
----
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c |  9 ++-----
 2 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 9deff8c..bc3cf04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1034,40 +1034,6 @@ static ssize_t amdgpu_read_mask(const char *buf, siz=
e_t count, uint32_t *mask)
         return 0;
 }

-static ssize_t amdgpu_set_pp_sclk(struct device *dev,
-               struct device_attribute *attr,
-               const char *buf,
-               size_t count)
-{
-       struct drm_device *ddev =3D dev_get_drvdata(dev);
-       struct amdgpu_device *adev =3D ddev->dev_private;
-       int ret;
-       uint32_t value;
-
-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
-       ret =3D pm_runtime_get_sync(ddev->dev);
-       if (ret < 0)
-               return ret;
-
-       ret =3D kstrtou32(buf, 0, &value);
-       if (ret < 0)
-               return ret;
-       if (is_support_sw_smu(adev))
-               ret =3D smu_set_soft_freq_range(&adev->smu, SMU_SCLK, value=
, value);
-       else
-               return 0;
-
-       pm_runtime_mark_last_busy(ddev->dev);
-       pm_runtime_put_autosuspend(ddev->dev);
-
-       if (ret)
-               return -EINVAL;
-
-       return count;
-}
-
 static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
                 struct device_attribute *attr,
                 const char *buf,
@@ -1829,8 +1795,6 @@ static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,=
  static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
                 amdgpu_get_pp_table,
                 amdgpu_set_pp_table);
-static DEVICE_ATTR(pp_sclk, S_IWUSR,
-               NULL, amdgpu_set_pp_sclk);
 static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
                 amdgpu_get_pp_dpm_sclk,
                 amdgpu_set_pp_dpm_sclk);
@@ -3322,12 +3286,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
                 return ret;
         }

-       ret =3D device_create_file(adev->dev, &dev_attr_pp_sclk);
-       if (ret) {
-               DRM_ERROR("failed to create device file pp_sclk\n");
-               return ret;
-       }
-
         ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
         if (ret) {
                 DRM_ERROR("failed to create device file pp_dpm_sclk\n"); d=
iff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd=
/powerplay/smu_v11_0.c
index 1507bb7..c9e5ce1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1803,17 +1803,12 @@ int smu_v11_0_set_soft_freq_limited_range(struct sm=
u_context *smu, enum smu_clk_  {
         int ret =3D 0, clk_id =3D 0;
         uint32_t param;
-       uint32_t min_freq, max_freq;

         clk_id =3D smu_clk_get_index(smu, clk_type);
         if (clk_id < 0)
                 return clk_id;

-       ret =3D smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq,=
 true);
-       if (ret)
-               return ret;
-
-       if (max > 0 && max <=3D  max_freq) {
+       if (max > 0) {
                 param =3D (uint32_t)((clk_id << 16) | (max & 0xffff));
                 ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMa=
xByFreq,
                                                   param);
@@ -1821,7 +1816,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_=
context *smu, enum smu_clk_
                         return ret;
         }

-       if (min > 0 && min >=3D min_freq) {
+       if (min > 0) {
                 param =3D (uint32_t)((clk_id << 16) | (min & 0xffff));
                 ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMi=
nByFreq,
                                                   param);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C86a8aed9b2854f38626908d7bbff8780%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637184578512568577&amp;sdata=3DO1zVjtLbL6JRjrWzN23=
MARS6NlM8kUjLd3%2BKuxQOVbI%3D&amp;reserved=3D0

--_000_CH2PR12MB3912B467956CC1067B20B7A3F7E80CH2PR12MB3912namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please also revert this fix:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-stagin=
g-drm-next&amp;id=3D4e261b86437af7481364a5239c62cc3c5ef0ee38" id=3D"LPlnk92=
5851">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-drm=
-next&amp;id=3D4e261b86437af7481364a5239c62cc3c5ef0ee38</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 10:37 PM<br>
<b>To:</b> Gui, Jack &lt;Jack.Gui@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] Revert &quot;drm/amdgpu: add sysfs interfac=
e to set arbitrary sclk value for navi14&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<b=
r>
<br>
-----Original Message-----<br>
From: Chengming Gui &lt;Jack.Gui@amd.com&gt; <br>
Sent: Friday, February 28, 2020 10:37 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@am=
d.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd=
.com&gt;<br>
Subject: [PATCH 1/2] Revert &quot;drm/amdgpu: add sysfs interface to set ar=
bitrary sclk value for navi14&quot;<br>
<br>
Revert this commit and than add debugfs interface to replace this to meet t=
he specitic requirement.<br>
<br>
This reverts commit 3107269204f8e18f389080673f7848b420970aa5.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp; | 42 -------=
------------------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c |&nbsp; 9 &#43;&#43;-----<b=
r>
&nbsp;2 files changed, 2 insertions(&#43;), 49 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 9deff8c..bc3cf04 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1034,40 &#43;1034,6 @@ static ssize_t amdgpu_read_mask(const char *buf,=
 size_t count, uint32_t *mask)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_set_pp_sclk(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const char *buf,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size_t count)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_get_d=
rvdata(dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ddev-&=
gt;dev_private;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev-&gt;=
dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtou32(buf, 0, &amp;value)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_soft_freq_range(&amp;adev-&gt;smu, SMU_SCLK, val=
ue, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;de=
v);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;d=
ev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
-}<br>
-<br>
&nbsp;static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
@@ -1829,8 &#43;1795,6 @@ static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IW=
USR,&nbsp; static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_table);<br>
-static DEVICE_ATTR(pp_sclk, S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; NULL, amdgpu_set_pp_sclk);<br>
&nbsp;static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_dpm_sclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_dpm_sclk);<br>
@@ -3322,12 &#43;3286,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_pp_sclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_sclk\n&quot;);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file=
(adev-&gt;dev, &amp;dev_attr_pp_dpm_sclk);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_s=
clk\n&quot;); diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/driv=
ers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
index 1507bb7..c9e5ce1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1803,17 &#43;1803,12 @@ int smu_v11_0_set_soft_freq_limited_range(struc=
t smu_context *smu, enum smu_clk_&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, clk_id =3D =
0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_freq, max_freq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_id =3D smu_clk_get_ind=
ex(smu, clk_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return clk_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_freq_range(smu, c=
lk_type, &amp;min_freq, &amp;max_freq, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max &gt; 0 &amp;&amp; max &lt;=3D=
&nbsp; max_freq) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; param =3D (uint32_t)((clk_id &lt;&lt; 16) | (max &amp=
; 0xffff));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetS=
oftMaxByFreq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 param);<br>
@@ -1821,7 &#43;1816,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct =
smu_context *smu, enum smu_clk_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (min &gt; 0 &amp;&amp; min &gt;=3D=
 min_freq) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (min &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; param =3D (uint32_t)((clk_id &lt;&lt; 16) | (min &amp=
; 0xffff));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetS=
oftMinByFreq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 param);<br>
--<br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C86a8aed9b2854f38626908d7bbff8780%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184578512568577&amp;amp;sdata=3D=
O1zVjtLbL6JRjrWzN23MARS6NlM8kUjLd3%2BKuxQOVbI%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C86a8aed9b2854f38626908d7bbff8780%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637184578512568577&amp;amp;sdata=3DO1zVjtLbL6JRjrW=
zN23MARS6NlM8kUjLd3%2BKuxQOVbI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912B467956CC1067B20B7A3F7E80CH2PR12MB3912namp_--

--===============1823444135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1823444135==--
