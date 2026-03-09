Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B4FCA198
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 22:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15AA010E5D0;
	Mon,  9 Mar 2026 22:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvatWHzu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA9410E5D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 22:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivR4D3LArp7t5J2GtWvvxCADLRUdcym2FvBJUGkYAgzVItoBkz/KS8jGXXK3lLX87vwAtL9TY7jhjiGO/K+5KKKuOeM7mHyXm4gBFCOUUFK+uEiXtJ0hN2A9kTy0n2juxWt+tAB1Cj8J548l9qM7ABLo50EolccR9/ahsEdM4gymKsStnntzovzeqaqBNdqG7VhXr4pYjhKARDibz7qUiDJeYRjRYa98SC7i+wHMMMG+d6hvLuoFNgt6VLQ07IAb5agMG3tNZr1hVQX4hb6N7wZl3auz9Zxm8QLaeE00UGQhx4dx9Z5Dk0CDHGY7+lwqWqXrHhhkqj2+TCF26nHqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrBHgdKPKVM23Tusm7p59VPvZOkW7RxeRKlarEIcgWs=;
 b=GH8vVVIfj/iWmj5+P4QBDKjU9OHGCPs25li5QJ3iL60oZdCvjjVxkDf5uDsYjfDAyTrjgJT/KTqTEsBZ7mV0V/xfyIlELQh9p35AzT8xg2u+Q3YPoFGYsGPvKECSjHmjhpzIhJOoCG77oj8CTIKXVwaYEzPtB6IS5HgG8iD6EbCkF/Iexm+1/xDNRNGsiT32AYHMYZ7tiGsYhpCSaraoph6d1sq8r/OV9qdqMDMu69cooFduyAbYXe0dQJNNehuBC4bjmFW1yJ1alSPCdryKjkYohgVWzNTSOOVBWjWqdPepdhfkfu9drXBfpiW8ISkY5KIhBDIqYdcOg12s7DBs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrBHgdKPKVM23Tusm7p59VPvZOkW7RxeRKlarEIcgWs=;
 b=MvatWHzuEk1M+QZgxFGTeg6L8yiVjPxfSMoXyen4+ZQwUBvkEygeV2w3W6DYShh9iv62AuMKYniPrCdkqqIRa0vNItkkn22kafjHSUNwRIOrsVdR8LAQv8dekrU432IpK6VzKAwoCzyh7Hsaig8uTEcv8HGIRjL/MChrOF5SVQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 22:08:13 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 22:08:12 +0000
Message-ID: <0ad7b2ba-e32a-44c4-9f98-1331c4c5fd2f@amd.com>
Date: Mon, 9 Mar 2026 18:08:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::11) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: efdf4837-5a6d-490f-36d4-08de7e285b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 2CfCIbsFoIWmvuN7Ii9+S3JZITSLUgAOZ3n1DKP/EzdhBD28p+WaqqvltPDOnHahOMsQh3Q4n10stCJmWejfvoD3e0rKfbnYCc5VRBRUN1UY6ZC1djjR1AmOkvtUWNLtIh5blP3rtU8bRBCjG6XfqN2e58Nd0UMgw1p9q0syR3ZzhSbY5MH27wQpSVm5i3sDeIPz7epfsL3jKk+ABV+QsV9PZe8AZ83olFnNIKUU0fUnimspQUJXSmtOMmj8WTtfo78xUzWpS3WCl2xjKL2EIw+Jo7uUFGiosU0+Fiql7cAT+xSEsxPQ0eho4cVonwEA3vaK2sqXG+kJ9xYT9G4klGBlkPW9dylgmv0KHHbMcB127x/kWy3Q4QINf4YXKSWwAFjwRYoZYe70DoRL2rfCzWjQDYt1tZdgzXe/hJK9+qDVZGzNZGtuB06O9FmIUfMVWbEBG4fDQCYsKFcGBVDPiVG1cZ3/CSIZM2Rj5G30uH13VhKVyStAwF1/9FB9zLBEe4ivUKTaoO/xVGK+wu/DqhLgmdHUauV7CQosydkW0YqkI2vq908nT2GUf678Hhjc6Fduspz92/Rk5RJlg9g8slldP3V4EjHt504Alb4u9Wr0psoFrSew3DZDh7l754qbXX98xfQWxzTosKqqHC1tt7qN+bmEIzTjmfBrq+W6hq0HhWFYGGDnHxStIalREl3Nxte6UZsNZEXYjECjO4i7RkEI+p7pDqtpUYlS36NK5iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0pRckpFazYzQkJiUlRSVk05WTdtWGxvZnlDVExSVTNqTVJrQlNCeHlDQld5?=
 =?utf-8?B?V2JHQUxoT1YvUm9ES1pRUGhSYk5qazlwYXpxeXdudGhpbGdyOWhRbkVUbDJH?=
 =?utf-8?B?TkhwRUhoZ0xiZTV2WjdvSVRaVzB2SmpUeklWNGJWaWxMaHZhNlI3UWZHYnY5?=
 =?utf-8?B?V2xPbkxTV2dSUVFmeEhiWHNmSWJsWHhSNUdxRHVOeU41eGl3bm5ZUTJZUGNS?=
 =?utf-8?B?b0IreDFkSlNWclA3SnpBRDBpL3Y2em4wdUY5TGF5dlB6VWVYUmRVeFYvRm5Z?=
 =?utf-8?B?ZnVPSHJIZ0NnWkg4WXRWMER5amorUTIrV01PS25YVDBwWVhJN2c5OUZQYXVu?=
 =?utf-8?B?L0NHRFlJa3ZCWlhHZE5jWmRvUnJUWVF3MkxBZGhVYzlYWXNkR3d0VXlaQWgz?=
 =?utf-8?B?eGErMFIrU3lpUjllRnUraXQ0V2R5RmNsbWJEQ1M4VEl5NXJIVFVSaStUaHU1?=
 =?utf-8?B?bTNLMGpDbnBuTmxIcDQ0YTJLNXpSVlljc0RuL2hHT2xEUmZBRVVoVVBveXFG?=
 =?utf-8?B?cTA4QVZ2Z3Nxa2g0dzZjTFV3a1preXdsSmdtVlFJN1V0dUxnbktkZk10TkZl?=
 =?utf-8?B?S3VMUGJnRXVSMm91cUJmREc5WXoyNTJ6T0F6bXBjelBhSXR1V0c1UHI2QW44?=
 =?utf-8?B?MU1JYzlxRy9JOXNiSzlUeUVUUndEZXVMUzN0Y0ZkVmVTZ3BjM0ZiWkFIL1li?=
 =?utf-8?B?UXA3TmNqcU9YbURseW1wZ3dUd3J2UTdmcUtuaWdJNEFvM0p5eU8yckVJYXdC?=
 =?utf-8?B?dEhQOUthVlAzM0NNeGxkVDhKODR2NkZ5ZGdORUpobUxGQXhNbUJVUUlIc05N?=
 =?utf-8?B?MTB3ZEVNVU5DaG5GYm5VR2ZjV3ZmeU54QXBYbXV1N2hFL1JKM2s0V2FWM04r?=
 =?utf-8?B?Y1I3WE5xSEI1QkM4MktYT29PK29obU5vZUJpdXYwWHRnQ1l1c05WZjRrMVZX?=
 =?utf-8?B?WHhzSld0dERKcjJjU3JFRzF0VXd0R0ZNVmhPQnhWM0xjR0psZ09WaEZlaVVD?=
 =?utf-8?B?YmxsWmxOOTZwQ0JZSWxkZlBPYmNUZ1ZQTnZCRXp6cmZML2ppcGprUkFSeUs3?=
 =?utf-8?B?bGVwMms3bDFPTVJIbWRUcWs5SWprUHE1a3NqQ0dUYlNCWFN1QkpiV0xLL2ND?=
 =?utf-8?B?QmEzSE9JWTlZeDZ2VVhEMkdmRy9XZXkzVXlSWGg4U2ppSHR6RHd5YWtFQm1q?=
 =?utf-8?B?MW90R29YMGQyaU44YVFMdTkyMHYzOFFtVlNpNFExMDZtczNKQkxmR1VSSXF3?=
 =?utf-8?B?Nnc4eVlvSVBDOEdNTnVBT0d2K3NicFNEbFBpK1pmM0NDNEE3b0M5Q0NUYits?=
 =?utf-8?B?YnlUd2RCbmxoUWJMdUo1blBpZjVKSDNSOVBwQjhyaSt5RzEzOGw2TlpQekVa?=
 =?utf-8?B?dGRRTXhDT1hPNUIwcmNadmtuVUo3em1LRWUrN2dNWU9YWkRLNVhmYUVJaG0w?=
 =?utf-8?B?UUR1Rkg3OGFQaUg4bDNiNU1aVTd6YWJxbXBldHJteWxIaE9QMGdXc0xxSDB3?=
 =?utf-8?B?NFpqd1I0ejgyZHplcWlPclhOL2pwbFl3L3hHRkZVZ2lZMkJ3eS9kN3JPUitT?=
 =?utf-8?B?a3dkSWU4MFNQak1TeThIbTVCYTR1ZTVqVkVTdHFqK1RtV0xmNXQ3RGEwSXJJ?=
 =?utf-8?B?YzZhaGhjSTJKWHc0VlVCS3FPbVFWbUtkbUhqOU5sbmhYTEVBTU00cjJwUkZX?=
 =?utf-8?B?UmRIYTlINEY4dy9yeXRKQlRCUHVZTEMyWWhINVpIWUhUVkx4d2ZsNXpCTzY4?=
 =?utf-8?B?emppdktwVW1wdW10bU9MSm8vSmliNTVrN1pXank2S3EvNndkTFE1S1NxOU5x?=
 =?utf-8?B?NGp5enNrYmo3QUxPb0FsWUlEVWl5WEp4dFp1eUZNWUN3clZrbWVGdDRxLzZy?=
 =?utf-8?B?Zyt6RVBtQklJRFdZZ3dwcUZ3eG1TdDlBVk1Mamc1Mk1hRlJDNVlYVVc3Q1g4?=
 =?utf-8?B?RmVlei9tRklDMldaQkMzaCtHMGpLWTdpWWNqWDg0NTBDelpaVktxbHN2Y2xa?=
 =?utf-8?B?QWtBMDRyNmltN0lPTGdEd2tST0NJVTd5akRZNTNPVzg3V3FkRXAxakFPSCtj?=
 =?utf-8?B?RXF1d3dYZHE3V0xTS0VKd1YzNzA5aGJsYVN3VWVHMHJaTGdpVDh4RFIxUW1D?=
 =?utf-8?B?QzJyYlBxd09yLzZxdGlFVDVmYkpva0RCQitGNEY4aXJsZkZwUzVDWXZwMmJ5?=
 =?utf-8?B?RGxIelhBWnZIdGtpbnpwUFVwUk03di91Zk1uM3MySlMxRmNxbEJ5MERVeUd4?=
 =?utf-8?B?SUU3cCtQYmJDbDI1UUY0TjZvcVEzSWJ6eCt1Q2ZwSi9BeStsb3dlOVR4d0NS?=
 =?utf-8?B?VGNZTUpPOXU5N0xHaTdMSlpmMzRseEZycjQ3ZFVrd0IvWU5EYlJtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdf4837-5a6d-490f-36d4-08de7e285b2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 22:08:12.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZFG38vWQxdO29SOT/mNx5wznZGd8I16GdX9mK9lWqr8ftyO4gMybWyuqYqgjkSjgYfyg3cky7GylK52fI9nGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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



On 3/9/2026 5:58 PM, Mario Limonciello wrote:
> 
> 
> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>> Add NULL pointer checks for dev->type before accessing
>> dev->type->name in ISP genpd add/remove functions to
>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>> ISP driver dependencies are loaded in correct order.
>>
>> The regression was introduced in kernel v7.0 where MFD ISP
>> device enumeration doesn't complete by the time it is added
>> to gendp. The timing of ISP device enumeration has changed
>> because of the changes in registering the device sources in
>> the device hierarchy.
> 
> It's a little bit pedantic; but I /think/ there are two different 
> problems here with two different root causes that both happened in 7.0-rc.
> 
> As a consequence I think you should have this split out as two separate 
> patches in a series linked to a Fixes tag with the reason for each of them.
> 
sure, will split into 2 patches in the next version.


>>
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_drv.c
>> index 95d26f086d545..920595f0d22ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>   MODULE_LICENSE("GPL and additional rights");
>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl- 
>> amdisp");
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index b3590b33cab9e..485ecdec96184 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>           goto exit;
>>       }
>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>           goto exit;
>>       }
> 
> 

