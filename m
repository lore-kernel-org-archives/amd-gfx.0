Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0466C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 08:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1627310F234;
	Thu, 10 Mar 2022 08:46:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB8310F234
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 08:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZaizXiUlT/WdzBRKlhqAes/uxk1FBudWtJ7KJEu3LUOzksG6exiaoaqUqTVvOkbidhRbbuTagC769HBYm3OvPW58R53pdgszen/kUgqkO3WxjxQGX+nS/iR6TXXbVbHRdNH9eEo4z34HO6mmBT5hVAWJj6YRDD08inxcQHz8VLGx28IkWBlwmnriAPT3vizBMHvQUbcR2GvVpjrN0WR7T1I4CSjLeXGHcsEnN0dP89XdG9TOY6TcrPEBpFBFxk1WLq888X+5G44iSGtr7rw5F5NstNkgcJQ33ExKzt+p0HiRL8R7+YiWwJ6OWnJYtkJR2sCmc5KE7J2HfAWvXn+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQwtCQmw2Gt/LVEAe1qTn6edn8kz69QDU+s/ySXXrCs=;
 b=L546l9Dme4Ezl8h8UVeDZST89dWS/YRTUMXRxpBFD1oHfWPuE+5BgWulnF3/A0BGiJfW9ZFWucsoRT4UljPfQo4zKjxVqM+cg4XK/qgw5Y9cn1AJU956R3F6TBoae8PV0X5q7Y9NS3+8GNmyL46mMUg+6fCKlfTYlNEhpxmIwexzWaWYuKVLJPSfcqP77C5objwANgyDVsH5hgMVsw60MHwG0Jb6NAgWj+eBfzyzUUtMuBSwVx4U/LcIerlTmc0vds94ff4ey1W7ByDeOF1F0rIRRig6RegAxZaWEkmzlnBZ+kmvvvG7dDa4MW9bAoL5zDWxpjeBRx7sFjIvp5gb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQwtCQmw2Gt/LVEAe1qTn6edn8kz69QDU+s/ySXXrCs=;
 b=Ta/nNrhaHduAf1jFxtJxbXe62tFXm5HS3jWHQBEGKo5lkRqtXrzu8n4kglwdmY402UlvRZKwWqHGJTtWW7tYX18j1mRHUXQ+S814ZNKJcEBTrZVPA45MSmvhdZpfn3VZPgNixFhX2YdvScTJiRJs9u9KT+oi3zuaWeC17NAVMIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CY4PR1201MB2469.namprd12.prod.outlook.com (2603:10b6:903:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 08:45:59 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 08:45:59 +0000
Date: Thu, 10 Mar 2022 16:45:48 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Leo Liu <leo.liu@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Message-ID: <Yim6vIBYKLd3Uqxu@lang-desktop>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a0c0abf-72ba-44b2-7d00-08da027265e3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2469:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB246954D448D0267B369BE4CDFB0B9@CY4PR1201MB2469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BklllOLfpB8LcvZzMocKzP2KncYRhNHGiPwQh4uhBhIzWPBi1V4BmPib0GUb+l+2s4WLSQLC0457EXaIDmv7uxmqw8mgStsSK9QxAciGjMRequYFDX09vgO7COKy+q0TaPUVSU6gC6sQYhjxhRMyRPP/Z4Z3KfwYzi5LBmbiSKQGZEwfWXK9DXPd20VrqPITbqan4DwRj2e8jtFImxiATDA+WbWKrlEu3jGBOmpZHxUYluawprvBSFupbVhugBtrUVUeIbPWDg/gLTcm/P+g4HW4+kdBJC+LXwO7nA49VUp9Tfp2SHzUC7GVKzIoO32c10kOLvg/RwbJ8H8S24/ONylJHhnog3kL/CNOMgZRKptDfMPVrRhEj8AWDF+woYwQi8TuLycDuEOq/n5YQOzMOHe1F1iB42GAbDF3bRFxJixvfuQQBGrmRdViqQe/BRTYgVrqZLAdPBqSrDK1dVWJECYRnndbmDUdDf3himBh09udO22+cVnsiGZDl5XNPnfuCD0VnHTVS35D9uE7BNl3JgNn4UuW+IHMw6P4tbDQfgbjo0pHPjUxmGw0MMQYAnz1VDj4HFE655/jr0cyXZt6CEUtt48YFy/JxBb3crg0wn5fVUJXnKZnCFuyVv3HEbnIxInSzYGrcFVp33LSfYAPuQTuE90YtFpWd03h52DZJrufTCjzIuqqN13OAGl0wMnV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(84040400005)(4326008)(2906002)(83380400001)(5660300002)(86362001)(66476007)(66556008)(66946007)(8676002)(8936002)(6636002)(508600001)(53546011)(316002)(26005)(186003)(110136005)(54906003)(38100700002)(33716001)(6486002)(6506007)(6512007)(6666004)(9686003)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CHCFA3IM9Mdbu9nYZTpw0ugyjQH2AAJOM3nat45aQ+2x2QirqjnVShg6st?=
 =?iso-8859-1?Q?ws4vnu2D9NWacIaL3QqsdjNdZFXm5lNXTzeVxS90MZsIw9aLgCNWDmBOtS?=
 =?iso-8859-1?Q?Va+KFGF5+LA0nNfPyCah3ljCr7mQ+swGeDsM4w5dUKOhnZqArWBztOlDVR?=
 =?iso-8859-1?Q?ZFz7SkJEWOHLTJrOFlQhUFhH3mczkbdj0Ab7PPg+qW60FqNY5aMjTc0nYq?=
 =?iso-8859-1?Q?1u++U2hThyL8EJAz8Y1f90xD4cAXG27CA2WbXjvPpNpo5e7UqWijkiF38J?=
 =?iso-8859-1?Q?tHhVFHxMwvA8t7j5RiyrxgVBeWKciUed5nVCE75E7re4ovRVUjwmg5o8+u?=
 =?iso-8859-1?Q?WMYpzmxy+hntY/QxnL1ITTicR6tCj1kfV8KnvMT+MzczOzGfcXPp67RqY+?=
 =?iso-8859-1?Q?6b580FNpuHEivY0vY3XHgpLEsfbG32ay/oTcK4asKE3OXgnEYL77bflmWC?=
 =?iso-8859-1?Q?8+sLkhJZm0sMAaoOn5A1m7J71gGN6rgoiKtLAOuZSVqsPFzh13ufiAGggw?=
 =?iso-8859-1?Q?7WGtEffceK7y5HuXGLPke3F2E5RPZA1BKllmGHXkp6d/nbJu6heyckl4LM?=
 =?iso-8859-1?Q?p9+jT9nYcF34CUDA/tP6jXukmkRzoN1giffjrInAMOEMEt/okpKP3vlOkF?=
 =?iso-8859-1?Q?2F6WCaIlBrs6M8OMRW/nmyusRhYXhXLZt0s+LqLVKw/MAXsblGr9kCRhn8?=
 =?iso-8859-1?Q?s60z5rwXtG5Bzf+8gV+1bOHiqs0azRQ4m+cG6F3at3T7xA9gt/YoGcDd1n?=
 =?iso-8859-1?Q?xUakyEhkC5V7h+F0cvmNlzU0Zc1/RFPA/x246x7mOchzTcnf503HY/1Rsp?=
 =?iso-8859-1?Q?3UQSUXaNuoLgK88eanCd6GJNB8pLTb9exDHC305HbWIaQAiPzf1Hu1297f?=
 =?iso-8859-1?Q?ekFnGetyP0nsscxhCsjZGbJ/Nd2MzSTm4KAhQjWBE/cPtNIZROj4Tk4BOt?=
 =?iso-8859-1?Q?PKJJ75LXFsWlTagXGZKtsUtK3HmNT74x7KnVIKUpL3gtcfrB0wTPMe2spC?=
 =?iso-8859-1?Q?ZxaWUFtJoyRxmINekQGVmcymDXRDacp5JpW2iYfkYB6CCxI93bEpUKWNK1?=
 =?iso-8859-1?Q?htG5co411BlLtqucP5SIpuAVBLYZbhfBb373/G+RpMjb1KMP0eewH+sevj?=
 =?iso-8859-1?Q?o+NiFy+6bg9IpScvRHWJ+FpGbagXdHwjLO3XPFq9g3bUg4BRPERmp2BYqg?=
 =?iso-8859-1?Q?K3NQGD6sh4u98/7p9aRNztaIn1Ynko/+lOb3fcY73OMc8RcT1UNDUqToOV?=
 =?iso-8859-1?Q?l2mSNj8PMei4NADTewt/EHCzI05tgVp0Ftn2OdZU2/ADeSzxZErrwwpgdq?=
 =?iso-8859-1?Q?RQ/reh7syy+WUuankX2hoaC41wWc9+KGQ6ljo1taZ8TvXnKoNeiWpV0W92?=
 =?iso-8859-1?Q?0jJdcZcjsDpPyTlH3jIQosb3GZnkQvLHAAwRM0Z72U3Hs0eUA2orftlRGm?=
 =?iso-8859-1?Q?ApdVU09PPrqOx0i8eJ3lGvq4Bp51tg6K5fbYmALxkLaNu0Dc+ZsxxTMDyB?=
 =?iso-8859-1?Q?DoFAeaN/3g44E9nJKdHWgO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0c0abf-72ba-44b2-7d00-08da027265e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:45:59.1217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHz/J/0nNZTQgMCQ7PoVKn5U+Ttoi8a3i0OdNkRX7KHyLALwJk/uDm8dC4nxCmCib5R03t4JVFMbvvlTfp0FjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
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
 amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.

On 03/08/ , Leo Liu wrote:
> 
> On 2022-03-08 11:18, Leo Liu wrote:
> > 
> > On 2022-03-08 04:16, Christian König wrote:
> > > Am 08.03.22 um 09:06 schrieb Lang Yu:
> > > > On 03/08/ , Christian König wrote:
> > > > > Am 08.03.22 um 08:33 schrieb Lang Yu:
> > > > > > On 03/08/ , Christian König wrote:
> > > > > > > Am 08.03.22 um 04:39 schrieb Lang Yu:
> > > > > > > > It is a hardware issue that VCN can't handle a GTT
> > > > > > > > backing stored TMZ buffer on Raven.
> > > > > > > > 
> > > > > > > > Move such a TMZ buffer to VRAM domain before command
> > > > > > > > submission.
> > > > > > > > 
> > > > > > > > v2:
> > > > > > > >     - Use patch_cs_in_place callback.
> > > > > > > > 
> > > > > > > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > > > ---
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
> > > > > > > > +++++++++++++++++++++++++++
> > > > > > > >     1 file changed, 68 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > index 7bbb9ba6b80b..810932abd3af 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > @@ -24,6 +24,7 @@
> > > > > > > >     #include <linux/firmware.h>
> > > > > > > >     #include "amdgpu.h"
> > > > > > > > +#include "amdgpu_cs.h"
> > > > > > > >     #include "amdgpu_vcn.h"
> > > > > > > >     #include "amdgpu_pm.h"
> > > > > > > >     #include "soc15.h"
> > > > > > > > @@ -1905,6 +1906,72 @@ static const struct
> > > > > > > > amd_ip_funcs vcn_v1_0_ip_funcs = {
> > > > > > > >         .set_powergating_state = vcn_v1_0_set_powergating_state,
> > > > > > > >     };
> > > > > > > > +/**
> > > > > > > > + * It is a hardware issue that Raven VCN can't
> > > > > > > > handle a GTT TMZ buffer.
> > > > > > > > + * Move such a GTT TMZ buffer to VRAM domain
> > > > > > > > before command submission.
> > > > > > > > + */
> > > > > > > > +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> > > > > > > > +                struct amdgpu_job *job,
> > > > > > > > +                uint64_t addr)
> > > > > > > > +{
> > > > > > > > +    struct ttm_operation_ctx ctx = { false, false };
> > > > > > > > +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> > > > > > > > +    struct amdgpu_vm *vm = &fpriv->vm;
> > > > > > > > +    struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > +    struct amdgpu_bo *bo;
> > > > > > > > +    int r;
> > > > > > > > +
> > > > > > > > +    addr &= AMDGPU_GMC_HOLE_MASK;
> > > > > > > > +    if (addr & 0x7) {
> > > > > > > > +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> > > > > > > > +        return -EINVAL;
> > > > > > > > +    }
> > > > > > > > +
> > > > > > > > +    mapping = amdgpu_vm_bo_lookup_mapping(vm,
> > > > > > > > addr/AMDGPU_GPU_PAGE_SIZE);
> > > > > > > > +    if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> > > > > > > > +        return -EINVAL;
> > > > > > > > +
> > > > > > > > +    bo = mapping->bo_va->base.bo;
> > > > > > > > +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> > > > > > > > +        return 0;
> > > > > > > > +
> > > > > > > > +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > > > > > > > +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > > > > > > > +    if (r) {
> > > > > > > > +        DRM_ERROR("Failed validating the VCN
> > > > > > > > message BO (%d)!\n", r);
> > > > > > > > +        return r;
> > > > > > > > +    }
> > > > > > > Well, exactly that won't work.
> > > > > > > 
> > > > > > > The message structure isn't TMZ protected because
> > > > > > > otherwise the driver won't
> > > > > > > be able to stitch it together.
> > > > > > > 
> > > > > > > What is TMZ protected are the surfaces the message
> > > > > > > structure is pointing to.
> > > > > > > So what you would need to do is to completely parse
> > > > > > > the structure and then
> > > > > > > move on the relevant buffers into VRAM.
> > > > > > > 
> > > > > > > Leo or James, can you help with that?
> > > > > >   From my observations, when decoding secure contents, register
> > > > > > GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
> > > > > > buffer address.
> > > > > > And this way works when allocating TMZ buffers in GTT domain.
> > > > > As far as I remember that's only the case for the decoding,
> > > > > encoding works
> > > > > by putting the addresses into the message buffer.
> > > > > 
> > > > > But could be that decoding is sufficient, Leo and James need
> > > > > to comment on
> > > > > this.
> > > > It seems that only decode needs TMZ buffers. Only observe
> > > > si_vid_create_tmz_buffer()
> > > > was called in rvcn_dec_message_decode() in
> > > > src/gallium/drivers/radeon/radeon_vcn_dec.c.
> > > 
> > > Mhm, good point. Let's wait for Leo and James to wake up, when we
> > > don't need encode support than that would makes things much easier.
> > 
> > For secure playback, the buffer required in TMZ are dpb, dt and ctx, for
> > the rest esp. those for CPU access don't need that E.g. msg buffer, and
> > bitstream buffer.
> > 
> > From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt
> > buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
> > 
> > 
> > Regards,
> > 
> > Leo
> > 
> For VCN1, due to performance reason, the msg and fb buffer was allocated
> into VRAM instead of GTT(for other HW), but those are not TMZ in order to
> have CPU access.
> 
> 
> Regards,
> 
> Leo
> 
> 
> 
> > 
> > 
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > 
> > > > Regards,
> > > > Lang
> > > > 
> > > > > Regards,
> > > > > Christian.
> > > > > 
> > > > > > Regards,
> > > > > > Lang
> > > > > > 
> > > > > > > Regards,
> > > > > > > Christian.
> > > > > > > 
> > > > > > > > +
> > > > > > > > +    return r;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int
> > > > > > > > vcn_v1_0_ring_patch_cs_in_place(struct
> > > > > > > > amdgpu_cs_parser *p,
> > > > > > > > +                       struct amdgpu_job *job,
> > > > > > > > +                       struct amdgpu_ib *ib)
> > > > > > > > +{
> > > > > > > > +    uint32_t msg_lo = 0, msg_hi = 0;
> > > > > > > > +    int i, r;
> > > > > > > > +
> > > > > > > > +    for (i = 0; i < ib->length_dw; i += 2) {
> > > > > > > > +        uint32_t reg = amdgpu_ib_get_value(ib, i);
> > > > > > > > +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> > > > > > > > +
> > > > > > > > +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> > > > > > > > +            msg_lo = val;
> > > > > > > > +        } else if (reg ==
> > > > > > > > PACKET0(p->adev->vcn.internal.data1, 0)) {
> > > > > > > > +            msg_hi = val;
> > > > > > > > +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> > > > > > > > +            r = vcn_v1_0_validate_bo(p, job,
> > > > > > > > +                         ((u64)msg_hi) << 32 | msg_lo);
> > > > > > > > +            if (r)
> > > > > > > > +                return r;
> > > > > > > > +        }
> > > > > > > > +    }
> > > > > > > > +
> > > > > > > > +    return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +
> > > > > > > >     static const struct amdgpu_ring_funcs
> > > > > > > > vcn_v1_0_dec_ring_vm_funcs = {
> > > > > > > >         .type = AMDGPU_RING_TYPE_VCN_DEC,
> > > > > > > >         .align_mask = 0xf,
> > > > > > > > @@ -1914,6 +1981,7 @@ static const struct
> > > > > > > > amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > > > > > >         .get_rptr = vcn_v1_0_dec_ring_get_rptr,
> > > > > > > >         .get_wptr = vcn_v1_0_dec_ring_get_wptr,
> > > > > > > >         .set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > > > > > > > +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> > > > > > > >         .emit_frame_size =
> > > > > > > >             6 + 6 + /* hdp invalidate / flush */
> > > > > > > >             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > > 
