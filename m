Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11308EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB9A10E41C;
	Tue, 11 Jul 2023 17:55:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7AD10E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 17:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VugafQPlBj8HbrsV5Ea9bJmNd9312hwF3nx6D2XtGOj9/r1LC5oFrlAqDCCaC0rSyd4D2z1dnrCl3SCsgJEiL0aF9bZ/7iAe9K4DoykWf/NhoZCKV+pVWk7fqJHuTL+ZzegDx4ChEj5vwij6Wfya2jUoVq2A7RL9hBlximxKrFY6GAx0LJHFdwgE8gcwMS3l6o8S3ASoswLYtnfFfk6at9YxHDMNJgbbwwjXYBW0uWelAMFpPIznz8fNAiSsMoXB95euFMYGupeyFzA5t/eNqnWyNl95k2b3TE6s/SYzribWb+mw4xE9P1Lw5kiKpySvWbpLLNe11iHnjCqbfodboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfgtDH8GGicEtMZHaKMsA0d4jm1oJqWR6JoPtLgr2Ag=;
 b=ErDbTDE//OCI0vSYdUh4hFe+qYwH86FYRNwR6LSZnNsbvh/4YGM4zeDDJu/Zig+CK6gbi0iarq1oyeBEH2o84NfiDBKCnQXfIkgiIOSYdkbfgceMTua/VWXn7fIV+QB0Rdumle9km4NbJmNMDWsFdYqdw0N72xjocRXuHVJUyJQTkp1bsFZOAtpj7orPq2OhHPuOZJZ4G3ICMN+h2UnEn9mdEuH6bjbejjXarN/nFmcdFYJq4jmPVa2ohMHxOf+xs8AXfsvxPSY/HpvmmVUJYn4YveSGXDJkrmlDWZXRMaWZ4T2fPjCLPS99OH5cllXzKK8dWv4vO3LJV7DL/oTb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfgtDH8GGicEtMZHaKMsA0d4jm1oJqWR6JoPtLgr2Ag=;
 b=IlTNNFNK/bs/5LY1Xn65xQGfycYF44BH36RSStyTL+jg9U1HVvhYo0ZETLzeyqKTuepIYU/qCFrvGf0xho8n6OFcMAw5dEA8l084q4kUFugSA2Aa+h3F4MvsYPjG/8pwL82xYCVCZYhZLoyyMXiRSAA0bHIesLmM1vhWbdk5IqQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 17:55:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:55:43 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
Thread-Topic: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
Thread-Index: AQHZsUOf8pukebAlYEaEndu2gIVQpa+yQFMAgAKe5yA=
Date: Tue, 11 Jul 2023 17:55:42 +0000
Message-ID: <MN0PR12MB610178C9F5DC757C8DBEC44FE231A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
 <20230708022611.50512-5-mario.limonciello@amd.com>
 <DM6PR12MB26197B684BAF112ACE9320FDE430A@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197B684BAF112ACE9320FDE430A@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=98b39db6-5858-445d-acd7-2fc581133e87;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-10T01:36:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM3PR12MB9352:EE_
x-ms-office365-filtering-correlation-id: 1185dc79-8f41-4b2f-a490-08db82380bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqxsABMnNNf9KvID/Le7vTlnKN9ojHPVftYBSChM5d+i5sV5y2UA8l/ln5xatkGL9745aJFei+P8OhW4uvFilcFmxogcnKSep4/kKZHLVAklaY8wAJYdiDlwHZ30tIOjA0jhUt6Wod3yfnAqxJvxReKgD/oNtKnVcAxcMds57jbB0cnTfDkXkn1ziHmGCmrFj1iji0b41YXykrirTAoDaEWcr6jxA/0N6xFwzV8JE4RROB+1Bgy+u+Lk3xU5E4GTOf1NmZ4zymp6KsNxDMhgHiZgLDETRb0t5IoFEnnuNl/+RDlr1M1VxOspQByCvV4/HygEM3dQSkXs6tvOgePG0kZw7d2CaBYncflja4ZQVa+l81sDDoN3ntRf5GeauanFYsQ/ei74/m6dG3sLUK2dB0EqLXtm0v210gQgrSHtO1ftwk5YY4mCXGMSjbaGdIYqBO0dpiJV07ap4z005R5eO3CPa2Wqq83oImsmB1gPgUhWpEHrfINR9s+PJAwJxuZgvPhG9/jIeNK8QkXV3PDXqCQURPVRB+yneQ6WH53TFQkMQvpe/wG76cPnF+TRa+LC7A4cEUZRSau6AAjxAhA8QO7arH/b92y+KBnNjUyqWRMsS2+ClM3ClgJ59gOrQCI4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(316002)(9686003)(41300700001)(8676002)(8936002)(478600001)(110136005)(7696005)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(83380400001)(6506007)(53546011)(71200400001)(122000001)(38100700002)(33656002)(38070700005)(86362001)(55016003)(26005)(52536014)(2906002)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hAHJZuJ9GyevturRCruT2nsw3F5DSfyFbt8fWjPmWJoDy/4W4imuQYSpsydO?=
 =?us-ascii?Q?r1iS9yB0qLVFepivNQ4EZ85OnG/lhoqcDi/Nqx8Gp5CGAdnNdFYHOSYRXbDS?=
 =?us-ascii?Q?Tv14PKQ/xHODK64qeZMbzWcYvrvqSXeMm3eI07E36/nbmrDB61EO6nojwp0w?=
 =?us-ascii?Q?tbvaaR8DxHQfy6yVSlNfFJCUzcjSG+I/tTvVtsoU7FAoxQ+HM0QtQ5tj7ijm?=
 =?us-ascii?Q?T6dbbrdQS54TezrRQGcZ+e76Un7El7MeCX9dlF3pMINtBeePpDm9j9wDYrhS?=
 =?us-ascii?Q?Lm9CE5htcYDLf3hN4NjGyOQu5SU8DIgPQW77nNM62Ohb1XENSoF6FBf8ohpf?=
 =?us-ascii?Q?ESg9Uwo9R9RidywYg14eZgYhWfCCeYEYzC9EfNpIlElLN0rbCQg7E8QwjLsD?=
 =?us-ascii?Q?Y5oLmiGx/5uatTmoLNc8UF2lc4E04ba3Hj4MyTPIh8M8lgC81wSngbIYYwci?=
 =?us-ascii?Q?cVzPkgN4X5hyDmUgmQYKEVKiNOVkli2xgUT/81JWd6IdKTORrWTrDHh+DeR3?=
 =?us-ascii?Q?o4X9nSFYQuNDtvsptHLErXqRo242YB1i9rZjvAJSo92LLSaR+V6vJb0/glvd?=
 =?us-ascii?Q?NY6HBPliExBHzI0PyVbjantm/esBjBF11eI/BbNc9mb7LMVwsPlMcq+KZy2+?=
 =?us-ascii?Q?oUzXU9SXT6J0eI1cKNnITgR7X/ZxYM1SMrc4WIlG1L9n+DVT1C41NJpFlkpp?=
 =?us-ascii?Q?Z97qv8M6Pkfzm9Z/TtJBzOKjgDQokrbQl69sSLZMKOLjfj7qcCfKVyUebB7D?=
 =?us-ascii?Q?v4LZJlRjQiRAij6nKrhS/i3wR5sC3z+xn7rwt/GdHiT0FNS3VMlLxJbEyYXU?=
 =?us-ascii?Q?aUFY5FMlzC5G2oJPVYw+3d20jZl3hogkMnsEoGAmNbUf+K2LYHwah0AFNPrV?=
 =?us-ascii?Q?kwwKZGBqy09NiD2SeX0UQl+B1o3mlGLBW+RcQuEIWd88oyGyvg4uYUltCdlH?=
 =?us-ascii?Q?Qb7uLKvEOe1fvc+gCvWZnpyzxuXMnP+XV198Sr0/can9UCL00s6o/7BKQM7u?=
 =?us-ascii?Q?fC64iBjh+7RuN9AkIMpBc68of7OT+JaxBhsErHwt1zaHcw5Quad3pTYYbUMX?=
 =?us-ascii?Q?CIRGuhcdAw71tJ+AcY6Klq7OOolmLFYjJNDMKT/7DkhSIUFBMoNfuqppxNHE?=
 =?us-ascii?Q?NrnH0O7AUn56SLzrAIjX/f5PGM8y8VOIYTc17djJZz4OUt24JKu8n2oGeZFh?=
 =?us-ascii?Q?NEJDHDOTWueOwe6gXnCDnwlwVsleIvpNrqJcRd9sZMzaVwPJSLSdHRC9URBo?=
 =?us-ascii?Q?QZR/qkemkwHyVvX9kndQ/Hm0H2Q8bHmq5RrFuwTeaKqDoF+2pXxaL7f4wJ2K?=
 =?us-ascii?Q?Vaqqe/jA+XFwaXaruS4RHVx+ANEZO8Crprs1OtrRSfI1fDVcD8aidTWIWGh/?=
 =?us-ascii?Q?ia6sLSMGtOek2um2JN13jx1Ir85r/5rWnZri028Ed4EsijY4z/ynhaMzgAUT?=
 =?us-ascii?Q?x+D6Te1LCAQVRG6DMowQZqkaLvEI9y0mVquT4K0wf8FSKnS5PZm7XEuK3I67?=
 =?us-ascii?Q?0KGk4pCK5Ih8Q9jV1BCG9+uJS4XZeLHXfo+gN+bgNhqaIeijzP4lq2y9zYxn?=
 =?us-ascii?Q?vdoTQPe5gpMuX3/ygGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1185dc79-8f41-4b2f-a490-08db82380bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 17:55:42.9063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/SRNHbwfciMeC4aKfm8RywWcZaRLHg8A35YY5ZGT9XZ3uDcQ4JPUmmwUO4DqQDQomtjq4hWO+hdtENm7vwr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

[AMD Official Use Only - General]

OK, will pick up 1/2/3 and continue to think about 4.

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Sunday, July 9, 2023 20:54
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH 4/4] drm/amd: Drop
> amdgpu_device_aspm_support_quirk()
>
> [AMD Official Use Only - General]
>
> Patch1, 2, 3 are reviewed-by: Evan Quan <evan.quan@amd.com>
>
> For patch4, it seems not quite right(at least for the naming).
> Since although the ASPM is the prerequisite for pcie/lclk dpm features.
> But the changes involved here are really for aspm feature disablement.
> I mean even if pcie dynamic lane/speed switching is not supported, aspm
> feature can be still enabled.
> So, using "amdgpu_device_pcie_dynamic_switching_supported" for the
> determination whether aspm feature can be enabled seems not proper.
>
> Evan
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Saturday, July 8, 2023 10:26 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Quan, Evan <Evan.Quan@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>
> > Subject: [PATCH 4/4] drm/amd: Drop
> amdgpu_device_aspm_support_quirk()
> >
> > NV and VI currently set up a quirk to not enable ASPM on Alder Lake
> > systems, but the issue appears to be tied to hosts without support
> > for dynamic speed switching. Migrate both of these over to use
> > amdgpu_device_pcie_dynamic_switching_supported() instead and drop
> > amdgpu_device_aspm_support_quirk().
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 -----------
> >  drivers/gpu/drm/amd/amdgpu/nv.c            |  5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/vi.c            |  5 ++++-
> >  4 files changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 813713f42d5e..6ecf42c4c970 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1315,7 +1315,6 @@ int amdgpu_device_pci_reset(struct
> > amdgpu_device *adev);
> >  bool amdgpu_device_need_post(struct amdgpu_device *adev);
> >  bool amdgpu_device_pcie_dynamic_switching_supported(void);
> >  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> > -bool amdgpu_device_aspm_support_quirk(void);
> >
> >  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64
> > num_bytes,
> >                                 u64 num_vis_bytes);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7314529553f6..a9e757f899f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1505,17 +1505,6 @@ bool amdgpu_device_should_use_aspm(struct
> > amdgpu_device *adev)
> >       return pcie_aspm_enabled(adev->pdev);
> >  }
> >
> > -bool amdgpu_device_aspm_support_quirk(void)
> > -{
> > -#if IS_ENABLED(CONFIG_X86)
> > -     struct cpuinfo_x86 *c =3D &cpu_data(0);
> > -
> > -     return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERL=
AKE);
> > -#else
> > -     return true;
> > -#endif
> > -}
> > -
> >  /* if we get transitioned to only one device, take VGA back */
> >  /**
> >   * amdgpu_device_vga_set_decode - enable/disable vga decode
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> > b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 51523b27a186..71bc5b2f36cf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -527,7 +527,10 @@ static int nv_set_vce_clocks(struct amdgpu_device
> > *adev, u32 evclk, u32 ecclk)
> >
> >  static void nv_program_aspm(struct amdgpu_device *adev)
> >  {
> > -     if (!amdgpu_device_should_use_aspm(adev)
> > || !amdgpu_device_aspm_support_quirk())
> > +     if (!amdgpu_device_should_use_aspm(adev))
> > +             return;
> > +
> > +     if (!amdgpu_device_pcie_dynamic_switching_supported())
> >               return;
> >
> >       if (!(adev->flags & AMD_IS_APU) &&
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index 6a8494f98d3e..f44c78e69b7f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1124,7 +1124,10 @@ static void vi_program_aspm(struct
> > amdgpu_device *adev)
> >       bool bL1SS =3D false;
> >       bool bClkReqSupport =3D true;
> >
> > -     if (!amdgpu_device_should_use_aspm(adev)
> > || !amdgpu_device_aspm_support_quirk())
> > +     if (!amdgpu_device_should_use_aspm(adev))
> > +             return;
> > +
> > +     if (!amdgpu_device_pcie_dynamic_switching_supported())
> >               return;
> >
> >       if (adev->flags & AMD_IS_APU ||
> > --
> > 2.34.1
>

