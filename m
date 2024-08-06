Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487B7C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 14:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11E610E399;
	Tue,  6 Aug 2024 14:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ylLPG/7p";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8E410E399
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 14:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUVSjeWoxAurCyoF1ttjsc+jkGP8Rr0xUl8BHti6ussEB0pVH2HVkP+smYmm+HG5gElwsIu6C29ppDmqWuQGFJ15YaJ7rC41kV914wt1fR/Lfdfjpd+X8kpGu33q11p9AVIbhNCWxht8AMI8DHq8N4gtawn4c79oqRWZL5++BfhMe3rGL8IsF7a22EpJRgtg6IAfbWDvWQVXpDpyKYTgTIiAfoYG03CF3I+J89zpTGrBr6JIHY9w9LD+ngBF8KwjAYjcTSs0OYdv/2dJQTDOmtoirNCGM6SEcNighQ8ANpDKFZ8Np3eP9hfPlr1UUv2KuqYeJUQ39AR+jvDUGRuyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZNR0mQoj0pm/MCOV5kxshwpnnsR3+TVGDp9ZzQYYr8=;
 b=tR7vNSdOBv2lL6KEoy+AB1vaDDSoZXSggcKuUHCYhkLgXWsjoGWdCt8lPeiA/fSpys17VM+tD5Bz6chdSbPvxiTMwg494tlLZkcanWP2BmhJy0QIup4kDgNsumAzkT+TWerzQNTfV3nFRWtA7W41ffABNB8e72YVC2QDkLS54umiaBsglc6Yzyfj/XRAXIMYA3VXU9SQLyQBWv5tSmkenvcihaxD5Rh/CjZAlgsR9cd/BjTIqbB/z27uIsemBM7WmpK+hWBl8vANDgIScqtzESs6mi9niUHmepRh8Q8SGxNXqkwd4bg7FytyEU+DJHTdwBiaFyYbBNIX1xlcj0VoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZNR0mQoj0pm/MCOV5kxshwpnnsR3+TVGDp9ZzQYYr8=;
 b=ylLPG/7pQmrQ/hppBjvXXEcavh2T4Aqu6p0sLEu5Tu93vTpCocB4tmcZX8TanLHt3VGr3mwmDOOnNVDMxX+zryF52eQwBuTgl3ZNK3hB7twsbY7SqoWtx1lufRJEPMxGbmQ+FTfeAhVd9QX5Zjn404+ldmkx9o0/y43NqYoTsn4=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 14:40:06 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:40:06 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Ma, Li"
 <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amd/display: fix s2idle entry for DCN3.5+
Thread-Topic: [PATCH] drm/amd/display: fix s2idle entry for DCN3.5+
Thread-Index: AQHa6At2rwrWwi7XdE+zFCT3VwqehrIaTNTw
Date: Tue, 6 Aug 2024 14:40:06 +0000
Message-ID: <CY8PR12MB8193B47590318E3D3931F35289BF2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240806141743.219673-1-hamza.mahfooz@amd.com>
In-Reply-To: <20240806141743.219673-1-hamza.mahfooz@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=efdac17e-bf9a-4c70-9735-e7190e1eac71;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-06T14:39:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|CH3PR12MB7571:EE_
x-ms-office365-filtering-correlation-id: c932b038-8311-4e61-9219-08dcb625a9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?J+qbCAY27f9b7iINHyhnYWxwWwtMVL4dEPHvmBftPgdR6VyCbFwUaezHyrwt?=
 =?us-ascii?Q?1/Bd2bQJ5HJ+vUl7PEK+daCcXNGZnepvyufNQhUhyz5VrD+qFqAQrUgUTZe1?=
 =?us-ascii?Q?5iSqaQyqaRkPf9SrwQM6qXephy/p9moYW623J1XC4BR4EfpUPjTB3QURhFdW?=
 =?us-ascii?Q?IofWsj2rzDlqQrxJ25IEjj7SGET/CrRVcYCuBIbaDkaRTxrl4kTIuNEnkDbW?=
 =?us-ascii?Q?hHnB1ajK8l92CifeZ0thsAI5Dx7SNFu2xQaFLE0ESv5o7+xVvnCC6WkcY88m?=
 =?us-ascii?Q?9lJ0PoMDd1Ea8R/gyShucR925ekY8Nt3SfjIRHaD6yu/r0Y3QtQmI94dx0hS?=
 =?us-ascii?Q?iKg3irLc3oar7g1eBDi6UvxEiSJe6WPnV3EfoTII5kTL/+fHArbfqPPzF4RT?=
 =?us-ascii?Q?2llkiZFI9C0UEHsIXeer7Fy9kT1iO8ft4biAWAkm/AvYp+21WL4+eLUDcw+5?=
 =?us-ascii?Q?+PTTFIHmgz87d4vXbjZ6/5ZawpLAkzhlSVLmjCL7v51w/cXcGHpiculF8/gl?=
 =?us-ascii?Q?a9AxVo8hFssYCdbEWjko/K4v6j1klpuyn0t2jlveZrleD/vnRRBov9Sq+TF0?=
 =?us-ascii?Q?5iKHQNi8smWoGLFJjixCWkpiCCwwPeMhkr9J8v7vqMOFskiVpTKJPpCTgq0m?=
 =?us-ascii?Q?nJ+8Il8D5fFulN1F/T+sUka0vboCKVKyzoOli/3WolMM+EVJ46vYtCcOVSnA?=
 =?us-ascii?Q?0AuLrjVTLzexDabw8hhgsieA33rp06Y1cQjRt0h2OaCEHyqo0Vs5pu+ceaC6?=
 =?us-ascii?Q?Tv0LhiAPDZUpvaSSump5jxMKL5oJOv5pfBily6MSrbdfcMRvAnkcYaLs+eQn?=
 =?us-ascii?Q?tPQRtxG5U5ty3QoyY1HPfoQ1ad9wRbOKPLMefX/HA0xmUqTDbORwI24Ii0IV?=
 =?us-ascii?Q?xW8cARN6Nr+VTUdMl4h87gQI2sPtZowV59q0ah3yrIpGX+w8omV80hofxUui?=
 =?us-ascii?Q?EH9e3gdoaZRSIfjFRfZRG90niRARY4VPti4rRrGgfPKF4Uya7QWBl+A+b55i?=
 =?us-ascii?Q?YhzKHRyFMNsvjADBD36vo/kxSO4beVoEpepKbEvqHU7JP/+LRJBe1z6/gygh?=
 =?us-ascii?Q?Oq+byu8YQ2bJMTkJQ5jDfdh61Ipu/mXN5DMnl3W5Ue7Xnusn5MrMJpPxVKtz?=
 =?us-ascii?Q?s+WQ7HepxVNT28YfmDj0fv3oKYw9cQ/EKFdoT6OEqnl9q/IzPcc8go6+bSfR?=
 =?us-ascii?Q?Q5iV92TKp5kHp+l18HaKLmSYJRb7SItW2N1/fn+u1OYQ6QSWnUWgSv+au5Mu?=
 =?us-ascii?Q?UMx8N2QsxTjrdvm1uZ3aD39dOXEUD82O83bf19SIl03cAEkEysR7NMEN1cOf?=
 =?us-ascii?Q?NF3HJCD1FpeNP3p4YxNjgR2iIWy0EQxJQb+liF+WDHDzvKM/qOAIVZYa93HX?=
 =?us-ascii?Q?2pgJu/q7qRYmSs5T9QZCQdgrNVWiyii/wuateAHrMt0dMFf/8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dllb8X2Q/Jm+zbx8GX3NQg0FvOKdzMmPBYErAl4PuQ2sGvmOhTh2OR37PctH?=
 =?us-ascii?Q?xqUoD6f/FehymjMIILn4XOeRTFCL1G6v5Jtw966dBoA6maZQjoe7T97i6TMv?=
 =?us-ascii?Q?RyC3YmylReTdtIUGH3Tk4t5IiQJ1qWZ/ncnOnqfdyagQkfZKW+roFVeDFlSn?=
 =?us-ascii?Q?DKH+cf5sw0b1A6F7ikFHMBTPh6CreQVw3ERj2YCi7x+e3yLJvQ1V2AOZlyAY?=
 =?us-ascii?Q?Yt2wxH6Dh4iap2gb3ij2ryOEc1DWM8WApYnYnYcYO44Oihbea/3QlVU8aKfP?=
 =?us-ascii?Q?aLtkSaEWaNItflgxwwTSWmRohPUvz7a2OaZeppIkUxeMjADSVjr9uvTzJHw/?=
 =?us-ascii?Q?cg+BsbG8MlDFz9B6NM0bFJT5lWOEP7W/HkkLdUxCbgWFM+ClUBIsTbz+88Tr?=
 =?us-ascii?Q?sgNzZZyzCoiGqIzJDmhRslzHYUCb53ckJ1H+BkqU9GhlOlv84FQ4JtlGT+ts?=
 =?us-ascii?Q?NCZT2enE+I0j2tDgSy+qnrIpnoLsIPuJBqMk+NZHdPjq1AccNx0rLeCKf2Gg?=
 =?us-ascii?Q?AOmXSt7nIGYJfGjOoHlDjQIxRZrY4adIt/pcwVGsSFdpKmTmoXtzX0tpgSkq?=
 =?us-ascii?Q?M7mPN5ciqo1IAlZVqRSG9E4A4ECpEB9x2z/69iolkh7K1esScZVKhJ5otRr5?=
 =?us-ascii?Q?gpB3xbdf+ETe0UqJl3RnZmiJ9aGq23/Z/D4aKT+xUnm23cGeJaw08ssQCH9p?=
 =?us-ascii?Q?U7YZaQH6NG6O+TPiZ1bUE/WBNAUXNi+ckgUUa6XZ8PuW5COBrMl/91d/7Opx?=
 =?us-ascii?Q?t4OHJQ3vsM/0Ld4U7g/yQ8dFc/G1VAg975Sy99gl7eIv25AVdepWgod4cDmO?=
 =?us-ascii?Q?+/Ms2xnARG4Ob62jvWRzHdqfo0rzSrAxs5egJcv3ncPTKTANWOARh+5rVtNe?=
 =?us-ascii?Q?8opUmrGj59373NC1oSbdpJzde3ovAGRGM62ep+8noMwQMCOeZ7lubeKsD8XC?=
 =?us-ascii?Q?3BdmfHHHdzWGMhgOBF3L2LZkzFTgibkYyOJOYy/OG80FQTkteIQst7e/3Npi?=
 =?us-ascii?Q?Tn3PGIxhE7mwt8JvEDkXf0xP+yWfqW+tK0TPnOuSc4WcjL2yhL1Z/TCx3LR6?=
 =?us-ascii?Q?g7ckNphSvvmfA5VBdDNeB/98XpHi4fKa9CXoHPCouTemLknEHg9NtwBdFJBU?=
 =?us-ascii?Q?ms+BqH+btqjv7zPPZ3c+9x5ZeU2ZRvivZmEUPW7hq+MAsiEjg/H8v6G+3S8u?=
 =?us-ascii?Q?vaV/VGVvjrpNmQHez8cdnfifoITConLjT/qQWV6kh/sgKH0z0aLU3Dsjx/KW?=
 =?us-ascii?Q?HoG/pJ6Y5qGLQdicXmckOb+LOQ2Pes9Qsqe5tMkpJXMJiNLez7+KMBIPHDEN?=
 =?us-ascii?Q?WaTLVtcumXJTSprO+Q5wDnGddEELzoWWRw3nbgyK+1yQpSmIpWtS/HehlUeS?=
 =?us-ascii?Q?mWgVslz1pRPtZJlVOCoPL+f3RforGYS8m86eeKeYfRC97yuuHGUtTmJL66NI?=
 =?us-ascii?Q?JK7sQS3tb2HNuEo9zPUVkdqcoboQgorOp6hffyqL17ILB5dhhiwUoOKOOeBx?=
 =?us-ascii?Q?+7ixKUgip4jsNqf3feYDj8foNZUk230+vO0D4tufXoaduAlH7Pewl3IWKYgN?=
 =?us-ascii?Q?PxXQDewKWu8lW9ozolo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c932b038-8311-4e61-9219-08dcb625a9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 14:40:06.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mnb9mp2B7fJLA4zW7FAHRe/Hhz9T9qMVl3T4jAL/He7J5lENeWaw5MIWUfjbQkHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> Sent: Tuesday, August 6, 2024 10:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Li, Roman
> <Roman.Li@amd.com>; Ma, Li <Li.Ma@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>
> Subject: [PATCH] drm/amd/display: fix s2idle entry for DCN3.5+
>
> To be able to get to the lowest power state when suspending systems with
> DCN3.5+, we must be in IPS before the display hardware is put into D3cold=
.
> So, to ensure that the system always reaches the lowest power state while
> suspending force systems that support IPS to enter idle optimizations bef=
ore
> entering D3cold.
>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a312c74f1e81..1169b0de7760 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2904,6 +2904,9 @@ static int dm_suspend(void *handle)
>
>       hpd_rx_irq_work_suspend(dm);
>
> +     if (adev->dm.dc->caps.ips_support)
> +             dc_allow_idle_optimizations(adev->dm.dc, true);
> +
>       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>       dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv,
> DC_ACPI_CM_POWER_STATE_D3);
>
> --
> 2.45.2

