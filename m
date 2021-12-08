Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17446C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 10:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3CC6EE3F;
	Wed,  8 Dec 2021 10:06:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27EA6E9BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 10:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qeb4keNHGP9yFVbEirNaBML2szv28E+fHIdQWQpr3tkKtwU026ak4HIC/oq0p/qGMZv17w8TRfqJcAOwi7pa52Hz29q52KJqyNcbf33w0LUpW3k60Ckn/RM8gFB63k5p4cbOEy8DMJwjabJ/H/AlJc3Z8NnZGKjdU0Eu8uBuXZFAQPQcssFCy70HBQNcUS6+i+1PCD/hvBlBzZqgBKApTExmapwgDpO7//vJAzdBwMl2GJcNAv1Nt8Pizf//ltwoGy681z9ibI+dkCmTvJU0E9I4rhTYJ7rcfAY1RpC1rAPlXaMmgylxNfLz1yOsT45fnz8r1uO9Riroga8oBMvSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqp/eewQgIJUD7uhPPy9HIgg3X6Il6LdzX3ZS78MdNs=;
 b=aYc7OKYeV3XhyCN1JUczYIwGs26XY1vXdiThGqc14uc+j/DlBWMh5XBw3Nin03TySWFnN8Qu3KPPv77EzIozm0RqbopkQ+nWnPppLt5KHrrPc8taF8822Iga8YHDZeUMweDCHZVr45X7bdPQ51DKUdusq1rmeEL+QcTkHnUk+Oz7GysbGMwOrAh+Pj3Xch8lEJ9caxj+Vm4Jpewy5FNwrP+E66Cc70fF1p4DEtNyP3wpCWggfUh5adVqxV9HXb/VkHxc6c0jp2fRWPjkHdm05tqNFS9WG/YXLtwYX7B/ZRu9SXYnLxCOsbtrv6XvvHpAjfvhFR1MYDUSB2cfUQs6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqp/eewQgIJUD7uhPPy9HIgg3X6Il6LdzX3ZS78MdNs=;
 b=cX48gWERUL9dxkLyVE+pKMl3fajRipxETW8Npt2q0y9uNH6opcayaCiFoUEWiGaaMa/1ImpAf9u07cDMFSQzfglgVBzPcyl4LjtFEGWD67as+ewotUcwx/SFyGRuu/j8ZfPtMIDh/6LO9ZUWOPeuY6rct4n9k7t1tsXfGfYLZuk=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 10:06:18 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4734.024; Wed, 8 Dec 2021
 10:06:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
Thread-Topic: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
Thread-Index: AQHX7BgU5HX9dZEduEK+rK85stTqHawoXQK3
Date: Wed, 8 Dec 2021 10:06:17 +0000
Message-ID: <CO6PR12MB547373A8EA694763B14A431A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211208092642.173385-1-lang.yu@amd.com>
In-Reply-To: <20211208092642.173385-1-lang.yu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T10:06:17.162Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 2ea8a8ee-b652-98c3-62c7-8e05a6307328
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cd14e6d-61fc-456d-ec3c-08d9ba32608d
x-ms-traffictypediagnostic: CO6PR12MB5474:EE_
x-microsoft-antispam-prvs: <CO6PR12MB547416185AF3D5046582DBB2826F9@CO6PR12MB5474.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdtfguIK+KnZizul99aZzo3lpIzb27EnxBa4D/bqEufW7ELSoPHwFg8vgr5Ni41g+iV9xJNpAFOmuVdL4lDyECwMLCAPXYL9GUv/PE3k4XiX6GUO8gwEsT0hRIPcLHAsFjva++oZXmsXDdjn27dOYHCSUl6kKO9She5qhNXchXygwB9tHd0KdjahIDsZU6lkKdBzz/fVoXk3UPQFyUtfQXJZeT4xf4mqqtNFIbuqqPRvZljRVyf09DR4Cvd+9A40hMTNjGuHzq+GdFw/hVAXeRrHHWzk3vpij+DiKnoAJiFEYztlQ9I3tiw6/H+9kUCfWOcjXzfZW2Bx4+I9zWXUW7ntM/e0g4pJbFCMQ+LCvzsJc0liNJgk7IcA+Q76KfaWTHLPpu9gznOM8kI+TKqyLID/BYvh0/SViEbQo5qIRNqlH43SMA2eTi/ThlcIrZCFSStXmCH8zWF3MIEMWWbiVDEfOVdHq2JKtceMndJV5/yaw+5Kszj9CQODwip8y+5DIpCFPZuI+VpZqVFJ+RHKmXBjHHPvjThW8zE3Rsnp7ypI7r4rpDozNVnPm1n6izK4tys5idine3qTUKjmT55r5c74nKuH6ariU3feS5/P55j4jReP6b24Y4dlZ76R35Tds3NP4NGnBSpB7SIZ3L3EoZTrnJQ0lcqwxibrHbuUnZ64G/MKgevViIJCF87kPyHdp1eKGunb11RCqkY4uK2vTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(4326008)(55016003)(122000001)(38100700002)(86362001)(33656002)(19627405001)(54906003)(110136005)(508600001)(5660300002)(186003)(8676002)(53546011)(91956017)(66556008)(66476007)(71200400001)(6506007)(76116006)(64756008)(316002)(66946007)(66446008)(9686003)(8936002)(2906002)(52536014)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+sofZtWs15AZRazPTnw8SS9iGkz26I8D1oZPXlR95y5IFga3ScQv1YbQk6?=
 =?iso-8859-1?Q?lrVf7aSUDtOQZwMQQrDNujiNItKbScSCbKEUOrSlikw/COCWp4OATWS6rP?=
 =?iso-8859-1?Q?V0oAOL8jDppwE+Cp8sHAdKhyDZjef4ftTQRXZE2gZtOBmfS/mVxAaA4Zw6?=
 =?iso-8859-1?Q?zYzbTpvaWEaheTmwPEaiuPyFEzZpMTShiNsWpsUPcLNS6ALkg8zpvp/4/b?=
 =?iso-8859-1?Q?E/s+uhKg68LPgeIFT9NrwKh6mqPIN5ZlswGjX/6ixFUieh8iOvcokUGR+D?=
 =?iso-8859-1?Q?Bc/RKHcS1vPRDsADjuge8ndUkNPEMWRVPl6fpN3zl72zhwPkKItK6GxnLW?=
 =?iso-8859-1?Q?3nG4zXMS4ai7xEpaFm/k2w/fdvH0kz+Ixx0anMHrUObWaB8LshrcOSJWbA?=
 =?iso-8859-1?Q?AXQE8HOD8ArE1K28EnF2Ef9VjVHqX/wrc5zLKWOuLmtyLc7gGRvAgXb7XX?=
 =?iso-8859-1?Q?CE1HrOoaVNwtvehu3QkCbF0Xw/wos3J1ah1dgSYXeJ/lsQzi6UVojg7SxM?=
 =?iso-8859-1?Q?qzHGKJUxUCM4biSdqCvEUU9QhYn5GmNao5BJCjOPsySdwmhp0z5ev8ru3W?=
 =?iso-8859-1?Q?6NUgRwr6fGzeMh6ItktwH7mQfpkKHkpD2oZcgDl0zorfYN6/IBFV7oPUwn?=
 =?iso-8859-1?Q?BXwBIv9f8Ndx4bcGxvk+SDwC5SkAMtFdhgwrZjxxakGXpwNkeaWs+Ny6hn?=
 =?iso-8859-1?Q?raE6KS3nmeESxghCtGp9cDfqGNY4WjL4OYHaGaRgakhsM7RGspWNGS7S7u?=
 =?iso-8859-1?Q?Yp3qCh8oqkv2ucqxdGtAqu3HnoaifQf0PhOh1yvWUlSKuKVDYSZB96ll+u?=
 =?iso-8859-1?Q?e0MZTatPMBjlCoIYV3p0NgCHdlOKkERxSWOZnKe+KlG+gPG52owyX1Y0sD?=
 =?iso-8859-1?Q?5XZqB/l5GW9DbnvOAeCX45GaYoO8GUloDl1cLDevalmJzZhiVTdT4rmeq3?=
 =?iso-8859-1?Q?U2tFzO4ARM9A24Ny90a2vq66qHAhjcd7sqT2iW4C7i8sdzj9ArxKgbv6Io?=
 =?iso-8859-1?Q?zKm+0lyYuW2RxXogbBOKJstkM+DlPJuGo3IZXn3ykkk9ARq6dgccy/Lv4T?=
 =?iso-8859-1?Q?DxCpU70JfSG1Ikdc7Ht+kfe8rwo1KCKCKk70LQMUlwIjhNB5czPLeWtqoN?=
 =?iso-8859-1?Q?QmGB5kXIYDkYd2E/bW1jy8gc3tY8kvVDvI+Z4ztUJXp/+GTu/8AcS++T1g?=
 =?iso-8859-1?Q?4/OatmX7jkE7DFwdbFHwdr4T0u2TxrZzxX2Q74EIsF9YbHN9/lgOTQVhUk?=
 =?iso-8859-1?Q?+KA6c1hDWNMlcuKSPhpVQuq3eXqosY8HzIY1h53oOx9Km9VGAozWGG6X2a?=
 =?iso-8859-1?Q?Qvr03p1d6mQGhorcSrS5MTUUMK2deE5pa58P0192tEDgJ06ZpzZKvu6sF6?=
 =?iso-8859-1?Q?bbHqWmkBWWFJw3Ap/9bIFx5qcqPGX7ZjttaB3LF5GYIqREmEjRPuBzjzh2?=
 =?iso-8859-1?Q?tR1uL2+xWvGDtzWNo1UKj6lw8XIa8SVNmiUT4S83hGLM5kmwPiec3x8pFi?=
 =?iso-8859-1?Q?hhwAI8bLOrfs6cWtZ8h+vdX78wVK0wVshB8y5MnOCmvWJq8QA7zjzPUykU?=
 =?iso-8859-1?Q?bDTN/iiI4gW9uU6li25Wdk0Lf5qCz9A1P6MJGeGhMkQxFEcZntn4ESzUrH?=
 =?iso-8859-1?Q?YmsFt0KFnw8+nlJ4e7N8PKFF4UIc1T2AsHNUQ4J0lcFbItO4NU8Ce23w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547373A8EA694763B14A431A826F9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd14e6d-61fc-456d-ec3c-08d9ba32608d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 10:06:17.7992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQ22LQTmn9xdv9O/Og+xZt+yOL14QUCwxZ+M1l6CxLSaLuLipB1wvH/8gVPBkegw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB547373A8EA694763B14A431A826F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Lang,

the function of smu_powergate_sdma() is only valid on renoir chip.
if you want to remove it, please also remove following callback pointer in =
struct pptable_funcs{}.
related macro definitions also need to be cleaned up.

int (*powergate_sdma)(struct smu_context *smu, bool gate);

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lang Yu =
<lang.yu@amd.com>
Sent: Wednesday, December 8, 2021 5:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU hw_init/fi=
ni()

Currently, we don't find some neccesities to power on/off
SDMA in SMU hw_init/fini(). It makes more sense in SDMA
hw_init/fini().

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 5839918cb574..2d718c30c8eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
         }

         if (smu->is_apu) {
-               smu_powergate_sdma(&adev->smu, false);
                 smu_dpm_set_vcn_enable(smu, true);
                 smu_dpm_set_jpeg_enable(smu, true);
                 smu_set_gfx_cgpg(&adev->smu, true);
@@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
         if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
                 return 0;

-       if (smu->is_apu) {
-               smu_powergate_sdma(&adev->smu, true);
-       }
-
         smu_dpm_set_vcn_enable(smu, false);
         smu_dpm_set_jpeg_enable(smu, false);

--
2.25.1


--_000_CO6PR12MB547373A8EA694763B14A431A826F9CO6PR12MB5473namp_
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
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">Hi Lang,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">the function of&nbsp;</span>=
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; background-=
color: rgba(0, 0, 0, 0); display: inline !important; color: rgb(0, 0, 0);">=
smu_powergate_sdma</span><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fon=
t-size: 12pt; background-color: rgba(0, 0, 0, 0); display: inline !importan=
t; color: rgb(0, 0, 0);">()
 is only valid on renoir chip.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">if you want to remove it, pl=
ease
 also remove following callback pointer in struct pptable_funcs{}.</span></=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (=
West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFo=
nt, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">related macro definitio=
ns
 also need to be cleaned up.</span><br>
</div>
<span></span>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<span style=3D"background-color: rgba(0, 0, 0, 0); display: inline !importa=
nt; font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quo=
t;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
int
 (*powergate_sdma)(struct smu_context *smu, bool gate);</span>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lang Yu &lt;lang.yu@amd.com&g=
t;<br>
<b>Sent:</b> Wednesday, December 8, 2021 5:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Yu, Lang &=
lt;Lang.Yu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Huang, Ray =
&lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU hw_=
init/fini()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Currently, we don't find some neccesities to power=
 on/off<br>
SDMA in SMU hw_init/fini(). It makes more sense in SDMA<br>
hw_init/fini().<br>
<br>
Signed-off-by: Lang Yu &lt;lang.yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 5839918cb574..2d718c30c8eb 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_powergate_sdma(&amp;adev-&gt;smu, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_dpm_set_vcn_enable(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_dpm_set_jpeg_enable(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;adev-&gt;smu, true);<br>
@@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)&=
amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_powergate_sdma(&amp;adev-&gt;smu, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm_set_vcn_enable(smu=
, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm_set_jpeg_enable(sm=
u, false);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547373A8EA694763B14A431A826F9CO6PR12MB5473namp_--
