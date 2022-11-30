Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344EDC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF2510E104;
	Wed, 30 Nov 2022 00:39:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301910E104
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF7zVxqSr3RbfT3xqG6gaBa7sKSnDzmVO0En5ZrGAz9L/E9y711H0V1NV5JqnyWWRwODng1JAQlYpE9Rvad1EEN/6wAhZ2AeI1ry2Pfvc4yWuGr2oJHVqpnlSbCs49KWsA6kF94aQpNMAYg7rtT7Vc/8F0Hw1CFSWXlLnaMTCJj05O/DmxjCfq5YrLkmHkCgHJjB8hWisqSa2dLrywSXaykQGgY/8UXoPBTWejUSbBRwGaPU4WFWj9neZrogYfYxUgXaDBW+sineEnmu3w8CiElz0fM36Ca624MeFPrjCsuOq4UsAEQqbhvr0hsuuVnrywQ4EzfRCjqJz9jL1XNdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg0V3/9msRn96B/aa5hwnisqZKjMe6swrBHUalFKYrA=;
 b=FtKX/4mCkW+YrMemuXmF0X92p0O9NnpRlIwE0XRHuOFiyptumnmcNygqO0xVZaXZiwPqZdysDNTUxrEKBLHT4chRu+WCPEUrspYOB+muIzWh+xZD7vO3EsbRFFAtr/yE0wKfM9jyXBZWXTIJmDf99iuzVCszmxU1ALPUR+yhA6nX90Rbq93CapgD6iR/L34ueX/nLpbuJDnMVRcQWv6F4u7HeWfYdUBXh9zQbzy8YP0yTp5pSbny03y1skvQlIBPAsJOWQcjzVAoL5yepPci6hymQtxhHHEkReDKo5/xggdpt7R/602bG5/Wi1NxidhigOZ9XGWVpxocG2OTYsEHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg0V3/9msRn96B/aa5hwnisqZKjMe6swrBHUalFKYrA=;
 b=KNogMFQ+/56H4+OasL6TR/vRmsISifWKrwjeS0I6kreXhoUArolP5QHpiTdb3OdIz//fjFOfUDjT5C0GeLYxMgYcDN+j6y1CdQIZIh4j362mha7T9eB5A+egn0aW0yw+XrhNO4enYeGFx9PublKuI8k/WmFXt2y4dJY2fyHg2rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:39:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:39:35 +0000
Message-ID: <a467a367-1ad6-a043-e1bb-0c9757263310@amd.com>
Date: Tue, 29 Nov 2022 19:39:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 24/29] drm/amdkfd: add debug set flags operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-24-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-24-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:36e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: b3083844-fd90-4e24-1bde-08dad26b5a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3EI5zwleVOmAoJj4p+oOtLwfGC1lO9MtdMqjilf3o6KSnk7mm5C8L8roxz3qYZ0JulonQJC9RoemqfPV+xSvrugdaZpY3FCAXt7ZWFxSds3dHBwEn0FfKPgzsN7FwZcxx2Yo10slBFQjwEhz/+NFnm5lkxq5i8wI8FW/nuzJtRvN6/CV4M0uqjef7lVPeNBpusrzVhgDspbr0izfxMg6tzH83W30kax78ZU1fcK/IQ6DFK+gofmZFBp3MoNKiuFYk1sQ+9qiEebx/kUU2SnguQUCfPc+DXdHO1EzkP/LLoqvpo6WJX8MEJzxXdMw1gG82t+zxtC38/W4gfmrMOL8zqApmo1iq711rAoahPEzasOfSS6abkLMHzJ+0Io2kt3tBDc/RRxg/OhW0wenIvKw7F/w67xGC+CEN6tvLG3fE0T1QV8ofRUgPjfHLNnVm+fCtLq4lBoh4zVI/IWjqMCCRh99wEvDOOzbR2EN6JKbq8g567RVX4Am7x+DWs18jEIogaiCsBu9Zl4yu2q4UI0Ph3dtCC1PPk2ItEQxwOZQFQvBB8Cw67PJTc6SYvEldNfIlhvMT/rTR2OWdXgMpQf1xO4hvlloPNZb6pwch2ndcfiQaKEQctKk/hmmFaHz0/rOkmdFPDv6CWYd9DysBdydcv0dCuGgrekI2dXMS1alJb7/V2duLcIMBleeS/9Oz4ueWVh+SEuY+pL2nPfwDHDzPR7xKCnkhTNlpuXdJo/oUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(5660300002)(44832011)(41300700001)(316002)(26005)(6512007)(2616005)(186003)(66476007)(36756003)(8676002)(66556008)(66946007)(38100700002)(4001150100001)(8936002)(2906002)(83380400001)(86362001)(6506007)(36916002)(6486002)(31696002)(6666004)(478600001)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTcreXgyTFBWNHFSbmVJNkdoRDBsNHBXWHJwcVZsZnd2bENmSVo2WDJhNnRD?=
 =?utf-8?B?N0pqS3ZWcGQ3MFVWdUErb3dZYzdWTVhZYzRCckRGZjFKRmUwbXBaS2Rxd1pz?=
 =?utf-8?B?b1dMMGZEcHlvR0pWYVlNVlk5am43SjRROS9yODdjVlRlWjlhWVArZEN5bnJ2?=
 =?utf-8?B?aVRKdlMwbkNScmRUd2lLRXlEd0FvM1U2NjZyVnZ0KzFBb05pdFNIQXRxY25E?=
 =?utf-8?B?M3E0cllvV24yWlNYTGFtTHZtK2NzZnE1YWJ2REp0aE9rbW1ZU3BFQm1GMWQ3?=
 =?utf-8?B?SmpTeXRBeU9YQlJ6UFN3YzBQVThTRDNNMHV1bW5lbktRc2lRcHJaQm1VWWVu?=
 =?utf-8?B?d3BQejRjQmY2TnBKWGx4bjZ4dTR0YlhzWlNyZTNoMVNyMWl4NC9zVm1NM1Er?=
 =?utf-8?B?RDN5K0FCSFd4eHNRUDl2RGFmc2tiZWtiZ09seFZuN3cvbG5rSDhFMTY2WW5k?=
 =?utf-8?B?bk10dVF3YzBucFdmaWlQZndjWSs5SWJFL2ZQQlpzeEVjVW5VNDB5a1NadVNN?=
 =?utf-8?B?bXl6bTJzd0Q1K05PdnNjdDFENVJDcUdTbitjMTdNOE41U3R2MnU2dHZvV24y?=
 =?utf-8?B?NExCZzJHYjUrNTZWYW00TnZnd2FUNjg5R3BXTm9hc3Y0dHAwN3BNaTEwMjVZ?=
 =?utf-8?B?WEZNVCtab28zaHpsV1FRVTJBMVV1Y1psQjNRR3RxU0FCOXd0amxKQWRZTmkz?=
 =?utf-8?B?dktEWHhPVnptRVd5VU9SRUNvNGJ1cXdzZ0xYMk5iRTl3d21iSHgzVk1RV21U?=
 =?utf-8?B?anNFQTk0aHJGR2dOVU5QdFdQQzNRKzZLWitRNyswNUpPY3FrR0NmemdpdUpW?=
 =?utf-8?B?SElIUXZkTmR3UzFKU2dBbmFFbjRlSXEwZGcxNnVaQzdSSytza213OE83anBy?=
 =?utf-8?B?OG9oRTlnZHRxSmdpMzNpT3BaRXAxcm9FUWNIbUxBekZiUmJ3bWl6ZDFHaDlF?=
 =?utf-8?B?K1hJdmVORkIxaEYvNmMvK2ROQWdIT1ZkaUNzUTNaMkZOUFFwZGp4VkV5TU1X?=
 =?utf-8?B?M2k5dXdkME1DMDFKbXY0clVtYm55cTBTeUJCWjVIRmh2RU9rSy8vZmRRQUlY?=
 =?utf-8?B?UThUc1pBWTdtUWdLTTJRV2RWTkdTUkt1UHRad3ZHRnpHUGVkY1luSHhGUk00?=
 =?utf-8?B?Q1NBU2d1eThIRENQdkJkdWJiUXVSb05SZ1kzTnVZZG1BRTgyb2pTclRoY21Q?=
 =?utf-8?B?OVNXUUdQN2hONGFKVWlXS1laZndBbUhFKzZNdEpMQmlpSWhocjJ5Z0dya1o5?=
 =?utf-8?B?azMxOEs3QkZrbFl2UFd0VVVJODE4TFVLRVdLdDdoU2N2bXc5OFEvTDR0VEI2?=
 =?utf-8?B?VE9jYkFFdzBETG13ZHlRQ1k3ZUZCMy9Udm9DN25ZN3M2OHFFWjhxbEpOTXNh?=
 =?utf-8?B?dmlvZ0pwbUNodFlIYmZmaHM3dTZ4SCtqR0Z2bEpBL2FoOGkyY0hiN2RhcG1F?=
 =?utf-8?B?c243WC9Fa0dtT3dLdmpIS1ZLUVBzTllEb3NIc3dsZEJ1ZzBENGxicm5yWjll?=
 =?utf-8?B?Q2psb0xKNWZrRC9SQU5PK0RsWStsWC9hWEd4Rm11NnBNZnhZYkcwZzh4UGw4?=
 =?utf-8?B?WWZWb2FJSXdJaXhmeHFUS203VFpiZWt2OURwQ1Q2VEd1UmFvR2ZGZ1FkMVdv?=
 =?utf-8?B?SHU3Q0VrUzM2THpiZkdkMGlXZFlNeUwvSGUweFMvZW80R0FybzhobDh5VjBM?=
 =?utf-8?B?RjZTNHo0aHFkNXRLUVhLTVgwTFltRHdQQUxZdTJXMG43RVAyajV3REd6R0dm?=
 =?utf-8?B?U3hxQ2RwV0dzai9CNVM2Sm1XSDZpZElkTVVsMytmVnVSSFZxV3dpRVpreHRM?=
 =?utf-8?B?NTM4QUpEb2g3alFFWitDSjBGd3hFcnpyODV3WUJDcDM5NStSQ3dtZEg1VVc5?=
 =?utf-8?B?bDYzQWZ3V1crRmZOcTl2a0Zkcyt6dHBWN0UxcXBjeituU2x3NENKbXo5WDUr?=
 =?utf-8?B?NHYyNzJ6R0FIQnJsREd3MS9Wd0lHL0V5T2l5d2d2WjhJaHlSNHVlU1ZlQVNK?=
 =?utf-8?B?blIvT0UrUFdZZlM3cE1KSlJHa0V5bWtha05PZXNmRWdoRjRmeGxKYmJQK21B?=
 =?utf-8?B?ZDFUOFIzdG1DY010ZExZMFdyakRKcEhEWm8zdG1FbzBkWnBsK09tVUJUb1N4?=
 =?utf-8?Q?cWTnnArZdOFXCGt4eYTb18Cqw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3083844-fd90-4e24-1bde-08dad26b5a10
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:39:35.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdvrGlosCCTeY9G1Te+16R1wXb3CDvZ2A4+J4b77k16ueRAnMv0LNkCZhlwSfLla9nbxbnpSwEHlpvG08fhVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Allow the debugger to set single memory and single ALU operations.
>
> Some exceptions are imprecise (memory violations, address watch) in the
> sense that a trap occurs only when the exception interrupt occurs and
> not at the non-halting faulty instruction.  Trap temporaries 0 & 1 save
> the program counter address, which means that these values will not point
> to the faulty instruction address but to whenever the interrupt was
> raised.
>
> Setting the Single Memory Operations flag will inject an automatic wait
> on every memory operation instruction forcing imprecise memory exceptions
> to become precise at the cost of performance.  This setting is not
> permitted on debug devices that support only a global setting of this
> option.
>
> Likewise, Single ALU Operations will force in-order ALU operations.
> Although this is available on current hardware, it's not required so it
> will be treated as a NOP.

Having a flag in the API that is just ignored is misleading. I think we 
should either remove it from the API for now, or at least make the 
function return an error if a debugger attempts to set the precise-ALU 
flag. This would be consistent with attempting to set a flag that is not 
supported on the HW.

Regards,
   Felix


>
> Return the previous set flags to the debugger as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 35 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  1 +
>   3 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 9b2ea6e9e078..200e11f02382 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2943,6 +2943,8 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				args->clear_node_address_watch.id);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SET_FLAGS:
> +		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
> +		break;
>   	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>   	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
>   	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 68bc1d5bfd05..1f4d3fa0278e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -23,6 +23,7 @@
>   #include "kfd_debug.h"
>   #include "kfd_device_queue_manager.h"
>   #include <linux/file.h>
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   /*
>    * The spinlock protects the per device dev->alloc_watch_ids for multi-process access.
> @@ -355,6 +356,37 @@ static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>   			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
>   }
>   
> +int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
> +{
> +	uint32_t prev_flags = target->dbg_flags;
> +	int i, r = 0;
> +
> +	for (i = 0; i < target->n_pdds; i++) {
> +		if (!kfd_dbg_is_per_vmid_supported(target->pdds[i]->dev) &&
> +			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
> +			*flags = prev_flags;
> +			return -EACCES;
> +		}
> +	}
> +
> +	target->dbg_flags = *flags;
> +	*flags = prev_flags;
> +	for (i = 0; i < target->n_pdds; i++) {
> +		struct kfd_process_device *pdd = target->pdds[i];
> +
> +		if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
> +			continue;
> +
> +		r = debug_refresh_runlist(target->pdds[i]->dev->dqm);
> +		if (r) {
> +			target->dbg_flags = prev_flags;
> +			break;
> +		}
> +	}
> +
> +	return r;
> +}
> +
>   
>   /* kfd_dbg_trap_deactivate:
>    *	target: target process
> @@ -369,9 +401,12 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   	int i, count = 0;
>   
>   	if (!unwind) {
> +		uint32_t flags = 0;
>   		cancel_work_sync(&target->debug_event_workarea);
>   		kfd_dbg_clear_process_address_watch(target);
>   		kfd_dbg_trap_set_wave_launch_mode(target, 0);
> +
> +		kfd_dbg_trap_set_flags(target, &flags);
>   	}
>   
>   	for (i = 0; i < target->n_pdds; i++) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index ad677e67e7eb..12b80b6c96d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -57,6 +57,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
>   					uint32_t watch_address_mask,
>   					uint32_t *watch_id,
>   					uint32_t watch_mode);
> +int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
>   					unsigned int queue_id,
