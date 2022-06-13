Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E17C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B67910E02D;
	Mon, 13 Jun 2022 08:41:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B56210E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgkmPXuBc36AO0nPm89vOWjYiPVYvaMm6LUCUP8uWpK6uh0n6H7L9nQQ9RCY7ow5T/VsSKEtqxCjEhYrIfvLfCg/9AS8SAcPvuOG2Z5MreYXjdjID7UusHyN+yATWH1cFvObib2HzB1NaoiOgoSmtaDtS51N2eK30K2/e18P3nLkPA93x465EcfVOktLFqLsElTV/PCqPTU0d97SaZWGW2Uvg5F9KXnEW+hylTBZ5f5s862ipZW3cs0IwZDDqFUrLECuTA3nCM9Er2G94TeKoYI3o7IfVvbjSBtmPK/mcnGvkeHGsIv+6+z4O+kDwLvfed0ZQqTA5m/QbT0m9sZG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIETJgbNtBTq94R4ORh4Wje/wzTHM9oafv6FYoDCBW4=;
 b=k2zfynHIzwB6tUFnNi2M/A1oVZC5g56SZ21zmHNBm0g/z9dwKhKbdgAkFuS7m6MVEpcQ2Zt4uz99tqoYwemDoKwpuiRDjN2QHe8bp0smA212fuXrHxtzeNglJd8Tz6WgpWRs2YPbC4HBApnYzwljYEATzpZ4Qt5HQ13xjBvCNd4xhm7wAvUPUvyUKst+1YBVlYJ5+UYL6EKPea379m9ShDlFD64la8vzaQhGpcTUDy5a5H79LIoUq8C4Dch7aGBKUG0Q6TW871cUkHpUVUS3cfOIdhpIvoYC713/C0AJLGeTTCNpaAHNVYthLnytZTuqmozBp5Q8edDrCTIc+ypXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIETJgbNtBTq94R4ORh4Wje/wzTHM9oafv6FYoDCBW4=;
 b=TJ6hhNymhZkUVoBPBdrXktAR7RabCfCoVABGh/Nfk0E057L/GRpq4SviIr8E5lc6YYVY6NDs8R5zEhCnlXRosY6choQJb50d28xqcrbz/+8kUeS0LvoOLsmibsVbpyfo1d98iWkBTXPZ58j4TtnOCefpbZFXutzgYV009AYQi78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 08:41:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 08:41:31 +0000
Date: Mon, 13 Jun 2022 16:41:22 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Message-ID: <Yqb4MrCTAVcnaGoZ@lang-desktop>
References: <20220613075956.720375-1-Lang.Yu@amd.com>
 <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
 <Yqb0qO2mym1X9ha4@lang-desktop>
 <13337f06-0244-008d-4f9d-672a99206b69@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13337f06-0244-008d-4f9d-672a99206b69@gmail.com>
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe71617a-68ff-4c3a-0d9c-08da4d18841d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4535727FFA3713FD083E63FEFBAB9@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV/cI/FPZ0L5j5NKgxyJf2L6tQRV7fERKpc1yhEkglNZ4KZ2DpfsG0EB4QVAnFFL+ZZm9Ou28RcJhpgibPlAZ/kWtjwFeFfUdPXJ44qfSu61Ct1el4zrE1QZjuuoYX9akCvDkGlHgFbYltBbxB/xdgcGCQMEmtuMHSD1x9TwBzfKKsax8e1vuuZr1eRlSt48s9wJzTM3Zk+Vmwwm5wu8Kb+4biEax8fegve3FA6ZR54Px+ZO6t4ZmcWLIBYi/OXcojFMrEvqRyd90rApyOGoy2WZ23yeQPOM5bfcncloF9dgsamcHTxv+67lrSVIHi7XU5Axxa59ZQTNkTG6pdUvRKNIQOkmhSXAGaFei7a7f9joUTYz4qaVdDnluIRPLdJKBvbQlFckStb0Zbqo3cpesk90P3hZmxJEuXSh7BnkQj1BVYfLPup+xH0RQtaM2C/WxmmjSRrgkMJZ05Z9noDPqedxmczai8zFniZT6KLt8aa0gA91pcjEibD24dntiYuEoFp8b7EyuUAk5l0QmfQVw4Va3EW5ODPb3yAN71a6R00nekTSuN0GJIoE4VIDUQnuAr1wYSq04IWDUiXFFgUtI+YVByHcYdPLPxZyMEKadbENXwriwTxGSHkFGLQ1xpc6eofUjvP/B14N7+1nQCJEuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(366004)(54906003)(38100700002)(316002)(4326008)(8676002)(83380400001)(33716001)(66476007)(66556008)(6916009)(66946007)(66574015)(2906002)(6666004)(6506007)(508600001)(186003)(6512007)(26005)(5660300002)(86362001)(6486002)(9686003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UkFU8fucXtNDXEedA7O0nymnaTcxp/zR28UWe+o2M304FVqy39vH95DKyT?=
 =?iso-8859-1?Q?aUbYwYsZ0am9xkDp01bPcDEKVuRaxlt1bYl70Tp2k1yfVqXig3TQGAf4Qy?=
 =?iso-8859-1?Q?LTqAR9LXHdeES/VIW0tk/oL2RIecKuHUBv9QJXlGXKMKWO0X6FzmOucVZ5?=
 =?iso-8859-1?Q?nV62zBKH06j11lRQNdFeFSznrKVn9i7kI1qaklX44TvZszr2iGhqZYt8Ey?=
 =?iso-8859-1?Q?Yjof5H50gq0xdX2eEXyEqwm4SrtYTuSRhiBdxHzuUs205IAr9JRkUuglJQ?=
 =?iso-8859-1?Q?Qrvp5+K96/TGHOxooAKbY8LOUqB+1MG2K6orLQ4XSnHV2c8HIGs1TTh2s0?=
 =?iso-8859-1?Q?OSTBUtQ3MFJ5E0Yz9Jhh8pn7r0sz0MKkHJZJXqRtsb03tMe+EKYnfIHXfr?=
 =?iso-8859-1?Q?vjabmWoS3Jk9SgvGSQgUV8YQp3qxf3dkjdmlQG1BxoPXLDbismSF6WYwER?=
 =?iso-8859-1?Q?9qZx5N5+Q99ZtqdmB4iB0PJMouFk/FIwu1ZcXGblAzzusrD43T0TzfSTDc?=
 =?iso-8859-1?Q?PAx3F9yJ791LkXBudn9wqh9fHH/EI5IkjY431Ppqq0qj5w52pudXlp6Joh?=
 =?iso-8859-1?Q?NjR89BRD2BEionouusppCsu3Y2fPTN1FVaozIgETq/SCMaN1UXEVYl7mxN?=
 =?iso-8859-1?Q?ehHxlnO+3WqRP4rTGzY15673Qmu0GqG+y/am5U0JkmIkcGo3ssqn8DPVpU?=
 =?iso-8859-1?Q?vkPsXXw4YQ3MttUzcvtrn2vr9kXxKm8cU9V3+njD+2NWs8rBMZzgJB4Gs8?=
 =?iso-8859-1?Q?AJV4NdDbme2YEZQxYoIGd3Ud6Uv8UmyXzKm+vbfWXtKiFAUOqjojariYOP?=
 =?iso-8859-1?Q?M4l/AwJjdEHHip00TbGB1eiuJ1EafyXQSfJc/++oN7KzRddiaHCCV9BBZB?=
 =?iso-8859-1?Q?R6OQvDQ8VIMWDLVmxmrJ63upCoCMiM6coQD+WJC0Kwx/xnFtMyTuS9S6Id?=
 =?iso-8859-1?Q?34yu5Sajy2c3FGKoKbLT8cz7RUEmO4lv9vpTmCu8rZo0Em6kzQYDLjlHm1?=
 =?iso-8859-1?Q?kufhluIz27dMWotRCMLB65nwd8uVaC3Q5nvoa0+55L/HbmtqDDlXJ77N+1?=
 =?iso-8859-1?Q?78tkIuG62oaBJJBe60H0wil/HjTc4V7wtkQ7HJWCGM/dEATLhxhygh0dLM?=
 =?iso-8859-1?Q?Rc/oZ9UXTXUPPr9YewTXwHNFhQMcp5ufChn/LT9rtQXJtfnP4PVePBNh9e?=
 =?iso-8859-1?Q?EZ7QHnHpJndDp0B1xMg27xjhvzDoEd6JwtBzdMCF2GX2ni48W+6NjDwZDr?=
 =?iso-8859-1?Q?AVp+xJmSrW7QTOUD0nCHVIJLKzGXcrXck2tyWoV/JFNhV20+TGUtxf+WHT?=
 =?iso-8859-1?Q?J4v02fouWstpncOpIje0p9wgVVpeophFeKC4whkYO5xkSseEHRQHVFagzA?=
 =?iso-8859-1?Q?kTMk5mVZzjT4igriCOUWLbsWtMkuus9RHyHqqTNCKY3L0VLTDwCMAD2lUn?=
 =?iso-8859-1?Q?jh3+oqT+Ak3OpP7MgeZm0DqT4KMsl3iTj5WzKrKWwNVf+IB3Nxa4yyNHN3?=
 =?iso-8859-1?Q?Ngmx7jnClAchXhRsyb3QiavXZZOyouqq1Fi7dCQUKBw7fgJBVJZTKU2Z+6?=
 =?iso-8859-1?Q?V262GO/Za7WqkU3vUVwz3m6zDKu92On0WnLWL1I84Thu7WzMgli23l4dpY?=
 =?iso-8859-1?Q?f/SJmLnYMLWxU1CDN2cEwMvv83Z89NMazV+8QLqKYsjnzihwL10pFYo2wn?=
 =?iso-8859-1?Q?LOkAfMomc+MrDiCSwFXEMxrCb75xxvdO1zHM6kHo96ibUKFLQ3JkV+y56O?=
 =?iso-8859-1?Q?yC7/RMWOvbqMqDb0lnFj+1a9QbxMACLCp0c07On19L1yg2ZdXjmoZgtwlL?=
 =?iso-8859-1?Q?ua02c0I7JA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71617a-68ff-4c3a-0d9c-08da4d18841d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:41:31.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKDVOY/9h5bY3+BZptfqIc2epMkI23dj3WnQJwqxB1ZKnEFBWXy+zJ3KQgBFSddR5e/LZtg9gduewc+xTMTm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/13/ , Christian König wrote:
> Am 13.06.22 um 10:26 schrieb Lang Yu:
> > On 06/13/ , Christian König wrote:
> > > Am 13.06.22 um 09:59 schrieb Lang Yu:
> > > > We don't need to validate and map root PD specially here,
> > > > it would be validated and mapped by amdgpu_vm_validate_pt_bos
> > > > if it is evicted.
> > > I'm not sure if that's correct. Traditionally we have handled the root PD
> > > differently to the rest in the VM.
> > > 
> > > It doesn't make much sense any more today, but I need to double check if
> > > that isn't still the case.
> >  From my observations, if root PD is evicted. amdgpu_vm_validate_pt_bos
> > will validate and map it.
> > 
> > And amdgpu_cs_list_validate always validates root PD after
> > amdgpu_vm_validate_pt_bos has done that, it is actually unnecessary.
> > Do you think it's worth skiping root PD validation in
> > amdgpu_cs_list_validate? Thanks!
> 
> No, it's just your change is completely irrelevant and just complicates
> things.
> 
> Validating a BO twice should have basically no overhead at all.
> 
> And especially adding the manual call to map_table() in
> amdgpu_vm_make_compute() is a no-go. We don't want such specific handling
> for compute contexts.

That's because when turning a GFX VM to a compute VM, if vm_update_mode changed,
we need to map the root PD again.

If we always validate and map it in vm_validate_pt_pd_bos, that's so confused.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lang
> > 
> > 
> > > Christian.
> > > 
> > > > The special case is when turning a GFX VM to a compute VM,
> > > > if vm_update_mode changed, we need to map the root PD again.
> > > > So just move root PD mapping to amdgpu_vm_make_compute.
> > > > 
> > > > v2:
> > > >    - Don't rename vm_validate_pt_pd_bos and make it public.
> > > > 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
> > > >    2 files changed, 5 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > index 6a3bd8b9a08f..3805eef9ab69 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > @@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
> > > >    		return ret;
> > > >    	}
> > > > -	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
> > > > -	if (ret) {
> > > > -		pr_err("failed to validate PD\n");
> > > > -		return ret;
> > > > -	}
> > > > -
> > > >    	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> > > > -	if (vm->use_cpu_for_update) {
> > > > -		ret = amdgpu_bo_kmap(pd, NULL);
> > > > -		if (ret) {
> > > > -			pr_err("failed to kmap PD, ret=%d\n", ret);
> > > > -			return ret;
> > > > -		}
> > > > -	}
> > > > -
> > > >    	return 0;
> > > >    }
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > > index 703552f9a6d7..08fda57f5aa2 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > > @@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> > > >    	} else {
> > > >    		vm->update_funcs = &amdgpu_vm_sdma_funcs;
> > > >    	}
> > > > +
> > > > +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
> > > > +	if (r)
> > > > +		goto unreserve_bo;
> > > > +
> > > >    	dma_fence_put(vm->last_update);
> > > >    	vm->last_update = NULL;
> > > >    	vm->is_compute_context = true;
> 
