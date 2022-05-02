Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5804C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 05:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5A510F6C2;
	Mon,  2 May 2022 05:57:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A098F10F694
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 05:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJVlSvyg3tZ0IHn1ytVZyRXwb3s4uVjtwwZS67UiLcvgzYO7WkkwBB/I83n0XRtgfLfQYx/rb9MceutpdviCKFHxKPeOsa8alUIOhUIeK4SOmMmVAJXOVc86J1sYANINKZGRgpHNfCTfVeTc0sNYD4Xkitnx1VcWCxzOd3Q14OSN7hCqbcyztuWyc2gdecflMP7IFzjbExmQ4iATq+6PjKP6qaA94+qrTUQNlVSKepSRWY4HSa08yIjybT0HygEvegto3nmrXWx5Y7/JOof4ycaFss0d5MoBv+qP7yDOTOsP9304yDOaaktBQABFlaNFDiK5yxrg/eM/svp3MKsr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+yUoESI63FutpM3ZmKnFigmsQqZn9SDyH301Wq/q4M=;
 b=XDJHEstoZCamOdKN2NJsXtYg4fRhGGTJT2bzjaAkBFeeB/5vbDqddCgMo2BBsFjpJsh3Cr1SmFWj7Fh8y17eisa4gX7SxJz9+3i+Rc7qYgfTGQuOOgbxYCCcZJqrCIJuaRC7DgrO690DDRzRr3lJfwcNTH0IV+qUOoIXEqtLjbBMAEZeZPkZsoEDzoH8k+OVI14+AGg1pAuJaT3rDJItU5Bh5aAeOLegdm4vMlVAaFWi1V78w4hJRpJLhYrKA5pStQiDXtLjaMPUofmdpW/xx8a9uwD0x96ypd0do4XtiPn+ene/kFL/gJD6/B2AjkJR5ZdLPTQ5v6+u/Zwky0+32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+yUoESI63FutpM3ZmKnFigmsQqZn9SDyH301Wq/q4M=;
 b=EE+qnQ9WUwXAv1BkBPP3gP3IzZ5bqkqA4WcktKnSS8mdA+Nmi+WlA1HQhLMzA+Rc9j+US/fA8e9nOA7wp4g5V47GbmKH3l6DRZz8MqjrQc6IisjV5CIN3RFAaGnJO0YaUwQzGxRiGVOEtvLBr61SEyYG+vq8UVz/jNUqMsPFAuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 05:56:56 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 05:56:54 +0000
Content-Type: multipart/alternative;
 boundary="------------Wn7Y6uzoue37ph553VFF5Vb0"
Message-ID: <54568104-c607-eb76-6c20-67e91baec00f@amd.com>
Date: Mon, 2 May 2022 07:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Add out parameters to drm_amdgpu_sched
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
 <85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com>
 <b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com>
X-ClientProxiedBy: AS8PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a350f13c-4d7d-4b64-7177-08da2c008f50
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5218E7ADF7FFFB7CFC6BE75C83C19@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvJztLtq0PGeG38fn0OXCWq13wvuWTpJkPzXlqjj6CONmQEChAIFQxK+OproGuY3suwgSHjfQPGC3UQI8MPGHjNvvA3OYGq1QfnVIZBV+KCSWEr6vw8gupsRBbZUcMm0tku16BdKtjEznRqhLarIe8yaxFCf03DukFRLJWbb2INRqeC2+noTPNFOL5Iz1rxVnx85InXPToGCThDHUl/4OfyhUFCxxGvkKlWy/p/Ilwq/ydoiWv+MXakx+3j9F4YOEpXh6jTTvjjcKYh3gXhjck5rDk8OOl2+NDElDI8txnZJsy/Jx01K4pbFJ2nGuiUnBNu8TPtrBUB+/UKW9TsRk74XTEgyCM0z4YuqdFYifoc2Yg5Vm81ZQw8CygUDP/4CaFL/ZP1Mltnzkj+8SQbm/Rs+pl2nrHNdVOo5EdZQYFrIXXOzMVGwR3n4Rrfv+t9YNODqxVuBcBs/elRQMSSUbbxqYI7aB8kfSrt4sgcvjRrNof+Q5auba/+nlFU1iGfFyKsLE9VxMHYLHTvtAztp68ssdCGTeCCFGJAtBGo4Lzdc/f0/cq2a7R39pRSV34CeUT6yJK+/WKwJRX39bjI60Y/OV6bDnnwETl/Var3M82NdnJFLHmAc+oRYBEiABvEESZQkAkRJK6nKRp4G0BURtFdwaPyZeanfUs6wgwOF7JPbim5+I1+x9rnap31G7E1o4GIC+jpFRfHbg2wmV5Rr6ifu9yMlQHBKPdj9dP98fws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(33964004)(26005)(66476007)(53546011)(2616005)(66946007)(66556008)(6512007)(110136005)(966005)(6486002)(316002)(45080400002)(86362001)(508600001)(31696002)(166002)(6506007)(83380400001)(186003)(38100700002)(66574015)(30864003)(2906002)(31686004)(4326008)(8936002)(36756003)(5660300002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5TQ3M4SHlqSEVST0NBYzhib1hZQjgzNjhyc1FrMWgzSitKeE8rNjBwSTVl?=
 =?utf-8?B?Y1FUMVNlNXFWaTByYzIyVTM0UzN2bWlEWnltKzNyMHRITXIyZy9LRzhINkU3?=
 =?utf-8?B?anhZWXZXZFlLd1ZKUi8vU090eXpGWHFjYk1vUDJ6bjV6ekIxcWhpODZKcUR5?=
 =?utf-8?B?SmZtOWIvZ1puVTNScFlwcHZtVytxcFdtMlRnQjFmNVc1ZXl5WXVObTVVL3pL?=
 =?utf-8?B?U1V6dU14MHcxc2UrVWpUOXBrWkJibi9jR2hXM1M5NFBUWjhtWk1TVVh4MVFL?=
 =?utf-8?B?MHJWVXpTUks2ZDhZZkUxd3hFL0ZMWmk5OFQydHE5ZFMrVUJHNUg0NmlHZFJR?=
 =?utf-8?B?WlJMdUc3QkpNZ3dFcytESC9xK2dYSm9McFp5MS9KTTd3azhqekhqenpZVnNM?=
 =?utf-8?B?OG42VE4yRUdnd3BqbXZTaW9MOUFVamNvMXhvMGtOTXQvbm0xbmsvYVNWVWw3?=
 =?utf-8?B?cS9icGNnV3lPblNma1lMZVIraENNcVRIWUNWbjFWRytFS1pub3JBeXhpLzBZ?=
 =?utf-8?B?QVZEeE9HaUhLNExJZVFxK2RKWHFsYmpXZ2tDeURzSEE4QnUrVzZMTG5WTUti?=
 =?utf-8?B?REh4TzFzOXVONWhzU0tBbE15U0Jvay84a0NtVnpBTi9KZGI5V1BCU0lnMi9u?=
 =?utf-8?B?dExoc2V5WjVPTEZSTG81aGV0WDRIbCszc3AwNWhVOTFkUXNwNFUzVktJdkto?=
 =?utf-8?B?SFJ5enRYY2VCWENGWnBwTVQwNEpJMm9pQ1Y1aVVhM0VEbUdZSzgyUis2Ujdx?=
 =?utf-8?B?SitBaUJnRTQ2V1B6ZzlGQnNGWWR6cDdhdjNhWlFlTzA4cTB0N3I4SUVlY0dQ?=
 =?utf-8?B?b2FSSEtzbXpXMmVVY01uQlRMWitGYjBXUFQzMGtqaUJBWVpobG80TVVrcVdZ?=
 =?utf-8?B?ZWtPdm5JRWF3MEZ2Q0FjRmRQTXFieTVBK2lnVDduWG8zWmt5QmJ5NUNLQWdx?=
 =?utf-8?B?Yms4NWpMOEJTMm5wQWdIYVNTa1NlR0dWWC9sWUFHQUJRbEUrWTBQYmp4NzZG?=
 =?utf-8?B?S0k5L0FIOXM0UkNML01JUWRDMENYMEdRbU13emR1ZWd0TVJlVUc1SFRneE9E?=
 =?utf-8?B?NENBdXJSM09hSzRlR21uQ2pHczJwalV3dUVhcDlldGVGZFFSY2szalBTZ08z?=
 =?utf-8?B?cm9CM2pmOTl6UjFvbVgyTEphTzRuVURXd2wvRHZMSUhIQkVMa2ttNUhQN1BD?=
 =?utf-8?B?TWFWSW94TzJ3LzB1aUkwbTlLYU9pOS9pRDNnUHNsS3Z2d1A2SWVwWVgxOXZH?=
 =?utf-8?B?L0tLU05vWG9OWlI3d1RpMloyRzNEdWdLT3piS20zYTNrL0Z6RXo3QkMyS3R2?=
 =?utf-8?B?dVlyYXIwVjN5SGtDdXFlcFN3QmZtdVl1SkZVd3BkRE8zbXl3cm5UOURJczFl?=
 =?utf-8?B?dmR2ZndNYVZJcnZzNGtNTmFiQzVRS1Rkd1NweGhGZVJINGdoM0dIdCttQzdk?=
 =?utf-8?B?NkQ3OE9SNldaOWhaelFURm1SUldUcEdSS2svOURaL0dWY2RLaUhhQ3NYUG1i?=
 =?utf-8?B?ZW12NGt4MDVkZXF5alNGQ1JiOWFTTWVJOVFveVYwMFVCbnVnenJ6WVkvZWIz?=
 =?utf-8?B?WlB4TERPYWsvR3BHT0pRSWE3QVpwQzBCTTM4cGxwRC91QXIzMTY3M0RNdWps?=
 =?utf-8?B?VnUxek5YMjJTYTlZRmdkeVhONmJMYjlWNmIyd0F3YXRZWjVFdEZCNTdjOEg1?=
 =?utf-8?B?cnpkSGdxc3dwSkR2am5hUDhCK3lwRkliSkNnYzJKTFdKOGRCVGNPTlBRZitN?=
 =?utf-8?B?VGZGVllqY1NjbzhOL0E5akxuK0ZMamFLNmg2Rlc1UUdzMnZsSEJMc2FZemhz?=
 =?utf-8?B?NWFsVis2ckpvYzRVZjFvYjQwN3Q5ajRRa2Q0WFU0djRHdE1wRDk3bVNrVkU1?=
 =?utf-8?B?MGw5SC85OFFGalJjMy8yQjg1ZlpsYlRuR2oxRjM1UEpWbEh1c0pXQzRjbnRq?=
 =?utf-8?B?L1ZRUGowdFpWR0dic3F2bStHSThoRFMvMHhHUU5CWHk1eitVcWdXYW9UYjBm?=
 =?utf-8?B?TDVYRGI4WkVXWVdNVUF6R1lGRDZNYzVCcVFzZWE2TzNOTjRQb1I0dzcxcDZa?=
 =?utf-8?B?NFlmajVZWHovY2hUUFdpQVR2ZEJsWFZjWXRMYVYydnlNbkNRbWtTbmQwMHU1?=
 =?utf-8?B?R2NzZHJzTDNOVEtiUCs5bVBaYytGVnBERXNhZHpCMEpYbitkUDdQbEYvUVhs?=
 =?utf-8?B?WmVzTWlVVmRRMzEwZ3BISDQ1NFpJUlNUZFZaOVk4eWhld1N3TThteDFMZDZs?=
 =?utf-8?B?MmhleHpRTlJKeDdzN1ZPbmpTNU4zaWdrbUIyZm12Mk4xWjJUUDI0ZGFydVNX?=
 =?utf-8?B?cXhCWFBwaUxQdmc4TG4wYW1XUjdzZUVWSnBhcFJQVGNLQTNrR2Ixdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a350f13c-4d7d-4b64-7177-08da2c008f50
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 05:56:54.4257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fop8ERnNmhR8lj4jz37xgfi14Qgk8r53CYwqzWDVdRkM7wo6l6YD1o8BEKif506w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------Wn7Y6uzoue37ph553VFF5Vb0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.05.22 um 21:45 schrieb Arunpravin Paneer Selvam:
>
> On 5/1/2022 12:59 AM, Christian König wrote:
>> Am 30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>>> - Add pipe and queue as out parameters to support high priority
>>>    queue test enabled in libdrm basic test suite.
>>>
>>> - Fetch amdgpu_ring pointer and pass sched info to userspace
>>>
>>> - Improve amdgpu_sched_ioctl() function
>>>
>>> The related merge request for enabling high priority test case are
>>> libdrm - 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4IosJc%3D&amp;reserved=0
>>> mesa - 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CPEy3JIhFMCjqwiY%3D&amp;reserved=0
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> Well that is certainly a NAK since as far as I can see this breaks 
>> the UAPI in a not backward compatible way.
>>
>> Then we absolutely should not pass scheduler info to userspace. That 
>> should be completely transparent to userspace.
>>
>> So can you summarize once more why that should be necessary?
> I added a new test case named high priority queue test in libdrm basic 
> test suite to validate the kernel feature patch named
> high priority gfx pipe. In the test case, we are creating a context 
> and overriding the priority as HIGH, submitting a simple NOP
> command to test the job scheduled on high priority pipe / queue. This 
> we have manually verified using the sysfs entry
> amdgpu_fence_info where fence signaled on gfx high priority pipe 
> (gfx_0.1.0). To ensure this in a unit test case, we require
> pipe and queue info.

Completely drop that requirement, it's not even remotely valid 
justification for an UAPI change.

The IOCTLs are for supporting userspace APIs like OpenGL, Vulkan, VA-API 
etc.. and *not* unit tests.

If you need additional information for unit tests we need to add that to 
debugfs instead and as you wrote we already have that in the form of the 
amdgpu_fence_info file.

Regards,
Christian.

>
> Thanks,
> Arun
>>
>> Regards,
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114 
>>> ++++++++--------------
>>>   include/uapi/drm/amdgpu_drm.h             |  14 ++-
>>>   2 files changed, 53 insertions(+), 75 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> index e9b45089a28a..fc2864b612d9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> @@ -32,106 +32,72 @@
>>>   #include "amdgpu_sched.h"
>>>   #include "amdgpu_vm.h"
>>>   -static int amdgpu_sched_process_priority_override(struct 
>>> amdgpu_device *adev,
>>> -                          int fd,
>>> -                          int32_t priority)
>>> +int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>>> +               struct drm_file *filp)
>>>   {
>>> -    struct fd f = fdget(fd);
>>> +    union drm_amdgpu_sched *args = data;
>>> +    struct amdgpu_ctx *ctx, *ctx_ptr;
>>> +    struct drm_sched_entity *entity;
>>>       struct amdgpu_fpriv *fpriv;
>>> -    struct amdgpu_ctx *ctx;
>>> -    uint32_t id;
>>> -    int r;
>>> -
>>> -    if (!f.file)
>>> -        return -EINVAL;
>>> -
>>> -    r = amdgpu_file_to_fpriv(f.file, &fpriv);
>>> -    if (r) {
>>> -        fdput(f);
>>> -        return r;
>>> -    }
>>> -
>>> -    idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
>>> -        amdgpu_ctx_priority_override(ctx, priority);
>>> -
>>> -    fdput(f);
>>> -    return 0;
>>> -}
>>> -
>>> -static int amdgpu_sched_context_priority_override(struct 
>>> amdgpu_device *adev,
>>> -                          int fd,
>>> -                          unsigned ctx_id,
>>> -                          int32_t priority)
>>> -{
>>> +    struct amdgpu_ring *ring;
>>> +    u32 fd = args->in.fd;
>>>       struct fd f = fdget(fd);
>>> -    struct amdgpu_fpriv *fpriv;
>>> -    struct amdgpu_ctx *ctx;
>>> +    u32 id;
>>>       int r;
>>>         if (!f.file)
>>>           return -EINVAL;
>>>         r = amdgpu_file_to_fpriv(f.file, &fpriv);
>>> -    if (r) {
>>> -        fdput(f);
>>> -        return r;
>>> -    }
>>> +    if (r)
>>> +        goto out_fd;
>>>   -    ctx = amdgpu_ctx_get(fpriv, ctx_id);
>>> +    ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>>         if (!ctx) {
>>> -        fdput(f);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    amdgpu_ctx_priority_override(ctx, priority);
>>> -    amdgpu_ctx_put(ctx);
>>> -    fdput(f);
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>>> -               struct drm_file *filp)
>>> -{
>>> -    union drm_amdgpu_sched *args = data;
>>> -    struct amdgpu_device *adev = drm_to_adev(dev);
>>> -    int r;
>>> -
>>> -    /* First check the op, then the op's argument.
>>> -     */
>>> -    switch (args->in.op) {
>>> -    case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>> -    case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>> -        break;
>>> -    default:
>>> -        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>>> -        return -EINVAL;
>>> +        r = -EINVAL;
>>> +        goto out_fd;
>>>       }
>>>         if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>>>           WARN(1, "Invalid context priority %d\n", args->in.priority);
>>> -        return -EINVAL;
>>> +        r = -EINVAL;
>>> +        goto out_ctx;
>>>       }
>>>         switch (args->in.op) {
>>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>> -        r = amdgpu_sched_process_priority_override(adev,
>>> -                               args->in.fd,
>>> -                               args->in.priority);
>>> +        /* Retrieve all ctx handles and override priority  */
>>> + idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx_ptr, id)
>>> +            amdgpu_ctx_priority_override(ctx_ptr, args->in.priority);
>>>           break;
>>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>> -        r = amdgpu_sched_context_priority_override(adev,
>>> -                               args->in.fd,
>>> -                               args->in.ctx_id,
>>> -                               args->in.priority);
>>> +        /* Override priority for a given context */
>>> +        amdgpu_ctx_priority_override(ctx, args->in.priority);
>>>           break;
>>>       default:
>>> -        /* Impossible.
>>> -         */
>>> +        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>>>           r = -EINVAL;
>>> -        break;
>>> +        goto out_ctx;
>>>       }
>>>   +    r = amdgpu_ctx_get_entity(ctx, args->in.ip_type, 0, 
>>> args->in.ring,
>>> +                  &entity);
>>> +    if (r)
>>> +        goto out_ctx;
>>> +
>>> +    /* Fetch amdgpu_ring pointer */
>>> +    ring = to_amdgpu_ring(entity->rq->sched);
>>> +
>>> +    /* Pass sched info to userspace */
>>> +    memset(args, 0, sizeof(*args));
>>> +    args->out.info.pipe = ring->pipe;
>>> +    args->out.info.queue = ring->queue;
>>> +
>>> +out_ctx:
>>> +    amdgpu_ctx_put(ctx);
>>> +out_fd:
>>> +    fdput(f);
>>> +
>>>       return r;
>>>   }
>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index 1d65c1fbc4ec..e93f1b6c4561 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -70,7 +70,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_WAIT_FENCES DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
>>>   #define DRM_IOCTL_AMDGPU_VM        DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE 
>>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>> -#define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>> +#define DRM_IOCTL_AMDGPU_SCHED DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>     /**
>>>    * DOC: memory domains
>>> @@ -308,6 +308,11 @@ union drm_amdgpu_vm {
>>>   #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE    1
>>>   #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE    2
>>>   +struct drm_amdgpu_sched_info {
>>> +    __u32 pipe;
>>> +    __u32 queue;
>>> +};
>>> +
>>>   struct drm_amdgpu_sched_in {
>>>       /* AMDGPU_SCHED_OP_* */
>>>       __u32    op;
>>> @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in {
>>>       /** AMDGPU_CTX_PRIORITY_* */
>>>       __s32    priority;
>>>       __u32   ctx_id;
>>> +    __u32   ip_type;
>>> +    __u32   ring;
>>> +};
>>> +
>>> +struct drm_amdgpu_sched_out {
>>> +    struct drm_amdgpu_sched_info info;
>>>   };
>>>     union drm_amdgpu_sched {
>>>       struct drm_amdgpu_sched_in in;
>>> +    struct drm_amdgpu_sched_out out;
>>>   };
>>>     /*
>>
>

--------------Wn7Y6uzoue37ph553VFF5Vb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 01.05.22 um 21:45 schrieb Arunpravin Paneer Selvam:<br>
    <blockquote type="cite" cite="mid:b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com">
      
      <br>
      On 5/1/2022 12:59 AM, Christian König wrote:<br>
      <blockquote type="cite" cite="mid:85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com">Am
        30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam: <br>
        <blockquote type="cite">- Add pipe and queue as out parameters
          to support high priority <br>
          &nbsp;&nbsp; queue test enabled in libdrm basic test suite. <br>
          <br>
          - Fetch amdgpu_ring pointer and pass sched info to userspace <br>
          <br>
          - Improve amdgpu_sched_ioctl() function <br>
          <br>
          The related merge request for enabling high priority test case
          are <br>
          libdrm -
          <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4IosJc%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4I
 osJc%3D&amp;amp;reserved=0</a><br>
          mesa -
          <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CPEy3JIhFMCjqwiY%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CP
 Ey3JIhFMCjqwiY%3D&amp;amp;reserved=0</a><br>
          <br>
          Signed-off-by: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com" moz-do-not-send="true">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
          <br>
        </blockquote>
        <br>
        Well that is certainly a NAK since as far as I can see this
        breaks the UAPI in a not backward compatible way. <br>
        <br>
        Then we absolutely should not pass scheduler info to userspace.
        That should be completely transparent to userspace. <br>
        <br>
        So can you summarize once more why that should be necessary?<br>
      </blockquote>
      I added a new test case named high priority queue test in libdrm
      basic test suite to validate the kernel feature patch named<br>
      <span style="mso-spacerun:yes"></span>high priority gfx pipe. In
      the test case, we are creating a context and overriding the
      priority as HIGH, submitting a simple NOP<br>
      command to test the job scheduled on high priority pipe / queue.
      This we have manually verified using the sysfs entry<br>
      amdgpu_fence_info where fence signaled on gfx high priority pipe
      (gfx_0.1.0). To ensure this in a unit test case, we require<br>
      pipe and queue info.<br>
    </blockquote>
    <br>
    Completely drop that requirement, it's not even remotely valid
    justification for an UAPI change.<br>
    <br>
    The IOCTLs are for supporting userspace APIs like OpenGL, Vulkan,
    VA-API etc.. and *not* unit tests.<br>
    <br>
    If you need additional information for unit tests we need to add
    that to debugfs instead and as you wrote we already have that in the
    form of the amdgpu_fence_info file.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com"> <br>
      Thanks,<br>
      Arun<br>
      <blockquote type="cite" cite="mid:85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com"> <br>
        Regards, <br>
        Christian. <br>
        <br>
        <blockquote type="cite">--- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114
          ++++++++-------------- <br>
          &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 ++- <br>
          &nbsp; 2 files changed, 53 insertions(+), 75 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
          index e9b45089a28a..fc2864b612d9 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c <br>
          @@ -32,106 +32,72 @@ <br>
          &nbsp; #include &quot;amdgpu_sched.h&quot; <br>
          &nbsp; #include &quot;amdgpu_vm.h&quot; <br>
          &nbsp; -static int amdgpu_sched_process_priority_override(struct
          amdgpu_device *adev, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t priority) <br>
          +int amdgpu_sched_ioctl(struct drm_device *dev, void *data, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *filp) <br>
          &nbsp; { <br>
          -&nbsp;&nbsp;&nbsp; struct fd f = fdget(fd); <br>
          +&nbsp;&nbsp;&nbsp; union drm_amdgpu_sched *args = data; <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx, *ctx_ptr; <br>
          +&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv; <br>
          -&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx; <br>
          -&nbsp;&nbsp;&nbsp; uint32_t id; <br>
          -&nbsp;&nbsp;&nbsp; int r; <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; if (!f.file) <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; r = amdgpu_file_to_fpriv(f.file, &amp;fpriv); <br>
          -&nbsp;&nbsp;&nbsp; if (r) { <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
          -&nbsp;&nbsp;&nbsp; } <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; idr_for_each_entry(&amp;fpriv-&gt;ctx_mgr.ctx_handles,
          ctx, id) <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx, priority); <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; fdput(f); <br>
          -&nbsp;&nbsp;&nbsp; return 0; <br>
          -} <br>
          - <br>
          -static int amdgpu_sched_context_priority_override(struct
          amdgpu_device *adev, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned ctx_id, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t priority) <br>
          -{ <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring; <br>
          +&nbsp;&nbsp;&nbsp; u32 fd = args-&gt;in.fd; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fd f = fdget(fd); <br>
          -&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv; <br>
          -&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx; <br>
          +&nbsp;&nbsp;&nbsp; u32 id; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f.file) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_file_to_fpriv(f.file, &amp;fpriv); <br>
          -&nbsp;&nbsp;&nbsp; if (r) { <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
          -&nbsp;&nbsp;&nbsp; } <br>
          +&nbsp;&nbsp;&nbsp; if (r) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_fd; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; ctx = amdgpu_ctx_get(fpriv, ctx_id); <br>
          +&nbsp;&nbsp;&nbsp; ctx = amdgpu_ctx_get(fpriv, args-&gt;in.ctx_id); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx) { <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdput(f); <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          -&nbsp;&nbsp;&nbsp; } <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx, priority); <br>
          -&nbsp;&nbsp;&nbsp; amdgpu_ctx_put(ctx); <br>
          -&nbsp;&nbsp;&nbsp; fdput(f); <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; return 0; <br>
          -} <br>
          - <br>
          -int amdgpu_sched_ioctl(struct drm_device *dev, void *data, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *filp) <br>
          -{ <br>
          -&nbsp;&nbsp;&nbsp; union drm_amdgpu_sched *args = data; <br>
          -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = drm_to_adev(dev); <br>
          -&nbsp;&nbsp;&nbsp; int r; <br>
          - <br>
          -&nbsp;&nbsp;&nbsp; /* First check the op, then the op's argument. <br>
          -&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          -&nbsp;&nbsp;&nbsp; switch (args-&gt;in.op) { <br>
          -&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE: <br>
          -&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE: <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
          -&nbsp;&nbsp;&nbsp; default: <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid sched op specified: %d\n&quot;,
          args-&gt;in.op); <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_fd; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (!amdgpu_ctx_priority_is_valid(args-&gt;in.priority)) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Invalid context priority %d\n&quot;,
          args-&gt;in.priority); <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (args-&gt;in.op) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE: <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_sched_process_priority_override(adev, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.fd, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.priority); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Retrieve all ctx handles and override priority&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          idr_for_each_entry(&amp;fpriv-&gt;ctx_mgr.ctx_handles,
          ctx_ptr, id) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx_ptr,
          args-&gt;in.priority); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE: <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_sched_context_priority_override(adev, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.fd, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.ctx_id, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.priority); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Override priority for a given context */ <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ctx_priority_override(ctx,
          args-&gt;in.priority); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default: <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Impossible. <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid sched op specified: %d\n&quot;,
          args-&gt;in.op); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; r = amdgpu_ctx_get_entity(ctx, args-&gt;in.ip_type, 0,
          args-&gt;in.ring, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;entity); <br>
          +&nbsp;&nbsp;&nbsp; if (r) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_ctx; <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; /* Fetch amdgpu_ring pointer */ <br>
          +&nbsp;&nbsp;&nbsp; ring = to_amdgpu_ring(entity-&gt;rq-&gt;sched); <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; /* Pass sched info to userspace */ <br>
          +&nbsp;&nbsp;&nbsp; memset(args, 0, sizeof(*args)); <br>
          +&nbsp;&nbsp;&nbsp; args-&gt;out.info.pipe = ring-&gt;pipe; <br>
          +&nbsp;&nbsp;&nbsp; args-&gt;out.info.queue = ring-&gt;queue; <br>
          + <br>
          +out_ctx: <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_ctx_put(ctx); <br>
          +out_fd: <br>
          +&nbsp;&nbsp;&nbsp; fdput(f); <br>
          + <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
          &nbsp; } <br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h <br>
          index 1d65c1fbc4ec..e93f1b6c4561 100644 <br>
          --- a/include/uapi/drm/amdgpu_drm.h <br>
          +++ b/include/uapi/drm/amdgpu_drm.h <br>
          @@ -70,7 +70,7 @@ extern &quot;C&quot; { <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_WAIT_FENCES&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union
          drm_amdgpu_wait_fences) <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_VM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE
          + DRM_AMDGPU_VM, union drm_amdgpu_vm) <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union
          drm_amdgpu_fence_to_handle) <br>
          -#define DRM_IOCTL_AMDGPU_SCHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union
          drm_amdgpu_sched) <br>
          +#define DRM_IOCTL_AMDGPU_SCHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union
          drm_amdgpu_sched) <br>
          &nbsp; &nbsp; /** <br>
          &nbsp;&nbsp; * DOC: memory domains <br>
          @@ -308,6 +308,11 @@ union drm_amdgpu_vm { <br>
          &nbsp; #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE&nbsp;&nbsp;&nbsp; 1 <br>
          &nbsp; #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE&nbsp;&nbsp;&nbsp; 2 <br>
          &nbsp; +struct drm_amdgpu_sched_info { <br>
          +&nbsp;&nbsp;&nbsp; __u32 pipe; <br>
          +&nbsp;&nbsp;&nbsp; __u32 queue; <br>
          +}; <br>
          + <br>
          &nbsp; struct drm_amdgpu_sched_in { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_SCHED_OP_* */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp;&nbsp; op; <br>
          @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** AMDGPU_CTX_PRIORITY_* */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __s32&nbsp;&nbsp;&nbsp; priority; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ctx_id; <br>
          +&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ip_type; <br>
          +&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; ring; <br>
          +}; <br>
          + <br>
          +struct drm_amdgpu_sched_out { <br>
          +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_info info; <br>
          &nbsp; }; <br>
          &nbsp; &nbsp; union drm_amdgpu_sched { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_in in; <br>
          +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_sched_out out; <br>
          &nbsp; }; <br>
          &nbsp; &nbsp; /* <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------Wn7Y6uzoue37ph553VFF5Vb0--
