Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D85606A332
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sD/Teywp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4005B10E1BC;
	Mon, 26 Oct 2026 03:38:19 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC22010E227
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvzvswdQ8A03L2z3Epcb8ZBtxBah0+cEuQr6nU5PwQNIcah/FYKXCoh4DboBUkUVjNn0mUjXTGlCRGienVIN+qom1Lz34v7O7v9kl7mD3xgAWXU1pHGYorhpXLXJx1ZnlY1+gv7hTppwZ5yyYDjkxDVH3UwN1uFkT0R8lxs/9QebXHN8lMB/cQ6LXBdqEdZtJBBOfotEwyR1X3H55zH+52DvM6m81iWFvWoHAesKRN9vRdrpXECkND2WBTkQEMRwH22NfTgDmliTXBXGIagFodxkhEmLJNXbFYCiVey7pbskQn37ay//gR/7govGBk7cc7jXC7aVSQLmPuy46+pX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmeOv0MtBqshlaLLSXpuPpxNrT1i55z0Oo9M/zin7qw=;
 b=L5G8UkdskkMe4ZnWx1ulc+ddG+1qayhkxJQZZJ+sRoSWMs8nlpI/xJ0OGCL18fuje/mlMz67P71Zl3R2Os/9X4Vfro2uqaOIqqbKzo+8qIi3EESIJY3fQjLLK+wJhGrGwQFbWtPSRzDx4NbllZ01sZIIEOEok9jB3L/Gkt1VWQhLaHI//1PkUS2ed0l8w0DNDaSJWzCqqjuuNos1PJGTO2kPMCPdwjcKbH5h6DT/5WxeM3wSA9GGomz+zZK8Q1Qyto32Mnuc5pAQ/rOlBr8iuyghY7umakkzXt0XsX0gJG3r2LHkwdqRBSnc5WkQBQm2ltzubtK5xdC9993Q9/IQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmeOv0MtBqshlaLLSXpuPpxNrT1i55z0Oo9M/zin7qw=;
 b=sD/Teywp/bX1FG1Y/THE0uIPXEeDfDntQniVaO/dbPH7e+7dqXny2hP/UeaNQZ57fFETlur0kGWATZsNN3tRHvzaDf4i32htTHXt3LS8d3HYXwT1iJm/g/BxBYm11vps5G840uqiKVSUM9k1XOyRgUYSjdv0JLbA7w3110Pq/4c=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:38:10 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 03:38:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the
 GPU reset
Thread-Topic: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the
 GPU reset
Thread-Index: AQHdYsld2pTwbQenPEq3U6ueIqSXd7cK3JgAgARSLCA=
Date: Mon, 26 Oct 2026 03:38:10 +0000
Message-ID: <PH7PR12MB6000DD56C8651C335ED83A4EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-7-Prike.Liang@amd.com>
 <6ed37c0c-eadc-406c-aeba-f86a522cf827@amd.com>
In-Reply-To: <6ed37c0c-eadc-406c-aeba-f86a522cf827@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-26T03:29:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB6465:EE_
x-ms-office365-filtering-correlation-id: e030f96e-6a44-411a-2ecc-08df33128e65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|4143699003|11063799006|261022075727099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: xsAgiGaJsX+jOEvWMk2NyIr9FOCN7NC4e0UbWiDUdyjJxiL85j1ZQBcJUkuUUEGUoDEL2s9oQVyJh42bZYbQedzW/TjMPsqEJGKYtDbNqixEPwHS99W+fgI2Tzhtabsgmh+fUPo2ucqID4kQcuSJ3Hcu+2HGK9GIoftl4NHbivsIwM+6AJKEBeZ+unVD1u9cK72kgFrRV7niMUa67LiFLDEAU7vE1iWzg9f1TGYsQquuViFvGAcwl6khY/z19EwdcO70HkvjBHstG0vzFY2v1e92XE9Xop0mW7BhAoiqTeBjOHQjFtxFp9MwTA8E/NQ06U+0iRlK0nSGUMxlejOUyNilvZidkQRejPEjtrJcxwr33UiyVh+E+7TVtdWP8Tmq//jZyTUAK5gy7aa+pjtb9k7xwgO/5KLHTvfeZ43TvK24VtuZwcofKCXJA2ZTEqg6ndV+7bmgrsmW1kWLkma1JDZCx7vG9YrjZfmkH80fUw2R5Vf42/PQUyB5esB+mpGyQxcHeT2Enyfk2AaAFU1pSYC9mhEzs+Wlr9tDf9UbPgjcJjGtjfTDIuj4qXcYSEVTHX5WDYZWneac6wnm99skWOnYyKFXhw95NLDeU+7PTu0KO9zwsQiwUSFs+0YUkwhkmokidGXWwWrdcBbxEGSLhV/Cv7GzB/J07jXQ4j6JfyEIsLxUNsH3dQhq2L1okWz2vfHkjWd76Pi65c7NHwTswA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4zx4i9bolQHcWf2FV3HcBO81kmwjhSoW/mCQHKgLgEqhhLfbrBmeWr5OMEp?=
 =?us-ascii?Q?u0YtQSPMQZooO0V4BAgCgRMWrusX3WdEIi17lzVACTX2+79JtimeZFeRz/o7?=
 =?us-ascii?Q?DQTvJLu9a3iyk1osdpZkm4OiPekS5cMkn78WEDmfgH629C2Dipvg5TTf2fUT?=
 =?us-ascii?Q?gMfO0uh/AHZDfh86FdmItRm95Ef6eaCVhzV9LMXFUNhci+ISBCZe3+Uq6x4J?=
 =?us-ascii?Q?7GJOODJ8n0CsG4Dtj0nWDrpsQQQXqBcakXpnvhINq99iPWvXe9/yiPXPTBgJ?=
 =?us-ascii?Q?wT8b8dXlZo46IWdjkt8KT6UfResmqvDu8CDpEb3c7OYTt79IiGg0Z9o2lbiB?=
 =?us-ascii?Q?MpDnhZWaqYVLGsCv3auBnTry9D5uXYRCNqTBJUmpEA3MCuNPyaf6l7Qnv5Cf?=
 =?us-ascii?Q?FGTTZlt3FhiA0qR4qKj6jEmi7kISpoE9vVUEV57UNumZcf7ApPsO9duFz0Wl?=
 =?us-ascii?Q?d17nO79G6mo09UIb6/v9ynwrVCz4uctvzzo1tRcUS+eTWFYolgDTynrYODEF?=
 =?us-ascii?Q?Kom93gtFQzLLJvlo42SpMuS2sKXXX50ELXNZwjKjqBh3IG5FzoEGNxGE0qNf?=
 =?us-ascii?Q?jTQ1/BxKRxnoVJ85G9lfiPeYZjtFTZxLUl2WAFA2qb83VfrJt5fcJCnMnHVb?=
 =?us-ascii?Q?nWg/G8zILn4BngIGpzENrPn+Wx6KDriiUFR4Oir1MfFD0ZbjgBb36PJ7/VUL?=
 =?us-ascii?Q?wYVnn6s6vqhjaJA2EY09STZjt/fSlPeRHxOVU9xadudQwqJhT0UukaAiQQ1j?=
 =?us-ascii?Q?aFi9uevxxQ/SoNcwYncYxiQF34knuDltXyxPvqxXzLQ/AhualSp3m1FanQn7?=
 =?us-ascii?Q?5jZkEu/rLYGIiPnkoK0my5qQdqYz66iRkwIVsG4s+hZEDeogfor0zPm+adoi?=
 =?us-ascii?Q?Br3qNbBA5i/zJkXrAiZn4kIxnLCMUwQ3RUovwDHwIn+aR5+n4zf/B7POk7tj?=
 =?us-ascii?Q?8uUq1G1kZD2ShdSHrgSr0hkKvf5QOu0kH1aIp2xNqkLXLJyfBsIlQNH79z9P?=
 =?us-ascii?Q?TFVpN5fEY4g5swTrGNbP5DZJlyD/7syUT2J9onVub5VJDcEc1iMV1/yMAKnQ?=
 =?us-ascii?Q?QktvHQva9Va+wreciIEkr8WHcCiFfVV5tozNN+8a+jP8iTnS2k9rtNEz+31x?=
 =?us-ascii?Q?mAjbp5bXkJc3ullDvKdQYu7zKo4psg8901cI735BBZVoS5mA+iqwNu8I906a?=
 =?us-ascii?Q?SZFVYZ3i0u1+1bRP6BgrVfGLvKVmv64MUsAlQphph+KCYBqeB0rnOoyKls1J?=
 =?us-ascii?Q?gpiV5JCHXr9qqGVQG0ET4CZOU+KO+JWarXipx0We62kKaKVdPINypLMYDWFK?=
 =?us-ascii?Q?2BKTMK+8P/Ic9CP7H+t1aLkmh6eQLB4EOErOfS455/mWe6p+v2C3GfXQGYAV?=
 =?us-ascii?Q?V+Ahvs5yXCPEQbA8ZsbX5dGtC47JJc1DBubOyXSOGMnIJX5sglD2FkSAFeTC?=
 =?us-ascii?Q?PenB0s7qSFGMAbY17oWe18xrlCklacTQFYqnRkp3Vd6Ta0OGhAu49MeQB4x7?=
 =?us-ascii?Q?dE8hXwP5wCMqv8TWVMrGpfBTf4DB+sqIJF7P6s56v87pw3VH7pJ1hFg27rgJ?=
 =?us-ascii?Q?i8/Rbx/W/t3W22e2/tlflI+nncQOi99w7NZbfYMF4+WCQ8QGKmHrqpqavL3q?=
 =?us-ascii?Q?uWcifJgGF/fxstFSCbJaHfvk7gVMXhxoBL6UtPrCX1QfKztlQqaHdPEUjmJi?=
 =?us-ascii?Q?SL0EfRttRXbR2eVwQ40jEdm5lWXj9it4xwuLkLm19fqwGOkV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e030f96e-6a44-411a-2ecc-08df33128e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 03:38:10.0852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/fErjcgFFvB8nyfDn1m8g/7PfUvn0D/HTPYasGNBOnaFJFTEXqlZiHojSl4Ay6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Regards,
      Prike

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, October 23, 2026 5:30 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> Subject: Re: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing=
 the
> GPU reset
>
>
>
> On 23-Oct-26 2:04 PM, Prike Liang wrote:
> > amdgpu_device_halt_activities() only stops the ring schedulers after
> > amdgpu_amdkfd_pre_reset() and amdgpu_userq_pre_reset(). With a hung
> > MES every REMOVE_QUEUE in amdgpu_userq_pre_reset() waits for its
> > timeout, so the schedulers keep pushing jobs to the hardware for
> > seconds after the reset has started:
> >
> >    GPU reset begin!. Source:  6
> >    MES failed to respond to msg=3DREMOVE_QUEUE fence_wait_ret=3D528494
> status=3D0x0
> >    WARNING: amdgpu_device.c:928 at
> amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
> >    Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> >    Call Trace:
> >     amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
> >     sdma_v6_0_ring_set_wptr+0xa6/0x180 [amdgpu]
> >     amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
> >     amdgpu_ib_schedule+0x64a/0x8f0 [amdgpu]
> >     amdgpu_job_run+0xa2/0x220 [amdgpu]
> >     drm_sched_run_job_work+0x10c/0x300 [gpu_sched]
> >
> > Stop the schedulers of all devices in the reset list first. None of
> > the preparation steps needs them, and jobs submitted meanwhile simply
> > wait until amdgpu_device_sched_resume().
> >
> > Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset
> > functionality")
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>
> Same question as before - should we keep memory management related rings
> running till user queues are stopped?

As to the gfx userq + kernel sdma then if keeping the drm scheduler and rel=
ated ring keep running until stopping userq, then there will have a registe=
r accessing fault caused by the inflight submission during gpu recovery per=
iod.

> Thanks,
> Lijo
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++++---------=
-
> >   1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 20f02dd14c41..08395cca18db 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5534,7 +5534,21 @@ static void amdgpu_device_halt_activities(struct
> amdgpu_device *adev,
> >     struct amdgpu_device *tmp_adev =3D NULL;
> >     int i;
> >
> > -   /* block all schedulers and reset given job's ring */
> > +   /* Stop job submission first, the preparation below can take second=
s */
> > +   list_for_each_entry(tmp_adev, device_list, reset_list) {
> > +           for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> > +                   struct amdgpu_ring *ring =3D tmp_adev->rings[i];
> > +
> > +                   if (!amdgpu_ring_sched_ready(ring))
> > +                           continue;
> > +
> > +                   drm_sched_wqueue_stop(&ring->sched);
> > +
> > +                   if (need_emergency_restart)
> > +                           amdgpu_job_stop_all_jobs_on_sched(&ring->sc=
hed);
> > +           }
> > +   }
> > +
> >     list_for_each_entry(tmp_adev, device_list, reset_list) {
> >             amdgpu_device_set_mp1_state(tmp_adev);
> >
> > @@ -5570,18 +5584,6 @@ static void amdgpu_device_halt_activities(struct
> amdgpu_device *adev,
> >                     amdgpu_ras_suspend(tmp_adev);
> >
> >             amdgpu_userq_pre_reset(tmp_adev);
> > -
> > -           for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> > -                   struct amdgpu_ring *ring =3D tmp_adev->rings[i];
> > -
> > -                   if (!amdgpu_ring_sched_ready(ring))
> > -                           continue;
> > -
> > -                   drm_sched_wqueue_stop(&ring->sched);
> > -
> > -                   if (need_emergency_restart)
> > -                           amdgpu_job_stop_all_jobs_on_sched(&ring->sc=
hed);
> > -           }
> >             atomic_inc(&tmp_adev->gpu_reset_counter);
> >     }
> >   }

