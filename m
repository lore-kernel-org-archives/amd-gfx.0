Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9551C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 08:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF3210FC56;
	Fri, 29 Apr 2022 08:32:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AC210FC56
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 08:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVJiMHPFrElMhKavCWVw55xPq7KefR/o6QDgXg+CxI/k7l9DBZ5UoF7Yqge6yp8m13o3MY6GpABLgBjHckNPFkmnus7BLLVClc0adwqrXq/4e0Ty6zVcXdLDl6o0AiuOkEqWiTwHfSG2gPxafG4Q2i6RrO000JhuMPh1UOSlpU7uPEPkrbmJAAuWVyj7j9O1BFALXFF85o1wUnbetWYYA1NsvTTgWGqiB+EPyefbVThHdOr7ZJCHLpO6vC5xdNvSPaspoJkLcXAtN8TBW16MuMRZ+DjHlSwwLedayPZaFBUf3Zwomry1O94NQLxYoUpuFYk0a3fj+KJc2cYXvNB9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/vby8/+bdCe+v41q03+aY9aBn9eSOBr4y1plKB+rys=;
 b=hMYofHjfPc3SYYDKfianU+Jt3VP0p3dEw0QDyaq1VwLRYkKG341qCTumc9384ojSrzQwjZblNnZHlOk5z/kV6ohyVYZD1uQSPf1ief3m/PKreLqnPMETD6eIN12PZd1BxxIEuttoGQS1ABV/G7XE7B+FKKOW5SDs7lifNEn7Bei5eJCvt09r3hcR5JKYpIv1CdF6S8Z07X2hPRJuBghbZO3ZdsFKYHczHE9A7i3cki57z+t+uWRDed+mZPCPYHaxUeZLAJjFPvQDgQc5rhJlzF2fjUBnBs779caPmgqr+qV3iTUvRLpJctTLayqt4ToZgCiN7OcWuL68j+VYFr3QWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/vby8/+bdCe+v41q03+aY9aBn9eSOBr4y1plKB+rys=;
 b=Nk/0ctyI5MxZVrYzoW0+Kktd3LpkctGe25niN8ZQneion4ErP4lxyS5kn7/uyuzWAuHIAwzubOeik+3aP6vZZxvUpc92XHRIVT77++IUaIxYj86x154deqvI0GiLwsLHo2azm7MBjVA2MhyynI6s+AymjIUJ+qloIhiPKbRyxso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Fri, 29 Apr
 2022 08:32:40 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 08:32:40 +0000
Date: Fri, 29 Apr 2022 16:32:31 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Haohui Mai <ricetons@gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <Ymuin6/LGeiz4SE9@lang-desktop>
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
 <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
 <YmqfNbHqsuE/erWL@lang-desktop>
 <CAHpOOhEA-GEgLU9B8RrYo9VnATj62sqnRm+6e3NsHo2H02pD7g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpOOhEA-GEgLU9B8RrYo9VnATj62sqnRm+6e3NsHo2H02pD7g@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b01c203-5dfe-4751-0ee2-08da29bad2db
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0093:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0093C911374DBED7989AF3B4FBFC9@MWHPR1201MB0093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6wsOgpWanEz4xuD4bFoiaP2Z18RNqmQweDET0NN2OyCavx0A1GjVuZ+Xhb/DcYqRMSdX8r6u9oI3MmstRxw5He5/G/NPaXBCd1K2dFNIXlPUuwfqTJGqHrQC7AMaguRfHTmdc3bLAfjDp7/m7gsdtoB6YKzzETOKnbsdN6rc0ne86IjTsOpbukwk8kt6tAUpevEAZEJ8LkV1W3v7+UjbuDox9It90EUYssj5xdb3RQ96zqN++fNzeB+YVp7AfW5T3BFjegqJEpv5EZtksO2au8lQ4Qwx9dUgxmCrbOPbq8IEyCyFQn4s/YlNzJn7QypI+d0/ozFNcrOwmbDrkK7TP56dfYYXpfjOEIh639HXPnBWOO+q/7NBaUZS7Mp6Yh1g6uGBOtXLl8dar05XcY2zf6bWbv2DLrJavv+iDLRTWJDc0dgEk7nwUb1pYn1qJar9ys+xwETLM784hzjWLwlNCxT/7eWN7UhrAdStICj0lfpZ9sCL0EO3FrMrnytG/tW2av0YjAxD10TmMccImxS4fjA+21jhTaHneWlwBmt7u3betcb0rqlQB7x72ohccShiCFESgxdzUXkq2L3lT5X5C5Egci46Xa4QvQg73JNYHSC2BQELMem6UYFGGAjKzTg3U+uoD/d8NoZKPVk8h4X9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(2906002)(66946007)(45080400002)(186003)(4326008)(5660300002)(38100700002)(54906003)(86362001)(30864003)(33716001)(8936002)(8676002)(6666004)(66556008)(83380400001)(66476007)(508600001)(6512007)(9686003)(6916009)(6486002)(316002)(6506007)(26005)(53546011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtT8c3PKlAJKPseUS5aHhJjda8/ePrDwmp3LJpRJCYN1MAISJE1+9fEQXsJr?=
 =?us-ascii?Q?tXfacYkxTRU6MEoTS7WsEf2nTF0CnT0EIf+6n+IJKmJ0WkyV2Nt3Zfi1M7Ri?=
 =?us-ascii?Q?qFl44NIYznQ4kKXYJJ+eMLS724cKgZpGYzTa0qDWFcrKcuVUEpZygC0rNDkY?=
 =?us-ascii?Q?GwPvkAMyhRZeRLj8Yea3rVliGuC0VyobsTHSM6QHVCSTouwLcO6XGpJC0C9b?=
 =?us-ascii?Q?YM0xDu4WZNAOapd1kPU5XNiCebPxDaF62BAw6MhP11TBTCMR+rQ3EsgsZLSI?=
 =?us-ascii?Q?4NawXzzP9JYHCUNRwt6VxBAeOPxiWH3MGimxKm6kZnCvvP+Gr5Dmh97igKST?=
 =?us-ascii?Q?WpnCJEw6F5l1Ih3nfjCOEq1Ty2v8fNKi8fiYeIT1nHam7y1jlNdTpTanqB6n?=
 =?us-ascii?Q?Hqr7xgheJRNR0uFumTSdz0w82gOtV4ohv0iQvajF/XjNb6R3dETmfm4u6Yc/?=
 =?us-ascii?Q?qVzcopuECwUJPe4gcigRrL0ngTjb3vDjvroyL7yT12sXgYgelxGZJmeXsKA5?=
 =?us-ascii?Q?+uQa7nHZdm2jhUoALx+YjGRj2JPlyzItA/rOwAyBQprXsmUBDPDjYKcpdVA9?=
 =?us-ascii?Q?jpO6H5PJF+lJ60wVpI8eABQixXIliIwgAyr9mwvhNUtK/2PAH1OC1k2eHUPO?=
 =?us-ascii?Q?15NX2V9ZyYrnzt0uKdkxo1rPuYx5xiZfpwMurakhA483mlPg9Am8CMOlEn21?=
 =?us-ascii?Q?63KX2ydM+lhiGVfyuo3ljc5QUjL0fsHw6BsOzgpGo2neza8Za4p7XN8gh/oF?=
 =?us-ascii?Q?KM0t6EkGNm9iuoKEkwympZwrbdBV5qvLxIEwe/v42TcdgCP6bi1lDOSpQZen?=
 =?us-ascii?Q?Aqx5l6UOb5VKb4d5lkELazbDsr3ijSANZpnrg+nvty6xFW81t3ZDVxlnLZN9?=
 =?us-ascii?Q?BjU8KGduKh6nqt1z8xNSHMpB/L2AUv3TQnuionsTb+fixy5ZiIPeca3J5yZ2?=
 =?us-ascii?Q?yocxtwNyCyOBe13NNx9NvfoHvHnpQmvHDRRufeTQ9cbZZd5ehH4KTTAqlcDB?=
 =?us-ascii?Q?vApMYcHPTEdDrXhL2ff8CHS82RCoCdSzECRVFscM0ynN5AkuGeWg3XhGjgKq?=
 =?us-ascii?Q?L1w62q+Mgsaefj04EFDW3IDLNVgNTUYMZmKYyZW8nNNEI74ZG3KCNLfF+WrR?=
 =?us-ascii?Q?KE1j4cI3VvPReXY8gjdlnvV10Feb2nDEkz7PZsprOjuygLVPAEO40O9dBzbS?=
 =?us-ascii?Q?C/zG+ViLar1X4yUMTj3ccwPVSUSbR2an1sEzo5RT9GUujLpbq828PwGQS0jW?=
 =?us-ascii?Q?hIXIlobmJIhfiYIEhbluDd2LgWKiQfz52kxX19CAU3f8EihDPkbqWuusAqKm?=
 =?us-ascii?Q?jl9h2VfPdsKxEL/42gw/i1AnQDMQLIwHvYmW5S198GLtYCSe/eBQqv1T9ZeW?=
 =?us-ascii?Q?yOqMhz6SQAyhaKrNAAjPh44KdzsATRS/pH+jC5G/y+kOdxGNCZO9LvNJsTRd?=
 =?us-ascii?Q?Dh6hV5U4FM2VwFEFzWyMw1XqoC5Ah/hfSBDbOUZo2I8LsoW/O9OSpsXR53zr?=
 =?us-ascii?Q?tu9blZ3SlEsIU/oiOZCrS07QV4bTkz8t596iR23u57h670cYpm3iMQ8UYWm1?=
 =?us-ascii?Q?BnK+QfxzTzondL/3LEPVJor6MeViZ3jgeGbwuyMUwbEp84atLN4XFKWb0jxI?=
 =?us-ascii?Q?WoWg25yG28yq2hIsD59eYr8DDSN89uKnRYBoF2DpF/Y6Rjao3eFTL21neO8L?=
 =?us-ascii?Q?D0D5Wy/LNZUf+o337qFxmRux76FUqirwN61MlKHc5Fi/DsPgzSIrDvspy8U0?=
 =?us-ascii?Q?lL7LCeW5fg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b01c203-5dfe-4751-0ee2-08da29bad2db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:32:40.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEhTxrBXXLrb1zxoWqYR6/dmY3qvSePg16My2PGZTtf9qAmXe5XElVjDGjuHXDlBa/60VyXvpYXYV+3s3fkeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
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

On 04/29/ , Haohui Mai wrote:
> Thanks for pointing it out. The v5 patch added the code back.
> 
> ~Haohui

But you didn't remove the following codes added in v4.

 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		sdma_v5_2_ctx_switch_disable_all(adev);
+		sdma_v5_2_halt(adev);
+

sdma_v5_2_halt() has been called in sdma_v5_2_load_microcode().

No need to call these two functions here.

Regards,
Lang

> On Thu, Apr 28, 2022 at 10:05 PM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > On 04/28/ , Haohui Mai wrote:
> > > If I understand correctly, the original code will disable the HALT bit
> > > of the register mmSDMA0_F32_CNTL twice on other code paths -- one in
> > > the sdma_v5_2_ctx_switch_enable() and the other one in
> > > sdma_v5_2_enable().
> > >
> > > The change ensures that the bit is only disabled once. Just wondering,
> > > which one is the expected behavior?
> > >
> > > ~Haohui
> >
> > The HALT bit of the register mmSDMA0_F32_CNTL is not set/reset in original sdma_v5_2_ctx_switch_enable()
> > (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Fsdma_v5_2.c%23L523&amp;data=05%7C01%7CLang.Yu%40amd.com%7C2df035ef6ad5411215a208da299c0253%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637868047861293833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2FLpd6TUyxSe96rEzbyvV0zXNPZ%2BIokiT8KtGAKea8Co%3D&amp;reserved=0)
> >
> > Regards,
> > Lang
> >
> > > On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > > >
> > > > On 04/28/ , ricetons@gmail.com wrote:
> > > > > From: Haohui Mai <ricetons@gmail.com>
> > > > >
> > > > > The patch fully deactivates the DMA engine before setting up the ring
> > > > > buffer to avoid potential data races and crashes.
> > > > >
> > > > > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> > > > >
> > > > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
> > > > >  1 file changed, 62 insertions(+), 51 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > index 013d2dec81d0..b000117b77d0 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> > > > >       }
> > > > >  }
> > > > >
> > > > > -
> > > > >  /**
> > > > >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > > > >   *
> > > > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> > > > >  }
> > > > >
> > > > >  /**
> > > > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > > > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > > > > + * context switch for an instance
> > > > >   *
> > > > >   * @adev: amdgpu_device pointer
> > > > > - * @enable: enable/disable the DMA MEs context switch.
> > > > > + * @instance_idx: the index of the SDMA instance
> > > > >   *
> > > > > - * Halt or unhalt the async dma engines context switch.
> > > > > + * Unhalt the async dma engines context switch.
> > > > >   */
> > > > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> > > > >  {
> > > > >       u32 f32_cntl, phase_quantum = 0;
> > > > > -     int i;
> > > > > +
> > > > > +     if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > > > > +             return;
> > > > > +     }
> > > > >
> > > > >       if (amdgpu_sdma_phase_quantum) {
> > > > >               unsigned value = amdgpu_sdma_phase_quantum;
> > > > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > >               phase_quantum =
> > > > >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > > > >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > > > -     }
> > > > > -
> > > > > -     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > -             if (enable && amdgpu_sdma_phase_quantum) {
> > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > > > -                            phase_quantum);
> > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > > > -                            phase_quantum);
> > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > > > -                            phase_quantum);
> > > > > -             }
> > > > >
> > > > > -             if (!amdgpu_sriov_vf(adev)) {
> > > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > > -             }
> > > > > +             WREG32_SOC15_IP(GC,
> > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > > > > +                     phase_quantum);
> > > > > +             WREG32_SOC15_IP(GC,
> > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > > > > +                 phase_quantum);
> > > > > +             WREG32_SOC15_IP(GC,
> > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > > > > +                 phase_quantum);
> > > > >       }
> > > > >
> > > > > +     if (!amdgpu_sriov_vf(adev)) {
> > > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > +                             AUTO_CTXSW_ENABLE, 1);
> > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > > > > +     }
> > > > >  }
> > > > >
> > > > >  /**
> > > > > - * sdma_v5_2_enable - stop the async dma engines
> > > > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> > > > >   *
> > > > >   * @adev: amdgpu_device pointer
> > > > > - * @enable: enable/disable the DMA MEs.
> > > > >   *
> > > > > - * Halt or unhalt the async dma engines.
> > > > > + * Halt the async dma engines context switch.
> > > > >   */
> > > > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > > > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> > > > >  {
> > > > >       u32 f32_cntl;
> > > > >       int i;
> > > > >
> > > > > -     if (!enable) {
> > > > > -             sdma_v5_2_gfx_stop(adev);
> > > > > -             sdma_v5_2_rlc_stop(adev);
> > > > > -     }
> > > > > +     if (amdgpu_sriov_vf(adev))
> > > > > +             return;
> > > > >
> > > > > -     if (!amdgpu_sriov_vf(adev)) {
> > > > > -             for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > > > -             }
> > > > > +     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > +                             AUTO_CTXSW_ENABLE, 0);
> > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > >       }
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * sdma_v5_2_halt - stop the async dma engines
> > > > > + *
> > > > > + * @adev: amdgpu_device pointer
> > > > > + *
> > > > > + * Halt the async dma engines.
> > > > > + */
> > > > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > > > +{
> > > > > +     sdma_v5_2_gfx_stop(adev);
> > > > > +     sdma_v5_2_rlc_stop(adev);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > > > >   *
> > > > >   * @adev: amdgpu_device pointer
> > > > >   *
> > > > >   * Set up the gfx DMA ring buffers and enable them.
> > > > > + * It assumes that the dma engine is stopped for each instance.
> > > > > + * The function enables the engine and preemptions sequentially for each instance.
> > > > > + *
> > > > >   * Returns 0 for success, error for failure.
> > > > >   */
> > > > >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > >
> > > > >               ring->sched.ready = true;
> > > > >
> > > > > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > > > > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > > -                     sdma_v5_2_enable(adev, true);
> > > > > -             }
> > > > > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > > > >
> > > > >               r = amdgpu_ring_test_ring(ring);
> > > > >               if (r) {
> > > > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> > > > >       int i, j;
> > > > >
> > > > >       /* halt the MEs */
> > > > > -     sdma_v5_2_enable(adev, false);
> > > > > +     sdma_v5_2_halt(adev);
> > > > >
> > > > >       for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > >               if (!adev->sdma.instance[i].fw)
> > > > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > >       int r = 0;
> > > > >
> > > > >       if (amdgpu_sriov_vf(adev)) {
> > > > > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > -             sdma_v5_2_enable(adev, false);
> > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > +             sdma_v5_2_halt(adev);
> > > > >
> > > > >               /* set RB registers */
> > > > >               r = sdma_v5_2_gfx_resume(adev);
> > > > > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > >       }
> > > > >
> > > > >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > +             sdma_v5_2_halt(adev);
> > > >
> > > > You don't need call these functions here.
> > > >
> > > > In original code, you can see sdma_v5_2_load_microcode() calls
> > > > sdma_v5_2_enable(adev, false) to halt the engine before load ucode.
> > > >
> > > > What I mean is sdma_v5_2_halt(adev) should have no functional change with
> > > > original sdma_v5_2_enable(adev, false), like this,
> > > >
> > > > static void sdma_v5_2_halt(struct amdgpu_device *adev) {
> > > >         u32 f32_cntl;
> > > >         int i;
> > > >
> > > >         sdma_v5_2_gfx_stop(adev);
> > > >         sdma_v5_2_rlc_stop(adev);
> > > >
> > > >         if (!amdgpu_sriov_vf(adev)) {
> > > >                 for (i = 0; i < adev->sdma.num_instances; i++) {
> > > >                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > >                         f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> > > >                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > >                 }
> > > >         }
> > > > }
> > > >
> > > > But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.
> > > >
> > > > Regards,
> > > > Lang
> > > >
> > > > >               r = sdma_v5_2_load_microcode(adev);
> > > > >               if (r)
> > > > >                       return r;
> > > > > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > >               amdgpu_gfx_off_ctrl(adev, false);
> > > > >
> > > > >       sdma_v5_2_soft_reset(adev);
> > > > > -     /* unhalt the MEs */
> > > > > -     sdma_v5_2_enable(adev, true);
> > > > > -     /* enable sdma ring preemption */
> > > > > -     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > >
> > > > > -     /* start the gfx rings and rlc compute queues */
> > > > > +     /* Soft reset supposes to disable the dma engine and preemption.
> > > > > +      * Now start the gfx rings and rlc compute queues.
> > > > > +      */
> > > > >       r = sdma_v5_2_gfx_resume(adev);
> > > > >       if (adev->in_s0ix)
> > > > >               amdgpu_gfx_off_ctrl(adev, true);
> > > > > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > > > >       if (amdgpu_sriov_vf(adev))
> > > > >               return 0;
> > > > >
> > > > > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > -     sdma_v5_2_enable(adev, false);
> > > > > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > +     sdma_v5_2_halt(adev);
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > >
