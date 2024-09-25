Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81191CF9C6C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 06:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEC010E099;
	Wed, 25 Sep 2024 06:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSGDSFrG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C137C10E099
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 06:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAdMBfAoLSYqZDAIgy7WiOmQbGYVt2R6GdRVVx8rF47DNHuLgKHpV9SazlPLrJGhfZ8UKjsozAbW3s2MpQbBtRnpLsbSTyRRAzgAJeBumV0b9jkpq2JH9B33lNecPekDJ+3hn6DGnQRU74DKTYJSXwW+CS7NEO5Y2GE2/w8CipreCyKf043r1DIzcnNQCB8T9xLKPBgFhKBi92K2MgUb4RnTa7Zjur0XafOB/JI/bD/ChplhOvf4lkEQ18VQTUIEsVvMeNYqpC5/tEOMF9sZ0iwXND9wwbbmnaxryRpTPreibyGrq8+BuCeuwdVcLXASvnZfMehieHNjVthXv5Gx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeguBCk9Y2gcg3EMxMnR0pyQh0+2dtmkYiBQmUK8IcM=;
 b=xbV9XhF08x9VPTQIMIg/nz/2185a9K4uONEcNhGS+y466Icy/A8OfsjltOVpqL7bK+RNcMIA/ODUhPX0el5m/4FT/NnxQbd+gQthlhpm6/hrwVUyBcDIcX8YPYpoH7DSi8J1yxtq8a6hqgJbreD1pZVi/tJcF2zpzTAnwaS9uw6TLU7N9LvH5t7WpLTLYWF0xG1FTf8VdzlVE8Cyx/tGP9csMrMi0RrrYD9xFYFa+Vq77hLsjWO41TrSvPxMQHtizLn0lBCBqjdS+uLj8qIAYeSrpB04636YMmUVxg9G9rgvlM/YdbbSqi5RduOjEZoFgKAO1wTuGS/OA8uJQXm7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeguBCk9Y2gcg3EMxMnR0pyQh0+2dtmkYiBQmUK8IcM=;
 b=VSGDSFrG1jOfqfWxkqyEuew+3VRNtD8rCT3gU9gZW4ERB0jckmaJODUo7u+bYzLyvNajw9nv6nZkfMJBeJ6Xe1RCo271xzVFqINWLuhGb5js6SgDuN6t9qrEQZrcGUAXo3+HMT5b/EHW8Ko7y8/BwGOLnYkg8/NfSD8OqUyCTRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 06:15:22 +0000
Received: from MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505]) by MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:15:22 +0000
Message-ID: <9c89000c-e5e1-4da8-be8d-fce3a787e2ce@amd.com>
Date: Wed, 25 Sep 2024 14:15:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/powerplay: skip enable mgpu fan boost in SRIOV
To: "Lazar, Lijo" <lijo.lazar@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, yifan.zha@amd.com
References: <20240924034012.237955-1-zhenguo.yin@amd.com>
 <a9bff99d-6d93-46bd-a13f-43a145adf93d@amd.com>
Content-Language: en-US
From: "Yin, ZhenGuo (Chris)" <zhengyin@amd.com>
In-Reply-To: <a9bff99d-6d93-46bd-a13f-43a145adf93d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:4::27) To MW4PR12MB6683.namprd12.prod.outlook.com
 (2603:10b6:303:1e2::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6683:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 376fc0db-40b7-45bd-a778-08dcdd296ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTRJMUZWYk1jYmY2QUxyVzM2SEhjU1RldVdrbHd3V3k2UjVwT3hvbkZWSWlF?=
 =?utf-8?B?azZNcUlRVXNGU25ieXhTMTQxdHZaRVZybUp0aHpVU0UyQnczMlBmc3VQcTFK?=
 =?utf-8?B?QkhORThaNlF4WXFGZGZpYjA1aDNSR2lEZklFWi9NNllqVERJeC8zdVhicGpP?=
 =?utf-8?B?aU1zZjdYNWJ4S2I2OHNpTE0wMFc1VE54M2p2YzV5bEZUVTdJMm1ZSXpjT1ZH?=
 =?utf-8?B?NjVRUjY0Z25SSDUya2RKRU9ObXZGNXZneWlNUk9HQmdXekFWamIvOXo1WnRn?=
 =?utf-8?B?QzVIVDVldnFrZUZWMUIrTTA3SER2alhTNVA0Mko2NHFVeGpDSG4wWnh1QmZo?=
 =?utf-8?B?L2xZVkxyanlGWmNCeUM0aExKbFErelZWbzV2RDdEb080MFhDOTJpeVdGYjUw?=
 =?utf-8?B?SEQ5cnMxdnlBZDVSWHo1OGNEUEZucUJRQVg5aWVyaEYzQThWZjQ0eWZyZkNU?=
 =?utf-8?B?NVZ2TVlMV2pCbDVEQlRiajhCOVhPOFA1NExRcWErZmtJRFpqQjlpVzZMcnpN?=
 =?utf-8?B?TDdRbXZwUkxZb2IzSTVOTlhUMFdIZmVWVlRLODdGMzFkYVVtYldYLytFZ1NX?=
 =?utf-8?B?bTV5VFFwc1pSQVFzOHA2M1pVSTBDNi9JQXN6MnV4SVZoeU9kSWNFYUxIbFVD?=
 =?utf-8?B?c3dTTVVFTGI4ZXJWUHpFTS92VDhmVVVJdVNxd0VmY2NkSldWS1B0K3lrRmpP?=
 =?utf-8?B?eDYzNHlMYllkWXNNL1Q1V3pEcEwwZzZuRjV4YkZMQkU4QjgxbjFvTkp6V3Yw?=
 =?utf-8?B?elJXLzI1M3NiQXRZTHpzUWExb0Q3aVVtREhVNEhmc0UrVWx6TWJHVHZTUGZF?=
 =?utf-8?B?WklSaWFFcTVtQytRMFJnVlk4eCtBMFplUytRdUVlVkxkSFdXaStBWnlMNkpX?=
 =?utf-8?B?bTgvQ1ZaamlVVjc2QktoZnVBYUFMLzlIWjFYZFhaWDB1bTBXOVJISTdiK0I1?=
 =?utf-8?B?NEFWWlFBbWJkUmdpSHNOcWFtZmQwRUVRNHBFbXVhNFZEZ0lqaWx2WUR0Rzdq?=
 =?utf-8?B?ZXpxVzd6WnFsOWhGZWMwSzQ3emlBOUd2TGxacjk2K0JRVzZNaXcwbmpNY2hL?=
 =?utf-8?B?cDdnMnNQUTVFaXhFUExwakpyOWhRSTVtb1Nwb3plVTY2SDdTSTh6Um1iYlNU?=
 =?utf-8?B?bHBMZkxMdUVRaTlLQktpZFVXcHNDRG9HNTg3RzRZMHVON3ZRSTUwRGFxenht?=
 =?utf-8?B?L1d4UldQamZvbmxSNTFHdnNkdFlQaDhndXdpNnNkRlNMK29RdXJHRE05bHlQ?=
 =?utf-8?B?OHRucXFFRXlJQ0c3VXcvYmFSczJBakNlcXU5VzM3QVZSaTIreCt0bThxamJu?=
 =?utf-8?B?UWJnakQrTTN3ZGxqdVBLNncyckFVZ2ZmTDVsN21QV0RoVElkMHVvcDNhNFVQ?=
 =?utf-8?B?WHB0ZEtrOEFGOGUrS3RnWUxwNGE5c3hxVkVTM3VpK1NXaFdIMmNxWlBiU05a?=
 =?utf-8?B?MkpvVDNIeXVPcmN6QXZ6Rm1xc3N2SndrTUN0SGkzZnpObVFRa2VFNzFLQWZy?=
 =?utf-8?B?d0Z2QzBLeURlanJTSnhCT1c1UlRBOGw5WEtqS28zVlpWN3d3VjluL0VGMXZC?=
 =?utf-8?B?UXBNeGdTVmYyTWc2MXJxY2xWbGlVSlJ3T21xZFdEYkx2UGs0NVVtYlBPRXUw?=
 =?utf-8?B?eTFIcmljU1ZHN1M5S3pORk5iN2FJaTVZN1V0dmpGOVpCcVJLVlJSekwwSnZE?=
 =?utf-8?B?eS9uMHNJQitUeGVhZnpxSnBWOHZPaFRxeXI0aDZZWTYweTlUQUdHWkh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6683.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFua1hLMXF4SFpVNjhPcytyM3g5YjNmWXFzejZwRWVkbmZaRC8vZ1pIaVBW?=
 =?utf-8?B?aFZENUFxNFk2bVZDcnpLZElwdUFYOUQ0WFFHdWtIODMvMVVvSFF6bnJVTFY0?=
 =?utf-8?B?Zll0WEdtWk50ZzlxN3dMVCtrbm9SSmUxbUF3ZHQ0QW9pUlVMRnFqYm05TmRa?=
 =?utf-8?B?N2hQRWcwZFN3VUpkN1hoVDBiY1dWaTRtVnVsVXNXeUdzSGx0UUdtSnVpN3c2?=
 =?utf-8?B?OWlkcm0zYmFxZSs0YTRsTmdWM29DZHhyejY1TitsRThjck9GL0w4NkowaXRN?=
 =?utf-8?B?OFJmR1BWNzNPOFRlNWNhTGgvRWN2MFNEYmN3bm1OajhGWmtTR29uaGNvdWJO?=
 =?utf-8?B?MW1kK1kyQzJSLy9TY2tjOWZySldxbWZ3NWp4VVh0V25rWmV6QTdpdU1xSGFm?=
 =?utf-8?B?STQ4ZTVqNGUxWlEwRElicHJnSGcrejZpdWk1elRkSWViL3NXT1lEMjY2Wi9B?=
 =?utf-8?B?Z0RIZ01LMjhDalNUWTlObE9nT3N6UE41dzdHZlExRVBESmt4OHg3TVZHYVNK?=
 =?utf-8?B?eW5tQnlteW1CYUxyVDFmV2hzaTY2OSt3QWxtSm5kak5tUStIVXQ3LzZBNXlD?=
 =?utf-8?B?WHZXa3VnRHpJZWNLZUdlcTZoR3o1NVlQL29LcFpVNXErUnhhSG03b0M4V243?=
 =?utf-8?B?NUhhN3N5dzRabk9qWk1SM2ZYd2lqV0xlSHZaOHF5V0NGNTA3OFdIampUNDlh?=
 =?utf-8?B?UkFPTGhvMWREUUI3NHZEOTdwZ3c1cnd0N3RzeTFFU2RqME02cHhvQ1lNNkl0?=
 =?utf-8?B?V2NOUWN1YldQc3ZhbWFRVVpHaDNsN0pvTVhsa0hadk9CeTNjcnFxZzU3VTkw?=
 =?utf-8?B?RHV5bERuUWdNYWZTbGl0Q0dNdHZTK3hMUlJMZEdBSkpPYW5UU1RiaDFYSGZa?=
 =?utf-8?B?U1FLY1EyTUxHWVppQktuSlgxLzZYeHlxYVZ1eHlHUXRCbVIySitCd2lVMDlo?=
 =?utf-8?B?cjVoQ1ZTaEMvK1p0MUNmNit5M2Fpa2p4MjZGbE1BZ3Y1ejFzTlluMS9GRWtr?=
 =?utf-8?B?d1l6R3hFL2FOMnZPK3dMWGZhbjF6dFFJODkyMlY2QzRNUXI2T0tnY3NucExS?=
 =?utf-8?B?WjZhb0JlajhkeENySVVPcUs2ZGM3ZWticGFFNDFOSXBQbG1MeEsvMmRIa3d2?=
 =?utf-8?B?N3FNWEtKWmg3Q1VLckMxQUs0TXBlN1lud3ovRkZod3pQaUhEa2tod0JSMUZl?=
 =?utf-8?B?T1VOVFJGR0l4U1RjZEVBZ1p6TlZxSjBHald5c0tUN294ckNzVE1PYXIwalRs?=
 =?utf-8?B?S0tDVGdLMmxRa3RrclYxYXQvTjdzTUNzaW5pRE1qMDJvenlzanJ6R2REcmdh?=
 =?utf-8?B?Z2RFeHRRSm01NjE2Mkw2ZHhlRzgveHpEYkYxa0FVOVB1WHl1YWR2MUxabS9w?=
 =?utf-8?B?WnJkZ2Z4SnNRQ3dJMGh0MjZVOW5BSXREZ0pDclBtUE1EdDJPOTNTM01HUlJ6?=
 =?utf-8?B?OW1vSnVFQmdsRFRrMnhmZEIxTkdsNUY4aEVKN05YVmVkS2JqSDVDbytXbGJB?=
 =?utf-8?B?enhtYU81MlR6ZTRBNGk2Q3lMQld4dEIxRmgvZkRyMUVidmxPMkNERHhZUjlF?=
 =?utf-8?B?UEk3NkZyMFpVV2RZWWxxQUJ0RW9CaEJGRVVOemU3eVVmamtXSnVORnduWm5C?=
 =?utf-8?B?cFZpQVN0ZGhqaG1qK3YwNnhDUEpLMUg0eGYyZ3NBL0lXUVh0RWF6ZGY1TjlQ?=
 =?utf-8?B?VW1RNUZNSURMTjJkcTNyT0RhYVZURWZ6dVZ5bkJCRlVidzU1YVA1UVd4L2lB?=
 =?utf-8?B?QTRtUnBQRnVua0lxY2ZsMXplc1Q2Yjl1a2lQSVVOSkZFTnNzWURlVGxjakJh?=
 =?utf-8?B?Um10SEkxYVUwQ3VJK1dlYlhnellkaVNpcDd1MVBNbUhEakpHUHo2VU9rSTMr?=
 =?utf-8?B?bTJvRVhvMkx6R1BOejcxbXM0bG5mSm5hWlM2ZXkyM0h6dlJIdkxQWFdXbzVn?=
 =?utf-8?B?MlNoSjJkVndPRDhtbnBqeXptMzRyUjhPZ0VMRC9mZ2NHUVBqSU5jb3hsQmhZ?=
 =?utf-8?B?TUo3cE9ZU3FTZ3Vkb3FieUtlcWlkdFBwSTFxOHcxQmxSampSREJoSnBtczRm?=
 =?utf-8?B?SW8zZFFuNGtVYmdNMHhydXhvbE8rVXgyVWNxN28zZEFGSmNtUm9OY2ZXSG1z?=
 =?utf-8?Q?LOle2j+0hz+kbnebYtfWAL1cl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376fc0db-40b7-45bd-a778-08dcdd296ff8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 06:15:22.4004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUdBhK7NaqfcGLrVvWgB5kcxZXeK2IWaBMA8d5dEbm+w+qUJSbMUbgP4uxVgE0QE58sWWUvq61/rp5DGtPnNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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


On 9/24/2024 8:24 PM, Lazar, Lijo wrote:
>
> On 9/24/2024 9:10 AM, ZhenGuo Yin wrote:
>> SMU_MSG_SetMGpuFanBoostLimitRpm is unsupported for VF,
>> skip enabling mgpu fan boost in SRIOV.
>>
>> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index dee57f15719e..49f320fc974a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3178,7 +3178,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
>>   	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>   		gpu_ins = &(mgpu_info.gpu_ins[i]);
>>   		adev = gpu_ins->adev;
>> -		if (!(adev->flags & AMD_IS_APU) &&
>> +		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
>>   		    !gpu_ins->mgpu_fan_enabled) {
>>   			ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);
> Better to move the fix inside amdgpu_dpm_enable_mgpu_fan_boost() so that
> any other call to this coming from some other piece of code also doesn't
> do anything for this.
>
> Thanks,
> Lijo

If we move the fix inside, the driver will either break and report an 
error message or set gpu_ins->mgpu_fan_enabled to 1.

I believe we should avoid both scenarios.

             ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);
             if (ret)
                 break;

             gpu_ins->mgpu_fan_enabled = 1;

>>   			if (ret)
