Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F086C433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE7622365
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xniFB7XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE7622365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2424E6E149;
	Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D3A6E149
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 13:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkKhWs518z786ICGOEpKax/xOVSsc0TLL0A7B1VnBKOIG+bNN8kx65f7oex+/rl1TR9ZqqCaBir0/r6HiHRpeib9ctDjp0wqiWdvUhleZd5oQ7iiIV6o5+d81V0wfFSlfXUnIRrPmeOh1CoNlOJ/LZ0t85EqHHxrAqKlXfeNoqdi2VI5Oso2Cm9Lb149WQFhxXyK2BZyoGFWyN6QQcinziM0vJF3Io6XzNherGHcK3mfFgL+IpZ9qhjrtgkfvRmnTCGZPqQyqYCL1ygPC1350i0+QfJHHsvhLPkIUDwu28UJZHQshba/J8LlD/KvqYkoQL9ENINlHg5hWOEEDHJoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJyrUXcnXtKk/SJ1elvK4+TE7muYVN9cJxyTI4ZBJeQ=;
 b=cPFVxvc33/RKpqs56PtTcTyzaXsZvYImgMKvgicxJ8/N7GlP8zt2tcFodBrISJ5k8CIfzIMPHM256JqFxCQOT0udR/8dGxBszyrD8c5CV4y9BKO/xNhBZY9o+Xi2w/Ayww31gjxhYMGGhSY8f/YTmLOIWbrPRIX//5WJ8I+aSUucwmoNUmsT7TSLEgFVQHD9qaho+AAT/HmHcxNU1WQ8l+ay9rFSyB4UdvVm5M4l0iMs1Jl458bqXzTF4yxGILgchkK7TLhWkHI62g8mH8Yq+MDcXncHQ/gZALecwyerTr805DFffTY+b3j3CADkpoNaFCdyi0BnAVZ2C6zBzPf+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJyrUXcnXtKk/SJ1elvK4+TE7muYVN9cJxyTI4ZBJeQ=;
 b=xniFB7XDfkOyIcdHSH5JuX1F+ERh/Ujyv5ZOqj2CpO4YGr41qoviPfIxv8FyUomx+VSlaNLZ1BuXDmdtE4fZkmERSuHTQj/Pb+HjCFqkMv7zbsAcF1uwZKjNRPRHWY59uHlXH6slHNWRbWxBCrxfr2OTOZMiKZCaGRS6BVi2pyg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 13:45:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 13:45:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amd/sriov skip jped ip block and close pgcg flags
Thread-Topic: [PATCH 1/5] drm/amd/sriov skip jped ip block and close pgcg flags
Thread-Index: AQHWWYj3XLy1dMzQJEKgez6+KnokcakHFsiX
Date: Tue, 14 Jul 2020 13:45:04 +0000
Message-ID: <MN2PR12MB4488058692A9643DEE9DE51DF7610@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1594694757-7620-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1594694757-7620-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-14T13:45:03.876Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25ff82d4-190c-4a33-587e-08d827fc1cfc
x-ms-traffictypediagnostic: MN2PR12MB4013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4013801B90377F474A29D73BF7610@MN2PR12MB4013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Ri2yRmK7CMz5qQ21ENMFni+i49Clu4JcFhdw37OR6oMCrBkeWs5VebUTIihgQF0I4R5Q3l/ddeljqBlFcR7qmBEkF71QVCVlHTukjG+iQW1dd8uYDgjxaSLkPNjQJV7tkYUZwNagFIaxodNL/+QpLd3tkawJgQOzXRaDgr80cXjjsywENsfcGDZerURzsf4xBLgLuGGiRscSEAFcnd+6+QZcXOMFiMrQ+HBsdndRk1Skk4rj1r62Bt/cSaAS+BUgUtETHAqk0CLejkb0ShUfAwDXKZkpEolt0r7kDnCViM3A78Pkb0B26SrXDkYAhqpovePKQvSyD8La8Quj30OUfb24TTzWLycNJTbaxuS434=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(54906003)(26005)(55016002)(8676002)(71200400001)(4326008)(33656002)(478600001)(19627405001)(9686003)(45080400002)(2906002)(76116006)(86362001)(53546011)(6506007)(52536014)(7696005)(966005)(66476007)(8936002)(64756008)(66446008)(66556008)(316002)(186003)(166002)(110136005)(83380400001)(5660300002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UR3pyLg3C/UzIrCYaOOJnohKjG2ehWgN7rrXhUhfRQxEVXUV8JyPe5T7IZu9N93d7yhOZ4Ana0ORPEnRTm946OENl090S8m898gAXCGzmuotn6jzuFEwJGq0cePHNJTs2iLsO87Sx7Jfwe00m3gDhsF02SIokpsP00EKw8QSXs/cNmzP4V8zJZe6qF1P4CDtCIfiv976Yh+sEOrWY6POGxYfIVk+/HbPV8TYLplo/vfiyeoZEWy89L/ABAA5A1pALL1MwRM7vBn7f2HYERxyUSCTh7uchZsw1HoVelS/UKI2EHTEayji4zym0GALJWFu4kr+0d1o+0LQTK0oUddVm3j/T4lgAUN0xczXl8aVrLOIZINo6IFWJ7qXu8zUPTPsde+5NCrRsB+tNbKgEVa9K1/Cdmp+SeYIH1d1suugO4vOuIIbjqQJCFFU7WCVjQ6t0COkIXBcAvvuAfS09nJUvCOnjyxt5MTbP0ADi5kk8gn9YKU14AF+tpbCveQNXBic
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ff82d4-190c-4a33-587e-08d827fc1cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:45:04.4118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pquz8t1bA6tXxipYXZEnEi/kSXmLcDsP/1uXzh20lJw8IB3DRlsqXFFIjYpBQ+NVaSpX81nqgq5DR+SGQ7CEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0695615023=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0695615023==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488058692A9643DEE9DE51DF7610MN2PR12MB4488namp_"

--_000_MN2PR12MB4488058692A9643DEE9DE51DF7610MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jack Zha=
ng <Jack.Zhang1@amd.com>
Sent: Monday, July 13, 2020 10:45 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amd/sriov skip jped ip block and close pgcg flags

For SIENNA_CICHLID SRIOV, jpeg and pgcp is not supported.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index a7cfe3ac7cb6..7f34a2f25700 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -504,7 +504,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
                 amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-               amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+               if (!amdgpu_sriov_vf(adev))
+                       amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_bloc=
k);
+
                 if (adev->enable_mes)
                         amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_blo=
ck);
                 break;
@@ -732,7 +734,13 @@ static int nv_common_early_init(void *handle)
                 adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                         AMD_PG_SUPPORT_VCN_DPG |
                         AMD_PG_SUPPORT_JPEG |
-                       AMD_PG_SUPPORT_ATHUB;
+                       AMD_PG_SUPPORT_ATHUB |
+                       AMD_PG_SUPPORT_MMHUB;
+               if (amdgpu_sriov_vf(adev)) {
+                       /* hypervisor control CG and PG enablement */
+                       adev->cg_flags =3D 0;
+                       adev->pg_flags =3D 0;
+               }
                 adev->external_rev_id =3D adev->rev_id + 0x28;
                 break;
         default:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C78d9223013c74c21b2c708d827a01820%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637302915854056774&amp;sdata=3DZ6SAzQ%2FKFcyJb%2FL=
PN3iUIBnqyacMeWG8Pjnu2LfioW8%3D&amp;reserved=3D0

--_000_MN2PR12MB4488058692A9643DEE9DE51DF7610MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jack Zhang &lt;Jack.Zhang1@am=
d.com&gt;<br>
<b>Sent:</b> Monday, July 13, 2020 10:45 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; Liu, Leo &lt;Leo=
.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/sriov skip jped ip block and close pgcg=
 flags</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For SIENNA_CICHLID SRIOV, jpeg and pgcp is not sup=
ported.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 12 &#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 10 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index a7cfe3ac7cb6..7f34a2f25700 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -504,7 &#43;504,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;sdma_v5_2_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_blo=
ck);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;jpeg_v3_0_ip_block);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devic=
e_ip_block_add(adev, &amp;jpeg_v3_0_ip_block);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;mes_v10_1_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -732,7 &#43;734,13 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT_VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN_DPG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_JPEG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_A=
THUB;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPO=
RT_ATHUB |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPO=
RT_MMHUB;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* hyperviso=
r control CG and PG enablement */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_=
flags =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_=
flags =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id &#43; 0x=
28;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C78d9223013c74c21b2c708d827a01820%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302915854056774&amp;amp;sdata=3D=
Z6SAzQ%2FKFcyJb%2FLPN3iUIBnqyacMeWG8Pjnu2LfioW8%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C78d9223013c74c21b2c708d827a01820%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637302915854056774&amp;amp;sdata=3DZ6SAzQ%2FKFcy=
Jb%2FLPN3iUIBnqyacMeWG8Pjnu2LfioW8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488058692A9643DEE9DE51DF7610MN2PR12MB4488namp_--

--===============0695615023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0695615023==--
