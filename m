Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC609C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845F410E9ED;
	Tue, 25 Jan 2022 10:48:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2165110E9F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeiQfUqooRI0ApUGQHVsk13FW9idbpi0IdmSVFe28FAfZdXSJeVO0CIZCnFIoXIk8QDtenWnn1eS2u6IstjbRGASE1lK/XgyE8PamSuQ0oRJ03raV+NzkaGTa5TyhykaBXDCWRE4NJjaLNh3Yh5AHvDRYJ7y54q2PxIz5kYZekOZL0gTEdS4LglwWyqLBQVoM5y5dS8yo+nR063n1xStwlTFl98Dtwz6WZggFrO2n8Cf0/7wq5F8gBNNWLmbcymTsV6VIze1RWl4MabrAdDOsEOvUzycpuVfCRBO8e9UCgOTZS86CKP/dauHM3qIk+eNzKM7jlQD5rCX5Tnrn/CBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoertF8N6Bm5uDgcp5teQDbC9jzKhV+WG0f6tcMiUsw=;
 b=atSDOc0rFWlWVbZS5PAhhOybTvGCa01+zf6Li1iNlbgqIJUn7VfGLUp1HtgEH3kHT8edLiGaNzJbcENYZv4bgUz2y2uD0xK2Ny5+KXPBoVdrH3x+z2lDbL5AkxXcnvXik4e+7L4V0HcifwvcdIQ6om2Sn0pN0OopUOplY77mBCK8D+7rDdRxCk9G9/Gf3zhCS4L6a7hQ1O9boAsWXqWtWUYXSZsimEA8mtgCAPB9TKJ1pyD+T90LPCrtt/yNxMudw328UJ8xTNzw7PfLIHwIJ8pIZBakJOUn7zH9uNexviLza5qjA4b3eCtn8jSgQmXR76G0AOnQwblrqWl4EF8LCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoertF8N6Bm5uDgcp5teQDbC9jzKhV+WG0f6tcMiUsw=;
 b=RBvYspSM+ApUemZlTa4oboT7Wy/j0bt6U4PZu7bjzQE/YXs6FraIHflxM9+aFS8C5SRAOe6k36kFKRS1Ws1NQ8TqDGYJ6nwINmYHAMq8HiXbzpFRua8LmQNYt0jnJR/hZcxdvSuBCKYng3gwBNF62j2snfTLE54t6EmEKzOcM/s=
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 10:48:43 +0000
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::7c6e:c35a:a136:425e]) by SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::7c6e:c35a:a136:425e%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 10:48:43 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Topic: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Index: AQHYEdLe5EW/6tLrTEK1YwVvNwwtJKxzjc2b
Date: Tue, 25 Jan 2022 10:48:43 +0000
Message-ID: <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
References: <20220125100321.450194-1-tianci.yin@amd.com>
In-Reply-To: <20220125100321.450194-1-tianci.yin@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-25T10:48:45.835Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d2c7552-6dbb-4e76-1161-08d9dff0418f
x-ms-traffictypediagnostic: BL0PR12MB5011:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5011488705C2BBB2609BE5DC825F9@BL0PR12MB5011.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MSSdaUdUGM1Ai19PEzDRJ4NrkEo+v+uceoQXnivGvSuM27DMapkfE6LcRzPYvAR0zLgleby6A8lSXYzoMGVScfk6QgHhMXk8qcKBvIh+H6H7VtplL+eqGRLSCzhIYTDmB5yxETExhjJAfplvBP8L5kR78EUCJkr2owePYxy3THf4Y91LUnlofbcfUEdioMAGB8Fup7p1uVxveJjyiEE4lN53YvVSx3qAxjp7UbsFBJQA8DX3ABSO2BJ5bvW482DMfd8k+XjwaIigqdLp4I+R+9hXf1aD2Yu3KpmpKKsrNkrEDoZuqXCFWZgyWcv63afKQ01pEfm4Drd9kSJQQhMqMX0GGmXdfnaZfVhkIN08htg2ZwOM9I4A22xAUucpz+xYP0aU9eF3yWdjx4AMzgLferViixs7SNnkU54H2PNQylGbtG4Ek1e3VlnFX5Q8mYQJIWWvIhenTRYc8fPtQ3xorJFfXmZ34kAfk4ObTSglY9SmaSEcbK2NLtjXp7wHAVQWSW+F7x1IpZDCs1RlSsWZLL2YJOLYvrT/FJ5U/ZpImI9G9yS8KdJyBoXnGhjRvaMBpkQga53xXzV+6dkgh73Ii+0WFysyqSPS5Lxx0AQtPZMCtTa+McqGeChLDeEcjGlKB8viFi6xtToKj4tzwQtsxHT9RyTHLuwP5YMOv8usUTs3Sw9zZkXJqg4M5iJ8UZeU+98K6v+Mq/3QgPcJe1+NA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(52536014)(55016003)(54906003)(53546011)(6506007)(83380400001)(7696005)(86362001)(122000001)(38100700002)(66946007)(4326008)(110136005)(316002)(64756008)(66556008)(66446008)(66476007)(91956017)(76116006)(19627405001)(33656002)(15650500001)(8936002)(71200400001)(26005)(8676002)(9686003)(5660300002)(2906002)(508600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k4FlrIpOsiNgDn1vMmqZLLbkmNWbpiS7iFkmdLGs2NMcJLPUYnld9H9V/S?=
 =?iso-8859-1?Q?kyxDB18CmgwpsRo4Ci40LiAiljE5HG/2bMS0blTUL9u7gsl96TvpMlivPg?=
 =?iso-8859-1?Q?9SFu5jhBDlPm7AJDZel66Of8un7misjLgKCbzhAYsG3mfjRB/B4WRI/jBF?=
 =?iso-8859-1?Q?F4yoIxyMzXF3Oa9fhlLmfOzwPNJmRa7nGcviX+rPjbHqMJN0gnDYDOyf/R?=
 =?iso-8859-1?Q?6Ev9nBnbEzSxHYm1wwIyc+cKQil7/dV9/oLINtTqbgCZY3pPXNLerxvojT?=
 =?iso-8859-1?Q?BE3tD2/NuVBUQfSJ4XewJw1G/bYoMMZgfbpm16I5cwdiZjRLIfLH39iNau?=
 =?iso-8859-1?Q?gtRAdHcmSPtpcYdCPWJ5FwFob+tuW6BTVLOXD1krvLmahUD6aA2pbxJX8a?=
 =?iso-8859-1?Q?Neovhombwh0rfKhp6LAgUZN/F3vD/69azNHcWY6O6LK4PmPbzIlUz/q4bB?=
 =?iso-8859-1?Q?6CccHPHNXUkLwMeUjz496JzKrWnIFhQzdaHbybPZVWq3pl5grHAOCT4b//?=
 =?iso-8859-1?Q?kBtvLf3Ybaoo97yssU+c/IJXwyxHiZw+NsiRU4k+VFEHcu+K+x1pKdTJrp?=
 =?iso-8859-1?Q?1DNS1AlOoyge55ve/BYg1EBmRnHGJ75FIwmD82gCruqov2p5knfS+VP7P8?=
 =?iso-8859-1?Q?8JdpFJ96HqQWqpDXI5H0VMEhT/Qt/onegrlJwUh2lBZNshzha3JwZWYoAH?=
 =?iso-8859-1?Q?33eWLShB1/gDjVdhanR2ntRhArWU2B20d1khVQzrmsszGAzJBGsre4GS+M?=
 =?iso-8859-1?Q?7w9x+OkP+gNIHEYv9nVX5j6k/B/lUIu7TDNcNwwtGLS+8gStWafYxM8QKJ?=
 =?iso-8859-1?Q?Rb5bGE9vi8gS0+KlYBAYHWAIHcVRF2+hLg1bm7j4av5fqQ2aBZoE6Ef8Z6?=
 =?iso-8859-1?Q?xhh1CXHaAND8YvVwcBLBTO9vuqdzrQ3eaUPYh2EymJV+g9XmrzXrwrKfiA?=
 =?iso-8859-1?Q?zW84VWcll9h/vqfxfEE+mypikE/fg5AeqzqDX6Mbu1JaCbSKMNPrYYTnEw?=
 =?iso-8859-1?Q?kVRaK162r5mSGqGZxGIni52YTWVUrcMHR3fbrrHCizvggce6w/01WWUwAW?=
 =?iso-8859-1?Q?GjIcDHoNMje08DQ/m4vpjW4i7JyuVylAYAS9D/VCCSyV6bPMI8F/N+kr+8?=
 =?iso-8859-1?Q?zUl3DML6pO9SvYFWHXYiIVCWl8YYX5o6oARkgkyfGMXAMc+VVE0aPqPMfp?=
 =?iso-8859-1?Q?78g3udqUMVbX3/t4rttLLXDQ/hU4fcxoD32ECa0DnUqEz7o9AXxB9D4jy7?=
 =?iso-8859-1?Q?7G6dfxmwaif9RZV79T7oFVhj/OuE8olZHtgM7V5WuTDEmVjIDQ9vvEbADw?=
 =?iso-8859-1?Q?52qxUqGAm28DFedmivGopQrvbC5WeKAg8ozNEQ1ZbHE78ebli+P8SnZznq?=
 =?iso-8859-1?Q?8w1PaGFO6iQs41rb9Di5vCf4oFrGrZn6U1qXxsfDRY9imPM0nkRz2B6Gor?=
 =?iso-8859-1?Q?o6HlV7uPriwI9y1oXWSqSl0Q8YDTPI43ScxkJzKhdWE/GbnueRvYAYOnrj?=
 =?iso-8859-1?Q?JKdGDFBMdRIuGCAld6JDlF7GT0tHZq6fXuaXmbFTtXFuFeRWKNmNB3WiXX?=
 =?iso-8859-1?Q?2Pi0efWXhHfzFcC5ARYliU2v1ZK3QWdge5aqu1nobD1nlAI+hUiSvcp/MF?=
 =?iso-8859-1?Q?SIX5PFjD+KI44=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB54888020E0D600D546BAC634825F9SJ0PR12MB5488namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c7552-6dbb-4e76-1161-08d9dff0418f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 10:48:43.3270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrtdYiCPS/Zn1IFP1k8RFJGdk2dlOOmdKwx19EOwklwrBAx5ZPqlcZXpcAEcqVtA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ0PR12MB54888020E0D600D546BAC634825F9SJ0PR12MB5488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

the issue is introduced in following patch, so add following information is=
 better.
fixes: (e9669fb78262) drm/amdgpu: Add early fini callback

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tianci Y=
in <tianci.yin@amd.com>
Sent: Tuesday, January 25, 2022 6:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci (Rico) <Tia=
nci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix an error message in rmmod

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
In rmmod procedure, kfd sends cp a dequeue request, but the
request does not get response, then an error message "cp
queue pipe 4 queue 0 preemption failed" printed.

[how]
Performing kfd suspending after disabling gfxoff can fix it.

Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b75d67f644e5..77e9837ba342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
                 }
         }

-       amdgpu_amdkfd_suspend(adev, false);
-
         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

+       amdgpu_amdkfd_suspend(adev, false);
+
         /* Workaroud for ASICs need to disable SMC first */
         amdgpu_device_smu_fini_early(adev);

--
2.25.1


--_000_SJ0PR12MB54888020E0D600D546BAC634825F9SJ0PR12MB5488namp_
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
the issue is introduced in following patch, so add following information is=
 better.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-=
caps: inherit; font-weight: inherit;">fixes: (e9669fb78262) drm/amdgpu: Add=
 early fini callback</i><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-=
caps: inherit; font-weight: inherit;"><br>
</i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-varia=
nt-caps: inherit; font-weight: inherit;">Reviewed-by: Yang Wang &lt;kevinya=
ng.wang@amd.com&gt;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-=
caps: inherit; font-weight: inherit;"><br>
</i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tianci Yin &lt;tianci.yin@amd=
.com&gt;<br>
<b>Sent:</b> Tuesday, January 25, 2022 6:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Yin, Tianc=
i (Rico) &lt;Tianci.Yin@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&g=
t;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix an error message in rmmod</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.co=
m&gt;<br>
<br>
[why]<br>
In rmmod procedure, kfd sends cp a dequeue request, but the<br>
request does not get response, then an error message &quot;cp<br>
queue pipe 4 queue 0 preemption failed&quot; printed.<br>
<br>
[how]<br>
Performing kfd suspending after disabling gfxoff can fix it.<br>
<br>
Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b75d67f644e5..77e9837ba342 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, false);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state=
(adev, AMD_PG_STATE_UNGATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state=
(adev, AMD_CG_STATE_UNGATE);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, false);<b=
r>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASICs nee=
d to disable SMC first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fini_ear=
ly(adev);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB54888020E0D600D546BAC634825F9SJ0PR12MB5488namp_--
