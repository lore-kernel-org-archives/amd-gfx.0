Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526E0C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF11D10E531;
	Mon, 13 May 2024 08:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qWARCW19";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9787C10E543
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOJOOs+V1BiEJAYrXNkPt+GAd1aDGXZYQFcooG7iJsu5+ifyHfY4mc5P4mIO5wufqipUcWPfbLW/4Z+p+2lu3s1Saz+GNMpLyTNfJJn/bKBlSbjTnf8ocClmunaYhYww6LekSo9anUNrB+pY516gh0MKorH+JSkJi2YCsC/5SzPvXGoX6GDBeiLmF7auKT/90RfzoRDqtVseEcRDmTEd4gL5S+0x1KCXGRIwo9OSm8FKbwWGMwUbDfrK/pBBtxtecdx6symeKjS5wPeK37JOX1k49NcX5MkhfiXWSWjDsdK/KF74n5WSquk01F+3srTbzAQClk4ukSZhj8ZsF00C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnqqpppeozpNWgyVWEzRDaFj5Msz64GhvL0j10wQMOU=;
 b=k6Pm4tf7BKM5eXwh7Z8VS0A73kdJDRbkxcf6/jKX2oVQ4Ft6Gru9g9d7D73dREfI4ENh1J4zC5ob81m0DmZh41c2psVJa9dseQ3NXt45jWytgZpl9rX1sjRBQoRpWl0z6xyfAGDvHvtfsePHtKg/vSnsesjJx5mvqQwlE9j3L9oUTzjVTeyb13kXZ5UMrS39ZNf6isTnRNWkKYQBLK93yaE/kF6RIs8Gd7hCp3DRbkVjsyk0qdGv1iTRjbeV7gqmfl8U+/aLAEo9VvIE7ElNVUmYEsM32MdrAs3ReLVeLhhSlAKkyoAW7lU/EQjwYxjTLyIfIbsaJ7fxIcCnKCeNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnqqpppeozpNWgyVWEzRDaFj5Msz64GhvL0j10wQMOU=;
 b=qWARCW19nNuCNAghKT0IEob4GJxgJx/hTHUHTcQBplo39X5nypW5KVNUoZC+KuiH5dfd6PPTEzZnMblGUj6I5WwjX7s50d7R8P/Z8niwU7pcusp0igonQ6DWKcjml5m2VzdS9kWkIzOSRwwyMFowJAe6dwvXKRm8ac5bhbUH07g=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:55:47 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:55:47 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
Thread-Topic: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
Thread-Index: AQHapRFl4ZPTezTvu0iKeMk/iEZ4dLGU3FVA
Date: Mon, 13 May 2024 08:55:47 +0000
Message-ID: <SA1PR12MB56592211FB21D663BFE2F7C5E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240513083929.91933-1-Frank.Min@amd.com>
In-Reply-To: <20240513083929.91933-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a0f72b4e-a389-49c9-a756-360b5ab5f063;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T08:54:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|PH8PR12MB6723:EE_
x-ms-office365-filtering-correlation-id: 9f6be1e8-01c5-4ec6-3709-08dc732a7b56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cFT6IAF5QzzHzAhlLQBqJ+e8BEHK12QgUKpwMsq4i1SgV3Jt09qqsLsWFzxL?=
 =?us-ascii?Q?nQOni7UbUslQlugJSQktzCO7P0C/aZHhNXmxUECrmkCuXCb1cxq0IYdP38FB?=
 =?us-ascii?Q?jtUjcvbBLSSSdD3YOXKrV6W17Uvj3UfqmbJ1cPiTmih0/aaNbAIdqp3bM+c7?=
 =?us-ascii?Q?AiwKq9d9FFo9qfdYU8JuAgPUtroo9ycGNJwGyhAogsN73SI73MK5b05l+aqZ?=
 =?us-ascii?Q?mvVBeLnWBjeuwO+5Y3o8ALFbBcaP7KFt5jrp8jguMkUodImEGr+L25qyPM8B?=
 =?us-ascii?Q?giAz1MljqklOiaxaIE/MlLNCKoS95qRwylkgJwC68z0lL8XucGxORFN+s+OR?=
 =?us-ascii?Q?Bh/6JdHey4aDdMTodjjlpmcQMW/v6pNn27WED53Ow3Ahj6aKClIM3QYR/MAO?=
 =?us-ascii?Q?T3tPb3H1AcYaFJcYYfgT5A2C+p25PwL3FpdPLes6vVRyzIG6wEPM01eWti3b?=
 =?us-ascii?Q?aSUXFPAU+QQ8Q+opw9dEEo8QoYhEGNbOFaOUAJd8pe5e811T5OntHTi2WWYW?=
 =?us-ascii?Q?HnHi8nx4/NEy9uVknJAQjo4oyIwTvgVOpGNuXKnqnjSxb1/5JORNZnqHVrOi?=
 =?us-ascii?Q?WMW602Utb/50ts/cOdIRc4RCq5PhKsvsdv82pJHWb+sj1odWCNhNfSx8ZdvA?=
 =?us-ascii?Q?MNJuvJw8/fYRPKw8folrk8LlOL6QQlgg1yQp7R7Q4vgB8LjQ9YqGsFmhlaP4?=
 =?us-ascii?Q?O/Sc2E7Asl8F6Ep+YLJVahNuH7BGQd/PiY1jdRoK2uRJypJ4aeB2nNULDPLp?=
 =?us-ascii?Q?6Z2TV+dnjBwNEoudpkkDN6AVXiRwBRCzWTYgcf6bNtGTRJYy023hV+aLhJZO?=
 =?us-ascii?Q?LiWPE5XrxtM7YSPf1fwfEB744Fhrg8NI6yfgjt7Dk1uSCnJWdZiRwSisdNuz?=
 =?us-ascii?Q?k58es66dSAmhXE/A+E/bTn9iUhf/jx1nyGs/QZ/hZMqtoY+OBZbO840ndDaP?=
 =?us-ascii?Q?gjpeTO1gx8dpfKT/e5RSwEJbsIaG1ozXFBCTnGZeI07Sme7C++sUolZCGpOM?=
 =?us-ascii?Q?cRmJ+sKWrIdkd3WtghGK0SoQzABjgvYewaer++tuaA6+xGvePOOTVFsfa8Vz?=
 =?us-ascii?Q?gNdcGukql5/3vLWcTr/QqG9vtp6acuL8dr0W35nlMza/F7s2qIA+zscirM+7?=
 =?us-ascii?Q?uWH+vOYnkfZStlCXSsHI0YG6VCgwvRy1CoBegF6B99z0QizSYZOc5u/eK2oc?=
 =?us-ascii?Q?MjwxVkXwsRNe/T/0T0f2S5hoSVsyFBFz7Iz4C8k+CFcefS//CUvBfYdGepFh?=
 =?us-ascii?Q?1JFEe5uTfDPTWYc4CoYRYo8vcJdwzUsB01eJpddWtX9pLpKEISTk4JAJD0sf?=
 =?us-ascii?Q?0TtN7QKA1IdFwO6ZWOt4JNSyz/ZMSLROXnNBQesCHuGcuQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2V6MLT/dJkpQ0n/Izi3TTBLsytrYAC00e6rNk5NCcUVvawA7sD7uuaTdh9aT?=
 =?us-ascii?Q?H7iZUinV1o+JIcPqynReiI/8z2IXmXa7d6d2V0uAqXmkzuPycefrngJPU2Cq?=
 =?us-ascii?Q?lAMfVjCix+rcaKiXzUZ5rq6E0EMTCjImM9nrRrdVql8HfXi73CXKv8IFmdDL?=
 =?us-ascii?Q?FCMOtdiUwwbj4agpwAUum/pxkOgM7mXNbqR7mkwH+GqnpBJ0H9pLX+TtMaNE?=
 =?us-ascii?Q?cODz+GWTHy52UWBg2RZMfPdVFf7oC2c1aXU0PU/Vp4xXf1HQskaXOPuNnAZH?=
 =?us-ascii?Q?83R6Y1+ZcXHJsyoiP9t3E6pJRiLHlqBQi4o7OBxsIYp7epPccGKqB5FzKu6w?=
 =?us-ascii?Q?vRHLpCW3t5dYJ1G/y7EU2TbB5KL40Q1qnqeSbueJXb2ayHAg/nInzUMlzdTZ?=
 =?us-ascii?Q?TJlLSQrKa2OvyYP0MKIPZokaOlBRHovYFeOnfanE9w46lRNr0vwgihFfQLD6?=
 =?us-ascii?Q?6k9E46ov6+m7f7bqIIGfYTKVqpNQv5tDwB97GIV27cho6GYPDI2mYZHbYvHa?=
 =?us-ascii?Q?X83y79O2tOHY+o3fo+fstYUwK4K0ya5WzJSludh/ySFZ5jSPcYSzQDeMOxkG?=
 =?us-ascii?Q?eiHBmUWWpReYNUHm9sjUDp2SQRxirIxoYK3AvzGvftbsB+w/ioiEDwjxCFI8?=
 =?us-ascii?Q?A+GrKoF6YZBimJk7eVBDsuWVkKVOZGOCFGwhZ2iAcGimfGwggU3xAfHzfNhh?=
 =?us-ascii?Q?S6AFYX0J7gRw4ydde1it5qFlUh4akeE25ikcOh8PpCvmt17XGK6B9fjy4mUm?=
 =?us-ascii?Q?+lthZebKqEKt6Sxo7pmFv0/lhmoz6WpAOdQcpAza9cQ3C1OfOxuRSV1Y9Zgj?=
 =?us-ascii?Q?d9ATES+4OtI2fn6n/I57uhMJh5hnjq2xw//JmRHfSoTkldHmJO4Djpcq1V2C?=
 =?us-ascii?Q?O976wFAXYvkmdkeNLt3fbR9iXkDwApEt8JPPhsK+9j3zty4KRyemWvG9xBIf?=
 =?us-ascii?Q?iezSFDFtw+PBU4wQiWxq2OMGoilaSyWNJdA9qlaZXONOtX5R+p0kmEGU1ypi?=
 =?us-ascii?Q?YKziQC6ewgxIJ03qier5HFxOPG/BNH7DbfhZwyMwD1VkalgfZGl6PsltIyIB?=
 =?us-ascii?Q?Ghf4qz3jpRmIueWplF6nk9kOwzk4zUz3j7gQM/zAj4EI33KsXfE1dp2Aq8s6?=
 =?us-ascii?Q?uMYUFJ4gRRV4vIlaejHfHHCRMsWoR9BbzNQMQ4M+D8HnG2Vipa95jTRbiyqO?=
 =?us-ascii?Q?ArEO/ZO4KZvC2qVkKo9SxOrM/hthTx09nN2ajZ3ZxAHR0dLt6oVA7IfwYvGm?=
 =?us-ascii?Q?+3FOKrloloVW/lrd30mYNImdf5R86iil5g4XvymvGT2kn20mN1+sR9X15orN?=
 =?us-ascii?Q?gBxpKgy6trgJDEpga/KSf86SBg+8AfL4ilj5HbriTfOT649k7bDz4TdoKzJV?=
 =?us-ascii?Q?tgikJkAEyG+JnJNhGBvyRMzjtRI/Rq0MQfmcTLFoqxIDCTUHspM9ORcbbtG3?=
 =?us-ascii?Q?W/v3/CR4aLm9zeIr8qdcD3PkmYhTBAyU1+W75NAQ95OVzvJWQoa/+ITlqgET?=
 =?us-ascii?Q?cRrRuhyI+jHt3rZ2Km8t99ga8jOgavKprCZQNxEFVH8vLkCsSPHf7rSynSf1?=
 =?us-ascii?Q?qi/8OIP8LShDx4YDpsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6be1e8-01c5-4ec6-3709-08dc732a7b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 08:55:47.4322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oR0zt6hBgxxNbVkRkPUKwrjMDdh+J5nz6fy68Wtt8S0115lZylp3bz1tT3g/CxzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

From: Frank Min <Frank.Min@amd.com>

add initial value for gfx12 AGP aperture

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 34264a33dcdf..b876300bb9f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -622,6 +622,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_d=
evice *adev,

        base =3D adev->mmhub.funcs->get_fb_location(adev);

+       amdgpu_gmc_set_agp_default(adev, mc);
        amdgpu_gmc_vram_location(adev, &adev->gmc, base);
        amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
        if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
--
2.34.1

