Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B7C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 17:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4F010E0D8;
	Tue, 27 Sep 2022 17:26:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1249F10E0D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 17:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INFBCHudsrFeRM6cXAzVS5HDeJ72lBx94PeNP3iP+r1cLCkoUEB08at6KTyeZupfRSm05jeDPM0YK75X3xlTmYQKQkFOyKSg2kkYGD1A/apfO1cuZYIqXao+BNhVVieV/nZCPs/zjftZcDIn4sV9E006SNESp+fw2SBcbYLmEC6lLC/PT/+O6l8iJCsLCNorGZCPCOs8nBuENPhsxBgiRwJpzec/DGimV+ZqO1j2ObUNuTelYmTt+3KhbNs3KNIe0srRV/xexGmGCzzJ8Ryhrd90H2Z4r/IPXHat3ZiS7ReYRx8LoHbN4XXDWnYq+nQQfdIhLnbQS1D3wAxsXb94og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk1mlEK6IgjdJ/cyooyeON7NvwuCmXU7Ujmg/kr2BPA=;
 b=K8JD13RVJ44svCb3/bFQVvjNB/GAoPmqlscRS7nIg4BgCEMvi38tYmxOJXwUUzsVZMW4TxzPE0z5iEf4kmU6PXYmFCH0s9LDQsTAfLENNoaJ3RaEGX4bfgdLglvXBUk9UjlmYWBed/fFPt9NNafulqReGqqk3W/6m8peQXW1gfPng3QzYD1RlA0xGaG14eME+hgtfgtyDGq5GgsUJVjUy/ZBg+jCcLydw76jAMb5N9HivvJcDRwujmKfWJVOZ5Mdk0f7r9WLkU9nNQbqG/uwO0SYEQxwl8LSP+6kT3mTplaysTRwUiedYIsrGb3ZGjo+mXpFpvhRWmJV5VsWZIphzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk1mlEK6IgjdJ/cyooyeON7NvwuCmXU7Ujmg/kr2BPA=;
 b=xY0FlgvKz1QXc/04NM+6T7qzRgiQThDraDAGrwAmWhCNufPtMQsqx7J+ZET2KhvpreotR0armJTTIwS1OphCEBdQjcTp3BvXPw0pXimFd49j1DAOEIax/hQvIiSxOq3kS1+XxijOhyNAwikD3dc63mWS2+LTu2jRDMVQK2ybab4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 17:25:53 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 17:25:53 +0000
Message-ID: <c81ee761-36aa-156e-8b8d-47e4bb4dd7f6@amd.com>
Date: Tue, 27 Sep 2022 19:25:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/5] GPU workload hints for better performance
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <1b549873-106d-1e93-7f77-4a3966828b9c@mailbox.org>
 <181b4f95-7a46-c8a3-0ffd-0d338f3cb193@amd.com>
 <1ac72ae5-9f8b-22f8-a5c6-3f33fad3a47e@mailbox.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1ac72ae5-9f8b-22f8-a5c6-3f33fad3a47e@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::19) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|BN9PR12MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0163fdf9-b9bb-42c3-854b-08daa0ad541b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXhgIqLHqvt/MlS7vh4cutc+2IpRNBf7jYiR3q016MWMBOUId5k6RcE+hdp56OyPRDXAsGQS+l+pI5MIbPSz8R1Xptv7bIqQwsna53OkTgP3XvQZ59uIviX0MHrRuiL5HNNp3zPrTPkvaqwsUpcOERnvTDCGNAsed91si0LT1/O50c97Aw2+5rzb0c3vYwQ66B7Fi+tBn4qNFxw857jh7iYHrxQL1jyRzXZT0Yl6HEnDcP3RwydwAH5OOOd4X5IXq3kiGFbxaAa0+FWwUtDsZm8LNpj7jLMi+93de4+dvNaOctTA+lE0m5PDMwkMwMKwqHyKU6VAxUBE5to7WDwMY4gZPTpr2pXTQ/6C/rYppfhHsIz1J8GhKi7ARcNiGvhiHzchq00vhdURFMrox+gIWuQeRu6DoK/ji/L9klZxyfnT7DLrra6C8h86bp0/sZjzCH+GTAcb+gg6CiQQGvTXwITU83Tto9ZthqbIxfnXb7Q4bbgmARqjRvjzRkoCMW6fxETYaJ3q/yFmiW06BdY39qUQmTzxM7qxyiHuanWnLqp/f7b2Dj4vkgQxeRRvNmq3MvneDdqj1hK5BrDgtxqY+yy/ilK1hRQ/6SW9O7KagqzqWaNylqVt9DqenxzjU1IOQ+2VnY/asJOF9AEvS7D8Rxi/2eXLF2KIHhM7gLnoCpiKRZAL3JM/geUC9wFaNvM02R947NNqM5pu8XDbgPPOm4uLEcsQPsHOz6Mr57myH0cmDoLTZuVKIAQTLAWDYSB/pRMDGrQAF/fxnSXCCPJYcPIHoNT9v+5ZHifjQwLtDBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(31686004)(8676002)(26005)(6512007)(6506007)(66574015)(4326008)(66556008)(66946007)(83380400001)(53546011)(66476007)(6666004)(5660300002)(316002)(36756003)(6486002)(478600001)(8936002)(6916009)(2906002)(31696002)(86362001)(186003)(38100700002)(2616005)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2Q5WjdKNzN1T1NJSmt6MzE4aCs5d0RieWFCLy9RZ285UHpZeGpkejZrRnV0?=
 =?utf-8?B?bkpsZStjN1dWM0pibFVJMXpOSmIrMVNMYVlidmRiMkNVRm8vUTMyYnNQNDU3?=
 =?utf-8?B?U2M4VVo2ZUdqaGptZ0tOTjFWUG9JRFVYUlZrYi95YkVSS1FkNzVoclh0NU52?=
 =?utf-8?B?c0pucHhBaUpSRHlLNHpBZk0zQmVXcDczOHVJeGJhOUtjODFTbFhrdHJYZ3oz?=
 =?utf-8?B?OXNRcjh3WU16NEdpYlFtdUZ3TTRGL2VFZ0FLc3FZZVFLbHljVTJyOVZ0ZXpi?=
 =?utf-8?B?bmE0ZnNnenl6L0gzOGxLRk01TU90SE91M255UmdRY3JqT0RGV2kzeThvSVNp?=
 =?utf-8?B?bnBKeDZGUFVWLzJEZzJReVlkN0c1c1ZpdUhneHIzZy9MSGV6a3JFdmhpYk9i?=
 =?utf-8?B?Zk9xVUpmZG9Kam9vdnBJWXpKSVMzNElKc3BFaDlLOUR6YXNTeFN5a2hrK2Yr?=
 =?utf-8?B?SDNjMU1qY1ZsOGlJYU1tMUQrSUdETVpsNUtuLzB6ZzZ1TUpkenl5ZTlyUG9h?=
 =?utf-8?B?dWNvZXBabnhKbFlMMU15WWJXNFVSZU0yQW93UkxidGd1S1VYdjhvbmF2MVBv?=
 =?utf-8?B?Q1lMbjNKL3pOYVdMUmxvY0tlU3JzYTNZbGVjejdmNXBET0tpNS83MmFNd2V5?=
 =?utf-8?B?OEpLRDAvQm0rQyttakZodHBkRExXMDZRaWt4bUlLSHE3dVV4THJySm04cmxF?=
 =?utf-8?B?dzMrRXQ0dW9VZXkyNGtuT1ljV3lUUkhHT2xISEJtakJYalR2cW0yS0ZTb2lN?=
 =?utf-8?B?T3RvTWN4WC9rbk10NFM5Mkk5cTI2ZGxMNDljMG5HWTZ6ZHRPaFlVNDNQZlJS?=
 =?utf-8?B?WXk1cWpxWFpJNys4c0JFVXJmNVk3cTV5eWRBQXduN0Z5QW4yQ2RiRENNMFpZ?=
 =?utf-8?B?eEpCZEhlR0RTQ0FSM3MrdTh6NUlHWTlXcmowWnlKbVlEcVVKTHJ0dkN1WUtB?=
 =?utf-8?B?QndkelJ6YWtpK2ZxNU43QW9RK1czRUtIbW05VktZbmtrVUlVcU52MkVuRkFX?=
 =?utf-8?B?OHNZM0FpSmRZRnFJVkR0SU93aXVldDRWbUZaNFJCLzFEWlJoSlQvWmxnQlRB?=
 =?utf-8?B?Z2l3YWdacDlNMTQ5ekxDVW9jYXNvQ1ZvMWJRdlVtejcveG44QXlYUm5DKzU0?=
 =?utf-8?B?eWRMZVRuN0dMYnNKU3lYTU5QbHNpVGI0dWJ0bDV0MWt5cHRrc3hZUithbU1Y?=
 =?utf-8?B?SVJnV2lUdUZrWndmcTdXZnVEMjZQb3BWNzcrWmF5YmFKQy8xV0RSOEhEb3hN?=
 =?utf-8?B?SDVLdG9JNGZpdDJhOXlQK2w2M3RqWVdHV0hWOFRMQkJVUG80c2w1L1MrekNS?=
 =?utf-8?B?M0dKaHZuQkF1eC9DQ2FZaHFmakhXODhZb2RsbHVYd09MMmpnTEhSSFdkLzFV?=
 =?utf-8?B?V3FRS3VJM0E0azlKUU5lZDdEWmhaQ01Jc08wK1NOZ0RTUU1YeE1wN2U3b1hH?=
 =?utf-8?B?enNaZmtqYWhCNUJ2R0RNQTI1cFNURmhZR1JxbHNZa0NUeFNNTVl0bFBwTHNN?=
 =?utf-8?B?Z1VndU94dyt1V0tNT3Q2K05XTU5WNHgyNDNSTTUyZjdoMitwY2UxWW0yVWlm?=
 =?utf-8?B?cktlNGMyNDU2MTZQajh4L1dxVUZKZXVEcmUzUkJxYmErS0JpSVZrTjdzbEZX?=
 =?utf-8?B?Wk4rUXNnRndDUVRESDU2bEJRallSN0YzZXErVVNwMHJ5WW9CWjZRSER2c2Mz?=
 =?utf-8?B?Njlzb0VjT2hLZ3BvSER4VE1Zd2NIeGhWb1dpQVJqaHZPM2U3eXBrK2MvQlBQ?=
 =?utf-8?B?M2x1V2FHZjg0d2xRRU1PMDlLZ0tJOFQ3UlhFMnVicFVXelpCQ0hNaHkwMU9Y?=
 =?utf-8?B?Y1lWVElaVEpoQUlDcWlvVjF6Z01uVFZrZVFhS0czNTNiM0d6dEhvSEtDZkJU?=
 =?utf-8?B?cDMybkpFc0xGN0hTVldSRHBPdjExVkt6MFRiOUxqVDFVN0cvMzlISzNNMklh?=
 =?utf-8?B?VDdTcnRxQVRBVDJ2aU1wQnNLU0Z1QVBIaVFWTzErOTFUZG5KaExrZHRwM3FM?=
 =?utf-8?B?WmF5cVZjUXZwTEpUcUxqcG9PdXVrdGYzeHhHdU1LNzFRMnhVSFJHUDI3YS9J?=
 =?utf-8?B?RGxRTkZhWFhicHpia0orZmhRN0hkSWZoalB4dk53V1pBbThUQ3VlSDdpUlRY?=
 =?utf-8?Q?7TeNqXRGEQZFEIjf+WJTwBm2o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0163fdf9-b9bb-42c3-854b-08daa0ad541b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:25:52.9722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JERVlNnFp7BksNwip7SJxUcRtC5eb0Rkshsw2hidlze5F9Ux4Ay/2YZ7lIbJKa6f0n0XWebBEKNJppGblCIo2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 7:13 PM, Michel Dänzer wrote:
> On 2022-09-27 18:59, Sharma, Shashank wrote:
>> Hey Michel,
>> Thanks for the review coments.
>>
>> On 9/27/2022 6:24 PM, Michel Dänzer wrote:
>>> On 2022-09-26 23:40, Shashank Sharma wrote:
>>>> AMDGPU SOCs supports dynamic workload based power profiles, which can
>>>> provide fine-tuned performance for a particular type of workload.
>>>> This patch series adds an interface to set/reset these power profiles
>>>> based on the workload type hints. A user can set a hint of workload
>>>> type being submistted to GPU, and the driver can dynamically switch
>>>> the power profiles which is best suited to this kind of workload.
>>>>
>>>> Currently supported workload profiles are:
>>>> "None", "3D", "Video", "VR", "Compute"
>>>>
>>>> V2: This version addresses the review comment from Christian about
>>>> chaning the design to set workload mode in a more dynamic method
>>>> than during the context creation.
>>>>
>>>> V3: Addressed review comment from Christian, Removed the get_workload()
>>>>       calls from UAPI, keeping only the set_workload() call.
>>>>
>>>> Shashank Sharma (5):
>>>>     drm/amdgpu: add UAPI for workload hints to ctx ioctl
>>>>     drm/amdgpu: add new functions to set GPU power profile
>>>>     drm/amdgpu: set GPU workload via ctx IOCTL
>>>>     drm/amdgpu: switch GPU workload profile
>>>>     drm/amdgpu: switch workload context to/from compute
>>>
>>> Where are the corresponding Mesa changes?
>>>
>>>
>> This series here was to get the feedback on the kernel side design first. As you can see from the patch history, we have already changed the design once and this is V2. So I thought it would be a good idea to get the feedback on kernel UAPI, before starting sending patches to mesa.
> 
> In general, it's not possible to review UAPI without the corresponding user-space code. I don't think this is an exception.
> 
> 

Sure, good that we already have got the kernel inputs we wanted, now the 
next version will be with corresponding MESA changes.

- Shashank
