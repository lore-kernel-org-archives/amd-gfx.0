Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66912CDB482
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 13:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17CB10E0CB;
	Fri, 13 Oct 2023 13:33:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2193310E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 13:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKGE+GV/RYlXAc70w6mmNZ6xiR4L5H+g2OQsn7woXUKy8JXLheR557Bh9DnRmjekR4rVCN/86Y6QrkFK1Edd4txMV41u5Jm4E+1fRrCxZ8P8vTHXztgbG6cWIEug5NctqeFROfGgL3Jl06YhqYnwUiwNOjxlzxtIL5dDf21826KWLzbQRbV8rHzbzgVWTd6CXxnSvO/y8MWiSGgXppm1TBLC1RHZq491huQtFYCTDjrQAI6S8WLKPpUiAUmz6RhOBkXa5ZwWtVdas+bYYnrc1nLWcfGB0XN9vup+No7tk8LQGRk9tm+88q7zNEefFhk8HvppiTZXkh0Kg/TKuUhOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcYIJ6vIBqCch86YfjfL10/EZXSKE7ICzyIKYzDyelA=;
 b=NXerfronNtgzZnNU2eU45+FGx8/BTkQnAOTjst9vcs0mAj2wRrjbnQzj/ijUlAvVuiDNsfsb0G1C7TUM9iT0/vCwfZ9pWrWrrMOgvpJx7bMIj830Q5B5HNq45l3QvHO8YrN0ofuZ8oASeFC+8zFy5K4PS18di0O5peCMnCP/SnxNf/tMtMHj708hBbNmPfXyDPCRD+Em/55sqGtjKZYv/Lk8V25l2UZZn1Uh9r7gPEIi6ch6ptsrVxG6L744BRf/UhcosCElJxpPpHUyRKPSrAY8LHSevI/N0K46r/pmODvssQbBErnkYTNU9M5YcIha6H6HqaTGH2USAJHinTV6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcYIJ6vIBqCch86YfjfL10/EZXSKE7ICzyIKYzDyelA=;
 b=04i5uC11XKMJt6MWafkvXI9IJiBJBo1MEomPcTRAQPrX2csU7LmSUGLdoYBAEr4ftPmH8+3xwJvlKwL0uowxM4OSfj/WwgGh2RA3oAKgK7s9D1f7z4fC4MGu71o+FEr/Q8S2XUHnOPv8jMi5QltkWoK/i+UE1PjtW0rQ0BiG2yk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 13:33:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 13:33:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/umsch: add suspend and resume callback
Thread-Topic: [PATCH] drm/amdgpu/umsch: add suspend and resume callback
Thread-Index: AQHZ/ZpxY7HCPoAGzUS1JKFU9tJ/qLBHuHy+
Date: Fri, 13 Oct 2023 13:33:46 +0000
Message-ID: <BL1PR12MB51449E62181F86610E23AAD1F7D2A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231013055859.37543-1-Lang.Yu@amd.com>
In-Reply-To: <20231013055859.37543-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-13T13:33:45.624Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8257:EE_
x-ms-office365-filtering-correlation-id: 8b23de6c-02ed-4f6e-97cb-08dbcbf106ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqHK9bZFPV/L5yqbevP6wOmkrm+BAItiZEuN5SJ0cjRBE1HdzrM9nAGuwgDL7T4FKVIF4uj1hfWS/s6K+e/dxl7Kc7N4i/tm5uPt5pueQUZaWICMvU+qp/n/EXy+dX2vGcvLzccBGsrVIiA+qW4A2+E3LWpHnQizyZQSx6SRTAZ4A7qcsxLZPkQhqTZQnVhnh7jH1g+WCPOsxrGxzqVmFWEI7a8agm0B4DEDwOoBmirmizEjVHvKlOkINrH+6Agx5sHZqs3AVw1AAvm4UnhI6z+GpijOJ+UOOgVK8WHZuWoAuDX1yq7EqcIDqG5Oebw6aSWnE5Jv9KmhZmN8pnX4tGlRLwZcQx6l2p/wCBZE5uYUs8B2+46+vXSr3nyiKm9kBI2rZIO3HhdDr/na8j9Liggf/InmnHuDYjLLhSZsoOChP8CeQy3PlkHBe+B/beEtZ4X5T1JMblC6WiUkFU+NcvVvZ5Aycn57MAae/VXYWzBi3WOfyDPocmj3/wdnDPQFq4VEmNoWCdz+qyboamc51xW6cZ25a3F/IScXUwgRaJPK8Nc9K9A+9ksCJL67Q9A4kTK2pZvXP1FF+opRS/+CeVLHqjgCfrTiTT3WbtkRsaMo8BgLkMX5wbFtg43Hd2X1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(122000001)(55016003)(38100700002)(38070700005)(9686003)(478600001)(5660300002)(8676002)(26005)(52536014)(4326008)(15650500001)(71200400001)(86362001)(2906002)(8936002)(66446008)(66946007)(66556008)(110136005)(76116006)(41300700001)(66476007)(64756008)(316002)(33656002)(53546011)(6506007)(7696005)(19627405001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/p+OzK/KKqOi0mIuNIoCi3uzSqY3d/bVY26Uy37T0+SODnc+NywYMmEoQr0P?=
 =?us-ascii?Q?Z3J5omE1YzvIpHM8yQqzVAc3G95WemozuiW9dW/eX2GeSWhtkBtDACspRsgZ?=
 =?us-ascii?Q?2EhSusLk8/opQ+XCZSzlDXkkmm1tlL6UgqvZKCpofYFKL9YQMM0VcOrrrmas?=
 =?us-ascii?Q?o4Vfq20Rrfyf2A6YaKko7nDCV+smmap48VJwWIwIyq5z69pBSkf/Duem4wkb?=
 =?us-ascii?Q?sGy8sLalqa9oW4HE9KWaB8hJE+tvA+WijT4YrOuNTzU5397ldwpacRdCjNMD?=
 =?us-ascii?Q?D6ylUuWSdXnYVCYDkButww0EW6l3YlOAArvH0JltV7xhGLnPFLitRLmzNhwz?=
 =?us-ascii?Q?CBBQR37kGjFeB5lxrrSeJqvoM2VAcH7WfYY9DGGqG4oFonjULLoa+ckH1/z1?=
 =?us-ascii?Q?tP5rcVuuXmT+0nlX8U6R/vqJvhvxqSgpsdJpTiwgYA06+uGWrh1pcganRkin?=
 =?us-ascii?Q?FV8fnb3vZ9gYa4Z/GcKJsJmrzNGED5tezI863Da5G8jvYCM/ncWI9IY6+rXz?=
 =?us-ascii?Q?17d/3GX6I1NsTcOWGlktQOWS2qDS6RLhXa2/QkS3Qc9xxsDcEt+5FFUiVOe+?=
 =?us-ascii?Q?8Yj9SlIJg9bkGeEP1CfoW3BCPW84+W40d06gfEjdos3P92l1YJAgoSXVWq3z?=
 =?us-ascii?Q?U1IaB+BIyuptOu1YSOWRasTGlOM3pMbV19O39JCfzqtCyCpdfy8kjr0G61ia?=
 =?us-ascii?Q?tC63/xGe2yZuk81CaQQxOVaNxQ4P2uH2EoReMWaQmO0BmK8I2lFSQ5shZ0aG?=
 =?us-ascii?Q?B31Vya/27CKMw0PtOqJefPrfJFdk1iP24iu59CA0VSCgIXInP30Ipd8yfb9i?=
 =?us-ascii?Q?aVtFudgawIIKFSZw6qnjnTEziZHv3labhILDY5pJeQHK63nwb5g7PqTgb5mU?=
 =?us-ascii?Q?48+gPlUPGXhGlMf7ON4qKuVJ8/ZzPehHXy8/ET/gpE8RG0jfaosIdICErmbX?=
 =?us-ascii?Q?5r0FDrVeDapXgk6LDG+s6C5txQGyNhQ6RS+oiXvS5B3NtpX5DmLL/6q+Z1t2?=
 =?us-ascii?Q?LvvO413I5cizkIuxX66g+sReEqYOsgYrYv2Rh/muTptxwU1vu0/X3+939lPk?=
 =?us-ascii?Q?nq9e3Ld/d/6CcVIwI5Sm9SWRS+P4QRrRpJy2hpsUw6bSAeMNsSLcUCA7GYWF?=
 =?us-ascii?Q?p50r+5ycC5tusT9Iqh6ClsNHFGy/VbNQb2ck3J7eOPSqcrXrLcO5PlsYgKOf?=
 =?us-ascii?Q?wehNvxZsgwDbSZ+cl92lFmfttfstJUfsF6XhajNxJTrKamFQxtjTJQ+dVFsQ?=
 =?us-ascii?Q?CmGGe94SeKlnPiAkI/5amL33dIlUVfZnZTdWKMOCF1GG48eWVnqq6V9rVoRt?=
 =?us-ascii?Q?2uv9v8ZjyYs559MO5+GoggF4FfXicEb5GLKFlfzwpQTuJ4OqfqLNL/DfKcAG?=
 =?us-ascii?Q?U05qK8mkcROj8xOuYpUEm31ilEIJhcGOGC6ZaJsn4/QB9MTIYd0x+tOoKhFf?=
 =?us-ascii?Q?u6uEn9lEF9Pmsi5MTlqxdHmDDrCz+oE0T327L/l5onpgezh+rVxnVUnW/En9?=
 =?us-ascii?Q?4zJtTHxpXQ/foAJqMIkuNgm1OUYyK/gD/RoR9K3BuoYeBCgI6uVC0Ov77NkJ?=
 =?us-ascii?Q?TJ+L9YIOQATW40pLU90=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449E62181F86610E23AAD1F7D2ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b23de6c-02ed-4f6e-97cb-08dbcbf106ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 13:33:46.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIa+6hMJIUF/Hda98i7jlMm4jyuunx+rpeiiTryKcJlNpCbww7J2JFdMYNnXkR2s/T6bS37asdIXtgnFF+zBUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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
Cc: "Gopalakrishnan,
 Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51449E62181F86610E23AAD1F7D2ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lang Yu =
<Lang.Yu@amd.com>
Sent: Friday, October 13, 2023 1:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.c=
om>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu/umsch: add suspend and resume callback

Add missing IP callbacks.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 4bd076e9e367..f5fdde5181f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -844,6 +844,20 @@ static int umsch_mm_hw_fini(void *handle)
         return 0;
 }

+static int umsch_mm_suspend(void *handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       return umsch_mm_hw_fini(adev);
+}
+
+static int umsch_mm_resume(void *handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       return umsch_mm_hw_init(adev);
+}
+
 static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs =3D {
         .name =3D "umsch_mm_v4_0",
         .early_init =3D umsch_mm_early_init,
@@ -852,6 +866,8 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs=
 =3D {
         .sw_fini =3D umsch_mm_sw_fini,
         .hw_init =3D umsch_mm_hw_init,
         .hw_fini =3D umsch_mm_hw_fini,
+       .suspend =3D umsch_mm_suspend,
+       .resume =3D umsch_mm_resume,
 };

 const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block =3D {
--
2.25.1


--_000_BL1PR12MB51449E62181F86610E23AAD1F7D2ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lang Yu &lt;Lang.Yu@amd.com&g=
t;<br>
<b>Sent:</b> Friday, October 13, 2023 1:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gopalakrishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakris=
hnan@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/umsch: add suspend and resume callback</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add missing IP callbacks.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 16 ++++++++++++++++<br=
>
&nbsp;1 file changed, 16 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c<br>
index 4bd076e9e367..f5fdde5181f7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
@@ -844,6 +844,20 @@ static int umsch_mm_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int umsch_mm_suspend(void *handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return umsch_mm_hw_fini(adev);<br>
+}<br>
+<br>
+static int umsch_mm_resume(void *handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return umsch_mm_hw_init(adev);<br>
+}<br>
+<br>
&nbsp;static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;umsch_mm_v=
4_0&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D umsch_mm_e=
arly_init,<br>
@@ -852,6 +866,8 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sw_fini =3D umsch_mm_sw_f=
ini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hw_init =3D umsch_mm_hw_i=
nit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hw_fini =3D umsch_mm_hw_f=
ini,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .suspend =3D umsch_mm_suspend,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D umsch_mm_resume,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block =3D {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449E62181F86610E23AAD1F7D2ABL1PR12MB5144namp_--
