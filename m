Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4028D1CDD3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 10:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570A010E313;
	Tue, 22 Oct 2024 10:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NacItdP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654DF10E313
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 10:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tafHumuc01gcpVHGGOdfPgqPnZFVvcVedjKx0/scOyk438Bg7mlOTPFb4DsEDqnx92N717E+FX5p+hl0DTCzQxpwQ9Gnt+4o8hyBqpYD4tJAugV8GllgcOavHhjvpvCWBdz+eZBcP+UW20P3EELSlDXxV6K02MjYX+liiQDuzxDz8PSYPg736PGohsA22kj/DaEDmOnFqa3A59QJQHWVqv9oQ0wPAqWErGS7VGEY3LaI77olGcbQDY1ud23klcLl0WgZFyLKS5uynuFvIlPZkkCJ45O6gZedsOj7MsBG1U3/vZKEdV2Clm3szpmGvZREj0qAHQjVG0xUC2+wGBX+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X42ePyt8IUBcxpq+fK+LMsmUDYwX1CbA9aFtQqV4xMQ=;
 b=GPuFf65zVD2ObISYAD9vx/Oo3Ai9fTlt8eW1XcmMiZ8yyqo8CthgRoxRw/C9olSZ+Gb6EzwKs31VJManOfKi1D7ITHQ7kyM7JjLzpJkj889inh5xs0XDs2pFoRCK6MxOKr2VvawAmM6fzvMbLOtuHe0oNsO8EcFYqDauojf7TmbGzLRRHLwGw603mUBscScAVdy6nvTQcYUbEUjo+LrGJFtOJGAFxTQ9o6o2gAeFGnM1B5PTivK1HLgPDuYAEHOIrGzqqFXzuVLglE5L/qFu4sce0DY3XjGyDgLku7WpK9DpW3IbT0axpYnwtcJNc5+xB1EuDyWFTVd80jwyuTLWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X42ePyt8IUBcxpq+fK+LMsmUDYwX1CbA9aFtQqV4xMQ=;
 b=1NacItdPcQIfLL3vF2lwoJtRqXn1v+ZqI4dXy8zBv0m3XxfuguW+Fgq3RSLRmk3wftqeBH/EqXXufYYBk5ROdXULIPhg0K9Ty2KlKbdXnLqpfvd4hRVZHlB94qF1ZfqkJMGSZj9OzmLS7eV2Xz+Ep9sDgl1Ar1SxQTEZ61a/72g=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 10:31:35 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:31:35 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Reduce redundant gpu resets on nbio v7.4
Thread-Topic: [PATCH] drm/amdgpu: Reduce redundant gpu resets on nbio v7.4
Thread-Index: AQHbJExU4BHpkplxWUGa06kGwD8cKrKSknIg
Date: Tue, 22 Oct 2024 10:31:35 +0000
Message-ID: <PH7PR12MB8796F986ED9E34B8CED9F452B04C2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241022063239.1517315-1-YiPeng.Chai@amd.com>
In-Reply-To: <20241022063239.1517315-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc02b79f-eda8-42a3-825d-8ad4d0c95c16;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-22T10:31:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: e5b0320b-7057-441d-e71f-08dcf284b45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yD+zDrlruf95JeCK8wrVJ761u1prMEbuizgm3ERikP+2DTWMDUL5dOLIFIKG?=
 =?us-ascii?Q?KWmCTU1jbydbsp8JYSHy6r4Inic1ZyWIj3EnGu39sQO6iKygG8iwajOIod2J?=
 =?us-ascii?Q?maIrDgu8nQ1DJrQYJ4UgWp+jABBrA082GnZHpWo4xrVT86+9Bi2iXgLXPlQA?=
 =?us-ascii?Q?hMsJv93TK9cvtc3VEtVp38wS0F3uaY2ALNH8SDGa75MzA1Kw0aF36dqSkC+g?=
 =?us-ascii?Q?0/eLKsRTRABczcG7AO7GuvkG1TSlaVd3EYFxw4a+A1oetOJrJeJWywkS9iwS?=
 =?us-ascii?Q?KbWj2kyd1CrFFdgmrJNz0STUXbCaDYk9c9YpAlq4OQeJiPNlCesozyFHyEKX?=
 =?us-ascii?Q?yJhouV7b4e2iDgC1I2LmEwiin4xWTRh1ONv3ujgWCAkbb/I1AGhuWe0/0z0/?=
 =?us-ascii?Q?g0V6kfR7t3nK8G1D18Xc9D5S8pwVat2GwxCpF6kb4TPvlXfWKTJZus6mj4j9?=
 =?us-ascii?Q?pgXfkcektH0MXXmRz7lk3DD3bmJN4L86DhIvSxB6PKFbBnEKVd2reDyAA2ND?=
 =?us-ascii?Q?nJgxzv6SH1r6HLmPLZj88m9Q5QOI/PmzEZyvlAQ+sgVrYj8yQmXk/1LfcKjR?=
 =?us-ascii?Q?BqNfBVx2EUesgE0SkGcglKKoU4f4joq5AewJp2apDscTNOoNTPG2cz44H/NR?=
 =?us-ascii?Q?YZZSm1GZLSdQa0O4rXXN4JwsEi3m18SHf8LaZCAfWD+TAHng7Ue19tis9Xmm?=
 =?us-ascii?Q?KKIvOIMcKraO9653M2UoWo0lmcDTeR7KPpVUifLjHk7jdPnmT/0RtVRtl/wG?=
 =?us-ascii?Q?ZccZ25dDrunA6DoATArb6AFurHg4MiLOV0ebIU++CMo0PVxpJ/dioR2flzJi?=
 =?us-ascii?Q?yCSMR+k9+B4TNUpnIt8kD81CEP1eqRIL9VBXugU8Q6soE/3YgmWaSdk9EcNI?=
 =?us-ascii?Q?GqH8yCh74Pgg3iJkCKZ2qAVjoEiS7IDC5TwsTCbKNAvFUb/Szet8Laa3DJiB?=
 =?us-ascii?Q?lXPHklPVBW+FbTyRpoB2gxibHh16BZTRQZvGVA68NVzTa3Ch0Oee8/Ai1XLO?=
 =?us-ascii?Q?HsJVRE6YJZ6qAeBlKyZ/qA6JQ8BZmm0x1rKurA+3vjmyPiQU/BQYOxRj7VD/?=
 =?us-ascii?Q?KzUKi50OBNucOL/8b0cxNdV0dMm9/hSNAV0rMG+bLroJpDB5gApXBrViq5Es?=
 =?us-ascii?Q?Lzoj7T5MTWxdEbUSwsWRWQVykJ1EN81q0qtTpo6ImTEubIIT5GX9a6G6UKat?=
 =?us-ascii?Q?1zEecbxPztmaN5uSExA26Y/h2CPz7lG8ouWmeumoBfvyYFkN72h9vDD9cQM4?=
 =?us-ascii?Q?Ve2XrZk1dkytj/ofkjIBFwyrbUWUdn03E+r39hjlt8J5C3OjiiDrab/1ELKo?=
 =?us-ascii?Q?4Ac6Bwbcapxmia/yyIy6+/TU1HJD9tmYdrKLePppiLczKXaX19s3E09IqdpW?=
 =?us-ascii?Q?W9HrsR8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mb8UnxEFRahV0lQPDg+YShcNrEdBwj6z1D11E7xqvxvV0D6I7yaCR7rb6EvO?=
 =?us-ascii?Q?lvP29hdKzOhBOBb2O5SfZm0McN0Aksfdn7199V+yESGbQ9+wPcSbDzParp8M?=
 =?us-ascii?Q?+jt9YmviW5KZk/82A3NYGht7Udp+f1O1qc5pWYESLapAcESzhMJLluoYo92D?=
 =?us-ascii?Q?M4IrZRqucBm3xV7vXAz0Wp1yfvqtcyljTKsikutcMphkxQzCFAUATmW69GkY?=
 =?us-ascii?Q?tyWI3cHRjxIzlfg/MXpjPg929KopP2rPuB4swB9HUxhvCFixBwlsCaPKJMAq?=
 =?us-ascii?Q?tLgWAeqaTAvDwYHWMv+A2ClFy48MoQRvtBqwIBJSl6h05MgR52s22s/li/yF?=
 =?us-ascii?Q?lVW6Xbbb0PH5+vnD2GNVDCX6NWy8okDP5UdCvbH1CgoRxV/ORn0l49dTS4ID?=
 =?us-ascii?Q?jJGjdMmPXeE++ivZmIC7MFY4Nk9Up8C1X4+E3aydr3lAJ7STBmVF/wHK09eQ?=
 =?us-ascii?Q?X//smfdwjakUOMD3esK3gKHZwaYF+c4x0hy/0W7aRGvHZ7nZ4G40iuCYmv98?=
 =?us-ascii?Q?LYwlXxeG0hpUmheB+Unemx5hyinRt7v1wJCT1IEJ+nq15py5qYL82X2ohkEo?=
 =?us-ascii?Q?q5G6/InAZYeAhFWS7pC9FvC9oUE839UTVng9dAVBZL0szqRHaB0UDCoIZEzK?=
 =?us-ascii?Q?NSR7jMdek4aFsihE3lzOgETcJIG/ms0Sp73c/4q1MkM5UIxFVlnRZUi1xfGd?=
 =?us-ascii?Q?T7xGAHVEjaqMn6L8hYk/E0epL3zkDosfgRvzUgjVqwofCLrTLBzUaYkT5HcC?=
 =?us-ascii?Q?MlyjKy7aRZRkpT6cAe2lrovGQv9MSMCVxCztTq8AvCKyyqNuWtjXyz2oKLaB?=
 =?us-ascii?Q?5WOvFU8gAKdFb2kWzyMQCCQwhbFiOZoD5AnzK/pFSpwCRDZYz1MNWJb/eSQF?=
 =?us-ascii?Q?of9FdUj8j76Oo6ydkk+Ow5pfncL8TOqHFf9tLUI4TT0DuT5Pym9N7SXi4gaa?=
 =?us-ascii?Q?xPO9gQocOWm492iaWFxsafW6vzUPdy/3SHECbtA/OdwjWXY1E9pMzdf5BuKU?=
 =?us-ascii?Q?nUaCSAABDb+BvD1CtFhEwuUNmu+gblLZb/NQyxC1YA8eWARivY5if4P1jENs?=
 =?us-ascii?Q?2dBU0pMuiBXQyYZfA3n1CebWx5xOtsU1M+OV3dIZe7k3UUu/7ewPF3f1FqNd?=
 =?us-ascii?Q?E9H9sieGUe0SF2FmuXjgGbWN4pYj5Dj8XtAUaupUquFbuFArNAb2gtdU5QXz?=
 =?us-ascii?Q?JQU6dqlYf8d9DgTmYljsQFWZz+Ri2QzTZPACdPP86WOAqM/0adACVhKMOFpK?=
 =?us-ascii?Q?3Q7zwYH64WEdOaGgX8BWMBZ+AZMGw1GiFA6ejGcc5bVzTgDBQ3WMdst7UlhM?=
 =?us-ascii?Q?bwXUgWSg+9/oXJPMq6DovVuAxPB3ZJQqeQrXI5Iv5irfb5kCXiqpCx2MZ6wZ?=
 =?us-ascii?Q?XRF0kCMUUuqYyCHDfwR0VSQ9htA/jW1e+MVl6Y3vT5a6v3mEm2K2OBN6Sh67?=
 =?us-ascii?Q?iFKlNz81sZGyAaDyNc6ccWsnKif/L7VxH7XEyhIEIrNfabR5y2cpvV8c3Smj?=
 =?us-ascii?Q?wqm0vLtW8sdX/7HYPHprsFWA5YimgBHxK3WUjWahKgDyqtOMY2wVoWt1YwSr?=
 =?us-ascii?Q?7VS2fTOykpBKmeYtmmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b0320b-7057-441d-e71f-08dcf284b45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 10:31:35.5147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uu//nLLocK5RC1hHop+ukaJDOMLgC2bOlk2tC5aXxCt5dUuQw7lKYB/IAAXPFLE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, October 22, 2024 2:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Reduce redundant gpu resets on nbio v7.4
>
> On nbio v7.4, ras controller interrupt and athub interrupt are generated =
after injecting
> UE to PCIE, but gpu reset only needs to be triggered once.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 9446bf6f82c1..97782a73f4b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -414,8 +414,7 @@ static void
> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>               /* ras_controller_int is dedicated for nbif ras error,
>                * not the global interrupt for sync flood
>                */
> -             amdgpu_ras_set_fed(adev, true);
> -             amdgpu_ras_reset_gpu(adev);
> +             amdgpu_ras_global_ras_isr(adev);
>       }
>
>       amdgpu_ras_error_data_fini(&err_data);
> --
> 2.34.1

