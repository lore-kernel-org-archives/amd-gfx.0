Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B43C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 03:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6410E217;
	Fri, 10 Dec 2021 03:22:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6010010E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 03:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+y+JPMfC23AkB1pAwNPNLlvb/sT7D2xEzli9tFpPVGkdaaRgD5F0CBf68GoC2fu4lTRavspb0+cC6ug/KO2cUZVtnUdt3888rIfG5meSlFHkKUAH25aG2aojE3itIVMGQE/hYrTYtdYnl6r4wvFwWEOaMeqpzmsA6LjpWcobOyJZe5d6NBj6KAX5kXFmKCIVxo80Ua+sIM7U5ZKm1kAeV/sh4ZAqHzjUe1821kdtPJ6uKQ/U5DkaZjgQzUyRJiLbfipDoMOevQaH69np+sesCPucyxgNYIzB/Joh1j7c7Ok6bnaJgwWiHCiXk/KOfpKjco3rRvnxZxiB7YAMF2Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxZ6HNJkiW5SNfG+m24/p+h0QDxsJk0EGeMhEGW0zFM=;
 b=i3UMRq6Pmf23Pq0fBdGo1sF5rV8fVmt9/Y6+MlxfseKvQ6ktdZ7gcC1y+zk7O/D7Z0nHlNWfV9W5XlX5Ifp91GqiFTeEqrgXXhbR4BPvcxJpNI6aX85idMYF6J8w+18fvUMvNAngit5Afsnecd/ZB9dd15XbpMEmtX3AxBh+qH/68EdVBExpeZ+fNhzIlHWK5U1iR7v1rin5xhqxmN8o28EsuTrYVyQNt+tefxUhVeZKfxiWucHxfkElZt1n50CCsCpsgakD1HFWnD7iv589HyL3OOCS2uJFWaK2zSX/sPDvfZ+mCvSeimy7FlBUYghEKhV8UJIRdEziok+BidaRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxZ6HNJkiW5SNfG+m24/p+h0QDxsJk0EGeMhEGW0zFM=;
 b=T5hZ4rwQV+d/T5ck0lDalDU/X10RbdDiH3nLHwNDXg9+2LKeudY+GZBb/XXzWOqOgcmqobXvo/L9Ob5JnW81QvqdYfVax8xcaA7hNeg1XITUJ/Jd7oZ9FbtMPdTmAhmgNSuLonzbwbrtcZ5CPyOAZXtAo1yBmRKUKO0mb8IA9SA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Fri, 10 Dec 2021 03:21:59 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 03:21:59 +0000
Date: Fri, 10 Dec 2021 11:21:44 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Message-ID: <YbLHyOypWV8FV0oc@lang-desktop>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
 <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbK8lwgodK5VutKA@lang-desktop>
 <DM6PR12MB2619F67E8A6A3D230A5D6E52E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619F67E8A6A3D230A5D6E52E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9988eda-de55-4e8e-05d1-08d9bb8c3a16
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB124107A6D49452C5AB2E7A90FB719@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztxu11ROPZTH7ZrFe/AohLfRT7rNgA5sUjWkcfBa6K3w0iboEcWVfMP/kjZxUY1cG9I77B6AO+qUPlavCHlG3zbispS1Afpu6D1uUIPBWYHktvY2H0kSQsDi7bJljjbvP0hnel1fkQ5xvemnA2NltuvIGrsMxq84F0NwMlajgi9qDFETPswrJfyp2PAp8AHr/EV9molibdbz102064iQWGMVbrqQ4ebW51jV+pBSrFEZIiNZGxD85wB6A2lZf6dQ2iNGGdaJnQkQpU5K5UTFnqD/0PCsReMfDwY5nsRZTbqRMHuhBGbVdO0rzYxSHVP2D5/PqNq5of0xOn1Z12Ehqwn9NU/gY0ZPb570+qVdtPez/VrZRrlPqpmWh2Hs50n2Xi6jPhpWMQgO24NSoA6niXjGeqSXj4EbX2ts9xIXpgGiBQ5dhqOwt/8pkIFu6Yfu3+++5QKeVGJV4hZvcOBPIjIBJw5MhqXx1yfCDYMWTM7XE9/uGnjsBybmsy4ZOT38LIgbI2MDwaEY9hTPgzzKQczEKj9pMdmPmglJ+e7niIAUt/kPMzmXr2SNqeczC75srVm2Sye/7hTwEggVZPcG7ThyX828WrYsO5NuWs8pTkjzs5gBnhyvJRdP6DEL37V1MXn4pXBmTN5O5ioPgjeuWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(26005)(6506007)(66946007)(6636002)(8676002)(53546011)(54906003)(66476007)(38100700002)(316002)(6666004)(66556008)(6486002)(8936002)(508600001)(5660300002)(86362001)(4326008)(83380400001)(9686003)(186003)(6512007)(6862004)(33716001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qb9ukCp4JIV7wuqbjkHD7Ia7p5OqwQubIe29IUovk5Gh5sg8SbMC8dwDPzBq?=
 =?us-ascii?Q?F61dYiTeYX2FXxpzprmsTapPexZW74c2ewj2tC1ujNK+5zvsSKZM6VNLYW5o?=
 =?us-ascii?Q?YViyAn2w3dC+PxtFxL1VhP3haEqjyXjpbN8vKmWsWlxHFMD90K39vPBLKTtA?=
 =?us-ascii?Q?tquhahIrsw1Kr5PJVMgOqhN9MUCMj7Mfya/w1LXyLgIoLNlptF5uDQxzSg5D?=
 =?us-ascii?Q?7xFmeYJmBhlSfH17xPqpprXnW5esnOwEZNygLTa9DWkyNvvy717wsOELKsQ8?=
 =?us-ascii?Q?duT1NKIz2fET95zKECPhWY3G7dLXExFCI/+Vo+z0IXkLXzTvCAOZ3LsNgAPs?=
 =?us-ascii?Q?7OWZM92Ma/vJ9re4ouqMoINDuQsUCagJbPK6ssZLoKJikwWmFoesQID+yujz?=
 =?us-ascii?Q?tT6dwTa367rj9eVPQIWI4rCQEs4qMyxp9h6BuVBdrsQtsazKEtASrUBfbTal?=
 =?us-ascii?Q?Ff7pEDroo+BoxAXRMCuNZYGJ0GCaXseT5yuUF0qyxpW2uO9dREy0j/K83D6Q?=
 =?us-ascii?Q?O/NKTVtgZSubOXsAxliVqdaBJgLhhIvxqtlvnd2b0XQavoa1mL312arBcWtE?=
 =?us-ascii?Q?bkNCWF73rLDYBIB8otBMZv9n36fwSA6RyV5yuFprjZcy55nwHeE1SuWrCSfy?=
 =?us-ascii?Q?CQeaz4SZc2sp6cTKX9lWzVfFmdNZnjSPSm2sVnvgcipK/z9+wSKQmbWsU1f7?=
 =?us-ascii?Q?XVBapFHcyiUjROR0QrmlqQ8QyLQIuM7WFyWaHmu60k+N1O1BrfarPovhuQ8R?=
 =?us-ascii?Q?3dQWxTC9UxlW+h6TsmD6WM89BBL7tBtQ08o5jwC/shBJAaqX5anNfVpq0TTA?=
 =?us-ascii?Q?CbMVrP7TrdjBdieA1JWMuuthHZ7SmueQZ9Wfrjc+i+aW7PfQXtLXTWh9Xihf?=
 =?us-ascii?Q?fdiyEpNBK9paYmuYmSZrArpnLoNCnjAzj9JwgB5QfUhTd6KnnugZIVXeGO/c?=
 =?us-ascii?Q?c9YDq7joc7BMkNzmk9uk2GvwR8z3O9OUm4PsXAf6SRccFCCptTmENDw+gKE5?=
 =?us-ascii?Q?Mk/EPFsuod1kRXuytdHPRP5AIddh114btB7LzodREkmickixpSUV/x11fAwo?=
 =?us-ascii?Q?PVfuhr59RML5KbhnUS9kQ+eMmCbCBqaEf9APUwRvCFOkz5nM4gQpTgUQHhdO?=
 =?us-ascii?Q?fkD4xuNOxF52dsuhMUZUmwrSB1uyigqt6GthwNDApiOUyaR7hVsOzyeKI2/N?=
 =?us-ascii?Q?sciwYamSNBLZtpxYJ+irA2BR0q/cE8EhF0rKEKCXGZfB7NDyFzCM7b73PMt5?=
 =?us-ascii?Q?YIdePARFVFjrcb2Pso8gMvHM08T6Gde19K4rCH3UIUFturY5PaikHFQKauzz?=
 =?us-ascii?Q?myb8UiVs7PMFgesmolH4dZGNVLiMrB4sW4ODYFfr5SsDcuCMPobfy2GfOn5Q?=
 =?us-ascii?Q?fkyAoaouKAIqPw1vja17vnqFScGqGuOycbCwwV3KkfSHCetqt/45GFecp8Ut?=
 =?us-ascii?Q?1alwyH7xRnzKFrNPcnvUlYtErAWdnb7F29d7otwdyibXhs4I8BXGBGRZhHck?=
 =?us-ascii?Q?GNlx4ERszp5px3C3c9W4DT1HaZv4hGBTnuA7haBQHx/kA9sUkqsYaW6j0b1n?=
 =?us-ascii?Q?UhS/yfOCrdSDzsxx11hq4VrP4Wd0koVVGbplpTvV6hSfMM9wAw3ok4/oMb1z?=
 =?us-ascii?Q?IDwa4nCGLebnUCz4Ia21ksI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9988eda-de55-4e8e-05d1-08d9bb8c3a16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 03:21:59.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3ALkSFBOS8F5+S9mGtF/E0v31/ziZDJVJM4EHY9zC4rVmsMIj5ZLsgAX5wcj+hb/dgrRyBtdroznEuKrw2kxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/10/ , Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Yu, Lang <Lang.Yu@amd.com>
> > Sent: Friday, December 10, 2021 10:34 AM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
> > <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang,
> > Ray <Ray.Huang@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > 
> > On 12/10/ , Quan, Evan wrote:
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Lang Yu
> > > > Sent: Thursday, December 9, 2021 4:49 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
> > > > <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; Yu, Lang
> > <Lang.Yu@amd.com>;
> > > > Koenig, Christian <Christian.Koenig@amd.com>
> > > > Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > > >
> > > > SMU firmware guys expect the driver maintains error context and
> > > > doesn't interact with SMU any more when SMU errors occurred.
> > > > That will aid in debugging SMU firmware issues.
> > > >
> > > > Add SMU debug option support for this request, it can be enabled or
> > > > disabled via amdgpu_smu_debug debugfs file.
> > > > When enabled, it brings hardware to a kind of halt state so that no
> > > > one can touch it any more in the envent of SMU errors.
> > > >
> > > > Currently, dirver interacts with SMU via sending messages.
> > > > And threre are three ways to sending messages to SMU.
> > > > Handle them respectively as following:
> > > >
> > > > 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
> > > >
> > > >   Halt on any error.
> > > >
> > > > 2,
> > smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> > > > for longer timeout cases
> > > >
> > > >   Halt on errors apart from ETIME. Otherwise this way won't work.
> > > >
> > > > 3, smu_cmn_send_msg_without_waiting() for no waiting cases
> > > >
> > > >   Halt on errors apart from ETIME. Otherwise second way won't work.
> > > >
> > > > After halting, use BUG() to explicitly notify users.
> > > >
> > > > == Command Guide ==
> > > >
> > > > 1, enable SMU debug option
> > > >
> > > >  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > > >
> > > > 2, disable SMU debug option
> > > >
> > > >  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > > >
> > > > v4:
> > > >  - Set to halt state instead of a simple hang.(Christian)
> > > >
> > > > v3:
> > > >  - Use debugfs_create_bool().(Christian)
> > > >  - Put variable into smu_context struct.
> > > >  - Don't resend command when timeout.
> > > >
> > > > v2:
> > > >  - Resend command when timeout.(Lijo)
> > > >  - Use debugfs file instead of module parameter.
> > > >
> > > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
> > > >  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
> > > >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
> > > > +++++++++++++++++++-
> > > >  3 files changed, 27 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > index 164d6a9e9fbb..86cd888c7822 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct
> > amdgpu_device
> > > > *adev)
> > > >  	if (!debugfs_initialized())
> > > >  		return 0;
> > > >
> > > > +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> > > > +				  &adev->smu.smu_debug_mode);
> > > > +
> > > >  	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
> > > >  				  &fops_ib_preempt);
> > > >  	if (IS_ERR(ent)) {
> > > > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > index f738f7dc20c9..50dbf5594a9d 100644
> > > > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > @@ -569,6 +569,11 @@ struct smu_context
> > > >  	struct smu_user_dpm_profile user_dpm_profile;
> > > >
> > > >  	struct stb_context stb_context;
> > > > +	/*
> > > > +	 * When enabled, it makes SMU errors fatal.
> > > > +	 * (0 = disabled (default), 1 = enabled)
> > > > +	 */
> > > > +	bool smu_debug_mode;
> > > [Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that
> > in future we can add support for other debug features.
> > > >  };
> > 
> > OK.
> > 
> > > >
> > > >  struct i2c_adapter;
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > index 048ca1673863..84016d22c075 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
> > > > smu_context *smu,
> > > >  	__smu_cmn_send_msg(smu, msg_index, param);
> > > >  	res = 0;
> > > >  Out:
> > > > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > > > +		amdgpu_device_halt(smu->adev);
> > > > +		BUG();
> > > [Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and
> > Andrey can share you more insights about that.
> > > Do we still need the "BUG()" then?
> > 
> > The BUG() is used to explicitly notify users something went wrong.
> > Otherwise userspace may not know immediately.
> > FW guys request this in ticket.
> [Quan, Evan] Won't drm_dev_unplug() and pci_disable_device() used in amdgpu_device_halt throw some errors(on user's further attempt to communicate with our driver)?
> Also if the purpose is to raise user's concern, WARN() may be a more gentle way?

From my testing and observation, it depends on what the driver will do next. 
Probably trigger a page fault. If we don't connect a monitor but SSH access.
We don't know what happended until something like a page fault is triggered.

But here what I want to do is throwing the error immediately to userspace.
If using WARN(), the user need to poll dmesg to see if something went wrong.

Regards,
Lang

> BR
> Evan
> > 
> > Regards,
> > Lang
> > 
> > > BR
> > > Evan
> > > > +	}
> > > > +
> > > >  	return res;
> > > >  }
> > > >
> > > > @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
> > > > smu_context *smu,
> > > >  int smu_cmn_wait_for_response(struct smu_context *smu)  {
> > > >  	u32 reg;
> > > > +	int res;
> > > >
> > > >  	reg = __smu_cmn_poll_stat(smu);
> > > > -	return __smu_cmn_reg2errno(smu, reg);
> > > > +	res = __smu_cmn_reg2errno(smu, reg);
> > > > +
> > > > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > > > +		amdgpu_device_halt(smu->adev);
> > > > +		BUG();
> > > > +	}
> > > > +
> > > > +	return res;
> > > >  }
> > > >
> > > >  /**
> > > > @@ -357,6 +370,11 @@ int
> > smu_cmn_send_smc_msg_with_param(struct
> > > > smu_context *smu,
> > > >  	if (read_arg)
> > > >  		smu_cmn_read_arg(smu, read_arg);
> > > >  Out:
> > > > +	if (unlikely(smu->smu_debug_mode) && res) {
> > > > +		amdgpu_device_halt(smu->adev);
> > > > +		BUG();
> > > > +	}
> > > > +
> > > >  	mutex_unlock(&smu->message_lock);
> > > >  	return res;
> > > >  }
> > > > --
> > > > 2.25.1
