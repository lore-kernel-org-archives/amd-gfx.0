Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50605CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 18:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26B610E0CB;
	Tue, 13 Oct 2026 18:09:14 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5D210E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtbxhCQxrHxS+f37KpMm3XyVLWBIkl57DmcCbvo1KmzxjNmdPT+a0RHh52RFoMrhEvMB/fALvZUeBTsPP1Lz/h96oj3EDCp/gHaSGoPbGQ2Wh5FTMQvqMOJfwA7UW/s762+FWqqyPnxuePlrmLC63NDMA1KoUKiSyS6vAdLj/KKacl0NcjqxQaFfwGqG3FQU28CZmoLRDglQv2MYv/UDO128y9a+CocqvJqPqePFWR5b2StIZ9oOYxzVcSffd/BOHHwiea3qiuGxZuIC75KdnruJonwl22fXJEwYH746KsY33tuL7JlAPNejuyx0+QXAFr/PbflkZ6qnlB83FYIZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZadb6X4IgwZqzSj5dCGlS6pWuwK9TO91FDlB0X0IBo=;
 b=itHIGmwIput05Kngiq0SxM9BfXwkpqZ7kMtM1nxxyKNNugBAv5q3yB4CXfk8Jod5UN88zAfUyNI76DM31L0vk4xFu5X7fapH4OYsJxzmdThekkI2rijEriJCIPCkMQRejP7Mnm3oXR+Yh7WabsYX8SkI8uhmY2rHgzSK8tY7XYGVWmR3W1uQnv8mAREokq5mNVhxqgA37xRmMLBZCi3vVV7UthUMH0+fdaqNR+8r+faYIyeAo30T1QQ1u7C+YV7p4UzP5JI5oa0SUADEaf3OWX3zijPnNCdnhXFdCyA4vkYI8UarHRbsjdxZXhXiR247H8JJgrgq4MdXY2EuBNQSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZadb6X4IgwZqzSj5dCGlS6pWuwK9TO91FDlB0X0IBo=;
 b=ewS3GdKxqYZEXc+/BxWRmgsdN/J6r0XPZWKOZk+98ZS7bwbmv7LsrqsKJGxjlKWIrIKh6AEK3XIcxgX8qGYSnbeTruJQYVznPrOfRFd7pKPhR1RdAupu4wwylgHDnozDtqoX9dgBiIEtBLjkfeHGLzs9cnb4k/5R6jq2IeNlwW0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA0PPF4D923B935.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:09:04 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 18:09:04 +0000
Message-ID: <3ba00fec-420e-4a58-a9b9-f781140ed461@amd.com>
Date: Tue, 13 Oct 2026 14:09:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
To: "Palacek, William" <William.Palacek@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20261008140045.1283288-1-William.Palacek@amd.com>
 <87e18cc7-2382-4440-96bc-605dc0828ab6@amd.com>
 <3d43d8fb-0cd6-49d3-a64e-dbbc160a7c62@amd.com>
 <CY8PR12MB71224C7E830D21794087E330F9912@CY8PR12MB7122.namprd12.prod.outlook.com>
 <89da0aeb-c78d-450c-9d6d-38c24f5607b6@amd.com>
 <CY8PR12MB712299E5F7D986366941AF18F99E2@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CY8PR12MB712299E5F7D986366941AF18F99E2@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4158bd70-110e-4273-0861-08df29551095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|5023799004|4143699003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: AHREHZPy1fBZpWjHHMGgzWsXtm3ZR1OWtn4ReeOa/KiICzBT0X0XJ3jks34tl/HcYeS75pv5QGifjUZ2WOBNi7Zq7JHSLfnxObHaxvGKNzsHkhW2c4jz6gpBXd5oG5GxP/GZOl1CHAc6KXxshCrZithAxbcuo8s0lSCQDp/RoIngykLguiGBth5umZoS0C87lU8+/VqdRJG0q5Ui4IA98L6A8LWhN+dhf8PIsdBwNjBODO3EWzINpA0uMxP2PVzfQ7+ORhi3WozHmBPPb6IqAEN66wo0FoIJCJfTaZC/xIF21cB5IdMg5Zqxyvi5L19SYDWgb3D4IwEvOiW9B03MiESoscpb+i3p/Y6XjozIanWl0u6F9hEUJnjNTBpvCiGNBgNG3H400sNtVzF6eQsi7RDEx1xdgIUVAlD1g3NpgYpfaDJOh2qWJYxIJNgC7lhnDpzqXrSnlQFdbxmGX2M7JpuoOiGU70TStafasD3bL7d+osueF1111v5QL5mi5ZixDwEAkb0c1+pMvTPBlruaEn1D71JXkgvjhsOIeW3rYzG1aMAUwX4SaA/IqkgcrgOUNLVUWQRALmscOI0iCeUyFsX2+rZE/jVa5/GzOmgMkjKBvGoYwctLjACjt0M0FSxlljhLLxbyX/mckIJsQ5kcC/PrbsiTykyByKsERbwHkQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allENnVHZm5ZUklUSkpxRllQZUN0d2lGZWpiRmZJWmZaMEh5eFRyN0c3bDNk?=
 =?utf-8?B?RDVBY0xNajA5RUF4ZzBoVFNPTWN5NUtES3VTb0xhQzBRNWh6Mkd5WDZwMkgy?=
 =?utf-8?B?RXlJREFJM3JaNzYrSzRKRi9xSWZGalk3L1d0NmsxMDlBYXg3N2ppSHNseUti?=
 =?utf-8?B?RXpWVXhQdzRVblRTNVltSWp6UTdYV0gzYnZsRVM1UDVwN3lSZDhvMFVtS3Fa?=
 =?utf-8?B?QkpmaXl6UHJrdHpiTDVaWGdmNVNZelAvR1pxaDJXdmQ1bnJnejhxcWl5RW1k?=
 =?utf-8?B?a3k0cGZwcUJncDM5Zk44TUhRNCtNeDBhd00wY1VsYW1Rd3p3Q2paN2pvSUVr?=
 =?utf-8?B?S0V6SkJxejlkVE9Hbk9QTlgxK0VSYnpWN3ViZXFWUmxBdm51WWRIR2IrbGNu?=
 =?utf-8?B?aDkxZDBvRUZRSVBoVVJiVHQ1eGUzbHo1L1ZwWXhJazI3SExDT3ZxZlcwRlFh?=
 =?utf-8?B?TU9aVHRkUklhS1ZaWXBqa1owMVBvYWNtSzhnT3d4WUIxb2ZQdkZCbDgxNjly?=
 =?utf-8?B?OHp6S0Ixemo4OUpLb3o0K01zQlg2WEEyQUVBWlYvcEFvSG5VSlJOY2JkVk40?=
 =?utf-8?B?Lzg0aFpBdkRuSnE0b042ODEzckFYQStsOGpPOWJrbjFZQlRuRDZNbTIvdmhx?=
 =?utf-8?B?bTExR2pNZVk4bzg3RHZxV3AzQng0Y1FZM0Y2WjlGTXhFbHNWWnhSVkNwNmRr?=
 =?utf-8?B?OGU2V1ViLzgrcjFpUmdKTyttNyt4SWg4eEMrdHBMRUpFdWFpaUFrbDgwZmVt?=
 =?utf-8?B?Rk51Q3Izb2tlc3lFUmJGU3p6M2xpM0d3eHg5N3daZHdYL3R2Y1pyOVJ0NWpp?=
 =?utf-8?B?dkR6Umx6MjllNmFMTk8rVUVJMS9xMVQ2QkZkVUtHUHQ0NzZtek9pZVBVem1U?=
 =?utf-8?B?VUJ1bU16Z0YzRTUxVW5JTFpVc2NuM21qZmF1cnZsNjNMbU9KLzlDeGNTYUJB?=
 =?utf-8?B?dXcyUXZkNWFCdmNab0toSWF5d0pXcU9XMGJwcjJLendRRFVCc0gvR1Z0WTd4?=
 =?utf-8?B?cXR4dmZnbmxETXBvcHE5VWc1cno0SzU1VHpGTkRNeWxzVkQyT0VLS1hzbmR2?=
 =?utf-8?B?UEo4SnprUERiQXpQeXVsN0JuNmhETGFramFrcEhiaFZrOEJUUktXNUFpS1Ja?=
 =?utf-8?B?dmUrZ1JmdXlQVTVudDgxcWhrUG9JN05abkdxWTRZWWoxMnFuSnZlRTV2aHFZ?=
 =?utf-8?B?YVA0ckw4RXlqWEVFOWZWeWJBcExxaWEzeVVUNGVQYkxESUhBUzlxZDA2Nm5U?=
 =?utf-8?B?ckNPbDZiWjN4RXNHTTlhVHl5SC91bldvMGV3MFlJd0FCSUpsaHBJdXU1Vnd5?=
 =?utf-8?B?S3A2NXl3WndkQkc3ajl2VnhDNjNZcFgvaWVpZG15T1haTEFmM2xRZlRONUpM?=
 =?utf-8?B?SFd6QXhvUFRKVkxabWtJVXBpRGQrOUs3UlprM0h4N25iQ0RzU25QR1FteGtX?=
 =?utf-8?B?RWYxKytPNmE5TmVSQnRTQm1tWlJlcC9TNTJ4Mk56SkQ4ZmFuTWdCVEZEa3RH?=
 =?utf-8?B?NndEK0pDNXZ1c3FWMmRYMkpMSjFLWUFoVDAxTkExdUlFZ2lhWUFORnJkWXgy?=
 =?utf-8?B?eTJFRFZZN0Fna1FvdzNOYUhWTno4eU5vMWhQUTA3RHJ6MDRoY1BBSld6K0ZV?=
 =?utf-8?B?cjJkZEIwL0wrUis5ZktNWHlwdFNZaXNYa01hUDhidklwcENKQ1BtaHY4TzRT?=
 =?utf-8?B?YTFhdHBJQmNudTR3Z2NQdDRyNXhzZFpncHRjbWNEN2tpVWFnTjdmYWRZTDU2?=
 =?utf-8?B?Ynp0c1BCV1doQjRlTmVkTFBiUlVJVXRpanlmK05VTzE5ZHBnN0NPYVVUTU8r?=
 =?utf-8?B?dTF2VFE3T0lHb056bDdNdVY1c1FyQTE2Ty9yMWNTYWVVUzQ3MVNmNkltaVFo?=
 =?utf-8?B?V3dLVHpUM0hVWXV3ekxLOFkxWTFETjVqZG81RHRWZWlYajViaEJhUDFXRGp5?=
 =?utf-8?B?ZWE0cExIZGxlOSs1aTBkYVNpMHEvUWtwVmNsellRL0R2QnYvLy9OZzRIRnVz?=
 =?utf-8?B?UWJvcCtEUFNGSm5FaWFGdjFNYmRrTFRtejR1QVcwQUFJNFVNc0hqSlpPa21o?=
 =?utf-8?B?M2tpdXFreHZVMXFyd2hsZDUvWEUzNHEveWtTVTM3V3NGOExWQlZyVnFLWTV1?=
 =?utf-8?B?bU90dyt1TkdwbXY2OGg2alRSb1VtSnpjallHdDF0MUFaeW45dWVpVlJUVXRm?=
 =?utf-8?B?dkFjcU1tVFVXL0c3eThHNEhQQ0VwNHgvYmpRbWdzdjd6VTRGM1A0ZnhFWEth?=
 =?utf-8?B?NWlMMmdUemVuWTlDSlBVOFg3YzRvNjgxM3N5Q29SclJEYWpJZWd0ZGRqNXNK?=
 =?utf-8?B?MHhIYUlGbk5qSEUxYk45NDVmMjFrdkcwYlFKS29YbFNrL2lQNDhLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4158bd70-110e-4273-0861-08df29551095
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:09:03.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmE3xAQi88KjjBz1Lb6xIRBqP6XvWPlvJLqP1nNDfgBRi992IVl855RM2QJU9xCJ4+5xFzCoLx3f1VPztnhVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
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


On 2026-10-13 09:58, Palacek, William wrote:
> AMD General
>
>   Hi Christian,
>
>   Understood. Moving pre-reset before the lock does not make HWS/MES reliable during reset. I’ll drop this approach.

Sorry, I'm reading things out-of-order. Ignore my Reviewed-by for patch v3.

Regards,
   Felix


>
>   Regards,
>   William
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, October 12, 2026 3:43 AM
> To: Palacek, William <William.Palacek@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset domain lock
>
> Hi William,
>
> yeah Felix pointed it out already.
>
> When we device to reset the ASIC this harsch the GPU is already completely gone, partial recovery by unmapping the KFD queues is not possible any more at that point.
>
> So clear NAK to the whole approach.
>
> Regards,
> Christian.
>
> On 10/10/26 18:27, Palacek, William wrote:
>> AMD General
>>
>> Hi Felix,
>>
>> Thanks for the review. v3 addresses these:
>>
>> - Interrupts during reset: with v3, KFD pre-reset runs before the reset
>>    domain is locked, so the unmap is sent and waited for while the GPU can
>>    still respond.
>>    Filtering interrupts for a half-broken GPU is a separate change; KFD also
>>    needs the fence interrupt for process-close draining, so I'd rather do that
>>    as a follow-up than fold it in here.
>> - amdgpu_amdkfd_pre_reset() now takes the device list; the extra wrapper is gone.
>> - pci_channel_state: you're right, it is only set in
>>    amdgpu_pci_error_detected(). kfd_dqm_can_reach_hw() is dropped, so no new
>>    "is the GPU usable" condition is added.
>> - unmap_queues_cpsch() now returns -EIO when the HWS is known to be hung.
>>    The MES check is removed.
>>
>> Regards,
>> William
>>
>> ----------------------------------------------------------------------
>> ------------------------------------------------------------
>> 1 Commerce Valley Drive, Markham, ON L3T 7X6 LinkedIn  |  Instagram  |
>> X  |  amd.com
>>
>>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, October 8, 2026 11:58 AM
>> To: Palacek, William <William.Palacek@amd.com>;
>> amd-gfx@lists.freedesktop.org; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: Russell, Kent <Kent.Russell@amd.com>; Kasiviswanathan, Harish
>> <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking
>> the reset domain lock
>>
>> [+Christian for comments on reset architecture]
>>
>> On 2026-10-08 11:46, Kuehling, Felix wrote:
>>> On 2026-10-08 10:00, William Palacek wrote:
>>>> A GPU reset issued while processes are using the device can Oops the
>>>> host in munmap() (free_swap_cache) after SDMA write faults from a
>>>> user queue whose process has already exited.
>>>>
>>>> amdgpu_device_gpu_recover() takes reset_domain->sem for write before
>>>> amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
>>>> unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and
>>>> no unmap is sent. stop_cpsch() still clears sched_running, so user
>>>> queues keep running while their memory is freed.
>>> There is a general assumption that the GPU is stuck when we're in a
>>> GPU reset. It seems in your scenario, the GPU is not entirely stuck.
>>> So you can still get interrupts from the GPU. At the same time, you
>>> can't rely on MES or HWS to unmap queues when the GPU is in a
>>> half-broken state. So while your patch may help in this special case,
>>> there could be other cases where you can't reliably stop the GPU from
>>> sending spurious interrupts while a reset is in progress.
>>>
>>> Maybe we need something in the interrupt handler to ignore interrupts
>>> while a GPU reset is in progress.
>> It's also possible that there are still interrupts pending in the IH ring when a reset starts that won't get processed until later. Do we drain or discard pending IRQs before starting a reset?
>>
>> Regards,
>>      Felix
>>
>>
>>>
>>>> Call amdgpu_amdkfd_pre_reset() before the lock, for gpu_recover and
>>>> PCI error handling. Skip the dequeue when the HWS is hung or the PCI
>>>> link is down, so recovery does not wait out the preemption timeout.
>>>>
>>>> Signed-off-by: William Palacek <William.Palacek@amd.com>
>>>> ---
>>>>
>>>> Notes:
>>>>       v2:
>>>>       - Drop the SRC_USER gate and the helper; run for every reset
>>>> source
>>>>       - Cover amdgpu_pci_error_detected() as well as gpu_recover()
>>>>       - Skip the dequeue when the HWS is hung or the PCI link is down
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 16
>>>> ++++++++++++++--
>>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 14
>>>> ++++++++++++++
>>>>    2 files changed, 28 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index e0014611f039..8ae6228dbf31 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5479,6 +5479,16 @@ static void
>>>> amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>>>>        }
>>>>    }
>>>>    +/* Dequeueing needs reset_domain->sem for read, so run before it
>>>> is write-locked */
>>>> +static void amdgpu_device_kfd_pre_reset(struct amdgpu_reset_context
>>>> *reset_context,
>>>> +                    struct list_head *device_list)
>>> Instead of adding a new function with a confusingly similar name,
>>> should we change the signature of amdgpu_amdkfd_pre_reset to accept a
>>> device-list instead?
>>>
>>>
>>>> +{
>>>> +    struct amdgpu_device *tmp_adev;
>>>> +
>>>> +    list_for_each_entry(tmp_adev, device_list, reset_list)
>>>> +        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context); }
>>>> +
>>>>    static void amdgpu_device_recovery_get_reset_lock(struct
>>>> amdgpu_device *adev,
>>>>                              struct list_head *device_list)
>>>>    {
>>>> @@ -5534,8 +5544,6 @@ static void
>>>> amdgpu_device_halt_activities(struct amdgpu_device *adev,
>>>> cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>>>>    -        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>>>> -
>>>>            /*
>>>>             * Mark these ASICs to be reset as untracked first
>>>>             * And add them back after reset completed @@ -5784,6
>>>> +5792,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>        /* Cannot be called after locking reset domain */
>>>>        amdgpu_ras_pre_reset(adev, &device_list);
>>>>    +    /* Cannot be called after locking reset domain either */
>>>> +    amdgpu_device_kfd_pre_reset(reset_context, &device_list);
>>>> +
>>>>        /* We need to lock reset domain only once both for XGMI and
>>>> single device */
>>>>        amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>>    @@ -6232,6 +6243,7 @@ pci_ers_result_t
>>>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>>>            INIT_LIST_HEAD(&device_list);
>>>>              amdgpu_device_recovery_prepare(adev, &device_list,
>>>> hive);
>>>> +        amdgpu_device_kfd_pre_reset(&reset_context, &device_list);
>>>>            amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>>            amdgpu_device_halt_activities(adev, NULL, &reset_context,
>>>> &device_list,
>>>>                              hive, false); diff --git
>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> index 5e57576fba21..988fce11a4fb 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> @@ -81,6 +81,16 @@ static void set_queue_as_reset(struct
>>>> device_queue_manager *dqm, struct queue *q
>>>>                       struct qcm_process_device *qpd, bool verbose);
>>>>    static int reset_queues_mes(struct device_queue_manager *dqm,
>>>> struct queue *q);
>>>>    +/*
>>>> + * A dead HWS or an offline PCI link cannot service a dequeue
>>>> request. Skip it
>>>> + * rather than wait out queue_preemption_timeout_ms per node.
>>>> + */
>>>> +static inline bool kfd_dqm_can_reach_hw(struct device_queue_manager
>>>> *dqm)
>>>> +{
>>>> +    return !dqm->is_hws_hang &&
>>>> +           dqm->dev->adev->pci_channel_state ==
>>>> +pci_channel_io_normal;
>>> Is pci_channel_state always valid? I notice that
>>> pci_channel_io_normal is 1. pci_channel_state is only set in
>>> amdgpu_pci_error_detected. If that never gets called,
>>> pci_channel_state is probably 0-initialized and this condition will never be true.
>>>
>>> I'm a bit cautious about spreading different versions of "is the GPU
>>> usable" throughout the code. There are lots of things you could look
>>> at. I've seen different conditions related to GPU hot-unplug in
>>> another patch I'm reviewing. These kinds of conditions should be
>>> managed carefully, otherwise we end up with subtly different or
>>> broken conditions all over the place and it will be a mess to fix
>>> later. Or the the code becomes unmaintainable if the conditions need
>>> to change, because now you have to change it in 15 different places.
>>>
>>>
>>>> +}
>>>> +
>>>>    static inline
>>>>    enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type
>>>> type)
>>>>    {
>>>> @@ -314,6 +324,8 @@ static int
>>>> remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>>>          if (!dqm->sched_running || dqm->sched_halt)
>>>>            return 0;
>>>> +    if (!kfd_dqm_can_reach_hw(dqm))
>>>> +        return 0;
>>> Why does this return 0 and not -EIO? Isn't this logically the same as
>>> the next condition? We don't talk to MES because the GPU is hanging
>>> and a reset in progress.
>>>
>>>
>>>>        if (!down_read_trylock(&adev->reset_domain->sem))
>>>>            return -EIO;
>>>>    @@ -2832,6 +2844,8 @@ static int unmap_queues_cpsch(struct
>>>> device_queue_manager *dqm,
>>>>          if (!dqm->sched_running)
>>>>            return 0;
>>>> +    if (!kfd_dqm_can_reach_hw(dqm))
>>>> +        return 0;
>>> Same question as above.
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>        if (!dqm->active_runlist)
>>>>            return 0;
>>>>        if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
