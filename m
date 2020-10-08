Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BBC433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 02:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD40B20B1F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 02:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VcNIDiai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD40B20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67066EA00;
	Thu,  8 Oct 2020 02:37:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0623B6EA00
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 02:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGYSLUJ3s+wQ5COD3WK3weO7wEvLd1s7XlEYHKm48ziUlKQE4A9DRJ+mdYdzQUdkKs7tgAbkCxB3rh4QYwINBWJK1CCb6oekWt9bqqnOnuUbdaOt9XEzIv9YxhsfNiqpATeHqu54oEgT/MmksByWfoPdxP4hI6ho5tEpEOzRFbtZqqAQI+bT5i/6wM0fHKvbxgHe+WTuxqJU96lr8Qvw/hqdMGEqO1Q1p+L9cRXtrqjCRhymHBl8vuRs90Ejo8/r/c2fAGyUoWyzHTMEDn2S/FqtSjc+xaH7TgVFOqnh0uiK+7ks+AegRlX9ocfmjYOJWVjnfnzcCxtkaJ/K1kIugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODm0JvsUtIoP7jmgQ6zi/0RF3PfDdwJ3AFVQ315tnFU=;
 b=m/F15nQuaVIQCOYY+MN6UDZlHGmDlJKecZiHpmEZUawWf5SkdKeWVmQ/w9TlpxywXRS/qZU1TivE771aRZlbbdN/QQ67sDMPBzq1fORUmqQ51dTQubD5F0EsD50NEs4MdUf+pS6PQt2jiCXeeoQdvTAeQZbENM4z0p8IViQlFil46RS/uR2LVCUZsllCQATuDDKjKA5W0pkLL6MRQ8y9IOJiNid7kTS3sKAW8RXFiO1I5qZCiFz4if0ggBl2OzBvMLD1PP7LmuCjfHJP8zwtBNYaqMJsA0jRRJZMDvhCvuroaHsvcl70TDyDIZIgWdTh/28k1h/qbBNUsbRKwr5s9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODm0JvsUtIoP7jmgQ6zi/0RF3PfDdwJ3AFVQ315tnFU=;
 b=VcNIDiaiM+l3bjRZbRUXqYFiV6btCpjp4NU77KapZLeOR9wLLh9uoV7Uk4N2EfKwAHkE9b79yQgbrVa+zEYf2JYEWFAN+QRChyEFWWErjNkyErfSk+zia90MJ1GFj1fHX/Z5rNZ7Fx6UlABNNIWnqbxdz3MHQdSkCh8WeFguULg=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Thu, 8 Oct 2020 02:37:27 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3455.022; Thu, 8 Oct 2020
 02:37:27 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Remove warning for virtual_display
Thread-Topic: [PATCH] drm/amdgpu: Remove warning for virtual_display
Thread-Index: AQHWnRNyUF09V8FUL0iX0QQwiBgS+KmM/UOU
Date: Thu, 8 Oct 2020 02:37:27 +0000
Message-ID: <DM6PR12MB4340EE7D2DADBC48E1963C9EEA0B0@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20201008013515.769531-1-Emily.Deng@amd.com>
In-Reply-To: <20201008013515.769531-1-Emily.Deng@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.228.232.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 316882e6-ef9f-4186-a4bc-08d86b3318d4
x-ms-traffictypediagnostic: DM6PR12MB4041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4041E7FBB9EF9180589CCFF9EA0B0@DM6PR12MB4041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S0VrWE0WXsPBAfpgCjTOJUbH0gX6DYXu/lNTqqTPQIUNKz8mYdfYGOy1kgbeRnNM/xlMxDMh3cb1j+onkaPwZnHlV6m42nNANUzCN1qmNBkIbgFwqTWxkr9es5WxelA0e3GckRUbkIedhymwo045VG/S/jjW1uB1iZBM/7YS/w265x7Dtu0obc9OtjykvM05zfdie8KUWfTLA8oO938xrn93H/P0fVdkQE8ImXYgIjXu5dcCwxMnEgRQqbBoEYJ8ZEFyhwVvcKVnyrYgGR2RLpP6FDVk0TvuuITyX8xFTtvolCPUoSZ+hi+Yk/YJQEmByCAxFdrFQ5PJE2ATNSJz8TMle5zEzSh46ovOPNq3c8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(8936002)(86362001)(8676002)(5660300002)(53546011)(2906002)(186003)(55016002)(6506007)(316002)(110136005)(9686003)(966005)(66946007)(66446008)(76116006)(66476007)(7696005)(166002)(91956017)(64756008)(26005)(83380400001)(478600001)(52536014)(71200400001)(33656002)(45080400002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nviaRyducYkpCaYZIjBNRq3w6LyNRZcJMfdht2bgc9JdiQygEXp3DazPmqqU86ruZVMYUmj/T8LMAyUDLe373xmSH2/kwk44Z5LdLnqSI+pmUufkDuxzIWCPpnM4zSO/2oNc/CbzUl5MsRC/MJK8XywyJaJCUjTvYIjEnRThiBq+I1to5dnIjhrOKJbZoNm0gRv9Gk8E5I5DA74L2MYS3f12+KXVNs19f9AAfX2+fa0DNlWMUEfaed0kXpeiSj/s+L1ShbORbjr6oGSe2bF+T/a6NOzyZtgxdyjHuTxUtt4XCYS5cWaUavAk3jUHI5kNg0hsRmT25JGpfB904KIK1gCJkKcHa/5TnQqtleBEa69UzEu6aBtigjo6W6gJeiV+QYgrj7B6f0Ssw0NRQ6SkVrqepXhA4aIesNZU3A5nxagi8fGLUhbsMOzTW60YH0z77AO47EfY0VEw0EZ1UuXnLVd4jDICb4bE/kdNyDwr/VGDUx2e551/IOmW9hRsXvbdoRri6w55Nlvf1TUR9pk0razlhOlp5g0b2HEBYnkPfYZgjwQ9KVBBlmTu+UJW2yyHbEVO3APbqyG3A4Vh2XGW42H0juty8AIqPTsWFaE4X9lD/cuscTn7yCI+5xYrDGx8YmUwBL5QsbntJ2gYkun0xA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316882e6-ef9f-4186-a4bc-08d86b3318d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 02:37:27.6211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C32Owb1KbXf+7Su6zbabOsNEY709yfI9QU3TynrZFoM+cI6dUZsmf+fODo/tPojki4bqi1YnMvjdjWheZYUi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Content-Type: multipart/mixed; boundary="===============1167998715=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1167998715==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4340EE7D2DADBC48E1963C9EEA0B0DM6PR12MB4340namp_"

--_000_DM6PR12MB4340EE7D2DADBC48E1963C9EEA0B0DM6PR12MB4340namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by Andrey Grodzovsky<andrey.grodzovsky@amd.com>

Andrey

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Emily.De=
ng <Emily.Deng@amd.com>
Sent: 07 October 2020 21:35
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Remove warning for virtual_display

Remove the virtual_display warning in drm_crtc_vblank_off when
dev->num_crtcs is null.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I755150a32478d8c128eed7ed98a71175d2b3aefc
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd=
/amdgpu/dce_virtual.c
index 52d40b5e14db..fcf61d94fbc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -189,8 +189,10 @@ static void dce_virtual_crtc_commit(struct drm_crtc *c=
rtc)
 static void dce_virtual_crtc_disable(struct drm_crtc *crtc)
 {
         struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+       struct drm_device *dev =3D crtc->dev;

-       drm_crtc_vblank_off(crtc);
+       if (!dev->num_crtcs)
+               drm_crtc_vblank_off(crtc);

         amdgpu_crtc->enabled =3D false;
         amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Candrey.g=
rodzovsky%40amd.com%7Cfd5676290dcd40dc951b08d86b2a6ea1%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637377177905980484&amp;sdata=3D7k9NLDRoiOFoLTxL%2B=
S2gHaIs5cQ7nNmch5onjEm9nnU%3D&amp;reserved=3D0

--_000_DM6PR12MB4340EE7D2DADBC48E1963C9EEA0B0DM6PR12MB4340namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Reviewed-by Andrey Grodzovsky&lt;andrey.grodzovsky@amd.com&gt;</div>
<div><br>
</div>
<div>Andrey</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Emily.Deng &lt;Emily.Deng@amd=
.com&gt;<br>
<b>Sent:</b> 07 October 2020 21:35<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Remove warning for virtual_display</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove the virtual_display warning in drm_crtc_vbl=
ank_off when<br>
dev-&gt;num_crtcs is null.<br>
<br>
Signed-off-by: Emily.Deng &lt;Emily.Deng@amd.com&gt;<br>
Change-Id: I755150a32478d8c128eed7ed98a71175d2b3aefc<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd=
/amdgpu/dce_virtual.c<br>
index 52d40b5e14db..fcf61d94fbc8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c<br>
@@ -189,8 +189,10 @@ static void dce_virtual_crtc_commit(struct drm_crtc *c=
rtc)<br>
&nbsp;static void dce_virtual_crtc_disable(struct drm_crtc *crtc)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc =3D to_amdgpu_crtc(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D crtc-&gt;d=
ev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_crtc_vblank_off(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;num_crtcs)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_crtc_vblank_off(crtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;enabled =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;pll_id =3D=
 ATOM_PPLL_INVALID;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Candrey.grodzovsky%40amd.com%7Cfd5676290dcd40dc951b08d86b2a6ea1%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637377177905980484&amp;amp;sdata=3D=
7k9NLDRoiOFoLTxL%2BS2gHaIs5cQ7nNmch5onjEm9nnU%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Candrey.g=
rodzovsky%40amd.com%7Cfd5676290dcd40dc951b08d86b2a6ea1%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637377177905980484&amp;amp;sdata=3D7k9NLDRoiOFoLTx=
L%2BS2gHaIs5cQ7nNmch5onjEm9nnU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB4340EE7D2DADBC48E1963C9EEA0B0DM6PR12MB4340namp_--

--===============1167998715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1167998715==--
