Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9DEC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 09:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3251310E71F;
	Thu, 29 May 2025 09:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQLtwPPi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB9B10E71F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 09:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vayoRw6TFHjhFlSluqT50pTJVKkq1t4a7BA0ssqi9o7jLueBM2x7DwjtSFNN7Ww9OZmtbJwwaN1ulKy9TRZWJI/6b+CvlHoPKoP8yeQbw28gtEAvQL+07aPM9ilen5Vm/9fDUi+HKDMl+XCoag7aZl/WpKXIcmc1Q7rm+TZZ4/iRYgWBps51fLcbZnKP7g7BbBmS2DvIlezEeyi13XKP1OT5y73e5WdZyKQylIIzkxThrzf/shW7BQ2Du8wss0Nrou+RlxW1fWz4TJsKX7t8/8XUnVcnWVHurmbp0XYez+FI5KgN3kzGjeOxnixuK317aiG2A8E9LcQ+NVyweskRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+apw6fEGK/A9Qjzc0wTS/MaDCRQeXYAYyi9oZOD72Uw=;
 b=CcZAgA2hyldBsJYx3fVDqXudKIkMg07mZq+DgKgd3PKiOvNCoRG64XwoBTXtKfiV3ZXme9xbFS+v6F5pZ/2zbd7sYWL/rD74odxzPjs0Sv6Ho8aSxuU0OFKV5Rl4wlAYTAZUkeaOqB07zlHGkVzj7j1ou+0qhN66S59g+eA6mkJ2ywXd2fW3XxZ6hgQbsVmt1ozzbOrqVS6ntTVOMtiHYog08PQ8mxVhtUB6M8Xs6pPhdgAbDeEnYZGriAJ4Zkw0nNjDALjOR4GKS0uzev4rWsrh3ueQCyPWvSiu0IianFdcIC9toFz32YZkh7kC5CtBWkJG71zqWMuYxpbQai9JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+apw6fEGK/A9Qjzc0wTS/MaDCRQeXYAYyi9oZOD72Uw=;
 b=EQLtwPPiUQOF5048FuAmmYPlPDUZIuRvmuhQ2EdZLnPtiOnKWiXSefxMx/BxLhRXmotV2KohgP8tksQLwfkSUGXr5lkmB7xcldTVA6lE374Jv012QEWbzV0RE9csou5NAEZ5dOhBA+46qfXlvgLPLcDonDVb1J2Ft2zGg6co2/U=
Received: from CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 09:04:54 +0000
Received: from CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f]) by CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 09:04:54 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
Thread-Topic: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
Thread-Index: AQHb0HPyERBZDgFp30iIz1rTiUybS7PpUI3g
Date: Thu, 29 May 2025 09:04:54 +0000
Message-ID: <CY8PR12MB8339970C8470822B51144EF7FD66A@CY8PR12MB8339.namprd12.prod.outlook.com>
References: <20250529083015.589652-1-lijo.lazar@amd.com>
In-Reply-To: <20250529083015.589652-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f80f6bf7-4494-411a-84cb-6a53c109990a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-29T09:04:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8339:EE_|SJ0PR12MB8090:EE_
x-ms-office365-filtering-correlation-id: a552bb5a-777b-443d-c673-08dd9e8fe0a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oJWL4aEoMnlZUcshLtSb83YkNjzShZ4E2Sr7v+cerKNCsxEE9IsBlrxKVxHa?=
 =?us-ascii?Q?oPU/TJtUn1HA2VBsurvwRpapnJd3pA9XJbLbZAwXjGDWEvaNW0ahJgrLB987?=
 =?us-ascii?Q?9ijh3580McSXm5qB0VKDqCXf3BCbGLiiMARETvtZL2RL41Mnme9o6ECIfKgu?=
 =?us-ascii?Q?LAMmqL7F2auNE0le9RYqTlj4nTYI4YTHwjcU4cYGOfi52l4tvXdo7Xnu+XHZ?=
 =?us-ascii?Q?kZLQ/wT9mWa1vVbjxymiUuD8pep1E26yNhtG1o6HOM3VI10ewhyQh3MFdPy8?=
 =?us-ascii?Q?JAGZ0NWFxdh7hj+GxC/ZddImSl8xSTt0IKpVLmtGnbdQhbzWdcO9J3BVvX6z?=
 =?us-ascii?Q?WiYRFpCq1rlYDO2iUvKq6pioQJWPNg73TNJHvFLSQWwi4GOzXj+ar0iQYdd9?=
 =?us-ascii?Q?dG19EIBNyMP7wDqzF9DuUSHmiHR3Jbf5NNZzcnZX2X9EhHtOmakm55zZdSpP?=
 =?us-ascii?Q?+Z9YX2ELUH/P/uISvm5lXZ9SHumzhyfoXZ5QMfvIvWvlzTCrZknDVEDDWKRU?=
 =?us-ascii?Q?UtBuIwtZ3T4+Ovs3o+aZUA9aGT0dhtVvV3GsmLJ9qIWSNSdoO3qCofa4/fAY?=
 =?us-ascii?Q?xgE22TsKHW0opaLVsPkfd5Nu3AGmZgc/4g6bcmCgjz2BuPuOubMsbhEDJJLa?=
 =?us-ascii?Q?NKX/mE2fgrjw+SBoYKhIjhdH24Kna+IyAltObIR41miVSTPZxavEs6Odl4aF?=
 =?us-ascii?Q?AGRTOxVO7xtmU/Qmw0rJFTOAOK6So8blUH/N6woNto2O30maVXj52XpgMUL8?=
 =?us-ascii?Q?vrq+Ygb3xIPOq1gkAw8B2294PpHujjm7JPoVyBjqp5P4I75LmcnpitsBWY8k?=
 =?us-ascii?Q?pTjaeulQqu2fSLFcpA6LwO6xT3CdhLb8BwwSC7r98CJQ4SsfkMYr8+Vc+xaP?=
 =?us-ascii?Q?L9yq7CcroQVkaELRMGt7uhI8bVBGy7RQ0eZBdAGCkY3IsGRgEmO/ydxNMJDk?=
 =?us-ascii?Q?ti9LP/6cgt/JeBfuPOtvRcZ6G/xcOWZfT18Nns0FcsW5e3r4VMU/AkbTrI0O?=
 =?us-ascii?Q?mjx2nhH8sInouU2iQptuxdq/NwGsVne9xdPKKo0Jr2vj+CCynn9vFDWSlelp?=
 =?us-ascii?Q?NWV9QhLybD7mzeAas8Vd/jNBdkfMohTyvjn3TDjC2vRSJ80pG05hVnSGav9o?=
 =?us-ascii?Q?8NIf3/I4vUol0DANQ7Va9m/YYTRlIPNq/lgmPp2mJea9FW/jg5x2XvBV4/A9?=
 =?us-ascii?Q?X8bHckoDkrPLAbQHiyyRS4/JUpG6qj4/rEP2Lst827btYxCS1V2tO+7ZXqwZ?=
 =?us-ascii?Q?8vECOVBzHxz7dzETrlXQZht/QnUU4TWenms4hy10cLUvRIn9QQl5CVligG5e?=
 =?us-ascii?Q?FPz9J96DLDLS6Xhi58pmylTc/VwsSpkq5B5lgo3afNx3mM9Zg6SIghmoqBxw?=
 =?us-ascii?Q?LIz5VBUEIAS4bavcm9gP3AAgeb2lTQ4AwfhqRXpLhfqxHlPW6OMI6QUnTEfh?=
 =?us-ascii?Q?a6sBpjAFsFr8Xd5VF8SiI6IHopA1rVCg9NJzj0QG6g6YSFpA6kMJMaemfJ79?=
 =?us-ascii?Q?ReR/fA6oOHI3AVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8339.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B0o/ZkOBTuy0Gdo3SCtif7s5Yfu8aI99Rc8Zu7pJ443eKHRX/YoW8A/cm3Tn?=
 =?us-ascii?Q?eYrX6yRnTWwkE3ExPUTCZc8i97Ih9A3iWF5OC5xqU33YOjwhSBMHYXbgNyac?=
 =?us-ascii?Q?yb9+LZgoLxUC/A762/f+5SBfYd5070Kmv8UVs+nea672XrzAm2iPNAoHZQ1T?=
 =?us-ascii?Q?CK44xodHwFhkTAbe0IHTWlYj3EsWJdY1E9M8i80JgIw97+Q2zv70oSQLJWJR?=
 =?us-ascii?Q?vPd3A65D/axOjSRGor2vElh8tzTSCG/HZiRTJofzBXF8fMPBNnHOwXbBzo2x?=
 =?us-ascii?Q?TVnlA5xiNjUvm0EkWBpoxhEzYTOAYHWh61JuD1KnW2bdJXDbpDKW1V5wxzQU?=
 =?us-ascii?Q?TYm8TG7P40TpPXJkQR/BpdEmvSC+x2TvpwohTNCP/dJa5e9jyTHZePK9asw7?=
 =?us-ascii?Q?321PSzw0XKULC6wz9aWjEJ0GE3Cz+VATRs97qmas9YX9zqHfqdh/VDgVhCy5?=
 =?us-ascii?Q?RuP0C7L+PGlLWdDGI0gFhlL9P4+CuwOrLLBAMwQh83+RJwpr4cLT2VZatLB0?=
 =?us-ascii?Q?cCwAs76ALC0RmE8g/poQrZoxOzJS0MZ7HnWa6HaH1In7Z2ZUPeuooQBvxcYs?=
 =?us-ascii?Q?R8q1yrdtx1uwgjSxMY/BVV6V7acVkKvnPzEqblcVkk0/kFBQHUEnDIqoIO1c?=
 =?us-ascii?Q?TvgudkEaETBnSL8Gd/X0f2EifE3T46oGHoziAM41EwP/84Btvhj0YJfA6vUk?=
 =?us-ascii?Q?enWCysUPAfr4nMlRoNRMDiB/5jNzDOrWkvvK0KfkYFSIp6w+c0TpIbwJBasY?=
 =?us-ascii?Q?5P1jYQ0GdQuTaW6fvrbq/qN33ibunx7mL4zwGejgx/Oe4tz2OA8eUno0Hp1Q?=
 =?us-ascii?Q?wq13ANqSfhoOlbl04wpgiKCenYp7sjICPT7OjjUc4JGL/sppEyghMYdmiHCA?=
 =?us-ascii?Q?jgQNhz7JjFxjwEHNEuDpH1tg0faQstaOLiwaXCV6MC18V4FpiUufZy7fn6vm?=
 =?us-ascii?Q?3mKd5ghsLcRBx6ti//dczvn2UZljeTHtagKULVrz2zzGteUh7aLS+aJTgodQ?=
 =?us-ascii?Q?F803StRx60hvKgKUyTx3cZr349CTwgbUbqB2BH70s1PjHQBqcwiXFjRyLNGI?=
 =?us-ascii?Q?12Ki9r5fzFcfX03cg7x4qT4NuJruYrolz/U47/+tjDZy7D1ANqh8AlPi2Z33?=
 =?us-ascii?Q?Bl0P658/ScY4IV6Exbb1v1KZy7clcJcKvl0HI5wSDZQw19LiPbJqvxg/E0Yd?=
 =?us-ascii?Q?u2L16JPaOF2lYsAI5igfL7UOaDhJcQu3uYQ3AvbIKumKsdtsFHoCEgug+FLt?=
 =?us-ascii?Q?whSm8KFfmU2McRXvJSa0I8qB7cTmdmdyOjV9XJ1RTSlRTK/2o0Y+LL7QOJzF?=
 =?us-ascii?Q?c4Kdq0nAZejkrNtyhy5CsqrN0HnQs9bNC/Pe8H6+qFN9HZ3xo6C9/PeD4fLN?=
 =?us-ascii?Q?LnITObc6GvDWZGl3ytg0W15vnpWBKXKhVSw/rLFvuWDs7hoGHtdhvUG7fnIz?=
 =?us-ascii?Q?lGO4w+59Y0i7KuWG1hSgKd1mgsC3R9fKZnjYdo4xb9MuAijOIqaXpDgv1xiR?=
 =?us-ascii?Q?fAutWnPxSWtRsKlnv1qw9QXsN3rkulhbM/Lt9il9M5ohSu48Xs+p1ASCvIm9?=
 =?us-ascii?Q?lZ1OHKrf5JtPAjMRHxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a552bb5a-777b-443d-c673-08dd9e8fe0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:04:54.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+ukCMPNZHk8+niNaCKnp+mTcUZ0u7fC5bCTXaIbYIhp+63uxcpfeQb0uHHwjX6COHynGTssjN8EjaTu1DZtmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Acked-by:  Mangesh Gadre <Mangesh.Gadre@amd.com>

>-----Original Message-----
>From: Lazar, Lijo <Lijo.Lazar@amd.com>
>Sent: Thursday, May 29, 2025 2:00 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre,
>Mangesh <Mangesh.Gadre@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
>
>Check if pcie replay count reporting is supported before creating sysfs at=
tribute.
>
>Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   | 9 +++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   | 2 ++
> 3 files changed, 13 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 72e41781afb0..9eaee8dacea7 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -232,7 +232,7 @@ static int amdgpu_device_attr_sysfs_init(struct
>amdgpu_device *adev)  {
>       int ret =3D 0;
>
>-      if (!amdgpu_sriov_vf(adev))
>+      if (amdgpu_nbio_is_replay_cnt_supported(adev))
>               ret =3D sysfs_create_file(&adev->dev->kobj,
>                                       &dev_attr_pcie_replay_count.attr);
>
>@@ -241,7 +241,7 @@ static int amdgpu_device_attr_sysfs_init(struct
>amdgpu_device *adev)
>
> static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)  {
>-      if (!amdgpu_sriov_vf(adev))
>+      if (amdgpu_nbio_is_replay_cnt_supported(adev))
>               sysfs_remove_file(&adev->dev->kobj,
>                                 &dev_attr_pcie_replay_count.attr);
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
>index d085687a47ea..e56ba93a8df6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
>@@ -53,6 +53,15 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct
>amdgpu_device *adev)
>       return 0;
> }
>
>+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev) {
>+      if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_cou=
nt ||
>+          (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_count)=
)
>+              return false;
>+
>+      return true;
>+}
>+
> int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_comm=
on_if
>*ras_block)  {
>       int r;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>index 79c2f807b9fe..b528de6a01f6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>@@ -119,4 +119,6 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev=
);
>int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_commo=
n_if
>*ras_block);
> u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
>
>+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
>+
> #endif
>--
>2.25.1

