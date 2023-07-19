Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6653EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 06:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E59210E194;
	Wed, 19 Jul 2023 06:35:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A34910E194
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 06:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXsok91UJdcGMRzFoKM/gX8MXt8vhZTevlTFaQ8Mb1OBM/8M7ktfHoPkt7fdDoBaO+XG1FIOUQcCBTJjdiyWlXiVrXt5Xr80Z63WJHVf4oHA7JZgRMExMqjXmF6I7tNGJ7gWWlHHv5elEy1RbxJ6y4yqTsDjcMlUQFOwLtHPu2QO0y0Q1vu+wBh+Kk745GirFSd4jh8ytdDKL4ko89OtHCWQXrJgmcsRP8AcHlZANCZLXtvIZQTo8THYeOvyMcul5eQx5yw+jhio+Di69UhmV8Ryoin5CVAszDnKFZ5BMxcHTYOH1KR43Lw32dalHmyHmPQxPCfoZd0UPs9rBvrupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9Zd2LEdd5pfVF2Q5KVxIvkCjHd3zu0kB0cjyQvMGUw=;
 b=oS6ap/+H9CW0PjgJuNmv4eXuKIrmNymG4+SP7+Ewc+ocbptZo6kPfmqNOyKy8XTXPPHptOLjwp3eNzW3YjoVrgLfwSzxqKINVpg1Up2n1biQ+SwuxJ0vQ4NvcFfltS1jEtf5916OIVpZ0K4sG8Bi1cgeOJNikbdDrZSmQgZnfKRJ1MK2D9c8SEk5K5bIkwM3udjguz3+5cHWISXozxmVMGCqTdyozQRH/pUefDhAxjWF4OApBbuPS9Gm+Eh3lPVVPotQCPRGT6n+8ApxxMFR91kvMSZxzw1qh38rTFAvMyiNCEohcppYe87YLo7fIkayXv5dKAtji4VpOfwfd1nu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9Zd2LEdd5pfVF2Q5KVxIvkCjHd3zu0kB0cjyQvMGUw=;
 b=k+HsgsN41jtBznferYdxM5Qd7Ua4xw/XBiFXB6EDJrx9cobRZQver7+Ut3k8ao7wVWmBugAf5vWU7WOsC4JLfC3r3NHlJHGtzWvrL+ThpzDQnMkVWiDpagKiSQrGDI03yrtRazScEtxUCu3MPDPKrsGOcZ0o2af2x0jq9NRxdds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 06:35:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:35:11 +0000
Message-ID: <c25609f3-f6e2-6610-2509-b704519ce736@amd.com>
Date: Wed, 19 Jul 2023 12:05:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230713051459.74044-1-mario.limonciello@amd.com>
 <MN0PR12MB61013749AE68692816B82F19E238A@MN0PR12MB6101.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <MN0PR12MB61013749AE68692816B82F19E238A@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: d35239f9-8ab5-49b3-8e5c-08db88224d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9Cxp9Q2MNUXKuogK+p5HL8f9LxG1d92S4UmotGo8CQ3f2rqjtfL9M73c/eTIMK5wYuScW4v7KtETv8Kq9iiTeDqAt+7hCuKm2KEcmdU3j5G9gN9s3F0IvySiKahR6ulSwFjKGbiGYAD0Vej81eoGEFU9wuqjKFyoguRTRwLf2Tw6qShkwife9SWtQUs4iU1DMWeOkc7ZCwB1rVVREFta7QrX66KRAniNHgsVsusb/p0+H7lHIxPRkyjQLZo1xO2jyF8nmOznKAMObg5PMKcATUxfwII6zGo99/e1Yo/5/T/GJMqtl2sIuiywmCnczI8xVczEe8Viy2iTd3wAHvaGULvmbu+FaHGj8ScAJo+zFW001T/d/6xbCy5Q/9JfVFMk6PjpahYvbcN0XUiSKZU0BNlNBT7ugAPPbx6fCPQRUvuOgiZMzGOrDMNDLxZep9xVoaMwbKW/dqPVE9eDUx0ANGxYPRLTGJNuFwf7fkuZVoXoWCX+1OraKlEa2fDtalNCnvEtJYv8RUWdP7N1NadwEStUHbMdBvnonbyl1C+qUv3jKFVGaAnsoQRfdqAgIFtpHi5cXJbZ7YL8qJXLeBM/QNZePWMS3xAJcHrvWZTKZ1KHbcojbUe+wubqyiiGnRrbK2N2KdcNJsKGwAGVZ6d4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(2906002)(86362001)(6512007)(83380400001)(186003)(26005)(2616005)(38100700002)(6506007)(53546011)(31696002)(5660300002)(8676002)(8936002)(66556008)(36756003)(6486002)(110136005)(478600001)(66476007)(6666004)(41300700001)(316002)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhzMDdRaFBnSG1RLzhBd0NnaTFNSXJHSTVMNWdpMC9BTXFnV3oybEg2YWQ0?=
 =?utf-8?B?MGVsUGhYTEZuMkE1Q0l3Z25HY1lOcmg1NTJCMk5KSnlTRmNXNzFUQXRzSytB?=
 =?utf-8?B?ZzQvMVJ4R0VTeDJUZUgvTVp0VThYWGVsUDlybEMzcVVJaVRrMkw1ejZ1RWJs?=
 =?utf-8?B?ejJ4b1lIbkxrUXg0TFB0ZGFCbDIyeE9sV2RMdnorYUFWWVBVYWREeEZkU1N6?=
 =?utf-8?B?a0pYMjBJUVZDNERGalVESEFYbVdLZlNrWW85RmJtNmJHV1YyeEI0ZmlKMlk1?=
 =?utf-8?B?ekVKZ2dielVKdFI0SDBjS0tkNkM4N29ZUE9OeHFiQ3BMdkZNWitCMFhaTWYv?=
 =?utf-8?B?aEs4NWRXSEpjZEpKZDBwT0cvNVJSR3pEQVlTSGtYZ2k5TjFkcjcvUDRIVlda?=
 =?utf-8?B?bzd4R0tRZ2VFdGg1azNqdU5lTWRNbVUvMEJJSjFzS0djeU9WckliUUw4WFU0?=
 =?utf-8?B?R0MrZGcydDBpdXN0TWxaUWdySlBFYUZLVGNTUzJLZVRKd0F3bDVLN0xCU0VE?=
 =?utf-8?B?QWo3cmNKV1dzRkEyejg0TTcrUS9YREpIRSt2OFA0RHVRVERtanN1NHcwRmNP?=
 =?utf-8?B?VEZKUGFhUXBsRERuc2ZzVWJId2psWnNNRmc4Zk5YTjV6eHRYd0NLNVpUVjY0?=
 =?utf-8?B?VHRpakpKb0VJT3hEcWFNWFhMYU5YN1pJWHNaMGV4UWh6V1dYWVBxT0x6WFhR?=
 =?utf-8?B?NGIwZWY5eCtOSmUzUDRTdTF0VFIrOTlMTWpPVDMxc1pxR1FtZDZXZWE1RzNR?=
 =?utf-8?B?Z1J6NFprN3BndEI3cStNN2FBSGhvSXNkYVFaZGJKV0NBV1pOY1M1ZG56dXZv?=
 =?utf-8?B?UmJ6Z212RGs3L3NuZU5JamlJQmlGTG0xenFKSEhaT09ScGtJaDV5T3JzVUZz?=
 =?utf-8?B?bnlxOWNNUjJJdEpTVTgwZHBqS3JYbGc4NTdIeEZJaHpXRjFDc0d3L3V4S3ht?=
 =?utf-8?B?eXJIMEs0RkxveGkveVM4Zlg4aEovRm5WeFlkcHlac3BvbWd4T2oyZWdZc2pm?=
 =?utf-8?B?R3QydHh5WTMyKzVscThJNWducWhLMTdTREUwVTlGYzdsNXRLTnpiTDJ4eVlQ?=
 =?utf-8?B?clFGZkJBaFM3YTNLazVCNGJZN2xZckdQSFFGZWovZm44dlgrUFZtRnRWZUw3?=
 =?utf-8?B?ZHNxOWZVaUlzL09veDRKVWNJTFkzZGdwWXhRK1krK1pZdDg3QnJRcmEwOGh6?=
 =?utf-8?B?MHRHV2FESFZQM2h5b0lIZ0pmWk1qQWI5a2NpMWxVN082TnF3ajd2b25yWitj?=
 =?utf-8?B?MFhBbUlhVm5yaEFrbzRPdkFhUTJoZ1pvbFJQU0QvaElnMUtIdWNod3lVZk55?=
 =?utf-8?B?UjVXRnREaXZJNWFULzd6SGJiVXVVMHIzR3J0aVAvV1JNeXpabW9IcEZHRWg1?=
 =?utf-8?B?eG1mYlNkM25uUEgwNGltMWkvMUdvYjF4b1JmSVo3NlJvQWNlOUdUZUg3N1dP?=
 =?utf-8?B?VDN3WEFNdlBSWU5ldjZXTlRTb3Q4dEUwcEFZdjVtODJsbEFjNUJTenJQdDhp?=
 =?utf-8?B?c0NleEtoZkQvdkcwNjhpNkQvM0psLzZhRGVYTTJaN25JQ2xGdU5hTHVMblFN?=
 =?utf-8?B?cWUzaCsrSEk0ZmRmcjlLb1BaN3lZd2F6TkZJRmFGQmdmS1RSMm1sZUhUaXhV?=
 =?utf-8?B?anRJQ2ZUSHhmUFdGTFplOXRqSndMZ1FUWkUvUnVwZVNXR205MytxL0JNWFlM?=
 =?utf-8?B?eGY2MzMwcnNLaWIzd2Q0R2x3RUI1RjVkS1hZMXplMXdLTTRmcXBodG52RTBE?=
 =?utf-8?B?ZUhKNlpER1BxUDJYbkZzT1g0dlhFc1d5WTdFbVFlMHU0SWtzQjNaYU5ObWp2?=
 =?utf-8?B?aDJuWUNQeW5nazBlMzM2cDFadmovNTFxWEhDTi93UVFBd0tQT3BrL0g3dlgx?=
 =?utf-8?B?UTRMMWNqYXpHblpKM2R2SW1qR1gxSXY1cllRaW96bktjcGJMZzMvQVk3UzMx?=
 =?utf-8?B?NlRocWNzQVpqQmhuZEVGRTYvMTR6Z3Y5Q01UQTVjK3ZQZkhWMFVLSHNRREZH?=
 =?utf-8?B?NFJhbmlDZmVLSTh2c1UwTWorK0QrTkhFbHlQZEw0NHRNMXUvYkw3TnVMMmgx?=
 =?utf-8?B?TXFTbDNQVnQ1QzFBMzBhV0NYeUsyZThsNzZYRFphZW53R1pOaHVYN3g4NVVn?=
 =?utf-8?Q?vM9TMA+mUEwHEIdUwKO0N2WpB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35239f9-8ab5-49b3-8e5c-08db88224d5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:35:11.6561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIQLXryHV9KFtGHPS3/kf6q3YMuqkyq1wDZnqwOuwpyMTV2TwOO9yyT45/tyh0Du
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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



On 7/19/2023 1:34 AM, Limonciello, Mario wrote:
> [Public]
> 
> [Public]
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Thursday, July 13, 2023 00:15
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Subject: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
>>
>> If the second call to amdgpu_bo_create_kernel() fails, the memory
>> allocated from the first call should be cleared.  If the third call
>> fails, the memory from the second call should be cleared.
>>
>> Fixes: b95b5391684b ("drm/amdgpu/psp: move PSP memory alloc from
>> hw_init to sw_init")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Ping on this one.
> 

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 1b4d5f04d968..6ffc1a640d2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -491,11 +491,11 @@ static int psp_sw_init(void *handle)
>>        return 0;
>>
>>   failed2:
>> -     amdgpu_bo_free_kernel(&psp->fw_pri_bo,
>> -                           &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
>> -failed1:
>>        amdgpu_bo_free_kernel(&psp->fence_buf_bo,
>>                              &psp->fence_buf_mc_addr, &psp->fence_buf);
>> +failed1:
>> +     amdgpu_bo_free_kernel(&psp->fw_pri_bo,
>> +                           &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
>>        return ret;
>>   }
>>
>> --
>> 2.34.1
> 
