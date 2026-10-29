Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D21606A335
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RrlN5QIY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D89112107;
	Thu, 29 Oct 2026 09:29:19 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38526112107
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 09:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpdNe10nfhHcNbOUpHWeqDGG+XfQmeOAoFjOi7++3peGhN8l2BL7sF5iinfqHXkBRK6AkqDoKUI5/S3BGLiZ9vhYzQpyNZsDZVEMGIT+HQZgh9sM8aghbOrbNY+Z7R1W9crZS2aLirIRP2JWzfTzahm2IgNDbMHBGT3yRhUPj/lC43cVQAh0k8CR8JdHbUWQH03Kh6YM6FLliDmum2a36mOLurUWjNtz5Rjp3sE9xiUJcqlI2K6mqv+E9flZyYrTq6SppCvwXpYuw9TsfvNJVypqPdocpGH1pGLEjIna/y79oDDWtXjwbvL9YF7F6IhqH5DJ6cOvxIBGOxNEM4/P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU3RHqbcfsRp04pbxjRdRsY0t37BKsevuFBv9XkyCmk=;
 b=t+Sc9RXJ9DGXLzA7WUvNtsap/3gWzdj5oiaMxmhDu637JJ1bVqIv/EJVVsQhs+vxHOcp0neh0MXTtbtZTHm3jJ0Kmj7yUE/gj4VVHxslTSdM0Sm3/viAd94SLq3c2e6yVxL1V//EB5u4skMZL04mVRmEqVTc42dVcPtb8xtiBKqR94na4BIJou2y/mRSGUX+4lPi5ClR8M27f1yLJZ1bWjLoiPc26eERaHwSRBZiK5Hy99mV5xWTJ6r0x+owwsf4XolmLygL2gwmWEPfTZmGd5H3k8LzW76XDiOstp5reJ9LrlLSbCbQ3d3mv+sA1dlEXr9xs3kAu1imd7f+daWD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU3RHqbcfsRp04pbxjRdRsY0t37BKsevuFBv9XkyCmk=;
 b=RrlN5QIY0zyXaUM4RXXLLy4kPCCrw4ON3TrkCjYjNU6a/LYdMvwB3oDec6rbNQ392+krA6hko0v0+qxfNx1R921bjopo/+iXoya7JTKnAcF7F4UMvhJSxJGHwOQx/rwwOMdC+X811NqH4alYJC5hYezJB1KmdQIzHZJyb+0mHXI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 29 Oct
 2026 09:29:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 09:29:10 +0000
Message-ID: <d432a21a-957e-4741-b858-e1c94e0ff85e@amd.com>
Date: Thu, 29 Oct 2026 14:59:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdgpu: Add xcp to reset_mes_compute function
To: "Lin, Amber" <Amber.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-2-amber.lin@amd.com>
 <870e73c3-a5e0-4f05-94e8-c9a2ce5bb971@amd.com>
 <CH3PR12MB504406D5E7AC97A15714CCE933E16F2@CH3PR12MB504406.namprd12.prod.outlook.com>
 <e0945308-126b-4fe9-aa0c-9651bdb67604@amd.com>
 <CH3PR12MB5044068F21F5E70D8160AD2FCBE16E2@CH3PR12MB504406.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH3PR12MB5044068F21F5E70D8160AD2FCBE16E2@CH3PR12MB504406.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 52da4a2d-5412-4e1e-3a1e-08df359f1631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|18002099003|261026140227099003|22082099003|10067099003|261028144727099003|3023799007|261026121527099003|261021123027099003|4143699003|11063799006|261009223027099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: 6GK2xBPiZ3tIjEC9+EZcc7RP5tKRZE1BVwdFjsRORN+GDJzuhCIYg6obZFe/56GCoPuVF8LqnYQQXFBvu0tYXJZ5wgWwKeUD/LPZyyLJAiDjhfLHdmmiAa1Odip+ReWelnltD0+AnX5EnyN+z4HP4Mg1NDDRlbBq2xKHxCrqmO86g0pS6tgpHD1tK0G3OzltVVIeRTdyZn8yNdXm6dexcYDicVJSOBHZQIQn5LloTwwQQOpMtWVmR7Z8J4jdkY7WFO/MPq3cTtXpl/4GKlzStlm76htOyPOIPBtzv4bpVoQNds/lWCnbb0J5v3GZAZh6nehit/ZtI268jW0PyhYqXggtH8/wmPQijxnDV1KSe6iziTIrPwCvS0cRIuNz8XpuWdx4K7Qf8Xc0jXI9Wf/8atQiihMF0SthgL1bz87CR26rVBzqluZ4axDEPH54ISPM6gBnVIU4bMhR7j4I1KWHlXRp8JclMAwSZmPgLf3Y7xEiv/Fy9jW57VBB6r7ghMV+nyEqjy0RpxF0DsNeSEOOoj2+FSDPJQUcHsu9scrxdJcYUW9mdpaFp1CMPgoOVDASUU+rOOjq/YvM0eWCoqxgL1iIdD+MlOiRjAW7PB1yl4j3p1ECqG8pBntLhrNv3dH1OmqcEVqjCC3jduO1FW+orUDNtNA4+BBspCwuCG43/CU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(18002099003)(261026140227099003)(22082099003)(10067099003)(261028144727099003)(3023799007)(261026121527099003)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9OS2dNQkptUVdpS2Faazc4aHkwdU1LdXdiL3V4cjBhVTQ3UGR1am1KMDd1?=
 =?utf-8?B?ME9SYW8wKzRtYVR1bi9VVVBURHBXY015MHVYVEJONWRRMnJoRDBKLzAyWjN0?=
 =?utf-8?B?V2JEdzJqVVlnd2RyZmt2VTBnVTFPbmxQay9oWHhLU3VEcHNXeXU5MDVXSTc3?=
 =?utf-8?B?UFREWmttNklSS1BOa3BCa0Y1NWY3MitWbXZqM3FUMTVoNVZwVFM5a0ZrVG5D?=
 =?utf-8?B?d294SThpb296OXZRR29lRlErZ1BHUTcwaHRiMlllMm1mSXdwTXk1dHh0TUkz?=
 =?utf-8?B?UFp1Z2hNU2FTdXhWU0Z1Ylo5OGJsVGcxQTV1S3pMTlMwOHJ1dytoKzVKVklM?=
 =?utf-8?B?RVNvbTBGVW5CUXdlTWpQWlhKTlNRcThtUnU1cUFYdkJqNXh5ZjZIOEJFeW5F?=
 =?utf-8?B?SmNDWjdnVU1ldlBZZERndno2YmtwQlR3MVNveVNDZXAwRVNtcEZQSjhWODh1?=
 =?utf-8?B?TklDWmlNTFJlc3crQzhYVjJwZjJGek9DcXZLN2N5TmpuOC9PNHpyREJ0UEhI?=
 =?utf-8?B?MmpMSndXVGdDMWJhMHVHMlNiSGZCM2hXd25sOFlwVkRtS1NpYXoweWpYK0FG?=
 =?utf-8?B?aSsrblBtSnFicmxOLzdXVmNUTXNRNm81aXRsWDJGekJybTAwZjBVeHBMNXQ2?=
 =?utf-8?B?dnQ2WCt6TThoTmN0WS9VcmlSWFE0cDJjeDQ5NWx6VzFkL1QzYXRMWnNFaVJ2?=
 =?utf-8?B?bzVVanlDWUkvNDRoSXFpanZPKytoYWVvcnIzOW1wS0dpSStnbVlJdGtLUENY?=
 =?utf-8?B?VHA5OUZHN2JFak1UOTdZL2oybFpBd3l5Ni8vcmZLaXpCSEdTckh4enpFQ2tT?=
 =?utf-8?B?Q1phVi9Za1UwUk9WaHNwRFNFTHl1WHFTSmdSTlhIM1oxL042TWZjRmFyN1Q2?=
 =?utf-8?B?MWJYRHZqTmUwbDVaenZQYWxuOUMyc1JKUjJiUjI4ZFBjeTB6MjlLZENCSDlD?=
 =?utf-8?B?VVdZejlBbUxhZXBPUW9XQkJ0VCtURHdkcFVmcUFPU2ZhWTUwd1FQNDZNemVy?=
 =?utf-8?B?VlFQSjhVTlkwQ3d2a25XVUNHeDdRdVJzbWtlUWF2eUFoZTVFbDFzNG0xY0pO?=
 =?utf-8?B?cG0wRHorTWxlMjhPcWpmYXAvMjBoREcyVFNabFd6T2Npek5WNEFCbCtiNDJr?=
 =?utf-8?B?OUwrOEZEUytvZXRGTjRkbVJ1L2RoQjlJU09xLzdWRlNvcDE3L2J0TjRiL3Zl?=
 =?utf-8?B?eGlPbW44aytMRG9ibHB4Mm53eFc3ZDFsV0Zlb1hYeVRDQVNScEdPMlFteG9Y?=
 =?utf-8?B?eDBMcVRuOXArZ2dNNmQ3UXZKM2dTOUdkcGlnSmM2aXNodGFza00xd0R1RklG?=
 =?utf-8?B?TUhqTXFKS3Z3UUlmY1cvYlptVlpON2o1RHJGaFhxNksydk1GbXJFbUZCWkl2?=
 =?utf-8?B?N1BzWm1Ba3AwVUF3V1B5RjExSXpTUFE5UUJOemJMM3BzRm9WU0RmQXJldnJJ?=
 =?utf-8?B?NDlkQi9UNFd5SFpOR0E3TmR3L3VWMC9SWDliQUY1VUVwakd6UTVWdThKQ2xE?=
 =?utf-8?B?YXBWNjBRMXozRGRSVlZoSkVzMWRQL2ZnMUNpZERYRXhRMnlLS0VneEtxUEor?=
 =?utf-8?B?MElQVjBGd0JxZVZmaXI0NytnTjlGMUpJZkhEYTIwVCsxTVVkZzQ2OWVGYkpr?=
 =?utf-8?B?QnFQcW1GVFRHRSsyQW13aHpqNzRaRTV3ZXRIdFJDZk1DUkFlMHJxZm5SYWRE?=
 =?utf-8?B?RFdNdlZkdnhFYTFJVElueDZmWTB0bW01dlFXUzN3Q0thc2ZnMklTdFBOMThy?=
 =?utf-8?B?VHFJdEhEd1VLQ1ZIOVZYTnlTb3llL01JL3NpWGFJQ0ZCUTZDZUFLZ3RkWWgv?=
 =?utf-8?B?YmR0Z1B6OGhoSW5Zd0RUcHdxYjBZOUVEVi9yKzNOS0JFTFBZV1V3QkJ0U3Zv?=
 =?utf-8?B?b3JEejROQWgzUHI2Q2VTbkp6WmlzNjdaYmlPUTJmV0JubWdYVW5EQVE3Mi9D?=
 =?utf-8?B?UVFwS3BMNXhEdDlSWEo5YjB4Q1I2aTZqTmYrdEIrZ3BCQTEwTEswRnVycFo3?=
 =?utf-8?B?cEtaUzNkVDJGR3Q5VmhmT0tOaEtYSXBIUVVXTVpGbGZUVEZXUTNCK0lYOGhD?=
 =?utf-8?B?elZSa1kyR0liRThtTnFxeGx4aEtkVXFHKy9RYzIzQ1BXUTJjcndoeTE4UDU2?=
 =?utf-8?B?Q0dJdTEvL1JOYUNiZ3l1Rk91anN2ZVBNdXlRZmx2R20zMmhUamx6d2dWL0hr?=
 =?utf-8?B?V2hlQzhQUDFyQjZ0UXNGQ1cvaGl3alBOWVlOVkR3blExUnpQV3lOWVFnWWtj?=
 =?utf-8?B?dmNBYkNudHk5SHJuTUxMWTJkVzlrcTF3YllRaEdIbTZqVExSNkJqOTJWdUR4?=
 =?utf-8?Q?7g0c4TnMHjJDAG41or?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52da4a2d-5412-4e1e-3a1e-08df359f1631
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:29:10.0299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TKOsQX0KjfwlizyfLn5AGn/4Yw6AW8Gu9yfXzc3NeKinoNhTwsSnAWnu7c7leX8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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



On 29-Oct-26 1:44 PM, Lin, Amber wrote:
> AMD General
> 
> Regards,
> Amber
> 
> On 10/28/2026 8:53 PM, Lazar, Lijo wrote:
>>
>>
>> On 28-Oct-26 5:55 PM, Lin, Amber wrote:
>>> AMD General
>>>
>>> Regards,
>>> Amber
>>>
>>> On 10/27/2026 4:41 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 27-Oct-26 1:20 PM, Amber Lin wrote:
>>>>> Add xcp parameter to amdgpu_gfx_reset_mes_compute() so on an ASIC that
>>>>> supports compute partitioning, we can identify the partition's node ID
>>>>> and
>>>>> its master XCC. Pass this master XCC ID to MES when calling MES for
>>>>> suspend, detecting hung queues, and resume.
>>>>>
>>>>> Signed-off-by: Amber Lin <amber.lin@amd.com>
>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 17 ++++++++++++
>>>>> +----
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h         |  1 +
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  2 +-
>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  2 +-
>>>>>     .../drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
>>>>>     6 files changed, 18 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_gfx.c
>>>>> index 0c1c8ae822d4..ef34f7b02d0e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> @@ -2470,6 +2470,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct
>>>>> amdgpu_device *adev,
>>>>>     }
>>>>>     int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>>>>> +                 struct amdgpu_xcp *xcp,
>>>>
>>>> Ring carries xcp_id. It's better to make use of the same (when xcp_mgr
>>>> is also present).
>>>>
>>> I need xcp_id (for KFD) and master xcc_id. When KFD calls this
>>> function, passing "struct amdgpu_xcp" can get both data. ring is non-
>>> NULL only when this function is called by KCQ (and I don't find any
>>> function to retrieve master xcc_id using xcp_id). When KFD or gfx user
>>> queue calls this function, ring is NULL.
>>>
>>
>> There is a queue input argument carrying xcc_id (end of this patch). The
>> same may be used for mes suspend etc. However, that doesn't cover xcp id.
>>
> Thank you Lijo for your review and feedback. True, the *faulty_queue_input argument used by KFD has the xcc_id info (lack of xcp_id so will still need to add "int xcp_id" argument), but I'm planning on code cleanup next, which will remove *faulty_queue_input argument.
> 
> Due to the fact this function is created to coordinate KFD, KCQ, and gfx user queue when each of them having their own data structure, we can't avoid those NULLs though I agree it's not easy to read from the caller. I tried to avoid adding more argument, but after looking into available data structures on KFD side and KGD side, I do believe adding xcp structure is the most generic approach to support KFD now and flexible if we need to support KCQ/gfx user queues in a multi-compute partition ASIC in the future.
> One thing I can improve would be adding one line comment in each caller like this (this is when the caller is gfx user queue):
>   /* adev, *xcp, *ring, *guilty_fence, *uq, *hung_queue_count, *faulty_queue_input */
>   r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>                                    queue, NULL, NULL);
> 

Thanks for the details. I don't have any other comments.

If they are many arguments, in your cleanup phase, passing them as a 
struct (like reset_input) is better; easier to read what params are 
filled in.

Thanks,
Lijo

>>>> It's harder to read the caller locations with NULL, NULL....
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>                      struct amdgpu_ring *ring,
>>>>>                      struct amdgpu_fence *guilty_fence,
>>>>>                      struct amdgpu_usermode_queue *uq,
>>>>> @@ -2486,6 +2487,14 @@ int amdgpu_gfx_reset_mes_compute(struct
>>>>> amdgpu_device *adev,
>>>>>         struct amdgpu_gfx_deferred_entry
>>>>> deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
>>>>>         int n_deferred = 0;
>>>>>         int ring_err;
>>>>> +    uint32_t xcc_mask, xcc_id = 0, xcp_id = 0;
>>>>> +
>>>>> +    if (xcp) {
>>>>> +        amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
>>>>> +        /* master xcc in the partition */
>>>>> +        xcc_id = ffs(xcc_mask) - 1;
>>>>> +        xcp_id = xcp->id;
>>>>> +    }
>>>>>         guard(mutex)(&adev->gfx.mec.reset_mutex);
>>>>>         /* stop the drm schedulers for all compute queues */
>>>>> @@ -2493,7 +2502,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>>>> amdgpu_device *adev,
>>>>>         /* suspend all will determine which queues are hung.
>>>>>          * reset detect will return the array of bad queue doorbells
>>>>>          */
>>>>> -    r = amdgpu_mes_suspend(adev, 0);
>>>>> +    r = amdgpu_mes_suspend(adev, xcc_id);
>>>>>         /* if suspend all success, it should no hang queue */
>>>>>         if (!r) {
>>>>>             dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n",
>>>>> xcc_id);
>>>>> @@ -2503,7 +2512,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>>>> amdgpu_device *adev,
>>>>>             goto fence_reset;
>>>>>         }
>>>>>         r = amdgpu_mes_detect_and_reset_hung_queues(adev,
>>>>> AMDGPU_RING_TYPE_COMPUTE,
>>>>> -                            true, &num_hung, adev-
>>>>>> gfx.mec.mes_hung_db_array, 0);
>>>>> +                            true, &num_hung, adev-
>>>>>> gfx.mec.mes_hung_db_array, xcc_id);
>>>>>         if (r) {
>>>>>             dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
>>>>>             goto out;
>>>>> @@ -2551,7 +2560,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>>>> amdgpu_device *adev,
>>>>>                 n_deferred++;
>>>>>             }
>>>>>             /* reset any KFD queues */
>>>>> -        r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe,
>>>>> queue,
>>>>> +        r = amdgpu_amdkfd_reset_mes_queue(adev, xcp_id, queue_type,
>>>>> pipe, queue,
>>>>>                               adev->gfx.mec.mes_hung_db_array[i]);
>>>>>             if (r)
>>>>>                 goto out;
>>>>> @@ -2582,7 +2591,7 @@ int amdgpu_gfx_reset_mes_compute(struct
>>>>> amdgpu_device *adev,
>>>>>     out:
>>>>>         /* resume all will enable the non-hung queues */
>>>>> -    amdgpu_mes_resume(adev, 0);
>>>>> +    amdgpu_mes_resume(adev, xcc_id);
>>>>>         /* Now CP is running again — replay backed-up commands and ring
>>>>>          * doorbells on each reset queue.
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_gfx.h
>>>>> index 5939e1fb3b24..26bbec8f92e8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> @@ -664,6 +664,7 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device
>>>>> *adev, int xcc_id);
>>>>>     int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>>>>>     void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>>>>>     int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>>>>> +                 struct amdgpu_xcp *xcp,
>>>>>                      struct amdgpu_ring *ring,
>>>>>                      struct amdgpu_fence *guilty_fence,
>>>>>                      struct amdgpu_usermode_queue *uq,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_userq.c
>>>>> index 1a2aa85c504e..7dfe6e83f8ce 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -153,7 +153,7 @@ static void amdgpu_userq_hang_detect_work(struct
>>>>> work_struct *work)
>>>>>             int r;
>>>>>             if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
>>>>> -            r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
>>>>> +            r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>>>>>                                  queue, NULL, NULL);
>>>>>             else
>>>>>                 r = userq_funcs->reset(queue);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/
>>>>> amd/amdgpu/gfx_v11_0.c
>>>>> index 315dfd806d56..fdc0620ca67f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> @@ -6932,7 +6932,7 @@ static int gfx_v11_0_reset_kcq(struct
>>>>> amdgpu_ring *ring,
>>>>>     {
>>>>>         struct amdgpu_device *adev = ring->adev;
>>>>> -    return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence,
>>>>> NULL, NULL, NULL);
>>>>> +    return amdgpu_gfx_reset_mes_compute(adev, NULL, ring,
>>>>> timedout_fence, NULL, NULL, NULL);
>>>>>     }
>>>>>     static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block,
>>>>> struct drm_printer *p)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/
>>>>> amd/amdgpu/gfx_v12_0.c
>>>>> index d334fb805020..ec5ec1fd8b9d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>>> @@ -5254,7 +5254,7 @@ static int gfx_v12_0_reset_kcq(struct
>>>>> amdgpu_ring *ring,
>>>>>     {
>>>>>         struct amdgpu_device *adev = ring->adev;
>>>>> -    return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence,
>>>>> NULL, NULL, NULL);
>>>>> +    return amdgpu_gfx_reset_mes_compute(adev, NULL, ring,
>>>>> timedout_fence, NULL, NULL, NULL);
>>>>>     }
>>>>>     static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/
>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> index ce67e56efa8c..0eb4081a5740 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> @@ -506,7 +506,7 @@ static int reset_queues_mes(struct
>>>>> device_queue_manager *dqm, struct queue *q)
>>>>>         queue_input.remove_queue_after_reset = false;
>>>>>         queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>>
>> This one is also sending the xcc_id in queue input. This is the master
>> xcc for the kfd node.
>>
>> Thanks,
>> Lijo
>>
>>>>>         /* pass the known bad queue info to the reset function */
>>>>> -    r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>>>>> &num_hung, &queue_input);
>>>>> +    r = amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL,
>>>>> NULL, &num_hung, &queue_input);
>>>>>         if (r)
>>>>>             goto fail;
>>>>>         pdd = kfd_get_process_device_data(q->device, q->process);
>>>>
>>

