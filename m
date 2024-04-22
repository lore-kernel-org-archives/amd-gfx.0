Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EC3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345FD1129FE;
	Mon, 22 Apr 2024 11:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U23p/gts";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D96D112A00
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHIn7lh5lC21nN3fGri9SBQy+2VM1A94vL5VDueZ1tV0/gNK872BhifSGzd4PFJ0t4aXh0TOQIyr+rI2OYmE25CSFYTz8giMePu3g6BeQdzZtRLbZ6+OE7uBJsvy2u3td1YcfQBhJZHalI6/2O27DKr2vU+XP1wzoKffPtIiXRc0syiiM9x3Fe/qSwgOGzUQng4hDIiABcrhsh1ny4HbQ+RXwxRES3LmJFTc2ErQPA2f9tB+Qyqhqp8JjkPbH5D1iPYaZsAUBMKAQ4QVFGpVfLDiND+L1LQyVezQQ6uMy6A53xY261hmmTf8v5zqS9kSMR4KwaEHhwJirEAfbPtESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek+kcqIMXT62ftfvjQN9j/T9oSdguoV4YGnbyFjuqjY=;
 b=d57YZ2tfglnWo7huBIZHcm7aSWlJHOv9yHSB8UgszU631iIclKl36Ktf58fQ/tAmaaOF65qI7VQ4O7ZSmS9JNgeGR8OBW/rgB74Tt4E2vVm4NxyM7O48uHaopHI9j6TKf8zBoHjryaj+fSFpFLTmX0vSAnza6GyVqoJ28dKA47LDadKpJIIx5hQEqsJFr9UCKbfL4N8IytLX6xX+2p22t07//89Hx+VrFNK9osr4awB6be3nktmfVMmv8Ur15NHbOwXRscZ4eu1C1tw3U+Z3Kj/3mGvED7hsaRCRz8YV8Z1IN7/jF71z/dRZEXl9JVHBP5cRSjT4FqSNi159BdQlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek+kcqIMXT62ftfvjQN9j/T9oSdguoV4YGnbyFjuqjY=;
 b=U23p/gtsr2f9I719y6YlOhAcoPvllh8QtwMAdbKKrr8DlwklvLfAZhqCSijTJ624o2ZNrXhW01R+UJEpAuTtbqj/U1PWBloRdW+8ek3kFIi1NtiCmS33KXBjbLCm0XTaSzshm6+pG4/xnLcFmbtVSN8xM5wghL+Yobnzj5q1jTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 11:31:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:31:44 +0000
Message-ID: <c6802bb8-aea9-44d3-8bb0-be7735cdcac4@amd.com>
Date: Mon, 22 Apr 2024 13:31:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free issue
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
References: <20240422084707.3803306-1-Jack.Xiao@amd.com>
 <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
 <6a3ff35f-09a2-429c-b8d2-d061dd3c92a7@amd.com>
 <7437f8dc-3199-45a2-9279-f64a5e49e130@amd.com>
 <b577f411-88cf-434f-939e-f5b0e6dd6876@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b577f411-88cf-434f-939e-f5b0e6dd6876@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8583019f-bf17-4818-98e0-08dc62bfc9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXRsRFA4dzI4TGZKSXk1YzUzalpISlpwcFk3eDFIaVRHOC9pZkZWbkdFUUND?=
 =?utf-8?B?VXdUZm1IRm5RTVhvSThzZmhpWUFPNE1LemluaS9nTVFESkJoeUo2L1c4ZVFj?=
 =?utf-8?B?OEtSb1RHa0ZDZmlheUt4UGwxNWpnQitreEp5L29oT2pLWlMxUGN2TDBCZUNI?=
 =?utf-8?B?elpZdHF6U2tjNzRhZlNLaUJHUko0Wk5iKzVYTXVIcXZONkpGbEN2cnBtdUVy?=
 =?utf-8?B?UFBoWllMdENCdGxDd3VvS1g1MHUrc2JXS3V2cFF6Y1ArdWEwVWdhbldydzhT?=
 =?utf-8?B?OGN0bTR2UWE3VG1sZFVXQmpxMktnWTNmKzRvRjFnZU5jZGpGQ0RSVnlSZHR0?=
 =?utf-8?B?Nm1IeHJQK2pJZ1N2UVo2V2s0NlVjcGo0bG5PNVRwUHdTYnMwUjVOc3M2Szkr?=
 =?utf-8?B?cW9meVp1VE1TZnYrang5ZENCTWtOWHRlZnd4cjk2aDVtbk5nbmtkMDV1eUFO?=
 =?utf-8?B?QjYzeWdEQjRmL09IWk80WkdFL2dSVWs4eDV4Qmc3ajBFM3k4bVFIT0Z3d0tB?=
 =?utf-8?B?ZmF6WUh0cGZZVlhEU1NRTDUyUlh0SXJROC9OOGU4elJHRjBHMTltM042eTJX?=
 =?utf-8?B?NUVWeU5QV3NvWjNqblVTR05XcjhJcEwzRjFpd0l5SXR5Mkg4a3FsSGlNYndo?=
 =?utf-8?B?R25RS0xTK1dWOHp2TXlBaWR5RjVBM3RXS3lWbVlZLzRvclkwdktmYjNRSVY2?=
 =?utf-8?B?bExodkpvZzBJczNpK3JBTy9mK3FDWWtrYUFwbThYNDUwU1V4eGxqSVlQcjV0?=
 =?utf-8?B?WFJYanEzdkJEdW5rZTAvK1QzUjlxQXR3bmdGTkswQWZxeHYrQ3NUU21jVDF5?=
 =?utf-8?B?d0cybXJLbGFyVmN0U1NjOURFZFNhYnlDTFMxV1NmcVJSU0laY01Bbms0amNK?=
 =?utf-8?B?ZzQvdGMzMldpd29XNmpKSUp1Qm5OWGZ4Uk9aclV5cllpSHpCVnFaeTRuUjky?=
 =?utf-8?B?em8vM2FPMjVOczBHdWdHeW9SS2NZWWhMQ2RUNkQ4WVFRdHMzdkFSbHRmdXJs?=
 =?utf-8?B?QlZCUUg4bEUzWlU1UnorTmxUWk8zWEJOMFQ0VGFCOFcyU05qcEsyZlFqMkhz?=
 =?utf-8?B?aFhnclg3eHJKejg2dUtrMngxazVrampEQWRNTVo1UUFTNUt1akQzelVXOTFU?=
 =?utf-8?B?SnBLbWtWSHQ4NURJUTlRNjNxZTJjWVVoZXgvdHo1OGZONVFxeW1JTlUrU2JH?=
 =?utf-8?B?STl4UmtTaGs4MjlOUktWRGRjK1JsMG1kRHl2eHJ0SXFtY1ZVUG55UVp0dHNV?=
 =?utf-8?B?dGpDLzQ2VU0zcFE0aFI2czdWb3lRK0ZIbi83c2l1UWxZbTE4dWw2VGl4eno2?=
 =?utf-8?B?bW1ab3BkaHhQeFNIcFAyRHpjclZmdGhrbEZ5QU02WVBMVUlpVVFnTi9zZDlB?=
 =?utf-8?B?MVM4eU00RFBleTVEdVVjS2YvZWx5WW9JalBjRXNCWjJ0aElxYXVQSzVKaTVj?=
 =?utf-8?B?N3Q1SGxCYkYyRTJVK3NxK0taNFV0VnhrazlueVVBNkJUSzRZNXlhNGZ4Y1Rx?=
 =?utf-8?B?TVVhMHFnOGFEMHNUU1dGenI1L3pjVC9qQkxhS1ZjRU5YekNqVHRXN2lRMlNv?=
 =?utf-8?B?T3ByRXR2NWR6Ym9GWXpTVmpsQWVva0cwMEl5US9jYlZqZUVaSEd3VmlLVU5U?=
 =?utf-8?B?UVgxOEhXdEJZSURWZEJrZW02Rm5wb1ZMMnJMSUF1eXJoSmsxOFQyWDl2R3Vp?=
 =?utf-8?B?YjJIaC84czRWRzFjTUpveG85c1huVG5aK3daYzJQWTc2azE0VW9HMUtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDI5UklQVDBwUkRaeWRTN0ZIZFpFSm9mNE9VUzBZb29FSWhqN2ZneVV0NktK?=
 =?utf-8?B?R1JlNzlsRUs0TmhBeHJSRUV4SkVKdklzUklUdjBLYkM4QXBxNFQ3NnRqWk1k?=
 =?utf-8?B?MHAxTzRSNzlTVkpyQ2NLQU0yNmVPZzFQREtZUmhxNFErOGNFcjUrWElWRVcv?=
 =?utf-8?B?eEZ1Y0pCTnN1V3NPYWNSUnFSU2hWc25BaFRiL1dSc3Y5cnFENlkxNXZXbjAw?=
 =?utf-8?B?cGJwaHloakZhOFQ4UkJyVnV5dkphMHh4N05oTEtONjdkZXNnSVRZSVRlTkY2?=
 =?utf-8?B?MjlobnNWckNvQWJTTUwyNzNzMW5mVG10M1I1QWduVE00ZW0zS3ZxM3piUHQr?=
 =?utf-8?B?Rmw1bEVrbzJVa3g0M01hTFZxdVlpNyt3RUlWYUdObUM3bjZuWndMZE9hby9t?=
 =?utf-8?B?YnFVSGR1MjdSM2FUeXVSRWNDTUlzRWxHaGxTK3ZUOFRmOTI1RmhVMGQvZzNY?=
 =?utf-8?B?eU8xNnRKQjdPWDdwcXo0aUs2OC9jVFJLRCtoUG01Y0pTZll5WGhzamF1L0NQ?=
 =?utf-8?B?MkJldXF1TjRMS0xDR1ppeGQ2bVhFcDZTUm5lMll3WmpieUR3bmE3bnU3dXR5?=
 =?utf-8?B?WUdXTGhvZldwMDBseGZ0T0o4dXNLKzJFVUxwcHRTZ1U4b056RXozU1lsMHU0?=
 =?utf-8?B?VjczOVVZbDlUdFlWOUVJd2UxYlRhVUdWSXdDUzhnaFVQRUszZElDSW9CQkVx?=
 =?utf-8?B?aklMcEhLMmkvMHAyUFhWZFlBRnZWdHVUYzk1U3E4N0xxNlZQS1FLejVnMmhZ?=
 =?utf-8?B?QnMrQmExUEIrSnVEODhIem1NK2VUb1QycFJjeDVWMDJXSUpTMnBESXdVNFN6?=
 =?utf-8?B?RTR6T3hVdVNYVXN1eHpzMFlockpPbjYwUHAzUERVSGYvTW1QSHA5RUtJOFc4?=
 =?utf-8?B?MnBad0U3MkNqcVZWTCs4VmRYWGNWTis1dFc2UUVmUXVEcEdZTkRwMW1zWTd0?=
 =?utf-8?B?OUJuUUNkeGc2TmxCanorY2RFb0VvMWVSRjZ6NVpmRXNreHFzMlgybG1MM0lr?=
 =?utf-8?B?aW1qdjRsTC9Od0NUS3k0UktNcmVuZjIzSndSVHcyM1JpMHcrUzhyNG9aSjBY?=
 =?utf-8?B?c2g0eFJMOVI0bHEyeW04dEZKalpOWHJSblFJQXN3b0hEaG5wRUtKdnFyNGFt?=
 =?utf-8?B?ZDJPNzZzK2xZbkFYVzVmV3VyYWlvS0dwejZMeTFOM0FXY0hXS2Ixa1FhZjE5?=
 =?utf-8?B?QUZSVk4xTUxYN3FpQlJuczZPTWdkZG5uT0hQU0tvV0FvbXNvcDZuVTVnTzBQ?=
 =?utf-8?B?d3N2bkI1d0gzSWxZZUZpTXlPZ3RURVhZSWtrcVowVll4a3RZQmxreHVGRm44?=
 =?utf-8?B?YzVoMU10UG9KNzQzT2ZOUnRCNm1NNUdEcGtET1hlQ3RSZEowSzE3bElVdXJK?=
 =?utf-8?B?QUNmODRKL1VrUVlMTUgxRnB4SWdRU25LQ3FxMnNVb3NOby9PUTEwQ0NUbDJO?=
 =?utf-8?B?MFpCWkVRSTdtYnE3U2dHaVR2Q05oZXc5QWM1TFRQcExYRmlkSXQ5bHB0bVdo?=
 =?utf-8?B?RzBHV2R2WU83cWU5VTk1dlBaYXVITDB4aXg4dmRVNFA5N3BZbjV3ckV0cVo0?=
 =?utf-8?B?dUlCaFM2ZDdJQUZPUzNVT0tBbXBwNkkvM09VMWVlM2RTR2Y5cGltVktzY2xN?=
 =?utf-8?B?RGRCRVRWRVZ5S3R3TEFEbUxXQkFJZEVUT3RsblJGOGgwTFpQYkQ2YTluRElX?=
 =?utf-8?B?Rjl0T3FUTGVrS2NlNTNJajJGcTlnaGlCYUJDMnhDTnBZQ2d0aWNJL21ZQlRm?=
 =?utf-8?B?Ulp1aCtpYk01NzY5cjNSRlJmdSthNGhHZWVsUk9uNzFUNzNISkN3Y1oycno1?=
 =?utf-8?B?Tmduc283QVhYOE9vbTBRekpyMjdJVXduSG4xSTVxTFBrek1qNE10QnI3eXhl?=
 =?utf-8?B?ZExmNGlKd0dndzJkSEZoVElMaWdCK3k1QjRZbDNuS2NYT0VkNHY3cFhXQ29h?=
 =?utf-8?B?YWsrK1JTcXkxV3d1R3ZjbGR3ajBtaVY2V0dVOGxxQ2ZBR2txN1pSR0R0c2Q2?=
 =?utf-8?B?WFdyOXFIZVJRQVBsR0t4Ti9MT3grZXJ3M0gyWkc1bW5Ldy8vaW96dmsvQ044?=
 =?utf-8?B?U2VXbWxyOHc4T2FsM2RBZ1Myb1JvUjliN0gzVEE0WExRdFVnenFnVzNnbytH?=
 =?utf-8?Q?3pYpc5HO4q3e2EK3IOoeqfP1n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8583019f-bf17-4818-98e0-08dc62bfc9e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:31:44.7370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmr0HrSvt9e5HxLj9mPsGmVunRfaxNEHpxN+pVQaHVeCIMvhD/+n2xPXZtwaP6nO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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

Am 22.04.24 um 13:29 schrieb Lazar, Lijo:
> On 4/22/2024 4:52 PM, Christian König wrote:
>> Am 22.04.24 um 11:37 schrieb Lazar, Lijo:
>>> On 4/22/2024 2:59 PM, Christian König wrote:
>>>> Am 22.04.24 um 10:47 schrieb Jack Xiao:
>>>>> Delete fence fallback timer to fix the ramdom
>>>>> use-after-free issue.
>>>> That's already done in amdgpu_fence_driver_hw_fini() and absolutely
>>>> shouldn't be in amdgpu_ring_fini().
>>>>
>>>> And the kfree(ring->fence_drv.fences); shouldn't be there either since
>>>> that is done in amdgpu_fence_driver_sw_fini().
>>>>
>>> In the present logic, these are part of special rings dynamically
>>> created for mes self tests with
>>> amdgpu_mes_add_ring/amdgpu_mes_remove_ring.
>> Ok, we should probably stop doing that altogether.
>>
>> Shashanks work of utilizing the MES in userspace is nearly finished and
>> we don't really need the MES test in the kernel any more.
>>
> A v2 of the patch is posted. Can we use it temporarily till Shashank's
> work is in place?

Yes, absolutely.

> Assuming Shashank's work will also include removing
> MES self test in kernel.

Yes, that was the long term plan. But no idea when we can completely 
upstream that work.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index 06f0a6534a94..93ab9faa2d72 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>>>>                           &ring->gpu_addr,
>>>>>                           (void **)&ring->ring);
>>>>>         } else {
>>>>> +        del_timer_sync(&ring->fence_drv.fallback_timer);
>>>>>             kfree(ring->fence_drv.fences);
>>>>>         }
>>>>>     

