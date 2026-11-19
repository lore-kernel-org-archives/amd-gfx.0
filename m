Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F9606A325
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CNjhzG7a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBC910E285;
	Thu, 19 Nov 2026 18:46:32 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C9010E285
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 18:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3BCHswDDt45XLcV52XoaIUZElsl+fx+A2CD2cIzyfje7MQLLtGWO5kyPPdRaFw/GR6elVqnqMI0Uk/fFUEBTFS+VfavkslihhClvKhWcPXfew1qUSydxvfzEVq0JX2DDStTDP930cbgmrfqZd6OLjxGw8UjeNd0DkanqT1smgGvz0t+UkMxTmOn183vquT3VJIMrOqzkQ47mfbFdTcM3fl7VAxEZGA6+UVlf1uiZ3OIcg8q8Rhb/9C3En+UARhbVy3BLZ5ImjzfTOEXv0DeLKr6I8BFgeRy1qIsfudkzuFBCWjueRIUsQgDvyqr+nc4q/4Xy++Td+TP6DAl7Gcodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2oxPY4H2maBbkptTeIfkhV9ieO/b5Gx7z47mFvHke8=;
 b=Wjec+VbN8/NGSKOiG78rk8TfQhcWWI+UoaIeO/rFTSfhLc9JSlJ9Kc6AnoHNX3xgj4IXiM9AAkCbqIC30rmPRLz9WkQWDCMENunUPzjSwsMA4vunarLi5IjpyorjgCh+YS99GRdmQ92FwROC0oefIrRZuxCxq0URNwQp9NXnhRt3GGZ/npUHpgfWG3HNp1zOGsq68mHRKmo/zyke0xSCNp3Kz9jKicUsf4+ug2rHQQMKYDxBUKjhuo9dLLTXtf/eZDEy9joJAIH5wsG4xvP3IOVOwaRPlSuhrjxepzYPx9LT0xErT2A2/yMs1M44kaxx4NUaGDx+CUx7tQUnkHK6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2oxPY4H2maBbkptTeIfkhV9ieO/b5Gx7z47mFvHke8=;
 b=CNjhzG7aiN1haYJAcW6NADKtPomMANPX+WYgVlguV2oKTElWAr0k5FIXoq/U0KC5AswPAY7WDgjP48GhG0g2GdW7Zg8q70uEXLRT7GJEjn0Zu8xZISXNggp1pzNygD1IE3lRWv6sliQBlNPfI4MfTtA7IFbcHtMtgOP9q7eJFAs=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 18:46:20 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:46:20 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Topic: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Index: AQHdeAU/UIvkFWHOw0u/VMjezXPVQbc1tP+Q
Date: Thu, 19 Nov 2026 18:46:20 +0000
Message-ID: <DS0PR12MB6392ECD4A8FEB76310E71BBD85792@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
 <20261119090557.3494649-3-Jesse.Zhang@amd.com>
In-Reply-To: <20261119090557.3494649-3-Jesse.Zhang@amd.com>
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
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|IA1PR12MB8262:EE_
x-ms-office365-filtering-correlation-id: c1758340-fd47-4a7b-3467-08df466d6739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18092099006|10086099003|18002099003|22082099003|4143699003|56012099006|11063799006|261026140227099003|5023799004|261026121527099003|261022105027099003|10067099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: AkYOc134xwrLMLnBN4m6yJrYC+RgSQXgL+Op41I/Xnzx2AOD56agGmKfZfsJOlTpu0HD9XAGOCECMADJY1ADnE349VZkYov3nMT+EP0Vzv2zWP836zSoF3WSjQviqGhuk8eFV8T6/PEEoLKrda1vPA1FuqNEeQDz9hgwVUeQ07TsTZiWUZN3I4y1Oirdhv10/WY/A2zuubpLDqwazadp09ddz9iMbJjt5ol6XONIO3IwBhIhafVQl5LcENUzkK113zc8bNiDucd73o1r6S6CVAo9bqkFbjbfQsQP257hMoowLM19rm4E3MPA4LXB7Z7msJ533uAsjBlzXUZVZIW73/F9tU+XlnictwDZVCqFzsFQnaJnTAffJHCIk8nmD6wX/IAj/bnjaZtqAyuVnb22tYmTRiT1eWwcFMworjrG80RIeIlSCJ9sYi5oC8GuuoOSlvxLSa4LTSRBVaqGo7hC6vVOYq5VvMI7pbXIqEx6FZxaktjDQM4ysCtxpThmjG0VP7U0usEzZpsFQUL39PjAurartpKCWOrArexTF2p2+ZnXKQuYJfrLGheULU2EYypLJ+oHbP4KTOk2DRr/eLENfx4ug9uV2Cb2NVY4/e6vUW2Eipjr66tdLRx6bTumCIWAoffCrx/lrcC14/2pgvf1Mp6V+OgmgbpsEcx9olv/78rBKujxCMXzRZdLM/AtP8yu+aoohszO7UNtyxlxK/aQxMFMHd4QzCb7Nvh37t4GZ1o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18092099006)(10086099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(5023799004)(261026121527099003)(261022105027099003)(10067099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?au7RwHOxq8oNBH5CrFiy37viCR9Qb7+TvKYNUvetaNgeyaSDhZlXOc/6fZ2z?=
 =?us-ascii?Q?vXdI3pI3SGq1AbQN5aEj1x+lv2gIX4YI6t3TXLrrjI26bdNupmSZbCgu+2bJ?=
 =?us-ascii?Q?YJphH84SKy0b02lklKp47Me8ieUP6Tl712IB06uXC0BsT2B3vhA0hdCGZn5i?=
 =?us-ascii?Q?3oOdvp991RIzA8NezX12dl/odoLu4VnxtU58bFp93kpB6r3Bry10CNB8w9+/?=
 =?us-ascii?Q?uRnBtZNGPoJbhtEKAywiva1dz2NB/MiqqIwpxiwGuI9naLvi6yj3oI95W++5?=
 =?us-ascii?Q?R2vXQN+XfnB6jLR/fzLTl641nQBhnqiH3HC+IZkmxI3DTL88CcIQLFNpe3O4?=
 =?us-ascii?Q?TQdkKlvVKryOFRbqwyOL55zC+jOSrSmYId6gwy3SaMEt19JO48Db7ndD3Qvl?=
 =?us-ascii?Q?Zytqw0Zu+siT82loipFil0XcWe7+Z3Kb7DHKL35U/cxSflmmePU39A84Uln6?=
 =?us-ascii?Q?4SWE/Q8+WHqXFnlg0OQmnWMpngMZdGXLvQLRwVP/44oAenZedQUP5E5HCWeZ?=
 =?us-ascii?Q?sPg3BLS2n6Nk6eVeNz+80q8NZRn64YQDXiPASd1z1JcyUvvPMiolhD7wUknI?=
 =?us-ascii?Q?PFONhHMMr37dPyUQ6v2pvIZ7sjLEAJdQALoSZt6kYuTJKfzEcOz9cGUn8K1+?=
 =?us-ascii?Q?eeAL+zeCSyVFhhgAZ5EjXSPniS6XPFSpxfkUc5k7qiFRIA/TskqUG3sHfVGm?=
 =?us-ascii?Q?PCsUCg74Rhf9/xzDn1oOeuFFx598qjQZVt0gSTreiis2adp5DOd4D1hZEcu1?=
 =?us-ascii?Q?HqHAyF0T9rQ1sKi3fIWVWRCgKXTcSDGF/I0S99TRXUYg4qyDGta2QuCCqbj1?=
 =?us-ascii?Q?hMaXbkKiqjDczCbGtwT24ZWhYJtTER13+h3J5RkR8sz0r/RCU/tcLSwa+IdB?=
 =?us-ascii?Q?2ugQDcKi4/yk5XnvyQwNc0Um/b1Q9kLw3Ah43FqAn8DPIzonkj0vOloEbdB7?=
 =?us-ascii?Q?OjJXf/nGxQU4wITy9hk7uGXZ8W/2OOlQ1sACwi/s22xcnIc1RUdPo3Qk0Frc?=
 =?us-ascii?Q?N5T0LH1X/1TZ6viTBPhUATL/yELhPti8D1PRC3zpTx9ngUurRBLGuFa0wP6N?=
 =?us-ascii?Q?SzqAg3LoLZiBxfT2FKVSoswA0QAAgIQB0a09PGC89P4m+0iBGy7ek4dhf6oj?=
 =?us-ascii?Q?cPtbVvdaWXQmrJzGExXHU6yTDDJBU+Yb5T0gXuKrzBUpHZK/HrFpGgHZuMvv?=
 =?us-ascii?Q?mADLr7BziyPquKSTJVWpSrhIaTtv2GxnueehQt2jcYot3n4WeRknAyChF7pJ?=
 =?us-ascii?Q?YHEyg00PpZmPwmUB0Dj1cP/+gJvrmZoTVuI6heyPO3ah2YbU7g/GGh3d06Og?=
 =?us-ascii?Q?wKjtxUUe/W2P5BkqRhAnVHXCRqHbk4AawMD8op+u/cBTL6WxnGvxp5S/jVcJ?=
 =?us-ascii?Q?0U8AxBdichHaLJLk97uaZy3Rhcs6JSKiwOtvpScQO8C8oe+tmC279JiyqDVE?=
 =?us-ascii?Q?57vjkEQ6M+d0VBgNUv2VluSKAUCZ34KYCpYDbhmww6UywHi25YCA8m/25f3/?=
 =?us-ascii?Q?XBQfQGjWztxHCWvtl702cHETWUCj4nVpjC55QUzI+30Ee/QUasCazI5MkQBX?=
 =?us-ascii?Q?A6SXFyj64jo48cIqMLg4sROAupYGqwJeXlms2J8Dfn565ZMF1eUId4hzZhFG?=
 =?us-ascii?Q?4hk6aqBD/H8viq3Ea9HWksrOe0SybP2nWFERMeRdy1bR/uVElM+M4ArwbJN+?=
 =?us-ascii?Q?risqje/sEHMSDb0ECvDH7VGQBXLcywbeDcyNoRBmTDDoTdql?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1758340-fd47-4a7b-3467-08df466d6739
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 18:46:20.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmAkVcwQ9uqnFRB/otEwDVF3CiWOOBBE84qccLL4UUBoysqdzczeuSFlaEDZP8cC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
> DBG_TRAP_ENABLE fails
>
> KFD_IOC_DBG_TRAP_ENABLE stores the caller in target->debugger_process
> before calling kfd_dbg_trap_enable(), and nothing resets it when that
> fails (-EALREADY, -ENODEV, -EBUSY, -EBADF for a bad dbg_fd, -EFAULT).
> The permission check at the top of kfd_ioctl_set_debug_trap() accepts
> any caller equal to target->debugger_process, so the caller keeps
> debug access after it stopped ptracing the target. The pointer is also
> not reference counted, so it dangles once the caller exits, and a later
> successful ENABLE by the target itself increments
> debugged_process_count of the freed process.
>
> A parent that ptraces its child, tries to enable debugging with
> dbg_fd =3D -1 (-EBADF) and then detaches can still enable debugging on
> the child with a valid fd:
>
>   1. ptraced, ENABLE with dbg_fd=3D-1      -> -9 (Bad file descriptor)
>   2. ptrace detached
>   3. not ptraced, ENABLE with valid fd  -> 0 (success)
>
> Clear the pointer again when enabling fails, a session that isn't
> enabled has no debugger. Step 3 now fails with -EPERM.
>
> Return -EALREADY for an already enabled session before touching the
> pointer at all: the exit of the debugger of that session looks for its
> targets through target->debugger_process before it takes
> target->mutex, so even a temporary change of the pointer could make it
> skip the target and leave a dangling pointer behind.
>
> v2: clear the pointer instead of restoring it, no local variable and
>     braces needed; clarify the comment (Jon)
>
> Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> disable")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d768511d002..9256a2468081 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3227,6 +3227,16 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep,
> struct kfd_process *p, v
>
>       switch (args->op) {
>       case KFD_IOC_DBG_TRAP_ENABLE:
> +             /*
> +              * Don't change the debugger of an enabled session, not eve=
n
> +              * temporarily: the exit of that debugger looks for its tar=
gets
> +              * by this pointer before it takes target->mutex.
> +              */
> +             if (target->debug_trap_enabled) {
> +                     r =3D -EALREADY;
> +                     break;
> +             }
> +
>               if (target !=3D p)
>                       target->debugger_process =3D p;

Ok.  I think I see what you're saying now.
Current debugger is exiting but hasn't detached from target.
New debugger tries to attach and prematurely assigns target->debugger_proce=
ss.
Current debugger is still exiting, doesn't find itself in target table beca=
use of new debugger target->debugger_process overwrite (since new debugger =
isn't holding the scru lock) and so current debugger doesn't disable target=
 on exit.
New debugger hits -EALREADY because current debugger didn't disable the tar=
get so debug mode is left dangling.

Could we move this conditional assignment inside kfd_dbg_trap_enable after =
it sets debug_trap_enabled=3Dtrue and before it atomic counts the caller pr=
ocess (pass p as an arg -> struct kfd_process *debugger)?

>
> @@ -3236,6 +3246,9 @@ static int kfd_ioctl_set_debug_trap(struct file *fi=
lep,
> struct kfd_process *p, v
>                                       &args->enable.rinfo_size);
>               if (!r)
>                       target->exception_enable_mask =3D args-
> >enable.exception_mask;
> +             else
> +                     /* A session that isn't enabled has no debugger */
> +                     target->debugger_process =3D NULL;

And maybe also put the NULL assignement in kfd_dbg_trap_enable as well when=
 copy_to_user fails after the conditional debugger reference decrement.

Jon

>
>               break;
>       case KFD_IOC_DBG_TRAP_DISABLE:
> --
> 2.50.1

