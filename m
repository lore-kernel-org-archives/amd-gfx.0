Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71620606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zIlx7Bpf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CEC10EEFA;
	Mon, 23 Nov 2026 15:08:49 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4210EEFA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 15:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HADQ8XO4iJxjjWmfVu6VYHKzEtQRWWqmHTLPsRpURHoqE1QSsRpswBaKdLS5yUFGn3b0m/RegdRxdRass+g7i7vbzicW3j0GW07qZv9BBT/+66ShQUjUosOZJSxZGema2EY/V+AufhkZfU4xCGgSpOz+aCwgsDlTP/qQob5qNUqtofkzWeCTQywZFufwsZMbqjzRr9umCuZ1GU56lbxaeH6zZd0X5itPtFdLFdKbbWlFa9W5sMhkCQBXwnj7PZmDGK+1qtZl0v+aUB+3sh1r2X5MqcAU60REpMTdTTHoibAODloOLivGjGQ708q5t+DtVhZWL52/yeN5gvGJoeAtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcIO86D1fIOmLk6FUYEBs+U/krHIV7hL3pwo8oo0Wew=;
 b=Ep3Nw/cTnOeITb3BWwtaIAQTpZsMf0SMMNViWd+mIZSwuAY0BOTYlH6HK7HyCs8UAoAfguCHeVodqTNiRd4ofcag+uQG7cavxu4qg5lG0hTKFqtGbpX3jEZiQ7NE2qRu4rgAOI0R4snHWSGbwrHgoasKK3/y2TPGL4kvA2dE+AuZPkVzeBK13UZMBU/8YRYy5z7difwPdvKxV423QuztVhaIGToqcZtIKwEBgIMh5uqou2lwNdA00XnFWK6WKrVyvSMMaLIg4R2AGULEdLuwUxD6oK7SF9b55YFWEPNHzLR64sJnDuwF5jmbG+HvnCDVvz8IYitaNZDVwSKoYuUXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcIO86D1fIOmLk6FUYEBs+U/krHIV7hL3pwo8oo0Wew=;
 b=zIlx7BpfLLP+6StwAbS9jDiub/9cAUxL2liwcM9dgZTh1Ed5bfqq5hcdDNEGFLWJoumTG0SfrV018GWc18LcyFyvh3PjW9ekSNxiBvDHjz2jwxxIPxwyUU1a1bWwYquLsNiS6X996elo9kgJ58FKUrJOnxNoUyxmiJce99SKzH0=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:08:24 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 15:08:24 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v3 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Topic: [PATCH v3 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Thread-Index: AQHdevUKL/sjG4snE0qMRX6466XK2rc7vzKA
Date: Mon, 23 Nov 2026 15:08:23 +0000
Message-ID: <DS0PR12MB639212FA5231B5B94E47089285452@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
 <20261123024737.1475714-3-Jesse.Zhang@amd.com>
In-Reply-To: <20261123024737.1475714-3-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-23T15:07:30.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|IA1PR12MB9064:EE_
x-ms-office365-filtering-correlation-id: d427e972-70d1-41fe-94cf-08df49739e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18092099006|18002099003|22082099003|10086099003|261009223027099003|3023799007|4143699003|56012099006|10067099003|11063799006|5023799004|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: 5EIdTwJn1ZKl33cBgk7sqkqT9Ddt2yAH8MiaOo7ohRo1CwWTWWvHjAfNfwYWuCbY6aHetCGzWUVdnJsMhNEkiMQjcjWJCNGd8K7pqukXs8bG81jNroGe7a0qsEnXlbNYP4lwfUCWPIjMa6qLLXAoAUTtOzZuKkt6RfIlz/sWwMPNQWyUVEps1OBfZBGRZNNQpcBRqhSuc2UJo/Ws5rS6H17Zgfcpdl1iQGSznXMkO5uy1WzMREdh/zOOr6qZ6JUgNBLNGd+5KCa0r2TsGA6ci1cFTYwwzLKTbRTB4eT6LiXsNh7svsyqz3CtMvg6EV8iouiV66hHUDaMSohnpMRIICXo5roF9bHnzMhHVyjHVgixVP+ZBGXHaGBJE//MXaX8ytX2zwCIyGYpHP2UR/JLPSqsI077AuiKclKcGvSxXV9k7YJ0fyY6kT8+ZGIhtcoa2IWR7SAAOHcfF2DWFpd/kKrjMM+ohUKc3ZaPZZHhaI/5ygnmgLZnu4h+885YmRr/7bcuDvlnhEZ4BOPAPn+MihXvgqJt8yU8GojjtXOD1sAU9MheO/pQYJDHUbZygkCPzmT/Paoy7zDtuLna7f+ECC/UxOt40Y48Xis3AbBpXgi8saHC9iqG3AG7jRuSVtGVFI0NaNLWHWPGLPmdLBeqsN3mweF79Kl1X83YfQP9QXHGtlid+PmMaAl4lXcSJFqJmFA79jgiPg926c7mb0G6tqZK/vs3l/HOy+2VxfHwrCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18092099006)(18002099003)(22082099003)(10086099003)(261009223027099003)(3023799007)(4143699003)(56012099006)(10067099003)(11063799006)(5023799004)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hiqZN+1sXCTGmgEtakgt92fVOg536R2KmfHANs1JMLofpPLy1uucD4IzOrOF?=
 =?us-ascii?Q?kuTfZ+xCPg7CHKqXn2S/CLYpi9N5f8NI60O1XWUIg3HQM6jwsl7/dFdq7FeL?=
 =?us-ascii?Q?aRk3F0mZRTkiU4XcEi04RAlsmmGtdzk1v8zVqKVevciwV+eurNauhSIND0/e?=
 =?us-ascii?Q?zqiM8jAs/rknS3TNFsubCsy0al4VdAoQoxhFFdW0S9ZIxZHOfrFHWBme+hoM?=
 =?us-ascii?Q?5CWtXP119KEKFMHDyUDVRL9iqHRGh2jG8FsDR+LyLw8e8d7gToyMzxArOB6W?=
 =?us-ascii?Q?W8/HBMFBpU4KbH0QsY1yzXPQ/hEE0K9pBpBTrPSAHlRhJx1Cj5rUZCTmWR1f?=
 =?us-ascii?Q?jcGUZtzeet0Qsu3QfSw7Atf0st0IP09kttnvfI7uqGm3wmlTho3+stPPvNT4?=
 =?us-ascii?Q?IIZ1//oWFJ7cYwHwiMes9O+gBOvsF4mHH6BlG8kqf7E9SUc1vTX5OyfJr0qi?=
 =?us-ascii?Q?grgD1Wgy1Ae7lyNbUpwJqU6SPtcsHkB2j5Q7SFRk03jAG615DITpWMFFMMFd?=
 =?us-ascii?Q?/HGFzl1CngeOHwdlLLZDpED7TfKcZbDLwbuxe7NijxpLlWRzd9/EKrWDPOdp?=
 =?us-ascii?Q?g7ccl8zxSo6AxaRFxKxAP4f7gp+q9//YbJElqtzbAOrOuctqeeIhCPXYeUCz?=
 =?us-ascii?Q?8OtYPLDNf+KyArAeEBqzyYX1RhzHfxdku2T8U5lADgY192upIi3hmEjcx+36?=
 =?us-ascii?Q?05Ukxqp07R7axQsiTiEmOzZlRCMJKxNNPl18wvaYqvsS8M1m/Drfp+bg4Na6?=
 =?us-ascii?Q?4XQEH408gNHA3KH+xIpGonri+GLV5oDAR+O6GO1KqbKVy5YAoN5EacTPqlb9?=
 =?us-ascii?Q?tYzvvgnop/trh15gSQWWpv66KSuMFblwImvpTBtl4TsuP1HP4/9QGxSattck?=
 =?us-ascii?Q?AsZ7UwL+hZUkPevZx8Jhn3qf6jXx2zI3JSWl6jY98nzR/qD6FV1gH/p0m2hq?=
 =?us-ascii?Q?54P7Q0JJLQoBGC4rpSo1DZsTn3EYphNZw1w71NJlifAX6slOjteq7rvs7j1+?=
 =?us-ascii?Q?DyL0djBMGWu9ke2E06XtXrv3zsVdNsNQWUuLMc6kO7DRnWr8ab0F+tinP01X?=
 =?us-ascii?Q?6wCrfGTfIwv46REA3yN/jc5h+gjJtau/Wea3wFsdEUEwNQSHY5GhpHilP+p0?=
 =?us-ascii?Q?eEkAOFAFE8YblQLTpGpvA+oZcd6wLc+1QwaFJTos9yU/32To25hw6tyydAAk?=
 =?us-ascii?Q?twugpFHZRH8tsw7HqtR5BST8wOwEWv1uhZuTJIpV5A7ukDzT7U3ORIKLM392?=
 =?us-ascii?Q?J4J/PilhJcDIa/UOS5vGIz+Px54TZCyZxaDa0RBqpKAU2IPeR02ZbniYHITN?=
 =?us-ascii?Q?1e8FBeFx0Wj44F9jr/m1TnoKFAV2/Wl1GFOXjI21Yft6TUxBY0UK12y+C2MD?=
 =?us-ascii?Q?2jRQjQWZtGrjuyXwwZFbOvsxR2ipSS2gYM2LR4nIV+Def7g77EwerQPeStmd?=
 =?us-ascii?Q?6SMluhtyXro660AT6+pdMizOQ7vNyf4ED2pEr7p2PWE+W1JmbN3qPLLDSaqe?=
 =?us-ascii?Q?NSg8DnXYPLcqbhN9eMwuYNeNLVpq2fvVddaa/S9nR+msF+OdNQiYJABT+o9W?=
 =?us-ascii?Q?C+hiiPzrQLP2EzN8KnUHc9hk1n9ILGXoVKIrHGkOkm2tuEr5DivOiSH6fGjD?=
 =?us-ascii?Q?dHyOLRZwD3ie4Pz7nqi3JeUIgUH5wlBpPzV7dPURT73crMVsHyf7mPsEvMR7?=
 =?us-ascii?Q?KgloNpqJh8fljWQ3mS3SJSbe3zRbHY0ZTRqwL2oM7kJw01EV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d427e972-70d1-41fe-94cf-08df49739e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 15:08:23.9541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5L0L2Mn5s22XRBH5k3+oCV0VN2tDHVthv8sx1CmjQ9Z9CjoE3aQrfCe6w7c9z9iw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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
> Sent: Sunday, November 22, 2026 9:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v3 3/3] drm/amdkfd: don't keep the debugger pointer when
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
> An ENABLE of an already enabled session also overwrites the pointer
> temporarily, so the exit of the debugger of that session, which looks
> for its targets by this pointer before taking target->mutex, can miss
> the target and leave its debug mode enabled.
>
> Set the pointer in kfd_dbg_trap_enable() only once the session is
> enabled, and clear it again when copying the runtime info fails. Step 3
> now fails with -EPERM.
>
> v2: clear the pointer instead of restoring it (Jon)
> v3: set the pointer in kfd_dbg_trap_enable() (Jon)
>
> Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> disable")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +----
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 7 +++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h   | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..5785cb8b4393 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3227,10 +3227,7 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep,
> struct kfd_process *p, v
>
>       switch (args->op) {
>       case KFD_IOC_DBG_TRAP_ENABLE:
> -             if (target !=3D p)
> -                     target->debugger_process =3D p;
> -
> -             r =3D kfd_dbg_trap_enable(target,
> +             r =3D kfd_dbg_trap_enable(target, p,
>                                       args->enable.dbg_fd,
>                                       (void __user *)args->enable.rinfo_p=
tr,
>                                       &args->enable.rinfo_size);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 14e7ee30cbdf..f7d5dc90f8e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -781,8 +781,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>       return r;
>  }
>
> -int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
> -                     void __user *runtime_info, uint32_t *runtime_size)
> +int kfd_dbg_trap_enable(struct kfd_process *target, struct kfd_process
> *debugger,
> +                     uint32_t fd, void __user *runtime_info, uint32_t
> *runtime_size)
>  {
>       struct file *f;
>       uint32_t copy_size;
> @@ -823,6 +823,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target,
> uint32_t fd,
>       kref_get(&target->ref);
>       target->debug_trap_enabled =3D true;
>
> +     if (target !=3D debugger)
> +             target->debugger_process =3D debugger;
>       if (target->debugger_process)

We can probably get rid of this test and tuck the atomic_inc under the targ=
et !=3D debugger test after debugger_process has been assigned, as create_p=
rocess will assign debugger_process as NULL by default.

With that fixed this patch is Reviewed-by: Jonathan Kim <Jonathan.kim@amd.c=
om>

Jon

>               atomic_inc(&target->debugger_process-
> >debugged_process_count);
>
> @@ -832,6 +834,7 @@ int kfd_dbg_trap_enable(struct kfd_process *target,
> uint32_t fd,
>               target->dbg_ev_file =3D NULL;
>               if (target->debugger_process)
>                       atomic_dec(&target->debugger_process-
> >debugged_process_count);
> +             target->debugger_process =3D NULL;
>               target->debug_trap_enabled =3D false;
>               kfd_unref_process(target);
>               r =3D -EFAULT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 5babf9b992cd..f675fe6ed353 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -44,8 +44,8 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
>                       void *exception_data,
>                       size_t exception_data_size);
>  int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs);
> -int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
> -                     void __user *runtime_info,
> +int kfd_dbg_trap_enable(struct kfd_process *target, struct kfd_process
> *debugger,
> +                     uint32_t fd, void __user *runtime_info,
>                       uint32_t *runtime_info_size);
>  int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>                                       uint32_t trap_override,
> --
> 2.50.1

