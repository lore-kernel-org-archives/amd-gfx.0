Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 15:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CA4610FC
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1CA4610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1F6EA00;
	Mon,  4 Oct 2021 15:00:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0A76EA00
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 15:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo0P8/uixDBiBcHfiuCUGgvv8RJJFXMC57mcubPG5Zbg09GxSvNu0pEZGo9Naj7qCrGgI+BRejiv9PUCQ1ciM0Z+PMLSCtWL79LY1q8AJLmOl1hWc7V6aYhYsy2P+yOQJg1V3evHQnHfDLCJRv3/V59ZFSR8pl0VmwW0wAAHx/kvdZ/M1BAl512c9UvhkqsMKJcEpGonodTlYG+udlr2fYHkiIEyvK52xPprfWd2UDVHWfHFs37M4VXtNa0d00z2L1wEYTeg+MefM5TKfPRiNwgWlx/LxSKGkmx6RXKgwE+QLnCuGI6rW46d+Bhytf/bA0FLblIHiXF5xwJKrVk57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwwfsvQ5Gs3rKKc+Ekv1w1MH2nENcqNIZVqmap5vZFI=;
 b=Iqrf0ZT6zFVvzQh3pxJDdylvVmkpJ+WmSe04qO5vA/BsaPWwXQUIvjFLWjEuwMvyu9dUbo9v6jmWWiKVP+cxo8zHO6Zsg9qL2znomgynw0ZXuRfSEVfSYJJMFx85IhiNW2hUQNfG68d+pFQrX2hjwgtiYjC9wTeyJ0Do8AblFk7AXCO1JPJFSH+ArtKNTKGyHWEXv5fhKhhi9pgZrGkV9LTuvZHGB0ixGWa8ejnK/FBNfGZ8P+TakHVn+QrN9sQlq1J9U3hlAPPiruTxW56bwlOi0JQtCMI2SYQFMtR5t3fUqysgG+1hqY/kxJul/xO0helHJqkqDSvZR7X1e6gnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwwfsvQ5Gs3rKKc+Ekv1w1MH2nENcqNIZVqmap5vZFI=;
 b=k23miP/I3q5E86hlUtocTc5qjP4x/Vxu52vtNSdt+IIpuT/1czwTvWpL1+DHJgkfEXH6zPOS7ZxiVXBkzH7Cw0wa9/EdCQUdRd9ovFTnzeFnjHeFFHaMO9M8PKedYYxNLFJ92z0mdJbLSIlsNjltlqx66qitARHXCoShziq4zUU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Mon, 4 Oct
 2021 15:00:06 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 15:00:06 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
 <20210928082819.205231-2-yifan1.zhang@amd.com>
 <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
 <DM5PR12MB18849F60DEE73D7FB8E20017E4A99@DM5PR12MB1884.namprd12.prod.outlook.com>
 <BN6PR12MB11875C3AC679F399E01C5D12C1AE9@BN6PR12MB1187.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <58199fef-3e27-4c18-07cc-a8d4fe8d0b29@amd.com>
Date: Mon, 4 Oct 2021 11:00:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <BN6PR12MB11875C3AC679F399E01C5D12C1AE9@BN6PR12MB1187.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13 via Frontend Transport; Mon, 4 Oct 2021 15:00:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d186fa-05d2-40d7-ae2d-08d98747a6f9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB124274731033FD07532E767192AE9@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddS8ZaT0aolg41702kksGtbocXPMxSK4xO8g6v+VsaMfJlEkMKDJhNEL82J8GeA4SdWxlWQDThI4uxP8QXXM+pv8DaEjHD8AaaTRXNWWCYra4ZWsYaI+NC72ilOesLE1/t3jx6s93lFptclTdBbj/UmkXR5QkAIChzY6UFQNKFY/H7OEXxav/02lAtxt1w84rsYREirK8rWLvimFe8mtgnu3ur/zl0cpk5f5lPZwp00b8R+51IKSk3Q1LjltkSduEWLpNS5xo76/3v0hvmkedperNesalG4XVc4tNQtKJjWlyy9ZXyuPzTjvAB9Z6vPOzpUwUOZ3w8Dy8sqWNKRlx87bpE97PsYQCHI4HCIndut+g0aYj0/GrbmrCiAj4fNVErGh7hRHoh0Uv25BEp0KvtPLUGi5OWAzVdnSAUDaSxWKhSfVuVBJ9HUinZ2R0gPg2/OaD1n8CA44IvFcUAWC6KaPlHtW+LloG1Qx3vArAdGyjRxJzILwFfrzyoOcf7GUtSlQsgnkKXn5lCsGGkOb37XUW7/zYjETp25eEyVe/DepGH9nL/b9F0Yg052ryfcq0K5NWQfg2YZOgvs6WvBsn8yv+TnXqgf9mD/hXZiSjeDDcKEFpsshN6uw8s878onpIBpqesDe1cWNCIhpv7qSuMumsuDQ8e9o6YPQD6jdi9+hQ/vWQD43hHdu3YzPZUKpqZOs69Psc63qRyuUTXUsIAvA3EaiKBR36BJnev8+3xpbjKGZLRV5uSzFGNRDT2j9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8936002)(38100700002)(66476007)(66556008)(5660300002)(110136005)(36756003)(8676002)(16576012)(66946007)(6486002)(44832011)(83380400001)(31686004)(186003)(956004)(2616005)(31696002)(2906002)(86362001)(26005)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktBWE1wZ3AyOERjZ1ZFWXRRb3hYRmlUQXkxK3c1RnZHalZsSmFvWEN0Q01x?=
 =?utf-8?B?WVZnR0l4VjZRb0tDUTd3dW0vZ2VHcjI5OFVtTFQ3Y2pBTkJ2WmNYK1IwQ1hH?=
 =?utf-8?B?NFgzY1B6aStpRm1oSkJvWWVMZ2xhZVBuUHpBbHNhWjU5V1FoVmNrNitFRGNq?=
 =?utf-8?B?bXN5Ty94dWdjYTNXZUxIMGgyM0xyNkpXRmRKZEhVLytZYW9vMzk4YWo1Uk1q?=
 =?utf-8?B?bVRESk9ITzhlR1FXckhrVVpSS0N0SXJxM3dXR0xqc0ZoK3NyU25UWmk3QmN5?=
 =?utf-8?B?c1hra2V1aXNqdndFaTI4TTdwRURYSXBWNFpwVUdROUVqTEZ2cmVtRXhvSllU?=
 =?utf-8?B?QVdESWZ5WVE1aW1mazZnWkJOcUFwS1E4UTNSeU5CVkZTbENDald1ejJjY0Ns?=
 =?utf-8?B?WEg1SWhWQkwzbktjYXlQQTRmNThTUHNGYmF0ZklhZy9jelVqVEhsVkF0WWYr?=
 =?utf-8?B?STR6eGlrVlpZd0taRE52aHg1OERYVnVyYmcrRTZJS3lVNSswRmFEZjYwMFZz?=
 =?utf-8?B?OHB1czhRWjdBYklYQzlFSWxCcUllYm9ZdFRHN3N1VzVHMm9RdFRiVlFkRUZu?=
 =?utf-8?B?MStwZ1V0VG9oZ0xrWE4vNitaYWlvYU12NGU3d2NldWw1VE5uLzZORWRaRjdv?=
 =?utf-8?B?RS95YTNYai9wZjlBbHlkOVN3dHFuV0ZsNkRpMERiZ0xzZGxkSWNPVVZ0aFpN?=
 =?utf-8?B?Y1Z4OWNNYXZ4STFqeTNubVY1b0dOaFhRZlZEOTJVV3ppaXROR2lmUEx5Tm53?=
 =?utf-8?B?bXFVczMvN0JGUTYrMDNTZEIzZFU1Vy80RUR0U0JMT0ViR3FuN1pzcTFFNHFn?=
 =?utf-8?B?SGhmMHRUK3preW9iQ0dqR2l2RHNVOVpnc2FWZmRPVkcrVHZUbS9NYlFGaXhr?=
 =?utf-8?B?MWJCZGNSdHp0L2VXSHJ6QWR5dlBBZ0xPckRBZ08yZXoyRWRlVEdINXl0QTdN?=
 =?utf-8?B?NENwQU0yUjd6Y09zZkNkUXFlSjdVaFNBN09SNXB3d3ltMFJKT3dDTW82ZXZz?=
 =?utf-8?B?cXBGNHRtZTIwWTBSZmoyUFFhb1VRNElIVUo3OGtyMEV3bUNvMkoxcTJ1RXNK?=
 =?utf-8?B?eUcyV0RTZVlvUnFmSDRxZWF4YmNHS2NtWjBndk9NdWtka3dTZlVKTXQ0VU1J?=
 =?utf-8?B?K0pScDluQ2k2NUYvMXZYYmlsQlJ1MnRiRXVoWFVxZS9yN0hhOHlkMVdYLytH?=
 =?utf-8?B?MmxHdEVJbU0yZkQ3Y3krL09IVTI2dGJudUppK1NVYUpVcnJSbFVNQmcwNlRJ?=
 =?utf-8?B?YVNnVlh1R1lSVlhqNkg5Z2RJdDBsQWRBcjYyNWx6dTFGVk8rbU5zbi9VQnU5?=
 =?utf-8?B?aGpxbHZ4Q3R6YW5UTG53K0FOeTBJdThUYkdOR3pHc25ibkpFU1hIbjQwUitX?=
 =?utf-8?B?V2k5dFRkazlRZUVNV29YcC93Z2cwa2lsYlhQKzN3MG1YVEpmSzBHUkM2QzBi?=
 =?utf-8?B?VTAwNi9SM3RuNkhycStWeVZuZEcxdG9TZHlzTUo1dG1sWExzS0xxbDloTWt4?=
 =?utf-8?B?cm9kaXNqeDYrRFFRaUQzV1NhQ2gxTVhNdjhLVytIT3BuNWNMWkNmZEowV1kr?=
 =?utf-8?B?a1JyVm11VDM4MHNkVjJWVUlUOG9sam93aFJqKzYzR0Z2YkQ1M2VoSXQ0WkZ1?=
 =?utf-8?B?aDh6UWEvWUM1U09VbTNlNGx1ek4rQVdRYi9hdHdrbzFKRnBTT1YvblczNTFn?=
 =?utf-8?B?MFRSVFJVTXhaczl0QktaOHFvNk9mSkJ1STVPSm4xRHpTc1oybDdUSjhwWUhX?=
 =?utf-8?Q?IR6vKBaHrqO13udNDYyJgY/iEpy+puZ9UcoGvC3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d186fa-05d2-40d7-ae2d-08d98747a6f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 15:00:06.4444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cblsi+zj04Oyg6v04yXUthkkY8vGDNnm9xxjk/Do/vgfNBaRNgWMWgWAGEKhzwblQtjj1qjCWUgWc0PSS00GWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'm trying to understand what the end result is after James' and your
patches. If I'm reading it correctly, we now initialize IOMMUv2 after
kfd_device_init during initialization, but before kfd_device_init during
resume from S3. Is  that the correct understanding?

My concern is, that we may run into related problems again if the root
cause and the mechanism of the fix are poorly understood. Do you have an
explanation why this different sequence is needed during init and resume?

That said, given that your patches are tested and reviewed by James, you
can add my Acked-by to both patches. The series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
  Felix


Am 2021-10-04 um 5:42 a.m. schrieb Zhang, Yifan:
>
> [AMD Official Use Only]
>
>  
>
> Hi Felix,
>
>  
>
> After sync w/ James, we agree that this patch series could fix both
> our problems, and he verified this patch series will not cause
> regression of his previous issue. Do you have more comments regarding
> this patch series ? Thanks.
>
>  
>
> BRs,
>
> Yifan
>
>  
>
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Wednesday, September 29, 2021 9:19 PM
> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
>
>  
>
> [AMD Official Use Only]
>
>  
>
> H Felix,
>
>  
>
> Since the previous patch can help on PCO suspend/resume hung issue.
> Let me work with YiFan to see if
>
> there is proper way to cover both cases.
>
>  
>
> Thanks & Best Regards!
>
>  
>
> James Zhu
>
> ------------------------------------------------------------------------
>
> *From:*Kuehling, Felix <Felix.Kuehling@amd.com
> <mailto:Felix.Kuehling@amd.com>>
> *Sent:* Tuesday, September 28, 2021 11:41 AM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>; Zhu, James <James.Zhu@amd.com
> <mailto:James.Zhu@amd.com>>
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device
> init
>
>  
>
> [+James]
>
> This basically undoes James's change "drm/amdgpu: move iommu_resume
> before ip init/resume". I assume James made his change for a reason. Can
> you please discuss the issue with him and determine a solution that
> solves both your problem and his?
>
> If James' patch series was a mistake, I'd prefer to revert his patches,
> because his patches complicated the initialization sequence and exposed
> the iommu init sequence in amdgpu.
>
> Thanks,
>   Felix
>
>
> Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:
> > This patch is to fix clinfo failure in Raven/Picasso:
> >
> > Number of platforms: 1
> >   Platform Profile: FULL_PROFILE
> >   Platform Version: OpenCL 2.2 AMD-APP (3364.0)
> >   Platform Name: AMD Accelerated Parallel Processing
> >   Platform Vendor: Advanced Micro Devices, Inc.
> >   Platform Extensions: cl_khr_icd cl_amd_event_callback
> >
> >   Platform Name: AMD Accelerated Parallel Processing Number of
> devices: 0
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
> <mailto:yifan1.zhang@amd.com>>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 4c8f2f4647c0..89ed9b091386 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >        if (r)
> >                goto init_failed;
> > 
> > -     r = amdgpu_amdkfd_resume_iommu(adev);
> > -     if (r)
> > -             goto init_failed;
> > -
> >        r = amdgpu_device_ip_hw_init_phase1(adev);
> >        if (r)
> >                goto init_failed;
> > @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >        if (!adev->gmc.xgmi.pending_reset)
> >                amdgpu_amdkfd_device_init(adev);
> > 
> > +     r = amdgpu_amdkfd_resume_iommu(adev);
> > +     if (r)
> > +             goto init_failed;
> > +
> >        amdgpu_fru_get_product_info(adev);
> > 
> >  init_failed:
>
