Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A77C2BB55
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 03:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9412E20678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 03:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="25w49owY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9412E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E15B89EAC;
	Mon, 13 Apr 2020 03:09:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1398389EAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 03:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlxfz5lAgOHnYUTXZCK8ZK6x/fv+SrX2p/zqX+7smiai+xGptTLvBKbho5ekWa69mtEvHegVCwRirD8pRbjr3ePl3XhiA9yORbugd947rsZwXgaEHupfqVh8nAPpMESH1UhSXEkHmXjhuLo7mVL72t++6FuOecGxA8EGLki2F35JF/Ons2Och9rvvxsk11apU+OQEpKs0l7sX+VhsGAkW+HhCB3g/XTbCwEELfwf3WiYzUnryOVx3eh3y2VQdTS1Fxo3DZQeOV3Z5UIEyNa1v8AUapGRKrUHZ9fN0zSZrVsgTBgV8uzB+A0HtFg+XpEKYYXtEFTkDRmakRy/pN5lqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaIEcAUgiCDk/euVCuNqmqzufzhiWsuPaOrI3pVzaeQ=;
 b=S/Y3r/jfI81lKapoX8kRhVc2xDuia1gshjT5nuID57AtUeXmPNDMXu/cGp/APmYlPUdKNabTBXBriwJw59dgGwbiwrX44OuozWjwLL+xsewWPl+kphhVV/LYt4Kkr5aBSk6FEwikW1dYrXYOBYXnw1CtiHCZ6NRNs/w6Z5u+DKPzoZi/zTQdRHUd3UE/NW5MFZuTG4NiNyIReKPp01wvs6XgXmcvqzng8vUSE7q19jWLzY1d0Z6sWQcSkejwUHDbnSsx4e91qdKpcFPtN1BIITCQCEEZ/4bCOWrQC7BbZcCtKc3/+SyXEhGuaXXFFp7AhwOP/JPfNFLnV5CCV11y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaIEcAUgiCDk/euVCuNqmqzufzhiWsuPaOrI3pVzaeQ=;
 b=25w49owYIY9B9uZVNUccpyDbfGHJCGXzsPfSjftiGBk9Mv+S194QO85iho1kzlulDJ2M1cqUKMG5CYbabbYkz2gIQKVVUMUz++8fAbcXvD5lkqDsgA1EVC0C0KCV0HN0tFoqOrKOaNGP1S6Z1xnaw7VwwJU7r1omMXT5BON9Zyg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 03:09:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2878.022; Mon, 13 Apr 2020
 03:09:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix wrong vram lost counter increment
Thread-Topic: [PATCH] drm/amdgpu: fix wrong vram lost counter increment
Thread-Index: AQHWDw5Nlt18iDHJOku623WBTtAVUKhyTYsAgAQWE4A=
Date: Mon, 13 Apr 2020 03:09:30 +0000
Message-ID: <DM6PR12MB26197950F92C6F355E17CF15E4DD0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200410080136.29119-1-evan.quan@amd.com>
 <CADnq5_NtxmN68VVKadomSSZ_vRcYZvCDJm6mhX269S2kKM2yiA@mail.gmail.com>
In-Reply-To: <CADnq5_NtxmN68VVKadomSSZ_vRcYZvCDJm6mhX269S2kKM2yiA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=936e25ee-a315-4b58-8d5e-0000390bec41;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-13T03:08:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1303786-bac3-498d-d3c6-08d7df5815a0
x-ms-traffictypediagnostic: DM6PR12MB2811:|DM6PR12MB2811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2811E7771EC742C7A683B66AE4DD0@DM6PR12MB2811.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(8936002)(4326008)(5660300002)(316002)(83080400001)(478600001)(71200400001)(86362001)(966005)(81156014)(8676002)(2906002)(33656002)(52536014)(54906003)(6506007)(53546011)(7696005)(9686003)(186003)(66476007)(66946007)(55016002)(64756008)(66556008)(66446008)(6916009)(26005)(45080400002)(76116006)(309714004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUQNG5oHpILPr//tzOdhGNFd/Nt242cnec56x/lwnbaz3aelOWQWj/RgmVP21NppALApgjavhpa8HP3YPIb1Qy4Ip3XjXbP/EEo7xq6HBvoDOZdVLQq4HRTJVuiPNBVIekVq7SNrfU7jnCFkG2x4iAPB+aBZvlhcOf80779UEGaYAaMGtTkNgf/GV4TjqRvmWgG/zZfZXxBHtsRlc3dZRlaMAcEc9KZA5nXSjPsON82EqWsfNv0bj41IF6zhIWYGaQ30wcmIew/844fZKoHXF+fhrak8lgMX88VPgsA9kJXE3Mh/2ICNfcfA+hoKB6befbXy6ERLvlK4N1aHEfW/3tFRA7fyNQzBV81QrIbKpXb+fsIJid1umglg9iLW1EArF0C2efcjFts3EgrEwFDEU+5Xft6R9ZOW5aGtHZ5p+sPzuAbjBCbTSncaaSIrCbEYOefnIlxx/sX0wsiaCJBSYCqpSKtlFbYOEVS5LVZAhtORi1TVOQv50qv3N1j8SX5EXyiYpRxdvFe/q+Ae6dD407K1zrVUBzb1JZnCaw01HrVWTycooP0XVaLFnWqW6sGH
x-ms-exchange-antispam-messagedata: K1e1FJ6J7o8Bptfvy2HN9QopFgrxGcepXDujz8LXozda7TivUGP+6KDQG5NDk2omtbdG3xBqba+enuK+bkjsLUTlJ8EdrKFPgedtoQM57uV8QNVPRIQekvbnrXmCO8TaiIUsqgSPtKgEaD0bDSgEpg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1303786-bac3-498d-d3c6-08d7df5815a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 03:09:30.7375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xYkPOlRSKW2oK8yyL8HAM2fAZsCzMj7K/S2aie74JvBWxaxmY4AsWD0MF8EjFLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Updated this in V2.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, April 10, 2020 8:45 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix wrong vram lost counter increment

On Fri, Apr 10, 2020 at 4:02 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Vram lost counter is wrongly increased by two during baco reset.
>
> Change-Id: I8b9959a5d1632abc774ba07d56cf295bdd8288eb
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/cik.c           |  2 --
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  4 ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ---
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 --
>  5 files changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a2a4e4b28d00..c9317975c46e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2087,8 +2087,40 @@ static void amdgpu_device_fill_reset_magic(struct amdgpu_device *adev)
>   */
>  static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)  
> {
> -       return !!memcmp(adev->gart.ptr, adev->reset_magic,
> -                       AMDGPU_RESET_MAGIC_NUM);
> +       if (memcmp(adev->gart.ptr, adev->reset_magic,
> +                       AMDGPU_RESET_MAGIC_NUM))
> +               return true;
> +
> +       if (!adev->in_gpu_reset)
> +               return false;
> +
> +       /*
> +        * For all ASICs with baco reset, the VRAM is assumed to be
> +        * lost.
> +        * For SOC15 and NV ASICs with mode1 reset, the VRAM is also
> +        * assumed to be lost.
> +        */
> +       switch (amdgpu_asic_reset_method(adev)) {
> +       case AMD_RESET_METHOD_BACO:
> +               return true;
> +       case AMD_RESET_METHOD_MODE1:
> +               switch (adev->asic_type) {
> +               case CHIP_VEGA10:
> +               case CHIP_VEGA12:
> +               case CHIP_VEGA20:
> +               case CHIP_RAVEN:
> +               case CHIP_ARCTURUS:
> +               case CHIP_RENOIR:
> +               case CHIP_NAVI10:
> +               case CHIP_NAVI14:
> +               case CHIP_NAVI12:

I think we can probably just drop the asic check and always return true for MODE1 reset.  The UMC block gets reset is memory is not reliable.

Alex

> +                       return true;
> +               default:
> +                       return false;
> +               }
> +       default:
> +               return false;
> +       }
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
> b/drivers/gpu/drm/amd/amdgpu/cik.c
> index db68ffa27984..fe306d0f73f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1358,8 +1358,6 @@ static int cik_asic_reset(struct amdgpu_device *adev)
>         int r;
>
>         if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 r = amdgpu_dpm_baco_reset(adev);
>         } else {
>                 r = cik_asic_pci_config_reset(adev); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c 
> index 7768880fcccf..995bdec9fa7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -351,8 +351,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>         struct smu_context *smu = &adev->smu;
>
>         if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 ret = smu_baco_enter(smu);
>                 if (ret)
>                         return ret;
> @@ -360,8 +358,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>                 if (ret)
>                         return ret;
>         } else {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 ret = nv_asic_mode1_reset(adev);
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a597ad22b675..58a440a15525 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -569,14 +569,10 @@ static int soc15_asic_reset(struct amdgpu_device 
> *adev)
>
>         switch (soc15_asic_reset_method(adev)) {
>                 case AMD_RESET_METHOD_BACO:
> -                       if (!adev->in_suspend)
> -                               amdgpu_inc_vram_lost(adev);
>                         return soc15_asic_baco_reset(adev);
>                 case AMD_RESET_METHOD_MODE2:
>                         return amdgpu_dpm_mode2_reset(adev);
>                 default:
> -                       if (!adev->in_suspend)
> -                               amdgpu_inc_vram_lost(adev);
>                         return soc15_asic_mode1_reset(adev);
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
> b/drivers/gpu/drm/amd/amdgpu/vi.c index 0a90c296409b..af8986a55354 
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -744,8 +744,6 @@ static int vi_asic_reset(struct amdgpu_device *adev)
>         int r;
>
>         if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 r = amdgpu_dpm_baco_reset(adev);
>         } else {
>                 r = vi_asic_pci_config_reset(adev);
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C22eb212ade824eb3fc5c08d7dd4cfe75%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637221195076651531&amp;sdata=2DazCSnEqgcdV
> pRpmyEBZ9k%2BawbTdciixdhCdNIij4g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
