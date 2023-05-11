Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFF5C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5D510E587;
	Thu, 11 May 2023 02:28:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF4310E587
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+wJbbugLdnn7NZd3Klv3/KefSe4+OR053pHc6JysZ/cjVyAJJIQ2i7XV91Gf59C74HUxjEcsmjQmH2bixTtA+gtfjj95zdAe8lqgNXwaRQ1gc1e4qL9du7MuC+qoRxx+R/2cSdJr6Qui9UaMCoeSBAqvlyjgxOV1/tBpzV912Rkr92aHHzeNshIdjxQj6ATLhMmMaiSJQXRaGxYK4XSx5h8nNCU0D1Osb0wgRT8K9G9c4Q2qi3jCfVK5jXN2CS/Z5m/ypwv6nbpU5cC4ecZeOAW7gXbOYlkndln1w/JSZNvqFV6r/XYblsDkR+pftPSqkw2fBXdPgOVL0WFGZKPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHOdE9b4kx1PHrcxqOQve4LZcnXMCTJ1BEMFtv/BpIo=;
 b=fyNQz+yk0s1YX+s5LMc2fzk7spgakY4kkYBALQus0rtbUGMP+0iZvryXFoIrdG1PjzXsqufbmFBYbKm3MUKJ2yItLTFkKwxi0GVDXLQmYUGUcRhDVB1Qo+UTEfWjZAuKR7G/I6pyR27g+ignAIc880FO+RNagKoHqW1vZ6RptNsnSmLcdWlNuwRFihuX7iZrVeaJo+jqmqq23sYVMrFhrW+hK7fOPV0NrRvAHi36b4zTCU91C8lbDudPiaINJqpuF9VBlobKUQOK32t8M4xr8B49cuH880tGm7SjOVl0ARln8jh0b63/x5QjMgBYK0YF7gf3hb0vZc3TZr2HGBHOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHOdE9b4kx1PHrcxqOQve4LZcnXMCTJ1BEMFtv/BpIo=;
 b=oNLnMYSWj19H0PliWrLfJnAlcZWYpYo4U0lCL7ftuoNjsbjvdSZ3maitJwgqkICREWmCTqjHsfpsyHdQlD1GfEieDAjkD/J62R7yFlWN5awpRd+GgqG+jStNVyGwbilxC4ySM5B6zdqMwGcwBD/uojIPS9hanaBE+RIUpiYrf4Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 02:28:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 02:28:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Index: AQHZgZasZrRwdOnxbUWSv4+E8XTEcK9QNtUAgAAXeOCAAwofAIABBDUw
Date: Thu, 11 May 2023 02:28:27 +0000
Message-ID: <BN9PR12MB52573D335EEF399D2E5135A9FC749@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BN9PR12MB5257E9F12A8C0FC2CF8B1A5CFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
 <SN1PR12MB2591B9BCFB27E5F48156EF5BF7779@SN1PR12MB2591.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2591B9BCFB27E5F48156EF5BF7779@SN1PR12MB2591.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-11T02:28:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a490c4aa-82aa-485c-bbc1-c470b98a3163;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: c4159d43-21c0-427a-255e-08db51c76720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bM9AuQLPm9ngi1U02+cuGR7JWtnR4nNxGp5n+iF5JrxV00WfLRtQhzMa0WHPtC++lUdsVbHUbxayPubon9w2iXaufzVfMFah2qbnKJ2vfoqjKR8PVL+8z61mLDQrLcfqCW2/r8W8xo5w1XDxhZWssRY1k4+N5FEp8T6RVqPiwpumqofI+9selvr4412rvYaFet8zzX545kc6ocgvQNcOOXxdZFmfxLemtpt6TJchQC5AGuHpaWC/dMGPU9XD5moe09/79/omKkf89mnSKYtnpCgbXtQ+Qzv2YjXXwLSXQ+o2YybOFWzjoRoz6Ip1+aKhhYyqRjCg3agJU5dRdj9O3BBsg3o3N/d16ZWeJBfMtQ4fgcqMMalxqLYwtvZ+Padg9e4Y1arwfjLt305Z6GSpQ6DOldVrt1vAlR9lbk4D35y4RzeiXI/5StBnhgD7O7h2SEgIq8v/+iawN9Goz9OvT4Dwbx2i6l3nnw6FkG504/662cZYQ3rZ/BO7IzO5tePqcHCLWeRuXU9rYJghga/+UIsQ0JS/16k5rwT8Tmq9R8AF/0v6fmxQI4Ttn/R55mDshoDNoZ5FXfI9rVGWPcQMdb/YP8QfC4f7WZPEQFsOWFhpEs1wX4Hch326R2rRNjZLD0c71SZL57s1LkhXVdNJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(38100700002)(122000001)(8936002)(8676002)(76116006)(110136005)(54906003)(83380400001)(41300700001)(33656002)(64756008)(66476007)(4326008)(66446008)(66556008)(66946007)(316002)(26005)(6506007)(9686003)(53546011)(186003)(55016003)(478600001)(86362001)(2906002)(7696005)(71200400001)(38070700005)(52536014)(5660300002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rajp+5mvYG8dPzNuMqsURqGa+/kid4l2Vpo/hNpND0IzAOnL9UEVVM/iczB6?=
 =?us-ascii?Q?tMLVYGFHx45FvarJ82H28pEZsA5vB4dyAxCMSQ1TywP7ltlcpDOLH+pkFCC8?=
 =?us-ascii?Q?9qgnkpHWrlxjQ99ZkKRs2PUhg9YkaigqIQWjsCnmoqeQ8PEOhx3kqboipC45?=
 =?us-ascii?Q?xTjoO9jd9OhZA4OmDWz+jgQXXKDFfnSh1uIp/VFyFpW01zX+YyAZVl7hgT3V?=
 =?us-ascii?Q?FrjfFJ9Ce63MjrCELrAnGcbzVIC26ExDu5NhTtgKSjONnWt0gwcNISaTYabr?=
 =?us-ascii?Q?RElz4dnd5GPa9Vz1GQTvAi1Wr7rZ0B7s5l4DVvu4NKpKXYbals+aJSC/esX1?=
 =?us-ascii?Q?oIucEbZmwG1CAv/d/48HXuhLvnRfOgahMVV4A74Wp+nMlj1fYR7y6lpkQ6Bm?=
 =?us-ascii?Q?wz4oY0C563Ldh1XLxAdOzI54Oq4eykic++lm4zuoUtRgBxRMvqphhDCTRtcW?=
 =?us-ascii?Q?ev3w1Rbd2N6QDG1hpK5rJT+BfRn2ELZeQV9QMexC1oX700s46SfnaUiCCG5W?=
 =?us-ascii?Q?XSl7QjKbVKF+ZBI2mB7sspKzK8jyoS0QuT5HmCGSPgctvnUzUIKN9ifxAHpf?=
 =?us-ascii?Q?Ib68AWRoYAY8c/TTPHZ/9cJOP/Bw0jX6oco7Lj2XucfRPBk/AdfW0dNtTSwr?=
 =?us-ascii?Q?gS8jjvRQ8trW4WA2hmisUb0Kfl0HmByfEfcVNUovAGiLtDNqT1VCbuQrrgn/?=
 =?us-ascii?Q?WQ9QtfnZR1GHoLf+Bj5juoIr1OhfrYXHebOr1OTSlq/na+ihfbm035eNQXyh?=
 =?us-ascii?Q?+akL8nlaxuJCIAPZEMy+MU4NttooYezyBYRcKl1hitKNJQVVGqS2bQn2/x+T?=
 =?us-ascii?Q?Pv23YQwxbxKRAwwTXETrOdtJcCoupfVZQfnE5K8qbFJZcFMLrkoVlHQ41WgH?=
 =?us-ascii?Q?x7RZltX4kaqX0ppd/fsb+D6eAxqmkwT4WIqrQ3zepY2zCvd+Z1ReRYP+qje1?=
 =?us-ascii?Q?ygjM8wy43wGV8MOPHq482Vmj4KEuFI02CCATDX/67ora0Ao1PkSxzJ75g21m?=
 =?us-ascii?Q?+xbZnF1ZKtmw/JYb5graLQRlp5bEoyT/0MmzWm7Me7D3ZYT67vuXzVAFKuqP?=
 =?us-ascii?Q?5nvMwUBfZWZ92LU0MfJlXwDjRSvgyPrurZjdO2vd9FIdGz54WZ0u+WZvd0UU?=
 =?us-ascii?Q?svH/3yEVDywE1IysfGFKOfUiJtoRC/POf+9SLN9pFGW3dA7fTfuKhSZXbs5M?=
 =?us-ascii?Q?HInj5F30OgYNJn//DD88pZNvrdFzxeHomgNWrmY9yvWYFPDFO5isA0b+9Irh?=
 =?us-ascii?Q?REbIsgAwNaU4qbrlxB1kFb798dsBlBZJPXWm68bFgtZ5BweoUE7HWGXdnkbx?=
 =?us-ascii?Q?9d/jsU9XQqwiMwT3c2uKgnc/AEowLifGX3ZWjUl9/WWIAap6jmCDkEj7wFh6?=
 =?us-ascii?Q?FDdaTmYK+9BEon+gtQonOrK1ADhiE0IjHwffFkt/XSKfECQtA55ngmCQIYre?=
 =?us-ascii?Q?O3jbo8DQQkN75BG9qRsco7J+uZdWX7hDkeNtWkaJRuOqDETIzuX2JXc0cf79?=
 =?us-ascii?Q?l7QGHbAsRoG7XLkY+J3+xT4FjIQpWYatcyqCS8w2lBRTfIk5F2SZevnvKzCV?=
 =?us-ascii?Q?xQB5lMyWv5ctqmBA3fo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4159d43-21c0-427a-255e-08db51c76720
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 02:28:27.3363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2ftlmXpsBKbZHEIyWc7893N2+R2IZmTTnSHOc1vnYN7MYOdFYHZnRLZ0XWaCBQhhWdgzxxBjUcQZi2Z7KA3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhou,
 Bob" <Bob.Zhou@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jiang, 
 Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please register dedicated ras_irq src and funcs for UVD_POISON, which shoul=
d allow you to create vcn ras sw calls like gfx/sdma ip block.

Regards,
Hawking

-----Original Message-----
From: Zhang, Horatio <Hongkun.Zhang@amd.com>=20
Sent: Wednesday, May 10, 2023 18:55
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Hi Hawking,

When modprobe, the interrupt of jpeg/vcn was enabled in amdgpu_fence_driver=
_hw_init(). If the amdgpu_irq_get function is added in amdgpu_xxx_ras_late_=
init/xxx_v4_0_late_init, it will enable the instance interrupt twice.=20
My previous modification plan also had this issue. Perhaps we should remove=
 the amdgpu_irq_put function from jpeg/vcn_v4_0_hw_fini.

Regards,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, May 8, 2023 8:32 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.=
com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Shall we consider creating amdgpu_vcn_ras_late_init as a common helper for =
interrupt enablement, like other IP blocks. This also reduces further effor=
t when RAS feature is introduced in new version of vcn/jpeg

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, May 8, 2023 19:06
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciell=
o, Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo=20
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)=20
> <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in=20
> jpeg_v4_0_hw_fini
>=20
> During the suspend, the jpeg_v4_0_hw_init function will use the=20
> amdgpu_irq_put to disable the irq of jpeg.inst, but it was not enabled=20
> during the resume process, which resulted in a call trace during the GPU =
reset process.
>=20
> [   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
> [   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09:
> 0000000000000000
> [   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff99b2105242d8
> [   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15:
> ffff99b210500000
> [   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000)
> knlGS:0000000000000000
> [   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4:
> 0000000000750ee0
> [   50.497624] PKRU: 55555554
> [   50.497625] Call Trace:
> [   50.497625]  <TASK>
> [   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
> [   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
> [   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   50.498060]  process_one_work+0x21f/0x400
> [   50.498063]  worker_thread+0x200/0x3f0
> [   50.498064]  ? process_one_work+0x400/0x400
> [   50.498065]  kthread+0xee/0x120
> [   50.498067]  ? kthread_complete_and_exit+0x20/0x20
> [   50.498068]  ret_from_fork+0x22/0x30
>=20
> Fixes: 86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 77e1e64aa1d1..b5c14a166063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -66,6 +66,13 @@ static int jpeg_v4_0_early_init(void *handle)
>  	return 0;
>  }
>=20
> +static int jpeg_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +	return amdgpu_irq_get(adev, &adev->jpeg.inst->irq, 0); }
> +
>  /**
>   * jpeg_v4_0_sw_init - sw init for JPEG block
>   *
> @@ -696,7 +703,7 @@ static int jpeg_v4_0_process_interrupt(struct
> amdgpu_device *adev,  static const struct amd_ip_funcs jpeg_v4_0_ip_funcs=
 =3D {
>  	.name =3D "jpeg_v4_0",
>  	.early_init =3D jpeg_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D jpeg_v4_0_late_init,
>  	.sw_init =3D jpeg_v4_0_sw_init,
>  	.sw_fini =3D jpeg_v4_0_sw_fini,
>  	.hw_init =3D jpeg_v4_0_hw_init,
> --
> 2.34.1
