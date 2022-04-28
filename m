Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20680C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 14:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8966910E506;
	Thu, 28 Apr 2022 14:05:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEC510E506
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 14:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUMKZqbSJK36Ml1MXLdZL2XGKJuLgQj6CNH8RtfxrDlbDMlmVseBFbtkW3s/Gc5Z/xEUZweN8jbFWud1ZMkkMIdRWo5fjAqGZVBvQC+wt+1xW170F6MxP1NoDZwH8VJqdOEyVNH1fpYJtPx7U9etsNYksJuEH7jlBh3wMfnG9DkxMbrULaEsldIQEH6oD3NWsz5cxm2xNu1NvLTtRxmjqnqE1vYen6inX9VdJ5YzqAcAro4UJRttNkDx/v+Flfq2wmioAqmfmYRlc/35i35ST+zYFicvU2xbQHtuMqjI9VpWs31Hd9zRP3fYne8jQHkYwBndjN3oNlsTjgKHoW0LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYI7hONdYIlB7NidAi3FSIBwUQSgOoyr3crzwhbtuc4=;
 b=OaVG8bqRk04g35vU8UEutxXoknRhf2/cTxcYK1LA4gPqVbpa/Lh3lhy9E/3cBFdXlZ4POyLodF+EKXUqEk9Kp87fyCpl+SqZhjuA9b0Hlli4I7Vh8mlsFxXS+/JAkGgeALZbP8JnYHHBEI21Z5fYiYRtTnR2atCOJrG25sdZpz1h2cnbHAF3ktHS1MrIpYY3oFRs4iiGaSeVDhNKno1/i5KQEJwyPgAogZ0JRTGhnII+8Th6SonDnKpBsAcNjU8E47LWe9ZPbtc+erZkXKEy7hVoAmW7l3Nh1/MA3STzTltooTLC8RA+3wV1OnzdoHlJngfuuXMmAR+cBZLWV7rJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYI7hONdYIlB7NidAi3FSIBwUQSgOoyr3crzwhbtuc4=;
 b=TWu/WzCs7RY5nEx8A+0EgojxN2V16lfcXfHLf44PURQkzfK8+JlX1aeAgUZqdYnufzC9KB/CZWTcrAesGWUmMI+8g58onDNcdRByXBKCEasxsfeKbBW+XX540kSEhvEY0o9QXV89jnsO8ZACP49d5SM8KFFFpOn0NxgkccsVVSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MW2PR12MB2570.namprd12.prod.outlook.com (2603:10b6:907:a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 28 Apr 2022 14:05:51 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 14:05:50 +0000
Date: Thu, 28 Apr 2022 22:05:41 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Haohui Mai <ricetons@gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <YmqfNbHqsuE/erWL@lang-desktop>
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
 <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e124cdd5-0155-4b3d-5d27-08da2920335d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25709456C55F0DF22083091FFBFD9@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEt/0oXRm2rQCN9T7KEMJKUz+9zLh409657dezIqvOIl7Fcjpb5RMDloVtbiA8Y/LK/dvQaezZd5VvlQKOZULSrPmWzfc1sVfdN7GYLcQWCuEHlm9WjD3yVLzI14zhxHxEt0GCcPMBTMi7iZ0dymR8+P1QIC5u/NmNTYHF6F8CdkQTJrDbeCASlBiB9yWcHA40ANgLXJLmuoYVoJMJRmONGZj0MMZsJV5Pe2UMiaiOr6KHIaHZ1y4AT1zJm+Ppj7PvNC7qgeY1ZSdurYDA2S/pf4qxherki0hZM8hp9DblSK38Mn5eQHQwQzccC9IemQPyP7GkJxnmrsv3gUitSqcZemdU84xpI02pHcfn/S3EF04yDBy9BWg0cC28EHqNqP3EO1cC5zgwQziYuCVv8n5a8aWAPDcxovopWmyUDTEjQSzQnk/JcZH24tIRV8KJddx2y2KxUB9Z7TZ7nY7ij4trFnvApGNAK3p6gstOke6OSjFs2+AWJZXcO9XZkmtgTFUb5Um9cCu4mYfDXPXCocIp9f4zngeQEWh0t3MeCsPVCtS2im9Q2T0HAIl8Cgvip15Y5zwTg2wx8RJs4/+KHM22zDUUmjRqTBr3LHHkaziAd8XWAHWn37NLQhf6SlrLJdtf4/K0NztG8M+D5xWH8//g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(8936002)(86362001)(53546011)(6916009)(186003)(6506007)(66946007)(2906002)(6666004)(4326008)(66556008)(8676002)(54906003)(66476007)(83380400001)(508600001)(316002)(6512007)(33716001)(6486002)(38100700002)(9686003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EvkRc2s8tqDUJKB9upm/zXg+NnBCorIoI78Xt0/Ji63QZfKf2KclMn+9EqqC?=
 =?us-ascii?Q?WQ1+YXwlvDFX9P6KaS1bbTgA3upfoEBpo2AiVg4AvCflJmdc8yJiiOA/Eqgs?=
 =?us-ascii?Q?n1WcIdAY4SBUCkrjBYxiVhalExRug5ZcomCs+wfzFCS9/9gh2Q0rtBbbLJjs?=
 =?us-ascii?Q?d+SvChfDcbFz+2ete89RYVdjfmMec3hZuDyjq5uCpOpU/OcBcpIAVca4m1HG?=
 =?us-ascii?Q?m5xgvzlFyOsL8ZJ+4cpXvMlQhyoFBM240ww2lVYg7HuOJRJ4xHuP53ddBl5y?=
 =?us-ascii?Q?mcpxKtcS6I2hlbwWkFGYvKeKE9KxQjlG8sozFY6+OmmX814JJGZA7d+YqCE+?=
 =?us-ascii?Q?9IQ2z6pchMNxG0cLqD4Rfv6nGMK7hCVhj4mtB5RH5CHf3gSQHNMhssZj6JFR?=
 =?us-ascii?Q?+0wQJqSHZn3BFSOrhQUY+UxmM44Y9d2A/MvqXRkCVJVOMFWsnfdFnkezyR37?=
 =?us-ascii?Q?m4m26cxnP1dh6cd1+N1/ANk3EWMvbYVbAgQjICf91eTCu8Bf4c3TWvO0L1nk?=
 =?us-ascii?Q?dKmKA+t9VN6HHKGvrIwoxXBdh3N5snObKCU+zF1W2sRZGkfrvqES2elAv3EB?=
 =?us-ascii?Q?DLcdyCAwJ+g3bA20UTE2LKqm86aFj7bgMuVnoqbLJ3AdBjOfdC5+WqX4S8eK?=
 =?us-ascii?Q?kACBJVzMIN9iUHeFANPVnPfGorwmTx6m8FYr39LRMz33XB/H9Hksx+VcO4Oe?=
 =?us-ascii?Q?mU+91rDVbcyt1Ui+NLeEPezZPnaZYf+Ym3n7NzyKHb11FRGVhRHFRknB5KSI?=
 =?us-ascii?Q?FOXvHbJnxazXgwNDZDfbbJjnm7godCpIw21OKINLrazN0eeW7ml2DlzLxQbv?=
 =?us-ascii?Q?ZOBOmxjRK2LWV+a2Q4/od4dIckISz6ONnQitgAtGO/khhl1FQE3auSHJgTYo?=
 =?us-ascii?Q?nhVuV+QRdv8Kl3nRcBHYV0zsVivia5fevJjaqDeVOXj5vQ18ZuOQIrUJ5HeV?=
 =?us-ascii?Q?KZWZJdo8Bi0JsAQgVygeE/3XdolrN4EAsZ8NM05O0csgk8OyWAozJ5NYg/kG?=
 =?us-ascii?Q?g3MjZvweEWLCp0LS9QLi9Yx9eiH0MOlO8UauB5qKMpo61Y6GPoCIi0E6vgO1?=
 =?us-ascii?Q?z0Hu/lfsyYAcyzT22hnop1jbBb2yo/pEd8876qDDfmTkiQyLkkpT5nLNPX6J?=
 =?us-ascii?Q?XtbxkEFtWynPoMJF5cQwVwKW7k9qSOMpd+unIL1Syo9NG5NupNuBRVGukzIg?=
 =?us-ascii?Q?mrxtFRjMVp/mUmVD2HgEVLQkvF0Tg6L9dMhSoQB1pmYjH4GtdNiHixvvRWb8?=
 =?us-ascii?Q?F2N+rl/VbpzcPyTEywMhUJ1O/zP/rsEo41SysR/VbrAxWZ1jji7D0Z/tC5J/?=
 =?us-ascii?Q?Lt+i2GqFGXUpACRHypnman94WrR/NJ9iNrNd3BbSdh45Z0gpXaSmoJ/YiTzh?=
 =?us-ascii?Q?JKRLjD+fDUZ1ztVpnYiPfk/o0XO/2A1qM5+Jz2CpLWLdiA5hsz/bjWixuxuh?=
 =?us-ascii?Q?fJ4JbpX0ITe38YN5C5/mtRz1u9vXu8Opu99xWXTMbGI8LjYioiZTycEQi9HG?=
 =?us-ascii?Q?4NeUar5uLl5AT7+4LlKCVKSt+cuZEMvYcGW+WfR6RjxAL8Xb/iiAuT/RQ1TK?=
 =?us-ascii?Q?hCmJSb8fsvd41pyQx5Tc516NQRz3ZM2NxSh9q4bjzA4685lai7um//mIpo7i?=
 =?us-ascii?Q?M5Kmdrceoke40uohRUPjnMNV7hpgtpF7f0hJU7wtjyEmtVz8bPpWFQsnW0yy?=
 =?us-ascii?Q?t9gghthhl3eWrTf0iqLzVdG4edm9q/zo2ZIL7Vhk3F3S6zX9uNLJDMotUsuU?=
 =?us-ascii?Q?Dwprgz9yCQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e124cdd5-0155-4b3d-5d27-08da2920335d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 14:05:50.6763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdJaDgd/zrfs6+bNHuxBmvKPqFuhcWLNY3/4Q78ikigrcfIBPRiTV/L29jSl1GZKiY1IXOAG/xCWjvflFCxuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/28/ , Haohui Mai wrote:
> If I understand correctly, the original code will disable the HALT bit
> of the register mmSDMA0_F32_CNTL twice on other code paths -- one in
> the sdma_v5_2_ctx_switch_enable() and the other one in
> sdma_v5_2_enable().
> 
> The change ensures that the bit is only disabled once. Just wondering,
> which one is the expected behavior?
> 
> ~Haohui

The HALT bit of the register mmSDMA0_F32_CNTL is not set/reset in original sdma_v5_2_ctx_switch_enable()
(https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c#L523)

Regards,
Lang

> On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > On 04/28/ , ricetons@gmail.com wrote:
> > > From: Haohui Mai <ricetons@gmail.com>
> > >
> > > The patch fully deactivates the DMA engine before setting up the ring
> > > buffer to avoid potential data races and crashes.
> > >
> > > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> > >
> > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
> > >  1 file changed, 62 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > index 013d2dec81d0..b000117b77d0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> > >       }
> > >  }
> > >
> > > -
> > >  /**
> > >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > >   *
> > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> > >  }
> > >
> > >  /**
> > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > > + * context switch for an instance
> > >   *
> > >   * @adev: amdgpu_device pointer
> > > - * @enable: enable/disable the DMA MEs context switch.
> > > + * @instance_idx: the index of the SDMA instance
> > >   *
> > > - * Halt or unhalt the async dma engines context switch.
> > > + * Unhalt the async dma engines context switch.
> > >   */
> > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> > >  {
> > >       u32 f32_cntl, phase_quantum = 0;
> > > -     int i;
> > > +
> > > +     if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > > +             return;
> > > +     }
> > >
> > >       if (amdgpu_sdma_phase_quantum) {
> > >               unsigned value = amdgpu_sdma_phase_quantum;
> > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > >               phase_quantum =
> > >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > -     }
> > > -
> > > -     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > -             if (enable && amdgpu_sdma_phase_quantum) {
> > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > -                            phase_quantum);
> > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > -                            phase_quantum);
> > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > -                            phase_quantum);
> > > -             }
> > >
> > > -             if (!amdgpu_sriov_vf(adev)) {
> > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > -             }
> > > +             WREG32_SOC15_IP(GC,
> > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > > +                     phase_quantum);
> > > +             WREG32_SOC15_IP(GC,
> > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > > +                 phase_quantum);
> > > +             WREG32_SOC15_IP(GC,
> > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > > +                 phase_quantum);
> > >       }
> > >
> > > +     if (!amdgpu_sriov_vf(adev)) {
> > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > +                             AUTO_CTXSW_ENABLE, 1);
> > > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > > +     }
> > >  }
> > >
> > >  /**
> > > - * sdma_v5_2_enable - stop the async dma engines
> > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> > >   *
> > >   * @adev: amdgpu_device pointer
> > > - * @enable: enable/disable the DMA MEs.
> > >   *
> > > - * Halt or unhalt the async dma engines.
> > > + * Halt the async dma engines context switch.
> > >   */
> > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> > >  {
> > >       u32 f32_cntl;
> > >       int i;
> > >
> > > -     if (!enable) {
> > > -             sdma_v5_2_gfx_stop(adev);
> > > -             sdma_v5_2_rlc_stop(adev);
> > > -     }
> > > +     if (amdgpu_sriov_vf(adev))
> > > +             return;
> > >
> > > -     if (!amdgpu_sriov_vf(adev)) {
> > > -             for (i = 0; i < adev->sdma.num_instances; i++) {
> > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > -             }
> > > +     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > +                             AUTO_CTXSW_ENABLE, 0);
> > > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > >       }
> > >  }
> > >
> > > +/**
> > > + * sdma_v5_2_halt - stop the async dma engines
> > > + *
> > > + * @adev: amdgpu_device pointer
> > > + *
> > > + * Halt the async dma engines.
> > > + */
> > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > +{
> > > +     sdma_v5_2_gfx_stop(adev);
> > > +     sdma_v5_2_rlc_stop(adev);
> > > +}
> > > +
> > >  /**
> > >   * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > >   *
> > >   * @adev: amdgpu_device pointer
> > >   *
> > >   * Set up the gfx DMA ring buffers and enable them.
> > > + * It assumes that the dma engine is stopped for each instance.
> > > + * The function enables the engine and preemptions sequentially for each instance.
> > > + *
> > >   * Returns 0 for success, error for failure.
> > >   */
> > >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > >
> > >               ring->sched.ready = true;
> > >
> > > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > > -                     sdma_v5_2_enable(adev, true);
> > > -             }
> > > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > >
> > >               r = amdgpu_ring_test_ring(ring);
> > >               if (r) {
> > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> > >       int i, j;
> > >
> > >       /* halt the MEs */
> > > -     sdma_v5_2_enable(adev, false);
> > > +     sdma_v5_2_halt(adev);
> > >
> > >       for (i = 0; i < adev->sdma.num_instances; i++) {
> > >               if (!adev->sdma.instance[i].fw)
> > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > >       int r = 0;
> > >
> > >       if (amdgpu_sriov_vf(adev)) {
> > > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > > -             sdma_v5_2_enable(adev, false);
> > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > +             sdma_v5_2_halt(adev);
> > >
> > >               /* set RB registers */
> > >               r = sdma_v5_2_gfx_resume(adev);
> > > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > >       }
> > >
> > >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > +             sdma_v5_2_halt(adev);
> >
> > You don't need call these functions here.
> >
> > In original code, you can see sdma_v5_2_load_microcode() calls
> > sdma_v5_2_enable(adev, false) to halt the engine before load ucode.
> >
> > What I mean is sdma_v5_2_halt(adev) should have no functional change with
> > original sdma_v5_2_enable(adev, false), like this,
> >
> > static void sdma_v5_2_halt(struct amdgpu_device *adev) {
> >         u32 f32_cntl;
> >         int i;
> >
> >         sdma_v5_2_gfx_stop(adev);
> >         sdma_v5_2_rlc_stop(adev);
> >
> >         if (!amdgpu_sriov_vf(adev)) {
> >                 for (i = 0; i < adev->sdma.num_instances; i++) {
> >                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> >                         f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> >                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> >                 }
> >         }
> > }
> >
> > But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.
> >
> > Regards,
> > Lang
> >
> > >               r = sdma_v5_2_load_microcode(adev);
> > >               if (r)
> > >                       return r;
> > > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > >               amdgpu_gfx_off_ctrl(adev, false);
> > >
> > >       sdma_v5_2_soft_reset(adev);
> > > -     /* unhalt the MEs */
> > > -     sdma_v5_2_enable(adev, true);
> > > -     /* enable sdma ring preemption */
> > > -     sdma_v5_2_ctx_switch_enable(adev, true);
> > >
> > > -     /* start the gfx rings and rlc compute queues */
> > > +     /* Soft reset supposes to disable the dma engine and preemption.
> > > +      * Now start the gfx rings and rlc compute queues.
> > > +      */
> > >       r = sdma_v5_2_gfx_resume(adev);
> > >       if (adev->in_s0ix)
> > >               amdgpu_gfx_off_ctrl(adev, true);
> > > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > >       if (amdgpu_sriov_vf(adev))
> > >               return 0;
> > >
> > > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > > -     sdma_v5_2_enable(adev, false);
> > > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > > +     sdma_v5_2_halt(adev);
> > >
> > >       return 0;
> > >  }
> > > --
> > > 2.25.1
> > >
