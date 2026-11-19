Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38E606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xzHieydZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C7510E38D;
	Thu, 19 Nov 2026 17:17:51 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB4D10E38D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 17:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qopjTYtKQoJjT4UsO15W7Oc7hcUFixCs2EHKlE6yjeRwNtq/ZJ062wzwh2aRuzUxowYyAFX3/hxp/HKpHkUTRUSx6uLeIURtcrBv9IM7fcMGZN5PDXWymgfojTEena36gtrIguAyEDWBL6meDpUn9NibxZ8fgyK/NZJevsv/5yeeDDGlKW5wNJwZwxPLrmpF5rkhyeZix9O4czRY7ye3PgCEZ++8uqNN0Jh8O7Ix9ieM0HbkxY3BkYNbspJlRHGGkxxjrCglTLKcofGKBAbrppLA5U4JQkosFunQX5D60/ePUZxHOZhlGKPP58F2Pl5H1vOhZg734rkKoj4cLYySMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh+G7CwhZq0SsbIgI3SaFi33EGuvGE8xhVeuk1EOWJc=;
 b=X+xYDxWovvsjlR4OP3IqLDymGPrMKqNORJHfLCRvox/Kp4RUlSOhCa8/V7fxpwpwWb8/DYxDKPcgbbF6ocYeHZQexMZaM6XC4gqvbOf6zQGfIbwHRJTJ+ojPJpQzW4IMma/smDnMHvib/66F3TqcuY+EO+3ho3/dUB+IVvtQk8S7il2pPbShou3a1LZNeTfs7VBoeXwe0xkBvTqrbq2/FqBCjoOmngrfC7yLUw1dIzzLdDgSC+whRWP4D/bXWQx6oOTUqtYqqwkRZW0h4qrzJkvcUZ6bxwvhUW8Dv308XFMzuus+tSL/qPlm+v0K34M7SKD2HV+Zpo8GalQJ6xVC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh+G7CwhZq0SsbIgI3SaFi33EGuvGE8xhVeuk1EOWJc=;
 b=xzHieydZb3vwNpr3jN0erCj355FRe2Xga7lF8mVSAa14RoTEp4jxK+RuzuPVGdowc22lE5ePYRLBsWhfmwf9ttbTI4FHuGogtggPblKGHYzuk16OWGSEeCbUFXk+TQZ3uoMKJQbsKwZUku/W22z4yf8bG2kI7ItDR9FeJvvF/5E=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 17:17:36 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 17:17:36 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on out
 of debugging
Thread-Topic: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on
 out of debugging
Thread-Index: AQHdeAU50XNdaMdH3USOgLbSDToBgLc1mgzw
Date: Thu, 19 Nov 2026 17:17:36 +0000
Message-ID: <DS0PR12MB6392ADBE68E53824E1F550A385792@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-19T17:15:42.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|CY5PR12MB6274:EE_
x-ms-office365-filtering-correlation-id: 94c3e645-e556-41e4-f264-08df46610197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|261026121527099003|261102123227099003|5023799004|261028144727099003|261022105027099003|261021121427099003|261026140227099003|38070700021|261021123027099003|10067099003|261022075727099003;
x-microsoft-antispam-message-info: G93b6Qv5DXbtPCHkwQQj9joXxTxn6+xglWBExi7/Icc/P0dsUIb1vmBZv/9utBe+y2D2xzouDC1R8cNokVF4vCbUCcOc+HgGFcoHGuSDSV9V3/03DYA2QZYrOoMw7MjFd1EmAUWNPWTbyO3dFcljZBofMqwMmHee9lgHnI3aqH+ziohT3ENLMeUHY5HbRyviov/pR/DHnx95U5Tq8sTbRGpavIJoAII24MEsCW5hOJ49zpxvj2tkx0m0eN0Z8bUEzv9gotQS/SBuapazIwaZzhtq0N+NRUbv+6GUmL80XcmzFTtg1M4lJs3T3OmzFFvTJ4Ea8ukmLtVb+kIgh3380J7oYAmmCv8/GfFEHTFsnc3AeD/I7+/POIQOpCqNDe1YGT3UBKEemDCrh2s+owAvAILWktD6WDbrZaZFj3ZUKsBLe6CpO30KFAIY+41aMCjz7n46IiLnk4SFxlNMfymgG0t+zU7nIDhLr1KgkZ02yIy8e0VrVtfVOuTVAzSTi9jTHS4HAmtqubYvs7KxhpzpGydgpmYGsgGmrhyl8GeAde+iYdonEEBiCohpCGEoC2x7dwOtFAm1sknNNxZ1hv2nNoo+m9/7S9HT+VXuX/KOh3tQX0qA0xDSFHXb1CzTdwiCRDU8v4de15ota94xkJEMXV/l6W2x5Btc6+meMkaPhTzypzpFTM9gF9qVfl90C3LtTaFrbEaC2wnXFHNLYffQSAhgZidGp+2eocIjsKMHSss=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(5023799004)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(38070700021)(261021123027099003)(10067099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wZ15EG+QOAsfX6MlORo9ewqGsnpZcCdy1B5ZUBZU7JB8iXQ0sjlt2x8PXVMy?=
 =?us-ascii?Q?uLECs6wkXUR9uJeG+zHjpSeCXbRq4E0f9aqY0I3OAJktiL0AjzsOUVF9h5td?=
 =?us-ascii?Q?XFyzaDDOXUG2Vwv4H5Xy3zsMngDkG7pBCpskE2qT1hb7JzzpIO1hH/4muMV9?=
 =?us-ascii?Q?duIOzdQE671HQyrfmq/c4YUHXR51IiZgmxADraxyD64dJ+kG5KAwgQ+51ErV?=
 =?us-ascii?Q?xxUaawTAE/JUoCGVCQpj8u0zyRK0WmLNFls6qDtb1zNhbFuLdT4CjJsOz0nj?=
 =?us-ascii?Q?hvWs0SlcMD9XxkHSI5XTpZT20dK9bzte37BUDny5fK3YccgOlcfq49U9dECq?=
 =?us-ascii?Q?XYdyZsa9kU/Dqyj4ZMnZt6uAllCz6wQz7pHUlNwV3IKKZg6vIGp+aH9Kd7hf?=
 =?us-ascii?Q?oX8+AGwQueiuAX1xoTL0JFDiyMFtPt42EDz5Eekl083gWyRqFuNsFBapel6W?=
 =?us-ascii?Q?+ij9BXgieqmCIAyqJaw34pMRP8hDQZrxuLpNEwVjhzFAmlmSELJvTQlHONoK?=
 =?us-ascii?Q?vQKZyf2DpxEhAsW1s21N+aQlUMZLfNgOYDF3tzSBgfrIma3c+D9ph29fj+mU?=
 =?us-ascii?Q?OEHuEmCs+ErcMn2ocZL8CnwyoZnGlY5V3a1zJg+EsDm+kXIAAND/Nh77qrva?=
 =?us-ascii?Q?ZhW3TYWG+EJWkNN6peNAllGcLJ84M0AfXPziT1pmk6iLDr5FmnmxTFSn4Kt7?=
 =?us-ascii?Q?7AbGFUlY06AT2xG3cAtc6iXk90dfHl/raPPAj4HsctqedGkutF+6E17H83G4?=
 =?us-ascii?Q?u9No97+kO62lU4bRkIiFuUGh3L64EoOMWsL4MTeH+O+xr08NeQgxDODllA+n?=
 =?us-ascii?Q?HfLRSTEB60acCz4GMaxgsh/n0qyBzfCvjcmzBnJ74H3EE0HcaCWyreLYnEjq?=
 =?us-ascii?Q?7kfXedHEsDSFOt7W4elyMvvFr8/0aPAYRQwLbuJjZxjr0dva5l/AFrhChn1Z?=
 =?us-ascii?Q?+n997CIHmX0I+ta+Yk2roxN3+YtqDkjWuhkBWIZrdbojA5LuNFPotVlZHcYg?=
 =?us-ascii?Q?x5kv23nVc9xbzgTAT9mvssJ4CzXhRN5sRboFf2tsKEL0AQV9pRaR6KaSFGJS?=
 =?us-ascii?Q?RtLrU5il2AoGx44S+pZz+J7izHXxBhUpswkojo6ukU6Z3msJhVVVUhBCPb4/?=
 =?us-ascii?Q?/0j5zliS/kK5A7pbem1PSs77OBkRlpjRcu5JKn8xrAvMw/Ldl1RoxY0daPZe?=
 =?us-ascii?Q?vNjLP0CKB2fk67uUTz7sAiYCKj9Lx7LVFieS2z7ba+2AzvZ6y1QQ6tAzghNW?=
 =?us-ascii?Q?euERe6baw3dh6O6SBEQIsteOqyqax4oxCz3CgGgXBPSB1Mnfwmu4+vEQy0gf?=
 =?us-ascii?Q?UqcSFNw4k/CRgX9kMkEh0QLQ1mS+xEWDpnG2HLf34sipce4IEUrIQ2NvPCMT?=
 =?us-ascii?Q?RccnQ5/B1orbWsValO+EWsGKILuT79M8JCzzJXIELjV9xBNN4nH9VcwMVT0k?=
 =?us-ascii?Q?NDq76gSpIm5SzqnhwTQytWToX3SR2AhDWlHefsY8dBOKyWXVodGov+vkhJpr?=
 =?us-ascii?Q?qaUSwDe7uPbDis7hTe1BnvgvzwbsC7XDjY6VCmIaI+TPNA5RHoeUQr/xENto?=
 =?us-ascii?Q?uDVYDCYcZdJZcinVyVWc1w6JRlCchAzB75RifrvzJGZAoogcw0SgV1CpFnwK?=
 =?us-ascii?Q?0GSNA0l4VR1Hhn/PWECu1Um4T8e2OjDmRFG0BlJ6pYxEKHkyQnC4ciAOPy++?=
 =?us-ascii?Q?UbESIHIBVnx2O21OX2AYGr7zkyh2COtZrvu1WSp8KuaQMSS1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c3e645-e556-41e4-f264-08df46610197
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 17:17:36.2109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVh2iCGuRCQNuAA0jprA9xdVEmLCOS0wC119+ijCmJ8o2IkLtXUS9oO4ESxEbYvQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Thursday, November 19, 2026 4:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on ou=
t of
> debugging
>
> Debug activation and the debug operations go through all devices of the
> process, also the ones it never acquired a VM on. With a dGPU and an
> iGPU without per VMID debugging, debugging a process that only uses the
> dGPU still takes the single debug VMID of the iGPU, so a second debugger
> fails:

There can't be a second debugger on any process to begin with otherwise ove=
rrides/debug setup would conflict.
I think you mean a single debugger with multiple inferiors (target processe=
s).
I'm getting a better idea of the issue now (but correct me if I'm wrong).

You have 2 types of devices, multi-process debug supported MES based hardwa=
re and single process debug supported device (non-MES) being debugged under=
 a single process.
You then have the debugger trying to attach to more than 1 target process w=
hich is supported by one type of device but not the other.

If this is the case, we shouldn't touch the unwind function.
Debugging is process wide by design so multi-inferior debugging should fail=
 on this setup (at least for the second inferior attach and onward).
The first process that attached successfully should still be OK.

What I'm still confused about is how we ended up being able to suspend on a=
 process with a device with no VM acquire.
Runtime enable happens after topology discovery and we should acquire the V=
Ms for all devices of that runtime instance.

What are the GDB reproducer steps?

Jon

>
>   amdgpu 0000:05:00.0: Trap debug id already reserved
>
> and a trap override the iGPU doesn't support fails with -EACCES.
>
> A process isn't expected to use a device it hasn't acquired by the time
> its runtime is enabled. Only activate debugging on the devices with a VM
> and track it in debug_active, set once the debug VMID is reserved so the
> unwind also undoes the device that failed. Deactivation and the debug
> operations only go over those devices and address watches on other
> devices fail with -ENODEV. A device the process still acquires later is
> only debugged from the next attach.
>
> As kfd_dbg_trap_set_flags() now skips devices, rewind up to the last
> updated device instead of using the number of updated devices as the
> bound.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 60 ++++++++++++-------
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +
>  5 files changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..3d768511d002 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3039,7 +3039,7 @@ static int runtime_disable(struct kfd_process *p)
>
>       if (p->debug_trap_enabled) {
>               if (was_enabled)
> -                     kfd_dbg_trap_deactivate(p, false, 0);
> +                     kfd_dbg_trap_deactivate(p, false);
>
>               if (!p->is_runtime_retry)
>
>       kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
> @@ -3219,7 +3219,7 @@ static int kfd_ioctl_set_debug_trap(struct file *fi=
lep,
> struct kfd_process *p, v
>                                       args-
> >clear_node_address_watch.gpu_id);
>
>               pdd =3D kfd_process_device_data_by_id(target, user_gpu_id);
> -             if (user_gpu_id =3D=3D -EINVAL || !pdd) {
> +             if (user_gpu_id =3D=3D -EINVAL || !pdd || !pdd->debug_activ=
e) {
>                       r =3D -ENODEV;
>                       goto unlock_out;
>               }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index d5c87de519ac..b2d01613a21c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -504,9 +504,13 @@ static void
> kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>  {
>       int i, j;
>
> -     for (i =3D 0; i < target->n_pdds; i++)
> +     for (i =3D 0; i < target->n_pdds; i++) {
> +             if (!target->pdds[i]->debug_active)
> +                     continue;
> +
>               for (j =3D 0; j < MAX_WATCH_ADDRESSES; j++)
>                       kfd_dbg_trap_clear_dev_address_watch(target-
> >pdds[i], j);
> +     }
>  }
>
>  int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
> @@ -517,8 +521,12 @@ int kfd_dbg_trap_set_flags(struct kfd_process *targe=
t,
> uint32_t *flags)
>       for (i =3D 0; i < target->n_pdds; i++) {
>               uint32_t caps;
>               uint32_t caps2;
> -             struct kfd_topology_device *topo_dev =3D
> -                     kfd_topology_device_by_id(target->pdds[i]->dev->id)=
;
> +             struct kfd_topology_device *topo_dev;
> +
> +             if (!target->pdds[i]->debug_active)
> +                     continue;
> +
> +             topo_dev =3D kfd_topology_device_by_id(target->pdds[i]->dev=
-
> >id);
>               if (!topo_dev)
>                       return -EINVAL;
>
> @@ -549,7 +557,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> -             if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
> +             if (!pdd->debug_active || !kfd_dbg_is_per_vmid_supported(pd=
d-
> >dev))
>                       continue;
>
>               if (!pdd->dev->kfd->shared_resources.enable_mes)
> @@ -562,7 +570,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>                       break;
>               }
>
> -             rewind_count++;
> +             rewind_count =3D i + 1;
>       }
>
>       /* Rewind flags */
> @@ -572,7 +580,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>               for (i =3D 0; i < rewind_count; i++) {
>                       struct kfd_process_device *pdd =3D target->pdds[i];
>
> -                     if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
> +                     if (!pdd->debug_active ||
> +                         !kfd_dbg_is_per_vmid_supported(pdd->dev))
>                               continue;
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> @@ -588,12 +597,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *targe=
t,
> uint32_t *flags)
>  /* kfd_dbg_trap_deactivate:
>   *   target: target process
>   *   unwind: If this is unwinding a failed kfd_dbg_trap_enable()
> - *   unwind_count:
> - *           If unwind =3D=3D true, how far down the pdd list we need
> - *                           to unwind
> - *           else: ignored
>   */
> -void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, in=
t
> unwind_count)
> +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind)
>  {
>       int i;
>
> @@ -614,12 +619,9 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> *target, bool unwind, int unwind
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> -             /* If this is an unwind, and we have unwound the required
> -              * enable calls on the pdd list, we need to stop now
> -              * otherwise we may mess up another debugger session.
> -              */
> -             if (unwind && i =3D=3D unwind_count)
> -                     break;
> +             if (!pdd->debug_active)
> +                     continue;
> +             pdd->debug_active =3D false;
>
>               kfd_process_set_trap_debug_flag(&pdd->qpd, false);
>
> @@ -684,7 +686,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target, =
bool
> drain_irqs)
>        * attached running target runtime state to enable for re-attach.
>        */
>       if (target->runtime_info.runtime_state =3D=3D
> DEBUG_RUNTIME_STATE_ENABLED)
> -             kfd_dbg_trap_deactivate(target, false, 0);
> +             kfd_dbg_trap_deactivate(target, false);
>       else if (target->runtime_info.runtime_state !=3D
> DEBUG_RUNTIME_STATE_DISABLED)
>               target->runtime_info.runtime_state =3D
> DEBUG_RUNTIME_STATE_ENABLED;
>
> @@ -715,6 +717,9 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> +             if (!pdd->drm_priv)
> +                     continue;
> +
>               if (!kfd_dbg_is_per_vmid_supported(pdd->dev)) {
>                       r =3D reserve_debug_trap_vmid(pdd->dev->dqm, &pdd-
> >qpd);
>
> @@ -727,6 +732,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>                       }
>               }
>
> +             pdd->debug_active =3D true;
> +
>               /* Disable GFX OFF to prevent garbage read/writes to debug
> registers.
>                * If RLC restore of debug registers is not supported and r=
untime
> enable
>                * hasn't done so already on ttmp setup request, restore th=
e trap
> config registers.
> @@ -775,7 +782,7 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>       /* Enabling debug failed, we need to disable on
>        * all GPUs so the enable is all or nothing.
>        */
> -     kfd_dbg_trap_deactivate(target, true, i);
> +     kfd_dbg_trap_deactivate(target, true);
>       return r;
>  }
>
> @@ -825,7 +832,7 @@ int kfd_dbg_trap_enable(struct kfd_process *target,
> uint32_t fd,
>               atomic_inc(&target->debugger_process-
> >debugged_process_count);
>
>       if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_=
size))
> {
> -             kfd_dbg_trap_deactivate(target, false, 0);
> +             kfd_dbg_trap_deactivate(target, false);
>               fput(target->dbg_ev_file);
>               target->dbg_ev_file =3D NULL;
>               if (target->debugger_process)
> @@ -851,7 +858,12 @@ static int
> kfd_dbg_validate_trap_override_request(struct kfd_process *p,
>
>       for (i =3D 0; i < p->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D p->pdds[i];
> -             int err =3D pdd->dev->kfd2kgd->validate_trap_override_reque=
st(
> +             int err;
> +
> +             if (!pdd->debug_active)
> +                     continue;
> +
> +             err =3D pdd->dev->kfd2kgd->validate_trap_override_request(
>                                                               pdd->dev-
> >adev,
>                                                               trap_overri=
de,
>
>       trap_mask_supported);
> @@ -886,6 +898,9 @@ int kfd_dbg_trap_set_wave_launch_override(struct
> kfd_process *target,
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> +             if (!pdd->debug_active)
> +                     continue;
> +
>               amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               pdd->spi_dbg_override =3D pdd->dev->kfd2kgd-
> >set_wave_launch_trap_override(
>                               pdd->dev->adev,
> @@ -922,6 +937,9 @@ int kfd_dbg_trap_set_wave_launch_mode(struct
> kfd_process *target,
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> +             if (!pdd->debug_active)
> +                     continue;
> +
>               amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               pdd->spi_dbg_launch_mode =3D pdd->dev->kfd2kgd-
> >set_wave_launch_mode(
>                               pdd->dev->adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 5babf9b992cd..e93d77fccda2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -25,7 +25,7 @@
>
>  #include "kfd_priv.h"
>
> -void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, in=
t
> unwind_count);
> +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind);
>  int kfd_dbg_trap_activate(struct kfd_process *target);
>  int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
>                       unsigned int *queue_id,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b5d7d13f31a5..b8ef93dba0af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3851,6 +3851,9 @@ int resume_queues(struct kfd_process *p,
>               struct queue *q;
>               int r, per_device_resumed =3D 0;
>
> +             if (!pdd->debug_active)
> +                     continue;
> +
>               dqm_lock(dqm);
>
>               /* unmask queues that resume or already resumed as valid */
> @@ -3954,6 +3957,9 @@ int suspend_queues(struct kfd_process *p,
>               struct queue *q;
>               int r, per_device_suspended =3D 0;
>
> +             if (!pdd->debug_active)
> +                     continue;
> +
>               mutex_lock(&p->event_mutex);
>               dqm_lock(dqm);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 129363ad4e34..ed85b7fb896e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -880,6 +880,8 @@ struct kfd_process_device {
>       uint32_t watch_points[4];
>       uint64_t watch_addresses[4];
>       uint32_t alloc_watch_ids;
> +     /* Debugging is activated on the device */
> +     bool debug_active;
>
>       /*
>        * If this process has been checkpointed before, then the user
> --
> 2.50.1

