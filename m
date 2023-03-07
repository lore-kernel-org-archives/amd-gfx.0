Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2383EC6FA99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 20:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA4A10E54D;
	Tue,  7 Mar 2023 20:36:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D006310E551
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 20:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkcUHwA+PlIR+pklTxNm4NZJhx1GHKsBs0Zs8hMYfPl2jWGId3hBHYGGqWK97S3GPazRF40meTuIl49ukSWSGlhJn7DKfHKFMGg84svj0Ks36LtM9W2WbS+wvp+I3sA1lgsw+ZoeJeeK4Gn923SdHcXtZOcKeg21ioDPY3jlvDubCVvTQIpE20EBmPUh2gmFfJyomCIet+WIWhretE9RnojYI0fzveV7v0nmnvluN/pHC4HdpaM3b2S+XdspHtJG4TOOpTnd9LD2NU4K+rViW8CsaXIYnr0BLS/SJqaobaIEEnPxVvrnwVOpN0Yl8qw1ALzDyMYfJK6htPpDdrX2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdOizwn7dzZb2juSrF3jnkTgRH9P/SCP6flQyYvU1io=;
 b=kckwjwd+lUdAbvmCiSjnbXS4WzB1mNFFZievEnAOrlX73uMVMvnk/mewkUd+iRFniQoXakhlr5UuZa7Ma/48vRcycmrBep3kBqHgKF3lkOtO8hXTwc9267tfgAPSofvptJUZa1HPupktN4WjSdQ/jSqTswbn+e4bdEI7m1QAmKkD572DelsRQCvBNS+wCzzN/C3uru9rythRbPHmTz4rIW0txTb4R0eX96Q4My8I2a5E5f31iSRrvGZKmNXXNcw+lbn2UKAcF6yd3PuY1dVZ2XdZAl+Vo9vWLtxfCzwAV8QWtndtLg/uwEY4BGfZhgZ3koiT+tQZi8zTZ6J9Js6/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdOizwn7dzZb2juSrF3jnkTgRH9P/SCP6flQyYvU1io=;
 b=UHiVwI7AD6j+TqaI5e+Xi8Myk0iYNlGgd62YR/YEUC140al8wELmGrp4Bk/fyVY+EqW8aBGOc7UY+IKZViy1dOwybOvnRPq7NzhmxV6zh4v4k/ncW+yDO1GH+tZen/vUOrXe31rrtlQ78Gjb7hJgj06DjUMN+089hUihVPpfYgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 20:36:30 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:36:30 +0000
Message-ID: <c01e8d00-0565-0015-0e69-ca22260c70c9@amd.com>
Date: Tue, 7 Mar 2023 15:36:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
 <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
In-Reply-To: <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 6311129b-6e9b-4b62-8d0b-08db1f4ba1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7Ef8Q+n+wm/JKFNJbsKZ+ojlFjJwzyMtHO/qsZLAUj2hBigVloBKVWIBC6HqadqHdhh5yFnCPBkGtmPIIX1PI8s52hP6Thwd2E8ww6COyu4RKWm+91xTwE95nTHhLy6D2ZKjp3oLIw0StH4ue05gdRyrxUHVWB0nSXZiGrCjCTkNbu/Bhnoum2zHB8keefOnikTBBhYTPvbF4QNURMaVZKYriMcxtl43n5wJ1m/WAJXgQ3m0WPVn6pBwfBOQvRWEP32Xrf3dm6y0ycSmeAwyq9sLFDbUcJFso3LhHMVPCStBPgNRv85xy4d364KMGmi/QeGaX/kERdsorHNhORVEnwbOYLplvdfIYlxrn4aje8iTGxLdZH8fDn0pavqucm4N2RjFyhsLctqQC50ullQSLx/PnyXbZWLFXpa+MZmHPxKbX+xTYL8VXPreqc/mnl1qQEOgmOt+4aAqecsQpdvLzQJybIPoq5i0rc+5pLLdno5tWrQggBUVuZTLEjH1h5s/0EhjyVEYH/L7KQoWvkVgtX0MKyjHcb9mp84MRsxrAREmsHUxGCEewb8jvrIVdtD9zqbiKfdd9oSAF3o7F3y2eSTlXV092FB2fNI5KaX5hBZ9Rvfb52kBtb1ac2boRmACYYWpod/Pl3bJpvFrU/z8g8AiuuUt4+ApfpUWMPN+V6iE9JjyvwYy24Gyb9LAtLKvxJpH/v6IJkYbtNVa//d7O3/wa0+7Fq4OZSi0naA77E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(26005)(31686004)(8936002)(5660300002)(41300700001)(4326008)(8676002)(66946007)(66476007)(66556008)(2906002)(44832011)(2616005)(316002)(54906003)(6506007)(478600001)(110136005)(6666004)(6512007)(6486002)(186003)(53546011)(55236004)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllLYzh3Qmk5SGZob1BHTFFHcnJWRXNTdis2L3AvdkIyNDdqV3daZnFSWSsy?=
 =?utf-8?B?RzJka1NzUUhnRzBsT2c2SWhaL0p4UFFsZFJVRVcrbTJEckRIUEloUHlWYjZk?=
 =?utf-8?B?ZmFkdGxCaXlhc0svTkVWN2NOazNVQzZXYzZ2MHVUcmdRa3VmQ2xrWnU5M0Qr?=
 =?utf-8?B?TWNkMmg4VUxkVmZ5d09xVUhSNDRNaUZlY3Z6QmZ0OVBjeVBSakxSS0R2dlRG?=
 =?utf-8?B?c2djanQxQW8wSTBGRG5OUExUSkp6THhFa2NaMFlZZE81TUVmSTVOWU52TzRt?=
 =?utf-8?B?dVdWdFcvZ2RyVzlHMmtWYVdKOFQvZFNiUzB6cUZCSDUvcnduZFdhOTl5aWdD?=
 =?utf-8?B?Q0xUeFN4RThWT3RVb3I3bmRKSHptdHJ1ZGQ4dzZwcDY3WEE4dFA3Y3Nxb0w4?=
 =?utf-8?B?RFJWTTRVUU93K2cyWXhsWDdxOFprNjBBRFRYV2tnWitJbHdkb1ROZXpqSGdO?=
 =?utf-8?B?OVlEczdNOVVoY1JqdHoxNjhScnQzbmRnbVE5WStOZ3RqWmFlSE1yemVVd0k4?=
 =?utf-8?B?aW03cWE5akxRVlFQQ0JzZTA2S0V1NFZCSGwvVjZvb01yUWFmQzd5cFR1Vmt3?=
 =?utf-8?B?dnRFdS9YbGdoN29KMlgzQ0xkVncrTXljWGFtcVhkSjhvNkU3UjVCM1VQSXpO?=
 =?utf-8?B?RDNJajhHZXJzQVowZFliVEllcUUxTnJ1SU52eHNuSStoTHlrR2QzU3R2OWlm?=
 =?utf-8?B?TEdQRktKM0Y3UjRCVWZjTWxRQ3B4RjBmS1JDTEp3UkFKUzZJQmNnSEl4eGZV?=
 =?utf-8?B?VWQ0djBuMTlzNzROVWF5M3VPMko4STBpL1ZwOFVlckxicDRLZEUvQTlteFMv?=
 =?utf-8?B?TXVYWUpmVUVWOUZSZVU1YklTdDJUdU9qdk5TUllMdHhXTU0wOFlBTTJ5TDhG?=
 =?utf-8?B?aklaVDRyTVVYZW9lbnNYdW9MUnErSkgybE9pRVo2S09EbXA0cFZVdDBKNWll?=
 =?utf-8?B?M0I4RFU2LzJxQ25zTERaVnBEVTR0STdXN1lpWWlkTDFjOEM0dVpFQURQRTc4?=
 =?utf-8?B?YzREYzRmSHRqK0xoTFQ2RGlicURUU052T2pldkwwRDNJNVNDK2Z4cW90a3dE?=
 =?utf-8?B?cEppOGFUbFoxTzFaWDkzWWVTNGlIS0VJRmVSYkFmVm1vWnM2NVRsS3V6KzhE?=
 =?utf-8?B?SjI5UmhzOWk2MWh6SXEyd3NJS1doNHhiUFRpNndkRmdBUlZsWHQ3MVBCZlRr?=
 =?utf-8?B?NDlxOU5SRVNtd29mV3Mxb3RXcDRETm02Uy9qT3A0Q1lMSUMyTzJVOWJ1ZldK?=
 =?utf-8?B?VWpyOWozOW12bGlaRXZrS0tCZ29mWVgvSUNHT29GbW9sMWMyYllVQml6azVZ?=
 =?utf-8?B?UWwzZmtjcWRDWWRQN0Z2Q1JXcEQzdE5vVnRQWHN6UExwMVhMdHBBdFpvdlJq?=
 =?utf-8?B?cXFCSlJlU3hSRlNiS3lHT1paZVMraG51U2xUNWJJWnJnTGx2MDVwS2IxVDda?=
 =?utf-8?B?SnMvV1ZQSzlwZVFSalVEdjlia2xiK3hwOWxzemNpUmRCdGxkSWtYTnpkODNw?=
 =?utf-8?B?UERpTTFYN2xCUXBFcEZuaDdKbFlxVklkNHRXaHlEVDRvWVZKRHIveHVzSWhy?=
 =?utf-8?B?OU9kRjNrWWw4VC9MZXhnQWM4aFZOYmxoVm02WlllMHZuR0kreVpxcktXMW55?=
 =?utf-8?B?NHJxTTlHNk14dlJnNTlOYkdob1NDdjVNRU5mY0hseFZ3bjlueUtwYXhWdlhj?=
 =?utf-8?B?K0JxN2wzR3hJTHNyUFE3cGV4N1orK0NwUDBFTUlUemV0QStBTjJQTmYya3h4?=
 =?utf-8?B?VEQwNGpBZnViejFKcUVMMXExQWdLazFIZmFXV3poRWNJV3FpKzRyYmNBRDF3?=
 =?utf-8?B?ZUtvZEs0TVhKSFBFZDVJUFdpY3YxOGQ2Y0xwY3ZYYm43Rjk5ZFFlSVhkN1Fs?=
 =?utf-8?B?Z2FpcWMrODFpcllFeTF2SUx6cjNncEdpd1IxeitRTUNrRi9PYkh4VEJxd2lq?=
 =?utf-8?B?ZkJnTk93OWpiTnNpSWRSYXQxU1ZFcnJYT0YxSEtaZnV1dFIzdHJkckhWbk9J?=
 =?utf-8?B?SW5MV1hpUU5wbkY1NHNVa2dWNmFBY2lCakJiLzh6WVhQR1ZobUpFNnRFZHp3?=
 =?utf-8?B?K2dxZzBZalE2NGw4UzhGaGN1QXNHWk1aSFhSWWt1Tk1RcXU4NUZKQ3VjTkIw?=
 =?utf-8?Q?NhkxCEJfRt2YkRGHD+ql39laV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311129b-6e9b-4b62-8d0b-08db1f4ba1f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:36:30.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuumBtJ3McvlpkvJy0427QlDHCUaS5MPHiPFPjj8te3JDrIGElHhL0ZbC/Hs1iF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Thanks for your patch!

On 2023-03-07 02:07, Christian König wrote:
> Am 07.03.23 um 08:02 schrieb YuBiao Wang:
>> [Why]
>> For engines not supporting soft reset, i.e. VCN, there will be a failed
>> ib test before mode 1 reset during asic reset. The fences in this case
>> are never signaled and next time when we try to free the sa_bo, kernel
>> will hang.
>>
>> [How]
>> During pre_asic_reset, driver will clear job fences and afterwards the
>> fences' refcount will be reduced to 1. For drm_sched_jobs it will be
>> released in job_free_cb, and for non-sched jobs like ib_test, it's meant
>> to be released in sa_bo_free but only when the fences are signaled. So

So, you're missing a signal for the non-scheduler job fences?

>> we have to force signal the non_sched bad job's fence during
>> pre_asic_reset or the clear is not complete.

Do you want to add a function which does just this (signals 
non-scheduler job fences) in amdgpu_device_pre_asic_reset(),
and resubmit your patch? (There will be code redundancy, but may
make the point clearer.)

Are we missing to signal non-scheduler job fences on reset altogether?
-- 
Regards,
Luben

> 
> Well NAK for now. It looks once more like one of those not very well 
> thought through changes.
> 
> Luben can you please take a look at this and double check it> 
> Thanks,
> Christian.
> 
>>
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index faff4a3f96e6..2e549bd50990 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>   {
>>   	int i;
>>   	struct dma_fence *old, **ptr;
>> +	struct amdgpu_job *job;
>>   
>>   	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>>   		ptr = &ring->fence_drv.fences[i];
>> @@ -680,6 +681,9 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>   		if (old && old->ops == &amdgpu_job_fence_ops) {
>>   			RCU_INIT_POINTER(*ptr, NULL);
>>   			dma_fence_put(old);
>> +			job = container_of(old, struct amdgpu_job, hw_fence);
>> +			if (!job->base.s_fence && !dma_fence_is_signaled(old))
>> +				dma_fence_signal(old);
>>   		}
>>   	}
>>   }
> 
