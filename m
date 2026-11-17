Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F61606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WF7/+W8w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C384F10F969;
	Tue, 17 Nov 2026 21:36:40 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B3210E095
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 21:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwAWtxOkA2RZATe7gH97cMyNOBo1cvWPOasFSgAs2KCOdRGMew16ll+UFHZQxK3XH2MkwIkKdwxxZWNY9aCozJmBmPo9C7OndV890q9gIFtPikCwvA/vlVnwWwBi5hPJPbBUM5y8VIUQeRwzMW/r0jicW00YDlrFx2x1RFn+j23klsQUp6CP21T/OSVWiv0/+jNJwdO4dI0/iFtMaTOyBT9KEa4TEPLqfecTmO+Dqlp0tET0v0sZF3X7AkLXr7WUnd/G1oGxD8nR5Fur0ni0ccnyAUQuTWpvjcAAIxB80PBGW6TzXsJ3RPsK6SltweoR5F5M8Jh73VhtpxEuOHYyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W5mXb5+6ubOh94Qldfh/XkGVvLvBqImpt7oOkIDaEI=;
 b=lD+WIvPDplRMj30c92Nfb9Bz2zjTzHaoYuDEfW/iquXSFu1rLnL6kBdCbOUtnVK+/qFLopG7OcQM7PqS1RpZFTNK47GwQVB2KNdylx2xrNLbiumxuQAL8jj3ya1xgop1izYrxdogLVKBCwW+AidRTSlliGaT2MTNSFeKwKuRpmG1b8Dzq8/YIjU6+o1LtRDpNK3raSNlLfphrPuDv0LctmXv5IASDZgZMeXj8e/65X7MOaLsJMwaVN6kDhcqUv4W4CP6SFDh5cr1+aNs3RxuHtuHnyQDesksA+qls/8L8FgRIqhizQZBy692AVb0nGmsVwvN1ci49qcQRvsY1M1fYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W5mXb5+6ubOh94Qldfh/XkGVvLvBqImpt7oOkIDaEI=;
 b=WF7/+W8wbmOivPjSryRUMEU1XtlS8M5yeGJBXb8RYx9ZwMZB0aSEXBx9KsATMqwX5WhddA2KXPHLWHyal5vVMqID7eSnxOBt34JPjUHEt5E1iFe4AAS7KCtDEGzIcBbFrFKxa4lxxaAG6tiWggfbrwISZwiWgj4ogKmNeX5nYGE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:36:32 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:36:26 +0000
Content-Type: multipart/alternative;
 boundary="------------4k10NP5XgIJwxnGKLGb7BQfv"
Message-ID: <69c5336b-fac7-421f-9942-1ee47943e3e4@amd.com>
Date: Tue, 17 Nov 2026 16:36:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261116191141.145348-1-kent.russell@amd.com>
 <9d649b16-d873-402c-9d59-70a5dcbb38b7@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <9d649b16-d873-402c-9d59-70a5dcbb38b7@amd.com>
X-ClientProxiedBy: YQZPR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::16) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5a855b-0ec1-4653-abb6-08df44f2d56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|8096899003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: qCs5fSOcXYBgNriJBZId7L5AKDGGtsVmuUyxApxsyyWstAtLRfMIsGZ1m+YgKnqRoFKDHsdgBf1L+p6wIvK0OGdlVAX+wMHgBxtzKwzo3M96chdAXGZdoGubziQNvblq+Aehm5YE32PbPWa6F7910OgdsqPEkAInOmRgqlGgRSjrFdYCqlJzapjrHWVkGzpW1lT+5EU4lHvz0f3YbPLwspVF8fHn5QT4S3AN8ZTd2KwjF+Nb5o+JvUVsTO6/x0idnPw6VxdeYavh1+KJ3ASLoO2UEds31kWUobUnAfk784dT1OZJnNjBKNu4vXH91kGGAHVskoy+uOvNthaLBD3GDg8wzW3h6QuafdvtanloSC1LSlhdtNIb/9ermYfmN0Yb49h7F8T7uIY1wIklWhM91OBXP4inoaj2gzTYMJRYQAg7dKhNcW+bFFnpWnueaeWIDS0L5COltjLSD0tc9RXqfvfJSOA4oQ9vGTkDPjxrnJSL8zDobq5qs6ccILAIaMaGDF9PR0FKgdBmnExUCZWKRepfah+7YwEszFfQp6TOzuZY08BKCTIH0EfhB9bIIkX+1gl3g3SPTjkHL6dBnb3jYyCLxScwbG0QFswgk9mFCZLGGgRWbJjdozVFb5pkgk6muhjYAEkdWQDKjnHVrMJBUgopdpyQ/s93fR8PsiTZuhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(8096899003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022113327099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJrcnFjZHErR0R3ZmQ3QzdIbDF3elpIclAwL0kyMGtrUUxOcXoxR0V3SHAy?=
 =?utf-8?B?TnVkcnZKdmJSUDJVVmRQNWZrMXphOGo4Q1RublBsdUIyeTFva2o5OURXZkUz?=
 =?utf-8?B?aXRRaEp6dXlHMm1OOEcyYkFkSHRFL1luR2JyUHhRbGVMbmtCYmRYK0FWY2k1?=
 =?utf-8?B?SGc4c2RBNFBNWjdwclRkLzJLNEJkY2N6YW4vM0EwUzNwWFRyY2l5Z2t0LzUr?=
 =?utf-8?B?ZVRxYW9IUzVuL0hGdnQ0ZUcreldWTVpSMUxKN0R1WFMrU01TNUFrTWltem1R?=
 =?utf-8?B?RCsvbEQ5UEtFbE8rYjd3ZUtMWmZJanIzNm5hbUZsSUhkZVdoRXorVm96M3ZU?=
 =?utf-8?B?YVZ0SUgzSmVLM2ZZS1NRZ1lYTVdXTlpGL2piNUJTcXc1bEl6NVlXRTVtdUdm?=
 =?utf-8?B?MkMzZm0rTlhIVmZid0ROd2VRWEFZR296SWsvU2NqSGVveDh3dmZoZ1FiQ0F0?=
 =?utf-8?B?bitkb3NYcmQ4Ym5FZGhOM1ZoRGJ0dHR1bG5FTFI1YlBOUnVOVnFjRGdlNHRa?=
 =?utf-8?B?S2sxMXBwTTBHREtXcURPU3NqK0pabVloNGJiYWtmTzNLMS9rWkl4VVF0YXQy?=
 =?utf-8?B?OUp4eDBSbnB5ejR2OWNrUzBET0dqMmtQcjRMcHE4K0FkQXVjdjZ6TCtGdTNz?=
 =?utf-8?B?RzZGVm84MWQxdURBVE9VZ1dOeUpRanVlUEdQN2IrVHQ0eVBjeWgwMko5UDRJ?=
 =?utf-8?B?VFk2dTc4eUh3S0NRRjlDbVFLY3NJcUEvMTVBenZDUW9wOURmeTVCbHBsWEY5?=
 =?utf-8?B?QmxBZkZFMk1HOUlNTFVQNnllcXREU1ZHTXQyVXJVRi9Kc2FTRklLS3AvOG0r?=
 =?utf-8?B?cC9BQzQrQTNmUlROeFRXTHJWYlBwT1UvakQ0WE4rTmE5RVFkYWRHUndMcnM4?=
 =?utf-8?B?VnY1Uks3OEg1K3NGa004Yms3dDJrSkI2YmV4UEljaDJxU2tVdDlVVXRwMzJr?=
 =?utf-8?B?Y0tHOEFLWGVLQUZEeG9scy9LQmhOUHlyeDRqWEI5NkZ2Q0JkcEVDbEd1ZVBv?=
 =?utf-8?B?K1AzQU9KbG43L0hZdUFuNlBzek9ybkhnYktVNXNZUnUrRnN0eWdGS3ZvWDNt?=
 =?utf-8?B?S21RRmRQSUFkZDFJcjMzM0RNSDBCSjRzeFJ0UGpCbS8zOHdhOWM3VXF5dnEx?=
 =?utf-8?B?TjJXbGNHcmhtOGZ6QjBscmN3TjhvcVYyS0ZWeU9pUDlUT2x2WS9EUHlnRC9h?=
 =?utf-8?B?WmcvNnFZSHQzQ1JQWitrS252ZWtxSTNWWkErSzRpSlpWd1BHWW5wdGRzNWpN?=
 =?utf-8?B?bUZZdWpKUS9YNFErNFpRSzU4TXA2WjMxQ2lFdU5GZjBCUUtBSk1JVXJtMHR4?=
 =?utf-8?B?UWk2M0w2T0VaSUwrS3kxeEZxRm5wTnpWTkI4NHd0UlA4a1NSV3hyR01NQU91?=
 =?utf-8?B?UHJ5dXRkYXlGL1FSZFNMMVQ4em41UXJWODh4THJNUUdDVzlRSktERzkyb3pm?=
 =?utf-8?B?NVR0YWgzd2FtamgxRDJnRCtGNDBmUjhHUjhQdVdJZTZzci9yYUM3MHQ4MjRk?=
 =?utf-8?B?b2F0U1dRcXRNbnRxY3pNSTBkc0IvVDNUWDBrdTg4RjNOQ1BsaGlqMmtNTVpk?=
 =?utf-8?B?WEFOaWpSajNKWEVJa2s4Si8xOU8xbklQTVN0UHRFMEVFRFJpeVZiWlFwanZ2?=
 =?utf-8?B?TlhoRmpLa2NMc0ROTitjbjNIVEg4THdHZHJSNlNUVms5QnFORTBVRUtLT2N4?=
 =?utf-8?B?UmRBNmx1SFoxMTF6TEhwUXlEWlNRdTBxVFpHejdlYk5TM1hTcHU5TFkvb3NM?=
 =?utf-8?B?c0lUeWExS3l3dkVMaHE5MldTdDBibFhiVHVIZnExMnNXa3Y0QlFFOXVSWFF0?=
 =?utf-8?B?ZTJKeXo1bVdKZEdHQmlmcm96VlpPWTl6T3NDalRCTUU2M0s0a0ZOVWZCWDFI?=
 =?utf-8?B?YUh2TVRscXhYQWtWOFZrKzJKSWJHendDeEx4VXN0OFJOMGNoZC9uRDVDcnd6?=
 =?utf-8?B?ZTB5MkdrTW1neE4vSmJVd3ByMWE0Q3VjQjMvR1B5THYvV2VYN3cvMi9QeXVQ?=
 =?utf-8?B?ZEd6VXdOTGRsajRxblBoS3pQanp0MXFXZGlKdkU5cjlqZDlEb3kxVVh4dFdR?=
 =?utf-8?B?N3Q4UXhCK2VWNUw2MDhaeWY1a1pCeXlHekV3ekc4YzkzYllUU1VKcmZtZ3J0?=
 =?utf-8?B?STdPaTM1SGpQUDNzMFlmMnhIejBYWVlMYVhQL3NUQnVyRnlFMnVHNDJuNEp4?=
 =?utf-8?B?UHRVcjlqVlE4MGY1cXhMak12endRd0VKYXZvazhqaWtuV0tNYitJZkxXeGdr?=
 =?utf-8?B?bkJzTGRPZDZlWFg0ZHorTnFQNzUrS1BSRGZ4OS81Y0hybWFpWVAwUG5MN1N3?=
 =?utf-8?Q?d+etnZkNZltH+WzZH1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5a855b-0ec1-4653-abb6-08df44f2d56f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:36:26.5624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXUWEGYVk9C4LH4HC2Dphn8R4RLKDPjvOaPHx6Azp8CcC3RqUhSHCPhCtXwDPLAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------4k10NP5XgIJwxnGKLGb7BQfv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-17 11:54, Mukul Joshi wrote:
> On 11/16/2026 2:11 PM, Kent Russell wrote:
>> This feature cannot be properly supported, so disable it both on the
>> amdgpu side and the amdkfd side.
>>
>> Signed-off-by: Kent Russell<kent.russell@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
>>   .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
>>   5 files changed, 32 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 08d3ff61edcc..d0ede277aa85 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>>   		gmc->noretry = 1;
>>   	else
>>   		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
>> +
>> +	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
>> +	if (gc_ver == IP_VERSION(12, 1, 0)) {
>> +		if (amdgpu_noretry == 0)
>> +			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
>> +		gmc->noretry = 1;
>> +	}
>>   }
>>   
>>   void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 1f57d0fa2c04..034cc3fd07f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
>>   {
>>   	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
>>   
>> -	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
>> -	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
>> -		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>> +	/* XNACK cannot be enabled for GFX12.1 */
>> +	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> I think we only the above 2 changes. I don't think we need the changes
> below.
>
> noretry=1 should handle the conditions below correctly anyways.
yes, I think change are limited in function kfd_process_xnack_mode() and 
function update_qpd_v12_1(), then set XNACK+ will return failure and 
qpd->sh_mem_config is always set to xnack- regardless of boottime 
noretry parameter. Regards, Philip
>
> Regards,
>
> Mukul
>
>>   	return sh_mem_config;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 3d2136adb62b..3b62b9e5ecda 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>   
>>   	mutex_lock(&p->mutex);
>>   	if (args->xnack_enabled >= 0) {
>> +		int i;
>> +
>>   		if (!list_empty(&p->pqm.queues)) {
>>   			pr_debug("Process has user queues running\n");
>>   			r = -EBUSY;
>> @@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>   			goto out_unlock;
>>   		}
>>   
>> +		/* XNACK cannot be enabled for gfx12.1 */
>> +		for (i = 0; i < p->n_pdds; i++) {
>> +			struct kfd_node *dev = p->pdds[i]->dev;
>> +
>> +			if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) {
>> +				r = -EPERM;
>> +				goto out_unlock;
>> +			}
>> +		}
>> +
>>   		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>>   	} else {
>>   		args->xnack_enabled = p->xnack_enabled;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
>> index 525989371378..63ba13a60b98 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
>> @@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>>   	struct kfd_process_device *pdd;
>>   	struct amdgpu_device *adev = dqm->dev->adev;
>>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> -	bool xnack_enabled;
>>   
>>   	pdd = qpd_to_pdd(qpd);
>>   	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
>> @@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>>   		qpd->sh_mem_ape1_base = 0;
>>   	}
>>   
>> -	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
>> -			pdd->process->xnack_enabled :
>> -			!pdd->dev->kfd->noretry;
>> -
>> -	if (!xnack_enabled) {
>> -		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>> -		qpd->vm_cntx_cntl &=
>> -			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>> -	} else {
>> -		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
>> -		qpd->vm_cntx_cntl |=
>> -			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>> -	}
>> +	/* XNACK cannot be enabled for gfx12.1 */
>> +	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>> +	qpd->vm_cntx_cntl &=
>> +		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>>   
>>   	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 546721b4d59a..059e22cd7f1a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>>   		    KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
>>   			return false;
>>   
>> +		/* XNACK cannot be enabled on GFX12.1 . While dev->kfd->noretry
>> +		 * should propagate this requirement, adding it explicitly here
>> +		 * will help cover any possible future reworks
>> +		 */
>> +		if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
>> +			return false;
>> +
>>   		if (dev->kfd->noretry)
>>   			return false;
>>   	}

--------------4k10NP5XgIJwxnGKLGb7BQfv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-17 11:54, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9d649b16-d873-402c-9d59-70a5dcbb38b7@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 11/16/2026 2:11 PM, Kent Russell wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

Signed-off-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		gmc-&gt;noretry = 1;
 	else
 		gmc-&gt;noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
+
+	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
+	if (gc_ver == IP_VERSION(12, 1, 0)) {
+		if (amdgpu_noretry == 0)
+			dev_warn(adev-&gt;dev, &quot;Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1&quot;);
+		gmc-&gt;noretry = 1;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c04..034cc3fd07f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
 {
 	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
 
-	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-	if (SOC_V1_0_DIE_REV_XCD(adev-&gt;rev_id) == 0)
-		sh_mem_config |= 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	/* XNACK cannot be enabled for GFX12.1 */
+	sh_mem_config |= 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think we only the above 2 changes. I don't think we need the changes
below.

noretry=1 should handle the conditions below correctly anyways.</pre>
    </blockquote>
    yes, I think change are limited in function&nbsp;<span style="white-space: pre-wrap">kfd_process_xnack_mode() and function </span><span style="white-space: pre-wrap">update_qpd_v12_1(), then set XNACK+ will return failure and </span><span style="white-space: pre-wrap">qpd-&gt;sh_mem_config is always set to xnack- regardless of boottime noretry parameter.

</span><span style="white-space: pre-wrap">Regards,
Philip</span>
    <blockquote type="cite" cite="mid:9d649b16-d873-402c-9d59-70a5dcbb38b7@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,

Mukul

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	return sh_mem_config;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..3b62b9e5ecda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 
 	mutex_lock(&amp;p-&gt;mutex);
 	if (args-&gt;xnack_enabled &gt;= 0) {
+		int i;
+
 		if (!list_empty(&amp;p-&gt;pqm.queues)) {
 			pr_debug(&quot;Process has user queues running\n&quot;);
 			r = -EBUSY;
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 			goto out_unlock;
 		}
 
+		/* XNACK cannot be enabled for gfx12.1 */
+		for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+			struct kfd_node *dev = p-&gt;pdds[i]-&gt;dev;
+
+			if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) {
+				r = -EPERM;
+				goto out_unlock;
+			}
+		}
+
 		r = svm_range_switch_xnack_reserve_mem(p, args-&gt;xnack_enabled);
 	} else {
 		args-&gt;xnack_enabled = p-&gt;xnack_enabled;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *adev = dqm-&gt;dev-&gt;adev;
 	struct amdgpu_vmhub *hub = &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];
-	bool xnack_enabled;
 
 	pdd = qpd_to_pdd(qpd);
 	qpd-&gt;vm_cntx_cntl = hub-&gt;vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 		qpd-&gt;sh_mem_ape1_base = 0;
 	}
 
-	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm-&gt;dev) ?
-			pdd-&gt;process-&gt;xnack_enabled :
-			!pdd-&gt;dev-&gt;kfd-&gt;noretry;
-
-	if (!xnack_enabled) {
-		qpd-&gt;sh_mem_config |= 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		qpd-&gt;vm_cntx_cntl &amp;=
-			~(1 &lt;&lt; GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	} else {
-		qpd-&gt;sh_mem_config &amp;= ~(1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
-		qpd-&gt;vm_cntx_cntl |=
-			(1 &lt;&lt; GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	}
+	/* XNACK cannot be enabled for gfx12.1 */
+	qpd-&gt;sh_mem_config |= 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	qpd-&gt;vm_cntx_cntl &amp;=
+		~(1 &lt;&lt; GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
 
 	qpd-&gt;sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59a..059e22cd7f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		    KFD_GC_VERSION(dev) &lt; IP_VERSION(12, 1, 0))
 			return false;
 
+		/* XNACK cannot be enabled on GFX12.1 . While dev-&gt;kfd-&gt;noretry
+		 * should propagate this requirement, adding it explicitly here
+		 * will help cover any possible future reworks
+		 */
+		if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
+			return false;
+
 		if (dev-&gt;kfd-&gt;noretry)
 			return false;
 	}
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------4k10NP5XgIJwxnGKLGb7BQfv--
