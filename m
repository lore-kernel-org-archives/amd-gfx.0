Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C4C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 08:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F50810F10F;
	Wed,  8 Jun 2022 08:28:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F2A10F118
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 08:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2i6Tiq08NYKCfEPFBoOfPofUZ7TZ+xwBobYKVTphnaTd4JbsfNQG4XKU4zxwr09OuqpM56fy3fBcuEFsQE2mSOc3ENBPedxvEqojw7CcQ2dwGFzT1W+hqkan5q+euyjXaEEL+ZfUo6ZB7NAxbx4JB/CqghbZvCygiRvn4Bb4ph2WHJGu7QR2cYQvR0R+cgYYjkXQ9+lSmZYimoSlHkPTkQ1j+OKlpuLn9TkqyyOAGrTFXC//iU/8pmG5Lr90F2j/DMXaMt/J7hEzmqCUf4Hn+vi5F4J7O47GhUkmcX1PNZh88DqKsD+2PdewQ78GTsvxRRUlfDrka8vHvmvulWS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DQx+7sN54NmwdmB9+7WBEbFntZIAy7KURWTsay4a1A=;
 b=SH09/7h+9428DeSiHppUIfkTOt14jYh4BGZ0PjDNcsLtTsWjMNci76zyC4+9jA+/NgYkCdtJszX0sPBlewoDC3RIQBrlXkCjv28A0a2VwkHkE1y+yN4md/XV0z0sSfOuDacUeaYA/pCedZJzZZjpTVea9NbZIW6e6ofVSr5XILko+ypqKTiylmF7pMx399OOG5LgI8pQnk/oilEDkmMCHzuGFGpyzsA+1BDTLMn3ocL727llbEyuVKJBZrS3reU+6U7daKLsavfaWZS0cEXNuXp6L41qWzKUnbwktivNVCpws3XW2zT/8PXeyYaQljNJ0kEfNq1m0RHYsLPekbpcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DQx+7sN54NmwdmB9+7WBEbFntZIAy7KURWTsay4a1A=;
 b=o8lUb6db0C2G+z2B32t3VR2dZzKzBWLigapwX5vIna104RQysEShmMOfDbf4pLCbNLMv4RVb0vN0we+ZS2qE3CxmBcCY9e6rK1maHjHzSMZsmP6swwM1p6RlfxNNsd2w3hlM41PQ4MG0i051WBhSKkRDCjBTITEMqag2riPKOjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 08:28:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 08:28:04 +0000
Message-ID: <7618d13b-2101-8104-b7e9-db42af9eb80a@amd.com>
Date: Wed, 8 Jun 2022 13:57:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/1] drm/amdgpu/jpeg2: Add jpeg vmid update under IB submit
Content-Language: en-US
To: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, James.Zhu@amd.com,
 Alexander.Deucher@amd.com
References: <20220608053618.3484143-1-Mohammadzafar.ziya@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220608053618.3484143-1-Mohammadzafar.ziya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923c5b23-f749-4dae-ecd5-08da4928cea5
X-MS-TrafficTypeDiagnostic: PH7PR12MB5655:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5655A8A033452F6A5B171F1197A49@PH7PR12MB5655.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 883Ha4x+8cpI3Kq7QsxcsfRFk4GY7S2MBi0eCr2pWF+SCwQ8snuuRJPbBh0J04C9D4ZdHghRCYGrKQCGOiC7SlZ3CEwMe2atzwKJud3OwExPNSxGu7IPuV1SQx276R/eIcMCUMVt+1FwrFQiqedjKZyIwgcqSciE1jiE1IbgR6AckTdJRcg+9E6MT5h7ge2SGcO4VPVz+Udq/NdclSWYbb56sWOzKLGttu0BAIF7ZlGa28aqo88MdkR+Xsx0x9I8hX1ovoPeVRCdyT0y/pQMPr0kR+RXS4fQ8g7SQBlcg3jmHfi7j5GmcbR7WkgxsvYagbRml20RAdVn43aq78kuOwfUYezhPnTEtx20rCVXCRmahYb9wsFEufLmzmHWcje+74xcuLe46D0inRQfmxDot9TOqgx/snohpVxDiot5xLF0Q4xi5Jjm7MMCfxB0Dn2+52z4lowaKpuvFkKnD2zPDNPmhALyNY8UCowq6zd6bYt19m9bw3rKJ4N8Ff28npoQYXhBdgo7pvfcN+3uTRGxs4P1QyIMaZQnVN3JvvDcIrE4jEkgc4RvhO1Vfg39T5vw0RFL97wzjb4yM25C76jPkCKUy3xVul6TFwrLaOvM3bia1ox9JRn42S74nWl95dljrAIX3M5N+jVsBSVleJYmSjHIXZMm47ElBDnJZ5t3e96r+TyxFqqvm2D4uZokMAtJ0CQXGyCB/U6555gBe0tyHKXKFrXfqm1qTVTDjwUJDDTCz6MVA5VuXJIeAsUbYOIy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(5660300002)(38100700002)(2906002)(316002)(8676002)(66556008)(4326008)(66476007)(86362001)(15650500001)(8936002)(6636002)(66574015)(66946007)(186003)(2616005)(83380400001)(6666004)(6486002)(6512007)(6506007)(508600001)(26005)(53546011)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmd3ZDRidm91aHVLaHpJb1puRUxEd1o4QVdUMUVvdXV4WVh1K1NRZktPMGRZ?=
 =?utf-8?B?d1IzNDNkaUVadjExOXh2TzdFL2RJRWRjR1JSQ2ZKWkJodEdXM3NWSEI0NW5Q?=
 =?utf-8?B?YXdWa0NhTUV5WTNCbjVsUFhxOTQyejNzZGNIbkJIOU0wRmZSd2YvQ2p5bUUw?=
 =?utf-8?B?NlZSZ2ZhblEyWkc4OXI1T1d4b2tiRlVnM3Fkcm50Y1FOVFpQRVEyKzRpU3FY?=
 =?utf-8?B?ZVlmVEZBdW1YRU9UTEtQS2JWdE9pOW9MMERwV2NBLzZ6T1MrT3psNzlXdmFW?=
 =?utf-8?B?bDNVbWU4RDFTand2RXhUNzluMyt1bUVPYStOczlsL0lGUTBPV1ppWU8ydHN3?=
 =?utf-8?B?TmRjZkp6WWJQb25QM09PT1NZVnlmLyt2M2VxaW9WT2dPRGxwNGdtQjNwZW1q?=
 =?utf-8?B?WVZmNzY5R1NSRXd3UnY5dDFHczRhWUUxYWtiMlltemJQZ242ZDY2NkFlUFlo?=
 =?utf-8?B?ODEwVDlxc1Zlc1gzaE9HOWE3TFI1a1J0d01FS1VJM0ovWHh5RmljcHVWc0t3?=
 =?utf-8?B?d3MxTHVZTXhLUDZDRG1tVGVnd09GSmRBTjZqa1ZBeHRxMFVSSXNmVDA0eHMz?=
 =?utf-8?B?Y0VIWWdDQkdKczhLemNuSDZDUm9jeVM1Nk5xd3VWUC96bm5zYWJvMCsvQ2do?=
 =?utf-8?B?aWN6Q2pMMHo5N3N1dWRGby96dG1qcjdPdUZCNE1LeE03OVljT2FIZ2NRZWh1?=
 =?utf-8?B?ZnoraklvSk8ybG9NK29odFRFbTFoNVpFa0ppeUVBWmFzeUN5eEtFWTR5a1hM?=
 =?utf-8?B?UU10R25Jb0hoTW44MjVyZ0FTdzh6OElnWHIxd3pFUzR2a1Y1SnFsdE5mQmEv?=
 =?utf-8?B?Skc0UFg0TWJlQWNOUXdkSWw5ZEdTcFdQNXQ3VHlxTXVlRlJaZ3ZRalpUZHJt?=
 =?utf-8?B?cDdyaXB2b2gxVlVma3VXQXIvdUlwb3Q4TExrYnVvNGx2N3lieEVqbUQwTEJ6?=
 =?utf-8?B?RVNmbGNBMkN5S3d5eEZlSWdKTjU5T0ZkSk5pcmRUQ1R0QjFVa3BmMXF1NVNC?=
 =?utf-8?B?VGo2MHJtanhJNXNkQ3MxQW53UkttY1E5Ykh4KytNcFZpbDJOdUxDdTBwdmZB?=
 =?utf-8?B?TXV2ZGdhUFNpdTRxSHJ3YTFHd29jczBINE5RbXlLSWVFbU1NVThCR1VXRmZG?=
 =?utf-8?B?VmsxOXdwZ3Z4ZmtWZGVTbHNDS0IweWZBdGY1cFgwZGNCM2EvVVhkSFNSbU5D?=
 =?utf-8?B?c0l1eVpXT09MR1BVZndWL3F3eU04dUZrU3ZkN3hWUzVmeVRrQnVaWW9udGNl?=
 =?utf-8?B?V1lsYnVPdEprTXhTSzF2MVI5R3AyU0cvODVCejN0ZStmeFJhclNBNE9rTTJw?=
 =?utf-8?B?YlYwc0thMVo5TGowYkxmMC9XcXFlcFlsTHpoMjUvVjRnTlpJdTg3SUhvMjBk?=
 =?utf-8?B?aEw1N3BmSTFUcGFPR1oyaHhsY3lySmp4TS9SV3RWR1lUODFkSkIzVGFZY0lW?=
 =?utf-8?B?YWlUNndZTnZTaXdBVElWSzdXSlJDWlFpRTN2aVNqc0Zmc3hYVlEyWEJLMW5v?=
 =?utf-8?B?MHVlb3ZDRFVsUWY2QUdiZ1JCcVB3dUkzYUFXeHdPMGgwajhpZmJEMkVua3p3?=
 =?utf-8?B?SjhwTmtGV0J5MmJBN1l0TXQ3M1ZDbTMzZVEvTkdGUnR2TGYwTm93R0E5WmlP?=
 =?utf-8?B?bXVyUW5OZmh3b2RkYXB1MVNyUTNKMVFLM2tBMVpOYW9yeGZWUXVvYkxOUU1B?=
 =?utf-8?B?ZHVSYkxPTWZyR3JxKzRJZW1ubkRGTUh2b2lqYTF0ZHJXN09CNTdzNlNHV2RW?=
 =?utf-8?B?Y3J6VDFUS1hTLzVJanRIYjJOOVFvMFd1ajczdEl3SHU0aWFnOW1HWnlvbkt0?=
 =?utf-8?B?Uk1SN1Awak8zWlZLcnBaQy8wY3VYeVo5L1hGVzY4RjdXVmRUTlVTVzFWcU1j?=
 =?utf-8?B?azZVby9BcmtHdVpxUVpwdmFGbWR1VGlLajlDK2IvWVk4MVhKdUQrMTZ1RG1C?=
 =?utf-8?B?YVRPRzIyMG5jQ1ZYQnU0SVkyODdJbjBlVURoR2JtN203UFpvNHNaWldXM3Ix?=
 =?utf-8?B?VVVXRWZjTThkZ203eUhJWlBxVzR5bEJJK0lGM0dFcUxITG1OVnhFZjBQdE5y?=
 =?utf-8?B?dlM3ZXBoV1UwR0wvMkJ3SGdqR1EzODh4RUVyM2xodzU4QXVBRFpXWkhWalZ2?=
 =?utf-8?B?QTJVczZQOE94UTlsNjQ4dmhWdVYrWUZnTUlhekQwVThOUXZiU01GU291bzRL?=
 =?utf-8?B?cHBzY1Y3TmtqbFpYMFRTY1BTZ3c4ZThSckFuYnpMVXlLazNJekVmaktpekl3?=
 =?utf-8?B?djlpdzdjejRlSWduS3ZKOHVQWEJaNndxa2NZeVNZRFRQazB2Y0p5QmlrV2VQ?=
 =?utf-8?B?VEhJbm5sdWlsTEMwaCtBbHJqdmZUNWc4Zkt0TGpTaFBMclBESjd1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923c5b23-f749-4dae-ecd5-08da4928cea5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 08:28:04.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AElFL9IsShs5NlDE2j9SWRripgmd/Sd3TIec/qLoIdsmX3fK8JFb9S8uSLWGsl7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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
Cc: Christian.Koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/8/2022 11:06 AM, Mohammad Zafar Ziya wrote:
> Add jpeg vmid update under IB submit
> 
> Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index d2722adabd1b..f3c1af5130ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -535,6 +535,10 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
>   {
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
> +	amdgpu_ring_write(ring,	PACKETJ(mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET,
> +		0, 0, PACKETJ_TYPE0));
> +	amdgpu_ring_write(ring, (vmid << JPEG_IH_CTRL__IH_VMID__SHIFT));
> +
>   	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
>   	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> @@ -768,7 +772,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
>   		8 + /* jpeg_v2_0_dec_ring_emit_vm_flush */
>   		18 + 18 + /* jpeg_v2_0_dec_ring_emit_fence x2 vm fence */
>   		8 + 16,
> -	.emit_ib_size = 22, /* jpeg_v2_0_dec_ring_emit_ib */
> +	.emit_ib_size = 24, /* jpeg_v2_0_dec_ring_emit_ib */
>   	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
>   	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
>   	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> index 1a03baa59755..654e43e83e2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> @@ -41,6 +41,7 @@
>   #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
>   #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
>   #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
> +#define mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET				0x4149
>   
>   #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
>   
> 
