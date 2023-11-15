Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3196AC07548
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 05:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A01D10E23E;
	Wed, 15 Nov 2023 05:40:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8914C10E23E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 05:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avi+lxIsPryeYpDNnTaeY6D56/eKFuXwi0aWobfs9IjYrJ7otICN0bsdn+9YJhBD4ESSrqKQSMF2YjOGyATgbVrYj6X9xhuvO1Fk9swAEv1McY9TCUn7gDMXF7wbUboiAfqJyxAHQArqOSXofQU4ss7UmiIihK6UoIcP96/I+B8+Re6I8wa0/0tAAjI9/f2i5qVz4lFMc/s6DTLTpTYjeGwG0ROEK4w/alIJ0stMcLwePhZpsJ5AmN/CWBI0rO2e/hzQPEcfxc/KYYjyR4su1ONgQ8ED57dVw/HDARQSj2kx+sWeCseAbCFQidnCWiuG+thkNBYDupsgPFMTwoew1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKemhbMo5n1M0VvnNIXEFRfWQHKiBU3vQRnNeWXn8ws=;
 b=kWqAcgoHJyCyoUoOBT9Hm16GP0JlutUVSQreXILli9P6LHc6KuV8O5z3kXrz5cmMD2+jPQMZ9K4iYiJoF9HkFYE/bV7HuQxIa3Yh9WNB4sYLRlK4olxNNFeIC5GmQY2kQsNsBWviNAo/hYhWyCE6CtuRoaLBli1YBfl6jMUsjng3Ke2T0DF/yHZ8NQeoZw206XVJWB96yZPXMPmBT/Ncagb0imhbggiNQFQwq7N06qk20/SgUkCIXe5UGBHNvJvogeVC62zKOWGBLzvtP/iPB4hkar6e16gjZjgsc8x+bai1G06+0+0fYW8b87yRBmvQvkZZmYdZ6+7mwa77HZZj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKemhbMo5n1M0VvnNIXEFRfWQHKiBU3vQRnNeWXn8ws=;
 b=eWSohjJyJfDegiRSlapxA3TqJzqUKemBMRN2ZY/SD8899EKYrXBZJc3gjOMHyPNMs27ajxwc6zWZVCOzxTI45BLpSu2cWn11JXzPEwayyjIYhJlgbHdpJ8TIWzOZIjSJEfgf96jFIszyQ5RyWNUdFCUY+g23jdc5+jsSd3dYya4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Wed, 15 Nov 2023 05:40:01 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 05:40:01 +0000
Message-ID: <becd39fd-c20f-4b47-b814-8806a10baca1@amd.com>
Date: Wed, 15 Nov 2023 13:39:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix the error of dpm_enabled flag
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com,
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20231115051808.357777-1-Jun.Ma2@amd.com>
 <e523f30c-6af5-ad1d-ae22-7d0d9c72c563@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <e523f30c-6af5-ad1d-ae22-7d0d9c72c563@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3590e90b-0112-432a-6961-08dbe59d4f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZjPlP4lSmQCk9ONNvhW8EQVutn4owt+NpIVQyyOi/ZulS037O2QG84lm1D08U3s8Omtfcmb5Q7q6kVk7RZKV/N5W99tgObhatut6EENNDeRb1QeACeXtQ9V0Xbt+aHxI4fbPHauPhHhMz/iTKa3A0f2wgGjBYbOcogR+DDMoBFK4swGnvn4UqdrmviIr8OWIf+Sum8uOI3zMcyBrtIeWYDx2I6F5A7VD51tV3F6q0Wc37BpraLmHyqwHxs1LxxWeXVRqKdy6rEYWmh4iStv8Baf6kQur/ETiAHshNCJ1/aXFEOHtg2xg7foJqvH/O85ZcLAh3VYC9hzY8m7t6LKFOApTxsjXbHkQ3Tk3E7Z4cTZ1RDZvQxw6mwcLHbgt1e+ZMwzezNmliRBMamBp2mIpyeIMblTB6MBO+OltNWD61EmhPeuqZdWTkq3gx1+YTp0GROZ/KUMNUDl2i/rYkfdKiFtcPgvSVmzuZNm/QZTB+EgXV+OxE9eRwte/N2migUnZc2HxAk/H9sUJ4QPmNoJO5wA8TaXf6W/Y9HfRMz/Iv+1uNHc+r1rElfTna6LlvsFyLkc7MJY/QjpIhxUp19HbZAMIkKs0zV6DlHmf2LT4kxozxqTVOyxs3MMkXwHAVaZ7zwDUOSJBAKtJUvOTJDRUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(6512007)(26005)(478600001)(6666004)(6506007)(2616005)(5660300002)(2906002)(8936002)(8676002)(4326008)(31686004)(53546011)(316002)(41300700001)(38100700002)(6486002)(66556008)(66476007)(66946007)(36756003)(110136005)(6636002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjkvb1BsVGh6UFROcmtNcUJtNEd2WHlsYStJRi9NYmNsNVE1RjJ6ZDBDdEZU?=
 =?utf-8?B?U3lQYTN6UlRKN21sUThkWEZGRkxIcmQvcXU1cnRpaE0wWjd3bFZhdXNwYjZR?=
 =?utf-8?B?RE1aZWJlYnI1LzNuWG5ZVXFRTWwxalZUeGNUTFE4aEVzemJpNGRxMzJwSDNS?=
 =?utf-8?B?ODBOOHVIRDdwaDZjOW1ra3JFV2NSTzAvQnVPVGtld3lrNzBSMkFEN24vVXVM?=
 =?utf-8?B?U1ltNlNDM3NWSEEyaUpWTU1sVURibjRmYi80WXFSamp3ZHhhSU9pMlErbUZQ?=
 =?utf-8?B?L3F2OExSdEpPQ0tJWHJ1cDBSd1RKbzhCOEpDbUwvN3hROXNyTEROYmMrdkky?=
 =?utf-8?B?aERMYXdicDNQRE9icEtQUGtDN205Y3AxK3lmM3JYcTg0NmxleGV2VGVHdjNt?=
 =?utf-8?B?NHVveU4yRWduME1MNFdrRG95cHdoRnR4RGJ2eUk4aVlwK2hhQ0hkeUxTckZl?=
 =?utf-8?B?VUVQaWlVK0FIOU5mcUhwQzYrS0ZYdVI4QTgwZDRKU29DMHZjbmZ4WjI2c3lQ?=
 =?utf-8?B?Vi8reVh2U09MNGRXWnhwUENXSFF0VXRxSUVoY3pXNUlCVWE0OWxqUks1MDdq?=
 =?utf-8?B?ZkFUbTEwNHFrVkZiS1dESWJsdXlZMXdsTUZZZ21nRU5NQnFVTEx3d2tBaGtr?=
 =?utf-8?B?TkZjcnhPZ3RBY2tNQm1McUxjVjU0Y3Z3bDFsU0lVZStpTmxBeFFJR0g0bVJY?=
 =?utf-8?B?d0Mwb1czNEpKaXIrNExxeVFveWFzbXhmY3k3djE0M0JUY2dDSStmUHEyVktx?=
 =?utf-8?B?Z0xJSElhbkMwenFiYVVIWklvWVpKdkk2SFRzYzQzdyt0R1N5RVBsUURNZ0Zk?=
 =?utf-8?B?Skh4NFlHcVQ2eWhyUDdQZy9zSXpEZ2R2c2FUSG16YVdmVldnZlM3OE9qd3BW?=
 =?utf-8?B?cStzNW1Hc0pJTW1aSVFpM1FoM2VQM2VmNnBEa0NzdzVGNE9ZMWd4dkNaaEt0?=
 =?utf-8?B?LzYvbHVsd21WSk9ZTDF2RGtvcUZ0cVU1dzVvdG5uTW5PTGpYSE42UGRyQWNn?=
 =?utf-8?B?b1lQNmUzeUtUVk9KbGtwK0V4UVV0ZkQ2bmcrNk5GWlpnK1NXWVVvR1VrajZn?=
 =?utf-8?B?WnV6S01nSU5MdXN1bDRrOUJ5SGFZMmNFdmExZWlaNW15bHR4ZTd0TTI4cXpQ?=
 =?utf-8?B?UGgva1RzNFZBWUxtMkhndUVuQ0gveWZnYTZscVc5RlpmSjNnRUhJWU5jQXIy?=
 =?utf-8?B?Ly9iTjMvdFd6NmhmOG02a254dFJ3SzNQc2IxdzZYbnBQbEk2eW9jWExwSE9m?=
 =?utf-8?B?RE1OMHpubGpMMkFwMFZBaWgwOUZxZ2cwcTFhTGJ3MzhUQ21PQm95VThNQ3dt?=
 =?utf-8?B?aVNOMXhGc05rRE4yMUJrTkxRRDREV1hOWkhuY2JqZzMxQXVmMWxRVXZvTDll?=
 =?utf-8?B?cysrWS9lQ2xsSlBJc1pFNWRwVEQ1c2RGams4elFtd1p1VzFGdnJGalF5M1dQ?=
 =?utf-8?B?eGxQT3NzQ2FlZSsxNTNvTXNqdlN5QWhITWRqR01RdDRtbHZZd1JNQjAxdFJn?=
 =?utf-8?B?ZzVwSXJkVnlvMWQvZWg3Z0pPNGk2cjFXVUJZbUhWQkNycnNHbUFxMmJxQ0dJ?=
 =?utf-8?B?MzFiUVhBdGhhci9JWHVBalVGdU5EVGd3Sit6NGpIVUlxRHVYcStQdGYvT3B5?=
 =?utf-8?B?ZytIQ29udEpaUlI2RkZ6bTNJSmRvclp3NGhjZldHSU4rWjlqbjZ0RDl2OXEx?=
 =?utf-8?B?aGNib3dDU25aWDRxZENLRGhtSWs0R1p1THhYdEs1dTFNUnJ4N2xzbWpzVkhE?=
 =?utf-8?B?QStIbGZjeXdmSkg2c1lIWllOR28vbU0vYmQ4RWhPR09VbTVVd2RLS3NjVFBl?=
 =?utf-8?B?U08wVVJLZmxqK2Z4bjFWZ0tZUHA1Skc4N0FrOXFIUG9WNDBkMGJpNkxqRHFJ?=
 =?utf-8?B?SDBGMDlaMGVjL0Nhc2N1RzRIaWVoaVVnS0grNHFhZ0VNQ3R5T0J6MWNrVENk?=
 =?utf-8?B?eDdkTk5sZldsMDhydEhCYm8rRGVRVXhzY3A4aUZWcHp1VmVlM2xlb3Y2NHc5?=
 =?utf-8?B?YWwrdG1tYnZUNm55NGlZSWJKYjVvek9TUThaVFJGZTMveVZHZXhKbDlZL1Vj?=
 =?utf-8?B?Q3Q2dXVZamRaRG9LQUYzc1V4L1FXdE53MFhtenY4SXlHN01mUEhXMXh5bjBi?=
 =?utf-8?Q?4dZFGgKY4588dNGTblJVCBVPC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3590e90b-0112-432a-6961-08dbe59d4f70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 05:40:01.0533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCLeMVWuZFmlZWsghqpN9BR1Js0+ItW2pSQ8vNKJnj8Yp7DcpfjOsTwY7OBeAfwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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

Hi Lijo,

No real issue here.
Thanks for your explanation. :)

Regards,
Ma Jun

On 11/15/2023 1:27 PM, Lazar, Lijo wrote:
> 
> 
> On 11/15/2023 10:48 AM, Ma Jun wrote:
>> Set dpm_enabled flag to false only when dpms is
>> successfully disabled.
>>
> 
> This a software flag and we block many services based on this flag 
> status. I think the purpose of setting it early is to block other 
> service calls which could come in between. Did you find any real issue 
> with this?
> 
> Thanks,
> Lijo
> 
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 1b9896001172..4bb86315e8c1 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1740,6 +1740,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>>   		return ret;
>>   	}
>>   
>> +	adev->pm.dpm_enabled = false;
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1762,8 +1764,6 @@ static int smu_hw_fini(void *handle)
>>   	if (!smu->pm_enabled)
>>   		return 0;
>>   
>> -	adev->pm.dpm_enabled = false;
>> -
>>   	return smu_smc_hw_cleanup(smu);
>>   }
>>   
>> @@ -1808,8 +1808,6 @@ static int smu_suspend(void *handle)
>>   	if (!smu->pm_enabled)
>>   		return 0;
>>   
>> -	adev->pm.dpm_enabled = false;
>> -
>>   	ret = smu_smc_hw_cleanup(smu);
>>   	if (ret)
>>   		return ret;
