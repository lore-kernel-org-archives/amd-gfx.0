Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29362EC875F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 02:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A574F10E086;
	Fri,  8 Sep 2023 02:27:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFE110E086
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 02:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qsz1kODOVdy4T7fpUNiET/4XHNktn8eiswkoAbSnzwIzH9C9fv5mE+1GFOVv8MXb9JN4FJ+GI+ibjDNCNhbqXb9+Gbu5yADQYZsEaZFfEb2NFoLjM25fZwc0fTySFh3jmrqff7hGzqFlWlUW5UqaX5q3JpBq/oFPnhQg7GGZnYERtiarZ4e9EdcB8MgFtTYMzEPgZTvK8YTZrL9mcMBt5ibEZwm99iMf+b0N0UaYDotYpfFJwNnCURmE6YFwribZ8GnrH0aWgniVxD7J52tklsHwOwR8yCUrNEFYPJXy0kTYmP8DZ4Jl+CRVwt0tTfUjiU4+WfTWHvPxbfkQW/DwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xvSqvTH6mhD4agZ50qaVYwGhMKaYwj6RuUIEy9Gd/U=;
 b=OXFFkp6OuFAldtCIJ/pGDy52ka8Vh2TADjrfYbRicZZuFq0ZgFzE68fEzRym624TJzasGnfxVhywhRTj9XiOx7sDhPciPaT/S0csXNS+ALdNs+2GYwjfiSYzw8oqcgauUX8Uq7gl6vEAi2DohNuXDu988WfFU93DM14MWtQA4XT61um4o7GgM39SDItRfPUyrv1rFsTyvZsp1cr4EP0UQ7ShBAQkXOaiBcKUOzW1mCDKCFOzFgbDOZ4pjrFWUwbvFb3MYNDfYPgoEcjZ9r8xIPbkRZfoSnKP1AyXpaUkgEoFcOqQB0GoZFZQG/g9jyXjHxvhhSoyg++tLu/Yr/hh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xvSqvTH6mhD4agZ50qaVYwGhMKaYwj6RuUIEy9Gd/U=;
 b=yWRXcYnDufiOzZKca+RKj/yRk7eiRNc8ou+GGHdA7GkOh+BXp+OObObGvHs3uUlTcw9cpDHBJfp8Oxuo1UEvFcuJmnx2W1qcKMTIuh3XL4cCz9F/xMlKhv4UsrlrHJbK9PRcaf9XZ8wJQnHesTLSLFz/MvtHCNRjz+MLeiNqWpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.36; Fri, 8 Sep 2023 02:27:32 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 02:27:32 +0000
Date: Fri, 8 Sep 2023 10:27:21 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: disable SVM for GC 10.1.3/4
Message-ID: <ZPqGiYAMc66wLr0o@lang-desktop>
References: <20230907120848.3169535-1-Lang.Yu@amd.com>
 <670c67e3-1ce4-e57d-3ff5-5b314cc61ab0@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <670c67e3-1ce4-e57d-3ff5-5b314cc61ab0@amd.com>
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: ea702aa3-731e-47da-f242-08dbb0132762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kexie873sUOJS3C4I2eTR5ZBV4LPRFXONyAyzPr4GIhqwbAyWYgq2ffp6MzfO8srkODjPpq1bH6Hoqj/5RMv10kAQAtiZ5KRViFRJ+6be4dq+P6HE47VLihzeo3QQjL/RSjbvk/70L0lVWUy1kw37yGL1bmAPGzikkk3r+ebAXj9/4XxpPUVsomFkXnEsfdty9PiVAnaes7BMIHkRULLhiXzQxB/VphkfFjprAQJv0XIjAg98HKyYF2wik/YH1vc80SWURIvlPgkEUzVIGIkiFuxexoYeCTW6h11MFYqS/LZwB4lyNOkFccL7ppvwaA5KdzeOhedtsdeDLUK+ARaYQbzWydzYn45Wh8YY4tez5JQiK/m4owyeP9Yef7kDWSxGj3ZWXAtUmQf3FVKcOPuMI8dKPn2AR4l8iYJEBvx0SuhI1hzwrV+/7tlkAXx9wRWzxb7CWiInFdCC+pBHGWogyDxFUD16QgEk9mMsxZnzrD/t92ABKDXrFD4nga8rY4Q3NCgt4uwPQFvdQdvwGa3VMShF8CKckLqAw2dUmrDhhByzozzt6zSmbX+h/JlzSus
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(8936002)(6512007)(478600001)(9686003)(26005)(38100700002)(33716001)(41300700001)(6506007)(53546011)(6486002)(66476007)(66556008)(316002)(6636002)(66946007)(83380400001)(6666004)(2906002)(5660300002)(6862004)(4326008)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kI1i8cKKlfCQJcN0eVYBiedHzwbedqFvBoitL7ZH8WkPYkPurUCufN+7Ep?=
 =?iso-8859-1?Q?i1V2DfnIHO/mCMMA7FVY+y/GAtWryGU5yPS8tZAvd4lj3CG9y9mHW/QAMF?=
 =?iso-8859-1?Q?iy/VNRKOkxq78eqpoDmq3j8HwVxwtsAsYigNCsu496NwNX43kPCAwUQh24?=
 =?iso-8859-1?Q?6YTwhDDYxwxSs6YkFVoU8x/3Gsl10usOS3Sj67+49Gu4yyhXMTIuDeVui+?=
 =?iso-8859-1?Q?trpGOBYr0JYKpjz1AP8SfBOCw8ZpG/YEAHyKiJP9eRAxa8/B6jRh5z8Q15?=
 =?iso-8859-1?Q?GudT3sGQfcaKrsP9D+fludHNB3qEtM8Ajv0aH6V1mBudr/uwW2dWk5uJLv?=
 =?iso-8859-1?Q?3i4IOMu+nk+a7RJeEv/1rf9j/7Gvmaen/sQJvrpfyng/a3G3hTAuZBCpB9?=
 =?iso-8859-1?Q?iXsiDBi9rEOY+Jm/IW6FMpbXYJ3MJxQbKKNn85lJZ83AVu9Cs1VChdWq5P?=
 =?iso-8859-1?Q?hhiXp4msrxjiRU9Yomimin1oTaUP36SgexvVMpnM50sKGEgP1Wshs887Gn?=
 =?iso-8859-1?Q?kJeMi3ZBXEZF8m163917rL6oC3n9rjoftNVjC2WmE2XlDqwUnBQ8CuJOug?=
 =?iso-8859-1?Q?ECyZrahEOjD3KYnPvo9W8vVnNC5YVHp8vEHXZZEMgeSkWCoVi3dE5nlFjw?=
 =?iso-8859-1?Q?he0pM1qPg/rqNzw7NRB0pBb0uIdOnCCLhYVtTQ3pXArorl4kqUPpZ1tFlo?=
 =?iso-8859-1?Q?wSsudGVnj1kLBfoC9gse2abEt1arHBH8dSXGfUJMHCRV6QC9ZXxe+xqopt?=
 =?iso-8859-1?Q?ifY7bFr2HyQonMuwb1dq+hyHyOzEtxsustJRPRK3z+Hvtey/9Vg0Wv/ypq?=
 =?iso-8859-1?Q?NklxpQ97ilPakdo0ns24Ce6+zcEXWcvm3SHi5x78esTRoCmmYb0FaQfqMS?=
 =?iso-8859-1?Q?K3oTS4k2WXrCLsjRV77ncpwRQF/x7zWhfPVMnj3QFlXQPe3HIsPFVvd/9G?=
 =?iso-8859-1?Q?JH8WIMCYhEXZN7ANKtJ432mm3C1FwAG23wfkmMPgf68LC8k/Qk6HxhmXtQ?=
 =?iso-8859-1?Q?X9D1es9xufI5E9cEC8zpbQt225iRQ9HE5peEW/7ogOSq7JI0+on8Q7/aa0?=
 =?iso-8859-1?Q?Gzk0Nn0JHf3O/DkhbVfl+1iRZk07dkYlSxjgtGSq2GG9xAsTW4DqEmx+zd?=
 =?iso-8859-1?Q?fe6KUO6/3j1FD89hKR0oqT58apqT5lAthaA/FLrwmxaggMYlshVpT5ccX/?=
 =?iso-8859-1?Q?oMT8MYheGEG0RHvk350RhiOumc4tRr0KhmrL1rVmItkyv8IurDNrkEdbCx?=
 =?iso-8859-1?Q?zErCMyXadjaIXg1xiAFWviJ1+JSFbsuJiaIVyOhmV7AdwGCxM9CSdcEmp1?=
 =?iso-8859-1?Q?oqR2BtEDltBu/hG+06JZnvIr/e7D0j3ZFdqVUsp4j5j9ybWQSvb9P3RT70?=
 =?iso-8859-1?Q?uKKV5gd7MlSdbntIIrnXBezToYg4RYIm+7/wWZ2Xf+RDEa569Xudgd/iIB?=
 =?iso-8859-1?Q?yzhcO29OVcsz0wLKO8YjvXsfbf+8F1+MLqCJSKh69wM5yzY5W6yIxlDIHu?=
 =?iso-8859-1?Q?dg0ZjTGeqAZJGCscRCpweHboEiRhL5sVcpxRHvzxydwUeLIx0VY7LaZi4M?=
 =?iso-8859-1?Q?xh6Tk+2JHbrtJt//nxfulqPnShUKuCX0feW2tYdkmP8B7m34JgBHJtvFE0?=
 =?iso-8859-1?Q?+Y2AItDCVpalXuzw6Z7CxCNqpzCoIzc8rg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea702aa3-731e-47da-f242-08dbb0132762
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 02:27:31.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUdm1MQE3Yk6bJBVZ684oEt+eZIK0zm8BX5z17SQaUaqi0iKGeVZaI86+oBdZQxRPDW/5jiZHiDWzqBWUSmilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Cc: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/07/ , Felix Kuehling wrote:
> We need heavy-weight flushes not just for SVM. If this is broken it will
> affect ROCm either way.

Currently, TLB_FLUSH_HEAVYWEIGHT is called in 2 places,

1, kfd_ioctl_unmap_memory_from_gpu()

Under following conditions. 

KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);

2, svm_range_unmap_from_gpus()

Unconditional.

That means TLB_FLUSH_HEAVYWEIGHT defect won't affect ROCm if 
we don't use SVM for ASICs except MI series.

Regards,
Lang

> Regards,
>   Felix
> 
> 
> On 2023-09-07 08:08, Lang Yu wrote:
> > GC 10.1.3/4 have problems with TLB_FLUSH_HEAVYWEIGHT
> > which is used by SVM in svm_range_unmap_from_gpus().
> > This causes problems on GC 10.1.3/4.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > index 7d82c7da223a..dd3db3d88d59 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > @@ -992,6 +992,22 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
> >   /* Each VRAM page uses sizeof(struct page) on system memory */
> >   #define SVM_HMM_PAGE_STRUCT_SIZE(size) ((size)/PAGE_SIZE * sizeof(struct page))
> > +static inline bool is_zone_device_needed(struct amdgpu_device *adev)
> > +{
> > +	/* Page migration works on gfx9 or newer */
> > +	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
> > +		return false;
> > +
> > +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3) ||
> > +	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
> > +		return false;
> > +
> > +	if (adev->gmc.is_app_apu)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >   int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
> >   {
> >   	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
> > @@ -1000,11 +1016,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
> >   	unsigned long size;
> >   	void *r;
> > -	/* Page migration works on gfx9 or newer */
> > -	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
> > -		return -EINVAL;
> > -
> > -	if (adev->gmc.is_app_apu)
> > +	if (!is_zone_device_needed(adev))
> >   		return 0;
> >   	pgmap = &kfddev->pgmap;
