Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB3606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PXvrZ7y5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF26112037;
	Wed, 18 Nov 2026 21:32:57 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0217911202F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 21:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQKLep/VSSCmMI/6cgfxAF4ZSSX2G/3504mL9NmuSbYlBwwC52NIcgYQOo1ZCLywsJ+ivxDheiAA8StF6DkIiwz/m97d6hiUhG23PN2E4WktjlUB+YQFd8YpgfdsZEtKivKnHwkF7H/1OvJ5QmTamAuK7EqhP3Co3GOWhLVAHrdlYc9umTNx4PGdwnW16I/mAGqkps9/nwutg1WnZuI/222P7eddPGpN4InH9A0uk+iuVckGAIdRRYKRhW0SwXVoCrWkWuqK0KXAyUhziG9Xe199gvU+KdI1G6ypz/xyWFASgYmJxK65/sruSokUZN3Al6r8lIKSyNX5h1/ryoM4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gae+72nvalpAxq18QFl6fwUVpwriK3bJ4oqSkvD7Qkk=;
 b=QTymdfRW2rLQq3kVetMTiJuka8jyO+290/JSDeyx9oLtFXiFxaUP26AnUTo2lfqvpGX7BMRt2bWKphn5O0sf7sUV3oK6tXTv9ypUKoZsGcwT5+r4lgoZlFF04iFh00CrxFjJCmNoVdKMBmR0gq1unRLxm9tk9mYWJC+dKCl8AUvcj8Nv4c8YVGofWkRHpkYr+BGQxEfGGk/F5KZ1gZ+A1OaSdDH8fxJI9AObepiCnM+U3kN9cqkxokuIRlxT4nMeTQjhgIPKgt4S12luRIXmkU2NKN721HI0ULaJQX08jiLV/HKoBjCKh0dEA6ywu19PDTvT9qFo3mnKRonzdDiCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gae+72nvalpAxq18QFl6fwUVpwriK3bJ4oqSkvD7Qkk=;
 b=PXvrZ7y5crTTRVVAnH088SITKe6QdyqVgHcMqkrkNNk+7CH4iEWJz6JugBYxOR61cuPNNLtAvsO9CnbQtYeCIMns0OnLeQ+g8exaOK0ZP4IZNRaoBf5tvUAQTJ9xQIWgp35Ne65rkBXJ1AAEzPu11YGu5I9U5LRdsnxBE8Kmr8Q=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:32:48 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:32:48 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdkfd: only flush the TLB of devices whose
 queues got suspended
Thread-Topic: [PATCH 1/3] drm/amdkfd: only flush the TLB of devices whose
 queues got suspended
Thread-Index: AQHddyC7ukg0JYOLl0eoqQE3eLWTnLc0Vnaw
Date: Wed, 18 Nov 2026 21:32:47 +0000
Message-ID: <DS0PR12MB639255657E8AC511F55B6E43857A2@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-18T21:30:23.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|PH7PR12MB7843:EE_
x-ms-office365-filtering-correlation-id: b473ff3c-8ec8-4747-caeb-08df45bb7dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|261009223027099003|22082099003|3023799007|11063799006|261026121527099003|56012099006|261021123027099003|261021135927099003|261021121427099003|10067099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: zxZfdK22n7RQxDjiB08bxK74bXbJzpA6EUifNbmfQoq7CniKLxB2ccRgiGuH9GVCnf1eD/CpmgSCNkw3eB+oY4CRP6vEmFPF4pHIZldvtfDbxtT4pTR2nft+LWk1uYa05orys8/kyoYBWySFt5fSU4tUvrYmwXgSU1cAajVItiMfM+hJBHkAN5johUFNyIoPlVZKEGxeYdz1ISZudDChmqXMq3+3hrNW6GYN72gqn8W2TYa/R6gF4FozVmg6FiITpM7EjTUkZepY6qc1EYqHrNxVjZktXlZtLara+DK+7nDOj+rVqv11MU+t/pQneAWRc2TY9UG4KUiWj2AKpLQFR8JbPIN/s4Wd/uIlEXQCLtXamoRmDtZRGFGSvj3qrE/xy4RyhlCalXrzlCwKsKe0zYzQvynTMq2J9Jh5V6Z3OSRm2UMW2tM8t1t5bHBYsSLcJyUIXOjGpg/uBU8YMCvOqD+pOHV5tuPbiTWly5gsPZPokaLBmtxZjeGZ9+d6Dgc7Kc4VINOLYMmWfjoaUw2hbyEcrRwUIwDqu8P/bZNcygu5OmEtCohEgtg1wEj91xPwl5M10N73i8Um2KTG+2gmiP6Hs7/OW693IryfGvIRw+aqHjnJdTbvfsX3itAdRdBAlb6PlAkvwVQQss3LCZYsn88U3sOOSCl08A/qD7CGEhg4ycHSo7y0Y33eJPkNTIpOucJLkK7g5x8G5CowQrS5RGf4z72Bfi429fdO7dE2fqY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(22082099003)(3023799007)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(10067099003)(261102123227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xqg59sXV1qDd5nz/T/wvGKZegGYHi6daAth8KxES1f8YLti1QEUJwGHuunn2?=
 =?us-ascii?Q?bpwqyQ1GvZkJb1QIWogSrtrlO0XFw1W0gbNWJNQnJgWgxEXm43M7tz8ilwGO?=
 =?us-ascii?Q?ekuRudVqQg300c9leHphFQqJeFc/BEnIDNMh2j0iwP39Cf5ynHojcb7paXM0?=
 =?us-ascii?Q?THFabcFmAFLNW82CgojjbJVOgzqjBgODVZSUAR9n1VArKSxCnYssRqnVMC41?=
 =?us-ascii?Q?iZMlwaRmFZJ7Mx1MMMPMWubnZQ4MfMhcDns9ol1wdcMV0ljcDt83nr4VulcK?=
 =?us-ascii?Q?iVwTuGsi0ME8BV5UU2xea0kJ98KuGkjM9rIgLL7fU1h2H3+/1hzjslETO2vP?=
 =?us-ascii?Q?fgyK6SwRFdFjYkz7xGUmc85eenqeBeHdHXRQpq0/r/rzfjypPjDlZZ4Rfsx2?=
 =?us-ascii?Q?lFccmxLXWUZ45QUh51Wc2HrOcC1pQ+wK5Dlmzm4gkS84mlWRlnkSSslIxl1B?=
 =?us-ascii?Q?3sA1WEFhrUTmRPqnJd8OEg3evTsCcCRX8+dBxdxdAWbi0xPXLrSy49qBUnU7?=
 =?us-ascii?Q?do6PacQMq44DsYuNxjr+rIobZIkyyDzdBSMuIwM4N+zJTu3PvaB7+70lQGZF?=
 =?us-ascii?Q?oWpRavOrjj1g2oHjubatfhxnIJOCj6dUyyur502gwjiaMvu8NGQ4HA/4SvDB?=
 =?us-ascii?Q?8FUcVjSxojoS6SVXmqFY5sPzlijhBwxixs71UrDE8TlrKwY5UhtqxBISjMY5?=
 =?us-ascii?Q?vop1uhWHnDIHCpR1iLwaCJsjEhxuupWiqILgzBq2AfrjtDeGyc506rx+LI2e?=
 =?us-ascii?Q?LNC8rl4rzLdwRFxBWOR8Vev+pywJG+xRFgOyXxpe1TsvPh/T8XLBgO3xS6yx?=
 =?us-ascii?Q?ZVsy//WbYO+ttBQmCaVnEVrlX3AC/C8dlvZjrORXmQtTlsliWbIFDLsU85m9?=
 =?us-ascii?Q?7zF0eZv30yhJk8tWoOOLRL52robiV1nLanzUYWcAmAuIdkSNmUPZjYvBhWCR?=
 =?us-ascii?Q?y/fjZ3h5WcMr4M2myoVhwea/MRy2lg3UIKDfpHDqsxA/mowfoeqytEX+uifu?=
 =?us-ascii?Q?pnUUNnzu/Z7jQB/MYKrfhOdEHMgYuNoBr9oLukQ3lxfne6vq/viIQGS4AbyZ?=
 =?us-ascii?Q?Wht4Hu8WpWHZ/dPrOF9+VUrHjcdab/GRnDXHlZJC5KhiMiauopDegoKa7t2E?=
 =?us-ascii?Q?LSeBzGk0c5YbwZbXD4VkaEbKoFkLIyd8GwfmiPD+IC/JwrVNol+6wtJ/OUf1?=
 =?us-ascii?Q?mbhxJy6ymNWaU1KmsYGxWBar7MYtM/ozcC/3y1QpoGlUdyg2ODLx4/RhN6Cm?=
 =?us-ascii?Q?MFTZlAE/plwA7AjYCZirgL6aWRfM+0VSWLAGBnkcrFjseAHvT2tOGE6X4m99?=
 =?us-ascii?Q?WrKWXje0k0kcR6+wBHp2tHSMqaJuh56vXwU8nzUmlHEgMQrsW5OMP3rr++CA?=
 =?us-ascii?Q?k4mwz9Gz7Bc1G1wWWebHdlbFJFGJa9CjYGzZ52DwHnTA2GjWs1H9p2eM0R/g?=
 =?us-ascii?Q?EGai5lqC/cEIDKnfnuY9EBY68kXWnsQM6eCoRXBiVpgfXiMdnhACR4dgZ8jU?=
 =?us-ascii?Q?1tA/dDcleKeoE+/QO0FywDXx+/mZrwO8rtGSu7obIMYnLx3eJNqPoBUVqMAw?=
 =?us-ascii?Q?TYTVHz8i6UCfyB2RZwmo3u9IPdBQ5J3UkEsAjQxNhOjjc1u6lk7XUsr6ftKJ?=
 =?us-ascii?Q?U+J594cCgkrmQD0L770fySMhWIoHVrcmuhQAR6bVV2x9l58JUAqM/IpPTbM7?=
 =?us-ascii?Q?X9GqLL65xGRL45Ku7O9M66Me9Qc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b473ff3c-8ec8-4747-caeb-08df45bb7dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 21:32:48.0283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvTz+hzoGz4QUTtJfMRCnftML/E53ZSbH6YH3bzFOavbpjXG77eQl2Cyn9wbgNPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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
> Sent: Wednesday, November 18, 2026 12:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/3] drm/amdkfd: only flush the TLB of devices whose queu=
es
> got suspended
>
> suspend_queues() goes through all devices of the process, and on MES does
> the debug memory fence and a heavy-weight TLB flush when total_suspended,
> the number of queues suspended so far on any device, is non-zero. On a
> later device without suspended queues that flushes the TLB of a VM the
> process may not even have: kfd_flush_tlb() dereferences pdd->drm_priv,
> which is NULL when the process never acquired a VM on that GPU.
>
> That is a process using only one GPU of a system with more, e.g. a dGPU
> plus the APU's iGPU, stopped by a debugger. On navi31 with the iGPU,
> a debugger suspending a compute queue of a ptraced child that only
> acquired the navi31 VM:
>
>   Oops: general protection fault, probably for non-canonical address
> 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
>   RIP: 0010:suspend_queues+0x104b/0x1a80 [amdgpu]
>   Call Trace:
>    kfd_ioctl_set_debug_trap+0x1234/0x1720 [amdgpu]
>    kfd_ioctl+0x46a/0xb70 [amdgpu]

I guess this is a problem of runtime masking off a device (no future work e=
xpected for that runtime instance) while the debugger early attaches to all=
 devices (no idea of the mask)?

Maybe a fast fix is to early return in kfd_flush_tlb on null to avoid any o=
ther caller from hitting the same null pointer problem.
A proper optimization might be to check acquire per pdd on trap activation =
(post runtime enable) and mark the pdd as undebuggable if unacquired (expec=
ting no future work).
Then any debug op that touches the device debug context (via suspend, resum=
e, override ops etc) can early return and saves unnecessary escape calls to=
 MES.

Jon

>
> and the debugger ends up in D state.
>
> Count the queues MES suspended per device and only fence and flush for
> those devices. With that the queue is suspended and resumed (status 0) an=
d
> the kfdtest KFDDBGTest tests pass.
>
> Fixes: ff114e705d6a ("drm/amdkfd: Add TLB flush after MES queue
> eviction/suspension")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b5d7d13f31a5..a50a49d6ed01 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3952,7 +3952,7 @@ int suspend_queues(struct kfd_process *p,
>               struct device *dev =3D dqm->dev->adev->dev;
>               struct qcm_process_device *qpd =3D &pdd->qpd;
>               struct queue *q;
> -             int r, per_device_suspended =3D 0;
> +             int r, per_device_suspended =3D 0, mes_suspended =3D 0;
>
>               mutex_lock(&p->event_mutex);
>               dqm_lock(dqm);
> @@ -3974,7 +3974,7 @@ int suspend_queues(struct kfd_process *p,
>
>       ~exception_clear_mask;
>
>                                       if (is_mes)
> -                                             total_suspended++;
> +                                             mes_suspended++;
>                                       else
>                                               per_device_suspended++;
>                               } else if (err !=3D -EBUSY) {
> @@ -3987,7 +3987,12 @@ int suspend_queues(struct kfd_process *p,
>               if (!per_device_suspended) {
>                       dqm_unlock(dqm);
>                       mutex_unlock(&p->event_mutex);
> -                     if (total_suspended) {
> +                     /*
> +                      * Only for the queues of this device, the process =
may
> +                      * not even have a VM on the other devices.
> +                      */
> +                     if (mes_suspended) {
> +                             total_suspended +=3D mes_suspended;
>                               amdgpu_amdkfd_debug_mem_fence(dqm-
> >dev->adev);
>                               /* Heavy-weight TLB flush after MES suspend=
s
> queues */
>                               kfd_flush_tlb(pdd);
> --
> 2.50.1

