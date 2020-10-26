Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A6C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4E922263
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e1UiMOR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4E922263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DA089DFA;
	Mon, 26 Oct 2020 14:44:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2507A89DFA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 14:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV5p477q11NODE88B/rUn/cLnEnB2ntchDOkDfLDppzTqNYLlJTCnZDSKvKTyNOVK+lrzQVUuyDvWwt2nsNPPwxiE0aS6fcSxjiAedK/IDZ5W4oS6mTPPEdPjhIix38gsVbuQr/kgr5QfIBZWRllpkrd38YFZsbDqsD5ZH/tkvQ3Jnr6V0T9fsfGw+361DSg0/h3njXs3eJMYh2N5HLAcn9twWw8Bb8fqO9kgt/YkcOlF391WMRoIPK3eW75pOi3KsRqn9Xb6o1c5dj2YLzr0Fi50mBHHRW8ZcbLO477MLdxL1NX0Mw3NAWS6EPX0QSQfYBYuw7ya8uh/0on/pJj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0EDljHDDOXwMVvwkvP5fAYsQYwSW8MnAOD4pTH421s=;
 b=lNrkEVI/yZIOJxKWuD5T2r5ldNiNlAlHG5NIrcxauA2hprDVrxD99Z9UFynQxzzpOkB6/cKYQ2ptrmuW+b/UtZQgbUQ3wvy5AxOK0YqW33PrqWW9F2sGzfEcaIE3ir3ao8wSQsW7y9PvvPgFJpyNrefmLlLrXNaJqTdvql9ephgQUDQriz1OspSCZ1E1elAeMx8G53TEndmr2IZ41T6qR6KfUUaFrE0OxIgqUZ4qaXPagkY/p9xRD2RHufPn/IDeySiCWjZvoJko9S+Vz05bqbsVu7xsi0oiBiZ/a9YBs+N++AxfHxOUJPuzkg96HVhbpactg7ofNH+Z53N6hzMSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0EDljHDDOXwMVvwkvP5fAYsQYwSW8MnAOD4pTH421s=;
 b=e1UiMOR+jp+U/YmE9/fX8NhSh0iB6PB50uH89aXHda2QiYYSIDt2FH3cokaqZGatYVS7zaQT0s489mDDzHZ8sD9wt10WHT43af3XpsQx6IKQiOh7BBjaaRxkbfycvmYWT49NTovu8Du5p4ErxvkQ1db6MNXgZ4Y3Qfdic+CO8xk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 14:44:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 14:44:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add vangogh apu flag
Thread-Topic: [PATCH] drm/amdgpu: add vangogh apu flag
Thread-Index: AQHWq5bcgn8wWFMRUk+kf9yKFjEQAKmp9cc6
Date: Mon, 26 Oct 2020 14:44:33 +0000
Message-ID: <MN2PR12MB44882982C0AF4CC9AFDB03F4F7190@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201026125152.460802-1-ray.huang@amd.com>
In-Reply-To: <20201026125152.460802-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-26T14:44:32.673Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b235f670-3298-4856-4352-08d879bda747
x-ms-traffictypediagnostic: BL0PR12MB2562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2562677124B5B41FBB51C271F7190@BL0PR12MB2562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qLgpvQI00F6VIcNm7ga85ONiO6Bd9Kf+lRMVtaJu0PDYk8TFHhen0ja5/cAQo9KZqL/tZxRYfORaJLCau0p5HvzNYxO1F7d9RkdCEbQ3ChMTURfCzTVhLtce0gT7r69et/cmKa/wh+NkJw04njLOkJu2kLIbG/lM1/gQDOqSzQDXOf+xzmJYasXkkUCfKT1HsywVDxRn3v9WrzVjGRdX3MR+o3c45eUtdMGdy7NzsPpvFrhckMfgYAYpzdwGpAHasqW506eFB3XX+bdLnt4hdE3s5wircDOm2BrXljKGFIQMhxWRUALz8GgBF2o0rYMQVJxGxxJvchvtaTaNmExVugyj0l5WLiMe0H6dNmgdeU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(186003)(9686003)(8676002)(45080400002)(316002)(66446008)(966005)(2906002)(7696005)(478600001)(8936002)(53546011)(55016002)(26005)(6506007)(52536014)(66556008)(76116006)(66476007)(19627405001)(66946007)(86362001)(83380400001)(71200400001)(110136005)(166002)(5660300002)(64756008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aoi/uYOgwiTiw/xJX96qAnaP2BouWz5mdPEgwntYUJXwtY+3Rc/n26j64t8XN6r948cIs0vN35D36HyqR5dKsilbv7k6pE7V/C6lAR+UjKwyAHCDkyom29/t5rRR2OkQRda6ATRgfQnWEbzFkqhavOT5b6q7pE5BLbuWWX/M980doaM6K+LdJxljxPX7CDFX1ACpN/C4L2ZfcIoMQF23YHiS/xt06F6yo/71Yh7LlGe+4U8xo9731RtEXJ4nlptJg+yhKlUwULQrGLdDkhVv1dco599pGUa2jZDuQ8uH07miJ2GRqOj8Lq2O5L2/IHIDA2pzdy7HAMivC6L+1JiWGw15EjhCVAR5SVIeN82RQEEKH80YVbhHGnmX70kvdkp3RhXVCTSJuNydbrkaBSD5kb8TEBiYtVKGeW4IifXfcy/556oZ7UBIrrXKmylNjVUjZoquVFcD8HFV7/I7/uIse9/D77Jk/DSJnHQZiOP3yViOJjQJhHdzbh+i22cxyS6vsBExvVP5Af+oEzeEJYQ6Ceayw3MgO+wBwo506muyd2SYqPmVnVGqd5bpcerLETcfMQsqlfAxbQ1bJtX5IJAtV88pUsoBWi/uTU1yFQcQMr6k0WBDau8+R1kYU2l1K+N85qY6q2eNLpAlj/L416roDw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b235f670-3298-4856-4352-08d879bda747
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 14:44:33.4513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOl4KZF1Po6aZKsS5K5atdCLg00VBATtKfbrO8hXgX4PBY0PyJEfKeU2jj6FE6GuQmD07XBYJhYhVvmgIVpBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
Content-Type: multipart/mixed; boundary="===============0274884090=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0274884090==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44882982C0AF4CC9AFDB03F4F7190MN2PR12MB4488namp_"

--_000_MN2PR12MB44882982C0AF4CC9AFDB03F4F7190MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Huang Ru=
i <ray.huang@amd.com>
Sent: Monday, October 26, 2020 8:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: add vangogh apu flag

This patch is to add vangogh apu flag to support more kickers that
belongs vangogh series.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c          | 4 +++-
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 30ec826c8760..b7fc9ebdf1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -941,6 +941,7 @@ static int nv_common_early_init(void *handle)
                 break;

         case CHIP_VANGOGH:
+               adev->apu_flags |=3D AMD_APU_IS_VANGOGH;
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
                         AMD_CG_SUPPORT_GFX_CGLS |
                         AMD_CG_SUPPORT_GFX_3D_CGCG |
@@ -951,7 +952,8 @@ static int nv_common_early_init(void *handle)
                         AMD_PG_SUPPORT_VCN |
                         AMD_PG_SUPPORT_VCN_DPG |
                         AMD_PG_SUPPORT_JPEG;
-               adev->external_rev_id =3D adev->rev_id + 0x01;
+               if (adev->apu_flags & AMD_APU_IS_VANGOGH)
+                       adev->external_rev_id =3D adev->rev_id + 0x01;
                 break;
         case CHIP_DIMGREY_CAVEFISH:
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 06c1aabf10ce..412602d84f71 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -46,6 +46,7 @@ enum amd_apu_flags {
         AMD_APU_IS_PICASSO =3D 0x00000004UL,
         AMD_APU_IS_RENOIR =3D 0x00000008UL,
         AMD_APU_IS_GREEN_SARDINE =3D 0x00000010UL,
+       AMD_APU_IS_VANGOGH =3D 0x00000020UL,
 };

 /**
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C997d0fa293f94eec44b008d879adfbcd%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637393135475905040%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D4zu%2FHsq0nTrx7NL4Dkqupaaet%2Fwzc40zzlXcYQXXbZU%3D&amp;reserved=3D0

--_000_MN2PR12MB44882982C0AF4CC9AFDB03F4F7190MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, October 26, 2020 8:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add vangogh apu flag</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add vangogh apu flag to support m=
ore kickers that<br>
belongs vangogh series.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 1 +<br>
&nbsp;2 files changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 30ec826c8760..b7fc9ebdf1c1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -941,6 +941,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;apu_flags |=3D AMD_APU_IS_VANGOGH;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGLS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_3D_CGCG |<br>
@@ -951,7 +952,8 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN_DPG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_JPEG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_VANGOGH)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;externa=
l_rev_id =3D adev-&gt;rev_id + 0x01;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 06c1aabf10ce..412602d84f71 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -46,6 +46,7 @@ enum amd_apu_flags {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_APU_IS_PICASSO =3D 0x0=
0000004UL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_APU_IS_RENOIR =3D 0x00=
000008UL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_APU_IS_GREEN_SARDINE =
=3D 0x00000010UL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_APU_IS_VANGOGH =3D 0x00000020UL,<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C997d0fa293f94eec44b008d879adfbcd%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393135475905040%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D4zu%2FHsq0nTrx7NL4Dkqupaaet%2Fwzc40zzlXcYQXXbZU%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C997d0fa293f94eec44b008d879ad=
fbcd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393135475905040%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3D4zu%2FHsq0nTrx7NL4Dkqupaaet%2Fwzc40zzlXcYQ=
XXbZU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44882982C0AF4CC9AFDB03F4F7190MN2PR12MB4488namp_--

--===============0274884090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0274884090==--
