Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E95C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 18:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E8A2075A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wGE6Y/pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8A2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0736E0F8;
	Wed, 22 Apr 2020 18:37:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B906E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 18:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SISw/mW67UpyEcoHq29tkXvY7mcMjVgLoaMtZpc+lcpaS0DhFIECewcypRgQxxrqcNViw10sPcd3bCuaEjvxvvHyYxItGmlC1hraJ0+DDkjPMRBuXqRpn5bpfNs4n7drwAejwDmVXTGtJN5hFa5qwIG7tqu/G01SCOLnHeylqAAekPkN3F8u3MDH4cs9dBdKYkk2tn6HowartPWjuexIFVrIEMv2mFhNehTwtvOHQdpLV6D2bvG4fkMB5JCa4imb5rLdiE9Wmkp6zn/VmqB114mFaAwGf7Jv6SnM8oJNOTpihQWAN0yV2RiNNkMW68Lc/OOwQmJLbKe3LH6pPnx0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a2t+dj77vErXanjVHsxukcvqPMMEDKgxdliECMfiRg=;
 b=QmJ74nXCoWPa5p/MGq53VuQpbPC80AHTYCtik4I81ITri9is7pCpfkhPF8HdQ7rI6C4SMK/GNrciqfZdBDR5RC8Urw2lM0wq0OiUiF5wZnZvD8htUv+De30ukSkDOjuuF+XMDtntzBOYOfqXlBnPnzc9VGdT8X1VdzvZsB3Wbo/WL1Bi32Goip1PZOP5qtj772vjjmIKG9P53ApBzkTBcu9mKyVochrn/5LtTtOghmSoE2n9KXqqo5JJeOTX06ptXsdiywEkJYLi1jO5oT5f4Epx5/gMMZ3j4M1gW/6za3sPULa+uHdI3V4v6noH0/06OM484w5a8bwHHMQwK2w7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a2t+dj77vErXanjVHsxukcvqPMMEDKgxdliECMfiRg=;
 b=wGE6Y/pbMVA5chOs3o6bD8BtdvMw65gBXZJFMJiRv47zEi/NrDUd/O50mxhH9pXtiQFpisiHk4rIUq4FZOV1P+tVpIRQqIPWIBBOd+DjqlDApdAFSyWNLT9Vll9fUDLAf0cBS/Q7PwMSolqh3Op2kpRt1VkWUmCfKhaL9BY7GEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 18:37:56 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 18:37:55 +0000
Subject: Re: [PATCH] drm/amdgpu: protect kiq overrun
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20200422145027.2209-1-yttao@amd.com>
 <BYAPR12MB324027891F92EFEE9CCF5E85F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
 <2506b93e-b3d5-25a8-1487-14fcf08c14dd@amd.com>
 <BYAPR12MB3240CD00DC6985E72EE9EB02F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <da4a72bc-32b2-f19c-e09c-2ea3d1439e9b@amd.com>
Date: Wed, 22 Apr 2020 20:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BYAPR12MB3240CD00DC6985E72EE9EB02F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 18:37:51 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff4f0e28-cde3-4f6d-e653-08d7e6ec45ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:|DM6PR12MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30684311F7D89D407AA0756D83D20@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(966005)(2906002)(66476007)(66556008)(83080400001)(2616005)(66946007)(30864003)(4326008)(5660300002)(6486002)(316002)(8676002)(45080400002)(8936002)(31686004)(110136005)(16526019)(86362001)(478600001)(186003)(81156014)(36756003)(6636002)(6666004)(53546011)(31696002)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9ptgX9WpTAERo50jUmfapx1SNeRZ1B5c5cT0TDviAlCckSPspD/fO74VoXbH2YOJkD/vrbnN5CDkOKOQ9M4aCeCwXEu8kOim8J6GYvn3MYia9DYkUyjhowjGTqAF18DY4k4Bzy/UdGhvrI5pnXukCGZWBh/TIYj+csNa+l29rKL8VNzpKmBKJFKPl2N8L+frlhrA/830eTyQ5Hrq8d3o0ThIz7fskjTy6H+pO87vKxl64EXN0zB4GOnRQO255tFdBTjL7S4E5UHOVYKOsdeOUJcXCi5LGkQiYy/28IXWghkqeIE6nlp1WSeVWpN/Sc5GN/NnNtBODm9yf6T37U/3wdsgwOgsTe4jrNtsxzFml3xzNTOnf6tzYHsSKfcd4wERxJ1WKVjh0PuofD+TwiO0REGuKqdRi3jmLTFOgCuZYRfiuLMVoDmmp6z9My5NfYAD+1IFy57Wpwv6NdhZkgKq6Bv+jQS5cxOEfXc32mDkMKMPtKYPqAg2zFC9zl9uDgcV4c/WeipcPOTAoJUcfnRKA==
X-MS-Exchange-AntiSpam-MessageData: 4Q+Tq0dxXonwfWBkpLUSY56iHyCSYYmL/0bfI/xqm/RbSFUPBtvJgqKgSLuJALNtjsn5NBqeQnExGadJjapbR/unET3Ig6y/C9/BaoUFFUdo4VjXYBrqDHpfYfRFQVHykAbnvMMC5uPRS2yc6swD+unzKYj3W1v8QPb3DDte36MRAgzIZVqWXuAm/j7e9VU9dJk78eGk7NeCcei/bR84zEiyS/2LrjPay19Mnmty78SilOtB66oYPvHAC4uFE6I8wHBLU5laY6otRli0doWjR7f/fUEBy0JrYh+QDqYnDDlJYbv6uztGLwvhywK6P46ngp9zrxsNcM7sDMLSIbtG0bD25eApZktsDqqu2Hpc+jEfaM7ei8/lCQfI6Fgji4IaOUUZ/YBc2hcrD+QTFqoJp7nRannVcCMkeYOsSvpQL8hs9/V51oXam0WA1RWRrMoPr+GKGBReIKi8Uxt6krVvLx9wO/2XNW/KxXCKE8Goz0Tlg8CSdDG8AjKZYtLuXckjB0e+66fk8mEplMjRXz5hbINxrft+5l6jOwGV73WsmzdLNvoHkNJKStOGlL36lEct2u2tJoACt1f/mwpsfjrq07b/xaejLYGygnypqj5q+ZcfrZcBOp9c54nKz2KRfKssdfuQL3pPKwb7COwrLF6vT2RUPU3ZNdZsOdnB5tNybQQa/7+g+tpv0D966ys3BRbDKjYHzvm2DI1s6orm+mYrcDiDiHKQKv8PRZW+qMqziNPtq8Uooj0gqEn+n0U80eh5zPAnhYHLzQe9LfkwUR0D8sBhrmCrWG1D1KUYQEXL9JbdEb6UjPoxp6CtmIVl+SRvYfXjZqs4iwQHQzUELRfK0/cIQkS9IDcgUKmsrVavIKc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4f0e28-cde3-4f6d-e653-08d7e6ec45ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 18:37:55.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg36kAHiQZIC/WWFqZVDAMBVTZ4eEASh/aiZ50xsiey3T3KcqAyNn9KPf+/3wg+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Can't  we  check the rptr write back  to determine the available room in the ring_alloc ?
We removed that a couple of years ago.

One reason for this is that checking the rptr each time is quite a huge 
overhead since it is an MMIO register.

The other reason is that the rptr is no longer a secure way of figuring 
out if an engine has processed all data.

Some engines like the CP are pipelined and the rptr is only the 
beginning of the pipeline, subsequent pipeline steps might read from the 
ring buffer again.

If you want to figure out the processing status of ring allocations you 
need to take a look at the fences.

Regards,
Christian.

Am 22.04.20 um 17:43 schrieb Liu, Shaoyun:
> [AMD Official Use Only - Internal Distribution Only]
>
> I always has an impression for each submission,  once the ring be allocated , before the fence be signed , this ring space will always be reserved . If this can not be guaranteed , it sound a  big issue  to me .   Can't  we  check the rptr write back  to determine the available room in the ring_alloc ?
>
> Regards
> Shaoyun.liu
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, April 22, 2020 10:57 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: protect kiq overrun
>
> The amdgpu_ring_alloc() function checks if the requested number of DW don't exceed the maximum submission size.
>
> It does NOT check if there is enough room on the ring. That would require MMIO access and that is what we want to avoid.
>
> Regards,
> Christian.
>
> Am 22.04.20 um 16:54 schrieb Liu, Shaoyun:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> I think each  kiq operation will call ring_alloc  for the package space  , why  not just check whether this allocation is succeed or not ?
>>
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Yintian Tao
>> Sent: Wednesday, April 22, 2020 10:50 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk
>> <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
>> Subject: [PATCH] drm/amdgpu: protect kiq overrun
>>
>> Wait for the oldest sequence on the kiq ring to be signaled in order to make sure there will be no kiq overrun.
>>
>> v2: remove unused the variable and correct
>>       kiq max_sub_num value
>>
>> Signed-off-by: Yintian Tao <yttao@amd.com>
>> ---
>>    .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++++
>>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 30 +++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 ++++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++++
>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 +++++
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 +++++
>>    8 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
>> index 691c89705bcd..fac8b9713dfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
>> @@ -325,6 +325,12 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>>    		 mec, pipe, queue_id);
>>    
>>    	spin_lock(&adev->gfx.kiq.ring_lock);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		pr_err("critical bug! too many kiq submission\n");
>> +		goto out_unlock;
>> +	}
>> +
>>    	r = amdgpu_ring_alloc(kiq_ring, 7);
>>    	if (r) {
>>    		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> index df841c2ac5e7..fd42c126510f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> @@ -323,6 +323,12 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>>    		 mec, pipe, queue_id);
>>    
>>    	spin_lock(&adev->gfx.kiq.ring_lock);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		pr_err("critical bug! too many kiq submissions\n");
>> +		goto out_unlock;
>> +	}
>> +
>>    	r = amdgpu_ring_alloc(kiq_ring, 7);
>>    	if (r) {
>>    		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index a721b0e0ff69..84e66c45df37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -321,6 +321,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>>    			     AMDGPU_RING_PRIO_DEFAULT);
>>    	if (r)
>>    		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
>> +	else
>> +		kiq->max_sub_num = (ring->ring_size / 4) /
>> +				(ring->funcs->align_mask + 1);
>>    
>>    	return r;
>>    }
>> @@ -663,6 +666,21 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>>    	return 0;
>>    }
>>    
>> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq) {
>> +	uint32_t seq = 0;
>> +	signed long r = 0;
>> +
>> +	seq = abs(kiq->ring.fence_drv.sync_seq - kiq->max_sub_num);
>> +	if (seq > kiq->max_sub_num) {
>> +		r = amdgpu_fence_wait_polling(&kiq->ring, seq,
>> +					      MAX_KIQ_REG_WAIT);
>> +		return r < 1 ? -ETIME : 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>    uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)  {
>>    	signed long r, cnt = 0;
>> @@ -674,6 +692,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>>    	BUG_ON(!ring->funcs->emit_rreg);
>>    
>>    	spin_lock_irqsave(&kiq->ring_lock, flags);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +		goto failed_kiq_read;
>> +	}
>> +
>>    	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>>    		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>    		pr_err("critical bug! too many kiq readers\n"); @@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>>    	BUG_ON(!ring->funcs->emit_wreg);
>>    
>>    	spin_lock_irqsave(&kiq->ring_lock, flags);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +		goto failed_kiq_write;
>> +	}
>> +
>>    	amdgpu_ring_alloc(ring, 32);
>>    	amdgpu_ring_emit_wreg(ring, reg, v);
>>    	amdgpu_fence_emit_polling(ring, &seq); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index ee698f0246d8..1ee59a927bd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -103,6 +103,7 @@ struct amdgpu_kiq {
>>    	struct amdgpu_ring	ring;
>>    	struct amdgpu_irq_src	irq;
>>    	const struct kiq_pm4_funcs *pmf;
>> +	uint32_t		max_sub_num;
>>    };
>>    
>>    /*
>> @@ -387,4 +388,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>>    				  struct amdgpu_iv_entry *entry);
>>    uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>> void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
>> uint32_t v);
>> +
>> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq);
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 8c10084f44ef..4b027006d072 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -57,6 +57,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>>    	uint32_t seq;
>>    
>>    	spin_lock_irqsave(&kiq->ring_lock, flags);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +		goto failed_kiq;
>> +	}
>> +
>>    	amdgpu_ring_alloc(ring, 32);
>>    	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>>    					    ref, mask);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 5b1549f167b0..a136e2229f7a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -4051,6 +4051,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>>    	BUG_ON(!ring->funcs->emit_rreg);
>>    
>>    	spin_lock_irqsave(&kiq->ring_lock, flags);
>> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +	if (r) {
>> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +		goto failed_kiq_read;
>> +	}
>> +
>>    	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>>    		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>    		pr_err("critical bug! too many kiq readers\n"); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 30b75d79efdb..77d8bc9c0111 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -423,6 +423,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct
>> amdgpu_device *adev,
>>    
>>    	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>    		spin_lock(&adev->gfx.kiq.ring_lock);
>> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +		if (r) {
>> +			spin_unlock(&kiq->ring_lock);
>> +			DRM_ERROR("too many kiq submissions\n");
>> +			return -ETIME;
>> +		}
>> +
>>    		/* 2 dwords flush + 8 dwords fence */
>>    		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
>>    		kiq->pmf->kiq_invalidate_tlbs(ring,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index fecdbc471983..c429a2a5fe3d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -614,6 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    			ndw += kiq->pmf->invalidate_tlbs_size;
>>    
>>    		spin_lock(&adev->gfx.kiq.ring_lock);
>> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
>> +		if (r) {
>> +			spin_unlock(&kiq->ring_lock);
>> +			DRM_ERROR("critical bug! too many kiq submissions\n");
>> +			return -ETIME;
>> +		}
>> +
>>    		/* 2 dwords flush + 8 dwords fence */
>>    		amdgpu_ring_alloc(ring, ndw);
>>    		if (vega20_xgmi_wa)
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CSh
>> aoyun.Liu%40amd.com%7C0cd26307c0a149ebe0bd08d7e6cc84b1%7C3dd8961fe4884
>> e608e11a82d994e183d%7C0%7C0%7C637231638419034830&amp;sdata=rxkhyMutFwb
>> e5Nw%2BeBGiESW9wTdflDUo%2F4xEvbCbR6U%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
