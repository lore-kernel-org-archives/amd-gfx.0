Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B7DC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 20:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F19910F86F;
	Mon, 18 Mar 2024 20:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mM9Lxv1E";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF8E10F86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 20:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4TUeh7dusoHMWHrOCiY4YM2qpvVlWhXGU7+mZn9JQuE4VryDAH0+y3Llgo0NfR28UD5wnTiz09TOArXY3l+AGYMEjy44ZyzleHhIbcomtcsaubkLD6MyLzekcv5EhlntZsg+n4c5aZXcnyqpFNSXbdbP2hs7zy8hpL22C3VoPxjkn5x2r6kyQCw+0+9KaGqZs9tp7G985cgmJhF27wJeoxBGgwS0TwfRAXhPUKMi1ZVdLxDRv88FeXxgAiQSZxHJLxjMK07MkCOU1UI2tX4ZglXVOgXHzNKFsNhpCX4MzQCFISIkDf+F0u4CKshqc79mMSKO3e1acF4b9zZy8L9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7KI+7p0pjSuzTHDeQgV/HzcUBQusK0bLvLT+cmsTeY=;
 b=ZiWPocDUQxxYsyTKxADz/Ub6te4u/jajtinazdHUihgY9Dj2CtQz3JkcYBkUP27XRAjX4GOZUKWBXp0aJsZ3ubR9WXQoK5yCNVFdqRQ5bIYzSgynlJRXi987x605siohJZfGqxojkjiHWS9+Pns/7LLy5zRWAEY1chp0dRpcdH/HE4Z1CqkMVfJK49bgOlbtYp/FsCFGK0C6uuvzQu+nWJIJVGdZFyE9lvnjCgFpbB8FSk3u7i0wYM6VCQ0TIdZ4pGbqrry8VuAmhm/Rx0DvJBo3q8FZxlELkzKGcmHPiQjoczLl1uDM5YQo4PS+VtL3v0sNJhT0JWYqGs7F6MHsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7KI+7p0pjSuzTHDeQgV/HzcUBQusK0bLvLT+cmsTeY=;
 b=mM9Lxv1EgyikxcF4kWMLYZ4zfNbEUJF4ALg8xYAZFlxUjAbwFQQFN7QDUIirEbjHasuL7CMBFCctJjaTlZuXPmlbA+w9vPqszQ8u8YPiPSLn8ungnMPK/gJIN7uMmjyTrIyZTZKBdi0tjRSpyk/p8nkEMmU3roH9xNvsbZDPy8c=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 20:12:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:12:41 +0000
Message-ID: <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
Date: Mon, 18 Mar 2024 16:12:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240315181756.685335-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240315181756.685335-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV3PR12MB9438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxX25LaHXUQmGPlQTMGPQnDRkEjDA/H0gHwQ85DdIPSI86yiRUqS3XZTiKvZ90/9sHtET3LEfIXvOiaDpaRVXzXwVQtLMfU7qD1JX2kADq8ZOxZ7Ml9cGPcHio9NAnTfqT8c1EWOX9oJp6vaUxXRfl48zLB0slhODzrHZIhsN88UV9VYn4jg/mTpfBIdc5K5CSJKjwv0XCJxCUSYpeNhYwc6+ajPkWe7TsBEG8jh3/gta5ShsYOGBBCkiMeAo3mes/XzBxu6wc2xgsQk+HC+S84T63xxmSRN5ZW51h/HwRLesJUb6mKLalstTq7qfX+gnya2/XsVup7ig07c9ajzZp9yR3B0vwntUgi3YJ6YQzg8LFkMrtDBazey3fjdNmpm70Yru0hKXBjO+5y3dAOfMeeVYsHgqex+tx5+rNBMgQlYJvm3xvlY6bJPFRU5kIPvBId1DSxis+WYwDS9xT+Aw8mRsA1PLhf8qDNzVsTG2ELNwrCu+PdT749qNzxraFenb1gJde1cIJWF4tg+3BAMrQeexIP9XifABbSXrgGxVyWQ5vbzDiDkHDG8j+TBL3Vo0jdi4IYG98UrgAe/J/vCVFu4u3o8z2YLwENs3YFsGliKSAt6jEpBSu3BLbJsP0dLyy7Y4ebtwfKX3OQLJG8ULlIF3suoGEp4aK/Q4OceJTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNxbjNjU25KcUVHeERsQ2Z0QjRsL3Bua0FVaXFjTlRKaVZzU2ZCamN4TGhq?=
 =?utf-8?B?NjZOUFJvUmp5WE1uOUJRRGdaSXhZTmJYSTNmaG94V29TUUpTaVpuMW9YZ0U1?=
 =?utf-8?B?MHB4NnpUcHJDWXFpT09vTm11TEhmL2hqTVF2SFhEUGhnWnB2VStpLzNRalVD?=
 =?utf-8?B?QzZoNXplUVE2a1ZjZldsa0FJeFMvSmhLd2tDOTVKaDJoTUM4OU1YbS96OWRj?=
 =?utf-8?B?bkRCYllodVQzZXNtdEIrUkxBOEc4ODV4ZzRWY3o5OU0vTTllOEpQeU1pNXda?=
 =?utf-8?B?L3RMd084ZFlOR09HdWR2bXU0QzFBN3dRekh2TU4xWkQ5ZzYwMlk3Q1lFOFhn?=
 =?utf-8?B?dUZuUStqS3ZQWnh0aVFzYlY0dmsrRHZEanU1QWdHbnhlekNnd1BtaHE1Ykpx?=
 =?utf-8?B?ZGsyNU10Z1FLU25GRlJCb0hZbFBUVGU2V1dqd1NUbVBZSXBpRWRRV1FJbkFH?=
 =?utf-8?B?RzBQWUF2cGlJcVpRUzk5RmJEN29zS2dFK3k4VjN4Y3hVaXBTbnhIcFNqZGp5?=
 =?utf-8?B?WHNhMHdCQ3RxaHJvWmVHQk1SangycnJPV3hTYTNjaldWTXY1YVRSbWdKVlI1?=
 =?utf-8?B?NmJzdzc4bVBTVW9uYUJyZzA4QVZ0R0NZNXJHMHAwL2lBRGFvaG9GZmV2SmtX?=
 =?utf-8?B?Y0p4cmVqNUxBUWNZUlpFMk84OFlEU096WWNRaUluOGtRcFlFSDBQNXMrRTlJ?=
 =?utf-8?B?NlBQMytNUE5KMzBXZUdSRWdKZTJCYUk5dmE4YkhJMHIyYk0yamltbFZ3RHJR?=
 =?utf-8?B?L1liWk9BYkVSY1h0YzdLd3YzNFU0VTJIYUUvaDg4YmJFMEMvWDU4ZTNZMHY5?=
 =?utf-8?B?ZEQ1RzczcFdZbzI5OFdnRld6ZGdOZE9tK1ZOR3Ezcmh3dEx6V1UwcDY2YThR?=
 =?utf-8?B?OTV1WmpORHJOZWp4M1d6RTcwQVpuQmlHNVErYUk3enZkYnBsU0gvbFZVNVhR?=
 =?utf-8?B?SStVVXVaUk9qUkVrcWJPaFNrU2MzZTErZGQwYndXZm9KOEZnRzFFLy9TRzMw?=
 =?utf-8?B?RWxpR2dDTDZhVGNwM0hLWGpHY29ZMVdDbC80VWRuWW1DMmNMWXhrN1RqbkxH?=
 =?utf-8?B?QnJLVUxoUXBlMFBBNDBGcWdIcWFOQ2FLelFRTmxZZ1FIemF3K3BzOW5SZ3hE?=
 =?utf-8?B?QXk4amxPTzl0QzJmb040Nmh3alR1UElxRjVlRXNCVmZSYkYrWW1GNis3dzVH?=
 =?utf-8?B?R1I5aTFGVDNpUVZSSFhDQk82TEh6UGNvSm1PMHIvWnI4N2orVlJPZWl2MTdL?=
 =?utf-8?B?WXBQcy9oMnJpYTZpTzhJMGVvYlk0WWkySXBCT1pQYi81TVYxc1lHMzJOeE9Q?=
 =?utf-8?B?UUtFS0wwUGN4Uk1LRHVDR0k2UXFpQTlzMzEvVkZnZHlROE5VekVNTGlITjQv?=
 =?utf-8?B?REUzS1lWbnE3alZyZ2ZmYUFSeXdKUDBRVDF6MVY5T0xBbk5FdHlZUWZhbGVZ?=
 =?utf-8?B?Y0ZjUVJQSno1NkdaZThmV1JyRG5mdkhFVjNrenZpNUFwNGVOblREWjFSZEIy?=
 =?utf-8?B?NlR6Uml2TUlNYW9hWlEvTzQwRTE1M1krRDJWS3ltZWN4N1k1YmwyeDVWeStV?=
 =?utf-8?B?K0JNQVcrSkplMnE2b3dsNE9GV2xIVEUwTUJ6bWVjUmJYLzVzK1hRdEpmVFND?=
 =?utf-8?B?T0JzNitpeEJSVFJrOEJPVERpc09LUXJQdmhNeUN6UXNleFR5b0NQbHZyb1lW?=
 =?utf-8?B?dkpnRXh2aTEybTQzY3lMcjlTYjYwQmM2b1NsR3ZONVVCZFZrenNBcnVRMzVQ?=
 =?utf-8?B?UGtHWktyRjBzTTJtZ09VbEpxVVExQ0N2eDlOdmxaZG9CSmFGTllBcStNNTJS?=
 =?utf-8?B?TmxJS0hraXlKU1ZicHNYYnlWRWdvaHZydmZUOUxIMXZqdHZlS2FJcGxUZkhP?=
 =?utf-8?B?bWsxSG9UR2hoRFFLV2xTVmZBZWg5b0U2VGxqQktmd1IrbTdSb1Z6Y3d5ZndP?=
 =?utf-8?B?V3FONkhPd3BicFVMNkllV04wV3dISnRUc1BCS2R6MTZHb2xxbDFrTWxMM0s4?=
 =?utf-8?B?UUVNL3ZIUXVBa213YnNYRmlRUDc3cEhSSFgrTnZ5TmcwdHZHZlFxcjBRYVUv?=
 =?utf-8?B?b0hkemhOZ1pTMkpvTHYxaU5hOWJFQW9ZVy91K0tjYXJoNGxMZ29xcHZxOGdh?=
 =?utf-8?Q?r3JbZ19zI97YgrVlH2IVWb8OC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8299d69a-d576-4141-f41f-08dc4787c3d7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:12:41.4728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AmEBC/+R4lnGgCELlQqraucz88jBEJR1XDi7Qh7qjYWxq5aeYw9PGRpZjrtBpJRmP4CeaA4xla+TNAbUlhQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438
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


On 2024-03-15 14:17, Mukul Joshi wrote:
> Check cgroup permissions when returning DMA-buf info and
> based on cgroup check return the id of the GPU that has
> access to the BO.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index dfa8c69532d4..f9631f4b1a02 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1523,7 +1523,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>   
>   	/* Find a KFD GPU device that supports the get_dmabuf_info query */
>   	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
> -		if (dev)
> +		if (dev && !kfd_devcgroup_check_permission(dev))
>   			break;
>   	if (!dev)
>   		return -EINVAL;
> @@ -1545,7 +1545,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>   	if (xcp_id >= 0)
>   		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
>   	else
> -		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
> +		args->gpu_id = dev->id;

If I remember correctly, this was meant as a fallback in case for GTT 
BOs where the exporting partition wasn't known and the application 
didn't have access to the first partition. I think the way you wrote 
this, it could also change the behaviour (report the wrong GPU ID) on 
single-partition GPUs, which is probably not intended. Maybe this would 
preserve the behaviour for that case:

	...
-	else
+	else if (!kfd_devcgroup_check_permission(dmabuf_adev->kfd.dev->nodes[0]))
  		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
+	else
+		args->gpu_id = dev->id;

Or maybe a more general solution would make DMABuf import work when the 
exporter is really unknown or not even a GPU. This came up not so long 
ago in the context of interop with 3rd-party devices. This may require 
user mode changes as well.

Regards,
   Felix


>   	args->flags = flags;
>   
>   	/* Copy metadata buffer to user mode */
