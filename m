Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40424C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 06:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECFA10FFF7;
	Fri, 15 Apr 2022 06:37:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEBB10FFF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 06:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMsi5bpH/nDzeN0CUGCm1uhLondMk5SVXEO0btgg7sQHJLXQlcCoPe+qThtSK0PYT7x42qZGzCtxi3e0bnacN0PgWtf1RhGoqfkmG6DOAwAFmLNKPx9FDOOhmf80t4BfF+43OBMH5Xeui1jkWO1++y8iz/ef9taxQJk5qZ8LQWZ/ipyDkTHL+LcQYMqz7ON+m2Sydj+wS+qncHoGRQCLrCpnumWDazndcjWUEcHpuqCvzZRPqM4CMWeJR+Ob0VnjmMcHueackaw3AhkVyfmqIRf+WVIETUzzAnSjYsIPabqANQTMQJccSVEFP5vqHc3hlJiwiYWVxHZ4vGIiJvdBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihEPl9qqSamAZl6jycnoc2Um/8eGY7P8/fCemFfiN3U=;
 b=h7AU43FZbwsuJl1+D/EqV2qVLTIDs42Jk1ZSLTF+QwVbAZG2Mm06rkPEmiFVXHylfZ6HUL2PfmRs22DgiQvlpa7yrj/8vwajt0u23AtG8n7Pkjr3xJzPXGWjPTl//36LAjKofzB9e9j6tzjlBjDirCTVGnoqaq+xvmazV4Own1+3wEDKaY32wj3ZubioQt/CF6mn+Y93OF6Cr+xEWJfho9lmywtgF7ZvMC3NnQL01HlKVInfj8PBkuC5MFUzYW/JDQNQzT1jkzc6qD7kGfGw+ZYufb+XwvlXkOetAOyAA6w0qHmb5sDsEU8hpc+qylo2oRD8YAJsZvdJBCwIBYpHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihEPl9qqSamAZl6jycnoc2Um/8eGY7P8/fCemFfiN3U=;
 b=MRs+boK1y9KVd9MAt69c9Yq1iIBRUrbZ1O8+bqFt9CxyJqgWqTUANwvwYT+YwVUzmW9+MomB/Irar8UN466VoEq+HyF5Ay8ZeiowB4yZVasfSl8JijhsvPSdYuQ3tNOPUemGEpt59Iy4Un4PTA6aviGS2BVLNHglT3y1rVnxZXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 06:37:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 06:37:31 +0000
Date: Fri, 15 Apr 2022 14:37:20 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Message-ID: <YlkSoHeX0ycfJ/aC@lang-desktop>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
 <e0a1119a-3cb4-4449-142d-a51baa8ad396@molgen.mpg.de>
 <Yljkf/yGk8YFEV9R@lang-desktop>
 <aac8e868-3a1d-7eca-8c85-65d8972add40@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aac8e868-3a1d-7eca-8c85-65d8972add40@molgen.mpg.de>
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8159d45e-2a72-43f0-761b-08da1eaa6aaa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB432788F2CCA198CA43391DEDFBEE9@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9LXNGhfVvgGDUNH4KxkqOI3vwhCVt4zRtz0V4wGJNb+MyjhuOm0YOsw8jrp8nITFJzDCvrRH3RWr//KOK15/ae+5iDvXhQvbGGjpxMOZeIlsENEZPLLo12uJuE/KE7hVeRxs5CmzCaI068+I9olksCxRJNMW148OoO3KtLHvctfh0Fzzo2cP69gOGfSxceM3nSty5S0ObApJfzzoQPtY1ALrf2O0KfxeSrqh5IUKKLtxKzhQXIfxlZINZrzIfnhNv0uahwLajX8KcjpCx2YEggGU+pitC6mRh+D8dRpu8xw+H2FEHn4kfeslBjLwcjXy8Qz56691p9B+CLbNKKLnhOrD38Lt0FPq0g/bPD3cvUFXWpbpAueoPpGwfSYDJsJJVLPlhORKSHoySFYO1V1qU5TvNkUGoWZyZEmEv3XLYzuohqk5LPUuokmUM/UvZxRMG8ywvo0lGWpeDPMNvHxIdkkJoJJibN2vdEg/OKifiaVtdxn+h4iQK+oFeunUJQhz9g8vjcRsnFG/Ewy5zDdGamokkQQ2FKN+K+pEEnWAspI9M1KQQc8r56wV5AH2N9Uk+wXPIMGtVLdu4s0o9v8FB4zncHr/57JRfdLzRRJMZSfI8Q1IXbk7eFc3PkajkCsYliBawxsbBc5xhq/Kj8taWARfuC0yH+JINHSYxnLICw0A6oLFe37+LSZR4rEpNVUi2cWhYRQdpoBv65dvIvYCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(6666004)(26005)(86362001)(6506007)(8936002)(508600001)(6512007)(9686003)(83380400001)(2906002)(5660300002)(186003)(6486002)(8676002)(33716001)(66946007)(66476007)(66556008)(54906003)(6916009)(316002)(38100700002)(4326008)(16393002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNCS0ZEVWw1Q3N6WTE4NGpvN2EwRW1lWlkzT011Qjlsbnl6UFY2Tnd5VHNW?=
 =?utf-8?B?YzdnY1hxS2FyS2dsOUwrTGtDYnVITVFGcW1NVUxsb0g2V2hYQ3FRaVg1Vm9v?=
 =?utf-8?B?TGRrdFhZR3pJbThSYXU4OVZ5NDhVM25EWTJmYldCY0hJNHdMKytsaVJtNG5H?=
 =?utf-8?B?OUIxMHpkcm0rYlhYUkJZVkU2VW1nTnVkOHVMem1JcGdXWFU1MnkrK095cmZn?=
 =?utf-8?B?Z0VzMVpOQ1Jqc0FsdW04M1ZzTENZcmhsOTQxY2Q1MGpUOGtPcTFBbnBsR3Bq?=
 =?utf-8?B?M3JnQ3hzRi9raTFoYUp5ZWMzMlM2dVc1ZHZCdzdKTEozVmRWYUhWell3eVY3?=
 =?utf-8?B?bHlKRzNJcnd6UlA5ZWVNS0I2b1BoNXp0T3dtS3hxa09GcTY1MGZqUk54aVl2?=
 =?utf-8?B?Tnpsc0NmRnZxeHRmYkZoa0FIR3JhQzQyVnFwY2hFYnVqY08zZjRUa3ZxTlBh?=
 =?utf-8?B?RGdiRHBOQlFlRkNkWDVEaTV1SGdFNXkraU1kZEhPTzVKUVBwL01sRjJTS1F4?=
 =?utf-8?B?U2ZNUjRsNVd0ek8rZ2ZSYVFPemJia3ptY29nNDc3RXpYcWRoZTRrTHRCZTRX?=
 =?utf-8?B?SVBwcElPaDRzUlpHRXZPWjZDTGlEWk85L25JclZ5T1VDaDMxSWgrUk1UUHBJ?=
 =?utf-8?B?QStxVGZKNFFySmFDam5xd3lhWlhIcmNJc2U4UENTNGFuTDFLRzdwd1VCZWYy?=
 =?utf-8?B?OFA0TmdxQktvNkJHQkJzMHZWNlZ5RWQzRDNENUtkS1JaSnczQStPMnZaQkxN?=
 =?utf-8?B?R2s4WnlySFM3Y3pEUnpKVUFkbGxWalcyTlc0WG5ZRjE0QW5tTGlueURvMXBI?=
 =?utf-8?B?WTNQK2NmWS96ZnFKUFdpVVVTTTdhUnRUdXNxaU8zd25FU3YwUlUxYWdEQlRU?=
 =?utf-8?B?WEVvSGtkOFdDT05yZTg2WldNT095VjVNQXR0VVRDK083R1cwdWxCUXJEYjVS?=
 =?utf-8?B?aVp1YnJGcHZmWk5ZTC96N0JQZGtXd0tvNEdMKzJKKzh2NUFYeDRuRUpNeU5s?=
 =?utf-8?B?eUo0NjFiQXoyYkduSVg3aEppZytHcVVQVFE2ck42OXNoUzhKb2JycEp0aklr?=
 =?utf-8?B?N01ESnJmK2FLL243dGdVM3hlSGE2Vml6VjhUeSt4VGdDaGNpUGgyRy9GOWFh?=
 =?utf-8?B?NVIvVTZqRHp2RE9yaHNKSFQzUWhBVWluQkkzOUpYM0JJRnlrODQ4Zm1XRXFz?=
 =?utf-8?B?c1ZYUll3VzEvbG9EcG5MRnlXYW5CK0U2Z0djSC8vWE1WKzJHdDJBNkxiTEl2?=
 =?utf-8?B?OElDWGwzS0xqMGR1T3J0eW5UQ21TT3BzR2xYNVM3L0sraUw5L1p6OGNtM2NE?=
 =?utf-8?B?MnloelF3dzJ5dnNicmdWbWVoclBubWVrbmtyYWpRUkNyT1hPM0hFN0RhUWZ5?=
 =?utf-8?B?aUlrbWJaODhYeW1SNlpVa2QxZmI0Zm9MR2V2UjhwRmlsTWZXb3VQY2Y2eUNu?=
 =?utf-8?B?STNkNFNaemUxQ2FXdSs4K0IzaGtDUXRIL0xjdGw1YUFUaVViWWxKUHU4OWs3?=
 =?utf-8?B?SVpBSmRYc1hhem1PT2VDeDBGTjV1MGFqQjVlUS8rMmZxR3dMQkVsWldMWllr?=
 =?utf-8?B?c3pKYUJnT1BVK05Ja0VsaXpWYkFKdjVVdlpydGZNK2JLdzA0Q0pKaWhqazdR?=
 =?utf-8?B?dVNOSzFtdi9FT1hUNlFFcHprUXZ2REpWOXhJOU0yQW8zL1J2eC9xSHltMkhU?=
 =?utf-8?B?cW5xdDN1UmNsYkNwSjlkQjAzbVZDTUU5eTl0RzB5aVpaYSt5UkJFdW9CTUcr?=
 =?utf-8?B?VU9iakVxd3VyZUI2RnJpRTZQcXRqU09xeWljRkJoYmd4SnMvYUZpSHZhUThR?=
 =?utf-8?B?R0NtSUNodkp5YTB6M1NrUzBydDJaaVpFbDdWVnJrQytXcmQvRktoRGhQM095?=
 =?utf-8?B?WlUwdWR0WFJBNE5kaUJVYml4Sy9OQUw3aEVxamV5Wmp2bHgzOEdWcUZjc1Vz?=
 =?utf-8?B?T3A0K1NQNmhsNFI3bGMxQU1DOE03dkFOTUNiOWxjN2hCNDIxYmxhNFRQcGc1?=
 =?utf-8?B?UUdaSTc5b0prd2xyMTU0dmt5MGtOeXZkV2VjV29wVUxPbkNMNFZnOC9hVlN1?=
 =?utf-8?B?N2NxQTFuVW51cDhGYW94d1dESnpTelhLOUg1RHV6Y3Qxdk9zWlhJbTlWTGht?=
 =?utf-8?B?VDdKT1psTjB5enltVUloeUpyZG9qVGp6ekw4dkIrRlpqTVhFVGk2Wnlscm0x?=
 =?utf-8?B?Z2tCM3dOclNodW5QVE1qMWliOSs5YVh6VEF4NDdPNiswRDI0SmltZmdRTXYr?=
 =?utf-8?B?dTVramJHejJpdGFuY3IzYTNsTzJsZitpbFc5cWtOSDFlZXhlUHAwRGVsaHZJ?=
 =?utf-8?B?RjdkVHJ4cnZTemtxZG1ETEJRd081VUtqdHNSSVdJKzRFYVJLc3ptZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8159d45e-2a72-43f0-761b-08da1eaa6aaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:37:31.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+nnn6CBrGHZqgwpHtMYzwGPtKyeMl+mIKxmAq3xJ2ys7pgtzbHXV9gf+ABN9XinTK9B3hcKI2PuPH6pQJl7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
 Alex Deucher <alexander.deucher@amd.com>,
 Felix =?iso-8859-1?Q?K=FChling?= <Felix.Kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/15/ , Paul Menzel wrote:
> Dear Lang,
> 
> 
> Am 15.04.22 um 05:20 schrieb Lang Yu:
> > On 04/14/ , Paul Menzel wrote:
> 
> > > Am 14.04.22 um 10:19 schrieb Lang Yu:
> > > > The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> > > > TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> > > > heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> > > > on some ASICs when running SVM applications.
> > > 
> > > Please list the ASICs, you know of having problems, and even add how to
> > > reproduce this.
> > 
> > Actually, this is ported from previous commits. You can find more details
> > from the commits I mentioned. At the moment the ASICs except Aldebaran
> > and Arcturus probably have the problem.
> 
> I think, it’s always good to make it as easy as possible for reviewers and,
> later, people reading a commit, and include the necessary information
> directly in the commit message. It’d be great if you amended the commit
> message.

Yes, I agree with you. Will amended the commit message.

> > And running a SVM application could reproduce the issue.
> 
> Thanks. How will it fail though?

Will describe more details in commit message.

> (Also, a small implementation note would be nice to have. Maybe: Move the
> helper function into the header `kfd_priv.h`, and use in
> `svm_range_unmap_from_gpus()`.)

Will separate this change into another patch suggested by Eric.

Thanks,
Lang

> Kind regards,
> 
> Paul
> 
> 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
> > > >    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
> > > >    drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
> > > >    3 files changed, 11 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > index 91f82a9ccdaf..459f59e3d0ed 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
> > > >    	return ret;
> > > >    }
> > > > -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > > > -{
> > > > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > > > -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > > > -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> > > > -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > > > -}
> > > > -
> > > >    static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> > > >    					struct kfd_process *p, void *data)
> > > >    {
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > index 8a43def1f638..aff6f598ff2c 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
> > > >    void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > > > +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > > > +{
> > > > +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > > > +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > > > +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> > > > +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > > > +}
> > > > +
> > > >    bool kfd_is_locked(void);
> > > >    /* Compute profile */
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > > > index 459fa07a3bcc..5afe216cf099 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > > > @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> > > >    			if (r)
> > > >    				break;
> > > >    		}
> > > > -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> > > > +
> > > > +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> > > > +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> > > >    	}
> > > >    	return r;
