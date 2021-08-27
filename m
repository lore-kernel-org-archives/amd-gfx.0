Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D9C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 18:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B9960F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 18:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28B9960F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3956E9AB;
	Fri, 27 Aug 2021 18:42:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2AE6E9AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 18:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTa4L082tGBf5Q1qWHqx0Y+zcZgKWTzUM7xNMrjw2g9MoHZMt7WTNk7qQxUlrfaPO9LnkxBc3gt5hc9HYDs9xH8WASo5uCr1Sr8J1a72u0vt6lOkfD84D1GeaJ5FhMS+EzBeQxQlodygF1FO6PZXtryUeoxz4qtOHxwf1sXl6qRASkCq9d88V9pWwj+A/87bJ4IKW6fW48VhOJ/mP1KDOyQMbGfp8D2X6tlxdInPy/aZDtVGt8eZVyO9NNowwrcgdxPGiE1X34VGNYAKaUBSv05RLRB/6ftcLzYYv+jwi9odgZPhnGmjEl18axthNfTpFxh2+JjkrNqohRjUlRGbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLeV0Rj5QitATq3igEPtTceI3mmM7GuUylD6oxHBbu0=;
 b=VWO/cuk0s+HR5aOzjl7qm2sMU+rszpicV7FdUP5HIZUWPsg7Hk89/BORsPXaLK3T7mRhPKmYeDx/jHbtbXVgm0J+K1sUQGDRS+Fp6+SCC1x+3azq6zrcE5mwnG+rLcWtnrvdE6K2EzAfaI+O1YZEYXpOEXPRHyk6BAjbtX8JHKtn9hUzVSIR7iyjXbKkQ6V5riuMK0Ieu8RS58MHBsSgp1m9dGZggKMkFretdsKr/eCVDaVdndoFWqqR9yKitF/bGK4TJ2Lq1C/mYcnhbjUrWoFPe/mSyfrRyll+eMq7LZLUyruiC2NzC68YzhtrtL94FYsD25xNBoGIqx1E7eIipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLeV0Rj5QitATq3igEPtTceI3mmM7GuUylD6oxHBbu0=;
 b=O/k8iVfElfMARVOvtdsF04BppCNToDH0+ktaZj0IuMSpvDqF3oDpw2LYyWz+8LDCp/TXKn0oaYfaFTWabAimdsSvW5lYY/uCLeku0y6qamMvDH9VG/+QUmImdSLV5bxSyyLYdgDYgcN8DTenyCxs3qOAUBM1njkgvWU39TrJESs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 18:28:18 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 18:28:18 +0000
Subject: Re: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, mike@fireburn.co.uk, alexander.deucher@amd.com
References: <20210827104038.4945-1-guchun.chen@amd.com>
 <5bc45025-b524-926f-736f-95e5b70ae8be@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <4d7eee83-e0f9-47a6-abc7-f690f2bca496@amd.com>
Date: Fri, 27 Aug 2021 14:28:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <5bc45025-b524-926f-736f-95e5b70ae8be@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1441:7037:5b2:9692]
 (2607:fea8:3edf:49b0:1441:7037:5b2:9692) by
 YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Fri, 27 Aug 2021 18:28:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab44fd35-08d6-4b02-c8f4-08d9698870d8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351FB92939F1A2EF83DF0E6EAC89@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubRqSHO5bixfA1TlbtWwZiMLRlGpg8abJis6aEd0u+dD8V5izWqlifiqCjlct+Os2wLV8qrsA9pZOAu55gti+K7zcktrHJylqWPjn6lCS51YaKhDN1RIRH4COZ3Me/y0ob/TJy758Fo+dHh1pprwP27KYPSz25NO47zfAI8VHvFkhIkIFojsjbJLn97I0SutzWLdO5qU1Rah6ibwq3wTkcfpmYqWq/vyKXEDi/hmjlRVh0MW5O4PDaFg5zz98ngAjJaOO71+XdfXXOpvCCnLNRrd9xafeHJ3TrwCfKFoLx9CF0FdAuOSqXM+jMUrOlLRrMLNFl564tAflQ4vWqO7DrB4Xoa6+SLe/zdfEZRWJ0inawm1z/I8Q7u3G/1l1WG+R0xx2nSDLcg6/J6xZJ8n9/tQ0v+kjZowCLzHpa4A+0TOO+mduUSAHZTl7CBhNmYgC9H5lAUsCRpDF/QqY/bZ1YHTZpFHjW/kGdZ/R/41rbbfu+ZKXoj7RcEBQ3dRvE1X2OXzxHVk05Xx8hN1N/NPKq7nHVA2PtdYfi6kBxo8O9I6fEP/dRZ15m8t7Aj8ni8s2AxOm04saqi7P6LiE8IDS1lilrhbPyDbPjVR4Q+RqHt+SCiFEnPLrlKYZvgn4YcfHjQ+Wj+cJi3E6dy3abV4z2UL7HN06bANR5ETv/IobaMwZ4Bl9H/1asFdosFa+Q/wCzmqhkt/iPhZhJlrCnAwqkgeboGb3+GS4w74QPo5lzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6486002)(66946007)(86362001)(31696002)(83380400001)(66556008)(66574015)(186003)(53546011)(478600001)(5660300002)(8936002)(6636002)(38100700002)(44832011)(31686004)(8676002)(110136005)(2616005)(36756003)(66476007)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStsOFNkR3QwcG5XTnh5eFFiaU9hcW9ESjAxbVZiSGlhQVg4SkdpeEJZSEZH?=
 =?utf-8?B?ZUQrSk9pK1FtSiszQTRlNHBnTmVHbFRDTUdmaHdqcnhmWTBDQzh1bnYwTjRO?=
 =?utf-8?B?ZCtWMkVVeEJjWXJaT1U2NDVYM04zQVp1a00vcXk3SDZ3QVVMU3QrdzdHcExN?=
 =?utf-8?B?c2w4TlVLTFozL3BGNzZJa1J2ajhaMytnb05iN1drY2tlaXhnNTV1VXJ6ZFh4?=
 =?utf-8?B?VzZqRDd5MjhEdEJjZURDTmZ6MXdHV09tWG1aNWlNREZ3b0VlK0xVbmhsVElD?=
 =?utf-8?B?aXFWcy9meVhFR2NPdGFGZ2dVTllWaVk1bE9iU0JRR2hXZGpORHN1bFh4MXFB?=
 =?utf-8?B?eXBiSFVEME9mUG5Bb0UvU3ZTR1pXVFMwSFJUWktPQ2psaC9DSWxyaFltQUlh?=
 =?utf-8?B?ZU93WmxiL1diUjN3REtFZkN3Tm9tUFBuNXVQMkx4VXFmRTJzZjVSU1NkcStR?=
 =?utf-8?B?bG5haGFiazJ3TWFqZXp2Z3lmd1VIY2ZLaEFlNU4rL2xVQ2RvV2FYaFZrZkpt?=
 =?utf-8?B?dkRMMm1adG1FS2IvL2RYZEhNVnR1ditCd1ZSbk16UHZIT3VOT2NVUlFsbXZM?=
 =?utf-8?B?NTdWRCtubkJpVWpBUktUWUxhektDUFl1Vzlaa0pKeWEvaGs2WXBKZnp5NU0r?=
 =?utf-8?B?akUrYjZac0l1QkZKLzJEaE9pcldWa0IvWkxjK1JJM2hLNjgvRjdYRXA2R3Vl?=
 =?utf-8?B?VWRNd09ObmlRM3Q0ZlpSeVpubzEzaWYvLzNwc3NqUSt0ZktWdTY4T2UxTzVq?=
 =?utf-8?B?anBTNnYrREtudjlZMGkyUlBJeUpmb3pIYmRmdGJPV1pScEpxUHdSdXd2QVNw?=
 =?utf-8?B?TlRVanBDd0RvSldtamU3K3ZLbFArYjR3aHVoWVJYYjF1bCtqNlZRVDYvZDNZ?=
 =?utf-8?B?cFVMeVFrV2xMa0ZxczNwc2VWT3k2RGFuNXZlR3dpRkpicWQ1ejFTVExnZ3h3?=
 =?utf-8?B?ajdSM2ZtRVYrRVdPYnVqb3lxK053LzVxNTZIbnROUkFXY1drRVVnQ2F2eXZP?=
 =?utf-8?B?K1VIa0VhNnpVU0lqamdsam82SGl4TTQxaUZEOTdVZTBSUTJTTHVLS3FtYXF6?=
 =?utf-8?B?U0JqZFp4YmE5cVp3WGRIekhlQUkyd3pGUjdDcDdEUGttVVAzZlRrK1NLUGxi?=
 =?utf-8?B?Wk5pSzBHZ0I5V1BSV1hScDZBV0tRRDNTanQ1RDZ0MkJESHh6cVFZS2g3a0xS?=
 =?utf-8?B?d3I1clVkamRhTWhNTVF5QVZoTS9yZ21hWEJTU2ZYL3RkdlBrVnQ4aGxwcmwx?=
 =?utf-8?B?ODQ2c3dLY3RpdHp1Q3hDcHZQUmVLNklQa3g5bzZGN0x6Tkd2UzREMXZDMXhl?=
 =?utf-8?B?ZmsyT1FyNTdPMmg0WUp6MWhwNWd2VWZleHRqWDNxN3ZsQjFpc01kdzhreHBi?=
 =?utf-8?B?cUNxT1NTQW9KS0N4c1hhNTl5QlV2SU5VWE5uSFhXbDlOZEZ3aEVSY2RwK0pR?=
 =?utf-8?B?SE1DWXBqZVRCYW5UbVFNbDdVZ0c1dVZVdkUvS3ZraUF0N0YrL1Z5QTdreEtF?=
 =?utf-8?B?eDJaTmdRSHVlci9rQUF2a3ZxV09JakJLV0F3cjRURDhxdlVyNmhmQVUvc24x?=
 =?utf-8?B?c01zTGp5ZEtQTG1RQlVFdkJYQm5nWjZKL3Vzb1BiZHNGZEpUazNVNnZXcXAz?=
 =?utf-8?B?YXZYeCtkVzdHSTNDa2pkK0MweDBOakRRa1d4RDFUVnNSek0xcnVhSmF5bVln?=
 =?utf-8?B?MnhjbHBlcHlSSlhCU000R1BnWnNhQzVZVERYY2dvbklMcmxkbVpWM1REV2JO?=
 =?utf-8?B?SlhzanQzTWx4SGtFN2VhZGR1VU5MYW1ZSFZxSS96bnh0NEFqeGZRQjBWNGZi?=
 =?utf-8?B?UTk2WXdkT0g3RG9yNHN1Z2cvR041QzNoK1A2bkFNSmI3dEtCdjk5Nzk4RnYw?=
 =?utf-8?Q?Z4fgHoKW2FGG0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab44fd35-08d6-4b02-c8f4-08d9698870d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:28:18.1009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yPWmuIzmXFAMXti2xZnZeamLrg01uoqEE7PHtCrEb/ueMFfGXdMuWyFw/wl6k2ijV9vfhTfhLna909bOO1tZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

I don't think it will start/stop twice because 
amdgpu_fence_driver_hw_fini/inint is not called during reset.

I am worried about calling drm_sched_start without calling 
drm_sched_resubmit_job first since that
the place where the jobs are actually restarted. Also calling 
drm_sched_start with false flag  wrong here since
it skips all the pending list handling.

Andrey

On 2021-08-27 7:34 a.m., Christian König wrote:
> In general that looks good to me, but what could be is that we now try 
> to stop/start the scheduler during reset twice.
>
> Andrey what do you think?
>
> Christian.
>
> Am 27.08.21 um 12:40 schrieb Guchun Chen:
>> This gurantees no more work on the ring can be submitted
>> to hardware in suspend/resume case, otherwise the ring will
>> not be empty before suspend.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index b439eb7d4177..d6e429e63604 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct 
>> amdgpu_device *adev)
>>           if (!ring || !ring->fence_drv.initialized)
>>               continue;
>>   +        if (!ring->no_scheduler)
>> +            drm_sched_stop(&ring->sched, NULL);
>> +
>>           /* You can't wait for HW to signal if it's gone */
>>           if (!drm_dev_is_unplugged(&adev->ddev))
>>               r = amdgpu_fence_wait_empty(ring);
>> @@ -611,6 +614,9 @@ void amdgpu_fence_driver_hw_init(struct 
>> amdgpu_device *adev)
>>           if (!ring || !ring->fence_drv.initialized)
>>               continue;
>>   +        if (!ring->no_scheduler)
>> +            drm_sched_start(&ring->sched, false);
>> +
>>           /* enable the interrupt */
>>           if (ring->fence_drv.irq_src)
>>               amdgpu_irq_get(adev, ring->fence_drv.irq_src,
>
