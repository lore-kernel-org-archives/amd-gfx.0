Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDED4C3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 21:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D1E10E042;
	Mon, 29 Jul 2024 21:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HD+h1U8l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904F010E042
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 21:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgrtMWiVYa4zOgPpidpvAyP6Zhmrid5dcO6E9iHFRHRvS88Rb0EXM7Jgl0pjIWV45Ii7A/olnsKFtLelGkGmN+JaslaasrWf/E8ZqU9gWiuShADVO0FG7q6xgM7edQBkX4BWtq+R9zO4JCgMhOS+3pz9sZbE2TxWybHVBM6Q85a1pw6DSoh5bJebzBcBlP5WryTs54ZUoV0MqRhYKsjSjRRtMIiDNBrRAbWzx+Zo4sYmfLokKIdF22D3DZbwqrzf/8cgBFPwgsgihOSrxbkrssVMfvQj/EQ2qfgZs9kDQL6l+qz8W5tHnqHktHHKHuQeKnm+3scYPR2k3N31ehzQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxKRX20oPnzZwzDRRzgOI7RGRQeqb2gVFrYUuB2tFJY=;
 b=ajBhcx8vHAEJxZaTcwhfeNd1MuVEbJf+VBF1h/MuyZJqqQLiR6T7o/ZuHL7BFVKE3R++GmiLwNe4E65dhzUImCKKDgGa2xmzUNt44yEnJyy5QoZyDiZ696lVAqYJmUL2IYgq8Khxt1G/ydAUk0tbWesl2EVoUBYsGzhm0EW/s11CV8MPqEN9M3VZtVEAiuzzgRK//nO3eCKfYhlwxu7V/2f/q8JEDHWU95aaeWrF0ZdKfpUJsNZZo7B25Mhk3lZfXsBSQ3y4YJRm0+DZETy0dQVX1wT5OdqL61i0dEHwU3WjNVFA45rrNEOYDlbLWczH4xBQcmeQvESTZ0IHWSQgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxKRX20oPnzZwzDRRzgOI7RGRQeqb2gVFrYUuB2tFJY=;
 b=HD+h1U8l7jYhlQH1R63m3MTDaftSRy4/gOvEYEOoM3nVJyq5x9eTm3u2Urg8a/hLmoDmgmEPYcZwX3vYUpgk8MJUAhgMq5/ADVya0dMIgfLUzORQFu2JuVb4gR3QHWah4gPMAs5btzhzAvKDHb1utHBY+00lc9+B6vGLvpYcVcM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 21:35:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 21:35:30 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Topic: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Index: AQHa3Gj7DVQ8R62dXUymO+7JFXFLHrIORV1Q
Date: Mon, 29 Jul 2024 21:35:30 +0000
Message-ID: <CY8PR12MB7435344E11EB3A4952D792BF85B72@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9b402556-39de-4b46-a7e9-c6eb8402e11f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-29T21:34:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW6PR12MB8707:EE_
x-ms-office365-filtering-correlation-id: 1914e831-5cfc-489c-f5c8-08dcb0165ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B3VE5DAeuVWoz0WKa/Z/DII0IqHk4SONz9XISdR26BuhS1tA3RLQy517r9CQ?=
 =?us-ascii?Q?e6aO7SYjc0S7Am26+lh27t9OxRv2E+2QUaTHrbzURX6IoxwPpLfsvxycYW63?=
 =?us-ascii?Q?RE0aDmDP4ruTcSR5EFx9ZC7gv/1gy7qNkfHoQJcN0KIc4fSFvzSBezemVvEt?=
 =?us-ascii?Q?3GesCk0F+iQKwwJdLspxuFemZHrJJkOCge7xRQtjjKznjrRm7zKLQ2yp3VoQ?=
 =?us-ascii?Q?9I7PMotmPEBqQjoJjIUCYph0gPJ/TawtKqTtEIRK0ABXenmM1vsNdajiL/DO?=
 =?us-ascii?Q?zL4BqOBwEQ6OhYVEKugDach6lcG9nxb1Nk0rgDo1ccjTCHd0lcuXBH+M2BjX?=
 =?us-ascii?Q?AD2m0SCsQNr0WC0AcaXzGpZf7vmtTI+H9EPMiCrxEaiVrJd+ohgUi414ns6j?=
 =?us-ascii?Q?Xyk6NsnQfb6RGzz8au1yyYn3XP/6s6Q4gPs8bdRTW4bfa4ebnn27r5BNgRDS?=
 =?us-ascii?Q?r2GW0ZUJTqgnrXdSdjS469pw45SfIja0IdLf29fswgE4alNkwvSk/xNDlO34?=
 =?us-ascii?Q?2M+miPjRp0k4hcd5tineTqukntKWBb0nqHCe/87uOHkWzax+NDnC1xu3vgqQ?=
 =?us-ascii?Q?q4NXeqlvNTDNYRH+we8DlfZsuNvRBCOS3a9BKVeqRXW/7Ia7QhyAJjyxtZhq?=
 =?us-ascii?Q?eMBI1SDVxZdkwuHvCSS3yvpwk97E5qOk6qJGObxUoC6WPAxqFz3g3in1qAac?=
 =?us-ascii?Q?romp0k+E8vxDM3i8DUkL0JMQhttSaO8Bc0Y5+dPiqi/2SFHtYnc2pnBm4xHn?=
 =?us-ascii?Q?rq08oMBsGfzABFUcdTmia+2e5F37parxqaIM6HLrlEWuPb5nifmA1N/SBmgO?=
 =?us-ascii?Q?JId61fyw1fnK5u5P6mP3UXTdOV2VV/4liobv9BvJg1CMiUiaExWSEBoAL6Po?=
 =?us-ascii?Q?/d/SRLZ/jNFq2Y7fJm3ylud+EqS84QrcbGLmHOd2NeRphaGD6uAG0a3K34Ae?=
 =?us-ascii?Q?R5Joi94ZtMYZ/fQJAmdiNmoPaE+4fhQGBROWstyu8yVq28ZwjQAmyTyiqBrg?=
 =?us-ascii?Q?VbJMTlP8l5LPB1Pq2rqxftDAi93T4B7WLVpWeN6GIXFaXmPOKFmmvn0URzcA?=
 =?us-ascii?Q?nXARbhW4i84qS4KZ27BfvfaeEllK6RbaMcKv3jtmrBpwSAVNg+K/jDJGImZv?=
 =?us-ascii?Q?nb2CB2GQtCQ0i34oHB3BTbiOIfLwW+8ap9NuCpEkGxjUUwcpl1zuCBgy+kNX?=
 =?us-ascii?Q?wMu3iCmx+ezroecVjvJKV3jIQSGBnihY2h1OQDgLzLQHU1PFyGk3Pff4tW/d?=
 =?us-ascii?Q?buQnM1PkuzZOi3ONYZNvhecWFo8SgITo3VykrvlVwcQPmVd01fb6sP+6g0Bh?=
 =?us-ascii?Q?WaDkBMhsw2Jm/0iho40EPOnw98TIDNrxVU6M+j6tMzSbbDAy7u3ZrdaZ3zfh?=
 =?us-ascii?Q?OZjACJOg8/f498ur6dpz+qLANws7O5TfNga671Iof1PfgYt/Qw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0bMjBhqLeXbVQgMStHXdJ99+qczr4rv5P40ttD/JQlU3O8SnKU2ydlynZnr?=
 =?us-ascii?Q?FNtX3rO2RPJxr4JTScqCFw9xbs9Iy6HgEnoaDhBP4Rt84gN6RSWbZLhdJz1Y?=
 =?us-ascii?Q?ExFxFtyf+FCPu2monDlhukFeVo1IpkUnaCH6dswl9Elatrl/3oUflIZI7xvc?=
 =?us-ascii?Q?ofwufegunAJfPP0rWy51V2VMVNPwGKnzCCnqhkGBUeeY1uKovp7wpNlyjHt8?=
 =?us-ascii?Q?j7nGzCvzFYA16X3Ez37gRjliWUlzZUXBtUBiW96V2OxHuk9I3ClxephGKlqj?=
 =?us-ascii?Q?ZE811FxEbuq8CzEPBoBgkQBpuhFCAvgQiBfcqGF7KfeJlaNmc5XfyokYSxkP?=
 =?us-ascii?Q?LMDeGGGWYuct7+NcgG39NpRdzc+C96ccpgfc65KLEpc92L9RFWRU4PCrs6nL?=
 =?us-ascii?Q?kcy4gAsAzpXOs5BpLRk4ez8qvAyo9CkWIVbUV+JT5StVH/EskR2lIEEH8upA?=
 =?us-ascii?Q?25Mxhwmc0/lA4V4mwGP4KvU4XnU9Wf8Bx5rfjgbPQCLDpPgHac9qQ/KoQFuW?=
 =?us-ascii?Q?HCgY9hjQsaKQ8FgNGkeiAu2kWmQQo4NbswvYZeHA+cpK8KGvCDH7XfziBtma?=
 =?us-ascii?Q?jqWkvxAHeqbvn/yej1NdZEHdcvvkNel77HdIgWnq2LUihL6AasfEFKVRxpu8?=
 =?us-ascii?Q?YY7nDrUNeXR2nJhI8z4Bide5llSGjhnZc31j2+p4AuyfJ99CPivBhKyBhQje?=
 =?us-ascii?Q?mUed2Le2m6vrPIVJ1pEBBF1LTwLbifrZyE1yP9++2KqJvLfBxxSH7b6QjUYd?=
 =?us-ascii?Q?2ss9tfDb+E73wLMevsp2KM19ZPmKvXnamVU+E/c4h6FUSB8mAPH6zSLFojl1?=
 =?us-ascii?Q?kAMuvxbyW5q61DrJbrqbwQFqijw8g46Qy5BL/cFgFBs9W9XtxtYaKrpzixCO?=
 =?us-ascii?Q?e5kEkD5L9tT5oZreIaVSTlkrVao/bqNEcKEAu8+7RFuWMCBMBksTVu6LuwjB?=
 =?us-ascii?Q?gWTpJYr2kjsYOY4vVeFUQb0YY1o7Zivp/ZXV031aqhyNSlc9ldLzpUJr7Rz1?=
 =?us-ascii?Q?DgPA/UMB6wHo+NaxZ2dyGvxW/W6BDv2IjyIRjd26AQ+sMPk+mNxo995AH7CP?=
 =?us-ascii?Q?mFdVSHYx/gYNpaLve3hdkoJVOz2LEpqh1J2FvpY2E0b3Bz3FWHekmDZpG8Zu?=
 =?us-ascii?Q?mScn72TugC2qM5mwlOXDyBDZiK7WQK1mGa07YLGMoI7DXuUsKxiGxMP4nI+k?=
 =?us-ascii?Q?J4WXs++NOVbiR/vfFtp2AOg0qYhjtjye2Uvdbt0K8wTrUJIo/JghflHQ/wJu?=
 =?us-ascii?Q?5zMRxPJsGDe+ojOnXEzkZBn8V7Ov2UXQmLVouk2hSzyEAZzq/P4OD8GlPgeH?=
 =?us-ascii?Q?DGzGAkAH2S/hO9KmZreYV52v15oAvGN/bX85zfdtAHBn768V3JAfnN61EYEj?=
 =?us-ascii?Q?t22zXPh78oH1deOQw9IV3LTHBm2R6V62EcngwSccCCCzaPB6wdMiUkUiO6kK?=
 =?us-ascii?Q?+t8LvcroPghRmV2nYLi2tWUOlJ5/bJZu15Msst5rURv4hujXSYDR3ruWkU52?=
 =?us-ascii?Q?qokh85pIMphjF2ttxaeKQmi4fOmhChQvdp4RcBPQQRqTy//k7ZRV8WTGk/5l?=
 =?us-ascii?Q?5f04Lk6zxaNd0ys5ywo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1914e831-5cfc-489c-f5c8-08dcb0165ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 21:35:30.4829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRHCy6LQi2oocAyI6Nx2b+gZCIoJQOxlCxdsYMMjgrxAUMlzRxQZgFcuzumiOvp9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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

Ping on review.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Monday, July 22, 2024 2:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
>
> The number of watchpoints should be set and constrained per logical
> partition device, not by the socket device.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c  | 20 ++++++++++----------
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  8 ++++----
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 34a282540c7e..312dfa84f29f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -365,47 +365,47 @@ static int kfd_dbg_get_dev_watch_id(struct
> kfd_process_device *pdd, int *watch_i
>
>       *watch_id =3D KFD_DEBUGGER_INVALID_WATCH_POINT_ID;
>
> -     spin_lock(&pdd->dev->kfd->watch_points_lock);
> +     spin_lock(&pdd->dev->watch_points_lock);
>
>       for (i =3D 0; i < MAX_WATCH_ADDRESSES; i++) {
>               /* device watchpoint in use so skip */
> -             if ((pdd->dev->kfd->alloc_watch_ids >> i) & 0x1)
> +             if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
>                       continue;
>
>               pdd->alloc_watch_ids |=3D 0x1 << i;
> -             pdd->dev->kfd->alloc_watch_ids |=3D 0x1 << i;
> +             pdd->dev->alloc_watch_ids |=3D 0x1 << i;
>               *watch_id =3D i;
> -             spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +             spin_unlock(&pdd->dev->watch_points_lock);
>               return 0;
>       }
>
> -     spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +     spin_unlock(&pdd->dev->watch_points_lock);
>
>       return -ENOMEM;
>  }
>
>  static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, i=
nt
> watch_id)
>  {
> -     spin_lock(&pdd->dev->kfd->watch_points_lock);
> +     spin_lock(&pdd->dev->watch_points_lock);
>
>       /* process owns device watch point so safe to clear */
>       if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
>               pdd->alloc_watch_ids &=3D ~(0x1 << watch_id);
> -             pdd->dev->kfd->alloc_watch_ids &=3D ~(0x1 << watch_id);
> +             pdd->dev->alloc_watch_ids &=3D ~(0x1 << watch_id);
>       }
>
> -     spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +     spin_unlock(&pdd->dev->watch_points_lock);
>  }
>
>  static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, in=
t
> watch_id)
>  {
>       bool owns_watch_id =3D false;
>
> -     spin_lock(&pdd->dev->kfd->watch_points_lock);
> +     spin_lock(&pdd->dev->watch_points_lock);
>       owns_watch_id =3D watch_id < MAX_WATCH_ADDRESSES &&
>                       ((pdd->alloc_watch_ids >> watch_id) & 0x1);
>
> -     spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +     spin_unlock(&pdd->dev->watch_points_lock);
>
>       return owns_watch_id;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f4d20adaa068..f91a9b6ce3fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -885,12 +885,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>                       goto node_init_error;
>               }
>               kfd->nodes[i] =3D node;
> +
> +             spin_lock_init(&kfd->nodes[i]->watch_points_lock);
>       }
>
>       svm_range_set_max_pages(kfd->adev);
>
> -     spin_lock_init(&kfd->watch_points_lock);
> -
>       kfd->init_complete =3D true;
>       dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev-
> >vendor,
>                kfd->adev->pdev->device);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..653e1f934107 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -310,6 +310,10 @@ struct kfd_node {
>       struct kfd_local_mem_info local_mem_info;
>
>       struct kfd_dev *kfd;
> +
> +     /* Track per device allocated watch points */
> +     uint32_t alloc_watch_ids;
> +     spinlock_t watch_points_lock;
>  };
>
>  struct kfd_dev {
> @@ -362,10 +366,6 @@ struct kfd_dev {
>       struct kfd_node *nodes[MAX_KFD_NODES];
>       unsigned int num_nodes;
>
> -     /* Track per device allocated watch points */
> -     uint32_t alloc_watch_ids;
> -     spinlock_t watch_points_lock;
> -
>       /* Kernel doorbells for KFD device */
>       struct amdgpu_bo *doorbells;
>
> --
> 2.34.1

