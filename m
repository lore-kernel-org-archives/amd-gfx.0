Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E43C2FC15
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 05:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CBD10E3F0;
	Thu, 17 Aug 2023 05:10:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADB010E3F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 05:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVnKgurRz8EENiFBkpgN9POuLfZuODq4mK9I8s4sPNZVCQeeAJqBvOBW2eNNFSW0yfDWywYgskF3P8z+4/BGd8Xt5AVo3eyhreK9n+Y3URAcPnxokk5+K/6jA4PueWJrAPynA0RTjn2F8mnHa2wp5lmZ9dH8LtkDPh1j6DZTHSjvK3R0WcdeLubIJY4NX+KY/8AQyMeawvLNTSDfZnicAH+ESq4V9we5vxqaP+xIV9oF2npZfZHtIPuKeG5dDBwkI0Fz+2OrcaIGkM8c1czwOazRO3lxf8R9u1qjZA6RedyIF+Wae/Lj+x4AIFDkNBarQYLNloWrbaQlbQq/Ox0VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9eqmZ/T18++a30iHi0o5EtVMt0gy4kSmFnYNNx3mQ4=;
 b=cR1m64N+/VkNjC8OSqxlxuuBL54wciUz+83IHQ9yF6t+MSfcFiV8E7625giYLAmsBR5d4LmpzEQrpgHqEfCku+h0t25wMjAdOPhfFiu5IPdOf1onIhTeE2BEdRp3l7nPa1tLbunaW1VufiZw5VLxVGelesnbb/EgLQelf/vWk/DnoMKuYFiIrHulUXxK9BmVycytPBQKmjQaLsN52lYbraQzLI8HIBtMK5KnJ1m86pdnMAv27RM7V3LOd00iSp4bSDiRWjW5moa6dPayU8a8xTMlAZQqV+eqjvdvKnl7BIldHgSdquosE6ZYHtevc9SK6J62FecAYcV+2H3ZwX5WhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9eqmZ/T18++a30iHi0o5EtVMt0gy4kSmFnYNNx3mQ4=;
 b=m/YXUBxWiWTip/+XikSpXkz39NI2ZHulT5UZNVEBb7dfyUUcyPtH6ksyDOfVj2SFcUacePhl1kygiCm53ThMj4PDty2wdddPt89Myg5nfJZWmh53UxG4ZZX9lUJGRQEz3ptq0sBdxcRbM51ltJNcEwIy9V9nu92zJMWcbQsGUxY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 05:10:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 05:10:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/scheduler: Partially revert "drm/scheduler: track GPU
 active time per entity"
Thread-Topic: [PATCH] drm/scheduler: Partially revert "drm/scheduler: track
 GPU active time per entity"
Thread-Index: AQHZ0MhqUjT4SBMS+kmaqi6Hioz9Lq/t8IVA
Date: Thu, 17 Aug 2023 05:10:37 +0000
Message-ID: <DM5PR12MB2469ADD726E71501AA71B525F11AA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230817050435.3109-1-xinhui.pan@amd.com>
In-Reply-To: <20230817050435.3109-1-xinhui.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=215ad365-f0a6-454f-bbaf-a32f3ce35fc9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-17T05:09:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN2PR12MB4048:EE_
x-ms-office365-filtering-correlation-id: f586954b-0c90-4114-fb8b-08db9ee04b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOFq0PSfDcKcDWudT0yJzM23z0DVGnvgdZslrAhDdqi5vEpUJ7kgMXyF8ynGsd2zz1I28d4bcStApX8fk3pad4Sw1n1a0mdI+vY0g80LGpFVCI9EWMtcqMAmGNNycY9GSX8suWn0dwWx1MgkfghaDW7FgEAzVmoobGMK022y/tw3d/DkkGxRHKu5CYe/mdvFu6r0h0cHZElZtTYIgv0Fl91jRCH2K9gBYer98QXr5z6QrmW07pDfi/kLszmrlIN9sgwv8ntC0uBMnJfMetcA4qjH0ctSNMtcTLjUWWDYzWi29+wRvheHaIgHpk6El2+yRMDAF9U00frvVyNicbxnYoeSEIMDBEM0kigrURGVLWQUPpVY4Xm/XuMR1cdnquZdtHli8XQc7sv3gRKj8nvzWP3yVUcjr9WNY2ICETP+ydf7knEz2C6B/c3WHXZ6rMuTN4NNe2yxEzXOHTc85z88DDM8OCHMWxJiC2dEBmhhy92TkuENBk67lmLbV1Kcn3himxRc0kJbZD1avqwde4F8/UgNm9VkKbKfAlUIZYNrJHNT6fqxaBHIE1kzOO1bIcWx2QbStVtHcKDdlz+SdqVo5wyQXVX6QPf9k7Tq/jnRih8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(55016003)(83380400001)(2906002)(110136005)(66946007)(76116006)(66556008)(66476007)(66446008)(53546011)(71200400001)(6506007)(54906003)(7696005)(64756008)(316002)(966005)(478600001)(52536014)(5660300002)(26005)(9686003)(4326008)(8936002)(8676002)(41300700001)(33656002)(86362001)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/xAv4A/2f/9TpPH1WkYTJ2oVMvkf3zrKm6Lgc0ioRvHeo8YvF0VqxcB4/dc?=
 =?us-ascii?Q?sqLaa7YX1kjUPwAY7LkQ+TfIbbvWOrRw27xuvKiESmRgpHdWmxFH2OOHr/rK?=
 =?us-ascii?Q?BEiQKg8QXOOxLNC1YSbtpqzmCn4nSoNEdVxE3zi3AFyA0vSo8X4uSGiIY40l?=
 =?us-ascii?Q?V9QIPCKbKdIu+lO+OLE7X6hRBbiyyOMTlstSPryDZzMHWB+ynwtXpQV73YVB?=
 =?us-ascii?Q?xleaPbup2mhRnmgIRXRHIjIz0WRJqqZC61/tQ28mAm6Zl49NB3YUDWZvlYj+?=
 =?us-ascii?Q?fbrZA6hHoKH5XKuSY+mSHqyDZGt0JZyRw74nIBcp5Zfhblh+JP3tcxqfm3xy?=
 =?us-ascii?Q?FKvP4tHHBJ7YY+FCMsTsfn270I6wkee9jHF3K0hxyLU971TDd0rQwwkzWbfl?=
 =?us-ascii?Q?WHbxxN6XEeVt1utJVRix9FW+yOJ2YVOpVQ09yfFqYWJpHaf/mW4o39k0tX5i?=
 =?us-ascii?Q?dP98geIdGnPD2OSteI+1DCT38+Zc0+iZwRB74ilboFerBPAPe3lpC1jXUW6Z?=
 =?us-ascii?Q?zL0fvns50z3DLzRo8VNsD2qFP0dHWfkWlKw3CX5Khve2oSZ8IW0O4o0JwoJu?=
 =?us-ascii?Q?3me7SNWMGoY9xPuj67lYTVY85BGNQaEI/nsPHfRN1H5TZEJPjo/xV4a2QxWW?=
 =?us-ascii?Q?NwlgRB+2F7ubcxU9OWhuwi6l3TfjKvOCsKJn3FqPjw8/sdxl3PObDAbP5XZm?=
 =?us-ascii?Q?AzG0C77MC3uDZEA+cidNMEVcrl3qoHp78CHGk6qfAK2Ar9P1VKd0bs9NStFy?=
 =?us-ascii?Q?AKYkcEqmanF74jOesR5Tm5YP49C6O4dapOMxjnl6OmiErbAsQrpwY92+eekQ?=
 =?us-ascii?Q?+tgcHL0RuUOEXnvi1beqHxx/5w+dhuNb2P+OFY0SXtwvr2WOF7EJ+PPDlBI6?=
 =?us-ascii?Q?XbXvoyO6rSFR836uV37fpZMniofPIYVzbQAk8FUhb8JPSO8hvVhIMzwkqg/d?=
 =?us-ascii?Q?+IS2EjHCkBzTmcd0hYZKvVuEVy9aicbophhPgMSk4YN+Rc6p8sVzZ38PJW/b?=
 =?us-ascii?Q?1EcmzBnA0dCpH5qjGS8YO+7rKWxjU40z+2fkTM/Ewmboiwq6aK9n2Z3G2BVY?=
 =?us-ascii?Q?Jts1adKAI1O72ZP+1E2VEBkRgf9Ij+POtXe/I7JQ1A9dJQZETvcxTL+X6UaI?=
 =?us-ascii?Q?q2TE2Dy5We9FXdw4mj1OvKQ5DJQIhU1b5LcuDsNt8icPvXi5Xctl0CfBderp?=
 =?us-ascii?Q?mK05HML5NKo/1rtoScRv7O65MvdPn8wkJoYhKlwRnhn45gtXviRuJAFDOyHg?=
 =?us-ascii?Q?5bIL6YsPPnOo/rzO/TUeTzi/uaSmZIJbTiDbeZwJyLURYjPUr8lu/HOWmJbi?=
 =?us-ascii?Q?ZRS35l2WCfDJ2hGYzGiy6KxGT1kcEnIvj1MufKgn7ZFbLXYv1mul+nBapv6r?=
 =?us-ascii?Q?OqYetdO5peklot2CxTMuXBdv5VfwDC06kQwbdPaycaWAGR8LaLXs+u1qKx4k?=
 =?us-ascii?Q?MPskePfTBJAHInABVURpz2IqdA++CC62sgngXyuq0uD0Pu4/aATrPtODTOFy?=
 =?us-ascii?Q?Ue1T2i0MR7RERsNyQ8LvOO5Gy0xIYsMyzICO4ioZIGvhpmKLkYBIjlaci84D?=
 =?us-ascii?Q?FkajnGMKZToGOWuUcJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f586954b-0c90-4114-fb8b-08db9ee04b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 05:10:37.5049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9w28eCM5VaXzcvjK1Ku7eDzOlIlmQJy9eprAZi7ZDt1fDQdrEAseCzVJvqlB4JURi5o+nLvBIH6FrcL2+IJNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Xinhui,

That patch has been reverted on Linux mainline.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/gpu/drm/scheduler/sched_main.c?h=3Dv6.5-rc6&id=3Dbaad10973fdb442912a=
f676de3348e80bd8fe602

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> xinhui pan
> Sent: Thursday, August 17, 2023 1:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Pan, Xinhui <Xinhui.Pan@amd.com>; dri-devel@lists.freedesktop.org;
> Tuikov, Luben <Luben.Tuikov@amd.com>; airlied@gmail.com; Koenig,
> Christian <Christian.Koenig@amd.com>; l.stach@pengutronix.de
> Subject: [PATCH] drm/scheduler: Partially revert "drm/scheduler: track GP=
U
> active time per entity"
>
> This patch partially revert commit df622729ddbf ("drm/scheduler: track GP=
U
> active time per entity") which touchs entity without any reference.
>
> I notice there is one memory overwritten from gpu scheduler side.
> The case is like below.
> A(drm_sched_main)                     B(vm fini)
> drm_sched_job_begin                   drm_sched_entity_kill
>       //job in pending_list                   wait_for_completion
> complete_all                          ...
> ...                                   kfree entity
> drm_sched_get_cleanup_job
>       //fetch job from pending_list
>       access job->entity //memory overwitten
>
> As long as we can NOT guarantee entity is alive in this case, lets revert=
 it for
> now.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 602361c690c9..1b3f1a6a8514 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -907,12 +907,6 @@ drm_sched_get_cleanup_job(struct
> drm_gpu_scheduler *sched)
>
>       spin_unlock(&sched->job_list_lock);
>
> -     if (job) {
> -             job->entity->elapsed_ns +=3D ktime_to_ns(
> -                     ktime_sub(job->s_fence->finished.timestamp,
> -                               job->s_fence->scheduled.timestamp));
> -     }
> -
>       return job;
>  }
>
> --
> 2.34.1

