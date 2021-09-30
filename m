Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B586CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C6E6187D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77C6E6187D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA506EB29;
	Thu, 30 Sep 2021 02:28:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60DE6EB29
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 02:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Awe2ShLiTt4iyIi7Ecyo1ARvwZnA0p6XiC2xPy+xCl5IYrBQW0ptXGdd7x6kDYHwQ1/Ubr2GjLijna8SHrdWvsxXiUMFzwV09pmTGadRyHMzic1/z1+dZzoli7tz2HUFA34009LB/fXEPbErS2UPTuOUCeeTLzJWvDWY21WCDfXGcF7HEYq7evxmBb6PxJhNNvoUXElX4lawH3cAFyIcBQtAvnh0wroz4XWJ6v/gWgyMgp3li7o+CZjemc32oRxkdjkf8wOgzOwtMpsn9M6rW/EyKLkuecH6s1LPnZv7/3+qyunU2MPbAmLjOLZCnqd5jdGFCUx/XYLkozsw6EBDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=b3aqfJPtz7q6jpya9BENdbf15ujjXfQYQ8za0VKv/M4=;
 b=ZLzrtCpQ3wijV9xAlyAlvSQO1Cbg1SSptxpk+My26GkxBqOaZJDM2MJwqTfHKe2BC18+JAGGteMJ9jSgFbLVhnHyh7LgQAJuSfq0s+e4TZy0xtOKP8g/AXWaLMKSXS34/XokZFcI7uDyyaW2H7Q9DtzEf1ZuqsO+4yqr9kD+oDki+SIDtdxxYPtQBG8aZx6ZjJTIlZsxaQ1lof2LMUKoYnFRwI1LydaKHYY2g7GldtaDaZfQ+gipWZW6magTY8SZkAuCv2CN+pNJ0KmKnTzm+rvjJBW6G7YxtZLcGFVejymqVvxOYYpSNjRREL/UqU8o4ZqzE5OvpvjsgkWBrqoTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aqfJPtz7q6jpya9BENdbf15ujjXfQYQ8za0VKv/M4=;
 b=hT31/5izbcRLdGG088pe8EDq+ofo0vyZsZpE1W4MYc+5wXyoK4Qw0dV0A/vXKm/fvQtHtbsa985+aYhfI3BodtB9y7lr1dTBv8Qx1I5h9N15gagQNalh++2HMpmoi++wNwSr+B0k02dX46kLRijX8TqX7My/X25nXO5Rudff8Mk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10) by BN6PR12MB1569.namprd12.prod.outlook.com
 (2603:10b6:405:6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 30 Sep
 2021 02:28:28 +0000
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e]) by BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e%9]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 02:28:28 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
 <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
 <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
 <DM6PR12MB425018180CB2B71C7BBC0134FBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <29e7070d-f36a-a904-e173-0de8a95a7d50@amd.com>
Date: Wed, 29 Sep 2021 22:28:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB425018180CB2B71C7BBC0134FBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 02:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0503b4f-9173-40dc-e9e6-08d983b9fcbc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB15693AC22A7D9CE112FBFC9592AA9@BN6PR12MB1569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdTMAZsg15sOM0p7H1YyjYSvrhOD2Qx3Z308q7J1yRzN775EK4zOfZpVqtHwcLVqe/UuM8G1R6oQs4uO/+KbGECekrIT8OOgPs+ox44j+cWRrhA7CuDiM4im9NMM/eN1ilzj6U5ZMxD9u/b6OJ/x618z6ALtwyH3oV9Tdu2rSuok5lBYErkuI5fVUB47U3+vPr/MKc9pn38WFFd4mmleTQUwODPdfqxVyWRjfhjniZS9omrkx2A8bbu69Acbaua8iqIJGngqp1egIjqiXCO4rcAu0Cmue8I55oHa67gs4dejUXJ7L69xJXWttEuwXV6wJvWskcJt5TR5qL2KitsGFHPqhtq9H2xQyKstHikre9MVpPufV1Yy0VUJ66gA1rS6X6MVCVkFeVYJZ68rIR7JzNpailixbm6AQokRsPAXgLrvNqJSAmV8F6GbImzcFfQujV6P9LQkRTRe6T4TEA+OVxoYCXFws2nZEjgVnrFENixJJKhGcxndUAYCztSIoczcTQOL1AQP+R2xjSlQHJEgKo9H1HWCi6oVn0nupnKu8m2cd6h89J2RtpceILspl5HlCp8CQ9FThuQ7qhqSQtCINE33JHplRdqmjZrVGCKHw6KaHGI04SS7HNHBfB3VzZemDLN3Y+zuvBf6rex5YCkaTPL3GaoPCiTK5rZnGGaPJnjW/QTtTL9rqmUzAipEWTtxIVsTvYCmJ6TC3XvuggxSg4dfd8qBy6GCUXZ9b+A/VEWJK/8wCQP7nawCrR5tkICI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(31686004)(54906003)(36916002)(508600001)(86362001)(53546011)(16576012)(316002)(31696002)(83380400001)(5660300002)(2616005)(4326008)(36756003)(186003)(44832011)(2906002)(8676002)(26005)(66476007)(66556008)(956004)(8936002)(6486002)(66946007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhieG9jY2hwdzEvb0tUbGJCWEFBSEZObHlHQ29JZEs5TGpuejlhU3poa3VJ?=
 =?utf-8?B?VExlKytRMnNGV080ZXQ5aFJtTFpQVWE0ZEh2TDArc0t6bnZRSjF3VHNCeFUz?=
 =?utf-8?B?MGgrZVZHbjlObVl2RjdCS1hZVW5JYWVidEJFMWJzbkdQc2UxVnF4MDM1ZmVQ?=
 =?utf-8?B?YlFld3I1U3lvL3NraEJMMUdoSlJ4azBTaXpzZDNYUlAwVG4yZDdVdzdoTlA2?=
 =?utf-8?B?M3Q5R1p5LzZ1SjlyangyKzc5UUNYUmg5T3JZQytoelJya2V0MDVoMGZWZkwr?=
 =?utf-8?B?MGdzeUVNalhEK1lWKzBSYStsL2tzbFJXREJiTmhObzFTQ1ZZQkRkY00rcUE1?=
 =?utf-8?B?cW1kOVpZN2RxdnRhVHFWbnhWS2IzdEJjcnZuTDlxTlF0WWMzelVFQUJRbG5p?=
 =?utf-8?B?NERMN0JuTE1GMUFLcnpNZlZtbXVQK3ZFVkZhbGdnUk9IYzQ1RUhaelhJSG4v?=
 =?utf-8?B?MEVDa3MzaU5nbWN5NkFqSVJ1c1JEMXIyZXhGUng1Slpvc0VXVkxhVllFV2RE?=
 =?utf-8?B?Ly9WWjJwVlVKS3YvRW56V3ZFV1ZUSzhsak5jTytHRERCcjUvVlpVQ3NYTXpp?=
 =?utf-8?B?WmpoWmQzZnJ0ZllzOU85TmJ0c040VHNmSy9BNWtvVys0OUdJSEdJNGVja2dK?=
 =?utf-8?B?MTJUL1JSeUIxVkhFM0xRSWE4ZE9ML0FnMHdyR0FSUXp4K0NGRFZCdytUZ05y?=
 =?utf-8?B?Sys0ZnpPbG5QZmIrdkRpOHo1cWlPdkljSXRhUmZ0WENxTVo2SWs5U2hCS2J6?=
 =?utf-8?B?cjc2ZlVLUzZLSmUxdGtPWFNwTHp1QnhIOW02Ri9jTzNOb2I4NEllMVV4enUx?=
 =?utf-8?B?QS9VZFBrSHEvby9vSzJCNDdHcVRxUVJQSVR6L2FvTHc5aGhOTjFuSE5nN3V6?=
 =?utf-8?B?WUJHZjhydFRhRkhvYXQ4OHArRFg3NFBRS3VqVXhPU2JzSnplcGNVVU1uQW1L?=
 =?utf-8?B?UDJIVmRJVnBhVUtyb1FHWDVTdkVXbVcrMGJKM0N6OVhhTGpwc2FRckRvWGZ0?=
 =?utf-8?B?cDU3Y2pIWU1IMy9Ba0VLVUJSeHc3QmM0Z1VVbWRnNzlhcVVQdWdJZEdUaVlk?=
 =?utf-8?B?U0tHdzExNUVHbHdQL0RJVXlUaVE4c1VlZklKeCtJMnlKR0lJMWM1VjVha0l1?=
 =?utf-8?B?emRDbXRhclRIOTk5VVJodXk0NUNrZ21UL1l3cFZtNzVFZDJRSVdPamZsdGRQ?=
 =?utf-8?B?Zk9tSUc3dHR6M1h4OWVMMjdYOW1XSVZSd2JzUFA4WU5YN1lUNmRYUVVZK3Fm?=
 =?utf-8?B?dXg2eHVXRm51S2s1RzZQSU5CZlBldktEclcxdDVCQXQrMmZ4ZkhQNkM0eUgr?=
 =?utf-8?B?L3pibFgzakdqNXh6SHhlZnZWQ1g0aERpQk9rUGV2dWpNaTZucVlNOXhIbVM2?=
 =?utf-8?B?VVBlNndzT2Y0dkRhSjJzYmJnd1JhNk9Ib0VsQ1VFQ1Z5NkJxOVZJeUVYT0Fy?=
 =?utf-8?B?SEh0N2I0QmZENW9yUG9KVzZOd29IajhqcUlicUFFSTg4anl5NnZ2by9OZlhO?=
 =?utf-8?B?NUpuaHlRU2U3SXd2QWFiSnduSCtRWU1OUTVaZkdRMzdweHYxZ3N3M0pJL0VY?=
 =?utf-8?B?aU92Q1RacUxUcTRZQzlsSStSNElWWkZSanY5Z1g3QlpxbkQrWFlaT2xwOEN3?=
 =?utf-8?B?RHNwNmFzUDgxZ0phb1VRNkc3VlFaNlE0YVdndHVJMmtGdm0wUjcrcUhmK2pW?=
 =?utf-8?B?YTlnZWdOMUFNZXZEN05iSW44UDNFNm95SDN1M2MveU0zd2dXZnZrU3lxN0NR?=
 =?utf-8?Q?Gqbk6BAR1iitlyfm684uJkAPzzT/9Brt1iaR/vn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0503b4f-9173-40dc-e9e6-08d983b9fcbc
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB2481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 02:28:28.3512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6SVuaGbUwWR74K5Meepwm/VJ+YCP+Fg/Tc/OkeoRUZlRpo8nGnYVJbHPcN4u7XNnRXiGCaQnkIYadqB3aD67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1569
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

On 2021-09-29 10:23 p.m., Yu, Lang wrote:
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, September 30, 2021 9:47 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
>>
>> On 2021-09-29 7:32 p.m., Yu, Lang wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Wednesday, September 29, 2021 11:25 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
>>>>
>>>> Am 2021-09-29 um 4:22 a.m. schrieb Lang Yu:
>>>>> If user doesn't explicitly call kfd_ioctl_destroy_queue to destroy
>>>>> all created queues, when the kfd process is destroyed, some queues'
>>>>> cu_mask memory are not freed.
>>>>>
>>>>> To avoid forgetting to free them in some places, free them
>>>>> immediately after use.
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  8 ++++----
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10
>>>>> ++++------
>>>>>    2 files changed, 8 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index 4de907f3e66a..5c0e6dcf692a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -451,8 +451,8 @@ static int kfd_ioctl_set_cu_mask(struct file
>>>>> *filp, struct
>>>> kfd_process *p,
>>>>>    	retval = copy_from_user(properties.cu_mask, cu_mask_ptr,
>>>> cu_mask_size);
>>>>>    	if (retval) {
>>>>>    		pr_debug("Could not copy CU mask from userspace");
>>>>> -		kfree(properties.cu_mask);
>>>>> -		return -EFAULT;
>>>>> +		retval = -EFAULT;
>>>>> +		goto out;
>>>>>    	}
>>>>>
>>>>>    	mutex_lock(&p->mutex);
>>>>> @@ -461,8 +461,8 @@ static int kfd_ioctl_set_cu_mask(struct file
>>>>> *filp, struct kfd_process *p,
>>>>>
>>>>>    	mutex_unlock(&p->mutex);
>>>>>
>>>>> -	if (retval)
>>>>> -		kfree(properties.cu_mask);
>>>>> +out:
>>>>> +	kfree(properties.cu_mask);
>>>>>
>>>>>    	return retval;
>>>>>    }
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> index 243dd1efcdbf..4c81d690f31a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> @@ -394,8 +394,6 @@ int pqm_destroy_queue(struct
>>>> process_queue_manager *pqm, unsigned int qid)
>>>>>    			pdd->qpd.num_gws = 0;
>>>>>    		}
>>>>>
>>>>> -		kfree(pqn->q->properties.cu_mask);
>>>>> -		pqn->q->properties.cu_mask = NULL;
>>>>>    		uninit_queue(pqn->q);
>>>>>    	}
>>>>>
>>>>> @@ -448,16 +446,16 @@ int pqm_set_cu_mask(struct
>>>> process_queue_manager *pqm, unsigned int qid,
>>>>>    		return -EFAULT;
>>>>>    	}
>>>>>
>>>>> -	/* Free the old CU mask memory if it is already allocated, then
>>>>> -	 * allocate memory for the new CU mask.
>>>>> -	 */
>>>>> -	kfree(pqn->q->properties.cu_mask);
>>>>> +	WARN_ON_ONCE(pqn->q->properties.cu_mask);
>>>>>
>>>>>    	pqn->q->properties.cu_mask_count = p->cu_mask_count;
>>>>>    	pqn->q->properties.cu_mask = p->cu_mask;
>>>>>
>>>>>    	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>>>>>    							pqn->q);
>>>>> +
>>>>> +	pqn->q->properties.cu_mask = NULL;
>>>>> +
>>>> This won't work correctly. We need to save the cu_mask for later.
>>>> Otherwise the next time dqm->ops.update_queue is called, for example
>>>> in pqm_update_queue or pqm_set_gws, it will wipe out the CU mask in the
>> MQD.
>>> Let's just return when meeting a null cu_mask in update_cu_mask() to avoid
>> that.
>>> Like following,
>>>
>>> static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>>> 			   struct queue_properties *q)
>>> {
>>> 	struct v10_compute_mqd *m;
>>> 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>>>
>>> 	if (!q-> cu_mask || q->cu_mask_count == 0)
>>> 		return;
>>> 	......
>>> }
>>>
>>> Is this fine with you? Thanks!
>> I think that could work. I still don't like it. It leaves the CU mask in the q-
>>> properties structure, but it's only ever used temporarily and doesn't need to be
>> persistent. I'd argue, in this case, the cu_mask shouldn't be in the q->properties
>> structure at all, but should be passed as an optional parameter into the dqm-
>>> ops.update_queue call.
> The cu_mask is originally in q->properties structure. I didn't change that.
> What I want to do is keeping the cu_mask memory allocation and deallocation just in kfd_ioctl_set_cu_mask.
> instead of everywhere.

You're not changing where it is stored. But you're changing it from 
something persistent (while the queue exists) to something ephemeral 
(while the ioctl call is executing in the kernel). I think that would 
justify removing the persistent pointer from the q->properties structure.


>   
>> But I think a simpler fix would be to move the freeing of the CU mask into
>> uninit_queue. That would catch all cases where a queue gets destroyed, including
>> the process termination case.
> Yes, it' better to free queue related resource in one function.
> But we allocate it in kfd_ioctl_set_cu_mask and free it in pqm_set_cu_mask, uninit_queue and so on.

My proposal here is to only free it in uninit_queue (when the queue is 
destroyed) or in pqm_set_cu_mask (when it is replaced by a different 
cu_mask).

Regards,
   Felix


> It seems strange and error-prone. Unless we allocate it in create queue.  As you said, it is temporary.
> It's not worth keeping it until queue is destroyed. Thanks.
>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Lang
>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>>>    	if (retval != 0)
>>>>>    		return retval;
>>>>>
