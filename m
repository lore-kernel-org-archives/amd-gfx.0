Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30630C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE30E61105
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE30E61105
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF7C6E434;
	Tue,  9 Nov 2021 06:44:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218B66E434
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 06:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LacFv0dIyMoq5j8SrjjshVB+lApz0pFsVDF4S9vCl6j+kd3puKVp8q37/D+KJnxzxtTbEzwmtu3oSKiXAmLyDcpRJHTW5f4nR3gcp+hSUlDuwZ9zWJhNk61Tke44uP7YpW8mMGG7BN6kE4qNnjgNlQ/oLVrZNT+K21h60PM8YF+G5Wcan6ZvI9sOxyuocYOVBfyEyYAExj/srC/Ilf+hu40Vyd7Y/8iuOPAt8UgIG/Ra2JdCGl2O92uENUQZCKOM9zXiK6rCNVsaZ8dk2OJO18RO9fHYHgvwb2Fp1+6QVAJA8pWZasJg9ep4Uz719jCj49L7tp3yHiZ9uS9g8f9uVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXy5wG96NZQ8r8vYcUg0gBV1aiz6kHBTIKzF84CTAgw=;
 b=cjB4JdhLdtNQzfNhfzEqGrakHnpV/YKecyCBZAecMAhVmqceT8V8nQxWSIfjHqvTXih+aUeZg2z+apZG+bgWX6YiZb1J+pr3L3Zuy8k/z+Kc/GB7PQ1cszmlz+TR4DlFYMVJkQko6niqFMuV4ZY8rCpNmeVU/bRD5/vDpPwBPwUxHbEhQwFCqF1QdkqqYNig1Q3ac7k2RbfviBPJmCMUTn/6uLRE8UkCgB5YqdP9J92GN+mohnWoGpGg2znm4y7QSkerwnOVf6Jq+OKuMWPM0kniqvea6UGUgxV2dWikKo+B5POeHBIWx5/6NhPqdK/CYOw1UBcQFle6RwW1mHMi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXy5wG96NZQ8r8vYcUg0gBV1aiz6kHBTIKzF84CTAgw=;
 b=NA+WS4SCLFLrgGutg5/qGNSRFHj8cTTpYOEcG9PY+GNCvb8UmaAofJMsQdIAMdXipCqQzJtr0OPAShPx7YEkAp85zrmxcNN/CNmCnOGpTf5GDf7xQG1/4YUx7Ii6KfLBzAmBWp2MSOevLCDlYg9QZ/0cg1EqRjR0t8l0orWufQo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Tue, 9 Nov 2021 06:44:30 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:44:30 +0000
Date: Tue, 9 Nov 2021 14:44:16 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Message-ID: <YYoYwLJbI/M7AKcV@lang-desktop>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
 <YYoGmHxlugJagJ70@lang-desktop>
 <SA0PR12MB43995DF3EBD469BE416B1DF4E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR12MB43995DF3EBD469BE416B1DF4E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by
 HK0PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Tue, 9 Nov 2021 06:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a498fb-f79c-4908-1354-08d9a34c61bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488DB81C2D6964F60D1005EFB929@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Z79lhMaTPPApAW0BjidpZ8RHIekVDDNH6s5unl5xL+gj0X6z1coEeyr4GEnZTdMBzbTZbkfDFHmK7a5kOYnqNC7/TCdPlbl4C5GjuNHBsPG9+wAAAEtpXgyYiSPFOg2DBKH+Vtxj778Bj9KsmSo0D5jielJSLnb0qVq7h+vmfBkYHEKHAt5nVfa0sZZsZ5BtENo4pnu1l4NAnlSITNDKaYuT5KCc5/oAVmCqiX0FjZRQDuIuEYpM/FMOho5onpcINf/cSDRSqFkxNZUpd+0XNh8nwx3WSeXma0YIe16ITZrwx2hlTcM5vJO0xcUI8HCTzYd9cwcNp8FhxefZfSnmV52RKU//5+Q014Fll3ncNAHKfmq1Lds7K9A2hL0lWxi8XJWzPcbIGuxNCqhdDY2QR8rQoYvnvWey1AAe8leCRxe/TDmIhhbMcbojWdr9v7Lm9SGT5kO0J8mhnY59A08xyczpQvUib+HYQrZBE3E/HJ8yQkio0GRAPAN/l0ju6a2U4ONX+RciztF8fqO77+hIjdWAfbd0tPX+QiYJ/lxVqqSRggfj7+Rq/e5hAd5sA2e5RongxWyAIbzsunb26mSPnkEkS6ZPpVJQKJySYMWPT3FBrCjGEm1DwFBLo5XM9n+LXk+9urL3aGkrhqK5Dy5ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(8676002)(66946007)(6666004)(6862004)(66556008)(956004)(4326008)(508600001)(9686003)(86362001)(8936002)(5660300002)(66476007)(38100700002)(316002)(55016002)(53546011)(6636002)(6496006)(33716001)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e7SwV8MHn45O5JQDkpjfIVnNJk071j9lX5FzpMO4JsPD6r55i2y3YvFudtEY?=
 =?us-ascii?Q?zo5WwgmzbcoRGHTCKP0RhZq3lLrUXZKFCQ8vqh1NjO8tRvsOf03dQZdUAon3?=
 =?us-ascii?Q?ouwM/+0Y5nHiqJTxnA/WFHcjUx1FJPbvEQaA+6W7SWIj/PegzfX+y8R26bdm?=
 =?us-ascii?Q?jx2/YIkAfSh4mXgSaJBODI3CtJLOh/cCs3evxu8W5kLfBvoHgG/m5siHTG4Y?=
 =?us-ascii?Q?2B158N8UyPD8r/E5JOAMa1mU5fnR1Ada34EVjm6KkdXdwPX3yyR4FkTIIftN?=
 =?us-ascii?Q?9qHk8pcj7UyL2mP1e68WbaVGZTsUKh16NHRuvL6/I9BiFL8pcdWIMZk8qEu9?=
 =?us-ascii?Q?5oOjtCxXlAGogpeoIi1ihmzmAJ2jSS4q5JcoCWz8R7c3Bt4KAS475DBFj4kz?=
 =?us-ascii?Q?AXrD6jM3R9wkag2D6MP3GFWjVD0Rxp1BYVXMISlUBzNkzcj/TBFbqkq8yY1N?=
 =?us-ascii?Q?wl3Df3i/6G7WUOiVvw+5Ly+Wb4qrpdSf0gTq5ltVJiwAwZ7Gmxs0HMoYkwau?=
 =?us-ascii?Q?bbHf3yDSIyMtkCDOncyggZ3C7mmDsEZpSOq6VGgcQLSlyPFYpZ6R8IGyWQHc?=
 =?us-ascii?Q?CJC1JhBiK9zvTi/yIjkMzME3jiBqI3xAABfxaLufcZwGMIBJB2jM2sb6Ss8B?=
 =?us-ascii?Q?qdSmBekfOtxn++d7TXUMravfsXWCERG3OVejJ2+qMXKlZ/u0ECEfblJyb4GY?=
 =?us-ascii?Q?aFGCGlURP+VcCMBDKleP6T1pbmP93sF37/8CH9E5EEkLxO9JbBZ6mSwEe+bt?=
 =?us-ascii?Q?Dlp0Y4IIdnFgiBKbmT9cy7VTiNPMHljV8vgNPVjZzaH0f9JmNLZGz3WNc6zX?=
 =?us-ascii?Q?fwhcbDFbNLuAkG9ThyJ9C9vel/apJKH/DPzk0lA0L+CjzivCM50KxmK1ch/b?=
 =?us-ascii?Q?NAERzwZhfgYpqYseZkR+qNVk7AvQ7T+IV0WwSQ13F9dGVg0iw0tbGMUhGt2T?=
 =?us-ascii?Q?0AOinPWmys297h6MPznqz81is/cWNYgycZvqbEs8n+bCBJ+5jV73mdple+mL?=
 =?us-ascii?Q?pwxP3h3xIe26/Sg60j3ijnWyYCTyVu+n/eYkCT/Ow64RH35MxbpaMM2ovn69?=
 =?us-ascii?Q?M0/84p1RX6X6Ph5GhZ7rx4Y48pauN2YPmJgrdzqxLP3lA0Bhpvvkd97N9vPb?=
 =?us-ascii?Q?0871oMA8CIOoGLkhmV/nXVvpmqX3+/jellU6HNjEoTsT3BWJE4eP9aS4ZHFM?=
 =?us-ascii?Q?FYoUdc3hRtOt2Q2oo1hYTWgni+mt+hsxLXJtaQoDgb6Z6xx68wkaqwCco+je?=
 =?us-ascii?Q?g56f1rU7KiikQ833V7kDpV6qvuxJy17vlBIwPkut1fR8FIWuAOMX0zfEktAG?=
 =?us-ascii?Q?RRSmvmMOkLNiwZPo5gNwDfLHtpw8R49b4LfRdIs68Ae8AyWIQgHDT6z8H4+I?=
 =?us-ascii?Q?KEqg/Y7ZZ+vWgbqDpA0kdxcEnjAOKbX/GzCcuF5NaIC/Mhne1VFLynC+po8+?=
 =?us-ascii?Q?2spFOcSaXGagxaEoD/4VWipQWxMJ5WatToQaTeIsrmUGSjGGMZfMMVyJGcOB?=
 =?us-ascii?Q?6P/9nmc7uhX/CqM8PAvJyiBKsZy5ubrsd7eeSNiznnOjbBRcRWmuWQRzxZgT?=
 =?us-ascii?Q?u296oV0lTwKjqQvoaIFL5R0vdF/qa2LdlA4oDE9R1JQv4u/if/ON0yQfu5Im?=
 =?us-ascii?Q?Xif6Cj/j6XgURzwqk6tq+Js=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a498fb-f79c-4908-1354-08d9a34c61bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 06:44:30.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI6UC/IQsHQFvDiuaBh4BHjzasjNZV5qydwwB4MIvO2pimV4rZXbb5+3EqQkXYcfqH04VHbgvpi4KpCnbP5HaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 09, 2021 at 02:12:00PM +0800, Errabolu, Ramesh wrote:
> [AMD Official Use Only]
> 
> Responses in line
> 
> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com> 
> Sent: Monday, November 8, 2021 11:27 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
> 
> On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:
> > MMIO/DOORBELL BOs encode control data and should be pinned in GTT 
> > domain before enabling PCIe connected peer devices in accessing it
> > 
> > Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55 
> > +++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 4c1d6536a7a5..d9a1cfd7876f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> >  				      uint64_t va, void *drm_priv,
> >  				      struct kgd_mem **mem, uint64_t *size,
> >  				      uint64_t *mmap_offset);
> > +
> > +/**
> > + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> > + * @bo: Handle of buffer object being pinned
> > + * @domain: Domain into which BO should be pinned
> > + *
> > + *   - USERPTR BOs are UNPINNABLE and will return error
> > + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> > + *     PIN count incremented. It is valid to PIN a BO multiple times
> > + *
> > + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> > + * Will return -EINVAL if input BO parameter is a USERPTR type.
> > + */
> > +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> > +
> > +/**
> > + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following 
> > +criteria
> > + * @bo: Handle of buffer object being unpinned
> > + *
> > + *   - Is a illegal request for USERPTR BOs and is ignored
> > + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> > + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> > + */
> > +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
> > +
> >  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
> >  				struct tile_config *config);
> >  void amdgpu_amdkfd_ras_poison_consumption_handler(struct 
> > amdgpu_device *adev); diff --git 
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 4fa814358552..f4ffc41873dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
> >  	return ret;
> >  }
> >  
> > +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain) {
> > +	int ret = 0;
> > +
> > +	ret = amdgpu_bo_reserve(bo, false);
> > +	if (unlikely(ret))
> > +		return ret;
> > +
> > +	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> > +	if (ret)
> > +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> > +
> > +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> > +	amdgpu_bo_unreserve(bo);
> > +
> > +	return ret;
> > +}
> > +
> > +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo) {
> > +	int ret = 0;
> > +
> > +	ret = amdgpu_bo_reserve(bo, false);
> > +	if (unlikely(ret))
> > +		return;
> > +
> > +	amdgpu_bo_unpin(bo);
> > +	amdgpu_bo_unreserve(bo);
> > +}
> > +
> >  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> >  					   struct file *filp, u32 pasid,
> >  					   void **process_info,
> > @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >  	if (offset)
> >  		*offset = amdgpu_bo_mmap_offset(bo);
> >  
> > +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> > +		ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
> > +		if (ret) {
> > +			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
> > +			goto err_node_allow;
> > +		}
> 
> amdgpu_amdkfd_gpuvm_pin_bo() will do ttm_bo_validate(),
> amdgpu_amdkfd_bo_validate() seems redundant here.
> 
> Ramesh: In my experiments I recall seeing an issue if BO was not validated in GTT domain prior to pinning. If my memory serves me correctly, the call to PIN will fail

From amdgpu_bo_pin_restricted() we can see, pin operation will

If not pinned, 
1, validate the BO with requested domain
2, increase pin count and update stats

If already pinned,
1, increase pin count

So seems not necessarily to validate it twice.

Regards,
Lang
 
> > +
> > +		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> > +		if (ret) {
> > +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> > +			goto err_node_allow;
> > +		}
> > +		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
> > +		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> > +	}
> > +
> >  	return 0;
> >  
> >  allocate_init_user_pages_failed:
> > @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >  	bool is_imported = false;
> >  
> >  	mutex_lock(&mem->lock);
> > +
> > +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> > +	if (mem->alloc_flags &
> > +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> > +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> > +	}
> > +
> >  	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
> >  	is_imported = mem->is_imported;
> >  	mutex_unlock(&mem->lock);
> > --
> > 2.31.1
> > 
