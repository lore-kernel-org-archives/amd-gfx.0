Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1375AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 07:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90320113267;
	Wed, 17 Apr 2024 07:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM5Mk5hz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA1A113266
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 07:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meo/+SCYf1QO7d8bkwzXM1RTDxoB7KIWXbJVU5kxcWLrH3DP4zedo3FPbcOFrZn4JPbcSASA5vNjGoQJTUgruT6FR7hFaQ3VGL4X9qEpR+uurEnSQ8yuxtYs90rno35wbzHq7yDkonFmQ2tf4qTIy8YzwmZiRh4s3iogtW8MRnNqtssjaN5HDVCFRhF2MiC22rvISOAha4Kl/iSRNqxcOrKujh1Ely1GDJE0OzqlwvRHCgVqpD22/5qmLhL1diZIDzsF1Z/KPXEoGrsQAj+XxmSagFn2H+3yvXK4IoE4en8elAUPOrqVy041/ijHsrgJxSW5jbtgY1kdk+oRSM7dZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UwW1aZQCfrmtMYvmvjpUOPXogEU6xBmUafLS4hP0QA=;
 b=DFgJ8jHY4SZccYfjCLIS9F4j2TdK9RoGER27l/u9eZhi6IFpF5fEPzJOL2oL0qNm9v/SXjJzO3A88vvUiWZIC4wj8yN37LH8rWlaz2YThdXon6NxnGExrFc20H8n2RPjgwaDLEVUuHKj46CT4G/qRdirOsgAeNAzhKYteMFjca2shubQ/AM2Tk0YdnwtvPh7GwazA4ThkwttUItiUFXfJN0OFe/FiEOGsaZ8kbXa/hrDfbVMVxXy4ZCT7EUUxctjgwgHo/9JFXokoh9R47b25XSY311yGbyJEP+Vc0EtrO7tLAEGCoLx0Zhapw0/8MF5sY+9eVy1G4qy6wtwLKzTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UwW1aZQCfrmtMYvmvjpUOPXogEU6xBmUafLS4hP0QA=;
 b=YM5Mk5hzwDzNtyWedpu7FTFAJieDeJuE8NWSgVNFUCxD57HNeZu9lRDRdPFZZc0dLhVn/dEw9Zn6z5SEpFg4UcshxvLq9vhTQfr6/7Jp/OtyUu5+I5/BTWXLGU5AtEewwthEi0sXiP/DXLRhH3+l5P9E7nGZjr+/lcHWNW7VXEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 07:49:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:49:47 +0000
Message-ID: <399498b0-6674-4a81-9382-f6f3946298be@amd.com>
Date: Wed, 17 Apr 2024 13:19:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset
 during driver reload
To: "Khatri, Sunil" <sukhatri@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
 <26c0e7b8-e0a6-495f-877d-2fe522b2249b@amd.com>
 <be82827f-93e8-4053-a301-7e6bc8fed5c5@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <be82827f-93e8-4053-a301-7e6bc8fed5c5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4238dd8d-3341-48b5-75a2-08dc5eb2f458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNEJ9t/zfvlyHFrwjXw9DPxleOg+h4E1ZVCMGE5pks1o3F4anItHbR+7ZL6U9CqGWtwOYrISQLWDr0NJWBeuRgMJHbUkUnElz8vpJtoEaBrEq8fzDefqmvZn1tLNceNkzBZAjI2paPaZSXulh96Ca2jJnUGBY/qymlBupC7l/xcgMjjIKM0+IB21ZpZQFK17YLgHxt0R6sGKE+fLwbrsa6oxht2HECvwqTxY9bK7u09K+Z/3Zg2ixQ3/IrlmaLsFrjk+5S+LKB3rXs07HaeeLBpbMsjiHvWEl5VfopZa5RovAnpKDGkJ1xAPJFCYiwQR44ixutEqLlP+RW4C8wrfI2Vg8bM3oUavo+AdORomivk1x1wIYO9eWKrlQHqnRhhT+rTLxNfe6eRDyGz4rY+BI5Qsn9cHZ2uuizNkR09uVgjBZdE8AEyYZtB3hAIeE+OCOnKalk0hCE2WkmYAzEl75YQs3brOfRrLRQ5ZhBJRTNtWN4mKqEOsxH0qXFGdNTw9eQg8vmmIWeRRvk7wtEClG/cSDBsNji/z+aZppc3W8gl7wChpFSh/8jmKXvRCyEEaffsyMRAQlkP5A8zY18w72eb4Dqs4xLNblm6/MBnaob5dHrLFu57lDIdrx4eL4jNzi4w0/lf0UWUwUEG/fZrgxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRYandoaExoSXZWYUNWNmppSDkwQmlGT3V0VWNUWlhyazZxQUxtSXdvZDQ3?=
 =?utf-8?B?TjNXZDdMWFR5UGtnMHpzelUwLzVUWjFLT0FwQjlyYlNRdzBqRXppdjBveGlm?=
 =?utf-8?B?Z1gzbDNwVldTSFhZbzBzQ3FaQkJacWhnVnF4ZkRUU3JTbkpIM1gvMUxGb29Z?=
 =?utf-8?B?b3NOM09COTNleU11VU0ycXRwc1pzeTZodGVzMWU5T1MwcUpjaTAzSVp4Qks1?=
 =?utf-8?B?cjdoWnVQM0RXVlhOL0R1ZkR5bUJuMk4xM1BWb1daOGNDUWNoYURja3NKRDM5?=
 =?utf-8?B?SnMrTDArWWFvYkRwUkhyYzhoN21tSUYrQXhEWVYyenJmNVJTbnltZXJGZUxQ?=
 =?utf-8?B?ZFRNWmlRbWJYbFZyM0NpL2l3MWVGN0ZZaXFuV0hUb3R5VUlqMkNVY2w1bTVw?=
 =?utf-8?B?bDVYOEJYNDBXaVhYTkFhOW4vQ3lwMDh3bVJqNGM1bktEaGRsdGIvSC9ydHlW?=
 =?utf-8?B?NXBESVkrUUthQ2RUMWxWZDFudk85bkJyWll0Y0ZwVWYwczJjUWJjdjNvZzlv?=
 =?utf-8?B?RzR3MVpNTUJ1U25rUlJPcUdNSmt2ZjlWN2NTakRxZmtJQlJUb2xHdkNmajIw?=
 =?utf-8?B?U0FFNGNCSGd5Nlo4UlFKZDc4RTF4b21ZNmhrY05CdWtYaWwzZUR0RUE5cGpU?=
 =?utf-8?B?SEVUbXhGOG9idk5aSDZKUjhTYmwwZ01HYk5NRzd3Y2F6VkJKY3ZSNjRrditE?=
 =?utf-8?B?ZWVaejhqbjVkMDFHSDlkdnJ6RXRaU3ZKL2dNVWNTc1daUGF5YzZvRWJXdE4x?=
 =?utf-8?B?UFp3STZnV0FvM2tlMmpncDZRZksrQW84MFJlOHNqbnc1N3Z5cVl2bHM0cUQ2?=
 =?utf-8?B?a0NBT0Yyb0swSGlCU0E2VEJLYitmelJpOVlWdVZlTzd2bzQrRmlZSmRyNktC?=
 =?utf-8?B?L3g1S05oSVVhZUZqRkJuMnFBdGFuU3VWOWJyd0NFUGpsdkdZTkp0aitDbTBY?=
 =?utf-8?B?eEV5N25DMUVqNG1ydEVlQTByNityOWl4MEhhRTBmTytGTDFpUERiK2I0Ym03?=
 =?utf-8?B?SzUyZ29CSGVtQ3pSMkFGTmJKUytLNmRKVnZZRE5LR2tvM3dHWC9xbDRYZ0xV?=
 =?utf-8?B?aUM0OUk4czJ4SkRsTUVHRHVReGNUbjZ4YmVyY2llaFJ3MEphdXJHZ0x1b0h3?=
 =?utf-8?B?NENhVTBXMXA0RU1KcHdDaDFEeHlOWTdnZXJ6TDVFcjl6ei9PZE5PL1RUUWZx?=
 =?utf-8?B?ZkgxcksxRjRLOHFMSys5K0I2ZVJCemI1cFVHZ3I2U25tYnE1cHRGVWhMM3E2?=
 =?utf-8?B?OUQrRHo4bk1VeUplbnVHaTVjNGdVUFlMVE41S1BxOHFSYW1JRSsvVC9BTUd3?=
 =?utf-8?B?TG5TaDB6cWFBbzVJNy9aLy9nSEF5VGJtbngxcXJiVVVRSFhMK2dLZTczbDNB?=
 =?utf-8?B?TnpTZFdONERIUk15K2lVTW51WEFUdFBiMmtGRHpqUm1uZlpOUFF4Qy9MME5Z?=
 =?utf-8?B?SllwSjA3emlIck1HSW9mWmJKKzZRV3VLOXNHNk5ERDlaZmVhTE9IL2V1eDFs?=
 =?utf-8?B?aFRoQy9TUm5DUHIvY2RzaDFDTDV3a2tpRml0ZkFCZ0JoOWM3cFRrTmgyeXhK?=
 =?utf-8?B?L1p3YWhNblZPQy9kYVBxZ25KSWt5TnZRMXZIT2FQbi8rVVpZNnp3WDVWVUFY?=
 =?utf-8?B?endTTElleGFFblNsajVWQ3BmaDF0QTVHSnQzUUVxWFZPNEtjQ1ZRUmpyTUd3?=
 =?utf-8?B?N3pmSnVjWUZSTkVHbnNKQTJTYnVYZEg2d3krNkpVcklnYXdYZWRGajdRVmR5?=
 =?utf-8?B?T0kvL2pQRFUyNnlUeWVyc1NZcFAzWWNjOFpscU5nTmZWMkIwZUhMek1JRXlY?=
 =?utf-8?B?S0tmMUhCMHlBK1pMb25oYXdDdTlQaGZBOXo4aFMwMFEvY0VOQlVmTmJOSmZo?=
 =?utf-8?B?QkRlWm5zTzcrOHMxMElNdDRyemx1bWlOeFZwYThZYmpveHRCenpReTczVFFn?=
 =?utf-8?B?VXkyVTlkTDVwRmN3dkdLOUVxNE9WYTJFamFsVDluYmkxV3FwSEN1bHBUOFNT?=
 =?utf-8?B?UGh3SnNYaEpLeVNnMjREaXZwa042RnBGZzlNL09wQlovSmhrd1ExZXdUUTJu?=
 =?utf-8?B?eTVGWnlHbFVZbmpUd1lYaG5jeWhwQlpkZUs5SjRBR2I3QTZBUTVGTXBTdndw?=
 =?utf-8?Q?hXn9PGruzjPyQR2XJ+wawTenj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4238dd8d-3341-48b5-75a2-08dc5eb2f458
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:49:47.7574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjLdtoS9gPZov0kxE+ntwNJcpz15PR064p4/PChlqUTKNGrni3TF2g1iGLelRXFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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



On 4/17/2024 1:14 PM, Khatri, Sunil wrote:
> 
> On 4/17/2024 1:06 PM, Khatri, Sunil wrote:
>> devcoredump is used to debug gpu hangs/resets. So in normal process
>> when there is a hang due to ring timeout or page fault we are doing a
>> hard reset as soft reset fail in those cases. How are we making sure
>> that the devcoredump is triggered in those cases and captured?
>>
>> Regards
>> Sunil Khatri
>>
>> On 4/17/2024 9:43 AM, Ahmad Rehman wrote:
>>> In passthrough environment, the driver triggers the mode-1 reset on
>>> reload. The reset causes the core dump collection which is delayed task
>>> and prevents driver from unloading until it is completed. Since we do
>>> not need to collect data on "reset on reload" case, we can skip core
>>> dump collection.
>>>
>>> v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.
>>>
>>> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1b2e177bc2d6..c718982cffa8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head
>>> *device_list_handle,
>>>       /* Try reset handler method first */
>>>       tmp_adev = list_first_entry(device_list_handle, struct
>>> amdgpu_device,
>>>                       reset_list);
>>> -    amdgpu_reset_reg_dumps(tmp_adev);
>>> +
>>> +    if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
>>> +        amdgpu_reset_reg_dumps(tmp_adev);
>>>         reset_context->reset_device_list = device_list_handle;
>>>       r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>> @@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head
>>> *device_list_handle,
>>>                     vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>>   -                amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>>> +                if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>> &reset_context->flags))
>>> +                    amdgpu_coredump(tmp_adev, vram_lost,
>>> reset_context);
>>>                     if (vram_lost) {
>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 6ea893ad9a36..c512f70b8272 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2481,6 +2481,7 @@ static void
>>> amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>>>         /* Use a common context, just need to make sure full reset is
>>> done */
>>>       set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>> +    set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> If this is used for guests only can we better have a flag like
> amdgpu_sriov_vf  for setting the skip coredump flag ??
> 

A reset is not always triggered just because of hang. There are other
cases like we want to do a reset after a suspend/resume cycle so that
the device starts from a clean state. Those are intentionally triggered
by driver. Also, there are case like RAS errors where we reset and that
also really doesn't need a core dump. In all such cases, this flag is
required, and this is one such case (this patch only addresses passthrough).

Thanks,
Lijo

> Regards
> Sunil khatri
> 
>>>       r = amdgpu_do_asic_reset(&device_list, &reset_context);
>>>         if (r) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> index 66125d43cf21..b11d190ece53 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>>>         AMDGPU_NEED_FULL_RESET = 0,
>>>       AMDGPU_SKIP_HW_RESET = 1,
>>> +    AMDGPU_SKIP_COREDUMP = 2,
>>>   };
>>>     struct amdgpu_reset_context {
