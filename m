Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773BC43467
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF5620709
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2NoLnQ8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B6A6EE1E;
	Fri, 16 Oct 2020 15:27:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE046EE1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 15:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4I4m8380vPCSHkUkMoQlIgwJoXKbfdYwLzGzvuj42TwRZPOY2Dx/2CRtUY0yAaZy3JFj59ss39I600wJ/p9dcVljOAYlqXOgii83sjsBOFtoM+hCgboPGZD556uU0S+dOtAPQmukxn2T7lNf7mvqjVq/tZDFE8O23EUxroTnNC9UlXH2wuFxOKfHZRXZbJnrBaPbZn9ZaeC9nGn8TewqOjBbgwhEfJjpNdKlyQtCbBIVueSNsta05gVsbnpYhPejcgBx+0wQMsriMCsnLDxF+81m+CgFRm+dSj+0gsV6PfIS4bBzQFRBYGH3HWJ/1r5eS0YhEUK33iEi25wf4FDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyVHt2+TF0EKZs7kDGBWkW+mKIDHyi1SBnZWDsiFPo=;
 b=E0eDyVjajjIFae2OcMzEFNK8Tzf0SztoAGfvvq2cG2iGF/kGG2hTCyGqq98sfpsRONpdXCZoQc4DPcoydeOaF79B/9dpqkwWSYS58NVdDeFuq8bkbJXgIvJiRFCPqO/y/w8/EeAbCGFfaKWXhrAbD9VRo4gepk580UH6iBMVjFlKh2rNX9rHAOX5rrX3v0r9niif7UlFXmTZIug0Ukd+shkL6zV66Q4XwEBDJd5oTQvGhKq8vKlHFBCNJ+Uwp7PXNLh3W4ttgYInUEmA8AGmk9ZELZaTdCZ/rytc+aEC6m4vhYGox643IOCuxrgRVRJ1w4oGRnGsen7oKCxzO8bnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyVHt2+TF0EKZs7kDGBWkW+mKIDHyi1SBnZWDsiFPo=;
 b=2NoLnQ8QNLr1JsHu9QrA8p5R0E3iLLEq5oVrVXyuD+GQO/uLSOyToEx1oONhdMZWXNhuZ/mmBSgwyAo0eY1CCZQcm8PACLKI0gNxHL7ZZFlw3X7TeeJfHuKQLdNcEiypknoSRJ9KZ9dx4FlbKhIGa1NJ8M8Wvjt3opx2t5li/Gc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 15:27:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 15:27:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/psp: Fix sysfs: cannot create duplicate filename
Thread-Topic: [PATCH] drm/amd/psp: Fix sysfs: cannot create duplicate filename
Thread-Index: AQHWo8v4wSIg1IF3EU+WMZyAx5jRxKmaWfsO
Date: Fri, 16 Oct 2020 15:27:30 +0000
Message-ID: <MN2PR12MB448800E3DF6CA570D65C0E2FF7030@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1602859937-30214-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1602859937-30214-1-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-16T15:27:29.870Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d2fcbb0-01cb-4644-bad2-08d871e7ff3d
x-ms-traffictypediagnostic: MN2PR12MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3742549A124C6141A73F2286F7030@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SqkK2vXP4xLtm8//QQkz1kkREWXE2WZIXo/pdraKnDFrfhCg6pWYLLYnlT/hWtS9Qr/Wol50gdyZAxxpzVPH4rUvaWoyYumkRGoA9Ulfdaw7l9XnBFYPXAcjoQXrA1jrACBcMIjE7vrWDDh9nhRYwMy58/Yy8PahrMqbbXwhOCkCGlIyNTcJPCcEWS2vaqnlLSV+Tnrcn09nZMonM8Lz9gvWYu63MXZaIseP0PPBfv3QjSaKcEZ82Mb7WMXtcqSVNe7BIlqPL4g8qI5iIVYPJOxjNS5rJxGZ0TPDAgZIE8NeYWWgNm44pnIqmdy6vXI6Fm8jK/MCEFwSwZz1lXwTJfX6VzZ4v/Xy8o0Vanm72HE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(8676002)(53546011)(83380400001)(66946007)(76116006)(6506007)(26005)(66556008)(45080400002)(66446008)(33656002)(2906002)(186003)(64756008)(66476007)(8936002)(5660300002)(71200400001)(4326008)(478600001)(9686003)(316002)(19627405001)(966005)(7696005)(110136005)(55016002)(52536014)(166002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lNSQWLp17tCRbFjSgu7sL5AHxuIJNmDtbyAmG0dwk0K/4AvAYrCdUZjWtwQs63kO2ozimta1U5ELO8q3ObTEKPy5XA+vTCEzlb/5Ln2Za4XTqm13Ugj0NPEuPz4xFpnhNiDQn3RKgrbc9XaAmpdOjbClrF3pWnn8FFwvdHTUfGw0JSsicTY3RPjxFlQmLUED/lYvpaRMmZ9qncPfgK6dqeUnqavdeOp9N9Qxdc+RS0u0WU9v3DV/jzzWa+spPAxRPRAG1Vff18uBAW4XV4MRatDa/Lngs0hmMNDKRnN58ndcqBFu1rktqg1et2MVocljqT3rveHWxC0OJel3lNO9SSswk4KPCg/q8WPDNK3072pwT2EBrrSZ2fDDepVWkwGrUpi4DUbrqnXsCCtLOzwBJ+MVLa6hr80suyUGTl3MoEmAVmRpJxaTNhyNlgOI97Hrfk7o097vojHLBSUgZcw106I18u+fmzadr4HyjX5AfFmZofIij3iawjX3nVz2nKG+WXatvXIqcFLK2AQm5cyTY3Acvx2B+jSjum1tdwZSIZ3/DlkgmgYnWql4GEkp6tpUKibDNhDVFwbxvGtEouI7jflZdFejTLYgnS+wjVgZ/YF5KC431tmyf65WbNcacM07UhH6U6rHJeyL8a5fAH7DiA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2fcbb0-01cb-4644-bad2-08d871e7ff3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 15:27:30.4971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH2nQI5IztXu0MZNGhaxgKf7mpiDYzYo5WCLTysuk23eT4CLEYTmx/4na8tj4LqbNUS8T7yGEPav0nLu+7u1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============0859182107=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0859182107==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448800E3DF6CA570D65C0E2FF7030MN2PR12MB4488namp_"

--_000_MN2PR12MB448800E3DF6CA570D65C0E2FF7030MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Want to add a Fixes: tag?
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky@amd.com>
Sent: Friday, October 16, 2020 10:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhang, Jack (Jian) <Jac=
k.Zhang1@amd.com>
Subject: [PATCH] drm/amd/psp: Fix sysfs: cannot create duplicate filename

psp sysfs not cleaned up on driver unload for sienna_cichlid

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 803b3ab..675b14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -210,7 +210,8 @@ static int psp_sw_fini(void *handle)
                 adev->psp.ta_fw =3D NULL;
         }

-       if (adev->asic_type =3D=3D CHIP_NAVI10)
+       if (adev->asic_type =3D=3D CHIP_NAVI10 ||
+           adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
                 psp_sysfs_fini(adev);

         return 0;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C4b9827047c1f4f1a535908d871e3193a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637384567500193749%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DklYQ7ZzcmrPbXDeEARNHMTjJMUyZWPSn7N3KTQZ2%2FMc%3D&amp;reserved=3D0

--_000_MN2PR12MB448800E3DF6CA570D65C0E2FF7030MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Want to add a Fixes: tag?<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Andrey Grodzovsky &lt;andrey.=
grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Friday, October 16, 2020 10:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Zhang, Jac=
k (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/psp: Fix sysfs: cannot create duplicate fil=
ename</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">psp sysfs not cleaned up on driver unload for sien=
na_cichlid<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 803b3ab..675b14a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -210,7 +210,8 @@ static int psp_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NA=
VI10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NA=
VI10 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic=
_type =3D=3D CHIP_SIENNA_CICHLID)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_sysfs_fini(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C4b9827047c1f4f1a535908d871e3193a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637384567500193749%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DklYQ7ZzcmrPbXDeEARNHMTjJMUyZWPSn7N3KTQZ2%2FMc%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C4b9827047c1f4f1a535908d871e319=
3a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637384567500193749%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DklYQ7ZzcmrPbXDeEARNHMTjJMUyZWPSn7N3KTQZ2%2FM=
c%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448800E3DF6CA570D65C0E2FF7030MN2PR12MB4488namp_--

--===============0859182107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0859182107==--
