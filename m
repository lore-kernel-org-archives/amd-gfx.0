Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B469C88E6A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 09:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B05510E14D;
	Mon, 14 Sep 2026 09:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0ue07CR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606BE10E14D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 09:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD7npgf1Z/M0znOlC76wTtBeQ+UIZddNa8IXP53LdbDTHO+k+UJvTE2abkv/U3v54xRV/bxM7SvhPj1Goaxy2rvIt9IrnMlsJnOLrnlAa0J9T1qlluzHIQX9OyOwoPf0/1PV3rF3XhfEDHtPAVP3aYqd0Fx+ZGAtVVTkSGCmvwNxFrsx1G3Q2Mn32anHopgVKhXcPPbhTjB+uRzxuUVOes+gT8aHN2FZkV+CAw7y45dqieJsAfoLORpJlaluPPpgFizAyRaDlVcMpsABQGHG4w7FQmh97i+fLaBmiMZf9WJd23a4BAXS+VK+tE23VyvKMp4eehYF5cxioXyi/coycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apdiox12YlztrwUX7TzemUbESckOpsvasAJMSV98MRw=;
 b=KUJrWE+Ac9q0tLhJ31dm7gOJKN0WA5uCOUcN7INDc4Pswz4B05hpHye3pJRzk0KC8emQ8SUOIxyouYTCfOh+yonC5/gDc4taM6dbmhTS5ICWR3LAVyC/7uBRf2SemPv5g3tT1eVH/lTK7ptZl5hf+nFcb6HqPdQUAINkFMaXuxlE1UC5lNjEaC+2K/wOBsM2J5Asy+eU0NRQWThroHbLXx2+mLsoLAmTdVEJF/Ra2TMo1QrP/lALuMS+RzG/NIQC9vj8l72ezjgFefGsl3Cu11GLo5olEhy2AbZnhUIXErxi/iDU5Rzc4N9OObJfUFdpm6+ojtPLCv0cs83kXXw+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apdiox12YlztrwUX7TzemUbESckOpsvasAJMSV98MRw=;
 b=R0ue07CRPVFA4OVEjLURAzLWyIDrUwql7+OlMxu7w2wCFp+G0fmhNByvlj7NdidsKHj0bWMWgFgT0c8zRP3ebzhCyrDH4mNiomPpNNMU4w0DZvtL80RMHs9byQwl/gZM0p/aivgD62KcyW+7nMBX7hsRho8p7x+poo5v/kn1dpI=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:18:23 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:18:23 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Soltani, Shahyan"
 <Shahyan.Soltani@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
Thread-Topic: [PATCH 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
Thread-Index: AQHdQgQ2AqR4vjJy6028GyYQTbpzRLbNyeyAgAAECHA=
Date: Mon, 14 Sep 2026 09:18:23 +0000
Message-ID: <BN9PR12MB52116AFBAF26FEFDE4E4BC6993BB2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-2-shahyan.soltani@amd.com>
 <0bf5a38d-d4f8-4691-9992-040b6dede31f@amd.com>
In-Reply-To: <0bf5a38d-d4f8-4691-9992-040b6dede31f@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ActionId=0628c3b9-9d9e-4c2c-9ae0-fda5fc366f32;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=0;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=true;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-14T09:11:15Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|CY5PR12MB6382:EE_
x-ms-office365-filtering-correlation-id: d9528a03-e1fd-4101-424b-08df12412027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: Dkx3Fae1bHxBcySCIPg3BaQxXKxqmQqGEXY9aLHDK4nBgCjQwPOTkPT1PaNMol8kn49/uuAW8xdc955JqgSd20umOqrOV7YuBwQrAjMQbkvicOnOzzIZZ9y1MEg7HNEIj95Pr6vmY0C6dbnkScfq1brbSoEOzl45u7vWcmanXY2RMn+WjhYIBgDKIcSFF7r5JIr6yCoKF1l6MnMByoNjXrsDQe64vf4T43GIAEoUI/CUelRV7nxmNOApuZb6h5kJzFwlYc5f8jTaw9E/BD3FjzZ4fzNqoiZVThUUX4pt/6XaihQdlFFfmETK77wollZRP0wPLgg+eM8AFnPKjcG8lumQ21cJCoaEWCJ7m7I2ukFmkwSBqhiVLYjtZ9ARtNte7idfaCmoRl6xTo413RoI8S/aSWir2F5QZYUw2DdiHJjdSylZkZv1cCmUpxNtsbkwgP4fGaR3Lf8mz0sxxgJQk5+QgBjsooj/2z90wl+7bLfWWVDCjedtgaUYMgmMzgFrZg/UwLYUc5DvK7XH83s8AvhnfFOLrntt1sxAS7XwkZ7ZjCgO239tqajOpJKDOyTqZkHj17nULI0ga8cJzibqHUkobZlaVH7zg1vMGsH4X+Hr1Medd89irotK6a4M09a664rg0buMZuitTw8cRZIWZPeCXF6Jaxz+xsqXrGUSK9DX4PY4Tfs30SJ0pM7nBdg9H1Mg30KhFn1sJLQLxdsohtOFxr03PBRkkj8l+oQQ3Cg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fL06gV5QiUdjx0d3W9abD4sCDDJr6CFl46fGXLDqkhEKL44ZcUNTKSDTLp?=
 =?iso-8859-1?Q?qVemozCi4MyxhCP5nvecchEUUNg6IzUdYK6PeLSvcGonGI5l3Tq7kNyxQn?=
 =?iso-8859-1?Q?pqk7qOh96ygNBfiXVtFlJRNR/BBZNWuW9BvB0VKF36SgvtjJxLui1dvLWv?=
 =?iso-8859-1?Q?eaEwAIXE4D7sqd1rJ/TOEMFuSncUz3x/VdW10ZGSGGNHSMf9WKktzA3uOI?=
 =?iso-8859-1?Q?JPGbT3qEkxOxOgVRiyAO8tIiiayasBDW+jYSoqkt3S0IMc18oiZAltVenM?=
 =?iso-8859-1?Q?cLwgqjL5s4xbqG/A6vHg7/V6w7ScspxNZIgLd8ZgRQuhIZQxLQfvowz6Lb?=
 =?iso-8859-1?Q?NmISh6tIjaaqKf0f9/5n0uFpf1ckK3nrGSH8il0HInfl9Xtd2H9u6Waqoq?=
 =?iso-8859-1?Q?SQD+qUj3FpmPX7pSWzWVeK3CHC/7+viu2D9OC7rR6CwpK/wqhRDIV4E9km?=
 =?iso-8859-1?Q?1anMObOrud6WVUUoPGEGJWGF7fNaAgrYEPrgf1i0BjrqDySIaTC2Kfu6vd?=
 =?iso-8859-1?Q?kjcx/yqbXUDrS97/vK1AF3rBsN9hcZ2+qR4r88mZMbBF8lsk+oqvDrZ70i?=
 =?iso-8859-1?Q?1uqX0V0Lnt/i7soQKgWU0K5AjqyKJOJ+gwaSl+36X8KtBy2LvR44vcshgR?=
 =?iso-8859-1?Q?ahL88L+sfxZHtJaWLR09fdSaKa5JYnFSevUJvT/im/HmdZaj9azi0DOtI9?=
 =?iso-8859-1?Q?V0bEutHjvP5xSpkntY1ZVKqQFmnBfh1SuigE0+vv4Hpm3F8XhbH2O9htmv?=
 =?iso-8859-1?Q?/kYjf2UG+MfvxbWbvBTWaSx/Gl3jLx17xzDeL65tHL1Z+GEDRdkDwTaZTi?=
 =?iso-8859-1?Q?tw9Cm/PZ651bbJKNgddqrU5jBXDN41SodeUKWPN6E4NDnEOvtD79aPcazC?=
 =?iso-8859-1?Q?6pFsrz4gWQDLvcT6skGFaqnBWT90WXxOMyRIqRF1B7+0QFmvc//vuZ/t4l?=
 =?iso-8859-1?Q?plhVp6b26NNW2yb435ceHj4UKGqzEmF/gC/mk+bfIOi05DbsTxrbrqCoI3?=
 =?iso-8859-1?Q?uS/ktqGbEKMXavzfQf7JntzoS/5I9SOP9mhyUldZn32H43fPV3Q/qzD+8d?=
 =?iso-8859-1?Q?q/69DHjmSeT++yoQC551Wle11CqaYtHTk7wEzZATMXLst7aExMUVQ5yYWs?=
 =?iso-8859-1?Q?bq4ylQY1fewRpW6h98Y8GI9abLnELqFPmD798Ing7TWtc6TZsabXOCRTEa?=
 =?iso-8859-1?Q?3fY7sNvGmM4QAB7tgO0b9zbH1ZbiauVC93OXXHuqL+7+JpaCKvqHXYCOT0?=
 =?iso-8859-1?Q?ld4PJDNnzIkwhiPpve8PO1TEwas1/pPhOwnJX/SOcq0outV/Ua5U7vRR1e?=
 =?iso-8859-1?Q?9Q+WqPncUmyu/BATh2AUUBCg36mmDXxIhB9DlwymzUikXTMpPV63ixx1tE?=
 =?iso-8859-1?Q?eN3dbmNdtfmgAxVrY8sqiC7m5plgpX8ZtjZM4UNFTPPd20QTBZ65uJLtR5?=
 =?iso-8859-1?Q?VwZ7F6qoSTWGsR5iM8lv+zxzO2e71jXB/8zmeraSNgUr99Dv/Vv4Ijwbvs?=
 =?iso-8859-1?Q?1yWVM8C4djOboEWtgnrb+NPg+gl/8IBnmaeiIv8ttXhg2WfRu9+Is+YesA?=
 =?iso-8859-1?Q?/8gXKGWyjb30DlTLMalKCmvCPsSgk+7BMCUT+o7H4L7wlx+bs2sVS4Bpqi?=
 =?iso-8859-1?Q?IDKA+0VvoFlDHAIcPWC5Tza34VoZtuKWRjN2iXqRRXYIq5I9/OUdA87qKC?=
 =?iso-8859-1?Q?vPLy9hIgs4KV8SY5GuW13GojGpzzgpucrq7wjSAiu1Zb2d5dD+g+NSejEn?=
 =?iso-8859-1?Q?AZ4fRZImELJzAqvKsk2JtlgEq/IHbZSdgPJD2lQv5vO5id?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9528a03-e1fd-4101-424b-08df12412027
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 09:18:23.1088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYY2aFqR+afuZirAiC6qywoeCk7NoR+Jue22OKcZ65HOS/YaZZ73vWCEIU5r+EpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christ=
ian
> K=F6nig
> Sent: Monday, September 14, 2026 16:57
> To: Soltani, Shahyan <Shahyan.Soltani@amd.com>; amd-gfx@lists.freedesktop=
.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-Prayer, Pierr=
e-
> Eric <Pierre-eric.Pelloux-prayer@amd.com>
> Subject: Re: [PATCH 1/8] drm/amdgpu: use pm_runtime_resume_and_get
> amdgpu_gem_create_ioctl
>=20
> On 9/11/26 17:42, Shahyan Soltani wrote:
> > From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >
> > This ioctl might trigger GPU work through ttm so make sure the GPU is
> > awake.
> >
> > Signed-off-by: Pierre-Eric Pelloux-Prayer
> > <pierre-eric.pelloux-prayer@amd.com>
> > [shahyan.soltani@amd.com: Applied the same logic to
> > !amdgpu_gem_are_domains_valid(args->in.domains)]
> > Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 43
> > ++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index 0d579517c03c..7b92e7b9fbb8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-fence-unwrap.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <drm/amdgpu_drm.h>
> >  #include <drm/drm_drv.h>
> > @@ -442,19 +443,31 @@ int amdgpu_gem_create_ioctl(struct drm_device *de=
v,
> void *data,
> >  	uint32_t handle, initial_domain;
> >  	int r;
> >
> > +	r =3D pm_runtime_resume_and_get(dev->dev);
> > +	if (r < 0)
> > +		return r;
>=20
> You might be able to replace this with a much simpler guard based approac=
h, e.g.
> something like this:
>=20
> guard(pm_runtime_active)(dev->dev);
>=20
> A guard automatically calls pm_runtime_put()/pm_runtime_put_autosuspend()=
 when
> it run out of scope (e.g. on the closing } or when return is used).

A guard would be a good fit here,
but guard(pm_runtime_active) does not propagate failures from pm_runtime_ge=
t_sync() and pairs it with pm_runtime_put(), rather than pm_runtime_put_aut=
osuspend().

Since this ioctl must not proceed if the device fails to resume,=20
I think we need either a conditional guard that propagates the resume error=
 and uses autosuspend on exit or retain the explicit pm_runtime_resume_and_=
get() / pm_runtime_put_autosuspend() handling.

Best Regards,
Kevin

>=20
> That saves you all the error handling which makes this patch so complicat=
ed.
>=20
> See the DEFINE_GUARD() lines in include/linux/pm_runtime.h as well.
>=20
> Regards,
> Christian.
>=20
> > +
> >  	/* reject invalid gem flags */
> > -	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
> > -		return -EINVAL;
> > +	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK) {
> > +		r =3D -EINVAL;
> > +		goto pm_out;
> > +	}
> >
> >  	/* reject invalid gem domains */
> > -	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> > -		return -EINVAL;
> > -	if (!amdgpu_gem_are_domains_valid(args->in.domains))
> > -		return -EINVAL;
> > +	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK) {
> > +		r =3D -EINVAL;
> > +		goto pm_out;
> > +	}
> > +
> > +	if (!amdgpu_gem_are_domains_valid(args->in.domains)) {
> > +		r =3D -EINVAL;
> > +		goto pm_out;
> > +	}
> >
> >  	if (!amdgpu_is_tmz(adev) && (flags &
> AMDGPU_GEM_CREATE_ENCRYPTED)) {
> >  		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is
> disabled\n");
> > -		return -EINVAL;
> > +		r =3D -EINVAL;
> > +		goto pm_out;
> >  	}
> >
> >  	/* always clear VRAM */
> > @@ -468,7 +481,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
> >  			 * passed to bo list
> >  			 */
> >  			DRM_ERROR("GDS bo cannot be per-vm-bo\n");
> > -			return -EINVAL;
> > +			r =3D -EINVAL;
> > +			goto pm_out;
> >  		}
> >  		flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> >  	}
> > @@ -476,7 +490,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
> >  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
> >  		r =3D amdgpu_bo_reserve(vm->root.bo, false);
> >  		if (r)
> > -			return r;
> > +			goto pm_out;
> >
> >  		resv =3D vm->root.bo->tbo.base.resv;
> >  	}
> > @@ -509,17 +523,22 @@ int amdgpu_gem_create_ioctl(struct drm_device *de=
v,
> void *data,
> >  		amdgpu_bo_unreserve(vm->root.bo);
> >  	}
> >  	if (r)
> > -		return r;
> > +		goto pm_out;
> >
> >  	r =3D drm_gem_handle_create(filp, gobj, &handle);
> >  	/* drop reference from allocate - handle holds it now */
> >  	drm_gem_object_put(gobj);
> >  	if (r)
> > -		return r;
> > +		goto pm_out;
> >
> > +	r =3D 0;
> >  	memset(args, 0, sizeof(*args));
> >  	args->out.handle =3D handle;
> > -	return 0;
> > +
> > +pm_out:
> > +	pm_runtime_put_autosuspend(dev->dev);
> > +
> > +	return r;
> >  }
> >
> >  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,

