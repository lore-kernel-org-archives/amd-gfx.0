Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0E606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iatNXzNX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CC710E62E;
	Wed, 28 Oct 2026 12:53:33 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CAB10E62E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 12:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP1MrMewEEXIAeGlBdqXLmkr1B2lohv6olDDvEw/d5qUUuhT5GhgciQz9T8ehzyt/d6vu1AiZfjvG/RrgNzghCPMTx/1a78AI59qvq14vifKyeStsemnA8wEz4y6quAaJxqqNRKo7i7RuhOGofFVehgPmlr6mWeOdRNxK1Y92L0zU9IqSeKzkTmYU66Dhd1EoSRDvYv4AR5ENIjk30sAOQ/GH0k/ksuP3DdZUCAb39ccjKm5M0KWeZYsSy8ew+XChWyRkZHWsxay6UfdS3a7RxlJ9QnQzM1iYkTtE4vqCCqpMCY7FA3MUvsugOraeZOMpr7H65ksuBxvhv9FF4b0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3u0lCYmV8o4IfkJSXfqz0cQkJBVnSCwiUlivzYtAdQ=;
 b=ouiJFGYoGVV948QXPpHoUqOrkM0TtvcrAx+V2CiqJ5rktiNaT1icpCndBBh3+C8YZyPBfrVlP9AQrX+pwq1T30KYq3JL8btbjlDekVwXTpewLObQmdk8sVTwvvmUVyGvB/GEDTZ3phg+LyIiH0ntpDdwHJt2Pez09uAKL2LiAJDJ7iWID9YRsvT/IRbWPqLkf/app6ZFGKBt/tmPD0BWiuLMkUtFuBvB2MYIEqAhn7yRBAktdTB42PsIbt3lO8wngAIlhjlvcfbv9LbLQZKjxqkzvyxzEG7Q60BXshXsYC7HVnnwoF9nb3Nz1ihaqUhnTyH4K8HI4xv8+FW/96gYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3u0lCYmV8o4IfkJSXfqz0cQkJBVnSCwiUlivzYtAdQ=;
 b=iatNXzNXeCFbzuF3M5b6rcjbWhmnT609MjVY3Fhzi13Q+3QdaQ155Z3vwQKmiM53iJI7sC/UfJQtLpf091fAaHXcNpjxdc7PiPEiRTqN+lnAWkXNang2HJRk6lEn5c+uUR/NyGGMKU12S3plN/oe+6Aq301MsMdBJ/dds0g5f5k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 12:53:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:53:22 +0000
Message-ID: <e0945308-126b-4fe9-aa0c-9651bdb67604@amd.com>
Date: Wed, 28 Oct 2026 18:23:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdgpu: Add xcp to reset_mes_compute function
To: "Lin, Amber" <Amber.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-2-amber.lin@amd.com>
 <870e73c3-a5e0-4f05-94e8-c9a2ce5bb971@amd.com>
 <CH3PR12MB504406D5E7AC97A15714CCE933E16F2@CH3PR12MB504406.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH3PR12MB504406D5E7AC97A15714CCE933E16F2@CH3PR12MB504406.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::6) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fefd1a-4cd2-4647-22cd-08df34f2724e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: CQs9bkqsNeRBXHDIzVmU4f6MxsLVVv6QrKKSLuHpg/1IRCHv90ZHUrnN2LKiXlSFcP7jhsj+IQpd6mCLGhPueG9FfTrxfaMXXzzlGu6RtwiO7DfI21A1dQeolFOelpMjqKwXVGq2jRsQ3Lq6hadnP+hVNSmaPub8PRtUkcFsieFlBfy7SUNvbfFrL2lBfIn53A8njLqQ5Q396zC8h/0jzVLmtaHn9gSJwdWp9J3LFd4cAQxTpA/Cm9gFx2pfGXuNGT8XVWEbH7AgT92N0arVdtGzRy2uIIKJl9RMhCaEJWR1VPKfLuzWDUtmXMBmQyTfQsK8YIGw0elnlITM2QvLtY8Cybjhju+OCd6PF3ywmi7Gsi4DswcysA1YLuCXYHsxRsfwfpcE+IvbkeSGGJjRkTVdFljIWc0vEr2X8gpozhEjA6fjK6bvV+NcG3GL0qJhCW8j4NUddevuB74M6/wIzFecNFsZ4imn0mljAXKZHK0E0CFqqwBISNeaOwRFMRrhIv7RUnYWfwyx3iHITgWPRP5YUqLSiAyTaasioIyvHII6vg3Rqbyt7lgL3Eh3WV2YawgEVQWy8ACgLYzzcbRFLbpWfg0lSmBsjYgeDfLPrnwrWrpIXPO0ayfBQQ69U1NYp1odmIAMkUx64vs4r4P3Ji3fNt9VNrMEvC1lkTJagGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tSSDB4VDFiSWhQenNSdDNHNnlqQkZJU1lCZzRtNjROZ1pVNjVOanN1Y2lO?=
 =?utf-8?B?Q1ZPa01SL0Q3MGRWMDNYNUlVYzZpN0xMMXlFWUlCSVVIRVFHTEhLU04xYk9T?=
 =?utf-8?B?c3U4aXRCQWlXVzNLOXdIcjBob3p6RmQxQnR4dHQyY0ZiK1ErcjJzcGRHSlZw?=
 =?utf-8?B?SzB1UzRUSTB2UUhQT2IrcE5HSVkxUEVFTFVjNjZMeHA3NzhFZ1lPWjhzek9B?=
 =?utf-8?B?dzF3azl6Wmg0VEU4eHNYUmpRZDEyWlZhdHRTZlhQMTVIci9DOTJEbitXZ2tG?=
 =?utf-8?B?anFOV3dhUGlDZ1FiNFlHb0Q3UjdHN3lpaXpiUXBOcG1NVTM3TFNlcXk0Y1Zi?=
 =?utf-8?B?aW5QQ3lnSW1nd1ZOWkNkNmE0VzNxUzdvMjVxZ3ZDZGtscElRY3hwOUFzZ1Nu?=
 =?utf-8?B?V3NpUUVJKzIvZktsWDlyL0NuOFAwaHZJUjN2cGNmdnBxL0h2b3hmYjB5NVNK?=
 =?utf-8?B?aG5KQVE1WDl6NDM5aFltSjYzU24yWGJZNGtHU3pXTzJGZmpxZEp0YlFNclJI?=
 =?utf-8?B?ZzZ5ZFVWMFNZREhpVkM4TktGemp1QVhneS9rbTFON1o3ZUoxb1hhQkRPL1FU?=
 =?utf-8?B?dCtQcklpbkdKUjNUYXVBVlJpNmlSTFFRTER0dTFCQTJtaTNFWWE1bWw4NzJX?=
 =?utf-8?B?KzRLNER2QXVyUmlqZElyelIyZDY0cjlUY0R6V2xJZklEOTJlblUzRWVabUFJ?=
 =?utf-8?B?Vkova09rT3NrdlBQZFRORHE2L2t6Wk9NNkhpOWFnWXY3SklvRktuLzRlTTNH?=
 =?utf-8?B?aDBGNURCMjI5b0QzdzRuNG1TM3hmZWNLNUc1YjV6MmdYd2VNQVNVdFJvTUZ6?=
 =?utf-8?B?RmQyVnZZVDkxQTc4b1VVV2drTzZ3UUxMUjFkY2orWlNnUGRpZVNpSFVlNzV1?=
 =?utf-8?B?aWdpbXdBUVBmaGNxK05CTCt5NzZOZmFSamFLOElUczFLNlpqRk1xOGpNL01a?=
 =?utf-8?B?MHQrTHBxN0dzeEVhWldSMTJBbjJoTFRHMmlwQ1lqRmg1S0JlWFdyVm5RbFB5?=
 =?utf-8?B?UU9EYjY5RnQ4b0lvNjVQODdoK08wbXB3ZE1yZlFBRGF6TTJFdDFhaUEzWGNV?=
 =?utf-8?B?eXVJMlNIVm1LTm5ORTBKWVhzUTc3aHo0NXdhUEJVNGJYMlBJdEhkVVFNbUZP?=
 =?utf-8?B?aFBGMzJBcDVSVk5lTklaSmU0cUQ3VEI3d1BzQVprTGU3L2hucmdnaVJISmNu?=
 =?utf-8?B?RHdGM1IwbzNhcU9pYXQzR3c5WnYzRVRVWlYxN1VjVTlQVFdRbHJZaXFCR1Iv?=
 =?utf-8?B?K0I3TFBhS2RGbVA2alFkU2dxbm1ER0c2Tkt4OG5tZ1pkV0FwYTBjUXpVbERG?=
 =?utf-8?B?Z2p6L1pTTkI1Tm8xUDlTdENqcSt6M2t5Nm5teGxkdWdJUk5sSm5vMFJBV1V5?=
 =?utf-8?B?WTZwaitCMzNQU3AvNnNYSVp3WmY0alp2UnlyY3NFOVplUXZLUmJiTDVRS29O?=
 =?utf-8?B?aHNHMVFHYlFIam9hVmdDdEh2M0ZycVQwaDFjYzlHaWdkVVlYWEcwUHBaRWNT?=
 =?utf-8?B?ZTI4QnExR1lJcjZqOUNaS3Rwb1l0UTZrYjVGSXg5bUJmQWN4ZVJVWStLUS9U?=
 =?utf-8?B?MWdGVnNaUzF1ZEJmVnQwemkxV1ZhcmRBTk42bDFvbkJaQnM2T0p4S3lIRFB6?=
 =?utf-8?B?R29rYnpJOXFtYk5JZWdBVkg1RlFGblFZQ3hXMCtlSi8yRXFhV3RQTEFvNmNJ?=
 =?utf-8?B?TUNBWnV3cjBKZ1VGOUo3eFFkTHpSekRoRVdnQXhTakZtQnpLbzVyeXZpTW1R?=
 =?utf-8?B?MkJRSk1BS0tRWWNaMUFzMnNCVXVwK2pWMk1DNTlndUYzUmhHMVVUSi9Lc1h4?=
 =?utf-8?B?TCtjeWZ3aThjeDlWNlEwcktNSGNXbFJXLzRRV2MvZ0g0bjdybm51WGRPVGs2?=
 =?utf-8?B?ZXh6dmVpNDIySjNLWm9RN1NTUkFDbVl3Tm9IQUI1bFhYTzZNRW55QTNrd056?=
 =?utf-8?B?b0tDeDVQOHBiYTZYODFuN0d1dHpKQWwyODFtdFFFNGw1Y2MxR3poUVJ1ZVlQ?=
 =?utf-8?B?UDFMYU5mdUZ4RlVHY0R5d21oQ1J0ckp4VWtzNCs4ZzZMWUdjM0diOCtFeCtn?=
 =?utf-8?B?TGtwejkxNERseUtkSVlKM3I3UlhVajNoTHp0Umk1R2N4VUhlM0RuRVFjdDhU?=
 =?utf-8?B?UDVYZWhuRno4WnV2QlowRGZyV1V4NmlNcTVPOWg0RTNSRjJrMERnN3hhdkg3?=
 =?utf-8?B?TU9HalNOQlcyYzJTREVTYmM4RHhuL2RGVTgrZmNxSUY5OEU4RFdXWURWdkFW?=
 =?utf-8?B?TEQ3TENkdDdtVFZrQTVGMEcwdkFYNGMvNHcrQ2R1ditudW9aNFNybTlaL0t1?=
 =?utf-8?Q?YNungiWqLYXOS/6/Ph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fefd1a-4cd2-4647-22cd-08df34f2724e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:53:22.7092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88AvTzU5WIuG0uK+LrhooLy3i/qcCu8A0gr5Q22CF6+uHlFO6c1cKH8I2SKWHUkK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28-Oct-26 5:55 PM, Lin, Amber wrote:
> AMD General
> 
> Regards,
> Amber
> 
> On 10/27/2026 4:41 PM, Lazar, Lijo wrote:
>>
>>
>> On 27-Oct-26 1:20 PM, Amber Lin wrote:
>>> Add xcp parameter to amdgpu_gfx_reset_mes_compute() so on an ASIC that
>>> supports compute partitioning, we can identify the partition's node ID
>>> and
>>> its master XCC. Pass this master XCC ID to MES when calling MES for
>>> suspend, detecting hung queues, and resume.
>>>
>>> Signed-off-by: Amber Lin <amber.lin@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 17 +++++++++++++----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h         |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  2 +-
>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
>>>    6 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_gfx.c
>>> index 0c1c8ae822d4..ef34f7b02d0e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -2470,6 +2470,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct
>>> amdgpu_device *adev,
>>>    }
>>>    int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>>> +                 struct amdgpu_xcp *xcp,
>>
>> Ring carries xcp_id. It's better to make use of the same (when xcp_mgr
>> is also present).
>>
> I need xcp_id (for KFD) and master xcc_id. When KFD calls this function, passing "struct amdgpu_xcp" can get both data. ring is non-NULL only when this function is called by KCQ (and I don't find any function to retrieve master xcc_id using xcp_id). When KFD or gfx user queue calls this function, ring is NULL.
> 

There is a queue input argument carrying xcc_id (end of this patch). The 
same may be used for mes suspend etc. However, that doesn't cover xcp id.

>> It's harder to read the caller locations with NULL, NULL....
>>
>> Thanks,
>> Lijo
>>
>>>                     struct amdgpu_ring *ring,
>>>                     struct amdgpu_fence *guilty_fence,
>>>                     struct amdgpu_usermode_queue *uq,
>>> @@ -2486,6 +2487,14 @@ int amdgpu_gfx_reset_mes_compute(struct
>>> amdgpu_device *adev,
>>>        struct amdgpu_gfx_deferred_entry
>>> deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
>>>        int n_deferred = 0;
>>>        int ring_err;
>>> +    uint32_t xcc_mask, xcc_id = 0, xcp_id = 0;
>>> +
>>> +    if (xcp) {
>>> +        amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
>>> +        /* master xcc in the partition */
>>> +        xcc_id = ffs(xcc_mask) - 1;
>>> +        xcp_id = xcp->id;
>>> +    }
>>>        guard(mutex)(&adev->gfx.mec.reset_mutex);
>>>        /* stop the drm schedulers for all compute queues */
>>> @@ -2493,7 +2502,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>> amdgpu_device *adev,
>>>        /* suspend all will determine which queues are hung.
>>>         * reset detect will return the array of bad queue doorbells
>>>         */
>>> -    r = amdgpu_mes_suspend(adev, 0);
>>> +    r = amdgpu_mes_suspend(adev, xcc_id);
>>>        /* if suspend all success, it should no hang queue */
>>>        if (!r) {
>>>            dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n",
>>> xcc_id);
>>> @@ -2503,7 +2512,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>> amdgpu_device *adev,
>>>            goto fence_reset;
>>>        }
>>>        r = amdgpu_mes_detect_and_reset_hung_queues(adev,
>>> AMDGPU_RING_TYPE_COMPUTE,
>>> -                            true, &num_hung, adev-
>>>> gfx.mec.mes_hung_db_array, 0);
>>> +                            true, &num_hung, adev-
>>>> gfx.mec.mes_hung_db_array, xcc_id);
>>>        if (r) {
>>>            dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
>>>            goto out;
>>> @@ -2551,7 +2560,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>> amdgpu_device *adev,
>>>                n_deferred++;
>>>            }
>>>            /* reset any KFD queues */
>>> -        r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe,
>>> queue,
>>> +        r = amdgpu_amdkfd_reset_mes_queue(adev, xcp_id, queue_type,
>>> pipe, queue,
>>>                              adev->gfx.mec.mes_hung_db_array[i]);
>>>            if (r)
>>>                goto out;
>>> @@ -2582,7 +2591,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>> amdgpu_device *adev,
>>>    out:
>>>        /* resume all will enable the non-hung queues */
>>> -    amdgpu_mes_resume(adev, 0);
>>> +    amdgpu_mes_resume(adev, xcc_id);
>>>        /* Now CP is running again — replay backed-up commands and ring
>>>         * doorbells on each reset queue.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_gfx.h
>>> index 5939e1fb3b24..26bbec8f92e8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -664,6 +664,7 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device
>>> *adev, int xcc_id);
>>>    int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>>>    void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>>>    int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>>> +                 struct amdgpu_xcp *xcp,
>>>                     struct amdgpu_ring *ring,
>>>                     struct amdgpu_fence *guilty_fence,
>>>                     struct amdgpu_usermode_queue *uq,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_userq.c
>>> index 1a2aa85c504e..7dfe6e83f8ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -153,7 +153,7 @@ static void amdgpu_userq_hang_detect_work(struct
>>> work_struct *work)
>>>            int r;
>>>            if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
>>> -            r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
>>> +            r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>>>                                 queue, NULL, NULL);
>>>            else
>>>                r = userq_funcs->reset(queue);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gfx_v11_0.c
>>> index 315dfd806d56..fdc0620ca67f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -6932,7 +6932,7 @@ static int gfx_v11_0_reset_kcq(struct
>>> amdgpu_ring *ring,
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>> -    return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence,
>>> NULL, NULL, NULL);
>>> +    return amdgpu_gfx_reset_mes_compute(adev, NULL, ring,
>>> timedout_fence, NULL, NULL, NULL);
>>>    }
>>>    static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block,
>>> struct drm_printer *p)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gfx_v12_0.c
>>> index d334fb805020..ec5ec1fd8b9d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -5254,7 +5254,7 @@ static int gfx_v12_0_reset_kcq(struct
>>> amdgpu_ring *ring,
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>> -    return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence,
>>> NULL, NULL, NULL);
>>> +    return amdgpu_gfx_reset_mes_compute(adev, NULL, ring,
>>> timedout_fence, NULL, NULL, NULL);
>>>    }
>>>    static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/
>>> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index ce67e56efa8c..0eb4081a5740 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -506,7 +506,7 @@ static int reset_queues_mes(struct
>>> device_queue_manager *dqm, struct queue *q)
>>>        queue_input.remove_queue_after_reset = false;
>>>        queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;

This one is also sending the xcc_id in queue input. This is the master 
xcc for the kfd node.

Thanks,
Lijo

>>>        /* pass the known bad queue info to the reset function */
>>> -    r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>>> &num_hung, &queue_input);
>>> +    r = amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL,
>>> NULL, &num_hung, &queue_input);
>>>        if (r)
>>>            goto fail;
>>>        pdd = kfd_get_process_device_data(q->device, q->process);
>>

