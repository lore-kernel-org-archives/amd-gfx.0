Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DDC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F9622AAA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F9622AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF546E454;
	Mon, 21 Dec 2020 04:31:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8278D6E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 04:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxoSlHfDdDtwqG0DexnbhjFqcyfN73waqSEgxMhymlwBtr+jVqGXVBiXw+I7M95HZWnV3HhthzZ30NJVKi+ZHmaYffee1Pn+UCLpqtiidzITwns7m5bPHX0lYjKiNEtViJ4u2Dc+a0L2OeodeLlVk+JuSTWxzQronfdJPadjJRe0wsd2zzn1PA4zQ1pIhwKeqiEXB3Ov7+KDRlIQDkfhbdUkvmXIDrGn/aiSo88mDVsn69MAzZ+fcEqhZaJK1rO2oU6R0uVmqtJL4uyqtPA3hVlHAXAFu2HpdWjK4QN8qi9gmVSz+jFgcozwWBC+vBxXDd/VjBGAUi15rkuVOBKIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c32IEo7AObmDp3VKrok5vsw5MUWiaQjOHHooPGli8i0=;
 b=K9mHzGt4kS441Ug0VNn/aibfoRwpO+YFN+hVXoeunDQul1K4uv36B/yn7BNidQmB5cs0Lxwak1A0n6w5XIiOg2IU8z5KupdyKWiPiQGM2g/0UqLt+8d8/4/Q5Ibfb7BVys4jBc95B+tnY0/o/zfqPRnx6M3N4Ndr7O2gW7OgGByUXbf4VOTsrmpoYqNvgIljphzzDf3PmUoiC//Nzz9sDRUuyfYnhP8T+EHLZKcNm9nRgeADYf9QLqcPXL0VSPgCATZ3MebP8nGmEEXHmXeCk33OX2itQeR7wFxPEv8KcimCL0hiuGYWzbjVr42Ew+zD6zv2tI00+S/6mfaPgXseXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c32IEo7AObmDp3VKrok5vsw5MUWiaQjOHHooPGli8i0=;
 b=enM6iIVo7VYhE90Iyj8+PwfiOyn9AgtNOQB4wrPpb4Ncmc+QFpnouNbzrx7T23UTVALAJNYzhp4bGYpJ/1v6P2S/CskMFnjz1oDKTNFhfkIQ9LIr9SZh3DpdKQjFdRshtopod9GSz/HtVRgjmFSsQ+ggLMaR68O78mImK/jzaoo=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3182.namprd12.prod.outlook.com (2603:10b6:208:107::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Mon, 21 Dec
 2020 04:31:08 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 04:31:08 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/8] amdgpu/pm: Powerplay API for smu , changed 9 pm power
 functions to use API
Thread-Topic: [PATCH 4/8] amdgpu/pm: Powerplay API for smu , changed 9 pm
 power functions to use API
Thread-Index: AQHW1aDHhCtJGwxnYUebUV6uC4hBGqoA9kBW
Date: Mon, 21 Dec 2020 04:31:08 +0000
Message-ID: <MN2PR12MB30227D86A5C14C6F846EED07A2C00@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201219004831.13527-1-darren.powell@amd.com>,
 <20201219004831.13527-5-darren.powell@amd.com>
In-Reply-To: <20201219004831.13527-5-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T04:31:08.578Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [111.42.32.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0de639be-3dbd-4031-92c2-08d8a5693cdd
x-ms-traffictypediagnostic: MN2PR12MB3182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3182BFB8641240B07E1A1583A2C00@MN2PR12MB3182.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+SmuUzlmupo32bIm54cTdNr0pUJ/3EqjQuVjZ5uUv/F4BTA2SCCk0+Iwj4eCibTUvrx+NKWFTX7fIsaTdsNSeFs+MScIfpHxzfx4DTnevRmVsnrBEeCkP/IP+Q2WMZI6kBlOtBL7i0fuIp+lZT5aFkHCpmo/ZRIMq9aXmY9tSuu2gtprsjHG0viPtWTPR8fcwsjr2YKZwbyektQpO7EgvifirKQDSBqcK5atDhQ0vZ+9OnzEsYomQh+wllMTDEswoQ/D1Mfu9zusP55THaDToKULioybemnBr0zrI0Qt6HaqTOvjTlCUj4b6KprE2bIHV7YHqidsKgumco84AJHWN4iexjLuvriZ8GUW8upRa+4RLMoRbZvcmHoF9TmvsXXxw2Jz0Ah7D5Bbjz8sU2/MQ9BlDHBh23esZExeE5ihEU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(45080400002)(478600001)(26005)(186003)(110136005)(966005)(8676002)(316002)(8936002)(7696005)(52536014)(66446008)(66946007)(66476007)(91956017)(66556008)(64756008)(76116006)(86362001)(55016002)(5660300002)(2906002)(6506007)(33656002)(30864003)(9686003)(166002)(19627405001)(71200400001)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G3/D6GCBDiBlKrpHqOJpFLh0v/Fkr7r5KCHBeOeFyUpiKZUqXrmc/kPSyj?=
 =?iso-8859-1?Q?btSBBZnczx0nqqEQ0W/lCuvBv8/+7baxWFZIEFAH13jYiOQ0TP5d/O6enV?=
 =?iso-8859-1?Q?W5/Hjldp9tUeEVbemXIG/9RK9v726grAxe1vkV6meY6qDP5QHKpl64CflE?=
 =?iso-8859-1?Q?KTTpRG2MT195hIjWkjdEMPcimmS7S1SvohhIOenR1J+sJhhRuUAg9pWA8E?=
 =?iso-8859-1?Q?z4LCGHbMCDeHKcie+cyy5VsuMmZQu2MF7KZ+MXhkdUEevjGG1lahRVCJCQ?=
 =?iso-8859-1?Q?6OSLICbSUvIVyVmthHZryrC8waA8Ph6uhY/5lTAldUUys28sMWBqIaIUcF?=
 =?iso-8859-1?Q?8H6rW4J5xQiqQlOt+2vfTux1bhER/zh9bm+oW/nhcckzP1w2w83JixtfIC?=
 =?iso-8859-1?Q?TzauvgJTPKFVPaugpDgdB9R9V1C6dMO5Y9f9MZ91hkrukHjoNlOyCuO84e?=
 =?iso-8859-1?Q?AW5iFsIuR0+tAeJuJa0hY4BLFW0c2Zb2rj6R9pvXrO8/6MlWVkv/u3WrdV?=
 =?iso-8859-1?Q?Ich6qOxiVL15Qtzj7oilBRbHpjmoEYrqadTnbnah//CgP3vFOmpHRApwTe?=
 =?iso-8859-1?Q?B0VtmvdqwaeqJlot8OY173gSpsfz1kd9AO8aprHS4MOXNVnOz2zRmtHBp0?=
 =?iso-8859-1?Q?FUMe1OwUr9EYwFesNNAELqb8Pu7Fza9FFQfdwx/N121hwgLC/zRS8NPKdG?=
 =?iso-8859-1?Q?tnoMOtZBO7tiS4pkoON1ZdQ8hv4WBn+pZgL2pSk+w+aleL8UkIqe/XZw1Y?=
 =?iso-8859-1?Q?0TyIOeGlRpEWyeLzNPohmlA+sQmeBSrFk/MNCHllkRkx9syFMO0zxBqPri?=
 =?iso-8859-1?Q?p9ddzhnm9SyNvrvvRUQ9YnVqg3nz9KpV127bMh7o18PH8IANCKm+YE452J?=
 =?iso-8859-1?Q?izydeQoETNEpPs3JeOqAhvte3165vn/tm4p/KLQLllx29kzHlA5Nw69/eq?=
 =?iso-8859-1?Q?zOfsffirsjLa20x5riD7o08ssSfQPJ9InyVEAN7wYsCgqocHOM4jn14izL?=
 =?iso-8859-1?Q?Y/lMOrTbt82MTBCSI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de639be-3dbd-4031-92c2-08d8a5693cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 04:31:08.2919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym56qROK1+iF7Niq7nuFVdkLFaz847g8607yZLfzNRakfQa7/XD+wrTzYGPMvAbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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
Content-Type: multipart/mixed; boundary="===============1791564442=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1791564442==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30227D86A5C14C6F846EED07A2C00MN2PR12MB3022namp_"

--_000_MN2PR12MB30227D86A5C14C6F846EED07A2C00MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Darren P=
owell <darren.powell@amd.com>
Sent: Saturday, December 19, 2020 8:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 4/8] amdgpu/pm: Powerplay API for smu , changed 9 pm power =
functions to use API

Modified Files
  smu_get_power_limit()         - modifed arg0 to match Powerplay API get_p=
ower_limit
  smu_set_power_limit()         - modifed arg0 to match Powerplay API set_p=
ower_limit
  smu_sys_get_pp_table()        - modifed signature to match Powerplay API =
get_pp_table
  smu_get_power_num_states()    - modifed arg0 to match Powerplay API get_p=
p_num_states
  smu_get_current_power_state() - modifed arg0 to match Powerplay API get_c=
urrent_power_state
  smu_sys_get_pp_feature_mask() - modifed signature to match Powerplay API =
get_ppfeature_status
  smu_sys_set_pp_feature_mask() - modifed arg0 to match Powerplay API set_p=
pfeature_status

Other Changes
  added 7 above smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerp=
lay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 73 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 16 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 59 +++++++++++-------
 3 files changed, 69 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b345c29147b9..41da5870af58 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -124,6 +124,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device=
 *dev,
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         enum amd_pm_state_type pm;
         int ret;

@@ -136,12 +137,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct devic=
e *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               if (adev->smu.ppt_funcs->get_current_power_state)
-                       pm =3D smu_get_current_power_state(&adev->smu);
-               else
-                       pm =3D adev->pm.dpm.user_state;
-       } else if (adev->powerplay.pp_funcs->get_current_power_state) {
+       if (pp_funcs->get_current_power_state) {
                 pm =3D amdgpu_dpm_get_current_power_state(adev);
         } else {
                 pm =3D adev->pm.dpm.user_state;
@@ -307,6 +303,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         enum amd_dpm_forced_level level;
         enum amd_dpm_forced_level current_level =3D 0xff;
         int ret =3D 0;
@@ -342,9 +339,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev))
-               current_level =3D smu_get_performance_level(&adev->smu);
-       else if (adev->powerplay.pp_funcs->get_performance_level)
+       if (pp_funcs->get_performance_level)
                 current_level =3D amdgpu_dpm_get_performance_level(adev);

         if (current_level =3D=3D level) {
@@ -381,7 +376,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,
                         pm_runtime_put_autosuspend(ddev->dev);
                         return -EINVAL;
                 }
-       } else if (adev->powerplay.pp_funcs->force_performance_level) {
+       } else if (pp_funcs->force_performance_level) {
                 mutex_lock(&adev->pm.mutex);
                 if (adev->pm.dpm.thermal_active) {
                         mutex_unlock(&adev->pm.mutex);
@@ -412,6 +407,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         struct pp_states_info data;
         int i, buf_len, ret;

@@ -424,12 +420,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device=
 *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               ret =3D smu_get_power_num_states(&adev->smu, &data);
-               if (ret)
+       if (pp_funcs->get_pp_num_states) {
+               ret =3D amdgpu_dpm_get_pp_num_states(adev, &data);
+               if (is_support_sw_smu(adev) && ret)
                         return ret;
-       } else if (adev->powerplay.pp_funcs->get_pp_num_states) {
-               amdgpu_dpm_get_pp_num_states(adev, &data);
         } else {
                 memset(&data, 0, sizeof(data));
         }
@@ -454,8 +448,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *d=
ev,
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         struct pp_states_info data;
-       struct smu_context *smu =3D &adev->smu;
         enum amd_pm_state_type pm =3D 0;
         int i =3D 0, ret =3D 0;

@@ -468,15 +462,13 @@ static ssize_t amdgpu_get_pp_cur_state(struct device =
*dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               pm =3D smu_get_current_power_state(smu);
-               ret =3D smu_get_power_num_states(smu, &data);
-               if (ret)
-                       return ret;
-       } else if (adev->powerplay.pp_funcs->get_current_power_state
-                && adev->powerplay.pp_funcs->get_pp_num_states) {
+       if (pp_funcs->get_current_power_state
+                && pp_funcs->get_pp_num_states) {
                 pm =3D amdgpu_dpm_get_current_power_state(adev);
-               amdgpu_dpm_get_pp_num_states(adev, &data);
+               ret =3D amdgpu_dpm_get_pp_num_states(adev, &data);
+
+               if (is_support_sw_smu(adev) && ret)
+                       return ret;
[kevin]:
why we need this workaround for swsmu ?
after using amd_pm_funcs as a proxy, these judgments should not be required=
.
otherwise, can you help me understand it , thanks.
         }

         pm_runtime_mark_last_busy(ddev->dev);
@@ -589,13 +581,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               size =3D smu_sys_get_pp_table(&adev->smu, (void **)&table);
-               pm_runtime_mark_last_busy(ddev->dev);
-               pm_runtime_put_autosuspend(ddev->dev);
-               if (size < 0)
-                       return size;
-       } else if (adev->powerplay.pp_funcs->get_pp_table) {
+       if (adev->powerplay.pp_funcs->get_pp_table) {
                 size =3D amdgpu_dpm_get_pp_table(adev, &table);
                 pm_runtime_mark_last_busy(ddev->dev);
                 pm_runtime_put_autosuspend(ddev->dev);
@@ -989,9 +975,7 @@ static ssize_t amdgpu_get_pp_features(struct device *de=
v,
                 return ret;
         }

-       if (is_support_sw_smu(adev))
-               size =3D smu_sys_get_pp_feature_mask(&adev->smu, buf);
-       else if (adev->powerplay.pp_funcs->get_ppfeature_status)
+       if (adev->powerplay.pp_funcs->get_ppfeature_status)
                 size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
         else
                 size =3D snprintf(buf, PAGE_SIZE, "\n");
@@ -2862,6 +2846,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,
                                          char *buf)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         uint32_t limit =3D 0;
         ssize_t size;
         int r;
@@ -2875,10 +2860,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struc=
t device *dev,
                 return r;
         }

-       if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, true);
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-       } else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->ge=
t_power_limit) {
+       if (pp_funcs && pp_funcs->get_power_limit) {
                 adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.=
pp_handle, &limit, true);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else {
@@ -2896,6 +2878,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,
                                          char *buf)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         uint32_t limit =3D 0;
         ssize_t size;
         int r;
@@ -2909,11 +2892,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct de=
vice *dev,
                 return r;
         }

-       if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, false);
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-       } else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->ge=
t_power_limit) {
-               adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.p=
p_handle, &limit, false);
+       if (pp_funcs && pp_funcs->get_power_limit) {
+               pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit=
, false);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else {
                 size =3D snprintf(buf, PAGE_SIZE, "\n");
@@ -2932,6 +2912,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct devi=
ce *dev,
                 size_t count)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         int err;
         u32 value;

@@ -2954,10 +2935,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,
                 return err;
         }

-       if (is_support_sw_smu(adev))
-               err =3D smu_set_power_limit(&adev->smu, value);
-       else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_=
power_limit)
-               err =3D adev->powerplay.pp_funcs->set_power_limit(adev->pow=
erplay.pp_handle, value);
+       if (pp_funcs && pp_funcs->set_power_limit)
+               err =3D pp_funcs->set_power_limit(adev->powerplay.pp_handle=
, value);
         else
                 err =3D -EINVAL;

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 9f739d1b18d5..8471b42587d3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -659,11 +659,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool ena=
bled);

 int smu_set_fan_speed_rpm(void *handle, uint32_t speed);

-int smu_get_power_limit(struct smu_context *smu,
-                       uint32_t *limit,
-                       bool max_setting);
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);

-int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
+int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_ty=
pe, char *buf);

 int smu_od_edit_dpm_table(struct smu_context *smu,
@@ -718,10 +716,10 @@ extern const struct amdgpu_ip_block_version smu_v12_0=
_ip_block;

 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
-int smu_sys_get_pp_table(struct smu_context *smu, void **table);
+int smu_sys_get_pp_table(void *handle, char **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)=
;
-int smu_get_power_num_states(struct smu_context *smu, struct pp_states_inf=
o *state_info);
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
);
+int smu_get_power_num_states(void *handle, struct pp_states_info *state_in=
fo);
+enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
 int smu_set_watermarks_for_clock_ranges(
                 struct smu_context *smu,
@@ -747,8 +745,8 @@ enum amd_dpm_forced_level smu_get_performance_level(voi=
d *handle);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forc=
ed_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
);
+int smu_sys_get_pp_feature_mask(void *handle, char *buf);
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
                          enum smu_clk_type clk_type,
                          uint32_t mask);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index acde0e831bb8..caed6a10ccd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -48,9 +48,10 @@

 static const struct amd_pm_funcs swsmu_dpm_funcs;

-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
+int smu_sys_get_pp_feature_mask(void *handle, char *buf)
 {
-       size_t size =3D 0;
+       struct smu_context *smu =3D handle;
+       int size =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;
@@ -64,8 +65,9 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *sm=
u, char *buf)
         return size;
 }

-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
)
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -268,7 +270,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uin=
t32_t block_type,
         return ret;
 }

-int smu_get_power_num_states(struct smu_context *smu,
+int smu_get_power_num_states(void *handle,
                              struct pp_states_info *state_info)
 {
         if (!state_info)
@@ -290,8 +292,9 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
         return false;
 }

-int smu_sys_get_pp_table(struct smu_context *smu, void **table)
+int smu_sys_get_pp_table(void *handle, char **table)
 {
+       struct smu_context *smu =3D handle;
         struct smu_table_context *smu_table =3D &smu->smu_table;
         uint32_t powerplay_table_size;

@@ -1914,10 +1917,9 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t spe=
ed)
         return ret;
 }

-int smu_get_power_limit(struct smu_context *smu,
-                       uint32_t *limit,
-                       bool max_setting)
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting)
 {
+       struct smu_context *smu =3D handle;
         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;

@@ -1930,8 +1932,9 @@ int smu_get_power_limit(struct smu_context *smu,
         return 0;
 }

-int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
+int smu_set_power_limit(void *handle, uint32_t limit)
 {
+       struct smu_context *smu =3D handle;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2482,8 +2485,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
         return ret;
 }

-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
)
+enum amd_pm_state_type smu_get_current_power_state(void *handle)
 {
+       struct smu_context *smu =3D handle;
         enum amd_pm_state_type pm_state =3D POWER_STATE_TYPE_DEFAULT;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2569,19 +2573,28 @@ int smu_gfx_state_change_set(struct smu_context *sm=
u, uint32_t state)

 static const struct amd_pm_funcs swsmu_dpm_funcs =3D {
         /* export for sysfs */
-       .set_fan_control_mode  =3D smu_set_fan_control_mode,
-       .get_fan_control_mode  =3D smu_get_fan_control_mode,
-       .set_fan_speed_percent =3D smu_set_fan_speed_percent,
-       .get_fan_speed_percent =3D smu_get_fan_speed_percent,
-       .get_performance_level =3D smu_get_performance_level,
-       .get_fan_speed_rpm     =3D smu_get_fan_speed_rpm,
-       .set_fan_speed_rpm     =3D smu_set_fan_speed_rpm,
-       .switch_power_profile  =3D smu_switch_power_profile,
+       .set_fan_control_mode    =3D smu_set_fan_control_mode,
+       .get_fan_control_mode    =3D smu_get_fan_control_mode,
+       .set_fan_speed_percent   =3D smu_set_fan_speed_percent,
+       .get_fan_speed_percent   =3D smu_get_fan_speed_percent,
+       .get_performance_level   =3D smu_get_performance_level,
+       .get_current_power_state =3D smu_get_current_power_state,
+       .get_fan_speed_rpm       =3D smu_get_fan_speed_rpm,
+       .set_fan_speed_rpm       =3D smu_set_fan_speed_rpm,
+       .get_pp_num_states       =3D smu_get_power_num_states,
+       .get_pp_table            =3D smu_sys_get_pp_table,
+       .switch_power_profile    =3D smu_switch_power_profile,
         /* export to amdgpu */
-       .set_mp1_state         =3D smu_set_mp1_state,
+       .set_power_limit         =3D smu_set_power_limit,
+       .get_power_limit         =3D smu_get_power_limit,
+       .set_mp1_state           =3D smu_set_mp1_state,
         /* export to DC */
-       .enable_mgpu_fan_boost =3D smu_enable_mgpu_fan_boost,
-       .asic_reset_mode_2     =3D smu_mode2_reset,
-       .set_df_cstate         =3D smu_set_df_cstate,
-       .set_xgmi_pstate       =3D smu_set_xgmi_pstate,
+       .enable_mgpu_fan_boost   =3D smu_enable_mgpu_fan_boost,
+       .get_ppfeature_status    =3D smu_sys_get_pp_feature_mask,
+       .set_ppfeature_status    =3D smu_sys_set_pp_feature_mask,
+       .asic_reset_mode_2       =3D smu_mode2_reset,
+       .set_df_cstate           =3D smu_set_df_cstate,
+       .set_xgmi_pstate         =3D smu_set_xgmi_pstate,
+
+
[kevin]:
the blank line is not neccessary,
please use "checkpatch.pl' to check coding style problems before patch revi=
ew.
 };
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cadb6f74a626d43c7614408d8a3b7e7c2%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637439357569667769%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dl9=
C5i335WmTBCjhwE41%2B3Fi5ZSHP15IhY4qsQCGFzWo%3D&amp;reserved=3D0

--_000_MN2PR12MB30227D86A5C14C6F846EED07A2C00MN2PR12MB3022namp_
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
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
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
<b>Subject:</b> [PATCH 4/8] amdgpu/pm: Powerplay API for smu , changed 9 pm=
 power functions to use API</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Modified Files<br>
&nbsp; smu_get_power_limit()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; - modifed arg0 to match Powerplay API get_power_limit<br>
&nbsp; smu_set_power_limit()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; - modifed arg0 to match Powerplay API set_power_limit<br>
&nbsp; smu_sys_get_pp_table()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - m=
odifed signature to match Powerplay API get_pp_table<br>
&nbsp; smu_get_power_num_states()&nbsp;&nbsp;&nbsp; - modifed arg0 to match=
 Powerplay API get_pp_num_states<br>
&nbsp; smu_get_current_power_state() - modifed arg0 to match Powerplay API =
get_current_power_state<br>
&nbsp; smu_sys_get_pp_feature_mask() - modifed signature to match Powerplay=
 API get_ppfeature_status<br>
&nbsp; smu_sys_set_pp_feature_mask() - modifed arg0 to match Powerplay API =
set_ppfeature_status<br>
<br>
Other Changes<br>
&nbsp; added 7 above smu Powerplay functions to swsmu_dpm_funcs<br>
&nbsp; removed special smu handling of above functions and called through P=
owerplay API<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 73 ++++++++---------------<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; | 16 +++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 59 +++++++++++-------<br>
&nbsp;3 files changed, 69 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b345c29147b9..41da5870af58 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -124,6 +124,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device=
 *dev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
@@ -136,12 +137,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct devic=
e *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;smu.ppt_funcs-&gt;get_current_power_state)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm =3D smu_get_c=
urrent_power_state(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm =3D adev-&gt;=
pm.dpm.user_state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;get_current_power_state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_current_power_st=
ate) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm =3D amdgpu_dpm_get_current_power_state(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm =3D adev-&gt;pm.dpm.user_state;<br>
@@ -307,6 +303,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
current_level =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -342,9 +339,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; current_level =3D smu_get_performance_level(&amp;adev-&gt;smu);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_performance_leve=
l)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; current_level =3D amdgpu_dpm_get_performance_level(ad=
ev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (current_level =3D=3D l=
evel) {<br>
@@ -381,7 +376,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_ru=
ntime_put_autosuspend(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;force_performance_level) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs-&gt;force_perform=
ance_level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.thermal_active) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex=
_unlock(&amp;adev-&gt;pm.mutex);<br>
@@ -412,6 +407,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info data=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, buf_len, ret;<br>
&nbsp;<br>
@@ -424,12 +420,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_get_power_num_states(&amp;adev-&gt;smu, &amp;data);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_pp_num_states) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (is_support_sw_smu(adev) &amp;&amp; ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;get_pp_num_states) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(&amp;data, 0, sizeof(data));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -454,8 +448,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *d=
ev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info data=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev=
-&gt;smu;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0, ret =3D 0;<br=
>
&nbsp;<br>
@@ -468,15 +462,13 @@ static ssize_t amdgpu_get_pp_cur_state(struct device =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm =3D smu_get_current_power_state(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_get_power_num_states(smu, &amp;data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;get_current_power_state<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;get_pp_num_stat=
es) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_current_power_st=
ate<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;&amp; pp_funcs-&gt;get_pp_num_states) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm =3D amdgpu_dpm_get_current_power_state(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (is_support_sw_smu(adev) &amp;&amp; ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</div=
>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">why we need this workaround for swsmu ?</div>
<div class=3D"PlainText">after using amd_pm_funcs as a proxy, these judgmen=
ts should not be required.</div>
<div class=3D"PlainText">otherwise, can you help me understand it , thanks.=
</div>
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
@@ -589,13 +581,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D smu_sys_get_pp_table(&amp;adev-&gt;smu, (void **)&amp;t=
able);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (size &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;get_pp_table) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_pp_table) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_pp_table(adev, &amp;table);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
@@ -989,9 +975,7 @@ static ssize_t amdgpu_get_pp_features(struct device *de=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D smu_sys_get_pp_feature_mask(&amp;adev-&gt;smu, buf);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_ppfeature_status)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_ppfeature_status)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br=
>
@@ -2862,6 +2846,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2875,10 +2860,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struc=
t device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp_funcs-&gt;=
get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(adev-=
&gt;powerplay.pp_handle, &amp;limit, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -2896,6 +2878,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2909,11 +2892,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(adev-&gt;powerpl=
ay.pp_handle, &amp;limit, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp_funcs-&gt;=
get_power_limit) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_handle, &amp;=
limit, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br=
>
@@ -2932,6 +2912,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&nbsp;<br>
@@ -2954,10 +2935,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D smu_set_power_limit(&amp;adev-&gt;smu, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs =
&amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;set_power_limit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D adev-&gt;powerplay.pp_funcs-&gt;set_power_limit(adev-&gt=
;powerplay.pp_handle, value);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp_funcs-&gt;=
set_power_limit)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D pp_funcs-&gt;set_power_limit(adev-&gt;powerplay.pp_handl=
e, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 9f739d1b18d5..8471b42587d3 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -659,11 +659,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool ena=
bled);<br>
&nbsp;<br>
&nbsp;int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<br>
&nbsp;<br>
-int smu_get_power_limit(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *limit,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool max_setting=
);<br>
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);<=
br>
&nbsp;<br>
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit);<br>
+int smu_set_power_limit(void *handle, uint32_t limit);<br>
&nbsp;int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type c=
lk_type, char *buf);<br>
&nbsp;<br>
&nbsp;int smu_od_edit_dpm_table(struct smu_context *smu,<br>
@@ -718,10 +716,10 @@ extern const struct amdgpu_ip_block_version smu_v12_0=
_ip_block;<br>
&nbsp;<br>
&nbsp;bool is_support_sw_smu(struct amdgpu_device *adev);<br>
&nbsp;int smu_reset(struct smu_context *smu);<br>
-int smu_sys_get_pp_table(struct smu_context *smu, void **table);<br>
+int smu_sys_get_pp_table(void *handle, char **table);<br>
&nbsp;int smu_sys_set_pp_table(struct smu_context *smu,&nbsp; void *buf, si=
ze_t size);<br>
-int smu_get_power_num_states(struct smu_context *smu, struct pp_states_inf=
o *state_info);<br>
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
);<br>
+int smu_get_power_num_states(void *handle, struct pp_states_info *state_in=
fo);<br>
+enum amd_pm_state_type smu_get_current_power_state(void *handle);<br>
&nbsp;int smu_write_watermarks_table(struct smu_context *smu);<br>
&nbsp;int smu_set_watermarks_for_clock_ranges(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_context *smu,<br>
@@ -747,8 +745,8 @@ enum amd_dpm_forced_level smu_get_performance_level(voi=
d *handle);<br>
&nbsp;int smu_force_performance_level(struct smu_context *smu, enum amd_dpm=
_forced_level level);<br>
&nbsp;int smu_set_display_count(struct smu_context *smu, uint32_t count);<b=
r>
&nbsp;int smu_set_ac_dc(struct smu_context *smu);<br>
-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);<br=
>
-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
);<br>
+int smu_sys_get_pp_feature_mask(void *handle, char *buf);<br>
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);<br>
&nbsp;int smu_force_clk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum smu_clk_type clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 uint32_t mask);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index acde0e831bb8..caed6a10ccd4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -48,9 +48,10 @@<br>
&nbsp;<br>
&nbsp;static const struct amd_pm_funcs swsmu_dpm_funcs;<br>
&nbsp;<br>
-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)<br>
+int smu_sys_get_pp_feature_mask(void *handle, char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
@@ -64,8 +65,9 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *sm=
u, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
)<br>
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
@@ -268,7 +270,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uin=
t32_t block_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_power_num_states(struct smu_context *smu,<br>
+int smu_get_power_num_states(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info *state_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!state_info)<br>
@@ -290,8 +292,9 @@ bool is_support_sw_smu(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_sys_get_pp_table(struct smu_context *smu, void **table)<br>
+int smu_sys_get_pp_table(void *handle, char **table)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t powerplay_table_s=
ize;<br>
&nbsp;<br>
@@ -1914,10 +1917,9 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t spe=
ed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_power_limit(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *limit,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool max_setting=
)<br>
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting)<b=
r>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
@@ -1930,8 +1932,9 @@ int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit)<br>
+int smu_set_power_limit(void *handle, uint32_t limit)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
@@ -2482,8 +2485,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
)<br>
+enum amd_pm_state_type smu_get_current_power_state(void *handle)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm_=
state =3D POWER_STATE_TYPE_DEFAULT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
@@ -2569,19 +2573,28 @@ int smu_gfx_state_change_set(struct smu_context *sm=
u, uint32_t state)<br>
&nbsp;<br>
&nbsp;static const struct amd_pm_funcs swsmu_dpm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export for sysfs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode&nbsp; =3D smu_s=
et_fan_control_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode&nbsp; =3D smu_g=
et_fan_control_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D smu_set_fa=
n_speed_percent,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D smu_get_fa=
n_speed_percent,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level =3D smu_get_pe=
rformance_level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp; =3D smu_get_fan_speed_rpm,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp; =3D smu_set_fan_speed_rpm,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .switch_power_profile&nbsp; =3D smu_s=
witch_power_profile,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode&nbsp;&nbsp;&nbs=
p; =3D smu_set_fan_control_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode&nbsp;&nbsp;&nbs=
p; =3D smu_get_fan_control_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent&nbsp;&nbsp; =
=3D smu_set_fan_speed_percent,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent&nbsp;&nbsp; =
=3D smu_get_fan_speed_percent,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level&nbsp;&nbsp; =
=3D smu_get_performance_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_power_state =3D smu_get_=
current_power_state,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D smu_get_fan_speed_rpm,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D smu_set_fan_speed_rpm,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_num_states&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D smu_get_power_num_states,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_table&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_sys_get_pp_table,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .switch_power_profile&nbsp;&nbsp;&nbs=
p; =3D smu_switch_power_profile,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export to amdgpu */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_mp1_state,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_power_limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_get_power_limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_mp1_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export to DC */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost =3D smu_enable=
_mgpu_fan_boost,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_reset_mode_2&nbsp;&nbsp;&nbsp;&=
nbsp; =3D smu_mode2_reset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_df_cstate,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_xgmi_pstate&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D smu_set_xgmi_pstate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost&nbsp;&nbsp; =
=3D smu_enable_mgpu_fan_boost,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status&nbsp;&nbsp;&nbs=
p; =3D smu_sys_get_pp_feature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status&nbsp;&nbsp;&nbs=
p; =3D smu_sys_set_pp_feature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_reset_mode_2&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D smu_mode2_reset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_df_cstate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_xgmi_pstate&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_set_xgmi_pstate,<br>
+<br>
+</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">the blank line is not neccessary,</div>
<div class=3D"PlainText">please use &quot;checkpatch.pl' to check coding st=
yle problems before patch review.</div>
<div class=3D"PlainText">&nbsp;};<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cadb6f74a626d43c7614408d8a3b7e7c2%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637439357569667769%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dl9C5i335WmTBCjhwE41%2B3Fi5ZSHP15IhY4qsQCGFzWo%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7CKevin1.Wang%40amd.com%7Cadb6f74a626d43c7614408d8a3b7e7c2%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637439357569667769%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3Dl9C5i335WmTBCjhwE41%2B3Fi5ZSHP15IhY4qsQCGFzWo%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30227D86A5C14C6F846EED07A2C00MN2PR12MB3022namp_--

--===============1791564442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1791564442==--
