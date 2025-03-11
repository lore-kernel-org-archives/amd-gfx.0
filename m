Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CB9C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 12:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B48610E597;
	Tue, 11 Mar 2025 12:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="43tP+JHq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB53A10E597
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 12:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqINBSF8uLqDrZa5qhGjYhJGUFWnYOgDgJCGROGgE3Q4Y5EeTFDn8ferVFVbnRn26ySNNBQh75fk9VkGgnUx7LxqZEoGS9S3+91+J3pw12PxKwyaWwC0nPimue3+3aAzPV1+7rOawT6JnAsZez5kesUcxxsTaGHwWGaKK3uoN6pBdBaFvSd9wSlYIUG7XppIaDFAAkAr4tgZgMOLX96nMLG09ud9NPFW2E1quJDKX2XZX1u4lKoQ3/q9J2iYEcpYFv0hUoB7oLzTxx1MMcqVK20cdrEMhthr3TbFzLq5ktbXF25oO3v6+l7wtIsVhhh9c6uPACGjVmRh8W/2fX3C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qubx+zY0J0LETBALw+ZmVMSWVN4m9EdeSZZ4aVg4PCs=;
 b=BQsVxcHfKNN61d8rmv7cEQTzH7ebuEl3mWhTGO7y8A11PC2SlFVSxDxrTcYywxTNdpWFvHCpYipJfQssRRWHXLcYLKqnP1nFY6NPAzLOqfRJPFBdNq3rdhOD3KbvKN9etTAO/TwnDCxOir6E3E7DhQb34lxYL6V6nPlG8T5Q9map8n+AgShfT9Ci1AF/A2po9mtGYAnGcfuEeiuZlwQOWL3OZWnsbGzp2mPjLBf9Zbgb6pqcHNnvVLBfTAJS2KPHDvq6coQSE7FSto6VscbhXIebWNSnfl+KzvHu66yo2gPlKLhoGsBvxjmNNX54jTb2GCQwf/zTv15AuF7kdGpWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qubx+zY0J0LETBALw+ZmVMSWVN4m9EdeSZZ4aVg4PCs=;
 b=43tP+JHqtRR70VWw9KzL6pY3FqbpIhyWA6LbLOd8FfhUzO9uhoDezrWQwgA80eAxO2+iCZvjCi2vcaUrucDr/qcroTeiyANG2LPX3L7R9ILRJVBE0G1L5FBpBrHuGqxx+dS+Dl+Z/DO2k50eymHVcZvTx2DhsdjiRgj/MFB1EKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:18:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 12:18:12 +0000
Message-ID: <ac040c1e-4d0b-4e6f-be08-7e21f0c08e8e@amd.com>
Date: Tue, 11 Mar 2025 13:18:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Add SDMA queue start/stop functions and
 integrate with ring funcs
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250311083300.2897523-1-jesse.zhang@amd.com>
 <20250311083300.2897523-2-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250311083300.2897523-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 38311c55-49b7-4026-6d14-08dd6096cac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWxlSUtNRXBObm9vNTVYZkhMMHpzc3ZoSEJkZHUrUTR5QXUzRU45MCt2S3c4?=
 =?utf-8?B?Vk4wdDlac01OcnE0WERWSmZGSjF1YS9BSVhjZGFvSmxheW9UcjhMZVY0MEs0?=
 =?utf-8?B?d1hsd253R1I1Z3RZdUhOZFZzYWVhUGJPcUlPOTgxQVI2MkVIT29ndFZMeS82?=
 =?utf-8?B?dldDbXd2MHJnU0tZbnZiVWJBSU5uOUVoejlEWGd6UUJYWjF2YW9HcmNLak5p?=
 =?utf-8?B?NGxYY0RIdGI0dlcwRVgwK0txMElacm1uWFFRbGRHcEk5RW11UENxVHI3WE9H?=
 =?utf-8?B?Qk94WHZNOTJXWllJSE4zQTJ6Y2s0d2dZcmY2bGErSXNrNmNYb1JxbXhtNFAx?=
 =?utf-8?B?dGFlUUpNZDVEbVkyb2pvaUlGNG0rc2QzVlpLYmJucllSbW0zUng0QlpSN3Ex?=
 =?utf-8?B?M1dSdlJVbFpURHh2bHg5M2Z0dzNOaUl0UlB3ei9IQnFETm1rZlNCUTNCeVVy?=
 =?utf-8?B?T1d2TGg3TGkyN2RESVpRNDRWbklKRUZkYzJ1dmVrQ1hwZVJWWmZSWk5Vb0V3?=
 =?utf-8?B?VmdEM1kvNk00QmVxbDJoVUpRU0JPRnpNK0lRR0VCcHV5c29BT3liZHRscXRw?=
 =?utf-8?B?MDFLaFd1U09VMDVRVHBlVFNWMVUzU3EwcktlR2JHdDllZmNvNUdzOXdhMW5W?=
 =?utf-8?B?bVlpVGdIZ2xrMnU4bm9keEFZVWN1K0dvVXR5Q2hPVTBaT2UzWVBodkdYK2xP?=
 =?utf-8?B?NTB4ZndZQk90MWEzbllkclZFdm0wY2tBSm5mVWhsVTh0Q1hIK1dkZElMOFVr?=
 =?utf-8?B?bkhIUXNLNjdaOEZJT2ZiZFJ4U2JkZ2d4Z0Fxbm1LWHZlYkQ5cVZiVEMyUmRE?=
 =?utf-8?B?WnRZUHFiWUdLSVAxc2MycHBxTXc1RWFia0RMamNrRHRmc0o2M0Q4UVBkYVli?=
 =?utf-8?B?clpvWEVWVWJxVG9FVW9zRUtSREExWG1VdzhrUHB2L0psVHkzYTI0QmpxZjNB?=
 =?utf-8?B?SG1PeFJldzR1QmdWTFl5Z0R6NUlML1lRd01qS0F3N0JNcEFaTDRHU0xGR2o3?=
 =?utf-8?B?S2Z4NnJRcGxlL3pPemRBblN6T2pNd2diTHpVTklORGJWbXd1NXNDMm1Ob3Rp?=
 =?utf-8?B?bGNFNXVpNm84dVV6Smt3RWpwK2pJbjBOc2xnQTNLNnYzMzAwRzVrR040cjV3?=
 =?utf-8?B?cVZHbW9qaERjMWI2cCtLT0w3dkJQcnZuSGNGUGs4YmViZE84NTRNSVl1UjNT?=
 =?utf-8?B?cFFlZ3grV1l0WC85RjA1d0FDUmJwcW9CNVNZcEFqcmYwZ2hITngwRGtPdlh3?=
 =?utf-8?B?NVZSOSttakViSmxkWDRKeTlVWmlYRTJXRDFLZnVwd25IZWJiRWtZSlhmdlhh?=
 =?utf-8?B?RWs2L2Fnb05kMTVFUzBVK2Yxd3lKZFBReGZ0RktqalAxTUQ5U3laOERwMGFE?=
 =?utf-8?B?a1hVNm8wV2xubXhVQVZYbEpIRGxXOG9ualJwNkg2dlQyYXdrSjBHMWpsRm9s?=
 =?utf-8?B?bjZKM3V3RGxtVVk5ZnNuR3N4SXZ0RjhUUEU0ajVDM0NiTllhbyt4eVBGWHNi?=
 =?utf-8?B?eHRPRmNtQy9xNDJJQnRVSjFoY0NJT29PSkxSWmovS1JmbE5qb0d5MEN6a3Q1?=
 =?utf-8?B?ZllmRFlDUVVSMWNoOU5SSU9FM2E1N3JQYnk3STdlaTQrNktzeUs1bVBtQnlu?=
 =?utf-8?B?ZzF2SjIxK2VqMG04WFVxelk5Sll6R3ZQblhXdGRQdlRrcVNmSzhyOUtkSHZR?=
 =?utf-8?B?Z1paVHpNdGV4OVRBa3BTSkVsKzlEdVBGNUV6Qnc2WkcxQWZqVmVxbjRQdTVJ?=
 =?utf-8?B?Wk1VaVl0QmRlQ1FUSDI4U1gzV1grYUZ5eWRiMHc4TExtdytTR1p3cThQWmFC?=
 =?utf-8?B?YlVEeEJMWVR3WklGSE85aXA3MlpQTms4Zk9DM2FYbmVpR2JuRE9PVEdTMWF1?=
 =?utf-8?Q?+dK8i+nfcBnEY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElOM3JXOUM4QUtVcVhjYVB2aVVpbFVYS3lQR2Y2Q1pPcld1Ny92YVdYVHoy?=
 =?utf-8?B?WGtYTmI3anJUWHl4d2Z2a2dVRXB6MDY3Kzk3aVdGcTAySGdSNm1sTkVsSU9s?=
 =?utf-8?B?RHczNmQ2dUlaZVRzeHNmQjZwWThZVnEzQ2RmZUtacHFJS29pSjEyNFo0a1hK?=
 =?utf-8?B?b1FJSFBkVmpiNWhHUmJwTy9zdjM4Q2ZqdXNNRzlRc2pKL090YVQzVFg3N2Fh?=
 =?utf-8?B?elFEVE1jK2QzekMyMkZJV3NOVk9uSjNOWE05SDZBTkdDUytXK1ozdTJubnNh?=
 =?utf-8?B?aGpBRDR2c0NERHZpcEY3bFQzamR6QUVaTzZzUnpjMmIzVG82UnpJTjV4WkEy?=
 =?utf-8?B?WnRJcy9XNlh3bWhUTnNWRnd4Z0QvY1BSQm1uL0lySFlXem9VQzMyZFB4RHNx?=
 =?utf-8?B?NndsSWxIekNLWExGS2JRRUtCZmFYREp6OWRZSFpNOFBhN3RiaU5qUDAxd25U?=
 =?utf-8?B?YVJVL0MxY1lKTHBOOEJYTy9aY0NTWEJCM29rc3grdUlJRThpcXk2bmFBcllw?=
 =?utf-8?B?WC9zWDZVRkNUaTdta1U3VWgrK0t3MldDMExrODhPblo1NDJFbkpKNTJYL09W?=
 =?utf-8?B?eCt5MHdzcjdBeUNudithYWJrdU42b0Vib3NXdWxKY0VZM2dpOWN2Q2tlQi9H?=
 =?utf-8?B?Z25rbTFJVzZzNVNYQm5LUjdpZGdXZjdQZUxpdXFlU2k2WGc5Ui9rZGo3ejIx?=
 =?utf-8?B?Ni81QU1oa0Z1SEk4ZGRMTGNQZ3AzRk03RjlXaWFkTlJWOUp3akZnUHNTY1FK?=
 =?utf-8?B?L1ZIN1puaUo2L00walUvVGFrQjVkWEx4VXR2Rnc3TTAvcU8xYzVub0loMFV2?=
 =?utf-8?B?NDBnUlVTT1BtS3QzWFA3OVNVSmFVWUI3a2t5UnpVcUdLZWpvNCtwQkJSUFFP?=
 =?utf-8?B?a2M0VjRITXhPbDlRUDNJZEhGZDJFM0ZlUVVzamhXMkJFZXhFQ1IxajI3WGF1?=
 =?utf-8?B?NVVpZ1pqRVdESHdwN1hkVE1sUEJQUWJsY1BTUnRyMHNoUHd5citXUzBSUWlK?=
 =?utf-8?B?NThzUHFRdEh0aE1uRWdCQ3F5MG1YaW5EUkZrY3EyTXhsYXk0cTJZVktnd0tG?=
 =?utf-8?B?STNxSVllRzcrRXZTZWdMTTFpUklIQWpIODVSWCsvYVFpdjJaL2JFbW04QU50?=
 =?utf-8?B?V1VEOU9XSFBWTC81dHh4MUpkTm1ReWp5VGprNzBwU3lxSHZJdno3VEtoMTdF?=
 =?utf-8?B?bk9lM0JkT0RPSHhocUVTYThnZGQ5MnNrblk1bll5VC9Xb21QZ0VSOGpIRGVQ?=
 =?utf-8?B?L3QybVd1S09yY2NHVUtjMHlURGJsT04rNi9LTmYrdEllMExBRXZoVkIvVGZJ?=
 =?utf-8?B?QldsN3FjU3pNaFAwc0hHYnVEVnNHVVNUSVcyYUhxMCtYaXptNlMyUXRJQkxM?=
 =?utf-8?B?WHlnNzRmRkc2anBXVmlsLzJES1k2UURUa243K3BMVm5hVUFleHlZcG9UWGcz?=
 =?utf-8?B?V1hXdGdvS3QveStKeWhQajVVaWpveEtQa0N0cE4rNjRhRW5SbElLeDl4bWg2?=
 =?utf-8?B?Qm1nSUJQNUFkaWRQdVc3TGhmYURYUjVVV2E4MUZlOGx3eXRiZUNtVG9CbE03?=
 =?utf-8?B?S2FjM2dSRStUNHZiclVCbTZDT0dTSlVBWTFmZGYyR3BKNTVRNjlOMVlyTC9y?=
 =?utf-8?B?Y2ZUNXRxdHFlUUl0UG8yL25maTdOZnY0MG5yVXVRRVFIaHpkTVAranRJOUlH?=
 =?utf-8?B?akFZM0toV1pmd05WK2FDZzdwbnY0cDZqeHFOU0ozMW5XYjEzRnZFOWJldHkw?=
 =?utf-8?B?VzJvY2ErRlJXdklXZUxvQ1NqYjFlZU9ZblUrKys5M241ZTR4RkNJWW9XTHJy?=
 =?utf-8?B?R3Z2RWU1N3RBSUErMHlpNUFqd3gzY0RROWhHbDNJeEZ3TUhxMUozRUhBVmVy?=
 =?utf-8?B?VS9qaXRkcnNMQ0h6bUxBeGRza0lVVllRM3pCbmRCcFVJWHBtY09ueVUrWmN2?=
 =?utf-8?B?SHErQWNrS3RUY0FvNWFHUU44bDZaQlZqRG1IUkhuRER2VytrZXRyUlB1UWpo?=
 =?utf-8?B?ZVVYdVVXaytjSXJVbU90ZWtGN3dpemhOclM1dVRobnFMOEc1YXY0YzdGSGg1?=
 =?utf-8?B?YTRTazAvVHBnZUJEWWtGeU1TYzJRQVJNWUxZbTQxcmtyaFlYbFplTXgzN3Mz?=
 =?utf-8?Q?oAGx2aQhm46awxslG/KazBkW0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38311c55-49b7-4026-6d14-08dd6096cac8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:18:12.1502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zfa8Ez6GmghcfzkHRy2wQanKKFPo1SM0/v343If/IXQZxJ3ozTkJDexemVpfpWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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

Am 11.03.25 um 09:33 schrieb Jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces two new functions, `amdgpu_sdma_stop_queue` and
> `amdgpu_sdma_start_queue`, to handle the stopping and starting of SDMA queues
> during engine reset operations. The changes include:
>
> 1. **New Functions**:
>    - `amdgpu_sdma_stop_queue`: Stops the SDMA queues and the scheduler's work queue
>      for the GFX and page rings.
>    - `amdgpu_sdma_start_queue`: Starts the SDMA queues and restarts the scheduler's
>      work queue for the GFX and page rings.
>
> 2. **Integration with Ring Functions**:
>    - The `stop_queue` and `start_queue` callbacks are added to the `amdgpu_ring_funcs`
>      structure and implemented for SDMA v4.4.2.
>
> Suggested-by:Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 92 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
>  4 files changed, 97 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index d55c8b7fdb59..ff9aacbdf046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -351,6 +351,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  		0xffffffffffffffff : ring->buf_mask;
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
> +	atomic_set(&ring->stop_refcount, 0);
>  
>  	/* Allocate ring buffer */
>  	if (ring->is_mes_queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 1c52ff92ea26..7a984dbb48c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -312,6 +312,8 @@ struct amdgpu_ring {
>  	unsigned int    entry_index;
>  	/* store the cached rptr to restore after reset */
>  	uint64_t cached_rptr;
> +	/* Reference counter for stop requests */
> +	atomic_t stop_refcount;
>  
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..7cd6dcd6e7f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -30,6 +30,7 @@
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
>  #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
> +DEFINE_MUTEX(sdma_queue_mutex);

Absolutely clear NAK to using a global mutex for this.

Regards,
Christian.

>  
>  /*
>   * GPU SDMA IP block helpers function.
> @@ -504,6 +505,97 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +int amdgpu_sdma_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +{
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
> +	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> +	struct amdgpu_ring *page_ring = &sdma_instance->page;
> +	int r;
> +
> +	mutex_lock(&sdma_queue_mutex);
> +
> +	/* Avoid accidentally unparking the sched thread during GPU reset */
> +	r = down_read_killable(&adev->reset_domain->sem);
> +	if (r)
> +		goto exit;
> +
> +	/* Increment the reference counter */
> +	atomic_inc(&gfx_ring->stop_refcount);
> +	if (adev->sdma.has_page_queue)
> +		atomic_inc(&page_ring->stop_refcount);
> +
> +	if (atomic_read(&gfx_ring->stop_refcount) != 1 ||
> +	   (adev->sdma.has_page_queue && atomic_read(&page_ring->stop_refcount) != 1)) {
> +		up_read(&adev->reset_domain->sem);
> +		r = -EBUSY;
> +		goto exit;
> +	}
> +
> +	if (!amdgpu_ring_sched_ready(gfx_ring))
> +		drm_sched_wqueue_stop(&gfx_ring->sched);
> +
> +	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring))
> +		drm_sched_wqueue_stop(&page_ring->sched);
> +
> +	if (gfx_ring->funcs && gfx_ring->funcs->stop_queue)
> +		gfx_ring->funcs->stop_queue(adev, instance_id);
> +
> +	if (adev->sdma.has_page_queue && page_ring->funcs && page_ring->funcs->stop_queue)
> +		page_ring->funcs->stop_queue(adev, instance_id);
> +
> +	up_read(&adev->reset_domain->sem);
> +
> +exit:
> +	mutex_unlock(&sdma_queue_mutex);
> +	return r;
> +}
> +
> +int amdgpu_sdma_start_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +{
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
> +	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> +	struct amdgpu_ring *page_ring = &sdma_instance->page;
> +	int r;
> +
> +	mutex_lock(&sdma_queue_mutex);
> +
> +	/* Avoid accidentally unparking the sched thread during GPU reset */
> +	r = down_read_killable(&adev->reset_domain->sem);
> +	if (r)
> +		goto exit;
> +
> +	/* Decrement the reference counter */
> +	atomic_dec(&gfx_ring->stop_refcount);
> +	if (adev->sdma.has_page_queue)
> +		atomic_dec(&page_ring->stop_refcount);
> +
> +	if (atomic_read(&gfx_ring->stop_refcount) != 0 ||
> +	   (adev->sdma.has_page_queue && atomic_read(&page_ring->stop_refcount) != 0)) {
> +		up_read(&adev->reset_domain->sem);
> +		r = -EBUSY;
> +		goto exit;
> +	}
> +
> +	if (gfx_ring->funcs && gfx_ring->funcs->start_queue)
> +		gfx_ring->funcs->start_queue(adev, instance_id);
> +
> +	if (adev->sdma.has_page_queue && page_ring->funcs && page_ring->funcs->start_queue)
> +		page_ring->funcs->start_queue(adev, instance_id);
> +
> +	/* Restart the scheduler's work queue for the GFX and page rings */
> +	if (amdgpu_ring_sched_ready(gfx_ring))
> +		drm_sched_wqueue_start(&gfx_ring->sched);
> +
> +	if (amdgpu_ring_sched_ready(page_ring))
> +		drm_sched_wqueue_start(&page_ring->sched);
> +
> +	up_read(&adev->reset_domain->sem);
> +
> +exit:
> +	mutex_unlock(&sdma_queue_mutex);
> +	return r;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..a91791fa3ecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -170,6 +170,8 @@ struct amdgpu_buffer_funcs {
>  
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
> +int amdgpu_sdma_stop_queue(struct amdgpu_device *adev, uint32_t instance_id);
> +int amdgpu_sdma_start_queue(struct amdgpu_device *adev, uint32_t instance_id);
>  
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))

