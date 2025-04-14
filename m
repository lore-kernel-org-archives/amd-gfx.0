Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70DDC369B1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 02:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA4C10E444;
	Mon, 14 Apr 2025 02:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GWbik89Z";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A0110E445
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 01:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/kDBI0DtA/zPVEGERSYk6oOwhPCX2iPHRVq9FHzckfO+N+H0bu/f95ZgKYzojTVFxo9GbDmeKlH/8p41ORc6CxOAocKcdn70suG7qgnLwaUho1n4cVDQemOl979E3KUFn+QYF2kqSg2AnuCrnWvxVNZaqn8YdipmbdZAU7dN6MyMe88yea7gwxmXxgAiO6+WXB9Uu0LertqMZ2R7J/oM3i5BeWo9JW0gCJYdiJi4OmhFqFkuPPcWCaXsotPdqcQ/5y18/ltufjHA6UvoLjir1J5vwIeYm+kIz2OowTjLCDSVgP4fwXSZfZi1D+j52rFUgE40UO2sIhhldz/Q2k+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWFgiP1P9pckMw8tzO9ovavC6HAHZGdAnCkxPrgDPgg=;
 b=YTC7S1tlZXlshlOFnO8Sxh6GcLqky+6rGVnjmvbIFrraYz1gHq4naAJ3i2gCyuGvlgYVVdXRW9z+2+sUNGkHS/dX/w6dcwSAx2HQhpId4/fESsYM4X0nWbHrD8/IoxH5SUJn1RH2siHpOvC/qmX97GRoukSgAgnTzuLkmpcvtUrnCShluXYVW8B1cKA8TvHhkohEliBFEj5RnqLBkxWyCM5EU+5S3tllqWQ544QGTfvU3k6axNfsQjQ0B7KYGL6Can9j8EdG1Knrfk1WE3r9HACIPc2a0Czb6ZBfGgn99DsKZcILD5OfMHA/LBnsb050mrSVIDOjplKrZIMSQbHdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWFgiP1P9pckMw8tzO9ovavC6HAHZGdAnCkxPrgDPgg=;
 b=GWbik89Z4/TtZTu+Z6GpETOT4u1p/NqP4dEe2SHD4L28oi70evd4sya8C/QcmRjrCn5fVR1gMkwJodEJO2g9ijq+cdMNvgYx52HwncwpubxePyf/ph/vEpW5C2Ko+GucOCe32TEWprXNc9gsUf1K5qSWgXUIjnERL/+vG/aqWjg=
Received: from SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 01:59:50 +0000
Received: from SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d]) by SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 01:59:49 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix no_user_submission check for SDMA
Thread-Topic: [PATCH] drm/amdgpu: fix no_user_submission check for SDMA
Thread-Index: AQHbqv+Cz4JrUgGxWEmb6IsZJEfVqbOiaywP
Date: Mon, 14 Apr 2025 01:59:49 +0000
Message-ID: <SN7PR12MB6958D9EAFDC66A7A099AAC799DB32@SN7PR12MB6958.namprd12.prod.outlook.com>
References: <20250411125047.2660769-1-alexander.deucher@amd.com>
 <a556e413-0313-44b6-9952-b736c7211978@amd.com>
In-Reply-To: <a556e413-0313-44b6-9952-b736c7211978@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-14T01:59:49.267Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6958:EE_|MW4PR12MB6826:EE_
x-ms-office365-filtering-correlation-id: 73ba9f61-c4de-4ab3-e61e-08dd7af80a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Ar0dk2iFhuQeM4dTTGdsJF2DQFbGAqs7YePlt4hySuavsf7iYo7FxmS/CPF3?=
 =?us-ascii?Q?H4kFAP1b8IGDzCdfBceXuYWhf5YSfbsGNBhkfTSJfrwrRp5yG29xAK0S3KXD?=
 =?us-ascii?Q?5cklTySRSeZQVHYlqLrQtzD2dU0q/eGYom2ZBXGBwmDYgYkSXyBqLVbcwdiD?=
 =?us-ascii?Q?AC5a0kGMFK4twKJoekG4VI0L7skDmWSDW107TjzD2ULRhXBb77i8XMA7sQ+u?=
 =?us-ascii?Q?wTrAtRHW+j7+wxHX9gk957aAPrBdjF7+fGmrVZYWZy105RIj2MnblWFb7+jw?=
 =?us-ascii?Q?QtRYxMswNlkEogbpToeprpm7kxVmEkZZ+Emjtq+MBpSlWLUcYqEu16SO5K43?=
 =?us-ascii?Q?DuMG1JT6Bp+UEEL659dsEYfDGkhmsxazvix6I9A3rowgk5XhccAoQ5mmYe2Y?=
 =?us-ascii?Q?oLdFvaRDfVXkxiTrC2pjFkhNrfAL+zZZiSeWqxy5VErnFHuJQpPwwgLvIb6W?=
 =?us-ascii?Q?mEPGzKhrDp/m+Kvt6vooX+1G4pRR7lwQzfjTHdzNrTlZ0SEhGYnow5b3EpIZ?=
 =?us-ascii?Q?dPVIeBdYlm0+uVa3UOEFLfFseoYg5pA0cvIWvaXGme7Hzr9/hhW1zw//Yte6?=
 =?us-ascii?Q?RxCTlgT2p/RSE152KGlHme4OrnncxeIYm3VbLfjqxZXOlZWFnhkLlmNAFM97?=
 =?us-ascii?Q?qpa5aqrv20OLUHvpXFH/KJiZIQi4Ia41VCE61gKUoYTwYtxiZPXbSd/WPCSb?=
 =?us-ascii?Q?2nQnvKeL7BFREg5FmxbaajyKGGpUguOJcN6m0BRnhn2EXVg/5iLyfYRGPjqF?=
 =?us-ascii?Q?mmJ+1NQuejWI0d7dMxjks9h78tlu+JsamRnZ7Rs9drdZ5BsRfGzZKJc117lX?=
 =?us-ascii?Q?jIUmvHvRJfqbESS1rfARf8h645302b+mpl/5ZrW+WPDtvV8Ee7wfTNZF9aJA?=
 =?us-ascii?Q?BgRgKNF0nA1fCr5++WskMeuZSVl0+ouaaB8nSN0gGhadOGYrE6DC69gchE3Y?=
 =?us-ascii?Q?E+mx1naOxDaXrNHFD84u7OJHVEs4dT3vD5Y8+aA6/HMo99xzN0+MWhxq6ce0?=
 =?us-ascii?Q?fASdGhkd0biVw8wcUyGC0rbLlgj46PZdA3dNcDu0B0um6G7udb87tntq6FHZ?=
 =?us-ascii?Q?OKCNNa02unKQPW6Rr6szd6GoqxqPeai031gwCVNNOlKbDBu54UxFAG6agRJ1?=
 =?us-ascii?Q?/XY4Z6UN1E51wFqs8yHGMQ+UfydSkkq4SvwPXMibC3mdATzl7NS1thOimzfz?=
 =?us-ascii?Q?0bBDT0zZMecolQTRS7/1H8Jb1n0grzNIQNWvenFJKLmD1lDJtC9rqUO5vaBP?=
 =?us-ascii?Q?dprC3+i5ZWoA0S5UPyawqV9yNOxHN7A/AAsZFoiMtj0lSdkfj1L7pGrQ2xoy?=
 =?us-ascii?Q?mOVNE79xqwDnrXfjx946MqEADspk2bXk6SyvBUYHu9wNZvJfO0Px8M2AaA2u?=
 =?us-ascii?Q?DH+tNbiD4sbmP4iHjBMW4UWlavfVinQnrVyxRYAL9SCGuUEhiRIjz1qLT5hC?=
 =?us-ascii?Q?4ITEdcX/oPpr6v8oJa02OEkIjGtkOI96EuPARhcoU5sV8ssJWI4XKE+mE20S?=
 =?us-ascii?Q?T6PfkFqsowjX09Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhExSbj79Dmf1rZRolW3z4B/nHpf7OPC6bLb70g1bIaaG9CgSvARhVTo2tnc?=
 =?us-ascii?Q?6limZnKXriNj+tKoNPC/gSPgTkcKm7LPtxZqBx3c1nsYg97nrthobkd3mlB6?=
 =?us-ascii?Q?CvRN/mMVdk2sgB2xtouhYeuNAMMxMxocNHOu7KJcXhfqy5VcFKjPETrAXiFQ?=
 =?us-ascii?Q?6OJPruRz+NFFi0VDKBFdDLJAhqvSAutCGlQOPnfGBptZc7ZelBpiqgvOBPfX?=
 =?us-ascii?Q?q6drsAREYPLoNQibr5B2h1sIRC9zO1+nXZb2/J6MLtgH34Y82yq641PiJH4D?=
 =?us-ascii?Q?TMAIXCtsLeFaTWYtuzAS8l2Z4+mcJ3b8ASlVgTWrtb6LqIZmESoMyZBYwrHf?=
 =?us-ascii?Q?6v8wkbjYlIZYrCUiRH2qWorx0kif3Q6eXRT2AEklHD5lAdeyjwFDPjauFeD4?=
 =?us-ascii?Q?k3u0+Ei8elHh7O4s9flYz3Hg/9bokyTuMxH5T/LjTwPmutPtUI/ogXld73Wm?=
 =?us-ascii?Q?bmcHPO+2IcAMallC1u2qX/7uK9y6+Tp0o9vlEWma216rrGP73pQSyrSkLBm7?=
 =?us-ascii?Q?aQzco97+qry68dPctMSiKTv9RmD/HkjD8d/tI0MSRjWXLaxizyb/ioYk0+x+?=
 =?us-ascii?Q?nrNL4aDR2s2KpDjUGOFAi0OxP9yOLueqCgokoPMqDXpIXMvFXJCeYIT5ewyq?=
 =?us-ascii?Q?MPn6roDwI9+C4NrjNjesEGpDPsZq1pUL+QBOmv5tolvGlOUYbyTCHH9EyXTs?=
 =?us-ascii?Q?OaG/C9l/RuOTY8S6+jsjpE/YsAnt0ghTFq8++68UEvasBgv8aAbrorft3UyG?=
 =?us-ascii?Q?4KFINmyQgKqZzySn6DwfO4LbZDeNv+VPPm5r7jWRY5hgufnFu7k5hHzrqCl9?=
 =?us-ascii?Q?mofwEqJnme/qm0ZVfdiLzohI7eYTE8236kuIgFFl6i1aJ2MTP2shmGwVUYiP?=
 =?us-ascii?Q?qwOChZAx6hErMqHn2+O5Nm1UClcn8jd1CAqKkn+C+qM5LAYXi5zsg9TXHZpH?=
 =?us-ascii?Q?FqB2ULTIby9ejhh+lstHs5h6Gdz6z4Pc6RcEJX7Zmtayn2tYvrhyz68NyuTn?=
 =?us-ascii?Q?PafOQOkdRCMTmz1jgLGq/1iTlVdRJabHyVs7xYJzXBfdani+pOpVQcdnWFny?=
 =?us-ascii?Q?H4kJ2UvF2Y/qbfUXHg7C+lpctoqo+0qoZ6oLzUPc8NwmujTSJ6BcIFlcHbTp?=
 =?us-ascii?Q?ZCXRWvSrF9/vMqH92+BZrvIZY60NIBjJd7XUKiaaB5QHDdw5L/pYv7secoEv?=
 =?us-ascii?Q?IsP2PPLMnUdeJCgemcyV3ALjj+j8Oz2Cv++6o1gwFYo8pYCK0kWAl2YwGB41?=
 =?us-ascii?Q?opxGL7A/fHjSS0vl3iPT+LXEdmbjXvClqkX7vtqK1WChZeQAP8MbwGVbnFD4?=
 =?us-ascii?Q?8hWW1V8ZjczyT+MVoaNj3VOqDgldkYG+Bo257zT77e2FVpCI6iXYoU7HJ3cB?=
 =?us-ascii?Q?0eTEfZfYvzkJz0O8WPGuXHQffJ3pZ6QxcDCq6THjdiXQX5FBk9xjx0g8Hz27?=
 =?us-ascii?Q?J7SxsSS/90pzyRQFK+xoNexuiojOyFZqqwAuR3xaxGk66Vf1TFScGPMMbWE6?=
 =?us-ascii?Q?88IClJtf1/otfkqmhCugA+A+4F6LUcPUjC5Drp79uPJAtnyKRIEJKbjQtO2b?=
 =?us-ascii?Q?S7SqMyFpPW1D8jOW69w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR12MB6958D9EAFDC66A7A099AAC799DB32SN7PR12MB6958namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba9f61-c4de-4ab3-e61e-08dd7af80a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 01:59:49.7709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbtQxBWpQuCQHqSTMg85F0+h+a3DQsvgkmW3F4iOBtbxVOC1f4oG+8+4aXnIb44zHy4cvHkXwdRV3UI+xCP9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SN7PR12MB6958D9EAFDC66A7A099AAC799DB32SN7PR12MB6958namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Ce Sun <cesun102@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Khatri, =
Sunil <sukhatri@amd.com>
Sent: Saturday, April 12, 2025 12:33 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix no_user_submission check for SDMA

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 6:20 PM, Alex Deucher wrote:
> Copy paste typo.  Use the flag from the sdma structure.
>
> Fixes: 4310acd4464b ("drm/amdgpu: add ring flag for no user submissions")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 0ba3ef1e4a068..6a42dea775b10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                type =3D AMD_IP_BLOCK_TYPE_SDMA;
>                for (i =3D 0; i < adev->sdma.num_instances; i++)
>                        if (adev->sdma.instance[i].ring.sched.ready &&
> -                         !adev->gfx.gfx_ring[i].no_user_submission)
> +                         !adev->sdma.instance[i].ring.no_user_submission=
)
>                                ++num_rings;
>                ib_start_alignment =3D 256;
>                ib_size_alignment =3D 4;

--_000_SN7PR12MB6958D9EAFDC66A7A099AAC799DB32SN7PR12MB6958namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: <span style=3D"font-size: 12pt;">Ce Sun &lt;cesun102@amd.com&g=
t;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Khatri, Sunil &lt;sukhatri@am=
d.com&gt;<br>
<b>Sent:</b> Saturday, April 12, 2025 12:33 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix no_user_submission check for SD=
MA</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Sunil Khatri &lt;sunil.khatri@amd.com=
&gt;<br>
<br>
On 4/11/2025 6:20 PM, Alex Deucher wrote:<br>
&gt; Copy paste typo.&nbsp; Use the flag from the sdma structure.<br>
&gt;<br>
&gt; Fixes: 4310acd4464b (&quot;drm/amdgpu: add ring flag for no user submi=
ssions&quot;)<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 0ba3ef1e4a068..6a42dea775b10 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device =
*adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_SDMA;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_instances; i++)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ade=
v-&gt;sdma.instance[i].ring.sched.ready &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 !adev-&gt;gfx.gfx_ring[i].no_user_submission)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 !adev-&gt;sdma.instance[i].ring.no_user_submission)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ib_start_alignment =3D 256;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ib_size_alignment =3D 4;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN7PR12MB6958D9EAFDC66A7A099AAC799DB32SN7PR12MB6958namp_--
