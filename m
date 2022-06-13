Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F1C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7182210E0A5;
	Mon, 13 Jun 2022 08:26:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0B610E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bldSucMqLBB9JgxjeH8OHNhd55UXJ1O/Fxabb2jS5jVokm0rnRPKNmD78yGqRRdneMNso6iWceOB2e94dXBmUO2hfeBV62z57UqtxEYCXaw/QE4YzsyiFWNvMDBm2fAyfFQ4pR1qVsaaNinssLFxwgd44n2p2bv8b+shsR3CxK581P55yL09L4rZg3kqIeYEIjK9YIX7LfKw+x0zehG5ShEKYT9il79pC7WM6LU49trWOB3osDjIv0Ue+/zOP/ZTi2bPkVbxEL/dg7xwQFVOCR/6bO8w7MLM/xbYPMXpb7DU/8r6oGny/Tgo/KaSX7gkVK9xobqw+b/GMt5DInV01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v37EquqF01xc0iC5KR1qShysa7EpSAXMf6G17gAWFik=;
 b=D9JGfME8T2ScsjFxdAm94DXChT59kBMJ+vcgQmWuXwNhZ3sX7D7KuN5ubjhbGhaxQQkL6gpZl2elGyI68463dQZ9PJ3Uo51sp6D2Vqbe9s0+jVTtygsszDeHO2P+PQHzuYV3IQIqsK9INqDMszmmC9nAGZjBUxbrKZMTJzDo4kDgWIq2lsC5s5xivsKVJNaY8QdQTER+y5LkmTbHL5VUtxCU8lUwC9ZfLAXiqHFaa41FQD065gm9SOo9HR7poZXbd+f4/UVe0d1tbWPElxACQPoMxh893OEy1xL8LCHC2ihVHVGzOn6LTfq3K4LI4a94qEoiugYSU2LQaextX95DaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v37EquqF01xc0iC5KR1qShysa7EpSAXMf6G17gAWFik=;
 b=ubPlZJGD/DQq8n7X/+mEb0FDS4bE/vEZ/UwM/0dxGGcXoFEbcKsqibkhF+0uKkQTX+9ZhJPEUFm1RKXugHEruGiWRIevw/geJaE7LLlF+aKcELUg0H9InzGMq4ByzCXhMGtdJIaDU88fgAN50Xe8QJcJT9TVrETK4dCgu3+5B+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 08:26:28 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 08:26:28 +0000
Date: Mon, 13 Jun 2022 16:26:16 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Message-ID: <Yqb0qO2mym1X9ha4@lang-desktop>
References: <20220613075956.720375-1-Lang.Yu@amd.com>
 <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da82fe1-1c9a-4f1f-3db4-08da4d166994
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42193C9E3CF769A25A31A6CFFBAB9@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGyMxlfq+afhBo3DeWBdLlHSkT496eJfPhwutgo1Ny9Ta7ZNFJdaAyBl/tVoc3qYaDm7aA5aWZi+8ZMrhPaRiejW+b/J7J7x7dI/6srjLPptQzBR+7I9e97TEVH0i105FM1+G8GoQpmMyBRO5Gj1sPD0TzPbL3UghD/th1WOLq00qY2vEg+k9MpKfI15n+g6GtjeUH2DvbohINJ1s2YcmLB5rTGDJURx0/83J2ikolAoq9/VNHxp8AwIwo1czmdU3GrJmw9rHecuB4Zi5cO/Uo/hzTXUXKRCArvjLwjw15SO2GPUBnMW4XYzApPyejA2tk09/jDH01b5JUIyZWnaTSOuLzLG0vHKMK2hSP+VWj+kL7mRnVh9LMXdg/UwGrvX8jDmOA0FFHJGiWOljYavnhgD1HSpMcr8tUxgOygidTTemc4vZS86rG6babatp3ukN/6QglNBK4Usnhk0tgai8fdoHd66kGCX1M79JUCKmWAv6bM9Pg9j/4yutqhdqM4VDPEr3veYdbkj5/ar1pXx+2VN8nDTVdstEkwUFtaijYLxfyCaw34mCR6njFprWrtDPAho2yugIKvFWfDlNTE/tEpXwra2g8mQZ1YB5Lr23H9sLpnrMU69fqpZzkACWJc7wUclfv0Abp3hb5eX8Ha5EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(366004)(316002)(6636002)(54906003)(66946007)(66556008)(4326008)(66476007)(33716001)(6666004)(2906002)(38100700002)(86362001)(8676002)(66574015)(9686003)(6862004)(8936002)(6486002)(6512007)(5660300002)(26005)(6506007)(83380400001)(186003)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?znw3+/91omSW3C4Oz0EHVQAgrtQZ2gyuHF4Hz6YdV22NcGB2vUFHyAJqLl?=
 =?iso-8859-1?Q?7CDrSgvhs6EbK/e0/tPj7iuJdZEa/l39K561Sc4P0BKwCkgz0FQmvgcVJw?=
 =?iso-8859-1?Q?mqGY/Fl7mtC3TxBpeKYvzJd2cFDBBIKOJ0o5lSJRPDDRnycOBpMwwPbrQU?=
 =?iso-8859-1?Q?oNvZGcRV9iWjwnheD1qGbp3N4uL0cMYsF6du26Ys/00K+KMXwZSV4S7DvB?=
 =?iso-8859-1?Q?54MfEuynBE+4LQXGz2ZCbTgA0/UZyC3TzL3Tk5CO33G1Hi7osLFDahOR98?=
 =?iso-8859-1?Q?H22qNcIgNR8NT57vcVPIwSVV1Qt3ZJcQAbavlIIPE0Z5qNNMkESBS5EUkh?=
 =?iso-8859-1?Q?f5NshP5pSF+NqP4KeZIFaZzpTClAj9+i3WtdY0vVNI86Qj6HbOeneLlf45?=
 =?iso-8859-1?Q?sKvd0apbPnNe1uSt+f4gJQV8q38Ci1OW3Y1GKKu4EMdC+zMCJTHfT8kICl?=
 =?iso-8859-1?Q?mjKxjAWsPP4oXtagzfcQSckvBs5McwtM6ToOHJn19uayJzKRMh8/LCopMO?=
 =?iso-8859-1?Q?RQEGr4h9nrSMukrAk0OIkTDeTMzWQljwQt/PyJPfFl+yqjz6mDMYjxrJCg?=
 =?iso-8859-1?Q?554kPQG6LI5EUwOBM1sMNXZx9mWDe3iunlwNwhNOMTCmON2/rwq84o3TZt?=
 =?iso-8859-1?Q?6eLbZzu24kX0NfR2Aq9Ywg5XvYPm1ff231n1DYpN5Gzcmie8eB/4D+P19/?=
 =?iso-8859-1?Q?sZfRsH0XdNxkl34ffnzGzUOSe3GD/lchwsNN/qJ2xrgVLTCK15hg79AOYL?=
 =?iso-8859-1?Q?KGLVFp/gGmHIuqSIQx5oWxDN5NDIGjRPkxLGy7z+FZkW/vy8zOMkz1RMUG?=
 =?iso-8859-1?Q?iDtAN/61odUS4RgcBArhyYVlKdA7soB01GYRP1pNWWRCy3qpVr9X6GW9Tc?=
 =?iso-8859-1?Q?GeGsU+ec2pM8zCXX8ad97LG+ydg0Dvf4e8TXvTnd00l+v5VEZwGr5PAMb+?=
 =?iso-8859-1?Q?zY8SVUdgQNf32B8aUJ+tDvN9pU4JjqIChoaW20YBBKtFXCEZiX8bOg8zli?=
 =?iso-8859-1?Q?cDgy11rH7Rn8/8YZNND3zJ2QnJEuOoLwM+DZdP1obTK1ussgjFM02T2ET1?=
 =?iso-8859-1?Q?XrQTJJhtmbsi1bp1HSdzf8Yz+9/IqCPXekMAGwUHbWrYvNDLxJpnAjjd4H?=
 =?iso-8859-1?Q?nseNmcVoVJFEuT1bMGX2+E+wi/W6WlnCCEBTmo2XBij2HWpOJYXZYMAnL7?=
 =?iso-8859-1?Q?EokaT9Wei6swXF6rM4sathaLN1OmfVgd2/WM9sJ2Dx07XPOE4tF8s/P7AK?=
 =?iso-8859-1?Q?vHqjZTPSAtcjVqkgAgZqbKqV9G9de5VvSbJfe8RqtZDLpBW44PvjWDPg5f?=
 =?iso-8859-1?Q?2VBX+h8ttZOgGzrMrTNJ4l3xPAYTYI8kkRpF0SRCv5ZEGd3ocagznf+822?=
 =?iso-8859-1?Q?15QzuQbha7nDfkQs6ZxhxUt5l+PfNKJJVm4f9hTJkjSzcOtF5H5epgYt+H?=
 =?iso-8859-1?Q?qNO7CaYwU/h3z39Rug43bxGHgjc3yFXt4e3O5/WgCsUCGgVyjA2ay9MBI3?=
 =?iso-8859-1?Q?MPBMJZksh6cEV0HbIkWYKAdGwrMmyxou0RCNK8siRD2sYTHaKjcIZQNjAZ?=
 =?iso-8859-1?Q?0X02RHEPg/HO79NptqkuVaHnixPrx6sgdfC+Tuzdpsv6P9Ea34s8oH+4fq?=
 =?iso-8859-1?Q?2fukCv0o1OKZhY5jJ/sxQ4AuMBkLv7iQUSZN3GO/3tsHA03a/X8zWzlRJW?=
 =?iso-8859-1?Q?Om+pEj0vjITBLBqnUI18rsV3AFhCNhqaLbU+2zZxSmxH3qDH8yn7ghB+dy?=
 =?iso-8859-1?Q?jKbkKeBrWbi58Lty/E5VuuI2dJzZsaH//r6xyLLJX8aroK5rOE0XaySgZP?=
 =?iso-8859-1?Q?MyIQuDO69Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da82fe1-1c9a-4f1f-3db4-08da4d166994
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:26:28.3694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh/88MVj2LhF8Z8x3EneqpbWQe7jf1XyAZ6Ef3qXQI3RUZHrz+ycnaPgKDJ94CklnaJW11Phh3mlkUhJqJPyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/13/ , Christian König wrote:
> Am 13.06.22 um 09:59 schrieb Lang Yu:
> > We don't need to validate and map root PD specially here,
> > it would be validated and mapped by amdgpu_vm_validate_pt_bos
> > if it is evicted.
> 
> I'm not sure if that's correct. Traditionally we have handled the root PD
> differently to the rest in the VM.
> 
> It doesn't make much sense any more today, but I need to double check if
> that isn't still the case.

From my observations, if root PD is evicted. amdgpu_vm_validate_pt_bos
will validate and map it.

And amdgpu_cs_list_validate always validates root PD after
amdgpu_vm_validate_pt_bos has done that, it is actually unnecessary. 
Do you think it's worth skiping root PD validation in
amdgpu_cs_list_validate? Thanks!

Regards,
Lang


> Christian.
> 
> > 
> > The special case is when turning a GFX VM to a compute VM,
> > if vm_update_mode changed, we need to map the root PD again.
> > So just move root PD mapping to amdgpu_vm_make_compute.
> > 
> > v2:
> >   - Don't rename vm_validate_pt_pd_bos and make it public.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
> >   2 files changed, 5 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 6a3bd8b9a08f..3805eef9ab69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
> >   		return ret;
> >   	}
> > -	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
> > -	if (ret) {
> > -		pr_err("failed to validate PD\n");
> > -		return ret;
> > -	}
> > -
> >   	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> > -	if (vm->use_cpu_for_update) {
> > -		ret = amdgpu_bo_kmap(pd, NULL);
> > -		if (ret) {
> > -			pr_err("failed to kmap PD, ret=%d\n", ret);
> > -			return ret;
> > -		}
> > -	}
> > -
> >   	return 0;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 703552f9a6d7..08fda57f5aa2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> >   	} else {
> >   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
> >   	}
> > +
> > +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
> > +	if (r)
> > +		goto unreserve_bo;
> > +
> >   	dma_fence_put(vm->last_update);
> >   	vm->last_update = NULL;
> >   	vm->is_compute_context = true;
> 
