Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDEAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 02:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C272A10E9C6;
	Fri, 21 Jan 2022 02:32:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D60E10E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 02:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As/fOkjH67Mbjw+ZjLn4kTXcDvEV0Ubk7SNuJbTQURHAfcriYJgJa6QKO5XuFaGXc9A56AiSwy9XO4jcbjsxgonQvyVi3rbviNpFrs0z65E+HnJFMoVs0gEwKaIFQ/JSMfea6pLPM/NQYEtgbNWl+M5V2Q/F9Q2XtprqDq6B0mdcjVMDsH9BrsV32hkLjmYEfF/0u1VPla3LIuY6/cQxsO6ZcluUKljx21qXnyL+bEGqART9iR6gnw/BgyrvNZgwdbq/D24id3JE9Fkcy1bb2Raq+HZI+YQQJJNuYGsmBdrTZzpJlIVoEWFEQEUTPSXOVkrBGgRlp4LV1TnDHEss7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tnftSHrHE8rVqQ3RjM1nauWgVTul+7ystes3RMqqKM=;
 b=FeB5wcvwh/MsF2FliSJ9JGMZmMFUTw88JlB8AqxWDICl/AET05Wym+v8LlJsmMVH3QYkOw/XpXsfXDcJZaFl0SsQZJU89PVUF83WOU4qgO26HSIQBNC4+nwBRY4qsvlDC1gu8w5LhuKh4ye0al2t2rnpoQ8HvwmY/7Y/QOh7k1NezErlMsz0rU/4dUMwdDlNClyWXfgSJUOCaakzR8guJEOmSsKBxNUxy8Ojg2mAI9ZAqkFRR1NnjaLHp663017NzHaH8p9YSA2ZbS1a3pR5bu7Cy0K2cyiCFSCwI+J2IGeWNVYtByCVBQXFq83J8dyZNu+4kC7oGh15EXAFg6iGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tnftSHrHE8rVqQ3RjM1nauWgVTul+7ystes3RMqqKM=;
 b=uiggFT1pbDxT06Sn/IC8Vu5TMjvwIncy8o3BEiA8ysABvMcWYLQGd8ggIZjhp4z+nrx0wA3C06KkgGCEWibMBzNpIdy1k5qus7hUNXKNCLrM0jpEdLJd3kG3XGntN5Pu6LmynfLX1X61qWE0yxJj/R2fkhiWCHjsIbYLkjqfFos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Fri, 21 Jan 2022 02:32:13 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::7d76:70fa:1f4:2e22]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::7d76:70fa:1f4:2e22%7]) with mapi id 15.20.4888.017; Fri, 21 Jan 2022
 02:32:13 +0000
Date: Fri, 21 Jan 2022 10:32:02 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable amdgpu_dc module parameter
Message-ID: <YeobIiFQTVSeSO6M@lang-desktop>
References: <20220120062504.565239-1-Lang.Yu@amd.com>
 <CADnq5_McP3zr6A+Ke8Uu=MZUAftT7qJeZM60H7vF0Ys+ieXYtA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_McP3zr6A+Ke8Uu=MZUAftT7qJeZM60H7vF0Ys+ieXYtA@mail.gmail.com>
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b8edf6-1e1e-4829-c834-08d9dc863b4c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5186:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51864CC84B37E58B1CC9DF5AFB5B9@CH0PR12MB5186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaDQ31cH/U88O+muAfp4XL7mE3jU5iI71745PdJewQ+qLx9nTABz4qbPNvBxez7hgGOyt2dro3rEKsyRdTrujhjc1WyrDtnyA1uFX6awkJeUTiUeT2qR0eqskS3oMYLcKs7JZTyzSUzzEuNCDRMh/7v6vMDcju/4gXg/mN45PiNiTDkyRARLwb+nc2pBxP62an5g+RP8tzXt0P4nQfCGvzY0GQNLG+n37YKJrYBLo497KFeO8kURXTkAOefdyhBztCrAJOlYsj1+5AWVvEI7hSGoMJE6uJ2wacDlijBMnEguV8rpEv5FRN0mQNGkk/X5GOqMbimtjbgj1Rsh0Hd/z4q0EL988Wlqthqu+UhaxXCiwP94TRNo0x3tbPW9/HJZw6lGbIuiJvlrpTEcqx0ZZjyhAs/tyhTWp1vWFzadyP8RCJNczKbvFBkpr8wRkL1q89d8Sm6xJUO37FgRUt9grG/k0L103y2qKQHlxC+6NHucNWXy+1D8gw92X/PSAO/eKLPewYYd1BmyTAL6HZyNt5fOAfPyeTm2aDWImDSJstqUgTWRW4RTONsvt4ofl/BgLDy20G4RuyEBnwRFwJlxohOZTT8vf3Nds5lJZZFZzZ0UF2gD5RyhWtiT3Wjn7Jtjy2978VfFgpmiRyZL2qtI8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(6916009)(54906003)(26005)(86362001)(316002)(66946007)(83380400001)(508600001)(38100700002)(5660300002)(186003)(4326008)(6666004)(2906002)(6512007)(53546011)(6506007)(8676002)(33716001)(9686003)(66476007)(6486002)(8936002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R92gmRXRMZ3JjZZXmLXZxw69gflS9rRbRM4BRKDWeRT8RxU4TkXKlggVfSf4?=
 =?us-ascii?Q?0BR0YNbZCwnGqP0ZxW2VL9pUWsNuOKZYlk4AQQfhj5hDzqXHfSXimZeJISsc?=
 =?us-ascii?Q?aKrzph+oRGUWKZDL/r0KwK+Pog3DqJ/UXH3Yvze55ptuZDh7TrGi9ulvZo+W?=
 =?us-ascii?Q?9wNTt17DZY6eoWQpKuuz08fWfYV5cq9S6rYJpvsIQBCJ5tWJn8hXvNo8UfLq?=
 =?us-ascii?Q?5EX1ZCMFcufkrOoK5wSBfUvbT+tgjhU7j8inGwPnbNBI5rMQlRABShZIkVXl?=
 =?us-ascii?Q?r0gHi7NHe6PqmLJ1A5TzVGSBvSJUrmJuXrRI0LhgDUdSevdA6puWom4xKlIF?=
 =?us-ascii?Q?+YfCqHhIWoIT/Dqe9fB6+fL1jsPVIsF863G8w1GyZCABbxWAGavFetbw597b?=
 =?us-ascii?Q?drBtuXpA6vqL0KFLxIPA6TuN7qqMKD8Setff7v+c/gjKucUXAocLdsFBLJEG?=
 =?us-ascii?Q?64/xK8JUGGIAZw8FPar9I2XVGoNvtCIPkrZchtPM4VajxLuIqP1cPEW6iaW0?=
 =?us-ascii?Q?9LqLxRMJqYISI3BgZzid7YugK0whTlkaPoF5yaPbbp9HE0A7kc/aiYock6F6?=
 =?us-ascii?Q?ZpfYFUv349XoYMp/ArqmYg16eg1Q+0l56BnU3bNJIV5khl8GPBxdtmDnX1jj?=
 =?us-ascii?Q?LWR/n/TNFAMrdDXHpBQUk70Yb+EnRbZ46VeAfzzPcY+8R2CDTuToXQIdaZZs?=
 =?us-ascii?Q?AwYIMzk7CA+I4mqY4EgnB2y5eL1srQPp0r0zSO54xENl6pK6ddZ7qfIPxuWR?=
 =?us-ascii?Q?nN40nFdkvEfmKCIuYflKwcwNC2hiqwiIn+lZ0+Rewju1IvM6tFvJa1+d/SI6?=
 =?us-ascii?Q?PWbLqxtxggnGKUJmSk9UVnbAVBJluobS2XTkeDvQ+0oOa2E2b0lUC2Vp7TP0?=
 =?us-ascii?Q?of2iv4kzF7Xw6M0LXm5gey1zfKDCwgdsrR7RVFLLnylslDJ2exC3dQIB20PP?=
 =?us-ascii?Q?W93RDBhA72NQztq8+9Ul5+gPeV/T+3VMk/Zkh6TD3R3X+Daotd7RTzTrorze?=
 =?us-ascii?Q?HXKdlCz2+8WbQToS0D2kLIM4UWstL3GCirjnJF8P/iPKmcyGKkbWNHf2QTsk?=
 =?us-ascii?Q?ngewFIRvb45kC1JWehV6pL8yc9bKzdtj4KaTH5oZLvZDfmBVUZF1MpuTMPS3?=
 =?us-ascii?Q?cMW/6Ewzsbou8zeyU+WIz66FkzZFuO3s/RNTz0/BUirqNGYFdwtbysh43gmS?=
 =?us-ascii?Q?YqfgBF+ZryreFOP0tQTNchzkUchh5Y3nLOG2OcX2z1uU05V842LiyGyEH+qR?=
 =?us-ascii?Q?A4TDKgdciVw/6/hwTVBh3ZjrQGF01kcJE1vH/XFSkXgqtsRSyKlaqCImuDu/?=
 =?us-ascii?Q?p0X5JSHh02otlu537NOiJSuVQ12MRlre0qoD4kXMuyjkT95eG6/69pfWA8ir?=
 =?us-ascii?Q?Z74i++YMEmvddb669yRoPA2Tbfq/kclQns5aeih3CSDzcvqgKcUXz4FJKySW?=
 =?us-ascii?Q?/b0UvEJwaE8ecVV9KlM9XmNtBXZdl6aFK9ClSVdpmGW0+ilyVCJggkL36wSQ?=
 =?us-ascii?Q?9WP3HpyWhxUgRPTmb5VrRuvi2hbzjcQLNAsZ73zUjsj0iL0pGHYMW2mo4ZZ6?=
 =?us-ascii?Q?GxoLd1BS4ZAYWKHt444ujOkCO7utLw+qx0ZZ7wUlDWMTPFAad7ph1t5dhIjH?=
 =?us-ascii?Q?uVtk0lydtdHjOoFvpTPvwoE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b8edf6-1e1e-4829-c834-08d9dc863b4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 02:32:13.0751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvRfOy6hpECjdpSxkerT8X3cj65nP+4ICgoM8HiO1Vz0lf6VNBz5MUMKwmdYKnv42/+dVUVAN+DGDVyYjxbAdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/20/ , Alex Deucher wrote:
> On Thu, Jan 20, 2022 at 1:25 AM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > It doesn't work under IP discovery mode. Make it work!
> >
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 07965ac6381b..1ad137499e38 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -846,8 +846,14 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
> >  {
> >         if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
> >                 amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
> > +               return 0;
> > +       }
> > +
> > +       if (!amdgpu_device_has_dc_support(adev))
> > +               return 0;
> > +
> >  #if defined(CONFIG_DRM_AMD_DC)
> > -       } else if (adev->ip_versions[DCE_HWIP][0]) {
> > +       if (adev->ip_versions[DCE_HWIP][0]) {
> >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> >                 case IP_VERSION(1, 0, 0):
> >                 case IP_VERSION(1, 0, 1):
> > @@ -882,9 +888,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
> >                                 adev->ip_versions[DCI_HWIP][0]);
> >                         return -EINVAL;
> >                 }
> > -#endif
> >         }
> >         return 0;
> > +#endif
> 
> I think the compiler will complain about this.  If you move the #endif
> before the return, the patch is:
> Reviewed-by: Alex Deucher <aleander.deucher@amd.com>

Thanks. I got it.

Regards,
Lang

> >  }
> >
> >  static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
> > --
> > 2.25.1
> >
