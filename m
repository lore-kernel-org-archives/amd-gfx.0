Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39747CAC5B8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 08:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D193D10E514;
	Tue, 30 Sep 2025 08:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogF7/u6l";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6313B10E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 08:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDAsHmhGHa4GBop8NvEvTiHzW8KFhdvLV72c+0vdttxApe+YpKhYPVPX6W3+GYJRRqfMZRM4YaEEJb8VQX5T7Un6b9qWALWJpFlmMq05hAzVQg+hdSE0A7jiEaaRrOPnlO90QZpmm3m+LLAhBn497sHsdUdKorkYCayFlNVuGUtSMLxhprYRkmSHQG5ZEFUZNIt1Eu8bGticaVcL2Xx2vBIuRNxu1lnR/iQCqY8vH9WtPpnHQ3XZMir0BmVuKPktQW62xf2ti73/W0+E8OwhD2GDiZi9k6aesCwo8vIp/iWzyKonxdFu5NO1Oe/18jeahdpYsXlUSjoKtCWqvJkBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMG9c1sAeCHojmOL8WL0lBkVatsz8WoL8VFSUsZjXBk=;
 b=nyrwv3zxuCGFpByTuoiJMpq7apluRI4WsHc2LEC32GWXBiqMfnetAoNGOZ6X/uvjF65aS+0KM5erwkdq/7o9QvxWB2H6xX9oDUJifoSwdugQkVzoTb0byMKgwXWvTYBgVPUk4intjPqyBSErFEUGg/upF92ero0dJbIQ8GCprRSF2Jgc/3usDVAC7uoNZ5GF5nd8OZyYPJOQg2whBwAUdLMpCqHZ6RczSUZjy+3FJEuRMpEf1Cs/PTLHwXOaE5bB/htMCEZ+TAZ2Cq7YAUihfa8P6PIdGXNSkCGJdTLqHVZMSxaLtDcN0k2w/Cht4cRpRZeFocD6wyuBw/NHYX4zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMG9c1sAeCHojmOL8WL0lBkVatsz8WoL8VFSUsZjXBk=;
 b=ogF7/u6lIA4RORxG/Ekj4I8A//xZv0uCnW4b1ZGmrkQXjNe+MbE0zE+5wRsPagrRiJhjDBSq3oByDLFrhoNZvxZWEvSAZ6NDbhFCJa3DIvenDyjgB0Arrt8umuzpjBXGPIhaIYgyK+sVDN1v1kmMKURXFW9SmoBpDvaY1YGfiR0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 08:19:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:19:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitely
Thread-Topic: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitely
Thread-Index: AQHcMRh4f54u41pNDkSkWx4wN2ttgrSrX8MA
Date: Tue, 30 Sep 2025 08:19:35 +0000
Message-ID: <DS7PR12MB6005E75670D98152A2C996D2FB1AA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
 <20250929080944.2892809-4-Prike.Liang@amd.com>
In-Reply-To: <20250929080944.2892809-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-30T08:12:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB6071:EE_
x-ms-office365-filtering-correlation-id: 903e833a-5d34-4cb3-73f5-08ddfffa1745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v0ydqCnGQBgDF5KQ95EWw/sWSsJiH/SlgfOQBga/IcaS+MRdv8HVjEssQS4J?=
 =?us-ascii?Q?OTJa/9b4Eibqj/pMbVzmRDd5EnDiu9niuk//DEg7FjMYr0BEo97atHWH5SQU?=
 =?us-ascii?Q?Cd5lwnNdeFpsRqW07oCFkkxZquHwiet513kbHhbj6tmGOFFkfxRmrABMZTuV?=
 =?us-ascii?Q?xkbEumGU8UMBBlmJSg1i+HYohXZo45LGVY6VoBp36GNW5xcNryCloQoY2n/n?=
 =?us-ascii?Q?AxKe0ucjPJoNzsuW5zwvlOVhPeSosrtiofWa100LEayhnr5yF1SJNtwVhyS+?=
 =?us-ascii?Q?ul9O3IEtW+6y3gtCtw0580zs69hlHEE4WUaHrXkWEoZj1xQRy83QNd0NPXP1?=
 =?us-ascii?Q?5Ew9AM70NLPGLvTmt/rWwkZqEmIRcWPepTz83YSVUUdsYnfa26VhMvK8K9Q0?=
 =?us-ascii?Q?iXX+1BUI5yWeIw+HKK3nqUO3NBT7cn1vJB0opIsWqgKH/g59KMRORGMUJ/qg?=
 =?us-ascii?Q?w8KT5aynoPbWd302OEK4HQNgr2k3H8um3e9polnhXWbqYs0R3gHsxcbqQZim?=
 =?us-ascii?Q?iQBvU9Kry21wrSRvC687xAtTlXi23tzwqZx4m9xiwVaCWPpWv+Hvw7PgT5VJ?=
 =?us-ascii?Q?fuxm1WXAeMAVu3v99hjYNWoAEEP+5HZ9TXReUHjW6HA/INuFgE+L53Dd2VUk?=
 =?us-ascii?Q?HWl55j5Pbdje9Yl/5P9rTYUU1PNYYO6LeD3RO+8bxaV5dWuz08EyPnioNyap?=
 =?us-ascii?Q?bu3D7354X8rs6x+jKcu8HyJBYT3wP3i8gEmyFE9dAlaI5pqOf8LB2IR88MlK?=
 =?us-ascii?Q?2Hp5n1WpJrU6Y0ylrUAMD9REUwu8hH8J97zy5N33kQ7v6PCQslbC+QFnRT5c?=
 =?us-ascii?Q?wWvrern1rJlUbvjcKoBc//6H8eq441ZgdQ39lulCzdD9bZrrfHfc/eDjZCJP?=
 =?us-ascii?Q?55WZXuVcUIQ5DgpGsqCp3agexbPcimaoq7+Jnxs1wTyxSQ+FC1E6FrbBMrw7?=
 =?us-ascii?Q?B1Js4HcRQq1K+LNkeNN4PU3N4l7BFfUD31CYdLPNwzE0IHtbyoAFNO4dyCFA?=
 =?us-ascii?Q?lobTm8WYKKWXPxmP2ZBkni6scwyyeZyGBkt+UceM+BPop/VW+xPe2O4dNpH1?=
 =?us-ascii?Q?6rl0mhUpdmiX5KhHZL942SEawBL79VPf30Nbdka/7HmiXVoea8MTTq4W5mst?=
 =?us-ascii?Q?l8hLg1iFA26h/1qJpOz0IVeqPN3g3GHlGf2bCz+0tGbMIhty8w0+UnCQFpSM?=
 =?us-ascii?Q?s8JFqbbz8v3qEuDY5NwT6FA37bep8bWV7MR6WqEq7Kqy/jdSmccU/XGWuXw1?=
 =?us-ascii?Q?fTwOQyHU8TNmKYIeDDJGqjTcAaTW7/hcTImWgp0O6hPHOr5gVgcoNEujhqLT?=
 =?us-ascii?Q?1x/X/kTbPhw4T4+M5q9wWZ33IVdRODz1Pl3PrP6Bosx7DrkYN6/EpSU7NQzM?=
 =?us-ascii?Q?XiALDJHRc186pA/Xg4P2hBqv0Qr3jNX2mySeV5ry8BJzcbpm0OHOAt649wlO?=
 =?us-ascii?Q?70Xf6frTQ/whvtnTROpHBbizHWzliBtaM97PQBew0ZmfkV6Yc2cWpFPrrrTr?=
 =?us-ascii?Q?UmwGP2NzqR/YxEUh1D3/VqFQNIt1l3Yxxiuy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlwlRaZ5Tc4WTHcgCkPMmL0mef+tBWcsXDe4LrhdIdQs6Kc5xkgglVoHyQlh?=
 =?us-ascii?Q?uVyA0qmUY7LnD1YCiY+MEnIbmATl1Jg0wDa8b+TNI7BqD+rSgnXI8r4br24v?=
 =?us-ascii?Q?Jo4J9n0B0QZGJPYA89OiNVa+I99cGnkCibMen03F1HxDxurCongsxOTm1OCs?=
 =?us-ascii?Q?CrqWyO7cNOchMDVruUPp1kK3Pvi9SB167p5JVCf8ya7o4uZL80Upf5DQPBaS?=
 =?us-ascii?Q?8ZKyAffe9RlnMQToP0jXCKiROwXp+VboPPi78hv+h2rN1Tx/mImexcrGHTCp?=
 =?us-ascii?Q?/T/DifqBiunCPVGCqdt+AL5+/DCOR1my9dBUNmWOaZhfSar7RDj47FRMVbUJ?=
 =?us-ascii?Q?02y3zsW2QUovj1YNI6uO+NHjm3ekUn91CrWo9Vg3iveXr1Y/8vcnZIwD7UqK?=
 =?us-ascii?Q?FMatrbfgQONv8MbT41nDmsi/WVeZ5Wi9ESn3DrX4ZheshtXyHASnDBaursE8?=
 =?us-ascii?Q?7KxRoTosktZ0rra7r9ubybETktBqwnSB4k8V/d/mywfbuV2fTW6KPtjW62uL?=
 =?us-ascii?Q?mwGRBdqXXs7Ft89nmPftVUiYQvWR2Fg4z3OwCGG7e/w9HH45YDBZ+QovlSuD?=
 =?us-ascii?Q?h9hYanBqLKty+WkrphToFMqS0Y6YH2AblEHZo52SwRqy731QtRQlfJrVo2h+?=
 =?us-ascii?Q?BitXv+wjdC6n3i65ix694i0ZJBmntz5hqpfKVyJ/5Ce6PlIzNikiJKETUHYm?=
 =?us-ascii?Q?zXjGK9kYyeUhhG9hyNb2XaXYURDjFQwuM3/WDGb4k7h9Jiec3huwSAn9Nm3u?=
 =?us-ascii?Q?yQjuG9V8jGv9mk7pjojaaOOQguhBBKTnP8lP+o6psn3eI9mGr+D46da2+zwe?=
 =?us-ascii?Q?wRiXBJEKEVLrjevMYg3jHnmOBVPJatlmWpaPiCzBvqew2DQOPxw4nAryAdB+?=
 =?us-ascii?Q?15xaTL/u71L+G3uHcQLo6yNEg2fwx8Fx8IEIVk+oF1nQSabKRWzKOl+Cp10O?=
 =?us-ascii?Q?veiROQ4NH/t8DhHs31A8nL7CTt77U0pEnLcqN5ODik+mujWQztpXw4s04upu?=
 =?us-ascii?Q?U0SyUJ1xH/6UMRViSqwFB/MkEz2kD9rxY+CYvSelum1f8agearzfDqZLkK9Q?=
 =?us-ascii?Q?O15NXK+RKBtWijvoC7wlB+dPegcuhZrW/Dr8wR/94vFrgn6u4ywJCFVRQKZL?=
 =?us-ascii?Q?RLlsdSzGzxYhcOml9sPma5w2mOA8g06NkCrSCU64gf22x2MQkFLRwkRPYhE8?=
 =?us-ascii?Q?H7NNnIpA7S597tyERJ7WCUZZ20xdgclpCFx7jVmXIgBOofrqwRIjbG53kztl?=
 =?us-ascii?Q?W3vd4eoOvrkP0k9V09z5gwN4icAQndsMrB0GEkXCRy+pXKrp/fNLaC+/q3xl?=
 =?us-ascii?Q?rkSvUtiY7M5nJ6VSFS+AdnV1SPVxhPrwQ8six17mOcFaL0SP62VaONtwTBee?=
 =?us-ascii?Q?ORKsCNyaW3xZXWDpJedHKcE6/vvzWHADPhSlLTllA+/kgw5fuAaf7vtaYrRw?=
 =?us-ascii?Q?TNFDhfWOE1rL+irdZ8hYP/sdK0uxWFqeObH3epf4tlhsnJJftSuSx/+3K5ir?=
 =?us-ascii?Q?DrTwUoXrpOiVMvKprKRquSXCZ9vsZEij12QOuXnLsFeWLZyF5ifbxv88zh9L?=
 =?us-ascii?Q?37fJNx3GrLPkmMMmibQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903e833a-5d34-4cb3-73f5-08ddfffa1745
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:19:35.3229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8rh77xiPrh3oyw+PPfwY4fTsFx3ZEcr8Z7VOjN6HgQR+5lq5wDoNMA0qfyzJYEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

Hi Alex,

Apologies for overlooking your earlier review comments. I just see patches =
1-4 have already been reviewed. Can we proceed to land the series (patches =
1-6) in drm-next?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, September 29, 2025 4:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitel=
y
>
> Keeping waiting the userq fence infinitely until hang detection, and then=
 suspend the
> hang queue and set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a82b8d30228d..93d92b6ea86c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -232,7 +232,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
> *uq_mgr,
>       return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                struct amdgpu_usermode_queue *queue)  { @@=
 -
> 240,11 +240,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mg=
r
> *uq_mgr,
>       int ret;
>
>       if (f && !dma_fence_is_signaled(f)) {
> -             ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(10=
0));
> -             if (ret <=3D 0)
> +             ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOU=
T);
> +             if (ret <=3D 0) {
>                       drm_file_err(uq_mgr->file, "Timed out waiting for
> fence=3D%llu:%llu\n",
>                                    f->context, f->seqno);
> +                     queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                     return -ETIME;
> +             }
>       }
> +
> +     return ret;
>  }
>
>  static void
> --
> 2.34.1

