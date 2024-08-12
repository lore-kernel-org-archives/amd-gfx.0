Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3DBC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 05:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0CF10E0B1;
	Mon, 12 Aug 2024 05:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GfeE2E8c";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A23710E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 05:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIe5Nc15tdMi+bA1WRPKA/WJfYftkeb9eTeStNjtkfytRM7kVo6WmkdUnAu/0aHpK/tWiubCqaKOijpN/Do2ZhYRbRTTSASB4+vFpz6gH4SBV1ZfWO3DU5VMgL3eI0QTcFlhiBSuuHjt3Pku+LaAyvSldeJL5b0lYU3lLGaFhJ7cd796LJkHmhw9jV3L3XSYBV/4l0WkRZqmu7RpIY3gp6IKAAHqAlD7wKGPgrI8GG6PiP4pVwstnsZUCf/BYal9bklS/DmSPwtjk+69Z4wUPgs8JJNMgobtQI1tapSsa4vM6C8WaQGjBfEfKXy1kNjA6LpLDfkdb1x3wW60bDUlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=060NDZ/P1ndQ8dRKHsAi5EuczmhJO4x/GcSg7abaejw=;
 b=biGssN/R3e3UXVdJrJc42gzbTl6RRAbcI1Asj5NGx42SSNFSQP9RE4a9HxIM0/F0SPsRXY7PaLDTaJ1J5o1CJH7ScScRdQrB0u/Bg+VytImr2bNmET8scSzBXfwChiCG1amGZPdd5wxcZihsvPzLj4bawGnl2zXHN90mmQW81oJCXwT0nkx76Af/gNexz2W6rhP+6kjf/y2clT+olgh54tHXr9KTlrtELTaNkU4lIDkl1K906xJrqOTqq+XR1HG4nGWSz2XqDIaz/2XVHrdOgfbmUGQ4vKbt9tSqxqQ85hwgNjWllT+k5zTGVRD3d0t2pAK7+RD5h45bP3kGPU6/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=060NDZ/P1ndQ8dRKHsAi5EuczmhJO4x/GcSg7abaejw=;
 b=GfeE2E8ckuiGagPLfhqmcP/Bbh4oXrNCnh5nyC79PC+ULQvz2XTERmLBxnX1SVRrL4rmaL1l8H0bzfYYb6iWUIiM2fnkJySuRrqY7fphmNKyuhOPNhw35HdlwXTgUGvaQCBUV6/ij6benjLaw7XWEsMt9NDE7qWVMcenHJjgTP0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 05:05:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:05:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Reorder to read EFI exported ROM first
Thread-Topic: [PATCH] drm/amdgpu: Reorder to read EFI exported ROM first
Thread-Index: AQHa7HMWuMZCKBgatUKnm/HcdEDgYLIjEYzg
Date: Mon, 12 Aug 2024 05:05:40 +0000
Message-ID: <BN9PR12MB5257E6F1251A64140BE6F18FFC852@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240812044942.1670218-1-lijo.lazar@amd.com>
In-Reply-To: <20240812044942.1670218-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e00f906e-86b9-4861-b9ca-53a8a76363eb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T05:05:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8360:EE_
x-ms-office365-filtering-correlation-id: 81a697cd-79a9-43ae-62c6-08dcba8c694a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wlbvrs6EJb7dqNjMyARM4cr2mmtDqTPCHt+1SmU2Ng5GrTKBY196qk8XN+BR?=
 =?us-ascii?Q?lD1rgIYUQfq4E+cJouePTSmL1CSj1pSbvQI0QxlDAO+hQMTKvSF6U9xkEFSV?=
 =?us-ascii?Q?MHAF+Z3XXunwihOwUnm0UhtmZxxTIyn+SitGYAnFDrI1Sc8us3D+tVfWHYbi?=
 =?us-ascii?Q?s1qF5uuCRa8hxUM7UZq0SA+UBHrCx/1Elv49uZjQP8qBZqR/43riZ4ylXdpy?=
 =?us-ascii?Q?Fu12w0mfZMnKeHVYiKFbl7oqq5sMJpNx9IVLmpgwY6QUhGACSZctq+Gob5rp?=
 =?us-ascii?Q?pU0PjHlbFMBUyo4ZPl5/OX1W+xMDyhz461ECgOqWgKMLv02Qvuy1OnZoAp82?=
 =?us-ascii?Q?mfrWtfPl+LtpbhAidaUBElPC1qdcTNzyW1O63PX6tuHiWeSCVhLBmELys4kH?=
 =?us-ascii?Q?3WRBC7W9rPDypUwPCTjmMLAW/bsPwuRob/XW1C/vHjATFQy2qSMdzT3clcc0?=
 =?us-ascii?Q?FHS95LqTgie2fp4vv8W1BBJLH28jkon5sA2TutC6wlUhkzSFFJCjCp7NcSTi?=
 =?us-ascii?Q?WFrhILjtCePMzPrcdd3lMvHZIKiTfELA1I27undUqsztyYnfNF7lEj4BAgVA?=
 =?us-ascii?Q?3Ba7HnUHNNCWpRZ7aY0F1TiG6CQ1PHt38iHWVH8oUujo4V5Df6EIUMaeJWtj?=
 =?us-ascii?Q?wmiY3Y5D29F8sERIYoVSr1MfXd+8mUYb/CBSOdCt20uVkS41HmeYXtJ5wCR7?=
 =?us-ascii?Q?CgfyCkV8emX8Kt/WSx24yBaAnwygamFX1/9MmIP2huXLgfg6jQ9m9kzfg23o?=
 =?us-ascii?Q?eFEfAux9a4cHwT7imkpLhaNR+UwXDgI/K63tZPXPGnubp8H09QV81py2CKoc?=
 =?us-ascii?Q?XY2pVLisBwN2J12Clt57PGPy+1QNLOyh31t0Xqa7TNIGs9LkOYDmfmLbX/9F?=
 =?us-ascii?Q?t4fYt2UBlLsO2Xc74FaUZTU994Hp2CgQNmHY4RX8MHLqP1viT6nyhQfSOQWn?=
 =?us-ascii?Q?V+33ABV4lZI+UskRnjJLqqf+3jiYqBE8+C+idMRpcyUf7LmLNwZoLiSi8w2p?=
 =?us-ascii?Q?JeXzoqDW+GVvS1ihMhIfw+tdZnEXxUwDF6bETEeVoM2tq0uzch/DkuFo1f1f?=
 =?us-ascii?Q?Kcmtmr23LLjou8VOgUgQIO6emVxg3DI2X21e91PY/bs79Rjh/j1M0pQRIEKS?=
 =?us-ascii?Q?eTLaBty8wfWi4cvpXQSV8sBaWjvCsOfgq/5CDTgwa6TCsDI7V5GPY+n1pA4t?=
 =?us-ascii?Q?gWUwqVYqOfddstzjCtkPrmdbPzZauvRTc4vodNTyvmP0kY2HEKL4+kiD4Tm+?=
 =?us-ascii?Q?L1PeAMQr1dl0r8smupQIxoFzqa7cdDtcq8S/KusjM8zpLZvCTwJlTmi9Nf75?=
 =?us-ascii?Q?N5xyT4HEktf5ffB1x/Dwudu0Ni7dvwNbnmArlXZ0Y1FXCEaMQ9J2vibWg/J6?=
 =?us-ascii?Q?EaIOFz21QHOOkIXinL+a1u24Pt7FGq+XHEpnCo8rgiQwexslIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0buu4XD/auwNn1lmDLIA0jXRFNB6nOItEfyhW7b53uW1MiGLnYx9qFPMISBO?=
 =?us-ascii?Q?jZTR333mF012VcIH4yp5+sZnRusTY+1aXQyZ2KoNMMdMChdOUcdwCWsJ/tTt?=
 =?us-ascii?Q?icXCYHdcPJuXLGys09/9lN82ucUf0X+CGO/1nzaCu0xlP6SZNX5nzF7D8oB4?=
 =?us-ascii?Q?10ejUEMlFbaBEWyB3Bylm39fZvYl1+uWD678nELK1U0zXVrqsgvJ70WHLaXs?=
 =?us-ascii?Q?+O9BGOtVA+mSkND5l+2VNZ9G8gLZXrxbkLLKNsHiqvy+MyBDqOc4dDB+hfvZ?=
 =?us-ascii?Q?4FhmVP1TxgLd1aLRerSP4uCdXFmK7LV97ztxc9YTURdYsicEHi583R4x72uU?=
 =?us-ascii?Q?ySNpcWdJq0ONu9I2Y4WfJ1HI4ePobrxCHufa8/dSFcxyRt8yj9ut6+egYw7a?=
 =?us-ascii?Q?DBrbX98wvn7S8ar1plnn2k/W/klNtF/dzlULXID9+aoxYOEMN627ZTmh0Xk+?=
 =?us-ascii?Q?fu0LEPl8TssRX41NqKpbogAt8Kd+tqyVauyNiMBy4K5RHdc7q34+eVjevyPL?=
 =?us-ascii?Q?F8kFMtkWDtzdU4uxUOxCvQqoJhTvn3YzcVh5mE+vlT31Vr77A6SjmljuaPBP?=
 =?us-ascii?Q?F2pUP4MCc7Kd9Gk1MrmxWWTnSLHq6sMVnAxVE9oHlbH9AKaYuForSIH8dfux?=
 =?us-ascii?Q?rRKALP+ZP6/+dmZ5TZ9Mq0eotQGgVTo2yh5eivi43uXWVK4/18EmHyh5kqA2?=
 =?us-ascii?Q?uH2DzrdmVOmnb6rGRVjC7Hqy7oHh+sNBef2x3ngdLzDOR/MYoE8sG/OWp6sG?=
 =?us-ascii?Q?PCgO10VwcTUp5mZQRJF+Ez8DbK7WlLWBZ02Ln9IynA9kIuSEziKP9i81x00o?=
 =?us-ascii?Q?1RTyZvUy3GEa+dPCiE25yc5W/rREcIfvMBFpH0iSd5rrsZ2qPOX+R9t1XOuB?=
 =?us-ascii?Q?OuqUv4O9RxCN6tfG78S5L/5fZin09NYRqffhj/mt8HHOv/A+DZauNAJ9TqoU?=
 =?us-ascii?Q?8ow8LHr6EAmnC/D0Rrzt/W0nE4V675DxvZiqvElBPQUF+v8q76rrWmxS1Z9p?=
 =?us-ascii?Q?zA0Kwe0crfAa+/r/f12scYEhWM/LyqLcPtyDOsiRKlhivzQHxZzrq1iiLr+X?=
 =?us-ascii?Q?reo/tT9KnZXSDW2vQ/Q3vHlAtEd8hc1BhWLZmNf+e+vhxyCJpIf6si+nFRj8?=
 =?us-ascii?Q?4qUcWYU6FRkD5UPE9fbWTXOetHBeBAQTs1p90nEuOdPR55zLl3CBLJUQyLSx?=
 =?us-ascii?Q?mRybgU+BqNNc5pNadfTpFsiA4iSHNcxQ3dnq/HkCHuQw9+YrOS0LiWAD2Liu?=
 =?us-ascii?Q?yihq7ZmC/SsrLgJ8q1EFKw91RIbt8Yx5eAWbxK+CTOAX/PIQFYmsVyANYQIl?=
 =?us-ascii?Q?dN0LRfm36aOZB1fpZFiO1AF9IHMapW/pa7rdkKYgFnLRD5xgbQ75wuhEWvcP?=
 =?us-ascii?Q?h8HdW+yo3n7yDKN0Y6hvkJp2qMvyDqdB2lXGVZrSMSUgirzrwI9W/0c6WF1z?=
 =?us-ascii?Q?uMl3wsFohq4k9OI/f9nC8V3Fob69tUsT0vcqTz8VYEncL6O5GuoLVx35Y7Gh?=
 =?us-ascii?Q?PaYZM/Bex8d9LgjGy7ogT0vTvYCHAtZVuU+pbD5HHnm63KgRu77eEyV6oA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a697cd-79a9-43ae-62c6-08dcba8c694a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 05:05:40.3923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qtL/eDo0/C/PYxa5b9kBQvPVjKqo4Qn1SEdJZQTaGkg6Qq0hw4z35U17fVpQFnZGdjWpcd/VgXeCNkYsQ59nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 12, 2024 12:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Reorder to read EFI exported ROM first

On EFI BIOSes, PCI ROM may be exported through EFI_PCI_IO_PROTOCOL and expa=
nsion ROM BARs may not be enabled. Choose to read from EFI exported ROM dat=
a before reading PCI Expansion ROM BAR.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index 618e469e3622..42e64bce661e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -431,6 +431,11 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
                goto success;
        }

+       if (amdgpu_read_platform_bios(adev)) {
+               dev_info(adev->dev, "Fetched VBIOS from platform\n");
+               goto success;
+       }
+
        if (amdgpu_read_bios(adev)) {
                dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
                goto success;
@@ -446,11 +451,6 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
                goto success;
        }

-       if (amdgpu_read_platform_bios(adev)) {
-               dev_info(adev->dev, "Fetched VBIOS from platform\n");
-               goto success;
-       }
-
        dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
        return false;

--
2.25.1

