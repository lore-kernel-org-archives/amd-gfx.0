Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05C606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x9H1XvWw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A286210E1DD;
	Fri, 20 Nov 2026 08:17:45 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370C210E1DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 08:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deftcHgHOplKHBfo1t0/Vw/EzPPWvxj3uoBNgZMW1oT+/28p6am2YHNEqmQhFL/a+1fiq80yINjVTG/qR9Z5Wd/Xixt3yksJNDhoaKD6s3MymNntvrm2SzlS1VDLzj480xkXwb31EUHciORTC1By8TPgB+5GAxlMP0zCQ4NxRQFbyfrF5+69tQkgaj5LK28tNkzdUTVjHsypDI1rxOTf/xY6CuxH90oMyedBnPtMJHG+/AH3iRBsEupXVi8jtzy6WYYJJqjo9KHt3K/sr40HUWs6Kg7MV4qKo36iBpqzVarTAmM1y1FkgOEHfid2dkq1qiAPd6NLS5gNwDGXR8VfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNTWU01jnkll5ykDShEpNtlH4+WdZpCGMIEMx/NWfx4=;
 b=dtmqUp5BGzRKA8pUlqEW+peVxUf2ur1tEnygi2i6zhAUVrP4mPrbv3dfCuuc15vIkROk1mWOJ1e4SjsfTDVFWEfWpKh6xz72nx3FTkRuRo8vBwi4IBnt+t+47mvPlfT6SY5BAfGi7pQDlfWaa6m/gRhpV9GhzHhf5wUKxISdvSdKz0O4/NzT/d2XHs+khzHCN9TwipYbhoU30rt4EkDVd5KfPJDtJjtVwIuXCVeNgZT36SrahkmdtR7UJc7dK0ZRVpwO4C5H/GFaW7qWCHfCMwspa4IVqgmelvvJaJvAR4952bGYNhTCNxYmPdBeokUhvUlJ0ox44EMdrqKuB70frQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNTWU01jnkll5ykDShEpNtlH4+WdZpCGMIEMx/NWfx4=;
 b=x9H1XvWw5WG/iPn/BDnHCjT4GwHDBiBCCnzHMvmdF7iSxYDUsO4AJLCsxbb1YTH69Bv7Dc7uJUPC29L2CJaNW8mxfc2fx+xo+/GiXiqjzX7CDpuPEoTWdmqkGR6oAxc3sDERgSbD3xuxD9qOIia72RJ7ILBiP97DIlmifyDjKtc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:17:34 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:17:34 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Topic: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Index: AQHdeAU/rPomPkNTtEKAeXg8cdgnn7c1vH4AgADdg+A=
Date: Fri, 20 Nov 2026 08:17:34 +0000
Message-ID: <DM4PR12MB5152A7760F253EDB8225884AE3782@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
 <20261119090557.3494649-3-Jesse.Zhang@amd.com>
 <DS0PR12MB6392ECD4A8FEB76310E71BBD85792@DS0PR12MB6392.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB6392ECD4A8FEB76310E71BBD85792@DS0PR12MB6392.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-19T18:46:00.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS4PR12MB9610:EE_
x-ms-office365-filtering-correlation-id: 65514b71-552e-4df1-011a-08df46debb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18092099006|18002099003|10086099003|11063799006|4143699003|5023799004|56012099006|10067099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261009223027099003|38070700021|261026121527099003;
x-microsoft-antispam-message-info: rpDByG97i5teyTpRtfPxGn2kjTrvA901RcaCcYGNQ7pRRxdCAPlPI6McnrV9rxwOKG9rTIUqHgqDPd7Wkx2h3YS+uv4eVEqBkGPQa8lMsg50VUahIT+xqZ3fobBfwD7CjSilllwiryAVflcnx+svO1NuKBGSWQTjDYtAeRWgu+x7x+3ao4e5t2DcPwwrZXa1ldZRo4Rct2OVQzJF8+n0Brr1lHItoK+BfwgCdpJB9krUHmftX5QSB7YjgPDq6i+SpRTjDmGdVsSN60YUKQADhLhwQUNOq3ouX01Glfd3rJTOf1A4RNPLS70BYdTGBBxnNY8nwNR2dpwQbNAMyzSl+U6a3F/hTKm5vmKfQJlIxu9paXjJAhUKSA68Qfce5nlJb3UHLajQ988j+h5VwgnTyG5CMPhO57wuPsPo/hJgyPWTXvRNeumlzOT/gCv27cMeE4Slv/fjRZy5ko+3Bq6/CiELKbGhCQrRfsIJCf4N4h48yUQ2NIPa0KpCMxtfBP1/prUpDs4jKPaB/Q1MoLWnY15C2HcQBzGaDtGVbeAyhE3Z6oWelT1CaGxyblSb8LHWC1fvvRoAY7K+07heYuvYhuIvaTYGIECUO0rfK87dEurZ9yE2rtsSrNcGTVSYojC55E1sO+t8m+YVJEoT5u/Hw4LFBLIRnZ38OHxu2E/FX8PJKOGmBCgWRePPbXQNZVb9ZB+yDfR13ZRpJEkADzBSpQSzqxT7muh/C2qVUkCbbSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18092099006)(18002099003)(10086099003)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261009223027099003)(38070700021)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WR+w2cW500o2RCtkR27f8KkCj8zKE1VDJHJcTIfqBXVZ9pkicgFxPSm2ZN8K?=
 =?us-ascii?Q?+LF7dpvKy+Aey+6wptfo0U8QItG/9KWMBO9kFqusrhXySjbE22zJt3rogRmi?=
 =?us-ascii?Q?KQNd1VMu3HYIYAZq6awpWX0a30tPrCtGwYS0Eb4gTx7iK3WdnYkxANON4cA6?=
 =?us-ascii?Q?Dr1jcQHZIn0rp7Gds8IuT+20mMn3DwQInwEZUMfVglxAZzV8ozwOqyba99Ej?=
 =?us-ascii?Q?mgWjqxZHWQc0hV7mjLKtpM8WSt0aRF+gtqtSfNaH28xl75NPPIXfcTSayBui?=
 =?us-ascii?Q?QIa9psjmy1i0Lns2Xz1Da4Hwa3J5bhQMy6wyf33ly4OmQ8K82L3AXn5d4tpL?=
 =?us-ascii?Q?MKfUTuUkAhTh0cXY++wb0O3OQLj28THqBtEDz3RliYfXL3IcAmLcA58iFDZd?=
 =?us-ascii?Q?wqXLh6YqdY3wrFGTR9V4NvE53htU2TeDp3YrJ0xG9RDGI9Uhyni8F2zGwnBc?=
 =?us-ascii?Q?tf3DNsln6DGBZ8rZnoou60/YBfGbMXUZ/YbGPvNplzNe0QihPyWJkjXOQCJy?=
 =?us-ascii?Q?FD8DXQVmvc9FKFs+/8rqVuDZRe0ALYqRhPXnm7xDZQrn6fH0c05LunMjCLUo?=
 =?us-ascii?Q?qyw4rBC6zz4oTwGZOjUadZwIpTyo5DNQHNY6a12OhI9i6an8waHE1ldkF72V?=
 =?us-ascii?Q?X8N0g5cQFWsPh3eabKzlZkQe9VOqtIDDzCLHU+CXDkc8vgyIt4vvHIhgikjU?=
 =?us-ascii?Q?Z6wvW7vTsRmnKvl7+yNqzTUDvZD9wk+11qKyWKYl+T2nqWWv2/y3U5Z3IrIr?=
 =?us-ascii?Q?DWypR59psTWNQH6cJnAhKpBGS7diAEZQuxTGBK3H/dFo7aOSB3QrC/bEXRnx?=
 =?us-ascii?Q?QQKUvfCmc5VZ6DB/39/ZBL3mqkvKNPWjrZmY3LQ2Vt7fN3khBL45TOpmxcen?=
 =?us-ascii?Q?wz0KY+sPnuF17Jl+Xty90SQs8qUTR+Se7F/KAPpyBez4sMDlTer0bz5F2C4r?=
 =?us-ascii?Q?6FHm0iQF76xYaKh15LjohDZhN+ohHB192Jud0SFArGbz96Kgds0OS7OUDF+V?=
 =?us-ascii?Q?sRdbCRcGVkuQ8gRtnbO/5cE1FP4WHayC5q7Db8flVC0iavK0znJy303CzlVO?=
 =?us-ascii?Q?ONJ2z6tpryEOSeW8YAFJUNAo7/d12GEi42uLtEF0Vkn8cK54Ym4t3BDkNTt4?=
 =?us-ascii?Q?jPKJIPygh+PU8nQppVRyifVCgrmEbf1BJLUS5ND33PuP0BsuCcd+Q+nRM1Qc?=
 =?us-ascii?Q?Tc4JDLFRslvd2LhUE26x3I99GBIxwPiTU9RJmAcvjEprHkOLzYxNssa5gg0a?=
 =?us-ascii?Q?i5p0KA4N68sZtnwh918NFOGLkrP6gpO9TjcwDfKwuwg60N0RBRzcUwjNBMNi?=
 =?us-ascii?Q?h1hByIjbwoI/kj1jjG3MKw7L27c4NP81gPan9gpdsQ8NI5MYOBrxwsp5ME83?=
 =?us-ascii?Q?GtwAPAQd8myhlYvwX7pWoqUJNWH97SRs94sNZPX8KqFYfAD3Mk03HJ2dgZJm?=
 =?us-ascii?Q?zOgY3lwjt5e+fGWMDdV3KMOBYKtGJWw2D0jqFM8HaWLr9JaXCE1ZBCzbNvbi?=
 =?us-ascii?Q?bV+h5Ul1Txhix1Ct1ewY8GezULXL1Hoa/MtXInXRtL8rdBNYsP/gNWKLUwFU?=
 =?us-ascii?Q?aelBOT13voYwSgU2pNXF7XP236Ez3TouSSPnE5dYOLzWx5GHCfYTdjzREuqW?=
 =?us-ascii?Q?3WPsAhRVsKAt1ICdCjppWbNI6oDcY0LxXaSLunmES5PR82SOqgKZTxJoOElW?=
 =?us-ascii?Q?Z7N4pSe04QiBZl/XcMYutyPskElafTBqXPA10dnPCTqU7/sZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65514b71-552e-4df1-011a-08df46debb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 08:17:34.5053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6/QlcPtRRqQWPJj1dqgqs1LWUb2cdy+of82G9T0aNgignCm1lp0hCzAnZ37jRqEhM+vh0krFJQdYQAmioF5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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
> Sent: Friday, November 20, 2026 2:46 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
> DBG_TRAP_ENABLE fails
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
> > Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
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
> > A parent that ptraces its child, tries to enable debugging with dbg_fd
> > =3D -1 (-EBADF) and then detaches can still enable debugging on the
> > child with a valid fd:
> >
> >   1. ptraced, ENABLE with dbg_fd=3D-1      -> -9 (Bad file descriptor)
> >   2. ptrace detached
> >   3. not ptraced, ENABLE with valid fd  -> 0 (success)
> >
> > Clear the pointer again when enabling fails, a session that isn't
> > enabled has no debugger. Step 3 now fails with -EPERM.
> >
> > Return -EALREADY for an already enabled session before touching the
> > pointer at all: the exit of the debugger of that session looks for its
> > targets through target->debugger_process before it takes
> > target->mutex, so even a temporary change of the pointer could make it
> > skip the target and leave a dangling pointer behind.
> >
> > v2: clear the pointer instead of restoring it, no local variable and
> >     braces needed; clarify the comment (Jon)
> >
> > Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> > disable")
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 3d768511d002..9256a2468081 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -3227,6 +3227,16 @@ static int kfd_ioctl_set_debug_trap(struct file
> > *filep, struct kfd_process *p, v
> >
> >       switch (args->op) {
> >       case KFD_IOC_DBG_TRAP_ENABLE:
> > +             /*
> > +              * Don't change the debugger of an enabled session, not e=
ven
> > +              * temporarily: the exit of that debugger looks for its t=
argets
> > +              * by this pointer before it takes target->mutex.
> > +              */
> > +             if (target->debug_trap_enabled) {
> > +                     r =3D -EALREADY;
> > +                     break;
> > +             }
> > +
> >               if (target !=3D p)
> >                       target->debugger_process =3D p;
>
> Ok.  I think I see what you're saying now.
> Current debugger is exiting but hasn't detached from target.
> New debugger tries to attach and prematurely assigns target-
> >debugger_process.
> Current debugger is still exiting, doesn't find itself in target table be=
cause of
> new debugger target->debugger_process overwrite (since new debugger isn't
> holding the scru lock) and so current debugger doesn't disable target on =
exit.
> New debugger hits -EALREADY because current debugger didn't disable the
> target so debug mode is left dangling.
>
> Could we move this conditional assignment inside kfd_dbg_trap_enable afte=
r
> it sets debug_trap_enabled=3Dtrue and before it atomic counts the caller
> process (pass p as an arg -> struct kfd_process *debugger)?
>
> >
> > @@ -3236,6 +3246,9 @@ static int kfd_ioctl_set_debug_trap(struct file
> > *filep, struct kfd_process *p, v
> >                                       &args->enable.rinfo_size);
> >               if (!r)
> >                       target->exception_enable_mask =3D args-
> > >enable.exception_mask;
> > +             else
> > +                     /* A session that isn't enabled has no debugger *=
/
> > +                     target->debugger_process =3D NULL;
>
> And maybe also put the NULL assignement in kfd_dbg_trap_enable as well
> when copy_to_user fails after the conditional debugger reference decremen=
t.

Thanks Jon. I will update the v3 as suggested: kfd_dbg_trap_enable() takes =
the debugger argument and assigns target->debugger_process after setting de=
bug_trap_enabled, before incrementing the debugger's count.

On copy_to_user() failure, it clears the pointer after decrementing the cou=
nt. The extra -EALREADY check and pointer cleanup in the ioctl are no longe=
r needed

Thanks
Jesse
>
> Jon
>
> >
> >               break;
> >       case KFD_IOC_DBG_TRAP_DISABLE:
> > --
> > 2.50.1
>

