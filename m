Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2A4C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 10:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC7310EA8F;
	Thu, 27 Feb 2025 10:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/i5Az+d";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E836310EA8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 10:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2cs/Gnd4y3M0BHOxTdbaTjYzvEz4AZIonPre//s+wcqNM+9eXbzFQY0Qgfj46hFI1EmSlOx/U0I2T8cmEKI74Ou8YTqR9wcRAZe4N9DvBXN7QwK42g+dX5/hQaPmNXQkRIojmKzbvrxRksA9UUDo0My72tv1V1/IbeqWs4i9UoxwHBh7PUUVVpPIWMU6cJTZX7I96idY1jNdsg22F02lM/2Pa6bGnX8elrgOVgXjVdfSqn1iTYXkYqW1OPbXwYhJMbhLE7vtUhq2N6cqPJ1JD6b8TkzWnIU1lKJ5XUafavqyV4lP/3a96ltg5Ed8o8SF6DAImoSQDdOQ8MohhLEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHNCy0s/tD/dnQ2kcHhAwxsAVZUIU7QSYgcLsu/7vWI=;
 b=pjzwCAiva9P7xso/HSLl7UmLjXc52mWlBytwAjbWBhyQGd+slua7ulTZlP6wTC/titiEI2ZSXldcV9vK23DHFkPfIHPzaRIIlnRswnkZ1152du4vuqPTWUXV9sKB/QnR0+TUpmCForlU8BwIkOWRT4Nbw/94j7Lq50ra1Uzf5eJkCUe/DU7/Az3yVF7CbHYfs0FBq1ofjZPCqi0D+0/4Z0FgRBLcFwl5/J1FLRYwKG+pMljfbwp1WFSjbIbfmDB2PNGzKRFw2J4BEDtoT05tooSdE3BaOKRKPs5gIff/cVzFkBXgm00Ot0rJf1cSwNOfpJA7ovmW1fWpxugIegyGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHNCy0s/tD/dnQ2kcHhAwxsAVZUIU7QSYgcLsu/7vWI=;
 b=J/i5Az+dslkYL58pcmbjGbx9P9Paoo4rcyCwlDCPzA7fYGjHD+/a69A4c1tclWP2XYuurq2KAR3tE+AfDHXE/TdvKVrM94WcrgV/6sic9kC5vqYYWLLoDCYwnev2B32U0tQqbW5PgfsdszuzcfCnLfCjaN289OT/7/INos95FUk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:15:28 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 10:15:28 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: validate user queue parameters
Thread-Topic: [PATCH 2/2] drm/amdgpu: validate user queue parameters
Thread-Index: AQHbiMyDA0LzpyBtBUa1MQrBF3i39rNa62GA
Date: Thu, 27 Feb 2025 10:15:28 +0000
Message-ID: <DS7PR12MB60055EF89017822A8C6106F6FBCD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250227040234.235004-1-alexander.deucher@amd.com>
 <20250227040234.235004-2-alexander.deucher@amd.com>
In-Reply-To: <20250227040234.235004-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f71860be-8d61-4394-a5db-409cab489d0e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-27T10:15:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB7991:EE_
x-ms-office365-filtering-correlation-id: d28a1c39-8d82-449f-18b8-08dd5717a8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f0h73Ff8+CwLmfLGdvaAAF4P7Z4vlROnuDp8lNvPzc94IXIqGyS/WK+zBkh+?=
 =?us-ascii?Q?21SPMJO/crW+3khIlg2eFG41jtALK/AMLDagigr6Eidinaa+/XcQKyOri7CD?=
 =?us-ascii?Q?dzKcNlyTcw2DxwTpSZ9fwYiHbE8pqQYgeOp5p+3kEMYjIFMz0QA1b2aBhB8r?=
 =?us-ascii?Q?Y/ghGPt/W9MezhDkX6Z62oqQExzujtCeOk4+/4YVN3txktFSRQIvdaDUujL1?=
 =?us-ascii?Q?xX+yGFveaa2m0RbCZAtE+ijcWxOESOji1B3NIej74NP5OHBqlANGpa+iXSpC?=
 =?us-ascii?Q?78PvHuBtcGLR1iozEDNmpFq7gS7S1CEV8NNuugStJIfOBD/La9s/oK+8nzHh?=
 =?us-ascii?Q?xCIl72p1IwMGaD5H+bK+HIHHiBb97HrUL8S1iVhVW9Xg+IqnmkHowDDob/tn?=
 =?us-ascii?Q?LDR8fS7v7zZ64EjGLZuz/DsN1siRF++C/XRIll7+uu+ZrgLpMaMqXBMbY/mW?=
 =?us-ascii?Q?HaLcYg54TCDh/l3X202dvYYKrGxzLe6blZ6+PwloJYilF2husENTZSDh+aYJ?=
 =?us-ascii?Q?EYjIT1sy/ODGjy7GlMa08KRaWBmQv/t7nu6n61oHlCuRrbNcyAS5QmIm7oM7?=
 =?us-ascii?Q?BnBgeTY4rVmnDBIoGwC65WJGf7jKw+S/wtY5kvL3baNMpvIKTc2M6P+b7rMt?=
 =?us-ascii?Q?h25gfJoluU1q+tcnGs81f1KPhfMhXhv4moetWfCtrJPfxMUVcv/G6QOqwHF9?=
 =?us-ascii?Q?Pu7+W24DUxSNja0X1OAFG4kcVAawO+8mFZ3bbn+NhEVl3nZzwcj7s0ALcwfn?=
 =?us-ascii?Q?I/Q92tMPUliDSJ3OlI4ziwTn3uwW/ih0Ql9QD1VoLM/4O8qXnS2sg6geI0FB?=
 =?us-ascii?Q?QFF8dKqTzEi7JXbT9Oj8SweydBKwVFSDkRoLZzYWTk6jr6ZT1q4ycPMYg/l7?=
 =?us-ascii?Q?GEwGm/loOEIl/MsXAhGMmqr4KNLq2OUyOyOIfEWGiHA5iTvaobhvOBtJ84EW?=
 =?us-ascii?Q?ifhnbYpTwKlhh262EF/QXR9UFXTeuzs2H5/nECJGl9AmFyXIQNx9wglw53TB?=
 =?us-ascii?Q?eJzLJsNLQbrg5+QT5KwtuFkKguMhRVThyhrbZK+iNwZ9ZLf9XZEMnMXkWCRw?=
 =?us-ascii?Q?Bkz56QBlDrPd1PeTRrURa7Y1epJVyTeGeUrNeCT04GVG1jrs3ap8G/Q1sFop?=
 =?us-ascii?Q?nDl5JR1rmNT7JKrnuny7KWV4KTLoA9iktqX90jq+vyKRvqE8DY7DfrmpRYDH?=
 =?us-ascii?Q?lrRejLFGq9/UUpmSEWehXQDBeW8+Awt1H6p/8faNrXGhyJebV8HDb0g4VDfb?=
 =?us-ascii?Q?3GPxS+f8NOBAtXtGlxllZe9U5fuw3JQ/2sNjnGuyEVW8zYMP3D4IOqyc0aIE?=
 =?us-ascii?Q?Qo8ST56CzlvHx2PtD41GhlAjrXqCnKLbgsgjnMOXmkttMq+H/1yJ0qB59tD4?=
 =?us-ascii?Q?+uQocZpEosrwM3kzBiWeSqYv4gurbZ+1ygd74BCkesgnrfM53TVNGVWa+E7+?=
 =?us-ascii?Q?w1olOg34ObcnXRhAoLF6M7l1EPSNUjyh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7eOaJO+t2kB2eCBJP14zHWuZOHylJY5lPR/qqIVJfN4puMsIWO8u3hKMEJc?=
 =?us-ascii?Q?74fIMJ/frG5S6ag7Mg68qk6hGeNMWg7JknK4/s+k7TX+FdXoFGmxUf3Miuw5?=
 =?us-ascii?Q?uWHA7njvhNAazHetzdiGs+qV6BT+bQSs+SittBU+ewaEIJCjB/NFP5VyPUig?=
 =?us-ascii?Q?EwGDGJKQS1PsNXRIMZLZ0U3tkwRa2Ja7MhtV2sbKaFHKdxi4M0qu+lMug3PU?=
 =?us-ascii?Q?pPqMWoYZWFUvdU9DcLksygA6jhja4dg45QvDVAsZy8bHe/6QIGUKgh+k8+4Z?=
 =?us-ascii?Q?VLDJcE6SpNvQBQPbcF9nY2Oo77V2+KnRlWZ/l1gPjg8dTa6UA/L0DJl7evN7?=
 =?us-ascii?Q?zfF40+HIse7ccTyTHkpdpb8SAhOOTxxXQ4v46NJn3PrcqfWKXU3taZNX9CoJ?=
 =?us-ascii?Q?PDFeba6mNt4iTaa0cyBfqAZhjolou74xldLyREglI7+eWV45SqJQcUeOUHtQ?=
 =?us-ascii?Q?6pLtaN86ufoUjvAUXg7sxoOgVnVHT3bpELK1CWDxr+LUk6Camte3F0aVvaFr?=
 =?us-ascii?Q?dXgcYsUtLFh+TjciHxZJ9DHOCE9b5IWi2QCti4KtGXwiNTheH+Ors51NtdMp?=
 =?us-ascii?Q?wyWb5aT309uwn4XAYuqzvfuNw5hb/55R+pZXKKeRMKeSrnNwfuayEZQJ2enN?=
 =?us-ascii?Q?VAq+6vCzLYmBhhAjfeigjCLY3s8fyG+E/WJPctBRZDnxhC5spTVXJR9xFp3c?=
 =?us-ascii?Q?OutPSH7KQLS5kxoDjdrASVIt1dN329a23NbJbK5srQHTE8ai45/7nslULdoh?=
 =?us-ascii?Q?owJT/38f6Qg+IHPuud4yudaFccvsTe6/N55ibG6U3FIJH2DJV8sYjnthVaAY?=
 =?us-ascii?Q?ySlgGhDkEP0kfr+lHRADm15bWTwPsZT1nFOEcDA1Sq/EY55ubVQ7C2sRpPj0?=
 =?us-ascii?Q?TWJnX7w2xyU3XujvZmqd2m0nQEqXElhyHIlVtVfAgmf54KC4fGadvtlIYC4h?=
 =?us-ascii?Q?A7++BaVey3wCF7M31CJd+nTPxmJMQJrQWsZ78QtsmIUcJ+I6KOL4Z+fgVsay?=
 =?us-ascii?Q?J5z9A6akAtcMtM0LaT62hSh/HMwCsHERc8D3A06qR6cqSjZW0a+Ym2SeeB3X?=
 =?us-ascii?Q?vE/RItnpKLtj6D/cA4HqTnSt/Sp1BXBM8wH+pBWRQvaBqpwX7EK+j3HjdVVf?=
 =?us-ascii?Q?EUel1LjzDcf/XzsDkI4MoEw2RV4cc3D3i0G6gNNEmrDCnntaSQyhl27J0XJ0?=
 =?us-ascii?Q?kraUlg+Ap4qE9KKGh4NMEcZC++mz83pehqJF1/COk+1u9zRQ/CvmfpwXhydH?=
 =?us-ascii?Q?Y6UZ/9vEbOPl4SYEja76ZExEvzw7twqN/skzXiu2F6Dwx86NLRIAUKVrsAur?=
 =?us-ascii?Q?xMb+yjvdTdbiYlLlSmZKGZMWCR4wDswslKgCMB3nY24MnlTZLuQWpExI1xmi?=
 =?us-ascii?Q?aSzPk982hB7o2fuiSm7nvbheZEifZrcPzSzBvCE3uo5M9/JTikYiUsUYyuIx?=
 =?us-ascii?Q?yrMcqBBO21Cva5s2Y8iv/Il09k6A0BVuz615Hp9yuvrRlewWmzPDkcM9pF1O?=
 =?us-ascii?Q?EvKw/ST66+yBuIgAW27+9EEQHMFMHHCaoDDyDPN4hqQrkWF9RnVPQjDviN65?=
 =?us-ascii?Q?GPX28rMc9MEp50uNmCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28a1c39-8d82-449f-18b8-08dd5717a8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:15:28.5347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyA5SzUWfM6HDpBtv59ScRLm6Z/XTE65biWiCFY7HYJ898XvFlSJuOqfwBKzwqdP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

[Public]

It seems that invalid input parameters happen rarely. Using the `unlikely()=
` function in the validation condition can optimize the code execution path=
.

Anyway, the patch series is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, February 27, 2025 12:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: validate user queue parameters
>
> Make sure these are set properly to ensure compatibility if we ever updat=
e the
> IOCTL interface.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 0664e04828c07..39279920a757c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -380,12 +380,26 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>
>       switch (args->in.op) {
>       case AMDGPU_USERQ_OP_CREATE:
> +             if (args->in._pad)
> +                     return -EINVAL;
>               r =3D amdgpu_userqueue_create(filp, args);
>               if (r)
>                       DRM_ERROR("Failed to create usermode queue\n");
>               break;
>
>       case AMDGPU_USERQ_OP_FREE:
> +             if (args->in.ip_type ||
> +                 args->in.doorbell_handle ||
> +                 args->in.doorbell_offset ||
> +                 args->in._pad ||
> +                 args->in.queue_va ||
> +                 args->in.queue_size ||
> +                 args->in.rptr_va ||
> +                 args->in.wptr_va ||
> +                 args->in.wptr_va ||
> +                 args->in.mqd ||
> +                 args->in.mqd_size)
> +                     return -EINVAL;
>               r =3D amdgpu_userqueue_destroy(filp, args->in.queue_id);
>               if (r)
>                       DRM_ERROR("Failed to destroy usermode queue\n");
> --
> 2.48.1

