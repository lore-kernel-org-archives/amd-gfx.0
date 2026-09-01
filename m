Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57C8C61DFD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 03:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832A110E351;
	Tue,  1 Sep 2026 03:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BzFJ0inq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F21110E351
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 03:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCITYV2+uAfP1KFzUhr2FoEfQ7vXZFSaF/US4YKOecyw5oAsDg87Vz1rR95iD5uSMdjBzZZjenZQBk1njsae2XZzEGeNuworlw+wHjSQkiiPfDuLHqwCrFNbDH87HVFH2rIJ+EQvAKtrFa07lBcvge7z9v1fLJn5vLp1nF+Szdx2n4jVGkOpg6lc7qtzMjv8ILiv82vZG/NMb671uvbEGrvlXSNbrqjBb74vknmvAvEDQPxOhDFf1O8p3C74QkKe7rvjXchiMZdv4UtBqrHvABOJaE9t82WQMC4x+P+F7B5fxBvItO0OtXmIklzMpvnVR2MLtdaHbZZIoDRU5Fx/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eD08f3sF/0X56aLKafB+gBDIj5TSRc9C9kYN/Tqflk=;
 b=LMX+5y4h72M1ComCtn6vILQkHe7csmOJbglVNNfD5a1IGT48ry+A5lPKW5USxRKtqvqufeZwMvCjlnoJ3fusiOf/j24elHjLdMiMzdDM1+6cPHoxcjuWcojhgwsA/Dlbs+lrXbgzbcm6e2cdtRyfmKLq/2s34fH/pKxreJ6qtxIzy/n/BgOaHT9uJ6o1hY8Ebv/TqzwN+W1yXw4QH0b78IK2T026uV65qsCsF0m3TXSvXS6qX50BVTiqwQmmRf43KHw2+uDW4yYEbNzYMuA1MViQqiIgfNBBclSsTJVDcZsAF/uCHs5VnHryAQxS794Gw6dLcpKK85ZHikpKe6pX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eD08f3sF/0X56aLKafB+gBDIj5TSRc9C9kYN/Tqflk=;
 b=BzFJ0inqDbDowPrc5ISqQr+1KR56fm3gSGNlFpbbd637QnDLJHK5TVTbHLYaWjQhIFKT2bNCT+6PSwVlBkN5CFH3dRRH/ALwERTpsqju5MAeSvRqY7uRy9WTi8dl8JLJbWfVL4iX2bsJaiHzFvFaT4c2Lpo6q6DpKeODSrokqWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS6PR12MB765380.namprd12.prod.outlook.com (2603:10b6:8:411::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:06:04 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:06:04 +0000
Content-Type: multipart/alternative;
 boundary="------------kCgd35baixXSRtaZzFImBpps"
Message-ID: <2ec575e1-658a-4f05-9185-1c2283c5f522@amd.com>
Date: Tue, 1 Sep 2026 11:06:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: keep the userq manager alive as long as
 its queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-3-lingshan.zhu@amd.com>
 <18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com>
 <7f53ac18-ecb5-4eaa-8692-67b9237447b2@amd.com>
 <847308aa-e4cb-405f-9e9c-dda3e4d28eef@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <847308aa-e4cb-405f-9e9c-dda3e4d28eef@amd.com>
X-ClientProxiedBy: TY4P301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::19) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS6PR12MB765380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8674ac4c-0d96-41b4-8479-08df07d5f5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|18002099003|22082099003|11063799006|56012099006|8096899003|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: V7o8yz7j+vd9OjdZDSTUBG8n/ZOzI9n2mpfOQFljgdTSZAzOkuYT2wFwir8ovGrLmbV4+uslDQ41+P5kcaRm60hi/HDBCjlMypHh04IAcLlAyZsSHIwvZxmpsOJUCG9jWMBnZSlWK9qoEB/1AqCyNeooTK4dbjhrP15kzUGbohXdCvwjY5ZJvUU1wUMgLoXuFGKRHFwi3d/uiFHV3K+F0SMpvqdqzKEoXvYkuJHj5gz1QPjIUtg9FtW5RpwvqhpqhPQG34pROfA6ABatktFTVPU/xKUg+xB2+jm9QtOY3QZh+YJLU/9xRondVYzillmJcXKC5hBN3Ls+aQGdjsITJY5d2oAuQf+cLyaAliqqRtA2TbjGsOw1ffvJxYXZK3pvGW6b22OOw0AVZsIYeKXjRD7Lk6yepY0HEfseDDDsip6JvSLVnePU/rfLbeQWV+52wdg10Q/M1micdaOl9/xm2y8yysvJ6j05DTv0VTbEoZpoeZZW/fps+toveGN6ckaqeEy2IUQyzKDzf8fOZtIpHKtLyeM1jlolo44Ydzdof2lbwOG+qyl8sONWF2F9jntryv+jV4AODfbSZs7C/5LHERyalwbS5c2oi7FkD2v39U7xC+eger5qxKn/UmtEUU7mUWAzDRB8W2urFVVrFszowSA4GCYUQYpr/6tTboWotWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003)(5023799004)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWpRYm5UMjdhRXhjTkxUOXh4Q0JWTDAxL2RidUkxOG9EWnB0Wjc0Ujg3Kzh5?=
 =?utf-8?B?ZkVTWDdIeGlENGdJcEl6Mi84clo3YTk5eXYrOWlhU3dTNGJERnRFNTA1NU41?=
 =?utf-8?B?UUR3ZFBYUU9CTk1NcVVQZHNkSGtUMml1ZFlGZFVUU2VxNFFrbjBiNmhUN3V1?=
 =?utf-8?B?Q2Fzbnd2dFcyL3drbDRSK2w4S2dYUHpSZlpRQUQ3aEQyM3JCdzRXVXlKVUp0?=
 =?utf-8?B?YWowcUtBdmRLTVJGUEtUME5hQy9aQnFYWEx0aTgybFlCL0JnT2QrdENwbjY4?=
 =?utf-8?B?M090MnZNaDhYTWk0SDdIdzJnMWtkaytWS1lnMW1DNVhvOE1NaWc0WExlZlFR?=
 =?utf-8?B?VHN1WlRrVTF0RFI2bHU1R1FHdDR4QUhwb3o4dXl5elNrMUpDempRUkZoSzZz?=
 =?utf-8?B?QmFndXI0Q0NmWkZLbXNGYktTK3pyNms2UVhEZXpBYnV2UURoc2sxUVN1Z1dU?=
 =?utf-8?B?WkN5dHRLbXhlajdKQW5RKy9yRjVaQkw1dUxKRWlpNk1vS2FFTXk0STRwNG9j?=
 =?utf-8?B?OTVGcitCU0xqWUlNMmlmVTdFeU9YYWorVUloZ3hUb3JUYlB5cWlUZ1B3Tmdw?=
 =?utf-8?B?MUxObWR0Qzl3ZHpRMXlqdWVFUmJwaCsyMTNLMGFQNW5ZYm5lTkh5T1dxY1ly?=
 =?utf-8?B?VDBZdUJQRmk5enMyWm1Ic3hjSktEeG5EbXhNZ1E4NkFveVpXZktKT2E0MVIw?=
 =?utf-8?B?bWFZUVg4RmdQV3gwcHlHZERobENBSFBuSllNTklQeURiWmNqS0daZ0JLYzAz?=
 =?utf-8?B?T0pnV1IyS09IcWc1SmdaY2hWRzNRQUpTdWsvOU5XNWw5S3RXbEJJVFZpb3ky?=
 =?utf-8?B?WFJNVkNCZjh4Sm15M2duRERFaEdpMGFlZXJpWnV1ZjRvc2xPRlp1L2tjNzhG?=
 =?utf-8?B?SmJ2SEpxWlludUcyQ3hadVc0bURrdWRNaXhyVWpHVU94V3daeHYreHNKRnU5?=
 =?utf-8?B?YXhpVUFpQUJhTEFkNlUvY3hjQlUzNGFMeW56aUxMNEppZzlDSEN4NE9haUlJ?=
 =?utf-8?B?RUlFbEIxdVRxbXFFWWZEeTIxd3lubzlRblBZRlM1Y3d5RncxeEdqRWJkL25a?=
 =?utf-8?B?cHlRTEhGRk01RWQ1bWpZelNRUUZ6RGFHaXE4YW5aODYrT3U0WnVqMlUwR0cz?=
 =?utf-8?B?a2JJaFh0SUZKSlVLNnNuOW51bUhMeDA3M1hxNm5McDRKdVJUVzZic2kxRHEr?=
 =?utf-8?B?QXN6NnhNTVRHT0JkaFNUWXQzYTJ4ZUN0cEIyYzRWZC95ek9JR0lqWXdUempo?=
 =?utf-8?B?TWhnZmdNL21xY2cwRzlhYzd2ZlJWUUo0T0ZQd05mQ2dkRmc5ZG9tVmRweFUr?=
 =?utf-8?B?Yyt0UEdqZUVYQlo1VTdKWW8ybWZGRjl4RkIxYVg3NzEyQm0xM1JSLytiZEZD?=
 =?utf-8?B?WWpVdkw3YVRmbXhMNXc5Q3IwaGZzVDVlaHdiZU95MmszWkhIWlVqTkc2eUc3?=
 =?utf-8?B?SURSS2hSR0NuN3d2NUhaV3JWMnFhSk9hYVRiajR4bFJrQ0pMSzFWY29Cd3ll?=
 =?utf-8?B?Q1gwQWNxbjAyc04yekJTK0tYMnJpaWZCL0JMVG9rdXhRZDFKVEdpMXl4ekF6?=
 =?utf-8?B?cHpIbXEreUJCNHZLeE5uTjFpYnoxeS9XT0hnWmc5cFVwdUpMbUZpcGVUWjEv?=
 =?utf-8?B?Y2MvQ2NNODNuVWQ0YzBmRVB4U25kRFRhZzZscEZwYzdjUHh1RWJ6amZJT2tQ?=
 =?utf-8?B?R1IvWFVJMkhSTkhhdkhCaTNhaElxbkE5bmdzY3J1TVNDcTR4bXIvNWUzYkNQ?=
 =?utf-8?B?UFY2bGRpc1lTZ2N3cUg0eFFsVXh4dUhCTC9rWU5DT1NEekZtVzQ3d2l6L1lS?=
 =?utf-8?B?MEpiVkJ4N2xGNG9OVnYyMHU2cjdiNEtXVitCRDBNMEdhREV6N2MrQnhBRmpT?=
 =?utf-8?B?elh4WlQvaU9ITUZNM3ZEeWFrbzdIR21DamdwWVZTQjl2KzZ5SzA4RG9taVpt?=
 =?utf-8?B?ekh6R0Q2aHpKaDI5Q2IxakMxSUJSS1dqRkEwNFBTWkl0NEh5cjJIUWpITmZG?=
 =?utf-8?B?NUFpaFU4eTBHb25FV2dmRkg2OWpHWGx6UFovQzJUUUVHRGtxQWp5YVpId0ho?=
 =?utf-8?B?dUVFZkt1OEtnYnFQTkc0dG1BNWxoRnBHL0Z5Tzk3SmRUcUVETkxQU0ZwWUI0?=
 =?utf-8?B?eDdoa2oyQ2xQUmY2RHlGOEx2Rmc0YzE2SWY1RExlOFpROWk5Yldvdy9ieE9R?=
 =?utf-8?B?YVRSM3dpTTZEcWI3S0pwZ1FIN3h3SWljMDg5a2JINXdSNjQ4UTNYNmxXVGRR?=
 =?utf-8?B?YnpjcGgwaDd6NHpDZEV0MkxNN1R4bXFOY09QVUlQdm9jNE5nSGFrQTlHYUZy?=
 =?utf-8?B?UjJJbWg4T05IS29hajRmWE45UWtYeS9iZGJ1Z2NIV2VDampvK0J1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8674ac4c-0d96-41b4-8479-08df07d5f5a5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:06:04.3796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HR3Pi29kZB66SP/DXfsN1OrIGGJZXa585HUx5P14udB08rY3A/044dgqfAdJTEjL7Q4kJo2T80BrKqqzPjK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765380
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

--------------kCgd35baixXSRtaZzFImBpps
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/2026 12:26 AM, Christian König wrote:

> On 8/28/26 17:59, Zhu, Lingshan wrote:
>> On 8/28/2026 9:09 PM, Christian König wrote:
>>
>>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>>> The life cycle of a user queue is managed by its
>>>> kref. However when destroy a userq manager,
>>>> the kref_put of its queues in amdgpu_userq_mgr_fini
>>>> may not be the last put, therefore the queues
>>>> could be still alive after the userq manager
>>>> has been destroyed, resulting in
>>>> userq->userq_mgr use-after-free issues.
>>>>
>>>> This commit fixes this problem by introduce a new
>>>> counter refs representing for the number of its queues,
>>>> and only free the userq_manager when refs == 0
>>> Clear NAK to that one as well, this is just nonsense.
>> It could be better to have some explanations.
>>
>> I am not sure how to guarantee the put_kref in amdgpu_userq_mgr_fini
>> is the last put and result in kref == 0, if not the last one,
>> there can be userq->userq_mgr UAF bugs.
> The rules are actually pretty simple:
>
> The reference is for keeping the userq alive while IOCTLs happen. And IOCTL can only happen while the file and therefor the fpriv, userq_mgr etc... are still alive.
>
> What can potentially be is that we also need to grab a reference from a work item, but in this case the fpriv/userq_mgr cleanup functions just need to cancel and wait for the work to finish.
>
> There should *never* be a reference grabbed from interrupt context, explicitely because releasing that reference is also not possible from interrupt context. Instead xa_lock_irqsave() needs to be used to make sure that the userq stays alive while the interrupt processing happens.

To protect a user queue from unexpected free and use-after-free, we either use xa_lock or the kref. 
Please note, currently the xa lock can work only because the user queue destruction routine also acquires the xa lock, and this is not always true.

However in some code paths, none of kref or xa_lock are employed, for example, in mes_userq_reset_queue, its just xa_for_each, no locking, no kref.
That is the problem this series intends to fix (UAF issues, racing with the destroyer).

And I believe we should choose kref rather than xa lock, the reasons:
1) in some code paths, like  mes_userq_reset_queue, amdgpu_userq_stop_sched_for_enforce_isolation and amdgpu_userq_start_sched_for_enforce_isolation,
they all acquire a mutex, may sleep, so can not use xa lock in such routines
2) xa lock is for the XArray, it serializes the access to the queues, means when lock the xarray, only one thread can process one queue, it is a performance degradation.
3) xa lock is a spin lock, so don't hold it for long time while processing a queue.
4) since the struct kref is embedded in user queue, it introduces a new destruction process of the queue, which is invoked when kref == 0,
so we should take kref in every routine that process the queue to avoid UAF.

So this patch is a prepare for the following patches, after fixing the user queue UAF issues, there would be more code paths get and put the kref to protect the queues,
therefore, the put in amdgpu_userq_mgr_fini may not be the last put, and amdgpu_userq_mgr_fini destroys the userq manager, resulting in userq->userq_mgr use-after-free,
that is why we need this improvement.

Thanks
Lingshan

>
> Regards,
> Christian.
>
>> Thanks
>> Lingshan
>>
>>> Christian.
>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
>>>>  2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index e0639f844a8e..f398986a61a5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include <linux/pm_runtime.h>
>>>>  #include <linux/overflow.h>
>>>>  #include <drm/drm_drv.h>
>>>> +#include <linux/wait_bit.h>
>>>>  
>>>>  #include "amdgpu.h"
>>>>  #include "amdgpu_reset.h"
>>>> @@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>>  	return r;
>>>>  }
>>>>  
>>>> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +	atomic_inc(&uq_mgr->refs);
>>>> +}
>>>> +
>>>> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +	if (atomic_dec_and_test(&uq_mgr->refs))
>>>> +		wake_up_var(&uq_mgr->refs);
>>>> +}
>>>> +
>>>>  static int
>>>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>  {
>>>> @@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>>>>  	if (r)
>>>>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>> +
>>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>>  }
>>>>  
>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>>>> @@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>>>>  				fpriv->xcp_id : 0;
>>>>  	queue->userq_mgr = uq_mgr;
>>>> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>>>>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>>>  			  amdgpu_userq_hang_detect_work);
>>>>  
>>>> @@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>  free_queue:
>>>>  	trace_amdgpu_userq_create_end(queue, r);
>>>>  	kfree(queue);
>>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>>  err_pm_runtime:
>>>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>  	return r;
>>>> @@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>>>  {
>>>>  	mutex_init(&userq_mgr->userq_mutex);
>>>>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>>>> +	atomic_set(&userq_mgr->refs, 0);
>>>>  	userq_mgr->adev = adev;
>>>>  	userq_mgr->file = file_priv;
>>>>  	userq_mgr->proc_ctx_allocated = false;
>>>> @@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>  		amdgpu_userq_put(queue);
>>>>  	}
>>>>  
>>>> +	/*
>>>> +	 * The above amdgpu_userq_put() may not be the last put
>>>> +	 * of the kref of a user queue, therefore there could
>>>> +	 * be some queues still alive even when the userq manager
>>>> +	 * has been destroyed. This wait_evet() blocks
>>>> +	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
>>>> +	 * while any queues holding it.
>>>> +	 *
>>>> +	 * This prevents queue->userq_mgr use-after-free issues.
>>>> +	 */
>>>> +	wait_var_event(&userq_mgr->refs,
>>>> +		       !atomic_read_acquire(&userq_mgr->refs));
>>>> +
>>>>  	xa_destroy(&userq_mgr->userq_xa);
>>>>  
>>>>  	/*
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> index 8fc73862f64e..a13d8d4dd5c7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> @@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
>>>>  	 */
>>>>  	struct xarray			userq_xa;
>>>>  	struct mutex			userq_mutex;
>>>> +
>>>> +	/**
>>>> +	 * @refs:
>>>> +	 *
>>>> +	 * Each queue increases this counter when join this manager,
>>>> +	 * and decreases it when leave this manager.
>>>> +	 */
>>>> +	atomic_t			refs;
>>>> +
>>>>  	struct amdgpu_device		*adev;
>>>>  	struct delayed_work		resume_work;
>>>>  	struct drm_file			*file;
--------------kCgd35baixXSRtaZzFImBpps
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/29/2026 12:26 AM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:847308aa-e4cb-405f-9e9c-dda3e4d28eef@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/28/26 17:59, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 8/28/2026 9:09 PM, Christian König wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 8/28/26 11:53, Zhu Lingshan wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">The life cycle of a user queue is managed by its
kref. However when destroy a userq manager,
the kref_put of its queues in amdgpu_userq_mgr_fini
may not be the last put, therefore the queues
could be still alive after the userq manager
has been destroyed, resulting in
userq-&gt;userq_mgr use-after-free issues.

This commit fixes this problem by introduce a new
counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Clear NAK to that one as well, this is just nonsense.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
It could be better to have some explanations.

I am not sure how to guarantee the put_kref in amdgpu_userq_mgr_fini
is the last put and result in kref == 0, if not the last one,
there can be userq-&gt;userq_mgr UAF bugs.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The rules are actually pretty simple:

The reference is for keeping the userq alive while IOCTLs happen. And IOCTL can only happen while the file and therefor the fpriv, userq_mgr etc... are still alive.

What can potentially be is that we also need to grab a reference from a work item, but in this case the fpriv/userq_mgr cleanup functions just need to cancel and wait for the work to finish.

There should *never* be a reference grabbed from interrupt context, explicitely because releasing that reference is also not possible from interrupt context. Instead xa_lock_irqsave() needs to be used to make sure that the userq stays alive while the interrupt processing happens.</pre>
    </blockquote>
    <pre>To protect a user queue from unexpected free and use-after-free, we either use xa_lock or the kref. 
Please note, currently the xa lock can work only because the user queue destruction routine also acquires the xa lock, and this is not always true.

However in some code paths, none of kref or xa_lock are employed, for example, in mes_userq_reset_queue, its just xa_for_each, no locking, no kref.
That is the problem this series intends to fix (UAF issues, racing with the destroyer).

And I believe we should choose kref rather than xa lock, the reasons:
1) in some code paths, like  mes_userq_reset_queue, amdgpu_userq_stop_sched_for_enforce_isolation and amdgpu_userq_start_sched_for_enforce_isolation,
they all acquire a mutex, may sleep, so can not use xa lock in such routines
2) xa lock is for the XArray, it serializes the access to the queues, means when lock the xarray, only one thread can process one queue, it is a performance degradation.
3) xa lock is a spin lock, so don't hold it for long time while processing a queue.
4) since the struct kref is embedded in user queue, it introduces a new destruction process of the queue, which is invoked when kref == 0,
so we should take kref in every routine that process the queue to avoid UAF.

So this patch is a prepare for the following patches, after fixing the user queue UAF issues, there would be more code paths get and put the kref to protect the queues,
therefore, the put in amdgpu_userq_mgr_fini may not be the last put, and amdgpu_userq_mgr_fini destroys the userq manager, resulting in userq-&gt;userq_mgr use-after-free,
that is why we need this improvement.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:847308aa-e4cb-405f-9e9c-dda3e4d28eef@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks
Lingshan

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Christian.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e0639f844a8e..f398986a61a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -27,6 +27,7 @@
 #include &lt;linux/pm_runtime.h&gt;
 #include &lt;linux/overflow.h&gt;
 #include &lt;drm/drm_drv.h&gt;
+#include &lt;linux/wait_bit.h&gt;
 
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_reset.h&quot;
@@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	atomic_inc(&amp;uq_mgr-&gt;refs);
+}
+
+static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	if (atomic_dec_and_test(&amp;uq_mgr-&gt;refs))
+		wake_up_var(&amp;uq_mgr-&gt;refs);
+}
+
 static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	r = amdgpu_userq_destroy(uq_mgr, queue);
 	if (r)
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to destroy usermode queue %d\n&quot;, r);
+
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
@@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue-&gt;xcp_id = (fpriv-&gt;xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv-&gt;xcp_id : 0;
 	queue-&gt;userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&amp;queue-&gt;hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 	return r;
@@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&amp;userq_mgr-&gt;userq_mutex);
 	xa_init_flags(&amp;userq_mgr-&gt;userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&amp;userq_mgr-&gt;refs, 0);
 	userq_mgr-&gt;adev = adev;
 	userq_mgr-&gt;file = file_priv;
 	userq_mgr-&gt;proc_ctx_allocated = false;
@@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_put(queue);
 	}
 
+	/*
+	 * The above amdgpu_userq_put() may not be the last put
+	 * of the kref of a user queue, therefore there could
+	 * be some queues still alive even when the userq manager
+	 * has been destroyed. This wait_evet() blocks
+	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
+	 * while any queues holding it.
+	 *
+	 * This prevents queue-&gt;userq_mgr use-after-free issues.
+	 */
+	wait_var_event(&amp;userq_mgr-&gt;refs,
+		       !atomic_read_acquire(&amp;userq_mgr-&gt;refs));
+
 	xa_destroy(&amp;userq_mgr-&gt;userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8fc73862f64e..a13d8d4dd5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
 	 */
 	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
+
+	/**
+	 * @refs:
+	 *
+	 * Each queue increases this counter when join this manager,
+	 * and decreases it when leave this manager.
+	 */
+	atomic_t			refs;
+
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------kCgd35baixXSRtaZzFImBpps--
