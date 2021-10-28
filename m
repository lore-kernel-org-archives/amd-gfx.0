Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879A9600D4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 879A9600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3151C6E0AA;
	Thu, 28 Oct 2021 14:46:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA94C6E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 14:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBJ7RPGDEMS28DuPlDBi9Wa0IylxUct+Pml85ZWO3ovxJnFAgcLjgAdGK/gROIiHNuKQu6RBvoSt3rvI3AzPsIo5zpJ29j7C5TIKqCIhOx3zhLlGjAQIvEXyMnS2aDyGaW9QOJiqfE/Rd9FXYJDK61K3PQWRhwJ1jK0+H1ehppMqjHkvJKh7x6EYcyHufSdB4D8HPi6TQ+wMsbwMc+9kH9jhWdpl+lgYRirrAjLaeGqRnNLHjynuG1ruvPp5ipZHeFyBU+0eguv0DNrpsUtVJufySRshCpzGK9OvFQq8z4vc1mm7YPeQcE/bKHXYNYyXQoGR088fJyWSOmLBgvSnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfwfHVBUS0KJ21/hr6Cgw4ezmc3xoagG8tPRdab4f6M=;
 b=IcjJtRU+E7Tur6wUkdmLilLUMySddPvR6WDjr062D8NL0cMpVmmHEfXtsalNVkbFqHCDIJtTb7yXM92nGTGyGE5LRSMRTZwz5WOAz3+KD0FOA5Zde1xf85/XvWRM3/tcfymSdRVFI7wVt+RLRClvdwvSOb7L++SHl/Oxq7Q/XAuzkodLAT2tZBHqnm6T/JYh9GG2hRNh/Vcjat5HjpU+PAFgEcxKEhWin8cqv6Iwsg8oMijEsjgwRVjCfR4J2LppPwFzmo0E81S+X9VJqbgh30oAakiR86pEujKnAWEIz6+azimBaHplteRdCOjmFF7cGTWYpSMsPW0wMwL3dqX9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfwfHVBUS0KJ21/hr6Cgw4ezmc3xoagG8tPRdab4f6M=;
 b=I9J5vi4emvrQeKCHf4m4gW3p3fMcsn9cp4sZQWPxHbwe10qE9qa6BYUxFq/PiyHI2sCFCPLQzjrER9stvOX7++POmMJFyVNN9iWHNJbV4khL2YWCI5y9tiZc0Mme0QnGI7U1dG9KXT6sEu2RUW/BOr8RcUALqVJcBnjLVqnLoXA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4746.namprd12.prod.outlook.com (2603:10b6:5:35::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 14:46:22 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::710e:dfc2:4247:8568]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::710e:dfc2:4247:8568%12]) with mapi id 15.20.4649.015; Thu, 28 Oct
 2021 14:46:22 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: jingwen.chen2@amd.com, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
 <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
 <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
 <9df71fc3-9862-59c0-56d6-9e325d15192b@amd.com>
 <3c7449a2-a6ef-28a6-ca0a-7c749ca3f093@amd.com>
 <df99eee9-8b11-bd4a-0f1e-08e4baaa9712@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <6d7507a3-8866-9974-5d29-adb31792e9d0@amd.com>
Date: Thu, 28 Oct 2021 10:46:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <df99eee9-8b11-bd4a-0f1e-08e4baaa9712@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b55f:1c8d:d03d:ea83]
 (2607:fea8:3edf:49b0:b55f:1c8d:d03d:ea83) by
 YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 14:46:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47757c5d-ac44-4d01-557f-08d99a21b56f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4746D5EC4486F58D9BFB45D3EA869@DM6PR12MB4746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPPcpWAwhim6+D2mymLbFvezH/6vA86cYc8j9Ol3+aBmKXabbolcUUnhJhVYRq7rpQ3X+zzofcj6OH6okMyhM6Ezh9+iVTxGBzvUVeB4+YpdVHjp5hkUHTH56nIUnFDz4Llc9vN7Wp/tNW48HVFapQf2ZtU/1wJCAnggArONUg3Wcu3lnXOgf6/hRRRM+Nv6GAZh/pm2oGtA80Oe9o78k7xjOcdk4TwbNGyOc7Bui7/invinCd6Nduo70llD8OEB68u4C0OcBLtkS3NQfeJExoTcy4RVokJl1fy9RZM/CsOhffNrwLW4dfOAOgz3iyF/Jlnsds4oLOfri0Po53pS4ImX51BfPsj24NJ28t5V+CHLMeJMrk+DekqlSFAqgDuLHjcPbW0TxgwxDGJ3n8bWrjXViGov2T/2RuvnRlamFauD0oLFQLLGI9rj0jEV521VGttx38XrG66em8J0996pNbGm2mHXM6zl5xPm5FYaH7yXSeHgYBLMaJaEqAgvgzU1hHT23GS7cTIxm6qJ7zNE0POu1CuIMvFrTfh8/6yLPBL+5HfXYFZApvnq6aLWq3zpM0nzsM/mmSOB0IUW88+uviO51tI6RWlIC2d9fiLRiXFzucWABKu5d8JJlvj6ZsUei4JXBZ7nQosrMfrPlCQzAXouiSJCQPJ3JM2ywNFZmHrWdRFJkUJGpBz3fKUZZlQuN/IQEZ0V+ov8vzYicZJz70SwIQu59ezkg4OTVMeouTnZSbt0qbVzXmxO1EKTf0iUe6Bn3+2Ts2frqivsFHd2kyteRTUHc1W6jD8dSgaaSOsha6kwU00YwHJCqtl90eMn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(66946007)(6666004)(38100700002)(6486002)(4001150100001)(2616005)(66476007)(86362001)(66556008)(4326008)(53546011)(508600001)(31686004)(83380400001)(44832011)(966005)(8936002)(316002)(5660300002)(2906002)(36756003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpqWDVUOXM1UEpVa2luQUpzZ1VjbGt1OGJOdFlYbERmVlg4SytTNWtscHdh?=
 =?utf-8?B?ZkJYQVBKZ1BYYkZoMEozcERGRklBUWZtS05QcFhTZHFYZ2luWFVZcG5zalhW?=
 =?utf-8?B?anZ2dEZVd0NpS1NyeHoxRVE1SzRYc3RjbURrZmxhSi9GQW1aUDkrRUs5Wm5Q?=
 =?utf-8?B?aHdiUVA3d0pCMGs0OGtEQVZKM1pZSGxqYmF1T2pzdGpoVHBtZU4wcFg3bXZJ?=
 =?utf-8?B?RGlONEdZNEFBRmxEbEpTTml2OXhYR2xET3dpSU5GOE8vQ2psd2ZCbXNNWU9i?=
 =?utf-8?B?SHpnNmpNUTZTdU5nYzFjQmpYZGkvQy83ZFhSSnA3cEphS2FQTHRjOWE1c0t0?=
 =?utf-8?B?d05SaWxQYXdWdzEySmJ4clZLNjJIREFjY1lzSkl4WE0xYnJTVHdoZG56Q1RQ?=
 =?utf-8?B?MUxBNS9DU1gxMUlLdTdvSkc1QzN0d0d0SExVZEhVSTBuZ3FUbnlDcHZBTWVZ?=
 =?utf-8?B?R3MrR2t2Ym5nODdCQlNTMnZwNGJQQzEzQld3SGZ0UHcxREc2b29kc1N3aUsr?=
 =?utf-8?B?TUtxSWpyOTg0c2diczZMVDJnQnlGS2ZjWk5NWTlRcU51RklCeWYwS296YVZq?=
 =?utf-8?B?UWwwT0JzSk9CUjA5WmhLZUhoTEtCcUQySUpSc0lRZysxUzhoeWl4Y0lYbzY3?=
 =?utf-8?B?czNab0drT3Y1TEFHZU1OMURSZUw3Y2U2YjNVOU9sZkxqUkg2ZmpPaEFZNGJ3?=
 =?utf-8?B?TENlOGhCVzdaOCtmQVVzdVpOQUs1NWNvQ3l4MlhuLzdRaEZYcTFaQlRHUHZZ?=
 =?utf-8?B?QXlacjRKMlRmOU1JeU5GQzJpRmZIdHl0MjVpQVplR0FWbzIySG1hZzZuRXdY?=
 =?utf-8?B?aGpxNkVtYllKSU9QRjdSM2o3aXN5TWFLcXZ1Zi85a2VYaW03SlczN09JcWNX?=
 =?utf-8?B?VDNGY2hXd0dza3RaZlEzNzVLV29oWFlNanF3Mi9aOERTUjF1MlRLdUkyOXRF?=
 =?utf-8?B?SFBIOUd1aFZIeExuQW5lb3IxV253SUpmK000SGR2MEpTdlgxWHpBRVh3WkUx?=
 =?utf-8?B?Sng0aWs1LzhUdUNUMjR4eENLeC9TM1VGOFBJK1FseEZobHhQSmxRcGNHcXgr?=
 =?utf-8?B?WEdlRmZ3eEJmdEcrZEdQVExYVUFtUDBaSmFwdDJ1UHgxYy9QRWVXZWxUN3J2?=
 =?utf-8?B?M0VNRHVHSXJJS05XbXUzVWkzRGFuNUU2Zzdrb240KzNTRWhOM1dGbHNJVW9j?=
 =?utf-8?B?aVJTdXYvaDJnd1g2cnFReXE2SEhlWEx6RmQ3bm1kbSszR2NqTTd5cUZjbk1x?=
 =?utf-8?B?K2o2VStua1VMalp0bUxKVWNmK3JqQno5RGhrMVVYblJmSENZU2dyeTljZlA0?=
 =?utf-8?B?UXZBdExGbXplOWR3a2RFNlAweHkrengxVDQwWXFjeC9QRGNXSno5ZllNRTlz?=
 =?utf-8?B?dXhINGJiajczSVJSb2hHdzJ6c2c2VUYvaGZtZDcrTFNtVmNjRlNUQnRjb3hx?=
 =?utf-8?B?MzBFSEdrRk9ab2dtUFVuRDI0RlhhdFpoK2tZcnByeUc5T3RtQWhWdUM1a281?=
 =?utf-8?B?Mnp5TzhJL3grOUdMZlRXV1FpelZrNmtDcUhOT3k0VFN3cmtMTE5CbEQzYlVT?=
 =?utf-8?B?YnNOSStrOHhiU0U2L3JmOGJhMG5KYVNNVEZKbkRhY1JDOEI5K3c1NkhZZWtC?=
 =?utf-8?B?SkRDOG1wVXlZaGtqVjFDUm1MKzZBSUNmOHd1N0JpbWxHRDE4VHp6R0FKelFw?=
 =?utf-8?B?QnZtTnlYVWpiQVpsNFRwYWR2VHdGQmNiS042d1MvcVd3cFZEZDZTb1FMMGhE?=
 =?utf-8?B?bFdOWWZyeS9vSnJnNU9OdkV2Z21ycGRhNThNZjJ6eG0ya3hoMEhLc3prSW1i?=
 =?utf-8?B?MnBmQVFvK1piMHVKOThOSEVmayt2VjJFRTZTY1NvYUNRaE44ZWo0dktKNFpZ?=
 =?utf-8?B?YXVlOGpPRjNaVU10aEVhUmt5QUplQVhxZTVkT0NyQWc5bDRlV2RucVMyQVZL?=
 =?utf-8?B?SUNBWUJ1OVNxeUtmZ3dmRSsrUVNQWHptcUFHWlFGWGNiL3hWV3BLOFhqK0cv?=
 =?utf-8?B?WWNPVkE4WEJGdGd0MnhLSExOY09QakVvY0wvdFRWbWY0WnZ4OGkzRW5kUDlm?=
 =?utf-8?B?dG4zUGpWdnAxUHVuWTlwSDZrRXkwWWhzQkhFZjVBbityRS9uMndnSzlyTVlQ?=
 =?utf-8?B?amJnQXcyTURpT2dNNks2NHU0eW5YTUFBSk9OMzFYU2tYOEJxTVZGYzhvbTcw?=
 =?utf-8?B?aEJnTnZzK0xXMHUvOTlWbFdCRFFJTXEzcTlyM3pKZmI2QnZYcUdDVVlpYTVM?=
 =?utf-8?Q?L4Skdi9Be1mX1c9mJk5xNuZ6zewiZU5ppADgxLtLXE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47757c5d-ac44-4d01-557f-08d99a21b56f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:46:22.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcQTeBuRS3Lrz26ByyzkCAhyKE7BblnhX5kEj7h/fMer4TLMWtLaiMdyyAvsg10raOmYy968eB2XKxTJyhroHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4746
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


On 2021-10-27 10:43 p.m., JingWen Chen wrote:
> On 2021/10/28 上午3:43, Andrey Grodzovsky wrote:
>> On 2021-10-25 10:57 p.m., JingWen Chen wrote:
>>> On 2021/10/25 下午11:18, Andrey Grodzovsky wrote:
>>>> On 2021-10-24 10:56 p.m., JingWen Chen wrote:
>>>>> On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>>>>>> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
>>>>> yes
>>>> Then maybe update the description  because 'underflow' is very confusing
>>>>
>>> will do
>>>>>> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>>>>>>> ping
>>>>>>>
>>>>>>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>>>>>>> [Why]
>>>>>>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>>>>>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>>>>>>> is put one more time than other jobs.
>>>>>>>>
>>>>>>>> [How]
>>>>>>>> Adding dma_fence_get before resbumit job in
>>>>>>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>>>>>>
>>>>>>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>>>>>>      1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 41ce86244144..975f069f6fe8 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>>>                /* clear job's guilty and depend the folowing step to decide the real one */
>>>>>>>>              drm_sched_reset_karma(s_job);
>>>>>>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>>>>>>> +         * to make sure fence is balanced */
>>>>>> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
>>>>>> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>> Hi Andrey,
>>>>>
>>>>> If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.
>>>> Right, I forgot that... What about removing line https://elixir.bootlin.com/linux/v5.15-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L265 ?
>>>> What if you make dma_get_fence unconditional instead ?
>>>>
>>>> Andrey
>>>>
>>>>
>>> Hi Andrey,
>>>
>>> I have tried this and this will cause normal jobs cannot be free(lacks a dma_fence_put).
>>
>> I can't see it  - can you point me where in that case you get unbalanced refcount ? As far as I see for a a normal job
>> being ran in amdgpu_device_recheck_guilty_jobs the refcount on hw_fence is  -
>>
>> drm_sched_resubmit_jobs_ext->dma_fence_put -> refcount decrease by 1
>> drm_sched_resubmit_jobs_ext->amdgpu_job_run->dma_fence_get increase by 1
>>
>> In total refcount didn't change until now
>>
>> Next,  dma_fence_wait_timeout completed successfully because the job is normal and then you delete that job from pending list and call the
>> free_job cb which drops remaining refcounts on the hw_fence.
>>
>> I am probably missing some  dma_fence_get since you checked it on a device but I wonder where is my mistake ?
>>
>> Andrey
>>
>>
> Hi Andrey,
>
> The thing is the put/get is balanced right now for normal jobs in TDR. Changing this dma_fence_get to unconditional simply adds 1 dma_fence_get but there's no corresponding dma_fence_put for normal jobs.
>
> And if this can be helpful, I try to find all dma_fence_get/put for a normal job in advance TDR based on the latest drm-next.
>
> amdgpu_fence_emit -> dma_fence_init    ref_count = 1​
> amdgpu_fence_emit -> add into rcu    ref_count = 2​
> amdgpu_job_run->get after ib_schedule    ref_count = 3​
> drm_sched_main-> add fence callback get    ref_count = 4​
> drm_sched_main-> add fence callback put    ref_count = 3​
> drm_sched_resubmit_jobs_ext    ref_count = 2
> amdgpu_fence_emit -> add into rcu    ref_count = 3​


Now I see that that put in drm_sched_resubmit_jobs_ext is for dropping 
the refcount for the previous
'amdgpu_fence_emit -> add into rcu' get... This is all very convoluted 
and confusing. Probably requires some
rework to make the code more clear but for now we need the bug fixed so 
with the title changed
the patch is Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey



> amdgpu_fence_process-> put after signal    ref_count = 2​
> drm_sched_main->free_job    ref_count = 1​
> drm_sched_fence_release_finished    ref_count = 0​
>
> If we do unconditional get, this sequence will turn into:
>
> amdgpu_fence_emit -> dma_fence_init    ref_count = 1​
> amdgpu_fence_emit -> add into rcu    ref_count = 2​
> amdgpu_job_run->get after ib_schedule    ref_count = 3​
> drm_sched_main-> add fence callback get    ref_count = 4​
> drm_sched_main-> add fence callback put    ref_count = 3​
> drm_sched_resubmit_jobs_ext    ref_count = 2
> amdgpu_fence_emit -> add into rcu    ref_count = 3​
> +  amdgpu_job_run->get after ib_schedule    ref_count = 4
> amdgpu_fence_process-> put after signal    ref_count = 3
> drm_sched_main->free_job    ref_count = 2
> drm_sched_fence_release_finished    ref_count = 1
>>> I have figured out all the get/put
>>>
>>> for sched_jobs and only the bad job lacks a dma_fence_get, other jobs are just fine.
>>>
>>>>>>>> +        dma_fence_get(s_job->s_fence->parent);
>>>>>>>>              drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>>>>>>                ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>>>>>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>>>                /* got the hw fence, signal finished fence */
>>>>>>>>              atomic_dec(ring->sched.score);
>>>>>>>> +        dma_fence_put(s_job->s_fence->parent);
>>>>>>>>              dma_fence_get(&s_job->s_fence->finished);
>>>>>>>>              dma_fence_signal(&s_job->s_fence->finished);
>>>>>>>>              dma_fence_put(&s_job->s_fence->finished);
