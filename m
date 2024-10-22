Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE13D2C548
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1660910E680;
	Tue, 22 Oct 2024 13:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kgtUKq0F";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26F810E319
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 12:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIijW5YSnuMKFAn2GlowHbKLCryeH8GdY3002c+n3eG1kocOYC3K1Y9xIlF8NI/6fql9W6ArYOGZxbwIf9iO10z9gU2oHfFEsaZ7N3nrYLKWFeL2ya7aSQvii2pW65xEo0TGk92MAg7XzkbecyRd4jJV6Aq56I3gothpcr+E5MYyI2cu/88u4TOiw1lDr2QZ0qnlZZIRhcAIN6kfswBskAABUYgjx5XgliJ8s874/rq+Z1/zTzElmHc9AIexc5MZjwScHtu/79zPwjhF706tifq7iNVyrateeejNRIKW6uxaOkl1U51ro6Dz92s6PidkRXaRO0ADGLmijZuws0GScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdimLJghNWCM1PmCPy/B3sdrTFfFczcVXIlq20Dq+Pg=;
 b=DBjO28pLmdmH94YB4YDYUGULVvGmyGmQdc8T0qQDL31z7LUtG/rg+3WhaR753C0jWffzGzb+7Fp+mCotdpTDhhku+v5zLNzwLila7qo4xpusDdo62TKbPr2/QtPyOElPvmwihYFMq3SUE51SJK+Zh5ktvn53X6G8uH7YsCCLk9XbZZVtWRWg3TRPJ+sIsOy/mad9gspt+3yP2UTX8YEYxPH+bYAmRZ+yZ77M9dC99Qj1S2sncQ7Qszh+oQUj8bNO/JQFuzLhIwKGxg6fgMAVp+Jhg654HzFo1Tx12yVbYNQa322lW6NSimKkveAZovS0TJf5Ji+dX/3DM1F6JwklaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdimLJghNWCM1PmCPy/B3sdrTFfFczcVXIlq20Dq+Pg=;
 b=kgtUKq0FruOuZUnhzKBLdxFK02LV6Hur4r/s/iZHQJWp5fDleOwMjYk9FlxbuOI7UUERZWmHBBYBH8n1utfXLARF6J5ynSDmZ2TRPDQfyuAnAWJo5rIGH7WD+6+tAKlroFbz4zvY1sH1gBbSE4md5Su9w42JR7w7E+lgjZv4+a8=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 12:59:50 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 12:59:50 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix kernel config name for gfx-userqueue
Thread-Topic: [PATCH] drm/amdgpu: Fix kernel config name for gfx-userqueue
Thread-Index: AQHbJIIeYnDqFWmZlUuCj/wrenEBmrKSu1OO
Date: Tue, 22 Oct 2024 12:59:50 +0000
Message-ID: <MW4PR12MB566743DB74BB4EEF6DE7D47FF24C2@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20241022125817.13758-1-Arvind.Yadav@amd.com>
In-Reply-To: <20241022125817.13758-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-22T12:59:50.319Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|CH3PR12MB8460:EE_
x-ms-office365-filtering-correlation-id: d87794f3-f0e8-4c2b-2bf9-08dcf2996a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GLi2rgoKId4hXK3wyb0DyrFB17mx0XKWCTUXPX7WgVmD+slgWU/TCiClp6?=
 =?iso-8859-1?Q?NToiLZF8Wknr6cnweb+lryAC9ho9Kvi1RebF8TcjTobXGK6etx0exzimtK?=
 =?iso-8859-1?Q?5NkTSA7or18pww+rDu79nob7nqkqUr4v+FuEBFfgKJtRACRkb5CvzN/nzx?=
 =?iso-8859-1?Q?6/rYnEPPXG7uja+n5M+ZFZSZv9yD7XPPBl1hHvvqxM21MEbUWA+ST2jNdj?=
 =?iso-8859-1?Q?0C1GkVRN6f73DtUW4bVgRMoKSyZsXO0Qc6R0fjepuIKT7g+deIKkbMyZYc?=
 =?iso-8859-1?Q?1GGocEpVoyGnGL/OHVEAKfA+zDtNA/w5DqN8XOnTzOjpjh+mqPbCIq7vre?=
 =?iso-8859-1?Q?vQJXQGS3Anhx3PvqlxPdl073bCJifkFXKTWkQPL83IZut9F4hCZK3NHJVg?=
 =?iso-8859-1?Q?pwv8g091OCk2UQ23qhvgwlmaylQ79P7BqaDU3/0shQTn8lgurUr7m55Qus?=
 =?iso-8859-1?Q?vnJNoZKx2Ci64RjVc7yhr4YE2qf4VzuiHFEqu0/i9OYytf1q0h4zVj+Vm6?=
 =?iso-8859-1?Q?kXyuZSdUiR3EdxpeZwn+LrUG9jcWILVuqAyCCXFCPGZGgGxQENOBEOosll?=
 =?iso-8859-1?Q?6/Lhi/7uKSaNae6BN28rUDT/e4h9JB7f02V+xX1a/JHpPzdZ7OKINAnfUT?=
 =?iso-8859-1?Q?jfBfRTmvrjHzXV2lYdixvxR5SBEmj5NU5Fz9LNK4Raq46MIiw2/ZECGMm1?=
 =?iso-8859-1?Q?kQ1EO2hserrf6j8Vrs23hr9WU8VmKuSK0gY48lckwEpr9TUn87+a/NSvHE?=
 =?iso-8859-1?Q?dZwBG36+SzHjuPG3xGqI12HP86jx3NwASIPK/8knBmsoGxL/2adtwDPTVV?=
 =?iso-8859-1?Q?tm231ffYcHZRwcx5jXDV7r44zwWZEeDeSOWu6wkI1YlNmGjh+h/RW1Bc8W?=
 =?iso-8859-1?Q?4Oa5rxez8znsCchHpi8/sI4zjllYGtvHEdia8/JW+KMeKLzwUrdNsyFGVp?=
 =?iso-8859-1?Q?o3I2S5l03TDoUuPIVp8KHDjSahFyz6ZC7HvWx2ePp66y8rMhDWdHeJwXz0?=
 =?iso-8859-1?Q?V3pGXaBmwtpTFr6qI5RLxV+EmDcQtLj3sC9FELjAK0ElvNM6Ff/psR0clL?=
 =?iso-8859-1?Q?EuDwawULWGFZRnCV1FqeUkFsBuaNV0HNsTkotvvWEAKIGLneYIuDFXqL32?=
 =?iso-8859-1?Q?KMdHGRBcx20XeQ5keGbO9bkkdn+edUwRB7Lk2lMDaEBJaTifHZKp3aVNsq?=
 =?iso-8859-1?Q?uh3714G6Nosux6DqjO3DbtLaL+bYlfgmUAPL8XBnwvNSPcwl4Y7JG72Kpe?=
 =?iso-8859-1?Q?upMG6v/wIvDWAHvyTJdMfbuytGaNa8oSu1QG4GPxX0VfRAG6WqHH9atqSj?=
 =?iso-8859-1?Q?pRWUyQxvZl0iJBswxfJxl4BRPY6NYOSSAaxsg7zWK6QdkpB5HssQNV+6KD?=
 =?iso-8859-1?Q?sPFkGX1N6oBE7TKaalaNLaJPfJInWxlX1/Fib5MCvK0qXdJyOVvYc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5WiVuAsqkHOQWXtvp8NQFcCtVnnAAmKR7bMQBEpOsGgc4ezz82Y1kH3MPq?=
 =?iso-8859-1?Q?IOchjeEdIJaF63dQe2OsfmslHCL6EnHcR/Fp50qfm73Vsvj4wGgJCCt7+W?=
 =?iso-8859-1?Q?TPgCtYCsgixYmItZuI6scY2WRe2V4J97dkC90ANWLN5vb6fDY96PBYGC0q?=
 =?iso-8859-1?Q?DF14gx5uJbmQY5IE+Y3jsZC6Sqgt28X4sc8o3zxwISQXni9kImb5VvzTga?=
 =?iso-8859-1?Q?9eIz61FcwAJP8fsdpTUIH9EwuIzHhyIZa5PIU31W6mqsyxbXuY5dIMP0jv?=
 =?iso-8859-1?Q?mHR0YCj9cU/xtRwJnRJYgdbvibnQO+g7iHRjClCG6KvVURizd+njN5ydeo?=
 =?iso-8859-1?Q?/9EApgGHkUVUhZZdgKwG5qfrCbKYpEdp85RpQUm0g8sNBikqV+41A2y1Rd?=
 =?iso-8859-1?Q?3spv4JoBdb7Sv2G3KWbaefSNqQM1p3ptxGRoQsnJmYGVyJui40kOLRWH/Y?=
 =?iso-8859-1?Q?jsQKAbm/4QcmfqR4BqOeVv/9rYuByED9roBJnalZFOUGVdwY95JMtRz7vf?=
 =?iso-8859-1?Q?WsPv8Mx/E8W5upcWIb5ub57TKA6eqI/BEU8KE58gc0NZuStNnEnnkMcljp?=
 =?iso-8859-1?Q?eHOqu3530/Fi244L/WGo+Uozl9NhorUNv6cXDwe/1rug9ePww86oktCcuG?=
 =?iso-8859-1?Q?pEbmAqPE6J4Vf6pv2st/6/l+uOTeydQS9rsDso2izPpnUNDOc5ci6R16ot?=
 =?iso-8859-1?Q?wubCQB7rAvVK9+uC7ZsNziQhH2R9bOiOIqQY/MmmcTshY5HwbuA+Jem/pN?=
 =?iso-8859-1?Q?v2ud91snGa1UZ4YbHxS4JtTNbhnNdGJ9BmHtj3jU3exmJobFDvP5cZgfQZ?=
 =?iso-8859-1?Q?xhIRdxKFYWfB9xHYmIJiiQyMqSH9Fa5ND3o0ASP+HFjZvjL0tMTlQCxBUm?=
 =?iso-8859-1?Q?e7mKmF/NO9I7h3wFA747Jz7xvtw7ew9KzCkUtvatH0HGvMRc3YW8QxxWi+?=
 =?iso-8859-1?Q?VmjWjS0ZVELMuMQGkWQtoggPw7KRMG3dXgqC5DVbaH8R4cg9FGy1fvmHv2?=
 =?iso-8859-1?Q?r1rRToVqEneRNN0x/cCxGPcEjGxgOlROp0Lvzq/MVRVsNdkhlsjC5NFLxF?=
 =?iso-8859-1?Q?Ajqj+YherZXK0Be5Vo1dphOo26SJYk+ZBNt8vEEVzIHvAgnu/gf9MbK+zR?=
 =?iso-8859-1?Q?eIqZIVkM3ICtCiWif8Q/Ge8owz43+hACoPXp3UBQv7FvSAcpc0h0BOMWYG?=
 =?iso-8859-1?Q?v963DVfyLG2k3WSH6ShZlpaoXoLLRWIyLBXAx4uKcfbOhIXz5rjAl0jonW?=
 =?iso-8859-1?Q?mObwktPvXDmc/HhRLf+VG+6UZHpYCIZ6WGMXPd6ffvKFlbP+aqljtu0rtR?=
 =?iso-8859-1?Q?U+KLO+9Wk0ym/6SJXzBBBndrWUC4J5DR0NAv0BAqK0XQ7Uj5QFmytjoS+a?=
 =?iso-8859-1?Q?X/mhiltPzHxRL6lZ+ZQXX5hB9kIbwVZUxwYeYM90MaAgVzZ76FW+jRb3Wg?=
 =?iso-8859-1?Q?gyCs88IiiUSNkVhtOlFqrkuBEcXuQKWFoMLFUAcHT5sfeos2NtW/UcGwDL?=
 =?iso-8859-1?Q?lq0cHYIz0aXWPz340Om1RswE+zc8otXVdBsb9rHaCBJkcslLVeCA9pSQVD?=
 =?iso-8859-1?Q?MrPEy3sDxo2rdbIe8oNNjoo2xkm9j3/8j1LOIXu4BQ53410e/gnAW3sYtu?=
 =?iso-8859-1?Q?Zm+3kk5OLZ8Qs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB566743DB74BB4EEF6DE7D47FF24C2MW4PR12MB5667namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87794f3-f0e8-4c2b-2bf9-08dcf2996a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 12:59:50.7657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZG/Dv+fmXnZDB/nNRhWzZ7UlLeoN7CIMGdd4AxojVPl9lK6T6NbZKbjjQIk/lCthfHao1BWzKv7S9WjnZai/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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

--_000_MW4PR12MB566743DB74BB4EEF6DE7D47FF24C2MW4PR12MB5667namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

Regards
Shashank
________________________________
From: Yadav, Arvind <Arvind.Yadav@amd.com>
Sent: Tuesday, October 22, 2024 2:58 PM
To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Yadav, Arvind <Arvind.Yadav@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.c=
om>
Subject: [PATCH] drm/amdgpu: Fix kernel config name for gfx-userqueue

DRM_AMD_USERQ_GFX was an old config flag and the new config flag
name is updated later which was missing.

Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 5aff8f72de9c..a12ce58962bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1572,7 +1572,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                 adev->gfx.mec.num_mec =3D 1;
                 adev->gfx.mec.num_pipe_per_mec =3D 4;
                 adev->gfx.mec.num_queue_per_pipe =3D 4;
-#ifdef CONFIG_DRM_AMD_USERQ_GFX
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
                 adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v11_0_f=
uncs;
                 adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_v11=
_0_funcs;
 #endif
--
2.34.1


--_000_MW4PR12MB566743DB74BB4EEF6DE7D47FF24C2MW4PR12MB5667namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Reviewed-by: Shashank Sharma &lt;shash=
ank.sharma@amd.com&gt;</span></div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shashank</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr" style=3D"color: inherit;"><span style=
=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
"><b>From:</b>&nbsp;Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, October 22, 2024 2:58 PM<br>
<b>To:</b>&nbsp;Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Yadav, Arvind &lt;Arvind.Yadav@amd.com&gt;; Yadav, Arvind &=
lt;Arvind.Yadav@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu: Fix kernel config name for gfx-use=
rqueue</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">DRM_AMD_USERQ_GFX was an old config flag an=
d the new config flag<br>
name is updated later which was missing.<br>
<br>
Cc: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
Signed-off-by: Arvind Yadav &lt;arvind.yadav@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 5aff8f72de9c..a12ce58962bb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1572,7 +1572,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_mec =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_queue_per_pipe =3D 4;<br>
-#ifdef CONFIG_DRM_AMD_USERQ_GFX<br>
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX] =3D &amp;userq=
_mes_v11_0_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &amp;u=
serq_mes_v11_0_funcs;<br>
&nbsp;#endif<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB566743DB74BB4EEF6DE7D47FF24C2MW4PR12MB5667namp_--
