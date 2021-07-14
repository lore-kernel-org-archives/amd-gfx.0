Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53864C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0836115B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0836115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CEA6E2EF;
	Wed, 14 Jul 2021 14:21:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7A16E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 14:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arLLYSYLRuMGyI3rnOoBkNDyQmBOtgN2c6BLSrXqF8VkTuWyywZ4bmvLzF6mterI7PaPXuUrH1x+TFIMZSe36fsrVaBmaK54Dc1fJCPgtEVs5CndPFYUR896WitNrP6sNCrjfVKn2VaR3PEZFNY70j9gE/VtLaB2HrrFvmV3IKyUCqtiR0rEp/QIhO9VNuwUIOhmzkMRBMzrsre2+QdVnV/eJfMMVsDUHbMw6Y5ynOO1Oenqg6bFf35aMflOU72WB2T5PL8FGI//i3BOclF3zPPnbmsBRljIroOiCEPSIYzgobped2ijP0dxqWORPbFEpVpAZ6YWiVZuv8cFCO9q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sknL7bCDP/iFBdpjlYZOoPhK23l/CZTBwkyMtVZ/1vw=;
 b=gLa9w+D7UMaygGEKJwd+YdteS6Ai8KrNZDGPfJRLbnRLdYDk2bA6XXtpjSTbTWyJerp/sbqUlMuby4DQGTDQHJnN7JxrtAzr09Vze7RdSwfQUYHuFhWuLpLtsm+jZlW1pYiwuEaSFqhmcWrZFnx2A2hDYPQV+zX9wfEk2HViLJ68NxPVlP6x8o7CGu8DY88lxiz2cxEnnNlIfswwCfO6xdrtHTJiQhnXrGBbYl44ZM4+TBYEzdfM6tHq+SRReFI3G+P4Bn0UEAThnzCoHhr8SciYacRT/PDfyQZZPhswCWVw1b3lNNSYlMjPGwiLNeFKw9Z0giGoEYIHccaEU3gDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sknL7bCDP/iFBdpjlYZOoPhK23l/CZTBwkyMtVZ/1vw=;
 b=N5CN7RgHBYQsMrn1eCp69i32yrUvECS664Vzs82aV4AwLZHHHpDsxJaA/dp9mqyXkLLdBx8UvxC0pLSURBqF2I4TFNMw759aeqy3ZU+HtAWvtFhRO8K55vWnY89VJjFjlj+qZuwkGivQWCuaF+AO8KkQr2wZBZmDwt/3ebQh9AI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 14:21:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 14:21:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update the golden setting for vangogh
Thread-Topic: [PATCH] drm/amdgpu: update the golden setting for vangogh
Thread-Index: AQHXeJNQA1fGqLl/x0yLLD8j8XPrIKtChb8w
Date: Wed, 14 Jul 2021 14:21:43 +0000
Message-ID: <BL1PR12MB5144BF5302C21A6E022CCF84F7139@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210714093203.9191-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210714093203.9191-1-Xiaojian.Du@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-14T14:21:42.733Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a9a79f-b712-4063-161b-08d946d2b46a
x-ms-traffictypediagnostic: BL1PR12MB5190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB51900F12FA9F40BA792A9DC0F7139@BL1PR12MB5190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DULo0QBKw0QJjv5ldGpAxdREqNUR7snOWUH2CPdAKYQuwu73SjgLLG0timd7sCJs5htNpbq/jq0Hgc32M8i/02CgpdpQfUNPy7wCfIuHxpsKgQclt96iGjVeRf0on3TbITXLJdSCIAqzyEGMvVxl+3597P51TgHSNDs8Y9/LgY7h9uefSZRD97gl8s304SYfQVUpUjE6YyC4ldj0/FPVIN1vAhHTWy4b7TBy9KioAZSv1pDs8pgTNdR1eMV8+Gtfs/g9zaQw5k8AVOHGC0FIU8pgYyUIy8RQS+EmgxBjulDw0CpB3p/IU0E4M1uHDVqDMzaf7pev6ZORrj8kTnCZKpXGN2kFdFribEKCZViIP6zcvGOELSX4Hdjyg/B4c5J87ftU/jvjUNEQrJIKMWFD8xfGDHNLgYyhZGKoE4DOtx/aZw/G9E7z9yazEmELxMmBQowWggOEhDZZiL0f/kx6n835sph3Vhq5VtVlg+R6BiZQvIFbV87SwYEr4dhv+EMyZTKwH8bOkLEtxsy614KO2bxc7fNLeL1A1qtooPS5Alo+3XVKcB5QfDT3keAHCQ7bJ8oNnRzO3DQ2OMzJDBjhxdeQRyOHmLt/FDnFuh3hJCl6uKQmOrIU+RJ5azD9p+CFTTM4UyS//hi3S+I3JJQtLr3MKfFreV8iOIEyy0Y3G+j9p8orSHeTmDpNffH23/86XdB++wykxs0Oe1cplSeWHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(55016002)(316002)(2906002)(7696005)(166002)(38100700002)(86362001)(66476007)(8676002)(9686003)(19627405001)(64756008)(66556008)(66446008)(26005)(186003)(6506007)(53546011)(66946007)(8936002)(122000001)(76116006)(966005)(4326008)(83380400001)(478600001)(52536014)(110136005)(71200400001)(33656002)(15650500001)(5660300002)(45080400002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lk2vKxPv2KCrh2SwRbQTMKA3eubIealLK39Ffyqk+YSx6xFUdYZ9fJtTNQl1?=
 =?us-ascii?Q?3f32GTZWfRV+4nAevZWWoqKK8X94dr2DRVgYS5vxxkaj1U/hvbsQ3Zxh6kjK?=
 =?us-ascii?Q?JazpvU9ufObYUhczNHnghZ0KPCZnb0kOOraq3LyqF4YnN+ZHzvILpc2FPt3x?=
 =?us-ascii?Q?xxb/xQ8FIxegz2dzbYwxuNTTsCSsgQAk7Qzx9zOB6Jl1GpLdhRrr/BpTp0HO?=
 =?us-ascii?Q?/oNla+pRM0kgZQe57R+PBDzZC9WOKHGJQ5I+leI+kYn6vObKZs+Mp6vvNn3l?=
 =?us-ascii?Q?pl4RwuFuuzBdzimVmZbqO8vEA7w2Dsx8/b+dtf2ZSXlCgXZYDbY2+CQudW7z?=
 =?us-ascii?Q?nBrfCEx+cHqtSgTZIHxEM98t0x2lHKHEByAX6s0ftCv9naN1hZixr9WZzoOr?=
 =?us-ascii?Q?7MGuR54VC4WYIl1dkzwrF8Pl60c2kGZ0v2Rp5C800/i6L/5yGDalcE/JO/z3?=
 =?us-ascii?Q?0Je+s9xCAVEYbwcCmO6NVRgp5jIwJucT9dib6de9wrOLcLcnR6wVJIEec0Wa?=
 =?us-ascii?Q?vj0mVDHQtaJX3OEzdECmlp4onbWx6slhnfmzqLouoS4RxFh+SxrM2UWXIrel?=
 =?us-ascii?Q?bTrmMIHqg7P+TXhJHmyFWZ6UcFcQhciccFna+EQ/HlverkzXq+QVtIh68VwZ?=
 =?us-ascii?Q?gr4X5cSItESSqWU35IDtuHNsBMSOFvMYId53mPZY0I0Kg5QIT4mEN2xcnFgP?=
 =?us-ascii?Q?It2lT7e37cjhAnJsxkOq0kO3bX0fdE4NRxmp+tRldk9j6I+GN34HmgfTJvHc?=
 =?us-ascii?Q?8V+DzwhqipICNln+Wq9ifjUhmGe8YNtURmwXwvb6s/vg/ORELjhDo/w6s2ZF?=
 =?us-ascii?Q?WP1ONNszmBkU3P4P9G+9VEv/r2IqRn1jHr0NaORFih33bwwFIHaJQNn8t9dN?=
 =?us-ascii?Q?NXIeCY8CTfkn14F79gsZfM9Gd89PI/1cCv2iXzyD7jmxhQ0l6BfUZ0kIOGeX?=
 =?us-ascii?Q?ZbTVbqNUSssujbOXy9qfGadzjiLWkyGiqgNH8iPOxiUtrZwSIYcl20062Y/j?=
 =?us-ascii?Q?dBd2U8IG/wbKXae6fFIXcC9P6rjSWVFnOD+q9fM5QixTxd1t3L2bGBAIgnBQ?=
 =?us-ascii?Q?17HvrgxceE2pkMgZEBjxplPkHu4ttvLuQ6mq4iSJa7SVlpqSLzr8XwJj19nK?=
 =?us-ascii?Q?JVLiUHBsvQlBOD29o6j1BxlVvxY9ur44Crd+0gYbhSoeTocDkNxDY5m+rEti?=
 =?us-ascii?Q?EY7k1e2ctr9Ahhjxu9MEN+9I5mIeDqDjOY3CyV7JsDwd82bOeX3rczsGx6jA?=
 =?us-ascii?Q?bVQc98Fd3I2HPrVkoLjyokChDxKvcUNWnlYnegY6kAtcXDtx2lmuP48vwrbb?=
 =?us-ascii?Q?FEEO1PeY6EoXCilvSZg0PgBO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a9a79f-b712-4063-161b-08d946d2b46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 14:21:43.2249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc2xuQoxWJx1d6ksUdAlZxU+eUDQQpcp/cgUKu3rAMY9QfvxWkpAot3ZqAwloXeIh88tmlulH5xsBVYaPOBZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============0373292198=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0373292198==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144BF5302C21A6E022CCF84F7139BL1PR12MB5144namp_"

--_000_BL1PR12MB5144BF5302C21A6E022CCF84F7139BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaojian=
 Du <Xiaojian.Du@amd.com>
Sent: Wednesday, July 14, 2021 5:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amdgpu: update the golden setting for vangogh

This patch is to update the golden setting for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 705fa3027199..9144836798c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3383,6 +3383,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3_vangogh[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x000=
00020),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1_Vangogh, 0xfffff=
fff, 0x00070103),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000=
),
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020)=
,
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x0103000=
0),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00400000=
),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x=
000000ff),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cb620c2e4fb6546e5cb2908d946aa56f3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637618520145692637%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat=
a=3Dt5Jq4s7bJ0oFkSElQuwdMUy%2ByOD7oB1V36hCoAcb4sk%3D&amp;reserved=3D0

--_000_BL1PR12MB5144BF5302C21A6E022CCF84F7139BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaojian Du &lt;Xiaojian.Du@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, July 14, 2021 5:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.=
Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update the golden setting for vangogh</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to update the golden setting for van=
gogh.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 705fa3027199..9144836798c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3383,6 +3383,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3_vangogh[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000020),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSPI_CONFIG_CNTL_1_Vangogh, 0xffffffff, 0x00070103),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DE=
BUG_1, 0x00010000, 0x00010020),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmUTCL1_CTRL, 0xffffffff, 0x00400000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000000ff),<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cb620c2e4fb6546e5cb2908d946aa56f3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618520145692637%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;amp;sdata=3Dt5Jq4s7bJ0oFkSElQuwdMUy%2ByOD7oB1V36hCoAcb4sk%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cb620c2e4fb6546e5cb2908d946aa56=
f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618520145692637%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000&amp;amp;sdata=3Dt5Jq4s7bJ0oFkSElQuwdMUy%2ByOD7oB1V36hCoAcb4s=
k%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144BF5302C21A6E022CCF84F7139BL1PR12MB5144namp_--

--===============0373292198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0373292198==--
