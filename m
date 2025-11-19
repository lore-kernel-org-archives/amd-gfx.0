Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A3CF2567
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 07:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B748210E596;
	Wed, 19 Nov 2025 07:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7tr3KcU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B712E10E594
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 07:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goIp6BLBIdgHPAd/MmsXorQ2XQ20ClT3ECxK2cZ/qpN5ft4rBCtmySgUmFeQbuVuPT7Pt2IfBrFJ04WOVulsQMPsINdu/Z/VNe7SeB97zmok1zQa73B3jvHabga0xz1MbUo40ADhnYtEpssmAIRBYOz5ELASVIXoVAh06npRpu3Vtmfx2MkMn2TF2aWrl7DU3c1+FigSco5u9KLDAPf5lOR35qyXoCjHmSs/fI2RQJ6fxfnR81EnU3SWUZpCfDFQYC9dav0TXa2SQluN00GFp3KDR65umavdBUrREJupvhTVlIWi+udjGOCyVzG0VqORFDdT8934UUFYG71owNQO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W/OrmwO3FXjFA7BsEjcfT3S7/qDdlA5PsGu6Y5GbPc=;
 b=C40nIuOtmCIFXbslXkqkylf+GoVEvT+Bo0vVieq+MUEJ6BcnJVU6QkzHYiBDv548tQ9f3OfRz9QVsBgqQaIKDOYE13sPqIcwdxBUvSiaV/JZsz01n+FjTb3MZHSZL52SDMj3qhTis2irsD4J8o5Nn5gOdu0HUzNBGMrZwEgezzwpYC3fSwZAa63+JLJBOKoZkHW/xl7/PaL0m9hpG/VEYlWDbgbjJnVJ0EIu2ScgX6Hv7oUWHJAi3w9dxkVPZlLPmZICt86ymSxiQG0ahtHjFy8hedXxihhPB7wTstK9pgYnaGVv90bgG1IRkEnB6njka9Dyhc5Bk9k33ZUCggD++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W/OrmwO3FXjFA7BsEjcfT3S7/qDdlA5PsGu6Y5GbPc=;
 b=J7tr3KcUtVrpD6kmmBNV+FpTaX4QCFLcqObOduUjA0zd6HzBp8LuCDmqNkEjXEYX1n8mirXm/SshGxjY0yTgkU0Rc6PfvM67B196jg0noDANC7JH+ZTHN2EF9YiW8Cw+qop7Kb+rQjzbDmfZlmi7o3qHw3SMvR9Gdcb/dtjnnFk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:31:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 07:31:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the calculation of RAS bad page number
Thread-Topic: [PATCH] drm/amdgpu: fix the calculation of RAS bad page number
Thread-Index: AQHcWSYnfGyB+41rjkW4GcRvlQgJobT5miMg
Date: Wed, 19 Nov 2025 07:31:16 +0000
Message-ID: <BN9PR12MB5257E6591625DBE40B2C964AFCD7A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251119072823.1456062-1-tao.zhou1@amd.com>
In-Reply-To: <20251119072823.1456062-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-19T07:29:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB9066:EE_
x-ms-office365-filtering-correlation-id: e9d518ef-3d89-47df-9184-08de273da024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?znC2DZ9dg5NdJI40UCcz9aOdB1SfhRSnfEgC72RPsNzlR9B7hEukCKMqhfjD?=
 =?us-ascii?Q?hz45DjEDrS/ueKQuZkuKLLWiPa8EAtD+luU5eNXF+8hcHvxaK/KSAL1c8YQF?=
 =?us-ascii?Q?ucDY6NdF1VRjNEnD7DA0QPcNpbwzly2hSHYteLNVg7GbrRy7lUb4sqU0BbVY?=
 =?us-ascii?Q?PlNaLTwK1/9u8jvhy8wO2dFiVddrOMSepv6/Iv9fE0Bf+5gwwRFwslglEM2g?=
 =?us-ascii?Q?xIg4jh6zQDK6Xwt7MoarbrjMF6MhVXZiuvITWbCr4NF0wwRKNdpeZc/Cfep5?=
 =?us-ascii?Q?Hownox1TnCfxw+AnRWkZTtcEL8PIoQ5JhCcNQVIfqtpNtlhRHENCwHFehrfo?=
 =?us-ascii?Q?lT5/vo4O7srC67h6Kxjts5uQipPo/diQpgB1istld19P32xaxlZYDktOVdDy?=
 =?us-ascii?Q?NUXt2XYlL1Sb16Z2huKBfcBZ5luqqId+nkQ7y8zHCTSYrk5wsZzsTclG1yDq?=
 =?us-ascii?Q?5XLmImW70lMJrI2IhAOGjpUf03uG/YZavvsQTeGh0GIlyrEYiyE6xVaHzXVz?=
 =?us-ascii?Q?vpsTfzMP13MHVOMrkM3Lo4DVbSo9bnFJgyyCVKj3tyTG0wqE5ZD3XGihbk5K?=
 =?us-ascii?Q?I+YX1iDjY2jk4uwRWBCux4tdahLB1YZ49oKxBZjYWtRd9XtB89d+7lK1oOJ+?=
 =?us-ascii?Q?P9dK4uwqLBSM11fejCEfkvjdv/XyPQJxP2B2nWqLrEig/E4I8ye2TPlJSxFu?=
 =?us-ascii?Q?LArdQLA3Sa2gAqsphMiA1xnfFQSFh9jvPiIh2jh+AUt7jiZRyayXI7vDgzy4?=
 =?us-ascii?Q?rd3KUFsI0leVF4C8deYJAK/wBOvUSmIYXiN+z0hv4Lp3G5APyIbTTWTNqnFp?=
 =?us-ascii?Q?kYji6u5RG2kdOEM7Z9GweTKzoYjdknlgnojue3QGbnoUbbDDBSV7TIIOJiGX?=
 =?us-ascii?Q?B2Rp93lNCNY9R/dmQ/U9OdxXxqzCYIeGLmOj1xrnyCkMPo2c3kPAXPlN5Mwb?=
 =?us-ascii?Q?X1QkI0xViug2iDQRvW1Q4gx1ycAFpFnb/5XhnPme9HzC6qMfaxXZM02g43XW?=
 =?us-ascii?Q?/25FiZx70kyfo6E2a5QCAHuwU9whKUWVePP1KFPQIRueQqFJRnXJE2vi5oLr?=
 =?us-ascii?Q?m+MqbMN1TdvzRkil6EEl4AFHHj5HOy4YiXS3XHG589aMA57hTZZ2susPIoEj?=
 =?us-ascii?Q?8FFwr9jdiITWKykHGemnmnpxL6Fg/a9yvcGwPBYQI4wpYjaFjhGhn3oy4O58?=
 =?us-ascii?Q?t/tX1oYtSW1JcnXtNZ4Y1VroasPohLOpawxKNZGgjzrWVwU2g3i1d5pnmokA?=
 =?us-ascii?Q?YbE8026q/OjYR1ENk+UzOpOmkVdfJJ1GbRvkduk+tkL+wWBwyD0RzyavItjn?=
 =?us-ascii?Q?t0XzKzbirBjlZ9wApwhF5jkiBK0iLcq/7l2Wzzn6DxE7Auo1q4Yhi39eDzcO?=
 =?us-ascii?Q?Gn/By9YUh1ohlRSGZqUfyH3jGDsPj9VOp+ITqQokygxNimEB7aHcA0c8h95b?=
 =?us-ascii?Q?OjzsMiHRkK+nUhdzyoVL3iCeOEhiWyobDZ49Gv32RjBDPqX4Yqaxes4AniN2?=
 =?us-ascii?Q?/Ursy7cVfeWWAD+/5kz2Z+/lXFznl5xDXE2q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ixa2nWHXrD5ZKy52yH4ap+EQJ++subn96Vw9C3wgntxR24VXHUD/3yPUVNrn?=
 =?us-ascii?Q?KIylHnYbcHynwhwiHMmvA53605+KgrBQI1swVrSsbik1p8kIT+DWfXD+RUzn?=
 =?us-ascii?Q?8S/+DzvyjdFG7uO1hxkEAiCC4GXrA0Xf6XHK7CqZHIXnPZQq3St40OZ7c1oR?=
 =?us-ascii?Q?yTLc76xhi5NbIJmrTFNQ8wydp2LHLOve9o8CFWNhrmrJa6UEAawtUOEKz80g?=
 =?us-ascii?Q?xs2UD7gDryMdAi2zRw/P7sbULF7Rbeo2qkySPDdC16kk4xa1X257Xi+NsdDw?=
 =?us-ascii?Q?wvvcpHyPO5O4VP9oDBcOREYS8+vYSyoffEUYiMM95V7lkJDJxDyaDCcFMqgP?=
 =?us-ascii?Q?puI+jcCTj91Yuhr/Yf2+nrt7I7CyYGs85ICrWL38qD8VO3JWV0zsM69B7ikL?=
 =?us-ascii?Q?QQtNLQgjzyNueXawbVgxbBEWspjNgOyF78s2I0LCSXdupA6vcD8Zq+GWKV32?=
 =?us-ascii?Q?Mf2ttS+QkaRIXUATYp3xgMcAugDs1kBf6Z96m27siZcx6VFGbIZoZAy9TqO9?=
 =?us-ascii?Q?tObPHqrGaw2C4KYWEmiLU40jylNfpJLFgL9Wepbwek14faJowzCQCd/fGGln?=
 =?us-ascii?Q?Jtzeke1/nSQmZNIFSwG9hlrHmSSaNAVmsjNuUVkbXM27cQYeDiOgab1SxdxE?=
 =?us-ascii?Q?9vqFeoXvmECMYCkJGQNj39gMnVhFvU6bMtziSIoyBAqUJZYeJsL+PQ/QT6l/?=
 =?us-ascii?Q?GAuUR3iU3D6mZzNZ6eZDPvucMAhIhgPkZCWQ1Yhq1/9CchKotYK6yhMdPZaS?=
 =?us-ascii?Q?bdCBbhGJIoYL3MyMPFa0Z8ef6XxkVEnoiSo7WQwTrQKFPzWsYGu8A/wBqDWW?=
 =?us-ascii?Q?wJo1pFBziMcCiDsOouwpm5MrYFNuaegwCN3xsDEVu7C5enOnJF+9nrZRHO8A?=
 =?us-ascii?Q?dSZOR5pQJyXvExHT+3ZTocpV3CqPm1DNa2q+tc4qOdXDsANaRXAf+88GgYdT?=
 =?us-ascii?Q?0H3S9+z0QKJQf57EbQaPLakXiIdYZ5m/i215Xu4rLRsxHHiH6gUH/pDqYfwp?=
 =?us-ascii?Q?hI5eOCS3zc3XV5LzOvID3Jt9a37tC2yiM44ucrDvm+zacP52vAOWFRon9FQZ?=
 =?us-ascii?Q?Go8MINYSR5HV5TGKNsQSaa363jGiMrIb1gMWKhuZIF6q3Fp9p0Ub8WqVaXYg?=
 =?us-ascii?Q?WwoopcbLQNJnRmxxOIX62Ekl73JR7kx9CnOPtskG7nJrZM7aE+qTpCkSPcy3?=
 =?us-ascii?Q?Rw8u5AD/zEDdiXemU9vDYGXvEGqRF9wc/uEyAYBGrI+5UfzCkHiMslPWajd1?=
 =?us-ascii?Q?6A045djBml34frrRRG1Y8U74xJG0q8fvqW52QUUPApNO+EG/FuNWXphZa6k6?=
 =?us-ascii?Q?KAdEm6OUycL4BcA5QsZhYsN2BSf9w9VeEv+qfQMfFIgtg/x5NDawvgAIx5d8?=
 =?us-ascii?Q?+JCR6NQIVnk8/1ld7wDN6fQWYDQv9CW71qMDOcR3ZFWYegXaYH6FayWZOFBO?=
 =?us-ascii?Q?KB2kwYbpzQFcl3cOKxCQ0dgpLyKv7wAgNCNOshX+EBVpjwfLt4niY8xpfKh8?=
 =?us-ascii?Q?Jo/FfMtz7XmszKiSm2eO2nbUxDWv1P1fi7mXwHqGX1HQm5fpJt1F8gyJ6gRs?=
 =?us-ascii?Q?d3SwDnRpreSILwSPYlY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d518ef-3d89-47df-9184-08de273da024
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 07:31:16.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA24BkN+REwd2cSc49LegQ8lzWnRGcg6pElMFYDSocJLRTv13favsDj4gIgRvilKgO5GyKy2T1MUaSd4Q18z+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, November 19, 2025 15:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: fix the calculation of RAS bad page number

__amdgpu_ras_restore_bad_pages is responsible for the maintenance of bad pa=
ge number, drop the unnecessary bad page number update in the error handlin=
g path of add_bad_pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 00f890bbe912..b0262fd52b58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3263,8 +3263,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *ad=
ev,
                                                /* deal with retire_unit re=
cords a time */
                                                ret =3D __amdgpu_ras_conver=
t_rec_array_from_rom(adev,
                                                                           =
     &bps[i], &err_data, nps);
-                                               if (ret)
-                                                       con->bad_page_num -=
=3D adev->umc.retire_unit;
                                                i +=3D (adev->umc.retire_un=
it - 1);
                                        } else {
                                                break;
@@ -3277,8 +3275,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *ad=
ev,
                for (; i < pages; i++) {
                        ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
                                &bps[i], &err_data, nps);
-                       if (ret)
-                               con->bad_page_num -=3D adev->umc.retire_uni=
t;
                }

                con->eh_data->count_saved =3D con->eh_data->count;
--
2.34.1

