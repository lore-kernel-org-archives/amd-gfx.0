Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25822C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 17:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EAE10E634;
	Wed,  8 Jul 2026 17:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wjGr74H";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDAC10E638
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 17:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brJ91lt3HmJvmsFCYd4fKYpwd2TcEgBv2s1R8zu7ojUjdy5Hz1Q7exWZeRfCth5X/4awBcKVs175Vr7wubijA4B/I822eCW7pzezZyzWpo9/BZHPwmCM98yvxsslV/Jr149UxQ6eaksWFJMy3Xuv3eBeBqiAxYQp5fnEK4yT5j5xjuAPwsgsJa0d8BoAfavwo6JS1UuDcPYgZ/KonUmNB00FtiGFNzaykgk/cRYI68SkTWmaqH/NcclUZ/SsYxx/kVybys72qc065iXo9Sm2d+hEAOoXDnuJqBu7Tz5LRfqBB+q+AInCyUOu2oaREhiuFcYIqe+kHhVwZrPYYokqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxudPvKAsYbrodjCcH2o/D+YUIxKXUptGGS58OS5oZo=;
 b=eAxyDWXK12XbWy/aCUc4IcSRbVP15KjsOXDus5mAT7tt+iw1rAklnVmJ9UZ0Q9QHn89n9npKC2o5AcCHUDiPbVTV0CC8HOnb/gyha2HVmpAjkYr71uerYQy8c6hWJ3Ksx34Fio8BzzJACCxzUHuZNJrvVjM5MQ7EHTpJAbqdGNB0r+OC2jREg0vAMPWQfdL70p+SwN+B6n84dG2aaXdiHEgjnU1zyTs30elJZDHkFqDpnMXDH6XOv0w7OLTtglrEgJUg20sBOFfd3hJY3QGnSgOuwhUzHpb/XikmWbcx8OFhmPsKFmSnUL7UwsgFqgEuXcRpfN6HRARj/c5RQAHSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxudPvKAsYbrodjCcH2o/D+YUIxKXUptGGS58OS5oZo=;
 b=1wjGr74HyqCHlVyQlF/z7wu2hWo4db2ryHNwzhJEYlOECWDlIQiczz5iN6E5BDhTt4CyXjD6cLsJbffACGOC86N4rN8W0JI0Rg1CMFCFUM92rptGnRXFH9xQBh9LOxVOSetb6S3uIEsqQ6SQbuJ3tatxHbqhFh44pHa4d8xftbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SAVPR12MB999145.namprd12.prod.outlook.com (2603:10b6:806:4e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 17:26:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 17:26:06 +0000
Content-Type: multipart/alternative;
 boundary="------------bHQwXXX0ZMnEujikibXSevST"
Message-ID: <191cae83-e11b-4189-9a8b-2b48989736fb@amd.com>
Date: Wed, 8 Jul 2026 13:26:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix 32-bit overflow in CWSR total size
 calculation
To: Yongqiang Sun <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260708164336.4099991-1-Yongqiang.Sun@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260708164336.4099991-1-Yongqiang.Sun@amd.com>
X-ClientProxiedBy: YT4PR01CA0491.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SAVPR12MB999145:EE_
X-MS-Office365-Filtering-Correlation-Id: 799735ec-d958-4695-b238-08dedd15fe11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: fcpZSFFMn4sGwooeWfDXmJCfxee2GVha/kP8O71AxHeN/38GWGrlGZbOJnVLQCgKSRiX0rsxZ//7nRpsFO8ftjCf/wkguvugONQS3YxTBSjKZbWGNmMcRTjeKNJ3yetm5iyGyF/kOnTmeAuuMp/G+RVBscnc76W771K7VZLxAmEcYMxfJCS6hGB+StjLIqdvQooGVqFWy5d3KNYSvOH9cJP6uI9zFdjI6bsqkI/fDGfsZ75Cyj1t0GHKI9r9Z75vLQpPB1eiEjo/RN5Vr1xF51Xqtagrl+rY1mzdL8lDV7TbVwY9SERSkVCTCbBRIm9YWgke7gJrLadsb9afyCls7ew68IteHAMvonk9mrRraGnhJkc8xjoxEZ+XbjtPE2/Q8YANeh0JSBtCPvf5VmPNo2kPs2/p4ymKOkLHa1257oo5B6Cfrx7ZARatc+KjaEoR4Yvh/gegX1Jg1i5JK8r2HJgm/aV30h57TTOOU1IkEpRj8vmiqkQRtMnB8LgCf976zdZ56iCRzjQDs206mH9rM4pqreY5uZ3s9Q2RxS/6ljyGZIOeyG/2o+I+XzSGIa3aoE6X7FuPnzD6reM8M7vxLBLlaqfPesd56d/Zqq64SNgA/J/1Bg/RcRWMc0AGWSzfTmXKsl/+Hp7DL0LJMlrqA4vsQm7OkYAm5c5+Lg1UF8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRoNTJGNXphbjMrd0xuNFdlRG1JUG5wQ3AvZnJKMDhxck5YaDBYWUU1cmhr?=
 =?utf-8?B?bXM3U0RmM3BITmZrbFVKenlpRytGYkc4K1pTMnRkWnAzSnNabzdFY0w3UEd1?=
 =?utf-8?B?SXRjcWxjTHN4aUZKcy9DSlhHNStpMWhJc1NLcWw2NXN0YUpOMVl1WERzVC8z?=
 =?utf-8?B?bmtOVnFnaU1yQ2M4RnU0b1A5RkJlZnBxTlBSQ3ZDdSs5YmJzMlI3OHFaNWZt?=
 =?utf-8?B?UE90R2FrRFVDS2hlS3A4dE9STng1MjFaZDFqdzU3QmN1VnJORUtOeXdTbDlK?=
 =?utf-8?B?NmNvY3QwQkxXaktYaE5KaVEvQTVMSUo4YVhrRjM0WDNsQ2orTnVSUk1TdDYy?=
 =?utf-8?B?WGlzWjAvR2ZpVnhOMi95TmFOSzB1WXZYeGJMVnVYMkJXOWNTVFlUbjcvd2JB?=
 =?utf-8?B?NzhxL0wzeHlMTE5DdkxYUktUTEJpSmhIUkp1ckFqdzIyaUJJRy9CSjFVT3ZR?=
 =?utf-8?B?eDE2bzZQeUZCTDhMSmJ2QmUzc2l3eDZBeDdCbGpKaWQwMGdubk1EVHBjYjl1?=
 =?utf-8?B?NXZNTzA1NzJwSGFZUFJYSXFPblVFUllWZU1kamp2Y2RyYzBzWnZ6MnExQ0pN?=
 =?utf-8?B?QWtXNHlGcmFTeld1RVBFVkJtUUJjcEc1QUl3ZVpCVG5Pa0UrQzk3UHpzUEVn?=
 =?utf-8?B?WEFaSEJXOFRxcmpPZjBtdUI4a1pER3dsR0x0ZHo2VDIrQTFZSmFwNDVZVXNl?=
 =?utf-8?B?OWJRdUcvK0ZCcHZYbmF4VWNzNlltUFNMYjRKQTI4K1UzM1NsSVAraWliYlRK?=
 =?utf-8?B?V0NweDZaNEY4ZG1TcEdsaHZpeHA1cGgza1JjNzRFUVBaZUVJb0tTMmQ0TFl2?=
 =?utf-8?B?VE1uV1FEUFphbkFibEROdWdBUmhxWGY2UXJscXByOVlnMVBuYUw4TTVxRUxR?=
 =?utf-8?B?bDFYVnpTWndySU9LTmdxcEpjSmxNam92a2tlanRmQk12N1E2TlZpNGxEdFMy?=
 =?utf-8?B?ZHZJU2kxeGttWWpTc2hrTzFGbXgvNnBraU05V21DNXRIeG9CMUd3SlVHVVVF?=
 =?utf-8?B?L0k4WHZGeEpBTGdielJVSUgwUk44OFJpYXNHbnh0eFFlaVVMNThwcEc1Qk1H?=
 =?utf-8?B?V2E4elI4OUwrUE9IdXhQZVlXRUxCcmpnZHYzUk5DV0V1M3dwdWpVRVBQYURV?=
 =?utf-8?B?a0NrL3BjVkVBbHptS0RQSTJleVlYMUNyUWVIU3c5QTYyZEZBSHZ4K3ZadURI?=
 =?utf-8?B?NzVuaHEvRjlYUitUV2t0T3VmcUttNkx4SDBuV214V0JkUm1RRlJSOFc2MjF6?=
 =?utf-8?B?TDU2WUpCUFVucWdKd2tUQmZhZnZDcll1UEJEaVE3RnRIdFpRZGdpQ2RRQzRk?=
 =?utf-8?B?SkN2UVhPVTBVdDVHSW9HRWw1SzhDbm9kYXpkcDluaDFheFVsQ1RMUFRFL2Jx?=
 =?utf-8?B?UGR4YjlwZjRrVWR5Y3VoQWNBTkhJY2s1TFU2M01YQWRmenoydzdrRHgwMC9D?=
 =?utf-8?B?R2tiWURLUlZEWkJPU3d3VHo1SFVPOFczbDZ6aXE5ZFdZSHN4SnJWZFBHY2lM?=
 =?utf-8?B?aExoWGNPQlJpUzY5RFlvVE1UQmZmOGFWRkQ5Q2s1dDNtZXZVQjFlUjJNOHFv?=
 =?utf-8?B?UVhsUjd2b05yV0x0RzVvbXdDbEhKam0vWGNGRFhnZkQwczM3Y3VGdmtkRXp2?=
 =?utf-8?B?WTRoajdxQmFzRHNpRVpFT3RwQ2xEYnRvSnBvTm42eTdrSXVveHdKVlRSczdL?=
 =?utf-8?B?N2FlRGdvdEdVcXFlUFBlYkpSSGtRaFJGbzRJWlV5c3UrTnhpZjY1ZXRaeVN6?=
 =?utf-8?B?KzJDaXBWWmN3V29lR3pYS0wrcDJYV04ranRvUEt2eDZFTWlKY0hsanRkRFJt?=
 =?utf-8?B?d3VCWisyTjZpMTZ3WGMrTWJicHkySkVadWUyNmJJZ3lpaTQrYkNqdWtCUHJm?=
 =?utf-8?B?RGI4eEVWeGVab0phTEw2VW56YWxLZlgrMVdrWGhFcmU0N24rWFFaekxiUk5S?=
 =?utf-8?B?YWgvNnJrVjdVSWpJQ0NycHdHZUlhbDl0MjNXVTZVc0pELytCemZJUU5tUENx?=
 =?utf-8?B?Q2kzRDNhWC9lbFowUFJTMi9KTVNrcXJheUUxQXJCOFVBaytLdXJDRVd2TlF6?=
 =?utf-8?B?STNteFZoYVA3Z0NqQkdpNFdsM0xxTnY4TWxxMFc0T1JQdkRzSHZBMDBXMDA0?=
 =?utf-8?B?NE5hdGs5anFOVWJKMEIzZEdyQVBiWnZUdUpyYzlSbmxEVmU0Ty8welZCVzVB?=
 =?utf-8?B?cnZCR3dlM2ZVVFlBMG0wWjV3RUVmaEdsMCthcjFCRm1QMFk4eUpka1hGTXZL?=
 =?utf-8?B?YWVENXhDN05lamVuYXJVckM4ZmxKeVRLLzYzVUFTRTFWdkpYTmZ2amZkd3Nu?=
 =?utf-8?Q?LP0v79taZFMsIxHQuF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799735ec-d958-4695-b238-08dedd15fe11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:26:06.1145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLBSd99AMwe37ARqX2iW6ntNWt4mPW6RjngUr7QpGeQ0bs6QuSH0VY3lLp7wStCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999145
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

--------------bHQwXXX0ZMnEujikibXSevST
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-07-08 12:43, Yongqiang Sun wrote:
> total_cwsr_size was computed in 32-bit before being used as a BO/SVM
> allocation size.
> With large ctx_save_restore_area_size and debug_memory_size
> multiplied by the XCC count, the product can wrap,
> yielding an undersized CWSR save area that firmware later overruns.
>
> Promote total_cwsr_size to u64 and use check_add_overflow()/

Remove check_add_overflow(), with this fixed, this patch is

Reviewed-by: Philip Yang<philip.yang@amd.com>

> check_mul_overflow() in both kfd_queue_acquire_buffers() and
> kfd_queue_release_buffers().
>
> Signed-off-by: Yongqiang Sun<Yongqiang.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 9d4838461168..01e228fc1860 100644
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
> @@ -308,8 +309,14 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   		goto out_err_unreserve;
>   	}
>   
> -	total_cwsr_size = (properties->ctx_save_restore_area_size +
> -			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
> +	total_cwsr_size = (u64)properties->ctx_save_restore_area_size +
> +			  topo_dev->node_props.debug_memory_size;
> +	if (check_mul_overflow(total_cwsr_size,
> +			       NUM_XCC(pdd->dev->xcc_mask),
> +			       &total_cwsr_size)) {
> +		err = -EINVAL;
> +		goto out_err_unreserve;
> +	}
>   	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>   
>   	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
> @@ -344,7 +351,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
>   	struct kfd_topology_device *topo_dev;
> -	u32 total_cwsr_size;
> +	u64 total_cwsr_size;
>   
>   	kfd_queue_buffer_put(&properties->wptr_bo);
>   	kfd_queue_buffer_put(&properties->rptr_bo);
> @@ -355,8 +362,12 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>   	if (!topo_dev)
>   		return -EINVAL;
> -	total_cwsr_size = (properties->ctx_save_restore_area_size +
> -			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
> +	total_cwsr_size = (u64)properties->ctx_save_restore_area_size +
> +			  topo_dev->node_props.debug_memory_size;
> +	if (check_mul_overflow(total_cwsr_size,
> +			       NUM_XCC(pdd->dev->xcc_mask),
> +			       &total_cwsr_size))
> +		return -EINVAL;
>   	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>   
>   	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);

--------------bHQwXXX0ZMnEujikibXSevST
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-07-08 12:43, Yongqiang Sun
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260708164336.4099991-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">total_cwsr_size was computed in 32-bit before being used as a BO/SVM
allocation size.
With large ctx_save_restore_area_size and debug_memory_size
multiplied by the XCC count, the product can wrap,
yielding an undersized CWSR save area that firmware later overruns.</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20260708164336.4099991-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">

Promote total_cwsr_size to u64 and use check_add_overflow()/</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Remove check_add_overflow(), with this fixed, this patch is

Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20260708164336.4099991-1-Yongqiang.Sun@amd.com">
      <pre wrap="" class="moz-quote-pre">
check_mul_overflow() in both kfd_queue_acquire_buffers() and
kfd_queue_release_buffers().

Signed-off-by: Yongqiang Sun <a class="moz-txt-link-rfc2396E" href="mailto:Yongqiang.Sun@amd.com">&lt;Yongqiang.Sun@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..01e228fc1860 100644
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
@@ -308,8 +309,14 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (properties-&gt;ctx_save_restore_area_size +
-			   topo_dev-&gt;node_props.debug_memory_size) * NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
+	total_cwsr_size = (u64)properties-&gt;ctx_save_restore_area_size +
+			  topo_dev-&gt;node_props.debug_memory_size;
+	if (check_mul_overflow(total_cwsr_size,
+			       NUM_XCC(pdd-&gt;dev-&gt;xcc_mask),
+			       &amp;total_cwsr_size)) {
+		err = -EINVAL;
+		goto out_err_unreserve;
+	}
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties-&gt;ctx_save_restore_area_address,
@@ -344,7 +351,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 
 	kfd_queue_buffer_put(&amp;properties-&gt;wptr_bo);
 	kfd_queue_buffer_put(&amp;properties-&gt;rptr_bo);
@@ -355,8 +362,12 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd-&gt;dev-&gt;id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (properties-&gt;ctx_save_restore_area_size +
-			   topo_dev-&gt;node_props.debug_memory_size) * NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
+	total_cwsr_size = (u64)properties-&gt;ctx_save_restore_area_size +
+			  topo_dev-&gt;node_props.debug_memory_size;
+	if (check_mul_overflow(total_cwsr_size,
+			       NUM_XCC(pdd-&gt;dev-&gt;xcc_mask),
+			       &amp;total_cwsr_size))
+		return -EINVAL;
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties-&gt;ctx_save_restore_area_address, total_cwsr_size);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------bHQwXXX0ZMnEujikibXSevST--
