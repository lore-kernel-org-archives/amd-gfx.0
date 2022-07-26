Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E021C00144
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 16:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8018B98B;
	Tue, 26 Jul 2022 16:57:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC268B68D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 16:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAFdV4NV/64cOvP9NiWJfVlLJ2GlO1V2jeP2ox9Tj3VZb6FvwbzTUjlSebQVVSARehcJUWldsnOzN7OLLBK7yrOynq9/w4GoUJ5odwjuWkI8sXHicgzLSY7wajJvAtWXuPNnKVhOWqNuQ8ELBgOQjbujWmzw+OsEZLnxdB8/tOHQ9EMUtyC2jT+yw7HpFe6lHQQ3rIVTyC44V9WZE3oGobm/K+U85G1Isb323ntEGcqrcN2yR+gIazOJ6LekkW9CJttqMOtRJzh0VRxUsX9UzA9RnugPzchwBQWidUDZz42x+NQ3uBwF07svdhSNRiH0KXDOih0O/Q9Px8c/5XvIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dJO+HkdrvPQk7O4V5zoLsjbSvt3Zr4s8i06IcSfSE4=;
 b=LUO3zNYPle6+Cuca4GfnsfvbDK/Ui3iA62blHvD8kMfdQXEDEdXK7z1+hIA+wz+laf0q8/jAFlrrFKisCkBM5zCwgrPkY3lpHZ+oCAHHanOqU0ZzzzN49HlYgjaSKRw7w4esKsXsK39FR0IkiaIzbyoS5KRbdddzWTPuvUVv5aoD8RSO0O2lYqHIyVsEdBGInbqlxikaZ1lgLKjulIgIfsqO4dz8BXpqoHI72VrItU54/k0MKQ6VmeNOT0mocW+7A4WAj18uu4EG7x3IhZpjzQxaYxIpMWa2wptU2VUkU2EAuFrEljMQHpebfIXPYr356E6WJnHkvaV35IzBjJuBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dJO+HkdrvPQk7O4V5zoLsjbSvt3Zr4s8i06IcSfSE4=;
 b=0ybCgs/vYJ9Yxpj7KbSq6ag74Tv4B8SK19mYCq9Fj/RNutJ9vYfhTJ04B/jiBebCnq9PhIZgjtPtqQT66WBhmaUGKqnbdJz/2dwqR1JTg2zzoaJV26SSK8joR+nsz/QdoxBONCTzq2x/iR4+GJFD0oMGSuKC6wKvV3sKmuCMxVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1263.namprd12.prod.outlook.com (2603:10b6:300:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 16:57:09 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 16:57:09 +0000
Message-ID: <933c6777-d658-138f-1350-83c4c547bbf0@amd.com>
Date: Tue, 26 Jul 2022 12:57:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-5-Victor.Zhao@amd.com>
 <85e76646-4b14-2d33-8143-0fe0095afa25@amd.com>
 <DM6PR12MB4340889B38A77BBCC4E0486CFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB4340889B38A77BBCC4E0486CFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f405eede-b1dc-4f7c-ae02-08da6f27e0a1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1263:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: si3Oj46BKtNgjBRANAKx/mg05G2U7Z6u2S2hj29NaUkHj/WSDQo43pZmn0IG3m12MEg570IhkEdZQUR/ydL5m2PEdOhd35900hF7LSD5c7fmPcxpqnMLYefcvdINQsyl1FnNsd0ZgEP2bL+HJCcT8AgO0aLFXqhRj8BN0crMSbG4AIKwqM6qOOUxvuXrxaw22yaIPYfwoS7IV9lWly6fWCw4yuCTJl6zsIOc3zm/zcSCHv4DXCVauO1feFjBkM2BY0+0tokAux5hyBdQvdcKDPoE1d1EvAHn6o/4lvKQS4QhY2QgdRrJNiQDHfuVOWOoFR1wG65aZ3TZkYgdWpLMddSl2bARmQaz26AnxEd9YhTHzcmGzJYeQiwG7FJDpBF0j2YCGGnnoHm2eRzeVLoyFx+2OxqRZ0NCtN0On8poguzW6qqiex7VohPZbIlKcLUaIOB0dTB2Dr2wr6U6BItwEfGDbYDZ/ucayNhAZ7CpadHe7o05h2Yi2V6HvULgbGT2rNEU4wwlAVh+PdhD6RJhJe9shZwoMjZzaBVepIdIhm+7/DJgSU8HfvK2qkZKZSnZL5Uy8ErhxlfChYFZ0LNgB6FlKuwmBXb6glVOamb4MRPubNuEyPTtpJ2vwSYjGgfCm1KDUQJH/T501hpYJ9Wl4oXhlTtQBy80G+Q7Z6AQcCnJtN5bXtjf5/riBIjlklRWohsviqwUZNG5oPXTjNifatYheYPrjpuBGkDFd4gvtTRzMN+wqUvrF+Etl1fN0I4T+ERdDsw+xr8nOp1nFP7j38edJ8pMU9Bc/aqj89soEDqqPdkytNQOERJWtPq/cP/JrQ9QTrrhZVyL9LvnbILvQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(478600001)(83380400001)(36756003)(31686004)(6666004)(2906002)(186003)(6486002)(86362001)(110136005)(54906003)(31696002)(2616005)(66476007)(44832011)(8676002)(316002)(6512007)(5660300002)(6506007)(53546011)(38100700002)(66946007)(4326008)(8936002)(66556008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXQ0NFRhQ0pHSG1SWC9TS1FiQmRvMXZvd0h2MXZ0TFEzeUV5eTNPdTlRVG01?=
 =?utf-8?B?OHhvVDJ5OUsya1ZJT1RQb3R6WmJuK2FRelFLUW9ucFhmaDdqT1R5UlIwVW83?=
 =?utf-8?B?R3I2ZU9CWm4zV3Q5WHV1c3QxaHowRlpDQ3pXN0QyditvcG1veFgrS0pHQ2Fk?=
 =?utf-8?B?T0dNcThCcnViSmVNTXNXeHhlV0R6ZXFSdTdScHYvbUs0QmRoZnVtYnUxRWVE?=
 =?utf-8?B?U3ROazJ3TkQ4WG80bE0rcHczRU1FZHRFN3NsZzRET1BLVEVyS2tIQ0JrQkor?=
 =?utf-8?B?NzY0WTQ2YzVoRDV2d2NPWlNvaDJEL01EWElKTkZkWGNMZXJJNXo4SUNyNi9K?=
 =?utf-8?B?TmtueXNnV211c2JIT1ExVGRsTTQ5dWkzQmhtMlJINGs0d2YvWnNZNGF3UDly?=
 =?utf-8?B?bVNVWDlBMkFydERsK3d3T2c3QVhhak5oRnNtMndBa0R3WHdpL2xJcDEzeEtV?=
 =?utf-8?B?Zzdtak9IRWk4dHFFU0pES1dLSkNXUmxQS3FyVVlrMUkra0Y5LzVmb3M2SkFh?=
 =?utf-8?B?OXpLTHJWR0ZpQnhlYTlaaHltbzVLOGxnb3dOZUg5MnAxVC91cWp2ajRhOXBy?=
 =?utf-8?B?VWxRc3hSeVlOYTBJQVBLWW5WcUxCUzdoZGxnUTRjMEEwYmtiZFAxV2dNVEdZ?=
 =?utf-8?B?dW1oeWZrdVA5R3c4bU9peitRRGMwekxib1doSEZOT1o4T1F2NEkybkhRWXZm?=
 =?utf-8?B?QkNiMThPc0pFVUxRbi9jU2sxSE1lcnFUNlJRbTUwcDdGSG9jbCtVdWRhWWlL?=
 =?utf-8?B?MDhab0ZtZGlmSnZRZlYzMXZZelVkZnBWdSt1czJ6bWdtc3NsMlluOFFpdmpv?=
 =?utf-8?B?Yi93REkzTGdIVjBzbFMwRThncEgyUkdVQjBBMzZia3hPN21UZm1KQ2taTFdO?=
 =?utf-8?B?bGpHSmdDY0tPcWI1bGlPR0l1OU5tcG93Mm5VcGg1WnJFM1BVV3hpaFdqblVQ?=
 =?utf-8?B?UEpuUlBxb293WnFRQXRtWlN4eitRQzJEZ20yaUtDaGNGZHpCWXpabEVHOW04?=
 =?utf-8?B?alBtVWZkbVNjRFVPeXdIdE95L0Y0S2pVZE11ZnRqUHEzZEVJWWdXc3lIdU13?=
 =?utf-8?B?TkVLeGxGV1YvTExkWkc4TWc2K3JZU3c5QjgySmlKR3JoZ2FRdkZzM0xNU3RE?=
 =?utf-8?B?UFFCWDY1SWh6TTk1bjdpZTd2K2dvakpEOG5vVUZmRHBpY1ZldlJEeWlPQ0k3?=
 =?utf-8?B?bTE4N1dlWnl4VFNGYjdEblR5RDhJdk53Z290MjJQU1BmcGVTaUs0T1ZkYXRu?=
 =?utf-8?B?MmVHRUpwWldXM1FwcDZlYmxSZXhLK0NZdDQ4Rk11SllPMG04V2grcldWVnJv?=
 =?utf-8?B?ZTk2cEFRZ28xL2lpS0RqMEJFbHNXbDJhRDhwb21HQTdkalNzVFIxRUlERzlI?=
 =?utf-8?B?b3VtTUUwZ2xmdXJWaVNiTGowMGIwaVhLZ1UxSVRONzhKNUxBbmw3a0E1VUpj?=
 =?utf-8?B?RmxBWm5NQ3k4VGtuTStENGo5dmFzbTBzUnZMdVUzbXhJaHpNZWJQc01YaFJx?=
 =?utf-8?B?ekdhZ0s1UVllYW9KZlR3dXZ5WkdMcFd3SlZiVW81NkdPREFnSXE4QitvaE1o?=
 =?utf-8?B?OUNISnM1TjZua24xa3RSTERObmVHeFhpNlJrMmRMVkc4UGJJYnJnOWk5ZHFU?=
 =?utf-8?B?WW9WeDdSbnp1THh6Ly9QTVI4SVU5dDB3VzdVYUs1ZlNKeHhwZ2hXVFByd3FO?=
 =?utf-8?B?RStVay9DQ2kzWkFLTklmUUxDN0lYcXpjc2hrdjFsWXlGblpLK2R0aVQydk1D?=
 =?utf-8?B?WGh0OVFxNzJwaUlvMTBLWUtZWUE5ME92OTNaU2JteHR5RVJMSDZGUHBlNS9X?=
 =?utf-8?B?MDEyZU1EQlFIUmpiRmZRaEp1elBMc1JqNG5qemVlRDNjdGJQWHp5cHowbHJw?=
 =?utf-8?B?RGRGNzFiZmRmTVNmSnpXRGsrMVZWUkxyck82TWpqVGZKNUR1cFcyWVZKKzRq?=
 =?utf-8?B?NkFYcDEyMVN1alp4YTFUcWw0WnJQRis4djIySUVGSy9ldUtRckhrSzFLc3ov?=
 =?utf-8?B?dnE4Q2d6aUxScWVVWFM3NHVxRVFjTDlQWWlyaXg1WkwzeUhmMW92WTRiMWg3?=
 =?utf-8?B?c2FJSW03YjFXcERWV0Jod0tRb0hEOTFEUTJoK3Y5dDVDYTdYaGEzK1cvL210?=
 =?utf-8?B?RnNReG1kVXJZaE9XUlpVWU1mNGdpZWpLUTRBUS9Hc2c4RnROMTBjMXVHMGRW?=
 =?utf-8?Q?+yrqaKlI0Q5Pf5efsouwyq74YnAowxNaBvvECiAboU4A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f405eede-b1dc-4f7c-ae02-08da6f27e0a1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 16:57:09.0852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un3jpLGuWDIBS9xs83ESsj4j74mQbTuXSe0AMXY0pOMBPq5Y80NfhfP6R/yxzXlfTW088k/QbPlbOixj3XBRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1263
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-26 05:40, Zhao, Victor wrote:
> [AMD Official Use Only - General]
>
> Hi Andrey,
>
> Reply inline.
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Tuesday, July 26, 2022 5:18 AM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
>
>
> On 2022-07-22 03:34, Victor Zhao wrote:
>> In multi container use case, reset time is important, so skip ring
>> tests and cp halt wait during ip suspending for reset as they are
>> going to fail and cost more time on reset
>
> Why are they failing in this case ? Skipping ring tests is not the best idea as you loose important indicator of system's sanity. Is there any way to make them work ?
>
> [Victor]: I've seen gfx ring test fail every time after a gfx engine hang. I thought it should be expected as gfx is in a bad state. Do you know the reason we have ring tests before reset? As we are going to reset the asic anyway.
> Another approach could be to make the skip mode2 only or reduce the wait time here.


I dug down in history and according to commit 'drm/amdgpu:unmap KCQ in 
gfx hw_fini(v2)' you need to write to scratch register for completion of 
queue unmap operation so you defently don't want to just skip it. I 
agree in case
that the ring is hung this has no point but remember that GPU reset can 
happen not only to a hunged ring but for other reasons (RAS, manual 
reset e.t.c.) in which case you probably want to shut down gracefully here ?
I see we have adev->ip_blocks[i].status.hang flag which you maybe can 
use here instead ?


>
>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 +-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 26 +++++++++++++++----------
>>    2 files changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 222d3d7ea076..f872495ccc3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -477,7 +477,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>>    		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>>    					   RESET_QUEUES, 0, 0);
>>    
>> -	if (adev->gfx.kiq.ring.sched.ready)
>> +	if (adev->gfx.kiq.ring.sched.ready && !amdgpu_in_reset(adev))
>>    		r = amdgpu_ring_test_helper(kiq_ring);
>>    	spin_unlock(&adev->gfx.kiq.ring_lock);
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index fafbad3cf08d..9ae29023e38f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5971,16 +5971,19 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>>    		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>>    	}
>>    
>> -	for (i = 0; i < adev->usec_timeout; i++) {
>> -		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>> -			break;
>> -		udelay(1);
>> -	}
>> -
>> -	if (i >= adev->usec_timeout)
>> -		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
>> +	if (!amdgpu_in_reset(adev)) {
>> +		for (i = 0; i < adev->usec_timeout; i++) {
>> +			if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>> +				break;
>> +			udelay(1);
>> +		}
>>    
>> +		if (i >= adev->usec_timeout)
>> +			DRM_ERROR("failed to %s cp gfx\n",
>> +				  enable ? "unhalt" : "halt");
>> +	}
>>    	return 0;
>> +
>>    }
>
> This change has impact beyond container case no ? We had no issue with this code during regular reset cases so why we would give up on this code which confirms CP is idle ? What is the side effect of skipping this during all GPU resets ?
>
> Andrey
>
> [Victor]: I see "failed to halt cp gfx" with regular reset cases as well when doing a gfx hang test using quark. I haven't seen a side effect with Mode1 reset yet but maybe shorten the wait time could be better?


Same as above i guess, it would indeed time out for a hung ring but GPU 
reset happens not only because of hung rings but for other reasons.

Andrey


>
>>    
>>    static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device
>> *adev) @@ -7569,8 +7572,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
>>    	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>    		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
>>    					   PREEMPT_QUEUES, 0, 0);
>> -
>> -	return amdgpu_ring_test_helper(kiq_ring);
>> +	if (!amdgpu_in_reset(adev))
>> +		return amdgpu_ring_test_helper(kiq_ring);
>> +	else
>> +		return 0;
>>    }
>>    #endif
>>    
>> @@ -7610,6 +7615,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>>    
>>    		return 0;
>>    	}
>> +
>>    	gfx_v10_0_cp_enable(adev, false);
>>    	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
>>    
