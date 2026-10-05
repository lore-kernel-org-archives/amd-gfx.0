Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B81CA5FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 20:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F347210E227;
	Mon,  5 Oct 2026 20:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eUYfZHbI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C37F10E227
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 20:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZe/QLFnEERj6mIO5+sUQDP3dcoB+F48/uXRtHujCkkXSHlzVvGuFi7vz6vUV/9oEsii1bFhw05SZbyWVtIv4x8QHqA8D3KtROIAYXHWV5QR//WRCG35P38Fyab+c6whoK+zTSoxsgw1ts29po0INpxmfMdnsYXd5+uBvAL6246M0IlAwE+JuI9oI/CDq2t53yAlWHqDwDkouWbrRu1MunTMD+0H9MyKTNngb9Dk3IIviad3Z5yDyhrvAj/XD5BRfQ9kyYuu9+0jby9OnDR0eCzwQ9+RiunKYJLHZ3FHmZK2qgHc7+mqT680KdxHxakQbko7C0wwZ42z6+OoVzBZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHN11G/+6In9/Iivr90HfQ+0vMbZtd9EQtimU2cRyU4=;
 b=dcDO/lQAiVx7rrrCxL0FzeYhVkmeHQC1uctr0f4qGUz/Lyw37iXs+xC5g/bjmV30IGJXE+mREb3WI74JPMv3F53LaDzoWv55K8xgs3ImbWCUAjEcHFuBJeemdcQHvw4WAHDD1Sy6siORRN2z/g45j2ozIFye1s+t5176rKSOQrEqOL/R41bUNpgEQTPKRiBVhOB0ClsHKkBNduUhmPMKMg7EHm6L5FPBcFPmlo2vVPneIKxa8Tp6/lAsxy/LF0pO/5JyvQWEsIWTiGoTxm1SQ5cAklqU0apjkqlrVxaL+ciAQiIHXSKh3xucJIoRNiWF40+2fhGB+17TN6mwpntYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHN11G/+6In9/Iivr90HfQ+0vMbZtd9EQtimU2cRyU4=;
 b=eUYfZHbIoMJFKukKLM56CpzX2YDrSYJiIMEejeu+C5clBWJpzxuu2fUAIBFKPTjksQWgI+666G8QYM3s1fT712W9aKEKBnIw1Mo2xskkGYX7eP9r2qJLVKGfvJ4QgonPBFkQbIGtBTcl6BpTqTn+z5Y4hrCSkN1EQyZ1a0CJy/A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ0PR12MB8092.namprd12.prod.outlook.com
 (2603:10b6:a03:4ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 20:42:46 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 20:42:46 +0000
Message-ID: <4f544967-a5aa-4fdc-ab84-4609faa611d8@amd.com>
Date: Mon, 5 Oct 2026 16:42:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: Remove unused code in CRAT initialization
To: Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
 <c10cf71b7923704e8f4ebfe97077dd51b9ff1737.1791208447.git.dhruv.b@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c10cf71b7923704e8f4ebfe97077dd51b9ff1737.1791208447.git.dhruv.b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: c3334c58-0333-4d83-ac7a-08df2321364f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|10067099003|18002099003|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 3tp64zgLOLXihaQdH6g3qAHaKiEEJ4fu7mqFcU3OwcZj95DH66F22MYz7cSL+4NV5JfgMqTmFHTUpa3b7SW8F/GAXJ0PXMI0mgU1/shaqkpmbnhmFe8zOGt189fEaEkJ2m4NJputRSfsFf4T0NNfy8XYj5lWxU4NACT7PWO534wzIAoUbdkvoReHil/V6ezBO2upKZLQby9P0M6Y2lVg+OJNwe0h3bYMABOLmRjp1UHlI8lNf3GYdCaExqu56Z8WMEZp8yx2dffd1DLKTN1w5lDSMzFuaSiwI7m7VhGkG0UqvagnWaDHhO2SCn3Mor4Qkd/+NratAhXNVqX4aqWcdURZWtIFF75DMwJk91fEFtXLNyS4hZytD0Qp5K/TwQIuzD3VVSXOC9UbAKx3NgAmWYFVBrTka5fkvZG/yn1KHJgwuZlF0T9TAps/SnLkl9koWXOmBUUD17ENp0fDW8g2iXV083XrmmZc7nOdzNQs4ku8GU8voXltm5obeqf9u/FoQi6smAKULKst+1uPviJJxkqM5TIvWaHTQ6Ei+O5zrWSwG4d63bRKCksOw/LvJKinhmDQxlUwgTmhZ705fmNNFA5+7+zULAWwZdi2E/mtVQIEbN6pi11Jr3mURyxJ5y35ICiHIq4+MTZiBMxZXy9MjjwyBw6qbI0xyCVcD+eGNNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(18002099003)(4143699003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRCN1dFTjJPR0pLeVJ2R25Mdm0zbnQyZU80UUFJdjJoUy9MNFZNZFVWcGdy?=
 =?utf-8?B?QUFQY1BlSmQ1eGJiR1V6Y3JkSXY1aC8vRGdpQWo2cEgrQXNOUTA0TU1Zdm9w?=
 =?utf-8?B?MXJ2WlVTeTU4cUFKY1F2V1h6NkRlU0w5eGZtMk9aVmZDWFg4UmZxa1J6ak9w?=
 =?utf-8?B?RU9TaXBDY2Nrb2pKbUlya25vWFFBTnIrSUZkWTZ6SWEwRG5iU1hveXlmaFA0?=
 =?utf-8?B?cXdpUkxxQjNZME9pL0tIMndqd1p1eWdTV1g2eWtZM3E4L1V6eHF3MG5JV0JS?=
 =?utf-8?B?OGYrY2Erd09uN3dWcjVSVERzWkRDNXltM1lqa2J2azJTSGxlU1NxVDQ3aEpF?=
 =?utf-8?B?Z3lGNVhzSzR1dTRaajRRcFZKTzdkNllVd24vNTE1dllZTVJUVkV6Z3ZiLzg5?=
 =?utf-8?B?MDlScGtSdmRtUVhmRnluNXNJMkd6NWRqaDhzUjV4Y2xhc3F6TlBodDE1VG90?=
 =?utf-8?B?TjU3bkFjandQZzd6dmRRTG5xUmozckdEdHhzTUd6bmlYUzFTVTF0aExtZUdQ?=
 =?utf-8?B?WEFTTHdEV2RDUzU2SXhsL2RZMVRrQ1hzYlIyRmpQaWxJZ0IzeFV1MS9obUdv?=
 =?utf-8?B?REFMRlRTRFk3c1EzQ2QyeE1pQ1JRMXpzVFQyU0Y5cnFGYmd6RVFacFZyUUs3?=
 =?utf-8?B?dy9XMVZwUm8yaW5VY0JOSEp2cVBOVnRDeUZBdU56c1Y5Y3FlYW5XVW1NQ3Za?=
 =?utf-8?B?czdYcm5oaFFRVWpWeE9RbXJvNFZNMXB5Y0JHT2dxSkoySE1LZU1ORnp2VzR5?=
 =?utf-8?B?THRLOVBaUUVSZkNXYUhuWTV3dkl3dm1nUWdSaEZWZlhPSGxBMitnc0Vma09q?=
 =?utf-8?B?cjRIY1FJOERqcURaUXFUVTQyZzNMeW1tSi9ZcGM5T1M1bUV3eUtIRGlFbWtD?=
 =?utf-8?B?bklibmFua0xmQmVsemFhdS9xM2FPTDBia3Nia2hUZTNhbFlXMzNGNnVLL2VE?=
 =?utf-8?B?a2h2cnBkdDUxZ21xMFZTc2VCV0UzVzdzWGlNV1hzM3dSL3hwMGpTTk9OZity?=
 =?utf-8?B?UTNNVEdGNk1BTWQ4OGM2SlZLTFZ5bzJIK3ZWbnVVTDRIZ3NkaHBjaks4UkRS?=
 =?utf-8?B?MWtQYUtoSlVRK3RQY1dEaVYyVUs3aHJVWGJ4ZFEzcmgvdTFCaGozaXFIVURD?=
 =?utf-8?B?dlZNeEVXTGFyUXA3NVRaT1Y5YzE4OUVTZ3lqZmMrYUtQVnNEcnA4NTE4aENl?=
 =?utf-8?B?VDIwbkdHSzd6QzJqbkMwZ0E4ME12a01wdVdjZUpHTDQrYWhWUDFxQ1ZnV1FO?=
 =?utf-8?B?S3ZkWjIxNlhlZDJIRUlzYzdzMzVjRDJQa1IrSDJ5dlRXbW81Q0FFL1lIOG1s?=
 =?utf-8?B?SjBYYjgxd0hkRkhBU2pQUGZvSmRUZVNLa1U5L2VTVlRQVWZ3UGNHeUdCWEk1?=
 =?utf-8?B?aDJDdVEwQW53bEF1N2RzblEyNWw2TllFN3E3MDNmVVU1d01BNUR2SmI4QVNC?=
 =?utf-8?B?Z1JqUk5POGN3STNFYUR0UlpWclByNDh2RmpmYmNnL2lGNmtwTzZuMVV0eVUv?=
 =?utf-8?B?TEpSaSsvZGdvSkxKbVgxSXBFQkN3NmtLZUJENUVkcGVIWGNJRFdmLzN3dzVQ?=
 =?utf-8?B?czMxU0dSeW4wVG1hR2Z6WnVWeitCS0xEV1pROEZJVzEzdEJ2b3p6d0tmdys5?=
 =?utf-8?B?enR4Q21SeW0rMjB1WGdYYWc3cm5YTEVTY0JCb09QZUhGZUU3KzlVRlRTUkdM?=
 =?utf-8?B?ZXJMWS9WVG9wZ0FKaVk5QldkM0JhOWR3S1V2d3lOWStsRWFGcEhKYXE5NEZS?=
 =?utf-8?B?eGNFYWNtbW51cHQzd3dnUU96aHBBYkVPMnVwWVh5MExFcU5jR3krVSs5bHEv?=
 =?utf-8?B?Wm1zaXFJYm1uMFhuNTJ0TVdXQ1J4ejE4VnMxSDRyYnRYalZ2Tk03eThxZTFC?=
 =?utf-8?B?dzlVN0pYdnNRRmt6c2d2VVk5ZXpUMldlTjdEekdqNkNyUk90L1Y3UVVPZ2d0?=
 =?utf-8?B?QUJhOWIzZkVTSCsxWTlkcWFidjlyYVdHWmMraVIyOFNvcjYwSTNtZ3J1YVJL?=
 =?utf-8?B?WFhmYkJ0N2s0YVMzM012RjhUVUlYL2dkdEJGQzJESVBtZC9nUmhUa0YyZmVh?=
 =?utf-8?B?RTN5SFpud2hiVG0xWUFwazlla1lrNWlFT0hNWnI0M2VEZXZjd0I1Sk8zdUZY?=
 =?utf-8?B?ZWxyNGNYQ1lPb0hOaVpFY2tPU3pIWUxzdGt0VnBBWm9zZWhWTzdDWFU2YjNJ?=
 =?utf-8?B?UEMyN3JOOEJNc1ZhaVpvcUhjckdDTjdLd1FHRUExR083U1pkcGpTM3NHYjZ4?=
 =?utf-8?B?eHdjRGJBNFBOOTNoNlNNQTJNUHBxWUhqMmc4OHJqeTg3bWFET3RZY3BwQjhp?=
 =?utf-8?B?TDA5NWZ3dnpaNUtmZWdqc2wrMlBPYk5hMS9FejdDRm9JNWdrcWhDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3334c58-0333-4d83-ac7a-08df2321364f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:42:46.4014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBagf5olpXtUPM+HnOIlma7ZCRJ+E4EzslQZnC/o+gv/xe+snZHFS66taAxTjT9VzZSy675GLHA/W3E0vqatMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

On 2026-10-05 10:00, Dhruv B wrote:
> The 'size' argument in kfd_create_crat_image_virtual() is not used
> by callers to retrieve the allocated CRAT image size. The callers
> rely solely on the returned image pointer and inspect the parsed CRAT
> table header directly for entry counts and lengths.
>
> Additionally, in kfd_topology_init(), the 'kdev' pointer assignment
> via list_first_entry() after parsing the CPU CRAT table is not being
> used and can be removed.
>
> Clean up the function signature of kfd_create_crat_image_virtual() by
> dropping the unused 'size' parameter, manage the buffer size locally,
> and remove the unused variable assignments in kfd_topology_init().
>
> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>

This patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I'll apply it with the rest of the series once that's ready.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 10 ++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 ++---------
>   3 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 6e0df685503d..99b0c7f825fe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2411,7 +2411,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>    *
>    *	@crat_image: VCRAT image created because ACPI does not have a
>    *		     CRAT for this device
> - *	@size: [OUT] size of virtual crat_image
>    *	@flags:	COMPUTE_UNIT_CPU - Create VCRAT for CPU device
>    *		COMPUTE_UNIT_GPU - Create VCRAT for GPU
>    *		(COMPUTE_UNIT_CPU | COMPUTE_UNIT_GPU) - Create VCRAT for APU
> @@ -2421,7 +2420,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>    *
>    *	Return 0 if successful else return -ve value
>    */
> -int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
> +int kfd_create_crat_image_virtual(void **crat_image,
>   				  int flags, struct kfd_node *kdev,
>   				  uint32_t proximity_domain)
>   {
> @@ -2449,9 +2448,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
>   		pcrat_image = kvmalloc(dyn_size, GFP_KERNEL);
>   		if (!pcrat_image)
>   			return -ENOMEM;
> -		*size = dyn_size;
>   		pr_debug("CRAT size is %ld", dyn_size);
> -		ret = kfd_create_vcrat_image_cpu(pcrat_image, size);
> +		ret = kfd_create_vcrat_image_cpu(pcrat_image, &dyn_size);
>   		break;
>   	case COMPUTE_UNIT_GPU:
>   		if (!kdev)
> @@ -2459,8 +2457,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
>   		pcrat_image = kvmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
>   		if (!pcrat_image)
>   			return -ENOMEM;
> -		*size = VCRAT_SIZE_FOR_GPU;
> -		ret = kfd_create_vcrat_image_gpu(pcrat_image, size, kdev,
> +		dyn_size = VCRAT_SIZE_FOR_GPU;
> +		ret = kfd_create_vcrat_image_gpu(pcrat_image, &dyn_size, kdev,
>   						 proximity_domain);
>   		break;
>   	case (COMPUTE_UNIT_CPU | COMPUTE_UNIT_GPU):
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index a8ca7ecb6d27..418a3939eda3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -313,7 +313,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   void kfd_destroy_crat_image(void *crat_image);
>   int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
>   			 uint32_t proximity_domain);
> -int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
> +int kfd_create_crat_image_virtual(void **crat_image,
>   				  int flags, struct kfd_node *kdev,
>   				  uint32_t proximity_domain);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 35b3abe57b80..b38d12f3da84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -996,7 +996,6 @@ static void kfd_add_non_crat_information(struct kfd_topology_device *kdev)
>   int kfd_topology_init(void)
>   {
>   	void *crat_image = NULL;
> -	size_t image_size = 0;
>   	int ret;
>   	struct list_head temp_topology_device_list;
>   	int cpu_only_node = 0;
> @@ -1023,8 +1022,7 @@ int kfd_topology_init(void)
>   	 */
>   	proximity_domain = 0;
>   
> -	ret = kfd_create_crat_image_virtual(&crat_image, &image_size,
> -					    COMPUTE_UNIT_CPU, NULL,
> +	ret = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_CPU, NULL,
>   					    proximity_domain);
>   	cpu_only_node = 1;
>   	if (ret) {
> @@ -1040,9 +1038,6 @@ int kfd_topology_init(void)
>   		goto err;
>   	}
>   
> -	kdev = list_first_entry(&temp_topology_device_list,
> -				struct kfd_topology_device, list);
> -
>   	down_write(&topology_lock);
>   	kfd_topology_update_device_list(&temp_topology_device_list,
>   					&topology_device_list);
> @@ -1871,11 +1866,9 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu,
>   	int proximity_domain = ++topology_crat_proximity_domain;
>   	struct list_head temp_topology_device_list;
>   	void *crat_image = NULL;
> -	size_t image_size = 0;
>   	int res;
>   
> -	res = kfd_create_crat_image_virtual(&crat_image, &image_size,
> -					    COMPUTE_UNIT_GPU, gpu,
> +	res = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_GPU, gpu,
>   					    proximity_domain);
>   	if (res) {
>   		dev_err(gpu->adev->dev, "Error creating VCRAT\n");
