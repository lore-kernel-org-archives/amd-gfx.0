Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D73C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 07:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4838710E4E7;
	Thu, 20 Jan 2022 07:32:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF8E10E4AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 07:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ega6t8agNlhh4qoQeVA8s+hrCajaTwIrH8bHdHmlc0hJ9ly9ZFeQJ9vSVI5sF478viZ3rs7zzyITV8XmqTMx7cqKLi139PpiD+G7hBwkGWB3ScRJGMZOVLZSMsuQz+nqHouamJv5x09t75AiIVa3dcVMe8XA2GO+7hHi8XfzZCtER7Yu6VW9vYlfF8uWderspzJAvK1/YlOgivaWkuQWSkWm5OuAg+CyG+KxJ0MHMGODArx+LQzx0UFE00dVyUgLht/naQXLQwXLlYxfDX69itADUailjDA4u2vZWgiuDryhRodu+Mr6JABcoXRV0Rn6rDTB7/IMpWoHyN5A66suiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYvqLPxThMkJd7/bu5aITEGZOfElyna9VFpqVHiltEQ=;
 b=n7PxgfOkTx1iVoSI3AlCgEoykVcTlWkTPekjfZKw7wYlZ5XS+UowUAqEKTztD15iP34k936bgbsmV4uGSr121RAVmL9HkOCrUt1t0oJSFb3LmUnq1rvABrVW7VtGFcdpnwRxpW2lw30gIx6v7BalDS4sqrkdvJlPqdEkqH80R+vAaZO8p8ZTS7BHzBaVkNG6t3y86OZUJoLKezZuV6XyvKb127LwRBNTjfAZgx6NsQlEcgYUTX7joxghHaCWx20dIaGgl1YyabT73N44Pz5dRw90bhVJLMFzrGysiWWJsUMDPdXX04jJ0YzUcnzwReriuYTiEsV1Tw3vHj/hvLu6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYvqLPxThMkJd7/bu5aITEGZOfElyna9VFpqVHiltEQ=;
 b=5jaBuvc2j3Nk3bwzV1boZSLUoi/ecJL3uNf+zYROui6zrw7D41UdBaSO3hZhcSEaGI32FU2XCikh/3H48jmUIn/gSlXTK4YADSqSpJQhbL4wf6KfYa86jUxA4KtFKu5/AZM/5T1iZuZUo8PbRF6yvMnwDpp1BiJxutmdvzuHZn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 07:32:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 07:32:02 +0000
Message-ID: <e5707a05-6601-e5cc-1cf4-83af2bc14804@amd.com>
Date: Thu, 20 Jan 2022 13:01:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Content-Language: en-US
To: "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220120031850.350206-1-YiPeng.Chai@amd.com>
 <bed5d7a1-d7a1-5f4e-3c7c-b69a81d033c0@amd.com>
 <CH2PR12MB421560F22FF5FFF14F7A19D5FC5A9@CH2PR12MB4215.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH2PR12MB421560F22FF5FFF14F7A19D5FC5A9@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8933268f-7bcb-4fbc-3b0a-08d9dbe6f304
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3151349C61895E5CE9295C2A975A9@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7r3ks8MF5Nd6nstVRKyG6yRhuJCagCo64KzTp60gM/Z6+P45CgXIAvjf156dJfw7xlC6t8KD0o7Sa3hXjV55Q1VWk4MUDYUIL42BHSezDEfXp624gok0RndeJq9HaafStRg7uVQp0OnDWQtb9T8HhaS20VAMoy1fVsqFdlUDsj26+Fr51z1uAegR2hu2jmTOv2OalNAV2Oh6OgkHUkLo5azAYTmc4FiW9NF/vQKDe+uYSepPJTM09y5rjCVohV0Dr1TcHgtyfBhZl7BCvM+UXLLwXn3BwFzD4zYiBMGZLO5aZZwS43JHDE0680reHSK+oUmQtOt6wQPbi+zYXHkhg5T/fvzEPSBZ0iDlFa/3oip6HKN+kH/iTxVbcN6gDRvFPxLTG3BhVUJJ4tgEb6lYqnLl+OqjPXbqUMxMN9s8JMVEpZK9bSYru/HgHqcEYbw3fEMpQ6Y2nUB2DIm5UAPUzQsew6xVbp9Jt0ce2fwp8Ejt0kAWUVV58pAmfmYSW/V4jF7hpJWH/rqwKuLVNIIv23NeavstedUW6Um+ioYu6eVMTmGMF8MGfXz3jT3SyOCftIMLF1H5CF2Q+mx/pVZfp8os8OTem8m2gT1q2aLpdO7wK1ikS03VnnGJzOriEhhoaM1jlsfMtnm+3maA8ORcDwg/09FQmzbFBL5cReMvOffk7uwzfV0XZ2q0sP0ZXrbMiVx4sFFjIKMaXL7pwcmvHVjgKdk181o5GH28hfERF5KKP3wy5Hx/pkkrNG9HxEy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(4326008)(5660300002)(186003)(316002)(66946007)(66476007)(66556008)(508600001)(36756003)(6506007)(31686004)(38100700002)(6512007)(83380400001)(31696002)(8676002)(2616005)(2906002)(6666004)(8936002)(26005)(54906003)(110136005)(86362001)(53546011)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndjYzFzK0gyb240czNBNGxWZysxbUVLTnl6Qll3eUZlTXdlVmJEWU9mdzZm?=
 =?utf-8?B?T2cySVNITCt0ZWM1aTdBdDlVSWtWcDVIcG1ldkM4N3UwTzNxWUN3RnJPUHpW?=
 =?utf-8?B?YUFlQVdLaDZhenU5KzRFTkFpS1ZBb2ZBbUdDQ3YzaTVGcDRTOTBBaWNaOGQ5?=
 =?utf-8?B?ZXFFaENKak4xZ1ZrNjNURDB3bFhFQ0ZPRnNKRnZBV1pKRGhhNDdzbWN5cDhi?=
 =?utf-8?B?dFlDdjNQWE5waWh2MmxOZVVOTmRVZ2FoTEhzcmtsRVFWUTZtN0diaVVwbkZ6?=
 =?utf-8?B?amhVcTZuNDh3SUJjc0NYWjNvb3NCMnlZZFhtQW9Ic2hiRGsxZ2hnRnpaR2xo?=
 =?utf-8?B?d2tYSDRSaVl2b2VrQWpablA4bmw4Q09Hc0p1SWcvL2FIRWNrVjQ1dTdScXo1?=
 =?utf-8?B?KzhTbXBGMk5Jc1dmS3FoN201QzJQeS9SQkRJbFVvc3JJNkE4R3A3WHlDWlRw?=
 =?utf-8?B?SkNudkU0dTZlWHBBYi9sYVVhRFYzV3BkaCtjUVNLZEZ0bGxDLzVtazRHdkhF?=
 =?utf-8?B?aFlwcmxrSEVyQUJ4eFp2c3JubW85U2NuU2pWK01zcGcxbTE2UXZhM1VwVlA3?=
 =?utf-8?B?K3g3Ymw2L21HM0RmRFBLRTNVTXp3QUZFRFROUmFrOTMzaDBBQW1iajZmcUs0?=
 =?utf-8?B?bldpTnl6R0VNay9UZXAxTlNhNmpzTDRWeDdqRUZoR0RXRytheno2M1VCRVlJ?=
 =?utf-8?B?VGRsdy9uVVRqeDBwQXRpK1pKYmF5NC9oVUM5cURGVnFaWGczVVBYOWVsbkd3?=
 =?utf-8?B?eUM3VnlqbGxESG05NEFEeTZxMHpSTVB5V3hxS0NXREZ5UktQb0Rxb2laQy9h?=
 =?utf-8?B?UzhCK0xoNjZMbGdMeWpjSlgybldyb2ZJeHNHbWVpYnNaYUk3dUl0cTJBc2p0?=
 =?utf-8?B?aHBOUXhrSG5xUXpSS2hXRk1Vb1d5VkpHZDJmV0tsVzdvQkhVbm02d1pZOHZQ?=
 =?utf-8?B?OEViL0dmY1pTckpTTVJ0THd2bTlUcXV6NUhQVzNsSmNhQVdmZUQ2Q0tHMm1S?=
 =?utf-8?B?SGF2QzFYbXVXRXlRd25hTjJzUC9WcDFsSEQra2czSkJ0dGpFd0pqZHpZQnhh?=
 =?utf-8?B?NmRBbkFWRU5qeXJSLzZSbVhRa09xY09melpIa3ExTGloRGhBT2N2ZS9neEx3?=
 =?utf-8?B?Qmk2ZXQxelo5Q1FaMmFFQStiSzdNZ3h4WlJKR0cyMFd5bUJZWHBoemFhSDJk?=
 =?utf-8?B?M0psbzNqM0NCOWZ3R3FBQ1RvaDVQODZaWkQ0RE9yT3RRWnZSK1RQV09UTXl5?=
 =?utf-8?B?d3B3NkNrL0prSGV0MjJHa0tuMSs4ZHJ5SjN4enFSTWNXRWFzUWJSL1VBOFFU?=
 =?utf-8?B?MkovbTgrNjVBWU16YWFXakQ5dXoyb3dDNkpzUUJKRGpYSktZTDh6OVY4cU1C?=
 =?utf-8?B?RWJLL0lwVHFJd2RSQWo0SVZqYmZGMktPTmxDQVAxVmVxNnZOVGhXemlKNU1y?=
 =?utf-8?B?NnJIY1k0aWZVNUZYSWtJK3phT0FZYmdhSmdwOHpNSUZ6Z3NYTTE0bTliWFlu?=
 =?utf-8?B?NWUzRnFtd0RJb0tGcS9jc2VFeDZKaWU3QnRwTFlMcU1mYmlSNU1jMUpjVjh5?=
 =?utf-8?B?RUpEZkFIVkFnZUxzeHpNVzZsZDJYQWQ2WXlMampxc2NKc2wrL240WjB6NEt1?=
 =?utf-8?B?U3d0Uk1HRUEwUTZxZm1lcXNmV2tZS083U0RVeWZ4RFpMNlR4RGQ5b1JPWmFL?=
 =?utf-8?B?cnJrQmxrQlJjL0JXazhud25uN1Z5VjZhdzRQMlF3RHJHZjh1TUJDWFZ6aU5T?=
 =?utf-8?B?bEpHTXh1M3UvVGpnbldIQTQvMnBsa0hOOVRpMXNRd1FCbUUvbi9tS280QkdC?=
 =?utf-8?B?OEY5WEdBNEpHTGxsSGkxOHZDRXF2RG9tRnlDZkM0SU96N0J0RTQvOXNnOUJ4?=
 =?utf-8?B?c0pIL1NsOHprM2xOTkY4MjkxQzltZmkydWF1c1hCRWxGRVRwd3Rab0VKU29p?=
 =?utf-8?B?V1NSTmN2SlhrTG16c1R1TlIxSFhRVWlhVlRseGFmUUppMUlBRXp1eFF2UklX?=
 =?utf-8?B?aTVSdGltTTlBQ3hyZDdhYWVjaTNzbjA2WDR2MGlFNnJ2cDYzR1BlNGtMcFAz?=
 =?utf-8?B?d2ZXdFMrMUtLaFoyT2RULy9LcjdSTDBTeS9VZ3VsZUphVkVVUGU1eWplMFdm?=
 =?utf-8?Q?/+a4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8933268f-7bcb-4fbc-3b0a-08d9dbe6f304
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:32:02.1362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KwJaYqIMARdM0Wdi2b4qi2+5VoaFt40MkJHVZrB558iv84UgxqRRNsIB3lplMDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/20/2022 12:57 PM, Chai, Thomas wrote:
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, January 20, 2022 1:49 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: Re: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from .late_init to .early_init
> 
> 
> 
> On 1/20/2022 8:48 AM, yipechai wrote:
>> Move xgmi ras initialization from .late_init to .early_init, which let
>> xgmi ras can be initialized only once.
>>
>> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++++-----
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++++
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +++++
>>    4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 3483a82f5734..788c0257832d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -436,6 +436,16 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>>    	} while (fault->timestamp < tmp);
>>    }
>>    
>> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev) {
>> +	if (!adev->gmc.xgmi.connected_to_cpu) {
>> +		adev->gmc.xgmi.ras = &xgmi_ras;
>> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>    int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>>    {
>>    	int r;
>> @@ -452,11 +462,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>>    			return r;
>>    	}
>>    
>> -	if (!adev->gmc.xgmi.connected_to_cpu) {
>> -		adev->gmc.xgmi.ras = &xgmi_ras;
>> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
>> -	}
>> -
>>    	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
>>    		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
>>    		if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 0001631cfedb..ac4c0e50b45c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -318,6 +318,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>>    			      uint16_t pasid, uint64_t timestamp);
>>    void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>>    				     uint16_t pasid);
>> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev);
>>    int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>>    void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>>    int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev); diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 4f8d356f8432..7a6ad5d467b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -719,6 +719,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct
>> amdgpu_device *adev)
>>    
>>    static int gmc_v10_0_early_init(void *handle)
>>    {
>> +	int r;
>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>    
>>    	gmc_v10_0_set_mmhub_funcs(adev);
>> @@ -734,6 +735,10 @@ static int gmc_v10_0_early_init(void *handle)
>>    	adev->gmc.private_aperture_end =
>>    		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>>    
>> +	r = amdgpu_gmc_ras_early_init(adev);
>> +	if (r)
>> +		return r;
>> +
> 
>> At this point it's unknown if RAS is applicable for the SKU. I think this failure check shouldn't be there (here and below one).
> 
>> amdgpu_gmc_ras_early_init is return 0 always, that way also this check is not needed.
> 
> [Thomas]  Just like calling amdgpu_gmc_ras_late_init,  checking the return status may make the code extensible.
> 	   In amdgpu_gmc_ras_early_init,  the xgmi ras initialization may always return 0, but it may add functions that need to check the return status in future.
> 

At this point, it's unknown

1) If the device is part of XGMI hive or not.
2) If the device supports RAS.

For such devices, it doesn't make any sense to fail here based on this 
function.

> Thanks,
> Lijo
> 
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index c76ffd1a70cd..3cdd3d459d51 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1318,6 +1318,7 @@ static void gmc_v9_0_set_mca_funcs(struct
>> amdgpu_device *adev)
>>    
>>    static int gmc_v9_0_early_init(void *handle)
>>    {
>> +	int r;
>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>    
>>    	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery
>> tables */ @@ -1347,6 +1348,10 @@ static int gmc_v9_0_early_init(void *handle)
>>    	adev->gmc.private_aperture_end =
>>    		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>>    
>> +	r = amdgpu_gmc_ras_early_init(adev);
>> +	if (r)
>> +		return r;
>> +
>>    	return 0;
>>    }
>>    
>>
