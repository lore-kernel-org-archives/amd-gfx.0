Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC475606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FaA8GVW7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F78B10E14D;
	Wed, 18 Nov 2026 21:54:50 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E89410E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 21:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWIqCgJqIcda98EczMM3nlTVgco5oM/TWsUDhwn6ffm5t7GElJckUpBVujY2clzVYUEzvBWSChvyJpj3FiTWCw++nDKDMm0l4gh+JymmTeo3FT2hVwaNtF2YNj+SOi4p2LVW29NY0Jg5GIg7oGrUqGJpzcbM1YsZISpaIf2UrnrVMjjjAa+4pAzhrrBChnk4rDgwI1/XP3n2Bj5JmzaSO4QBNOvKwTqY9kQ5B7Ekm7PzlVW2Z7vESy5EzhgL7yd/x13hLRPUjEsSHShdtvYdC6nWhzpA0ysXHRwicp2/AReyc1XW+0f3O/fh3ajnnfQHD6c3avtUWijGTbVCxExp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6AjCN78yCCJrnm5HoFLt6f8eGjTXLSQRck0K9wXnkE=;
 b=H18F1WCxP3f54m4oayQdSg/e2FBB7F3lh4/SB9/5K4xVThN+A+7DYJMrpuo7zDAdYNq6G4NRLSYkRmIgIakrVkQmPnjYJxXONzIMAyVQzirwhzc+hhOpe2Tb4nOTU31usD3mUX5ibtNz2mOZx5sud2N71Yit3PfFzGY+brDxp8vkBy7Liv7HD3Ca4tAZU92kQaJf1ndG+puTue8e4NdBEe5Qnl9xv6WeivxSUwezrrQAtvqQNQ+rR1cQEf+p1VxS/dm/GgtwUtjCTalkPiccqwjHcvO3dAcDl6Hn8cfBdjYrMeArcxRSR/7mC2I0VPek7HLRIbDx06ozgLwwx6zSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6AjCN78yCCJrnm5HoFLt6f8eGjTXLSQRck0K9wXnkE=;
 b=FaA8GVW7Q0v/IRIPnunj7pSTHV7JHZof7ken8sEW7AJ1cvmGnAx1RqQgNk4v8093tjEl2EDj0G/hBrUlS8qG/wnP+imZNTc2VyIh9neEwCFMPI3HI7/i84X/COpTD1c0iBBW+MjerW+qTEKg6BCThMzOMcw2ZPAmJT3aHU9MEkU=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 CH9PR12MB167381.namprd12.prod.outlook.com (2603:10b6:610:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:54:38 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:54:38 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Topic: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Index: AQHddyC2HnKnXrqJBkyypo9es89fyrc0Wn7w
Date: Wed, 18 Nov 2026 21:54:38 +0000
Message-ID: <DS0PR12MB63924BF666B4F1A9B4ABB18A857A2@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
 <20261118055009.3005630-3-Jesse.Zhang@amd.com>
In-Reply-To: <20261118055009.3005630-3-Jesse.Zhang@amd.com>
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
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|CH9PR12MB167381:EE_
x-ms-office365-filtering-correlation-id: 33c2fa52-5467-4ade-ca1b-08df45be8abb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|5023799004|11063799006|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003;
x-microsoft-antispam-message-info: 3Xi8Ic/Gc09AwdQpVw6+aL6gBbmYiCdARYIRdWjhl0oXwcsxJK4C+OQfolcSYwfnQw/0cHV3oXbcpYi/y3nS8Cp9MpZtWtOz7f3pRRYxjiNo9AeuolPH+f2JObcbnH5zOva3Fm6T/O3b1jE8Mfcf6/JCRW6vgHJdT/i4PymTPmrgrB/SeODuCXbzpnB/0YqXef05wLIWNfKJkgDpY/nveNZQ6lvfsFUq2Ame/3uaDAI8y8LiZCZkvUkZB32ACrOIQafyX/HJOq+JMqwQxtDfvlZrQe0J/0u+WhBr87WihdE4GLJZ2gD42NUL6P8uN43kTKaISQN7I7EgbBCqbQguhbBGP2pt7AZUl9q4GRXPzs90y7ilUyRQPs4XvFvKCQar5KMJCRgXP6OthQ1YpIO2RHJpmGyjVM4q3of7DxcQ5fgjqXdUvCcqXrtBnIdvZtQUwUDbAUJJEcIx6L/V1xo5u7+TjoKw/3Yn3OJyN6N/g5fM7QCrxv8d8rWTEXwlp1s1ayp8ffbRol3Vlbs4wjWs0gN0YWjgUT7YVQLCV3P3zT4GBHQYGnmIzkhAoW7qU0SqI15V2HeAXA7ahhZ6OQUw0zhZI2cpRf0wRf1peZuiWgyTxZJryqWex4+xUCMHvRFJ/cYgw+aeobr5YdunO8raeoR99nyu3cNvQuKcbGl10gy2tN0RzJAXzWLiokLRs9PFSHASvLKkAzftn5BAdXFooA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Mbpn4fVKy3Ba2wnE6axngy1frknh0/mu26UB12rDl/gw1Z9IJ8BLaSMdd0I?=
 =?us-ascii?Q?cGuUkPxV6OeLCHsU8KPq+BaEvcxnEwmYWCXFzRgjVuPVKTtOeSg+xb+keIga?=
 =?us-ascii?Q?wGv2zh3pRR+kg6oLZ8Dhjh7flvrmkRWPs6s5SrSTikn27vc0KtzQW6Vk61t2?=
 =?us-ascii?Q?9NXGZ6G5XlxqdeEujXmLDNHJW6hxWJfgs+ZAilLq6LzPv8FZjiFhCv3I5yr0?=
 =?us-ascii?Q?h9HAOIOLWsIEmJ9eDZdIew3Ia5lwPepJN0D+sywx8+1Y2PmSgDwb3ldJSz94?=
 =?us-ascii?Q?FSMo8l8sB5qQnZ9bQ9q6wxOSqAdMNsOxdlDSslUpcHo94IIfPFDD3ZkeDnMy?=
 =?us-ascii?Q?IOfuGBvQSb32e0JfIHFFovMAmH4xEDgVqoTmDnMQmLGSMy4Zf0UIZMUxWsXF?=
 =?us-ascii?Q?R3T9ifxx04XEix5Sf8qqY1i6W+Ta9AOCwGWhCL+LLGGutEwjiHlYRhxnDK4v?=
 =?us-ascii?Q?c8JtH5KIRGOjd13UnIIM/lfbiyCUv4X51/EibL6E8Ryu3SlsenlAtzagkAbS?=
 =?us-ascii?Q?17MBIAuhGgHWvU/JStfh8P7w6IE35Trnbd30rd6DXbgmLM85tGiQckfKYvqy?=
 =?us-ascii?Q?kmFkgnd6Qbzx/BUqXFAxLTdwL3F/3rsP3GC860LiTsRz4Xqqwddw7PCHJycB?=
 =?us-ascii?Q?xFNfngmGpRwkj6XGGd9RcODB4a/24PUzWcWTG6lKyqmy+CWSBM/X1XKR3A0H?=
 =?us-ascii?Q?dDk1UqqkPoDsKckhlk3Hoo6xkL9e6XhscmHFXOLfSF01UMc6Wk2TR9wcsLKO?=
 =?us-ascii?Q?MN5J56E6NotfFj5HcTarRnixF5FiaeEFhl1QA5JduD0Whyr25Bzji/oPPm9r?=
 =?us-ascii?Q?/0G3ywFHuNHlYbktptuRkLzzOfUBxpEetyFEbTdlSPCJtKjlwUQYEMdEnsDY?=
 =?us-ascii?Q?nNuEDcIDvCxHaq4e6pSWOOHbpAfkwd5LwLIEcX2ZbaNvaQ2YAV2k4JNUtPL/?=
 =?us-ascii?Q?b0DXOI8CyvkxlTZ2mF3xHwpr6f4KYRa+jeNzMgBRDVDHkmdvurGTSAt9JRe4?=
 =?us-ascii?Q?OD5Oc6TbpfiUxN3ioodlTTmqoqeaa7CWZUxi9dHqGuADffriVz803Q2+E6Fq?=
 =?us-ascii?Q?z5ZhhI9Pk9dtU54hNOG3LGJIxS+mVgBRi9H/R7idCsvWbpk31sv2cGz/5Cl6?=
 =?us-ascii?Q?RhJWr7SANUdHfxpiW08++Gb4ubR0Weh67fcscJYFDCghto7t9A2GdfLUn3RA?=
 =?us-ascii?Q?xuF5qGESuw7H72/RplAhmvM9rZDv54hcgYuyEYTQ59IP+ABvq9il+eCjjpYh?=
 =?us-ascii?Q?OuYQGQeJEpMsgzg1wxsnCGXOQDlbrkYSzCp3BcAxZjw2YSCHaMeTQOZEJBZC?=
 =?us-ascii?Q?nsVRi5eDw/CisLfZJXHWvebEoVZ+AynfSIqu3rk2Mo62sTRtzDobEpEbf/Xj?=
 =?us-ascii?Q?yCicgsyQF06QDb7omo7e1bDrRHryGCgTCb9Fgt0dePoz8Z7Pu/pWubJ9yO/R?=
 =?us-ascii?Q?uRaiqosxP+KKRh3oRpTC55N/Bg1KxYPzwh2jKO5Zfhq6VtQ7ziCbLqUaheI3?=
 =?us-ascii?Q?R0vFT+TlGhEU3FfCwZjWNUCJX3aunbm0b17Wsk5qTAF8KiPz+onfeqgc1sy0?=
 =?us-ascii?Q?aXXYIQeR2w+phjUqLoJSOFhDl+4I59iGrvAZ4S2CTFSsmF2ILuNJ6F1Z823V?=
 =?us-ascii?Q?y5ISCuh9VgaQuoXt1KhrV+eJM8AQrNTSax8yIpfRENIwjBlc55NB+qTnjrjb?=
 =?us-ascii?Q?llNcq0DwPGVVF8H+7l5jBnJij8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c2fa52-5467-4ade-ca1b-08df45be8abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 21:54:38.2803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtNYV3WeN60DnLZ1INQS+Fq2RTnFH2h7LiQEU4sJLRD8XYHXeEH3HoEJvdIdKnOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB167381
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
> Subject: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
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
> On navi31, a parent that ptraces its child, tries to enable debugging
> with dbg_fd =3D -1 (-EBADF) and then detaches can still enable debugging
> on the child with a valid fd:
>
>   1. ptraced, ENABLE with dbg_fd=3D-1      -> -9 (Bad file descriptor)
>   2. ptrace detached
>   3. not ptraced, ENABLE with valid fd  -> 0 (success)
>
> Restore the previous debugger when enabling fails. Step 3 now fails with
> -EPERM.
>
> Return -EALREADY for an already enabled session before touching the
> pointer at all: the exit cleanup of the current debugger looks for its
> targets through target->debugger_process without holding
> target->mutex, so even a temporary change of the pointer could make it
> skip the target and leave a dangling pointer behind.
>
> Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> disable")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..c42c30b459a3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3226,7 +3226,19 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep,
> struct kfd_process *p, v
>       }
>
>       switch (args->op) {
> -     case KFD_IOC_DBG_TRAP_ENABLE:
> +     case KFD_IOC_DBG_TRAP_ENABLE: {

Any reason for the brace?

> +             struct kfd_process *old_debugger =3D target->debugger_proce=
ss;
> +
> +             /*
> +              * Don't touch the debugger of a session that is already en=
abled,
> +              * not even temporarily: its exit cleanup looks the pointer=
 up
> +              * without target->mutex.
> +              */

I'm not sure what you mean by this.  Did you mean the mutex of the caller p=
rocess instead of target to avoid a race during process release?
We should probably hold the mutex for the process if process !=3D target he=
re and drop the condition below.
That way either only enable or release can happen (but not both at the same=
 time) and a bad return of kfd_dbg_trap_enable (including -EALREADY) will c=
leanup properly with your change below.

> +             if (target->debug_trap_enabled) {
> +                     r =3D -EALREADY;
> +                     break;
> +             }
> +
>               if (target !=3D p)
>                       target->debugger_process =3D p;
>
> @@ -3236,8 +3248,12 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep,
> struct kfd_process *p, v
>                                       &args->enable.rinfo_size);
>               if (!r)
>                       target->exception_enable_mask =3D args-
> >enable.exception_mask;
> +             else
> +                     /* the debugger check above trusts this pointer */
> +                     target->debugger_process =3D old_debugger;

This probably only works if you hold the process mutex if process !=3D targ=
et during enable to avoid race with process release.

Jon

>
>               break;
> +     }
>       case KFD_IOC_DBG_TRAP_DISABLE:
>               r =3D kfd_dbg_trap_disable(target, true);
>               break;
> --
> 2.50.1

