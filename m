Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0299C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BB120771
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aYommeG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BB120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB8C6E366;
	Tue, 11 Aug 2020 13:33:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CBC6E366
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYPNOarshvBoMlyzmin3msXv6Av3ikjb+mt6G7ZZzkCUvrvmVdPzbZZqBjP4++tU63CSgoyKb+QzWRib70mKGc0ePp8RgeHE5xTq9/XCIQaSD6lP6XpjYG8+FHp5iqW4E4xxfWM9T0JcNp1HtJh14Ekq4mL6iuEXngLszJ8I2q1llTRsUDaytmW5cFlkpDS8l2V/Vx5nFzCK/JEd0lcpMEOslgJ/CTBdkdVSzEpVzYypa8BDNkTFC0UzWedXym0TrCvOj5N8HeGcyvKy1cefMXQEVeS3WDo6HeAUm1M2BDDPs6yb6uXxS7RlknBYI70v2Ti+P1g0JU+63XGGksPVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKsWlQd7m3WZHnBfQGKqLae40lQsX7JDnZfIEpbxToE=;
 b=dMe920hhk+EeMGtVycLOXBoWp7kepVoc4eNOWlccAvnwuJW5H4qT/Do7lm0KGzPNVyPixmLMCO1CqbK35Vz4iMOx5CYXPxpMjbv6fWIOpMxW7sUFY+OL1KuTOY6OqFbMtmQVxhUALYw0vIErWG13NDNyqv+Nv6jROn6LjTtkzKdwlrGxrxXZb/bYov/UauW/ZSCevlPASAgX2itWyQz6iZzb77dKVgw+4qoSq9o3S4lAeHY9EfhVApKNnUDVDPc+sabv7mR3GZr8L/Gzhyhb5hE8tGl/iVxi9/u4IDbok8SNqXT1SXPhFoMfu3sgvYMpOgxyPJxv/7bB9Qm2uJTNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKsWlQd7m3WZHnBfQGKqLae40lQsX7JDnZfIEpbxToE=;
 b=aYommeG44ISdu6JYJDzfY7OL9kE/AUOZ8qhFojufOi1y1H6HI6MUxXMi+qozh0ANzQIMG2WuvyztT0+fhTfzbO4LYjnC3OwSpngihXnRgcV684b4UomY/sCfCnPalL3IDOZj79aM9jyAn/eyXnYKxaPJNls4veS9C27BRpUOpEs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 13:33:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 13:33:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: fix the wrong sdma instance query for renoir
Thread-Topic: [PATCH] drm/amdkfd: fix the wrong sdma instance query for renoir
Thread-Index: AQHWb6iGiPH50dtQv0yf+q/I5m0RJqky6FXb
Date: Tue, 11 Aug 2020 13:33:02 +0000
Message-ID: <MN2PR12MB44889F3A0A27115B276BF95CF7450@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200811062716.2927620-1-ray.huang@amd.com>
In-Reply-To: <20200811062716.2927620-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T13:33:01.728Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0172d35e-3dd5-4e5c-0c7a-08d83dfb122b
x-ms-traffictypediagnostic: MN2PR12MB4032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB403202CD5F5DB7258DCD8ACCF7450@MN2PR12MB4032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pm3bdLIPLUiJDWyMCKZNHo5e0BnLkb5REgtNHV6G4IgCaMu7gc49LAgVHuzbYPP3X/lEz6Ri/VHHlKc0CT4JrqayTtPNbaatY1QcRqaOsVMIjj9G3gAJHs1utNVgkDIiFv5ws3Y2QUGRjFgEzkVar9s2asEPOXWXGqpAg7AR1U4hVEwArb63qJYanUFe4IF/TcwYi4fWKVguDp/N7gALucuWbOkYUvotKK5n3Nvye6rJrbHgiy09Yh1UBobRuiOLyxDsirlOKtrFNX0+Huneqsxlyc7ylaB2H9GER5rnA8LnyU8HRQx37Dd9cNS+qHJ8vQhB300vLiju7z6bDXpIpjW/1t95WsR6+7j1xBH7Lx4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(186003)(7696005)(110136005)(26005)(316002)(966005)(166002)(33656002)(64756008)(66446008)(76116006)(71200400001)(66476007)(478600001)(66946007)(83380400001)(66556008)(53546011)(6506007)(19627405001)(45080400002)(5660300002)(2906002)(8936002)(4326008)(52536014)(86362001)(8676002)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0oLClQedmkD3+ix8GJ6bcepQqTCgUOWKkdWsbfVxZ9WBtLdX9eT+4sGmxehVStEOpgCyoQM/9jzuunPzdCM4tyn4vTZHQsvgTf1S8tMRn0OI4U9V11tqF/CfjguEIGVNSP6K1ZW217CtNhLNzROc/xOPkmgYmRpNgLdSVXF8w7HTgByQxkauTNP1wOarWA0N6bsokNee+3bD3CLFPnqU79njDy3KHgMVZxJmglArQ8G5msp9KisUg77XUiUs+0hIe0z2Z9vKkxVaQzJ2jwXdUI1GPfk6LcOWrCUAjpya4b4NaRGCo8d0DinZcYVRYNVOaxxLOIB5tGt7b9qs9L8CkqAaijUqUhojnO1q+ZNyypbOyjJxERiuID9+Q+eVvE4IsC91CbYa8AiG8vu5TILQebXrvg+fzzaYQ3cIdbZTPGOq0AXi6zr/89+JyooD0UdtB1smqS1I/ePaowJXE3ytyAi+4JWV6YLguP3Hlbh3DCJk5epjA0J9TI+93L1UhoDAUv0elcPqDxz2GPcH/881twKLvVKu7zeihsKOYwVPpBeFW9ZsJSpILmq/O84dA8u3ogxx3yWrAYtE9OiH0SJUcJJbx6exwwrs8JjFfItkXRRIDWeU5tvAlkOHHm/99ccn0GxKyCxzZcLiOIntRca2tQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0172d35e-3dd5-4e5c-0c7a-08d83dfb122b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 13:33:02.2965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ik8ONC7ZvWngmR+UiYubt0TdQnWxYJ2UbW68GDj3GReNDkfyuiAc30AP43jJfNicXTcNfG6dZYfkcJxTtBCMkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============1823682697=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1823682697==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889F3A0A27115B276BF95CF7450MN2PR12MB4488namp_"

--_000_MN2PR12MB44889F3A0A27115B276BF95CF7450MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Huang Ru=
i <ray.huang@amd.com>
Sent: Tuesday, August 11, 2020 2:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Ray <Ray.Huang@amd.com=
>
Subject: [PATCH] drm/amdkfd: fix the wrong sdma instance query for renoir

Renoir only has one sdma instance, it will get failed once query the
sdma1 registers. So use switch-case instead of static register array.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 032d3c866280..23ccfe0ad5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -197,19 +197,32 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu=
_device *adev,
                                 unsigned int engine_id,
                                 unsigned int queue_id)
 {
-       uint32_t sdma_engine_reg_base[2] =3D {
-               SOC15_REG_OFFSET(SDMA0, 0,
-                                mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CN=
TL,
-               SOC15_REG_OFFSET(SDMA1, 0,
-                                mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CN=
TL
-       };
-       uint32_t retval =3D sdma_engine_reg_base[engine_id]
+       uint32_t sdma_engine_reg_base =3D 0;
+       uint32_t sdma_rlc_reg_offset;
+
+       switch (engine_id) {
+       default:
+               dev_warn(adev->dev,
+                        "Invalid sdma engine id (%d), using engine id 0\n"=
,
+                        engine_id);
+               /* fall through */
+       case 0:
+               sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA0, 0,
+                               mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNT=
L;
+               break;
+       case 1:
+               sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA1, 0,
+                               mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNT=
L;
+               break;
+       }
+
+       sdma_rlc_reg_offset =3D sdma_engine_reg_base
                 + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL)=
;

         pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id=
,
-                       queue_id, retval);
+                queue_id, sdma_rlc_reg_offset);

-       return retval;
+       return sdma_rlc_reg_offset;
 }

 static inline struct v9_mqd *get_mqd(void *mqd)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C575d3b20ab90469e7a5208d83dbfa612%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637327240654534583&amp;sdata=3Du%2By9MwOEH7bGIQbaj=
nefKann2HyJ%2FWRG6I91FBgVakM%3D&amp;reserved=3D0

--_000_MN2PR12MB44889F3A0A27115B276BF95CF7450MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, August 11, 2020 2:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Huang, Ray &lt;R=
ay.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: fix the wrong sdma instance query for r=
enoir</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Renoir only has one sdma instance, it will get fai=
led once query the<br>
sdma1 registers. So use switch-case instead of static register array.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 31 +++++++++++++-----=
-<br>
&nbsp;1 file changed, 22 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 032d3c866280..23ccfe0ad5d4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -197,19 +197,32 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[2] =3D =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_=
RB_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_=
RB_CNTL<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_reg_b=
ase[engine_id]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base =3D 0;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_reg_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (engine_id) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Inva=
lid sdma engine id (%d), using engine id 0\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine_id)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* fall through */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA0, 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNT=
L;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA1, 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNT=
L;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_reg_offset =3D sdma_engine_r=
eg_base<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_=
CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC registe=
r offset for SDMA%d RLC%d: 0x%x\n&quot;, engine_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id, retval=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; queue_id, sdma_rlc_reg_offset);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sdma_rlc_reg_offset;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline struct v9_mqd *get_mqd(void *mqd)<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C575d3b20ab90469e7a5208d83dbfa612%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637327240654534583&amp;amp;sdata=3D=
u%2By9MwOEH7bGIQbajnefKann2HyJ%2FWRG6I91FBgVakM%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C575d3b20ab90469e7a5208d83dbfa612%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637327240654534583&amp;amp;sdata=3Du%2By9MwOEH7b=
GIQbajnefKann2HyJ%2FWRG6I91FBgVakM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889F3A0A27115B276BF95CF7450MN2PR12MB4488namp_--

--===============1823682697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1823682697==--
