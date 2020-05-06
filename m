Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD43C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86C220714
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86C220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5093C894E0;
	Wed,  6 May 2020 06:22:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB45894E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj6tfJpfAFuXTa5ISCAqATM/T1xC53YJCFScbFiMHbivcEGCTx4fu+2iMh76xOaXRxJGaZLJRm23RJWz0WSZhMAInjLYnpzk+qQ+0NB2RUinh34MCmMih4YG6KeJ32jcgaGmLU7kxf3Qo+5C8QTg8EIyYGkzI5Pa5+5RenktMaJBJJnhwTr2N6lEYBBbzAzmVQNc2BS7iAMSvi6sOxS00iMbAZjobQFGezA4QoIltPB9VIcCbLc2wEpd+KsnlH7BqVPwC5s/a8a3GIVpR3Chjeuga3uUGboMxiX1BrBmJbU8Rxle9LT4LEYbOJ1AsG5va9Dv/l266V+I3B7Blxs+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NGRTTRD8fpDA1V38NOR8eFvH7yIY+6rE4jhYMPfNKg=;
 b=Y1yhzYSB92zvhpxf4LjfuN9sfgJXZQOIK2zGfBp11ZuqrYSsg5t7CBmpDnthRmISUzaAUTd8NDsqJW6tSnLkg8TpJE+c+p0JCXiL0oBoOIiNNQnqnXT27U/CHW39xtWmG8z6mLlP9wMh4ADsJa8Hs3HwQclqi02Ja0/rLpf5g/4DLGRT4E1p9Rf6BcH/i3X7XUsFOC3LfcApUCM/S8RC9IxAsAeLuOpIsqMRtmpw3m7wrFSdX1c+EQTtVKeaHSYWIbDlpV8Jox+rtmyVBnizMToqBFHNZ81f90zaijkMH4LXesK0yBCryErTiF84gOsW2QvxNIDaQ5pVT9LfsLBPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NGRTTRD8fpDA1V38NOR8eFvH7yIY+6rE4jhYMPfNKg=;
 b=MbvloGckrshrhrVVmE8BQAsOkXodNK/CAWPeGCRVdBh20hZTpLZmsix8oVXElYtRED+b0ZZte/xfKqAaHRN5cZY4LO8usgLLIrxwIH/xbOTWZdSgtZSquTxlMQ+WTX2lGbr+DRpD/F2tq+ayCAFABO0qRykxOrewNg9FOAbdKIw=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 06:22:26 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:22:26 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup not_vf & pp_not_vf in powerplay
Thread-Topic: [PATCH] drm/amdgpu: cleanup not_vf & pp_not_vf in powerplay
Thread-Index: AQHWI26H7ZAPWkONmUqQpJKwsHNChqiallhc
Date: Wed, 6 May 2020 06:22:26 +0000
Message-ID: <BY5PR12MB40682C65CA302870D0915C23A2A40@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200506062040.15692-1-kevin1.wang@amd.com>
In-Reply-To: <20200506062040.15692-1-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T06:22:26.109Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c99b2f40-33fa-4a5e-bc77-08d7f185d8d0
x-ms-traffictypediagnostic: BY5PR12MB4164:|BY5PR12MB4164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4164B4E2098AA0B50747AC25A2A40@BY5PR12MB4164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLaMaknR1CxKQU5cposJUtppkfuzbJoXmYo22pvrIp9nPnXwgwDxRpT2ipv2dN/gVqCgk5fJSSQVSH+jLqUjBrAEOeLmpCtgJ1ne5GU6AKo2qhzaEWj8PiLYLU9VUhxurh4I8oD9cYPNO6jJkjJHkRuIKVEbvN5o+YT6RovfQcHLIAtp/WEIqbJwbhh8t0WyVQjc7rfjCdcLPZlvW/T0B+GQ9vo3aJ7Yq7RmLPVfzKd6rqa2uCLm97ZdmkxILPm497wl9QoGE8o8cpXJ4mPLAzN5aTSxdmogxEMamOGUSz48uU0OfrhWgNpYMkwNyPSXckADAxVmh1eR7xlbfujvBtp4J6NM38cOjuYgpVRuGWcorfYeGvewkzLhLNK/NxLnQr+DAgnj1o577Gh/KCJGeJiUMa4YpT3Iqn8kvjQ459w8W2U7PJgGUWNL6AAMAtX/e8we2YXhEkYBr6+JbgU5fUrLFJbdWzZq3i/dS398ZslYkIdsxZloGfI+pkjVk0vSoZ6ZuOeBd23X70627UA9jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(33430700001)(53546011)(33440700001)(7696005)(54906003)(4326008)(6506007)(5660300002)(86362001)(478600001)(316002)(76116006)(186003)(66556008)(66946007)(9686003)(91956017)(2906002)(66476007)(66446008)(71200400001)(26005)(55016002)(8676002)(6916009)(19627405001)(33656002)(52536014)(64756008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ByjMsAAR7u4gitmRZADqo03OROAP/1aX54TM+fYrehoNJo/IeLketTGVWQh3/odICETxH5bWpOXlAgLRusWdWT6FoQ3Q1w83zDDDnfiIb2IWjJK5j/VrPQESw8ANgmEaqkazrtWVV2aBBeoINSigsescw1TXtcsLxdgl4u38rdsjTFFjzuwi1u3K68tPfKXGfsMZUbf7yysypA38wEi4KCasz9ux7UzvwrDkVoc5s/nYX1mUEgHR0qJI87ygx2ovM5CTVB/0rnZhNtv9UTpOVtEZ3SOxe0spYj2Yi0+sPgzICuGoyfHjmKGb1K+7tP5VAN0KoYt/ej9ZrJWpbSipTVdGOCXHGOwFc9/XwyEkG6+ygpxUUv2elkwEG24W4vFmo3g1j3CK607zqyAbLJcbRW3vm+0G8t07Lrrd2FMghU1jV8H1QnXRyFW0719US7CHYdwIppn+5wQPiv2uM+w2YcLfFjXD0sIMiWoQY0Q5vk7caU9BHqL6m1rO9oJqka0J65taxfeI0MA3zNT87DWyufds1KXJKpvANtiHS4bwoAOSSMZM1RGWh6Cq9EyOBoV10lRpZ+kNtPIb1gEm5Vl8kNsEhB9rIIVrH5JXDYtGpqMtcSUlFYtMZZQmUswc2+GYLSgemNi8X6FWYrWUbSoDZp0Kp5fRHhhvLRy+x+oZIx3ZqbyQDxcPsSTvoREJrcyD6MYZAJliWZfWKkBClz28A7qzyuxXxgbs7FHOxuWNYVYknQfH455BMDskK73ggV4j3XlVqoDcqMaSBeEhqhBtnk9N/2YA9E+6TUg0knVjxDI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b2f40-33fa-4a5e-bc77-08d7f185d8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 06:22:26.5661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy6RIHXUSvKowiBEemtj/IS6ysHINs1C1hjJI6AiEJHy4KAl7BVlxc+pj9fQkS5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0838484405=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0838484405==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40682C65CA302870D0915C23A2A40BY5PR12MB4068namp_"

--_000_BY5PR12MB40682C65CA302870D0915C23A2A40BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

send error, please ignore this patch.

Best Regards,
Kevin
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, May 6, 2020 2:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Feng, Kenneth <Kenneth.Feng@=
amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: cleanup not_vf & pp_not_vf in powerplay

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 14 +++++++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   |  6 +++---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index fc31499c2e5c..5d22a80c4dea 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -47,7 +47,7 @@ static int amd_powerplay_create(struct amdgpu_device *ade=
v)
                 return -ENOMEM;

         hwmgr->adev =3D adev;
-       hwmgr->not_vf =3D !amdgpu_sriov_vf(adev);
+       hwmgr->vf_mode =3D amdgpu_virt_get_sriov_vf_mode(adev);
         hwmgr->device =3D amdgpu_cgs_create_device(adev);
         mutex_init(&hwmgr->smu_lock);
         mutex_init(&hwmgr->msg_lock);
@@ -1438,12 +1438,12 @@ static int pp_get_asic_baco_capability(void *handle=
, bool *cap)
         if (!hwmgr)
                 return -EINVAL;

-       if (!(hwmgr->not_vf && amdgpu_dpm) ||
-               !hwmgr->hwmgr_func->get_asic_baco_capability)
+       if (!hwmgr->pm_en)
                 return 0;

         mutex_lock(&hwmgr->smu_lock);
-       hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
+       if (hwmgr->hwmgr_func->get_asic_baco_capability)
+               hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
         mutex_unlock(&hwmgr->smu_lock);

         return 0;
@@ -1473,12 +1473,12 @@ static int pp_set_asic_baco_state(void *handle, int=
 state)
         if (!hwmgr)
                 return -EINVAL;

-       if (!(hwmgr->not_vf && amdgpu_dpm) ||
-               !hwmgr->hwmgr_func->set_asic_baco_state)
+       if (!hwmgr->pm_en)
                 return 0;

         mutex_lock(&hwmgr->smu_lock);
-       hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)stat=
e);
+       if (hwmgr->hwmgr_func->set_asic_baco_state)
+               hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_ST=
ATE)state);
         mutex_unlock(&hwmgr->smu_lock);

         return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index f48fdc7f0382..e2379efcd621 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -221,9 +221,9 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 {
         int ret =3D 0;

-       hwmgr->pp_one_vf =3D amdgpu_sriov_is_pp_one_vf((struct amdgpu_devic=
e *)hwmgr->adev);
-       hwmgr->pm_en =3D (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf)=
)
-                       ? true : false;
+       hwmgr->pm_en =3D (amdgpu_dpm && vf_mode =3D=3D SRIOV_VF_MODE_NORMAL=
)
+               ? true : false;
+
         if (!hwmgr->pm_en)
                 return 0;

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 15ed6cbdf366..9edb70933c46 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -742,6 +742,7 @@ struct pp_hwmgr {
         bool not_vf;
         bool pm_en;
         bool pp_one_vf;
+       enum amdgpu_sriov_vf_mode vf_mode;
         struct mutex smu_lock;
         struct mutex msg_lock;

--
2.17.1


--_000_BY5PR12MB40682C65CA302870D0915C23A2A40BY5PR12MB4068namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
send error, please ignore this patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 6, 2020 2:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Fen=
g, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: cleanup not_vf &amp; pp_not_vf in power=
play</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&=
gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 14 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 1 &#43;<br>
&nbsp;3 files changed, 11 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index fc31499c2e5c..5d22a80c4dea 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -47,7 &#43;47,7 @@ static int amd_powerplay_create(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;adev =3D adev;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;not_vf =3D !amdgpu_sriov_vf=
(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;vf_mode =3D amdgpu_virt=
_get_sriov_vf_mode(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;device =3D amdgp=
u_cgs_create_device(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;hwmgr-&gt;=
smu_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;hwmgr-&gt;=
msg_lock);<br>
@@ -1438,12 &#43;1438,12 @@ static int pp_get_asic_baco_capability(void *ha=
ndle, bool *cap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;not_vf &amp;&amp; amd=
gpu_dpm) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !hwmgr-&gt;hwmgr_func-&gt;get_asic_baco_capability)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;=
smu_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;get_asic_bac=
o_capability(hwmgr, cap);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;get_=
asic_baco_capability)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;get_asic_baco_capability(hwmgr, cap=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1473,12 &#43;1473,12 @@ static int pp_set_asic_baco_state(void *handle,=
 int state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;not_vf &amp;&amp; amd=
gpu_dpm) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !hwmgr-&gt;hwmgr_func-&gt;set_asic_baco_state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;=
smu_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_asic_bac=
o_state(hwmgr, (enum BACO_STATE)state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
asic_baco_state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_asic_baco_state(hwmgr, (enum BA=
CO_STATE)state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index f48fdc7f0382..e2379efcd621 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -221,9 &#43;221,9 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pp_one_vf =3D amdgpu_sriov_=
is_pp_one_vf((struct amdgpu_device *)hwmgr-&gt;adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pm_en =3D (amdgpu_dpm &amp;=
&amp; (hwmgr-&gt;not_vf || hwmgr-&gt;pp_one_vf))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? true : false;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pm_en =3D (amdgpu_dpm &=
amp;&amp; vf_mode =3D=3D SRIOV_VF_MODE_NORMAL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ? true : false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 15ed6cbdf366..9edb70933c46 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -742,6 &#43;742,7 @@ struct pp_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool not_vf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pm_en;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pp_one_vf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_sriov_vf_mode vf_mode=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex smu_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex msg_lock;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB40682C65CA302870D0915C23A2A40BY5PR12MB4068namp_--

--===============0838484405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0838484405==--
