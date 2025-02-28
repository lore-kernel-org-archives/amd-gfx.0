Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AE5C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 09:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A8E10EC20;
	Fri, 28 Feb 2025 09:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G931tNjU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1D610EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 09:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9YnzbVQ/H2G0W0sUw/55xTDZLcWu6rBB/m4HU5N8NN2gi8+usz3zl8Lt5BHLWKrIf0kwexu/1Hd4gMVWe9Sa/G2nVN+ydRCacUi/+WkjEIz7fwbxG6gXdIFhZVTLt/NXEtoUHX+t2EN9n87dPmboQHMi09X1W20t8yQjxoOkKB6AEK5Ffq16Jqx+uhkUwg4ZDnvvf2bn3rM0oHRN7bUWxcrZsFXRwnb8HUqTxU5vxlPwMDbFcpCUn6IPypilA8tv6cbVYGd+cDQ1ttJ4VwubAO/Dvoa769NCHnsMAydxm3nGQLGX91Kk9lIRdvW/Z4k41V7QLnWMKVqvJnWia2P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2Vs0w7s5o3FHA2IfLeSYEF+TBaNSUHpV5Ci/5N89Rw=;
 b=ZcxMY4ZFnc33TJSgOdXqx++HD1/IZuAQJTmyy/rlLuqGBOCTcv5euY3KxqFlZsdpYgBLsnNDEfTIqrAn6uyl6B95fmBQAYiHeY9E4mLW8tsf+OcnVKf3NpIbPImXVUfMEXdRrdgZ637uclui0BabB+5Hl4bmafDyY10pBy2myMpP+H3X/NEf97lBxX41GiMl6hM/drA7+aLCffyhpjopjBZuhMWadkl8nQYV+tClk35gezO2tp9nWAIkcEGkxo4+aOH+AV3Ey5/iXYyIZiq0eRToMogd6epB8dz/copZKH6EO5aI+0odjX9wfpVsp3OMhYuTWmF3IuHBBu8R/sTilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Vs0w7s5o3FHA2IfLeSYEF+TBaNSUHpV5Ci/5N89Rw=;
 b=G931tNjUmcgMLt/SDzFYwPorONf2J/aFuKJRUP/2TQpoA5/ELKz0unNI2QMYFzOEETJVTlb5JKiQCwNYJJTMFluhuAsU/cZeAEYbUF/Kt6Brf4REx1wfjMB4bRgKiLVoRSs6k1G+4X11K/xOrVFHNafkc2WvW9c3Cfkb7NRwFQg=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:03:40 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:03:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yi, Tony" <Tony.Yi@amd.com>, "Yi, Tony" <Tony.Yi@amd.com>, "Skvortsov,
 Victor" <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>
CC: "Yi, Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Index: AQHbiSo6iXz1azjfEEmDaWakGF6hl7Nca8JQ
Date: Fri, 28 Feb 2025 09:03:40 +0000
Message-ID: <SJ2PR12MB880723C02C5A652B7B62A0D4B0CC2@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
 <20250227151217.2620348-2-Tony.Yi@amd.com>
In-Reply-To: <20250227151217.2620348-2-Tony.Yi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a68f39df-31d2-4359-982c-4ebe188373ed;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T08:59:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|LV2PR12MB6016:EE_
x-ms-office365-filtering-correlation-id: 708110c5-ffc6-4fea-e48d-08dd57d6cb71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1x9a+dNAH53SCzZGhWB+I0PLMRhCbdoXNbIxW1FGO1Y4jJxnKSwCY9COEDJN?=
 =?us-ascii?Q?0b8lnf/9ER1rcNcVXdMg+62iTn7yyMWAa6J0/LcMZJJEsnb9cHVuuJR8vwbP?=
 =?us-ascii?Q?CoIAPcxawDEiLcT0biLTDVJV64HyeBiKSuw8bH4KvrQW8BUO0rlUa4f4GlBq?=
 =?us-ascii?Q?j0QDb3BAuxIpwb9FOXyvbViAnix0sQWs+GxsSQzRsdiz33IhsBcqDkrfqOQa?=
 =?us-ascii?Q?LJhYSNv5NvC6HbsWUw+DH/rD6kPmOzyrJv0laI7RRgN9m8JxJv4V8dTt+85z?=
 =?us-ascii?Q?MIaCFupeaLPbYkYuDeSwYcppLidsDWY30d7gQo2ylxjz69nZg9V7HDlRWJAC?=
 =?us-ascii?Q?/oNhksgXRwmWVchmBq8XaB2np79lOJTNZSr/lbl+xBo3czVVUf2Yy9BykTI+?=
 =?us-ascii?Q?g0FtYxzqNfsPZtgkJXPRQXJmNyZMJFa8lZHoHnWGNhjscsnRxiOpanEUptru?=
 =?us-ascii?Q?1KLxpHM8q72c8fGG2zRCUaqjK6TL20olKmSfF72Lwwk+zJMmvhuZZ3jmgmdd?=
 =?us-ascii?Q?wmRvEucSi9w+oYalNERPZdwmV+PgxaA1/DK3OuicpzlswtdpIOjxMn1E8tRh?=
 =?us-ascii?Q?iOwKGwFyctagwqJwYzk/lXU0abLN+miIsDSNuUruEXcOedmCk0JGHhEge4S5?=
 =?us-ascii?Q?HCH0vFwex+ovb+Qnao2/fM76kRRYiWYSXJ1JTTh/MoQlafEp4F2MXksktRxX?=
 =?us-ascii?Q?TK2tZo/IdB2SKcB4Sc+JedzYSZLuwpjbxsKPhBH2y9SMyobh8GUC8ckYtxdr?=
 =?us-ascii?Q?fJqb6V4RtNR2+fQew/2CQtduC9guRS5twJuaAkKO6ZXEXQgtuusWGEsPelEx?=
 =?us-ascii?Q?nRcIgOSCIQwcaU1d6dtkXiV7hm3ra3tHS7+HZF0NglYZpVzjlSW+fs6k4fDg?=
 =?us-ascii?Q?g2L5Dh4HB4xUsDtgxTlKxMe2frhpzaysJYdVw7Y4d3wAH/2KIpUQsyrAE78d?=
 =?us-ascii?Q?4NCXLc43BjQolUOwabeL6FVCZSPOqftMqrvWWZIUNrLM2VkPAJHozVcORseb?=
 =?us-ascii?Q?Iu0908r6uQS8A5zA/qhdENw8vrNENYVGOExtn6mgpHwx5QPSYTE9F3oE9fg5?=
 =?us-ascii?Q?c3X/BxKXhVwNBTB/9BwjSld1iwjPFlJXD7e/yrkUVPddEtOzqzvJ6lBD4rPd?=
 =?us-ascii?Q?fc1Rd5Kb7HinEmHzNepYN0Q/Xl/pu1RXIMhgbPQiVH51b7kw1CbMsBRrNCJD?=
 =?us-ascii?Q?9omzVMDEkWNVwsUOC8QQ4YCeK8vZbcEotRkayzgoCSoFp9a+GY/zXlAPhQsq?=
 =?us-ascii?Q?XhzZ6he+rqgMaQFHQrp+ukSIYaaZJ6e0pr+otXoPiHL0dQJlIWE41XnIONBG?=
 =?us-ascii?Q?YKFN2LWnEoe+WkF9eCIs2PgDNRaAQG42IYVqTkwaV/AYz0MwyPezEfff6GQt?=
 =?us-ascii?Q?DuYew/HhHr8ilfwhH3+WMk8211gNfFjNXSeEhVUI0uYj4W2OL7rFCWYTG28s?=
 =?us-ascii?Q?NBOnBgKVIpLsxA/sPnRkdOiE6DxExo3AoRYZtYDHQdqZQIftzbb0hg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5otbdJhup408BHpgaTznaklWfKwCzzweinJg4wr8kF/QsGimC/Lr/J7oEc6V?=
 =?us-ascii?Q?IVSXFO6aXEG2+TLRCHsKee73HqYhd1MBYPrRTFqPgXDRLcrlzvoxztxfSUdp?=
 =?us-ascii?Q?rNoFtyOuIiJwrWb4xUdrJTd1NCAiYHvtcsxLLGnJgydSc6eykMZQsFlGz93K?=
 =?us-ascii?Q?3dDW3jEyoYFhaElL+2DqsTvnbbcdyLRRhDYb1YaMweJcD+Mx5TykKpbDXwXF?=
 =?us-ascii?Q?csQm+ERpecGE5+lwaDD1UQE3pDJr6igT0hWMn50el9ry/vqA6seHT5xKHjq0?=
 =?us-ascii?Q?Af4bTGJYxUKTtX755owp2hv8ekLq4HVBVORIbhUoE8mQyX3e4X9GjrQyQQ00?=
 =?us-ascii?Q?N8Il5t0eMRPnPr5k2zTioLdJ/4kEWN9wvQWF3XzNGmhc249sLYBsW0sVY/mr?=
 =?us-ascii?Q?sbPdhWEwtodef0o4SZ5+9/F9duOC6C+ECcBDfAYyVVACbNB/txWfjTwzzZ8e?=
 =?us-ascii?Q?1+zWOCSGdg0jh/51qfU+weA9JP6GMAsuA8KoQEaDsK56Lm5XmaIge7Go8ENE?=
 =?us-ascii?Q?w8hSo9c3PV/cZqrM2Pt4PAZoyShIG8eQArdeYRT6VIYhxoE/ig7UaWvJZY3B?=
 =?us-ascii?Q?UK7otZDzB+flnYWFAbk08Wc6V11y0/UDOKeAI/r0kPKbUSk7WZtr15loWjMn?=
 =?us-ascii?Q?UTxe1dl5hsd8Dxl5qsbQF78AdmRNRyswe+2rx5fnbXhaLmcL18RQy+CP+uKF?=
 =?us-ascii?Q?fFkwkJX6gnZ7g+5PI0oqfcHOdgwjn0mKjBlXNs0CB3kBijBKxsSivCUNr6ZX?=
 =?us-ascii?Q?o1VEYpJuQqeb5vgxu0hoySGb5Mvg0W6V3hcnAiwXnHKKoKkYA8DI6KVJmsx9?=
 =?us-ascii?Q?NeKXS3bQCBSGNZr5pbGQiYWuXZvD8hSP0sj/THUa54uRiIhO2/j8isD0nKWN?=
 =?us-ascii?Q?aLI7dBhLkIZhtZ3yA+sPn6TiE1sKE9yFJ3SjsRe2/VOl2W45qXInqrFr9APu?=
 =?us-ascii?Q?CPBFbYWO/3rd+/+vx8THWJ5MbxICRFfE5EodL7SIhgDUoGmUcu8gUUgm0VQi?=
 =?us-ascii?Q?DAwy9pUm4V8KFRCwBGCs+z3hX5K4j8ebKg9a8ujfno8+MX68peIM9emkipwf?=
 =?us-ascii?Q?pDOJH8Ui9d2JlWe158vBbO5lGjDvpJcsonJK0ax0uWBOtQ3osme1PLx+BmUD?=
 =?us-ascii?Q?5ZI8JSlhMsXsUpGnnpiYLUOb8VS5OQZGjsdn81s+c85oxF+UNFDOJC8iDRn6?=
 =?us-ascii?Q?EvQoU7/HVKosXn4GrJxbq/EpTbyCU+68EsFu/TlVRwh8t7uWHu63S4+api+q?=
 =?us-ascii?Q?PbvjelttYuMOmsEse6RGoXmkhcRkXMyK3QUZ+/drWdVWO/1v9lYyky2o2itw?=
 =?us-ascii?Q?2tLUyALlQ+Xzld6BkNu7WdZNudE7fmOyMIvgOjOEWNPCbpymCMV9Etj9Izbj?=
 =?us-ascii?Q?OQ2FYXSG78GXHoQN0vknfEdbL7zdkGMJCrspxDT/qFD1U/zFMqpsd8fkFvaf?=
 =?us-ascii?Q?iapJ4mbBBTUXW/Gc1HlLgQlNXsGhg+Gs72ep2V277t/VGyLvrfbCnNlmaF5R?=
 =?us-ascii?Q?GmF3ag1an05Oe5mi/mfkUaIdKMASauDiaM2DU29WAL/uuHOma44qik0YjXc3?=
 =?us-ascii?Q?Qgwn277/xdKUZN8mzvY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708110c5-ffc6-4fea-e48d-08dd57d6cb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:03:40.4245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNBdhI66+gWAWhR9ZpKyoplHvGfOAUsHcLzW1p9txzk2R/8fwoGx4BJTOIMXG6XI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tony Y=
i
> Sent: Thursday, February 27, 2025 11:12 PM
> To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.c=
om>;
> amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Lu=
o,
> Zhigang <Zhigang.Luo@amd.com>
> Cc: Yi, Tony <Tony.Yi@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
>
> Add support for CPERs on VFs.
>
> VFs do not receive PMFW messages directly; as such, they need to query th=
em
> from the host. To avoid hitting host event guard, CPER queries need to be=
 rate
> limited. CPER queries share the same RAS telemetry buffer as error count =
query, so
> a mutex protecting the shared buffer was added as well.
>
> For readability, the amdgpu_detect_virtualization was refactored into mul=
tiple
> individual functions.
>
> Signed-off-by: Tony Yi <Tony.Yi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
>  5 files changed, 195 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5e1d8f0039d0..198d29faa754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce
> *adev)
>
>       amdgpu_fru_get_product_info(adev);
>
> -     r =3D amdgpu_cper_init(adev);
> +     if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
> +             r =3D amdgpu_cper_init(adev);
>
>  init_failed:
>
> @@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        * for throttling interrupt) =3D 60 seconds.
>        */
>       ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1=
);
> -     ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
>
>       ratelimit_set_flags(&adev->throttling_logging_rs,
> RATELIMIT_MSG_ON_RELEASE);
> -     ratelimit_set_flags(&adev->virt.ras_telemetry_rs,
> RATELIMIT_MSG_ON_RELEASE);
>
>       /* Registers mapping */
>       /* TODO: block userspace mapping of io register */ @@ -4370,7 +4369=
,7
> @@ int amdgpu_device_init(struct amdgpu_device *adev,
>               return -ENOMEM;
>
>       /* detect hw virtualization here */
> -     amdgpu_detect_virtualization(adev);
> +     amdgpu_virt_init(adev);
>
>       amdgpu_device_get_pcie_info(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 81a7d4faac9c..d55c8b7fdb59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file=
 *f,
> char __user *buf,
>       return result;
>  }
>
> +static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user=
 *buf,
> +     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> +
> +     if (*pos & 3 || size & 3)
> +             return -EINVAL;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
> +             amdgpu_virt_req_ras_cper_dump(ring->adev, false);
> +
> +     return amdgpu_debugfs_ring_read(f, buf, size, pos); }
> +
>  static const struct file_operations amdgpu_debugfs_ring_fops =3D {
>       .owner =3D THIS_MODULE,
>       .read =3D amdgpu_debugfs_ring_read,
>       .llseek =3D default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_virt_ring_read,
> +     .llseek =3D default_llseek
> +};
> +
>  static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
>                                      size_t size, loff_t *pos)
>  {
> @@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device
> *adev,
>       char name[32];
>
>       sprintf(name, "amdgpu_ring_%s", ring->name);
> -     debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> -                              &amdgpu_debugfs_ring_fops,
> -                              ring->ring_size + 12);
> +     if (amdgpu_sriov_vf(adev))
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_virt_ring_fops,
> +                                      ring->ring_size + 12);
> +     else
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_ring_fops,
> +                                      ring->ring_size + 12);
>
>       if (ring->mqd_obj) {
>               sprintf(name, "amdgpu_mqd_%s", ring->name); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e6f0152e5b08..3832513ec7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device
> *adev)
>       }
>  }
>
> -void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> +static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
>  {
>       uint32_t reg;
>
> @@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_devi=
ce
> *adev)
>                       adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
>       }
>
> +     return reg;
> +}
> +
> +static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32
> +reg) {
> +     bool is_sriov =3D false;
> +
>       /* we have the ability to check now */
>       if (amdgpu_sriov_vf(adev)) {
> +             is_sriov =3D true;
> +
>               switch (adev->asic_type) {
>               case CHIP_TONGA:
>               case CHIP_FIJI:
> @@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_dev=
ice
> *adev)
>                       amdgpu_virt_request_init_data(adev);
>                       break;
>               default: /* other chip doesn't support SRIOV */
> +                     is_sriov =3D false;
>                       DRM_ERROR("Unknown asic type: %d!\n", adev-
> >asic_type);
>                       break;
>               }
>       }
> +
> +     return is_sriov;
> +}
> +
> +static void amdgpu_virt_init_ras(struct amdgpu_device *adev) {
> +     ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
> +     ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
> +
> +     ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +
> +     mutex_init(&adev->virt.ras.ras_telemetry_mutex);
> +
> +     adev->virt.ras.cper_rptr =3D 0;
> +}
> +
> +void amdgpu_virt_init(struct amdgpu_device *adev) {
> +     bool is_sriov =3D false;
> +     uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);
> +
> +     is_sriov =3D amdgpu_virt_init_req_data(adev, reg);
> +
> +     if (is_sriov)
> +             amdgpu_virt_init_ras(adev);
>  }
>
>  static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *ade=
v)
> @@ -1288,10 +1326,12 @@ static int
> amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
>        * will ignore incoming guest messages. Ratelimit the guest message=
s to
>        * prevent guest self DOS.
>        */
> -     if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
> +     if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
>               if (!virt->ops->req_ras_err_count(adev))
>                       amdgpu_virt_cache_host_error_counts(adev,
> -                             adev->virt.fw_reserve.ras_telemetry);
> +                             virt->fw_reserve.ras_telemetry);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
>       }
>
>       return 0;
> @@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct
> amdgpu_device *adev, enum amdgpu_ras_bl
>       return 0;
>  }
>
> +static int
> +amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
> +                             struct amdsriov_ras_telemetry *host_telemet=
ry,
> +                             u32 *more)
> +{
> +     struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
> +     struct cper_hdr *entry =3D NULL;
> +     struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
> +     uint32_t checksum, used_size, i, j;
> +     int ret =3D 0;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size,
> GFP_KERNEL);
> +     if (!cper_dump)
> +             return -ENOMEM;
> +
> +     if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
> +             goto out;
> +
> +     *more =3D cper_dump->more;
> +
> +     if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
> +             dev_warn(
> +                     adev->dev,
> +                     "guest specified rptr that was too high! guest rptr=
: 0x%llx, host
> rptr: 0x%llx\n",
> +                     adev->virt.ras.cper_rptr, cper_dump->wptr);
> +
> +             adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +             goto out;
> +     }
> +
> +     entry =3D (struct cper_hdr *)&cper_dump->buf[0];
> +
> +     for (i =3D 0; i < cper_dump->count; i++) {
> +             amdgpu_cper_ring_write(ring, entry, entry->record_length);
> +             entry =3D (struct cper_hdr *)((char *)entry +
> +                                         entry->record_length);
> +     }
> +
> +     if (cper_dump->overflow_count)
> +             dev_warn(adev->dev,
> +                      "host reported CPER overflow of 0x%llx entries!\n"=
,
> +                      cper_dump->overflow_count);
> +
> +     adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +out:
> +     kfree(cper_dump);
> +
> +     return ret;
> +}
> +
> +static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +     uint32_t more =3D 0;
> +
> +     if (!amdgpu_sriov_ras_cper_en(adev))
> +             return -EOPNOTSUPP;
> +
> +     do {
> +             if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr=
))
> +                     ret =3D amdgpu_virt_write_cpers_to_ring(
> +                             adev, virt->fw_reserve.ras_telemetry, &more=
);
> +             else
> +                     ret =3D 0;
> +     } while (more);
> +
> +     return ret;
> +}
> +
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +
> +     if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
> +         down_read_trylock(&adev->reset_domain->sem)) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
> +             ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
> +             up_read(&adev->reset_domain->sem);
> +     }
> +
> +     return ret;
> +}
> +
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)  {
>       unsigned long ue_count, ce_count;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 0f3ccae5c1ab..9f65487e60f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
>                                       enum amdgpu_ras_block block);
>       bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
>       int (*req_ras_err_count)(struct amdgpu_device *adev);
> +     int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
>  };
>
>  /*
> @@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
>       AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
>       AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
>       AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
> +     AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
>  };
>
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
>       int last_reserved;
>  };
>
> +struct amdgpu_virt_ras {
> +     struct ratelimit_state ras_error_cnt_rs;
> +     struct ratelimit_state ras_cper_dump_rs;
> +     struct mutex ras_telemetry_mutex;
> +     uint64_t cper_rptr;
> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>       uint32_t                        caps;
> @@ -284,8 +293,7 @@ struct amdgpu_virt {
>
>       union amd_sriov_ras_caps ras_en_caps;
>       union amd_sriov_ras_caps ras_telemetry_en_caps;
> -
> -     struct ratelimit_state ras_telemetry_rs;
> +     struct amdgpu_virt_ras ras;
>       struct amd_sriov_ras_telemetry_error_count count_cache;  };
>
> @@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;  #define
> amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
>  (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_=
caps.all
> & BIT(sriov_blk))
>
> +#define amdgpu_sriov_ras_cper_en(adev) \ ((adev)->virt.gim_feature &
> +AMDGIM_FEATURE_RAS_CPER)
> +
>  static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) =
@@ -378,7
> +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_dev=
ice
> *adev);  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);=
  void
> amdgpu_virt_exchange_data(struct amdgpu_device *adev);  void
> amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev); -void
> amdgpu_detect_virtualization(struct amdgpu_device *adev);
> +void amdgpu_virt_init(struct amdgpu_device *adev);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
> amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6
> +417,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 off=
set,
> u32 v, u32 f  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *a=
dev);  int
> amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum
> amdgpu_ras_block block,
>                                 struct ras_err_data *err_data);
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update);
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);  b=
ool
> amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
>                                       enum amdgpu_ras_block block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 4dcb72d1bdda..5aadf24cb202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -184,6 +184,9 @@ static int
> xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>       case IDH_REQ_RAS_ERROR_COUNT:
>               event =3D IDH_RAS_ERROR_COUNT_READY;
>               break;
> +     case IDH_REQ_RAS_CPER_DUMP:
> +             event =3D IDH_RAS_CPER_DUMP_READY;
> +             break;
>       default:
>               break;
>       }
> @@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct
> amdgpu_device *adev)
>       return xgpu_nv_send_access_requests(adev,
> IDH_REQ_RAS_ERROR_COUNT);  }
>
> +static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64
> +vf_rptr) {
> +     uint32_t vf_rptr_hi, vf_rptr_lo;
> +
> +     vf_rptr_hi =3D (uint32_t)(vf_rptr >> 32);
> +     vf_rptr_lo =3D (uint32_t)(vf_rptr & 0xFFFFFFFF);
> +     return xgpu_nv_send_access_requests_with_param(
> +             adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0);

[Tao] so the cper info will be sent to host? Can host handle cper work by i=
tself?

}
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
> @@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
>       .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
>       .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
> +     .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
>  };
> --
> 2.34.1

