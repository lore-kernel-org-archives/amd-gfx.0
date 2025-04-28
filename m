Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAB5C3ABA4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B415410E48E;
	Mon, 28 Apr 2025 12:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkb56k44";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878410E48D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpE+6wRJoGxSZdNGDoE91t0eDEQO9bccxK8QBx6ccAtUrEcaub/qHlVVVj4X2H5puACvo2nzhbAjgdTnoAzFCJThtoJQ3oRwpevZ771K5UInpEcjoccpZcZJ1+kZTwwv1e3bY7FmCeyVEeidvLTxHtcZd+jx0ps+MRdZJecyrQO1qLUzklV+ikNqmhJctDrvCiPwPwQIGyFpwfE0A/R0zpi72E7JL2ueVyczFjG2HRlsdwDnG6ZTcrMvsdYwM0p3Pl2/w74xyDRoA6OoqW9jB/Gi0ij5pLB9dqrfQde/+n6hPDYjWRsgdSqxVnHa0vgRwS30nAm+3NRCjXuXUCliKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90kJ0D2xVgwx7ZIQ6lqbNuvu36ZfnGHjbMQR5hHkRb8=;
 b=pMrQ0/zNaeGwTbc8CoRZVxuYgc0DC2NTheouba7idvrnNxKbobedIgIQUg8NSoCFVTxFabjQ/IuxBjTGp6cpfmpoQunjOZTRgyU0azwt4MOcJvhEsk+qglnnADrfaLhWm8olAPYLCOn93939UmKlRY0k5vEGJKpfOOGGkyHF/gn9fNA+2hDU/lqEOOWGUVClQyUQfi3E27wUa0Vj7v2PuYA7L2fSIaohTasZrlHptW8HhD0Eah1VdvrNFSpgQhM4W843tifR+Sdl7GN5Kb4ivtm90YrfvZvgp/vFac3kpA7yTIuaWwAxblR+jUeESMgvK5a5FN3mris7kGvTVW7CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90kJ0D2xVgwx7ZIQ6lqbNuvu36ZfnGHjbMQR5hHkRb8=;
 b=pkb56k44e512xHMPrkJ/IHOrmQZmi94jm7t4nuJCPbGvQ3uCyqxROUmf0uf1l0mH8QSrHuOXlbytGxLG1udKhnMPXRyOJoUYSOFbyWn2SkmwPopURNuf66m4cIpZmSY6vTCztTtRoJS7UlO9gM6IXU1Iol5NFE2v4he/frQzohw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 12:29:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:29:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
Thread-Topic: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
Thread-Index: AQHbt+bvgM88QV8n40S/gOBxe9mH67O5AoJA
Date: Mon, 28 Apr 2025 12:29:40 +0000
Message-ID: <DS7PR12MB6005971B5F8CD9CA8C045D0FFB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250428024010.1330997-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250428024010.1330997-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bd278f73-13d5-4249-a25c-fbb5d4ee05a5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T12:29:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB7375:EE_
x-ms-office365-filtering-correlation-id: 831c6930-7980-4b0c-8c5e-08dd865058d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZODL5QSD9xTzNkcVk6/HO9tK077WaZyxlp5Nn4m9Yq+g34LjIYCxK5xm7TbF?=
 =?us-ascii?Q?qGARfSp77h3Kx70kWTlFzsAULnZsxylKZOkkCsaIoV2vRTK04KrGobPSPQVc?=
 =?us-ascii?Q?Mf70s28+GpaIJxk/B6u6Kbzsp2wMEGWpI68vSbEcnTjGZziKJ7sVjtmBzjgq?=
 =?us-ascii?Q?FOP/Zp9xe2wOeeNBFK9zg5W4BdSCt1inKSyWd6v3t4Ww1kMrvrALJ6PyQRX2?=
 =?us-ascii?Q?Cz9C59g2L/jWKkaTGlS0Lj93GQdcB5+fQwnv77K5UyGgITQAKTpgWcIJHCTI?=
 =?us-ascii?Q?jZM8H/Wd2brwsyfOmXZW9056LA3mV9og4R/hd/oiUxs7ExoHQSYDTeDJoEuo?=
 =?us-ascii?Q?qmSwOBX3pIF6ZIedl+l/GX7RjWvf3w+2MHnZnRUWUbjY1NtGVYzhC5lcPEHO?=
 =?us-ascii?Q?LnAw73hdAAg/czvcLh7sZYNJJ6OcpYOsebohNmouPpTp3CZ/yVUdfpPZB+yf?=
 =?us-ascii?Q?XvuRJIyz3K9Ywmfw7Bge8/bL74tuYgZL/1PSm8Ofv7AVJmHAObh9BAl/JuWN?=
 =?us-ascii?Q?qUPzkg6M7V3RSi0NAdTOLWYJHK58rnqco8XNdvCPtRug8otOThUjcjgXTiZy?=
 =?us-ascii?Q?ae+kN5iPnuSoZLXg8cPZE+gGUeANr2Zp80+4QYZikHm5uaYNUzVqps3gZn2Z?=
 =?us-ascii?Q?KUeJ8OE0CPSgmk8ZYSAzcizgBS4qcOoWTImlUX8EtuZt9jrgO+9SMHipVvHS?=
 =?us-ascii?Q?sIk3oUvSm92CCTziguMhLZB266WKEsmRIQXidkhA1xOM+2CF4cDyWDmCKrrb?=
 =?us-ascii?Q?+0s+61tGjrf8OPc5vb/zXaeUiguPSdUEJvF147j4C3Nw5PMSbDDHbVoEKN3m?=
 =?us-ascii?Q?dcJRgna7O0aWvMfxWSUVR9+Ofyg/Dys98kzdkC1GuE2aOZG/7jZOyOojfCfM?=
 =?us-ascii?Q?+Go7KX541FviPJzG5SxoWGj5dnAiS1MyMeNnpv45XNFp6PWSIsGhc/SrfE6M?=
 =?us-ascii?Q?M8vfJCB44QLD9GPGGztpsRRla2kNUi0L0DNFcXR3Sh/JeQKj0nYbcIXzUmnu?=
 =?us-ascii?Q?Du4RCoNR4htXWNOMwycp2OYnv0bgsXG39L9VjpyVDoTspUGDBkdz/CSlixMQ?=
 =?us-ascii?Q?G4kFXxzE5MVMzDmNE/1T7Gx0mj/5Xs0nQh9zfFkxSuvfPkiTc8F4bQaYFH4Q?=
 =?us-ascii?Q?rhJ5sYXu/uQXyEN5v84CZj2LMQ6b8ru+8oxyi/coY+/3PMioG2Hl0s/iAqYI?=
 =?us-ascii?Q?1vG6tCUQhvAnLq9tlVFfCIM9UCLJtMBxWZW03aWIb4XUh1qzJG5OjwjcvGgz?=
 =?us-ascii?Q?dO3e/oyOhbl3fzueAHrwFRV/20arNBKFyUcATMwJY5MJ7RpckQuzsXmuIyT6?=
 =?us-ascii?Q?5OH9WHUOlxhZ17Q9HS33s6rM+hCCY6LjU3SLyYS9oCtXrYgyxvd8mBqYIWRr?=
 =?us-ascii?Q?ilgFD4UebcJ1Hu12Byq+2y1o3npjX/Wx2s5NbxVyHdELz91QkMeOAKes+iCr?=
 =?us-ascii?Q?8919ZGzUizZXWf0CXyIh+IuZufSlZWHh8wvkxulRUYMq4DjuLh3S+shvIKit?=
 =?us-ascii?Q?te97kS3txCguGBE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lsgo3uaTQRzbDQATdvqJO98FiDUSBbmoRdApuxDYJPd+jIAfxqkaauz4kbYL?=
 =?us-ascii?Q?BlZ5keNDL+ckJLQf0RwJoNXkyw3Bq9H2d5E6/4S6R2YBnVhOnZ1aRfnAXh2c?=
 =?us-ascii?Q?TSxt84DqZ7fREW3UrQKSomkhGDTx0EGIAfcFj7IkmeswXrSaJqHf3b578TOz?=
 =?us-ascii?Q?vRUXaCAmq5FqtOjsvunE0bdW7P6LxaaW6doluJUshcg6XoocEq6ZV3dtBy1z?=
 =?us-ascii?Q?88gK51TsWVJelPrrhFCk7zemwkE+seD9zrngflm0TqycCl30g4RaCVAgC0Km?=
 =?us-ascii?Q?yofFM8znsAoKpEUPzYubNzFP97/8ObCx4Tno8bTJkfWsRZqwpQp9EeayOiiW?=
 =?us-ascii?Q?uIaHc0TwLshhOjD7O8viGd9zrbCoBW8zEBAgVu/klJ6FSdsoOkMHxF/XyGN9?=
 =?us-ascii?Q?6Z5Tg9Ep5KQJaYgVAqA8F1F2sT8fMpYgzaIcZ6WeubW5UXqbpSxtmb2aseQ1?=
 =?us-ascii?Q?1ScnxsnhnQ+CKZAyl17Q8wkFT9o9onrx+HRPKGPs7biEOfQbmOzL730K10Q6?=
 =?us-ascii?Q?lNaIWhxPUrBDZZhAShNXlKip+5A3wT3vSkB6Q26oJPQEp6w2sVKjiCWrFTEP?=
 =?us-ascii?Q?EQCREkyeRMWUVUu4flyQ6PNBqEeJvvkbG6VWRNI+I5A4UMYPQM0rHpbdFl7s?=
 =?us-ascii?Q?zly7UzXD2WgogyXnMrvAiQc5F+suM004ADEqlOm8UK8is4Gsez+Lxcee2g0G?=
 =?us-ascii?Q?bPaUdNCKaDJIM3CrVZ8Sf/v7fG9TsLr91ZCQ1wGzJIMf5hZ17ojYlIj+zK2q?=
 =?us-ascii?Q?rMvNywmk/FyPA34kP7EwrdItKhf59IfVOJLJjXM1jXbHUzWI+v5Kdk434VJd?=
 =?us-ascii?Q?Y8yJLihUU8sGbt+y3F7PQPpxIljjE2vEqAw1KGQoKBkOvifWzvBsAHvEnWhW?=
 =?us-ascii?Q?zzwBJySQcYItq+q+sQOJzJ+WCuVQnK6yvfUM8M2+B30wdWWVHBabSQ2dNr2p?=
 =?us-ascii?Q?nuKmDxkuOtE6mI8WBrU4X9+BxTRHUVHzRl9pZrehlgA4tHqYMDXz1DGH8AeO?=
 =?us-ascii?Q?hzgteWu4K1QXqDfCZuTlSG52HlxQQ8eQUuTYwBhQDqxagHSExJBPZgeD3Pg5?=
 =?us-ascii?Q?ZLG499njeoE15VmbUjqVKYAg/1RQQ+a12OQge0EaVV6/6kYj6UI1lKWzxzO/?=
 =?us-ascii?Q?IcM7BVAFxDvJj848meIcU8Nia9zhjlrc+hK0Y9sgBPJe6Ryt73PUXhnZPjoF?=
 =?us-ascii?Q?U7+3iFTSIMB00++BYtKlKYuop+HWw1b4un9JZB18gWFKGVkFgaTkg/0ZCXgn?=
 =?us-ascii?Q?Te6fyTWik4IgSGoJNIqlLDMHzGA67qvgGGxiBIXjhQcHU0WNHyWKWz6xehbj?=
 =?us-ascii?Q?bXjN963RkXIBrpLEPtsh1qV5HgQCDM/gojw150yby6tuCBHdHb4zRG6Y6C7Z?=
 =?us-ascii?Q?9BcrzrvYG7+QijG5FR71g6SSEpJc/VsgYFKlmp28DuguPd0HiT2sAi06XqId?=
 =?us-ascii?Q?GSLApIorYIOf8gZjepe0dQ7dA3KiHJZAzqx4fuvvG4Q7pcRVccdOEKequTV8?=
 =?us-ascii?Q?d1c65s6d+LLrPDoWNzmh0q+Sfk+4SN7ZjqqcLadQHdOv+6iaZt6D31HI/2Y7?=
 =?us-ascii?Q?1e+lYfWthEsu3A8UhLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831c6930-7980-4b0c-8c5e-08dd865058d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:29:40.2320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tvxsKeDd7jbQVSysXYfKXa/3XHBMlXhBiSfqcogYTMCujNWLpa5fI5bP/y0gfxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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

[Public]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.Zhang
> Sent: Monday, April 28, 2025 10:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
>
> The mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue functions
> were using the wrong union type (MESAPI__REMOVE_QUEUE) when getting the
> offset for api_status. Since these functions handle queue reset operation=
s, they
> should use MESAPI__RESET union instead.
>
> This fixes the polling of API status during hardware queue reset operatio=
ns in the
> MES for both v11 and v12 versions.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 0a5b7a296f08..b34d7bedc317 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -497,7 +497,7 @@ static int mes_v11_0_reset_hw_queue(struct
> amdgpu_mes *mes,
>
>       return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
> -                     offsetof(union MESAPI__REMOVE_QUEUE, api_status));
> +                     offsetof(union MESAPI__RESET, api_status));
>  }
>
>  static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes, diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 1f7614dccb00..ee8b531b713d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -517,7 +517,7 @@ static int mes_v12_0_reset_hw_queue(struct
> amdgpu_mes *mes,
>
>       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
> -                     offsetof(union MESAPI__REMOVE_QUEUE, api_status));
> +                     offsetof(union MESAPI__RESET, api_status));
>  }
>
>  static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
> --
> 2.49.0

