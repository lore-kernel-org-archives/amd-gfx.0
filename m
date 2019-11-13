Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B5C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 13:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7798B207FC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 13:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7798B207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE066ED16;
	Wed, 13 Nov 2019 13:54:47 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730053.outbound.protection.outlook.com [40.107.73.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B726ED15
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 13:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1K8ykFF+YiENSTahxuMNLI1yWLX6VK71keTa5RyGJoZJZAKRV4Y8z7tZYsC3EFskYICIwv2ocMpzsom4G1E4waBuMCOXBADJIYSdoxj3XMAeINNp9jvaepBuhGZXkXwIx+XlHjHCEZrxs8QwVfJKbYfS97mWpOgp//fYdsaNv4QNq4cUx4ZbxecUGg1N0+sWMa9rzXaqWwUaeLPkmcdSNgwcZh49M8uYbuYKRGixNFKHd4umrQyr1UTi0z2x2uopu7ZgZAwAZC8Ly/KB7jHGsN0cmQWEDeqyhnWO6HEydApC5Qeub0d3xRZBs89U7d4JckR6HJf5sni8lk7k0VXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSjIMvAdIv4RUPofRttRoq03Y7kceH47m4hFtJMtN5U=;
 b=BOMHVR2G2JCm/T8LCPdUeJv+ip7I7+MYVlVzU+wPyYmYYU8qLyeNrr5JXH7wae6RTSt+ALq4AdffZIeN3dyT/O4ssL1Q6rg4JS1UMtxZTtlSEvQz5tZBnvKV03lle1NQKHL2dVGRX4N2GiBYaEQb6rKEfUZOmbcrochCTjMF+qDE9+Ub8u3Hb7EDx81RAZQ2XAJaLlx6jgarV7zi6LpyZogfpzVpYaTyTdtKMdyh2fEi47rG6ZRdMVY0Snp+MgEA9/XmEEqXIlJhqV2JB9PMl2kq2i+kUve4MYcmauRWDtauOLMSvQ6hciHiGtKOv/eD/KInxqJdV9a5OUiJqNKcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1302.namprd12.prod.outlook.com (10.168.164.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 13:54:42 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 13:54:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled (v2)
Thread-Topic: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled
 (v2)
Thread-Index: AQHVmWvCnB2nGLHPsEuvKO9VPAVEqaeIW+UAgADFAFg=
Date: Wed, 13 Nov 2019 13:54:41 +0000
Message-ID:
 <CY4PR12MB1813FAB578D07C4FB3C30320F7760@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191112151327.108438-1-alexander.deucher@amd.com>,
 <MN2PR12MB3344C97B5167EAC63AF5796FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344C97B5167EAC63AF5796FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30b908b6-0f41-4c25-e44a-08d76841087f
x-ms-traffictypediagnostic: CY4PR12MB1302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB13028FDCF6776F6E24CA019BF7760@CY4PR12MB1302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(13464003)(189003)(199004)(25786009)(105004)(446003)(14454004)(26005)(966005)(606006)(6436002)(236005)(99286004)(9686003)(33656002)(6246003)(11346002)(71200400001)(66066001)(110136005)(186003)(71190400001)(229853002)(256004)(76116006)(316002)(478600001)(7736002)(3846002)(6116002)(81166006)(81156014)(2501003)(486006)(86362001)(55016002)(102836004)(8936002)(74316002)(5660300002)(6506007)(66556008)(64756008)(66446008)(53546011)(19627405001)(6306002)(54896002)(76176011)(2906002)(66476007)(8676002)(66946007)(7696005)(52536014)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1302;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ho/aHarvPMlDcxQ+6TZaA3NtajYnnE9toqDphaizE/9Ln2QGPLQnyKj7zEJr7+JylXOP63SpadHLdZL/Yq+unQ+iAdo1nRsAVpCc3juaueyInoqYvMAAir/w66mrwDp/0qYKWLSKXnujXWizPJ0KxPeFb87a7CBkK49UnlEIUSrCGQkjCb34ccw7sc4bX60gLLb8v4uycB04BSIB2WY+cUuyj6mPYT1YeuIcFEMbKnyVezyqYufGn8u4fjJVdES6hyUlTkPqyJKtSftXUBmR5iDwV3vMHgep6EuhTwT/gKKlFMLw1fANF5N6xcSWD1RRiHqMR1yFBBCvYgbNcDZ0fweo7eR0ehM5+Xp3hfziZR+tkFG8Foh9UR1M53WpRBq3d8ci2fRgpYozaq/tcFUawqJoqugFJ3Ylo+9heFsppogcZYEaG4Apqy7oyKLIPguM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b908b6-0f41-4c25-e44a-08d76841087f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:54:41.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uDgR8p6UaxJQrBdMrRX5KDhniqDAzsKCWUcw7yNHLEkjT/HfTe8JO3McruWFDw6HsA3pCQd6oHfcBoKbOTIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1302
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSjIMvAdIv4RUPofRttRoq03Y7kceH47m4hFtJMtN5U=;
 b=WJ8vhGGNsPyoRMCiYS/Uts/U55GNW0Yrn4Sfq5l5CrnLQP0GIU+rLgb/ha2a427x4aVGicdL6Y1+6/PXeq5UpGBhewaPpqusVeRu9stfZf6nM7STqh+RGkFzp7HjlRB4nsg7A+6i0n6Cy1oVGSQV0MvEEoVPAXXHAsbzcZnd2L4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1161191373=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113135441.8VHBtyl_s8-HmJDlsVAzz7X0OoaaF031QN65C66jOYc@z>

--===============1161191373==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_"

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I can send a patch for that.  Thanks!

Alex
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, November 12, 2019 9:09 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled =
(v2)

This patch is reviewed-by: Evan Quan <evan.quan@amd.com>
However, i just find we need a separate patch to clear PP_GFXOFF_MASK suppo=
rt from Arcturus.
Can you do that or you want me to do that?

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, November 12, 2019 11:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled (v=
2)
>
> When gfxoff is enabled, accessing gfx registers via MMIO
> can lead to a hang.
>
> v2: return cached registers properly.
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D205497
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 27 ++++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 31 ++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index af68f9815f28..7283d6198b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -201,17 +201,25 @@ static uint32_t nv_read_indexed_register(struct
> amdgpu_device *adev, u32 se_num,
>        return val;
>  }
>
> -static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> +static int nv_get_register_value(struct amdgpu_device *adev,
>                                      bool indexed, u32 se_num,
> -                                   u32 sh_num, u32 reg_offset)
> +                                   u32 sh_num, u32 reg_offset,
> +                                   u32 *value)
>  {
>        if (indexed) {
> -             return nv_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
> +             if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                     return -EINVAL;
> +             *value =3D nv_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
>        } else {
> -             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG))
> -                     return adev->gfx.config.gb_addr_config;
> -             return RREG32(reg_offset);
> +             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG)) {
> +                     *value =3D adev->gfx.config.gb_addr_config;
> +             } else {
> +                     if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                             return -EINVAL;
> +                     *value =3D RREG32(reg_offset);
> +             }
>        }
> +     return 0;
>  }
>
>  static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
> @@ -227,10 +235,9 @@ static int nv_read_register(struct amdgpu_device
> *adev, u32 se_num,
>                    (adev->reg_offset[en->hwip][en->inst][en->seg] + en-
> >reg_offset))
>                        continue;
>
> -             *value =3D nv_get_register_value(adev,
> -
> nv_allowed_read_registers[i].grbm_indexed,
> -                                            se_num, sh_num, reg_offset);
> -             return 0;
> +             return nv_get_register_value(adev,
> +
> nv_allowed_read_registers[i].grbm_indexed,
> +                                          se_num, sh_num, reg_offset, va=
lue);
>        }
>        return -EINVAL;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 305ad3eec987..2cc16e9f39fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -363,19 +363,27 @@ static uint32_t soc15_read_indexed_register(struct
> amdgpu_device *adev, u32 se_n
>        return val;
>  }
>
> -static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> +static int soc15_get_register_value(struct amdgpu_device *adev,
>                                         bool indexed, u32 se_num,
> -                                      u32 sh_num, u32 reg_offset)
> +                                      u32 sh_num, u32 reg_offset,
> +                                      u32 *value)
>  {
>        if (indexed) {
> -             return soc15_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
> +             if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                     return -EINVAL;
> +             *value =3D soc15_read_indexed_register(adev, se_num, sh_num=
,
> reg_offset);
>        } else {
> -             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG))
> -                     return adev->gfx.config.gb_addr_config;
> -             else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmDB_DEBUG2))
> -                     return adev->gfx.config.db_debug2;
> -             return RREG32(reg_offset);
> +             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG)) {
> +                     *value =3D adev->gfx.config.gb_addr_config;
> +             } else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmDB_DEBUG2)) {
> +                     *value =3D adev->gfx.config.db_debug2;
> +             } else {
> +                     if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                             return -EINVAL;
> +                     *value =3D RREG32(reg_offset);
> +             }
>        }
> +     return 0;
>  }
>
>  static int soc15_read_register(struct amdgpu_device *adev, u32 se_num,
> @@ -391,10 +399,9 @@ static int soc15_read_register(struct amdgpu_device
> *adev, u32 se_num,
>                                        + en->reg_offset))
>                        continue;
>
> -             *value =3D soc15_get_register_value(adev,
> -
> soc15_allowed_read_registers[i].grbm_indexed,
> -                                               se_num, sh_num, reg_offse=
t);
> -             return 0;
> +             return soc15_get_register_value(adev,
> +
>        soc15_allowed_read_registers[i].grbm_indexed,
> +                                             se_num, sh_num, reg_offset,
> value);
>        }
>        return -EINVAL;
>  }
> --
> 2.23.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_
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
I can send a patch for that.&nbsp; Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2019 9:09 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: don't read registers if gfxoff is e=
nabled (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is reviewed-by: Evan Quan &lt;evan.quan=
@amd.com&gt;<br>
However, i just find we need a separate patch to clear PP_GFXOFF_MASK suppo=
rt from Arcturus.<br>
Can you do that or you want me to do that?<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Alex<br>
&gt; Deucher<br>
&gt; Sent: Tuesday, November 12, 2019 11:13 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled=
 (v2)<br>
&gt; <br>
&gt; When gfxoff is enabled, accessing gfx registers via MMIO<br>
&gt; can lead to a hang.<br>
&gt; <br>
&gt; v2: return cached registers properly.<br>
&gt; <br>
&gt; Bug: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D205497">=
https://bugzilla.kernel.org/show_bug.cgi?id=3D205497</a><br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp; | 27 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----=
------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 31 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
---<br>
&gt;&nbsp; 2 files changed, 36 insertions(&#43;), 22 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; index af68f9815f28..7283d6198b89 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -201,17 &#43;201,25 @@ static uint32_t nv_read_indexed_register(str=
uct<br>
&gt; amdgpu_device *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return val;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static uint32_t nv_get_register_value(struct amdgpu_device *adev,<br>
&gt; &#43;static int nv_get_register_value(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool indexed, u32 se_num,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_num, u3=
2 reg_offset)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_num=
, u32 reg_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *value=
)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indexed) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return nv_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D nv_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.gb_addr_config;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32(reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.gb_addr_config;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_=
feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D RREG32(r=
eg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static int nv_read_register(struct amdgpu_device *adev, u32 se_n=
um,<br>
&gt; @@ -227,10 &#43;235,9 @@ static int nv_read_register(struct amdgpu_dev=
ice<br>
&gt; *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;reg_offset[en-&gt;hwi=
p][en-&gt;inst][en-&gt;seg] &#43; en-<br>
&gt; &gt;reg_offset))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D nv_get_register_value(adev,<br>
&gt; -<br>
&gt; nv_allowed_read_registers[i].grbm_indexed,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return nv_get_register_value(adev,<br>
&gt; &#43;<br>
&gt; nv_allowed_read_registers[i].grbm_indexed,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offset, value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 305ad3eec987..2cc16e9f39fb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -363,19 &#43;363,27 @@ static uint32_t soc15_read_indexed_register(=
struct<br>
&gt; amdgpu_device *adev, u32 se_n<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return val;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static uint32_t soc15_get_register_value(struct amdgpu_device *adev,<=
br>
&gt; &#43;static int soc15_get_register_value(struct amdgpu_device *adev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool indexed, u32 se_num,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 sh_num, u32 reg_offset)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; u32 sh_num, u32 reg_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; u32 *value)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indexed) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return soc15_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D soc15_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.gb_addr_config;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmDB_DEBUG2))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.db_debug2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32(reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.gb_addr_config;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmDB_DEBUG2)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.db_debug2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_=
feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D RREG32(r=
eg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static int soc15_read_register(struct amdgpu_device *adev, u32 s=
e_num,<br>
&gt; @@ -391,10 &#43;399,9 @@ static int soc15_read_register(struct amdgpu_=
device<br>
&gt; *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &#43; en-&gt;reg_offset))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D soc15_get_register_value(adev,<br>
&gt; -<br>
&gt; soc15_allowed_read_registers[i].grbm_indexed,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, r=
eg_offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return soc15_get_register_value(adev,<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_allowed_read_registers=
[i].grbm_indexed,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offse=
t,<br>
&gt; value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.23.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_--

--===============1161191373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1161191373==--
