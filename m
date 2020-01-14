Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B55C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C5C24679
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yizvNnLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C5C24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2086E3BB;
	Tue, 14 Jan 2020 13:45:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB24B6E3BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 13:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du07eG4AJgHuAZB5BGvaqHc6BvjpCEnqTv5cXe5uRzlMJF7Yw918Pz0yjXhjd1cUbGfQsXv4Wt1iTp0UhrCrhBFd5ep0YbGaC7vv2OXrWu1g6bQHUPiwMiwt8y6rZX1PUkiLEPKH0UiOxr+bM8ozE4ZcgWLpafqmjmLiNJhmKVkKIcHR4W5kEAXkuNNBBDmu8LA5TBEgm7fLHN/3Nx+T8fHnZw6cLbwehN69rp8bQgIbjHvzIpRzrE0iDX0NYgVSd4LuE1q47uEAkSjqqLTI+O7Winmv2qWPOOfj3Vo0HDt+sTmxrepmbS6uN79STiZv+hFQ0ma6U9b1CmNe0Vvr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlMGc8h/tJQGmPGU9y6Xajy7QQfhZ06wYk1GfCi9uQ0=;
 b=fgME1laIC3Qzq+aafeKn5hg32zwludL/vjF7zZihgmyRhepXJBREsXLT0bMG4Ppt0DOCxD3vyzj2X8cToKJjx8iVvwZW2WA+Fnl9cWa2pj9rMTEiZvPbl1qY8CxPLz4DcvzQVrIEfT8C3X6ZK9G/X8RXdhIC6LPN3cSa95zE5wnL2AQ01zf2chLgEQb/9tmEmc21neoyW1gWOdiUeVacsn3oODcMAHVvK25/8cTZTnG8WHH7utrJ32BL4PMBPOJ10XJhu6yt305ZahiuIMkBSTrYxMw1pbRxh5NEPZMbRR1vY1mZ68qRYZK30r1Z5hx3k8dZpyc1Bm98EQqioGSIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlMGc8h/tJQGmPGU9y6Xajy7QQfhZ06wYk1GfCi9uQ0=;
 b=yizvNnLNdl4IFC1k/gZycFjX2MfgJATqcQN4h4oXlH43nirPgbs2EJ6FJ72vPMFz8sxtoURuI7btxDk+oioeY3B214YBXoEA+oAAVN3J9DwuHM2Z2VDE18uq753OSbx+6qIZyGIA7wkp12Ta2gNjmmwRPyCXAeCDiZ18N/ywuWw=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB3701.namprd12.prod.outlook.com (52.132.244.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 13:45:37 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d%6]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 13:45:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm
Thread-Topic: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm
Thread-Index: AQHVyBAHzemX1J9v606B7YDHNrF+eafn9NmAgAEamwCAAFQBAIAAzhfT
Date: Tue, 14 Jan 2020 13:45:36 +0000
Message-ID: <CH2PR12MB3912F6D3B0E0DB3C0B2D827CF7340@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200110234509.4195-1-alexander.deucher@amd.com>
 <MN2PR12MB334455C7CB4ADB0C5365D341E4350@MN2PR12MB3344.namprd12.prod.outlook.com>
 <CADnq5_P9YOPVWKyfRVhH9c=yJJHaWuz-BaGpG62GTFOV59jBUg@mail.gmail.com>,
 <MN2PR12MB33446ABDBFC8D14D14E3B4B4E4340@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33446ABDBFC8D14D14E3B4B4E4340@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-14T13:45:36.057Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9360bb4-0e85-45b3-22bf-08d798f80939
x-ms-traffictypediagnostic: CH2PR12MB3701:|CH2PR12MB3701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3701DA7E4B59750C8CD06EBBF7340@CH2PR12MB3701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(45080400002)(5660300002)(19627405001)(30864003)(478600001)(86362001)(966005)(52536014)(4326008)(316002)(110136005)(26005)(9686003)(55016002)(33656002)(81156014)(7696005)(186003)(6506007)(2906002)(71200400001)(81166006)(53546011)(66556008)(8676002)(76116006)(66476007)(8936002)(66446008)(66946007)(64756008)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3701;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBtQWCgR8y4mAJD2bGOHi0MOvXYFYUYw2oYkIOA8jiYKZzKerGs0uHZviLr/Xe7+hnyaZWXaqctthNPWgMO8sxMhXN4HcHlhnC4ADK85fZ1qiEHB5b3IvCPakXnSyvRStedqQiN4CsMsSscK5qTQXHR1HF8LXAQEOK2mXaHd+JyJWO51r96u1UaZz8xkd2cYZmY6Rzm6FNCpJK/h92N3K4NTTNaSkso/3nfGI9ktG3GSWFcdM3kli55CPSVIo31n5NpMAcDftO0/k8A1OAA7n2KuKjkRwVuVXAxaA9u4ipoXnu+X7ndRO74OINQ0gw3I9jrr11orN4fg8z0m7hRSy3xD+RB/MB8Wkowo7Bee1/6yt3CyH8LlxjziRkyhTpT4fCNyNgiTT8vKkGkMBZjvjK66AAtK6KmGI/IlHYtko1sJyKxetwAPJ63vYMmACno5ZDwljiQYBHRhheJMrFR2yEolX3zFJ1kmIB6YNfONgJkb8j+S2R7goBLAYyFzI8YnnXS8B1xkof8s5eiqW3RGzQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9360bb4-0e85-45b3-22bf-08d798f80939
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 13:45:36.7786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UX6X/wX0QRzdehcDAYBkD7HKXRRco9PkGfx2M7B7K038uXOlOW+Ey6h01Xkyc4h1vZbBW2WsaAGKU8hz8psbdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3701
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1056290537=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1056290537==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912F6D3B0E0DB3C0B2D827CF7340CH2PR12MB3912namp_"

--_000_CH2PR12MB3912F6D3B0E0DB3C0B2D827CF7340CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ah, yeah, missed that.  It was wrong before as well.  I'll send a follow up=
 patch to fix that up.

Alex

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, January 13, 2020 8:27 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm

Yes, 'ssize_t' is fine. But 'count' comes with type of 'size_t'.
Although it should not bring any true problem. I'm not sure whether there w=
ill be compile warnings.

Regards,
Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, January 14, 2020 4:27 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm
>
> On Sun, Jan 12, 2020 at 10:35 PM Quan, Evan <Evan.Quan@amd.com> wrote:
> >
> > The "count" from amdgpu_set_pp_feature_status() seems with type of size=
_t.
> > Then assignment "count =3D -EINVAL" may be improper.
>
> It's fine. ssize_t is signed.  We've been doing it long before this patch=
.
>
> Alex
>
> > With that confirmed, the patch is reviewed-by: Evan Quan
> <evan.quan@amd.com>
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Al=
ex
> > > Deucher
> > > Sent: Saturday, January 11, 2020 7:45 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Subject: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm
> > >
> > > If power management sysfs or debugfs files are accessed, power up the
> GPU
> > > when necessary.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 822
> ++++++++++++++++++-----
> > > --
> > >  1 file changed, 614 insertions(+), 208 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > index 285d460624c8..806e731c1ff4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > @@ -37,6 +37,7 @@
> > >  #include <linux/hwmon.h>
> > >  #include <linux/hwmon-sysfs.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include "hwmgr.h"
> > >  #define WIDTH_4K 3840
> > >
> > > @@ -158,10 +159,15 @@ static ssize_t amdgpu_get_dpm_state(struct
> device
> > > *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       enum amd_pm_state_type pm;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               if (adev->smu.ppt_funcs->get_current_power_state)
> > >                       pm =3D smu_get_current_power_state(&adev->smu);
> > > @@ -173,6 +179,9 @@ static ssize_t amdgpu_get_dpm_state(struct device
> > > *dev,
> > >               pm =3D adev->pm.dpm.user_state;
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%s\n",
> > >                       (pm =3D=3D POWER_STATE_TYPE_BATTERY) ? "battery=
" :
> > >                       (pm =3D=3D POWER_STATE_TYPE_BALANCED) ?
> > > "balanced" : "performance"); @@ -186,6 +195,7 @@ static ssize_t
> > > amdgpu_set_dpm_state(struct device *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       enum amd_pm_state_type  state;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return -EINVAL;
> > > @@ -201,6 +211,10 @@ static ssize_t amdgpu_set_dpm_state(struct
> device
> > > *dev,
> > >               goto fail;
> > >       }
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               mutex_lock(&adev->pm.mutex);
> > >               adev->pm.dpm.user_state =3D state;
> > > @@ -212,11 +226,12 @@ static ssize_t amdgpu_set_dpm_state(struct
> device
> > > *dev,
> > >               adev->pm.dpm.user_state =3D state;
> > >               mutex_unlock(&adev->pm.mutex);
> > >
> > > -             /* Can't set dpm state when the card is off */
> > > -             if (!(adev->flags & AMD_IS_PX) ||
> > > -                 (ddev->switch_power_state =3D=3D DRM_SWITCH_POWER_O=
N))
> > > -                     amdgpu_pm_compute_clocks(adev);
> > > +             amdgpu_pm_compute_clocks(adev);
> > >       }
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +
> > >  fail:
> > >       return count;
> > >  }
> > > @@ -288,13 +303,14 @@ static ssize_t
> > > amdgpu_get_dpm_forced_performance_level(struct device *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       enum amd_dpm_forced_level level =3D 0xff;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > -     if ((adev->flags & AMD_IS_PX) &&
> > > -         (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return snprintf(buf, PAGE_SIZE, "off\n");
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (is_support_sw_smu(adev))
> > >               level =3D smu_get_performance_level(&adev->smu);
> > > @@ -303,6 +319,9 @@ static ssize_t
> > > amdgpu_get_dpm_forced_performance_level(struct device *dev,
> > >       else
> > >               level =3D adev->pm.dpm.forced_level;
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%s\n",
> > >                       (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "aut=
o" :
> > >                       (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? "low"=
 :
> > > @@ -329,11 +348,6 @@ static ssize_t
> > > amdgpu_set_dpm_forced_performance_level(struct device *dev,
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return -EINVAL;
> > >
> > > -     /* Can't force performance level when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > -
> > >       if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
> > >               level =3D AMD_DPM_FORCED_LEVEL_LOW;
> > >       } else if (strncmp("high", buf, strlen("high")) =3D=3D 0) { @@ =
-353,17
> > > +367,23 @@ static ssize_t
> amdgpu_set_dpm_forced_performance_level(struct
> > > device *dev,
> > >       } else if (strncmp("profile_peak", buf, strlen("profile_peak"))=
 =3D=3D 0) {
> > >               level =3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> > >       }  else {
> > > -             count =3D -EINVAL;
> > > -             goto fail;
> > > +             return -EINVAL;
> > >       }
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               current_level =3D smu_get_performance_level(&adev->smu)=
;
> > >       else if (adev->powerplay.pp_funcs->get_performance_level)
> > >               current_level =3D amdgpu_dpm_get_performance_level(adev=
);
> > >
> > > -     if (current_level =3D=3D level)
> > > +     if (current_level =3D=3D level) {
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > >               return count;
> > > +     }
> > >
> > >       /* profile_exit setting is valid only when current mode is in p=
rofile
> > > mode */
> > >       if (!(current_level & (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD
> > > | @@ -372,6 +392,8 @@ static ssize_t
> > > amdgpu_set_dpm_forced_performance_level(struct device *dev,
> > >           AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
> > >           (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
> > >               pr_err("Currently not in any profile mode!\n");
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > >               return -EINVAL;
> > >       }
> > >
> > > @@ -382,9 +404,10 @@ static ssize_t
> > > amdgpu_set_dpm_forced_performance_level(struct device *dev,
> > >       } else if (adev->powerplay.pp_funcs->force_performance_level) {
> > >               mutex_lock(&adev->pm.mutex);
> > >               if (adev->pm.dpm.thermal_active) {
> > > -                     count =3D -EINVAL;
> > >                       mutex_unlock(&adev->pm.mutex);
> > > -                     goto fail;
> > > +                     pm_runtime_mark_last_busy(ddev->dev);
> > > +                     pm_runtime_put_autosuspend(ddev->dev);
> > > +                     return -EINVAL;
> > >               }
> > >               ret =3D amdgpu_dpm_force_performance_level(adev, level)=
;
> > >               if (ret)
> > > @@ -393,8 +416,9 @@ static ssize_t
> > > amdgpu_set_dpm_forced_performance_level(struct device *dev,
> > >                       adev->pm.dpm.forced_level =3D level;
> > >               mutex_unlock(&adev->pm.mutex);
> > >       }
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > > -fail:
> > >       return count;
> > >  }
> > >
> > > @@ -407,6 +431,10 @@ static ssize_t amdgpu_get_pp_num_states(struct
> > > device *dev,
> > >       struct pp_states_info data;
> > >       int i, buf_len, ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               ret =3D smu_get_power_num_states(&adev->smu, &data);
> > >               if (ret)
> > > @@ -414,6 +442,9 @@ static ssize_t amdgpu_get_pp_num_states(struct
> > > device *dev,
> > >       } else if (adev->powerplay.pp_funcs->get_pp_num_states)
> > >               amdgpu_dpm_get_pp_num_states(adev, &data);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       buf_len =3D snprintf(buf, PAGE_SIZE, "states: %d\n", data.nums)=
;
> > >       for (i =3D 0; i < data.nums; i++)
> > >               buf_len +=3D snprintf(buf + buf_len, PAGE_SIZE, "%d %s\=
n", i,
> > > @@ -439,6 +470,10 @@ static ssize_t amdgpu_get_pp_cur_state(struct
> device
> > > *dev,
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               pm =3D smu_get_current_power_state(smu);
> > >               ret =3D smu_get_power_num_states(smu, &data); @@ -450,6
> > > +485,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
> > >               amdgpu_dpm_get_pp_num_states(adev, &data);
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       for (i =3D 0; i < data.nums; i++) {
> > >               if (pm =3D=3D data.states[i])
> > >                       break;
> > > @@ -500,14 +538,18 @@ static ssize_t amdgpu_set_pp_force_state(struct
> > > device *dev,
> > >               struct pp_states_info data;
> > >
> > >               ret =3D kstrtoul(buf, 0, &idx);
> > > -             if (ret || idx >=3D ARRAY_SIZE(data.states)) {
> > > -                     count =3D -EINVAL;
> > > -                     goto fail;
> > > -             }
> > > +             if (ret || idx >=3D ARRAY_SIZE(data.states))
> > > +                     return -EINVAL;
> > > +
> > >               idx =3D array_index_nospec(idx, ARRAY_SIZE(data.states)=
);
> > >
> > >               amdgpu_dpm_get_pp_num_states(adev, &data);
> > >               state =3D data.states[idx];
> > > +
> > > +             ret =3D pm_runtime_get_sync(ddev->dev);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > >               /* only set user selected power states */
> > >               if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &&
> > >                   state !=3D POWER_STATE_TYPE_DEFAULT) { @@ -515,8
> > > +557,10 @@ static ssize_t amdgpu_set_pp_force_state(struct device *de=
v,
> > >                                       AMD_PP_TASK_ENABLE_USER_STATE,
> > > &state);
> > >                       adev->pp_force_state_enabled =3D true;
> > >               }
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > >       }
> > > -fail:
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -538,20 +582,32 @@ static ssize_t amdgpu_get_pp_table(struct devic=
e
> > > *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       char *table =3D NULL;
> > > -     int size;
> > > +     int size, ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               size =3D smu_sys_get_pp_table(&adev->smu, (void **)&tab=
le);
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > >               if (size < 0)
> > >                       return size;
> > > -     }
> > > -     else if (adev->powerplay.pp_funcs->get_pp_table)
> > > +     } else if (adev->powerplay.pp_funcs->get_pp_table) {
> > >               size =3D amdgpu_dpm_get_pp_table(adev, &table);
> > > -     else
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > > +             if (size < 0)
> > > +                     return size;
> > > +     } else {
> > > +             pm_runtime_mark_last_busy(ddev->dev);
> > > +             pm_runtime_put_autosuspend(ddev->dev);
> > >               return 0;
> > > +     }
> > >
> > >       if (size >=3D PAGE_SIZE)
> > >               size =3D PAGE_SIZE - 1;
> > > @@ -573,13 +629,23 @@ static ssize_t amdgpu_set_pp_table(struct devic=
e
> > > *dev,
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return -EINVAL;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               ret =3D smu_sys_set_pp_table(&adev->smu, (void *)buf, c=
ount);
> > > -             if (ret)
> > > +             if (ret) {
> > > +                     pm_runtime_mark_last_busy(ddev->dev);
> > > +                     pm_runtime_put_autosuspend(ddev->dev);
> > >                       return ret;
> > > +             }
> > >       } else if (adev->powerplay.pp_funcs->set_pp_table)
> > >               amdgpu_dpm_set_pp_table(adev, buf, count);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -703,18 +769,28 @@ static ssize_t
> amdgpu_set_pp_od_clk_voltage(struct
> > > device *dev,
> > >                       tmp_str++;
> > >       }
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               ret =3D smu_od_edit_dpm_table(&adev->smu, type,
> > >                                           parameter, parameter_size);
> > >
> > > -             if (ret)
> > > +             if (ret) {
> > > +                     pm_runtime_mark_last_busy(ddev->dev);
> > > +                     pm_runtime_put_autosuspend(ddev->dev);
> > >                       return -EINVAL;
> > > +             }
> > >       } else {
> > >               if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
> > >                       ret =3D amdgpu_dpm_odn_edit_dpm_table(adev, typ=
e,
> > >                                               parameter, parameter_si=
ze);
> > > -                     if (ret)
> > > +                     if (ret) {
> > > +                             pm_runtime_mark_last_busy(ddev->dev);
> > > +                             pm_runtime_put_autosuspend(ddev->dev);
> > >                               return -EINVAL;
> > > +                     }
> > >               }
> > >
> > >               if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) { @@ -722,12
> > > +798,18 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device
> *dev,
> > >                               amdgpu_dpm_dispatch_task(adev,
> > >
> > >       AMD_PP_TASK_READJUST_POWER_STATE,
> > >                                               NULL);
> > > +                             pm_runtime_mark_last_busy(ddev->dev);
> > > +                             pm_runtime_put_autosuspend(ddev->dev);
> > >                               return count;
> > >                       } else {
> > > +                             pm_runtime_mark_last_busy(ddev->dev);
> > > +                             pm_runtime_put_autosuspend(ddev->dev);
> > >                               return -EINVAL;
> > >                       }
> > >               }
> > >       }
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       return count;
> > >  }
> > > @@ -738,27 +820,33 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > -     uint32_t size =3D 0;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               size =3D smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, =
buf);
> > >               size +=3D smu_print_clk_levels(&adev->smu, SMU_OD_MCLK,
> > > buf+size);
> > >               size +=3D smu_print_clk_levels(&adev->smu,
> > > SMU_OD_VDDC_CURVE, buf+size);
> > >               size +=3D smu_print_clk_levels(&adev->smu, SMU_OD_RANGE=
,
> > > buf+size);
> > > -             return size;
> > >       } else if (adev->powerplay.pp_funcs->print_clock_levels) {
> > >               size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, b=
uf);
> > >               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> > > buf+size);
> > >               size +=3D amdgpu_dpm_print_clock_levels(adev,
> > > OD_VDDC_CURVE, buf+size);
> > >               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANGE,
> > > buf+size);
> > > -             return size;
> > >       } else {
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > >       }
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > > +     return size;
> > >  }
> > >
> > >  /**
> > > @@ -796,15 +884,21 @@ static ssize_t
> amdgpu_set_pp_feature_status(struct
> > > device *dev,
> > >
> > >       pr_debug("featuremask =3D 0x%llx\n", featuremask);
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               ret =3D smu_sys_set_pp_feature_mask(&adev->smu,
> > > featuremask);
> > >               if (ret)
> > > -                     return -EINVAL;
> > > +                     count =3D -EINVAL;
> > >       } else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
> > >               ret =3D amdgpu_dpm_set_ppfeature_status(adev, featurema=
sk);
> > >               if (ret)
> > > -                     return -EINVAL;
> > > +                     count =3D -EINVAL;
> > >       }
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       return count;
> > >  }
> > > @@ -815,16 +909,27 @@ static ssize_t
> amdgpu_get_pp_feature_status(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > -             return smu_sys_get_pp_feature_mask(&adev->smu, buf);
> > > -     } else if (adev->powerplay.pp_funcs->get_ppfeature_status)
> > > -             return amdgpu_dpm_get_ppfeature_status(adev, buf);
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     if (is_support_sw_smu(adev))
> > > +             size =3D smu_sys_get_pp_feature_mask(&adev->smu, buf);
> > > +     else if (adev->powerplay.pp_funcs->get_ppfeature_status)
> > > +             size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
> > > +     else
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > > -     return snprintf(buf, PAGE_SIZE, "\n");
> > > +     return size;
> > >  }
> > >
> > >  /**
> > > @@ -863,16 +968,27 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_SCLK, buf);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_SCLK, buf=
);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_SCLK, buf=
);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_SCLK, b=
uf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  /*
> > > @@ -928,11 +1044,18 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct
> > > device *dev,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_SCLK, mask=
,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_SCLK, mas=
k);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       if (ret)
> > >               return -EINVAL;
> > >
> > > @@ -945,16 +1068,27 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_MCLK, buf);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_MCLK, buf=
);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_MCLK, buf=
);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_MCLK, b=
uf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev, @@ -964,8
> > > +1098,8 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev, =
 {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > -     int ret;
> > >       uint32_t mask =3D 0;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >                       return -EINVAL;
> > > @@ -974,11 +1108,18 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct
> > > device *dev,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_MCLK, mask=
,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_MCLK, mas=
k);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       if (ret)
> > >               return -EINVAL;
> > >
> > > @@ -991,16 +1132,27 @@ static ssize_t
> amdgpu_get_pp_dpm_socclk(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf=
);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_SOCCLK, b=
uf);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK, b=
uf);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK,=
 buf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev, @@ -
> 1020,10
> > > +1172,19 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *de=
v,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_SOCCLK, ma=
sk,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_SOCCLK, m=
ask);
> > > +     else
> > > +             ret =3D 0;
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       if (ret)
> > >               return -EINVAL;
> > > @@ -1037,16 +1198,27 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_FCLK, buf);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_FCLK, buf=
);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_FCLK, buf=
);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_FCLK, b=
uf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev, @@ -1066,1=
0
> > > +1238,19 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_FCLK, mask=
,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_FCLK, mas=
k);
> > > +     else
> > > +             ret =3D 0;
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       if (ret)
> > >               return -EINVAL;
> > > @@ -1083,16 +1264,27 @@ static ssize_t
> amdgpu_get_pp_dpm_dcefclk(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, bu=
f);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, =
buf);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK,
> > > buf);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK=
,
> > > buf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev, @@ -
> 1112,10
> > > +1304,19 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device
> *dev,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, m=
ask,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK,
> > > mask);
> > > +     else
> > > +             ret =3D 0;
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       if (ret)
> > >               return -EINVAL;
> > > @@ -1129,16 +1330,27 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct
> > > device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_print_clk_levels(&adev->smu, SMU_PCIE, buf);
> > > +             size =3D smu_print_clk_levels(&adev->smu, SMU_PCIE, buf=
);
> > >       else if (adev->powerplay.pp_funcs->print_clock_levels)
> > > -             return amdgpu_dpm_print_clock_levels(adev, PP_PCIE, buf=
);
> > > +             size =3D amdgpu_dpm_print_clock_levels(adev, PP_PCIE, b=
uf);
> > >       else
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev, @@ -1158,1=
0
> > > +1370,19 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_force_clk_levels(&adev->smu, SMU_PCIE, mask=
,
> > > true);
> > >       else if (adev->powerplay.pp_funcs->force_clock_level)
> > >               ret =3D amdgpu_dpm_force_clock_level(adev, PP_PCIE, mas=
k);
> > > +     else
> > > +             ret =3D 0;
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > >       if (ret)
> > >               return -EINVAL;
> > > @@ -1176,15 +1397,23 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
> > > device *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       uint32_t value =3D 0;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               value =3D smu_get_od_percentage(&(adev->smu),
> > > SMU_OD_SCLK);
> > >       else if (adev->powerplay.pp_funcs->get_sclk_od)
> > >               value =3D amdgpu_dpm_get_sclk_od(adev);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%d\n", value);  }
> > >
> > > @@ -1203,10 +1432,12 @@ static ssize_t amdgpu_set_pp_sclk_od(struct
> > > device *dev,
> > >
> > >       ret =3D kstrtol(buf, 0, &value);
> > >
> > > -     if (ret) {
> > > -             count =3D -EINVAL;
> > > -             goto fail;
> > > -     }
> > > +     if (ret)
> > > +             return -EINVAL;
> > > +
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               value =3D smu_set_od_percentage(&(adev->smu),
> > > SMU_OD_SCLK, (uint32_t)value); @@ -1222,7 +1453,9 @@ static ssize_t
> > > amdgpu_set_pp_sclk_od(struct device *dev,
> > >               }
> > >       }
> > >
> > > -fail:
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -1233,15 +1466,23 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
> > > device *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       uint32_t value =3D 0;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               value =3D smu_get_od_percentage(&(adev->smu),
> > > SMU_OD_MCLK);
> > >       else if (adev->powerplay.pp_funcs->get_mclk_od)
> > >               value =3D amdgpu_dpm_get_mclk_od(adev);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%d\n", value);  }
> > >
> > > @@ -1260,10 +1501,12 @@ static ssize_t amdgpu_set_pp_mclk_od(struct
> > > device *dev,
> > >
> > >       ret =3D kstrtol(buf, 0, &value);
> > >
> > > -     if (ret) {
> > > -             count =3D -EINVAL;
> > > -             goto fail;
> > > -     }
> > > +     if (ret)
> > > +             return -EINVAL;
> > > +
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               value =3D smu_set_od_percentage(&(adev->smu),
> > > SMU_OD_MCLK, (uint32_t)value); @@ -1279,7 +1522,9 @@ static ssize_t
> > > amdgpu_set_pp_mclk_od(struct device *dev,
> > >               }
> > >       }
> > >
> > > -fail:
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -1309,16 +1554,27 @@ static ssize_t
> > > amdgpu_get_pp_power_profile_mode(struct device *dev,  {
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +     ssize_t size;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > > -             return smu_get_power_profile_mode(&adev->smu, buf);
> > > +             size =3D smu_get_power_profile_mode(&adev->smu, buf);
> > >       else if (adev->powerplay.pp_funcs->get_power_profile_mode)
> > > -             return amdgpu_dpm_get_power_profile_mode(adev, buf);
> > > +             size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
> > > +     else
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > >
> > > -     return snprintf(buf, PAGE_SIZE, "\n");
> > > +     return size;
> > >  }
> > >
> > >
> > > @@ -1343,7 +1599,7 @@ static ssize_t
> > > amdgpu_set_pp_power_profile_mode(struct device *dev,
> > >       tmp[1] =3D '\0';
> > >       ret =3D kstrtol(tmp, 0, &profile_mode);
> > >       if (ret)
> > > -             goto fail;
> > > +             return -EINVAL;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return -EINVAL;
> > > @@ -1358,23 +1614,30 @@ static ssize_t
> > > amdgpu_set_pp_power_profile_mode(struct device *dev,
> > >               while (tmp_str[0]) {
> > >                       sub_str =3D strsep(&tmp_str, delimiter);
> > >                       ret =3D kstrtol(sub_str, 0, &parameter[paramete=
r_size]);
> > > -                     if (ret) {
> > > -                             count =3D -EINVAL;
> > > -                             goto fail;
> > > -                     }
> > > +                     if (ret)
> > > +                             return -EINVAL;
> > >                       parameter_size++;
> > >                       while (isspace(*tmp_str))
> > >                               tmp_str++;
> > >               }
> > >       }
> > >       parameter[parameter_size] =3D profile_mode;
> > > +
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               ret =3D smu_set_power_profile_mode(&adev->smu, paramete=
r,
> > > parameter_size, true);
> > >       else if (adev->powerplay.pp_funcs->set_power_profile_mode)
> > >               ret =3D amdgpu_dpm_set_power_profile_mode(adev, paramet=
er,
> > > parameter_size);
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       if (!ret)
> > >               return count;
> > > -fail:
> > > +
> > >       return -EINVAL;
> > >  }
> > >
> > > @@ -1397,10 +1660,17 @@ static ssize_t amdgpu_get_busy_percent(struct
> > > device *dev,
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     r =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > > +
> > >       /* read the IP busy sensor */
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_GPU_LOAD,
> > >                                  (void *)&value, &size);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -1426,10 +1696,17 @@ static ssize_t
> > > amdgpu_get_memory_busy_percent(struct device *dev,
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     r =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > > +
> > >       /* read the IP busy sensor */
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_MEM_LOAD,
> > >                                  (void *)&value, &size);
> > >
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -1455,11 +1732,20 @@ static ssize_t amdgpu_get_pcie_bw(struct
> device
> > > *dev,
> > >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D ddev->dev_private;
> > >       uint64_t count0, count1;
> > > +     int ret;
> > >
> > >       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> > >               return 0;
> > >
> > > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
> > > +
> > > +     pm_runtime_mark_last_busy(ddev->dev);
> > > +     pm_runtime_put_autosuspend(ddev->dev);
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%llu %llu %i\n",
> > >                       count0, count1, pcie_get_mps(adev->pdev));  } @=
@ -
> > > 1547,42 +1833,43 @@ static ssize_t amdgpu_hwmon_show_temp(struct
> device
> > > *dev,
> > >                                     char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       int channel =3D to_sensor_dev_attr(attr)->index;
> > >       int r, temp =3D 0, size =3D sizeof(temp);
> > >
> > > -     /* Can't get temperature when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > -
> > >       if (channel >=3D PP_TEMP_MAX)
> > >               return -EINVAL;
> > >
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > > +
> > >       switch (channel) {
> > >       case PP_TEMP_JUNCTION:
> > >               /* get current junction temperature */
> > >               r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> > >                                          (void *)&temp, &size);
> > > -             if (r)
> > > -                     return r;
> > >               break;
> > >       case PP_TEMP_EDGE:
> > >               /* get current edge temperature */
> > >               r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_EDGE_TEMP,
> > >                                          (void *)&temp, &size);
> > > -             if (r)
> > > -                     return r;
> > >               break;
> > >       case PP_TEMP_MEM:
> > >               /* get current memory temperature */
> > >               r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_MEM_TEMP,
> > >                                          (void *)&temp, &size);
> > > -             if (r)
> > > -                     return r;
> > > +             break;
> > > +     default:
> > > +             r =3D -EINVAL;
> > >               break;
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (r)
> > > +             return r;
> > > +
> > >       return snprintf(buf, PAGE_SIZE, "%d\n", temp);  }
> > >
> > > @@ -1678,16 +1965,27 @@ static ssize_t
> > > amdgpu_hwmon_get_pwm1_enable(struct device *dev,  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > >       u32 pwm_mode =3D 0;
> > > +     int ret;
> > > +
> > > +     ret =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
> > >       } else {
> > > -             if (!adev->powerplay.pp_funcs->get_fan_control_mode)
> > > +             if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> > > +                     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +                     pm_runtime_put_autosuspend(adev->ddev->dev);
> > >                       return -EINVAL;
> > > +             }
> > >
> > >               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       return sprintf(buf, "%i\n", pwm_mode);  }
> > >
> > > @@ -1697,27 +1995,32 @@ static ssize_t
> > > amdgpu_hwmon_set_pwm1_enable(struct device *dev,
> > >                                           size_t count)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     int err;
> > > +     int err, ret;
> > >       int value;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > -
> > >       err =3D kstrtoint(buf, 10, &value);
> > >       if (err)
> > >               return err;
> > >
> > > +     ret =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               smu_set_fan_control_mode(&adev->smu, value);
> > >       } else {
> > > -             if (!adev->powerplay.pp_funcs->set_fan_control_mode)
> > > +             if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> > > +                     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +                     pm_runtime_put_autosuspend(adev->ddev->dev);
> > >                       return -EINVAL;
> > > +             }
> > >
> > >               amdgpu_dpm_set_fan_control_mode(adev, value);
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -1744,34 +2047,43 @@ static ssize_t
> amdgpu_hwmon_set_pwm1(struct
> > > device *dev,
> > >       u32 value;
> > >       u32 pwm_mode;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
> > >       else
> > >               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> > > +
> > >       if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
> > >               pr_info("manual fan speed control should be enabled fir=
st\n");
> > > +             pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +             pm_runtime_put_autosuspend(adev->ddev->dev);
> > >               return -EINVAL;
> > >       }
> > >
> > >       err =3D kstrtou32(buf, 10, &value);
> > > -     if (err)
> > > +     if (err) {
> > > +             pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +             pm_runtime_put_autosuspend(adev->ddev->dev);
> > >               return err;
> > > +     }
> > >
> > >       value =3D (value * 100) / 255;
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_set_fan_speed_percent(&adev->smu, value);
> > > -             if (err)
> > > -                     return err;
> > > -     } else if (adev->powerplay.pp_funcs->set_fan_speed_percent) {
> > > +     else if (adev->powerplay.pp_funcs->set_fan_speed_percent)
> > >               err =3D amdgpu_dpm_set_fan_speed_percent(adev, value);
> > > -             if (err)
> > > -                     return err;
> > > -     }
> > > +     else
> > > +             err =3D -EINVAL;
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (err)
> > > +             return err;
> > >
> > >       return count;
> > >  }
> > > @@ -1784,20 +2096,22 @@ static ssize_t
> amdgpu_hwmon_get_pwm1(struct
> > > device *dev,
> > >       int err;
> > >       u32 speed =3D 0;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_get_fan_speed_percent(&adev->smu, &speed);
> > > -             if (err)
> > > -                     return err;
> > > -     } else if (adev->powerplay.pp_funcs->get_fan_speed_percent) {
> > > +     else if (adev->powerplay.pp_funcs->get_fan_speed_percent)
> > >               err =3D amdgpu_dpm_get_fan_speed_percent(adev, &speed);
> > > -             if (err)
> > > -                     return err;
> > > -     }
> > > +     else
> > > +             err =3D -EINVAL;
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (err)
> > > +             return err;
> > >
> > >       speed =3D (speed * 255) / 100;
> > >
> > > @@ -1812,20 +2126,22 @@ static ssize_t
> > > amdgpu_hwmon_get_fan1_input(struct device *dev,
> > >       int err;
> > >       u32 speed =3D 0;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_get_fan_speed_rpm(&adev->smu, &speed);
> > > -             if (err)
> > > -                     return err;
> > > -     } else if (adev->powerplay.pp_funcs->get_fan_speed_rpm) {
> > > +     else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> > >               err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
> > > -             if (err)
> > > -                     return err;
> > > -     }
> > > +     else
> > > +             err =3D -EINVAL;
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (err)
> > > +             return err;
> > >
> > >       return sprintf(buf, "%i\n", speed);
> > >  }
> > > @@ -1839,8 +2155,16 @@ static ssize_t
> amdgpu_hwmon_get_fan1_min(struct
> > > device *dev,
> > >       u32 size =3D sizeof(min_rpm);
> > >       int r;
> > >
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > > +
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_MIN_FAN_RPM,
> > >                                  (void *)&min_rpm, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -1856,8 +2180,16 @@ static ssize_t
> > > amdgpu_hwmon_get_fan1_max(struct device *dev,
> > >       u32 size =3D sizeof(max_rpm);
> > >       int r;
> > >
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > > +
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_MAX_FAN_RPM,
> > >                                  (void *)&max_rpm, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -1872,20 +2204,22 @@ static ssize_t
> > > amdgpu_hwmon_get_fan1_target(struct device *dev,
> > >       int err;
> > >       u32 rpm =3D 0;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_get_fan_speed_rpm(&adev->smu, &rpm);
> > > -             if (err)
> > > -                     return err;
> > > -     } else if (adev->powerplay.pp_funcs->get_fan_speed_rpm) {
> > > +     else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> > >               err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
> > > -             if (err)
> > > -                     return err;
> > > -     }
> > > +     else
> > > +             err =3D -EINVAL;
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (err)
> > > +             return err;
> > >
> > >       return sprintf(buf, "%i\n", rpm);
> > >  }
> > > @@ -1899,32 +2233,40 @@ static ssize_t
> > > amdgpu_hwmon_set_fan1_target(struct device *dev,
> > >       u32 value;
> > >       u32 pwm_mode;
> > >
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > >       if (is_support_sw_smu(adev))
> > >               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
> > >       else
> > >               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> > >
> > > -     if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL)
> > > +     if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
> > > +             pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +             pm_runtime_put_autosuspend(adev->ddev->dev);
> > >               return -ENODATA;
> > > -
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     }
> > >
> > >       err =3D kstrtou32(buf, 10, &value);
> > > -     if (err)
> > > +     if (err) {
> > > +             pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +             pm_runtime_put_autosuspend(adev->ddev->dev);
> > >               return err;
> > > +     }
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_set_fan_speed_rpm(&adev->smu, value);
> > > -             if (err)
> > > -                     return err;
> > > -     } else if (adev->powerplay.pp_funcs->set_fan_speed_rpm) {
> > > +     else if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
> > >               err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);
> > > -             if (err)
> > > -                     return err;
> > > -     }
> > > +     else
> > > +             err =3D -EINVAL;
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     if (err)
> > > +             return err;
> > >
> > >       return count;
> > >  }
> > > @@ -1935,15 +2277,27 @@ static ssize_t
> > > amdgpu_hwmon_get_fan1_enable(struct device *dev,  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > >       u32 pwm_mode =3D 0;
> > > +     int ret;
> > > +
> > > +     ret =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               pwm_mode =3D smu_get_fan_control_mode(&adev->smu);
> > >       } else {
> > > -             if (!adev->powerplay.pp_funcs->get_fan_control_mode)
> > > +             if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> > > +                     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +                     pm_runtime_put_autosuspend(adev->ddev->dev);
> > >                       return -EINVAL;
> > > +             }
> > >
> > >               pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> > >       }
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       return sprintf(buf, "%i\n", pwm_mode =3D=3D AMD_FAN_CTRL_AUTO ?=
 0 :
> > > 1);  }
> > >
> > > @@ -1957,12 +2311,6 @@ static ssize_t
> > > amdgpu_hwmon_set_fan1_enable(struct device *dev,
> > >       int value;
> > >       u32 pwm_mode;
> > >
> > > -     /* Can't adjust fan when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > -
> > > -
> > >       err =3D kstrtoint(buf, 10, &value);
> > >       if (err)
> > >               return err;
> > > @@ -1974,14 +2322,24 @@ static ssize_t
> > > amdgpu_hwmon_set_fan1_enable(struct device *dev,
> > >       else
> > >               return -EINVAL;
> > >
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > >       if (is_support_sw_smu(adev)) {
> > >               smu_set_fan_control_mode(&adev->smu, pwm_mode);
> > >       } else {
> > > -             if (!adev->powerplay.pp_funcs->set_fan_control_mode)
> > > +             if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> > > +                     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +                     pm_runtime_put_autosuspend(adev->ddev->dev);
> > >                       return -EINVAL;
> > > +             }
> > >               amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
> > >       }
> > >
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       return count;
> > >  }
> > >
> > > @@ -1990,18 +2348,20 @@ static ssize_t
> amdgpu_hwmon_show_vddgfx(struct
> > > device *dev,
> > >                                       char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       u32 vddgfx;
> > >       int r, size =3D sizeof(vddgfx);
> > >
> > > -     /* Can't get voltage when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       /* get the voltage */
> > >       r =3D amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX,
> > >                                  (void *)&vddgfx, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -2020,7 +2380,6 @@ static ssize_t
> amdgpu_hwmon_show_vddnb(struct
> > > device *dev,
> > >                                      char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       u32 vddnb;
> > >       int r, size =3D sizeof(vddnb);
> > >
> > > @@ -2028,14 +2387,17 @@ static ssize_t
> amdgpu_hwmon_show_vddnb(struct
> > > device *dev,
> > >       if  (!(adev->flags & AMD_IS_APU))
> > >               return -EINVAL;
> > >
> > > -     /* Can't get voltage when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       /* get the voltage */
> > >       r =3D amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB,
> > >                                  (void *)&vddnb, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -2054,19 +2416,21 @@ static ssize_t
> > > amdgpu_hwmon_show_power_avg(struct device *dev,
> > >                                          char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       u32 query =3D 0;
> > >       int r, size =3D sizeof(u32);
> > >       unsigned uw;
> > >
> > > -     /* Can't get power when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       /* get the voltage */
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_GPU_POWER,
> > >                                  (void *)&query, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -2089,16 +2453,27 @@ static ssize_t
> > > amdgpu_hwmon_show_power_cap_max(struct device *dev,  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > >       uint32_t limit =3D 0;
> > > +     ssize_t size;
> > > +     int r;
> > > +
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               smu_get_power_limit(&adev->smu, &limit, true, true);
> > > -             return snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000=
);
> > > +             size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 10000=
00);
> > >       } else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs=
-
> > > >get_power_limit) {
> > >               adev->powerplay.pp_funcs->get_power_limit(adev-
> > > >powerplay.pp_handle, &limit, true);
> > > -             return snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000=
);
> > > +             size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 10000=
00);
> > >       } else {
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > >       }
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >  static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev, @@ -
> > > 2107,16 +2482,27 @@ static ssize_t
> amdgpu_hwmon_show_power_cap(struct
> > > device *dev,  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > >       uint32_t limit =3D 0;
> > > +     ssize_t size;
> > > +     int r;
> > > +
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       if (is_support_sw_smu(adev)) {
> > >               smu_get_power_limit(&adev->smu, &limit, false,  true);
> > > -             return snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000=
);
> > > +             size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 10000=
00);
> > >       } else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs=
-
> > > >get_power_limit) {
> > >               adev->powerplay.pp_funcs->get_power_limit(adev-
> > > >powerplay.pp_handle, &limit, false);
> > > -             return snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000=
);
> > > +             size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 10000=
00);
> > >       } else {
> > > -             return snprintf(buf, PAGE_SIZE, "\n");
> > > +             size =3D snprintf(buf, PAGE_SIZE, "\n");
> > >       }
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > > +     return size;
> > >  }
> > >
> > >
> > > @@ -2138,13 +2524,20 @@ static ssize_t
> > > amdgpu_hwmon_set_power_cap(struct device *dev,
> > >
> > >       value =3D value / 1000000; /* convert to Watt */
> > >
> > > -     if (is_support_sw_smu(adev)) {
> > > +
> > > +     err =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     if (is_support_sw_smu(adev))
> > >               err =3D smu_set_power_limit(&adev->smu, value);
> > > -     } else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs=
-
> > > >set_power_limit) {
> > > +     else if (adev->powerplay.pp_funcs &&
> > > +adev->powerplay.pp_funcs->set_power_limit)
> > >               err =3D adev->powerplay.pp_funcs->set_power_limit(adev-
> > > >powerplay.pp_handle, value);
> > > -     } else {
> > > +     else
> > >               err =3D -EINVAL;
> > > -     }
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > >
> > >       if (err)
> > >               return err;
> > > @@ -2157,18 +2550,20 @@ static ssize_t
> amdgpu_hwmon_show_sclk(struct
> > > device *dev,
> > >                                     char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       uint32_t sclk;
> > >       int r, size =3D sizeof(sclk);
> > >
> > > -     /* Can't get voltage when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       /* get the sclk */
> > >       r =3D amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
> > >                                  (void *)&sclk, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -2187,18 +2582,20 @@ static ssize_t
> amdgpu_hwmon_show_mclk(struct
> > > device *dev,
> > >                                     char *buf)
> > >  {
> > >       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       uint32_t mclk;
> > >       int r, size =3D sizeof(mclk);
> > >
> > > -     /* Can't get voltage when the card is off */
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
> > > -             return -EINVAL;
> > > +     r =3D pm_runtime_get_sync(adev->ddev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       /* get the sclk */
> > >       r =3D amdgpu_dpm_read_sensor(adev,
> > > AMDGPU_PP_SENSOR_GFX_MCLK,
> > >                                  (void *)&mclk, &size);
> > > +
> > > +     pm_runtime_mark_last_busy(adev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(adev->ddev->dev);
> > > +
> > >       if (r)
> > >               return r;
> > >
> > > @@ -3220,8 +3617,12 @@ static int amdgpu_debugfs_pm_info(struct
> seq_file
> > > *m, void *data)
> > >       struct drm_info_node *node =3D (struct drm_info_node *) m->priv=
ate;
> > >       struct drm_device *dev =3D node->minor->dev;
> > >       struct amdgpu_device *adev =3D dev->dev_private;
> > > -     struct drm_device *ddev =3D adev->ddev;
> > >       u32 flags =3D 0;
> > > +     int r;
> > > +
> > > +     r =3D pm_runtime_get_sync(dev->dev);
> > > +     if (r < 0)
> > > +             return r;
> > >
> > >       amdgpu_device_ip_get_clockgating_state(adev, &flags);
> > >       seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags); @@ -32=
30,23
> > > +3631,28 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, voi=
d
> > > *data)
> > >
> > >       if (!adev->pm.dpm_enabled) {
> > >               seq_printf(m, "dpm not enabled\n");
> > > +             pm_runtime_mark_last_busy(dev->dev);
> > > +             pm_runtime_put_autosuspend(dev->dev);
> > >               return 0;
> > >       }
> > > -     if  ((adev->flags & AMD_IS_PX) &&
> > > -          (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON)) {
> > > -             seq_printf(m, "PX asic powered off\n");
> > > -     } else if (!is_support_sw_smu(adev) && adev->powerplay.pp_funcs=
-
> > > >debugfs_print_current_performance_level) {
> > > +
> > > +     if (!is_support_sw_smu(adev) &&
> > > +         adev->powerplay.pp_funcs-
> > > >debugfs_print_current_performance_level)
> > > +{
> > >               mutex_lock(&adev->pm.mutex);
> > >               if (adev->powerplay.pp_funcs-
> > > >debugfs_print_current_performance_level)
> > >                       adev->powerplay.pp_funcs-
> > > >debugfs_print_current_performance_level(adev, m);
> > >               else
> > >                       seq_printf(m, "Debugfs support not implemented =
for
> > > this asic\n");
> > >               mutex_unlock(&adev->pm.mutex);
> > > +             r =3D 0;
> > >       } else {
> > > -             return amdgpu_debugfs_pm_info_pp(m, adev);
> > > +             r =3D amdgpu_debugfs_pm_info_pp(m, adev);
> > >       }
> > >
> > > -     return 0;
> > > +     pm_runtime_mark_last_busy(dev->dev);
> > > +     pm_runtime_put_autosuspend(dev->dev);
> > > +
> > > +     return r;
> > >  }
> > >
> > >  static const struct drm_info_list amdgpu_pm_info_list[] =3D {
> > > --
> > > 2.24.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.free
> > > desktop.org%2Fmailman%2Flistinfo%2Famd-
> > >
> gfx&amp;data=3D02%7C01%7Cevan.quan%40amd.com%7C238a3b3424e54410d5
> > >
> 4b08d796272999%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> > >
> 142967374684544&amp;sdata=3DoFtEwMdJl2KVMiwz9y5GBcwwheE%2FKeg80C4
> > > LqfjZf08%3D&amp;reserved=3D0

--_000_CH2PR12MB3912F6D3B0E0DB3C0B2D827CF7340CH2PR12MB3912namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ah, yeah, missed that.&nbsp; It was wrong before as well.&nbsp; I'll send a=
 follow up patch to fix that up.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, January 13, 2020 8:27 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Yes, 'ssize_t' is fine. But 'count' comes with typ=
e of 'size_t'.<br>
Although it should not bring any true problem. I'm not sure whether there w=
ill be compile warnings.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
&gt; Sent: Tuesday, January 14, 2020 4:27 AM<br>
&gt; To: Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime pm<br>
&gt; <br>
&gt; On Sun, Jan 12, 2020 at 10:35 PM Quan, Evan &lt;Evan.Quan@amd.com&gt; =
wrote:<br>
&gt; &gt;<br>
&gt; &gt; The &quot;count&quot; from amdgpu_set_pp_feature_status() seems w=
ith type of size_t.<br>
&gt; &gt; Then assignment &quot;count =3D -EINVAL&quot; may be improper.<br=
>
&gt; <br>
&gt; It's fine. ssize_t is signed.&nbsp; We've been doing it long before th=
is patch.<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; &gt; With that confirmed, the patch is reviewed-by: Evan Quan<br>
&gt; &lt;evan.quan@amd.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; =
On Behalf Of Alex<br>
&gt; &gt; &gt; Deucher<br>
&gt; &gt; &gt; Sent: Saturday, January 11, 2020 7:45 AM<br>
&gt; &gt; &gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; &gt; &gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; &gt; &gt; Subject: [PATCH 1/2] drm/amdgpu/pm: properly handle runtime =
pm<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If power management sysfs or debugfs files are accessed, pow=
er up the<br>
&gt; GPU<br>
&gt; &gt; &gt; when necessary.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt=
;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 822<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;-----<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt;&nbsp; 1 file changed, 614 insertions(&#43;), 208 deletions(-=
)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; index 285d460624c8..806e731c1ff4 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; @@ -37,6 &#43;37,7 @@<br>
&gt; &gt; &gt;&nbsp; #include &lt;linux/hwmon.h&gt;<br>
&gt; &gt; &gt;&nbsp; #include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt; &gt; &gt;&nbsp; #include &lt;linux/nospec.h&gt;<br>
&gt; &gt; &gt; &#43;#include &lt;linux/pm_runtime.h&gt;<br>
&gt; &gt; &gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt; &gt; &gt;&nbsp; #define WIDTH_4K 3840<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -158,10 &#43;159,15 @@ static ssize_t amdgpu_get_dpm_stat=
e(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type p=
m;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;smu.ppt_funcs-&gt;get_current_power_st=
ate)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm =
=3D smu_get_current_power_state(&amp;adev-&gt;smu);<br>
&gt; &gt; &gt; @@ -173,6 &#43;179,9 @@ static ssize_t amdgpu_get_dpm_state(=
struct device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pm =3D adev-&gt;pm.dpm.user_state;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%s\n&quot;,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pm=
 =3D=3D POWER_STATE_TYPE_BATTERY) ? &quot;battery&quot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pm=
 =3D=3D POWER_STATE_TYPE_BALANCED) ?<br>
&gt; &gt; &gt; &quot;balanced&quot; : &quot;performance&quot;); @@ -186,6 &=
#43;195,7 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_dpm_state(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type&n=
bsp; state;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -201,6 &#43;211,10 @@ static ssize_t amdgpu_set_dpm_state=
(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.user_state =3D state;<br>
&gt; &gt; &gt; @@ -212,11 &#43;226,12 @@ static ssize_t amdgpu_set_dpm_stat=
e(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.user_state =3D state;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Can't set dpm state when the card is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_PX) ||<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ddev-&gt;switch_power_state =3D=3D D=
RM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pm_com=
pute_clocks(adev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp; fail:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -288,13 &#43;303,14 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_leve=
l level =3D 0xff;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AMD_IS_P=
X) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ddev-&gt;=
switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;off\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; level =3D smu_get_performance_level(&amp;adev-&gt;s=
mu);<br>
&gt; &gt; &gt; @@ -303,6 &#43;319,9 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; level =3D adev-&gt;pm.dpm.forced_level;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%s\n&quot;,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (le=
vel =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? &quot;auto&quot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (le=
vel =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? &quot;low&quot; :<br>
&gt; &gt; &gt; @@ -329,11 &#43;348,6 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't force performance level w=
hen the card is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strncmp(&quot;low&qu=
ot;, buf, strlen(&quot;low&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_LOW;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot=
;high&quot;, buf, strlen(&quot;high&quot;)) =3D=3D 0) { @@ -353,17<br>
&gt; &gt; &gt; &#43;367,23 @@ static ssize_t<br>
&gt; amdgpu_set_dpm_forced_performance_level(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot=
;profile_peak&quot;, buf, strlen(&quot;profile_peak&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp; else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; current_level =3D smu_get_performance_level(&amp;ad=
ev-&gt;smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;get_performance_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; current_level =3D amdgpu_dpm_get_performance_level(=
adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (current_level =3D=3D level)<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (current_level =3D=3D level=
) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* profile_exit setting =
is valid only when current mode is in profile<br>
&gt; &gt; &gt; mode */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(current_level &amp=
; (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD<br>
&gt; &gt; &gt; | @@ -372,6 &#43;392,8 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &amp;&amp;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Currently not in any profile mode!\n&q=
uot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -382,9 &#43;404,10 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs-&gt;force_performance_level) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.thermal_active) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EI=
NVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mut=
ex_unlock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
INVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_performance_level(adev, le=
vel);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; @@ -393,8 &#43;416,9 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_dpm_forced_performance_level(struct device *dev,<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;pm.dpm.forced_level =3D level;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -fail:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -407,6 &#43;431,10 @@ static ssize_t amdgpu_get_pp_num_st=
ates(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info da=
ta;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, buf_len, ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_power_num_states(&amp;adev-&gt;smu,=
 &amp;data);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; @@ -414,6 &#43;442,9 @@ static ssize_t amdgpu_get_pp_num_sta=
tes(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs-&gt;get_pp_num_states)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_len =3D snprintf(buf=
, PAGE_SIZE, &quot;states: %d\n&quot;, data.nums);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dat=
a.nums; i&#43;&#43;)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; buf_len &#43;=3D snprintf(buf &#43; buf_len, PAGE_S=
IZE, &quot;%d %s\n&quot;, i,<br>
&gt; &gt; &gt; @@ -439,6 &#43;470,10 @@ static ssize_t amdgpu_get_pp_cur_st=
ate(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pm =3D smu_get_current_power_state(smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_power_num_states(smu, &amp;data); @=
@ -450,6<br>
&gt; &gt; &gt; &#43;485,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct =
device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dat=
a.nums; i&#43;&#43;) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (pm =3D=3D data.states[i])<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bre=
ak;<br>
&gt; &gt; &gt; @@ -500,14 &#43;538,18 @@ static ssize_t amdgpu_set_pp_force=
_state(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info data;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtoul(buf, 0, &amp;idx);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (ret || idx &gt;=3D ARRAY_SIZE(data.states)) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EI=
NVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br=
>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret || idx &gt;=3D ARRAY_SIZE(data.states))<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
INVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; idx =3D array_index_nospec(idx, ARRAY_SIZE(data.sta=
tes));<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_get_pp_num_states(adev, &amp;data);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; state =3D data.states[idx];<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* only set user selected power states */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &amp;=
&amp;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state !=3D POWER_STATE_TYPE=
_DEFAULT) { @@ -515,8<br>
&gt; &gt; &gt; &#43;557,10 @@ static ssize_t amdgpu_set_pp_force_state(stru=
ct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; AMD_PP_TASK_ENABLE_USER_STATE,<br>
&gt; &gt; &gt; &amp;state);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;pp_force_state_enabled =3D true;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -fail:<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -538,20 &#43;582,32 @@ static ssize_t amdgpu_get_pp_table=
(struct device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *table =3D NULL;<br=
>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; int size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int size, ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D smu_sys_get_pp_table(&amp;adev-&gt;smu, (v=
oid **)&amp;table);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (size &lt; 0)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn size;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_fun=
cs-&gt;get_pp_table)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.=
pp_funcs-&gt;get_pp_table) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_pp_table(adev, &amp;table);=
<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (size &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return si=
ze;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt;=3D PAGE_SI=
ZE)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D PAGE_SIZE - 1;<br>
&gt; &gt; &gt; @@ -573,13 &#43;629,23 @@ static ssize_t amdgpu_set_pp_table=
(struct device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_sys_set_pp_table(&amp;adev-&gt;smu, (vo=
id *)buf, count);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn ret;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs-&gt;set_pp_table)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_pp_table(adev, buf, count);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -703,18 &#43;769,28 @@ static ssize_t<br>
&gt; amdgpu_set_pp_od_clk_voltage(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp=
_str&#43;&#43;;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_od_edit_dpm_table(&amp;adev-&gt;smu, ty=
pe,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter, parameter_size);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;odn_edit_dpm_ta=
ble) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
 =3D amdgpu_dpm_odn_edit_dpm_table(adev, type,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter=
, parameter_size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) =
{<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;d=
ev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;=
dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) { @@ -722,1=
2<br>
&gt; &gt; &gt; &#43;798,18 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(s=
truct device<br>
&gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev,=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PP_TASK_READJUST_POW=
ER_STATE,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;d=
ev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;=
dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;d=
ev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;=
dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -738,27 &#43;820,33 @@ static ssize_t<br>
&gt; amdgpu_get_pp_od_clk_voltage(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SM=
U_OD_SCLK, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D smu_print_clk_levels(&amp;adev-&gt;sm=
u, SMU_OD_MCLK,<br>
&gt; &gt; &gt; buf&#43;size);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D smu_print_clk_levels(&amp;adev-&gt;sm=
u,<br>
&gt; &gt; &gt; SMU_OD_VDDC_CURVE, buf&#43;size);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D smu_print_clk_levels(&amp;adev-&gt;sm=
u, SMU_OD_RANGE,<br>
&gt; &gt; &gt; buf&#43;size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs-&gt;print_clock_levels) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCL=
K, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D amdgpu_dpm_print_clock_levels(adev, O=
D_MCLK,<br>
&gt; &gt; &gt; buf&#43;size);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D amdgpu_dpm_print_clock_levels(adev,<b=
r>
&gt; &gt; &gt; OD_VDDC_CURVE, buf&#43;size);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D amdgpu_dpm_print_clock_levels(adev, O=
D_RANGE,<br>
&gt; &gt; &gt; buf&#43;size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; /**<br>
&gt; &gt; &gt; @@ -796,15 &#43;884,21 @@ static ssize_t<br>
&gt; amdgpu_set_pp_feature_status(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;featurema=
sk =3D 0x%llx\n&quot;, featuremask);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_sys_set_pp_feature_mask(&amp;adev-&gt;s=
mu,<br>
&gt; &gt; &gt; featuremask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVA=
L;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D=
 -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs-&gt;set_ppfeature_status) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_ppfeature_status(adev, featu=
remask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVA=
L;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D=
 -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -815,16 &#43;909,27 @@ static ssize_t<br>
&gt; amdgpu_get_pp_feature_status(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_sys_get_pp_feature_mask(&amp;adev-&gt;smu, buf);<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;get_ppfeature_status)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_get_ppfeature_status(adev, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_sys_get_pp_feature_mask(&amp;adev-&gt;smu, b=
uf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;get_ppfeature_status)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &q=
uot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; /**<br>
&gt; &gt; &gt; @@ -863,16 &#43;968,27 @@ static ssize_t amdgpu_get_pp_dpm_s=
clk(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_SCLK, buf)=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_SCLK=
, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_SCLK, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_SCLK, buf=
);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; /*<br>
&gt; &gt; &gt; @@ -928,11 &#43;1044,18 @@ static ssize_t amdgpu_set_pp_dpm_=
sclk(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_SCLK, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_SCLK,=
 mask);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -945,16 &#43;1068,27 @@ static ssize_t amdgpu_get_pp_dpm_=
mclk(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_MCLK, buf)=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_MCLK=
, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_MCLK, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_MCLK, buf=
);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_set_pp_dpm_mclk(struct device *d=
ev, @@ -964,8<br>
&gt; &gt; &gt; &#43;1098,8 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct =
device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; @@ -974,11 &#43;1108,18 @@ static ssize_t amdgpu_set_pp_dpm_=
mclk(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_MCLK, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_MCLK,=
 mask);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -991,16 &#43;1132,27 @@ static ssize_t<br>
&gt; amdgpu_get_pp_dpm_socclk(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_SOCCLK, bu=
f);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_SOCC=
LK, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK, buf);<b=
r>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK, b=
uf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_set_pp_dpm_socclk(struct device =
*dev, @@ -<br>
&gt; 1020,10<br>
&gt; &gt; &gt; &#43;1172,19 @@ static ssize_t amdgpu_set_pp_dpm_socclk(stru=
ct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_SOCCLK, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_SOCCL=
K, mask);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -1037,16 &#43;1198,27 @@ static ssize_t amdgpu_get_pp_dpm=
_fclk(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_FCLK, buf)=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_FCLK=
, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_FCLK, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_FCLK, buf=
);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_set_pp_dpm_fclk(struct device *d=
ev, @@ -1066,10<br>
&gt; &gt; &gt; &#43;1238,19 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct=
 device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_FCLK, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_FCLK,=
 mask);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -1083,16 &#43;1264,27 @@ static ssize_t<br>
&gt; amdgpu_get_pp_dpm_dcefclk(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_DCEFCLK, b=
uf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_DCEF=
CLK, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK,<br>
&gt; &gt; &gt; buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK,<=
br>
&gt; &gt; &gt; buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device=
 *dev, @@ -<br>
&gt; 1112,10<br>
&gt; &gt; &gt; &#43;1304,19 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(str=
uct device<br>
&gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_DCEFCLK, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_DCEFC=
LK,<br>
&gt; &gt; &gt; mask);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -1129,16 &#43;1330,27 @@ static ssize_t amdgpu_get_pp_dpm=
_pcie(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_print_clk_levels(&amp;adev-&gt;smu, SMU_PCIE, buf)=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_print_clk_levels(&amp;adev-&gt;smu, SMU_PCIE=
, buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP_PCIE, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, PP_PCIE, buf=
);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_set_pp_dpm_pcie(struct device *d=
ev, @@ -1158,10<br>
&gt; &gt; &gt; &#43;1370,19 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct=
 device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_clk_levels(&amp;adev-&gt;smu, SMU=
_PCIE, mask,<br>
&gt; &gt; &gt; true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_PCIE,=
 mask);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -1176,15 &#43;1397,23 @@ static ssize_t amdgpu_get_pp_scl=
k_od(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D smu_get_od_percentage(&amp;(adev-&gt;smu)=
,<br>
&gt; &gt; &gt; SMU_OD_SCLK);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;get_sclk_od)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D amdgpu_dpm_get_sclk_od(adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%d\n&quot;, value);&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1203,10 &#43;1432,12 @@ static ssize_t amdgpu_set_pp_scl=
k_od(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(buf, 0, =
&amp;value);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D smu_set_od_percentage(&amp;(adev-&gt;smu)=
,<br>
&gt; &gt; &gt; SMU_OD_SCLK, (uint32_t)value); @@ -1222,7 &#43;1453,9 @@ sta=
tic ssize_t<br>
&gt; &gt; &gt; amdgpu_set_pp_sclk_od(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -fail:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1233,15 &#43;1466,23 @@ static ssize_t amdgpu_get_pp_mcl=
k_od(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D smu_get_od_percentage(&amp;(adev-&gt;smu)=
,<br>
&gt; &gt; &gt; SMU_OD_MCLK);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;get_mclk_od)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D amdgpu_dpm_get_mclk_od(adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%d\n&quot;, value);&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1260,10 &#43;1501,12 @@ static ssize_t amdgpu_set_pp_mcl=
k_od(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(buf, 0, =
&amp;value);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value =3D smu_set_od_percentage(&amp;(adev-&gt;smu)=
,<br>
&gt; &gt; &gt; SMU_OD_MCLK, (uint32_t)value); @@ -1279,7 &#43;1522,9 @@ sta=
tic ssize_t<br>
&gt; &gt; &gt; amdgpu_set_pp_mclk_od(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -fail:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1309,16 &#43;1554,27 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_pp_power_profile_mode(struct device *dev,&nbsp; {=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return smu_get_power_profile_mode(&amp;adev-&gt;smu, buf);<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D smu_get_power_profile_mode(&amp;adev-&gt;smu, bu=
f);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;get_power_profile_mode)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_dpm_get_power_profile_mode(adev, buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &q=
uot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1343,7 &#43;1599,7 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_pp_power_profile_mode(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp[1] =3D '\0';<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(tmp, 0, =
&amp;profile_mode);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; @@ -1358,23 &#43;1614,30 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_set_pp_power_profile_mode(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; while (tmp_str[0]) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub=
_str =3D strsep(&amp;tmp_str, delimiter);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
 =3D kstrtol(sub_str, 0, &amp;parameter[parameter_size]);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br=
>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<=
br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; par=
ameter_size&#43;&#43;;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; whi=
le (isspace(*tmp_str))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_str&#43;&#43;;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter[parameter_size=
] =3D profile_mode;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_power_profile_mode(&amp;adev-&gt;sm=
u, parameter,<br>
&gt; &gt; &gt; parameter_size, true);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerp=
lay.pp_funcs-&gt;set_power_profile_mode)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_power_profile_mode(adev, par=
ameter,<br>
&gt; &gt; &gt; parameter_size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt; -fail:<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1397,10 &#43;1660,17 @@ static ssize_t amdgpu_get_busy_p=
ercent(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read the IP busy sens=
or */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_GPU_LOAD,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;value, &amp;size);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1426,10 &#43;1696,17 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_memory_busy_percent(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read the IP busy sens=
or */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_MEM_LOAD,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;value, &amp;size);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1455,11 &#43;1732,20 @@ static ssize_t amdgpu_get_pcie_b=
w(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t count0, count1;=
<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dd=
ev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_get_pcie_usa=
ge(adev, &amp;count0, &amp;count1);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dde=
v-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%llu %llu %i\n&quot;,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cou=
nt0, count1, pcie_get_mps(adev-&gt;pdev));&nbsp; } @@ -<br>
&gt; &gt; &gt; 1547,42 &#43;1833,43 @@ static ssize_t amdgpu_hwmon_show_tem=
p(struct<br>
&gt; device<br>
&gt; &gt; &gt; *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int channel =3D to_senso=
r_dev_attr(attr)-&gt;index;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, temp =3D 0, size =
=3D sizeof(temp);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get temperature when the =
card is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (channel &gt;=3D PP_T=
EMP_MAX)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (channel) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_TEMP_JUNCTION:<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* get current junction temperature */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_sensor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_HOTSPOT_TEMP,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;temp, &amp;size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_TEMP_EDGE:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* get current edge temperature */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_sensor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_EDGE_TEMP,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;temp, &amp;size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_TEMP_MEM:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* get current memory temperature */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_sensor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_MEM_TEMP,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;temp, &amp;size);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAG=
E_SIZE, &quot;%d\n&quot;, temp);&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1678,16 &#43;1965,27 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_get_pwm1_enable(struct device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pwm_mode =3D 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt=
;smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode)<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode=
) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quo=
t;%i\n&quot;, pwm_mode);&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1697,27 &#43;1995,32 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_set_pwm1_enable(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int err, ret;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int value;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtoint(buf, 1=
0, &amp;value);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; smu_set_fan_control_mode(&amp;adev-&gt;smu, value);=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode)<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode=
) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, value);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1744,34 &#43;2047,43 @@ static ssize_t<br>
&gt; amdgpu_hwmon_set_pwm1(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pwm_mode;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt=
;smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);=
<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pwm_mode !=3D AMD_FA=
N_CTRL_MANUAL) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;manual fan speed control should be en=
abled first\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 1=
0, &amp;value);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value * 100) =
/ 255;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_set_fan_speed_percent(&amp;adev-&gt;smu=
, value);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;set_fan_speed_percent) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;set_fan_speed_percent)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_percent(adev, valu=
e);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -1784,20 &#43;2096,22 @@ static ssize_t<br>
&gt; amdgpu_hwmon_get_pwm1(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 speed =3D 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_get_fan_speed_percent(&amp;adev-&gt;smu=
, &amp;speed);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;get_fan_speed_percent) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;get_fan_speed_percent)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_percent(adev, &amp=
;speed);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed =3D (speed * 255) =
/ 100;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1812,20 &#43;2126,22 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_get_fan1_input(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 speed =3D 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_get_fan_speed_rpm(&amp;adev-&gt;smu, &a=
mp;speed);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;get_fan_speed_rpm) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;get_fan_speed_rpm)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &amp;spe=
ed);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quo=
t;%i\n&quot;, speed);<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -1839,8 &#43;2155,16 @@ static ssize_t<br>
&gt; amdgpu_hwmon_get_fan1_min(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size =3D sizeof(min_=
rpm);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_MIN_FAN_RPM,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;min_rpm, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1856,8 &#43;2180,16 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_get_fan1_max(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size =3D sizeof(max_=
rpm);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_MAX_FAN_RPM,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;max_rpm, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1872,20 &#43;2204,22 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_get_fan1_target(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rpm =3D 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_get_fan_speed_rpm(&amp;adev-&gt;smu, &a=
mp;rpm);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;get_fan_speed_rpm) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;get_fan_speed_rpm)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &amp;rpm=
);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quo=
t;%i\n&quot;, rpm);<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -1899,32 &#43;2233,40 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_set_fan1_target(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pwm_mode;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt=
;smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pwm_mode !=3D AMD_FAN_CTRL_MAN=
UAL)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (pwm_mode !=3D AMD_FAN_CTRL=
_MANUAL) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -ENODATA;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 1=
0, &amp;value);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_set_fan_speed_rpm(&amp;adev-&gt;smu, va=
lue);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs-&gt;set_fan_speed_rpm) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs-&gt;set_fan_speed_rpm)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);<=
br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; @@ -1935,15 &#43;2277,27 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_get_fan1_enable(struct device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pwm_mode =3D 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D smu_get_fan_control_mode(&amp;adev-&gt=
;smu);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode)<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;get_fan_control_mode=
) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quo=
t;%i\n&quot;, pwm_mode =3D=3D AMD_FAN_CTRL_AUTO ? 0 :<br>
&gt; &gt; &gt; 1);&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1957,12 &#43;2311,6 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_set_fan1_enable(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int value;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pwm_mode;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card =
is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtoint(buf, 1=
0, &amp;value);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; @@ -1974,14 &#43;2322,24 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_set_fan1_enable(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; smu_set_fan_control_mode(&amp;adev-&gt;smu, pwm_mod=
e);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode)<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-&gt;set_fan_control_mode=
) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_mark_last_busy(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtim=
e_put_autosuspend(adev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1990,18 &#43;2348,20 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_vddgfx(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 vddgfx;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(v=
ddgfx);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the card=
 is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the voltage */<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev, AMDGPU_PP_SENSOR_VDDGFX,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;vddgfx, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2020,7 &#43;2380,6 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_vddnb(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 vddnb;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(v=
ddnb);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2028,14 &#43;2387,17 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_vddnb(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; (!(adev-&gt;fla=
gs &amp; AMD_IS_APU))<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the card=
 is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the voltage */<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev, AMDGPU_PP_SENSOR_VDDNB,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;vddnb, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2054,19 &#43;2416,21 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_show_power_avg(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 query =3D 0;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(u=
32);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned uw;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get power when the card i=
s off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the voltage */<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_GPU_POWER,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;query, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2089,16 &#43;2453,27 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_show_power_cap_max(struct device *dev,&nbsp; {<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, =
true, true);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 100=
0000);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit=
 * 1000000);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs &amp;&amp; adev-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;get_power_limit) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(ade=
v-<br>
&gt; &gt; &gt; &gt;powerplay.pp_handle, &amp;limit, true);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 100=
0000);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit=
 * 1000000);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_hwmon_show_power_cap(struct devi=
ce *dev, @@ -<br>
&gt; &gt; &gt; 2107,16 &#43;2482,27 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_power_cap(struct<br>
&gt; &gt; &gt; device *dev,&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(ad=
ev)) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, =
false,&nbsp; true);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 100=
0000);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit=
 * 1000000);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powe=
rplay.pp_funcs &amp;&amp; adev-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;get_power_limit) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(ade=
v-<br>
&gt; &gt; &gt; &gt;powerplay.pp_handle, &amp;limit, false);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 100=
0000);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit=
 * 1000000);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2138,13 &#43;2524,20 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_hwmon_set_power_cap(struct device *dev,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D value / 100000=
0; /* convert to Watt */<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; err =3D pm_runtime_get_sync(ad=
ev-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D smu_set_power_limit(&amp;adev-&gt;smu, valu=
e);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_f=
uncs &amp;&amp; adev-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;set_power_limit) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp=
_funcs &amp;&amp;<br>
&gt; &gt; &gt; &#43;adev-&gt;powerplay.pp_funcs-&gt;set_power_limit)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D adev-&gt;powerplay.pp_funcs-&gt;set_power_l=
imit(adev-<br>
&gt; &gt; &gt; &gt;powerplay.pp_handle, value);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &gt; &gt; @@ -2157,18 &#43;2550,20 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_sclk(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(s=
clk);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the card=
 is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the sclk */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;sclk, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2187,18 &#43;2582,20 @@ static ssize_t<br>
&gt; amdgpu_hwmon_show_mclk(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; char *buf)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(m=
clk);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the card=
 is off */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the sclk */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_se=
nsor(adev,<br>
&gt; &gt; &gt; AMDGPU_PP_SENSOR_GFX_MCLK,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp=
;mclk, &amp;size);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev=
-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ade=
v-&gt;ddev-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -3220,8 &#43;3617,12 @@ static int amdgpu_debugfs_pm_info=
(struct<br>
&gt; seq_file<br>
&gt; &gt; &gt; *m, void *data)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_info_node *no=
de =3D (struct drm_info_node *) m-&gt;private;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =
=3D node-&gt;minor-&gt;dev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D dev-&gt;dev_private;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&=
gt;ddev;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 flags =3D 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(dev-=
&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_get_clo=
ckgating_state(adev, &amp;flags);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;Cloc=
k Gating Flags Mask: 0x%x\n&quot;, flags); @@ -3230,23<br>
&gt; &gt; &gt; &#43;3631,28 @@ static int amdgpu_debugfs_pm_info(struct seq=
_file *m, void<br>
&gt; &gt; &gt; *data)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_ena=
bled) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;dpm not enabled\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dev-&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;dev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; AM=
D_IS_PX) &amp;&amp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dde=
v-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON)) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; seq_printf(m, &quot;PX asic powered off\n&quot;);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (!is_support_sw_smu(adev=
) &amp;&amp; adev-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;debugfs_print_current_performance_level) {<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_support_sw_smu(adev) &=
amp;&amp;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;debugfs_print_current_performance_level)<br>
&gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;debugfs_print_current_performance_level)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;powerplay.pp_funcs-<br>
&gt; &gt; &gt; &gt;debugfs_print_current_performance_level(adev, m);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq=
_printf(m, &quot;Debugfs support not implemented for<br>
&gt; &gt; &gt; this asic\n&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D 0;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return amdgpu_debugfs_pm_info_pp(m, adev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D amdgpu_debugfs_pm_info_pp(m, adev);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dev-=
&gt;dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev=
-&gt;dev);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static const struct drm_info_list amdgpu_pm_info_list[=
] =3D {<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.24.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; amd-gfx@lists.freedesktop.org<br>
&gt; &gt; &gt;<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.free">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
ree</a><br>
&gt; &gt; &gt; desktop.org%2Fmailman%2Flistinfo%2Famd-<br>
&gt; &gt; &gt;<br>
&gt; gfx&amp;amp;data=3D02%7C01%7Cevan.quan%40amd.com%7C238a3b3424e54410d5<=
br>
&gt; &gt; &gt;<br>
&gt; 4b08d796272999%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637<br>
&gt; &gt; &gt;<br>
&gt; 142967374684544&amp;amp;sdata=3DoFtEwMdJl2KVMiwz9y5GBcwwheE%2FKeg80C4<=
br>
&gt; &gt; &gt; LqfjZf08%3D&amp;amp;reserved=3D0<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH2PR12MB3912F6D3B0E0DB3C0B2D827CF7340CH2PR12MB3912namp_--

--===============1056290537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1056290537==--
