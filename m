Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 14:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9FF2078B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gmD0mAwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9FF2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E286E0C9;
	Fri,  6 Nov 2020 14:23:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40256E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 14:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZl/gurCbFpsgsH9dWdqnmb7N+Q79grCeR9Y1voR8CE+q7MV2L8cMR5qtSkMbZxRNAZnZIr0JZkrToTC8IGtD9/QxGgQ2NIHcL3ZjCSPa4Ms6kd4BS4O1raSm4FS8odhVAlfgtx8SBqISyLCZfcFi5v/bTKMi5914NNzoXKdxvvTGtHCKhe9Xvu8SdEbuO9pEwpsPHZ8h4h/T+Y5Nk/OmhUTyR36JNutzrGmtiPYg1EpCgt44R/qjeuPiN89kl6ZWhNdpmLY3G7LDNOyP7AuuZuFVXU2lI/wtHXadNyKZHFwX8NpMNsM2QTBQjWz51yJ9yegbv87bgXeRFDMTnYYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0PbZdTVg+xsVnRXkOqgzNgL/7DZ3oN/tKTDq3SZeuA=;
 b=HvrBVZLshPy9uMs4uE3l69ml5zCaTm0umtj7qBLg+VYuwDIOAQ69zRBbueybPWUPd6GG+lmm216vMpMec+pqk739rGsDXytk+cHOCZraArqt4q3XNoVgp4vSYXfcn1fFfY/YWLQuBSL9p7hdUUPnjwZhoPpWDGZ88gjXJcb/Pbr+UAybfgZRx4RRhKLMUM7hqPRnaAKZT8A0QB/njau7ZzyNFVhNqaICL8f4VvQU4dPMhAyln7dREsJFZAUUu1OBTZ59xYomNqEgEk3KQ17gKFTVwFbQ6FlUT74r+oJChTrv+L4RQKpJRQ1VkR8yVxGcskIMm50mFFFO1qwTRdxMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0PbZdTVg+xsVnRXkOqgzNgL/7DZ3oN/tKTDq3SZeuA=;
 b=gmD0mAwtFf1oyck3yQvSr29hpq6aAY4OPMnk+KQEf7DXamWj3SOGaMMrvImIcPxSoVzXGWKEooToi69p4b0fpVzwtVU0M71d6CUvacpJiT0LyLeQEnkaGvYXTizrwkvteaDKkgXUrdgJBVsjf61NXqsqfd0OlUaBhyxMVfNRLdc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 14:23:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 14:23:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Index: AQHWtA+qGfUPXkgcN02ypm70z6wsm6m7JzQn
Date: Fri, 6 Nov 2020 14:23:06 +0000
Message-ID: <MN2PR12MB4488038A343E762EB83B552AF7ED0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201106073659.53993-1-tianci.yin@amd.com>
In-Reply-To: <20201106073659.53993-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-06T14:23:05.633Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e7f35d0-d622-4026-6540-08d8825f7a9c
x-ms-traffictypediagnostic: BL0PR12MB2436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24364966FED266A455D36BB0F7ED0@BL0PR12MB2436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K60KddFNOuKMSqwLEi6htWcneO8R2dq8piq6GWsPqM/tjDxPA3sPHVyC/EA8SeGp/tC8NR35SfgPS4V5540vKMn76bP5Dq9WsmbXOa+d8xg0M4g85hHvTS4oU4mdzSQHfQPUoOT+WIOJOA6/slU395RUkEagzsEC+8D3bzMjYI7oh41eAHRxLOhI/4zpJKbwWtlBL4vRZR3nEV7EUuHPzJllyigi/CPq/wK98aOnN3Ub8+UR5y10CXypTvTY0zoPvkgQV0YJK9VEICkQwKtqojYkJIFgTBOQFLvZtNaXBCDef2ggDQHhUYnQi8B0tSbH98wD91wfkIvr40u0dl+GuD+soLdXXCWizd8YdaDOVWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(5660300002)(2906002)(7696005)(26005)(54906003)(8936002)(33656002)(9686003)(478600001)(66946007)(76116006)(52536014)(66476007)(316002)(4326008)(66446008)(8676002)(64756008)(53546011)(19627405001)(6506007)(110136005)(186003)(71200400001)(966005)(166002)(45080400002)(55016002)(86362001)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RRJln0+HuFY6DtvHV/3N7wBAHSR9WYG4ilUv6/ykwk1GNjpP7xEd8d2gTBTbhdD2AACcog53mCxYkSGYg85cWUr6mW1n5jwE8FW2OiaDzqoVyhz9IKVWvfkRfLR7TVp8IV3w6UcaTaKZptaJOSqa6j8ys5iXgFuUGdbG2QUeHFaxQZ3Gqu9IWdHAwjqYxulEV5uaObOr/u6TIxK6qNbWqszRuapjqAfGDWZoAX4LPTbogHs6f4fbiTIMoQY7NCcEtJAXE85SjeLXzpXMdZtKMWg/kvfIX+oZonLtXMW9vd24EhQntsTdpff2CEXHqFYsfyUHakRB9sVhD37sfp4zRImBVuCjBtx8bS/jNYHJjw5wMzvJkzPFu76uqg3cMrleH+wMAJmri7z5niReMfLSEteKCV+GyE1VJA4avo4Pf5BUrposcZ1EJJQUoeAVJaKzb0hXrw2ehwCsKjWqapajCfvSJSQhB0av2vPDSXJ6PB4cyUF9r8WtUIRchQAB8nzPqtYFBFMchAtDC1l64LnnaBodtoBb0PqPDyH3VH/9vMOzv37WtKkA7TT5T2Rzb8qCwbazsI8yTqqNNMW0vSWA40KojOvmO2yJut9uw18Sk+4F3GfjeGTPO1JMjxI9RBZU1Js2SYvieg/+YX35gAytfQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7f35d0-d622-4026-6540-08d8825f7a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 14:23:06.2174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dr7q7Sdyp7HCUUtPTAdIdWF101zL/QYHl9myZfInngcXrOdy9Oa1Li/sJYgPPjhLArhxxQ5SJzqyGXly0VSTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
 Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Cui,
 Flora" <Flora.Cui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1982169555=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1982169555==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488038A343E762EB83B552AF7ED0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488038A343E762EB83B552AF7ED0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tianci Y=
in <tianci.yin@amd.com>
Sent: Friday, November 6, 2020 2:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu,=
 Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuiko=
v, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.=
com>; Cui, Flora <Flora.Cui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>
Subject: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

There is a NULL pointer crash when DCN disabled on headless SKU.
On normal SKU, the variable adev->ddev.mode_config.funcs is
initialized in dm_hw_init(), and it is fine to access it in
amdgpu_device_resume(). But on headless SKU, DCN is disabled,
the funcs variable is not initialized, then crash arises.
Enable DCN to fix this issue.

Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index e33d8022cc32..67375b2948f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_b=
lock);
 #if defined(CONFIG_DRM_AMD_DC)
-               else if (amdgpu_device_has_dc_support(adev) &&
-                        !nv_is_headless_sku(adev->pdev))
+               else if (amdgpu_device_has_dc_support(adev))
                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C516e3593f84a45811bd908d88226c8e8%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637402450426333203%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DRzbVAu02p9LVSSOXx3M0QwQztABgpf8FRiWhDyU6BOY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488038A343E762EB83B552AF7ED0MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tianci Yin &lt;tianci.yin@amd=
.com&gt;<br>
<b>Sent:</b> Friday, November 6, 2020 2:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Chen, Guchun &lt;Guchun.Ch=
en@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yin, Tianci (Rico) &l=
t;Tianci.Yin@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deuch=
er, Alexander &lt;Alexander.Deucher@amd.com&gt;; Cui, Flora &lt;Flora.Cui@a=
md.com&gt;;
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.co=
m&gt;<br>
<br>
There is a NULL pointer crash when DCN disabled on headless SKU.<br>
On normal SKU, the variable adev-&gt;ddev.mode_config.funcs is<br>
initialized in dm_hw_init(), and it is fine to access it in<br>
amdgpu_device_resume(). But on headless SKU, DCN is disabled,<br>
the funcs variable is not initialized, then crash arises.<br>
Enable DCN to fix this issue.<br>
<br>
Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index e33d8022cc32..67375b2948f5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_v=
f(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dce_virtual_ip_block);<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !nv_is_hea=
dless_sku(adev-&gt;pdev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dm_ip_block);<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_ip_bl=
ock);<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C516e3593f84a45811bd908d88226c8e8%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402450426333203%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DRzbVAu02p9LVSSOXx3M0QwQztABgpf8FRiWhDyU6BOY%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C516e3593f84a45811bd908d88226c8e8=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402450426333203%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DRzbVAu02p9LVSSOXx3M0QwQztABgpf8FRiWhDyU6BOY%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488038A343E762EB83B552AF7ED0MN2PR12MB4488namp_--

--===============1982169555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1982169555==--
