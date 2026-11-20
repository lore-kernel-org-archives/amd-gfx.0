Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50A606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n8cRiR1B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D5F10E24E;
	Fri, 20 Nov 2026 08:00:34 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A00710E28B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 08:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4pnKRNnXUn2ngQ7yGZq5RIS8kDQNUMoKHEbDpJr8/CiRnRrhUvCdnOhN4Yd1Fa0rW8a+i5pg3jqZA6UT0Csmq6UGVlx/Qx7sXJu5Es+nCdJT1hJBPgkHA3+MrlLo/xCVJ9nuXIWC/dCGZXFqlTU0lqjGoy9qeLvHoY10FMZ3V4ss6cNCwmEA7pJUqV2fsc5qd/ZlzQwbPw0RDp7Xt9ItCcUJFgBO35T76SyEktDUt6PGJZ8HUf+c9z902CtbgbH3MDOKGkrQ9UZ+vPY9onwR3VyPppQOHOIOGPnVh/2TbIKGl8ErHpDTwH4gLXE9z+0mEIasqmMOUzV2iPSSEidyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/Kv8n6kYWtsrlDjDxUPQY0A7mH6lNVTGldhO4i+fTM=;
 b=Ymw7rgZbzGKVkaEyt0zuZNDqBg6RarWCDISaEkg3RiM9x2z6BjEAYhN0oP99UFSso2ZRaoaWl9M/cfC0iJ5xWtcgaI3C99bJ7F1Q77P8Qr929I/KkSBMQS3VifOiy+U/sq1SHuSF4LzyuIqoZu2s7tbYC90PpxEqG9D9TA+0cR+YPZYqw2AdDLFJKWH0kLD6eGjvwuMFO39JjvY3/PhwLelzIsGhCLBmuzaV3Db++rx/ZNYj5bfAHSIrUBMZp1Nec2yHOAFYhZvaPqFh3Vl8ZmoDB/T5LYVmSWdITTCgCdulCUthIYdu8f4QiTc5OdTmaH7MN4vKBTpX+XDtdspH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/Kv8n6kYWtsrlDjDxUPQY0A7mH6lNVTGldhO4i+fTM=;
 b=n8cRiR1BSRELFayq7bWdyi013Ey1n46oG/p8JiweU1Lt4DYyycydY6MWnvLIsEzIDHFDhNpTdLELx4lxUc+SlvN4Q8a62A0s2HtDSdB3Gb3wiNCs78w3EaFQesmPPzKbhA2tBSDAYpLxgFAMEa8APlMqWkVPC7FHt1oJ99/k7Fs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:58:20 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:58:19 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on out
 of debugging
Thread-Topic: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on
 out of debugging
Thread-Index: AQHdeAU5SZRK2N60O02AFK+KorERNbc1o7MAgADz20A=
Date: Fri, 20 Nov 2026 07:58:19 +0000
Message-ID: <DM4PR12MB5152BD53E8FE2A95ADA28066E3782@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
 <DS0PR12MB6392ADBE68E53824E1F550A385792@DS0PR12MB6392.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB6392ADBE68E53824E1F550A385792@DS0PR12MB6392.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB6758:EE_
x-ms-office365-filtering-correlation-id: 1f196aab-0d94-4461-dd88-08df46dc0ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|261009223027099003|18002099003|22082099003|3023799007|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|56012099006|4143699003|10067099003|38070700021|11063799006|5023799004;
x-microsoft-antispam-message-info: qb2m+wxXOUiPJHOr+fXf+Q9Ov+BDtIpmYyY2qZKzFpxvcB5JdS1jbSvwDMoRjnTivcVcUowJbJM1R7z76f36Xitsd38SmzqNDn9V/85aL4vK8itSHOzIlkSkoCNfND0U2Jmj+zMOaOaXTIsaGl1bp0IF1FX8MeqEb6msGNcuV1BWAbZdx/kschBE7dQacNmz4N8PnH9sbflCfqhyb/PXNxTyCYRttICEyxe+o+I3XknTI5dqlFLR1XlzfJ1OOjtGZzJB2Q+Cii6mHh1YCmfhwM2er5EvbbZfqX0J9vVJjNaG4qjwkwq5mZVxu6I5D9F/k1AILE6N6hFZvtoGer4IvA+DMsuprocfJ/c3/La+VGtVvMfrjTfHqbK7kHwtZudgdZPRqlTiTGs70G5JuSR1y8iKy8xNrEQp9+bfkHwJUXCn6TqoM+FddPBZUF0iutxuywbYOLEPmtloDIHMKYB50aVwih8sainfa5VxWOmoXBjTZexadPG3yGcYHibmd5BB2aRO2pvpVf1ZdlxJ4TvWoS9o6kGCY6APn3L6K24mvUQ3GDDCGXkr97YGoT4PIGsvRGBGX1+RnFZE6dNATN8Ohp8Llr+utxMqT+VPKvu/5a+oR6P5aqsaqfGbrkVOjDJ6HnTzGOSvwNMc00t0JwLXjN6AploRbv55jRJrfqQbpLW1QSnzGRVnM9IADCShhoopwUgRI+SgA4anS9jUAyWVNQR/e2lHiuzvGPFeKT+ZERU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(56012099006)(4143699003)(10067099003)(38070700021)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXZTWi6HhKt8TOfDR1HiKnT7g+WrKcwyCY3Uu8pOlfaQEGTvzP1KNepYV6sf?=
 =?us-ascii?Q?EECEvzHpvI/0BhmwZWB2La04U7QFR2L1pXuTpmruKMva1tnAyrYykk/mVN+2?=
 =?us-ascii?Q?JITAx/FizuPXHab9baeFJR/gpeOMlq0UzV5fwamUowNPekq9wS7o4aCuAVJY?=
 =?us-ascii?Q?uj7gJJyehZ6vVHOha/aqYrhiYcv12fz8gNwd1G4GNS1rCsNt9eeatbzgJ9VZ?=
 =?us-ascii?Q?pxZrqbeq7NjJKsN2r3fUoTPIjE06ehdTfPbCy7+6ffTASzn626A1Ynfm0+L1?=
 =?us-ascii?Q?Q+A2155eY1M4j0zFHp0myoG3p5entsDEIdyDb0XZyqduz1EuG615KDpUIw7o?=
 =?us-ascii?Q?2j/PT+yAIHi8QFaPt4tQenc5FBheGixs5kXaCSY6gqfNt8Tk9DaXU03pTHJt?=
 =?us-ascii?Q?cMIfpk8s1T0XkmloL+DevEJSU/xT8VzC94yR7JxGngjjylIQyIlYM9AXVV6v?=
 =?us-ascii?Q?txEvn/1BRnClPe+NBf+2TI28iVYK9ooeCB+YHNBVfAqADdY3mCaccjsv7yZt?=
 =?us-ascii?Q?fZANb1vHyWvjJtGTVdqU1nss6yrfwIk/cYce4uuKWkn0+b9O2HbuO1O+/VKa?=
 =?us-ascii?Q?Kevsxn5titkWGsaoWQkmiKY0plCaXsxI0LwXE3kOig/WGHaVSlE/CgsFpC0x?=
 =?us-ascii?Q?pScuaRK7qj1Wz/zd8exZGaZetkT/KZec2E0AsHQShAixPSeuYrOWHmX6LuEO?=
 =?us-ascii?Q?7vjI0zZtxJZ5WPFIqE32KK18CgtkjicG/uoXDxiRpLgxEkyVmBwXET9Tchwv?=
 =?us-ascii?Q?KKXa8gUPUi6wbAUVNSlYBw2M4fRV0o5YfHNW8NiHz47kfK10sSecbP2t8t27?=
 =?us-ascii?Q?UofSzzlF56i/jQxZyOtsfzOMRVBcvECFXLbtOEKk37hVL+qamI3KSaGF/KJz?=
 =?us-ascii?Q?C/pV9ETDMTkPnXt5ZTRWmhW4AaumGiv4z95McVE2qDX2rGuQmMIUzsijlcRk?=
 =?us-ascii?Q?BMlupBgzdUnHTVrKGiOlvH9hDIdUdtfTN2zXxnHJo/W4tiU5MlVfEGNPcMz4?=
 =?us-ascii?Q?jqjYeUiS6HNBDGKyweG89J81/QmDjIzNiIYz5MaacxCWGFUgEWg5UdO0CiTR?=
 =?us-ascii?Q?98oj8hnYhXmKZoNuUjSnP7D2XDS39dGlt6Ob17LzToMhle53gk5HhpjC5Ya5?=
 =?us-ascii?Q?SNhQQjynliZ0NgJdjE8n/erBApFULxNZyA14Hn9fAeVWix8cNNgiKfOf8+Jn?=
 =?us-ascii?Q?8tVK1HzdKpduTeTcUzFgjJBrKzTIEfes2KCb3afuBPcCEXQVzB6qkHo7jIea?=
 =?us-ascii?Q?c7ArC8ePYpJErTx1CCI0iZwTVatXmOB1VUTftnJWM8GRyD5x+vdCzZEsEN1s?=
 =?us-ascii?Q?KZ/9Gw3S2muJ0TzbLJKCZA9nHgyYc3QNmA87ERXlQv291EYU6UrknHFT5jG8?=
 =?us-ascii?Q?imwBVKIbXjcxa6MBC1Nl71YXPQFkxYt5bVvMG2gnE9UU0EdQ/B59dtLTuHhN?=
 =?us-ascii?Q?QtOEvTgDGV4Jet0AF2ALfLO8s6lYAPWrVYGfgdO+DPpnONyjz55ilOu7bXP7?=
 =?us-ascii?Q?PLL/zMtLvRsOWf9VNqQKG760OA9mN0GqYLIn8amUPKKHlcJaLBQkwU573hBJ?=
 =?us-ascii?Q?5YnNMj/x+rUXfwKkp0+UNFkCiHaJcdelMJlc0iKHa+y+sZrLxfcMDq99SS2Y?=
 =?us-ascii?Q?fW2EBVMWD+QUhX8hLauVHgmfSGXmh3d2k4USiEqWW7dcXd6r7zS7OB/NsZCR?=
 =?us-ascii?Q?zvT1PHE4M/VTHbLHFO2TjiR2ga1Dp2qsNoYv5qAmlEnN7ma5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f196aab-0d94-4461-dd88-08df46dc0ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 07:58:19.5453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dGh4nNP/0AHv+EuL4igfrIjhgKMwyarEkyRQRA0SzQlUfWTjGvey3j73e1GBH120zRcY+3M14MFZPv4Z8x++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, November 20, 2026 1:18 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [v2 1/3] drm/amdkfd: leave the devices a process has no VM o=
n
> out of debugging
>
> Public
>
> > -----Original Message-----
> > From: Jesse Zhang <Jesse.Zhang@amd.com>
> > Sent: Thursday, November 19, 2026 4:05 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Zhang,
> > Jesse(Jie) <Jesse.Zhang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> > Subject: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on
> > out of debugging
> >
> > Debug activation and the debug operations go through all devices of
> > the process, also the ones it never acquired a VM on. With a dGPU and
> > an iGPU without per VMID debugging, debugging a process that only uses
> > the dGPU still takes the single debug VMID of the iGPU, so a second
> > debugger
> > fails:
>
> There can't be a second debugger on any process to begin with otherwise
> overrides/debug setup would conflict.
> I think you mean a single debugger with multiple inferiors (target proces=
ses).
> I'm getting a better idea of the issue now (but correct me if I'm wrong).
>
> You have 2 types of devices, multi-process debug supported MES based
> hardware and single process debug supported device (non-MES) being
> debugged under a single process.
> You then have the debugger trying to attach to more than 1 target process
> which is supported by one type of device but not the other.
>
> If this is the case, we shouldn't touch the unwind function.
> Debugging is process wide by design so multi-inferior debugging should fa=
il
> on this setup (at least for the second inferior attach and onward).
> The first process that attached successfully should still be OK.
>
> What I'm still confused about is how we ended up being able to suspend on=
 a
> process with a device with no VM acquire.
> Runtime enable happens after topology discovery and we should acquire the
> VMs for all devices of that runtime instance.
>
> What are the GDB reproducer steps?
You're right - I meant one debugger with two inferiors. I don't have a GDB =
reproducer. In the ROCr path I checked, VMs are acquired for all GPUs in th=
e runtime instance before RUNTIME_ENABLE.

The crash reproducer is the test using the KFD ioctls directly. The child a=
cquires only the dGPU VM before RUNTIME_ENABLE; the parent ptraces it, enab=
les debugging and suspends its queue. The suspend loop then reaches the iGP=
U PDD with no VM and calls kfd_flush_tlb() because total_suspended is alrea=
dy nonzero.

I agree that the second inferior failing because of the iGPU's single-proce=
ss debugging limit is expected. I'll drop this patch. Can we only keep the =
kfd_flush_tlb() NULL check, since direct use of the KFD ioctls can otherwis=
e trigger a kernel oops.

Thanks,
Jess
>
> Jon
>
> >
> >   amdgpu 0000:05:00.0: Trap debug id already reserved
> >
> > and a trap override the iGPU doesn't support fails with -EACCES.
> >
> > A process isn't expected to use a device it hasn't acquired by the
> > time its runtime is enabled. Only activate debugging on the devices
> > with a VM and track it in debug_active, set once the debug VMID is
> > reserved so the unwind also undoes the device that failed.
> > Deactivation and the debug operations only go over those devices and
> > address watches on other devices fail with -ENODEV. A device the
> > process still acquires later is only debugged from the next attach.
> >
> > As kfd_dbg_trap_set_flags() now skips devices, rewind up to the last
> > updated device instead of using the number of updated devices as the
> > bound.
> >
> > Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 60 ++++++++++++-------
> >  drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  2 +-
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +
> >  5 files changed, 50 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 3d2136adb62b..3d768511d002 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -3039,7 +3039,7 @@ static int runtime_disable(struct kfd_process
> > *p)
> >
> >       if (p->debug_trap_enabled) {
> >               if (was_enabled)
> > -                     kfd_dbg_trap_deactivate(p, false, 0);
> > +                     kfd_dbg_trap_deactivate(p, false);
> >
> >               if (!p->is_runtime_retry)
> >
> >       kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
> > @@ -3219,7 +3219,7 @@ static int kfd_ioctl_set_debug_trap(struct file
> > *filep, struct kfd_process *p, v
> >                                       args-
> > >clear_node_address_watch.gpu_id);
> >
> >               pdd =3D kfd_process_device_data_by_id(target, user_gpu_id=
);
> > -             if (user_gpu_id =3D=3D -EINVAL || !pdd) {
> > +             if (user_gpu_id =3D=3D -EINVAL || !pdd ||
> > + !pdd->debug_active) {
> >                       r =3D -ENODEV;
> >                       goto unlock_out;
> >               }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > index d5c87de519ac..b2d01613a21c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > @@ -504,9 +504,13 @@ static void
> > kfd_dbg_clear_process_address_watch(struct kfd_process *target)  {
> >       int i, j;
> >
> > -     for (i =3D 0; i < target->n_pdds; i++)
> > +     for (i =3D 0; i < target->n_pdds; i++) {
> > +             if (!target->pdds[i]->debug_active)
> > +                     continue;
> > +
> >               for (j =3D 0; j < MAX_WATCH_ADDRESSES; j++)
> >                       kfd_dbg_trap_clear_dev_address_watch(target-
> > >pdds[i], j);
> > +     }
> >  }
> >
> >  int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t
> > *flags) @@ -517,8 +521,12 @@ int kfd_dbg_trap_set_flags(struct
> > kfd_process *target, uint32_t *flags)
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               uint32_t caps;
> >               uint32_t caps2;
> > -             struct kfd_topology_device *topo_dev =3D
> > -                     kfd_topology_device_by_id(target->pdds[i]->dev->i=
d);
> > +             struct kfd_topology_device *topo_dev;
> > +
> > +             if (!target->pdds[i]->debug_active)
> > +                     continue;
> > +
> > +             topo_dev =3D
> > + kfd_topology_device_by_id(target->pdds[i]->dev-
> > >id);
> >               if (!topo_dev)
> >                       return -EINVAL;
> >
> > @@ -549,7 +557,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >
> > -             if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
> > +             if (!pdd->debug_active ||
> > + !kfd_dbg_is_per_vmid_supported(pdd-
> > >dev))
> >                       continue;
> >
> >               if (!pdd->dev->kfd->shared_resources.enable_mes)
> > @@ -562,7 +570,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >                       break;
> >               }
> >
> > -             rewind_count++;
> > +             rewind_count =3D i + 1;
> >       }
> >
> >       /* Rewind flags */
> > @@ -572,7 +580,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >               for (i =3D 0; i < rewind_count; i++) {
> >                       struct kfd_process_device *pdd =3D
> > target->pdds[i];
> >
> > -                     if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
> > +                     if (!pdd->debug_active ||
> > +                         !kfd_dbg_is_per_vmid_supported(pdd->dev))
> >                               continue;
> >
> >                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> > @@ -588,12 +597,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >  /* kfd_dbg_trap_deactivate:
> >   *   target: target process
> >   *   unwind: If this is unwinding a failed kfd_dbg_trap_enable()
> > - *   unwind_count:
> > - *           If unwind =3D=3D true, how far down the pdd list we need
> > - *                           to unwind
> > - *           else: ignored
> >   */
> > -void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind,
> > int
> > unwind_count)
> > +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind)
> >  {
> >       int i;
> >
> > @@ -614,12 +619,9 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> > *target, bool unwind, int unwind
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >
> > -             /* If this is an unwind, and we have unwound the required
> > -              * enable calls on the pdd list, we need to stop now
> > -              * otherwise we may mess up another debugger session.
> > -              */
> > -             if (unwind && i =3D=3D unwind_count)
> > -                     break;
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +             pdd->debug_active =3D false;
> >
> >               kfd_process_set_trap_debug_flag(&pdd->qpd, false);
> >
> > @@ -684,7 +686,7 @@ int kfd_dbg_trap_disable(struct kfd_process
> > *target, bool
> > drain_irqs)
> >        * attached running target runtime state to enable for re-attach.
> >        */
> >       if (target->runtime_info.runtime_state =3D=3D
> > DEBUG_RUNTIME_STATE_ENABLED)
> > -             kfd_dbg_trap_deactivate(target, false, 0);
> > +             kfd_dbg_trap_deactivate(target, false);
> >       else if (target->runtime_info.runtime_state !=3D
> > DEBUG_RUNTIME_STATE_DISABLED)
> >               target->runtime_info.runtime_state =3D
> > DEBUG_RUNTIME_STATE_ENABLED;
> >
> > @@ -715,6 +717,9 @@ int kfd_dbg_trap_activate(struct kfd_process
> *target)
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >
> > +             if (!pdd->drm_priv)
> > +                     continue;
> > +
> >               if (!kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> >                       r =3D reserve_debug_trap_vmid(pdd->dev->dqm, &pdd=
-
> > >qpd);
> >
> > @@ -727,6 +732,8 @@ int kfd_dbg_trap_activate(struct kfd_process
> *target)
> >                       }
> >               }
> >
> > +             pdd->debug_active =3D true;
> > +
> >               /* Disable GFX OFF to prevent garbage read/writes to
> > debug registers.
> >                * If RLC restore of debug registers is not supported
> > and runtime enable
> >                * hasn't done so already on ttmp setup request, restore
> > the trap config registers.
> > @@ -775,7 +782,7 @@ int kfd_dbg_trap_activate(struct kfd_process
> *target)
> >       /* Enabling debug failed, we need to disable on
> >        * all GPUs so the enable is all or nothing.
> >        */
> > -     kfd_dbg_trap_deactivate(target, true, i);
> > +     kfd_dbg_trap_deactivate(target, true);
> >       return r;
> >  }
> >
> > @@ -825,7 +832,7 @@ int kfd_dbg_trap_enable(struct kfd_process
> > *target, uint32_t fd,
> >               atomic_inc(&target->debugger_process-
> > >debugged_process_count);
> >
> >       if (copy_to_user(runtime_info, (void *)&target->runtime_info,
> > copy_size)) {
> > -             kfd_dbg_trap_deactivate(target, false, 0);
> > +             kfd_dbg_trap_deactivate(target, false);
> >               fput(target->dbg_ev_file);
> >               target->dbg_ev_file =3D NULL;
> >               if (target->debugger_process) @@ -851,7 +858,12 @@
> > static int kfd_dbg_validate_trap_override_request(struct kfd_process
> > *p,
> >
> >       for (i =3D 0; i < p->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D p->pdds[i];
> > -             int err =3D pdd->dev->kfd2kgd->validate_trap_override_req=
uest(
> > +             int err;
> > +
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +
> > +             err =3D pdd->dev->kfd2kgd->validate_trap_override_request=
(
> >
> > pdd->dev-
> > >adev,
> >
> > trap_override,
> >
> >       trap_mask_supported);
> > @@ -886,6 +898,9 @@ int kfd_dbg_trap_set_wave_launch_override(struct
> > kfd_process *target,
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +
> >               amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> >               pdd->spi_dbg_override =3D pdd->dev->kfd2kgd-
> > >set_wave_launch_trap_override(
> >                               pdd->dev->adev, @@ -922,6 +937,9 @@ int
> > kfd_dbg_trap_set_wave_launch_mode(struct
> > kfd_process *target,
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +
> >               amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> >               pdd->spi_dbg_launch_mode =3D pdd->dev->kfd2kgd-
> > >set_wave_launch_mode(
> >                               pdd->dev->adev, diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> > index 5babf9b992cd..e93d77fccda2 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> > @@ -25,7 +25,7 @@
> >
> >  #include "kfd_priv.h"
> >
> > -void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind,
> > int unwind_count);
> > +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool
> > +unwind);
> >  int kfd_dbg_trap_activate(struct kfd_process *target);  int
> > kfd_dbg_ev_query_debug_event(struct kfd_process *process,
> >                       unsigned int *queue_id, diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index b5d7d13f31a5..b8ef93dba0af 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -3851,6 +3851,9 @@ int resume_queues(struct kfd_process *p,
> >               struct queue *q;
> >               int r, per_device_resumed =3D 0;
> >
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +
> >               dqm_lock(dqm);
> >
> >               /* unmask queues that resume or already resumed as valid
> > */ @@ -3954,6 +3957,9 @@ int suspend_queues(struct kfd_process *p,
> >               struct queue *q;
> >               int r, per_device_suspended =3D 0;
> >
> > +             if (!pdd->debug_active)
> > +                     continue;
> > +
> >               mutex_lock(&p->event_mutex);
> >               dqm_lock(dqm);
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 129363ad4e34..ed85b7fb896e 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -880,6 +880,8 @@ struct kfd_process_device {
> >       uint32_t watch_points[4];
> >       uint64_t watch_addresses[4];
> >       uint32_t alloc_watch_ids;
> > +     /* Debugging is activated on the device */
> > +     bool debug_active;
> >
> >       /*
> >        * If this process has been checkpointed before, then the user
> > --
> > 2.50.1
>

