Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D9CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 21:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D7B10F601;
	Fri, 15 May 2026 21:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHik0zqx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C3610F601
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 21:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyYga8u4AJA51jaYj0DC5HVwRHamYzaumEvkdqSd+bUtJK2oYX+BeMKWUu8su9yFysqv/QVFrdBIZNjpzltLczg0rVVFhHlyzhOgKLWHZah9vf8KRLm0RDKqjSPqqm8jRmkhXLXC1H46TQKW81yMo6WbsFh7Rj2Qvi4qdVKqouoyUM95yruMV0xyVC1gsP5wwicNzialcVAHnhPwhZdWr/37XIDj0mvDASh+8wYR/QzBEjEnK7icCMStS4NKBz4WLa3u6bVqFdqEt23QbofCAOrUGxFJhwRGdk8sEO/WW9Mj+jPWdwxydDYDL25IAF2/ZWGvz6loe43cVRRvOnwWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6jQnU/5OfoY66jx4yJR7njHjuDFIOFq59L1wE1DP8Q=;
 b=Hz/ZvzomoWll/sV8cRJ+qZ91VM1tYQCSb3rvraANr0STHmViq7e4VxLngCPamHRMp5iKuSjZB9oB+jbgMQnt9XtIfgHqtilaBMi8pJTnboeXzoYyCoeKmacwy6g+H6pWrfT8fTt/5fII8/xvFX16eUUjtvPXcolsJVS+D3hPAeHkan2xvGxntiuFja5Qy9oQF2Dm31kkP8WiF82GPb2Cha1M8EBhC8ZVRLBg0Z/lLhfk5c3u3iGTNYIfebNnV5OGOfkSbxT04Dl6k032s91dhXCn6130mpZehhJhg5jF17BqZDgCgToY43N13cnd0p/fiuFiq9nylKRauoOBJk9NNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6jQnU/5OfoY66jx4yJR7njHjuDFIOFq59L1wE1DP8Q=;
 b=UHik0zqxBJkg/AIjGKyic90Z9HzE+Pgbm3HsgpgTrRBH0sdu1lJukG8c/OY8pUGZP3Vum6DcogvoFFbKYMCKHXKS8+O4ZPxWDcqug+yNUU1U8CGBtajaWPZfSmCr5NCM5rXibRBI3FbrzWy3744Spa1pB7Vj3ijytNxGBNsO0J8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9ab) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 15 May
 2026 21:38:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 21:38:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Check for pdd drm file first in CRIU restore
 path
Thread-Topic: [PATCH] drm/amdkfd: Check for pdd drm file first in CRIU restore
 path
Thread-Index: AQHc468ueAZSSER6hkevytKpzCEPx7YPnoEg
Date: Fri, 15 May 2026 21:38:12 +0000
Message-ID: <BL1PR12MB514434151469715B0A142A48F7042@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260514143651.3913199-1-David.Francis@amd.com>
In-Reply-To: <20260514143651.3913199-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-15T21:36:55.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ5PPFFA661D690:EE_
x-ms-office365-filtering-correlation-id: 522e770f-c741-4daa-e054-08deb2ca43c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|38070700021|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info: 4Y2/JjJy2/LR05KeD1oHKt3fTZ79+mCySIRyOZA/JDPN85ND7T3t+B8yuUHX4vqmuEWhrnlJb4/W6wCuoiPtLf1XVbrHIWzKE5QhhqiJ3l8YvHFK64mA814FE496gCr3LXyJ4TUDP15mKd7tAObqNdXrUakw73STVHK71nrNbSjASwef3jEXbxGztAiI7TC4JUmbXKIyEsnmffvKirjmk+jenBYiPK29gJCaOvC3RSE0IvKCQU0FozGNAjf3vRdWXM0GieKBSRxqgZ5uyddlAYVi8x7Z0+4nj/Mvp5eYKJ/zOQ0IdsEznZ6QPKazA8UcisZT1Rx24jD9VaPIQ4XHvSSMUCUM8x7W5Aa0IAFtXzZ+TLW0hnQiqO3ipZC+rCpmViqxtek/Us4DcE7hvbL/Tnj9vJcrbbA8FXACN+tn517x7L+IP6QT78tiLyWX2p9rUeiLRl+DsqRVosr/u2Vpecxl3NWmo6LlUPZTLSvdisQpmCHYFjdO+oHbFbn+jkjb1O1xy6qhf3fqKsn+oO8CyyKnl1USiIQuW3rdn6El4g6osB+x3JT6ctoo00NUvSV8W3ZjqXVaMMmyKID7SfVYEX0zw78Ta/KThFfYv0V7FXItuKJ5/MRpPlCs1blwDnUXRsOVL+nNZ+N2FebLr4glNnSN0iZMgXKYl2yZAj9Dj37fF6r8SDdMM4EYqLyIDJ2Uj4cQVCAGx2felODBDAW71kTR4Z98gDjVn5WhR81RxY9AbBP5MJdkvnP1QXqrGH5o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3cBYwBrKkRjFQuFyjy/IhGJaei+PJWlVobBhxdSte2lBjGfq04e3OwWIBSq?=
 =?us-ascii?Q?jtCKOcaNpG0QDY5Sz8USPdlYnqr7ojwnUYBvSfCqwOz9fHnWXW0r57debvb5?=
 =?us-ascii?Q?9EDde28egf6CbMaq+y8b7z28byTFo2CRL/q8otpxdQsucJTX47YXlfT8+whJ?=
 =?us-ascii?Q?BFQCOQWed+oAbaNW2EskeTpzfZxtADfhu3tKG+qnNJ59lq+Eb3kMxdnILxWE?=
 =?us-ascii?Q?HYitmX3sFUVlMipGsLiTvXBqn82EtCsewcfYdyEZrCOIoQqynNal2QD3CWPM?=
 =?us-ascii?Q?DrlDIq62N83aU033qUTBac0N59bz7z7VDVPjosbuQmjWYx58M9LUYlEgQeyW?=
 =?us-ascii?Q?oEoT5cY6sEtRY1tBcA++HNT9DKHa8+r1EqWxXF7rl0dpDl4ODcLNvrlVlA3z?=
 =?us-ascii?Q?ePIPEf9mjY2LANXsz+rH4xfF7FaHjiqyHmI5FG3tc3wk75C+N81jUIS4rJfo?=
 =?us-ascii?Q?T0D1u0evR5X+MmjsNDqI4SDOdHbRQi35ga2d88HxfH2BzMdLCdR51vYEGXpq?=
 =?us-ascii?Q?ye1Y142rOXFE2/nTgfpYF4Oa6mpvnhYabKCZmJDzaDwJJJpEzz66igpCdR5p?=
 =?us-ascii?Q?iwQUf33y6moVUbb2Bm4ekk75uYlnj0wNjT/NrvEbatYJUfQhxPDyfPTdMSFQ?=
 =?us-ascii?Q?d35QDVeEvOSsTQLwhdg5eH2KMRV3X6Ho7oqpDckcNt7f1e37GAqAx46ZBic5?=
 =?us-ascii?Q?oPQiN5I89lpLNm//fLYkPB2NnZAVIP2g42kfMletV5pUQHit8qWFq88ycb6/?=
 =?us-ascii?Q?pp6vT6lLgKQ5gHhvNk9nXM/yPbY++hJPoDDDluO9ASsJlirWt9foaswYaa+Q?=
 =?us-ascii?Q?ZMVVXYK6vGH6Zjit1VXEErinSWU/slUN+mi4pegMGBL6Bc9dhRaRUrsjXdSM?=
 =?us-ascii?Q?Ps+ap95pbNlMNAiIZXZN1fYF1h/W8oJg5wARfU/zQJgO5hEA4QUu8oRreoSt?=
 =?us-ascii?Q?/uX/nP05EmrbfpbFRqJ+t3kfxjJfd7e6zgh67liFFyUtushmzvuEJPt83DZl?=
 =?us-ascii?Q?cWw2yS6XOslOpSlGw200IQVauwHkjzCZlnqC4tv5suSTixbQt+DXiXcAUYTt?=
 =?us-ascii?Q?DN3HR4txgMm7aqCslNQdFiqH9wR8tLXuGUq+ybOG1vsk3sGzrLpweQX5rKGv?=
 =?us-ascii?Q?6KpROcoUkQlmnXmXjGsASGbETd27Q0RBCKh447+WLmDLH0pxO8mtQge9lbso?=
 =?us-ascii?Q?w6vHSy+uXLnuAWDV2U1TAzHwWZn8ABSXiPRHwdHdU7JPWRGlwLNoqOaf3r04?=
 =?us-ascii?Q?tnEctMtgBBQVWlPQn11MHBDozN/RnGSfIB5hZv9su3TR6rD7sJOB6VuCjDnD?=
 =?us-ascii?Q?pNxfbNKZMm8XeVCFamBLwJKiG9p5K6SdHepQF1jFEK3HZjqpYQgy56p5F2Gv?=
 =?us-ascii?Q?b2tYbkZneVQruqrGm/8+5kjD/rmc2cSaHLAnE7My1POmB6rz2BC9MjGaepwt?=
 =?us-ascii?Q?LetriEySTgQ7COsj0jzWxPCX/GnEnkP+C6s1NPGO9b9kDiNSzlgVn8sDh8in?=
 =?us-ascii?Q?ZxNdrG/xMJ5niv4KXsLT19xayNJwmYMVvzfFosbD7s5FKhORb4VaROPh1Fve?=
 =?us-ascii?Q?ICxW42RZIrRQoPT1ErV3yLR9M9JBJ5uQlj8UNmLj0FhgRuLuxSC5KVXVml60?=
 =?us-ascii?Q?aGnI8EAquEZO18cVfZGIYQkVFQXN6W+hTMZJ+IqYIL0IsD3vlcFm96A+3FuY?=
 =?us-ascii?Q?gR9bhXbU8el65M92pBOAqIX46VHsPtLR5z32CibKWc42P+xm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522e770f-c741-4daa-e054-08deb2ca43c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 21:38:12.3044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsXDcgj/YII+wz7kew12Gh6MVUxBYPAgxmxEOwnt2/Sk/roKVoBG5hZKQd58ZrUTKQpVcEXxyDTMt5d5LHX2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
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

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: Thursday, May 14, 2026 10:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Check for pdd drm file first in CRIU restore
> path
>
> CRIU restore ioctls are meant to be called by CRIU with no existing drm f=
ile.
> There's an error path for if the drm fiel unexpectedly exists. It was pos=
itioned
> so it was missing a fput(drm_file).
>
> Do that check earlier, as soon as we have the pdd.
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84b9bde7f371..db9223e00fd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2377,6 +2377,11 @@ static int criu_restore_devices(struct kfd_process
> *p,
>                       ret =3D -EINVAL;
>                       goto exit;
>               }
> +
> +             if (pdd->drm_file) {
> +                     ret =3D -EINVAL;
> +                     goto exit;
> +             }
>               pdd->user_gpu_id =3D device_buckets[i].user_gpu_id;
>
>               drm_file =3D fget(device_buckets[i].drm_fd); @@ -2387,11
> +2392,6 @@ static int criu_restore_devices(struct kfd_process *p,
>                       goto exit;
>               }
>
> -             if (pdd->drm_file) {
> -                     ret =3D -EINVAL;
> -                     goto exit;
> -             }
> -
>               /* create the vm using render nodes for kfd pdd */
>               if (kfd_process_device_init_vm(pdd, drm_file)) {
>                       pr_err("could not init vm for given pdd\n");
> --
> 2.34.1

