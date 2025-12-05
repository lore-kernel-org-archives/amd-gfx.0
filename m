Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD7D37490
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 19:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A7310EBA5;
	Fri,  5 Dec 2025 19:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16nnczeG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D061D10EBA5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 19:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzi1PFszf0SKG0US0AJW4jwudvYiygG54Fyzgbhac++sLVhAXM1qXRdCit9fASV5nm9Aji2zvVw1A39Ee3bgRUnlsDoHO2yt1gf8exVAL4qP2y9akqI2Pk++teENi56uWZZeftxCMXCJYWEKxuJ9KaMs73k6TuYajz2P68AaJsDKoalxrE6Qew4hWI8RVJrcM097opBtm2hgOkbrUqa33ZVLviDb7olcuw2Yu6EuIrmDxq3EDLqe3lsR9qnxihUp0xY+ZOe19xju2GzPZFN7xPRiD1RPIkl8cp/TOHKpqzicSuoE62SwPmLhZtJz0S0l4aoE8q+dQziu4o8PQlhX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mumua22UrTIn1VAx40qWE+5gSxgKQNd/RSFSC2BJ3HQ=;
 b=C1TNiclwF6eSVU0aRSkh+XCw2TU45GfUpdwSiDk1Q1MSP8m8Rz1y5AHktoxD90PvwHDGiopIU5DSroUM3c276mXCu1zRLbp9vxjERqLM3Wp7TqUQUWSy2nBWqWRBHtIvRPXfy8gVi9PpxDt5tOlNdKphmwPMFuBcvuiZNAdTzRkg5D/P/YGJGNFGp0TpIa8p6CGMFkWUrbYvlrHT3GqHJQAUtNGIBZOZXH2DAMkrA3WzG8+Rc2zhxIUuODyfFvVXDbPYr8K13D6+5csWh1QLo+sOOlZii6Ro6gkyU8LzbDqPyZ4qDKsqz7skG0eGsFTXZAk+XGfPG0/511087iivqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mumua22UrTIn1VAx40qWE+5gSxgKQNd/RSFSC2BJ3HQ=;
 b=16nnczeGOvtjw6rWRBBPmA/QVMuLZ55O4T4mNk5UpSwXStHiAbpOIrOXCRkICrPEvEuJIH/IbF3FVlOnZQApG8dKfQDWoD3XoSBw0aBtN4D4QofT3/gnc/1PTragdj19qq/Fkpr+FFfzuTQKkxr0FKwiGyvXO9bR4jwwB6a397Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 19:46:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 19:46:53 +0000
Message-ID: <3461429f-fd3b-40b9-8d83-c45be32563c3@amd.com>
Date: Fri, 5 Dec 2025 14:46:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-4-Philip.Yang@amd.com>
 <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
 <fec99fdd-a8b5-4c48-a835-31ac604f3755@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <fec99fdd-a8b5-4c48-a835-31ac604f3755@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 905709b7-8201-4678-587c-08de34370a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzF4SzhCWWR3TTZFeGg5KzVheDFheUI3elNZaEQyblR4NFhDeTRQOTlwYUdx?=
 =?utf-8?B?M1NDN2U5MXJxVFdWYlJ5U3VwdWxFSFdxZWVSUlBLSmhhSGZidnkxWlFGdUNo?=
 =?utf-8?B?akFTcHZSRkNCTkhDRTljYnZoUS90cDZCbG8xYTJSK2dpYjJ3Y1dLd20rMnZ4?=
 =?utf-8?B?cFJQaFFDeVpraVYvNGIwNFhNMW45TWhiWExndnVwbU1zVG02Y01odTBpNi9o?=
 =?utf-8?B?MDIvb0JIeU91OUxGdHl1WDRoaFphWDd0bm9KMzZEZHIrTGRBV09CWGxIK040?=
 =?utf-8?B?YngxbjRHWTgvQ0F4OVozV0wveWp6RzBMOGpOTFBBQ3RJQ2VINUN5azBqNDhi?=
 =?utf-8?B?eWNxelRTOHlvNTcrRGg0Nm13ZjRReXZ3UFQ1NSt0YVczNnVkYVFKZnl3dDNr?=
 =?utf-8?B?UE0waHFLUkhIWW5RT016SjJQMWhGK2dLcHpnSkI4bHdWMldBR1lubnAvQmVF?=
 =?utf-8?B?QnFFWEg2VGFIRzFSaGVSb3A1WTNtQ0UwZ2xEWkM3UGtMeVpzOUhtcDUwT05Z?=
 =?utf-8?B?NHRrMzBYejdmSHQ0aUdaNTZIU2dTdU1oZGNTbDYxWlpJRHpDeXFsLy9CUVE4?=
 =?utf-8?B?ZkIyTmovUExJSzFwaXMvenlLWUN3b2cvWis1b0trZTlXTlRvMDluMGdQd2t1?=
 =?utf-8?B?WWtkVldjbjZ2dlovMWV4V25iMUtJTlZoWkd5aXgxeldta1E1RUlOM3hEbVg0?=
 =?utf-8?B?anF2Y1hXWnBMWkJUQzlzMnpMYWxyRkdmMnJmTEExdlhMb0NTUGVrQnZXNjVO?=
 =?utf-8?B?L2lYeHJDaGlRb0pjRTZrS1JaR2cxaVVaZCs0S0oyZ1RDN0JyYytkRXNQdjM5?=
 =?utf-8?B?SFFFQWtwd1FpcmlUdkt1QzRYT3lZVHN1STNmWVlPRjJrS0hWc2daQ2dKUkNJ?=
 =?utf-8?B?WmxIT1hvdm45c0FKZEJLdnF1TkVRcXFvR3E3QmZIV0hBZGtZMVlEQ0J0OTIz?=
 =?utf-8?B?UjZ6TG53ZG9IOXFiODFZS3hnbnYwK1Y1QUlzajNkMkJTa3ZPT2tEcEsxaHNO?=
 =?utf-8?B?MEdSWjBacktaODFrRm0vU21Wc01QMGp5VDBBcDRPZ0JPV1gvNUdnNllKM3Yr?=
 =?utf-8?B?TzN4czh3MHNuQ25yczdUWnZmT0ZqaDNyM0pzWTlWTXRYUitwWVB1V1lHNVp3?=
 =?utf-8?B?VXNIZFRHRDNNUUh0VlEyaTdEMk9VaDN4akMyYW8wTng1UnJLbXNTV2JCYVR1?=
 =?utf-8?B?YWhlT3d0clVybDRvN0VDWUJBMW04VmU0SjJQdEhJbE4wY1JjS2hNSjZIYVZu?=
 =?utf-8?B?ZDFqNDd5NUYxTWtxMlhRK3pwU0FOMThVNzZXNkJXSzZiNk9DdGczUWRCTGJR?=
 =?utf-8?B?WWhqL3ZzUnZOUVFGcmlyR05DdzNFbVN2UG1iM2Z6b2o1TllOakE2TlVzVkps?=
 =?utf-8?B?VU0zSEVZd0lpWFNKWTBSR2FtdmhEYXZrRTJRZUxyUHpCZW5pR2tpN0JmeXFM?=
 =?utf-8?B?eERlNkdaYlc5Q1VVU1FOb016SXBVZ1hqZTE2N1owUEVFRXNKbm44YVpMREZE?=
 =?utf-8?B?SktFazBHWlBXUXpxTlVwTGJ2YkhWMndLUGxnOWUrVEtEK2p6T3NUb0tRVWJm?=
 =?utf-8?B?MjFoSWNzVG8vRVA2VWs2b2xtMzBDRTNoNDk5ZTZWK09TL3NhVXZGa3pJVHg3?=
 =?utf-8?B?N2FpejFRL3l3M1FqVHhLT3Z5MEl4bXhTNkl6QmNtcVgrZlYyQ0ZKUDQ0b0RL?=
 =?utf-8?B?WkNlOGhocXA5ekJ1dnYxUTBHRzV2eVJST2JWdlM1eFBIdlA4bXZxeEdWT3RG?=
 =?utf-8?B?N2lEaDE4M1oxcmlYOWwrVHhBNjBxVzY2cm4zZ0dvaEZ4NVlFK3FLc1NBR1hk?=
 =?utf-8?B?RXVObVRxQXcxSTNMUC9nUXBYajMvaVdvemJJNVRDWHRGVjhwTDBSamxIL1kr?=
 =?utf-8?B?N01RTGRQT0dkZFU4RFB2RkcrRk9KeERsM2JqMzlEM25xRTBJZmwyVkJnVUIw?=
 =?utf-8?Q?vunccC0exxSNKtlROIpIC247gMKK76SP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZXMlZnQ21FbEFBQTU4ZzRESFlBNjBEbVRNcCtiSlBCWU56TzNXcnJWVlhN?=
 =?utf-8?B?UHNxR0xYMFhzWk9KNHkvbjNaNEtjRTlnOUtqc2ZOeHc3UCttK0MxZ0pJT1Jy?=
 =?utf-8?B?elFkUk1ERndNVERNM01XOUpiYVk0eUtlaGdmRlhud1pvUEE4bWV1SVNDQ29S?=
 =?utf-8?B?ZEVDd2x4NUp4cXhzTnBQS2JYN1FxMGRZL0FqUlZXS3dEeDdWNnBQUjNOaWJJ?=
 =?utf-8?B?b0YycWdoNk1Gd0plOVpzMW83emNoSDlrOGFwVks2Y0wyQzlmQnBKR1FrSWtH?=
 =?utf-8?B?MWhXTzUxMVRxRUFlZ0hRdjdMdkptOHhsV2czZ1UwcXY3eU5SR21DdXhPZnBj?=
 =?utf-8?B?b0hZQ29sWUU4dy9KeVNidzFsRzI3T21sb0wxcitnS2JyMHRWdmR2WVpOQ3BJ?=
 =?utf-8?B?Qy9CU3U2SmZQaGhHQmdTWFpXZ2FhTEdldGRPaFcyc1czdzJ2VkdJT0t5bHNZ?=
 =?utf-8?B?anV6eGtRdURkUFZKRWI0cVZ0NmJuVW9PMU9HVVYzdWM5dUVLMGIxZ2xtNWpz?=
 =?utf-8?B?T3R6OHpCM0U1TWkzc3Y2Vlc3NloyNm9EWkZjbHNOSDBqRnc5RWsyNi84bElD?=
 =?utf-8?B?cDlsMUJYRFJpS0dnZkw2VnBMd3hhMi95ZzFQeVVSMGJxWFBzQ2F5QW1qUFVr?=
 =?utf-8?B?cTFRYmtsbkJKRVZsb0RXeVFISHRYRU1jWTVnM1hreGRBSk1TeEVIdGhpdWxL?=
 =?utf-8?B?TWxNVEozVmptcERHdzk1QkQzdWRFdFQ5SEhrcWxjL0xwbGlwRUp3R0xJbTFm?=
 =?utf-8?B?azUzNElVSGhpZFU5eFdBbGFmamg1K3crYmphbzRkNmtEdkRVeWNMVnFNN2FE?=
 =?utf-8?B?OFNnUGp3cFhkVGE1ZS9CRnhwTUNGWmk4bWh3bGx1dDJ3UExUOUJQMXBrYWpy?=
 =?utf-8?B?Mmw5Q1lVSXB2Y2YvT0FUUzUvc0ZIK2lFRnZ5cU1mR3NIeWNPK3c3SXFWMFpw?=
 =?utf-8?B?S1l3ZkJqNUpYcG9FZFNPVGIyZ3lTVlk5SG9Kd3BxMURIMncyQVFueTRsVDlI?=
 =?utf-8?B?R1h0V0xSclowTjZLMUF4Y3lZZGV3N01hRUVuNmpXZ1ZweWJrSkh2WlRyZGRp?=
 =?utf-8?B?L0ljUWNNSExBYTVlSXBtaVZ2M2V1ckVpcUNQRUZjM1pHUFZmOGcyemFmUWxS?=
 =?utf-8?B?c3hjUWcraU1WWGJoZ3UwLzg4UHdvdXplNEp4aWNhQitEZkRVSkxPSDRrZkZF?=
 =?utf-8?B?Njg2TEcxejdMMlVOeUU4THFjN1FSaEVHWTNGang5KzlUUlc4S1Z6T2xtaElB?=
 =?utf-8?B?enVhM09HQldQUjNkalNCbTR4SEtabDlYZ29LelRGYzZjaWlOSE1sUGV5eVEr?=
 =?utf-8?B?OFByUloxYTNXZDZpVVJjUlMyaTFQM2hrMUR6UUN6RXZ4SSs3K2VSZ2drMmo3?=
 =?utf-8?B?dnovTHhRa1AvQ0xYbzhIQS9ScXE0VlF4d0g0aEkxRjViYUR3US9yZ3R4U1NH?=
 =?utf-8?B?dWdlT251QjM1bFJWZHh0Vm1lWnQ3dE9WRzJjZVk1QTE5eFlvdWZ3VElEVVhP?=
 =?utf-8?B?MVY3NU9mTnRweVBLTU5IREVXb200SFJqMjI1NDlhVk1CU3JLL3RlVkNrTkRD?=
 =?utf-8?B?QjVpOFhlcFk4VStxNDVWMGhGMi9CTkI2OG4wZU9TQTZQeFhXNDNxRlo1ZXcy?=
 =?utf-8?B?VUtVa0tnalpmdEVOMUJWZ203V3JiRXgzR09jQUhBKzljcjdqdUpmYXpidHND?=
 =?utf-8?B?TXU0c0tZZlVtN3pxTTgyTkg5TC90YmdLSG1PaEdad04ra1YyS1Q5MWZSRVpr?=
 =?utf-8?B?NTJOa0hpNFRZS0Vydi9vSWF4dlVMZjhScTlaakpqNG9Bb1VxMVZGekhTRDV3?=
 =?utf-8?B?MFhMbVlpU2hqazlIUzRqaWU4dVpIVFcwRmJ4SGtBM0tnZnVPaGJYajI2WWl4?=
 =?utf-8?B?TTRQTWxZeThYaUx0Ym54ZXcyNS9yWUkrZzgrTmdGb25XU1hDYlZpOU85WGNj?=
 =?utf-8?B?Yk1iSVdDNnl4V0JPOXpQN3o5c0JDcWVSeFdkTlNWU3Y2T1dMZ3BjRFpRU2lR?=
 =?utf-8?B?SGhVRnA4SDlzdVFBcnRucEdLSlJMbmRYM2trd0lSZ3FFMzVZOW1FOFhzOEpJ?=
 =?utf-8?B?eEJDdmhrK0ZZZC80QWY3clpJQzgwd3UyaGxxeHhhMTUvaWsydUVsVUcyR0s1?=
 =?utf-8?Q?kEiF9DMyR1ksgSIeO1Sl9SK4T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905709b7-8201-4678-587c-08de34370a2d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:46:53.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lr29SmJLHhsQP5uzQXDTj764kdC/xKAtTN0pO+KjPAbVBF5lAaotT4HalEBu73KjtTCgiRfrPn/EHWLmqfLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

On 2025-12-04 17:51, Philip Yang wrote:
>
>
> On 2025-12-03 12:55, Kuehling, Felix wrote:
>> On 2025-12-01 09:28, Philip Yang wrote:
>>> To reduce queue switch latency further, move MQD to VRAM domain, add
>>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
>>> using one buddy block.
>>
>> Why does it need to be contiguous? In the next patch you're mapping 
>> it in the GART anyway.
> Without AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, amdgpu_bo_gpu_offset 
> trigger this warning
>
>     WARN_ON_ONCE(bo->tbo.resource->mem_type == TTM_PL_VRAM &&
>              !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>
> This makes senses because we pass the FB aperture address to CP, this 
> should be contiguous pages.

That's right, if you query the VRAM offset of the BO, you're assuming 
that it's contiguous. If you're mapping it in the GART, you wouldn't use 
that VRAM offset, you'd use the GART address instead. Since you don't 
want to use the mapping of the BO in the FB aperture (because that gives 
you the wrong MTYPE), you should not need to use amdgpu_bo_gpu_offset at 
all.

Regards,
   Felix


>
> Regards,
> Philip
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 9cd1660b8f60..c11e37915365 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>>> amdgpu_device *adev, size_t size,
>>>       bp.size = size;
>>>       bp.byte_align = PAGE_SIZE;
>>>       bp.domain = domain;
>>> -    bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>> +    bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>> +           AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>>       bp.type = ttm_bo_type_kernel;
>>>       bp.resv = NULL;
>>>       bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index a489d43d5f64..c6945c842267 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>>> kfd_node *node,
>>>               (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>>               ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>>               NUM_XCC(node->xcc_mask),
>>> -            AMDGPU_GEM_DOMAIN_GTT,
>>> +            AMDGPU_GEM_DOMAIN_VRAM,
>>>               &(mqd_mem_obj->gtt_mem),
>>>               &(mqd_mem_obj->gpu_addr),
>>>               (void *)&(mqd_mem_obj->cpu_ptr), true);
>
