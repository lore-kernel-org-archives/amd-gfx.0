Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 02:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5071F6109D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 02:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5071F6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F166E215;
	Tue, 26 Oct 2021 02:57:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9132E6E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 02:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfrqzATMN1dmRLkHQBX2eSb/LSsibPrCQYrSh4ngL1SkzQMCjrL285JGbPtRrdSlYdtCPv1rCfWAEPrAv/NLjdRNfAuNGhc9KSQu+pz5m6ImAhxsv6gRVSvOKxBWcMDT12bQpitRgLKxJzeMVY7/mB/9754Y3SM/hfw7L4y7DpKgLLFQCtnc98rWgoD7sTb1AUqgtbebit/zEvLda7MQ3pkCwSNL+G8TWApt6kiRR7emwc40NpBdtX80tYBjqRxW8XNjsVD/StarT8W3dvHZEg8449juHqc1UulYVNQhjGWQ1rrscNm/cu7T1XZGvuY5Jenwk9HrdGNeef+gafSgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/VqRxmBxnUYLSXSadI95iWlCMYp78ldmoE7lRQDDLk=;
 b=l0zNl79AijMnDC+o3MM3DpxEUm7TCyHm/YStkdG30ohtQWevnKPiFt1Sbxj0lBJ2v+IyDemEgt8rnW83ayCwjFpgGGYMEP5U3MTZyl7AJVoStoNkWb+l8iA+H8raxT1gXV/+0XWxagNh/v853dFnui2FdAAApmyVVHQ8m4rwGq+r2MrJGXuR/mo+CT5NmuFL0x00G9997fTK5JkAQfKd/i3CyFKVZZS1fVpZMXslCwsS0d4KMbVr0G7VlP0/9hyUMgPlZf9jvbRP4X5FIkcXk7SaYiEz/FRwC3nuVKaqh3YyJvvy/1AoQ0QsVrP14BOUEB49lp7MhOht5x7QUuaIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/VqRxmBxnUYLSXSadI95iWlCMYp78ldmoE7lRQDDLk=;
 b=sWlFjrKDCgeV1iFrFwqZaxFBVXIP62RTSdlwT26yrEHEoWHrKp7HKd5ZFNNGk8wzCB35ZS09dzPeT0v0n14ojqQypLZ691yJS94bKFCKF2WO8sP/1/hukYF+p45y/ylwlM69WTtTmQ/psbQyTRGzaXIYblyaUIhGEeUsBHCxiKU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 02:57:15 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 02:57:15 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, jingwen.chen2@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
 <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
 <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <9df71fc3-9862-59c0-56d6-9e325d15192b@amd.com>
Date: Tue, 26 Oct 2021 10:57:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:203:c9::15) To DM4PR12MB5232.namprd12.prod.outlook.com
 (2603:10b6:5:39c::16)
MIME-Version: 1.0
Received: from [10.65.96.204] (165.204.134.244) by
 HKAPR03CA0028.apcprd03.prod.outlook.com (2603:1096:203:c9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.12 via Frontend Transport; Tue, 26 Oct 2021 02:57:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e3ec7a-0e0d-47d8-5be6-08d9982c50a8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5231:
X-Microsoft-Antispam-PRVS: <DM4PR12MB523135EA186400E2CBB317B2B7849@DM4PR12MB5231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9f5f+Batfqw5GFzH5jrkk6ncrN0rh2NcEalOPBH+pOyb/TVZigQVIa/zHP6eNu56hKFnA/18ag4b/HHhlRk0FKrjVSHzDyS+DbuqJ3lPPsFilTpFciDC3JWMyuUCvMqZWaOPBKiteI8EJXLgvpemsm9rS8qfpFbOgKoG0xQB+odXIm+ymXvJJSoTtDMrWlsrFzinI7vzdmemfy/kjvhvBCOrug5AOKgcYDtluMk1jrjzqGklzsxkFz+s6Wkp7qZMDDZmRFLVBCZvJzB4vFZPneCO1XKQZDKS6A8ljOzPNYIssH5/5TO8VOVDzb6k/8oU22fltm3viyFUOhGcRCR55vysY6XvCBx7WjY8lgA5XF/ZRZacNs3ezZuCdplaZnMoLendWcGVZJR0MVB3tLGOPaYTNQveQJLQGUjTjM5aZK1kC7kcZ6E1dxlnFIuzVY/ly9Mpz/t0jn+Bhw9pKscBYMGzbap5CNYiyBd4oK8lMY84fm5b2BqZI1D7DhNC+0e5WkelXMWgyOJDO1WzgRGlBpFkGkFzDoUtpMyYy2mgsAj1aDNEB3wYd70snlegHF0PWmrUCSL2mEioiwgUJDv0WWtG9Hu+kwpcFq2ojyyo2pF4EKJkAQFDk1BQAJ+M1Qo1gqP43MeIrFiy+hYsYb39pyi7xyCkOaBDMI91rxYIS/l/IubOVPWXDTnO5puHpBURxmEnkquyWplPSyPwrtl4c+14x6FHf0sWTe/d6QUypt1Hb3cnR5zIhR9FFyx/H6UYjkdKHuhnfXH18cJoXqCwXAwBlOH9QClYJ5KjmOPCO6oUn1GbntBqSYH1q4x3d6v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(38100700002)(966005)(8676002)(8936002)(6486002)(316002)(66476007)(83380400001)(26005)(36756003)(508600001)(31696002)(2906002)(5660300002)(186003)(31686004)(4326008)(66556008)(53546011)(6666004)(2616005)(956004)(4001150100001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBZZHJoWmE1emE2NmlEZ0Z1UWhsKy9oeURGdzU4aUdxM1dRemlMb20ydkxs?=
 =?utf-8?B?M04zdmVUbEMvdmoyeGFCdnlLTHlMRHVTMXhRaWVrcFlqS0xocFJRTEtjT0Z2?=
 =?utf-8?B?M3hTTU5PeWtUdzlXNzhlT2VNSWxpODVhUW0rM2dtRlF5TldZYzlsTTFMbjNz?=
 =?utf-8?B?NzFCSExRTUd0RXVJaDFVTzhNTG91eTEyeHNuR00wY3hPUHU5dTRVSUhVZ0ls?=
 =?utf-8?B?SzlkSkREY25KdWUrdksyazEzRXQxWUo1aEQ3SUVmN1ZlZGpwdEtsR2VlMXkz?=
 =?utf-8?B?enhnLytSUGRwZm0wV3VLVE11dVM3R1VwU1dyZ3pWM0N2OGJJNDdKWFRra2tX?=
 =?utf-8?B?SSszV05PMFBHQXNjK3pWMVNWbVF6M0tZTC8zblhQSHFoRVNrak0yUU5oN2lm?=
 =?utf-8?B?Q3I5bGZOMEJRdUlzUVRGakordWlJZ3VhQ0hIQ1RyaSs4QTh3WGQ0YTlnWWJH?=
 =?utf-8?B?NzJGVVVoM1JBWmwwUFhBWDBMVHRlZU1WNWErSi94Q213d05obEgyVHZMTHRz?=
 =?utf-8?B?UldzSHYwamI2bjI5VjlxYnBUYXg1S0l1UDZFTHhON291c3ErTDhHZCt1eWdZ?=
 =?utf-8?B?YU5iUkZxWmpONzhwUlJQQ0srSCtUdzUvYUZvc2xzc08rMzZoMEptVVNXL08v?=
 =?utf-8?B?OHZYN2ZoM1llbU9JWStwTFJvNGJ1VzNqL1J3YXRsU1MraTU4cXpuc0hFWWpX?=
 =?utf-8?B?K2ZDa1Z5WTF0aWdLV2IwUGVqaDJWbUdvS2ZuV2lJSHM2d21nSXNyN1NML3dn?=
 =?utf-8?B?RWFvZTV0aU93TCt1TzVqQXpGeWpOOExvUG15UlZyTUdXTXhaZCtubEMwaEti?=
 =?utf-8?B?S3lzNjFYdDF3UkJLTU9TSWRTNW9PTVI3ZDNJVFVZOWM1OGx0akcyQUE2c1NO?=
 =?utf-8?B?bjRnMDc1WVcyWVVsdWk1Zk9HNGJFWGdUNEc0QTVTY3hJV0ZBRWJPNVVIcVVj?=
 =?utf-8?B?R0Z0alFySk85MGlrNEZFVXk3ZExiM3dsUFIwNkdKekprUHJjc3VDYXRHWURH?=
 =?utf-8?B?ajJieU9Bb1p0Q2VyeDArVk4yUVMyc0R5MlZFdlVPcTN2MmNOeVNYN1RqdmZV?=
 =?utf-8?B?dm9vSzV4VTJ1YUI1T3JwT3RkaTB3RDhmR3N1UnlWUjZmUzBBSGp1TXNFendr?=
 =?utf-8?B?b1Jhb2hmdlkrVXFiN0ZmUnM2dHhtamhQNmNZRGVaMy9LdDI1eWNwRll6MitE?=
 =?utf-8?B?MHNwWDlRcmRBQmtKbnZpUzdzVjhzVVgyQlNmYk5SVVh0RFBOdEp6MGhydDhN?=
 =?utf-8?B?OHIxS0gxL1ZjWVZuUmN6OSs2OG1WcnJUTWVGS2hhRm1ZSkxYOVoyOTFRMUZV?=
 =?utf-8?B?UU1TUWVTVzNkZ28rYXRGVm4yU1BqeWdGM0x6L0ZKT1FQVFJpTmQ5S29yOFg4?=
 =?utf-8?B?czE4NXgrY0ZGSFkySEd5M0tSeWsvTGxNMDQwZ0I4S0xGTjI4RnZkQU5XVlAx?=
 =?utf-8?B?SlA1blBEbWRoYWVzbTNXeFgrZm41bFdKS1YvZnJoLy9yWXlwRTVRTGR3QWd6?=
 =?utf-8?B?UjB1S2RGOC9HNUFUdEdJL1R6dXA2MTREMnd6VkFrL1p1VHhmbk82OWdMYzA0?=
 =?utf-8?B?OUV0V0JHNzRaK0hpQ0FQVGMrOVNiZEF6dWJjU0ZmTVRFRzk4ZHg4OWczaWNR?=
 =?utf-8?B?bUJ4dDFrbGtVQ1BWWndLMjNKZFJWZU1qcDZ3b1FrcG9heDhYSnY4ZVQ3VnJy?=
 =?utf-8?B?N0hObzhPWUVzNXZ2Vm5sdGE1MjNJczhPMXZTaXlLTkN3LzAvUmduMWZGYllH?=
 =?utf-8?B?ZEo1Q3hnM1IyeWJBN3hZV0U5Skl5aWIvYnBKSU9MeEFYWkt1VUwvMm9YaHFz?=
 =?utf-8?B?bjUyWFdwMUpJdUR4cVYzbjV1QUZsZlZPRmZuME11WHRkQ29ka0xWUjBhRFJG?=
 =?utf-8?B?VzhhQllGemhuU1B0ZDBiWU5IRC9xdUtUZVVZT3lCdk5nVFZuaEYrbktkVlRT?=
 =?utf-8?B?eHh0WWN3dk1VVzdLeWdTeVVENGNGUVozbVpRTXZLR2hFRG1YMEFjdjIxcU5E?=
 =?utf-8?B?TGtnQm5POU5pdDJ4MmE3cVo5RmJKRHowUjlJZWIxVzU3VXl0NHBwK1F2R3VL?=
 =?utf-8?B?NUYwaGxvNTZYVlptZ1hTMTVoQzh3OURiMitpNk5VNnVnKzFTd1VGazRsYVVp?=
 =?utf-8?B?RUtBS3ZNZ3JtSElWRWs2V3MzVmtyNEwvZkgxa0xxTzJlbzExait1bU5CNlhZ?=
 =?utf-8?Q?TdABf7ButbTXhdzkis3gFog=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e3ec7a-0e0d-47d8-5be6-08d9982c50a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 02:57:14.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXnIOH2a9/YBaZlaRn5SgMf2d4Zv2ebiHHnzyRE3XC7Oe/AHvDsPyBmjfaSf+K5LHwwlHZ1s4SS4ryXBBRHv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
Reply-To: jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021/10/25 下午11:18, Andrey Grodzovsky wrote:
>
> On 2021-10-24 10:56 p.m., JingWen Chen wrote:
>> On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>>> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
>> yes
>
>
> Then maybe update the description  because 'underflow' is very confusing
>
will do
>
>>> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>>>> ping
>>>>
>>>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>>>> [Why]
>>>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>>>> is put one more time than other jobs.
>>>>>
>>>>> [How]
>>>>> Adding dma_fence_get before resbumit job in
>>>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>>>
>>>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 41ce86244144..975f069f6fe8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>              /* clear job's guilty and depend the folowing step to decide the real one */
>>>>>            drm_sched_reset_karma(s_job);
>>>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>>>> +         * to make sure fence is balanced */
>>>
>>> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
>>> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>>>
>>> Andrey
>>>
>>>
>> Hi Andrey,
>>
>> If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.
>
>
> Right, I forgot that... What about removing line https://elixir.bootlin.com/linux/v5.15-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L265 ?
> What if you make dma_get_fence unconditional instead ?
>
> Andrey
>
>
Hi Andrey,

I have tried this and this will cause normal jobs cannot be free(lacks a dma_fence_put). I have figured out all the get/put

for sched_jobs and only the bad job lacks a dma_fence_get, other jobs are just fine.

>>
>>>>> +        dma_fence_get(s_job->s_fence->parent);
>>>>>            drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>>>              ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>              /* got the hw fence, signal finished fence */
>>>>>            atomic_dec(ring->sched.score);
>>>>> +        dma_fence_put(s_job->s_fence->parent);
>>>>>            dma_fence_get(&s_job->s_fence->finished);
>>>>>            dma_fence_signal(&s_job->s_fence->finished);
>>>>>            dma_fence_put(&s_job->s_fence->finished);
