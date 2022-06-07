Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B925910E141;
	Tue,  7 Jun 2022 14:44:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6334110E13E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/dY9ERCiGPj9sgXj0DLxun5el9U3jxs1KyHrelE3evOw81TeOJEWazkkwc153KRgLqC2dt56vP8LQXEXExB3ezcJGqruzhYW+PilByRu8FjvjFtqN8a7oDB0Ow0hcrhml7fY54DxDhiNFAeuZUu6JDCVWYcBhAdaPDmyNnbkcyUKYdnutRyIcJv1/LxxTLnnkZ+aXZkrtHOFTHlh3+DwG+xmQ7K+SucDK9hY0RNk2UMpV8msNLxpPCBozcFNfLUxANt/rqFAP6vnZ4AOYjYPicNn+GdhNAhGab17aD6ucx/w+uqsMYE8VlQh+EDRbBAk7h+f/1aRd66SuhUBGb91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXTZdUkobWpcSjs7I3wFN7DpiK0BSA2oZ5l9xzD4VWs=;
 b=QSfhN+LLrapJOXXim7We8NpLPl4N7YvZizPqQXAN+6XkpVYCjM3T6AOHhI2dTresnuNOvfvhOQ7WPCaaFK+Y/BGZXcOYR9TcOvWHd4fqzcC0rx3gl2XtXmpz/0vlfhl0sbxg/wa8OazM96gjpTEj8CvTbuJ0fjOkUMj1n4MBev3Wz7V5GPCRYT7+U7N3gNiCoNWN4T9JQjWlAXPbQ5+bRn5nM8t9/jlbq+YSZojqv4PLrIsRFtzkRrVlPsPF7U+N1WILxnsVf/8xMgqSiVgo9/WYilfMF7ycPXsrymRTtTEaq0w9hBq58wqQctTnelDcfPeSULSsRcTGzOUjnonB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXTZdUkobWpcSjs7I3wFN7DpiK0BSA2oZ5l9xzD4VWs=;
 b=O4WN2F+MXroj6NACL1fzaar/HoKa8BGmU1N2s+n9zIKI9V74wo/QwzSLMvAU6hm4xi3lu2CbCR3saAyoI6toUz4kGeFkvRB7hQc9bqjsU+3iVbUBXCtaWdtmXCGDIIJ1S2LHRhPPIui3MC8NSKy+tC8875Bg/kaiydUURH1YAfo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14; Tue, 7 Jun
 2022 14:44:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:44:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add MODE register to wave debug info in gfx11
Thread-Topic: [PATCH] drm/amdgpu: Add MODE register to wave debug info in gfx11
Thread-Index: AQHYefnkYuSJkCAZ2U+LJDBQoCgCEa1EBhCC
Date: Tue, 7 Jun 2022 14:44:07 +0000
Message-ID: <BL1PR12MB514410954317978BB02330A8F7A59@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220606230454.697232-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20220606230454.697232-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T14:44:07.112Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4e2f0ef-5b82-47ae-d555-08da48942d1d
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_
x-microsoft-antispam-prvs: <CY5PR12MB652689A63C6646BE9C291509F7A59@CY5PR12MB6526.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgJ/sEvFi8mBdL14x0ku1+1H77uTJL3uRz7NXeuT1Z/HcWy5VCect5CQ+quUINS50kTKbzmyNEONuAROyVDBmxFCikv9hgIv/9MhEeDR9HvcuRQ2l6uLqsL2D1ASAuh51O3nHpihLwIHlQ/iQsyq0W3lj9DRFlx7CacoXxBiMW924sgxGS2sr7jXzERFTQuhgBtqUSO7YmYrng3HpdXODf1mU7gm5RNFdUy6rtUNVTI7xd4MNFB2XrPEFVr44dKj87P0VlGWbkJwqfQVSDIc9wTwavmV8wSbvHHxyT3HYg3d9Xq9kNFccqVTiuQr/dVZPFAt4sbwlav3ong1aI1ZA8RUIOfGejcyt9z8uBaeXxGIB1zeKNEZj11S4rCJUkCOwhbTUtn2NbGl+a6UZog6DCIiV7qAvpzYvmBiLvRbTTNvg/gzrQvbRhN2S40pC7heebp0buvBtxNRbIK5o3k7A3ylVeUyIOmPShzYdbUT8UhIDw7Yy3g1Uhe2T3wyvquZfKGP6R3EmRIjxVB3HPp6Uk386jOARYPywJadvPWbcMOCA8A9frUsf4gu1D3wnajUNu9DSaUfQKcA3+UxFqtPp+jhXcLEGSpPPHhXIhOElopQ/MZ+FLAHesjwVUSXWYGRtvm7qJDSdSSmdDcc6Cn6vUEuq7lrdGUI31op9dFr6qXrcVqlY+bk9hg8esMDcOFpy4AiLxjUgJ+C2tfsTBRB5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(19627405001)(2906002)(4326008)(38100700002)(86362001)(122000001)(33656002)(6506007)(7696005)(38070700005)(316002)(76116006)(186003)(26005)(55016003)(9686003)(66556008)(66946007)(110136005)(8676002)(53546011)(71200400001)(508600001)(5660300002)(52536014)(8936002)(66476007)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyBiUX3tWWhOVSuEeRQ1t5+7IWE/rjp8iFZBlM3XYGRK1AZ72tfIGyI7SlyG?=
 =?us-ascii?Q?Biv9wLWDoq3JINf+OYENSFJYzj+7F+V+IELV8eFwZDRQz7FUh2qJ8YvbE18Z?=
 =?us-ascii?Q?7HKabungFYzEaCF1uuBsOQIAYASwV8tieaRZl1kAHfhXRNRuBplmQYVOfkTt?=
 =?us-ascii?Q?Nb+LK8BXeCvLYXIY/Gxzxni2YltmZl/rOKLfupvVWXTR6DSpMHtWKy2VTdil?=
 =?us-ascii?Q?xy6I6Hccq4HKde8jB6oRX64OW5P4utHiXOWYV7U9ssrzGdtmfQBmoWyyHOB+?=
 =?us-ascii?Q?nudlyDFD261AnNtUcpCBZ8tIQr8fPXh0COI/r03O7T17KlD/hZ3EucAW8LMI?=
 =?us-ascii?Q?G0PAqaTb+51AsAKXRsEuTLeY4BykAbXLOUDZ5xZXlUPUatLlky4l//ZPfe0i?=
 =?us-ascii?Q?6AqfmsG4ed0o5K1txesNhICUmLaaVbLehIKmJjok0mEuBrOv88QjlRUKl+7V?=
 =?us-ascii?Q?aOFsKl5Cv5QcIov7LYDHnsjgqGXKBlqDjRIQ6wkV+I9iXLhb99aUcc3D2wht?=
 =?us-ascii?Q?hnJhn+2zJ74QeF3GQXTcEkWp2DrPyUFAVnpLlKB1Lg+iLMx375EhCgrlzC2p?=
 =?us-ascii?Q?+nBYriwpVPr+d/QtXGsbWk61XAtaa05ao86L7YnvKaIJZSuPvXXq5NFu3NAd?=
 =?us-ascii?Q?VUEnUFVCLSfKuQMh/0Sfc6RLOUVi5m3namHOupPaIRUHtp7LFsDQuA7FSZSe?=
 =?us-ascii?Q?/AB1N845MuDzvElLYHUpmRlpL5/C5gE24zPmPWgJJWmf6oo8+61ztbgLpKf2?=
 =?us-ascii?Q?DtZFJF2A80p8JUtNV9u+ktbo56HnOA/pL/GxYfNXlVXX4ZlsNhXFeBoykOeS?=
 =?us-ascii?Q?jnU6gaeV8apZdk2hzGuuDR6qheNvr20/MN02kR3UxbRzPOktscGzCnbxghTc?=
 =?us-ascii?Q?7zbGP6m10s0n1IBaozunhEG0cQ965rvylZH3cLk1CltMPMZR1zi7E2JzGjwo?=
 =?us-ascii?Q?64lvrusJzESpS/eUBWMObxWtN5tO4ALDZG5qEosR6Ifm0JRW7EsIQeg5sNVv?=
 =?us-ascii?Q?DY8BxDt/qdNOCg7RGD4tOGzFp9CqPqkBGK4YitogRofDL3eija+MggThwl9X?=
 =?us-ascii?Q?B5Fv6i+tAt21MVkja4sU+SMNMJ+cpIgEtl5ZJH1dRmMA8dlK5WJx9ZI4biy9?=
 =?us-ascii?Q?9lOqyr4eHos5foA8YAMgKrKw4/hBpwjew+j5PmLK123S5/k9X1+Yg0uMvTWk?=
 =?us-ascii?Q?HnWeLKa7D//jHWmFfz+1gkHQ3TNXeQKpC18iE9PfJIbplhq9qfe1J7BSwQVc?=
 =?us-ascii?Q?ZZJcuyurVFQmTTCkIY94IdmannUsW5CaMlJar5SVJdAoJinJKaMyxR4Lrpyi?=
 =?us-ascii?Q?BsYdAbvauvbJ7uvKMFR+OunfefcGEMK3McAZpkZf9T5/6/OjWyBUzQ7MHumV?=
 =?us-ascii?Q?Gcw3oGre5bnKTpZ/hQGxd1vK+DRQc+rjy5UrXcMMUGFDavZw3E5Ccmb158Yp?=
 =?us-ascii?Q?hNRsto87c7uQU4ashexq4IHWerOvHZp6k2U/PunvA14BbMncEEEjtDFUqxPr?=
 =?us-ascii?Q?TXD9rfv0LtsI9Vp0X2GFuUqA8rU8kV+zJ3u30JRjgTev7peBFLo32mtxzkdL?=
 =?us-ascii?Q?b9HbOMhgsadRMVZsq8hyIipXHyd0uPa88xYOIM/Oh5RH5LaeyDSYnKxQIH1D?=
 =?us-ascii?Q?0tHheMt0C0cj7OeFcPuQGoTaDYQSUgJbW0R0+CYzeeNFkxzLlc7boOacctmX?=
 =?us-ascii?Q?v2zf51icLeIK1Pwxb89vZtYujhYD2jn448uvciWA2LdOE/Kq5pKY/eo/Tyf2?=
 =?us-ascii?Q?G5O03y+JvA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514410954317978BB02330A8F7A59BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2f0ef-5b82-47ae-d555-08da48942d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:44:07.5479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwELJANp8K/iLki7OaKz53XrNq8SLf9gichtP4G1/4eG3npwXAeK7V5pdGqj7q2R4+apZTuN4fd/NmYygRhuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514410954317978BB02330A8F7A59BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Joseph G=
reathouse <Joseph.Greathouse@amd.com>
Sent: Monday, June 6, 2022 7:04 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>; Greathouse, Joseph <Joseph.Greathou=
se@amd.com>
Subject: [PATCH] drm/amdgpu: Add MODE register to wave debug info in gfx11

All other chips, from gfx6-gfx10, now include the MODE register at the
end of the wave debug state. This appears to have been missed in gfx11,
so this patch adds in MODE to the debug state for gfx11.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index ca37289c644f..05359df6c354 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1096,6 +1096,7 @@ static void gfx_v11_0_read_wave_data(struct amdgpu_de=
vice *adev, uint32_t simd,
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS=
2);
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG=
1);
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }

 static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t=
 simd,
--
2.20.1


--_000_BL1PR12MB514410954317978BB02330A8F7A59BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Joseph Greathouse &lt;Joseph.=
Greathouse@amd.com&gt;<br>
<b>Sent:</b> Monday, June 6, 2022 7:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; Greathouse, Joseph &lt=
;Joseph.Greathouse@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add MODE register to wave debug info in=
 gfx11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">All other chips, from gfx6-gfx10, now include the =
MODE register at the<br>
end of the wave debug state. This appears to have been missed in gfx11,<br>
so this patch adds in MODE to the debug state for gfx11.<br>
<br>
Signed-off-by: Joseph Greathouse &lt;Joseph.Greathouse@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index ca37289c644f..05359df6c354 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1096,6 +1096,7 @@ static void gfx_v11_0_read_wave_data(struct amdgpu_de=
vice *adev, uint32_t simd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uin=
t32_t simd,<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514410954317978BB02330A8F7A59BL1PR12MB5144namp_--
