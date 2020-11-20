Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA10C5519F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407602224C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="13FHXQze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407602224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D97689CD5;
	Fri, 20 Nov 2020 14:34:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C02589CD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 14:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anSCNeDJOPK3qqn5qi5/tYw88FmYEbROh4OjzemgpwergW4ufxAMoDMI+e5xZzsjCPJOM9jHfLegMh8L+J5H3DVXDt0HePd38KwCaHrsqBhYZUSpAdWweHG3Fo1xrO7W8ZRqaSIprdnYkpEachRar0F43NBQHMqOhnj83DS/jTZJaXb81LrPBDe/8nEIf5CM93FJPVPtNcJ/eoLY9pUkCQbDnOm0Y4KMdQNAlBR5AaQaMZu/llacbwEsleOj6rIQEc0NbTzF4IGvsnbssVEpyCWVb6kdE1i1XxXcZGO2bHX7Ygum0bWGLcoX9c50z9HPdI4Cf1SvCFPz623pZGlQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f6bXCR8VgnzfJnsgrxNApqFwxJaxVD8tE4nkYetI08=;
 b=J8XHq8Gx/O3Meq14dF2wTKuOro90Bp8niSwqYXirIZY804VEsJD1dhgUDSWm9PQreWNuw8gg9gJo/oTgR4vCKfaUYuXMhzDmCr3tiwmEYck9+kAira4DsX23TKUdPzB+QZ6rHaRdi7MZYjqyvA/GIvBhLfwskJGfFer+yJs+9a3fWphLnXTrs8bwIH63gE16Pp0RK1+Jj3SAtm6PT9QbnIaLVZPxLG/k2f9LU+dj88XPi3N4zabGm+Ji7p+zb0vUM3fqE4q4Ed9SBSa5RXdH/VIk2s8beCaxdAc6vnnBML4pkIGbMy5lwJ5ZcMMSD8PgjPbT9nz9vjezng70jeXqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f6bXCR8VgnzfJnsgrxNApqFwxJaxVD8tE4nkYetI08=;
 b=13FHXQzefzn3a3mXK+kJrvn58Tgqq0KJrEOa6Qhfks24ev9DryXXe1pc5uz2pJEqbbYi7S9GIFAjCEOxODdqcPjEnEzrm0kLcywFMgOUnzXUDbwwclbf16WgfjYwTI16V1LAWcoFICmUy9OJCLJbT8z+4zyo2vd2ozmz175Y514=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 14:34:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%6]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 14:34:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Avoid HDCP initialization in devices
 without output
Thread-Topic: [PATCH] drm/amd/display: Avoid HDCP initialization in devices
 without output
Thread-Index: AQHWv0V1dRIuAu2B1k6Ao5pAAgFFN6nRFeYH
Date: Fri, 20 Nov 2020 14:34:34 +0000
Message-ID: <MN2PR12MB44884B9BF67E73207E555FD9F7FF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201120135956.2387185-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20201120135956.2387185-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-20T14:34:33.935Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2eb1a00d-2e1b-4691-2c93-08d88d616699
x-ms-traffictypediagnostic: MN2PR12MB4407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB440750086F110752F82A7883F7FF0@MN2PR12MB4407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSa4mfhlNMSY6gA1lHZlUqlHSjH7mv34JcBl3SAEzC08jdGruKB8Eu42Cf7Elu/aAloV1efnC1Fg6EVLfQHdzQCnOdU/lSd8hNBAH4MYvrS5Rrx5nWAyv7aZMDQQjfF7UlSjVIXHV4XP8HsUlzIzR/JyvwwTSCUUmgX70eGk2PTw5shzpHPNDJyd9tMA1ZQrLOkRsAeDsHzc6cg/Mz8gdZVrHaIhYvKidC8ue5cHvB+UmQeggkx/WtQJrjjG4ce9tKx1yTgHoUDNECJpyisIOwkZ4WQfhKkfsmhGGEjYNuodFQ3Kgp1D93rnuTvYewfwweARpZ/dj6/8Yb9tGZ4CTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(8676002)(26005)(110136005)(71200400001)(8936002)(19627405001)(52536014)(6506007)(53546011)(33656002)(186003)(316002)(55016002)(86362001)(9686003)(83380400001)(66476007)(478600001)(7696005)(2906002)(76116006)(5660300002)(4326008)(66946007)(64756008)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: doubwg3TG4BXKZoAX9iDQBZgajpNJEXy0tFDJEWzL77J1KU2qMT8DB4QbMYkMp65tTdumGkUO/0Nu8zdEX2j1W9Tukj1wLwoEUqZczMaWwbx3fdRiNylPGrH0tgY1q9BlzMz72zA9LjmJbJJxyNswAJnvCGdgmULGKd/TF5OKX+0spCLkahuoLt1z4pae5zqjBO5zpG8ubVz5p3xFWLwzsdbVEhyLwzzJ38YmSLtsTpl4RfmjXf8rJOTYbrrfRz7G8Mxfz5mSsgwbGL5AEfoL1mOCCFaSRKKzVRMvKlwHXUdPg/Ld6lRub6DwAMMGjipR/qit69vrsY4+5vro7zzxK/WuHiDtEBNmOkHQ97FPFR9lEpq3V0iNeKWo4SJAFaU84WPM54tmKFuDpqM8siBhGBUn3RYX+x+SPb+OGpu3yOsR06DwBT1MuqXkpYB9aFuG876c97F6q8V6ivuz1LGB5JG8g2Qz9b5cOeucLUXM3aU3Dc9suPRR0Zfqw4El9O0MQvtujucfz6VKEWvGFAp0rPhVDsOznq5xMgq/6P3lri6mxzja8hSK9hjAINkEerbCqaN65kMirWUgRc6l4i8vch3r/wrtpLVHT3qwYpo4uVD/34XulLgnIHpBlr0g5lK44m4gEanVsW4xWujisYyBiMtd+xnrihG9RBkv8WE0+GjSCBfMmOpIR38AsUu86HDhJ5ZmHWV+yvwtg5/2uksMNEi+y0VMmRPDwzxGPIxU8WL+8H8DnYE0W/k4w++OKNNvT+4tUteMZBkuHCEjrzABYBhUSAisOshZHFn2VHlsmKjdBosGWY3oraC79zrFsbN+5MIrQICNB4ksVkYbhvVfxyCVgR5yzIR1UaovffoFJ1VqHiux3zyHg/FdMVWlm+X5LDthbxRU95/PE/1NnTpCQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb1a00d-2e1b-4691-2c93-08d88d616699
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 14:34:34.4727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGziZ0hS/vL2McG1pVLYjIYPndug5nEdJHq5u7RBMXoTlTkUkSe24f33rDgiU4h1ozap1q5NFgxvpWopfbE8GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: multipart/mixed; boundary="===============1392971355=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1392971355==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44884B9BF67E73207E555FD9F7FF0MN2PR12MB4488namp_"

--_000_MN2PR12MB44884B9BF67E73207E555FD9F7FF0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Friday, November 20, 2020 8:59 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>
Subject: [PATCH] drm/amd/display: Avoid HDCP initialization in devices with=
out output

The HDCP feature requires at least one connector attached to the device;
however, some GPUs do not have a physical output, making the HDCP
initialization irrelevant. This patch disables HDCP initialization when
the graphic card does not have output.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1da4ad529309..e213246e3f04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1109,7 +1109,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
         amdgpu_dm_init_color_mod();

 #ifdef CONFIG_DRM_AMD_DC_HDCP
-       if (adev->asic_type >=3D CHIP_RAVEN) {
+       if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >=3D CHIP_RA=
VEN) {
                 adev->dm.hdcp_workqueue =3D hdcp_create_workqueue(adev, &i=
nit_params.cp_psp, adev->dm.dc);

                 if (!adev->dm.hdcp_workqueue)
--
2.29.2


--_000_MN2PR12MB44884B9BF67E73207E555FD9F7FF0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Friday, November 20, 2020 8:59 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Deucher, Alexand=
er &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Avoid HDCP initialization in devic=
es without output</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The HDCP feature requires at least one connector a=
ttached to the device;<br>
however, some GPUs do not have a physical output, making the HDCP<br>
initialization irrelevant. This patch disables HDCP initialization when<br>
the graphic card does not have output.<br>
<br>
Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 1da4ad529309..e213246e3f04 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1109,7 +1109,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_init_color_mod()=
;<br>
&nbsp;<br>
&nbsp;#ifdef CONFIG_DRM_AMD_DC_HDCP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_R=
AVEN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;dm.dc-&gt;caps.max_links=
 &gt; 0 &amp;&amp; adev-&gt;asic_type &gt;=3D CHIP_RAVEN) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;dm.hdcp_workqueue =3D hdcp_create_workqueue(=
adev, &amp;init_params.cp_psp, adev-&gt;dm.dc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;dm.hdcp_workqueue)<br>
-- <br>
2.29.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44884B9BF67E73207E555FD9F7FF0MN2PR12MB4488namp_--

--===============1392971355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1392971355==--
