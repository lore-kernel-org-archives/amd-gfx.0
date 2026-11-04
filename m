Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2097606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L6HXSgZc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6323C10FAB9;
	Wed,  4 Nov 2026 09:55:47 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2D810FACF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 09:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSADQYlP7GDoiUkWNHZPba83VL9Qwld8/Y9SQpA3oq+0l5AgcEXjTmLnbhAuU+9lUFWsLCe95iG7UV61jD6Xlucv5JXkpmLw5Lcsz+q0zkwMd2pC0K5uzqgzZjgFdbVcP5qH38dHTlhmOPf2VuuYn0b+RxL+1lICvWOXKNSe5mFLRssTUtjMJetZ4gQN7he5mQhxn+5Ajr2+tYG9gPMBb1J6nCElITsYbxHhk/deRUMDkl+zuxUceknGEn5D33fV6IwiQ113PJ8vYAHQRlLIoCAFYNn4eUnRUeEq2Tq2aSTJ1h/YlVxc08wnTH8B/M4PGoKfDqS5TasuIevHqwnJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWGAmojpc88ktetUV8kqpPcynemcUZOw8Z9827TyV3c=;
 b=XVeMVPi+AZ0qpf/LKYC0sMvhhcmwUImCA3LUW/wD2WwznS0eSgoUIRffhiHz4hMQYspDyH6I/ARA1csUTNBLEG6+YBeV+LBM6HPYdRvygbW1Al8zrB53PHjvbQ9nFsCAI5nA/YayzeadkfGvZahdj39v+9Xk581SuiG0SZOmrKNrGRzlrozlnpvBHwTSWRbOoTuqifEmLWFpt8gfnmuagyhceyEKlfq6INkxnk0FdMHLqrZKeVG7D+ynCvCPU5MGpnaJ8Cyj96bFfhW9gd2ecalHyNOakzv3pfaEHyLsfDD9dQOkXl7XAJ9tgPqRHKOAdqfReEY+ec1LtzDcfVtM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWGAmojpc88ktetUV8kqpPcynemcUZOw8Z9827TyV3c=;
 b=L6HXSgZce9exh3cE1c02WA0uAjCWyp0wZ2GNL7PRE3CH5O0JZ3Eku+507HeFRKimDxatXAL7voVDw+OistrhRq4aDukfEBGYM6gw8P1UEhQrN1OpxIptPUJFqYmpQmFAjwTvdA5AhQhXOv4Sf6Eiy2SVO+zdKqmsqFzgbx4R3Bk=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:55:36 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 09:55:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Topic: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Index: AQHdWGIlEWucozmnYUWuewqTdziwCLcHyI7QgBMaWBCAAvCMcA==
Date: Wed, 4 Nov 2026 09:55:35 +0000
Message-ID: <PH7PR12MB60000DCA403354989F1BAD12FB682@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
 <20261010025024.2453900-4-Prike.Liang@amd.com>
 <PH7PR12MB60008793634464A78A3FA17EFB662@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB60007852782439A41045D115FB6A2@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60007852782439A41045D115FB6A2@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Pierre-eric.Pelloux-prayer@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-21T09:15:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DS0PR12MB7727:EE_
x-ms-office365-filtering-correlation-id: 600e1ed7-b4df-4072-4cb4-08df3a59c5da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|4143699003|56012099006|261022105027099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261022075727099003|10067099003|11063799006|6133799003;
x-microsoft-antispam-message-info: 5sve4oJkp4Tjkmpg2uYFAyuz5hR0nHxyLNSarov1LFF7esiqKZ1Y8EMYZI4nKO4hZbJMm1vrqJU1W56UclrN33DzAE8DHvEHiwNicyas9k9VdCAL2VW3oOdKmLb1teH4EBgqfnHyREb6JLlAdjxXcSwvBn2S95c52scqtqAe1CtXNvgmnhdar0O//joLU9kZ92P6ebzXV0rKy2d2eCiD8qXlNu0/g/Hi2ykEKO7C7syyACtUR5vUhcTLtIhWp3QsO1RGmNb8crhACf4zLITokt0R7BzixPqhY9sl+f69Khw1JyqDN23t+S1TeCLAvR9Wt92xYg5Qug3aiplLpet2qbe2/JGsY0h9yz7DfWw8osjhUHr7/v0irGOnRUdAojExXQ+WUwL206ukq36uA4su1ZvpKPKk941vKnoJ/Ky1GNTEKdTAT0i+2poRkxsFYodxKxRziU3oJ2n5zg2eVoxloyuiah6R6/W1nLvBTLUg5u4/vp2U9jodpSJysLMFhL/qmuGCRw9GakaIw7D0ICfUxaHCvVYD7RuIM0MRKCwo65fhWcXx1FCd/cx7n+gUvjSUs/tz2yHyOviIgNyNc9MMCs0mkRVAycd9fmCb0WwFJMo5EDxFBm31ZVnLNnHBrZJBHBELRhsF7W+uR7Z85Nqn2XwbNK0/2FO3NzDjrDZLxF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261022075727099003)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ep+dJsJ9d4w6ZsNv0h7kHQTFV2Ye7cCV0Kb0OpipEG2NiY29tu6c8Z2ATv+g?=
 =?us-ascii?Q?A/YGPO3iIYTg4hWct9jV9vjLOhQQTEtjyfMXogdn6bnbAL3S3HHwklGWGPWq?=
 =?us-ascii?Q?dapijtaJi73tmz5BLTSqRcPJ0+NNKb5JYE4m1qqZZm5rc9s5Oq2hyTPLS+Oe?=
 =?us-ascii?Q?8lU5G1VhZz/0RujzVyLOwzaoFot97xwg53QO6LAG0V9GR5ZExv2ZvRYCuXvK?=
 =?us-ascii?Q?ikgfjvXwJ/5HRkJrvLRTDD8mC0l2wgO7GEKs+2NKTlyvedAA61JqsKosrl65?=
 =?us-ascii?Q?haCQq+vQvUVxSbd/k4WWxGvHGrmeOKmRVW828L4KdraKB6c7TquoM7E2z5ve?=
 =?us-ascii?Q?8LFV0iv6X7A79MElymI/IYkuqWRzRI1QySTAs4asQ7iBogZ36IPlvqEB78VT?=
 =?us-ascii?Q?zC37xz/z7xjvxrqhPl9nz/OlOiLN8wf8IQln8WPQeLrhfjmgLLQXNb7s1FYS?=
 =?us-ascii?Q?S+E3mMreaQX5eGmsVrgrzyz46F1LkyWfH8hMBpxBACZbH1bO5fC3/bhMVu60?=
 =?us-ascii?Q?jXZVXlgl0kFgKPw5OLWsCi4O11YKr1qdG+8dIcEI24jsiSEAjZjuVlCt5k5+?=
 =?us-ascii?Q?P+8SNlnclrku267YpA/aHOPSQZcYM0FCriiUIXVwD1dtqHWsqQ2FamFGSkPT?=
 =?us-ascii?Q?ruRLmhus4+LWP/6ktFl2K8gIC804fHqW4pLWFWSlHPHrAPw1QMhGoGcA7c78?=
 =?us-ascii?Q?P7LltzAkrRYBl+w6q6GYwa9C4ppkpw++nPfLJBVCShumwavSb5N4gAtfWXuE?=
 =?us-ascii?Q?EdhDA2O4b/nfTP6BvIT8IIfqvDr7Cve++2wwslv6dIjyt8hkcbQEunzslRzn?=
 =?us-ascii?Q?Lix+9rEHoYRTPu58t7QtGowusrm1r8GcYdDfnczUCSP6zsQ0zfKQQ929M6QV?=
 =?us-ascii?Q?+YwWEPijVgp9doWGIQVQavaCwht1/z9a4hbXeXOi8HZ/vEFZY6Trr3wFJsfC?=
 =?us-ascii?Q?QLrjR27eliYLuPx8y1LEMxRmXffisWZOw+xSlst/MgQCvSKpVOmD0R0uV+RI?=
 =?us-ascii?Q?e8TUqIg8wvKYWykQt8ivHME2BQb/6C5mcHBr0ra1OB3OP/5MyM9dxC6CBO03?=
 =?us-ascii?Q?uCljSb6jW/Bte7UREVvD+CksqkKCxmi/M44fccepl2lAcybaHflv3wqOW7mm?=
 =?us-ascii?Q?apwbPwAkyxHJsTDmIfcUh4Eed6bf11diq+qzTAaUrTXUdgRqJLRF3sNM8qDL?=
 =?us-ascii?Q?dx6X/r1eGCiqDxwTk0sd89z6W0A+Coy2OyikW151pIREnEyiUb6s+kiaxR5v?=
 =?us-ascii?Q?IU24zj42L5y94igwZJMzMzjWTFhFwe5JqkxXv2HCiQ+lTY6V42VVbRnBb4+f?=
 =?us-ascii?Q?87DZbBjXGnOUEIbfmdFDNDVkEPm8GLR92DZE8MDa2f4rquthEE6spt01E5hb?=
 =?us-ascii?Q?tvyPGmvFPSLv4ZysEgphbWbtzAjV8DYQUMqo6s14MOf7msgndQWtuW1XMWo3?=
 =?us-ascii?Q?OHQCZHlFQNd0meet7EcJJEiSDBSSdhoSv+slZc7q8lC2dVev0y2LstCdAwzC?=
 =?us-ascii?Q?1YZAYKO10+DLaIkOD1uMqmTaxXLWk2oAdQGkApB6Ht+KmUemfI80zPXkAGBJ?=
 =?us-ascii?Q?ADudK3x7SEvk/7vHLY/dbecfBXMFJtenI853sNuQjVX6FDfgmS/qv6E33LNF?=
 =?us-ascii?Q?DpTfYj8QAfillDS3xKVVhRspZ593aCwgdXEJMYipouwJnvCQBhn5Qyxxr7NM?=
 =?us-ascii?Q?0mUX4LNFVD2ijchM9myMWfwus7wPkH9u+KIs8QvXv1vzdJvv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600e1ed7-b4df-4072-4cb4-08df3a59c5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:55:35.5597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgiYkOorzQSTW8rdclFLTbRGXBSp3/xcwYhnjfY5q3nzQCftkyV4IqvmeL0uG1eC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

AMD General

Hi @Deucher, Alexander

Since @Pelloux-Prayer, Pierre-Eric has already reviewed the userq query lib=
drm implementation, could you please help review the corresponding kernel p=
atch?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike
> Sent: Monday, November 2, 2026 9:02 PM
> To: 'Liang, Prike' <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-Prayer, Pierre-Er=
ic
> <Pierre-eric.Pelloux-prayer@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progres=
s
>
> Hi @Deucher, Alexander, @Pelloux-Prayer, Pierre-Eric
>
> Could you please review the following patches, which include the libdrm
> implementation?
>
> https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/487
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Liang, Prike
> > Sent: Wednesday, October 21, 2026 5:15 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>
> > Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in
> > progress
> >
> > AMD General
> >
> > Ping on the series
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Saturday, October 10, 2026 10:50 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > > <Pierre-eric.Pelloux- prayer@amd.com>; Liang, Prike
> > > <Prike.Liang@amd.com>
> > > Subject: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in
> > > progress
> > >
> > > Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1,
> > > alongside BROKEN at bit 0, so userspace can query whether GPU
> > > recovery is
> > ongoing.
> > >
> > > Validate query inputs using the same rules as queue deletion and
> > > document the required fields. Drop the queue reference after
> > > releasing userq_mutex because the final put may destroy the queue and=
 acquire
> that mutex.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
> > >  include/uapi/drm/amdgpu_drm.h             | 8 +++++---
> > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index 6340e647a67d..6c4743ddf04a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -835,8 +835,11 @@ amdgpu_userq_query_status(struct drm_file
> > > *filp, union drm_amdgpu_userq *args)
> > >           queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA ||
> > >           queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->v=
m))
> > >               args->out_qs.flags |=3D
> > > AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
> > > -     amdgpu_userq_put(queue);
> > > +     if (amdgpu_in_reset(adev))
> > > +             args->out_qs.flags |=3D
> > > +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
> > >       mutex_unlock(&uq_mgr->userq_mutex);
> > > +     /* The final put may destroy the queue and take userq_mutex. */
> > > +     amdgpu_userq_put(queue);
> > >
> > >       return 0;
> > >  }
> > > @@ -898,6 +901,7 @@ static int
> > > amdgpu_userq_input_args_validate(struct
> > > drm_device *dev,
> > >               }
> > >               break;
> > >       case AMDGPU_USERQ_OP_FREE:
> > > +     case AMDGPU_USERQ_OP_QUERY_STATUS:
> > >               if (args->in.ip_type ||
> > >                   args->in.doorbell_handle ||
> > >                   args->in.doorbell_offset || diff --git
> > > a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > > index
> > > 98c3fa8a4a72..32ed4c4349a4 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
> > >
> > >  /* the queue is broken because it is hung, has an invalid VA, or
> > > VRAM was lost */ #define
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1
> > << 0)
> > > +/* indicate that a GPU reset has not completed yet */ #define
> > > +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1
> <<
> > 1)
> > >
> > >  /*
> > >   * This structure is a container to pass input configuration
> > >   * info for all supported userqueue related operations.
> > >   * For operation AMDGPU_USERQ_OP_CREATE: user is expected
> > >   *  to set all fields, excep the parameter 'queue_id'.
> > > - * For operation AMDGPU_USERQ_OP_FREE: the only input parameter
> > > expected
> > > - *  to be set is 'queue_id', eveything else is ignored.
> > > + * For operations AMDGPU_USERQ_OP_FREE and
> > > AMDGPU_USERQ_OP_QUERY_STATUS:
> > > + *  only 'op' and 'queue_id' should be set; all other fields must be=
 zero.
> > >   */
> > >  struct drm_amdgpu_userq_in {
> > >       /** AMDGPU_USERQ_OP_* */
> > >       __u32   op;
> > > -     /** Queue id passed for operation USERQ_OP_FREE */
> > > +     /** Queue id passed for operations USERQ_OP_FREE and
> > > +USERQ_OP_QUERY_STATUS */
> > >       __u32   queue_id;
> > >       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) =
*/
> > >       __u32   ip_type;
> > > --
> > > 2.34.1

