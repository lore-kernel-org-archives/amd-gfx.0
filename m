Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A81DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 09:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8368A10EAB1;
	Thu, 28 Apr 2022 09:24:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B4D10EAB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 09:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyngzIiBAsUcJmNdC7BEsN6XBwowftHLc6JpgFAHnsbzW4P89gG6eVYStoCh0jlCPXf/6+3CMKvO3Cbp5uxicy0/ogrRujj+FOC/cEzU+nB5jo6dFK4IdndXVlI4AMrfuXWIegX1xiPEbhrXnMIR9myCw9jOK6PqeSBsaRd3jR3vX2hczX016KefpZRykfytkwukPPszY4AW9SoHm4DgcEgO3RcQiOEHa6pxXRmy92/O5kZVcAKKnUPu6lpv83CHnt128Xlk9nTYPFZzgl39W1GVFRH46+4guRLqtpuYF/3ftr+RnHCNVKyqmvpnAjYI68BRi8YwObYnZ2w2uSXikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ghf7Quc9hUW4nypq9d2Y0nnHC3C9zV3M9Es91DjPow=;
 b=n8J4VQRUVEVBSsugttFpjH98JQedqOSU5/bI8VoWJvGCpfH/2PzUcJKwlyx0VhEosuxFkbNeL4BgMZIYqC0CcXnbm576NRIlF4DrRItHJdCpmcAOI1I7W7wx1+QptsrUd1fQyc6c9HVsx4gINc4zCUiwkri5/r86EUnYlnqRnMq72JmGCIEinQRgo4lT8m0nsuvTgwnG5cW1e5Um508l4fHgEjN+rJzOlKx4A6EsRxkxIRQvuSKpsFDKNh2ezqu8QvERo1MIbp2+sMGj6SEN08TeDmfY6O7Bt4dy8Rtpfky1jY0wUDJXDtp/UES3EtXyyXPTeJjkoXv/bUFG4KuX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ghf7Quc9hUW4nypq9d2Y0nnHC3C9zV3M9Es91DjPow=;
 b=kNFIOsilv/U7T9fZXc4f9uF1jtwpRsdT+X5BgKYkJXElSUHrzw6Mhy6NGgkv4itemIMI+W6oi+sSayss8llrAJ+FRDlq14nPLfrD1s+CXV4+84NJusnHjKrkdXn7AdEpc0RSsjnC5btSttKNzIfft13/rTcwhXmcmNZpPQ7uPNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 28 Apr 2022 09:24:45 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 09:24:45 +0000
Date: Thu, 28 Apr 2022 17:24:36 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Haohui Mai <ricetons@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <YmpdVIgv6iPsXqik@lang-desktop>
References: <20220428021109.2571-1-ricetons@gmail.com>
 <05b5464c-9d2c-844a-ef0a-818d04ed9592@gmail.com>
 <YmpRi8LXk2Z9o1Dh@lang-desktop>
 <CAHpOOhHdN_eb5u=M9FUTX==r4He3dik--tXHHJ39dKGfcYPi2A@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpOOhHdN_eb5u=M9FUTX==r4He3dik--tXHHJ39dKGfcYPi2A@mail.gmail.com>
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f52139-55a8-454e-122c-08da28f8eeae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4893AEA65A8B2C60BFE326A6FBFD9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGzi6SImpGQMTTGeia5o5seYDKYkAOrmq2YW+rFWvbTK0Oi+OQFnAIaSio8cbu/7UU6RnuSi8Q+4evrcou8qGocUzh2kgnQZBB40F1VCWKm4HdXYXvESPys1sc4VMokrjYSp5tm3krCFFdccEpda/LJbgMTMqwfmJGy5utjAJViC0raS7RBXIwLhHVoJf+40E3UBgttDqjoB6xym23RzDuQlmE0UI6od6kuIJWS6I2oiwL1dJLsmZ7MR07wbrRckanOGGJpr0y4d3jtHx1mvQ8JoWBWj0YkYu0BOLkFaC4qXGku2et+QXxSKDfI364DnUQy/gCbLeiKDAG3gDghkwPxP0BW7co1y9k5dWZvRzksyIEvZ79KesLIMEhnqYyBIWIV0US1H3DtZWsWs+ndCsOPYbSLCHwo5F9G46sA5xvRQA3fTto6/S80WLN55MZ41N8w4h/FpJ1EOvSzvFdben4S8yGvMA6uG+AKKswkT0F0LsWe1s1N46o5pLXVoLlbx/rXbnCgydsqo3h/qlNz8/PuavzWonOJoJ0jkiyxrQcv3m5QFfk+HwCqCcsduhL2OCPMliNUy0y0qz1dz4/G2Tchq/nABs4LoJGeB91aXEpD+t1jFv1Jsr5OBBlHnsiZvYp3M+dUca1rAqDMqHpVieg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(316002)(9686003)(6512007)(26005)(33716001)(86362001)(6486002)(54906003)(5660300002)(4326008)(508600001)(6916009)(8936002)(38100700002)(6506007)(53546011)(6666004)(66574015)(186003)(83380400001)(66476007)(8676002)(2906002)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?05gKwiFQ4Ty31Ue3mz9wGSWrSpM4RGJ56wKXWp7bFQ/H/h5keFjA6+fiNI?=
 =?iso-8859-1?Q?qQvTxBptmamvLUCnMTdWgvLOYXiaFUVPVo1509xK6TI+wOK+TMxGKee2Ye?=
 =?iso-8859-1?Q?J+b9+8RGeYVo9ES5Yq99Ap/7ew45EhPPJUQoXVacMLnF5pVa5JBi0XjsHT?=
 =?iso-8859-1?Q?ksBDxNulPDX/iUKp+Mx1x0fkiAZFVp3fnKsYeRStb8WnPPtLAnpmwWCq+U?=
 =?iso-8859-1?Q?ZT/TflFgb0PbNsGWTG0OIjDh9Wm0kzeFCKQ7vZFSEFnh/I4X2xZF8d1DMM?=
 =?iso-8859-1?Q?f/v0MTpZV3dAID8wJ4B8fcVDnFXuLIfODBWBBHm+I9JeICx9I9eFUs2nQl?=
 =?iso-8859-1?Q?MGpokf7GWBH/3WaUof8tAkV8QtQla4ZPpYMN3uCYnZm0Drhcgn02+3fn+c?=
 =?iso-8859-1?Q?biMozOdfb1VjugNCJHUtVpWYhl3JlfDKYw854O7tOuIpMJB21jSN8HjSj2?=
 =?iso-8859-1?Q?NM6AbqWQ6KfiPBY2hUVIg3nFPCy9b3Igw6BYrLv578SB0JoRPCsOvz7uy0?=
 =?iso-8859-1?Q?SSYR2uJCIFbBflikra7bnh9cFwLCbpJKpGtQA2Fe+x6cTsSnfSL5vA4Rqv?=
 =?iso-8859-1?Q?jj262WDq4fwdoufTr32FJmOmcDWuulg+Tbrrfgy+vMa0AJAwYcAts7vOY4?=
 =?iso-8859-1?Q?6OzxdlZqHtnrEToN4WLVn0M3tLtgST/lL0vLs4OQnmpNryA58ZmOlX4gsm?=
 =?iso-8859-1?Q?xiP3nfRtJOXnYxKACyjG+0ireGPa83alcwVHBOYsISS9nbQ9ullvsS6HNK?=
 =?iso-8859-1?Q?GpFsSHBsW+BKF1Z2ni04qQFXhwTvlp8auvXxkeaZCYMZZD+4zrdt3U84E7?=
 =?iso-8859-1?Q?a2nofoWydpccdtBHyrd9qWv0Jz5Kenwq29CpWRs9RnQOHdV6mEWESoUY7P?=
 =?iso-8859-1?Q?HW2eferT35wvqQIRcsUky1X+mx+fQXMm7PLHPNUJv1/QmXo7lpGA0ZNQUi?=
 =?iso-8859-1?Q?ufETe28LGB9Jzun5w1+MV+aTRpwUSboyYETxYbYyJclKXf54/5VordmQm4?=
 =?iso-8859-1?Q?2YlB2KycG+qUyZzO0ooydzim+U0mIIXofaobNEbX6Tz6fHwHAM1izoN2Fd?=
 =?iso-8859-1?Q?QHRlksUsuJBSv3sZNGQJqIy3jVTikTMgRM3gJvl4SaXlOclzr04EZdx3UJ?=
 =?iso-8859-1?Q?L7+eGf7B/KII3QuvMPQY/gd4wbux9Bl0ArQ+dmZiLMKbYIOc75WpEylJV1?=
 =?iso-8859-1?Q?+vGS3b/yqMU0KSOMuPpkXNV8kbjvH8KQjxGBDkWsMBZxELmafT5yycFoQT?=
 =?iso-8859-1?Q?e7d4Af9hL4EoaZB1rnI2IQSIExqB/AKalrfrpqHLS5AGLrbmy8hYQDylkJ?=
 =?iso-8859-1?Q?ARq1KxGzoW66IM7zNI8pgNeUgwtS6js/bzZTAMf7TedUvgLufFFPlZMfD0?=
 =?iso-8859-1?Q?xBVDL2fWpjI3Z5FxyRd2GHuoAymAsMiPN8vOmKGCJ0t8KqPzMZ+HZcRU0a?=
 =?iso-8859-1?Q?M8eI3VtjTOjHMh8mbHIQvWJJgXsIKDPXTfXYZgFygOG4lH1Xm083jc2yq+?=
 =?iso-8859-1?Q?o+0QklR6jb+GgPWs/f/4TxWBtTH62I1j/7sNxMkv9flKvuwdCdxhrP7XJi?=
 =?iso-8859-1?Q?F1At17vhJH770Xn9a0aOLniLjS2U8Bqo7YGShnWhHO0c2VvhD/kQOlrXcU?=
 =?iso-8859-1?Q?17/zSjDEX3VnT03ly0MHPHMlPvqqdK5VXz0k89JWsPqxB/hGF9UQwWczFv?=
 =?iso-8859-1?Q?oL97nS2vvIQIVwXWaMHkvDJZBQsm5Nl8XQzFBGEa6rXpJvyPekCMdkMwX4?=
 =?iso-8859-1?Q?n0BT1m4Z9rIUpuyRE1HG0kpw7pC0XWS4dntOwPAKqr0P9Db8QM8LZUG1wn?=
 =?iso-8859-1?Q?zYSxNqZN9w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f52139-55a8-454e-122c-08da28f8eeae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:24:45.0388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geTDeyjBrMvZKfiC7f3NiTnKEltHxSwjRR8oB8dL8e0v+vbt5BkK6L+2zf7C2/11OCgvZYRjjMwc3Pn2/klQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Haohui Mai <haohui@alt-chain.io>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/28/ , Haohui Mai wrote:
> sdma_v5_2_gfx_resume() sets the bit to unhalts the engine for each
> SDMA instance.
> sdma_v5_2_ctx_switch_disable_all() halts the engine.
> 
> Do you mean that the engine should be halted when
> adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT?
> 
> ~Haohui

Yes, as far as I know, ucode loading sequence should be:

1, halt the engine
2, load ucode
3, unhalt the engine

Regards,
Lang

> On Thu, Apr 28, 2022 at 4:34 PM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > On 04/28/ , Christian König wrote:
> > > Adding a few more people to review this.
> > >
> > > Am 28.04.22 um 04:11 schrieb ricetons@gmail.com:
> > > > From: Haohui Mai <haohui@alt-chain.io>
> > > >
> > > > The patch fully deactivates the DMA engine before setting up the ring
> > > > buffer to avoid potential data races and crashes.
> > > >
> > > > Signed-off-by: Haohui Mai <haohui@alt-chain.io>
> > >
> > > From my side this is Acked-by: Christian König <christian.koenig@amd.com>,
> > > but I'm not so deeply into the hardware programming sequence to fully judge.
> > >
> > > Enabling the engine first and then setting it up is certainly incorrect, but
> > > could be that I'm missing something else. So please guys take a look as
> > > well.
> > >
> > > Thanks,
> > > Christian.
> > >
> > > > ---
> > > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 110 +++++++++++++------------
> > > >   1 file changed, 59 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > index 013d2dec81d0..a22aafd2d7f6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> > > >     }
> > > >   }
> > > > -
> > > >   /**
> > > >    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > > >    *
> > > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> > > >   }
> > > >   /**
> > > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > > > + * context switch for an instance
> > > >    *
> > > >    * @adev: amdgpu_device pointer
> > > > - * @enable: enable/disable the DMA MEs context switch.
> > > > + * @instance_idx: the index of the SDMA instance
> > > >    *
> > > > - * Halt or unhalt the async dma engines context switch.
> > > > + * Unhalt the async dma engines context switch.
> > > >    */
> > > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> > > >   {
> > > >     u32 f32_cntl, phase_quantum = 0;
> > > > -   int i;
> > > > +
> > > > +   if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > > > +           return;
> > > > +   }
> > > >     if (amdgpu_sdma_phase_quantum) {
> > > >             unsigned value = amdgpu_sdma_phase_quantum;
> > > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > >             phase_quantum =
> > > >                     value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > > >                     unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > > -   }
> > > > -
> > > > -   for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > -           if (enable && amdgpu_sdma_phase_quantum) {
> > > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > > -                          phase_quantum);
> > > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > > -                          phase_quantum);
> > > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > > -                          phase_quantum);
> > > > -           }
> > > > -           if (!amdgpu_sriov_vf(adev)) {
> > > > -                   f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > -                   f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > -                                   AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > > > -                   WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > -           }
> > > > +           WREG32_SOC15_IP(GC,
> > > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > > > +                   phase_quantum);
> > > > +           WREG32_SOC15_IP(GC,
> > > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > > > +               phase_quantum);
> > > > +           WREG32_SOC15_IP(GC,
> > > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > > > +               phase_quantum);
> > > >     }
> > > > +   if (!amdgpu_sriov_vf(adev)) {
> > > > +           f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > > > +           f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > +                           AUTO_CTXSW_ENABLE, 1);
> > > > +           WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > > > +   }
> > > >   }
> > > >   /**
> > > > - * sdma_v5_2_enable - stop the async dma engines
> > > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> > > >    *
> > > >    * @adev: amdgpu_device pointer
> > > > - * @enable: enable/disable the DMA MEs.
> > > >    *
> > > > - * Halt or unhalt the async dma engines.
> > > > + * Halt the async dma engines context switch.
> > > >    */
> > > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> > > >   {
> > > >     u32 f32_cntl;
> > > >     int i;
> > > > -   if (!enable) {
> > > > -           sdma_v5_2_gfx_stop(adev);
> > > > -           sdma_v5_2_rlc_stop(adev);
> > > > -   }
> > > > +   if (amdgpu_sriov_vf(adev))
> > > > +           return;
> > > > -   if (!amdgpu_sriov_vf(adev)) {
> > > > -           for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > -                   f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > > -                   f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > > > -                   WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > > -           }
> > > > +   for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > +           f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > +           f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > +                           AUTO_CTXSW_ENABLE, 0);
> > > > +           WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > >     }
> > > >   }
> > > > +/**
> > > > + * sdma_v5_2_halt - stop the async dma engines
> > > > + *
> > > > + * @adev: amdgpu_device pointer
> > > > + *
> > > > + * Halt the async dma engines.
> > > > + */
> > > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > > +{
> > > > +   sdma_v5_2_gfx_stop(adev);
> > > > +   sdma_v5_2_rlc_stop(adev);
> > > > +}
> >
> > Following codes are missing in halt/unhalt,
> >
> > f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> >
> > Probably AMDGPU_FW_LOAD_DIRECT(sdma_v5_2_load_microcode) needs these codes.
> >
> > Regards,
> > Lang
> >
> > > > +
> > > >   /**
> > > >    * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > > >    *
> > > >    * @adev: amdgpu_device pointer
> > > >    *
> > > >    * Set up the gfx DMA ring buffers and enable them.
> > > > + * It assumes that the dma engine is stopped for each instance.
> > > > + * The function enables the engine and preemptions sequentially for each instance.
> > > > + *
> > > >    * Returns 0 for success, error for failure.
> > > >    */
> > > >   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > >             ring->sched.ready = true;
> > > > -           if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > > > -                   sdma_v5_2_ctx_switch_enable(adev, true);
> > > > -                   sdma_v5_2_enable(adev, true);
> > > > -           }
> > > > +           sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > > >             r = amdgpu_ring_test_ring(ring);
> > > >             if (r) {
> > > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> > > >     int i, j;
> > > >     /* halt the MEs */
> > > > -   sdma_v5_2_enable(adev, false);
> > > > +   sdma_v5_2_halt(adev);
> > > >     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > >             if (!adev->sdma.instance[i].fw)
> > > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > >     int r = 0;
> > > >     if (amdgpu_sriov_vf(adev)) {
> > > > -           sdma_v5_2_ctx_switch_enable(adev, false);
> > > > -           sdma_v5_2_enable(adev, false);
> > > > +           sdma_v5_2_ctx_switch_disable_all(adev);
> > > > +           sdma_v5_2_halt(adev);
> > > >             /* set RB registers */
> > > >             r = sdma_v5_2_gfx_resume(adev);
> > > > @@ -881,12 +891,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > >             amdgpu_gfx_off_ctrl(adev, false);
> > > >     sdma_v5_2_soft_reset(adev);
> > > > -   /* unhalt the MEs */
> > > > -   sdma_v5_2_enable(adev, true);
> > > > -   /* enable sdma ring preemption */
> > > > -   sdma_v5_2_ctx_switch_enable(adev, true);
> > > > -   /* start the gfx rings and rlc compute queues */
> > > > +   /* Soft reset supposes to disable the dma engine and preemption.
> > > > +    * Now start the gfx rings and rlc compute queues.
> > > > +    */
> > > >     r = sdma_v5_2_gfx_resume(adev);
> > > >     if (adev->in_s0ix)
> > > >             amdgpu_gfx_off_ctrl(adev, true);
> > > > @@ -1340,8 +1348,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > > >     if (amdgpu_sriov_vf(adev))
> > > >             return 0;
> > > > -   sdma_v5_2_ctx_switch_enable(adev, false);
> > > > -   sdma_v5_2_enable(adev, false);
> > > > +   sdma_v5_2_ctx_switch_disable_all(adev);
> > > > +   sdma_v5_2_halt(adev);
> > > >     return 0;
> > > >   }
> > >
