Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B840BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 11:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3728E10EDC0;
	Wed, 25 May 2022 11:37:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C0710EDC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 11:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrq/8TY7sziq54W/e3+OWlA0zwFPAjtGM7fTp9G7vO8hiM3QbVwitiiDGnJ6cCZRtEmaXJxP/yP02Z42BqVenDPYiUnEbtBEtcA609cRcanzLELTrpPu2kqbQBu7CX11W3HqgIigr/AJG5LJmILlp7Au20tMkNTMzij1RJAFDzpSK1Y7MHHVACPALKN4zO8xY3SRr0Pcv1tvrN8vTmg+NobxNPi3vBfMIeQwFaFk4wZwFf+uycqh/w17T1q9KZuATeag78fMGe5pGL8tE01IpNoRZQktCU4c5eNvqaxMRzXRHuGMExdHA25FwNIkDGY1eAe9Jc0OWkig1MJjdsxBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRVujQwPg5mgGoEmtTxKs1WYe33znEln8SBYQNGj8uU=;
 b=HuHZdRBWm6Dd54Hf8sKp1JsxQlKtxc1E4uWhkCue80PY67gbM4hP3S9Vp/0YsmFoql+D7a4+ibAKRpknPgsElrjd7AH+IhC0xjeWDKyK7ipqjCEeWe55vdU6ZFhaQ9qmI2w1DQtT3NfHC5deSKwK9tgvmQlB0aVWTG0eayVmroV13529xd03UP+2Gt4Hszr+q5NUk2UepKun/mYgpGFzuxIUjzhnbAFEsD1UXPl83PoSJ0UvMVMntH5p2c2U+dRmmq5E05Ln+Nl3p2KsF0tEdZQ17WcRdAfoNG/LOcy3xkmLmf6z9mEzdUX+3W8EC29Md+kcD1dDuJVQf6QtOmu1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRVujQwPg5mgGoEmtTxKs1WYe33znEln8SBYQNGj8uU=;
 b=PHOO2aFP0xknbZvePctJ9pGZ3Rov9AM4lVOx4yvKqZhc8n8+VQvXXlan+SIvA7HPVUI9zzYdEWCWPdWZljTyE5HZ0+gZqG7+hJhspQ65LeZeOAr5aFW4GJ1P34S8DNXECgKzu087nlgwIJpmKLtUblJnYOxf5gDFX8Y4hNUbN8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 11:37:36 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 11:37:36 +0000
Date: Wed, 25 May 2022 19:37:28 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Message-ID: <Yo4U+BrDV8bgALkJ@lang-desktop>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
 <Yo31/hZQ7qzs2KyO@lang-desktop>
 <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e133a0-2506-4984-f7ff-08da3e42f758
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42223DDAABD3DB2489CE87FFFBD69@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1ctHqhaJrcRllBtY1wlI5xzQWrvYiVXiftecNnQuKm4ZA4//0a9o7ltQ8aJVnkAJdP0uxjfkQIR+AIj5pkw2aI/qmZuy356rrOmRTPyeBRumxfxtDzSdD0As/ykukEIkF5+r54Yjbi63threMPWdrkLZg58GqNT5e6G4SAWSsngCRrXwkuo97xZ0ETKdgGdjSJ3aeoLCKF/uwXAGy7vqD+nRHSST1bMH8kq8YCfGmkbfYEvJeZ7ajPsGSs+0g/QE4TDFQYeOVyti5vfrnAESev0n9V8i0hs9TS1/f34NePSK09jKcGQ51rlFTsUopiCYq7giYNm916JM89QfgTlLqCllAzfS6DhGQxn5iZVRH6hhHw9EqmQrlWNd/bezMAZ3RDk0A4T3oVDrzVOWY9zkiX2c9FSaasci6RC8yoEj475OzY65S00cILRn0GBeRsRsO1LWJmQqKnmR+P2Gg7CrODEzS5JWnVmRVVsAbOyA0NYk0Pn3brBtgMzGz7iYGRwF50rthib4JA9NG3BQf5pgjNTpeC3iZ2uoqBROu6HdhyhytLYLCIKts3mr3a6yK2ZI9jv8zzGJjju/B3MvCN+9CIc3d2RvLLPf0NSj1TSzQFq5ns36xAtGgMlMxk9UUbuzqm8EwpyM3A1788CAk9YvVVXpoOJAK42y6L3nTJc6QzUqznAsT1C3D2xHKq2Wpopl2yqxaxFILJ1dNeMiSWLyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(4326008)(8676002)(86362001)(15650500001)(6486002)(33716001)(316002)(186003)(38100700002)(2906002)(508600001)(54906003)(8936002)(6666004)(6916009)(26005)(9686003)(5660300002)(6512007)(66476007)(66946007)(66556008)(66574015)(6506007)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KHIEziqcEBFSJxBxcnNZXziRE47bG584pkXBjh69e19eMk0PczkIJDhYYV?=
 =?iso-8859-1?Q?zG88CAJ7TegxXZqsXYdlkkI+RTxmyAx8TwFlXXL4NVEREhSkDZvUNEDWvt?=
 =?iso-8859-1?Q?J/RTiqMzNeN+3Bv26jgdI6yQLureWcYhG6BswXTliHTiAUqGx8qDQ/jIpf?=
 =?iso-8859-1?Q?ddL7DlN6AJLlmowQnjBoGUk/5Ub6EA83MFyuetf9ehKTB8z9cu+t1sdEWu?=
 =?iso-8859-1?Q?+6awyiHxm895aVNbipFVj53awWV87JCArfW3alQmGp4l2XR5bkBWCvSdsm?=
 =?iso-8859-1?Q?nS2sHwrSiAwYUVbtzM43tbtbUUfYTSHZ9hFC2sYco54PW5NEwDLUgTfMRf?=
 =?iso-8859-1?Q?+tC6jYAJBm5XzvUnRydgjMW7srB2hZbEfx6jr0iObEKHlX1xR6EizLC+0p?=
 =?iso-8859-1?Q?XMjtTl2wpzp7QLPOy9QZdYeSAjKuFwJ9KcK/Ek2E3elfHH/COXvhyQbSIM?=
 =?iso-8859-1?Q?CcE+SJhTJuxn19ubnMrvh9FHnm/7WCcbpXlAc+vXvYHFtd0hJvOB1R0zyx?=
 =?iso-8859-1?Q?S7JT5OjIyq7qWHSoopu7H5DxOlS4MHcOaolFnfeAYJhoM8G6yYyYkAknK0?=
 =?iso-8859-1?Q?fjnAtj89yChLjJ58uCL1pzGZVzE+gC907HGakmXY6rpCSD1kfIC9eU6AaF?=
 =?iso-8859-1?Q?tEiUeGcbdI4UoYzqddF2Q8dSVbt+31I6PLKm3LqgXFMlRcitZkcM/9ktZq?=
 =?iso-8859-1?Q?4IiPQ2iUBcCOMarzhysn2YqEta1JD0D69eBS71nqwOHGIcgF3XtAnMNYVM?=
 =?iso-8859-1?Q?kowreJYSiP4TpZepOl8AsUxdltBRhjcbVK17AmYIhBxWRtVHDlgUveuJVN?=
 =?iso-8859-1?Q?Us4KZaoGchbLXi3UGm1lDNsZp0mH+qJaJr5t3hB8K45bwWG2DEFc0+qkjh?=
 =?iso-8859-1?Q?367b0u7vgsaTjCW3nWBRqwMtqvClUqdeztqevpkL0jVYigO024Dn3tomop?=
 =?iso-8859-1?Q?cUeKerDc0c7m8Sspx8JgHGeEfaL7ADRLy0lVN3z+7PElydYNsnpNQ3oa/h?=
 =?iso-8859-1?Q?xXezM/j8zxgpLDBZtRptvVnN95HB3CexH5nAK9PFuXl9ZJQLb91dnaFF+B?=
 =?iso-8859-1?Q?JOQqaDvrZzhIwp8UHeAS5bF5r9HYSGFmOvIc2iGyu9Vz98nnXF3MBN0oby?=
 =?iso-8859-1?Q?O5NHjGTchYA45fDOJ5m+hZ4ugOE6t5ROuulCDlfycwZw7d6zDJkaYILuwx?=
 =?iso-8859-1?Q?OvyPXAKfJSPychtlaA2qnfo2oLX7dxmtKDnM9p0l+RKbxm/wHBvSZ69ppa?=
 =?iso-8859-1?Q?pGMZucO7VVTY7CBCzCqF50KFtzT55u5CMsBMgISZMH9mqDaloJpAsqzc+y?=
 =?iso-8859-1?Q?GWz3LkKvVB9gQe1GzUWDas2uXalZctUyBxLmnIv0G1Gdm2zlm5uY7p81vH?=
 =?iso-8859-1?Q?hwE5eRoc3tMwd8ptkZTX2korJ/tjzJawwVU/8LgIFTyMf+33IkVmdhUQgN?=
 =?iso-8859-1?Q?Yq+x1Wtvrl6uSddOKZI0TVBZXFwm/CACfgVKztsfAtUScSHVWico0BG6cB?=
 =?iso-8859-1?Q?zwPOz776ZSCzuWmn6lR57jqgnsh89aH3u7LWeAtKFJJWov6SHn4DZDG80O?=
 =?iso-8859-1?Q?Cqec2na+4gZm5DeErU6LlCMCH8zYRb/L0GpyBGvNGsjHQNbTmWQHpunpM/?=
 =?iso-8859-1?Q?JmfKx4PO2MM/CA9AhlAeo2K4dcwDhced/Q3T63wxbX7cqafRrbnFgabG6V?=
 =?iso-8859-1?Q?3KUPta0GqsdaPqlJEC5jXhztaONR5RPXKV6Mzu5MSNJAxLgMP7sVU1hha+?=
 =?iso-8859-1?Q?5T71inVhxhMWKUGQmFcdRGCmXculUJE8uqzWNrs8h7avpH/9qw0M5xZ2Ni?=
 =?iso-8859-1?Q?TU1qesI5Yg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e133a0-2506-4984-f7ff-08da3e42f758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 11:37:36.5850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQt3pmquqU1AZE69NX/UohmhEHLeILd4Wu2F1fV9VqHWzzj55MH20o1HYVgBtRGA+OTea0xvbph99FEAM+bbNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

On 05/25/ , Christian König wrote:
> Am 25.05.22 um 11:25 schrieb Lang Yu:
> > On 05/25/ , Christian König wrote:
> > > Am 25.05.22 um 10:43 schrieb Lang Yu:
> > > > DOORBELL and MMIO BOs never move once created.
> > > > No need to validate them after that.
> > > Yeah, but you still need to make sure their page tables are up to date.
> > > 
> > > So this here might break horrible.
> > These BOs(and attachments) are validated when allocated and mapped.
> > Their page tables should be determined at this time.
> > 
> > The kfd_bo_list is used to restore BOs after evictions.
> > 
> > Do you mean their page tabes could be changed? Thanks.
> 
> Yes, page tables can be destroyed under memory pressure as well.

Destroyed? You mean the contents of page table BOs are disappeared.
If so, could other BOs be destroyed under memory pressure? Thanks!

Regards,
Lang

> Not sure how the KFD handles that, but in theory we should have every BO
> used by a process on the validation list. Even the ones pinned.
> 
> Regards,
> Christian.
> 
> > 
> > 
> > > Christian.
> > > 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
> > > >    1 file changed, 9 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > index 34ba9e776521..45de9cadd771 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
> > > >    	struct ttm_validate_buffer *entry = &mem->validate_list;
> > > >    	struct amdgpu_bo *bo = mem->bo;
> > > > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > > > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > > > +		return;
> > > > +
> > > >    	INIT_LIST_HEAD(&entry->head);
> > > >    	entry->num_shared = 1;
> > > >    	entry->bo = &bo->tbo;
> > > > @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
> > > >    {
> > > >    	struct ttm_validate_buffer *bo_list_entry;
> > > > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > > > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > > > +		return;
> > > > +
> > > >    	bo_list_entry = &mem->validate_list;
> > > >    	mutex_lock(&process_info->lock);
> > > >    	list_del(&bo_list_entry->head);
> > > > @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > >    	unsigned long bo_size = mem->bo->tbo.base.size;
> > > >    	struct kfd_mem_attachment *entry, *tmp;
> > > >    	struct bo_vm_reservation_context ctx;
> > > > -	struct ttm_validate_buffer *bo_list_entry;
> > > >    	unsigned int mapped_to_gpu_memory;
> > > >    	int ret;
> > > >    	bool is_imported = false;
> > > > @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > >    	}
> > > >    	/* Make sure restore workers don't access the BO any more */
> > > > -	bo_list_entry = &mem->validate_list;
> > > > -	mutex_lock(&process_info->lock);
> > > > -	list_del(&bo_list_entry->head);
> > > > -	mutex_unlock(&process_info->lock);
> > > > +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
> > > >    	/* No more MMU notifiers */
> > > >    	amdgpu_mn_unregister(mem->bo);
> 
