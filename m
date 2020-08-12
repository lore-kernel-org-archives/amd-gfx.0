Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C80C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 20:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6568920658
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x8oMJ+Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6568920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0FF6E1B2;
	Wed, 12 Aug 2020 20:41:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9546E1B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 20:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFg37R3C2+TRy8SY+TJVqKL+O9j0MRbry/Fp/aeMNNEANqMvmkltUr5Lppi23hr3/1CkTspgu9K/mii9eKtp8tD0JifWxgiPQjIScJO33nxl3ulgS+vxh+ESyFo/2WxGVhaTo3ko9ZZ12SdcK0Iq0DyQf+1fm4P2igpl3cpcPuabvSiKG9K2WFQWs45DTW5+VNFKb8oeWNm2FMXYI40NDVByQhXBbkEBKioKnAu/VxCTWqDaoiZ6VqfuVdgP4qlMAjKMMUPFk9hlatkenJV4anmiQD2uDkJF+vW+KDA+p/No7qNNKXdchtqllWnfjPehcFxSle0pUClZWffNU6hD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiBv/AgwPfJObqUYD7WIpDOI1lTbUA/x+EY29pBfxSk=;
 b=fHUGwsVFqE4ow+USOTmngFivZ+YcPF9x+P9wLfJl/XQNW/+lUYrTd0Y6Zs1k3hWfENWqVLMLmZbUlKVz100oxqVz/AotiaID7HwmiCZcgm5csa6ALDYRF25tYnvJAczRwRuLRYSek94oX5s+PuYQcIGovYDkChMS0+I8eCJmJ87ISOwXqqtuZDhE96JXPNezsdZL+65So3gtARW4epQWa4faasjcyC60wlO0ePRpprAVqkQFjzgxh439FrP2oFoK5zx7ujm066QBc4PSDd4jyuRa14iwIXl494NRRUKTxdT4f4TcLq5Mbl5GIBHVXXB1bnt6jU7RB2bQJzhx9yV9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiBv/AgwPfJObqUYD7WIpDOI1lTbUA/x+EY29pBfxSk=;
 b=x8oMJ+Tm44qANjauNp/uMJZ7HBAkyaX8CSghgxhV3mamiJBHIFULEGkREp2afFUiDVla2N+NMYZqMh52fHbWDZ/vVErq7kmWZFfwCQD27VWKXPZVPL15sAE6TzpK1GPaO/rYiEdFcB4Yn4muZ8Rlqiepo6Gs6to5Thgm8RaihDI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 20:41:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 20:41:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: load ta firmware for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: load ta firmware for navy_flounder
Thread-Index: AQHWcOWrON2WCXJKq0upsga69+O0pak08APy
Date: Wed, 12 Aug 2020 20:41:36 +0000
Message-ID: <MN2PR12MB4488CE56FD5F58C5BF83B7D9F7420@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200812201720.25242-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200812201720.25242-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-12T20:41:36.015Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1a397f1-3131-43a2-fe8e-08d83f001b6b
x-ms-traffictypediagnostic: MN2PR12MB4143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41438631B3457E9C47EB062BF7420@MN2PR12MB4143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nR97EjIOQ9tEXLLJf4LC4sqokAFcXW4TLRqqs3cCLDPxbs3KZNWTWinmszB7a3hVomoUNAKvY+zVjZ7DZzTW7LGH19grDLypU4tHAnJbM+AEBbxyK48zWW8WynP/4frAH+JBisyCSFv/PB7ZChu6oZbdC9uYpB5mIs6SzXN59lqYxtYvGTvC2CqwI2wsWv7srDk8vxI0TKh362e6t4ZOqwB7LKHLKkwg/mysGvBdd2LzqGrNkm/3LiZK1Fs3rPE28yBQJ3rB8k7ofN96VyUKHTGzvB8PmRmauo7sdrFRfD/Z2TSUpBT74tZUedwxwEjRHLCZ9NRf+DZC1dqMRWM+5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(9686003)(55016002)(53546011)(19627405001)(478600001)(5660300002)(33656002)(26005)(186003)(2906002)(52536014)(6506007)(83380400001)(71200400001)(86362001)(8936002)(4326008)(7696005)(8676002)(66946007)(110136005)(66556008)(64756008)(66446008)(66476007)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9DYvEp6G+XLeETo2zYzz7loeqR/MN6clkyELLT0gGoaypC0H5OiqV+ozIQCtbuqlNTHNhrdtaGz6jSHdUwwhiJyZPWvcM7FwAqSawE8A7/wOBkSbcgrBUv11IAV0EYK0gYYRDscxP0GLRIHuASYz6/FE1l9HQsHFRVbQv3n48AeW0V7HLtdiYlqRt3nGWxtwgYs2BKo9uk1cUBOEf2M8TTgy+Y4WbCV+95dkErtkJwGoCrZSEqt9N0NIKUrf6q1qRhHPA0Z61yF9bc2jnX7ZyvU9P9MoEXEStz7HxQBTglMpaL27421KkfEg3cJlhiARkdqbdhL1IBBwxAOmuXGNTiYsGcphLazESypUHCQxeJ6zGxVvhK0GM4TRmOfRonZUur9ZwJA8nzGbyfyJMlLoK8b9p8i1MFlgEWCAMp0GlzwjMOR2lP6JfZ/qFrsxcnpZIYyaDYK2OzW/PIsqpto6mhKQNJlhH3H8dl32JcneyfEoIbL5OFChYBKLSkMDviUFrkuwkRgH5dYxDFsDiiHVnu6aHQ6QyOJLCxW6gOqqH1w5A4N4haDEr88xZPSYYEE0FQNvHQl7zp5wGrcIV9Jqw08WM/Ap7QA+Py3g9Ec1FW/4tLmKcVl54Jro/RNDNmo4jFFbzOkeokP2GCt4AtKs0Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a397f1-3131-43a2-fe8e-08d83f001b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 20:41:36.4721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LY1Bl940yvsRzTT8hf5rdtUd4QsNLjg6vGHp7V/fcgYZRxnvXeg4X+Ev8khUj2/umuNhjPNQ04yPLBAUIQ29w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: "Clements, John" <John.Clements@amd.com>
Content-Type: multipart/mixed; boundary="===============0396094501=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0396094501==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CE56FD5F58C5BF83B7D9F7420MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CE56FD5F58C5BF83B7D9F7420MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Wednesday, August 12, 2020 4:17 PM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.f=
reedesktop.org>
Cc: Clements, John <John.Clements@amd.com>; Lakha, Bhawanpreet <Bhawanpreet=
.Lakha@amd.com>
Subject: [PATCH] drm/amdgpu: load ta firmware for navy_flounder

call psp_int_ta_microcode() to parse the ta firmware.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index d488d250805d..6c5d9612abcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -58,7 +58,7 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_asd.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");

 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024
@@ -179,12 +179,11 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)
                 }
                 break;
         case CHIP_SIENNA_CICHLID:
+       case CHIP_NAVY_FLOUNDER:
                 err =3D psp_init_ta_microcode(&adev->psp, chip_name);
                 if (err)
                         return err;
                 break;
-       case CHIP_NAVY_FLOUNDER:
-               break;
         default:
                 BUG();
         }
--
2.17.1


--_000_MN2PR12MB4488CE56FD5F58C5BF83B7D9F7420MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 12, 2020 4:17 PM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.o=
rg &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Lakha, Bhawanpreet=
 &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: load ta firmware for navy_flounder</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">call psp_int_ta_microcode() to parse the ta firmwa=
re.<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 5 ++---<br>
&nbsp;1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index d488d250805d..6c5d9612abcb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -58,7 +58,7 @@ MODULE_FIRMWARE(&quot;amdgpu/arcturus_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/sienna_cichlid_sos.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/sienna_cichlid_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navy_flounder_sos.bin&quot;);<br>
-MODULE_FIRMWARE(&quot;amdgpu/navy_flounder_asd.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/navy_flounder_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
@@ -179,12 +179,11 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_ta_microcode(&amp;adev-&gt;psp, chip=
_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CE56FD5F58C5BF83B7D9F7420MN2PR12MB4488namp_--

--===============0396094501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0396094501==--
