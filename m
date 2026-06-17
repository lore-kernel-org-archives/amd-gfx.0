Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1660CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 16:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718A610EA72;
	Wed, 17 Jun 2026 16:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAbJHggq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CE210EA72
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 16:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5DbMidX2MelmQJaeDFJbAnWfwPKxPJKQRI/iIa/3OZoGfLoWZJRTh5H7SHGNt53/FcmDAYAcGEHHKCmXL8mVyWSJT7V9pt5zIHW5O86FCPYlopc7Oat7Xu7fG/dXfclOZRRecwm1MSTdEnliBc3S3OOSBcHV0a1c1+QZAQvHvRZx7mBHya/pgusDlzkRbq69BkfiYg7zvqtWPvKz5tqxFAEfjcA2WwCV9BeBNk+T+ecz9hcde4YUqHhBNUv8ut+lKR9XbxNT1+sT7YmAHMkU9ShQ2VOtNBkAmdmtk6tFQgEqGBauS4YWSv6xYA6GRSQExtvg/GCXa+oXN5s3IQSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RQlKIrk7KCUyCI7xnKKKB9QYiUvafL7L8+7FtxA7oQ=;
 b=naO66ZOs/y89rz9uY0s7JHV0DH0w4Zg7/dt9NAGsfZfo/5sLzKDFkQDGksnQAWR5E5ST0wIfaBHplAE22yrDESkjr0Wf3k/EytrALyG3ceu/eczoUozSF7zXN8S6S8kNrM5cmg8QG64vI1rTuTv8v7dXZOsbM5Eu/I+air+ELWWB1qbIwhV5qrxBxdg5kzv3bHkPpF5zGyGeAGonU/tDvdo8x6WIZGbbHXdT5L3RKtkmw1rEvnFN/ce+4Z3vLCwjmpXIb5oa50JilgrI9SzQTKl/+uiwtfuwJvPTB1CxeGZDIFJ0RDvsmaojTrQbyeL6w4/RMQGKd6DHq524nG7+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RQlKIrk7KCUyCI7xnKKKB9QYiUvafL7L8+7FtxA7oQ=;
 b=PAbJHggqvvXSHO4C4lzfV1o0t0RgKTiMkrB0z03TeW2uEj/s8zkBNgJYCfdskljTQSP5fw9oAaaJREHd4hhLSNVXdEgH2SloxuhT2+yDnjXd71tFvNrTNFpXPn74GBQKECcPwK8yd4wG2NR1GpB0syODJcpAezyN00iAbhasJeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:15:26 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 16:15:26 +0000
Content-Type: multipart/alternative;
 boundary="------------O4cYkWt0ugIO3Lz3Av5N6fGv"
Message-ID: <a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com>
Date: Wed, 17 Jun 2026 11:15:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Unmap svm range when all GPUs set to
 no-access
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-2-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260616211652.1962285-2-Philip.Yang@amd.com>
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: e8df5bb7-09b8-4476-ae96-08decc8ba43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|8096899003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 28PHb7ZNwX5yES90kfz+U0tlUD8hzPVdqnQW6nTY788xdSdTwxVIbe5GdM46/eSZ1kZ/QOgx+w7JU9hUR+9+532aLU7Qxb7AWefI5DMeFgZxg9K7dE8bxoIdvTJ62l4mWycaqWtt5ugMYneWFsdLS3IjJl4uOqDTJ5D+N2QrvaHKAKUphQS9b0QOBXVh4WYv8yjX/5wDO5SyUbjx+CTeIoB+U5SN42KMCsTI9TDL/veU9VxcfSS401RXQU/kRenU1cTFOU+jt/vmdBaPz2fsmE7XmgZy+ZoOIMgY2x2/nI9axD6HsuZgdCuxVH+7LMzZMKjSgZS8gb+1zxqcb6w7gaQehZ3/zMk10P4Cdn7mi3/qqXZwoGV4lfd9fEiIPmtLosmUglyHk6s4NLC/Zf7oBgMYU628lSrIdxRgHOr25pNjk/yLmBjOdAjTTHo1N3vM/QtGxrXk7H3Gcf30xm8F9CBJ09AJZQQWUcZv4kQtMJ2eMzeZXoN28EfoxxfX8c065jmWhw2SucErJOfebtlzFVoU7MGZZxvy6sPf4pbE5WBPDi0rm4vOMQ741+SgHLH2GwS/nNKzLPphMl+IxLEe90xfkbFuDlrNSwdxYNv0isZdDPAus3/OVK8MCuK+bJnEZbuosqDdWteIePCA6AarxJ+cokFuMnYBkENAe2l2cmqXVcBbJFPsi5vDdrYibx73
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(8096899003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdnaUJINmdDZUIzSVNxSTM4L09aV09nYjdnb01OV0puTzZtc3lQMFR0ekdP?=
 =?utf-8?B?YVZTL1U5YTVUWG5UN0wvM1J4ZHg3TnNSYXlXMUpKakI3SVNWQXBmWkpEaG9W?=
 =?utf-8?B?dXJ2Ryt2OEtmUmFsREhtUDMzRXN3cEhOeXZMK2lGQVova1pHWHd2NVNQMTBa?=
 =?utf-8?B?UUlYeU1rOWQ3ejdpNWdEVzlaaDcwenlxWExBYzNFN1BqWTR0bGdJcnJzUkY1?=
 =?utf-8?B?WW80WGZGbWIzOE1iM0ltNHp1Y3hnRzh4bVZCY1V5WUswRkE0bGtUZWM1Wmx2?=
 =?utf-8?B?R2hKc2ZmRVlKTDJoOWwwVGxNcVRJWTUxMVlVSWVsak9OVzVjTUZDNXRIOHUv?=
 =?utf-8?B?QjNqbzd2YnduTVR3Ny9PamlJZWRqZ1lSM3FlanVpRjd4aGVMZ2d5R0xvM1Bw?=
 =?utf-8?B?amkzeCtBMmJsbm1EaEd1OUMyUGE5dDgzcmtiQkVtZ042eExGd1RXaUFKNlZT?=
 =?utf-8?B?QThMSVMyVmlwS1BxcXZHM2MrbW4rN05JVU9jWGZLeUw5UUNhc0Z2MEkxYkhV?=
 =?utf-8?B?eEhyMEVOL2ZRYkl0Qk54MHlLeG8vQ1oxaU41OEFCaUtlNXI2VmpjZWVTQUNF?=
 =?utf-8?B?OHFiWXk4b2N3OHZnWVA0K0VoZkltUkhuc0UvYndyakNWU29FWTh4TW82WFJB?=
 =?utf-8?B?UGRSV1V4Q2RDbEpuUXpUVzV2eXBSTy95bW1NZDg4eStpZVluUGdhbTZmb2RP?=
 =?utf-8?B?RjN5UHJCbkNndmszQWt4WFJ3K3lwWnV5aGx0VXkvcjJiRDduWWNBY1NtZW80?=
 =?utf-8?B?cFJBRjdLWmZxd2pOb1lKVTUrbytXVGh6Y1QrREprRk5yU0g0T2VOSmJWR2RT?=
 =?utf-8?B?ZDRCT09qNFNucTVoQW1PdTlhSUN3a0dxbFM2SU9YMlBtb3AwTFJ5YzhZVGEr?=
 =?utf-8?B?WDZTNEhiUnJ5cWVaMkJsTlNoZTRXSmNYVkVCaTZTWnNLMWduK3RCcFkrWVRi?=
 =?utf-8?B?RkI1UFc1VDdjbXNFNXg5VmR5UGl0a05zRVZGZkVQa1Z5ZTVUNUZvMnpjdS9T?=
 =?utf-8?B?a0hOdGZXc0ZFd2lUUEtkTEZxR0Fza2V2c2UwL29OcUJ2RXlLMkpQazZUUW9j?=
 =?utf-8?B?NUtrQUtPdG1MZDlpU0xXaDVYM2RGeHJxaGl4bVJCM09vcS9vS3BKMHZhTjNz?=
 =?utf-8?B?RlB6a1pLRU4xcnhLR1ZMeEtnOERoTXZHaTJWRmdJeFhsUWFyUjdtNEpxaFpv?=
 =?utf-8?B?VDBjWG81ZVQxOURKbDRJbElycWY5dDNzUWNFVExSQVY1YkZ2NG0yODVkcjBG?=
 =?utf-8?B?cW5yM1JkWm5lRDhZMCtRK1lDT1NLRE52YWMycEsrbXZ3L2tQeUtJT2JtcmpS?=
 =?utf-8?B?eUYrTkNGcUV2NmhYQXpQeGoxN0txYmt1TTE2VjdBb3o5UllLRy95ejdDWWtR?=
 =?utf-8?B?bXhzVHlxOGpyTUNVVE5XOFF3TWdLWHlzMUdlZnVsMnYya1prVmNwQVhlMmlH?=
 =?utf-8?B?QldCMERRR2F2d2Nwa2xzWWNDQy9Nb0dGMjA0a3dlU0ExY0FCcVBHL3FNNlZT?=
 =?utf-8?B?RkR2M1dwaWYvdDRPYXFYREVtVFJVZ2Fna09naGhPREczdytLWTJFb0Zjd1ZY?=
 =?utf-8?B?dHJ0Nm1McWpCRWxOc0xjMDlkZzUrcDNrOWxLWHpyeU44cjV4NUNML1ZvaUtt?=
 =?utf-8?B?WkVlNCtwVUNSVjNMRG9DNVR4U2k1QlE1T3kvVmNjVWUzRVErTlFPbG5QT3Jh?=
 =?utf-8?B?REZiWExTRUNIb3VTK2hRay8wYWVqN0lZQ3JpejQ5TC9HbDNuNGFjampBakYr?=
 =?utf-8?B?SEtKeTNkUEt1bEZweVlvRnlRNlp4LzVERDRiUFlWck1lNVM3V3g5dUtvMnpj?=
 =?utf-8?B?QkxpNGpJT1V6U1JBQUtxOWt1OVlaV2p0Qkk3bEg1MS9VVzZ3bWRMVGltbUdN?=
 =?utf-8?B?RlRCZklaMkwvWlN4cVc3ZlpYak51TTFvZDBKKzAzd2F5bXRMZ2lVWVM0dmE2?=
 =?utf-8?B?RmE5R01ldTJMSXBmRDNSaDBMcktKWU13dXZma2tvQ3lVR3lta042VyswTnps?=
 =?utf-8?B?Mm1lNXhCQ2J1WWNWMTVpaHFhalhEZVhCNlordTZxc28rTmRCeGRhNTJCaHZH?=
 =?utf-8?B?L2V0eFNNUmZaYUF6eXg2T0ltbkI0dGE2N0tSMWJ3Rld5TlpCSTZjKzlkWHgw?=
 =?utf-8?B?Z1Z5MysxTnJnT0R2aHMydzJNSXVYYjlhU2ViM1JrMDJzY0xMYmtyVjhkVWVF?=
 =?utf-8?B?NUludGZzb1Y0RDRTUGpZSmNxcENTQTBTWjV3N3dIQlJpL1N0L0hNWUw0SGd1?=
 =?utf-8?B?QTJsaDZwMExQK3JoOFZUYzBTSXJraWpLaHgvcTE5WVBsRGZmZWZnR2U3ZkYw?=
 =?utf-8?Q?noWgqqurMCDkeTnGqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8df5bb7-09b8-4476-ae96-08decc8ba43d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:15:26.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4UBT3NyythY4DBA2h9ldK1JyLet+AasSNNkPhtLVRM+FBBBbBSSkt5GT15zJWnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
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

--------------O4cYkWt0ugIO3Lz3Av5N6fGv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/16/2026 4:16 PM, Philip Yang wrote:
> When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
> SVM range mapped, unmap the range so the MMU notifier can skip queue
> eviction — safe because no GPU will access it.

KFD_IOCTL_SVM_ATTR_NO_ACCESS means shadder will not access this prange 
on a gpu. It does not mean driver needs unmap this prange.

At MMU notifier stop queue or not should be decided by affected prange's 
access attributions:

KFD_IOCTL_SVM_ATTR_ACCESS,
KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,
KFD_IOCTL_SVM_ATTR_NO_ACCESS,

or

bitmap_access/bitmap_aip.

Current kfd uses mapping info to decide evict queue at MMU notifier. I 
think it is not right. Should use prange access attributions that are 
from user to decide whether stop queue on this gpu. If user has 
specified KFD_IOCTL_SVM_ATTR_NO_ACCESS on this prange and this gpu 
driver does not need stop queue on this gpu at  MMU notifier.

This patch seems introducing unnecessary complications if the goal is to 
not stop queue at MMU notifier when KFD_IOCTL_SVM_ATTR_NO_ACCESS has 
been specified by user. Driver should use prange access attributions to 
decide queue eviction at MMU notifier.

And access attributions can be dynamically changed. User component can 
change a prange from no_access to access(or access to no_access) at 
runtime, then driver has to remap the prange if it had been unmapped 
during no_access. In other words mapping is not exact equivalent to 
accessing.

Regards

Xiaogang


>
> Replace the mapped_to_gpu boolean with bitmap_mapped to track which
> GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
> and clear them in svm_range_unmap_from_gpus(). This is separate from
> bitmap_access/bitmap_aip which track user-requested attributes and must
> not be used to determine mapping state.
>
> Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
> Add svm_range_needs_unmap() to trigger the unmap once bitmap_needs_unmap
> equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.
>
> v4:
>   - Rename and set prange->mapping_done to false if validate and map not
>     complete successfully (Felix)
> v3:
>   - Correct error handling, support app retry update mapping (Felix)
> v2:
>   - Add bitmap_mapped to not break get_attr (Felix)
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 ++++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>   3 files changed, 73 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 9d4838461168..5d55407069a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
>   		if (!prange)
>   			break;
>   
> -		if (!prange->mapped_to_gpu)
> -			break;
> -
>   		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
>   		if (r < 0)
>   			break;
> +		if (!test_bit(gpuidx, prange->bitmap_mapped))
> +			break;
>   		if (!test_bit(gpuidx, prange->bitmap_access) &&
>   		    !test_bit(gpuidx, prange->bitmap_aip))
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index df7fca65e9a2..e039b6f2942f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>   				bitmap_clear(prange->bitmap_access, gpuidx, 1);
>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
> +				bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>   			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
>   				bitmap_set(prange->bitmap_access, gpuidx, 1);
>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
> @@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
> +	new->mapping_done = old->mapping_done;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return 0;
> @@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> -			  unsigned long last, uint32_t trigger)
> +			  unsigned long last, unsigned long *bitmap_unmap,
> +			  uint32_t trigger)
>   {
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *fence = NULL;
> @@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   	uint32_t gpuidx;
>   	int r = 0;
>   
> -	if (!prange->mapped_to_gpu) {
> -		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> -			 prange, prange->start, prange->last);
> -		return 0;
> -	}
> -
> -	if (prange->start == start && prange->last == last) {
> -		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> -		prange->mapped_to_gpu = false;
> -	}
> -
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   
> -	for_each_or_bit(gpuidx, prange->bitmap_access, prange->bitmap_aip, MAX_GPU_INSTANCE) {
> -		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
> +	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
> +		if (prange->start == start && prange->last == last) {
> +			pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n",
> +				 prange->svms, prange, gpuidx);
> +			clear_bit(gpuidx, prange->bitmap_mapped);
> +		}
> +
>   		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>   		if (!pdd) {
>   			pr_debug("failed to find device idx %d\n", gpuidx);
> @@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   			continue;
>   		}
>   
> +		set_bit(gpuidx, prange->bitmap_mapped);
> +
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
>   					 bo_adev, wait ? &fence : NULL,
> @@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>   		bitmap_set(ctx->bitmap, gpuidx, 1);
>   	} else if (ctx->process->xnack_enabled) {
> -		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +		/* Update mapping on already mapped or access in place GPU */
> +		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
>   
>   		/* If prefetch range to GPU, or GPU retry fault migrate range to
>   		 * GPU, which has ACCESS attribute to the range, create mapping
> @@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		/*
> -		 * If prange is already mapped or with always mapped flag,
> -		 * update mapping on GPUs with ACCESS attribute
> +		 * If prange with always mapped flag, update mapping on GPUs with
> +		 * ACCESS attribute
>   		 */
> -		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> -			if (prange->mapped_to_gpu ||
> -			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> -				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -		}
> +		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
> +				  MAX_GPU_INSTANCE);
>   	} else {
>   		bitmap_or(ctx->bitmap, prange->bitmap_access,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
> @@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				e = min(end, prange->last);
>   				if (e >= s)
>   					r = svm_range_unmap_from_gpus(prange, s, e,
> +						       prange->bitmap_mapped,
>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>   				svm_range_unlock(prange);
>   				/* If unmap returns non-zero, we'll bail on the next for loop
> @@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		if (!r && next == end)
> -			prange->mapped_to_gpu = true;
> +			prange->mapping_done = true;
> +		else
> +			prange->mapping_done = false;
>   
>   		svm_range_unlock(prange);
>   
> @@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	if (!p->xnack_enabled ||
>   	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>   		int evicted_ranges;
> -		bool mapped = prange->mapped_to_gpu;
> +		bool mapped = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>   
>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
> -			if (!pchild->mapped_to_gpu)
> +			if (bitmap_empty(pchild->bitmap_mapped, MAX_GPU_INSTANCE))
>   				continue;
>   			mapped = true;
>   			mutex_lock_nested(&pchild->lock, 1);
> @@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			s = max(start, pchild->start);
>   			l = min(last, pchild->last);
>   			if (l >= s)
> -				svm_range_unmap_from_gpus(pchild, s, l, trigger);
> +				svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped,
> +							  trigger);
>   			mutex_unlock(&pchild->lock);
>   		}
>   		s = max(start, prange->start);
>   		l = min(last, prange->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(prange, s, l, trigger);
> +			svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>   	}
>   
>   	return r;
> @@ -2112,10 +2115,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
> +	new->mapping_done = old->mapping_done;
>   	new->vram_pages = old->vram_pages;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return new;
> @@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next_start = min(node->last, last) + 1;
>   
>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -		    prange->mapped_to_gpu) {
> +		    prange->mapping_done) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   		s = max(start, pchild->start);
>   		l = min(last, pchild->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(pchild, s, l, trigger);
> +			svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped, trigger);
>   		svm_range_unmap_split(prange, pchild, start, last);
>   		mutex_unlock(&pchild->lock);
>   	}
>   	s = max(start, prange->start);
>   	l = min(last, prange->last);
>   	if (l >= s)
> -		svm_range_unmap_from_gpus(prange, s, l, trigger);
> +		svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>   	svm_range_unmap_split(prange, prange, start, last);
>   
>   	if (unmap_parent)
> @@ -3706,6 +3710,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	svm_range_bo_unref(svm_bo);
>   }
>   
> +static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
> +{
> +	if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
> +		return false;
> +
> +	pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
> +		 prange, prange->start, prange->last);
> +
> +	svm_range_unmap_from_gpus(prange, prange->start,
> +				  prange->last, prange->bitmap_needs_unmap,
> +				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +
> +	bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
> +
> +	return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
> +}
> +
>   static int
>   svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		   uint64_t start, uint64_t size, uint32_t nattr,
> @@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		svm_range_add_to_svms(prange);
>   		svm_range_add_notifier_locked(mm, prange);
>   	}
> -	list_for_each_entry(prange, &update_list, update_list) {
> +
> +	list_for_each_entry(prange, &update_list, update_list)
>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
> -		/* TODO: unmap ranges from GPU that lost access */
> -	}
> +
>   	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>   
>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
> @@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	list_for_each_entry(prange, &update_list, update_list) {
>   		bool migrated;
>   
> +		if (svm_range_needs_unmap(p, prange))
> +			continue;
> +
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_trigger_migration(mm, prange, &migrated);
> @@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   		if (migrated && (!p->xnack_enabled ||
>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -		    prange->mapped_to_gpu) {
> +		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
>   			pr_debug("restore_work will update mappings of GPUs\n");
>   			mutex_unlock(&prange->migrate_mutex);
>   			continue;
> @@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> -		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +		flush_tlb = !migrated && update_mapping &&
> +			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>   
>   		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
>   					       MAX_GPU_INSTANCE, true, true, flush_tlb);
> @@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	}
>   
>   	list_for_each_entry(prange, &remap_list, update_list) {
> +		flush_tlb = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
> +
>   		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>   			 prange, prange->start, prange->last);
>   		mutex_lock(&prange->migrate_mutex);
>   		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
> -					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
> +					       MAX_GPU_INSTANCE, true, true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d on remap svm range\n", r);
>   		mutex_unlock(&prange->migrate_mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index a63dfc95b602..0da635532aff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -100,6 +100,9 @@ struct svm_work_list_item {
>    * @child_list: list header for split ranges which are not added to svms yet
>    * @bitmap_access: index bitmap of GPUs which can access the range
>    * @bitmap_aip: index bitmap of GPUs which can access the range in place
> + * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
> + * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
> + * @mapping_done: true if range_validate_and_map complete successfully
>    *
>    * Data structure for virtual memory range shared by CPU and GPUs, it can be
>    * allocated from system memory ram or device vram, and migrate from ram to vram
> @@ -135,7 +138,9 @@ struct svm_range {
>   	struct list_head		child_list;
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -	bool				mapped_to_gpu;
> +	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
> +	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
> +	bool				mapping_done;
>   	atomic_t			queue_refcount;
>   };
>   
--------------O4cYkWt0ugIO3Lz3Av5N6fGv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/16/2026 4:16 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260616211652.1962285-2-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
SVM range mapped, unmap the range so the MMU notifier can skip queue
eviction — safe because no GPU will access it.</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_NO_ACCESS </span>means
      shadder will not access this prange on a gpu. It does not mean
      driver needs unmap this prange.</p>
    <p>At MMU notifier stop queue or not should be decided by affected
      prange's access attributions:&nbsp;</p>
    <p>KFD_IOCTL_SVM_ATTR_ACCESS,<br>
      KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,<br>
      KFD_IOCTL_SVM_ATTR_NO_ACCESS,</p>
    <p>or&nbsp;</p>
    <p>bitmap_access/bitmap_aip.</p>
    <p>Current kfd uses mapping info to decide evict queue at MMU
      notifier. I think it is not right. Should use prange access
      attributions that are from user to decide whether stop queue on
      this gpu. If user has specified&nbsp;KFD_IOCTL_SVM_ATTR_NO_ACCESS on
      this prange and this gpu driver does not need stop queue on this
      gpu at&nbsp; MMU notifier.</p>
    <p>This patch seems introducing unnecessary complications if the
      goal is to not stop queue at MMU notifier when&nbsp;<span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_NO_ACCESS has been specified by user. Driver should use prange access attributions to decide queue eviction at MMU notifier. </span></p>
    <p><span style="white-space: pre-wrap">And access attributions can be dynamically changed. User component can change a prange from no_access to access(or access to no_access) at runtime, then driver has to remap the prange if it had been unmapped during no_access. In other words mapping is not exact equivalent to accessing. </span></p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260616211652.1962285-2-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">

Replace the mapped_to_gpu boolean with bitmap_mapped to track which
GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
and clear them in svm_range_unmap_from_gpus(). This is separate from
bitmap_access/bitmap_aip which track user-requested attributes and must
not be used to determine mapping state.

Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
Add svm_range_needs_unmap() to trigger the unmap once bitmap_needs_unmap
equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.

v4:
 - Rename and set prange-&gt;mapping_done to false if validate and map not
   complete successfully (Felix)
v3:
 - Correct error handling, support app retry update mapping (Felix)
v2:
 - Add bitmap_mapped to not break get_attr (Felix)

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 3 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..5d55407069a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
 		if (!prange)
 			break;
 
-		if (!prange-&gt;mapped_to_gpu)
-			break;
-
 		r = kfd_process_gpuid_from_node(p, pdd-&gt;dev, &amp;gpuid, &amp;gpuidx);
 		if (r &lt; 0)
 			break;
+		if (!test_bit(gpuidx, prange-&gt;bitmap_mapped))
+			break;
 		if (!test_bit(gpuidx, prange-&gt;bitmap_access) &amp;&amp;
 		    !test_bit(gpuidx, prange-&gt;bitmap_aip))
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index df7fca65e9a2..e039b6f2942f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
 				bitmap_clear(prange-&gt;bitmap_access, gpuidx, 1);
 				bitmap_clear(prange-&gt;bitmap_aip, gpuidx, 1);
+				bitmap_set(prange-&gt;bitmap_needs_unmap, gpuidx, 1);
 			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
 				bitmap_set(prange-&gt;bitmap_access, gpuidx, 1);
 				bitmap_clear(prange-&gt;bitmap_aip, gpuidx, 1);
@@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;mapping_done = old-&gt;mapping_done;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new-&gt;bitmap_mapped, old-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&amp;new-&gt;queue_refcount, atomic_read(&amp;old-&gt;queue_refcount));
 
 	return 0;
@@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last, uint32_t trigger)
+			  unsigned long last, unsigned long *bitmap_unmap,
+			  uint32_t trigger)
 {
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
@@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange-&gt;mapped_to_gpu) {
-		pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last);
-		return 0;
-	}
-
-	if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
-		pr_debug(&quot;unmap svms 0x%p prange 0x%p\n&quot;, prange-&gt;svms, prange);
-		prange-&gt;mapped_to_gpu = false;
-	}
-
 	p = container_of(prange-&gt;svms, struct kfd_process, svms);
 
-	for_each_or_bit(gpuidx, prange-&gt;bitmap_access, prange-&gt;bitmap_aip, MAX_GPU_INSTANCE) {
-		pr_debug(&quot;unmap from gpu idx 0x%x\n&quot;, gpuidx);
+	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
+		if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
+			pr_debug(&quot;unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n&quot;,
+				 prange-&gt;svms, prange, gpuidx);
+			clear_bit(gpuidx, prange-&gt;bitmap_mapped);
+		}
+
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug(&quot;failed to find device idx %d\n&quot;, gpuidx);
@@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		set_bit(gpuidx, prange-&gt;bitmap_mapped);
+
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange-&gt;dma_addr[gpuidx],
 					 bo_adev, wait ? &amp;fence : NULL,
@@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bitmap_zero(ctx-&gt;bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx-&gt;bitmap, gpuidx, 1);
 	} else if (ctx-&gt;process-&gt;xnack_enabled) {
-		bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+		/* Update mapping on already mapped or access in place GPU */
+		bitmap_or(ctx-&gt;bitmap, prange-&gt;bitmap_mapped, prange-&gt;bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
@@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		/*
-		 * If prange is already mapped or with always mapped flag,
-		 * update mapping on GPUs with ACCESS attribute
+		 * If prange with always mapped flag, update mapping on GPUs with
+		 * ACCESS attribute
 		 */
-		if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
-			if (prange-&gt;mapped_to_gpu ||
-			    prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-				bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
-		}
+		if (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			bitmap_or(ctx-&gt;bitmap, ctx-&gt;bitmap, prange-&gt;bitmap_access,
+				  MAX_GPU_INSTANCE);
 	} else {
 		bitmap_or(ctx-&gt;bitmap, prange-&gt;bitmap_access,
 			  prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
@@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				e = min(end, prange-&gt;last);
 				if (e &gt;= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
+						       prange-&gt;bitmap_mapped,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
@@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r &amp;&amp; next == end)
-			prange-&gt;mapped_to_gpu = true;
+			prange-&gt;mapping_done = true;
+		else
+			prange-&gt;mapping_done = false;
 
 		svm_range_unlock(prange);
 
@@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p-&gt;xnack_enabled ||
 	    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange-&gt;mapped_to_gpu;
+		bool mapped = !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
-			if (!pchild-&gt;mapped_to_gpu)
+			if (bitmap_empty(pchild-&gt;bitmap_mapped, MAX_GPU_INSTANCE))
 				continue;
 			mapped = true;
 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
@@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			s = max(start, pchild-&gt;start);
 			l = min(last, pchild-&gt;last);
 			if (l &gt;= s)
-				svm_range_unmap_from_gpus(pchild, s, l, trigger);
+				svm_range_unmap_from_gpus(pchild, s, l, prange-&gt;bitmap_mapped,
+							  trigger);
 			mutex_unlock(&amp;pchild-&gt;lock);
 		}
 		s = max(start, prange-&gt;start);
 		l = min(last, prange-&gt;last);
 		if (l &gt;= s)
-			svm_range_unmap_from_gpus(prange, s, l, trigger);
+			svm_range_unmap_from_gpus(prange, s, l, prange-&gt;bitmap_mapped, trigger);
 	}
 
 	return r;
@@ -2112,10 +2115,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;mapping_done = old-&gt;mapping_done;
 	new-&gt;vram_pages = old-&gt;vram_pages;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new-&gt;bitmap_mapped, old-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&amp;new-&gt;queue_refcount, atomic_read(&amp;old-&gt;queue_refcount));
 
 	return new;
@@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node-&gt;last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    prange-&gt;mapping_done) {
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		s = max(start, pchild-&gt;start);
 		l = min(last, pchild-&gt;last);
 		if (l &gt;= s)
-			svm_range_unmap_from_gpus(pchild, s, l, trigger);
+			svm_range_unmap_from_gpus(pchild, s, l, prange-&gt;bitmap_mapped, trigger);
 		svm_range_unmap_split(prange, pchild, start, last);
 		mutex_unlock(&amp;pchild-&gt;lock);
 	}
 	s = max(start, prange-&gt;start);
 	l = min(last, prange-&gt;last);
 	if (l &gt;= s)
-		svm_range_unmap_from_gpus(prange, s, l, trigger);
+		svm_range_unmap_from_gpus(prange, s, l, prange-&gt;bitmap_mapped, trigger);
 	svm_range_unmap_split(prange, prange, start, last);
 
 	if (unmap_parent)
@@ -3706,6 +3710,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	svm_range_bo_unref(svm_bo);
 }
 
+static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
+{
+	if (bitmap_empty(prange-&gt;bitmap_needs_unmap, MAX_GPU_INSTANCE))
+		return false;
+
+	pr_debug(&quot;prange 0x%p no access set for [0x%lx 0x%lx]\n&quot;,
+		 prange, prange-&gt;start, prange-&gt;last);
+
+	svm_range_unmap_from_gpus(prange, prange-&gt;start,
+				  prange-&gt;last, prange-&gt;bitmap_needs_unmap,
+				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+
+	bitmap_clear(prange-&gt;bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
+
+	return bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
+}
+
 static int
 svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		   uint64_t start, uint64_t size, uint32_t nattr,
@@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
 	}
-	list_for_each_entry(prange, &amp;update_list, update_list) {
+
+	list_for_each_entry(prange, &amp;update_list, update_list)
 		svm_range_apply_attrs(p, prange, nattr, attrs, &amp;update_mapping);
-		/* TODO: unmap ranges from GPU that lost access */
-	}
+
 	update_mapping |= !p-&gt;xnack_enabled &amp;&amp; !list_empty(&amp;remap_list);
 
 	list_for_each_entry_safe(prange, next, &amp;remove_list, update_list) {
@@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry(prange, &amp;update_list, update_list) {
 		bool migrated;
 
+		if (svm_range_needs_unmap(p, prange))
+			continue;
+
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 
 		r = svm_range_trigger_migration(mm, prange, &amp;migrated);
@@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated &amp;&amp; (!p-&gt;xnack_enabled ||
 		    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE)) {
 			pr_debug(&quot;restore_work will update mappings of GPUs\n&quot;);
 			mutex_unlock(&amp;prange-&gt;migrate_mutex);
 			continue;
@@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
+		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp;
+			    !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 
 		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
@@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 
 	list_for_each_entry(prange, &amp;remap_list, update_list) {
+		flush_tlb = !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
+
 		pr_debug(&quot;Remapping prange 0x%p [0x%lx 0x%lx]\n&quot;,
 			 prange, prange-&gt;start, prange-&gt;last);
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 		r = svm_range_validate_and_map(mm,  prange-&gt;start, prange-&gt;last, prange,
-					       MAX_GPU_INSTANCE, true, true, prange-&gt;mapped_to_gpu);
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a63dfc95b602..0da635532aff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -100,6 +100,9 @@ struct svm_work_list_item {
  * @child_list: list header for split ranges which are not added to svms yet
  * @bitmap_access: index bitmap of GPUs which can access the range
  * @bitmap_aip: index bitmap of GPUs which can access the range in place
+ * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
+ * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
+ * @mapping_done: true if range_validate_and_map complete successfully
  *
  * Data structure for virtual memory range shared by CPU and GPUs, it can be
  * allocated from system memory ram or device vram, and migrate from ram to vram
@@ -135,7 +138,9 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
+	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
+	bool				mapping_done;
 	atomic_t			queue_refcount;
 };
 
</pre>
    </blockquote>
  </body>
</html>

--------------O4cYkWt0ugIO3Lz3Av5N6fGv--
