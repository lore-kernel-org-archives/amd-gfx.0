Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE66EC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503B020B1F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4b/XwA4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCC16E2BD;
	Wed,  6 May 2020 15:24:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CC46E2BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 15:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B38Gjf7sg5BSfQl+ib/TPc6s9aAZhI588tcxwGWNfw9+696FtmJEAFsnYeTLmbs1X02TGZrm/XZm6B+XhUDozLSny4EPJW+1OT7vuLszB0ldh6x0QU513LHkyTJjpFe7vPpbbOfpptKkCPu6iTO7RgnKnOSC1RKAf19uJaESpH50aReDX1zx/5Fnq7zv21r4JSDUHcKSE3x5M28jrmUWkAhePb6et2323RN9bViyH9OpQhIpnWqgLhhattPO21ce7oL09+Yqw2tvqZf9Spw7msIbBRTktWrNs6GZUKnCi6vAJCgr+zvHaFp1gU1bYCvJtkuV8vRneqpojJygV46y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFldBWQQlcKxVOP2xup+n5RdsYIxjrGRkp8JTRy+Jmo=;
 b=clZ3U9gPdTzvR+3aD/Uv0cRutVCs/lesTzsSACcwxqI3Tb+RV5tRjXIgmCau0miaebBCE8VJWAXBFjB2yNwXFnwxociPnsdFCYu8ocEMemDnGFw3xLyxnNSompEz2+JqxDWr1FRuZj9KIm3b02H/eBgrIeiP6YDOmAP2rbE2lwwv+JEYeZu/kFa27LFbcHbGeB9NLfCFD9B5RLrOB3GIpgmls6VYTKdKxfbeF3vVNwZ0iRh0JsBKw5sqXFpWdEDeI82Jdy0RoR+B+0M43LDupY8/PIeiEktfmrW7AwbiwMP2XS3M/eccRk0gVkc9KuQ8OJNo6PjZ5RBry95omkkHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFldBWQQlcKxVOP2xup+n5RdsYIxjrGRkp8JTRy+Jmo=;
 b=4b/XwA4ocrNXbzxEpU1lwxB6Jf8yCeUCmLwk7Ik1DMK5Vl04o1dFKYJ4PcKF+dKsCwYN0m32ibPjHpgWRkwvLsIb3HY1iI0zFnAQNPlZFWYXdFBNNJXPfgAI6BJVGN0/DkjUrXZBvQXU2zHzmRerxniZa6Y4ElP5Mbz+RBPaFFc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 15:24:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%7]) with mapi id 15.20.2958.033; Wed, 6 May 2020
 15:24:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code
Thread-Index: AQHWI27hqd1EN9gtNk+a55dbSA2i+KiayfWAgAAbdYCAAEgTIg==
Date: Wed, 6 May 2020 15:24:01 +0000
Message-ID: <MN2PR12MB4488FCBAE34F505EB081BE46F7A40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200506062314.16040-1-kevin1.wang@amd.com>
 <20200506062314.16040-2-kevin1.wang@amd.com>,
 <DM6PR12MB4075C26C1CB012FA4ABBF497FCA40@DM6PR12MB4075.namprd12.prod.outlook.com>,
 <BY5PR12MB4068E70046BE5B137CAAD056A2A40@BY5PR12MB4068.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4068E70046BE5B137CAAD056A2A40@BY5PR12MB4068.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T15:24:01.152Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.37.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 921665de-f354-4ea7-be87-08d7f1d18192
x-ms-traffictypediagnostic: MN2PR12MB2943:|MN2PR12MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2943B61DD719DFD8B1CB1059F7A40@MN2PR12MB2943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5d84e5PvG3SBA/VHWwSY168oz/SeC2ffJmF87cR3zxX5QAuYUZETmfmsN91BT344M6yTRNJeHIwRAG2+tQomUXBhTKQilDqpVYHuS+4dtMSu7oIRINLPI+PrWRUNQ5Be5cEyv1mhhKihh2adZjPP74n7p21J6vJESkFMC6owlQdhwEeDypeYAyE7OMShqa7mqBEx2LWQ6yj70D799YRQx0EKqDUB6vp6wAPkWumo5h4G/3dGsuIQ5zBGOnDxurWWi6tLmCi8r2UzfYm51lnYrYq5zLsNDprgYg/sJRn41Pg69wmZXCPo2m+5+4hULKb3Rn0IzQWAFf7+maETZKx0pCut53YakhClgzGN43n7pBPJY8pgG8Sm5ZMLBSp7slcry1/pSqI2D1mm4nCpHRKj9euzQdbtbkr8C6f84ZDkAAftgFdmvRzOgItnk7ogvmiIJXnYHX2EMXFw3iPVqOkYx/GIqBc0LfeRO964WkI7amiiArwYuDHnpnikp4qtJ5lhhgWN0lgtr8cdQzShpVcH7xDP+OXr3v2Z3jum3F0Fws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(33430700001)(54906003)(30864003)(6506007)(478600001)(110136005)(8676002)(76116006)(66946007)(55016002)(19627405001)(4326008)(52536014)(9686003)(7696005)(186003)(316002)(71200400001)(64756008)(66556008)(33656002)(66476007)(53546011)(2906002)(5660300002)(8936002)(33440700001)(86362001)(26005)(66446008)(21314003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lYnMz8RjqlyNtnh2+nJowELO06wJTSqZj/3cTMZL6kh5q5O575mugCjHPz8DLuLAYF4v5YAT15LH/ByXHhktCMR1OJci2juuLiVvr9iATSkg+dZ2qZW6cE1VS0OwF/4VAmUMdHjBQHb9eLBU6lSf2qHlK/67WgRXyZEizx49bt+BoZ1PWmPuZn5cSiELJi4lIwK+JiDQzAjq6hV2OQvD0wBBaFL2KXvjKjrHfC+lk+nSTycIIl8205BvYDt0Qz65PV4maesG/DsgbE4HQAp+ePniC8uhwZyHtHK+sT7L9wpJ/BoZRwTUM4AVbVQoC706Cqv9xPC/XK7HDsFnrg2jl0RTBxl7Iwj52cboJrjPFI/u/ko0RxtoJGP+43JDuDy4YSYfwYnVc4ijab1V+jca9suDW1oDRuawOebWWeTbbQGPq2euv3VNcUkv+iIv18miDbQlD3dox+xWrjZFnqDI3veDumluYSaBGBmFPJI4PE6afSFkK5ufNG2twYrBBn2P3bKJ/956q7SMNEdb+xDoH0O6Vl8IQxLRA8EtC2a756rzqSnv8OPB+O8M1uLX41E6+/2VZ43ENzW6SrHEEguuWc6KBFuR3Q2Yrlsx1IjBHBP7Javf++k4Sv2VUnLCJ3q02CF3RuCxn2mJgWC7UaYgvoNrejzcHSPbkc2nMDJVSyFEMYjTDzHBMaszZCc8nFDvp0SUC1Lyl+AZGSEgBMG8kwOBZJN10C0eFNkeC/obS32n3JNd8kiRncO1DrUQVvkG0/6uwvehi/HzCT8lR4iiZyX89CAumLQ5PXUvW0phJfg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921665de-f354-4ea7-be87-08d7f1d18192
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 15:24:01.8809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCjkAXN6L1rnn5CewlRbn4U9B0WBtdoK7zd+zGzWILEJZg0jSLXUR4SIil9QuMMP9ySQ2rvJiBWap18J90ElvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0410079139=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0410079139==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FCBAE34F505EB081BE46F7A40MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FCBAE34F505EB081BE46F7A40MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Perhaps it's too much churn for this patch set, but I'd like to unify the p=
p func callbacks between powerplay and swsmu so we can drop all of the is_s=
wsmu_supported() and function pointer checks sprinkled all through the code=
.

Alex
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, May 6, 2020 7:04 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd=
.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code


[AMD Official Use Only - Internal Distribution Only]


________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, May 6, 2020 5:26 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd=
.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code

[AMD Official Use Only - Internal Distribution Only]

Hi Kelvin,

Thanks for the series that remove the duplicated one_vf mode check in all t=
he amdgpu_dpm functions.

Can we split the patch into two? One for amdgpu device sysfs attr code refi=
ne, with the new dev_attr structures, the other for retiring all the unnece=
ssary one_vf mode support.

thanks your comment.
[kevin]: Q1, agree, i will split it into two patch.

+enum amdgpu_device_attr_states {
+       ATTR_STATE_UNSUPPORT =3D 0,
+       ATTR_STATE_SUPPORT,
+       ATTR_STATE_DEAD,
+       ATTR_STATE_ALIVE,
+};
+
The attr_states seems unnecessary to me. You need a flag to mark whether a =
particular attribute is supported by specific ASIC or not, right? Then just=
 a bool variable should be good enough for this purpose, Like attr->support=
ed. I' d like to understand the use case for DEAD and ALIVE. Accordingly, y=
ou can simplify the logic that only remove the supported ones.

[kevin]: Q2, the origin idea, it is used to store sysfs file state, but for=
 this case, we can try to drop DEAD & ALIVE state,
because the origin code logic will exit directly when create file fail.

If we have to introduce more complicated flags to indicate different status=
, I'd prefer to go directly to initialize one_vf mode attr sets and bare-me=
tal attr sets directly.
[kevin]: Q3, i'd like to keep this patch code,  in fact, not all sysfs devi=
ces need to be created on bare-metal mode.
the driver must check it at runtime. eg: is_sw_smu_support(), if (asic_chip=
 =3D=3D XXX), etc..

In addition, the function naming like default_attr_perform also confusing m=
e. Would it be the function that used to update attr status?
+static int default_attr_perform(struct amdgpu_device *adev, struct amdgpu_=
device_attr *attr,
+                               uint32_t mask)

[kevin]: Q4, yes, the function is used to update attr status according to a=
sic information at runtime.
maybe rename to "attr_update" is better.

Best Regards,
Kevin

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, May 6, 2020 14:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Feng, Kenneth <Kenneth.Feng@=
amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code

unified amdgpu device attribute node functions:
1. add some helper functions to create amdgpu device attribute node.
2. create device node according to device attr flags on different VF mode.
3. rename some functions name to adapt a new interface.
4. remove unneccessary virt mode check in inernal functions (xxx_show, xxx_=
store).

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 577 ++++++++++---------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_pm.h |  48 ++
 2 files changed, 271 insertions(+), 354 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index c762deb5abc7..367ac79418b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -154,18 +154,15 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev=
, enum amd_pp_sensors senso
  *
  */

-static ssize_t amdgpu_get_dpm_state(struct device *dev,
-                                   struct device_attribute *attr,
-                                   char *buf)
+static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
+                                         struct device_attribute *attr,
+                                         char *buf)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
         enum amd_pm_state_type pm;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -189,19 +186,16 @@ static ssize_t amdgpu_get_dpm_state(struct device *de=
v,
                         (pm =3D=3D POWER_STATE_TYPE_BALANCED) ? "balanced"=
 : "performance");  }

-static ssize_t amdgpu_set_dpm_state(struct device *dev,
-                                   struct device_attribute *attr,
-                                   const char *buf,
-                                   size_t count)
+static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
+                                         struct device_attribute *attr,
+                                         const char *buf,
+                                         size_t count)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
         enum amd_pm_state_type  state;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         if (strncmp("battery", buf, strlen("battery")) =3D=3D 0)
                 state =3D POWER_STATE_TYPE_BATTERY;
         else if (strncmp("balanced", buf, strlen("balanced")) =3D=3D 0) @@=
 -294,18 +288,15 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
  *
  */

-static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,
-                                               struct device_attribute *at=
tr,
-                                                               char *buf)
+static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device =
*dev,
+                                                           struct device_a=
ttribute *attr,
+                                                           char *buf)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
         enum amd_dpm_forced_level level =3D 0xff;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -332,10 +323,10 @@ static ssize_t amdgpu_get_dpm_forced_performance_leve=
l(struct device *dev,
                         "unknown");
 }

-static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
-                                                      struct device_attrib=
ute *attr,
-                                                      const char *buf,
-                                                      size_t count)
+static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device =
*dev,
+                                                           struct device_a=
ttribute *attr,
+                                                           const char *buf=
,
+                                                           size_t count)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private; @@ -343,9 +334,6=
 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *d=
ev,
         enum amd_dpm_forced_level current_level =3D 0xff;
         int ret =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
                 level =3D AMD_DPM_FORCED_LEVEL_LOW;
         } else if (strncmp("high", buf, strlen("high")) =3D=3D 0) { @@ -47=
5,9 +463,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
         enum amd_pm_state_type pm =3D 0;
         int i =3D 0, ret =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -514,9 +499,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device =
*dev,
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         if (adev->pp_force_state_enabled)
                 return amdgpu_get_pp_cur_state(dev, attr, buf);
         else
@@ -534,9 +516,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device =
*dev,
         unsigned long idx;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         if (strlen(buf) =3D=3D 1)
                 adev->pp_force_state_enabled =3D false;
         else if (is_support_sw_smu(adev))
@@ -592,9 +571,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
         char *table =3D NULL;
         int size, ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -634,9 +610,6 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
         struct amdgpu_device *adev =3D ddev->dev_private;
         int ret =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -873,10 +846,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct de=
vice *dev,
  * the corresponding bit from original ppfeature masks and input the
  * new ppfeature masks.
  */
-static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
-               struct device_attribute *attr,
-               const char *buf,
-               size_t count)
+static ssize_t amdgpu_set_pp_features(struct device *dev,
+                                     struct device_attribute *attr,
+                                     const char *buf,
+                                     size_t count)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private; @@ -917,9 +890,9=
 @@ static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
         return count;
 }

-static ssize_t amdgpu_get_pp_feature_status(struct device *dev,
-               struct device_attribute *attr,
-               char *buf)
+static ssize_t amdgpu_get_pp_features(struct device *dev,
+                                     struct device_attribute *attr,
+                                     char *buf)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private; @@ -985,9 +958,6=
 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1051,9 +1021,6 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *=
dev,
         int ret;
         uint32_t mask =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         ret =3D amdgpu_read_mask(buf, count, &mask);
         if (ret)
                 return ret;
@@ -1085,9 +1052,6 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *=
dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1115,9 +1079,6 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *=
dev,
         uint32_t mask =3D 0;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-                       return -EINVAL;
-
         ret =3D amdgpu_read_mask(buf, count, &mask);
         if (ret)
                 return ret;
@@ -1149,9 +1110,6 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device=
 *dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1179,9 +1137,6 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device=
 *dev,
         int ret;
         uint32_t mask =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         ret =3D amdgpu_read_mask(buf, count, &mask);
         if (ret)
                 return ret;
@@ -1215,9 +1170,6 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *=
dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1245,9 +1197,6 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *=
dev,
         int ret;
         uint32_t mask =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         ret =3D amdgpu_read_mask(buf, count, &mask);
         if (ret)
                 return ret;
@@ -1347,9 +1296,6 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *=
dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1377,9 +1323,6 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *=
dev,
         int ret;
         uint32_t mask =3D 0;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         ret =3D amdgpu_read_mask(buf, count, &mask);
         if (ret)
                 return ret;
@@ -1571,9 +1514,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struc=
t device *dev,
         ssize_t size;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1615,9 +1555,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struc=
t device *dev,
         if (ret)
                 return -EINVAL;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return -EINVAL;
-
         if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                 if (count < 2 || count > 127)
                         return -EINVAL;
@@ -1663,17 +1600,14 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_busy_percent(struct device *dev,
-               struct device_attribute *attr,
-               char *buf)
+static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
+                                          struct device_attribute *attr,
+                                          char *buf)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
         int r, value, size =3D sizeof(value);

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         r =3D pm_runtime_get_sync(ddev->dev);
         if (r < 0)
                 return r;
@@ -1699,17 +1633,14 @@ static ssize_t amdgpu_get_busy_percent(struct devic=
e *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_memory_busy_percent(struct device *dev,
-               struct device_attribute *attr,
-               char *buf)
+static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
+                                          struct device_attribute *attr,
+                                          char *buf)
 {
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
         int r, value, size =3D sizeof(value);

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         r =3D pm_runtime_get_sync(ddev->dev);
         if (r < 0)
                 return r;
@@ -1748,9 +1679,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
         uint64_t count0, count1;
         int ret;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         ret =3D pm_runtime_get_sync(ddev->dev);
         if (ret < 0)
                 return ret;
@@ -1781,66 +1709,186 @@ static ssize_t amdgpu_get_unique_id(struct device =
*dev,
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;

-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-               return 0;
-
         if (adev->unique_id)
                 return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_=
id);

         return 0;
 }

-static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, amdgpu_get_dpm_stat=
e, amdgpu_set_dpm_state); -static DEVICE_ATTR(power_dpm_force_performance_l=
evel, S_IRUGO | S_IWUSR,
-                  amdgpu_get_dpm_forced_performance_level,
-                  amdgpu_set_dpm_forced_performance_level);
-static DEVICE_ATTR(pp_num_states, S_IRUGO, amdgpu_get_pp_num_states, NULL)=
; -static DEVICE_ATTR(pp_cur_state, S_IRUGO, amdgpu_get_pp_cur_state, NULL)=
; -static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_force_state,
-               amdgpu_set_pp_force_state);
-static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_table,
-               amdgpu_set_pp_table);
-static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_sclk,
-               amdgpu_set_pp_dpm_sclk);
-static DEVICE_ATTR(pp_dpm_mclk, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_mclk,
-               amdgpu_set_pp_dpm_mclk);
-static DEVICE_ATTR(pp_dpm_socclk, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_socclk,
-               amdgpu_set_pp_dpm_socclk);
-static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_fclk,
-               amdgpu_set_pp_dpm_fclk);
-static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_dcefclk,
-               amdgpu_set_pp_dpm_dcefclk);
-static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_dpm_pcie,
-               amdgpu_set_pp_dpm_pcie);
-static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_sclk_od,
-               amdgpu_set_pp_sclk_od);
-static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_mclk_od,
-               amdgpu_set_pp_mclk_od);
-static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_power_profile_mode,
-               amdgpu_set_pp_power_profile_mode);
-static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_od_clk_voltage,
-               amdgpu_set_pp_od_clk_voltage);
-static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
-               amdgpu_get_busy_percent, NULL);
-static DEVICE_ATTR(mem_busy_percent, S_IRUGO,
-               amdgpu_get_memory_busy_percent, NULL);
-static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL); -static DE=
VICE_ATTR(pp_features, S_IRUGO | S_IWUSR,
-               amdgpu_get_pp_feature_status,
-               amdgpu_set_pp_feature_status);
-static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);
+static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,                            ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,                           ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,                               ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,                               ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,                    ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,                        ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,                         ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,                         ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RO(pcie_bw,                                  ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_features,                              ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RO(unique_id,                                ATT=
R_FLAG_BASIC),
+};
+
+static int default_attr_perform(struct amdgpu_device *adev, struct amdgpu_=
device_attr *attr,
+                               uint32_t mask)
+{
+       struct device_attribute *dev_attr =3D &attr->dev_attr;
+       const char *attr_name =3D dev_attr->attr.name;
+       struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
+       enum amd_asic_type asic_type =3D adev->asic_type;
+
+       if (!(attr->flags & mask)) {
+               attr->states =3D ATTR_STATE_UNSUPPORT;
+               return 0;
+       }
+
+#define DEVICE_ATTR_IS(_name)  (!strcmp(attr_name, #_name))
+
+       if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
+               if (asic_type <=3D CHIP_VEGA10)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+               if (asic_type <=3D CHIP_VEGA10 || asic_type =3D=3D CHIP_ARC=
TURUS)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+               if (asic_type < CHIP_VEGA20)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+               if (asic_type =3D=3D CHIP_ARCTURUS)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
+               attr->states =3D ATTR_STATE_UNSUPPORT;
+               if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
+                   (!is_support_sw_smu(adev) && hwmgr->od_enabled))
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
+               if (adev->flags & AMD_IS_APU || asic_type =3D=3D CHIP_VEGA1=
0)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pcie_bw)) {
+               /* PCIe Perf counters won't work on APU nodes */
+               if (adev->flags & AMD_IS_APU)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(unique_id)) {
+               if (!adev->unique_id)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       } else if (DEVICE_ATTR_IS(pp_features)) {
+               if (adev->flags & AMD_IS_APU || asic_type <=3D CHIP_VEGA10)
+                       attr->states =3D ATTR_STATE_UNSUPPORT;
+       }
+
+       if (asic_type =3D=3D CHIP_ARCTURUS) {
+               /* Arcturus does not support standalone mclk/socclk/fclk le=
vel setting */
+               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_socclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_fclk)) {
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               }
+       }
+
+#undef DEVICE_ATTR_IS
+
+       return 0;
+}
+
+
+static int amdgpu_device_attr_create(struct amdgpu_device *adev,
+                                    struct amdgpu_device_attr *attr,
+                                    uint32_t mask)
+{
+       int ret =3D 0;
+       struct device_attribute *dev_attr =3D &attr->dev_attr;
+       const char *name =3D dev_attr->attr.name;
+       int (*attr_perform)(struct amdgpu_device *adev, struct amdgpu_devic=
e_attr *attr,
+                           uint32_t mask) =3D default_attr_perform;
+
+       BUG_ON(!attr);
+
+       if (attr->states =3D=3D ATTR_STATE_UNSUPPORT ||
+           attr->states =3D=3D ATTR_STATE_ALIVE)
+               return 0;
+
+       if (attr->perform) {
+               attr_perform =3D attr->perform;
+       }
+
+       ret =3D attr_perform(adev, attr, mask);
+       if (ret) {
+               dev_err(adev->dev, "failed to perform device file %s, ret =
=3D %d\n",
+                       name, ret);
+               return ret;
+       }
+
+       /* the attr->states maybe changed after call attr->perform function=
 */
+       if (attr->states =3D=3D ATTR_STATE_UNSUPPORT)
+               return 0;
+
+       ret =3D device_create_file(adev->dev, dev_attr);
+       if (ret) {
+               dev_err(adev->dev, "failed to create device file %s, ret =
=3D %d\n",
+                       name, ret);
+       }
+
+       attr->states =3D ATTR_STATE_ALIVE;
+
+       return ret;
+}
+
+static void amdgpu_device_attr_remove(struct amdgpu_device *adev,
+struct amdgpu_device_attr *attr) {
+       struct device_attribute *dev_attr =3D &attr->dev_attr;
+
+       if (attr->states !=3D ATTR_STATE_ALIVE)
+               return;
+
+       device_remove_file(adev->dev, dev_attr);
+
+       attr->states =3D ATTR_STATE_DEAD;
+}
+
+static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
+                                           struct amdgpu_device_attr *attr=
s,
+                                           uint32_t counts,
+                                           uint32_t mask)
+{
+       int ret =3D 0;
+       uint32_t i =3D 0;
+
+       for (i =3D 0; i < counts; i++) {
+               ret =3D amdgpu_device_attr_create(adev, &attrs[i], mask);
+               if (ret)
+                       goto failed;
+       }
+
+       return 0;
+
+failed:
+       for (; i > 0; i--) {
+               amdgpu_device_attr_remove(adev, &attrs[i]);
+       }
+
+       return ret;
+}
+
+static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
+                                            struct amdgpu_device_attr *att=
rs,
+                                            uint32_t counts)
+{
+       uint32_t i =3D 0;
+
+       for (i =3D 0; i < counts; i++)
+               amdgpu_device_attr_remove(adev, &attrs[i]); }

 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
                                       struct device_attribute *attr, @@ -2=
790,7 +2838,7 @@ static umode_t hwmon_attributes_visible(struct kobject *ko=
bj,
         umode_t effective_mode =3D attr->mode;

         /* under multi-vf mode, the hwmon attributes are all not supported=
 */
-       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+       if (amdgpu_virt_get_sriov_vf_mode(adev) =3D=3D SRIOV_VF_MODE_MULTI_=
VF)
                 return 0;

         /* there is no fan under pp one vf mode */ @@ -3241,8 +3289,8 @@ i=
nt amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_ve=
rsio

 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)  {
-       struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
         int ret;
+       uint32_t mask =3D 0;

         if (adev->pm.sysfs_initialized)
                 return 0;
@@ -3260,168 +3308,25 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)
                 return ret;
         }

-       ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_state);
-       if (ret) {
-               DRM_ERROR("failed to create device file for dpm state\n");
-               return ret;
-       }
-       ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_force_per=
formance_level);
-       if (ret) {
-               DRM_ERROR("failed to create device file for dpm state\n");
-               return ret;
-       }
-
-       if (!amdgpu_sriov_vf(adev)) {
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_num_stat=
es);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_num_stat=
es\n");
-                       return ret;
-               }
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_cur_stat=
e);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_cur_stat=
e\n");
-                       return ret;
-               }
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_force_st=
ate);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_force_st=
ate\n");
-                       return ret;
-               }
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_table);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_table\n"=
);
-                       return ret;
-               }
-       }
-
-       ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
-       if (ret) {
-               DRM_ERROR("failed to create device file pp_dpm_sclk\n");
-               return ret;
-       }
-
-       /* Arcturus does not support standalone mclk/socclk/fclk level sett=
ing */
-       if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
-               dev_attr_pp_dpm_mclk.attr.mode &=3D ~S_IWUGO;
-               dev_attr_pp_dpm_mclk.store =3D NULL;
-
-               dev_attr_pp_dpm_socclk.attr.mode &=3D ~S_IWUGO;
-               dev_attr_pp_dpm_socclk.store =3D NULL;
-
-               dev_attr_pp_dpm_fclk.attr.mode &=3D ~S_IWUGO;
-               dev_attr_pp_dpm_fclk.store =3D NULL;
-       }
-
-       ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
-       if (ret) {
-               DRM_ERROR("failed to create device file pp_dpm_mclk\n");
-               return ret;
-       }
-       if (adev->asic_type >=3D CHIP_VEGA10) {
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_socc=
lk);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_dpm_socc=
lk\n");
-                       return ret;
-               }
-               if (adev->asic_type !=3D CHIP_ARCTURUS) {
-                       ret =3D device_create_file(adev->dev, &dev_attr_pp_=
dpm_dcefclk);
-                       if (ret) {
-                               DRM_ERROR("failed to create device file pp_=
dpm_dcefclk\n");
-                               return ret;
-                       }
-               }
-       }
-       if (adev->asic_type >=3D CHIP_VEGA20) {
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_fclk=
);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_dpm_fclk=
\n");
-                       return ret;
-               }
-       }
-
-       /* the reset are not needed for SRIOV one vf mode */
-       if (amdgpu_sriov_vf(adev)) {
-               adev->pm.sysfs_initialized =3D true;
-               return ret;
+       switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
+       case SRIOV_VF_MODE_ONE_VF:
+               mask =3D ATTR_FLAG_ONEVF;
+               break;
+       case SRIOV_VF_MODE_MULTI_VF:
+               mask =3D 0;
+               break;
+       case SRIOV_VF_MODE_BARE_METAL:
+       default:
+               mask =3D ATTR_FLAG_MASK_ALL;
+               break;
         }

-       if (adev->asic_type !=3D CHIP_ARCTURUS) {
-               ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_pcie=
);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pp_dpm_pcie=
\n");
-                       return ret;
-               }
-       }
-       ret =3D device_create_file(adev->dev, &dev_attr_pp_sclk_od);
-       if (ret) {
-               DRM_ERROR("failed to create device file pp_sclk_od\n");
-               return ret;
-       }
-       ret =3D device_create_file(adev->dev, &dev_attr_pp_mclk_od);
-       if (ret) {
-               DRM_ERROR("failed to create device file pp_mclk_od\n");
-               return ret;
-       }
-       ret =3D device_create_file(adev->dev,
-                       &dev_attr_pp_power_profile_mode);
-       if (ret) {
-               DRM_ERROR("failed to create device file "
-                               "pp_power_profile_mode\n");
-               return ret;
-       }
-       if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-           (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
-               ret =3D device_create_file(adev->dev,
-                               &dev_attr_pp_od_clk_voltage);
-               if (ret) {
-                       DRM_ERROR("failed to create device file "
-                                       "pp_od_clk_voltage\n");
-                       return ret;
-               }
-       }
-       ret =3D device_create_file(adev->dev,
-                       &dev_attr_gpu_busy_percent);
-       if (ret) {
-               DRM_ERROR("failed to create device file "
-                               "gpu_busy_level\n");
-               return ret;
-       }
-       /* APU does not have its own dedicated memory */
-       if (!(adev->flags & AMD_IS_APU) &&
-            (adev->asic_type !=3D CHIP_VEGA10)) {
-               ret =3D device_create_file(adev->dev,
-                               &dev_attr_mem_busy_percent);
-               if (ret) {
-                       DRM_ERROR("failed to create device file "
-                                       "mem_busy_percent\n");
-                       return ret;
-               }
-       }
-       /* PCIe Perf counters won't work on APU nodes */
-       if (!(adev->flags & AMD_IS_APU)) {
-               ret =3D device_create_file(adev->dev, &dev_attr_pcie_bw);
-               if (ret) {
-                       DRM_ERROR("failed to create device file pcie_bw\n")=
;
-                       return ret;
-               }
-       }
-       if (adev->unique_id)
-               ret =3D device_create_file(adev->dev, &dev_attr_unique_id);
-       if (ret) {
-               DRM_ERROR("failed to create device file unique_id\n");
+       ret =3D amdgpu_device_attr_create_groups(adev,
+                                              amdgpu_device_attrs,
+                                              ARRAY_SIZE(amdgpu_device_att=
rs),
+                                              mask);
+       if (ret)
                 return ret;
-       }
-
-       if ((adev->asic_type >=3D CHIP_VEGA10) &&
-           !(adev->flags & AMD_IS_APU)) {
-               ret =3D device_create_file(adev->dev,
-                               &dev_attr_pp_features);
-               if (ret) {
-                       DRM_ERROR("failed to create device file "
-                                       "pp_features\n");
-                       return ret;
-               }
-       }

         adev->pm.sysfs_initialized =3D true;

@@ -3430,51 +3335,15 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev=
)

 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)  {
-       struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
-
         if (adev->pm.dpm_enabled =3D=3D 0)
                 return;

         if (adev->pm.int_hwmon_dev)
                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
-       device_remove_file(adev->dev, &dev_attr_power_dpm_state);
-       device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance=
_level);
-
-       device_remove_file(adev->dev, &dev_attr_pp_num_states);
-       device_remove_file(adev->dev, &dev_attr_pp_cur_state);
-       device_remove_file(adev->dev, &dev_attr_pp_force_state);
-       device_remove_file(adev->dev, &dev_attr_pp_table);
-
-       device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
-       device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
-       if (adev->asic_type >=3D CHIP_VEGA10) {
-               device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
-               if (adev->asic_type !=3D CHIP_ARCTURUS)
-                       device_remove_file(adev->dev, &dev_attr_pp_dpm_dcef=
clk);
-       }
-       if (adev->asic_type !=3D CHIP_ARCTURUS)
-               device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
-       if (adev->asic_type >=3D CHIP_VEGA20)
-               device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
-       device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
-       device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
-       device_remove_file(adev->dev,
-                       &dev_attr_pp_power_profile_mode);
-       if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-           (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-               device_remove_file(adev->dev,
-                               &dev_attr_pp_od_clk_voltage);
-       device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
-       if (!(adev->flags & AMD_IS_APU) &&
-            (adev->asic_type !=3D CHIP_VEGA10))
-               device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
-       if (!(adev->flags & AMD_IS_APU))
-               device_remove_file(adev->dev, &dev_attr_pcie_bw);
-       if (adev->unique_id)
-               device_remove_file(adev->dev, &dev_attr_unique_id);
-       if ((adev->asic_type >=3D CHIP_VEGA10) &&
-           !(adev->flags & AMD_IS_APU))
-               device_remove_file(adev->dev, &dev_attr_pp_features);
+
+       amdgpu_device_attr_remove_groups(adev,
+                                        amdgpu_device_attrs,
+                                        ARRAY_SIZE(amdgpu_device_attrs));
 }

 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev) diff --git a/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.=
h
index 5db0ef86e84c..5ca5f3f9e8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -30,6 +30,54 @@ struct cg_flag_name
         const char *name;
 };

+enum amdgpu_device_attr_flags {
+       ATTR_FLAG_BASIC =3D (1 << 0),
+       ATTR_FLAG_ONEVF =3D (1 << 16),
+};
+
+#define ATTR_FLAG_TYPE_MASK    (0x0000ffff)
+#define ATTR_FLAG_MODE_MASK    (0xffff0000)
+#define ATTR_FLAG_MASK_ALL     (0xffffffff)
+
+enum amdgpu_device_attr_states {
+       ATTR_STATE_UNSUPPORT =3D 0,
+       ATTR_STATE_SUPPORT,
+       ATTR_STATE_DEAD,
+       ATTR_STATE_ALIVE,
+};
+
+struct amdgpu_device_attr {
+       struct device_attribute dev_attr;
+       enum amdgpu_device_attr_flags flags;
+       enum amdgpu_device_attr_states states;
+       int (*perform)(struct amdgpu_device *adev,
+                      struct amdgpu_device_attr* attr,
+                      uint32_t mask);
+};
+
+#define to_amdgpu_device_attr(_dev_attr) \
+       container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
+
+#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...) \
+       { .dev_attr =3D __ATTR(_name, _mode, _show, _store),              \
+         .flags =3D _flags,                                               =
\
+         .states =3D ATTR_STATE_SUPPORT,                                  =
\
+         ##__VA_ARGS__, }
+
+#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)                  \
+       __AMDGPU_DEVICE_ATTR(_name, _mode,                              \
+                            amdgpu_get_##_name, amdgpu_set_##_name,     \
+                            _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)                      \
+       AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,                    \
+                          _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)                      \
+       __AMDGPU_DEVICE_ATTR(_name, S_IRUGO,                            \
+                            amdgpu_get_##_name, NULL,                   \
+                            _flags, ##__VA_ARGS__)
+
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);  int amdgpu=
_pm_sysfs_init(struct amdgpu_device *adev);  int amdgpu_pm_virt_sysfs_init(=
struct amdgpu_device *adev);
--
2.17.1

--_000_MN2PR12MB4488FCBAE34F505EB081BE46F7A40MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Perhaps it's too much churn for this patch set, but I'd like to unify the p=
p func callbacks between powerplay and swsmu so we can drop all of the is_s=
wsmu_supported() and function pointer checks sprinkled all through the code=
.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 6, 2020 7:04 AM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Monk =
&lt;Monk.Liu@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribut=
e code</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Hawking &lt;=
Hawking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 6, 2020 5:26 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Monk =
&lt;Monk.Liu@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribut=
e code</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">[AMD Official Use Only - Internal Distribution O=
nly]<br>
<br>
Hi Kelvin,<br>
<br>
Thanks for the series that remove the duplicated one_vf mode check in all t=
he amdgpu_dpm functions.<br>
<br>
Can we split the patch into two? One for amdgpu device sysfs attr code refi=
ne, with the new dev_attr structures, the other for retiring all the unnece=
ssary one_vf mode support.<br>
<br>
<span style=3D"background-color:rgb(255,255,255); display:inline!important"=
>thanks your comment.</span><br>
[kevin]: Q1, agree, i will split it into two patch.</div>
<div class=3D"x_PlainText"><br>
&#43;enum amdgpu_device_attr_states {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_UNSUPPORT =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_SUPPORT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_DEAD,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_ALIVE,<br>
&#43;};<br>
&#43;<br>
The attr_states seems unnecessary to me. You need a flag to mark whether a =
particular attribute is supported by specific ASIC or not, right? Then just=
 a bool variable should be good enough for this purpose, Like attr-&gt;supp=
orted. I' d like to understand the
 use case for DEAD and ALIVE. Accordingly, you can simplify the logic that =
only remove the supported ones.</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">[kevin]: Q2, the origin idea, it is used to stor=
e sysfs file state, but for this case, we can try to drop DEAD &amp; ALIVE =
state,&nbsp;</div>
<div class=3D"x_PlainText">because the origin code logic will exit directly=
 when create file fail.<br>
<br>
If we have to introduce more complicated flags to indicate different status=
, I'd prefer to go directly to initialize one_vf mode attr sets and bare-me=
tal attr sets directly.</div>
<div class=3D"x_PlainText">[kevin]: Q3, i'd like to keep this patch code,&n=
bsp; in fact, n<span>ot all sysfs devices need to be created on bare-metal =
mode.</span></div>
<div class=3D"x_PlainText"><span>the driver must check it at runtime. eg: i=
s_sw_smu_support(), if (asic_chip =3D=3D XXX), etc..</span></div>
<div class=3D"x_PlainText"><br>
In addition, the function naming like default_attr_perform also confusing m=
e. Would it be the function that used to update attr status?
<br>
&#43;static int default_attr_perform(struct amdgpu_device *adev, struct amd=
gpu_device_attr *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">[kevin]: Q4, yes, the function is used to update=
 attr status according to asic information at runtime.</div>
<div class=3D"x_PlainText">maybe rename to &quot;attr_update&quot; is bette=
r.</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">Best Regards,</div>
<div class=3D"x_PlainText">Kevin</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
Sent: Wednesday, May 6, 2020 14:23<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Feng, Kenn=
eth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com=
&gt;<br>
Subject: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code<br>
<br>
unified amdgpu device attribute node functions:<br>
1. add some helper functions to create amdgpu device attribute node.<br>
2. create device node according to device attr flags on different VF mode.<=
br>
3. rename some functions name to adapt a new interface.<br>
4. remove unneccessary virt mode check in inernal functions (xxx_show, xxx_=
store).<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 577 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;---------------&nbsp; drivers/gpu/drm/amd/amdgpu/=
amdgpu_pm.h |&nbsp; 48 &#43;&#43;<br>
&nbsp;2 files changed, 271 insertions(&#43;), 354 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index c762deb5abc7..367ac79418b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -154,18 &#43;154,15 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *=
adev, enum amd_pp_sensors senso<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-static ssize_t amdgpu_get_dpm_state(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attri=
bute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&#43;static ssize_t amdgpu_get_power_dpm_state(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -189,19 &#43;186,16 @@ static ssize_t amdgpu_get_dpm_state(struct device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pm =
=3D=3D POWER_STATE_TYPE_BALANCED) ? &quot;balanced&quot; : &quot;performanc=
e&quot;);&nbsp; }<br>
&nbsp;<br>
-static ssize_t amdgpu_set_dpm_state(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attri=
bute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&#43;static ssize_t amdgpu_set_power_dpm_state(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; size_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type&nbs=
p; state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strncmp(&quot;battery&=
quot;, buf, strlen(&quot;battery&quot;)) =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; state =3D POWER_STATE_TYPE_BATTERY;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (strncmp(&quot;bal=
anced&quot;, buf, strlen(&quot;balanced&quot;)) =3D=3D 0) @@ -294,18 &#43;2=
88,15 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribut=
e *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
har *buf)<br>
&#43;static ssize_t amdgpu_get_power_dpm_force_performance_level(struct dev=
ice *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribu=
te *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -332,10 &#43;323,10 @@ static ssize_t amdgpu_get_dpm_forced_performance_=
level(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;unknown&quot;);<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const char *buf,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size_t count)<br>
&#43;static ssize_t amdgpu_set_power_dpm_force_performance_level(struct dev=
ice *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribu=
te *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private; @@ -343,9 &#43;334,6 @@ static ssize_t amdgpu_se=
t_dpm_forced_performance_level(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
current_level =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strncmp(&quot;low&quot=
;, buf, strlen(&quot;low&quot;)) =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_LOW;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot;h=
igh&quot;, buf, strlen(&quot;high&quot;)) =3D=3D 0) { @@ -475,9 &#43;463,6 =
@@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0, ret =3D 0;<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -514,9 &#43;499,6 @@ static ssize_t amdgpu_get_pp_force_state(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pp_force_stat=
e_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_get_pp_cur_state(dev, attr, buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -534,9 &#43;516,6 @@ static ssize_t amdgpu_set_pp_force_state(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long idx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(buf) =3D=3D 1)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pp_force_state_enabled =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (is_support_sw_smu=
(adev))<br>
@@ -592,9 &#43;571,6 @@ static ssize_t amdgpu_get_pp_table(struct device *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *table =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size, ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -634,9 &#43;610,6 @@ static ssize_t amdgpu_set_pp_table(struct device *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -873,10 &#43;846,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struc=
t device *dev,<br>
&nbsp; * the corresponding bit from original ppfeature masks and input the<=
br>
&nbsp; * new ppfeature masks.<br>
&nbsp; */<br>
-static ssize_t amdgpu_set_pp_feature_status(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const char *buf,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size_t count)<br>
&#43;static ssize_t amdgpu_set_pp_features(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
st char *buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private; @@ -917,9 &#43;890,9 @@ static ssize_t amdgpu_se=
t_pp_feature_status(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_get_pp_feature_status(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; char *buf)<br>
&#43;static ssize_t amdgpu_get_pp_features(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cha=
r *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private; @@ -985,9 &#43;958,6 @@ static ssize_t amdgpu_ge=
t_pp_dpm_sclk(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1051,9 &#43;1021,6 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(b=
uf, count, &amp;mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1085,9 &#43;1052,6 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1115,9 &#43;1079,6 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(b=
uf, count, &amp;mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1149,9 &#43;1110,6 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1179,9 &#43;1137,6 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(b=
uf, count, &amp;mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1215,9 &#43;1170,6 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1245,9 &#43;1197,6 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(b=
uf, count, &amp;mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1347,9 &#43;1296,6 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1377,9 &#43;1323,6 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(b=
uf, count, &amp;mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1571,9 &#43;1514,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(s=
truct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1615,9 &#43;1555,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(s=
truct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (profile_mode =3D=3D PP=
_SMC_POWER_PROFILE_CUSTOM) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (count &lt; 2 || count &gt; 127)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
@@ -1663,17 &#43;1600,14 @@ static ssize_t amdgpu_set_pp_power_profile_mode=
(struct device *dev,<br>
&nbsp; * The SMU firmware computes a percentage of load based on the<br>
&nbsp; * aggregate activity level in the IP cores.<br>
&nbsp; */<br>
-static ssize_t amdgpu_get_busy_percent(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; char *buf)<br>
&#43;static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, value, size =3D siz=
eof(value);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -1699,17 &#43;1633,14 @@ static ssize_t amdgpu_get_busy_percent(struct d=
evice *dev,<br>
&nbsp; * The SMU firmware computes a percentage of load based on the<br>
&nbsp; * aggregate activity level in the IP cores.<br>
&nbsp; */<br>
-static ssize_t amdgpu_get_memory_busy_percent(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; char *buf)<br>
&#43;static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, value, size =3D siz=
eof(value);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -1748,9 &#43;1679,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t count0, count1;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1781,66 &#43;1709,186 @@ static ssize_t amdgpu_get_unique_id(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;unique_id)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%016llx\n&quot;=
, adev-&gt;unique_id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, amdgpu_get_dpm_stat=
e, amdgpu_set_dpm_state); -static DEVICE_ATTR(power_dpm_force_performance_l=
evel, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_dpm_forced_performance_level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_dpm_forced_performance_level);<br>
-static DEVICE_ATTR(pp_num_states, S_IRUGO, amdgpu_get_pp_num_states, NULL)=
; -static DEVICE_ATTR(pp_cur_state, S_IRUGO, amdgpu_get_pp_cur_state, NULL)=
; -static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_force_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_force_state);<br>
-static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_table);<br>
-static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_sclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_sclk);<br>
-static DEVICE_ATTR(pp_dpm_mclk, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_mclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_mclk);<br>
-static DEVICE_ATTR(pp_dpm_socclk, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_socclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_socclk);<br>
-static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_fclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_fclk);<br>
-static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_dcefclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_dcefclk);<br>
-static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_dpm_pcie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_dpm_pcie);<br>
-static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_sclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_sclk_od);<br>
-static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_mclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_mclk_od);<br>
-static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_power_profile_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_power_profile_mode);<br>
-static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_od_clk_voltage,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_od_clk_voltage);<br>
-static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_busy_percent, NULL);<br>
-static DEVICE_ATTR(mem_busy_percent, S_IRUGO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_memory_busy_percent, NULL);<br>
-static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL); -static DE=
VICE_ATTR(pp_features, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_pp_feature_status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_pp_feature_status);<br>
-static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);<br>
&#43;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_s=
tate,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_f=
orce_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG=
_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_num_stat=
es,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_cur_stat=
e,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_force_st=
ate,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_table,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_socc=
lk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcef=
clk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_power_pr=
ofile_mode,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_od_clk_v=
oltage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR=
_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(gpu_busy_pe=
rcent,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(mem_busy_pe=
rcent,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pcie_bw,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_features=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(unique_id,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&#43;};<br>
&#43;<br>
&#43;static int default_attr_perform(struct amdgpu_device *adev, struct amd=
gpu_device_attr *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *dev_attr=
 =3D &amp;attr-&gt;dev_attr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *attr_name =3D dev_att=
r-&gt;attr.name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D adev-&=
gt;powerplay.pp_handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_asic_type asic_type =3D =
adev-&gt;asic_type;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(attr-&gt;flags &amp; mask))=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;#define DEVICE_ATTR_IS(_name)&nbsp; (!strcmp(attr_name, #_name))<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_socclk)=
) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (asic_type &lt;=3D CHIP_VEGA10)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_=
dcefclk)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (asic_type &lt;=3D CHIP_VEGA10 || asic_type =3D=3D CHIP_A=
RCTURUS)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_=
fclk)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (asic_type &lt; CHIP_VEGA20)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_=
pcie)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (asic_type =3D=3D CHIP_ARCTURUS)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_od_c=
lk_voltage)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((is_support_sw_smu(adev) &amp;&amp; adev-&gt;smu.od_enab=
led) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!is_support_sw_smu(adev) &amp;&amp;=
 hwmgr-&gt;od_enabled))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(mem_bus=
y_percent)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type =3D=3D CHIP=
_VEGA10)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pcie_bw=
)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* PCIe Perf counters won't work on APU nodes */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(unique_=
id)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!adev-&gt;unique_id)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_feat=
ures)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type &lt;=3D CHI=
P_VEGA10)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;sta=
tes =3D ATTR_STATE_UNSUPPORT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type =3D=3D CHIP_ARCTURU=
S) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Arcturus does not support standalone mclk/socclk/fclk lev=
el setting */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_fclk)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt=
;attr.mode &amp;=3D ~S_IWUGO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt=
;store =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;#undef DEVICE_ATTR_IS<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&#43;static int amdgpu_device_attr_create(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct am=
dgpu_device_attr *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
mask)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *dev_attr=
 =3D &amp;attr-&gt;dev_attr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name =3D dev_attr-&gt=
;attr.name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*attr_perform)(struct amdgpu=
_device *adev, struct amdgpu_device_attr *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; uint32_t mask) =3D default_attr_perform;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!attr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;states =3D=3D ATTR_S=
TATE_UNSUPPORT ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;=
states =3D=3D ATTR_STATE_ALIVE)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;perform) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; attr_perform =3D attr-&gt;perform;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D attr_perform(adev, attr, =
mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;failed to perform device file %s=
, ret =3D %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name, ret);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the attr-&gt;states maybe chan=
ged after call attr-&gt;perform function */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;states =3D=3D ATTR_S=
TATE_UNSUPPORT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&=
gt;dev, dev_attr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;failed to create device file %s,=
 ret =3D %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name, ret);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_AL=
IVE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static void amdgpu_device_attr_remove(struct amdgpu_device *adev, <br>
&#43;struct amdgpu_device_attr *attr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *dev_attr=
 =3D &amp;attr-&gt;dev_attr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;states !=3D ATTR_STA=
TE_ALIVE)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, =
dev_attr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_DE=
AD;<br>
&#43;}<br>
&#43;<br>
&#43;static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr *attrs,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t counts,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; counts; i&#4=
3;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_device_attr_create(adev, &amp;attrs[i], mask)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;failed:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; i &gt; 0; i--) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, &amp;attrs[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static void amdgpu_device_attr_remove_groups(struct amdgpu_device *ade=
v,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr *attrs,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t counts)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; counts; i&#4=
3;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, &amp;attrs[i]); }<br>
&nbsp;<br>
&nbsp;static ssize_t amdgpu_hwmon_show_temp(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct device_attribute *attr, @@ -2790,7 &#43;2838,7 @@ static umode_t=
 hwmon_attributes_visible(struct kobject *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umode_t effective_mode =3D=
 attr-&gt;mode;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* under multi-vf mode, th=
e hwmon attributes are all not supported */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
!amdgpu_sriov_is_pp_one_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_virt_get_sriov_vf_mode=
(adev) =3D=3D SRIOV_VF_MODE_MULTI_VF)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* there is no fan under p=
p one vf mode */ @@ -3241,8 &#43;3289,8 @@ int amdgpu_pm_load_smu_firmware(=
struct amdgpu_device *adev, uint32_t *smu_versio<br>
&nbsp;<br>
&nbsp;int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D adev-&gt;p=
owerplay.pp_handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.sysfs_init=
ialized)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -3260,168 &#43;3308,25 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_power_dpm_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file for dpm state\n&quo=
t;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_power_dpm_force_performance_level);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file for dpm state\n&quo=
t;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_num_st=
ates);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_num_states\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_cur_st=
ate);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_cur_state\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_force_=
state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_force_state\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_table)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_table\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_pp_dpm_sclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_sclk\n&quot;=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Arcturus does not support standalo=
ne mclk/socclk/fclk level setting */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_AR=
CTURUS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_mclk.attr.mode &amp;=3D ~S_IWUGO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_mclk.store =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_socclk.attr.mode &amp;=3D ~S_IWUGO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_socclk.store =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_fclk.attr.mode &amp;=3D ~S_IWUGO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_pp_dpm_fclk.store =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_pp_dpm_mclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_mclk\n&quot;=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_V=
EGA10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_so=
cclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_dpm_socclk\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_ARCTURUS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_c=
reate_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device fil=
e pp_dpm_dcefclk\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_V=
EGA20) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_fc=
lk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_dpm_fclk\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the reset are not needed for SRIOV=
 one vf mode */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.sysfs_initialized =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_virt_get_sriov_vf_=
mode(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SRIOV_VF_MODE_ONE_VF:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mask =3D ATTR_FLAG_ONEVF;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SRIOV_VF_MODE_MULTI_VF:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mask =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SRIOV_VF_MODE_BARE_METAL:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mask =3D ATTR_FLAG_MASK_ALL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_ARCT=
URUS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_pc=
ie);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pp_dpm_pcie\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_pp_sclk_od);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_sclk_od\n&quot;)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev, &amp;dev_attr_pp_mclk_od);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_mclk_od\n&quot;)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp=
_power_profile_mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_power_profile_mode\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((is_support_sw_smu(adev) &amp;&am=
p; adev-&gt;smu.od_enabled) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!is_support_=
sw_smu(adev) &amp;&amp; hwmgr-&gt;od_enabled)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_od_clk_voltage);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;pp_od_clk_voltage\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;d=
ev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_gp=
u_busy_percent);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gpu_busy_level\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APU does not have its own dedicate=
d memory */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;asic_type !=3D CHIP_VEGA10)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_mem_busy_percent);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;mem_busy_percent\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PCIe Perf counters won't work on A=
PU nodes */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pcie_bw);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file pcie_bw\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;unique_id)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_unique_id=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;failed to create device file unique_id\n&quot;);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_device_attr_create=
_groups(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attrs,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(amdgpu_device=
_attrs),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_=
VEGA10) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;fl=
ags &amp; AMD_IS_APU)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_features);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;pp_features\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.sysfs_initiali=
zed =3D true;<br>
&nbsp;<br>
@@ -3430,51 &#43;3335,15 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *=
adev)<br>
&nbsp;<br>
&nbsp;void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D adev-&gt;p=
owerplay.pp_handle;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enable=
d =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hwmon_=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmon_device_unregister(adev-&gt;pm.int_hwmon_dev);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_power_dpm_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_power_dpm_force_performance_level);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_num_states);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_cur_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_force_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_table);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_dpm_sclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_dpm_mclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_V=
EGA10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_socclk);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_ARCTURUS)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_fi=
le(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_ARCT=
URUS)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_pcie);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_V=
EGA20)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_fclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_sclk_od);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_pp_mclk_od);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp=
_power_profile_mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((is_support_sw_smu(adev) &amp;&am=
p; adev-&gt;smu.od_enabled) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!is_support_=
sw_smu(adev) &amp;&amp; hwmgr-&gt;od_enabled))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_od_clk_voltage);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_gpu_busy_percent);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;asic_type !=3D CHIP_VEGA10))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_mem_busy_percent)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pcie_bw);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;unique_id)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_unique_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_=
VEGA10) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;fl=
ags &amp; AMD_IS_APU))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_features);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove_groups(=
adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_attrs,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ARRAY_SIZE(amdgpu_device_attrs));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_pm_compute_clocks(struct amdgpu_device *adev) diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_pm.h<br>
index 5db0ef86e84c..5ca5f3f9e8c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h<br>
@@ -30,6 &#43;30,54 @@ struct cg_flag_name<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum amdgpu_device_attr_flags {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC =3D (1 &lt;&lt; 0=
),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_ONEVF =3D (1 &lt;&lt; 1=
6),<br>
&#43;};<br>
&#43;<br>
&#43;#define ATTR_FLAG_TYPE_MASK&nbsp;&nbsp;&nbsp; (0x0000ffff)<br>
&#43;#define ATTR_FLAG_MODE_MASK&nbsp;&nbsp;&nbsp; (0xffff0000)<br>
&#43;#define ATTR_FLAG_MASK_ALL&nbsp;&nbsp;&nbsp;&nbsp; (0xffffffff)<br>
&#43;<br>
&#43;enum amdgpu_device_attr_states {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_UNSUPPORT =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_SUPPORT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_DEAD,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_STATE_ALIVE,<br>
&#43;};<br>
&#43;<br>
&#43;struct amdgpu_device_attr {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute dev_attr;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_device_attr_flags fla=
gs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_device_attr_states st=
ates;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*perform)(struct amdgpu_devi=
ce *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devi=
ce_attr* attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask);<br=
>
&#43;};<br>
&#43;<br>
&#43;#define to_amdgpu_device_attr(_dev_attr) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(_dev_attr, struct am=
dgpu_device_attr, dev_attr)<br>
&#43;<br>
&#43;#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)=
 \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .dev_attr =3D __ATTR(_name, _mo=
de, _show, _store),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D _flags,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .states =3D ATTR_STAT=
E_SUPPORT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ##__VA_ARGS__, }<br>
&#43;<br>
&#43;#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __AMDGPU_DEVICE_ATTR(_name, _mode=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_get_##_name, amdgpu_set_##_name,&nbsp;&nbsp;&nbsp;=
&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; _flags, ##__VA_ARGS__)<br>
&#43;<br>
&#43;#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR(_name, S_IRUGO=
 | S_IWUSR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; _flags, ##__VA_ARGS__)<br>
&#43;<br>
&#43;#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __AMDGPU_DEVICE_ATTR(_name, S_IRU=
GO,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_get_##_name, NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; _flags, ##__VA_ARGS__)<br>
&#43;<br>
&nbsp;void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);&nbsp; =
int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);&nbsp; int amdgpu_pm_v=
irt_sysfs_init(struct amdgpu_device *adev);<br>
--<br>
2.17.1<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FCBAE34F505EB081BE46F7A40MN2PR12MB4488namp_--

--===============0410079139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0410079139==--
