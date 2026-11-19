Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F4606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=girjKScS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292F7112190;
	Thu, 19 Nov 2026 08:43:34 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F39B11218F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 08:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj6H/WiRzrqx+ZhrlaElT+N340QnFKubQ0g4IUDyLRM01/xZ9W583Qo560Kyn0Ehn0uUA1UkggT3w2YZbxQLVdPsWjpOWKEJtQ7hWvdVqyToRycFv96SEiy9bvuKso6T9TjlV+18mCobKB2O3EdkGI+HhrZAWoZfVqQi/i1gNGlO48dCdafavKtF05z5HY1xQu7m9vjap2uMce7Vm/Zq01hQ8OMwXDVTvKCbAhzFlXo7Qm8nGMK3Ky69GJTPO1YC+yp+WrrHQriccNTmsAUYKRKVVN9x4NOFugBeKfCRWGgik9rPwpJWdU6vgGJhiQDhA3lFoTX7uzFIwsjFtEEHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WlSciYB1qyhrhED8v9pxQNSSy4eNPUfiGjx77f3xkY=;
 b=ic0EPfysxl2OQD3jNhsXoIZ6Cqz/wOxllDZhYTMwLv7Pe9WN8C292gIG8QG2lppUSkwz/BLXGvjQOsqNMAlLR72cPBGn4fd+LSvn5zKzySnhlv8g800+8qx/+jCx+F43f3JV3+eMmXkSI4/1STmC0NAOfBtLpnrcIGCJLssov/KSps3ybsMNPTmsl8hFMcafqV0zE4QG3CF38LjBCurUmcrH93I2zfDXhUiFh5xRM1lvQebdY2zK2CBxlt9XEKpdqxFTdjSKrgnSMVcmxtmLzRKHGhTJI+b2xPgBLUbMs3yCnnPyBI11X8NkK11Y14winxaDkL9mldmdc86hrszsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WlSciYB1qyhrhED8v9pxQNSSy4eNPUfiGjx77f3xkY=;
 b=girjKScSqgRexeaNwmTFOmTbO8rD4CZUIM2WwC3nyCw6NC5CLcQax0cLIgs1wKAyNCMTS4mzKXQWrI98SQMIMYWFr5UJoWdyVRLqjPHkrb6443aqTptaAPfUqbxsC3MpVVxw8iC3vBfEtjHPoH5jaHVyCAKoJKiUBbaqzLyMwdE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 08:43:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 08:43:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Topic: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Index: AQHddyC2h6pszV1O3kuE1s+iLJszvrc0YI4AgACnCSA=
Date: Thu, 19 Nov 2026 08:43:22 +0000
Message-ID: <DM4PR12MB5152FE29423A49B9FA72E865E3792@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
 <20261118055009.3005630-3-Jesse.Zhang@amd.com>
 <DS0PR12MB63924BF666B4F1A9B4ABB18A857A2@DS0PR12MB6392.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB63924BF666B4F1A9B4ABB18A857A2@DS0PR12MB6392.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-18T21:33:01.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB8984:EE_
x-ms-office365-filtering-correlation-id: bf2f7a77-4f1f-4c5f-bd67-08df46192b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|5023799004|38070700021|261022075727099003|261021123027099003|4143699003|11063799006|56012099006|261026140227099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: IB7vT9k4YCYDZAvyLwr8pvIi5X8nky0TLuWvtRYRX0fxgZNHuJnmbYUD9wjnfwbw0oArS2vTOyVksO+z8QFfHDsmASUkvj7/pLiOB3quneVps0drbB/+OwJGsaV90y5ut0VnnEPHkoZYznXCSaPD9/theNt7fAKjqYuFLLOLbhhjKlQCxnDk82z4E62IhBscXGzkN+PrYlK0Bs5EvJQ+I/OuMLgqC88tvbkn6Egp1fg4rtuNLgzaDiMrtCopIAVmVBclzP0ZbqbHltJuirhspSPmDjmUKMSNoSlFfPBLbB9FQTvTIAwosEUyWWFUlX/I9C74sxIXIna90Lv1yhQA3TIpYvYX7ggLiU5yqILcNLjKnU1vv1lJkDMD9vqHJpXuTttyAXT56tU6XWK49PwXKBLqe23SVOV2GzNF+MV/SG2JL9a9fcf7yQAYgEjA+kgGUl/5SvJGzg9QEMkg0sbE97jamRXiFIFot0ejgPCD5+kMjGKESDF6rs/cs8k2+tMf06mee3OkSFKofSUtZ0hfq3JN9WypHQEGhXNPqggvKtV46Bviz4SwWGcVz7rZpazLT8nxFWAnbsIwmaoxuuqMMVWH+8rNuesrNn1jbvE0qCnCXNFZaNZiht5XuWZ0qre5Eo9PeuMPzdIL64s/14X+HspRn1wHmjk9cj/Mieu8j9GVly1XNQvJtSzM8BrLW0eOzaBx2qIz72fFecLRZM7IuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(38070700021)(261022075727099003)(261021123027099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ncbjGN3GoKo267q7vT9KAowONvPVuurRgUelS5cV2hxBS6WqnFExHkKsYBU4?=
 =?us-ascii?Q?K1lV+E7LAFaeK1kmVFPTcrh0fcEbECJB+o49kIVzbOGr429p26XXLyr9KBzq?=
 =?us-ascii?Q?ApJRViQf37FWhOiLMwOwH+S1F/SNPuZIKZxl8UMAq+dUnrR2DRQ1YDtbpjc9?=
 =?us-ascii?Q?QN03A6CKrm0mQ7jrq+47N8nLVN1TnPxpffoGCF97Du9kY/y4+wD2QgjvgdBy?=
 =?us-ascii?Q?GWDAEbR1DCho/FkTXV4R3QAmTMiKQhmWdRVeQZf0H1e3+xUiXxtavXs2Y8Cs?=
 =?us-ascii?Q?BG8omhzdWiGOxUZ3aCnbA0RIpcSxwQieuIk4nDJ80l8ezCuGZ/dny/kq8iUe?=
 =?us-ascii?Q?OyS9VJYcVv6u9BPU+xdabQXQsEB3o6Kb4cqAVZifrE0Lp7+7qTeoZX2TI0ns?=
 =?us-ascii?Q?2OuzfIL+f8jWziRx5lx3nF8oLcgFKIeaERQ42Egi5aYMu8cGUnDFzjphswWy?=
 =?us-ascii?Q?wRoaOEAa3fpAq/K2GyUrzp02XDAsicAf1MUuP/9ekRRkO2OPZg+/z4rgHntJ?=
 =?us-ascii?Q?k9J7hXXoHcKr72mfuKi82aJqfT+UeSc8P1Twg7kkxhBJoq51zo2dF5z5Ph5c?=
 =?us-ascii?Q?f0GbGC6K4qoCjjyOtrfN3wcqd5eIKoQOD9nPPl8iT1fZkAM+NHnn9O10tMKc?=
 =?us-ascii?Q?TpE7qXlE9NFdzpt16FNMpU9EOy69fvUDomo80mu0ckotNquqhjul1ds7kxau?=
 =?us-ascii?Q?wxvybR913d2xwSs/XyBpapVFTXR0ZNyNV78SFCxQMWnZttZwvzbJB7xrwmiD?=
 =?us-ascii?Q?nNSbe0Dzbi+dpMi1A3iIs+KFv9HXJAc8HYSF3OGoincgdpFse8VedzM5DU8A?=
 =?us-ascii?Q?LMAiFvgLj28iTwmSx6G0mqFOK9P7hY5g9kp5QMW+naTWgNln7if35GuQfIFz?=
 =?us-ascii?Q?IItrjlNq3UG4/7N6bps5E9umvWRgKTKE0LD3BMd1XKOJX+X4CA7LZdKiOSOV?=
 =?us-ascii?Q?Brx/Ox1TPiycqN0UY0DEGufqwoM8pNjRclIt+Tq8vV277keAUxBnzP7+0goQ?=
 =?us-ascii?Q?ntY6IU7/yz+1n4iz+TBWcfnbAxKsOjjKngkJVg9eNKxRQdgvK4bpZrcnZoo1?=
 =?us-ascii?Q?5OpM7rGXpiDIri3z1sXA1h37i9LK0QSJqxIok+w1i6gVFtZRwLvYLWB4xkzf?=
 =?us-ascii?Q?1oP/0AfQ4IZZm8dig4w8JNIe2CPUU2YvCzBQI+zv7eyjRbkcWzwy1mtwUBjr?=
 =?us-ascii?Q?0rFuWz6AQHgncu0IK0MaeegANipO40NOpXTa86xW5wBHz8+/GejoHN0WcP9i?=
 =?us-ascii?Q?Bfy4kTD+cinrNplo7/mt3HU9EvBhoKY2sxcaCeMZ+0HtAcZAZKAqiFd4lHon?=
 =?us-ascii?Q?ek/YN0VrbPJ2FMbHFnUoxIZHheWeTWnIm8fyJXyfVVzNj4Ukm13do1i8ncyR?=
 =?us-ascii?Q?BnCblZnwfCGVylKgU4xT0D1s9YR2Dk0iFV7lPmwbiXA6TX+8B9XnQt3WU+Q+?=
 =?us-ascii?Q?tmMWX8xD6nPwLGD1mA6vVjCIF2srJUliMIGQ/BxHREP/Zlg/PhCqUXcPWGM0?=
 =?us-ascii?Q?h7rhZg0p+6EhQBSnBhpS8T6rd8XpC/uQGDPMgPTmP0FbzBBNbII/kPVLIcPd?=
 =?us-ascii?Q?GprfTVEx0k5KEo0HLwvvfTkq33fg21s2QRazzqkjKKsgSdvP4ylKJN77Te4G?=
 =?us-ascii?Q?34dcfF+zeZLh5InrdEJKrBG48I9l4ODneF9Adcp4UFQpIXBbaEj1D2+3AXhF?=
 =?us-ascii?Q?RqDRL+dZkcHCGyoUqbI7VdpqHEJJlDHR8bq5UdwGuOYJzjG+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2f7a77-4f1f-4c5f-bd67-08df46192b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 08:43:22.8267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJZCyeYndkLS/g1wgCzN5KqTF4ip7BDWl7LuuupyCPay5sdB8LLUQ+SlhtgSsv1encSuV+47066//fkbD49LoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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
> Sent: Thursday, November 19, 2026 5:55 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
> DBG_TRAP_ENABLE fails
>
> Public
>
> > -----Original Message-----
> > From: Jesse Zhang <Jesse.Zhang@amd.com>
> > Sent: Wednesday, November 18, 2026 12:50 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Zhang,
> > Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
> > DBG_TRAP_ENABLE fails
> >
> > KFD_IOC_DBG_TRAP_ENABLE stores the caller in target->debugger_process
> > before calling kfd_dbg_trap_enable(), and nothing resets it when that
> > fails (-EALREADY, -ENODEV, -EBUSY, -EBADF for a bad dbg_fd, -EFAULT).
> > The permission check at the top of kfd_ioctl_set_debug_trap() accepts
> > any caller equal to target->debugger_process, so the caller keeps
> > debug access after it stopped ptracing the target. The pointer is also
> > not reference counted, so it dangles once the caller exits, and a
> > later successful ENABLE by the target itself increments
> > debugged_process_count of the freed process.
> >
> > On navi31, a parent that ptraces its child, tries to enable debugging
> > with dbg_fd =3D -1 (-EBADF) and then detaches can still enable debuggin=
g
> > on the child with a valid fd:
> >
> >   1. ptraced, ENABLE with dbg_fd=3D-1      -> -9 (Bad file descriptor)
> >   2. ptrace detached
> >   3. not ptraced, ENABLE with valid fd  -> 0 (success)
> >
> > Restore the previous debugger when enabling fails. Step 3 now fails
> > with -EPERM.
> >
> > Return -EALREADY for an already enabled session before touching the
> > pointer at all: the exit cleanup of the current debugger looks for its
> > targets through target->debugger_process without holding
> > target->mutex, so even a temporary change of the pointer could make it
> > skip the target and leave a dangling pointer behind.
> >
> > Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> > disable")
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 3d2136adb62b..c42c30b459a3 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -3226,7 +3226,19 @@ static int kfd_ioctl_set_debug_trap(struct file
> > *filep, struct kfd_process *p, v
> >       }
> >
> >       switch (args->op) {
> > -     case KFD_IOC_DBG_TRAP_ENABLE:
> > +     case KFD_IOC_DBG_TRAP_ENABLE: {
>
> Any reason for the brace?
The brace is only for the local old_debugger. I'll drop both in v2

>
> > +             struct kfd_process *old_debugger =3D
> > + target->debugger_process;
> > +
> > +             /*
> > +              * Don't touch the debugger of a session that is already =
enabled,
> > +              * not even temporarily: its exit cleanup looks the point=
er up
> > +              * without target->mutex.
> > +              */
>
> I'm not sure what you mean by this.  Did you mean the mutex of the caller
> process instead of target to avoid a race during process release?
Sorry for the confusion. I'll clarify the comment in v2.
I meant the exit of the debugger owning the existing session.
Its kfd_process_notifier_release_internal() checks target->debugger_process=
 before taking target->mutex.
If another caller's ENABLE temporarily replaces that pointer, cleanup could=
 miss the target, leaving a dangling pointer
when it is restored and the original debugger exits.

Returning -EALREADY before changing the pointer avoids this window.
holding the caller's mutex would cover this case, since the existing debugg=
er's cleanup doesn't take that mutex

Jesse

> We should probably hold the mutex for the process if process !=3D target =
here
> and drop the condition below.
> That way either only enable or release can happen (but not both at the sa=
me
> time) and a bad return of kfd_dbg_trap_enable (including -EALREADY) will
> cleanup properly with your change below.
>
> > +             if (target->debug_trap_enabled) {
> > +                     r =3D -EALREADY;
> > +                     break;
> > +             }
> > +
> >               if (target !=3D p)
> >                       target->debugger_process =3D p;
> >
> > @@ -3236,8 +3248,12 @@ static int kfd_ioctl_set_debug_trap(struct file
> > *filep, struct kfd_process *p, v
> >                                       &args->enable.rinfo_size);
> >               if (!r)
> >                       target->exception_enable_mask =3D args-
> > >enable.exception_mask;
> > +             else
> > +                     /* the debugger check above trusts this pointer *=
/
> > +                     target->debugger_process =3D old_debugger;
>
> This probably only works if you hold the process mutex if process !=3D ta=
rget
> during enable to avoid race with process release.
>
> Jon
>
> >
> >               break;
> > +     }
> >       case KFD_IOC_DBG_TRAP_DISABLE:
> >               r =3D kfd_dbg_trap_disable(target, true);
> >               break;
> > --
> > 2.50.1
>

