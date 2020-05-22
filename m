Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE46C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C74920757
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2L09JfIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C74920757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F8C6E046;
	Fri, 22 May 2020 05:53:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E2F6E046
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy1gBhT1M1rYEwhETaNm60CROiNMJOvFJOw67nX21bp4WH/Jioe3FIG9DlwXR+CfYUafnjLyYbjR4iYT0D2jD2zgVCt8XN5/iU1xS2IRIal5nJjM8uInPDGVo8dDbuHtstNC3Xmfhzmxf2yOOa3HSWrUwxlCr/X7TGtqQrzWCyQ2krQ9iUSPmrrhQCZo7FYCgVlEkuTIhXlX3FQyAeamxCYuwamIwCPxmTAdX0Q3Fpu+rEhrL5+15vTYQnqUVTWTfmDi0BA69EPb3Al+EJ8L50Le6dLpFwgkqUUjHREzYGlf2k+fb+CG7V67eQhKgBAV0s5jABpOekaOi59FWL0/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo0AZH1B6Y2F9V7Qo3GV3CZrgPhgBsvJgUAy7NXmey0=;
 b=dWHvKQCHDkSRZozY2NcXkS9nKNc1wzD48gje1yUUQWQEl7KCVTt9hVgXrdfReXsb5gN6cxjSTZkKCl68Ak0o52eaOyrLHsrEq0VzIjtDRCeiIUeGBZNUeD46pfz7+RLioiitszyF/GEwdGzAVqw/QW+XND0ELqMfkqXX2KmDJVdH7AZymbuwa8LP5p4APXn6ZAtCfbUJUcjyz3a9/pQGMUTPnhQulMraRoMGQjQh4Qrey/yEmwmFLxGkyUxAF+gmfK4fl7ba46fdCONXCWcjKKvPB52rOpOGQWQjFYe2VzcObP7uwoo4N+SwojVj3TwcpKxV4RkJ+nWIvZMdnkC6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo0AZH1B6Y2F9V7Qo3GV3CZrgPhgBsvJgUAy7NXmey0=;
 b=2L09JfITj3TBIpdRMq94bqSYQbHPWji8Vn0y/xNo3X5BEDeThFmWRSA32mYgEJUsXeaHobW1FfKREnIeX9p1CKfqymJCmfRpQCk6HYV9KxaqJVU+wiHs8OIp98yiqOPWINZhuHlxjnk1tfbe5TO8bXDto6RYVky+HRT4o6mCBlM=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3986.namprd12.prod.outlook.com (2603:10b6:a03:195::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 05:53:18 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 05:53:18 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU
Thread-Index: AQHWL7gl6BJxwgFrSUypIHvvSK+vlaizlfqggAAE4e0=
Date: Fri, 22 May 2020 05:53:18 +0000
Message-ID: <BY5PR12MB4068ABF0C467558D479D4D49A2B40@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200521213806.4016-1-alexander.deucher@amd.com>,
 <DM6PR12MB261949C39144B50C765AE290E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261949C39144B50C765AE290E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:53:22.842Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2154330-f35c-4bbb-bbb1-08d7fe146da1
x-ms-traffictypediagnostic: BY5PR12MB3986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3986E9483E2028F5622A5B7CA2B40@BY5PR12MB3986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYZU1t0PnXkMgQl9bHiHCrUdKCTBG3oe1xajOsduS41niXN4sM1IzLhP0fpV49CmQo4X/cAgMWrYyFIzP1781cE18nIDqZ+1ShXNV9JzFkF601BiSGXS+ti5YAnNOEO/scKKCY0MtTMPTXRRIXkhqVxxKX4X6M7tuuTuuSPrZ2gygGGOXfso56eGoyiCjWKZ5ys+n7midOqEd3ErVs1LoXQqWj5Wk/NimrF57gi9YZba4IrK755PyydFJ1OnKxz+xGwpsAdqJ5OeWjbFY84qzEjSIkoLdzMNCwuDcZIMJGz8/RcWgIo6ng34ipIbYKinTykSpjXfG7hMhCrLpIQaKQKeXTrab2YF7YhCjQuA72xN4SXFVwHl1nF8nZoKG6N8aH0ZqIvp6XCvxnJSWTfjE1P4S17sYy1uoob+E70EpRg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(45080400002)(966005)(5660300002)(86362001)(55016002)(478600001)(66446008)(33656002)(316002)(7696005)(66946007)(186003)(64756008)(53546011)(66556008)(76116006)(110136005)(6506007)(9686003)(91956017)(66476007)(52536014)(4326008)(8676002)(2906002)(26005)(71200400001)(166002)(19627405001)(8936002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nVCggVt0BitG79mmsjixVtj1AUBkwa+Rs8u6XL/Y/d9zBc/UxENyfMUjqp8uFk+XhXBGbRSDESUkFP3uOHbxBIXutHHU4XZafM7Se51zeJ3Cu59e/yLsaQ5SrVnA9mlnu9QLE3bexfOOqNsUkWEdPwwwjKDDxWgHIIBWqRLEY8lvRyW8wCvrTojot4BcFiPmFrmk8gygXVJbvRfbNR2AMmfDvEfEDmmU3LRz40O6skxZXnVGv0TWDCpwaV4xIGLltcTFuw01coA6dQBYWkn7eUTAwPkKG8IQU3QLIIgfzhni2uIAe2toy/dQBNH/P2mN2SltljdxsTHZAZ+VhqlZ3Tu7KeuP50q/+B2/99yChQT4yVkEjGiyEfAjJuR/S9pXQ6+1xddiTwZezksrAgA80yPfjWrUv0KXGxttLT1Oi/eRnX4FLn4QwHbflmQNtB1u6riFDiTMHWLTGnB19s5ti57KamLq/m96zGmtAyfltoa70hnPOk3updOh8CpdH8XB
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2154330-f35c-4bbb-bbb1-08d7fe146da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:53:18.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwAODkoKQMmADzGMtGKTxI3Ibzm1d7DpOqCW7D3VdCEWLQlirOQjpm9uQ1kd1Zs0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3986
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1153434727=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1153434727==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB4068ABF0C467558D479D4D49A2B40BY5PR12MB4068namp_"

--_000_BY5PR12MB4068ABF0C467558D479D4D49A2B40BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

the flag of "ATTR_STATE_[UN]SUPPORTED" should be binding to device not devi=
ce attribute node,
when inserting two different video cards, the driver may be need to create =
different node according device type (vega, navi,...),
and when unload driver, the driver also need remove different node accordin=
g device type and the state of ATTR_STATE_SUPPORTED.
so i think the ATTR_STATE_XXX is not work well on multi gpu, so we'd better=
 revert previous patch.
thanks.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Quan, Ev=
an <Evan.Quan@amd.com>
Sent: Friday, May 22, 2020 1:35 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, May 22, 2020 5:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU

Reset the SUPPORTED attribute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

This fixes multi-GPU, but I think we could still race without some sort of =
locking around the attr array.

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index e06fef6174e5..4c65444e9ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1790,6 +1790,8 @@ static int amdgpu_device_attr_create(struct amdgpu_de=
vice *adev,

 BUG_ON(!attr);

+attr->states =3D ATTR_STATE_SUPPORTED;
+
 attr_update =3D attr->attr_update ? attr_update : default_attr_update;

 ret =3D attr_update(adev, attr, mask);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637257225315854026&amp;sdata=3DTMiKBdpSF4wPgkLgbRBtTloPL=
FBHyyLXuO%2BxSgSE%2BeY%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637257225315864023&amp;sdata=3DMtypjxOmgqJhKwNEMH75r3Z%2=
F9M3Uv7qTpOjQo1yBSVk%3D&amp;reserved=3D0

--_000_BY5PR12MB4068ABF0C467558D479D4D49A2B40BY5PR12MB4068namp_
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
<span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, 48); =
font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west european)&quot;=
, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, roboto, &quot;he=
lvetica neue&quot;, sans-serif; font-size: 11pt;">Hi Alex,</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<span style=3D"margin: 0px; font-size: 11pt; font-family: &quot;segoe ui&qu=
ot;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple=
-system, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif=
; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0)">the flag of
 &quot;ATTR_STATE_[UN]SUPPORTED&quot; should be binding to device not devic=
e attribute node,</span></div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; color: rgb(50, 4=
9, 48)">
<font face=3D"segoe ui, segoe ui web (west european), segoe ui, -apple-syst=
em, blinkmacsystemfont, roboto, helvetica neue, sans-serif"><span style=3D"=
margin: 0px; font-size: 14.6667px"></span></font></div>
<span style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe =
UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; color: rgb(50, =
49, 48)">when inserting two different video cards, the driver may be need
 to create different node according device type (vega, navi,...),</span>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; color: rgb(50, 4=
9, 48)">
<span style=3D"margin: 0px">and when unload driver, the driver also need re=
move different node according device type and the state of ATTR_STATE_SUPPO=
RTED.<br>
</span>
<div style=3D"margin: 0px"><font face=3D"segoe ui, segoe ui web (west europ=
ean), segoe ui, -apple-system, blinkmacsystemfont, roboto, helvetica neue, =
sans-serif"><span style=3D"margin: 0px; font-size: 14.6667px">so i think th=
e ATTR_STATE_XXX is not work well on multi
 gpu, so we'd better revert previous patch.</span></font></div>
<div style=3D"margin: 0px"><font face=3D"segoe ui, segoe ui web (west europ=
ean), segoe ui, -apple-system, blinkmacsystemfont, roboto, helvetica neue, =
sans-serif"><span style=3D"margin: 0px; font-size: 14.6667px">thanks.</span=
></font></div>
<div style=3D"margin: 0px">
<div style=3D"margin: 0px"><span style=3D"margin: 0px"></span>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
<span style=3D"margin: 0px; font-size: 11pt; font-family: &quot;segoe ui&qu=
ot;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple=
-system, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif=
; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0)">Best Regards,=
</span></div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
<span style=3D"margin: 0px; font-size: 11pt; font-family: &quot;segoe ui&qu=
ot;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple=
-system, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif=
; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0)">Kevin</span><=
/div>
</div>
</div>
</div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Friday, May 22, 2020 1:35 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix sysfs power controls with multi=
-GPU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Acked-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Friday, May 22, 2020 5:38 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU<br>
<br>
Reset the SUPPORTED attribute.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
<br>
This fixes multi-GPU, but I think we could still race without some sort of =
locking around the attr array.<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index e06fef6174e5..4c65444e9ef7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1790,6 &#43;1790,8 @@ static int amdgpu_device_attr_create(struct amdgp=
u_device *adev,<br>
<br>
&nbsp;BUG_ON(!attr);<br>
<br>
&#43;attr-&gt;states =3D ATTR_STATE_SUPPORTED;<br>
&#43;<br>
&nbsp;attr_update =3D attr-&gt;attr_update ? attr_update : default_attr_upd=
ate;<br>
<br>
&nbsp;ret =3D attr_update(adev, attr, mask);<br>
--<br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637257225315854026&amp;amp;sdata=3DTMiKBd=
pSF4wPgkLgbRBtTloPLFBHyyLXuO%2BxSgSE%2BeY%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%=
40amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637257225315854026&amp;amp;sdata=3DTMiKBdpSF4wPgkLgbRBtTloPL=
FBHyyLXuO%2BxSgSE%2BeY%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637257225315864023&amp;amp;sdata=3DMtypjx=
OmgqJhKwNEMH75r3Z%2F9M3Uv7qTpOjQo1yBSVk%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cd86afa6ac5ab49bd75d208d7fe11ed8d%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637257225315864023&amp;amp;sdata=3DMtypjxOmgqJhKwNEMH75r3Z%2F9=
M3Uv7qTpOjQo1yBSVk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB4068ABF0C467558D479D4D49A2B40BY5PR12MB4068namp_--

--===============1153434727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1153434727==--
