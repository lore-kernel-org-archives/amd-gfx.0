Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF41EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C755110E2AE;
	Mon, 21 Aug 2023 20:49:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF4D10E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh0M/Xa/uwO+4p5/iA2z2SFjS2czZwRZ0S3n+RAYixP07QE9Q8l9xqKO6tnwwToPLYvT0pdHJrDz7G1q9Ad6a4skoX+jGoN4qeBbBmJBe4GSGmnFOx4JXKJLXGDqvAwDhKDkma2A8N1q/3sB65JQSO0NNhpJtf7IwDSVMOFuLFINCaxt9JpO2nZUb93rusZmTU9QZKC7H7S/a6xkJK1J4r5c7zpUDeQso3MCVrzCPe4llRNJt1SmEDZvG/a090FQFtGJIDijOgUQfTHy+iMJQdjihpEN1ClvruXjy4jyBSh4rbmmhVHmOzyInWfcSUNuO50rdtfSbQoiqKiZGQklRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXruwFzgCxo55wozCTy24g4EQUjr5LajJltbNFijNrI=;
 b=bcKv6K5gjo+WM9GFwsJ9q4nnBsYG8k+DwtAZg+QVLQaIM1C3M0Wwe5ebmwNRQU+FBYC4ErqSiPcNvaKQQHtwwHt2Lgxuz7x1LfnZ/kfdw5Rnft5WyJrCq7rN9h/kAa3LPpJkj6jH0pk65+wWxJQMPg+OHIdxufEd7PC78W6gcOBVh4u7TGRsNDsJwORUZJaR/XZ2aV38ANgn3tL61udyE5iKrnTjnqRwklFuiBvyyls5CoYgbRUqJjktxsSAyRgwGwtHLOchoWyCUVrfrkbrRu30JyGMdK8zvHwmxy3ZdGAiWN0aoTOzwUAe0wixccxukoCcFpEEdjg+/8oN5vRO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXruwFzgCxo55wozCTy24g4EQUjr5LajJltbNFijNrI=;
 b=c0pkhNSPnmmg8xhqbmak1aua2z5DxTtCqXI0ToWZ+OR+lG6Eq7HOYOdDU5JIt4DddB1j9iUsErIUXzhKZUOHMj0dQ8LWdr5mZ58vRXndkWMnvr0nFUPXSzso1YlDiECiSil3V4TUYhFEIhAFxgokTlmvVNBWGwrmCDzfCtXv0x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 20:49:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:49:19 +0000
Message-ID: <e438e5fc-6088-3d45-f651-0ffa27af3ba1@amd.com>
Date: Mon, 21 Aug 2023 16:49:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
 <8210ebe4-b637-5aaf-c548-b2a4be718f98@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8210ebe4-b637-5aaf-c548-b2a4be718f98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc5451b-d494-4644-e623-08dba288176a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhrInda68KKcuOWDZHdInWh6Lo0pID7GuPxoTXqpnfVIxK0oaj+TZ7ZB05dmikUygGrVKwwN0QK5qoRXglE4iMsMnmJWSytXU009GYlGErtOcYX41zHcc20yM/m5/Axy5GJwTeKcZKv4ui/XUXnf9Wx7EOMW6vU2I6HysqAVfmvaiDdEAGkHWPOr2Wa/jrVOukjLw3LyRhzfo8s9sVXps9KxlVBNGaZtAc8PQpMyPK9oK0whQC1hXg+zToWE5TKUbRUv0fMSrD0UffVIYfV1ahqFu7j6rbIsozqUfKxB2iko04yYlvNjQKwg8Ds17/r+1QQPId5WbL7L9UlN5kNFpDQ8y/kraLMDJxOEJwUI7GZWU2rcEseLyQ1YGpm3zoN75vkyTyniMGFbnS/cpU+BcJdKib0BrZjjGBJHokEC1/fxoJmfLQyN+9nGcbJ1huqZ/zn2Ll9clZQBoQBsU3OAO8Vpotj9nINtrV2uzlA0UPIPsrGEeiMk0FP2kBuzJ5aSV5igbOMyOZ4W12qC+L1P5nUcmdDBNYQStTJOxsHpIUEeaSvb1cVXcvTEzBz9kIS5ugM6A2I6tA3zWhQ6N4Q+zYIh7FffKLMHqaC0KnpnVDnKq/DftbLSMGuzx9ZN9sM9W7+tov8B5uCTjr7Zx4VRJ4NJFBNIsaaek0sZR2BwAFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(31696002)(86362001)(36756003)(31686004)(66556008)(54906003)(316002)(66476007)(66946007)(6636002)(478600001)(966005)(110136005)(41300700001)(38100700002)(6486002)(6506007)(36916002)(6666004)(53546011)(6512007)(26005)(2616005)(66574015)(8676002)(4326008)(8936002)(2906002)(83380400001)(5660300002)(44832011)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlRMnBTN0c0RnVwcysrNFdmRCtWZWZmcDcvdFd5Uk5PS2ZaRU53eFFkWi92?=
 =?utf-8?B?M1VyN3dDalJHM1JyNFhPYjIvbkE0S010K0V0NWNkWjNCUDRLc2kwdndydE9s?=
 =?utf-8?B?NzZQc3VFUUNxWUdvbzY3bkJjcUo4TVVnTzIyM0x1cC9XZ1c2YkZDaHhJKzBO?=
 =?utf-8?B?YWltMnlucnhhZ2xYWStOeDVQaXFidG82MWJNWEx3TXJOUUpMMzNDY2dhOVEx?=
 =?utf-8?B?ZGdRSDBNRC9PbFArNjVGb1Vja0pjQkVzR3REeCtSS2oyRDBLQ3F1VzJVMDlw?=
 =?utf-8?B?Z2dVcDA3UzhKS0podjZPZTZnMk9lUDZYdDBZTVVxTHFDVkVMaXZTQ1FIWDVG?=
 =?utf-8?B?cndJZVJxREQzdVpLSFVNTFNIR2VvSWNYR2hMWjltREhRc29BaG5EcGU3ZkUr?=
 =?utf-8?B?VHJGV3hBYXJWOVRmRDNwa0Y4Vks5SUZ3c1dnZlZBdzc3MitNeVdmZk8zWHll?=
 =?utf-8?B?dEZxMjVCMXhid3pSK1ZOS2I0RmpkQkZTR0RKMURHeFJpY21nMjBnV0x3SjVP?=
 =?utf-8?B?ejlDNVNsaU1lNTd6aGtOQWh2SFBtYnR0amEvQUlqL09BaGVha1NCSlFlcGRJ?=
 =?utf-8?B?YjdMU0EyclF3bW5nMWs2djF5Tit1bGxtUngyU2FDN2RvbzFEWHRrS3B3VWU4?=
 =?utf-8?B?SElNUnBsUHo2aWNNWmJ3RTljb2NMd1hlTUk1eGwyS2doTHpQZ2RUcWtvb1Bk?=
 =?utf-8?B?NVBtTUFxQWJTK3RlbWJVWFBTaTNmTFg1dGpkQU8vNktHdUIwZXJMYmprdENL?=
 =?utf-8?B?TnA2c2U4eU5uOThpbnNmbVJHNmxnekZuUCtXZFkxMnAxdzZUTWExVU1mcytj?=
 =?utf-8?B?N2JuRVZlcXhjdkg3bXVZMG1jUmRaV0tBYWhjRThuVUdUaXFkK0owdjQzVFVh?=
 =?utf-8?B?OUkzMXYrbHVuWFFuTnRTcDZZN1l0bHF6bDBGbXBuaVJ4YnFvZ21aSmp0K1hK?=
 =?utf-8?B?NVArREpRYjVaaU54bTZTbDZnb202RDd4a3BwQlpTaWkwM2dTRWhyUStzUWRp?=
 =?utf-8?B?NTlIU2srTWt3aWNuaG0rSlJLWllwR25FMFJYQUxuUnlyY091SkZMUkZKM1Z0?=
 =?utf-8?B?UHQwSWhqa0dUWlh5azZnV09aK1ppM0dMOGYzKzk0Ni9CaXZCTU4zRVBtOXZq?=
 =?utf-8?B?THdINytYUi9pdC9wR0xHOXBuczFpNVZ0cjBGZndvOUZ1Zk50L0Q1czdNdEx0?=
 =?utf-8?B?N2ozbzhwMzlrUFlObDV0aHVNN3BpTHVSNFB3RzZFeWVFaHg0RFlocUdTSXpT?=
 =?utf-8?B?RmFHN2ZrYnQyUWpRU3lOMHZTRW1oRWVzR0V1d1NFRE54Y2JBQXNsTm1HU1Y4?=
 =?utf-8?B?WE5oN0sxc0ZlSmtYbGZpd2xOVWV4dTB2ZGVWRThPcXpJbjRxRlM1dGI5V0tZ?=
 =?utf-8?B?S2hob29ObVhESnlvQjdTTVFwZk5qWWtMbkRzaWtXeHdMM29YeC9yODhxNUw0?=
 =?utf-8?B?SVRWNG1oK2Ixc2JiMVBVbTI3R0N1YWRUbGRpZFpoOEpmYTVIRExCWm1sU285?=
 =?utf-8?B?ZWYxYUx2V3U4cUJRc1FvYnpxYTVDZkh2TkNJZXhic2Zqc3EwMlR3dVNlRmVk?=
 =?utf-8?B?OUl6dE1DVEVXU2ZzcHVWSm9TdktmYVBrUFNSbFB3NFIyZk8xNVBzOHcrU3Zw?=
 =?utf-8?B?MlZsQzJIZzlIN1l0OFU1cTltbGQ1VktvZWRyNThreUZLUnZucERiVW9OQWVK?=
 =?utf-8?B?QnlnVlA0WlFwN3ltL3F0Nzg3UzdmU0ZySzRFV21EMW5RSkwvS3ZFMmRpUi9v?=
 =?utf-8?B?cWZHL0oyc1ZObkhBbis4Z1R4R3VXaWQ5WVZxNzVWWW1nYnlNK0p4cit1anN5?=
 =?utf-8?B?NTk0aVpBYi9xYyt4LzFSd1djLzI5Z0dHZjA3cmZzekVwSm5mY3kwUzV6SHF4?=
 =?utf-8?B?MFZVbEpOZEhwdjA3MWRRQVJGbmcrUUIrMmp5eG5OMmZ5eTdvcG5HY1VEUWJO?=
 =?utf-8?B?QmgwVit4SGZUaVBYQktnelZjcEVhdEFKakRjcld4ZG4vd29PNjlCZ294ZFV6?=
 =?utf-8?B?M0JzWnJVVmVyaHZpT0R1RTlWaTNHKzNDZk13eEx2VlJnR0xOZjFlNVBYRSt3?=
 =?utf-8?B?Uk9zQWFpcUpJaHRwN1RQQ3FkWGxSSWpDZi96cHpOZDRrWUlGQnJWM2tXNS9Z?=
 =?utf-8?Q?b/ps2Oe3btWqCsjBGsIZ+XEkK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc5451b-d494-4644-e623-08dba288176a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:49:19.7313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idGxU+vKaQ3eQyOhwhNByvny7x/PmkGuPXMMV8vnICzV9tNrrjkicrnht3dI+KOVu4Q5ULkyE5ReGww2hBiNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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
Cc: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Would it make sense to include a link to a better explanation of the 
underlying issue? E.g. https://lwn.net/Articles/624126/?

Regards,
   Felix


On 2023-08-21 07:23, Christian König wrote:
> Am 04.08.23 um 07:46 schrieb Srinivasan Shanmugam:
>> Instead of declaring pointers use READ_ONCE(), when accessing those
>> values to make sure that the compiler doesn't voilate any cache
>> coherences
>
> That commit message is a bit confusing and not 100% technically correct.
>
> The compiler is not causing any cache coherency issues, but 
> potentially re-ordering things or reading the value multiple times.
>
> Just write something like "Use READ_ONCE() instead of declaring the 
> pointer volatile.". The background explanation would exceed the 
> information suitable for a commit message anyway.
>
> Apart from that looks good to me,
> Christian.
>
>>
>> Cc: Guchun Chen <guchun.chen@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
>> Cc: Le Ma <le.ma@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index f413898dda37..267c1b7b8dcd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -154,13 +154,13 @@ static int sdma_v4_4_2_init_microcode(struct 
>> amdgpu_device *adev)
>>    */
>>   static uint64_t sdma_v4_4_2_ring_get_rptr(struct amdgpu_ring *ring)
>>   {
>> -    u64 *rptr;
>> +    u64 rptr;
>>         /* XXX check if swapping is necessary on BE */
>> -    rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
>> +    rptr = READ_ONCE(*((u64 *)&ring->adev->wb.wb[ring->rptr_offs]));
>>   -    DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
>> -    return ((*rptr) >> 2);
>> +    DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
>> +    return rptr >> 2;
>>   }
>>     /**
>
