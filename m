Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB92C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 16:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7A110E70A;
	Tue, 10 May 2022 16:00:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F82210E8A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 16:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQc1mzj0hLj8Oumqe6IgOnw8fstAC2ycxp05PRVhvbCTWSUeKRNveg6jJEEqkiHIqvVuBA84SkpCYDCiBgDDFvlvbknGKYw2zQaE5nBYai5gJPGcLvmHa0r8o1s1ij+M4IAGHUDAPkHROxUAptEFAAi3khN06NBjFatj7l5zPE5iImuS4X4a7Wnqti8n8O1NPDpnf3CxrHzV5wrKF5LuU1eiPQcm07jLs+trRJVB7P99diouay84L69WJpledg6R9F49zj0RZoISCcZpecT0nyOzkyApr/FrctqalZd91qUPW+f54dAVkc3W2iMoVCJFXNXIZiwl70YLlG+uxuWFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLYCwNkgQ++xhpWAFCSdLV3tpUfZqJETvndFxw5uInE=;
 b=Djp0MiSCMu/tPm9/UUUQlRP5Zej9cuh6kZLPEcB9S3LRQMy8NpnFRfJoTf412VgdKC5//Mgv+HBh6A60pmXAxj+QBMCL/apzVIz0UMwsUv2AOCoDcizCItw10sE7JHg/Gr8pHTLyFW0LfNRRf4/hImuYt5vWUyz89HApgxigrEhR637HnGai6L6sXu6L9m2olV6ZMqzjS7YWzqa1gjuxFrBx9FE+dF9SWCpqweq4owP54xDUYuuxpzjf8hgHP9GY1hqOX0Vss2ikJIC0c9cU3hbke+1kqffI+zL8gwI8V5/9csz8E4PyRFtHMzxDnEo8iXD8stqH2OohCoxs8rKmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLYCwNkgQ++xhpWAFCSdLV3tpUfZqJETvndFxw5uInE=;
 b=qf4jHDKyl+z5xgH8yplv0/zonfnWC7S/rBba/GflfHCJrS62ByemNtPJ1SjNZY+7x7yQ3FqEyheCntEvJoh64Jb2Pu1XOhIcWOn5gRKSLFVxXKmzHbhd3Grwxu+uvu8oDO35a8RNCMm5iWTXm5N8KZ/L4YY4O5UPSij9JVw8BWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN6PR12MB1202.namprd12.prod.outlook.com (2603:10b6:404:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 16:00:09 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:00:09 +0000
Message-ID: <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
Date: Tue, 10 May 2022 12:00:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ded9959c-dfb2-46ed-b863-08da329e2852
X-MS-TrafficTypeDiagnostic: BN6PR12MB1202:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1202AB654CC9050E335305FDEAC99@BN6PR12MB1202.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta9epFxbDHO4cWAPMBaIKgukP81y8vt3wUZ5Q37lS2jHI+CrYfGGvQwYHtGi1K9NuTtDk+OCCJ7UMLMqA3R36rYLK+NNOk5pTMjnOCwZ2IHJkAiwyFgohwlu6jYGpSmnnJL8s9ez6k8R6NvKSHAgfjwm5JyZUSCQCIYtawKbflDCxjs73/BoDYpCKGr9TguRgYpFwkW/wxmLveOKhtYylEfBHaSYIBcyUSC/YUfkF/jM6hOP4aDnCFE/NOnm73U8wOZfTpM9joAIK60waFg4FA5AJlCmewOQLEjR+e4khkUMYCLtnTOKLdamzlMo7UiYqlLXVZQfdcZzlwGs1rHwLo8+PpLlYPnTTSP/NomDVsZK51K82i+z2snwlDhc/RYd4fx582jPjauaB2VGv6aOXw/GFPKyZacCkWyh8p15YbrydmKrqUhPb2lMdk1vXChkF6xZyMgMz+FeMZA/MM9vO8zL0CxXXl+UNNbpVMSL7E3i8QoD+SS84lX6qpPPXayfuoYyre5FnaYssUPh0hzZCU9Lfd7pW9tOOQoKtlmm1fQtYdKaliLqyCXa2lQhebG1sCBuILECQj+KRj/8/CpdSw+x2T6Hpe4vRR4YOSj0Gxh07BY0JjUHMkctpHIKNkstUbjE7cee916pqmeljGZSN8Mcvf9fVuGSUK8MkDRghmND/78SCGilzS/ZifOg5g0MUz0wqV64EsJlTlxNrzbwRdGtVjsZuzfogk+8NC/9Sm4T9ifuBQr0XQEhTGzx+Qrv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(31696002)(66574015)(508600001)(6486002)(30864003)(316002)(86362001)(6506007)(186003)(2906002)(5660300002)(53546011)(36756003)(83380400001)(44832011)(8676002)(66946007)(4326008)(66556008)(66476007)(38100700002)(31686004)(8936002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjYySEI3dE5FU1FNS0tqWnYySUVBUjRUc0pORFhGZldLNmFRbjFSZElyazZx?=
 =?utf-8?B?V0lMNEVDYTd0SitjZGI3NC84VWtOeHZGZWJ1UHdEb0RieWlUaUIwNm1ESkJI?=
 =?utf-8?B?Zlk4OGtJNnVnelhqSkFybWk4Rko1VE04K0hIeWJ4S1dJRER6cEVCNUVvVDBX?=
 =?utf-8?B?SHVPRU95T1l3azBoTVZrSGRscDFtaGxHUWJPZ0xQSjc1VXJoSDR5elRGMnJC?=
 =?utf-8?B?ZCtZWUFvSnVFc1VRMjJjRjA3WjBmcFBkd1NWcTZETVU0WjQ3dEhXRE1za3g3?=
 =?utf-8?B?VjJKek5IM2dNcVpGWUZUeCtEVEROQUhDcklOak8vR1BYZTRsUEZDZ3VueXI2?=
 =?utf-8?B?eWM5UEErWTFieGpZbGlHRk9veUNXa2tpRjNUd2h4UW1rNER4NjVBbjNwSlNI?=
 =?utf-8?B?OEZNOUNuY29mUGtSREFQVU10RmUyU0RRbGkzRUJSSStoczIzYjNhUElIR0do?=
 =?utf-8?B?NG1pcW9XK0dzMkI4S1FlOE5YRkUxc083WjB3UHFhaVUvNE9VdWVnNHRJTXdQ?=
 =?utf-8?B?eUVoUGEveHVyMGwzSlFGUXRIeC9mYTMzRmI2U1RYZkNWNFRIbFpJeUNPdFgw?=
 =?utf-8?B?YnhlTTFUZGs2YnpkL2NjSXFGaHdWRDZGUTljVjVPM0xsbmlqOUF4c3BUbk96?=
 =?utf-8?B?UkpiT0hKVW90S2ZMYmR0cnFVV0Ixa0FFY05DRVRMM2RCaXBQaENRZDMwWlFu?=
 =?utf-8?B?Wlh2c2lhR1dQRTF6V2dyR0ZLaWtlc3lqem1aZU9Td2g1d1RkWHduZzl2RVVV?=
 =?utf-8?B?cTN5Rkt4RlphdFhiRHVlQ0d4VWdDWUl5ZDBoUS96Tk4zQUg3WlVEK3FPeEpF?=
 =?utf-8?B?ZEdQYk8zaEl6NHl5R2dKVUhKeERxSG5DSVRnWDZXRkd0cm9HZmRCeVVXMU83?=
 =?utf-8?B?QmtQVWk2cWpRbldFSGRxOFdXK1hyK0NtaGtIbmN2UmdoeTVEV3VpYUpGR29j?=
 =?utf-8?B?S2NVaVZuWWJKL1U3d3pHMExraFFNbzA3Z216SG1xZUwxYkE4Vk5sZHdMY0FY?=
 =?utf-8?B?QkxNQlA1aXhlUkhHR3pxcjVkTDFuVmFBbGZ5YS8yNFBtQlZOeHAzZEI2bXVZ?=
 =?utf-8?B?ZGtoS0JBNDFEdWx2M1BzU0JqVlJ0clRoNFdkRmxDaC9uSjRsQlBLUkhob0xQ?=
 =?utf-8?B?ZjhJUHBSbmJrY1M1UWY5eWJpSG5WOTQ2TmxrbUhoTVZwYWI2VVBqN21lSVF1?=
 =?utf-8?B?aDQzSElYWnZnbW9FRkJlcWZjQkw3dnNlbGx4c0VhRHdWY1dSSlhVMTdZMmVz?=
 =?utf-8?B?ZkJjZ29SUU4xamFwZTRmY0dIcWxPTUFhbTJydEpPcFhXU3IxV3ZlYldWRkEw?=
 =?utf-8?B?b1VyQjZobzJSUDJLVU5yVVZqczVvMUN2a1ZKK2U3MTV2NWtyZTJLMllnVmo0?=
 =?utf-8?B?OHN3OWd1YUVEOE5GdTNFRkFlV3p2YWNNbWtITk1mVTY4V3lLbExZYXNDMlVt?=
 =?utf-8?B?L1NEK1ZVdjgzcHhqaTg5aXIrOEJ4ZFU0ZHhHK3Zranlwb0YrMnZTamY3V0Rs?=
 =?utf-8?B?SkU3U3ZxN0VQUzhQSzlZVWEvVW9jSXJITEhwTjFZeG9PQXp6KzhlbmFTVExj?=
 =?utf-8?B?VURlWkVhbWJwYXJaWEQ0NEZPVGtNWHp5dEljTlo4algyajFpaWNpYzM5Q1hv?=
 =?utf-8?B?Y1ZtWjdNYXZvaDBJU1dWd3dhdzZlQ0JOdFYzdW0rQmVzcGIwZXRtQno4a0g5?=
 =?utf-8?B?VXBTV1loSGhCMUhGR1pTYUIxL01yU3M2R2UrQzh0T01yV09nNFMzaHJHVGp6?=
 =?utf-8?B?aUxMdzB5ZmdYWUlabEJxZ0hUY2FhWjlFTU1CVVU1N3R2T1ZPbWFaRUdqTUlw?=
 =?utf-8?B?Qy9LS2tNcVVlN1lpWWJKRFpmOFIyc0x3blFZOVRFMEVsaFRPamFoQ01iODUx?=
 =?utf-8?B?SkVzeGp2d3FSSTZXSzlOdC8vVDhTWlQzMU9NM3FjdDV3R3JZUlY3ZnZsRlhn?=
 =?utf-8?B?Q1Q0cE5IZS9nL1hQSldzczVMaHErMHpmOHNsTmoyMlQwWXA0bmN6dmtISGhB?=
 =?utf-8?B?RWI3TjlEZlkweGlxVjQ0SnlCNEIyZGlLa0FXamZGUWM5b1A1U3lmQW5oVm9B?=
 =?utf-8?B?K1NacmFJQk5uWUV0ZFluVzk0Qk00Q1dGS2lPTWlZL3VIQlV4TkFKcm1sTURV?=
 =?utf-8?B?MFR4QjVDdE56bkx4R0xlbG02V1dkT2IwaXNwQnc3MEFoemE4U0N2SE1sQWJm?=
 =?utf-8?B?NlhLRjBXMTdPNUtpYjMzSEt0UUdaUzVyMHk5RTRDWmdOSk8reTA2QUtWbDVV?=
 =?utf-8?B?c3Uwa2Fya3lwT3B2RlFWbS9kYThFRitzYldhdTI1dWM5RmlyWks3QW1iVEN6?=
 =?utf-8?B?U0FJT0NtMlBSOFdEZkQxaTIwN2JlTjFpclhtSXVNazYrMjVHUlhTZkVDdlYr?=
 =?utf-8?Q?z/tqtmLVaXC5dFju7V4PaW0+QoQ0G7Lk7EjR2Q+npowQt?=
X-MS-Exchange-AntiSpam-MessageData-1: ICBYX4864hGIwA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded9959c-dfb2-46ed-b863-08da329e2852
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 16:00:09.1109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l++yHuP8Y25zna/M+YB3NojexMG0ph7ARrS7raJlhDBeIVRHzjqg8NIZ28N1q5lJdESa+XCtBywzOS15Y2L5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1202
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-06 04:56, Christian König wrote:
> Am 06.05.22 um 08:02 schrieb Lazar, Lijo:
>> On 5/6/2022 3:17 AM, Andrey Grodzovsky wrote:
>>>
>>> On 2022-05-05 15:49, Felix Kuehling wrote:
>>>>
>>>> Am 2022-05-05 um 14:57 schrieb Andrey Grodzovsky:
>>>>>
>>>>> On 2022-05-05 11:06, Christian König wrote:
>>>>>> Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>>>>>>>
>>>>>>> On 2022-05-05 09:23, Christian König wrote:
>>>>>>>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>>>>>>>> On 2022-05-05 06:09, Christian König wrote:
>>>>>>>>>
>>>>>>>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>>>>>>>> Problem:
>>>>>>>>>>> During hive reset caused by command timing out on a ring
>>>>>>>>>>> extra resets are generated by triggered by KFD which is
>>>>>>>>>>> unable to accesses registers on the resetting ASIC.
>>>>>>>>>>>
>>>>>>>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>>>>>>>> such that the first reset jobs that actaully resets the entire
>>>>>>>>>>> reset domain will cancel all those pending redundant resets.
>>>>>>>>>>>
>>>>>>>>>>> This is in line with what we already do for redundant TDRs
>>>>>>>>>>> in scheduler code.
>>>>>>>>>>
>>>>>>>>>> Mhm, why exactly do you need the extra linked list then?
>>>>>>>>>>
>>>>>>>>>> Let's talk about that on our call today.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Going to miss it as you know, and also this is the place to 
>>>>>>>>> discuss technical questions anyway so -
>>>>>>>>
>>>>>>>> Good point.
>>>>>>>>
>>>>>>>>> It's needed because those other resets are not time out 
>>>>>>>>> handlers that are governed by the scheduler
>>>>>>>>> but rather external resets that are triggered by such clients 
>>>>>>>>> as KFD, RAS and sysfs. Scheduler has no
>>>>>>>>> knowledge of them (and should not have) but they are 
>>>>>>>>> serialized into same wq as the TO handlers
>>>>>>>>> from the scheduler. It just happens that TO triggered reset 
>>>>>>>>> causes in turn another reset (from KFD in
>>>>>>>>> this case) and we want to prevent this second reset from 
>>>>>>>>> taking place just as we want to avoid multiple
>>>>>>>>> TO resets to take place in scheduler code.
>>>>>>>>
>>>>>>>> Yeah, but why do you need multiple workers?
>>>>>>>>
>>>>>>>> You have a single worker for the GPU reset not triggered by the 
>>>>>>>> scheduler in you adev and cancel that at the end of the reset 
>>>>>>>> procedure.
>>>>>>>>
>>>>>>>> If anybody things it needs to trigger another reset while in 
>>>>>>>> reset (which is actually a small design bug separately) the 
>>>>>>>> reset will just be canceled in the same way we cancel the 
>>>>>>>> scheduler resets.
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>
>>>>>>>
>>>>>>> Had this in mind at first but then I realized that each client 
>>>>>>> (RAS, KFD and sysfs) will want to fill his own data for the work 
>>>>>>> (see amdgpu_device_gpu_recover) - for XGMI hive each will want 
>>>>>>> to set his own adev (which is fine if you set a work per adev as 
>>>>>>> you suggest) but also each client might want (they all put NULL 
>>>>>>> there but in theory in the future) also set his own bad job 
>>>>>>> value and here you might have a collision.
>>>>>>
>>>>>> Yeah, but that is intentional. See when we have a job that needs 
>>>>>> to be consumed by the reset handler and not overwritten or 
>>>>>> something.
>>>>>
>>>>>
>>>>> I am not sure why this is a requirement, multiple clients can 
>>>>> decide concurrently to trigger a reset for some reason (possibly 
>>>>> independent reasons) hence they cannot share same work struct to 
>>>>> pass to it their data.
>>>>
>>>> If those concurrent clients could detect that a reset was already 
>>>> in progress, you wouldn't need the complexity of multiple work 
>>>> structs being scheduled. You could simply return without triggering 
>>>> another reset.
>>>
>>>
>>> In my view main problem here with single work struct either at reset 
>>> domain level or even adev level is that in some cases we optimize 
>>> resets and don't really perform ASIC HW reset (see 
>>> amdgpu_job_timedout with soft recovery and skip_hw_reset in 
>>> amdgpu_device_gpu_recover_imp for the case the bad job does get 
>>> signaled just before we start HW reset and we just skip this).
>
> That's one of the reasons why we should have multiple work items for 
> job based reset and other reset sources.
>
> See the whole idea is the following:
> 1. We have one single queued work queue for each reset domain which 
> makes sure that all reset requests execute in order.
> 2. We have one delayed work item for each scheduler which fires when a 
> timeout on a scheduler occurs and eventually calls the reset procedure 
> with the last running job.
> 3. We have one work item for each necessary hard reset.
>
> The delayed work item from the scheduler first tries a soft recovery 
> and checks if a hard reset is really necessary. If it's not necessary 
> and we can cancel the offending job we skip the hard reset.
>
> The hard reset work item doesn't do any of those checks and just does 
> a reset no matter what.
>
> When we really do a reset, independent if its triggered by a job or 
> other source we cancel all sources at the end of the reset procedure.
>
> This makes sure that a) We only do one reset even when multiple 
> sources fire at the same time and b) when any source bails out and 
> only does a soft recovery we do a full reset anyway when necessary.
>
> That design was outlined multiple times now on the mailing list and 
> looks totally clear to me. We should probably document that somewhere.


If you look at the patch what you described above is exactly what is 
happening - since scheduler's delayed work is different from any non 
scheduler delayed work the SW reset which might take place from 
scheduler's reset
will not have any impact on any non scheduler delayed work and will not 
cancel them. In case the scheduler actually reaches the point of HW 
reset it will cancel out all pending reset works from any other sources 
on the same
reset domain. Non scheduler reset will always proceed to do full HW 
reset and will cancel any other pending resets.

The only difference is I chose to do the canceling right BEFORE the HW 
reset and not AFTER. I did this because I see a possible race where a 
new reset request is being generated exactly after we finished the HW 
reset but before we canceled out all pending resets - in such case you 
wold not want to cancel this 'border line new' reset request.

Andrey


>
> Regards,
> Christian.
>
>>> You can see that if many different reset sources share same work 
>>> struct what can happen is that the first to obtain the lock you 
>>> describe bellow might opt out from full HW reset because his bad job 
>>> did signal for example or because his hunged IP block was able to 
>>> recover through SW reset but in the meantime another reset source 
>>> who needed an actual HW reset just silently returned and we end up 
>>> with unhandled reset request. True that today this happens only to 
>>> job timeout reset sources that are handled form within the scheduler 
>>> and won't use this single work struct but no one prevents a future 
>>> case for this to happen and also, if we actually want to unify 
>>> scheduler time out handlers within reset domain (which seems to me 
>>> the right design approach) we won't be able to use just one work 
>>> struct for this reason anyway.
>>>
>>
>> Just to add to this point - a reset domain is co-operative domain. In 
>> addition to sharing a set of clients from various reset sources for 
>> one device, it also will have a set of devices like in XGMI hive. The 
>> job timeout on one device may not eventually result in result, but a 
>> RAS error happening on another device at the same time would need a 
>> reset. The second device's RAS error cannot return seeing  that a 
>> reset work already started, or ignore the reset work given that 
>> another device has filled the reset data.
>>
>> When there is a reset domain, it should take care of the work 
>> scheduled and keeping it in device or any other level doesn't sound 
>> good.
>>
>> Thanks,
>> Lijo
>>
>>> Andrey
>>>
>>>
>>>>
>>>> I'd put the reset work struct into the reset_domain struct. That 
>>>> way you'd have exactly one worker for the reset domain. You could 
>>>> implement a lock-less scheme to decide whether you need to schedule 
>>>> a reset, e.g. using an atomic counter in the shared work struct 
>>>> that gets incremented when a client wants to trigger a reset 
>>>> (atomic_add_return). If that counter is exactly 1 after 
>>>> incrementing, you need to fill in the rest of the work struct and 
>>>> schedule the work. Otherwise, it's already scheduled (or another 
>>>> client is in the process of scheduling it) and you just return. 
>>>> When the worker finishes (after confirming a successful reset), it 
>>>> resets the counter to 0, so the next client requesting a reset will 
>>>> schedule the worker again.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Additional to that keep in mind that you can't allocate any 
>>>>>> memory before or during the GPU reset nor wait for the reset to 
>>>>>> complete (so you can't allocate anything on the stack either).
>>>>>
>>>>>
>>>>> There is no dynamic allocation here, regarding stack allocations - 
>>>>> we do it all the time when we call functions, even during GPU 
>>>>> resets, how on stack allocation of work struct in 
>>>>> amdgpu_device_gpu_recover is different from any other local 
>>>>> variable we allocate in any function we call ?
>>>>>
>>>>> I am also not sure why it's not allowed to wait for reset to 
>>>>> complete ? Also, see in amdgpu_ras_do_recovery and gpu_recover_get 
>>>>> (debugfs) - the caller expects the reset to complete before he 
>>>>> returns. I can probably work around it in RAS code by calling 
>>>>> atomic_set(&ras->in_recovery, 0) from some callback within actual 
>>>>> reset function but regarding sysfs it actually expects a result 
>>>>> returned indicating whether the call was successful or not.
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> I don't think that concept you try here will work.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Also in general seems to me it's cleaner approach where this 
>>>>>>> logic (the work items) are held and handled in reset_domain and 
>>>>>>> are not split in each adev or any other entity. We might want in 
>>>>>>> the future to even move the scheduler handling into reset domain 
>>>>>>> since reset domain is supposed to be a generic things and not 
>>>>>>> only or AMD.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 3 +
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 +-
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 7 ++-
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 7 ++-
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 7 ++-
>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>   };
>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>>>>>>> -};
>>>>>>>>>>> -
>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>>>>>>>>>>>       }
>>>>>>>>>>>         tmp_vram_lost_counter = 
>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>> +
>>>>>>>>>>> +    /* Drop all pending resets since we will reset now 
>>>>>>>>>>> anyway */
>>>>>>>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>> +                        reset_list);
>>>>>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>>>>> +
>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>>>>>>>>>>>   }
>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>       int ret;
>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>   {
>>>>>>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>>>>>>> base.base.work);
>>>>>>>>>>>         recover_work->ret = 
>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>   }
>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>   {
>>>>>>>>>>>       struct amdgpu_recover_work_struct work = {.adev = 
>>>>>>>>>>> adev, .job = job};
>>>>>>>>>>>   -    INIT_WORK(&work.base, 
>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>         if 
>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>   -    flush_work(&work.base);
>>>>>>>>>>> +    flush_delayed_work(&work.base.base);
>>>>>>>>>>> +
>>>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>> &work.base);
>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>   }
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>       init_rwsem(&reset_domain->sem);
>>>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>> +
>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>   }
>>>>>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>> +
>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>> +
>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>> +
>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>   };
>>>>>>>>>>>   +
>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>   };
>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>> +
>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>   };
>>>>>>>>>>>   +
>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>> +
>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>   };
>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>>>>>>>   }
>>>>>>>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>> -                        struct work_struct *work)
>>>>>>>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>   {
>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>> +        return false;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>>>> +
>>>>>>>>>>> +    return true;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static inline void 
>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>>>>>>> +{
>>>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>>>> +    list_del_init(&work->node);
>>>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>>>>> +
>>>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>>>> +    list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>> +
>>>>>>>>>>> +        list_del_init(&entry->node);
>>>>>>>>>>> +
>>>>>>>>>>> +        /* Stop any other related pending resets */
>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>   }
>>>>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS 
>>>>>>>>>>> is sr-iov ready */
>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov 
>>>>>>>>>>> is enabled on this GPU */
>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>       uint32_t            reg_val_offs;
>>>>>>>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>>>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>>>>>>>> -    struct work_struct        flr_work;
>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>>>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct 
>>>>>>>>>>> *work)
>>>>>>>>>>>   {
>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>           return r;
>>>>>>>>>>>       }
>>>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>         return 0;
>>>>>>>>>>>   }
>>>>>>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>   {
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>> +
>>>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>   }
>>>>>>>>>>>     static int xgpu_ai_request_init_data(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct 
>>>>>>>>>>> *work)
>>>>>>>>>>>   {
>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>           return r;
>>>>>>>>>>>       }
>>>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>         return 0;
>>>>>>>>>>>   }
>>>>>>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>   {
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>> +
>>>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>   }
>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct 
>>>>>>>>>>> *work)
>>>>>>>>>>>   {
>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>           return r;
>>>>>>>>>>>       }
>>>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>         return 0;
>>>>>>>>>>>   }
>>>>>>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>   {
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>> +
>>>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>   }
>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>>>>>>
>>>>>>>>
>>>>>>
>
