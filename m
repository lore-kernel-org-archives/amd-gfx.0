Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB89C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 02:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6043E10E282;
	Tue, 14 Jul 2026 02:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNsAi1HH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE6510E282
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 02:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu2BXu+qkq2awsCtqbz/i7hWbBJ/mCsXn+NY+Tne7cgufYv8Yz+LcXJj8AKpFqrfKnB9+7NnlwAm2wt4x8WbgSCb45kV4+aC2u3YPMwd+RptRjgA4XuUQVMpS9yO4pVO8NDarBWU3bPMLijgbKopayBvDx8U+XiZpHO/O/TihB61JJQ963UFUy24r97Lbyw06DNXq/YvmWUxwCKj3F7kgGhJzXE5Uiyn0hDn5kJmsX7PKFwves3CdJaBXdoowZJi8CajNe5tVogcFUeFDB23bLEfrnncrt1OHi86mbQNhxrRfoiUNHCpB1dPQkaoeCSONAAaMf16HtXNJkFgMW9Rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlp+TsmHce+5arzGgfod3ljVFn+iqsS30Odq7OzfuVM=;
 b=QdWBUBvH3jwSSvQjQoIfVXOakvI37hRLiLYJrMqWajQc5+0B/yN0rmezTB2PkyVDX+tvLNywrE2VVRw4oqlurNP2+5tM2bAm8DoeOO0gNQi5B0BXjOfZQRTIjoMwmthYL39ABa1akfEG7Kr1uPpC2HTUhSZNWKWXQTrhL8AG3bAc3atWlfXDB/PX3qEvpTuDTRCCjcrz/9Ju4F+G3Bdh/VK+/n6xQ5R8iWkl5sqE/KPX6ktSLHvUqcYXcvGiXDfkNOCCzy1t+2qWSM4YUZjfA9yRhbscN1rf5cNTVwLVC9b28UaYbuyyVKJBjJnd4hkjSv20lnohRPMwiO61mUFHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlp+TsmHce+5arzGgfod3ljVFn+iqsS30Odq7OzfuVM=;
 b=hNsAi1HHX/kmTolEvSTMQ3iVAB0HrcDJLdYwURXcmRUGmYyfgTsKRjlVE7EBNPnZDJ93aRTtihBHGSddp5l3OgLZQZFphR4s3U5w9oZFc+f9J8tBfRmZxT7dOQGcvP8OMHivB2UyuGmm+eb7oJXiaEJ9EmUwvu3zwdPomcKmBsA=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Tue, 14 Jul 2026 02:48:55 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 02:48:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwem2ibSw3o1iUqkIFz+zu3sh7ZsTuHg
Date: Tue, 14 Jul 2026 02:48:55 +0000
Message-ID: <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
In-Reply-To: <20260713203850.650426-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T02:42:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYYPR12MB8922:EE_
x-ms-office365-filtering-correlation-id: 4c50fc13-f285-4ffa-f240-08dee1527249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: /BqTdNqUTGoRuMmvga4rRaKz8zg/iJt44wMyEoiA0rvdJQoVnWvrD+s2tNjlw0ynDkk1KXxArM3Zel3MSz7BbqIWgpfZ9ayWLzYh3mTl1niiZ2NuoYZnwlyZBuJiSN7fycH2FgOl/Zta+tGfMqv6jvUWleZNInvuC2jkLX/zqfUN7HuOd1pfud/h/EBZcVFusf+TuzJzWWAWBt8v4WXsaFKg5QnR2i6kLh7u2vqwnf7yT8UP+Qjfkuo8iy10bt4G99bAtLtUz4fHSTjiCcEokH6IhYNAmu1BqRL5WSn5vaMFjiSazNYSXk1CJT+jEK7Z3H3dxC8I2/fVBH/dBtE1/dxry5DkRbysirqfNTDuJTzRPwwUnUNqlRiBmPyJ5ZoVlR3KZ+bnEiDCOLSA0dO8mE9J+sdSQ+pUts0rlCuhQ2MR8y88ZILHS+w2cBPVd9O/+eNWLcAhjq4dtyCc5ofxOkCAjm8itO2XEFXVzi/W5yD9gsFTJTs0R5PsOzzDiDiskpsPwxrOmmypnwNlNVpb5cML8z5LsvGgtugeCRnUNiprzoshCdmH6Jkx7CL3hLmJqfbFBEvzY8N5pSslJIiTYSfS55JAQciSqYYvvQ6GH7jZgDasMXvmdk6O6vqW+PjAOvnjbQPC9gu29dlKPF4Lhp9eQecK0DH9qvsddHj5bVzp+O8maHldSaz6/1t8w3NxdSyQuKMNWrbMclm+z8Wv7hbdnx+Fxcx52mwsaUCkseM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gwLsLJJC5CCfJxvzbPSoFL1uj62+OZyKx0WPAyD0AGigTa6fUUgX3vR9zA37?=
 =?us-ascii?Q?/HvvDHIsPkClzezhOoQKXka+ilUxAK7xVgPa7/zMF+z9iGMWfpT9tlu23Obk?=
 =?us-ascii?Q?SFEPfauyjRQzThygMtQKbyyDJLhdgRzJVZNN/EyhaVOSIQfKdLYpFySTv/Ie?=
 =?us-ascii?Q?Yu9SzTCwCrigvGFNkMn88wEVeYo0NQSjTcIUJ5+RPe4NdT9iG2XlsfnCKTI+?=
 =?us-ascii?Q?zEXIB/ioYczHD9YneB9pVpJfDQXCOHp35tNX0fQSLmL8eqf5P/5p33ISthuo?=
 =?us-ascii?Q?FhjxeOPGg0/sfOZpJgdpQh8LowAThkQgI4BTXLEd0JeAMI1O9TqACnJKtaNM?=
 =?us-ascii?Q?uVXrgPKER5HTYixAUemZ0Cen8Nz6HMDLqdfS9zPVCRcWowX35wK/IqAb2yZh?=
 =?us-ascii?Q?le9H1Gg3X68pdliXrc97I/bzopm06NBSi04oxskbxB7TYegmbvJv1g35RaMw?=
 =?us-ascii?Q?nlNAiMoIyTPoAS7YLjfx5nU8MmKLxQcOTNorXpjt3MT0BFzrqC+ewP5BTyF0?=
 =?us-ascii?Q?iR05kG18y81spk73/mDb/4IL3NcmR0zkkXpx8ZKR+E0xc6u/Y3Yf++s/64hZ?=
 =?us-ascii?Q?VRKSm5iMr0eR95hlqln/gtluaJhQxvgz+Ksaill42Wj9yb5QY2OuZ6R+gUQR?=
 =?us-ascii?Q?Tg+sigaLI/icGg0TZplyW1BvT07PLCiomrX0TZCp/8OqNa05zFK1t638wMSp?=
 =?us-ascii?Q?8HPSP2lL/xUtglTJNBej+wieGFL2KhMEh5IiXbbKBy2m0kP2cAssSuH5FJyD?=
 =?us-ascii?Q?etfYZJQGp2Yp8qMc87HH72agFJmy+io10068ndRA/WYh0Y/CvX5KVuBSQHie?=
 =?us-ascii?Q?wk1+DJFBVkNmSQtb3uDgQbJl4A2Ap0bpaMtkxyvf1I6OoL/p9hy9KDtPAsUz?=
 =?us-ascii?Q?12Sne71QFsHZstfDvhFLQF4KxrkHtcxQiA9PphdCPXGsgDeNt24HHKU/s85P?=
 =?us-ascii?Q?Ho/qBkyxhlx+cnFpcLscfhGdIOvSsAea3D8OjqHnM1qgNLz9d9luZMwc0Rii?=
 =?us-ascii?Q?8dXCMUrHEDtZVA8obn+4FsLaQEsBbhgyv0idXlporYQ4XY9yJNCaaWlO5hXw?=
 =?us-ascii?Q?3X5QsxogsVL+Ubd8SA7BpUydXCbLOw+BnrGboF/Lua2c8KBGE4/fsAgf8c87?=
 =?us-ascii?Q?58u6/7Kj4j+FiXqzL1mJyShL45+sFzjg7daG6tt+DwgKs7vCVZ5aUOHiJic6?=
 =?us-ascii?Q?57ZSVLMTTAe8jrzetqfQFHnbNlEM/143qhvLDunQMzVD0WBILfNCc8VT1Eyf?=
 =?us-ascii?Q?6JHTFNKoNYDjMZbGtGbJbsW/bL5p/0MqTTr5+Q9BY6NMeDnalFFDz5mnC3Kr?=
 =?us-ascii?Q?A6EPrf9z4UUAxUnVQ2sVUCm4WOTbVKtzkqo69OPQfp5WLgQvHkLMG37MPvRk?=
 =?us-ascii?Q?FL3PM2n2sk+Ptw71acqT5zcPI7/UCb0QO7WgMxhKv0AT8dPE2jykQFu5D6O+?=
 =?us-ascii?Q?v2wh5r7Qlkh24DrCU0ZVMJsHDXa7D/XIvl6sD6Ghrn4D2fTRCuaGusNe/qrB?=
 =?us-ascii?Q?dBENOhXNZpeDoV+oTmdHkYN1yEb3UsW9qU0a/Oo9iLj6Dhpjh3AvOQCS1WYf?=
 =?us-ascii?Q?g2yYGPcGpitmsqH4sJ3HO4dmsfx/Jz/WjYajA59BhwlZihkwaLb3no43cZ8b?=
 =?us-ascii?Q?zKOr4Nv0IDhv3t06gqyadM1vnvvw7+NJWdrp4MBRGuS3T0TG8/+6PbJaI3TT?=
 =?us-ascii?Q?tepadJg2JUMrP0ucEVz0crpNOGvO2DAQP9f63O+u4TPcFlM/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c50fc13-f285-4ffa-f240-08dee1527249
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 02:48:55.3794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l4yPNi7RwrvymNfHGb+QkU3fCQF73f/7vXa0RydJpgD2w5ra6e85qrMc+G3hhpn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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

Regards,
      Prike

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Tuesday, July 14, 2026 4:39 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>
> We need to increment the reset counter, force fence completion, and set t=
he wedged
> event when a user queue is reset.
>
> mes_userq_reset_queue() handles this for collateral damage, but the calle=
r needs to
> handle this directly for the original guilty queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..5e1262636e1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>                                                        queue, NULL, NULL)=
;
>               else
>                       r =3D userq_funcs->reset(queue);
> -             if (r)
> +             if (r) {
>                       gpu_reset =3D true;
> +             } else {
> +                     atomic_inc(&adev->gpu_reset_counter);
> +                     amdgpu_userq_fence_driver_force_completion(queue);
> +                     drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);

If we do the userq reset post similar process here just like as mes_userq_r=
eset_queue(), so do we need to clear the duplicate the code in the mes_user=
q_reset_queue()? Otherwise, the gpu reset counter should be incorrect. Exce=
pt that, we might input the wedge task info to report the guilty process in=
fo.


> +             }
>       } else {
>               gpu_reset =3D true;
>       }
> --
> 2.55.0

