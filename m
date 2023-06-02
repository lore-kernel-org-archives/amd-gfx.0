Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD7C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 17:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BF410E064;
	Fri,  2 Jun 2023 17:45:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6776310E064
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 17:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSiDhTCRcwuS81MV52s+LvTdsYW4OK4UopKdo7O/as7idUgljiUgJeZ9RZLZns3pJVPYKaELF/OkNaNcWWZGoj9xqW82qDiYDfnY1fxcH3+3h5cczUloKjkmpCIqNJEjIWXBtWBpJFLzr+K7ENARwcmAdoZf5d/J7dPyO/SKXs5GS7SA0tH5O+0qkqqrpfJ9x82fC8eizTK3uOU0WUT9+9fwrlXOFq8aksblHgLywcJdiCsVpgqvGUpDAvrq7Uwq3GRql44yp7UCwhlBfwhJdii0xtw17oixITJOlmwjTcB2L6S8bOVDU97Nk9TiSCP4W24tO/BSLgek7YiDgrsmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Fqv/dczjjQYtKJ8Vd2jnTCtknTFbcSBorcn9jvlkw=;
 b=MZ8lovWNAS02X5g3O6j6QXbQPwQs6Zs4UXdH1XmUHqr62igHyb9pa1lUxrR7VR3eysfnV/iD1ySTItv1JfLNfP/jgLfnIO363G31YPfv5Mtktg5Rg5B1Ztn1dUHUSKrPsAnj1piobe/5hRniQyNGJJlJujLL7cr8OSI1ZyNYEh1Q+4hWw+LvUUGP3/puiOp+Yd//Xo6M5zbk5twWKM6pAMb9nSnL8BY17+e3NSdtdNx/qR0W+8fCSuYby6mqgemU1TZTE9+klPFCVdhfjHxs1tKCKqaCsfi6ysETdnNI+gUm63Nlba1Ge51wXZB/BIFnES+cB6oxs5zsTfFv2So9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Fqv/dczjjQYtKJ8Vd2jnTCtknTFbcSBorcn9jvlkw=;
 b=NVEmWsCGAxaWhJGmLwtmIxurSYEbsEBFT3rtMM8YXA9p9Vsc9qVTNm87JE0/UtrPrTkF1hQVaPcC74gQ66QEhAfl16PTyX+DONudHqIKPheLEG28mTy+k27FvlrCHN+fUw2M2Uvh0q+R8Pngb48J4nVvdipvxYXL54i8DhVXGSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 17:45:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 17:45:04 +0000
Message-ID: <84cfc3ae-2cce-4620-2e51-40b8929b2feb@amd.com>
Date: Fri, 2 Jun 2023 13:45:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: fix debug wait on idle for gfx9.4.1
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230602155801.1438646-1-jonathan.kim@amd.com>
 <911b646b-c1bd-f65b-be9e-0df32cd1dc12@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <911b646b-c1bd-f65b-be9e-0df32cd1dc12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7ad2ad-d1d4-44d1-7c8d-08db639118c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoiQESvQJ5nKvcoX8OlYBS7mqpqKwPW3r2wUA0+n/p4d7kXHo4WVpdc9AYkGh1I4ODDm6KEG1MhjyZr/TvwrtIwySYLwbtSbzk30kPeWhzuDg+AWf9H3BGcq36OptoZDPZ85Zpbh7pv/OOi8J+RQo192b9teBkjhqZ5TzSpnfVnDaczwHLKY0J5WNSN89uzOEhu0FiR5FVhUhv8uDkNMuSVWKvhY9SzZ3HhyGO6zPJEoQ74QaW96dEh0qgbaT/iyirD4CD+OkjJxUjrHS+4gbqV10bEshtiRbYla6RBvi1C046W19LcHlq7aWeB/pMycjw840mpd1MYM6xE0IZ5P8zIQUQv+Dq/hGI6mpW0rUIaNUO5gA9WXO/1KDbBv8tmIwnCSMBwrNuyCFJZKPdea3ri2UuJhffnGoqOBBtmZ8v7wSSHV/6gtOGy/bDUtA73X4JOwr+TJHGy3qayzFG9u2onnyqJFJ8rGOJbmx1ZqtPC9ccyk5zZE7XdObRNmDPw+o4IvrgbJTffj6973wqPfNc32RCe9n2LI5BFxIiPTZqbkChQWqdanw8E+GRyTbQtlyDxTlPSFW9ez1LkL/6VIMC53Bst9ZZ0hnGa6acLuiya80ucS7pIFJ9hrmQba2588h2ICV19DuMFaZONWYBqQbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(53546011)(66946007)(66476007)(186003)(66556008)(31686004)(4326008)(36756003)(2616005)(31696002)(6506007)(6512007)(83380400001)(26005)(2906002)(44832011)(86362001)(8676002)(8936002)(5660300002)(38100700002)(36916002)(478600001)(41300700001)(6666004)(316002)(110136005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUlscXBVUm5nRytJL1lFeU40WXhlSlZtc1oySnhueWpyOVVGdWpWajZqV2xM?=
 =?utf-8?B?RDEyR2ZqSzIzeThybGRubERMNXdBVEdHK2YrYmFTQ1YrTmpHK2JqOTV1Nmg1?=
 =?utf-8?B?RkxCRk50Z0trQWhMclJ0YmZCUVJTZS9obXllaGE5djN4YzZtVUs5RGlWZE9t?=
 =?utf-8?B?cW9HbU5VcUkvcTBCdGhQTDgwU0dyb0NRM0pKTitkWEZpV1hZRlpFMGE3NFIw?=
 =?utf-8?B?ZC9zWEM3YituV1h3emRhdTcrTnQ1ODNlb1Q2cjlBd0JlSmc0dzRnR24vSUZu?=
 =?utf-8?B?TENFYStCN0hjMVQvWGQ5NS9JVUZZb0psZHR3eVRZUHBrMnBZMnYyY2pYMno5?=
 =?utf-8?B?eHB6cnNXakZqTko5UjdKeXJwSm4rWHlydWxIQW0rWDNyVWRtWGRZZm5YU21Z?=
 =?utf-8?B?dWRwUHgxOVMvanMxY3dlV0ljQ0g3MmlnbTRPUzZSazdZZXRmbFUrd1pRRXdn?=
 =?utf-8?B?K2tZWktUUkhPSEpndnFFYnF4eXFvWDZnTk1qbzdzcGlvREgybGxZVTFUMk5a?=
 =?utf-8?B?ZkFOcjZOTFRvUHpDNlo0bGdCKzF2bmk2Q2x0Rm5YdkVtOUVDTEFmclJqRlhH?=
 =?utf-8?B?ZlJtRlNTOHczKzc3ZHYzbHp1b3RYK3BkU002OGlMOWp2cVI5WHl1MXBLWUpE?=
 =?utf-8?B?WFAySXo0OHBwSWVVNXAydUFxQ0NZVWZDVHRoU2dVWHF2VjhMejdaMFJXYjRq?=
 =?utf-8?B?Z2UyaDg2MThHNTN6WGg5OURsalRZVWJsUUJENmRLUFAzUjE3RXM0dGJVVDQ2?=
 =?utf-8?B?VXNTSzNjWENBanQ1U25Ub0RRVjkvMFVpMXc1c0k0K2x5MnJOVU1LR3Jqb2hh?=
 =?utf-8?B?SUpsSGlETVRPa1lYZWt1c1JDQ0JhejdxdXRKTURyZ0ZYL24xLy92b0ZHeUUx?=
 =?utf-8?B?bGdpTzJmSHY2SUIyVlF5ZUVUMG5aOW5xeUQ0K2R6RXhwcHRxUHc2LzZSdDJx?=
 =?utf-8?B?UmIyM3hiN21BWitaL0E5L1E2cVJ0ZFZOYWNyQ2xycGVwazV6RWtXaDJrd2Nr?=
 =?utf-8?B?MXEwaUZ5aHExTkdocEhvblM1VDdKU2lOUTBWQVE4YlZMRlYvN3hkUzEraTVL?=
 =?utf-8?B?WGFBbzFPWkJENUIxV3NpZzJyc0dLdlk3RVdza1FMdWk0QUNPNFBobFo4REkv?=
 =?utf-8?B?ajJEbW91NmtaR281alZ5M1BqSlo2aE40cnJsSmNJYUcyMGVwS2E2c3hta2NH?=
 =?utf-8?B?dnMvMjhsUXpHbFJyT1BnQjZwMnd0b0t5MVdDWElyL2hZL3lFT1ljMGx1Qld3?=
 =?utf-8?B?SDRFZnNrWktZdnlaeUgwbS81ZHNaZXR1RFdJK0pPSXh3cVVmMFI2STZxUGNI?=
 =?utf-8?B?RHZQL1ZLMnhVNXI3SlRSSVEwdVBRWjdielBPd3ovQ0hMcm1Eb053RC90bXYz?=
 =?utf-8?B?RTEyMEJBaFNlNjdVbVFxMDVwNmd2bS8wV2F2TlFWMDdGcDNYRnBtVkJJZ3Na?=
 =?utf-8?B?QU1kSTVMQWk1ZjM4dVI3a1VyUUVKeWV3aGo1VWVoek1SWUtmTWd6YzZsaDhO?=
 =?utf-8?B?d2FPcG13UDhYNnZ5bWZxbzBBVmlTQ0Nsd292SWtVeGNsOHFJQUhaR1BOUk5o?=
 =?utf-8?B?V0dDOTBBc3RlUXZVdEE2bkFZK3JoMU9BQUZNQkRrN08zYXc1Z1V3M1N5M2R3?=
 =?utf-8?B?ZTJ2bXlSTFJYT1JCVW1RMmcxTXlBVEJaMkNXZ1FjKzBZOFVTVVZEM3N3eWxS?=
 =?utf-8?B?L3Z1S0RxNVRTU2JhNHJQUFY4a3lIWWk0V1Z2aC9LZkhPaU1VR3JKZE0rc3Vk?=
 =?utf-8?B?Sm1TOEV2bHpBTFFSUGM1bEtjRWNRVjBBMDBxSzJCUmlvU3Z1bEtXUU9nK1BS?=
 =?utf-8?B?UU0xaThQS0FJb3NHL3FSdHBqczBLQXBtTHdpZzZ6eTMvNjVvOU8vSVU5djMr?=
 =?utf-8?B?ZGt5eVNwRlZaUFdxRzRFd0pHZmFMV3ZYMVlmWXU4bGpjYUhCVVg3K2kxU1hv?=
 =?utf-8?B?M0FpUE5NQThweExUby9mS3BWK20vTHh4VHpieFNDSjh5Ny9nTXVvYlV0Zmhn?=
 =?utf-8?B?UFVMbGtaU0hIU05SZmlqb3ZGcnJoRjcybmlKb0lVUFFZUWRMWlhvQ2lFNjQw?=
 =?utf-8?B?akpjNzNKR3ptc1NIV0pNUmhiN1Q2c1VwZXNJTXhiNkRuOXNlZXN4UnV0S1dt?=
 =?utf-8?Q?qh3lCw4hcU+flZDo6NcbhKdY5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7ad2ad-d1d4-44d1-7c8d-08db639118c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:45:04.1887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OZvJg6ylSWzQm0/r2V7paCb/d+aMtWCXwegj81j3xJ33mAsNTI2XeruV2m5Hi2sP9hhaTqF0/wy5MWU/0tWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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
Cc: Kenny.Ho@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-02 12:37, Hamza Mahfooz wrote:
> + amd-gfx
>
> On 6/2/23 11:58, Jonathan Kim wrote:
>> Wait calls for amd_ip_block_type not amd_hw_ip_block_type.
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> index 6df215aba4c4..625db444df1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> @@ -309,7 +309,7 @@ static int 
>> suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
>>       if (!suspend || r)
>>           return r;
>>   -    return amdgpu_device_ip_wait_for_idle(adev, GC_HWIP);
>> +    return amdgpu_device_ip_wait_for_idle(adev, AMD_IP_BLOCK_TYPE_GFX);
>>   }
>>     static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, 
>> bool enable_waitcnt)
