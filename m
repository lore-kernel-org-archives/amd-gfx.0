Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD93C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 08:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3FB10E206;
	Thu, 28 Apr 2022 08:34:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6291810E455
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 08:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIcC4dyJluba02CDE50htShSPeJsbOu0NNkZAyNP6n/2G034AoFRMboAoG1GWgnwohM5hfYKARVGaCaNUELV7CdK4r/mLbW6nDRKtyKlzbVJ55VUZL0uFQ4JdfUOAqPwGSQic++ju7KRCuhIeyiQao2iPqcWQI0fe/rruvkxrjnVPstF55m9x/prs0IHysl+vcJLNdsz833ISM6g1kVesRxsoP4zNG/gKV6C8jttio5Ug7IIk/5DVHwTdcuwNdAbiVsCd2aHGtiYOsafbVn/AXgBWepKDq2it2rO14M2YAMccl/DYXeLAqN4zZKGEkQ0R9zT0mQMASMMAS9PFTQpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3U3bjsQfKkDc13/77R3V9gFXswiCq6xqaTU+TxaypM=;
 b=KJMcgMGAiRcOG5awKR1FSbk0c3vsmQkHQsCfZlZHqv00BOChOUzvWpMGNYKaXltp/06t3F3rZMYLit4AtjLgHLaDe5F7pUhG4hfQWBZr8irgDUcD9yhZAyJFdITmbBjzwwwUuVQ1rKhc6HIi4kzJlDbkyOrODAF12JE11NnBDZ0xbEMp+HoFZ5hk+F/ri+OnkgU/qo0yXIzi4yIsV/S3O+LyeBRTs9dh67bhs3Id1iXMrKxUNf4oeJsg7fiFv9S/c/RrVVDKfzlp3VEWSgtibAsbyiHTe8bTHR4I9SSlwfpjVHp4otqRNyc0MLP1FwwyZ0i+HCH3uvmqIEvpbKu3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3U3bjsQfKkDc13/77R3V9gFXswiCq6xqaTU+TxaypM=;
 b=rawvHQQ2/+2TK/NZWsGzFnis/wrniDJMOVr/PV0FucXgC16Pb7Zo0iISBJq8o0JG2Op0Fx0h7ZvFywpQbuot/o6Qmc4vBA9R60fEq4pLy/j7xz3dT4PtCor5Nnzn+ju3SwdiEQfgHOiUGk+UO/IIkWjgWz+Bvw1klcsULz1fWVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 28 Apr 2022 08:34:28 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 08:34:28 +0000
Date: Thu, 28 Apr 2022 16:34:19 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Haohui Mai <ricetons@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <YmpRi8LXk2Z9o1Dh@lang-desktop>
References: <20220428021109.2571-1-ricetons@gmail.com>
 <05b5464c-9d2c-844a-ef0a-818d04ed9592@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05b5464c-9d2c-844a-ef0a-818d04ed9592@gmail.com>
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e16c5dc-e79f-45d7-31d4-08da28f1e86a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090A4B745641641D94AB4C1FBFD9@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2eHBUg0oBBysKbR6FqNqA7izqfY0x5t7kYAdZCROv5rMRdOuoKt/PoD4GgSfEgkChNOm7SkpyBK96qNxwT4ZsrwlOf46p1/GU/SG9n1VdFzOIsdx2FiL8g8Q5qwwyQhVojZi3kCWu35dpA0e1oxsavXL77rj0Ch6mT9tDRCsePMFaZsJdMWU/TKyp+RUZd8nATfIFEHMWMU6qrvPchPTOPkqXMOaQg/Zrs1LQhMSiKFwt+l3AuSgZyVytZ6g56ZI74Ouzrbxlylo7BHrYFNmgTE665AXaKCZEXYz0NlOhttDdXsisZZPgEknne9XyJMLUzTFK38Mog8l9gpLH6RrM/vfc+pwAlNad0G+/aOkZjFkMvfTZ1x9YX/QKY1vUzYiEOFNZPv2v7W2Un6v9ldzi9m0oaq+E5ZjrSbnPgIb+qXwHUa9EL1ZbPkAivI4QYOViEBORdELY8uU6+0ScwbrCUF+dsLv8Hsu+JvUxYXsRvxt7yjK8bClC84uccTcsLDvE3TZfT4r1O6PTJAmN4zQ07AWp93XVVtQ9NXl2P2oMxMXDIfN1il9WmtHnUnPXmMGqp4mr8WPXzcf817lwvwYE2aaCuS2DCkeeDVCajdQUzUmR5sFGzvgmqhMdIz5g036fdJY7Aj6nUVxfVYuX4hBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(2906002)(38100700002)(33716001)(26005)(9686003)(6506007)(6666004)(6512007)(316002)(110136005)(508600001)(5660300002)(8676002)(6486002)(54906003)(4326008)(86362001)(83380400001)(8936002)(66574015)(66946007)(66556008)(66476007)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B/J25GzSugT82w0mbZbl2/qjzcEso3G4UKWMCI4gn2RSD0my2st+Bq9FFt?=
 =?iso-8859-1?Q?DtPS9iyLg8O6pPnimJbdhA4JsSzFt365eT95xWoDjwo9/Nk+5szn4TTY9i?=
 =?iso-8859-1?Q?hi+tjxjFa2JbHomBDaw/TNTgLc4M/wLZzLN6aHkGCIm3DnCC9e1yk4u6fq?=
 =?iso-8859-1?Q?8qxYmzZIjiuhph5zmpaOhfU0tvBTfteCAzMJerow3ryjMdIr9cC7IB+8tO?=
 =?iso-8859-1?Q?yp59bW9tIi4IMC4sjeldGtiSBOc6KHqzysa8g1sbRlbMqCZnwrFwAFNRrE?=
 =?iso-8859-1?Q?Ff+5MkDffvcGNe6/MBZzmn7h2qS54Z5FMAWbsBauZeelrJd4jrZYRxdRAk?=
 =?iso-8859-1?Q?/kAgd6FZPAsWHk5rlPaTYUjz/vmTfCzdHKhwXHmMoi6pi0ZabUz8kgLJH3?=
 =?iso-8859-1?Q?7Vh5WOu9Ld8KvmgkBpr/9sOEOt+SFh77UH2AwVj+0lhvLvmiU4S3Sp45yC?=
 =?iso-8859-1?Q?nxLciJ7HSdryYnyt8Vw42KTYKNkDTl+dDevU7J1xbZn5XebyYEi/bNLtmC?=
 =?iso-8859-1?Q?31Y26T/09IKaEOju8aciDJQ0vH+8NGM+6wNRCEmBJNplj9iQgkFRNvYQGg?=
 =?iso-8859-1?Q?6kqAbEGG1OxN+A9DgVJznDUFsl0yX0pSk12wlQdL8ktAmtPD/gkhx/2QeW?=
 =?iso-8859-1?Q?cNBOvyG7bepdeGqRUqJDVYT9doOSjt0D5FrAU1f7lgqOELlok+kgoF0EwU?=
 =?iso-8859-1?Q?fWN0vLSBQQHPWzJsivZJWbFLlwJVdzuTKVNZpkyEmKfHVhtMB/rAgw9uJ+?=
 =?iso-8859-1?Q?caklASH1ke94iix0KjEI7N6GkRxgfgjVQhtco5XszpFVp1kSv+CROa5wSc?=
 =?iso-8859-1?Q?2+1ppIuvIJX4X6MObBMacEX1ksiMIszRiEmh1v+AzDhfq4/KVlHotvRinB?=
 =?iso-8859-1?Q?Fg6JWgl87OE2seI13HdvEgfECGOJZ9ek/eJ7LSKX5KbYfijBpfESZVmlqQ?=
 =?iso-8859-1?Q?UWJ0cR/8s5Sh4QmXJROM/jlgA91bcCyR/ww+BfmtGDUkOkEkqwY9/3OtF3?=
 =?iso-8859-1?Q?xpgXHHHDDNcV1oG/0Rf+Kg0Cxbt2Xy68c4QJhil4JtJE87UHPxW677p7GA?=
 =?iso-8859-1?Q?OTd+2FTyKO8+JuFYI7yafvWjzi+/xy5DO8WJW6dzNqkEy2kxt8Nn4+HVel?=
 =?iso-8859-1?Q?H97ld6SJjeY94qMu3uH2C0QyeNntOeVqnGVz29AVj6D5XNnhkiMw/xBnHc?=
 =?iso-8859-1?Q?X8UBcFjYyJJUo2w43vRImZi+dDugptXWuSl/JBl1l9ZtlADVB5pOTLj1Ja?=
 =?iso-8859-1?Q?NE4MnzRaAADRpeHLOnKkiKUZNS2LeFKu+b4M4i2mE0o6LCCO+Kl7ETrfkp?=
 =?iso-8859-1?Q?CCvWGab0rwX8yatWiZDe1irpt5n9Sye/k7ieQ3ha+OdmI0gkFC0S/oh61M?=
 =?iso-8859-1?Q?+TnxXeDtG0Kn2r4LqGz7n52U5utSX+oYcmPHKrXVm5U0sBu14cvP375AxB?=
 =?iso-8859-1?Q?nWh9jYpC8j10HLFUZ4M6PU2q3qg16/EpTUPgMVxgfMtv3KL27CRG8KpL4F?=
 =?iso-8859-1?Q?7071xB/BNYXJu/nEDNEeBrz/cK5eRnRCLv52TQXSmH0jcZbpzpJJ4D+f2S?=
 =?iso-8859-1?Q?Q1xQXgeWwTTFwKj7wUPoU2CykPsu2JkCAXom6oKpV2c+az3+FhOJp9C+Jm?=
 =?iso-8859-1?Q?en6Po6EYl/ylXzADHBj0jQ+T0N87dkoJtDgpwGsms9NeLVVzrENJTDccZV?=
 =?iso-8859-1?Q?yF981ZvRcxJ04aNyBMS5X3Wwe1FarSvZoEw1cvIztwieeYYj/MZed0FQW2?=
 =?iso-8859-1?Q?DA2vb6yfSBU344aM3KfSd8mIoEMendP84dk+D2cdrY/Qo33aF+7EHuA3nn?=
 =?iso-8859-1?Q?VQOcPePJgQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e16c5dc-e79f-45d7-31d4-08da28f1e86a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 08:34:28.1130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98Q5ZP3st5eaJGx14ua0R34lQ7eg7pTON4gEnpJilp+k7GxT61qI146whE2k9U2nb3GThqJNp4175VUDC8KkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
 Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org,
 Haohui Mai <haohui@alt-chain.io>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/28/ , Christian König wrote:
> Adding a few more people to review this.
> 
> Am 28.04.22 um 04:11 schrieb ricetons@gmail.com:
> > From: Haohui Mai <haohui@alt-chain.io>
> > 
> > The patch fully deactivates the DMA engine before setting up the ring
> > buffer to avoid potential data races and crashes.
> > 
> > Signed-off-by: Haohui Mai <haohui@alt-chain.io>
> 
> From my side this is Acked-by: Christian König <christian.koenig@amd.com>,
> but I'm not so deeply into the hardware programming sequence to fully judge.
> 
> Enabling the engine first and then setting it up is certainly incorrect, but
> could be that I'm missing something else. So please guys take a look as
> well.
> 
> Thanks,
> Christian.
> 
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 110 +++++++++++++------------
> >   1 file changed, 59 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > index 013d2dec81d0..a22aafd2d7f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> >   	}
> >   }
> > -
> >   /**
> >    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> >    *
> > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> >   }
> >   /**
> > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > + * context switch for an instance
> >    *
> >    * @adev: amdgpu_device pointer
> > - * @enable: enable/disable the DMA MEs context switch.
> > + * @instance_idx: the index of the SDMA instance
> >    *
> > - * Halt or unhalt the async dma engines context switch.
> > + * Unhalt the async dma engines context switch.
> >    */
> > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> >   {
> >   	u32 f32_cntl, phase_quantum = 0;
> > -	int i;
> > +
> > +	if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > +		return;
> > +	}
> >   	if (amdgpu_sdma_phase_quantum) {
> >   		unsigned value = amdgpu_sdma_phase_quantum;
> > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> >   		phase_quantum =
> >   			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> >   			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > -	}
> > -
> > -	for (i = 0; i < adev->sdma.num_instances; i++) {
> > -		if (enable && amdgpu_sdma_phase_quantum) {
> > -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > -			       phase_quantum);
> > -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > -			       phase_quantum);
> > -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > -			       phase_quantum);
> > -		}
> > -		if (!amdgpu_sriov_vf(adev)) {
> > -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > -					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > -		}
> > +		WREG32_SOC15_IP(GC,
> > +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > +			phase_quantum);
> > +		WREG32_SOC15_IP(GC,
> > +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > +		    phase_quantum);
> > +		WREG32_SOC15_IP(GC,
> > +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > +		    phase_quantum);
> >   	}
> > +	if (!amdgpu_sriov_vf(adev)) {
> > +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +				AUTO_CTXSW_ENABLE, 1);
> > +		WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > +	}
> >   }
> >   /**
> > - * sdma_v5_2_enable - stop the async dma engines
> > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> >    *
> >    * @adev: amdgpu_device pointer
> > - * @enable: enable/disable the DMA MEs.
> >    *
> > - * Halt or unhalt the async dma engines.
> > + * Halt the async dma engines context switch.
> >    */
> > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> >   {
> >   	u32 f32_cntl;
> >   	int i;
> > -	if (!enable) {
> > -		sdma_v5_2_gfx_stop(adev);
> > -		sdma_v5_2_rlc_stop(adev);
> > -	}
> > +	if (amdgpu_sriov_vf(adev))
> > +		return;
> > -	if (!amdgpu_sriov_vf(adev)) {
> > -		for (i = 0; i < adev->sdma.num_instances; i++) {
> > -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > -		}
> > +	for (i = 0; i < adev->sdma.num_instances; i++) {
> > +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +				AUTO_CTXSW_ENABLE, 0);
> > +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> >   	}
> >   }
> > +/**
> > + * sdma_v5_2_halt - stop the async dma engines
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Halt the async dma engines.
> > + */
> > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > +{
> > +	sdma_v5_2_gfx_stop(adev);
> > +	sdma_v5_2_rlc_stop(adev);
> > +}

Following codes are missing in halt/unhalt,

f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);

Probably AMDGPU_FW_LOAD_DIRECT(sdma_v5_2_load_microcode) needs these codes.

Regards,
Lang

> > +
> >   /**
> >    * sdma_v5_2_gfx_resume - setup and start the async dma engines
> >    *
> >    * @adev: amdgpu_device pointer
> >    *
> >    * Set up the gfx DMA ring buffers and enable them.
> > + * It assumes that the dma engine is stopped for each instance.
> > + * The function enables the engine and preemptions sequentially for each instance.
> > + *
> >    * Returns 0 for success, error for failure.
> >    */
> >   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> >   		ring->sched.ready = true;
> > -		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > -			sdma_v5_2_ctx_switch_enable(adev, true);
> > -			sdma_v5_2_enable(adev, true);
> > -		}
> > +		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> >   		r = amdgpu_ring_test_ring(ring);
> >   		if (r) {
> > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> >   	int i, j;
> >   	/* halt the MEs */
> > -	sdma_v5_2_enable(adev, false);
> > +	sdma_v5_2_halt(adev);
> >   	for (i = 0; i < adev->sdma.num_instances; i++) {
> >   		if (!adev->sdma.instance[i].fw)
> > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> >   	int r = 0;
> >   	if (amdgpu_sriov_vf(adev)) {
> > -		sdma_v5_2_ctx_switch_enable(adev, false);
> > -		sdma_v5_2_enable(adev, false);
> > +		sdma_v5_2_ctx_switch_disable_all(adev);
> > +		sdma_v5_2_halt(adev);
> >   		/* set RB registers */
> >   		r = sdma_v5_2_gfx_resume(adev);
> > @@ -881,12 +891,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> >   		amdgpu_gfx_off_ctrl(adev, false);
> >   	sdma_v5_2_soft_reset(adev);
> > -	/* unhalt the MEs */
> > -	sdma_v5_2_enable(adev, true);
> > -	/* enable sdma ring preemption */
> > -	sdma_v5_2_ctx_switch_enable(adev, true);
> > -	/* start the gfx rings and rlc compute queues */
> > +	/* Soft reset supposes to disable the dma engine and preemption.
> > +	 * Now start the gfx rings and rlc compute queues.
> > +	 */
> >   	r = sdma_v5_2_gfx_resume(adev);
> >   	if (adev->in_s0ix)
> >   		amdgpu_gfx_off_ctrl(adev, true);
> > @@ -1340,8 +1348,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> >   	if (amdgpu_sriov_vf(adev))
> >   		return 0;
> > -	sdma_v5_2_ctx_switch_enable(adev, false);
> > -	sdma_v5_2_enable(adev, false);
> > +	sdma_v5_2_ctx_switch_disable_all(adev);
> > +	sdma_v5_2_halt(adev);
> >   	return 0;
> >   }
> 
