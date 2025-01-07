Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0807DE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 18:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A861310E331;
	Tue,  7 Jan 2025 18:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgFG4S6o";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C74810E331
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 18:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwayaxX5CAtsEXTphzNHViTePVX594zGt+wRUMTFeps0+2hzs28AhqKme+6kgz8aBXoq6xGzcQwMLg45pxZgOdt64tCIFfVW7Vm3piBOiyFtL53YIFJxsWpQJffQrj4gI0OyBveweaEnwvvYZwZ/k7Q7qwfjnrEzpqaGIAA/clQDG8H64Q5+AoChmmSekdtVBRG++Lq7h/K+XxHbMm86pH05YIM2DWz/VxuQMIJUERwZcZyUfu7tl7PcYGkcApgKVvF0ZXLBAOveVTgpdvZUm8tHnc4MjB56kDMX2K+qNLZ+cz7+YHPKmRG4aCwb+gLiQegJUh2DZfWuW6qBzcL/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWZRErL0IZlM1UjlHUVIX9eSgL4QyQTXjP/Qha9mcRQ=;
 b=XC5o2Fpp8RssW0Txu98jg1ltDbWEcwn+bPUHrIfQrgfZyJ89HUBD0NS2FvRADNkiYbO9q/G9yt5r/lU4/+3z8y75PeVvw4Tc26BdgGHmJhJa7p+/7hRsjyXGEKimYiOv3zTrXHsQ72JPu0vyx2ujMz64pByf44kFIklnQFRDOvVZ4agzECNUBQY8c1/WeSGOXKFsMbuROS5TDeExy6jo+wxoDMlOo0y6bx1nsVAEzvB8M9w1wG25so+RHY0PyNtgG01jMY8hf4oedVlytUKbOmIYpLb3qvBfvYYpeaSmTL15h6oUUvdBvsVbkPKb3u+cpIzvT4Ihn81dFdKuwkaV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWZRErL0IZlM1UjlHUVIX9eSgL4QyQTXjP/Qha9mcRQ=;
 b=GgFG4S6olmA2wzOKOjzKTY7k+KBAOzpm+EqyWcU4q70YuXOop61vsshVDLXrxJN85FwgjrpeIK3qZFtj9uCeZkX0XLahvwhwmA/LNpbazzIJSEFeIFZIKGZP9DdDM0/Yij1hPEN+oYOEMv09rki0b/Vp89BDkBNNiR82SB5aZjM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 18:53:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 18:53:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH] amdgpu: tear down ttm range manager for doorbell in
 amdgpu_ttm_fini()
Thread-Topic: [PATCH] amdgpu: tear down ttm range manager for doorbell in
 amdgpu_ttm_fini()
Thread-Index: AQHbVUcoTuRYuinB9kysgMejvUBkBrMLwC/Q
Date: Tue, 7 Jan 2025 18:53:20 +0000
Message-ID: <BL1PR12MB51443164938FB99288E9C829F7112@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241223142939.819712-1-kent.russell@amd.com>
In-Reply-To: <20241223142939.819712-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-07T18:53:19.647Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8319:EE_
x-ms-office365-filtering-correlation-id: e2a9cade-da78-4ce2-adec-08dd2f4c8de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ga9a6YCT4g4FMLplJEPtJE2I+PPclv4iTaDi6n6SdCl9i2Aan4wT+Epd1OOg?=
 =?us-ascii?Q?X2YjNDCFkZojK+CqaO+5AU6DlSPyNB7fADq4RMzSsWoAFw1F3KWzq4jL5Cnf?=
 =?us-ascii?Q?jdKVXM9rKQcXYS2BDJ956I+Uu7p+XGUSfWi0e8It9ICDFg8KtRUNGnwbGEeC?=
 =?us-ascii?Q?oeh84f9KXSJ7RvGdFNY2f/VaAsRrnJiGMpyBg5n625vrdBJYL+8Fa5dVCjOz?=
 =?us-ascii?Q?bKayoRhg4W9uJHOsm87CtRYpPZp00sNRKmFUJ4IlfQaQ/ZpB8bgDAaNd0SFz?=
 =?us-ascii?Q?lfHaXU9kqTY/WYbOnGRFbdCkPoUlou08xUkYFCs2dTRKeWoIVtamh+Lvt8mz?=
 =?us-ascii?Q?xawjvE+vfzXP+OqFlbDmJqbBh+fcO+202QWyWBBeUzZ7IXo8YJ6AMSBbU+cM?=
 =?us-ascii?Q?JfJJIvzyf+kuXtusCJ9Re1ezVLGTneWXtTpkhB9MdSl3+ipTcx4BoW4luLQv?=
 =?us-ascii?Q?kHKkQf1WmhJGnYnCqoxjJnqcBQOsj9gFq8cwriSNX1snivnwfp9KAekSUan1?=
 =?us-ascii?Q?dDL69pOgTOJ1fr8qX20J2hgB37znrPd9Y20fICcM0K3R3bdOL7ecBSHIxs8I?=
 =?us-ascii?Q?NHDzrY8rL+lsxPMU1kGALLN6/8ChLYyvT+bA+qpN0vqMH5hB2aO2FiVJImwM?=
 =?us-ascii?Q?8tNGIQvHywiEwPLNfD6ngqRlmIljH9PioGLDdqu2q/Nvpga5IyYriopnEQyX?=
 =?us-ascii?Q?1h25cpo2j3QMWltAU9HFIeUQ/9hgIAiv7oyJkanQbm7TYmkRyodo7wshkbFy?=
 =?us-ascii?Q?kVqqoUGOvwWg3B27M//T2nzmC+O6UC0TEtgjztIlnAfexYeBAmNORoYiACd+?=
 =?us-ascii?Q?ZB1FyIYhY62FOlGQywFBmsmz5rr8siNHFRtjV4jf7oOOLAIdKZSiHG5sBxcT?=
 =?us-ascii?Q?LiqXm4DtsD+wxYLBMVsJD2Z8kUG3Px60CESs74vgevhxqJdhKIKwmCKyf34h?=
 =?us-ascii?Q?1DZXXDlkeeovBk9pZrQCrjFvJcgq31os6RU3NYTBAsW2zSQJycRMfBQzqhE3?=
 =?us-ascii?Q?/D2k7GPt9l0lpwVvXBv4HMNrA2upwTBtPxL67B0EO331MZR8Tm5RNK0ZAXwW?=
 =?us-ascii?Q?37i1AxVDlNUXpUOdw1YKhpkSyszop7lWbf42xjt0sDiNRz7i7VmcQJVbiNY6?=
 =?us-ascii?Q?F113/Dlf+zG57fBhoDSLlMPFzDfitn9hHddg1f7mhVTJe/1vrtLsbIl6kfwJ?=
 =?us-ascii?Q?tB1zGtyvZQk1nAitvzxn+Uku0/E1PXmiORr6OeENfsq7HXhjO8SPqzrcFb4y?=
 =?us-ascii?Q?eiUXmrLgpQdSaJGR7O5Ko1W3bNmNK4bm0f76QNximVDZ05ylzQIUvZ3vQwX2?=
 =?us-ascii?Q?S/0keGiKqSY/hSWXHjavNdspjmr+F4ZnmurnleVjMW6Cc7L876dU4AhbQEID?=
 =?us-ascii?Q?yTZTDjTT0CQhccp7u1q6OXaS+iz3e+LLxnfHc+F3K6y7PX2lj4G9J+VehJGx?=
 =?us-ascii?Q?pAZsRDD+MQTdtTIlyfNRiu+G+k9t5xdS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zomh9Oi8cpuc4erBrB2pXbSAITUcJKeq0tQHrQXXPcmCFA+qQiG0p50J1skL?=
 =?us-ascii?Q?7CVposT6jrbNMzYNkq3EBZ7XbBQJALDZfVnC5eJxetOIa/YsWGPDgYI/7o8w?=
 =?us-ascii?Q?LytgCy0vlHQrnLwdH9sQ7DzReAK3XCC8nAAs+psp3JUqFbwvKUtsqE0au5mZ?=
 =?us-ascii?Q?3hMXNu/aLd7j+q+JS1K/KhNme4wFHpr32wVO7JU8v3VQrKIWV0s0wxhbQnoX?=
 =?us-ascii?Q?1ri1yo/2E/6Uf2pbKv96nNSNe97K4qTYfmo1EqVV4+dusVA7ACCVNPd6XucK?=
 =?us-ascii?Q?HbrzkifmFNOzQQJKLCZ6xh7u1WzLpUkzDkjNzpGkPcqsrBpEsz9ZzioSO9gh?=
 =?us-ascii?Q?QPfskRWFlyqyVOoOCgOae32pXMzO2Qf6jNDXkcoove8jl3o98CUao0ZVKOUR?=
 =?us-ascii?Q?yc+HoKQml7U3j21TCTAOqnKVe/L/teJDbxclxaVD7PLQrH1CpYLHAkg1q8Mu?=
 =?us-ascii?Q?/fHWYAEWU8V/zzDFeFOZzeDa/QM6Gy2TunW8ZL/Kmfw/qyysreH779D+Dm7P?=
 =?us-ascii?Q?XpFJYVD/mSdkst8XiXDvdS9tR2K+ad9QmjLu4Xa2PUXESdVIEC3Y+Wq8m3D6?=
 =?us-ascii?Q?tlwgA5FwZYVTbHpzmmbRXqCKEmPuJimdb4Z4qjPg8n1yEUj6P1GRdaw5s5qE?=
 =?us-ascii?Q?RX9qIhmRv4n1bZY36dIiKSm5nK0n+XTJoQLkoDNyzTxZgtstqtyUtHwnIVlU?=
 =?us-ascii?Q?oQ8gkx+LNJ1gJQIQbXbF7QGldom+uR3nI71e/M71UJnjsurTIFvw/pnhcNrO?=
 =?us-ascii?Q?JJsltZhvJhyFFls/zl6U+v2UGYYxay8FXbH50FK+mHam8ucn/4SIk+QyiFs8?=
 =?us-ascii?Q?SImkv4gtJZVqUITMXkJJAJ/wMXc2rLIyw/6Rge4V57BqP7iNuFkizsG1kZaV?=
 =?us-ascii?Q?BwLthe/komVw7zWbNZ8eJFQkayj99KuNOVzCOSc/er+jtdoBSxiYmZut9V6O?=
 =?us-ascii?Q?00ZX+PR2Qcn/LefIndHYLCVovwi/3QMYroXb9VzRpH+Mb0ynFfsIPL+OzJ2J?=
 =?us-ascii?Q?53XwFvogK52ZER4PX/tMtQlQnmOvQxQfRQ/3pwvC4mU3GRWpu3QCM7VMAwDx?=
 =?us-ascii?Q?EwsO/xAFbF+kn7T/4mm9VmR7Y+S/rwhgmthT7GDzLqoJ5pSShT1hLKI5Vh8b?=
 =?us-ascii?Q?7QL4UsMeSLuptvnyiTDOcvf/kLrw7QHKPY1UUaBHxbbCN8wXxNIvEQ0vF/Ba?=
 =?us-ascii?Q?yhB4sDRvGjg0TegPoEMWCtIJWtBLC3CoWEsydvtIdujL1g0udLKWjwRNXM2k?=
 =?us-ascii?Q?jhPYM+mY6prQ0J3sCooOxZ4JspCmBpTSg2k/1K6Nn3EPo4hEUDflT6MMFeTJ?=
 =?us-ascii?Q?y+R7oftkuQs4vb9DHUZexLBpINu0hukp9ZOxvs3CP/Z30KPHKFV4bBm/nwPG?=
 =?us-ascii?Q?u+y2nnLkO3lxAerDNco2qL1CMFoDiDW3ueNdGE9Pl84RktWxQjoIbCuKIfXa?=
 =?us-ascii?Q?2gZ3L4rr7Heb9r3OKKRUWIKgp/N4fhm18J4dMzJ4+BhGIuXACTBjDgJ353dm?=
 =?us-ascii?Q?W0NnOJescIDgImvmeiZMLjjFhwGv1y4SMOqdJhDlhovKwq2NDkfMKMrARozT?=
 =?us-ascii?Q?zLgT/6TX2MO8hu57VxI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443164938FB99288E9C829F7112BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9cade-da78-4ce2-adec-08dd2f4c8de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 18:53:20.0709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bN7stSydxAEd1iJmlZIdlBXK0bP9Mavm/jPSE1HXaQRJUTJ1eu9RkXGJ+GCV7jtWG6aSyUXGGobbmbZM7yCLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

--_000_BL1PR12MB51443164938FB99288E9C829F7112BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Monday, December 23, 2024 9:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang Liu <gerry@linux.alibaba.com>; Russell, Kent <Kent.Russell@amd.co=
m>
Subject: [PATCH] amdgpu: tear down ttm range manager for doorbell in amdgpu=
_ttm_fini()

From: Jiang Liu <gerry@linux.alibaba.com>

Tear down ttm range manager for doorbell in function amdgpu_ttm_fini(),
to avoid memory leakage.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 9ff6cfacfd34..e6fc89440210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2066,6 +2066,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
+       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
         ttm_device_fini(&adev->mman.bdev);
         adev->mman.initialized =3D false;
         DRM_INFO("amdgpu: ttm finalized\n");
--
2.43.0


--_000_BL1PR12MB51443164938FB99288E9C829F7112BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Monday, December 23, 2024 9:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang Liu &lt;gerry@linux.alibaba.com&gt;; Russell, Kent &lt;Ken=
t.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdgpu: tear down ttm range manager for doorbell in=
 amdgpu_ttm_fini()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br=
>
<br>
Tear down ttm range manager for doorbell in function amdgpu_ttm_fini(),<br>
to avoid memory leakage.<br>
<br>
Signed-off-by: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 9ff6cfacfd34..e6fc89440210 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -2066,6 +2066,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;ad=
ev-&gt;mman.bdev, AMDGPU_PL_GDS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;ad=
ev-&gt;mman.bdev, AMDGPU_PL_GWS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;ad=
ev-&gt;mman.bdev, AMDGPU_PL_OA);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;adev-&gt;mman=
.bdev, AMDGPU_PL_DOORBELL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_device_fini(&amp;adev-=
&gt;mman.bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.initialized =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;amdgpu: ttm=
 finalized\n&quot;);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51443164938FB99288E9C829F7112BL1PR12MB5144namp_--
