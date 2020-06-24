Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B771C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F79720578
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qe5kxtlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0066E833;
	Wed, 24 Jun 2020 20:35:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9C46E833
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 20:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj2RgKRY1fCic6NKlkSuZp8k6zQ8pX3sypGp9lanuCcR505x/pDh1m4J4XC6w1tCt+gFQbdBmFd8WN20bnpVaAps1LWU0akuMHMNNH0UwqTI2QJNIiEoer/F8lHGy9FZV/F5HgUMZVgSERmgvBbf1mDIzPCrWYM95iNTwTle2zAPAQesHRlgUWpT6Z/3Bh9MQVgBvjLw3gDQocgVXil0ZFm93BtGKIkz64ow+/nzFQ0jxMep3GcEBOQL6l6Qi3y2JATn8d/xT5N0IcG6xizZfeBFTmFkf4SSmFCm6XK1b2p8kYb57kF7JAL+qZHSw9OUjm0cNq77C1QPBYJkRD/i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxJBTAY029CSGXYBfo/Hd7C0WFolAAwFMUlOOiXmUQ=;
 b=mKXz8AMNYx7rZDnn0WiTDmhjsjqL+ATu8VeGZgY2x5Jm+qGeU/HdmN8HPf7uRWvvKVpITv7ljFa/1oAne7U61e/9xgKq9CDF5eiihR6Cgi3QBco4bZQzWiBN4M0pSOskF0cMgcahKI3fP+WbKCIA/gh2KJ3+fEhHP1r638NCNrIixqBLcyxS9ag6VQFcVB3fKEiI78RBXqz5JVwI13KwcQmLzoBFllFsumNqRPzbZ4xGSQvWNEqaHfSTon0jDCZC1k4gseFCMnNa+oSK6vuzlrfmb5cTpzyVlZj1k7oEGIvfEvF+3sd7Yyu6yxZSPgRZR79N9oRIlTIJjFPpJKZDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxJBTAY029CSGXYBfo/Hd7C0WFolAAwFMUlOOiXmUQ=;
 b=Qe5kxtljCu1QXVmadZFWl0Cbd0DakCUruWOc8GmJ7ZY5ZqtsSsxcFrg8iZG2juY3Qggjwp4RndUKtJav/nB//XdGZmMzmhZEMJFFMatVkuTlrMOhVf1lAxEoxyDJQuZxXDagbvaN/OMcX0KK2uMkeCXyoLZ6UQFYigUyZF0osyU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 20:35:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 20:35:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jivin, Alex" <Alex.Jivin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: SI support for UVD and VCE power managment
Thread-Topic: [PATCH 3/3] drm/amdgpu: SI support for UVD and VCE power
 managment
Thread-Index: AQHWSmaA6Ge8IQZkYE6nTNNirBxscajoOQxf
Date: Wed, 24 Jun 2020 20:35:22 +0000
Message-ID: <MN2PR12MB4488BD8607D8F25756B21DB0F7950@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200624203137.14377-1-alex.jivin@amd.com>,
 <20200624203137.14377-3-alex.jivin@amd.com>
In-Reply-To: <20200624203137.14377-3-alex.jivin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T20:35:21.666Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.187.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7eb4922d-6a5b-4392-b335-08d8187e1e12
x-ms-traffictypediagnostic: MN2PR12MB3920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB392077DEC86E960AFB89F3AAF7950@MN2PR12MB3920.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djtN7NoE0Djfi7103GFvFi+Qe1lthwBaIa//sdTtutjyTalxCcaGK938UwLM75WwD21oLwQvNUCcCCVH52dNQrBnDQ94DcOY3EqLedd5RqIj4NSiTE5laIjTueIxMIu7qE6cqrKIZsL7dnZA/VE2rKVYmne19rNoKxyBUN4BXQOtY9if5BHAKt3QL0NZUxfCUQbKj1Dnl4nz7RzvNYNlTId6o8sqiY53JYXGteX8VTCVFk7eCacyjH9ZdE60qHYAOZceacUJdWw+/2kGlSMA1J9Yl9yLAeJPQpXW2K7EvFnlaPvqiUT2TSj5Z6eak+Nqk7nxyze+jLqGbKe43iCOaBW4X6+5qL4tKRaQKUdcuVd3Qvf97vXHyuEo+1tkWIEi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8936002)(478600001)(66476007)(5660300002)(2906002)(71200400001)(66946007)(66446008)(64756008)(76116006)(83380400001)(66556008)(19627405001)(9686003)(33656002)(8676002)(7696005)(52536014)(110136005)(6506007)(53546011)(316002)(26005)(186003)(86362001)(55016002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UThxBaf8zFAUwb7B0or5KRMpHzT/yRZUqNezm3GUl7Q10UHJwGVi8GuKofS8IkzOsKBtGe1+eKYApMG12rcPqYx+r+hz54O9xC7c+OajTJMSmXJqLE3Pww6R3BUYhCSihYtrFZeGE87ekR6J9ai1MKxLV2Rj7f8Nzm53GSf1fcTGop3Gb+BP5BpPVU4btM1+EI+hUFar54EQdI+GKqdaeve9052lUvHrFoxZZIFVI+bsn98gpuUhwsnGrdCu34vS5OAxdkDiRpOAX+9pWXNNiT7tdVfarL2zTMSqRSJj/f5VOUzCzBowmN6lqwzGEiaWtybBDNuvdiAh8tesZioGxajZ3xgMjhb4itd11N+3vUTsrqgf3pm2Hp+YUzGV8cYof6axLsL18QCd+H75IkBjOPypCA1rH5WWWNXnEOFLWtwRxuv0UgX2D1Fwx8F68MVniX4RvmFBOcGYRfQWsC8vTX5g3X6Q1NLilNAlxbyIZ6VghKX5ftuPsBmPW9AZtdmW
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb4922d-6a5b-4392-b335-08d8187e1e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 20:35:22.1029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPlHx174kC0CNKNEzyjEEVQHMUpswTJO+Hv0qi9fYrBO37P/8U+VPw3V2dkk7m6OVjmltZML0dTlNyZ53MGa9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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
Content-Type: multipart/mixed; boundary="===============0008088412=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0008088412==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488BD8607D8F25756B21DB0F7950MN2PR12MB4488namp_"

--_000_MN2PR12MB4488BD8607D8F25756B21DB0F7950MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Jivin, Alex <Alex.Jivin@amd.com>
Sent: Wednesday, June 24, 2020 4:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: SI support for UVD and VCE power managment

Port functionality from the Radeon driver to support
UVD and VCE power management.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 67 +++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/si_dpm.c    | 19 ++++++++
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 347b06d3c140..26c8e39a78bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3558,21 +3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *ad=
ev, bool enable)
 {
         int ret =3D 0;

-       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_U=
VD, !enable);
-       if (ret)
-               DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
-                         enable ? "enable" : "disable", ret);
-
-       /* enable/disable Low Memory PState for UVD (4k videos) */
-       if (adev->asic_type =3D=3D CHIP_STONEY &&
-               adev->uvd.decode_image_width >=3D WIDTH_4K) {
-               struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
+       if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
+               if (enable) {
+                       mutex_lock(&adev->pm.mutex);
+                       adev->pm.dpm.uvd_active =3D true;
+                       adev->pm.dpm.state =3D POWER_STATE_TYPE_INTERNAL_UV=
D;
+                       mutex_unlock(&adev->pm.mutex);
+               } else {
+                       mutex_lock(&adev->pm.mutex);
+                       adev->pm.dpm.uvd_active =3D false;
+                       mutex_unlock(&adev->pm.mutex);
+               }

-               if (hwmgr && hwmgr->hwmgr_func &&
-                   hwmgr->hwmgr_func->update_nbdpm_pstate)
-                       hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
-                                                              !enable,
-                                                              true);
+               amdgpu_pm_compute_clocks(adev);
+       } else {
+               ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOC=
K_TYPE_UVD, !enable);
+               if (ret)
+                       DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
+                                 enable ? "enable" : "disable", ret);
+
+               /* enable/disable Low Memory PState for UVD (4k videos) */
+               if (adev->asic_type =3D=3D CHIP_STONEY &&
+                       adev->uvd.decode_image_width >=3D WIDTH_4K) {
+                       struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handl=
e;
+
+                       if (hwmgr && hwmgr->hwmgr_func &&
+                           hwmgr->hwmgr_func->update_nbdpm_pstate)
+                               hwmgr->hwmgr_func->update_nbdpm_pstate(hwmg=
r,
+                                                                      !ena=
ble,
+                                                                      true=
);
+               }
         }
 }

@@ -3580,10 +3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *ad=
ev, bool enable)
 {
         int ret =3D 0;

-       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_V=
CE, !enable);
-       if (ret)
-               DRM_ERROR("Dpm %s vce failed, ret =3D %d. \n",
-                         enable ? "enable" : "disable", ret);
+       if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
+               if (enable) {
+                       mutex_lock(&adev->pm.mutex);
+                       adev->pm.dpm.vce_active =3D true;
+                       /* XXX select vce level based on ring/task */
+                       adev->pm.dpm.vce_level =3D AMD_VCE_LEVEL_AC_ALL;
+                       mutex_unlock(&adev->pm.mutex);
+               } else {
+                       mutex_lock(&adev->pm.mutex);
+                       adev->pm.dpm.vce_active =3D false;
+                       mutex_unlock(&adev->pm.mutex);
+               }
+
+               amdgpu_pm_compute_clocks(adev);
+       } else {
+               ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOC=
K_TYPE_VCE, !enable);
+               if (ret)
+                       DRM_ERROR("Dpm %s vce failed, ret =3D %d. \n",
+                                 enable ? "enable" : "disable", ret);
+       }
 }

 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c
index c00ba4b23c9a..ea914b256ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6953,6 +6953,24 @@ static int si_power_control_set_level(struct amdgpu_=
device *adev)
         return 0;
 }

+static void si_set_vce_clock(struct amdgpu_device *adev,
+                            struct amdgpu_ps *new_rps,
+                            struct amdgpu_ps *old_rps)
+{
+       if ((old_rps->evclk !=3D new_rps->evclk) ||
+           (old_rps->ecclk !=3D new_rps->ecclk)) {
+               /* Turn the clocks on when encoding, off otherwise */
+               if (new_rps->evclk || new_rps->ecclk) {
+                       /* Place holder for future VCE1.0 porting to amdgpu
+                       vce_v1_0_enable_mgcg(adev, false, false);*/
+               } else {
+                       /* Place holder for future VCE1.0 porting to amdgpu
+                       vce_v1_0_enable_mgcg(adev, true, false);
+                       amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, ne=
w_rps->ecclk);*/
+               }
+       }
+}
+
 static int si_dpm_set_power_state(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -7029,6 +7047,7 @@ static int si_dpm_set_power_state(void *handle)
                 return ret;
         }
         ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
+       si_set_vce_clock(adev, new_ps, old_ps);
         if (eg_pi->pcie_performance_request)
                 si_notify_link_speed_change_after_state_change(adev, new_p=
s, old_ps);
         ret =3D si_set_power_state_conditionally_enable_ulv(adev, new_ps);
--
2.17.1


--_000_MN2PR12MB4488BD8607D8F25756B21DB0F7950MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jivin, Alex &lt;Alex.=
Jivin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 24, 2020 4:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: SI support for UVD and VCE power ma=
nagment</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Port functionality from the Radeon driver to suppo=
rt<br>
UVD and VCE power management.<br>
<br>
Signed-off-by: Alex Jivin &lt;alex.jivin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 67 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----=
--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dpm.c&nbsp;&nbsp;&nbsp; | 19 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 68 insertions(&#43;), 18 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 347b06d3c140..26c8e39a78bd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -3558,21 &#43;3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device=
 *adev, bool enable)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_powergating_by=
_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Dpm %s uvd failed, ret =3D %d. \n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enab=
le ? &quot;enable&quot; : &quot;disable&quot;, ret);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable/disable Low Memory PState f=
or UVD (4k videos) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_ST=
ONEY &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;uvd.decode_image_width &gt;=3D WIDTH_4K) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pp_hwmgr *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU=
_FAMILY_SI) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (enable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.uvd_active =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.state =3D POWER_STATE_TYPE_INTERNAL_UVD;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.uvd_active =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hwmgr &amp;&amp; hwmgr-&gt;hwmgr_func &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;update_nbdpm_ps=
tate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_=
func-&gt;update_nbdpm_pstate(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !enable=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK=
_TYPE_UVD, !enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&q=
uot;Dpm %s uvd failed, ret =3D %d. \n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable ? &quot;enable&quot;=
 : &quot;disable&quot;, ret);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* enable/disable Low Memory PState for UVD (4k videos) */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_STONEY &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd=
.decode_image_width &gt;=3D WIDTH_4K) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hw=
mgr *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &a=
mp;&amp; hwmgr-&gt;hwmgr_func &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;update_nbdpm_pstate)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;update_nbdpm_p=
state(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !enable,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
@@ -3580,10 &#43;3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device=
 *adev, bool enable)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_powergating_by=
_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Dpm %s vce failed, ret =3D %d. \n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enab=
le ? &quot;enable&quot; : &quot;disable&quot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU=
_FAMILY_SI) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (enable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.vce_active =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX selec=
t vce level based on ring/task */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.vce_level =3D AMD_VCE_LEVEL_AC_ALL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
dpm.vce_active =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK=
_TYPE_VCE, !enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&q=
uot;Dpm %s vce failed, ret =3D %d. \n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable ? &quot;enable&quot;=
 : &quot;disable&quot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_pm_print_power_states(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c<br>
index c00ba4b23c9a..ea914b256ebd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
@@ -6953,6 &#43;6953,24 @@ static int si_power_control_set_level(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void si_set_vce_clock(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_ps *new_rps,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_ps *old_rps)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((old_rps-&gt;evclk !=3D new_r=
ps-&gt;evclk) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (old_rps-=
&gt;ecclk !=3D new_rps-&gt;ecclk)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Turn the clocks on when encoding, off otherwise */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (new_rps-&gt;evclk || new_rps-&gt;ecclk) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Place hol=
der for future VCE1.0 porting to amdgpu<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v1_0_ena=
ble_mgcg(adev, false, false);*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Place hol=
der for future VCE1.0 porting to amdgpu<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v1_0_ena=
ble_mgcg(adev, true, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_=
set_vce_clocks(adev, new_rps-&gt;evclk, new_rps-&gt;ecclk);*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int si_dpm_set_power_state(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -7029,6 &#43;7047,7 @@ static int si_dpm_set_power_state(void *handle)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ni_set_uvd_clock_after_set=
_eng_clock(adev, new_ps, old_ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_set_vce_clock(adev, new_ps, ol=
d_ps);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (eg_pi-&gt;pcie_perform=
ance_request)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; si_notify_link_speed_change_after_state_change(adev, =
new_ps, old_ps);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D si_set_power_state=
_conditionally_enable_ulv(adev, new_ps);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488BD8607D8F25756B21DB0F7950MN2PR12MB4488namp_--

--===============0008088412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0008088412==--
