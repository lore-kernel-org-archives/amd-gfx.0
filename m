Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6872A1061B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EB510E1EA;
	Tue, 31 Mar 2026 11:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvxXozZj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE10F10E1EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAvIQbeHsbrl+HlpDSbP2e3/mvfzQKPXp4et68EBhbzbHDSjrC362MYeqgjPETI2hl9Lpa+uMx3LcbKhWEhgu+oL/oAbHzGynp1HW+xzEANt5gOYA7zgPo+7UuGnqAPn+UqcFr5ecH9XmMHsrL64a/NpJlq4J85zN2dcsIN5aMqLl4NA9pFIFfBh/cmmQ4vQBiveGcY2pimr75jVe2WmpNrQI8XagOJwGIlhYayDKVKgxys9piiAyGSM1pzokZoFl094ciWv7ta+Ctykh3H7Y8zM/paaKzqOW9qWkwqa8c8bL8gecjgPqU2cPM4NHf/676EATRLbJam07PkyrNvxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP9oylrW2FM+X7cyvwhP2kDEQVmnZWqvMlaw/m7sXYw=;
 b=envEuZz7EzGbJ76QLPrLtPHt5/VTdsSbiD8/cC6GqwH/XesQ4ILp4ygSPqeP/xHb3DgVLU+7oyl4yyf92Uyuy/akuOAqv5fmIjCRCaIxU+SJKVz2t/xJCGpDr5oQIe5THZuP9ze2mik+7Xdna2Or20Dau3ZXah+tcpYK9tZ0zrtSWN6zJVQ4YnAQLOVsOzQfOUo1CjVqTNWG9Xg4//sAsTJ81+sb96ANNTt/K0bpu3bp6914pQ36Lde8BmS/CIYc5hPFSpvaopP6TZSDaUPlK/DTj94Kvu+aspo/FOINEI3WXhVQpXOldD99KsoZ7Lb0Zk/zL6hRCXY3aujQJpzPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP9oylrW2FM+X7cyvwhP2kDEQVmnZWqvMlaw/m7sXYw=;
 b=mvxXozZjlfTjDAf7fGmi4uw4INlil6AIWPxdO9d53drpGFOUh6BPAqaLfz+p00gaR/JYDiXBmLTdarXIvufauhV9zuUR8vWQVjxMKvJhEj3aJMVd0MmeN7l0taK/1ibQsq689crrhmglwyq42emJCawubBkBIUDs0NPJeS/Rq0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:55:41 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:55:41 +0000
Message-ID: <d3103968-d0d8-4885-87a8-4953b63ffd1d@amd.com>
Date: Tue, 31 Mar 2026 17:25:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 1/4] drm/amdgpu/userq: dont check return value in
 amdgpu_userq_evict
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331074943.2510941-1-sunil.khatri@amd.com>
 <20260331074943.2510941-2-sunil.khatri@amd.com>
 <6e408ee6-2855-4845-85be-296b1e6108cc@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <6e408ee6-2855-4845-85be-296b1e6108cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0038b6ea-4882-4f00-3c6d-08de8f1c6eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: gzgqi2jjbXSpUDp3tSjhBxwCb9dbAoy4rtedKLTEd/PQFqFuXtmoqSdN45iNjqZ78lFHeVCsKTCJX3J9JnZOeA95T26d4kg++jnFI0bH39hSxktukBVCyjKB4Am9Z6LLTFjuXMnB3wS/vPRMoqut+iSRlbTB/vi5Bgu3S+dJbXxpTt/CkLYUYl8eED3qBIkI4wmYHJ9VE8piNIiV69e80q/0dsGypYTISpZiAj74bSOlHwmuCXZrsDzWw0uDQlUKifzw+zZLenQ30AO3kR5SYirvGNpx489DmagGYSxSU64VvTy1Siz7c+PkHWXLlsUQU4hJID61vPSDvpCgSEYl4OgVQDaMZzVy8ve/MjICk+zmaFbalCYf/CuvbSj8z5Bw5obZT3HzCCzDqmgvTboUPvs2/7VxpQd6Trx4Xb33vUmLCqst/txBnhjWhjgkAnGr42v1AHEjiR7GBBxk4wOySoS/JB7cCEprhaaDbfEM13u9nxB87Kh31WpcKqGqXsSMyf3bOTiYgWwFT6zYrF3ux4jVZqEBEO3fBXGEVprgBavZGYTmAu7T80R3gdRFkiFsLMMdGVfV5i9ZJ+ZPKh+DILmkbIb+hBtRsxgvE7l6JUzN6gEZFm92DEsHJn4xuUC3HV5/rqUasi9C0rYTwYPzqE+6uVyoBD9FRW/uxty2omMEWoWW83d+XAF7d3SMMn+N7RFhds4KBEFev6yEw6xD5te39qokDef6RkRDtnqnoTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVM2SzROZU9rQVpOT2JDcnQ5MGc3azdNOTJUL1R6NFYyd3YwZ0JXTTE2NUVz?=
 =?utf-8?B?U2tlMlQwR01IekM4eFFhUFUvbnU1QXJxSU5tbDNuUXBaSDludlNtWTBDUUtF?=
 =?utf-8?B?cm01UDF4MC9URDJKdmxIOHRQN01NeC9VTnRKZ0w3VmhRU0x2bFZ1VHZQVFRi?=
 =?utf-8?B?YWN0K2JZMEE1RFFCY2I3MWVUMmREbDg1cWxGa3lNdGFQMTNvRTBIU1lvdVlF?=
 =?utf-8?B?eXhobnZRdzRxcjJnbU5SZjE4bU1GdTVNa2NUZTBmelB4YVdNbHpUbGtyQ3dD?=
 =?utf-8?B?SXh1eDZZS0xVQ3hyNTNjZWpQQWpHYmRsclZ1T1FnNkFVcU5tSlpSRkU5T251?=
 =?utf-8?B?c0dONENBU25mTjJ2SVp2M1daNG5TVFVFYkhQeUNXb2dOSkp4UVZ6MTBmemxa?=
 =?utf-8?B?RTZsVUdQU3VEak0yTkMvc1cwekorNkRta1lsQitlSnJEWHQ1WGRKOHBFZlBI?=
 =?utf-8?B?eGdDUUtWVHlkS3ZTeXA4SE5SWFJ2WHo2ZlI0SVZxV3RCQVNLbFl3RStIdlpL?=
 =?utf-8?B?c3hrcUk5Y3Awb0s2VVFSWlIvcWNRZWdKNGhodWtkcWZqRWR1RGVyUU0zMjgw?=
 =?utf-8?B?N1lNQllJUUhWd0xNaTVKTkNUY3hQeHRZT2RydnFDUE9ET0xPY1h5eGpmeis0?=
 =?utf-8?B?eDAzSEpxcEZOTXRBSEJOcURCUnpScy9ua3hBN0NyM2VZeDlvVnY4QlIxQTNZ?=
 =?utf-8?B?TjBIeTRzN3VINTFDV2xpczhCc2dodXI1Yno1cnFYTlEvWXdzY1ZsY1c3bU1K?=
 =?utf-8?B?dTNxVU9pWXk5c09kN2swVzVVb0VYaTRuL3pkV3BNdmVGSVh5WFdZbzJpTGxL?=
 =?utf-8?B?bFVuZGdNTlNsSDdyM0l4ZlJMM1UvV1prMlNlQUFuWldnK0pXLzBJUEtYMHJE?=
 =?utf-8?B?TGVMcUx0bllOTVV4NWhIdUI4bW5GSEx5U0FGSUVYVFAwd2licGlaaE9Wa1V0?=
 =?utf-8?B?dldHN2prclI3amlHaWN0d3VqeUo4MUJ3T0NlR1NwOVUwM0dDRTc4T2xRb0d1?=
 =?utf-8?B?OCtnazFzK3hiRGRBemlpZ3B0bzRJWmd1bFRTN1hRU2hDMzdiUnRDQVRGZ3ZF?=
 =?utf-8?B?WHdocWVMY2NiQTJZeHZzTlZsclBJMEdsT3VVVW9vOVJzVWJkSjdiRE5IZ1p3?=
 =?utf-8?B?QWhlS0wzQmVTMmsrUnorRWZucldwd3UzRjI3MjlseWRjbkVLeUN2anZ1akZQ?=
 =?utf-8?B?akg3OVN0a1B4OFNzTUV0TkVFS1l5djZWT0laZVl1Q1lZV2c5OFhBUUpjaFJ6?=
 =?utf-8?B?SGxmbGpPWlNuMWg5K3M2eTNUMGFZWWtNL1ZScHgyZWN1QVA2Vk80WTIzbjlK?=
 =?utf-8?B?Y0pUcThTb2FOREx3cXoxV1U2QjlocnRzQk4wbFhDWVRiVkZIOS91ZzZUQ1Bi?=
 =?utf-8?B?VDE1SCtlY1l3UTlVZ2pzYlBWeURQMnp4RW8xTVdZNW5NQm1DL1RLWFVKRjFX?=
 =?utf-8?B?VEI1TUNzTTNIMWtFWmNqKzRXOCtJRmR6bTNJMU5jL2xhOU9UZHpGaVdJU3Az?=
 =?utf-8?B?MWtPRzVLMFl1MTZmZ0o5YlRWSzU5b2NOdWkrMzFyVmJickFSN1R3T2dOVjh2?=
 =?utf-8?B?MGo2MFMvTGNLUVpWTy95SUdsQ250SVdzbGZURWw2YWlVbDQ5V0txcXpZS2sy?=
 =?utf-8?B?V3FJY2RGYitEaGFQOGR0c3Z2YlgyMnlMbHU3bDF2WG9KdkNiSG93enArSGVn?=
 =?utf-8?B?czdkS09ZL1dNMHIrT3I3ZktXbXNkaHJ0V0lMTjNOd0h6c3BtdG9INHJNT2Z4?=
 =?utf-8?B?WXh1S1daZmdvVEtuLzJ4R2N5ZEdXU3BINkZFRWxJc05ncFhEbnhlNXdtYkxJ?=
 =?utf-8?B?ZXliTHlyZ0dDNy8zR293NS8rSGpwRjFDQmZwMlRkYS81b3Jsa2R3WVlOcUZw?=
 =?utf-8?B?aGR6RUFFOWpDTHU2SWs2NGFYbzEvVFBzMDZEcE1YQ1FyMklralQ4b092c1ky?=
 =?utf-8?B?clp3ZU1TR2ZJNkxQanVWY29YSGJJWW9kRGZxc2ZITDAxbm1Mc0s5R2VBTDJC?=
 =?utf-8?B?WlBFcml6UkU0U3JrbjhwNklETkV0M2UzckV5WWYyQkEzZnBxV2pMVEo0OTU0?=
 =?utf-8?B?d3hjRVVqdmtJa0QwZkVLbjNZZXU5TzlFMmV2bU5NWVhJdUdYWS9sejdvRjBw?=
 =?utf-8?B?cFBsZWYycnFPb2pmZDRmZ2h1TnVjSlQ0c1hIVXF5Y24zdCtSQ0lnaFUxZkky?=
 =?utf-8?B?Uk8xKzVZZFlhVExlUHVzVW1sM2RmYnR5cmdaM2toN0N1cEJxVVVtSjlWTGcw?=
 =?utf-8?B?ckZUeE15S2pnMkE2aVFnTWdnZHkybWtwenpaQTRTa0R2WWlxbE45MitOYkVW?=
 =?utf-8?B?ZDlVSU1OUWpFdUl6VGlIOHVWbGZkQUZKYmJCb0szYk9qZnJRY2JJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0038b6ea-4882-4f00-3c6d-08de8f1c6eaa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:55:41.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlkHVAFZ24xNmM/bcHzcuVDFPAFCBWHaSG25RktOcbBcTFnTKYdJvwzjhdHl9GZHTEJl+KuNbdoqiF0slggh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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


On 31-03-2026 05:12 pm, Christian König wrote:
>
> On 3/31/26 09:49, Sunil Khatri wrote:
>> In function amdgpu_userq_evict we do not need to check
>> for return values and print errors as we are already
>> print error in all the functions of amdgpu_userq_evict.
>>
>> a. amdgpu_userq_wait_for_signal: Could timeout and we print
>>     error message in the function already
>> b. amdgpu_userq_evict_all: We unmap all the queues here and
>>     in case of unmap failure we already print unmap error.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++--------------
>>   1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index fdae8c411aaa..79ee2f6e09da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1258,7 +1258,8 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>   	}
>>   
>>   	if (ret)
>> -		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
>> +		drm_file_err(uq_mgr->file,
>> +			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>>   	return ret;
>>   }
>>   
>> @@ -1289,13 +1290,14 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>>   		struct dma_fence *f = queue->last_fence;
>>   
>> -		if (!f || dma_fence_is_signaled(f))
>> +		if (!f)
>>   			continue;
>>   
>> -		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>> +		ret = dma_fence_wait(f, false);
>>   		if (ret <= 0) {
>> -			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>> -				     f->context, f->seqno);
>> +			drm_file_err(uq_mgr->file,
>> +				     "Timed out in wait_for_signal fence=%llu:%llu ret=%d\n",
>> +				     f->context, f->seqno, ret);
>>   
>>   			return -ETIMEDOUT;
>>   		}
> You can completely drop this. dma_fence_wait() will never return any error when used like this.
>
> Apart from that the patch looks correct to me.

Got it

Regards
Sunil

>
> Regards,
> Christian.
>
>
>> @@ -1307,18 +1309,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   void
>>   amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>> -	struct amdgpu_device *adev = uq_mgr->adev;
>> -	int ret;
>> -
>>   	/* Wait for any pending userqueue fence work to finish */
>> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
>> -	if (ret)
>> -		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>> -
>> -	ret = amdgpu_userq_evict_all(uq_mgr);
>> -	if (ret)
>> -		dev_err(adev->dev, "Failed to evict userqueue\n");
>> -
>> +	amdgpu_userq_wait_for_signal(uq_mgr);
>> +	/* unmaps all the queues */
>> +	amdgpu_userq_evict_all(uq_mgr);
>>   }
>>   
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
