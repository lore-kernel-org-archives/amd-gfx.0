Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 12:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5C310F082;
	Wed, 25 May 2022 12:46:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D001E10F066
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 12:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQsD7MAENT4pA4xiLv7AZnKiUZOhE3OFkou1wxTqAomRuOBXHSXvM6mdgLlkZu673hEGWGQE2lKbPa4kRhaANtenyMBWXNPJMt3IoU0FKSnA0a4fI35s4ns/F6Qf2MJpr98L38OwWV8lXZq2a4k9RzuzCcL6n3YRmXpOuT+/V53tbtJomuMrHRQpWunCUcHgRxKAOjH6sGTBAkTkZ/XvdP9eDnfm/N119JYO+AxZra/1AgRlCx6HZmKE3XJWemwGN999GAxqlisiElQOddQFrLnRnQHPCK/GP0saaJ97fcbZ7RCaNDbInB9YiehP+GbW6kNnY+GY0/VzZniLVUgehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z93pLJCbamrHSUwlEuMPXGCJwGcAbsoVX8LoToxEXK4=;
 b=Fq2ctz5aDMNaQ5WLHyv+P+gw6rnnhbM4tOkBt3KN1EkFrGNEUtL/sSn42naAyePf+rg74PzX2D7jdm2g+oWiXO6MTDsM2jt4S49FfCxpINkzpBSFiZsc/pZmbzrEVw/A0C5eVU5Q7EO+Io/tHplk0lfE4pAnbQouRj/GSNhibcmddc96hrKlZC9I3lrQjlRpeXEi/2epljYoEOpsimPHTx3lCnRWYC4iVdIvcg9sop7arh/uWZRGs9WiycElqacp+PYB3SBdr5k72W5TJpwU/wdV6EiwjK/SeuIF4PHIwdmbwgzkeGdV7/rXh06DiJQoTrN3Ry76BYFdJAElHhuTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z93pLJCbamrHSUwlEuMPXGCJwGcAbsoVX8LoToxEXK4=;
 b=RYaF9qXqKzO4ofxjDQwyMBsbbd02fATKRIvRMtFOZpt8zXNJBse8a2N3PP87Bp11KYrXiw1U6rhAuPFWqtgxs/0v029RDQdww4hG5UKlGf7XiwS0DEZX+RR+AKgWNkB9x2vcWtIsPbAOJrpGpbcSccP3JksFdC72QuJJqjATSZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 12:46:33 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:46:33 +0000
Date: Wed, 25 May 2022 20:46:25 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Message-ID: <Yo4lIcdjOLkRD8x6@lang-desktop>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
 <Yo31/hZQ7qzs2KyO@lang-desktop>
 <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
 <Yo4U+BrDV8bgALkJ@lang-desktop>
 <d8586e11-8d65-93ea-8226-36cfd5ab978d@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8586e11-8d65-93ea-8226-36cfd5ab978d@gmail.com>
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e1c2874-97f9-427d-b829-08da3e4c9941
X-MS-TrafficTypeDiagnostic: BY5PR12MB4243:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42434ACBC43003B1747B672CFBD69@BY5PR12MB4243.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13L9A3nozK+LGqVaqpWfTcZodZphOQ+2cCJagCamwlVys2Lv/SUW/6qN/M/rSqmOQqS8dkMSjgoVfrl83Nj3Ypgx6xsiwQYwztrYLwTqthwzS9puDKoXY3ozANgX3eXlhOycH0UfXDhrevGfb1UhjfYk7L/CYBPjQar56f3qJM7w3Hin4gq2+d3ZJpey6lHTaEjJpbr9USv2+6utZP7gJ5tpo/fQhhtNB2SZ+xO9EQPmFH5Dq9Vu8bywY4wMVC/k3+DXHcUyyoTs04aA7IxI2DCykty7FQQ6nCKsLPGBAOzYw5WP6c3Pt0GvHKp/cmcJ5wP0AW+VdDPNNh2i+LgKP+OxVtgSPDej+HPWoZ+kjQQghLuzkoBnJrlCqYYDjGJ2WTywr+XFIHuzy9sSpopVwIbxShuEgImHXXUX3no9k75pJGKUqx+X/shhTw9V2e9RE6MHu2XxQxrJzvZ8vjBV5GraXAyl8Sidw/4XPm7tYCZ7p9mr/kyj36mBY3mQFN9zhfdp3Epn54wp/Avdw1UlkO5it/4PwcB//YCWfYQVCiazF0624vMAweAnNnBiRT9ggqYnqcUZSfHd/aNHJep3qBl166ZSJY+G2WRWBrquWwXkxH3tI7J+uaGCA378sv7jTdtXwNnGUnp742OfhW0TVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(66574015)(186003)(8936002)(26005)(6506007)(38100700002)(9686003)(6512007)(15650500001)(5660300002)(4326008)(54906003)(66946007)(66556008)(8676002)(66476007)(6916009)(6666004)(508600001)(2906002)(6486002)(33716001)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fJ73cB2r6P7r9DCZGyDvA0iEJ4cgFALfiokma9V54vuTt3C/AXMbT1wbee?=
 =?iso-8859-1?Q?WIQbX9eDWCM7KC+jIB9+vtQSluW5c8QwpggPgRzDDU+Y8PQ9RIXyhOeLD3?=
 =?iso-8859-1?Q?7Mu3fa9TCa3tRyNIRxArRVMVklJQxBLqJTFvmKuidbzwiaeYv1QQO3Qwzj?=
 =?iso-8859-1?Q?oGoYEmJmf8M4eFJEmPzSFmGHfp5kCMljEteI6BQnH5Uz46l+JPq+aJJi/d?=
 =?iso-8859-1?Q?DZ+oFNM5yUw2Tv7t0fF5crP/0XGPbweOSNclXJ5e0owMVc2D1PJxYemA8I?=
 =?iso-8859-1?Q?2b1RXXcTp6Y8wvAU0axq+SCzNOtK9bdPf3S7zJesRK9QJ0nFBGYwZWx3Kg?=
 =?iso-8859-1?Q?K1y6UHExdp1vOiyWwyp8sC7XYvsrar2nnYXlOBtE3RM9yXRyC72PNCDDHJ?=
 =?iso-8859-1?Q?g5ZTDSn5B8Q/2FxKFGQ2gQQmTMAnsqW7xPG2Zs+yXzF/xZfmBK8JLTuz62?=
 =?iso-8859-1?Q?bypk6goEnCf1C3W4b7gj658PnfOl7YfMjR1MVXGm9KuVCD1qDsY4N+QJZ+?=
 =?iso-8859-1?Q?j4ggikAzvqfYpNy4m/YIBWWa7JZvx6XcOMEXI2ZXFfeXewedtvrvtikKnv?=
 =?iso-8859-1?Q?gTbclM0aykOis2SPznF5DNtYhwggt5n+YYTlnqNV6iC1CA1OqmSeMTJpNy?=
 =?iso-8859-1?Q?08FwzZ6Ue8KqoACE8oQRkCdCRfCX9I2/08jlPb2dOjm2WqMUcxbI3Hj6UG?=
 =?iso-8859-1?Q?hFqwWi1IPtWSZNI92L6yor+Gq3qQudpnqGW3tB/BxqLlyYL/DtfvoJCXNY?=
 =?iso-8859-1?Q?c4wD8+nXgqx8m0hBTYy4we6dnbxxjDRGKHQzZ5IXpwZ9NA/l1ZktjDptCF?=
 =?iso-8859-1?Q?QX5rWCkgwWjcQMj3whwgYaoe3IFW55uanjVqNUIuGvwC97Z2OMboxqguWn?=
 =?iso-8859-1?Q?lCUMEGtAOt6gIIUy7Ro2AkB8vpUWIWVmX0xJpZQN3EGApSBbEG5paJcczL?=
 =?iso-8859-1?Q?ihK5L/Xs7LcZxKXvejRrYnUGuAuf1843Q5xeWxyLradZLJg22KlR1YtZt1?=
 =?iso-8859-1?Q?l0npev6m8vTeaErJs2zZ2gXOCB7P1D+4bG+u2bwXdLt3cRugjlJKZhAXdp?=
 =?iso-8859-1?Q?BfwQ79mTJIl5ISSQ7lpzZSoJ0iE8P8b5tT2vhKe9DFlMkLDiFRFDZoFL29?=
 =?iso-8859-1?Q?+HvRkB5v7doqrLT30bN9eX/Ojwa17cTJZvVN8lasZINWq6QMnwoM6Sh73f?=
 =?iso-8859-1?Q?AVXisd2CFOFHPr24HUdHK1t3DHgK8+vSdK0p+dnvL6wO8UCrxF1kcMcudb?=
 =?iso-8859-1?Q?14yrHfPZXUZ+9dHkP9LQlfmHzyYx44gLa8mMzGVrjJn4T97aTWTEQerY5B?=
 =?iso-8859-1?Q?oOjpjl1ULIcUtUa1l+g44doQXaI0sY7nkUUAZmrXgxUVOjZlE19x2usrO1?=
 =?iso-8859-1?Q?QcfJnsBgD2x4hs/GDavJu0S7qZrARtfokovbctCzt3Cb0uE2KJI+zt/cQC?=
 =?iso-8859-1?Q?TwPuZrIQq3/o3G8sQvZCninMPvQQZC/NDpLaalnH6Bw1lPqD/z+WH2IvJN?=
 =?iso-8859-1?Q?22vrhi3HepN0hssvH0FCT0Y38WhD5W6JfprOblopJdqhjHJvG9PjX1////?=
 =?iso-8859-1?Q?CqeNIDc6THidaZsfwbNq3pGXs4OkBKKly2l9KiO0uMDAgrH30FUMfLpqit?=
 =?iso-8859-1?Q?BnJrhugX07NwvHiunX8THhGH8NsohV85aL650wcenLSv3/GO+7xNEWmsTn?=
 =?iso-8859-1?Q?jaCqzGqlJOzP03P+Nnz5k6DXhg02rXQQcH0ae6Z2PRfR3nqiItaGoSFEy9?=
 =?iso-8859-1?Q?pQwKnqlry7MwDGI/ASmw1VnQ+PCCy9w3ZNgL6ij+R1sdXEJbHwxgH3zjVE?=
 =?iso-8859-1?Q?pCsZHuxfkw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1c2874-97f9-427d-b829-08da3e4c9941
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:46:33.7410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSQMemsWlA0623QtI5SLzt/XaeK7l0WnxMxGh0rG/jJg6fMJWRYIOBK3l7LK9Dr8kBv646AXZ5JmInGwVAmQow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
> Am 25.05.22 um 13:37 schrieb Lang Yu:
> > On 05/25/ , Christian König wrote:
> > > Am 25.05.22 um 11:25 schrieb Lang Yu:
> > > > On 05/25/ , Christian König wrote:
> > > > > Am 25.05.22 um 10:43 schrieb Lang Yu:
> > > > > > DOORBELL and MMIO BOs never move once created.
> > > > > > No need to validate them after that.
> > > > > Yeah, but you still need to make sure their page tables are up to date.
> > > > > 
> > > > > So this here might break horrible.
> > > > These BOs(and attachments) are validated when allocated and mapped.
> > > > Their page tables should be determined at this time.
> > > > 
> > > > The kfd_bo_list is used to restore BOs after evictions.
> > > > 
> > > > Do you mean their page tabes could be changed? Thanks.
> > > Yes, page tables can be destroyed under memory pressure as well.
> > Destroyed? You mean the contents of page table BOs are disappeared.
> 
> Currently we try to just free up the backing store of them, but the idea is
> to really get rid of the whole BO under memory pressure.
> 
> See page tables are managed in a hierarchy and their content can be fully
> restored from the metadata.
> 
> So except for the root PD all page tables in a VM can (in theory) be
> destroyed and re-created when they are not used.
> 
> > If so, could other BOs be destroyed under memory pressure? Thanks!
> 
> I don't think so, everything else is just referenced somewhere.

Thanks. I got it. Just curious how do we identify PT BOs when we want
to destroy them under memory pressure? And does this happen in eviction
process?

Regards,
Lang


> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lang
> > 
> > > Not sure how the KFD handles that, but in theory we should have every BO
> > > used by a process on the validation list. Even the ones pinned.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > 
> > > > > Christian.
> > > > > 
> > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > ---
> > > > > >     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
> > > > > >     1 file changed, 9 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > index 34ba9e776521..45de9cadd771 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
> > > > > >     	struct ttm_validate_buffer *entry = &mem->validate_list;
> > > > > >     	struct amdgpu_bo *bo = mem->bo;
> > > > > > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > > > > > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > > > > > +		return;
> > > > > > +
> > > > > >     	INIT_LIST_HEAD(&entry->head);
> > > > > >     	entry->num_shared = 1;
> > > > > >     	entry->bo = &bo->tbo;
> > > > > > @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
> > > > > >     {
> > > > > >     	struct ttm_validate_buffer *bo_list_entry;
> > > > > > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > > > > > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > > > > > +		return;
> > > > > > +
> > > > > >     	bo_list_entry = &mem->validate_list;
> > > > > >     	mutex_lock(&process_info->lock);
> > > > > >     	list_del(&bo_list_entry->head);
> > > > > > @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > >     	unsigned long bo_size = mem->bo->tbo.base.size;
> > > > > >     	struct kfd_mem_attachment *entry, *tmp;
> > > > > >     	struct bo_vm_reservation_context ctx;
> > > > > > -	struct ttm_validate_buffer *bo_list_entry;
> > > > > >     	unsigned int mapped_to_gpu_memory;
> > > > > >     	int ret;
> > > > > >     	bool is_imported = false;
> > > > > > @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > >     	}
> > > > > >     	/* Make sure restore workers don't access the BO any more */
> > > > > > -	bo_list_entry = &mem->validate_list;
> > > > > > -	mutex_lock(&process_info->lock);
> > > > > > -	list_del(&bo_list_entry->head);
> > > > > > -	mutex_unlock(&process_info->lock);
> > > > > > +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
> > > > > >     	/* No more MMU notifiers */
> > > > > >     	amdgpu_mn_unregister(mem->bo);
> 
