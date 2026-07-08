Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D422C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 14:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F136C10E5F9;
	Wed,  8 Jul 2026 14:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvTFOsOg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B7C10E5F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 14:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htEYVhke+cxbPubkLAPCCW7ZAyErtt2OY7C0/VS5Xwmq/TQj0zzy/gt7Q/+gjavFNyBYhz4o2me6K5dqNQcjtd+b3jPr92Q8XaTctGPttYoAaXLU1snw1HzG/R1Ex1BSrNhcjwBuzjI3V0koVgSTFiibMOZxbWH3JQbl99MVi7584g2HNM+ZFWHcM+QRy1mPhPwEWyMYtty23wMxeoSErZWqoncFVw+0bOguSxH4Q/AKzynLk1KJaDL/mzgu77eGxZuDmNPjp0shDkd2/Z8FYCNfh9TWUcmUU1vPGPQVOlita2xPi+IQVCzDRBelQttHJUFN1yvugHdtExgUEz73cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL4Tzgqs+xhdhpijPR0v3/sLr85tx5vRL8pcYKYw4XE=;
 b=KD1kLmaBuXAhZ512kkQ77zwY/boN0zMVp5+dMfnduovfGq+LweT9sWNjdsirfdBz6Gxr2R7zYjYd7tiBJXSTttgirc2t1HsEYY1wlhIuy4HVFsvY3p1HEn3peUqAV+cThYaPUTH2CSvw5iABkQSFUy0KxVBZQD+/SV1Xj4xkyLItKocEqZZel/X5NX7EPUys9iCsTtfB/zOHdTKk8DH7fJWJsS8c3a3WvUpuerEX5HJA6Vl+K8v4Hp7uaHP0FhBvjK1kmkMe3p9SIX7Jk7O+kfuyBJ2gky44a+wLHt4hXoiBwxWiRSPLjhJkW5e5Ij/o5IYS0zs3Sl1MAxeG72ZQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL4Tzgqs+xhdhpijPR0v3/sLr85tx5vRL8pcYKYw4XE=;
 b=pvTFOsOgALQB0lfngq3OBe73n6+bUpp829SY7k2WKLtQh4sDhxRoSx7mKPr9WdxkHXql/021cT6qWP0PUqIcitS2exWT7SrRCTEXAJpA7cR/Mr3MM/vjVN6+w3D3X2OPWBAzIG3KU4JsWr+sfiGfZ4HpKJDdnZngMQyRsOfoT3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 14:17:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 14:17:57 +0000
Content-Type: multipart/alternative;
 boundary="------------bLfSVg0lL0rKnUixjntWjSWD"
Message-ID: <f23b1cf4-aed0-469d-9739-e9cfcc0b6bcd@amd.com>
Date: Wed, 8 Jul 2026 10:17:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix 32-bit overflow in CWSR total size
 calculation
To: Yongqiang Sun <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260706191852.2077498-1-Yongqiang.Sun@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260706191852.2077498-1-Yongqiang.Sun@amd.com>
X-ClientProxiedBy: YT4PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0b2b2c-464f-4517-22ce-08dedcfbb56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|6133799003|11063799006|56012099006|8096899003|22082099003;
X-Microsoft-Antispam-Message-Info: IcKzoHl3zUaCB0huZTn59z0zWkAiSkAakbDNyNCWCGin1az1UURJVM2qkDdHnRUQ7sR5CpJZE/l+PT3Fut+G/+kvJsvv6sKWd6Tcm2Su0lafxW27jSDSV+ngZdFUmROl0eAcairUnrU/I9LVe1GECKuveu5D806qK8uSNFDwfOa2T6gEYFDwBEFsgU9AqmucvliFmTI57G58+PxhIEjCLCaNY9qhZ66BL3DP+x6vjodLSjvSxM0sEiozGSi0sbSGGRZ22qjo7n7IeI5O2nnFlvmnMXVtDmp+4NAgVYOWdm8WPZEgW2U9HQ5883i2nzgQxX3of95oArNAi34iYsC47L1ZGcpir1dY/uQ3CaldPiYqOcQiy/EAvFEdEsSKO2K+u6yHBhLagesGP6cPSK56THY/oAEQTfG93XDuUyDt40WY+fE2vSHKNh7St1KbJenSsDXA2LG+aPz63wARDpQpY62X6ZzepvuVohqgOIbKxZTrFDgz39xnzAwW3xK594nAGSjfTXsnZHHXSMWpDaJRcVz1sRItJQkoDdmccWDKgLAIK6abKm5J7m6NqOUD+LPd4OTtZJX4OoI/cdmA9ruHxnckULpjWTDZiwWqlUqKwGqdt6XXWDxY3POnVXQmHBd92JS3GAyEP9W1UEYDJeO8S+v44SYRlf41UI3TQg3MKaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(6133799003)(11063799006)(56012099006)(8096899003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlCeE13RTYzTlZOUm5iU2NoWDRYMDI2U1kyRmpKT2xmcC9hdFJab3YwUEgw?=
 =?utf-8?B?NjNzYVNzOFF5NWRTVVhOcXZrbzZBNEloM2pvTFZLVDJLVExFS0RRb2NkbHRu?=
 =?utf-8?B?ajdPVWcwTzRqOEwzNmE1NDl6SGFDN2phdU5tbVdiaWZjcHk2VnRvdzI2UDJF?=
 =?utf-8?B?d3RTWXFUMlJaY2tiWnF3Y0FTbjFNbUFKYm03bzQwcVdmTDJZWFdNYitXQjkz?=
 =?utf-8?B?alUwOC9uR0ZHTkdLZVFCMzMxRFRGWFhKMmRsSXRmQ05zbXN3RGdzaGExRmlS?=
 =?utf-8?B?SVgvY0l0bnc2SGJOZUNGZ3VLUjdSaFBHSU1Ba3lmK3IycW9VRXhLL3B0TDdi?=
 =?utf-8?B?VkM1dWJUNCtGaElxVzNvejlxM1lHV1R4eUpOdExycGdjZjZEVm9YTDROUnRV?=
 =?utf-8?B?N2xESEhXNnVIVFVlTTdMQzNMSkNLYWs0bFdqV2RnQ2poRWtpWXRHL2ExTVlm?=
 =?utf-8?B?dGgrQnI2YmN5OVdEQ1NpdEJqTFNBNld3NFhaSFUxWlBTaytBSkIyemx6bnZt?=
 =?utf-8?B?dnpTNFNpTWNTM2tHR3VCK0RBS3ZCUktkcklwcTJZVWRaNlNGdDI0Zm81WmFk?=
 =?utf-8?B?L1BXNnlqT3UyTmdZa1dWWWwzRFNKbXg5c1lzSTlZdzRYRitRWktwdGhjU0ow?=
 =?utf-8?B?dnUrdEduU0ZDSDJZcExtNWdMUVlRYmE3aGVlR2VYM1FVWlhqbDJnK1c1RlpR?=
 =?utf-8?B?NHUzTjhjUVVxR1lsdVpHR29KdlV6VFhVRjcrSHpKNUtNbC9aeTRib3F6NWgz?=
 =?utf-8?B?ODVEWnFjVjdqSTRaRjlyeHhyTVAyWWlZcUlaaGhCQmpySnlaU1FPVWJ5bVRq?=
 =?utf-8?B?R3JwdTkxTUNtQjRHZUlWWWtTY1Jwckt0eTd6RXdPdjdGMEsvTUZmRDB5d0FV?=
 =?utf-8?B?OTh2N2RkU2c1bWlLNmFORWNwK3RtNkJwYVU1dmZTS3lwaXIrcS9LeGowNkx0?=
 =?utf-8?B?Skp6UDZLb1c0aEE5ZmJiK2ltc1A4Y2Qwc1M3Uks0MUV4Q0ZjcnNMeERmbU5M?=
 =?utf-8?B?emNkVGZ5aU4wU2s4b2NPdVF2MTFEbHRYMVdyTE9IbGRzSXFFRHNyRDR0V1Rm?=
 =?utf-8?B?QVhCMzNnVS9WdWpYdVdWdkJWZE81Z0g3OXNHdlhkZTdQSzBwWVZqdDJ0dG1o?=
 =?utf-8?B?dVBDYmdIZ3FyeTVsdlNXay9GRjZQSzRKRVRhRVFzT01CbTJTODY4dmk4aFdo?=
 =?utf-8?B?WXpCN0dUM1BKdnNtdkxhS0xpMzByTUNMLzBBcnplVmJldG9uVjJ6N0pYaC9K?=
 =?utf-8?B?SEVmTUREVGYzRXRkVzVXa0hXOWU4dVo5TmtqR0FkcVpacHd2RStMMHFYWm9M?=
 =?utf-8?B?WlgrU1A4SEVSV09Dd1hEMHpXa2liRnBRNHR0NGEwMHpWMFlXU3dRYTlxNU5h?=
 =?utf-8?B?ZTZXWjl6NVpsUTYxWXlKN3p0NUc2Ukszb2Y0THF0U0tmckxvWFRKZDE2NWtz?=
 =?utf-8?B?dEh4bS80K2ZHd3RWRUc1UFVTeHBZZmNLbStIdzlhbUEzQmJPMHU3S3ZmNE9s?=
 =?utf-8?B?RjlPM3Zab0lFNXlxWkhoM1dMM05zYWtZWWZ1RC9JRW5WZk5lbG9zbTJURG5O?=
 =?utf-8?B?Q0h6dWd3RmIzU3ZFT0pHUnRCb3VYd0JiRDdHejNnbkhSM3JLQXlZc0pPc3FN?=
 =?utf-8?B?cEZXb0lYTFArYndvanRya2JiZllqamcxTTFPZkMveUJ0anRqem5MUDkzdm4r?=
 =?utf-8?B?bXh2WDFuRGN1Mk43UDJlUVpOYW9XNXBUSWIzZ3RqLzZjMVZPb1UrdWVwZk1R?=
 =?utf-8?B?SldUM2FTWForaDdiNGdpczhJd1JFM2NxSGRub0orWTdEVG5ldWxkRStZMGdr?=
 =?utf-8?B?SzQ1ejd5dmtyQ0tjRnoyelBzWkJVRnZVSFRvQmxobC9QNHV6L0xMNW94SWJN?=
 =?utf-8?B?MDRqeW9BSC92YnlFcXlpWHZtTjd5dk9qNjNtcm5uNi8vWU45ZHArN2czLzhy?=
 =?utf-8?B?aXhBd3E5OTR1U1BUNnBaVGlUZ1kybVlMNUdKWEFXblJ1VkJBbUpjUXpTZzZn?=
 =?utf-8?B?N2RCKzRnMVRpTHNqYnExTGVMeXNsZml4ODlOaXVvc0h4R3dFSTJQV0ZxeGZs?=
 =?utf-8?B?bjZtRnVvTURFS0w0b1ZFUndUdi9HRk1CZjJVMVRUWEVBYXB5Umx2dDJMSnVP?=
 =?utf-8?B?Y1lVQjE0WGJNRjRJUU9FelhBaXByaTBLcGN4T3Z1RkJZTWZoaEQwZlJPdzVU?=
 =?utf-8?B?VHo2cVpXU0h2MnNNNXozS1dvY0U2Zk55ZS9NWEtxR2pYNjZuY01SSS9jUVpO?=
 =?utf-8?B?ODNmK1RZK0p5VFJaZkNsdlRQRW1zTjFGWkJheS9PVE9qQjRXTVhuWEpXVE1t?=
 =?utf-8?Q?lVB1/P0183S8sNHqhc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b2b2c-464f-4517-22ce-08dedcfbb56c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:17:57.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2o+Bug7EXXCzf6tU2QBrrxJik2poKdWkzNwSZ5m7X4hR2enfc3nOQ9yGK6qFJBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

--------------bLfSVg0lL0rKnUixjntWjSWD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-07-06 15:18, Yongqiang Sun wrote:
> total_cwsr_size was computed in 32-bit before being used as a BO/SVM
> allocation size.
> With large ctx_save_restore_area_size and debug_memory_size
> multiplied by the XCC count, the product can wrap,
> yielding an undersized CWSR save area that firmware later overruns.
>
> Promote total_cwsr_size to u64 and use check_add_overflow()/
> check_mul_overflow() in both kfd_queue_acquire_buffers() and
> kfd_queue_release_buffers().
>
> Signed-off-by: Yongqiang Sun<Yongqiang.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 9d4838461168..4b1c1e379244 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include <linux/slab.h>
> +#include <linux/overflow.h>
>   #include "kfd_priv.h"
>   #include "kfd_topology.h"
>   #include "kfd_svm.h"
> @@ -235,7 +236,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	struct kfd_topology_device *topo_dev;
>   	u64 expected_queue_size;
>   	struct amdgpu_vm *vm;
> -	u32 total_cwsr_size;
> +	u64 total_cwsr_size;
>   	int err;
>   
>   	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> @@ -308,8 +309,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   		goto out_err_unreserve;
>   	}
>   
> -	total_cwsr_size = (properties->ctx_save_restore_area_size +
> -			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
> +	if (check_add_overflow(properties->ctx_save_restore_area_size,
> +			       topo_dev->node_props.debug_memory_size,
> +			       &total_cwsr_size) ||
Because properties->ctx_save_restore_area_size and 
topo_dev->node_props.debug_memory_size are u32, total_cwsr_size is u64 
now, check_add_overflow will never overflow to return true, use typecast 
u64 add instead

total_cwsr_size = (u64)properties->ctx_save_restore_area_size + topo_dev->node_props.debug_memory_size;

> +	    check_mul_overflow(total_cwsr_size,
> +			       (u64)NUM_XCC(pdd->dev->xcc_mask),
Since total_cwsr_size is u64, NUM_XCC(pdd->dev->xcc_mask) will promote 
to u64 as well, this u64 typecast is not needed.
> +			       &total_cwsr_size)) {
> +		err = -EINVAL;
> +		goto out_err_unreserve;
> +	}
>   	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>   
>   	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
> @@ -344,7 +352,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
>   	struct kfd_topology_device *topo_dev;
> -	u32 total_cwsr_size;
> +	u64 total_cwsr_size;
>   
>   	kfd_queue_buffer_put(&properties->wptr_bo);
>   	kfd_queue_buffer_put(&properties->rptr_bo);
> @@ -355,8 +363,13 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>   	if (!topo_dev)
>   		return -EINVAL;
> -	total_cwsr_size = (properties->ctx_save_restore_area_size +
> -			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
> +	if (check_add_overflow(properties->ctx_save_restore_area_size,
> +			       topo_dev->node_props.debug_memory_size,
> +			       &total_cwsr_size) ||
> +	    check_mul_overflow(total_cwsr_size,
> +			       (u64)NUM_XCC(pdd->dev->xcc_mask),
> +			       &total_cwsr_size))
Do the same change as above kfd_queue_acquire_buffers. Regards, Philip
> +		return -EINVAL;
>   	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>   
>   	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);

--------------bLfSVg0lL0rKnUixjntWjSWD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-07-06 15:18, Yongqiang Sun
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260706191852.2077498-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">total_cwsr_size was computed in 32-bit before being used as a BO/SVM
allocation size.
With large ctx_save_restore_area_size and debug_memory_size
multiplied by the XCC count, the product can wrap,
yielding an undersized CWSR save area that firmware later overruns.

Promote total_cwsr_size to u64 and use check_add_overflow()/
check_mul_overflow() in both kfd_queue_acquire_buffers() and
kfd_queue_release_buffers().

Signed-off-by: Yongqiang Sun <a class="moz-txt-link-rfc2396E" href="mailto:Yongqiang.Sun@amd.com">&lt;Yongqiang.Sun@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..4b1c1e379244 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -23,6 +23,7 @@
  */
 
 #include &lt;linux/slab.h&gt;
+#include &lt;linux/overflow.h&gt;
 #include &quot;kfd_priv.h&quot;
 #include &quot;kfd_topology.h&quot;
 #include &quot;kfd_svm.h&quot;
@@ -235,7 +236,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	struct kfd_topology_device *topo_dev;
 	u64 expected_queue_size;
 	struct amdgpu_vm *vm;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 	int err;
 
 	topo_dev = kfd_topology_device_by_id(pdd-&gt;dev-&gt;id);
@@ -308,8 +309,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (properties-&gt;ctx_save_restore_area_size +
-			   topo_dev-&gt;node_props.debug_memory_size) * NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
+	if (check_add_overflow(properties-&gt;ctx_save_restore_area_size,
+			       topo_dev-&gt;node_props.debug_memory_size,
+			       &amp;total_cwsr_size) ||</pre>
    </blockquote>
    Because&nbsp;<span style="white-space: pre-wrap">properties-&gt;ctx_save_restore_area_size and </span><span style="white-space: pre-wrap">topo_dev-&gt;node_props.debug_memory_size are u32, 
</span><span style="white-space: pre-wrap">total_cwsr_size is u64 now, </span><span style="white-space: pre-wrap">check_add_overflow</span>&nbsp;will never
    overflow to return true, use typecast u64 add instead<br>
    <br>
    <pre wrap="" class="moz-quote-pre">total_cwsr_size = (u64)properties-&gt;ctx_save_restore_area_size + topo_dev-&gt;node_props.debug_memory_size;</pre>
    <blockquote type="cite" cite="mid:20260706191852.2077498-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	    check_mul_overflow(total_cwsr_size,
+			       (u64)NUM_XCC(pdd-&gt;dev-&gt;xcc_mask),</pre>
    </blockquote>
    Since&nbsp;<span style="white-space: pre-wrap">total_cwsr_size is u64,  </span><span style="white-space: pre-wrap">NUM_XCC(pdd-&gt;dev-&gt;xcc_mask) will promote to u64 as well, this u64 typecast is not needed.</span>
    <blockquote type="cite" cite="mid:20260706191852.2077498-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">
+			       &amp;total_cwsr_size)) {
+		err = -EINVAL;
+		goto out_err_unreserve;
+	}
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties-&gt;ctx_save_restore_area_address,
@@ -344,7 +352,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 
 	kfd_queue_buffer_put(&amp;properties-&gt;wptr_bo);
 	kfd_queue_buffer_put(&amp;properties-&gt;rptr_bo);
@@ -355,8 +363,13 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd-&gt;dev-&gt;id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (properties-&gt;ctx_save_restore_area_size +
-			   topo_dev-&gt;node_props.debug_memory_size) * NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
+	if (check_add_overflow(properties-&gt;ctx_save_restore_area_size,
+			       topo_dev-&gt;node_props.debug_memory_size,
+			       &amp;total_cwsr_size) ||
+	    check_mul_overflow(total_cwsr_size,
+			       (u64)NUM_XCC(pdd-&gt;dev-&gt;xcc_mask),
+			       &amp;total_cwsr_size))</pre>
    </blockquote>
    Do the same change as above&nbsp;<span style="white-space: pre-wrap">kfd_queue_acquire_buffers.

Regards,
Philip</span>
    <blockquote type="cite" cite="mid:20260706191852.2077498-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		return -EINVAL;
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties-&gt;ctx_save_restore_area_address, total_cwsr_size);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------bLfSVg0lL0rKnUixjntWjSWD--
