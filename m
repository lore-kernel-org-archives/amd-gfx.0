Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DCD1088E70
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 05:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8C810E0C1;
	Thu, 19 Mar 2026 05:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KAGnH6MW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3676D10E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjY0egqg9kK4TdZshbzpU2qG00IcWGlxSEe805vpCJcGry1zPK50ZoJEiE7Bchsk9Sn18v9jUkDIN/4mxRkJVODC3SXBT89nv9en43ZE2odJ+Wp06lEULgXexuppAnaoC9pN9v9tE+oLbYysDYd/NMe7o64aDoELcJEqY50nGt7t0CDn6fTTs4y8s3twUKbomczX9yBYUnvqgwHrGYjw5ZGbSWcijpoJhau20BfSMGrEyVIvv2zdPy7f5iGXYyWd9FlFKGTo6w6YSbfS2CpGOuas/5wA1kKPxXg3eVYqqg19MvlLIRf3ykHseeyJ7sSn4C1d3c8Ydv1UWh+YPFnBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWXzKYDyqC7r4V5Ek8s9vusrvPa7yrTwNfBUSedgWOU=;
 b=rgzpV53hpgkm0iwETgwPHUkbBndpnMOP8JICAom07rZRPDmjiw+FquV0IdNlq8SWWn7jIFnQXj7YdFjoUChhJOM8hWE4ImiB7JxecZDtiRceRbPKNrvBj88tvcfKpQaHUDhERC/IQn1uqivkl23SC2SlpKqvRCf5BGvIkif3lg5D3rXF1S544sDloakg6uBhn9TSUbrO5yQ6zE8digXEUy1ND43OSw5czUhforKetZ7XZ/fHdBEbtaQAMAzDkaiZ5zIhf9T0fr5+MEAETdPlDo9sVCRjsj45PJfAuLTjQ04P3TaeMm/XgWwRVSy2in4A+Vbt79enU8njir/MoAqCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWXzKYDyqC7r4V5Ek8s9vusrvPa7yrTwNfBUSedgWOU=;
 b=KAGnH6MWugc6EcYeBIjnhBNSn5QAi8aalPah9D9zYhia/8E2HAR+wgG59mdj3QLwI6x7gqk7Q7MuIWnAKWaJHUFrqa2F3ouZ3H2NQzPzki1FEx6wk1aXisgvfvY7p70aK/T+ECoqgM9B+iu4ZObGP+2BuMSMlkaHZJ+D0ecxA6c=
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 05:00:29 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 05:00:28 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
Thread-Topic: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
Thread-Index: AQHctsJmtaxnhqVAp0+SQyto8DylvLW0Hp8AgAAD1ACAAR4UgIAACNeAgAADCwg=
Date: Thu, 19 Mar 2026 05:00:28 +0000
Message-ID: <SJ0PR12MB708298F39630A4EA6264DB36974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
 <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
 <IA0PR12MB8208A7A18B8626B723B2D5FD904EA@IA0PR12MB8208.namprd12.prod.outlook.com>
 <01fbbf0b-72ba-4df9-a3cc-d0bce429a5be@amd.com>
 <IA0PR12MB82083457A40B3AAD336605A6904FA@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB82083457A40B3AAD336605A6904FA@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-19T04:59:11.5765740Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7082:EE_|IA1PR12MB6481:EE_
x-ms-office365-filtering-correlation-id: d9243e5b-997e-4126-64dd-08de857470ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BWGhL7F0YH63hSrx1HQj6pQpteYkZ/nmgRz5ZVq57FrdOvmdPTAlsodKMGKLyopmpuDiW4Hh0TBFHPn+NIEfdCFsHoxCyseARHdSwSqcGX3eTD1jO+0+3sQ8zC0jn1Hnd4WG94+PC3j2JIvWOrEUEqzm3HDhb+GgHC1qpNwbA/QY+jhJh4yU1iDH4XjciSd0nOUU0p8i8BrRKi13QTLr7fv6cKWIe80Ae9qowdo6tjWjh2dee2aZCviOix5Uu7DNW4GEcIJLFdBkF7+UWSWq7HBvlwJ5yzQ+sLeJ7NomeTk3OfWF3HJNfZI8ah1/k5W+BMaUOcP65+z4Bj9590B88zA0AboKoR3TsRhCOdJ+rIpZR8cYwZYNPsS9vZbQO/eUqeEgfRZS180IEgX7XlNuBaXleauFcGgsuLPDBPtOFl/fJedsO/y/MaOpNd5L1h/JWiA7XB4BBVeNAXQSN7kMwbK+52c72ZX7z02llEC+a5vQSQ/WPhYVWCTDASXY7EiWwBgDuEUPjgSQUbDUm7moZHq/kbsW99bs+VEufWD3SWJQlHBRgJqeCQAIwgepoR0xPCgq7LS3kU5FPOxvOhpyJjyb6M/+OGqVyW8tV4DyQsJlYTZK1YJpBW5OtSat8A9hJWD9k44uSLy3ar8Jf8OdtO84QOgldz7W54YuomokMF/irVwifulduZujolWVNBztCBC/BSGKZtpm86Te6xn7AEMPdaX89LOw5w8x4otboRTcDZOLjdMoFgJnnCaCm3ZEBYlroohF+JZcqftDC33h6DJSagBhSsW1pMhWv5gpytA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KplWA2IOTIkdiLLn6dlz4G+/91MQsaKN1KBK7JPI8mQN5kucrYAK2MOs0N?=
 =?iso-8859-1?Q?Q2wjJa7AWCGke19HzOZlXcuk+pe5uypKlgq8PhlK3Tf6MWQrSmSRSZULes?=
 =?iso-8859-1?Q?st5NLFiM2fcSqCbpqwit5bmgg/tXugu55wuw/cy1jMHeEF3pzrfbVh46/X?=
 =?iso-8859-1?Q?4mSVoxew1efNGKCy76EAZAVAYlcpay7atN6MrwY8K6qa9qK1VOOgMt9jdC?=
 =?iso-8859-1?Q?+jHQOb6yNKf16WSzWCupBdqL0t9eCP0H2VBXxkFH3yQSaekc1yrxy3VmCN?=
 =?iso-8859-1?Q?hXIPO3fdEZraVOLxIRjAjF+1WORR+l6DESdatqYj+/11ht6dzVwvMgX30W?=
 =?iso-8859-1?Q?bR0DMOrigJ/W7ls97SqS9RL16gj6gVEKQ8Jlj1NV4ZLDz3AkLrgO5YaOG4?=
 =?iso-8859-1?Q?ge6WUytLtOFBZd4yfeFXEGiL6FBfnjoA8fg+r/x8CukRbWx3T2vJnqTifp?=
 =?iso-8859-1?Q?NSkLHncQUcdXddK7FDtq6JtlWYJh/HNuYD1g43thSNHlmVJbWvk1vVe/L2?=
 =?iso-8859-1?Q?QIF221sTefyWU986WxYOlaNahNki61PeqB++SCzu2alkqfBGiivJ+oUmUB?=
 =?iso-8859-1?Q?zSS/O2++8XwLD7Q/l5n1rVssxO7oPqkLVgHhMZIwpnf15ixbk6oRUMICFi?=
 =?iso-8859-1?Q?ci/ZVNViX2jfS0t56t6/YD0/eP8jzM86XnzaS5NdFtO0TfemK772vGVF4W?=
 =?iso-8859-1?Q?PoDPYE5/14gLK6jBGzHzKnCbNKWyZ24FVJYrhMqFDXYf0IhA33a8JfvrGw?=
 =?iso-8859-1?Q?9IoUdK6wN85t8GyQDEmHv31v1qbEgdZJaVqcqMW8ZJOxnU9NTfN1uJ19r7?=
 =?iso-8859-1?Q?kYVJpFjMdQygTVL8djNV3uvnC8UjTojokTwkyUxFcKZNHx4rowHCge4X0A?=
 =?iso-8859-1?Q?9smbV0Qk+0B2CFfLMaiQ64twzvJcR/kmsA06pNUEWGfBXr3Ek5ei71Fm6T?=
 =?iso-8859-1?Q?ggLwN4A7Gp+KRX73SItX6mgSEpTVVUEzEJQNTR/u65BPFsL83eL3OCwgrk?=
 =?iso-8859-1?Q?XJ7tkCrpl65KFzRXitTHclc4MOGAizd9QAOSOmu53cNIYflkfb/8D61ZBK?=
 =?iso-8859-1?Q?SvEC6JNTxC3Q2ZHAvbWrtYv4qaRMHYawFGGuIv98maoDmNbdCfOa0zBSlJ?=
 =?iso-8859-1?Q?NfkHcNedq8dkfQsgw12zsmh16rXGv/y2ejhihVD9x+IbZ8PNfbS6GwwzLn?=
 =?iso-8859-1?Q?BGx0fJeyF7rBZdw21wUYayGdZSCrnXvhaT6ntunrJj/7JgUfAGDN4mLb2L?=
 =?iso-8859-1?Q?aknEzKXxGyOCVs0Il4rS7SWT3GTyL9lvPdtLPR/uOrR/0DWOeQvGU5PZrv?=
 =?iso-8859-1?Q?iXFsxnzXXrIciTPObjDCdPJ3aR6eDYsliqEI23s/1MIAcBfYhQeMBa+VAq?=
 =?iso-8859-1?Q?S6cXBtVOewkdnR8dkuccUSyU6NgmznlFNwsRIo/nzsg45NzhixlUa+neoK?=
 =?iso-8859-1?Q?7jLNB7M6Y+lK+ocCErGR3JPZabGwpPsnAV2wr1vByLZvtiOlL7LSK/HxcD?=
 =?iso-8859-1?Q?ZQ8AxwkrUoU7eiyT0jSQL1q9gzSC3rJYuduqThXwn3MK78OzpuxU9z3Mel?=
 =?iso-8859-1?Q?76ZMgYx8IXOG9PU5cugZZwIft9C8N9tIN82IJH5CssZOk4ZFgfFAZaFyAs?=
 =?iso-8859-1?Q?Ntpz4JtfWy6XHpzYuHBUFHXckGe4ulws5g4fSTB/gPq6rbVndgredtinXk?=
 =?iso-8859-1?Q?RNq+eF8o2jdZfOg4OwrbO8A0oVad5MWLAUuDeLoJKa9zz4WTHSAL0hxA7N?=
 =?iso-8859-1?Q?qGbEn6Tt0Jw9MRfUXam2+gMuzZab3be1ZNBNT0o2vC6wwq6USd7qQPJZ2v?=
 =?iso-8859-1?Q?yA7sLm6CoQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB708298F39630A4EA6264DB36974FASJ0PR12MB7082namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9243e5b-997e-4126-64dd-08de857470ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 05:00:28.5990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gyfa2L+bjBjLCRH08q3CHTwjZOom4ndHByO05UwQXKA90R/3AGZcIe/xdX5wnuH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

--_000_SJ0PR12MB708298F39630A4EA6264DB36974FASJ0PR12MB7082namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

To run coredump logic, driver needs to be loaded first. For driver load to =
work on all new SOCs, it needs discovery.

Other SOCs which depend on pci id mechanism don't need discovery and they d=
on't have discovery section either.

Thanks,
Lijo
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, March 19, 2026 10:17:09 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Pelloux-=
Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery top=
ology coredump path v3

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, March 19, 2026 9:46 AM
> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-
> eric.Pelloux-prayer@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
> topology coredump path v3
>
>
>
> On 18-Mar-26 4:41 PM, SHANMUGAM, SRINIVASAN wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Wednesday, March 18, 2026 4:28 PM
> >> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> Koenig,
> >> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric
> >> <Pierre- eric.Pelloux-prayer@amd.com>
> >> Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in
> >> discovery topology coredump path v3
> >>
> >>
> >>
> >> On 18-Mar-26 4:00 PM, Srinivasan Shanmugam wrote:
> >>> When a GPU fault or timeout happens, the driver creates a
> >>> devcoredump to collect debug information.
> >>>
> >>> During this, amdgpu_devcoredump_format() calls
> >>> amdgpu_discovery_dump() to print IP discovery data.
> >>>
> >>> amdgpu_discovery_dump() uses:
> >>>     adev->discovery.ip_top
> >>>
> >>> and then accesses:
> >>>     ip_top->die_kset
> >>>
> >>> amdgpu_discovery_dump() uses adev->discovery.ip_top. However, ip_top
> >>> may be NULL if the discovery topology was never initialized.
> >>>
> >>> The current code does not check for this before using ip_top. As a
> >>> result, when ip_top is NULL, the coredump worker crashes while
> >>> taking the spinlock for ip_top->die_kset.
> >>>
> >>> Fix this by checking for a missing ip_top before walking the
> >>> discovery topology. If it is unavailable, print a short message in
> >>> the dump and return safely.
> >>>
> >>> - If ip_top is NULL, print a message and skip the dump
> >>> - Also add the same check in the cleanup path
> >>>
> >>> This makes the coredump and cleanup paths safe even when the
> >>> discovery topology is not available.
> >>>
> >>> KASAN trace:
> >>> [  522.228252] [IGT] amd_deadlock: starting subtest
> >>> amdgpu-deadlock-sdma [  522.240681] [IGT] amd_deadlock: starting
> >>> dynamic subtest amdgpu-deadlock-sdma
> >>>
> >>> ...
> >>>
> >>> [  522.952317] Write of size 4 at addr 0000000000000050 by task
> >>> kworker/u129:5/5434 [  522.937526] BUG: KASAN: null-ptr-deref in
> >>> _raw_spin_lock+0x66/0xc0 [  522.967659] Workqueue: events_unbound
> >>> amdgpu_devcoredump_deferred_work [amdgpu]
> >>>
> >>> ...
> >>>
> >>> [  522.969445] Call Trace:
> >>> [  522.969508]  _raw_spin_lock+0x66/0xc0 [  522.969518]  ?
> >>> __pfx__raw_spin_lock+0x10/0x10 [  522.969534]
> >>> amdgpu_discovery_dump+0x61/0x530 [amdgpu] [  522.971346]  ?
> >>> pick_next_task_fair+0x3f6/0x1c60 [  522.971363]
> >>> amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu] [  522.973188]  ?
> >>> __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu] [  522.975012]  ?
> >>> psi_task_switch+0x2b5/0x9b0 [  522.975027]  ?
> >>> __pfx___drm_printfn_coredump+0x10/0x10 [drm] [  522.975198]  ?
> >>> __pfx___drm_puts_coredump+0x10/0x10 [drm] [  522.975366]  ?
> >>> __schedule+0x113c/0x38d0 [  522.975381]
> >>> amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
> >>>
> >>> v2: Updated commit message - Clarified that ip_top is not freed, it c=
an
> >>>       just be NULL if discovery was not initialized.
> >>> (Christian/Lijo)
> >>>
> >>> v3: Removed the extra drm_warn() for sysfs init failure as sysfs alre=
ady
> >>>       reports errors. (Christian)
> >>>
> >>> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in
> >>> devcoredump")
> >>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >>> Cc: Christian K=F6nig <christian.koenig@amd.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++++++++-
> >>>    1 file changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> index f7f37d93d0ce..6be1f971a31a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct
> >> amdgpu_device *adev)
> >>>      struct list_head *el, *tmp;
> >>>      struct kset *die_kset;
> >>>
> >>> +   if (!ip_top)
> >>> +           return;
> >>> +
> >>>      die_kset =3D &ip_top->die_kset;
> >>>      spin_lock(&die_kset->list_lock);
> >>>      list_for_each_prev_safe(el, tmp, &die_kset->list) { @@ -1419,9
> >>> +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev,
> >> struct drm_printer *p)
> >>>      struct ip_hw_instance *ip_inst;
> >>>      int i =3D 0, j;
> >>>
> >>> +   drm_printf(p, "\nHW IP Discovery\n");
> >>> +
> >>> +   if (!ip_top) {
> >>> +           drm_printf(p, "ip discovery topology unavailable\n");
> >>
> >> Is this type of printing really required or just skipping the whole
> >> section good enough?
> >
> >
> > Silently skipping the rest may look like incomplete or missing data in
> > the coredump.
> >
> > Adding a one-line message makes it clear that the topology was not
> > available, rather than leaving an empty section.
> >
>
> Here is my take - Discovery is the basic requirement for SOCs which make =
use of
> that mechanism and it is always expected to be present for those, otherwi=
se driver
> load will fail.
>
> For those which don't make use of discovery, the section will not be pres=
ent. There
> is no special message required for that. There is no harm to keep that, i=
t only adds
> extra parsing.

It's ok for normal cases. However, this runs in the *coredump/debug path
during error conditions* - where the discovery topology may not be
initialized. instead of leaving the section empty, which can be confusing
during debugging.

Best,
Srini


--_000_SJ0PR12MB708298F39630A4EA6264DB36974FASJ0PR12MB7082namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
To run coredump logic, driver needs to be loaded first. For driver load to =
work on all new SOCs, it needs discovery.&nbsp;</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Other SOCs which depend on pci id mechanism don't need discovery and they d=
on't have discovery section either.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 19, 2026 10:17:09 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Koenig, Christian &lt;Ch=
ristian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Pelloux-Prayer, Pierre-Eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;=
<br>
<b>Subject:</b> RE: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discov=
ery topology coredump path v3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Sent: Thursday, March 19, 2026 9:46 AM<br>
&gt; To: SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;;<br>
&gt; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander=
<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric &lt;Pie=
rre-<br>
&gt; eric.Pelloux-prayer@amd.com&gt;<br>
&gt; Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discover=
y<br>
&gt; topology coredump path v3<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 18-Mar-26 4:41 PM, SHANMUGAM, SRINIVASAN wrote:<br>
&gt; &gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, March 18, 2026 4:28 PM<br>
&gt; &gt;&gt; To: SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt=
;;<br>
&gt; Koenig,<br>
&gt; &gt;&gt; Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexande=
r<br>
&gt; &gt;&gt; &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; &gt;&gt; Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eri=
c<br>
&gt; &gt;&gt; &lt;Pierre- eric.Pelloux-prayer@amd.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in=
<br>
&gt; &gt;&gt; discovery topology coredump path v3<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 18-Mar-26 4:00 PM, Srinivasan Shanmugam wrote:<br>
&gt; &gt;&gt;&gt; When a GPU fault or timeout happens, the driver creates a=
<br>
&gt; &gt;&gt;&gt; devcoredump to collect debug information.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; During this, amdgpu_devcoredump_format() calls<br>
&gt; &gt;&gt;&gt; amdgpu_discovery_dump() to print IP discovery data.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; amdgpu_discovery_dump() uses:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;discovery.ip_top<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; and then accesses:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ip_top-&gt;die_kset<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; amdgpu_discovery_dump() uses adev-&gt;discovery.ip_top. H=
owever, ip_top<br>
&gt; &gt;&gt;&gt; may be NULL if the discovery topology was never initializ=
ed.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The current code does not check for this before using ip_=
top. As a<br>
&gt; &gt;&gt;&gt; result, when ip_top is NULL, the coredump worker crashes =
while<br>
&gt; &gt;&gt;&gt; taking the spinlock for ip_top-&gt;die_kset.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Fix this by checking for a missing ip_top before walking =
the<br>
&gt; &gt;&gt;&gt; discovery topology. If it is unavailable, print a short m=
essage in<br>
&gt; &gt;&gt;&gt; the dump and return safely.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; - If ip_top is NULL, print a message and skip the dump<br=
>
&gt; &gt;&gt;&gt; - Also add the same check in the cleanup path<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This makes the coredump and cleanup paths safe even when =
the<br>
&gt; &gt;&gt;&gt; discovery topology is not available.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; KASAN trace:<br>
&gt; &gt;&gt;&gt; [&nbsp; 522.228252] [IGT] amd_deadlock: starting subtest<=
br>
&gt; &gt;&gt;&gt; amdgpu-deadlock-sdma [&nbsp; 522.240681] [IGT] amd_deadlo=
ck: starting<br>
&gt; &gt;&gt;&gt; dynamic subtest amdgpu-deadlock-sdma<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ...<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; [&nbsp; 522.952317] Write of size 4 at addr 0000000000000=
050 by task<br>
&gt; &gt;&gt;&gt; kworker/u129:5/5434 [&nbsp; 522.937526] BUG: KASAN: null-=
ptr-deref in<br>
&gt; &gt;&gt;&gt; _raw_spin_lock+0x66/0xc0 [&nbsp; 522.967659] Workqueue: e=
vents_unbound<br>
&gt; &gt;&gt;&gt; amdgpu_devcoredump_deferred_work [amdgpu]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ...<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; [&nbsp; 522.969445] Call Trace:<br>
&gt; &gt;&gt;&gt; [&nbsp; 522.969508]&nbsp; _raw_spin_lock+0x66/0xc0 [&nbsp=
; 522.969518]&nbsp; ?<br>
&gt; &gt;&gt;&gt; __pfx__raw_spin_lock+0x10/0x10 [&nbsp; 522.969534]<br>
&gt; &gt;&gt;&gt; amdgpu_discovery_dump+0x61/0x530 [amdgpu] [&nbsp; 522.971=
346]&nbsp; ?<br>
&gt; &gt;&gt;&gt; pick_next_task_fair+0x3f6/0x1c60 [&nbsp; 522.971363]<br>
&gt; &gt;&gt;&gt; amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu] [&nbsp; 5=
22.973188]&nbsp; ?<br>
&gt; &gt;&gt;&gt; __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu] [&nbsp=
; 522.975012]&nbsp; ?<br>
&gt; &gt;&gt;&gt; psi_task_switch+0x2b5/0x9b0 [&nbsp; 522.975027]&nbsp; ?<b=
r>
&gt; &gt;&gt;&gt; __pfx___drm_printfn_coredump+0x10/0x10 [drm] [&nbsp; 522.=
975198]&nbsp; ?<br>
&gt; &gt;&gt;&gt; __pfx___drm_puts_coredump+0x10/0x10 [drm] [&nbsp; 522.975=
366]&nbsp; ?<br>
&gt; &gt;&gt;&gt; __schedule+0x113c/0x38d0 [&nbsp; 522.975381]<br>
&gt; &gt;&gt;&gt; amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; v2: Updated commit message - Clarified that ip_top is not=
 freed, it can<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; just be NULL if disco=
very was not initialized.<br>
&gt; &gt;&gt;&gt; (Christian/Lijo)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; v3: Removed the extra drm_warn() for sysfs init failure a=
s sysfs already<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reports errors. (Chri=
stian)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Fixes: 7083eb8982fb (&quot;drm/amdgpu: include ip discove=
ry data in<br>
&gt; &gt;&gt;&gt; devcoredump&quot;)<br>
&gt; &gt;&gt;&gt; Cc: Pierre-Eric Pelloux-Prayer &lt;pierre-eric.pelloux-pr=
ayer@amd.com&gt;<br>
&gt; &gt;&gt;&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br=
>
&gt; &gt;&gt;&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmu=
gam@amd.com&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c | 11 ++++++++++-<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 10 insertions(+), 1 del=
etion(-)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.=
c<br>
&gt; &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt;&gt;&gt; index f7f37d93d0ce..6be1f971a31a 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt;&gt;&gt; @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_=
fini(struct<br>
&gt; &gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *el, *tmp;=
<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *die_kset;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!ip_top)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset =3D &amp;ip_top-&g=
t;die_kset;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;die_kset-&gt=
;list_lock);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_prev_safe(el,=
 tmp, &amp;die_kset-&gt;list) { @@ -1419,9<br>
&gt; &gt;&gt;&gt; +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_devi=
ce *adev,<br>
&gt; &gt;&gt; struct drm_printer *p)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_instance *ip_i=
nst;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0, j;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; drm_printf(p, &quot;\nHW IP Discovery\n&quo=
t;);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!ip_top) {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; drm_printf(p, &quot;ip discovery topology unavailable\n&quot;);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is this type of printing really required or just skipping the=
 whole<br>
&gt; &gt;&gt; section good enough?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Silently skipping the rest may look like incomplete or missing da=
ta in<br>
&gt; &gt; the coredump.<br>
&gt; &gt;<br>
&gt; &gt; Adding a one-line message makes it clear that the topology was no=
t<br>
&gt; &gt; available, rather than leaving an empty section.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Here is my take - Discovery is the basic requirement for SOCs which ma=
ke use of<br>
&gt; that mechanism and it is always expected to be present for those, othe=
rwise driver<br>
&gt; load will fail.<br>
&gt;<br>
&gt; For those which don't make use of discovery, the section will not be p=
resent. There<br>
&gt; is no special message required for that. There is no harm to keep that=
, it only adds<br>
&gt; extra parsing.<br>
<br>
It's ok for normal cases. However, this runs in the *coredump/debug path<br=
>
during error conditions* - where the discovery topology may not be<br>
initialized. instead of leaving the section empty, which can be confusing<b=
r>
during debugging.<br>
<br>
Best,<br>
Srini<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB708298F39630A4EA6264DB36974FASJ0PR12MB7082namp_--
