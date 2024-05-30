Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D7DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2DB1134CE;
	Thu, 30 May 2024 20:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HeiMFNrS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9CA112825
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGgnPhmF6qGzLWwVUPOyMMdSmeqwrtDyPvoZa93wc6uX8bEvJQ/nWd/Ht4sz7/fkR7JFSRMPTQ6XDoQG7EdNGUX4oD4l2SG+IVeIw9eL4vYE0rlvpj09WO/oIAHriqUGOL8M3RQGBPzASfvZWc12Bl5+MIVcE/Mzj9i2dCdxQp1yCQzqo2HjOeFOkquDdJkzZEKXm85bYxM/p1hDrjo+FzqpA0zn7H9uxLb3cZPmuMRezQA8XX02SkRdLjMYBISH9UYSHsviIdiLo0hXmziRaaIM8zUxabmnPSMeP/1KQ3P8XFns0/9NlgzdwZF+bwtCMn0vja1XCWPJsmlR7CkyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42epkw33GZe1skum8hNmdM9EqXiYXW4tYFdbML8TJNw=;
 b=ST3ENesiDtn9OaBnCWpj/k/9LNmjXqz2jy0W/4pVyepTcvwTpxw4KgHrxUz+FL8ZpxuxN01zCHtXwh2U1VJcCicIjCiSjizbuxyt9N4K/Ek2Og50A+IT8njTtnUrsEAwF48FWWm4c5UsvYifxH/edVCXcq+3BUZclxz3hJTqZ4WCikCdHi6hmhS7SERl+MWkzz2ZnbOWjekPeUunwWJNOBz18l3nPpHG7u/nW1AXaByBsJFsYGhPJe8Ses2I/mMTUZkb4o7NO8BraWMo9hOpMpWA1AhBAyLpLezbUAYCELLDD5qAC7tj4XGmqlTFcB4JfF2eI4B/q7C5bhyqmx7FbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42epkw33GZe1skum8hNmdM9EqXiYXW4tYFdbML8TJNw=;
 b=HeiMFNrS5S6hkX8owGwYK95NskniOBlj1tDSO+ChIyO+/ZxB+i2el/x3SIFzq0H+VRmH6y36wagKfgu+dnBhB5qUaRK6s2Te9aImb9250dWWPBS5qVV22a6KOvwVx9+gYl6dERmSYrg9h3hfXw0POpfytWVp4eIksph/tUVb9bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 20:51:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:51:44 +0000
Message-ID: <20acd03d-dcd2-498b-bed3-b5f2ecc0865f@amd.com>
Date: Thu, 30 May 2024 16:51:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdkfd: Comment out the unused variable
 use_static in pm_map_queues_v9
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530035012.2341573-1-jesse.zhang@amd.com>
 <15b6ed13-acd6-4363-90ea-e5e87a834a59@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <15b6ed13-acd6-4363-90ea-e5e87a834a59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: d95beb72-c04a-4dbd-55ce-08dc80ea50ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVljRWpRdTJBaE5SYzFWL1hEWkIwU2hsVHhWTzNFbjVCZmdLTm5pdGRqalZQ?=
 =?utf-8?B?blpKb011cklITXJYQWxXVkQzUHVPM21ST3hlcXEwZ1FNVk9zYUtPZWNMYlJs?=
 =?utf-8?B?aTFncWhBSzdmL1dBdXowMklTVVdGZ3BPQU1ZWFcwUEtJOGh0R1JVdGtleGti?=
 =?utf-8?B?Y2JGbEFlMkllQW15TUl6eG5kTjNDZTQxbDd6d3dMS2ZpUStEZ3JNMW90UGpJ?=
 =?utf-8?B?YThqQ2t3Q2dFUkc2cTh6Skp1UzVqQmpRYXZSMm04YW1hNTNSVEdwRVlIS1lI?=
 =?utf-8?B?MEFrcWpyTld2RTlFY1VRSVZmbFdIaG1DQmpSLzNVd3NVUXcxS3lhd2VQMXVw?=
 =?utf-8?B?K2N5cldOL0VXSkFuemhXTERRcEp0WnFlTEh4YWNhblBTUndFdTBoZE8yelVM?=
 =?utf-8?B?RGoyb0M2aGl1YVhOZWR2RW9XUUtHdGYzaEF6MEJ5bVFQcTBmQ0xSZjQwNnpT?=
 =?utf-8?B?NHBIeWhPZWd4dmJUV1JuY1RXM2RFUVZZeERzT0FpQ3VuUmtnMnVMK2tnaGla?=
 =?utf-8?B?WEJrbkkwa1VuWC9BaEtoOG5Ba2pLdFV4NVgyMlR5a1lFNTB6bzVlK1AzV0I4?=
 =?utf-8?B?MFBXUlRWQWd5WWNtNks4dTFkalBWVmhFa0UvQUtYTWNuNjQra0VIUDI5NlVu?=
 =?utf-8?B?cFdxMXBzK2xjOWJ5M0ZsRHUwc254S1JsYkZwckd6Q3pnUm9tZ2liZVh4d01T?=
 =?utf-8?B?U2VYcS92SmFRcTkyT2dDQ0xZL2todHpzN3grMHZXc3dBT01NYzA0cG8vQnNv?=
 =?utf-8?B?YVRSblVHTXUxM3Boay9UNmNUU0dkVTBaSi96N0JVcW51MzdRS0NGY2MrZE84?=
 =?utf-8?B?T3R4TE4xZE9qMXE1T1JiWmFCQUJWY3Ruc0VGcnFZQzRta2t6azZEK0NCZ0Js?=
 =?utf-8?B?TzVCY0ZSZEh2Ri9Jc2pEeGE1dk5EUFVKSk9YTUdIaC9RRHl5QWV2SGErT2JO?=
 =?utf-8?B?bzBpYTZnMDNmTGlrVlpYL2lad3lDZnF5RzFuaWk2cUJzU3B1U21YSzAvOGxi?=
 =?utf-8?B?anNzWWFzQms2UmloRlE0ZW1NU21JdWFGcnpGUzdyZ043NURoc0lkbUdkZENH?=
 =?utf-8?B?Z3ZBZlpxV29ZUE5pcU84TE01cm00SVFJc3VaRG1lZUJkL1BGZmdkUmhQU2tI?=
 =?utf-8?B?QUZyeGNUSGQ4a0hSRkVkS3BTRXhZN3liQUJ1WjFITnpmeTl6OHREdFFwajBl?=
 =?utf-8?B?Nnd4ZENOTXVqU3pib1k0M1ZDWTV3VE10bzBqOFJQUWJOOHRpTVF6dTlzOGpG?=
 =?utf-8?B?WkdvcWszeVhZdVNlWkJONmxNdDR6cjU1K0JSOVl6QkpIM0xQT2l5YU53bDZF?=
 =?utf-8?B?UGRxek10OXkvemJBUXpzSDFHVUVnbGdKa3I4azZ1MWJUTHozR083bDZSeTZW?=
 =?utf-8?B?eExOWEh5dlVqajhaR0g1Si9Gc3hCR0pkMjljOFBqYnVGbnl3eE81dkp2bXhT?=
 =?utf-8?B?dlh0VWR6M1NpZHhvRFBXbm1lWHh5SURPNzAveGVVU2NJa05HMlV3c0ViSHhr?=
 =?utf-8?B?M2hKZDRDbVlFSG8wQ1pEcVQrWG51VzNmenlVbmFoVWxhUGtTZ29UdC9tdXR4?=
 =?utf-8?B?VWh3TVFPWU1uM0IyZjBXQmEvTEFkUEhKTTJDcVRpT0RlbTArQmpuUEtKNHBS?=
 =?utf-8?B?ZG1kUGRBUG9NUTBJK3JuUWxqWlZaU04zSy92TEdFTkptVlc4dS91bFdiTjNV?=
 =?utf-8?B?QnZJbzg5YmpIbUdSOURCWHo3eGhOWUJTYmo2TDlpYXJhLyt4TlFCRlFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNQakZ3Z2lNM0VUQ1FEOTYzbFBpQlB0TXcwUUhmb1dQWFRjbVlLZVZNK2li?=
 =?utf-8?B?bkF2ZkR3VUVPaTdGNVAwMVhzMStZdndOaGRsY1hkRW5Hc0RYcE95SUhBSFdy?=
 =?utf-8?B?N3crb09FY0JnOXJ1bFIyTnZjQ3lqK3RpYnVDbG1WU09NQnQ3bVNUYjVmRndO?=
 =?utf-8?B?eVEvTHc0SGZJTUhxUDVQMGRiRHZ2dzc3d0JRcXZ2OWl6NFI4V2ZycHRjTjFH?=
 =?utf-8?B?VW9zZ29vZ21WTFRoakpUUzhrQSt1eE9xOHBrclllcDJieTRaVFljZXZKeC9v?=
 =?utf-8?B?bXpiYjdlQ1dsdCtNTXdhN3A3SmhBbUJVeWt1VWIrdXRKQXU4MGxOZFJSWHB2?=
 =?utf-8?B?b0JoQXppRGhFWjB3Zm81VStDeUU0aXF2K2hDMzBTRnRPdmY5eEdpTldSU01K?=
 =?utf-8?B?c2dudENNYXZFUFo4dnowTzQzdGxtcjhtaWh5QmEyVXhvc1A0Qk9HdDVqY1JC?=
 =?utf-8?B?WjBManhmY3U1OUdscjh3VVUxWWllRFh1ZTV5VlFOQTdrQmxJVG5yWC9WSnhK?=
 =?utf-8?B?WjBNU3ZhN1B6RVRraEZlSTVrMGxGZzRBVzhaamdVTXFicTRHdUJGT0RqMHF2?=
 =?utf-8?B?Um51Zk54a0RnZXBJQVlxODMwV256RjRxTjJQbWFFSUp1V0taRkNOMXp0d0g0?=
 =?utf-8?B?U3MrOHlCOERjMjQrNHZVYUdwT3ZQRURGSis1QVdaZFFnRUZnZ1JUN1k5K1oz?=
 =?utf-8?B?YWUxUEVlcVZucjQ5akdRdFQ4T05PbzFnKythbzJ0djd1MnZXQkF6M2JUQUNy?=
 =?utf-8?B?OG5oU3crQm95a3ppdWI5Y1hvTE1QWXNhYzk5SGhjcTN4SDlKcVNFUHRnVWlN?=
 =?utf-8?B?bWZMazJ3czhvdWRvU0JYZXZTeG93TjQ4V3VuVjlsQmttd2JJby9OMHdKSW9r?=
 =?utf-8?B?U0RmaDF1b0srbmtMeGhxdlRTWW5ubUJ5c0JRTDE2SlZReWVOMzVzYzVBMXFR?=
 =?utf-8?B?OUNSRGtpLzdmOFJYVUhyb2RrV2VLZjVFNlpRWml0OWE3aDBpbThFV0VHVFRm?=
 =?utf-8?B?SEwwL3FPTGhsREYrVVJOZno4dW5Mc0xCNHhuUkJEQ3JrVXZOQllVOGxYenF6?=
 =?utf-8?B?L1JWR09ScXIyeDlqZGxiMm9zeXF3OWJiNGc5a2pRQ1p3d3RhVGpTYWFhRXZF?=
 =?utf-8?B?RHVCeUZYQUJ4azQzcEtKU1VlYVNBaGt0VDB6U2J4S3ZoVENEL2hRYm9peXdz?=
 =?utf-8?B?MjJXOW42VlJhZHY3cFRBb1Q4VkF5YlhrcTkzQmY3aEF1S2lyYjZsU2pSZGRI?=
 =?utf-8?B?OTB1alVNWi9KbTF6NUVDOE9BSEE2bTFVcmRwK3pxUTZuRmhPb0tvOE9ESFdz?=
 =?utf-8?B?RUdFVjEyM1BoWjF3UldJU0RlMDNOZ0p3QW15Qy9YMFkwY08vVmEwekJ4bGdI?=
 =?utf-8?B?S3g5T0RnRGZZMWhGbklmNEtQOTNndTIzaVA1emJzUlkxTDZQcll4L0FwT2FR?=
 =?utf-8?B?NzhKMmloV0FqTjQ0NUF5SllqeTZ2anFNTTRPRWNFbzZDTXluQWUzN09JSURi?=
 =?utf-8?B?YmlVRE5xNXNwZlZrLzdDdXd6NXBmai9aZXBJMzhyMTBadHFXV2tsVnlFL3JI?=
 =?utf-8?B?MHorR0phUm9nYXg0eGNMd3crVU84WjVLYjZVNmNRQ241MUdqeXIrOHpncWx0?=
 =?utf-8?B?WnIyZWU2TStWNHZoSGU5bGJydnlKS1hNWlViQk5RWkt0eklpNUQzRGtHQi9U?=
 =?utf-8?B?dzFTQnpkbGtpYU5UZHFRMTczWE5oaXp3Wi83TjZZMWFkUmJsVTcvdjNIcGdj?=
 =?utf-8?B?bWNHemovOGJYVHhHTlpDeWJBT29aeHVLODlBT3Z6WnR3ajQyc3ZxUGQzck9T?=
 =?utf-8?B?aitaYzUwa2p0cWZvOW5ucDdKOFc4OE5reG1lVDdHM2NWTU0vdFFRb0RqK1Jz?=
 =?utf-8?B?S0pxVkZBL09kMDZLV3hyM0duMlNjTitKSnRaVEpCZ0xkcFhHWFpzczNldVZG?=
 =?utf-8?B?bCtiRjBmenRnS1lReEh2MXM1K0RzR1BEemtobFp3SEdsWHE5V2xuWlZkU3B4?=
 =?utf-8?B?cW5KMk5pODM3ejd4SUhEYUtDWm53cTZCZ0FrK01uVjMyRXg0Q0xSWmZ6R2l1?=
 =?utf-8?B?S3ZZd1QybFZYQUlpS241MjlydTMxRjFDNitlcFNKa0lMaVVTbjYydCtmeko3?=
 =?utf-8?Q?pXMikk3//OyBvuAEfOHlEq8z2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95beb72-c04a-4dbd-55ce-08dc80ea50ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:51:44.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBehauIg8CVAb2RYwiUh26A3oxfLdZEByKalDplpJLCiA5zLeiiEXb9dF6pk5qq5bQmG22IcBDsaOpcukhrjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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


On 2024-05-30 10:12, Christian König wrote:
> Am 30.05.24 um 05:50 schrieb Jesse Zhang:
>> To fix the warning about unused value, comment out the variable 
>> use_static.
>
> Commenting out variables with // will just get you another warning 
> from checkpatch.
>
> Christian.
>
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 8ee2bedd301a..c09476273f73 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -244,7 +244,7 @@ static int pm_map_queues_v9(struct packet_manager 
>> *pm, uint32_t *buffer,
>>           break;
>>       case KFD_QUEUE_TYPE_SDMA:
>>       case KFD_QUEUE_TYPE_SDMA_XGMI:
>> -        use_static = false; /* no static queues under SDMA */
>> +        //use_static = false; /* no static queues under SDMA */

I'd just remove this line, remove the use_static variable and use the 
parameter is_static directly under case KFD_QUEUE_TYPE_COMPUTE.

Regards,
   Felix


>>           if (q->properties.sdma_engine_id < 2 &&
>>               !pm_use_ext_eng(q->device->kfd))
>>               packet->bitfields2.engine_sel = 
>> q->properties.sdma_engine_id +
>
