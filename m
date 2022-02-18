Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B393C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FAF10E393;
	Fri, 18 Feb 2022 14:44:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9DB10E3A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEflZLWVJpwPDMBaHOahtvf53LajwG5cAjLkP2UumAc5rIyn7UD1h5Spsi/L9EL4xQvwulrVG6uxkA0eH90G251bnx/n44LWikJaDQIPb3QU8sFkMZVdVzdCGra/JQh84diOx3BJ7ylONJ6BFUx+fnDKS/YHbsb7I8FXDZH+7GVIyLTA9QJgCNieHOXObCNH+CB5Ec7XbDBkkwSNOwOiQc1dOfjQ9T4Cr3p56IDCBYAARdkCrsxCQSqL+zoj9+EUdZh+++gpCyowymyi5mxkBetitGoyEf8BTUIe83L+pUly221WKo8f2VSjJPXqX60KmVqoEpmIr3gjH74Er40a6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPddqTBDohWJ3IT282by4aWQopRyC5rb9LY3VajXXd0=;
 b=H3aAcyQMohs4fHVCWsV02clNjplbkKR3VPTmCdOx206ZHbl0afryMsjjANTEEMgyTpjZTh9B3rYBlX9dXKMQo1qDKLc5mONg6yryPpgFJ26WBzCwwXxAf9pjFZLtZ4DhSk/NvbooY9oVTV8evdyPdUZ8VC5Cf2Mvf7PYZM+iJYWaf5JTiwXNQ4S2XzbwAKH4L0HWiAZO3fanOa2EZB74/a5CnINExt0tFY3h/WOXEVNMSKY3ML3EaaJvZDtz9FbINxSoLNgRWP4xxlZkcIEktDsrBwE5pqWB8q8NJsjeI8m56XaE2KhU6Ye3yTeWI8+ncJzzZvx7ViofU10qxl1HhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPddqTBDohWJ3IT282by4aWQopRyC5rb9LY3VajXXd0=;
 b=MDqyQNKGDkhqQFl9Anl16D0+oGEDbSQrS3DjVRc9kfgs8qzx428domAxwbQFtSBaS53R43HUlwQ8m+UDzBOCLl5VP6y9/zoXz7ga2ywbveuh8jE/4tOB33j6jihFHwkfdj9ZSw/Be1evRPtN1l18pN/o0cZVPyvuUDUaVxPT8g8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Fri, 18 Feb 2022 14:44:23 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 14:44:23 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>, "Cui,
 Flora" <Flora.Cui@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV
Thread-Index: AQHYJIYXC/OSbf19xEuG+dW6WfKb1KyZYY0AgAABGdA=
Date: Fri, 18 Feb 2022 14:44:23 +0000
Message-ID: <DM5PR12MB24695037ACA51DCFB3038DD2F1379@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220218051157.19548-1-guchun.chen@amd.com>
 <BL1PR12MB51445530B33A46F09054E987F7379@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51445530B33A46F09054E987F7379@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T14:39:13.547Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6b1049-4dbb-4f7e-caf4-08d9f2ed279c
x-ms-traffictypediagnostic: MW3PR12MB4411:EE_
x-microsoft-antispam-prvs: <MW3PR12MB44114D9CADF901C4408A8E18F1379@MW3PR12MB4411.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /k7wu8iIhr7qwhFNgUQTv/oLd7fdwTdBcKaTOGx5mDsRNrcl4ddJYv4sIX7/x2V8iMQdv9hFZeelTvhncCxhNA+ckZWjPe1FKXqnK5htM9bohIpWA8fBtcasbGoPOGIDBDwe6NGODLEBmjV0LvnKnila2Wvu7OgcjgwF1N0gOc22uHK8xhYofoeaZ5PGdrimONlTCXRz9rrRSQlGEJhAj0+FhdhLfv4GxMX0nq6weOYSvg5CPJMnxavhE+/RM9L7vKd4LMcJcF3Yw0p3TdE2YmKoFL1LXCl6SzlMFaIONrVtx8Pfw4ozDd5V1TmJpK5yRBmJGwQ2axQl5pR17UwKmqSUJfzjGewR3t2Kh6cCwdSYNrNc0P6YMThZefRkvDb+PIgOXDjy2nXxpJWisd4ACVwiyZ4MS3o5fPtvXT3k9eLUOJCsY/tlf95FzY3xqL6YfoxX7RVPvAWTehoiMaw14lNCmy5ZnDQmfnjdyCdLkFiMK7LfMfSSUYMMQnO1N18R9YTTX20wH2J1PrCgbLWBHEt5mixYI6l9/MG3PEieyVZ8cl7h7epPfxVwsIDEW5tB/xPBcQDD80IJ2nQ+4hLONR5kA+U4/efeyzF0xCFejQ6UA/y1NlGyx9bi/Y8cKcSdtt6Iy7IeqhzHh2BCj0P3gRtzFegIKVzm62Hf61TqCb81NjICY8U2lNNegzarLkfIrF4IvwfTH9G1Ev/2jx3ROrn9CdhVPBSd7BxdXEa48r0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(2906002)(38100700002)(122000001)(86362001)(64756008)(76116006)(66946007)(52536014)(38070700005)(8676002)(5660300002)(66476007)(66556008)(66446008)(8936002)(9686003)(7696005)(6506007)(316002)(110136005)(6636002)(83380400001)(55016003)(33656002)(921005)(186003)(53546011)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tBTyRW6iEe3EMCRKwXOnWipfVpZI09dPyTe1HsljWmWXIuiWytI0Nyg66XD3?=
 =?us-ascii?Q?Raz3FH15CN64K2bXj0p8de9mS5fT5+upztj1zPPqEmd4IdHg6a0B7WfQ3emZ?=
 =?us-ascii?Q?rH2bSTxJcY3zJ86M5/pDkj6mbzqRVIhCFYIGr8iZJmKIDvggFp/eq3N2O29R?=
 =?us-ascii?Q?iLvX3N4UQ5ZehNTVFr/8sfLOcJgVVA/yGK/5eTYy6wuZrXRlwtlXJ7mbIURv?=
 =?us-ascii?Q?Tg29av+PKXIfd7DvwNV625tu0yLjltzuyUs+Wa9Ss1nY73z7768NV3Cc8JYT?=
 =?us-ascii?Q?SsQY1GXOSD7s1Dzr20QiC5PbF4Zj5z2bfNvQAJpWZ6o6TMTUhg3x2xnQ0xCw?=
 =?us-ascii?Q?5D1/f48pDtCJQTJqIjE1dLE/KO1wrbdGGMZW9eHGgbXcv9MW1EaxhziZC03h?=
 =?us-ascii?Q?u1NwCVBzZHHC2KsxeWZYEVJyUj3IJWKfN021wUsHORqUSS29DP+e3ipsuUFB?=
 =?us-ascii?Q?wXLRPZn/2KbvyURstsRiRgB8m+KB8LoxEgTu6a4ywzoOZ2o7ZXAD5zBYX/TJ?=
 =?us-ascii?Q?BEKabMUH/TuolhWWyyzXRDijrs7qJzPOed8m4APEQljklIorDJoVDBkTK4lG?=
 =?us-ascii?Q?2hp6X1/xUXdhSv6fyUxXX9xwREYZzHS2HI3MECham5FogFPlsq2g68GtVUmv?=
 =?us-ascii?Q?rD0aNGc51VLQPbnKOAWzmG/kMbPdd23lf+Iw5i6Cuun3xyT77b2QF0GZDev0?=
 =?us-ascii?Q?4/jCMp2CpLDNi7BVvrsRx7XW7kdfEhjNQWeVCLWWT2FhY/xGq9G6zxwxSsGQ?=
 =?us-ascii?Q?F9jHy8mxWKwinjoG8vTEbvAcnbudLz4rwpSTKQ9piKX6HpmuZbnH4uTm0NxS?=
 =?us-ascii?Q?IS5fZiPMmLKP1TFy+sJTg4e3dQdomlRvpbm9TpW2R8wdHSDA6e2voeF4AR/8?=
 =?us-ascii?Q?WfYF6814pCLikXH7JkzCn0OfaMne76oRtjIh4s8H4iN5VjIiit3s2airknlU?=
 =?us-ascii?Q?WiqAj1l85Kix2doH3JK05drRQ3yP4taBptOCiW3UfUUf5RyW+K5l58isNses?=
 =?us-ascii?Q?SuAZNmyeaCwQYYRr+PreFamf+pnj4gm56iCakysDMxV7RBEqSIbmApdrHz+7?=
 =?us-ascii?Q?w8JdD2cwjtjgWcNwWXUcXezIhGvcD4TUfLo9T7akxy4JRnqEzSFGIB39R/mv?=
 =?us-ascii?Q?P0R8QCHDIxfk3/AZ2l1+LYCDl30QEjZqTyOvXiOGb3Lnq1O0hyQmZiClwO0L?=
 =?us-ascii?Q?e2jX9ARoE2kUpQIUl8Hbt4hFla3W49eSj/XVPZGtW5Oa6IU+CIWMAOfmccFf?=
 =?us-ascii?Q?rsT4jmJlhmvwGydvDbKe56YUftnGki4RCgSccM6cdjfN5LiYekKmeA0tFAQn?=
 =?us-ascii?Q?HtktkwQIcmp/ZulSxlpYI3OP80ZyqQXsew/XAhUtDQ1ZPUrLDz1Jv3a9e+28?=
 =?us-ascii?Q?NCxYJlR4Bqh1gOVZnKcyZm4slyeKp92YHIwojsBgGi8LimbtIGRTqtqLYOfK?=
 =?us-ascii?Q?so4pboa2sM26qKKei9BCz4iMJswrXZlB6eAcwReZvtqzSXsm78Rv4OnaQJPt?=
 =?us-ascii?Q?M7yezOOupImLaaH72elmgy5OHm9S6abgRsLrhg+IfLyAeKdOFAaxAvvw2UBo?=
 =?us-ascii?Q?bOr7ziN1Se+M9a/iufziXFxx1zm43KyiutWguAb+Iro7BH0JZQpV1ZljTh1h?=
 =?us-ascii?Q?pqDr0UgBx5Vc2KDQYvMATsA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24695037ACA51DCFB3038DD2F1379DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b1049-4dbb-4f7e-caf4-08d9f2ed279c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:44:23.3362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmJv9Iywutqtyq8Wh51ixAK0zexn2kBVloXH9RJneXSI3WCOCdYpGQQ3ewvBFVFzapUB/mKJfFuSwI0w2uuvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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

--_000_DM5PR12MB24695037ACA51DCFB3038DD2F1379DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Excellent point, exactly, we should check adev->enable_virtual_display. Let=
 me send out a v2 soon.

Regards,
Guchun

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 18, 2022 10:39 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhan=
g, Hawking <Hawking.Zhang@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>; Cui,=
 Flora <Flora.Cui@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; P=
an, Xinhui <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV


[Public]

I think we should check adev->enable_virtual_display instead of sr-iov?  Yo=
u can enable virtual display on bare metal as well.

Alex
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Friday, February 18, 2022 12:11 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Shi, =
Leslie <Yuliang.Shi@amd.com<mailto:Yuliang.Shi@amd.com>>; Cui, Flora <Flora=
.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Koenig, Christian <Christian.Koeni=
g@amd.com<mailto:Christian.Koenig@amd.com>>; Pan, Xinhui <Xinhui.Pan@amd.co=
m<mailto:Xinhui.Pan@amd.com>>
Cc: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV

vkms leverages common amdgpu framebuffer creation, and
also it does not support pixel format modifier, so there
is no need to check tiling flags when initing framebuffer.
This can fix below calltrace:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com<mailto:Yuliang.Shi@amd.com>>
Signed-off-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0d4ad1ee8348..63cc210e4b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,
         if (ret)
                 return ret;

-       if (!dev->mode_config.allow_fb_modifiers) {
+       if (!dev->mode_config.allow_fb_modifiers && !amdgpu_sriov_vf(adev))=
 {
                 drm_WARN_ONCE(dev, adev->family >=3D AMDGPU_FAMILY_AI,
                               "GFX9+ requires FB check based on format mod=
ifier\n");
                 ret =3D check_tiling_flags_gfx6(rfb);
--
2.17.1

--_000_DM5PR12MB24695037ACA51DCFB3038DD2F1379DM5PR12MB2469namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Excellent point, exactly, we should check adev-&gt;<=
span style=3D"color:black">enable_virtual_display. Let me send out a v2 soo=
n.</span><o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, February 18, 2022 10:39 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Shi, Leslie &lt;Yuli=
ang.Shi@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<=
br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRI=
OV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I think=
 we should check adev-&gt;enable_virtual_display instead of sr-iov?&nbsp; Y=
ou can enable virtual display on bare metal as well.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, February 18, 2022 12:11 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;; Shi, Leslie &lt;<a href=3D"mailto:Yuliang.Shi@amd.com">Yul=
iang.Shi@amd.com</a>&gt;; Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.co=
m">Flora.Cui@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Chris=
tian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;;
 Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.com</=
a>&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">vkms leverages common=
 amdgpu framebuffer creation, and<br>
also it does not support pixel format modifier, so there<br>
is no need to check tiling flags when initing framebuffer.<br>
This can fix below calltrace:<br>
<br>
amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier<br>
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]<br>
<br>
Signed-off-by: Leslie Shi &lt;<a href=3D"mailto:Yuliang.Shi@amd.com">Yulian=
g.Shi@amd.com</a>&gt;<br>
Signed-off-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.com">guchu=
n.chen@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0d4ad1ee8348..63cc210e4b6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;mode_config.allow_fb_mod=
ifiers) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;mode_config.allow_fb_mod=
ifiers &amp;&amp; !amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_WARN_ONCE(dev, adev-&gt;family &gt;=3D AMDGPU_FAM=
ILY_AI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX9+ requires FB check based on forma=
t modifier\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D check_tiling_flags_gfx6(rfb);<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24695037ACA51DCFB3038DD2F1379DM5PR12MB2469namp_--
