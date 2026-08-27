Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDD7C61DBE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 02:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D7E10E380;
	Thu, 27 Aug 2026 02:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqRB9dPQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84E110E380
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 02:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZiKhxqKzBghV0hHQ0zTY6EWJW9knYzqfkxuoc7oG2MsaSzOdj9rdW3WxSSRJD1UMk/RqINKQIl6ORRoifUkiosNeKWUCBbpzVMA1xkm5mvoaTvS9Jm+ROorSVUUKhvADrZtHWazkL9nT3A+xF9UU5hpEC92m8M6A3SgA5Q+Oij0r8YycCIMmqbnUu/xgLi0k6latniwkZZvE1WdgeodCA8VqXtIneWHlTPwuSF8Tiqw8oBp67++w+r6CEp20NjFcQVT7gmzsaYlmm1gENKrq7yMOGrGqj66xCKZ+mnbB/2CpO2G+JdFFChNG7bI4NbwB/p+4UE6evbneVzOZ/wTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MwiUi0hHv72ONqVIG8H7LINvsgqhJQ2dEYf6yZweu4=;
 b=BYe9K33wcbPFTy+SvkP2fXHNEkdkqPHZDaiUwkA9petZ0AefTbpWZio5I8TpxabGz/RsJtd+2g2tnQa2fC5FcWk7saYZPErnEx7uTnjnDE+5ATggQPRJE1W2NI39Hxhhy5oN4eqgcEUEhmR1cYfSStLBlWoO8OFn10S3sRIUh6hpH3gsT1y6ELpwjqm1PVMVAUpoNWEBR4HlqPVLj9v/f6QZGaZcLgFsiLQkuIcJBExFJuO4RQ31jCePoe4kZed2GEseM4AQJDCOaBBjGcAIazJyChDEX9r7ZvbIh0Qu2x/tce/5xHzdMg4QuMh1zQj3hI4658T61/VJu3yF4++8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MwiUi0hHv72ONqVIG8H7LINvsgqhJQ2dEYf6yZweu4=;
 b=bqRB9dPQTepPc9tpZEg7tNvHR+VbGCHXggHWRlBS1dmv9FsGdZRxfpA73BTEuGBGUKpJEI9OgC0iJ30nszS5cYotwlJXEmVFQUYHGuaIg3lDz9kn2U6KsOfLCVrFGsRSv4RDSFhb4DAaA/pqTSJcpHTVTK8DgA/2/D0egHB7jJM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 02:07:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 02:07:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Thread-Topic: [PATCH 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Thread-Index: AQHdMVMQC7PdRecGz0S0+ZsqBVj/9LaxLsVA
Date: Thu, 27 Aug 2026 02:07:21 +0000
Message-ID: <DM4PR12MB5152D5F39C0148215EA63734E3AD2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-27T02:06:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ5PPF4C71815F9:EE_
x-ms-office365-filtering-correlation-id: 938e7bcc-6e17-43d4-4214-08df03dfee32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: DzB781vRx5oWSF5MQayy+FYvDcyJ0B+DLs5UoXlMShLgQSebDfp7lQBymQH6ZoYfXemlQxMhANzRszMG/ygReFS0rucDh6xZ2n1+ezQAIxgT4GaEXKQzNpxa10350+fd50f1fHPvBelhr657RxLZU96GuXpnIHxbNNQPdog3b8jxAKmMGF9REHykVgZ3RR++TkMpC434X43sAzwyiZ7eCz8N8KvyT+xixRyq7E0bBYWxrJWZcNuFSc/Y2Se5bBJ9dUNNvKCPKkulgxbBIVT/ml/RwIxuOKQA7cuB8dPXPa/vL3jtAXWemJaM0fvE1fsTmBGxibcCWfZbyc+RNk6RJFFH+4eqtuJCoHUyfm9y4fXam33gwDOzch47pPuG83GThqq2pX8bbFD7Wm2rOiSfhIhlUZr4hqK7grpkOUPg2jonifOQGt/7XE9BqBSWIIfgimouhtLB2jo0S+8M6xoMTKkGYPk2QO2dc/PBzLiS1CLM6g8HfS1UxjbCLxE9aFLDFTD/6cehYNVjRsLmQ4nsSr8wFr6QmgfrsawoeS0y+cu8hs9maT3zkmzKIbhKGSw3YX1LSdflP2STtE48XqU4yD8Qy/j28OU7Q+28835boJcdG1c9ST0+GzTRWb4XvDZprKSRbp3sBkW502BxhhGWHjKmN92fR0DLhrrXkuIDPX8SOxHKCFLWKROA1wrTjCPFfowV7CDcL6Yt4cIi9c7E2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AA4Wmj4s1BFLit5nICAQwFbUoH0U87UknkxRmWiCtqAnQFvH7Fbk4/wg6/Jb?=
 =?us-ascii?Q?GpnFtCKTuXs/A6nwAO+f+mgga612FqEDZlhevcQAwn4gYXZ/+N709Gbqu0Vm?=
 =?us-ascii?Q?6tPXlTHojJQQkQAhgzoCdxaOHUYK+4eDCiKPZCb0hD+BXw8U0IA8YVcRYamk?=
 =?us-ascii?Q?TWpfZzZ2zj8AcFWhfio9Mj2qcXXVXoX1k18fi/g/F0+psfc5D/qltwOykrhH?=
 =?us-ascii?Q?7ecM15qxoGBbMqqyje6G+6jGubQ/Q2pvefHC00L/110A7hcT5wmtHBjdN7de?=
 =?us-ascii?Q?ycBlID7twMTnyblo3PLIhLrizoR9A73J4lHAZ22aYECkRnyfEmY4IB1iHd0P?=
 =?us-ascii?Q?MauOLfxzagjhkZ/PCaXff4elLgEkLnbCtQa/UjnPkpfnbDTpFuXPV+6P6U0H?=
 =?us-ascii?Q?jgbn7TGrkCwIVv3CJ/8qeT5fT88T3dmoMejRqLOOgWypYDUc0n/nXfVxOzRH?=
 =?us-ascii?Q?dC1sNMXlBHuvXfivj7ET2O/qsEQE9dpBb9GUDGfMyWRK/GV16LsYW/o6a5yR?=
 =?us-ascii?Q?2IOyGEq1OIu7X0s9TnVkkKI5IecY7S5vlzn4j7BqfGq5zRzjVEezga6gs+zl?=
 =?us-ascii?Q?laodL+xvrqoqcPtb7igX0ew7RetFo7V+7QIQjMRIov6UiMgKl51si5uyck6P?=
 =?us-ascii?Q?j6HL1y3fPbPwhTG+ajhIs4lB7r5bQ3c9XOo+qFG6OAOtnchyggm0U62zHL/h?=
 =?us-ascii?Q?SsWmUsO//WTUY2ypQv5ybW2OomHkciXTMbDJx4s3s+Mx5fj910UDIUiicIzV?=
 =?us-ascii?Q?k06bmTfIeYypTDsdC/5u0mokm5i+tdmbp30U6cWMk3OYeN4cLBkLhqYXL++v?=
 =?us-ascii?Q?oN4qbym5P0XW8qJDNuP1SR+9a+XfPfXASCmstlPzoKNT3VGM79KTSlnb2bBY?=
 =?us-ascii?Q?8LIIYOxze6+BI0qYi7578g5JXi17n1/lK3lpTkTfE6RHDVFWOf1DkXLkPwja?=
 =?us-ascii?Q?nuoNtHwfMsBHiZNrE7eQx58RViOGPS+eKZAvyIuxRbbycNglUjDXIace0asg?=
 =?us-ascii?Q?7hGuw8qLIE/ueWfD6JyxV2WehE7dnZToa/gmNp3kNzvCV3T7r3Y3oq7Z1SWr?=
 =?us-ascii?Q?86JjzoXKMtH6pLhY1dO8zxl9nc8NGo+iZVhP2oW3htWHLyod/14qHJ0Qk3QL?=
 =?us-ascii?Q?foZPvFewZTTgMQrurQ9oEucfcztoeNHuz70NAzXDzoLOyEB3pIdOj3HaMv3u?=
 =?us-ascii?Q?dO0SS6E/+UL4HaEPB02Dih6sBGOwJYd4rIYOCFGlGCxDaeX6KGLcerc+BtUf?=
 =?us-ascii?Q?JS2A5tSjHMygsTuI5Rx77ENOFTfz5uxm8ej278hYf3Eb0gLXIrghX+q2PcDk?=
 =?us-ascii?Q?nKOGEmggVXsPB/OJLQzNGDVr+fwx7JIxFeNZ2hTtuURT328wEzySpuEyubba?=
 =?us-ascii?Q?jpaow65kvReWAsy7jboW9g/gvPeEDAurE+WoDUm3Djv/D8Nmwdy0TsB0Sqof?=
 =?us-ascii?Q?a4JeRioHu0IDPJZDDIZdyPciniHhXmdD2LOa96DvY6COejLJBj/1YbnZGz19?=
 =?us-ascii?Q?YNZNmnbLoRN16VPcrVQOhtYK6SKyWRGD0XQojrEM15t9uaLfW6t853+HGWQF?=
 =?us-ascii?Q?14ixr1uICK5Hm3BBPREB+9azoUJrm91dX1VieE0uy5MGH5bICH39NAjuq12v?=
 =?us-ascii?Q?fL2crVH19dTgb5wIZJ0FNp5Z+5101mHdifQGlIOV0FAfaVMXcIeVStHo9Gp0?=
 =?us-ascii?Q?pXCJFZG/799k+npH7/kgPG/PtiVHVJ6IdS8ebMRkWew80xiZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938e7bcc-6e17-43d4-4214-08df03dfee32
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:07:21.8729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iECbkj83A7P1OhtL07+ZyqLQp3T475WYQgp9N+1ThtpFNOv5Y3Mprr0PhSiqAMWJbcrdYDZ5fGCA+5l+rGzQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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

AMD General

Ping  ...

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Friday, August 21, 2026 5:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
> per-IP helpers
>
> Split the inlined compute path out of mes_userq_mqd_update() into
> mes_userq_compute_mqd_update() and turn the former into a dispatcher that
> switches on queue_type, giving other IPs an obvious place to hook in.
>
> No functional change.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index ad72ced472dd..82bb4369451e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -681,7 +681,8 @@ static int mes_userq_mqd_create(struct
> amdgpu_usermode_queue *queue,
>       return r;
>  }
>
> -static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, str=
uct
> drm_amdgpu_userq_in *args_in)
> +static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue
> *queue,
> +                                     struct drm_amdgpu_userq_in *args_in=
)
>  {
>       int retval =3D 0;
>       struct amdgpu_device *adev =3D queue->userq_mgr->adev; @@ -689,12
> +690,6 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue
> *queue, struct drm_
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue-
> >queue_type];
>       struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
>
> -     if (!queue || !userq_props)
> -             return -EINVAL;
> -
> -     if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
> -             return -EINVAL;
> -
>       if (args_in->mqd_size !=3D sizeof(*compute_mqd_v11)) {
>               DRM_ERROR("Invalid compute IP MQD size\n");
>               return -EINVAL;
> @@ -720,6 +715,19 @@ static int mes_userq_mqd_update(struct
> amdgpu_usermode_queue *queue, struct drm_
>       return retval;
>  }
>
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue,
> +struct drm_amdgpu_userq_in *args_in) {
> +     if (!queue || !queue->userq_prop)
> +             return -EINVAL;
> +
> +     switch (queue->queue_type) {
> +     case AMDGPU_HW_IP_COMPUTE:
> +             return mes_userq_compute_mqd_update(queue, args_in);
> +     default:
> +             return -EINVAL;
> +     }
> +}
> +
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)  =
{
>
> --
> 2.49.0

