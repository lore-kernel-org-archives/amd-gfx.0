Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A661BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 09:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3835B10E586;
	Fri, 28 Jan 2022 09:33:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BB910E586
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 09:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8oC84gGA6RhlFuHNsRwX9N8QA9aDpS6b4ebs5bd8lEgS30hXlz6cKqUrCUWrVNaNierSIR5KKR4aLURic5z72xLHbIy1OOVSDZiK/NEv9YOENU/yDZAqAWdh03aOp2tvAGchjaB+qgYeOiRccxIjhkGmScqF43ZnESLL7buzzkTh8TrzrRi641Pl1w/atD58cot8JjqDgJx/R9S8xO99Mha9wfIq3loWhRC96DEdCXkB0zxPNlWxvA6q5jG5e01iM+7eLp12ASfATsmZ/z0oBp6xuA0fXZ/NSKHTovGC8X1ECSUV5qZE4fz9q754a9HI5PY9zGWzEESvweVtzDlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32OFZxprLr2Vkoh7KDs3siL/hApfxg/p+n/KMaylois=;
 b=c11bgOeOdv64z4GAcetuizh83WEMeoX5vScZTv4Mz317P6jou7ol+1F+znoHTdHGpLtHePlHe5+ZetVNkjT0UTbFpAABk3BI/I6ikwxCh4zsbtuQ5LsgyredVJoBArY0c/QPnuuP6ZcmNqG9C0bos7l3jw6KPn6uZe71PwA66mtuQpWUs5bZhYh9fVqISMdtEIpJI2gNf7r3BFIxvhrVokoy8dOg8AxJ78ccjNo//SO52dWPmt85C04TxLNNLMkH58mDGBUfy0Vq8zNGXtlkluNH968GyoXjI/e/Zr4t1kB4Wp0E4MXw4RT92wEI3QzgEL1uBvg4TuqI/yYVR7PeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32OFZxprLr2Vkoh7KDs3siL/hApfxg/p+n/KMaylois=;
 b=GJnoG1kQIuQ7FOd2mB3BuDACG7XTzr+KOLIYUmDUeknC5f0iuKiVmoE5tjjN42T11B2V22N+XUa8EdplFgxAohSn4OyWp3fPhJF7bGFWtApahlk/ImkBZ3psUnnsCWiRKfnXdtZ+a6X9SObO9W9IWJGzHtN1icWNakcZP0H4BMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:33:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 09:33:40 +0000
Message-ID: <44478e5c-d885-831e-30eb-e92bc74b4064@amd.com>
Date: Fri, 28 Jan 2022 15:03:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220128065409.1479854-1-Lang.Yu@amd.com>
 <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
 <YfOuy/sVoKBpJI5+@lang-desktop>
 <e2976675-f3a3-084e-2d90-b3000f216098@amd.com>
 <YfO0h5OHkLZj7Dtn@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <YfO0h5OHkLZj7Dtn@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::26) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bb5fce-2d40-4bee-179d-08d9e2414474
X-MS-TrafficTypeDiagnostic: PH0PR12MB5645:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5645837DA802810ECCD3887A97229@PH0PR12MB5645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQ05AtBw1dK95TNo5CKU2ECRFtRvINPz4m9cHWDsPSnqn2cTj4iTIIyCrj1hATHyOoqHofeXdEQhYTXqYS1RHKubAB6jW6PJzrNYM4FatcqtV94NQqlCvEalPa85dlGr4zO7vFO4QV+PF8NHpnSXcpD5vqVGO+Y47yavpI/BWCBYMnFRlQvwXkSAGqsM0DtRMQNwMZKtTy2baI0+4YXt6CtZP6tIgMn/1F6xDrWY4zXMOwSmOTXLTCaiy1eTHkHlMMep3EWaR0xG9IbzUsPGvPblIcun9DGipng6oycomlqwGALDWVtusjhAA9WE6HJ++dLJOyFVAUP0isRi3Djdq1IgYe2+JFDIJ03rsbgvmchx8d9zt1t/JXMetOcnDJIpdXjuBwAAdFAhdbN7U82q2eCN52Az3YTC7NuwNGmRjD+RyH/8EiwvhpeeaHW4cmaqEc0fw/H9oidV+89cAct3qjtYSCnqEEMYf5jK8tdD2Xr5vwE3wDCjx/nGmyKdJKGLGrDXDki+Crttk82ZvAby3adAnsItMwK414mUkJ0s9rXPi7QCz2Py233wtFjpS22OjMZ9PMyBoRnD6qT+1VKA3i5leBc0YaS4ScRfeFl9RrDO9+V+7j3nqUGv17fVaoB6sq87wV+P+Tce66/06/VlB0NWc5iv1GbqIuX5z2qS5cw1dMcOQl1JKeKxzXlqADCB2CrAZbomaNjw4hSHT0L4Y5GgN1w0Woidscmv1A4RN0YekvdPzGrWEDq4jTjXilVL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(36756003)(186003)(53546011)(2616005)(6506007)(26005)(31686004)(5660300002)(6666004)(6512007)(508600001)(6486002)(37006003)(66476007)(8676002)(31696002)(4326008)(6862004)(8936002)(54906003)(66556008)(66946007)(6636002)(316002)(83380400001)(86362001)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lKeStUZk1CWitlNEFjK2JVL1BaOGV0emJvNXZTd1BQWERiQndmRS9IRnRj?=
 =?utf-8?B?OUdObEpYWUd2dEVLTFJEdXlGSTdla2JtYWthbktIejRuV3A4bThzUFN0MFJH?=
 =?utf-8?B?V2dXaFFIY0dia2ZmMU9WSE4rWi9mV3o2TWVEVFhrblc3d2l2V2dhK0lYRzdY?=
 =?utf-8?B?SXl0a3BacWJpN2dQQk9VQkMyaWJWa2dBNUdTQWF3eWM4SkYyOFc5WkZiZ1ZJ?=
 =?utf-8?B?cUI0ZXFNcFZkM2Y1ZUtsRTcyd2ZDbmQ3VkMzb1E5OC9yV0xXaTE4U1RHYzRS?=
 =?utf-8?B?L0NHNHRvcnRoaXNXK3RmVHBab1VRcGVtaXQyelAyT09wTEliaEZCY1N5Znd1?=
 =?utf-8?B?WHNINEg1RGQ5Q0twbmp4OVdPZDUydXpWekVFTGJBVGJHQmZ5RUdtRGVNSkl4?=
 =?utf-8?B?S3J2bnBpLy9aMnZnc3UxMDB3WG15WEIrbTQwMWV0T0RTeXdLNDR1VENCUkZu?=
 =?utf-8?B?b21rME45dTZwSkQ5SE9SM0tIcCs2S3Qvemk3WnNua3B0cVNINHpSOUhGM1NE?=
 =?utf-8?B?TVRzYWk0MDlseUYzYjE1TFpjb1lXMG82eDlXYWZLVm5oUWR6cXkwdGp2K2Vn?=
 =?utf-8?B?c2N5WUxrSzJ4OVVNaGEwYy80QVI2T0FkQzZYc0JORzVXdjJCbEpZWDNZNkNM?=
 =?utf-8?B?WGlMNFpZSWl1QXJ1a0l0bjIrbXBjTkZpZkFUaUowK2NMN0dkR0tKa3J3eDNV?=
 =?utf-8?B?M3ZlZExZdlJnZ1MwUWZxZE9CYjBxYTAweEUwODZVZGdHQjIwRys1Ymx5aTRm?=
 =?utf-8?B?MHBlcXkwVGJtTG8zdE9Qd29SOHgrQ1NyTFNqL0kwTTdmMlFaVDBibVF5cTVz?=
 =?utf-8?B?eDhBLzh1WUY1M3BlekFIM0NnZ09VeGJ0UVZiSmVpaEFyb1lOYitkbTlMemZz?=
 =?utf-8?B?MGZSYnE3ZUdXazRZWG5WY0MvY1lvTlpCNTFidEhTTDhVTmdpd2U4cW01RW5n?=
 =?utf-8?B?WHpHL1dNS25XaWhJMEV0cFdqa2V4WVpWMVpGcm9kTWpKc0tQTGZUMlhaODV3?=
 =?utf-8?B?TnE1UHdQRDRvamlmL2crM1plcnEzOEJSYUczUTdEUlpKYm9ZMklkWmVwa1Ew?=
 =?utf-8?B?Z0VPd3BscWlSbEV6VmtrY0Nnc3N2M3pzeU54Rm1xbFNpMTRMNWt6K014cklp?=
 =?utf-8?B?enlXZGo5ZVhFL2IvSHlTQTJjM2FCWVgyWDQraldWMGJ5U3Bwcm9HSE1pR0Ew?=
 =?utf-8?B?UDlLcXNKeml6V240TDZia0tjNVVZRlpiMk9FVUQrd2NiMEoxdXJxT1R2K2dp?=
 =?utf-8?B?N0xCd2ZDY3pTSnlRdjRGb3kwQVBUWEYzSnlWZzhDdDcrOHA1L0NEZ0ZTR0FK?=
 =?utf-8?B?UU1PRmdkRlFGMm9wdVNaVWZnVlliQ0FvdXRGVklPV3ROdDlGZjJMREx1SWVa?=
 =?utf-8?B?cmdTN1RWa1grazl2dlV2UDRkWnAwa2R6bHcyeXdrLzhDMm5KSEY4azFYRnVo?=
 =?utf-8?B?VUtMM2t2dWxpTWJ2bmlqVlJHa0xramF1Q2ZRWXhNRXFoTXlUWkVvR3VFOXhM?=
 =?utf-8?B?QlVYa3A1UkdORzRaRUZ2T2ZxNFc4WGkybXo2emVJelZIVzVZY1hrOHUzcDNr?=
 =?utf-8?B?ZXBYeU53ZWROenhMLzFyOFhEVVhPK291RnRoWDBmZnBLZGxNL3g1ZWZtL0NH?=
 =?utf-8?B?QU56UkNJN0ZqRGhkLzRZQW90dFQ2cUMybmpFVkRiMUp4QVZXQjJucVc0Tlov?=
 =?utf-8?B?M0ZkU3VybDVSckxNcDFyU1VNY01XWlJJbkhYTEtCY2ZZbjBPRVA1bGlkbCtq?=
 =?utf-8?B?MU9xN05ZdEtmYmI0ME93a25NMm1lTkw2M3orcE9HejFkWnR0aXozcEVMSVYy?=
 =?utf-8?B?UkIwMEZKVjlwZ3V5TEZZN005UGxOTnBTWjZUTm1UN2UyK1Vzc3V4MnczVUJV?=
 =?utf-8?B?T0ZYOTl1eXBLd0xlOWJ5aTBBNmt0RVpTdmU1TkdWNnFacG1CMTMxYlljVVl5?=
 =?utf-8?B?MTBuaERYNXJsQUx2T3FXMjAySTlqeUp2V1FheW5kbEV3elFxeFVoSW1KMUxi?=
 =?utf-8?B?T09qazg4N3FrRU1LeThQUlNWWHM5dlIzMWdINWFKRmpIeHVJeS95cWlLcGJw?=
 =?utf-8?B?ZzluLzRjTW1IOTBwN3JqVGZhdGlHZjBuVFB1WjB0RGtzVmhJd0JaZHdlWnZk?=
 =?utf-8?Q?mSHg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bb5fce-2d40-4bee-179d-08d9e2414474
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:33:40.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAEGQFzIaAOJDHSvIZUAfIPvIZ5U8DJR0hExSHN+Xto1JaCwlRdzSwKEIqItk3Qb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/28/2022 2:46 PM, Lang Yu wrote:
> On 01/28/ , Lazar, Lijo wrote:
>>
>>
>> On 1/28/2022 2:22 PM, Lang Yu wrote:
>>> On 01/28/ , Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 1/28/2022 12:24 PM, Lang Yu wrote:
>>>>> We observed a GPU hang when querying GMC CG state(i.e.,
>>>>> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
>>>>> skillfish doesn't support any CG features.
>>>>>
>>>>> Only allow ASICs which support GMC CG features accessing
>>>>> related registers. As some ASICs support GMC CG but cg_flags
>>>>> are not set. Use GC IP version instead of cg_flags to
>>>>> determine whether GMC CG is supported or not.
>>>>>
>>>>> v2:
>>>>>     - Use a function to encapsulate more functionality.(Christian)
>>>>>     - Use IP verion to determine whether CG is supported or not.(Lijo)
>>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
>>>>>     5 files changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> index d426de48d299..be1f03b02af6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> @@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>>>>>     	return 0;
>>>>>     }
>>>>> +
>>>>> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
>>>>> +{
>>>>> +	switch (adev->ip_versions[GC_HWIP][0]) {
>>>>> +	case IP_VERSION(10, 1, 3):
>>>>> +		return false;
>>>>> +	default:
>>>>> +		return true;
>>>>> +	}
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> index 93505bb0a36c..b916e73c7de1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>>>>>     uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>>>>>     uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>>>>>     int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
>>>>> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
>>>>>     #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index 73ab0eebe4e2..4e46f618d6c1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>>>> +		return;
>>>>> +
>>>>
>>>> I think Christian suggested amdgpu_gmc_cg_enabled function assuming it's a
>>>> common logic for all ASICs based on flags. Now that assumption has changed.
>>>> Now the logic is a specific IP version doesn't enable CG which is known
>>>> beforehand. So we could maintain the check in the specific IP version block
>>>> itself (gmc 10 in this example). No need to call another common function
>>>> which checks IP version again.
>>>
>>> Thanks. You mean just like this?
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 73ab0eebe4e2..bddaf2417344 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>>>    {
>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> +       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
>> 		*flags = 0;
>>
>> Yes, add the above line also.
> 
> It may clear CG mask of other IP block. Does it make sense? Thanks!
> 
Ah! right. No need to clear the flags.

Thanks,
Lijo

> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>> +               return;
>>> +
>>>           adev->mmhub.funcs->get_clockgating(adev, flags);
>>>
>>>           if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
>>>
>>> Regards,
>>> Lang
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	adev->mmhub.funcs->get_clockgating(adev, flags);
>>>>>     	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> index ca9841d5669f..ff9dff2a6cf1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> @@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>     	int data;
>>>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>>>> +		return;
>>>>> +
>>>>>     	if (amdgpu_sriov_vf(adev))
>>>>>     		*flags = 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> index 4595027a8c63..faf017609dfe 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> @@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>>>> +		return;
>>>>> +
>>>>>     	adev->mmhub.funcs->get_clockgating(adev, flags);
>>>>>     	athub_v1_0_get_clockgating(adev, flags);
>>>>>
