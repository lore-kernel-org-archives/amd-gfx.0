Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55632C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 17:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019D810E353;
	Mon, 30 Oct 2023 17:48:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440A010E353
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 17:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVmHrx4CiyKsWHbGk6CBMVj91N4HlfWTQUvpBbo6JuWgOHOKgz+6lWnGILT7BF2KqIsTXnpb1hxRqGbRCU3qc6/Yh5IHShUCv0hurE+bN0QiqMytPp6CneYCtE86MUbWqADjD+FQpTklDzbAf5zpIMMK+EtpiHX7zWT09vx5JmrpOkOwLH1I6zsHBvy/3591HunPI45FxXpwJELi4hB6JOET6T08PdHHEO2tQ7PL5Tnja622abUa15xash1OyhBNFId+6jbWtEYZ07Lz1RV0Y3/OCxIm7VYD9r2cL/S8RKNZIsj27EoFLl03z66kdZndQlWMQwFyurFRDa8oZojcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lPiVIs9JJBfNqeT4bJvpchYWp1UjAvSxlR2HZ5yN88=;
 b=RBXyVnW6cYKlSSH7N1uTbkiKCZzKPnGWFz1SvhRSiaTuR383j9KoS7pbf/wc0IMHJLoAZpRIhplnnZq3ws8N2PaWMRSnZ4Egs/vJhZNiATq0BcLbMtdYcrSbYl1VwcpXWRkyPaH5/mYHlLv27CI5fKlesKAE1B3+qRyEqptBrxBw7zSq2QowlydFvTt1H9XhPHciuiQJUHbImpdJeaaBwUky97lGjIJBbhxBI6U9Q3dINEPVhtli9B52yflv7ABbUF9n9j6i6Ra5V0kLxUosYRCrmd2Gs3XseHoN10vPLEJjrVj1J8ImbPb8RuDMLjjH4AcBGLOg8z3ZBVhsERlh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lPiVIs9JJBfNqeT4bJvpchYWp1UjAvSxlR2HZ5yN88=;
 b=O1I7DPYho3BrdaZDXQxUiT/OL5Y1OmEnYZ7B65NVYE38E1tz3gxxEaiqxOlJ/D+iN4YbU2nmQs9Re3C5lUopesIRFUJpPmWgTnFH/NvuIeTgHV48ormWcdqdqUQk8fTCptE2wS/z+UFxLMV3FqDevGGP7FBHT+LKM2yUbGjUqWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 17:48:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 17:48:42 +0000
Message-ID: <2e1e1fd3-ae15-4faa-98a6-a71ba3d8fafe@amd.com>
Date: Mon, 30 Oct 2023 18:48:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
 <da7010c1-6b11-41f6-986d-796539073451@amd.com>
 <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
 <f1d1b3e1-fac3-49a2-97f8-7cf9ede8c064@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f1d1b3e1-fac3-49a2-97f8-7cf9ede8c064@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1c0831-3563-4a07-dad1-08dbd97074f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaCHyhlIH2pI6BPM1vpooOcKsxTG/+UyQwXS3B0equ9njXAKMiNc140YRkORNrhKJCaeubp9lnVqmcmodnsmlAmFoPQqbl9b1VjoCXLkZDlBMetUzitYzKdtnlz+O0gTMQGU3GUUFkDQmzt7KQEKcuK5ICk8R5y07SSdAJDHJZHBnLG5VwXJB0cecU6jx2qg3FM0FH8098dPgJOwV3HsvfRt3NAtiaolPKFM+oemDUMOLykwZcHZzO6L0BmVU6VSQZytNLMmEK+3Lbey8CIY51V0tDQC2yXcjJOzEJn2PlKZoYNx/7Mdb1LTbeC2plkAEvYQsjP4o2jqrLnGcVDo4uMDfRpW2QHyiO/4BTPMrzbLQh+8PqxnaygGJgeSASPO4Vs1n5Q3hyRINk8jCpg3b/P3KrkFoz1qoceoIgfjhTkof/IJ9QhoN99S8pGT43lsCljafBbPds1p0uPzAqPC94KBkS2lphJeZNw4FXo+kUb884ye+4fqMzw6bbLmzB4392yGN9pTQuKyMPXJ7Ees5dnRjr4HnSnCqN68v6cwtJ7IEHCrvoEcQ49QT0mG4lNe3i4Orpsvpas+G7DRFdx8kNI01u1w1GBqd3rCAlh7l91O7v8047kLj6qD7IihHvkIkvO7G3SDoSOMlKNkvLGhIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4001150100001)(6512007)(26005)(2616005)(53546011)(478600001)(6506007)(6666004)(66574015)(2906002)(6486002)(83380400001)(41300700001)(66476007)(66556008)(110136005)(5660300002)(66946007)(8676002)(8936002)(316002)(4326008)(31696002)(38100700002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnh5SXdUVGpMaEhMcXRXQ0FNaFIvSTZYeDNnOElKdHBnZHlnNk9BUnJCcDh2?=
 =?utf-8?B?ZkthWlNzWHhDcmdhYitCK0ZnQlduTkxxcUtTWkZZQ3ZnSzNhL1RPMGhUdWds?=
 =?utf-8?B?clFwMm9UallkZitQVE1vQmt1L0VpVHI3TzhkNzg4RXNJaUw4a0NmZ0JtWUE2?=
 =?utf-8?B?d2I0ZXFNNlFOUm1nYXdvais3azdFYmlWdDlPcEcvMFRSQStwTWN1NGNycE9Y?=
 =?utf-8?B?ZUFLbjdaRmcwbmhuNndhYk9tUWVEanozdHc4UCtGTlB1c1M1VldyZVFiejlL?=
 =?utf-8?B?RllYVGlrKzRnM1JuVXdGdDl4R1E0ZGJRZ245VlA3ejcxd2FBdjBXSlkrc01R?=
 =?utf-8?B?Nm9EYzllUlFYcTNzODVZVi9jekptZFJBMWRyUXlsTUxqa0lqZTNHbFdMT1JK?=
 =?utf-8?B?L3J4bXQ0SzlyeDhkOUlyTmplRGlHdVBSSlVqdDZGcUppMitlUVEvUStmMHBh?=
 =?utf-8?B?bE5qdmw0Sks4ZnVHVUdvcVFQT3NvZ2MwQWF5ZzErOWdWaVNhZGRUQWZWNzM5?=
 =?utf-8?B?WFZwSFhLdDZIcjhGNXZHYS9zRWpQY1VHcUl0N2U1ZHllSDBXRENzRnZIN2xm?=
 =?utf-8?B?SE0xdFFtbi9NSmw3SnlEL3hpTitiUlJKd3Nuc3JCenJpa2o4YU5xQVQ2V3ZM?=
 =?utf-8?B?ZEFOWVJZbEc4WXRvWUtKK0VBaXFKM2RIT1ZuR2tJaHpMdjJ6aWtIVzhOTHRN?=
 =?utf-8?B?L3dEazRlVlEya0g0L3BiT2JtRHBDRDN0YmRuV2UxUTRnR0hpaHhaSDN3S2lE?=
 =?utf-8?B?ZDIyUkxYOTYxaFFwdkZTUHE4aU1BV2poZjE3cWRhRGNKTkl0b1BOZFlQbExS?=
 =?utf-8?B?SXMwVGF5djdWcDRjaDNCb2h6UWRHWEJQWHVSSksweVYrb1JlK3VpTHlSekM5?=
 =?utf-8?B?TEtWSldiZ0lBQUlEYTNyU2NnZmNzOGxXc3Q1VCtwZy9uZlcxT215QnVNczlp?=
 =?utf-8?B?SW5MZkk0b2YvNEhwQTYyRU9EcjQ0WVlnQklBK0JxY1gxUDZCaExOZnV1ckx4?=
 =?utf-8?B?UmJyVmhQRzBQdGJUWHFpNG82THA3SWVKeGFFQ3BidXByeXA2S0loSDBxOWxL?=
 =?utf-8?B?b3lncFpxMXZoVmN3M2NUOTd0NkovaEphM3ozVGZ5WlNLYkZtcG9ad2t6cFdN?=
 =?utf-8?B?ck13YUFDT2luOCszcFhlVnAyK0xTVXNsOTVUR05udzNYUDJIVTNlZlUxSkNR?=
 =?utf-8?B?aHcwOTE4R20xTFh4T2MvVTYza0ZHT051WldKb2VkekcxKzZEcVAxQWR4RVdM?=
 =?utf-8?B?Ukc3Ulg1VTMvRmlINXVJWFFMR1dDTEhDLzRYaUJUS0hwWE9IVGZYVmtRbjlF?=
 =?utf-8?B?WDZtS3F0eW9iUnBzUS9lYXh5NnBvdU03MzFHVmJJL2hpSzVTSE9kV1B2ejVH?=
 =?utf-8?B?TitNRXdoVFJCNjh6dlJwKzd3bTNycEV6WmUyYlVRQWcrMXdMaUtiSjUwZU5v?=
 =?utf-8?B?OXExZ1ZjRGFGNWpIL3VKcnNaWS81ZjByKzUzRDRqTWVKa3ltMTZyUkpUZEZN?=
 =?utf-8?B?N2sxZmtWbTZxYnp3aW5NT0QvSjdnYzkvTVQ3a3BpekFPdEQzNjFEMENlRzJL?=
 =?utf-8?B?MXhpYnI4K3VySTJLdnQ0Qm9iOVkzOFdOWER5ZUNxT0FmZldvQUx1ZWwyanU1?=
 =?utf-8?B?bUJ5K1JGV1hxWVBhVWp6ck44SktScTRPQmlkc2hmSWVEUGJOV05xdk5kL0Zq?=
 =?utf-8?B?bWJ1MU93cVoxMzVBZzM3Q3JOSklRUXcxMHhiNUp5eER1d1ZBUlAyRnpkWFdZ?=
 =?utf-8?B?L3RBSzgxVGJiai85akdBZHJKZGJTYmpLWXdGdjBjODlBQVhrSzVmZmFMZEtl?=
 =?utf-8?B?WW14RE44TldtVnh0YlpSVGJtb3F4QXdrdnZXK0FrQkpSMGRKVmN1VWt0SzFV?=
 =?utf-8?B?UnJ5QnptUjBRQVRzUzdFclllaHYvQnZrSmFwR3RVaWNqTkRzUFZBL1YvbmR6?=
 =?utf-8?B?MmROdXBlTVpzWXNhazZzemwxUWtaM2MwMFpNS0p3TTlaR29QblIzR0NhK2Jq?=
 =?utf-8?B?Tk5qL3gycWRWT3dpMHVmRkRyM1o4SUJTd1lxTU5KSEVUcXdiSlBUbVNHaUhj?=
 =?utf-8?B?bWw2WVozZmZab24zRnV0RGJSek9zM0tMcXppTllRMng2WnRJUXdyVUhiTmpk?=
 =?utf-8?Q?vOi0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1c0831-3563-4a07-dad1-08dbd97074f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:48:42.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT2OZMiVpx8EkTuS+4F0pPFcIa7zrybOyfMgoL2k6Qrx8SPdsKfmm6tFBxuIMU/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.10.23 um 18:38 schrieb Felix Kuehling:
> On 2023-10-30 12:16, Christian König wrote:
>>>>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct 
>>>>> kfd_process *p, struct kfd_node *node,
>>>>>       return -EINVAL;
>>>>>   }
>>>>>   +static void signal_eviction_fence(struct kfd_process *p)
>>>>> +{
>>>>> +    spin_lock(&p->ef_lock);
>>>>> +    if (!p->ef)
>>>>> +        goto unlock_out;
>>>>> +    dma_fence_signal(p->ef);
>>>>
>>>> This needs to grab the internal lock of the eviction fence, I'm not 
>>>> sure that has correct ordering with the newly added ef_lock.
>>>
>>> Hmm, the only thing we could get a circular lock dependency would 
>>> be, if we took the p->ef_lock in a fence callback. I don't think 
>>> that ever happens, because even the eviction work runs on a worker 
>>> thread (exactly to avoid such lock dependency issues).
>>>
>>> Anyway, I could try to move the fence_signal out of the critical 
>>> section. The lock is only there to ensure that exactly one process 
>>> signals and frees the fence.
>>>
>>
>> So basically either the eviction worker or the GPU reset could signal 
>> this fence.
>>
>> In that case I think it would be simpler to grab the reset lock in 
>> the eviction worker to protect against a concurrent reset.
>
> Which reset lock? adev->reset_cntl->reset_lock? I only see that lock 
> taken in aldebaran_mode2_perform_reset. I don't understand why this is 
> in ASIC-specific code. But even so, it's only taken during the actual 
> reset (in aldebaran_mode2_perform_reset). I don't think it covers the 
> pre-reset code path that signals the eviction fence.

No, what I mean is adev->reset_domain->sem. It's hold in write lock 
during the reset and you can grab the read side if you need to delay a 
reset.

But thinking about that a bit more, you actually don't need any of this. 
Something like this here should do fine:

tmp = dma_fence_get_rcu_safe(&p->ef);
dma_fence_signal(tmp);
dma_fence_put(tmp);

dma_fences are always RCU protected and can be signaled from multiple 
sources by design.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.

