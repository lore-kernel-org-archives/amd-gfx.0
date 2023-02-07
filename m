Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53234C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 23:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB23510E64E;
	Tue,  7 Feb 2023 23:36:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCF810E64A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 23:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+uBFg1/QjUvHAe4OWo/mWRA9L2WMb7DmG6TGaRtbz4nCbnwKOENz2FtqQhycva3YA8OjaaYpUCu/FKXDjQuW5wSAWVV9iT+CdnVKvZB8AGKmrTD/WmQtEzmZiFEnQ1shEgFFplUt7S9iKiPlq0IMVgq0eX+3wotScYSCNnWso/vORtlVCH42bMmAPSoEmGbeDLck+pctnv+ZwHZwW8R4GNKDeMjkuZgSP1Bcneo1LXg4sBodVDYy4uHz+K7G8CKiobbEUP3UTxsEKwGxt4VUBB66BJ+ReIi2O5ChCAlnG+Gz4eWUC3adYAbsWa+7UjJ5mqpT34cQ1DvDQmRExjmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otaTGwRE9GWbJCfSWi9yFxDQmUz3DUYphsBkU0gMN/c=;
 b=EOqNWdIlZAqZqrbu+u3fsqUQ2wexpD9PtEjyvzx0JO/pxq1k5HPRZ1AxhHnfL1+tUq/ak1miUW3ocvVVi/BEcQ8PwpbAHFUvl2rS/tU6gc0AD2DmhG3YE5+g1/w8cK3hNa19dNiEvW92ikGEtwV02FM7T2AnEx63YlFfIkO+6DVfGUlwhqdVWJ5TzRj+BXRWzOg58gatpO2R2VWBawEQ+/Q6klTh5h0dd4AU0MZFeZH1amQLt84UEc8UCzxh9qpnSHe5cb2jFDa3QPxrhnwi12b+jtmoSf/P48H1rlnCWrGHHl54NWXnZN7yuF/Li01owQywNJQbXEyW3PO8jdN1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otaTGwRE9GWbJCfSWi9yFxDQmUz3DUYphsBkU0gMN/c=;
 b=BxiIxRNqVfJqyzbNdBg6G/DPyZpacz92SdWL3UTA/rOmF9KlvXA64xnzjDxo9Sjw5gJBu+HIsveuykZ7AnJvLLhUvdc8SleB6SagoItvxJQF9yyMgJ2dwRG+vbmTJog9sX8/PDMJ9kyl8AyS+dpvc1XtsRNFSjZUl8PARb3BE5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 23:36:29 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::7418:855f:c703:f78b]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::7418:855f:c703:f78b%4]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 23:36:29 +0000
Message-ID: <d0043f07-183b-f6ca-c97b-faf45cde3ce8@amd.com>
Date: Tue, 7 Feb 2023 17:36:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdkfd: Prevent user space using both svm and kfd api
 to register same user buffer
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230207203504.879056-1-xiaogang.chen@amd.com>
 <3c62317d-7ef8-9f5d-4ca3-1b1bb9d56b14@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <3c62317d-7ef8-9f5d-4ca3-1b1bb9d56b14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 805c816c-e8ec-407f-0b1c-08db096422c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Lxm0SJHxbKgrcTxjV7CZj+XWI72p0b2rjLG4oIGq9tSB4pu1oiptaDMuOeU85FBqOCF/R+EB2JGtq5pH+FKITqvnWMj5eczz82FWdtapxAfYEc50T7cpPWLyUEFpnbZW19ovcMZqGOSNZAJsUde5lPW4QfxNbOQMiBJRqLaamWLKF/1lCL9sE/l6jdkVznslptsCy6S0s5KFRbuRBLBosffIKkpr2ce9NOxoyUy09nyQQy44QHTslac6wMLH4po3ynzYoaMDfwDBP4xxto/4ofoPjOBaAomYFQFq+HfVRObvuzrlipK7c+2qVSGBQEN3MTmpRojJYZJAj4JYs5AjwUkgDMX/dR/6UFPpPNsZUwoLyWQl6n9PnzEboMnTServb9KEJohFC/DO/AxZuXC3gQ5rEVlOPL4Kerg6SenqRFu8sF557O7avDBbFtrbm8y/AM0cI5MRByJyAryp/HlkhcrloXHo0oYZ+tDPCqGx4ToziiHuAtroNDLrx/dsjz7E81QjlzEz3aL2CrnflvjnDCqr10dCA+cPC3MXVUxSEcx6OTsRHmxa07EC/n9J2lhoGU3k+0TaNSFJPbuFriZ8KGjdtjqvRKk1nd/7+/lq89wpSyEUZFNI/zeCvTZ27IRNcwu4/PLSEMM8NnX6jHBrmd1G3TL711Y1E1T2Z0rU16P6AjRNgkjDXiqqebd7fpNeR+xsg6uQTm1Vgb+NYF/JU3Nczm6cbujeqEMTMjjZB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(6486002)(478600001)(66556008)(5660300002)(316002)(31696002)(36756003)(83380400001)(8676002)(41300700001)(66476007)(86362001)(2906002)(8936002)(66946007)(26005)(53546011)(2616005)(38100700002)(6506007)(6512007)(186003)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JmUU9QbnpHVUdzTFVUMTFWNVFtUzNBRnB3VENCWklVQ3JnN3BYUUtyREF6?=
 =?utf-8?B?WEp3OHlzL3ozcGowNFNvWWd6SWNkZ0dPdXl2NU53TDZZcHBwQUJ4TWh6TmE2?=
 =?utf-8?B?ckhKVUN6TCswclJzekJ3TXIxTjRhUVhGOU9QMk1vS0lUZlMvcitaMm9zSnpI?=
 =?utf-8?B?Z1I1cWc5eitDWTNhbFB5a3ROdWhyRDBWUVhVcG1nY0paSGNLcmJ3MGxlU0hL?=
 =?utf-8?B?ZUpHenRKV2dReGVuZk9oNVRUZ3pCNkd0b0ZnUytVVnNGZ1p4QzIvbndBUWt1?=
 =?utf-8?B?bHJUaXA4QlVnMCtEMGVFeldvRmhlR0ZFWlkydmF1ajZ4akxTR3dVWUhEZDJE?=
 =?utf-8?B?UGc1WVlDM1VjS2dvbXJJUUtCVWdzemM4RUVUMVFCRkZoYXlERTY5T29uaUF4?=
 =?utf-8?B?NU1OV1hxc2pvTTB2VDRKclczRGtLK3JnZFNhaUgvTHFzckJjdGMyclBZNE9T?=
 =?utf-8?B?MVBzQnNWanZmZlhvTUdLRFQ4ejJoS3M1QlJBNmdMbGdBQ01uRWpLb0tydHQ1?=
 =?utf-8?B?TFhPVDRQUU5DelE3TEpxd3p6U2ZFV1lQWmVxSjhiQUtDV09iYS9KWTBKY1FM?=
 =?utf-8?B?SnNaMVhETVVWWXJDUmtmVUV3bERnSjVjUlBXWm1aTk5oY0dLcmw3TTUrUHZ0?=
 =?utf-8?B?eHAvVjM5Q2lWM0JONTdiQnJpUE9PNHRHZ3VWMDNWaUFzMjNVZjVRRkR3Qzh2?=
 =?utf-8?B?NWgxbUZIMzBiSlUraFFaQ0JGRFU5TFlwOFBxV3lZaUFJVFpYODlBN3NWcGJ2?=
 =?utf-8?B?RkNrZUZ0TlBXRGxSd0RyTHRkeks4dEJuYnNFa00wT2pGNGU2c2dMbWFrVHor?=
 =?utf-8?B?dlFsdEZyRUZldHpZdlJZaHBMTFhJZ3RJbW9lMk1lRHl4UXNZRW9HbCtJL0NM?=
 =?utf-8?B?dll3Q0s3MHg1UWthYmtNRWNvT2oyd3c3emh1dTc4U0R0SFpWSGc4OHJ0YnQz?=
 =?utf-8?B?MjR4YVRFNnBpK0lnMkRhbUJxU2ZhK0hoWDlPU1I4T0ZmTVh2Nk10czFJSUJT?=
 =?utf-8?B?MkYySzk3VEVBMnZBY0RTNy9USm00eWw3YVlHMEl5bEcyNUZXMks0SERldU1z?=
 =?utf-8?B?RFJOc0UzSjhkR0JrMU15Z3Vjb1pzYlpMLzZLMnZwRWNOVjlQMktRSmNhUlhs?=
 =?utf-8?B?Yjl1RFY2RHlFM0JQVkhsL1p5QjdJdnpXazBaTjVQc1ZSdU4wYzFwWTZNNnVG?=
 =?utf-8?B?L2RReEN2Q0VpbEY0aHJVTDRNb3RUazgvM2FIM3BpQzBsYW5ETmd0T0p0N2g3?=
 =?utf-8?B?S0Q0eUdkanZoL0tGSEsrOURGTU1aRDhTRkxyMFJwcHZxcWZyOWwzUFlRc0pj?=
 =?utf-8?B?bUNjdGFMYXJ3bjBJNTVBSEdyWE9lMUlUZ0ZEMjVEYWV4c0dTa1l5Nloxck5u?=
 =?utf-8?B?MWk2ZG1pbThCZUk3UmlZSmtTVWo2NGlZU3VDUzlmcnNxd2lEMHBWUWh5bWcx?=
 =?utf-8?B?dERmbFlmcEVCZDZtUVBuSWhzU2YybVlmUThleG1IQTdQQVBTMVQ4Z01yUTJm?=
 =?utf-8?B?MGtNZTJrTVRSZk92WmlCVmtudnZQcjFtNE5ORFd1SFVKSnpxRnNlUVNzUDdp?=
 =?utf-8?B?RUZadkY1WnNDdTBxNUVEQ2JTNUVlbXBEK0tGelRHbkl0cVNTSzkwd0wzMHB6?=
 =?utf-8?B?bU5oRHNKb0NGYm9oc2UreXRXL2RtK3UvQWZHSEg2eW1OT1ludXlTUVFsckxD?=
 =?utf-8?B?Y1RiNlkzUFBzZ01sSk9uMm5SM2kwSWdTNlFBSEI3OUVuSlJMMVNNaFBFZDk0?=
 =?utf-8?B?Slhudm8vMDcwZHQramlWUTIwVTlwS2dtWm44SDVuSEJ2ZmZONlhhZHZrQXJS?=
 =?utf-8?B?QlJIdTVNQ1RvcEdBUXBiYjVWK2lQd2VZSUY3NDVWNUFLVHB1VFNud0VSSFZW?=
 =?utf-8?B?Q1pkSS9XUkFPd0MvOHk3WWtyd2ttd2ZwREI3bUdVdDJ3YmpsOUdpTTB6Nlo4?=
 =?utf-8?B?aDdGOTlZVmZUM2dJYVpTeTRmOFVhb2ZxV3NnL2V3ZmZwRlFROGh3Wkt2RTlh?=
 =?utf-8?B?alZhMHB4QmhKQmMxSzFGVVROMlk5RUowZ25BczBBc0lkRktzNklvaTJtT0pn?=
 =?utf-8?B?aDlrV2hYVnpMSVBvYlVRUEFxOGl4NDhqeUNDVzB6ZkZLV1lYRGpzMW5HOWRE?=
 =?utf-8?Q?IlfU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c816c-e8ec-407f-0b1c-08db096422c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 23:36:28.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr6QqzZLNF8BM+Cy3Yrl6QK57Qxw315ft0OyZYhYybNIWKCva0+8Wwsn631ZX3JC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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


On 2/7/2023 2:48 PM, Felix Kuehling wrote:
>
> Am 2023-02-07 um 15:35 schrieb Xiaogang.Chen:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When xnack is on user space can use svm page restore to set a vm 
>> range without
>> setup it first, then use regular api to register. Currently kfd api 
>> and svm are
>> not interoperable. We already have check on that, but for user buffer 
>> the mapping
>> address is not same as buffer cpu virtual address. Add checking on 
>> that to
>> avoid error propagate to hmm.
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index f79b8e964140..cb7acb0b9b52 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1065,6 +1065,23 @@ static int 
>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>           mutex_unlock(&p->svms.lock);
>>           return -EADDRINUSE;
>>       }
>> +
>> +    /* When register user buffer check if it has been registered by 
>> svm by
>> +     * buffer cpu virtual address.
>> +     */
>> +    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>> +
>> +        if (interval_tree_iter_first(&p->svms.objects,
>> +                untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
>> +                (untagged_addr(args->mmap_offset) + args->size - 1) 
>> >> PAGE_SHIFT)) {
>
> Instead of nesting two if-blocks, you can write this as a single 
> if-block like
>
>     if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
>         interval_tree_iter_first(&p->svms.objects,
>                      untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
>                      (untagged_addr(args->mmap_offset)  + args->size - 
> 1) >> PAGE_SHIFT) {
>
> I'm also not sure untagged_addr is needed here. If it is, we're 
> missing it in a bunch of other places too. Most notably, we don't 
> untag pointers anywhere in the SVM API.
memory virtual address tagging is architecture dependent. Ex: if virtual 
address is 48bits and use 64bits pointer, people can use additional bits 
for different purpose. From kernel source tree seems only arm64 and 
sparc define untagged_addr that are not noop. For other architectures it 
is defined as noop. I think we want have it if run on different 
architecture cpu.
>
> Regards,
>   Felix
>
>
>> +
>> +            pr_err("User Buffer Address: 0x%llx already allocated by 
>> SVM\n",
>> +                untagged_addr(args->mmap_offset));
>> +            mutex_unlock(&p->svms.lock);
>> +            return -EADDRINUSE;
>> +        }
>> +
>> +    }
>>       mutex_unlock(&p->svms.lock);
>>   #endif
>>       mutex_lock(&p->mutex);
