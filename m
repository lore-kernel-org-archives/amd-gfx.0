Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD53AC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 18:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E7310E5BF;
	Tue,  4 Jun 2024 18:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+wlOdJz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FE010E494
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 18:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0w5yL0J7EMsY4AuOG6qQ5ZE7WIlR4DLDWykUIFo1BiPLWa5g70jO0OYqXn0Lpt+X7oF56d/TIuEvB1fs88CHOgMT0rz0gaFTJPxnLsRDtxCOA2cro5U9jfVyvOdR47VGhOh3hezPwplppLf3zA2QjgEEOwRBooxhVHkb3mDx3PRAaOi1TdXV+cPVduMvvxYIa0w7EzdVpXa1ySLTdfQ2DVJWAQQQT9wxnJ/qiYWcAxV4+1nE2DeCzRt9Z/Hbp94zLK9AayQwQz0EUWOICj8NnFLETVvN1f9evN+ECbAWYti2AUidJWvvjgLV+y9IoYdXcWIpvEG6hP1HIw7SHpJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ktg3AMTKpYaxvBRfUWZuBwT/BNEwqtyTPogk9PVrdM=;
 b=akOfUkGF+PN70Nm2gIa9eL+SI+OAGFP2ylNBOtnmEWM+pAWwa2bJiYeMcYaJqkZQPV9XvsubNegYPFIJdOYQQrESQL0sphdVZ0Ksyt3Sv/fhuExJ9Dm6FHmNcW8ChT57Jn8XyX5Dpz05xq8wslZMs0Ai5a3VX5jkE3m97aTpKCxrDRxoNgThxfFc8OVabXdBtueTREVS3szRnRdcJdckqY/oqCUOGeiE5LMpF0Gp3OWDo6uT+Z6XhiZRPpbPnrz+CqyGFJYOzg4yHnkngtdjTogLYT0p6aDNEc+/8P9HTM2G/oWVKH3nzG48dM1HByZeKwM4BG/etvhkMqguHDRoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ktg3AMTKpYaxvBRfUWZuBwT/BNEwqtyTPogk9PVrdM=;
 b=s+wlOdJzOTTuvX1pyaM2ViY0gwBMGTU+H6bRVMx4dBhgViuJePPQt5s4ED5aMXJxnk3UZYevfz6S5pHZJy4ULKg2u36HuDpvKNIFWchdCcueQuHk7XiTJfE5+DxSnHhysdMibwrZ+vHc02JC5tlx6VHHCTOrCHdw5SzOllfonrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 18:44:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:44:35 +0000
Message-ID: <fb11113c-f4c1-497b-95f9-e80eb4e261eb@amd.com>
Date: Tue, 4 Jun 2024 14:44:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/amdkfd: remove dead code in kq_initialize
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240603084927.2570235-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240603084927.2570235-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d47b6e4b-6b5a-411f-9218-08dc84c6618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0M0a1pHQjBYcWhqQ1NqZnpmVDhOTXZCTWF2a0hyMmxWNGpKSjEzakIxK29X?=
 =?utf-8?B?dHlRQzQvMTZLTEJEN1RzSmhPZ3ZUZU94bURpakFsYXNtQi9WWmUvT01Uc1k4?=
 =?utf-8?B?TjlwZ2EvYzA2dFRBMGpRM3JJekE1UkNLRGJxdC9lMXVXRURqUHZjRTJaNGtW?=
 =?utf-8?B?UFFDYXhEVTdlLzlWTGFqcXBDRUdHSU9tTm9Ca3pFT2oxU3NDY2t2Vzc0aHZN?=
 =?utf-8?B?dStOTVZpT0cyM1pRVURIbExsd1liRkZObFAzaVQ0TVdoaGJYMkFWS0E0dHlV?=
 =?utf-8?B?WVZ0aXlRcmNlUGEyZmJER25sRXRwY1JiOUxZU1RHell5UGFwbERNZzEyR1lr?=
 =?utf-8?B?SFBrTHl2ck0zSHdBRDhJNm5oZXRRK1VzbXZNSVV6OVYvS2hWMjgwamRIVGxx?=
 =?utf-8?B?ODRZb0J2cEZ0UVNTWmhjY0MxbXEvUXJ2UlN6R3RPblNjS1BqbkJVUVVNSGx5?=
 =?utf-8?B?SmYzcTBpOGY5VHNMU3JHNnFRMDdVTEZoU3FNVDc2aFJWbkx1UXB3enpXcVZ1?=
 =?utf-8?B?ZnI1SWZPMzY1ajJJY1N1V0ZNVU5kbVJOWFUrVnVqdFNsL0ovU0VoN2VsalpW?=
 =?utf-8?B?NWozQitiUHRKT1o0UkNRdDJXM0RkUjVyNEJSZ2ZWRnRlTTAwRWIyK09ibTR1?=
 =?utf-8?B?ZjdCNmVCYTJxTWlzS3oyaWU1eWoxYnRvaGZoUXI3QS9qdVZHVk80WndZOURj?=
 =?utf-8?B?dVZrYUF3VXBLSlhhNmsra0k0eXRUV3Y1VUdBRjJQakd0ZGhObFhMdzhMcTZC?=
 =?utf-8?B?VU5tb04xV3VoVkl2bkl5R3JFMFd3ZUovK3kwalQvUjFYQkYxSjJzckRnNXZn?=
 =?utf-8?B?UkhoV0V5VFVWMXh4UXBjRFBORTlYMFlnTGNRbjhyT3ByZjRxZXd5TUtYN2pp?=
 =?utf-8?B?YWJKT1lBR01LajVDNlBPVGZoWXpsV1dBT2REK254Nll2MEJyNkRsVWxhb0NV?=
 =?utf-8?B?RC8rNSswR01BVmJQTWw0dE1Jd1h6YW5kQUtrSHg2WWlqSzZPeGE4aTFCa1Iy?=
 =?utf-8?B?V1VGRnBGcWIyTVpwd05EUnUvM2hSeUlKRFVwdUE3TjFHUDR0TlJtTnFBeTRn?=
 =?utf-8?B?T21pOTVibyt6QXk1Mi9BTS82QmRlZ3VQTFlwSjZXdVVjNWQ2UVNkSjlYMkJG?=
 =?utf-8?B?T2ZneUZnTlFMbWpNSUZGSFI5eWx4c3U5bDR6cnZuc0Z3NTdqMHQrQjNsS0pu?=
 =?utf-8?B?R2V6aGI5aWxNRmF6MVE2ZWp5WkZUMTVRbS9iL2RvbklHL05UVzREeVpwR2ZV?=
 =?utf-8?B?cXVHdzNyV3RYWm5kQzF6WTUrOFo4RndjY0lmcGhnQy8yMVdmcHBYdm44VDF6?=
 =?utf-8?B?eGZSdnlhdTVQQWVTS3NWYjRMZEl0NTFMQ3dBYzNWWG1iMVNSbGxqVVg1T3ZU?=
 =?utf-8?B?WjdsZjlxS0FZYlhuazBZSTdnOUhjMnJFTWliTUdSWFNGOHIrNENZQmVMcVNm?=
 =?utf-8?B?MUFDc3FHWXZQM1NueGlIUUdrNXR0dE4xbUx2TVFyellNRDNPZDU5amRXaUxl?=
 =?utf-8?B?OTJMVVZkMDhwMnpucysrSi8xYXhUUGJad214bExoU3ZVR0YrYlFHdHRrOEpn?=
 =?utf-8?B?dkx3RTFjelZtY3NsUGJEU1paK2RKOVRmRVpTWmlVZC9CUEdHNHFvRU52dk5D?=
 =?utf-8?B?WmJDMS9Db0pkUFEvRFFLcERJd2VEUUp3SlZoOGZJL1ROdG1KYjdGVWRJSnpt?=
 =?utf-8?B?YkQ3RTh5TDZXZmFWSDlTNFM5dXRFa0pZa2RDWlJIanRWRHRiL041KzhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNPS2JWcWlBeVJTMXcrL1duVE90b0JQUHI4c2JFL2ZlSC9ERzRUVmgyUGZj?=
 =?utf-8?B?cXJpSVJoM0tmWndFKzh0MWJzMWh3dzFROG1aZzdPU0JOMkJzOFlJMDZnN0pq?=
 =?utf-8?B?V0k0WFhHNVE4MVNUZHk2T2tCN1lnRWtTcWl0VmRUWjZXUnBYNTNRbjhuMXNv?=
 =?utf-8?B?NmVYU0ZCMysxSm5vZkdCenI5MEtMTDhmVHVLd1FQcDhYWjdTZzJiQ2gwYk1i?=
 =?utf-8?B?YUsycFpJZFh1cDBDdlhscEtUYWZTcGhGYnpNV2dWdGw5S2hMaHo3UWxDT1Jx?=
 =?utf-8?B?QVpvNW5HTGUvY2xEbFQzMzh2UlRzcTI3VVRIYy9vcGUzMFcwc1pOaWZoS0hQ?=
 =?utf-8?B?SlJQcG5sRlNNb04ya1N5SXBNSWlrZ0c1cmdwWXdIWm5xZlhEQlZsUmU0Z21W?=
 =?utf-8?B?Z2hhYmJha2ZmNjB5cHNjWXIrZmRNUjhXclU5RUtzRWRwWHlweUtjSFhWSGFy?=
 =?utf-8?B?dnRTWU9lVE9oM2ZEd1JXOWN4R3JrUW9sdTRSMXkvSVJ2dDFTQ1I0UktUZEJq?=
 =?utf-8?B?S0pqZWUyM0hJRmhLSExOZytyT3FWV2FNVlBBQ3ZIQnFLL25WUHZ0VWFwU0RN?=
 =?utf-8?B?dFJEWjFwQXFCODdUaXNCTloyTUhYeFZodlRTcnFud1RiWmEvYUFRcVdvT05F?=
 =?utf-8?B?aWxieHJxQXJwMThNZUpTUDBNQ1QyOHp4dkhaMXluM2pUcHMydUl3S0xNVzRF?=
 =?utf-8?B?b0xJMmJ2TERKelVaM2ZlL3NYa3B1WVlXTGl3TUU3RDVxSDc3ekl5Q0oxd1hL?=
 =?utf-8?B?T1JvcXJwZzFCaE80S0xzb0hXNVJYa3F0cVJYZmFua0djbzlUNktMY2VKSFFZ?=
 =?utf-8?B?ekNiYmxFWWEwOFQ0c09IT1ZBQWF6VDFHcUtweGV0VHlNd3Y2NjAzQVU0WEJk?=
 =?utf-8?B?aXdQRE1ueko5UXllU29FdE1HUGNxSDBabm1EaVBjSE1wUG5LWDY2WDczZ1FO?=
 =?utf-8?B?OXR4bzQ4UkY1NG1paWZXMk42ajg0dXlSNjdkNjdjdlVOdTRrNjRSZTFoTkIy?=
 =?utf-8?B?Qi83ZG1vTk1IUkN3M0gzZHd5cWQxZ3ZqV2FubDRQeVRpU2I3eURab1J6emky?=
 =?utf-8?B?SEVrS2xSSHBOVVo0M1Nhb1luRFZpWXd3OU1uWXpWZGhGOG9BbjQ3R1R0WFJM?=
 =?utf-8?B?ZUdEaUQ4cEFlUDMwOURqOFhrWUFYdkRmQU9SZktaTVBPNjlFU3hRdU9wclU5?=
 =?utf-8?B?YzVZOVRENkt5bUNVeGxJeFR4TkFaMFhkVFQ1L0xCWW5sSUZSdU5GS2hzVlpQ?=
 =?utf-8?B?dk5JOVYzTDRheHBmZW5jVFRxSGlrOTZDbDhYWEhwNWhER09uYUtORDE1Sy8r?=
 =?utf-8?B?WHNrakt1OTJySW9FZ0RyWTFMNzNQK3pSbUpvSDExRktLK2M0QlBOdU5uMFlV?=
 =?utf-8?B?ZklsbWFHZnYwRDdSZ21Wb2h6QkFiL0x1Rm1SanpaTzhhYUFSZ2tQVEFXbkRR?=
 =?utf-8?B?QWYvbmxyQlFlKzJTKzJTWkZjcmVDbDYyR1hYaDU5dytNNkFRbVVaVGgzcTFZ?=
 =?utf-8?B?UlhmcHh1dTlENDNETDVTdXdraU42ZUY1b3RZNkxNa1JuMkt3RVBjSWd0QzI0?=
 =?utf-8?B?N0tZaGpSNVBZUDJIRXlqWWRvTzV0VFZIbytObDJMZW40V2NLbnVZbXRsSjFK?=
 =?utf-8?B?OGwrL3F2ZVhaL0RxU1FJQWhXaDNmV0VTam5tUWRhUWRjN2loQ2htZ3hKdkdM?=
 =?utf-8?B?VHZhb0NLOTVpTk4wazMyOE9KTVFtU1RycXlGS1ZhRVJpeHpsanZyVThMOXNS?=
 =?utf-8?B?Qjc1Z0pJZlprMm9wY05STmZOTmJlODFNL0EzK3dkT2l5RXFWN3lTWW04UTNL?=
 =?utf-8?B?cDg1Y1N2S1diYjNKZzg1SzM3ckswSE5Oa3hPNzN2bTJFbHVHTjhWSCtVOU1l?=
 =?utf-8?B?T2xVRXNveHZBaWlEVnJVcXRyVlJld3g5OWtwUjVIclN4akVBaXVLaS9oSDRN?=
 =?utf-8?B?SisvVXkreXdYci9jc1dIUmlCZ0czd2ZmdE9OWmRIZkM1SHk0SlpZZi85WGZ3?=
 =?utf-8?B?WmNzdU9sSUFEdnRvNkthOUxjMFJmR1BZRjUwUFFpYmZrOEp1UmlzVHZKcFJ5?=
 =?utf-8?B?eVp2ZFdyUWVsQ3N2dmw2UjYyOU9IZ0trVFlXOUphRjJ2QXlITm5yV2lEdlJu?=
 =?utf-8?Q?QiX5FxEKBsZkcKDr8TfWMUZcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47b6e4b-6b5a-411f-9218-08dc84c6618e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:44:35.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buSZG/bnvx/T8aWI7BHuoMhKPc71WVYlTHlFyIoBaC7ix5HKB6tsnSMi7gMMC09NCXI/Sq5mZc1PiGEDqiAHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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


On 2024-06-03 04:49, Jesse Zhang wrote:
> The queue type can only be KFD_QUEUE_TYPE_DIQ or KFD_QUEUE_TYPE_HIQ,
> and the default cannot be reached.

I wonder, if you remove the default case, I guess you are relying on the 
compiler or a static checker to ensure that we can only pass valid enum 
values to this function. I don't think C compilers are that strict. You 
could pass a random integer to the function. That said, this function 
only has two callers, and both of them use a proper enum value.


>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 32c926986dbb..3142b2593e2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -67,9 +67,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   	case KFD_QUEUE_TYPE_HIQ:
>   		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>   		break;
> -	default:
> -		pr_err("Invalid queue type %d\n", type);
> -		return false;
>   	}
>   
>   	if (!kq->mqd_mgr)
