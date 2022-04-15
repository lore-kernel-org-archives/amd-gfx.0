Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895CAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 02:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE6210E37D;
	Fri, 15 Apr 2022 02:47:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A5310E37D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 02:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5xj/vM5b5f8EERM8gEfbLjaAfCyfd1MkgIORtgMh0t8QrtvS+arn5dy4myjVfdgDfLiOje0JUZltBW+bEUJuTiKxzTqB3NydwBguRjKEL2js5xbhMLSG69BHawhrkFhzIxXpRBubox/necstNLKdlwPrsMqatsTsSQ1y61DoQftXUITZG5BzRtt423bF2H+2tUzE8akHslFhDcg/azb/CZrLEEmhg84pebfBjJIxttHA1otVpADW/xAyxO68wNAGXu7248CGobxtgBcjsd6P+MFG20dsJsqGeL/DnwIi7zg/g+FcB7UX7byWtq663g1NqY5m0DAQZmt3Z+H7ERhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDXlsGoGfYS06QlvoOpYZQ0pwb2CPAPmhMlFcp2PST8=;
 b=T+eG/WuG8+UDQJFGjMTtcCqtLJuRHImIG/bwC9IB2NhUXPv185o5E6rGchDOjFo60wgxSMLvdy7/olrlXN7diGCdFD1lTLUhWOdxQiXWvs4afByVdfr4aZPMs/u25R30EIKVOkXigyx/5fmORoClIvOaTkHJZXH2pQvoPG8LDdie0wJcFEFkswLBWOWbB8vsKZK9DwlN13jkG+jAJvVk2chuoP46Le1jUpRywSfnD+lakPRwJZoNXqhwrnj4HBjLCkcu2GVumzOekEqobzV8Vgf0Ylsm272srMlI0oYjE7S31YKwnzTNnNkm9HtJRehQ7FkHs1j22tVFhtL17sKwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDXlsGoGfYS06QlvoOpYZQ0pwb2CPAPmhMlFcp2PST8=;
 b=P1CckdBqVUoH41N9x8jS0v01S2PKziinRkdzj3uvaN+Gbjtywp7un2IKEFzGxf/oBZF6MmY4Q2FZb4mluAjXb1t6/cCuJpiZ3eY578gAB9hdYGJjbXCs/7GThNvjK/j1piWiyO0Ejx3Q5f7DPap9X6RDI3maKomG9/WX7QnZv80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4794.namprd12.prod.outlook.com (2603:10b6:5:163::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Fri, 15 Apr 2022 02:47:41 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 02:47:41 +0000
Date: Fri, 15 Apr 2022 10:47:32 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Message-ID: <YljcxNtP+zGB1QJD@lang-desktop>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
 <35cf31c5-3c2b-d232-7b22-fc9bdd31bc9b@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35cf31c5-3c2b-d232-7b22-fc9bdd31bc9b@amd.com>
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bd22b45-ff85-4fed-0baa-08da1e8a4f60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4794:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4794C7A8B4062649F62C167CFBEE9@DM6PR12MB4794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GF2EFidLlJ/YJWF3jJ3D+LRDT/rP0F4dDJE+vOGSmghI+VxD9eabfZH/w/mKJgL+EFRzl1YuxQs4ZPzisTmeSJhIY3j5TYqpFvNtoynPJuNytPZsvrAmt7dcmDMDJYiq6I0118CJj2Hg5bZY8swvBsGhQwl8K+C/NnEnPXx8Y0eBHOYbmZ6xU+7bWmzpEph608pHIYvvkJO4ziUXO9KFpi+Rye+3jq2k2hFXE31ISgCRK8UORfCeh/6KtuxLhkEjf/9MxlzEUQSmB2ukQEix0uHgG5uy/ati8+xMjCjWSc/4HHlZ2XVfD8GlyJz3cEpqQnc/nhbYkBG+admxrevaFhNtk5rEwxxjobyVecXDBsXOCXgjtPzBh82bViwzQ9EshWW/yYwBHeF0YpVhjCHlOlW0nq9As4SS0dHbtXtdmrbgkYRJTH8RQEbNpGwS97ZYHjeU0aXjh2xk1nbs6wO//E0XaUh3f1RsG3Kv7CHNJw4LOZeGpU1dOX5PW50Nt+nnhI4gGog6oZYXMBePUHkJ6ZucrCYePFlvtEyQ4WdW6VeMmC6DW+82rDuptdAKrLA360mjC2KF2RSbMPl4meyc3wxiJYrI4UOCwCUf77hPvYVy0A//3AboXPv0zTfNd/FyJFE99ZyHlx8dc8KhaGR8wc6x8JWI/zeZnyawOjZm1KNXiqcXYyZHKCM3DwHyw0G5DtkeOwGccg498glW/kDYuVZsRYW1EkXdVel4bu3vJDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(26005)(6512007)(2906002)(508600001)(86362001)(6666004)(186003)(6486002)(33716001)(4326008)(8676002)(6862004)(54906003)(66556008)(66946007)(66476007)(8936002)(83380400001)(316002)(6636002)(9686003)(5660300002)(6506007)(38100700002)(16393002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1Tk95ZFK5I3bWck7iipA0ZxvETpkIEwsqH/AwmwHmjiL71HS/sjMoiRa6t?=
 =?iso-8859-1?Q?eeMmPXaj9gSLSYQPtUFV3cotIGIHmrZGJ10LhF1rv+L3e6F1FD8+WcqXi0?=
 =?iso-8859-1?Q?LXlscrubwC6sZ2mnFOS6cMx7uUi3fCFez+QEAewEJ+BOGh16r1hHNDetBG?=
 =?iso-8859-1?Q?C99X/N8umrBCBgrCy5JA1wO7B6uywW6izKjLW+BjMfCLB7mZU1JZndU5Wl?=
 =?iso-8859-1?Q?MgFMtnfXgnSIaWFyH4wncvUq7uehNIQIgZuvl0oyICXH2pYgSNUIeCXRZ9?=
 =?iso-8859-1?Q?nUSJsr12p5ShFZQYq15182NgbMdddmha4Sa/iddWiP+O7KrWhT9MgQLSdI?=
 =?iso-8859-1?Q?iqH8O6o/dUcPuUBxIiIEhw+n0yuzSlw3TbUa74rRcdIlgLA9jwzapf4Pl/?=
 =?iso-8859-1?Q?80DZn4BaTUR8NrWOie4NBA0sPh69bTPbKxcCjjI2JDFf2Gml0AzgulS3Ig?=
 =?iso-8859-1?Q?mXA2QEbLonldTEAWTJUybb9bKZXLaLvYMFTio6xVb/f1UCqHPWCwbkHhN6?=
 =?iso-8859-1?Q?wKBgETJDzEUOxJhR5IrBaC5P8iDvXnJMmC75Xp+TM8NgTqnIfQNGXI7EEl?=
 =?iso-8859-1?Q?PEplBOuypjErRtZcY2Y+FPhWA81n+IJf2TLOrhmSwkmcnuahkdr/jn/9rQ?=
 =?iso-8859-1?Q?LoD9UKSBx7vuG3JHvs457ySVgMaNu84puOUmIcUjWT8RuBCB4Cszb3KyZG?=
 =?iso-8859-1?Q?TFn6tIkDmmmyKB+RAZji8Bv/LGUzHJMpSKvbdnjW0iWo8NFAycsdkWLjxe?=
 =?iso-8859-1?Q?SddG2yWQ8Yj2b+zPQ57e1sJXaOpl8kSgZzFf7gtl7XkEbm0inCvFkUy1ZK?=
 =?iso-8859-1?Q?afg29YWqNJoFLuX+rfL+3xevNbP3rRXHSjVCSCWF0WJfg5G/F/4BlzTFlG?=
 =?iso-8859-1?Q?D8b7l24bMVQVR4vkw7bxRnYF2FzktvaG+TvFtS6FSbHZLLLV+NletDKE2z?=
 =?iso-8859-1?Q?uOMqvk4orl4YWxtGFHhljEY/UWhpPkO1KHW2JPd6dhr+z+aJ6We910CfeT?=
 =?iso-8859-1?Q?CqQnkZF14ncPtayjymUq470tCEkUJLZxxm9XIWboyK8viFnjD1kSDsXJ36?=
 =?iso-8859-1?Q?rA+PjaSQyz2NJoBDgr4heJAdG0W0TCUMnjny5BwA7Qii1Xy8Mc7OPxsOBr?=
 =?iso-8859-1?Q?qNSWTKp6WzyVwbFabMqOizFWc0YhbF8ox11k44e8Otgo26EbaTKI/vzADn?=
 =?iso-8859-1?Q?3gGvOHYUIU5FbSg/Kni/4faOyZFEXZXtCmX6IWWVzIJyr2HyFGFlWfVuBA?=
 =?iso-8859-1?Q?xdTsjweoM2XFEBZkIjwzxzwv0a7bZS9zJWZfRK0VmbTtYN5pvhWxO/zmTn?=
 =?iso-8859-1?Q?3l/eAVRlXnw3svD8DUo78woSLXfqn0vB9k2PWX9L170pSSk0wP3A7ruDyX?=
 =?iso-8859-1?Q?ACZ4okU3jubGn80jRE2YWPMjjoVnrpJYV7QPxUzTLbNMXsbckA+KwxwJ+Z?=
 =?iso-8859-1?Q?WYjqLScsuWY240ANiwcJ71NMVdzZGn8O2orBmjeghXBF+weE6QDgQtotvn?=
 =?iso-8859-1?Q?jSNYqe74A/7MAZDoqLq8ESUn3ZSNvzPUDKXg95FwtWptxSRVr7DjOHzcwj?=
 =?iso-8859-1?Q?2OuslzPnw+O63JTr7r1Zo/QD2wKwtK3E4hKHpE9DyYlfB8wQVW7LtlsaNM?=
 =?iso-8859-1?Q?JAXAvCEnTkxvE3CKFkBgaYNuDV3Mjg9GMHpJu/4JHvdDtCy4fgZXqXyi5Z?=
 =?iso-8859-1?Q?uSKXiYHISbXsm/5HMrJRqbgJzFPHUG6hG3aXLEKvciUvERjThpYFYkEyWf?=
 =?iso-8859-1?Q?SkQx2507aC74JGdkno1k3NYAAqv7hAJeTadsJTHfCLZ6NTm7KBrqyRdndL?=
 =?iso-8859-1?Q?YiuRvCofbA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd22b45-ff85-4fed-0baa-08da1e8a4f60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 02:47:41.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM0EJWwa/lbvic6wwWGqolnZdiiwJ2OLDtKwlvelQtJ5eoeIBcrDuo1mk8ily1qNBaongKXWnVeosPBIXfDrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4794
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/14/ , Felix Kuehling wrote:
> 
> Am 2022-04-14 um 04:19 schrieb Lang Yu:
> > The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> > TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> > heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> > on some ASICs when running SVM applications.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
> >   3 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 91f82a9ccdaf..459f59e3d0ed 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
> >   	return ret;
> >   }
> > -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > -{
> > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> > -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > -}
> > -
> >   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> >   					struct kfd_process *p, void *data)
> >   {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 8a43def1f638..aff6f598ff2c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
> >   void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > +{
> > +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> > +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > +}
> > +
> >   bool kfd_is_locked(void);
> >   /* Compute profile */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index 459fa07a3bcc..5afe216cf099 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> >   			if (r)
> >   				break;
> >   		}
> > -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> > +
> > +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> > +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> 
> Then you probably need to add another flush_tlb call in
> svm_range_map_to_gpus.

There is a TLB_FLUSH_LEGACY call in svm_range_map_to_gpus same with
kfd_ioctl_map_memory_to_gpu. Do we still need to add another one?

Regards,
Lang

> Regards,
>   Felix
> 
> 
> >   	}
> >   	return r;
