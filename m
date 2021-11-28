Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC62C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Nov 2021 13:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A3E6E9D3;
	Sun, 28 Nov 2021 13:11:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118F96E9D3
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Nov 2021 13:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiSV8p7Ky1qi9mVRIMgWtdEKc0EenlNXguC3YAczWCEeb9iEagZ8O1omnFMl3lrfMm3qxWsndSybG8bK1JLwM7iQAdumMfr5e2n8k/dW9GXS7BUgTc6CM+9xzo9HpIvq3V/pQnlxx0kAtfFirs4Ern5L5Zb1fdOLir/nyTM/VXbiqEUdPvDqH6gYW8LFtJ/3ccjwECzMzR3fQcvgnAXBTr/R/ptmRUZjk03HM3/R8oKB0NbWe4VVl9h6RXaQthUFg9daBNx7l8tKZgJdmpOD+ds+ziwq+18RGwvqQYg9O1slfC+M/lLk/49jPaEzaq5tIo5N55o0i8cDBdYdaukpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMjizQwpJKvDxG7bwneVJ0myvPmmQM/OPKVZ3YCZA8w=;
 b=A1hQCuD675Hwj1aDvOq71ucRcDEzXYYiAfGYZw3Q1w1VE7slrnm28JgXaDeLnkBaHY/6FVqu72OAkZANIV0vLszTDOtwPFK6VpDB267XN8dXv8h4nNRcbd/mEFWKBbeSi4+/sWBAI16OJDfVAwyrQkBnAbsM0gYwT2/u3p48Y5sv855VIBrMhyiDZxMoxY9V9Jq2Rrvj2kQ5Ij/P8C9B4GoxPOu3YuEDcqewb4tv8eqjaocEl+MHGtUaBOU5UVefGuqa+G04UEQJ8Ki+ukZyzlTX3KULzvuUh6wCquSufuYCA/Uq5DC0B78NmA+aY2tg78ZKqq6g3PYMqTP1W5TFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMjizQwpJKvDxG7bwneVJ0myvPmmQM/OPKVZ3YCZA8w=;
 b=WsMQM9fOt1Z8BNg3Di59LphMBBpJ21y7qcF+dMD+6nFLkOLneqp19BMfc9bfLPcmsQrQeJQpuhq6LPEo/V2ReUo2m2srC/yDzID9gnjcJOkUQlWoqX4RvxuNyNsWzjFYphS/g7rmjaec79EgrYkOqCvZjYTLREc4XnkWCxujeTQ=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 13:11:10 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 13:11:09 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: use advanced TDR mode by default
Thread-Topic: [PATCH] drm/amd/amdgpu: use advanced TDR mode by default
Thread-Index: AQHX4yngTlIr3R1YGE+KTN0jJDHkcqwY6vHL
Date: Sun, 28 Nov 2021 13:11:09 +0000
Message-ID: <CO6PR12MB5473807B7A2EC363DD56B70282659@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211127005756.41687-1-Bokun.Zhang@amd.com>
In-Reply-To: <20211127005756.41687-1-Bokun.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-28T13:11:10.364Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 39d5842f-45dc-39c8-514c-ca08fe4764dd
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ef90428-22c0-4c83-a9ce-08d9b2708baa
x-ms-traffictypediagnostic: CO6PR12MB5491:
x-microsoft-antispam-prvs: <CO6PR12MB5491864E3A63D66DEA80238182659@CO6PR12MB5491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Olr0i21mV3Z/54uzteFHbcbEPkWK3l/t8YPW88REbljoQW7gVmcE/+zzB6abFw9gCUDvAfjPEf9OkrBb6U45x/lS1hnW2seW7g7nyZka8y2FXrP05zS9C27vgGr7WRND4uLwxIvqddjRSSfQNJb+oIjMpX5vwMZRFUP/+FUXTBwxxOu2TOg7ZrNcy4kdtkBh8bAXdCusXoGsdwyfPRuiQ/IyfWsDsiBu2FpMhBvQAYTRwlK44Qb0dcK6sLHpkfQENvWEzH8e3503cUEjlgzrtvqwdrSl9nnwnvGLM5iTxrq8laQzWRLSxvAqIBJI3fzW59FzqRKfQn63O+Jn2Xxf1G8scr6DZe5PtNcP2ajkl4Qou3rnsmYsNLHElY9a5BbTHuSG/G9PvJkEC0Ix+/fYysz52/Qi0iF/vh/CqcFlU+mo3HMO7LqEuCEdeSPHPVqf/1AGt88ElbpiFlwbRkRMcbjpXeVL/O4XopOiNGfcBzE6OmvJJxFhSJdZdQ+Vfnbjw7opKH9C6h0AW1y7s7/WKow+PPe8nHgNYrw7KjrU13sM4SYXHsZed9qR3PtKeWFVXiZvz5WOw9oOyceaIgWNZafcU9lJZEhD04Veu00RltYxPN50Td/ZUBBlVWRwbRgX2S/av1DIfkY6bG6PcYtdaJrVpCuKw/GWxarCAzjykZ50FGnJi9uF84egCk68/Q4LwGZhJSVCrE8GhiNP1Y5WpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(76116006)(66556008)(9686003)(91956017)(55016003)(19627405001)(53546011)(186003)(66476007)(52536014)(38100700002)(33656002)(6506007)(8936002)(5660300002)(83380400001)(66446008)(64756008)(86362001)(7696005)(110136005)(8676002)(38070700005)(316002)(2906002)(122000001)(71200400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Dk3QFIMvZZczBYlGugBBP0ojxwIHQ8W/vteYPbU/to8vcpW+QOxzUY0d66?=
 =?iso-8859-1?Q?um+1SXzEk8lA0F2tTQFXmFeaYMMFi7rK8XkgP8Z63jkdA6zPgsx+kIY1yf?=
 =?iso-8859-1?Q?CGK7ZzkrRCeWdHccMVvkjfCFfVk7JkMSk5HM54uUwU7DlvWYMTzMdRsg4A?=
 =?iso-8859-1?Q?OdMqlend8rbfSAtL0Yv73O3ROg0J3GY6JnMKqlN1O+5hi2x3wjGSPDl2qu?=
 =?iso-8859-1?Q?yk7JeEOc0T3Q+j5ZVsDDRcgxM9+7csQftAbAjcwHIpqGKt2T8n+0EzhyQB?=
 =?iso-8859-1?Q?73bMojCrd/4O1yp2U9p2lROGGZ/9WRB3zu+aI2KAxaTJNtvsQnUoX/laX7?=
 =?iso-8859-1?Q?h9QHn5dI/rSR2DiJlL+irr6OJ3Y6bBcKrYkINHkxNe8q0GqJ6zgetwy1dS?=
 =?iso-8859-1?Q?CweoaC0+ncQwmOToDPfByo6Oo0GdQU87wj4VFingGfr7iMjPYls93wyT8L?=
 =?iso-8859-1?Q?o/GecOaUoNs7hCxlvHEt4NAKUWgW3Dq3mDm2dcZ6r8zAqacnkGyfyztbBV?=
 =?iso-8859-1?Q?V2aIv+vgdJ2AAHpooyuYZ2w0TGcVXi4kNi1y241mI3ukyZ25GRfjTHf2I3?=
 =?iso-8859-1?Q?1OOxBRwmKlXWG+5OyMlKg+PA9/CJJrfUiJN6sO3IIs9EbpVOUdudIhemLI?=
 =?iso-8859-1?Q?+X1NnhtlABF6lnSwYCuocsA5jSB6uKceHeErc2jY2oEaeqqf/Aq8SMSOk2?=
 =?iso-8859-1?Q?9FQux+fXVXfhjvdIDgTl2Eco7d2xvWxikKJF5E7+gQB6Y8Pwp0QDJxz58i?=
 =?iso-8859-1?Q?V3CEQqt3AUbI4ednqahZCxYWc/pXhfKEywsrDsRYJ89MTLITpdDkvh4vPo?=
 =?iso-8859-1?Q?eDTpG8pQUwkziOuOIsU4rMEolv0a+6H0hy/+tx0MycF37Sf00Ia0zqdopl?=
 =?iso-8859-1?Q?duWePosOUb5Dc7nUr+flRICW3gXFpaL+Ln/N0wCgZvI2mmMUjcpjXSMtYY?=
 =?iso-8859-1?Q?TkG4ASvZGJyLEDueOcL7EAaOdEFRXMnR4nryZbhfB07Z+kjEtsjvMr3LJn?=
 =?iso-8859-1?Q?mNvUbfCig30qH+fk+L3dnaxcrYNC+bmuu/OAoIXqTEGsqLoHO8JVIXeDFx?=
 =?iso-8859-1?Q?oe+gvb7KGgSCJAMjYACg4bKclpFDe5TtEpK12hlRvrXlZuhqxWppxZbTUE?=
 =?iso-8859-1?Q?VvrHQTcRWJIOoZjtjzF+iR98lYVIpXrogw/TP0IssVXde0DPM2V0vsj5NC?=
 =?iso-8859-1?Q?w6oVnI+mn7rvij0VPeptOTDPIZpJsaVZf+lfmquEgdjmZF9t0tgs37lODs?=
 =?iso-8859-1?Q?9L+02ZiO6oiecfOX3igj42bMvUs2FlHW26TLFehM/J0aXmkVNpU3xyT0d5?=
 =?iso-8859-1?Q?s9nE7XoRYy8Ar+vu4400uLJ6xwrSwenVIMfPhmQii0PhppQ0JguRg/otKi?=
 =?iso-8859-1?Q?xo+0UWEONFsnjeIWJwQacbX99T9yCcYifInU0fe5ft/vI/Sja+cSmhyrD8?=
 =?iso-8859-1?Q?/F/Na2ckR7W/buoSAX1NWtco7ZgMfIZEgzRIvLFXa+j1kHFZiC6wv7DV/l?=
 =?iso-8859-1?Q?q2wJXJtNs0czY5293e+xjU40zDKgKwqfcF3x3c31DM3HfE+QZEa9y+D5dn?=
 =?iso-8859-1?Q?3oKGyKnkMagZUlMNZgqXJuLI4L75ruikyF01unuJfwYfQxvVHzbgrcA5S2?=
 =?iso-8859-1?Q?OLtm+8OTJmYIXcudBRzOgrc0y/crQCJJeb2F6gC2Qijaw0WAoY3LBsLesE?=
 =?iso-8859-1?Q?f8pamhUdkivx4l6dpXI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473807B7A2EC363DD56B70282659CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef90428-22c0-4c83-a9ce-08d9b2708baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2021 13:11:09.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfmkYrjEg5ca8tOaoxbNd2jKW7IOS57LgPP+NbLBPvVHQKC0dnrCwPBkLrAGQx08
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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

--_000_CO6PR12MB5473807B7A2EC363DD56B70282659CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

although this module parameter can be modified during driver probe, but it =
also can be modified at runtime.
(via /sys/module/amdgpu/parameter/gpu_recovery).
This may result in a mismatch with the expected results.
You'd better to check SRIOV in the right place.

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bokun Zh=
ang <Bokun.Zhang@amd.com>
Sent: Saturday, November 27, 2021 8:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: use advanced TDR mode by default

From: Bokun Zhang <bokun.zhang@amd.com>

In the patch about advanced TDR mode, we force to always set
amdgpu_gpu_recovery=3D2 under SRIOV. This is not ideal, since we
may want to revert back to use the legacy TDR routine.

Therefore, we only set amdgpu_gpu_recovery=3D2 when it is
configured as AUTO, which is the default value (gpu_recovery=3D-1)

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Change-Id: Ifae78854b53f124d2ea53f401919ab5e403ef822
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 93af2cd2a065..62ec484a35aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -64,8 +64,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
         adev->cg_flags =3D 0;
         adev->pg_flags =3D 0;

-       /*use advance recovery mode for SRIOV*/
-       if (amdgpu_gpu_recovery)
+       /* use advance recovery mode for SRIOV by default */
+       if (amdgpu_gpu_recovery =3D=3D -1)
                 amdgpu_gpu_recovery =3D 2;
 }

--
2.25.1


--_000_CO6PR12MB5473807B7A2EC363DD56B70282659CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">although=
 this module parameter can be modified during driver probe, but it also can=
 be modified at runtime.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt; background-color: rgba(0, 0, 0, 0);">(via /sy=
s/module/amdgpu/parameter/gpu_recovery).</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt; background-color: rgba(0, 0, 0, 0);">This may=
 result in a mismatch with the expected results.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0); fon=
t-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">You'd be=
tter to check SRIOV in the right place.</span><br>
</div>
<span></span>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Bokun Zhang &lt;Bokun.Zhang@a=
md.com&gt;<br>
<b>Sent:</b> Saturday, November 27, 2021 8:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: use advanced TDR mode by default</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
<br>
In the patch about advanced TDR mode, we force to always set<br>
amdgpu_gpu_recovery=3D2 under SRIOV. This is not ideal, since we<br>
may want to revert back to use the legacy TDR routine.<br>
<br>
Therefore, we only set amdgpu_gpu_recovery=3D2 when it is<br>
configured as AUTO, which is the default value (gpu_recovery=3D-1)<br>
<br>
Signed-off-by: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
Change-Id: Ifae78854b53f124d2ea53f401919ab5e403ef822<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 93af2cd2a065..62ec484a35aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -64,8 +64,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D 0;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D 0;<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*use advance recovery mode for SRIOV=
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use advance recovery mode for SRIO=
V by default */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery =3D=3D -1)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gpu_recovery =3D 2;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473807B7A2EC363DD56B70282659CO6PR12MB5473namp_--
