Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1651DC56201
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA4B2245F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OTyvmgwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA4B2245F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903246E185;
	Thu, 22 Oct 2020 03:47:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC456E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu3pS/rHWJ67QZAqun4Y7EVd0pMQLz9FH5srHZ3KRDAZlTGlpy8pFywETRQ+3mIzYVMc/qho3echtS+kEL9lcFezHIFSYqCnmnj0XJHwJ/YJ+UFnr2tfWw9Gw92D8B0pud7DuZLouy2VZSChvuOP298FXehVfR1X7Rgd9QTy8Q4ieQpQ9t7gwq8+Sg+GpiaUZLxjl4proRx/f2WhYcdbCl3rVlXi1fvrtB2JpYjpaGFIBzJAg2wJN0DSpIZsw3LPaPWK6qjdCSiWUznAMFI6RXruzuEiuwsIEh+lAUn1EffrnzEzW0002gaYXAn6dAygjEDgLn4uf8EFOoLvTig4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0F5VcuLRMVL9ukF/CM+IPxSJA16T+MclakqMM26wns=;
 b=dMnMApfc+ldebsoT2/ViPYq9v97/Z6pyPiDMN/rQuwvsCo80BPZMp9V+O7cX6Q1b7TMAjCuY5kqXsajyLPdxFdxT/+VvISL2HOQL3/qhyRoW5tOfQL5Dd6rl3a9hUsAgXHSOrA0/rLA/7Lc6Bu5YZRvXipyw2d+t4pHNCFtrqgqzErg97wAUvjehILt+voxMb2HljZvgh8xB83BLeGzV3XZ7QGfNRjvOQp44eGcBoGucFaCwxbmRDgZMM701Ue2+2AstqIw1wblc4b1/2dD6wnJg9NX+WkFEp0dnG2hWF/js3bZ3s96H4EK+uXoj6sStD11xFSpTDyVU2sMTmpQKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0F5VcuLRMVL9ukF/CM+IPxSJA16T+MclakqMM26wns=;
 b=OTyvmgwamMeP2VB6mhoz4YouvNEWPLOujHmwRKBJ4+JbevHflIuFTUG87cX5hywooc6/mtNKDKdPXnRfk5SfbtlknIRAkn17NWQ+Mougt3f1b4R5EEbIgs4KO5Xe3WsgLPo9bj+xozZb6mzw699k7e0GimMDW2Z1fFxBD7KjKSo=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Thu, 22 Oct 2020 03:47:55 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 03:47:55 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 blockchain
 SKU(v3)
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10
 blockchain SKU(v3)
Thread-Index: AQHWqCV8udPgQ6yWpkmna2NrAmRGYKmi+2IAgAAAgL4=
Date: Thu, 22 Oct 2020 03:47:55 +0000
Message-ID: <DM5PR12MB154699A6CADBE9C545B2203F951D0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201022034309.7568-1-tianci.yin@amd.com>
 <20201022034309.7568-2-tianci.yin@amd.com>,
 <CADnq5_MeJxe5VO1o-+x7rL-UvJGEKy3PrE7zrNzb4hxZ30Rkmg@mail.gmail.com>
In-Reply-To: <CADnq5_MeJxe5VO1o-+x7rL-UvJGEKy3PrE7zrNzb4hxZ30Rkmg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T03:47:54.698Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76ee1327-5001-462c-b71f-08d8763d42a8
x-ms-traffictypediagnostic: DM5PR12MB1545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1545E694449D30B5A03CFCC3951D0@DM5PR12MB1545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpFPp6ReTCK16U0+CWEwskCOEjSMkYUkT5bbhisuVGiOnY5SNT/WZI7QJIvCpOOFG15WI8yaTLMzYUZiZeSSBHJPvwbJC19EuEKXrBTSLigqIDm60xDwj5OW3Gb1RCGAR7pf0gtaWm6XWgrzcpH3seMUrCyU4uaDsgKUhiKX2eHVvq74aL+qSd2eWb7bMvVsSkgbPNZokQPiw4nq6qL1j6QuTPxpFKjvI5w/WsGfM/2xLt4aTIvqTVNTdsUd67/gGPAP3Ea7SIK7xkw25h0RWXJKWym4qucDnkuYOCoYKgJz0PI0MSPa6v9DYJOMWeHWP2QjwaxWlQ7scMwajFgYXGEQZg8zpbISG9aerSbfawI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(6916009)(26005)(166002)(8676002)(8936002)(71200400001)(2906002)(53546011)(83380400001)(6506007)(186003)(9686003)(33656002)(66556008)(66446008)(4326008)(478600001)(64756008)(54906003)(91956017)(76116006)(45080400002)(52536014)(55016002)(66946007)(86362001)(7696005)(66476007)(19627405001)(5660300002)(966005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mu5UInZjbPjlqhsBR/uPSnqVMsYMz8PVPfCvgcTeGypWHBUKMv3lptVE2K0ecMltDyjiIOQAZ5mcwyxfWiKHFX1XwuZ/AGfgOg+UalcIp01bSpDgbSOwqwoLPyRgVwvidddnZApvvUmWkFq/dwYjwiBkatyfDxVAxIqXCWfUzHFFURyYi8FHxJi6dpyE4tTmYuzdcEhb7DLbRCg3fNVHwdAt37Ocmp+lbVmX361lYWSefXqeCANKFaFR0PAamF8pYUzV04ZtBaaYngf+j9fvP2p2mjfdtnnuebYNcCY6rMsAIKG0OnvFaV9E7uBnSM9n6YGRkaqB/4jl+Cbx3GBkDEY/3Xv0crcYIBT3Mj5otZ963kmkQWxIrEJZ8iQwW6Wl9nIT7FXK1YiL/QQQtojwGfS6N9MTILQAThUSPOpPPmGmsJb+xk2HAWZc1S0nmqhOqk+GxcmEpOjaBu3ynloIrIqU/r1NlU12EXGJFWu2yAPnP8vZRufbSxhRBWUsKSv7Uv5i7LrEHxLcKsT6ZAK7RSHMQnuPhPAIOkIiqJiyfGLv2/O6Z03GDNYJ4fPymDQN6GqgMXoEjKd+10L5fd8QnHauzOHwPnywGQuvShj63Hv4vhBU/9GSDJP57m9fqdE5OQXoOtdklzIPIdpW5sqo1w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ee1327-5001-462c-b71f-08d8763d42a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 03:47:55.4421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS/P2qX9J5de/zi2wUPc1n30Sjxay+KPffAx9X55kkEwL7/NxIPOnpGHmeIUi3A/59B4gReJ+pPv0MHrSkgSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1746690318=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1746690318==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB154699A6CADBE9C545B2203F951D0DM5PR12MB1546namp_"

--_000_DM5PR12MB154699A6CADBE9C545B2203F951D0DM5PR12MB1546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Alex!
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, October 22, 2020 11:45
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Long, Gang <Gang.Long@amd=
.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; =
Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Zhang, Hawking <Hawking.Zhang@am=
d.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 blockch=
ain SKU(v3)

On Wed, Oct 21, 2020 at 11:43 PM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display and video support, remove them.
>
> Change-Id: I419cfae8b00125f3bff18c0a8cd92f3266d5f04a
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index ce787489aaeb..26702c85caf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -497,6 +497,14 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
>         adev->virt.ops =3D &xgpu_nv_virt_ops;
>  }
>
> +bool nv_is_blockchain_sku(struct pci_dev *pdev)

This can be static.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +{
> +       if (pdev->device =3D=3D 0x731E &&
> +           (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7))
> +               return true;
> +       return false;
> +}
> +
>  int nv_set_ip_blocks(struct amdgpu_device *adev)
>  {
>         int r;
> @@ -530,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)=
)
>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_=
block);
>  #if defined(CONFIG_DRM_AMD_DC)
> -               else if (amdgpu_device_has_dc_support(adev))
> +               else if (amdgpu_device_has_dc_support(adev) &&
> +                        !nv_is_blockchain_sku(adev->pdev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>  #endif
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
> @@ -538,7 +547,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
 &&
>                     !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_bl=
ock);
> -               amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> +               if (!nv_is_blockchain_sku(adev->pdev))
> +                       amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_blo=
ck);
>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>                 if (adev->enable_mes)
>                         amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_bl=
ock);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctianci=
.yin%40amd.com%7C69a8d879c10a4a95df8408d8763d00da%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637389351668689049%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DB=
oBEgmT7npcabo5NhzjKxqeyErXx3CKFzK1HNHa8LWU%3D&amp;reserved=3D0

--_000_DM5PR12MB154699A6CADBE9C545B2203F951D0DM5PR12MB1546namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Alex!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2020 11:45<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Long, Gang &=
lt;Gang.Long@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Xu, Fei=
fei &lt;Feifei.Xu@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; =
Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Cui, Flora &lt;Flora.=
Cui@amd.com&gt;;
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 =
blockchain SKU(v3)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Oct 21, 2020 at 11:43 PM Tianci Yin &lt;ti=
anci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; The blockchain SKU has no display and video support, remove them.<br>
&gt;<br>
&gt; Change-Id: I419cfae8b00125f3bff18c0a8cd92f3266d5f04a<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c | 14 ++++++++++++--<br>
&gt;&nbsp; 1 file changed, 12 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index ce787489aaeb..26702c85caf8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -497,6 +497,14 @@ void nv_set_virt_ops(struct amdgpu_device *adev)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D =
&amp;xgpu_nv_virt_ops;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +bool nv_is_blockchain_sku(struct pci_dev *pdev)<br>
<br>
This can be static.&nbsp; With that fixed, the series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdev-&gt;device =3D=3D 0x731=
E &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pdev-&g=
t;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0xC7))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; @@ -530,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sri=
ov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;dce_virtual_ip_block);<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else if (amdgpu_device_has_dc_support(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !nv_i=
s_blockchain_sku(adev-&gt;pdev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;dm_ip_block);<br>
&gt;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_i=
p_block);<br>
&gt; @@ -538,7 +547,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_=
LOAD_DIRECT &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_sriov_vf(adev))<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;smu_v11_0_ip_block);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vcn_v2_0_ip_block);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!nv_is_blockchain_sku(adev-&gt;pdev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_ip_block_add(adev, &amp;vcn_v2_0_ip_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;jpeg_v2_0_i=
p_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;mes_v10_1_ip_block);<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Ctianci.yin%40amd.com%7C69a8d879c10a4a95df8408d8763d00da%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637389351668689049%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3DBoBEgmT7npcabo5NhzjKxqeyErXx3CKFzK1HNHa8LWU%3D&amp;am=
p;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Ctian=
ci.yin%40amd.com%7C69a8d879c10a4a95df8408d8763d00da%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637389351668689049%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3DBoBEgmT7npcabo5NhzjKxqeyErXx3CKFzK1HNHa8LWU%3D&amp;amp;reserved=3D0</a=
><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB154699A6CADBE9C545B2203F951D0DM5PR12MB1546namp_--

--===============1746690318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1746690318==--
