Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C6FC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 09:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862D110E97C;
	Wed, 16 Sep 2026 09:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qm5q9D8W";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7A210EAD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 09:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbCWqcCdP2TbmrjjtVGZMlbpneKxaBjVM56DgltdHGM/Q+pNX1qoeJAeLDxDTdBY+1W8SBbE2o5EOmtYnTyYUeeQK8c/lRfhthYwIYxaNEqO8cOfsYZHHcZtTzHI3qc1/tjfOh5RZAQKG7rn9WShI9/7Q6snZQ6hCjmswxPKnk8Plk6UvqfZ0ray9EvkaERgcls9tTB61mimI/S55/XEuXqmM/Oo7HfTqomBkKNFkn2z82fL5wdiKP+d2Y63EVLw1GvYbHalhpTcg74RobHJdB1Wu0TJPjKiDiuDmXKdcJmSGHcdqmoC1QRfvh8f6upSwCtnaiY1vXe1qySdVI3PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhNwK5xNdhJ7Yalgg21tiapeKhSAr5FGc263h87ofBs=;
 b=UBjs9bmv8dS3NZf1SVL+w9xawZyV1865j3MPFKBW9yhAK824lVxQzkujdWI7VvK7Jx99G6l/r9dY21gf8jDKMdWMfmIlQkF+PtPv7IPaG1hD1wbwg1K0AG9XCIx9JLNYzOvG/V+q3rjXTmgtnPi+S9/G9gqsgPxbVFNw3NTojHrt5tFiY7VLNwAxahzw/scjXCBHVEE6njesf6GWf0mUgBD48K28C+zXv/fUh6fjQYzpI4WqCN/A6/M4cJCcVJ50D4MRJSi5zgvCvH27sXGA/BO8a1fdRY55nRcB/UJvCGBHmpN8NLfo+Vz316m/dImHo8y0i0pS8/8BplkfJaP/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhNwK5xNdhJ7Yalgg21tiapeKhSAr5FGc263h87ofBs=;
 b=Qm5q9D8WnyXq3jQhAVR4H+E+6IGV2So21sQ/vwzzCy+3uM+Sy/CyjMBxrfmYMeZdDl/9fYhAOYJ/FlgtbkcAtcz+87v5lE1srozeLa/c6Q41nctgMqjaZCR3OGDsseg72gEUvOTT3SKfwOXIyqB4Y0luR1agrIlAtc7Anb0ests=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 09:31:20 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:31:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/ras: enable UniRAS for psp v15_0_8
Thread-Topic: [PATCH] drm/amd/ras: enable UniRAS for psp v15_0_8
Thread-Index: AQHdRb2r2vGGkQg5Q0iFhCX9pPWR6bbQ8MCw
Date: Wed, 16 Sep 2026 09:31:19 +0000
Message-ID: <CYYPR12MB872956A19A93F8675A31A725B0B92@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260916092732.1054500-1-candice.li@amd.com>
In-Reply-To: <20260916092732.1054500-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T09:31:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|PH8PR12MB7277:EE_
x-ms-office365-filtering-correlation-id: be0d1b8f-9876-4ac0-7dc4-08df13d543f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: lyDkpTwwNg0uXOVoFinYWin8K2yzAQ6QB9m9wv3YhOh9UJto2Wa6YYZjLdgCm8f3d5s+LAOSX7qGYxa0ENR3eT7j1HpmSqGIyu+BDmIjgNbCMb4CBo1Ffo7eNTJyOm/Hk5RnNB/oceu6wbHvEKum8AaDiONJWWvNErVvj6zzVvUCWn6IvmM3qDvGxqWn8GquMloF0x2pZfMoFJj8v54vPd+ud3DAsdBsfhEZCW4DAW0Zh7KoWaIpsJ/dZNosh6sS2obZ67Vrjh+roE55tCxHNsWi8MdayvGJCfE4SL1qlnDW4xUNDo+ZVdLUUUVFFrikdUCo3gNQvaMAZBSxWoyQwR0yP4ZBYKeOCr26yTbm7GOc+Msk06FvbUqZ+H7pWlA38NNdlj7r6S1zH8e7EF9X/cpTE3iW3Gjq0AadWoWlZ1ADTGp8uaO107CDQ6387fhW4K0/vEuXmbbW+lJbCDew3Ar/dFbAKANG3AfDuMKAJ4Jd6lKXLBqyTE2BCNtNumakLewnQYH+L/bOF6bqq8stkGTGmnR4Q00EmPEhkmOQnH6GydcwQgryqoHQqZYybV1tmh5AGG9uxFLzxIYLzHoE/OGeGemUraiNNfZeUfedyLSKhCnLaP1X/owkS8ePZlodVghrS4/t+261QGdvxwDZ0Sn3yzjIYAnExLPPYS5gfMoNSIgPjCPhl1hafJ97oOuQN9Cl+En8KFkr5mVAtmJo/Y83XKQY+dvJqeXV9XaFKOo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KB/Gzd1Xu4iHJiAZRMq64u6hCOrMZxywy4qaZl4dPne3MEGz0sgHHb3VXoSA?=
 =?us-ascii?Q?ztGJ640TFGRGJQJVH8rDcXhbvSybY8Y3lVNRPFPjAlFIsLVBRyvgOt0cQ0CO?=
 =?us-ascii?Q?x0sdK57V5P5frwmJGHAm7evF6ZbcuT3+2nCRhX0ZNJTYLAW9m2sgzwJ9PbZQ?=
 =?us-ascii?Q?X/V0vHpoEaKSHRpCm3C6ritEmyz0eb7nZEH6dY4TTbt3nZGqEY7SZNufvD8J?=
 =?us-ascii?Q?7hVbTENN0xd8Fl8BHjvc6DZ39SNng3vJOFPnj6T48nnI8XWZUZ8uc9RlIvzc?=
 =?us-ascii?Q?Va5jStDra+JwYw4hm7wgSSEdLAvmxLPJEovHXiP6s234dqVf4z4q6XvrqRuh?=
 =?us-ascii?Q?/L362e+uAUY2zyH0wFvWpMM1dfHfabm4CM/vs/yDAcv1Lvcp3f9tFgr+mwqO?=
 =?us-ascii?Q?9b+vy3Fd8tlNpRS9YOORNYRNuoipclv5qn3zazmLHVmeCJ0Pg3g2ziJUs82B?=
 =?us-ascii?Q?dWss5K2EE2L3Ax5hfw9ULyfcw+UgPg+DNevLaXthekSStegCbCCwCegEv8Ux?=
 =?us-ascii?Q?cnLD+55eqMcP2cdO1CW4B3Qr2y2IPgZmZL454jSy2KVAWRCsySFojq/c+UGA?=
 =?us-ascii?Q?qFxT9E9MoPxyZwzQNgZKgrastDmDLYzddtuOb3015uTDb+AR0fhdTwxdZFBw?=
 =?us-ascii?Q?hVYz0m8eB8dTgBq3IXFU0spvO2pDoh03b+XiEc4QjYJ+0LZOXyiDV2kiO4G9?=
 =?us-ascii?Q?iCnmkNISiHmLuhKucWeBKVGJlKfrcLjvOL0OcxlLV3vVNw5d1VKs1HOIj04Q?=
 =?us-ascii?Q?5IoF2iv5rQ/xbmA4x+XyUKIJO09G8/EH3x3+Oi/AO5fMdz8T1lEqaWJccoMY?=
 =?us-ascii?Q?16CaJSgUF4i3N6Iev70xpAETctygs+1SYwWxA12Hv/xRtpxvwROQZS/ZBebK?=
 =?us-ascii?Q?b+5e19tl9y5sT86Rk1LPK0v/Xm6wtYPDSH5k+4b8ws36Vxv1NcQfBESTUcQY?=
 =?us-ascii?Q?EAABElZhmMI4+pXbwLdFic+iPNtrQgMugThoiqvCPavPoZT7IMiNrlktCRkv?=
 =?us-ascii?Q?kKmh1Xynb+IAr6tAxSgPgxkfDh7I+h08CbZgJkC4SUvO+kHWrG00Wog36kQ4?=
 =?us-ascii?Q?yg9DE+iOb+d/DM/SLPLut99mLQ30vBcmqn7vpshXD39WoGTb7lgPC0ZnZYYl?=
 =?us-ascii?Q?kqz2aY/5uFxLO/TSB31eovcMqBh0m11TV+MFlASBzgePzuy34eRbKVVAks30?=
 =?us-ascii?Q?GFLIIuOAjA4ul1miRF4ZAr9NFJq2DZeZaz8dhjBBzQBBm8OHenPUFIA9RbbT?=
 =?us-ascii?Q?JITema6pL0QxUc3Tl9OwFaOf3CL2r1rLedQx5CjIwpR5zAkNhW1dWvsiQTNs?=
 =?us-ascii?Q?rNVhQxNc2UWt7Z0fLrqhMNZjBeQheNXeDEKDe6DmJnockoul/fkKz4PEE2kw?=
 =?us-ascii?Q?YPnkKKd4T2Ooqi2OcbDg/qVn3bTSEoNQ+GH4ociG00w0vEq2VmWv8DjhtmYR?=
 =?us-ascii?Q?WP4BTQ9UUxV9Rztbsw1VrxLLLhOe9cX/Db7LnlhawW8aLMrW71wy7gFf6Q3g?=
 =?us-ascii?Q?EX+1Isdeicnc0nwb8QCM2MlowRj/sCEYRUjKvSwdPPA7KWhudUB35h3rJSlE?=
 =?us-ascii?Q?X6gh6f5FEKO2nrH+Le8So4m/DMp3B0VvktALZsMnlQsniX+nsx170zzY7Vly?=
 =?us-ascii?Q?V9UdNpaZwvdOecOlW6GKnsBn8mZ+Z61vzDZFEiZz6xsMiJMUnkHxgg7sEwKz?=
 =?us-ascii?Q?QbV/y2OdAHtIgZejCHd2QA10f//yEEQRQCYEv3I2WMAY5/D2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d1b8f-9876-4ac0-7dc4-08df13d543f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:31:19.9135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uEufaedtw00L0kxv393qYO3rUGNSQhWR7AU6i4zagzDhThmFYiL7QZS9lkoB1MP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Wednesday, September 16, 2026 5:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amd/ras: enable UniRAS for psp v15_0_8
>
> Enable UniRAS for psp v15_0_8.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index a02167397ce28b..e893d9901c08db 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -328,7 +328,8 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev=
,
> struct ras_module_param *
>               return 0;
>       else if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 14)
> ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
> -         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
))
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(15, 0, 8=
))
>               con->uniras_enabled =3D true;
>       else
>               return 0;
> --
> 2.50.1

