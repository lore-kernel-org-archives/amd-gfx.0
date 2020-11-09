Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1714C388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A932068D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y/ZlWV/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A932068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB76892F3;
	Mon,  9 Nov 2020 02:20:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FC5892F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 02:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNLya9Ebqur9LFuocwqk4IxKHV3lCKo9HW2BVVsVYU+fYNAEFYikmuQig23448tLSvYAIKm9g7E+N3aHKODmWbU5SS0RxCweLzyjvKLd1BjRUT9pNZ10zxL0CDnYlSORgUduEcbRtS1R8ExixA/80wp+uGUIbvzZWuVWqAVXxPrlKfkEw4ILFBf7hQvTqh4Y81GXcC1LBoJ90hoAAeGPSg5UnIReik/yZpwtLPbnr5/vFe2IxXDsP3EjW4vP8U52AK0nLYifni5hFSXDQPTSAdHvUohEoJHFXaha1saMEKSdS1Mg/N3x+Jqiax/w57ZbnM1mR/DndSbxdPLl0IBjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWrFfHIiSuhYzphAO64pRhLXGY7HzcI+eFj0RTAT7Ls=;
 b=agKykgbh4EFmvPnGHBoe1g3Yh0h0q0t0J/EkpyElTNEmHbH37mRQUK2RBPY+pjCl/WvHAlaZ8pBJAJsiyrEdlpMrGtOgQ2TT/N79zbULQAt3pgkUOFoNdMLQTr1zpdh0SZOpg2FxSQ5n5LSqUxyou4Y0f+J2zcNe5GhdAgJCGNxE47tHck4uarz5gfCoo9uHE8l4o2dgaM5mI5AcTTE7515pSUGwgZ+jeNW0h0iELVZilmWsn7KT0fzxfSbSIB7OwW+Z68pmBh9sdlvq9LPEQMYMC+XWysYBzyWnKg4unB+hrqlKBBjrk0QhvrxlwOM0eL0wuW5WdKl4K2VDeDbZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWrFfHIiSuhYzphAO64pRhLXGY7HzcI+eFj0RTAT7Ls=;
 b=y/ZlWV/gUkabVTdd/+thKuYFegIt23+zh3SxSuXJOb14wLzcNbr7yrYrp/sdeEQBgw9lxecrj+q6B9MM9Z5WKhb36u3V4EpG/TUHtUEgeqmsW6IdXlKzI49JQcnH9lacHDDj0R3VrvdwCWk54uvAG2VwzT5KT8vm0sfZj853SBc=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 02:20:54 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::4034:84a0:fb9b:a60f]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::4034:84a0:fb9b:a60f%12]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 02:20:54 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Thread-Index: AQHWtA+qREblf+EqsEyxmm3qXrFRyqm+QfSAgADTvJo=
Date: Mon, 9 Nov 2020 02:20:54 +0000
Message-ID: <DM5PR12MB15460CFEAC9B141C00444F2E95EA0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201106073659.53993-1-tianci.yin@amd.com>,
 <CY4PR12MB12870FD6197853EEAB216DE9F1EB0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12870FD6197853EEAB216DE9F1EB0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-09T02:20:53.760Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7692182a-c2bd-4f98-603b-08d88456161e
x-ms-traffictypediagnostic: DM6PR12MB3210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB321048A5A9911ECDC219BD2B95EA0@DM6PR12MB3210.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4xPXp0pXz+4wkSOwmxq4sIVjKxKuPNbI/dlIUFYyypNMFQKM40wg17iN7qLKLsCYwvT76PfQJKwKkP2sIjJwPBP2AyoHXgcDKyr07GZ0KwndjkW1Sb6+YEIqszVpb0xvSlODWj/hhQpU5vRwFjCLK/NZgWuQxeZTjA4a6SgoHDWz/YeYSVa0THrx/DKk9GW9Yb7PYdpglTVIYtDdFaS5psiIdZZH99kf5D00GSLtnBjCV7ZFekl0HYczXeFhDCJ61htNmRH58wX7EcHBYR5PDgDFcdzOFxagD4+tCIgtArZWVBowgLMXt6xCZgyPZutHgsuw9fKNGzJtwtfNlLKwzkv3GjuQAbZnqBPx8wayso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(83380400001)(8936002)(45080400002)(478600001)(186003)(26005)(4326008)(6506007)(55016002)(53546011)(9686003)(966005)(8676002)(7696005)(166002)(66446008)(64756008)(66556008)(66476007)(66946007)(19627405001)(91956017)(76116006)(316002)(2906002)(110136005)(86362001)(52536014)(5660300002)(71200400001)(54906003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gwKF5EGD/JtvLMylRps+QjYzm1tuOwvLlJQrJvRlSBoSIGQbImXIk+xgysqBGZUFUdUWohA8zT/BywVe3lLACiYtObDSniOR+SgvIPPrC624AnZkyHRcHcEBLcC1zFnek9fDhtLP1E1Md4DCgN+Fa6HZl+IiX6AilIiTfOYR3d2dLPn6v/bqcVL+hdr+eF36haL0etISzHEe1kcV82rLcMmd7sZP1niqVlCPjLDg5R8wOCMXoBUdN9YHC647LQfauZBpoQvMHgCKdXIckKNM3YbQLNqh0rRIOCgxJL5serF89PIPF+DiT4E+xg1vmJB3zF0/Qn537oFQGUyixVtSI6wQbUyuXEIdhihhHl8nXeIpXCIhX9SHWFuWL0gxwKFYDUlc8vemKVTo1xYeKAxjE6h74446Qr49QrFU/HpaxpCVjqkxsHOVEZG9lnLihI4NA8qafWpkK7uH/SqexEjdPz+is/1PdYKAjCLx51vLS3Tzu6lnWYjeEX/TM8Q803+2iC48OjvuhWn8AFDYsO3twNYVb1xEiywbiTkjfFZsmIyxxSIcVW0/w3nWzmuXpkd5n57DXXcabxNKw5n2bMiNAd1cahm5t+rvP0iu6l+XAwVB8Dd2zR32fXGBOolBaLc23foR6cH/qYBJkSOnj7+L6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692182a-c2bd-4f98-603b-08d88456161e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 02:20:54.4269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+uIHNEJ7ckMYLmWAN3nvd+4Z3QtmyHpMMnk/HiXfEOdVP0DluXOCN8WxsWxmfj5Uuyaz90G90z6NHeGUR9ZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0940777098=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0940777098==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB15460CFEAC9B141C00444F2E95EA0DM5PR12MB1546namp_"

--_000_DM5PR12MB15460CFEAC9B141C00444F2E95EA0DM5PR12MB1546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks very much Alex and Guchun!
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Sunday, November 8, 2020 21:42
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yin, Ti=
anci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Cui, Flora <Flora.Cui@amd.com>=
; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Y=
in
Sent: Friday, November 6, 2020 3:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Long, Gang <Gang.Long@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu,=
 Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuiko=
v, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.=
com>; Cui, Flora <Flora.Cui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>
Subject: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

There is a NULL pointer crash when DCN disabled on headless SKU.
On normal SKU, the variable adev->ddev.mode_config.funcs is initialized in =
dm_hw_init(), and it is fine to access it in amdgpu_device_resume(). But on=
 headless SKU, DCN is disabled, the funcs variable is not initialized, then=
 crash arises.
Enable DCN to fix this issue.

Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index e33d8022cc32..67375b2948f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_b=
lock);  #if defined(CONFIG_DRM_AMD_DC)
-               else if (amdgpu_device_has_dc_support(adev) &&
-                        !nv_is_headless_sku(adev->pdev))
+               else if (amdgpu_device_has_dc_support(adev))
                         amdgpu_device_ip_block_add(adev, &dm_ip_block);  #=
endif
                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7C317e06850aac4667ccb608d88226ca40%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637402450416710143%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DkF=
9LlID5Di%2FFivWvtiBQWhtXefE%2FuZ3C7tgXCEQFuQU%3D&amp;reserved=3D0

--_000_DM5PR12MB15460CFEAC9B141C00444F2E95EA0DM5PR12MB1546namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Alex and Guchun!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Sunday, November 8, 2020 21:42<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@a=
md.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Tuikov, Luben &l=
t;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ti=
anci Yin<br>
Sent: Friday, November 6, 2020 3:37 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Long, Gang &lt;Gang.Long@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.=
com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianc=
i.Yin@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&=
gt;;
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
There is a NULL pointer crash when DCN disabled on headless SKU.<br>
On normal SKU, the variable adev-&gt;ddev.mode_config.funcs is initialized =
in dm_hw_init(), and it is fine to access it in amdgpu_device_resume(). But=
 on headless SKU, DCN is disabled, the funcs variable is not initialized, t=
hen crash arises.<br>
Enable DCN to fix this issue.<br>
<br>
Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index e33d8022cc32..67375b2948f5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_v=
f(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dce_virtual_ip_block);&nbsp; #if defined(C=
ONFIG_DRM_AMD_DC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !nv_is_hea=
dless_sku(adev-&gt;pdev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dm_ip_block);&nbsp; #endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_ip_bl=
ock);<br>
--<br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7C317e06850aac4667ccb608d88226ca40%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637402450416710143%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DkF9LlID5Di%2FFivWvtiBQWhtXefE%2FuZ3C7tgXCEQFuQU%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cguchun.chen%40amd.com%7C317e06850aac4667ccb608d88226ca40%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402450416710143%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DkF9LlID5Di%2FFivWvtiBQWhtXefE%2FuZ3C7tgXCEQFuQU%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB15460CFEAC9B141C00444F2E95EA0DM5PR12MB1546namp_--

--===============0940777098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0940777098==--
