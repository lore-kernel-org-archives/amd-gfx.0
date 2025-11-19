Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FDCF258C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 08:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41353892F2;
	Wed, 19 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyN+UDhg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293C3892F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 08:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJXsUXYwTpgq4ANEM4nJww5i2F2jBYc8S0/ENeSzFd3dGGcmYm/ozO66UM00g40YSJQ5jS3IavmT4ZtHSTH0wErPTAqEgntGrnuo/WVNv0LOAyLh2tT7W4vBI9LOBIjjn8obejwr2lFIlfEN9B+FY9m8yTUvx8/4t2osYgc8H+w/WixSqLsbqe3Tq7/NCTX1uG93ozsabw5ZASn9nTVkj049kGt1jyN9UoeMNC6x0oR0EYANwp+SZkbcmJt+guaeE7rDE5wKkTbcQEXHUxYGSnTc/cvR0oIzT7qd8xDc8L8+ZhzdRnUUU0Asn6nqcEOaO1wNHjC9090IPrEsWb/C8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T+OIT/+UW4Z+pFsBaQkAK9JqI/ZLaITGnpfSLfVdvY=;
 b=Aw/upPiS6B0y0gU9Cqd5T0ltE5QPYX65ybIVIqiDiJijXIlQWjEYbSPyJbEdCTGjmkpCPGjox/R2Ft1p9VybppWlcHI3nUl8hj2msfT424jKvfM6Bk508PXRXSeov8nIOxY7uG3KkC3SKDR2qvTekA/27e0aoPd5QjscnyK6tmvebnx6us9TxWxbd3i5zPhgX3gcWMC9ZTLYl3xmhEfLGZ1JBgo5j34F5PzR11BIcR0M3pEZFCC5CnG63x37ZkHwzvAdRQ+qeCloHEeNT3ONmojMTFUbOVKPEoJAMFfe0te0iis1FzE9YGuFV5SeEU7E7gunxsCHwxOB4lFvFWJmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T+OIT/+UW4Z+pFsBaQkAK9JqI/ZLaITGnpfSLfVdvY=;
 b=zyN+UDhgLobOeDceCOy97XVUidb3zBZlCUmXHUl2ycMx++kat7NwPb6sFSFvh9JkqSjJX1Yhynb1ktuLj6xikc0KgAq2LDgUxjsey7ZK7Rj+wIDUx4ntUKtZKPoWRHtwcddfqP2Jyp7JnDnLswxwye8sJ2/MkU7ByQAdh4EVbl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:34:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 08:34:41 +0000
Message-ID: <c2e00046-7160-453e-ac46-5d2647b31769@amd.com>
Date: Wed, 19 Nov 2025 09:34:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation/gpu: Add PRT, PTE to amdgpu glossary
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20251118165620.216753-1-timur.kristof@gmail.com>
 <20251118165620.216753-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251118165620.216753-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b022752-8d80-4595-4a12-08de27467bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXJJQTkvZTROdzc1K05UZ2YvNVJTKzMxS1hnNkU2aTE2b2xkWnZIeTh2djZO?=
 =?utf-8?B?emlMbWRlMnlWUWVDbW1ENmFBRzBuUHYvOEsxWSsyVkdLbk44ZXg0TzZ4L0Rn?=
 =?utf-8?B?QlhkU1ZTNXVPd3B2M01XbldsaTA2UEoxRU8wUmxCT3NqdmVtaHlkM2JKK0xS?=
 =?utf-8?B?OGh4cTEzTlJCeXhQdDhtUWgwOUY4UkdxcnlOQVFxYlBvS3FnVlAwOTBFZUZs?=
 =?utf-8?B?NnppNWloYThXNzFWNXI0cDFMbUt5VHd5MUdHWE9XS3NsQWpreWl3TmNrMENp?=
 =?utf-8?B?N1pTTnZDU2IrRWJkZTNrWVFKczFoS3JTb2V1ZHlnMXVBTERERUR2WE1HQUhK?=
 =?utf-8?B?NlpTMEorRGgrWE5HNTM3M1lLeE9ZM3NsZVR0MEhnRGwxc1NYSXFmcDVZRzk0?=
 =?utf-8?B?WEdlalhqUno2bmRZdHZNVkxDUnU5V2p3d2grc2lNQnlBbGhyaFBsOU5lTkVT?=
 =?utf-8?B?NitReTZJVjJYUU44ZlZaQzladHRjN0VZZDBlellJVTVFYmRGUlY3ZDRDdnFm?=
 =?utf-8?B?L3VPaE9pdHAyNFlUcDdRMjdvWU44Z0Q2YTNGaXUxaUxSTkMvUVRSTW4wa09I?=
 =?utf-8?B?bDhudW5Gei9ucW9CV0tOYTJTNFYzcnl1UmdVVUd5OThTMzYvNFY3UWNDMnBw?=
 =?utf-8?B?M3NOd2hsaDVTQWhoclAyZXVndnlmNHlUV0gzVDhTTlZMNkFGWVJ6YUFYMVMr?=
 =?utf-8?B?WUs0RkkyRC81UE1Bcy9CN0g1K21hbGtSRTE4RkpiNVB3Z1JlWnpGQTdUMnJo?=
 =?utf-8?B?RHNPbFJFaDJNUVdUTytsdis4anVnMFhBVitFOVdxNVBxb1IvcUQwbEFYbHJ3?=
 =?utf-8?B?d0VsRWxpRjZTd2lsa2hIM2NodWxwVG1VRnpGSFpMak1wL3g4dkZTWVNkMnlV?=
 =?utf-8?B?VUxzeGlURnFFNGhjdDgzRlYrWjQxYTdpOWFQTElSUUtlQmh2MXNwMlRQeUhV?=
 =?utf-8?B?SXpkUzM3UHp5NW5LNDdVOXltVDRpM2grd0xIb2VYWTRVSE1tV3MxNU12bkNo?=
 =?utf-8?B?T1Y4VXZhb1FQaWlsVmF3bmppWllLRk5mMXV6Mm9oWEwwa25IeEk0M2s1QzVB?=
 =?utf-8?B?ajJQSmF1eExTN1VJRnY1amZqdENWOW5JWGdSSTJCWkFQSGR6dWVGL2dEOHU4?=
 =?utf-8?B?WFlVQmdzOFZJSGg1QjJ2a3lsbGZjY0wwVlpYWEh6TnFicCs4a2RSSmdpNlI1?=
 =?utf-8?B?MmJhVjZNckZ5RFlXT2VkcmxnbzUwTlFLOFlQcmw2R1hmMVVzYWJLTW9HdXN0?=
 =?utf-8?B?K1BuZ1Jsc3l2Nldpa3ZFeHRvRDFYZnpGaHNNaktRdUxraFVTblRyMW1QTzVM?=
 =?utf-8?B?TlZ6ZmllRC9rV3lWTFlRYUh5blMvckJjQ3c3aEpFVFRtTDRvMWFUbGpjbGQ1?=
 =?utf-8?B?dTRCR0ZtcFNBb01hcnJLM1R3aDd6SUptR3FqcWN3T1BPNnA0K2srVGtndzNx?=
 =?utf-8?B?OWN3a00weFdWV3NsOStvQ3dYa1lObkNTVjVETUJNaXowdkhZRUp0OW9UT0Z1?=
 =?utf-8?B?aEJseW1yMmpCWTBkQUhpT0Zyc1BrbFZEYjhjSUJVZkRFUDBqUFhTR2JHcVlF?=
 =?utf-8?B?SEIydHFWczE1ck9pMEt5KzY3TlplQmdUWEQxaXlOcU82V2k1eVhVM3pNT21W?=
 =?utf-8?B?RU5xM3ZuVlRUK1N0OVhFVkFpRG1VS1ZwWDNPcEl2WTJKMzErSkh1ZHVXNzNo?=
 =?utf-8?B?UUc0QVVtdGRaRTZhUUd0RlRDdFFNSDczbk9EOFBoZ0xzN09GMlpoS3NneXpD?=
 =?utf-8?B?MkVyYkx5RmdFMldLRGt1ZjI1V1RzWDRMZVd1S2hwOGJWbG8weXZ0bS9Ud1R5?=
 =?utf-8?B?Ym9zdjNLUmZRZFM3cy8vTEcyLy8wWkRlQW45c3oxS1dzQzcwMXhhUmZqMFg0?=
 =?utf-8?B?SHVYNnZPTkJZcmNaWlY0Z2N0OWo3WkE3SXpUaXJTbXRLY0JPdVY5MkJ4RzN2?=
 =?utf-8?Q?WcDcpsHN454E5GpdKgkPOewZLdXshYGL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdkc3dkNHBvS1BqVjNZZm1LY25ZaGp5aHJVK2FiNE0wVkV1aGRra01pM0lG?=
 =?utf-8?B?TG50UW95aHFpZURxUk9vZnBaTlBwSFNrbkZsaDBCU01nMDJQMVVHM1p6b3BB?=
 =?utf-8?B?dFFsekttVU54MXl1QlBBdy9yYXN1TTVRM1ZTRHFVaVh4MUlNYjFZTlA2TFpw?=
 =?utf-8?B?eG9BalFDOTFWMkRvdEV5Nk9pbVFjUVhKdWNFSXIvOHpVYitUSkxwOWdlMEw5?=
 =?utf-8?B?Um83c2xHSTNJaGhBUERRbktlYWNnK2R5MUlrT2NmZ2grRkN5QXl5T2F6Qll2?=
 =?utf-8?B?bTdiRmtLbFZRSklrWG5sVVBXSUtxNUhBdXJNOXZSZ2VLVUZlMDh5b1RUWUhx?=
 =?utf-8?B?Y2krL0dOQlRRU1hlS2EwVXBOUTdiMDdIVnRTUXJnemNYSWlXYklUL2VORWVQ?=
 =?utf-8?B?dTluSjNBWSt2eDhEbGJHRXdvNnk0NXl1T2VoMmNobzZOTXVuekkzM0ViREhn?=
 =?utf-8?B?eGpWdENMUlVYeWF0KzJqUjlWSFljSS85MEhoRENYSENNUm5BL1pQM2xxTkE2?=
 =?utf-8?B?eTJpcGhsYm4yTWVQQWE1MlgzRERPY29naWdWTTJWbmtPbEhwQ0pzbmcxY3NV?=
 =?utf-8?B?aExRVkxHVE53OVRWVW53Sjg5VWRHZ1dPd3QwLzVmUEUwVW5YRVluV3h0bnFN?=
 =?utf-8?B?ZGVuT0JrVElXNEZGZjZ1RlRlWHM2dGg4Vkp1S2RGRVJaNG5xWDIvL3RrWmZv?=
 =?utf-8?B?T21TUlVUQVNMRzhXWGJ5bHl6WTVTT1RpOVZMdzExdjBqVHR5N283TWx6enlZ?=
 =?utf-8?B?T29RVXZTL1hWUDN3NWVmV1JWS0pEU3UrNGJOSVN5eXpaL0FVTFR1Z0pSd3Fi?=
 =?utf-8?B?Mkh3SDZyZDZXbUhkeXEzYTRCRnFQRWJqc1R4cWYwQWNib0h3M21oQi9tYi9z?=
 =?utf-8?B?L2lmZFhTLy96ZU5mQVZ3WEw2RDJCbno5Y2N0a0I5bUhnNTMzRFpmVDZDcytC?=
 =?utf-8?B?ZGJqYU9UcW56aEZnSE1JR2JTWk9nN3l4VjBxMDZBb1phQWdSb0l2d05mWnhI?=
 =?utf-8?B?eC8wNCtNYzVDTlJOWWExRGZoOHRQcmdiN0hmZkZFY0dBQjZjWWl1Q2R6TWI2?=
 =?utf-8?B?by9HSjZQQ0ExaElKUURIWE05UVEyVk5LbzhGVFBKQU9qbXFMdDN6Wkdva3E0?=
 =?utf-8?B?M1JRSVdHd2lISTVVbytpRDFpYVJVcExxZ2d4QzFQMEZxN2NyaTVlZkxFcDBt?=
 =?utf-8?B?QlJXMjBZdEJVSXM0MVZML0hpT0xxb1hWUUhHcFdPK0Ewc28wYTRlTDQwZHlr?=
 =?utf-8?B?NnRZNzQwa0h5N0lGMmpvMXVwZmRkZ0loMitrQ0dNaHVmQlRHbmtNeDRwM3c3?=
 =?utf-8?B?WnJud1BqUWdjb3pCazNXVlR5ajRjUzZ4OW1PM2IvWHdrMnVYckN0eGZtS1FM?=
 =?utf-8?B?MTFRSEVmVXVZMytZNE5MQ3drY3NMWnYwK1FwMDhPcWMzL0JWZGh3OHNDZk1k?=
 =?utf-8?B?MGZWMUd5bFhJREpEOWlMY3FoOWQ4OGtTS3BYUGRkNTFiTS9pS1N6TG5hQnpp?=
 =?utf-8?B?K2o3N1BtdzlyUlkyY29EZmZmN3R4V1REdExoanByRXhvZXlLU0swWUpNemc3?=
 =?utf-8?B?N0g5NzN6bFpWS01NSkpsSTJSL2RDQ0JUdkIwejZSVldwMGRqUXFkS2hXSytj?=
 =?utf-8?B?NnVGQW9sL2I1QkxUbzlybDNkMEgyWTJaa1hUVC91Wkd3NXhiV1libzA2TTF1?=
 =?utf-8?B?Qmd5clpXb3F6QWlKOVZUUld2SlVMTGdMMjZtOUlYMDZlaUZ5SGxJWTRhalhx?=
 =?utf-8?B?dmd3SFNSbG9NN2h2aTJWVnpNSnA2MG5QNytYUHAzeGx3Q1h4cnZidjB3L1c5?=
 =?utf-8?B?YW1zY1JOMG9QaFV4UTZkZFBCZFZnWFFpK0dBdW9tZCtMZis3aEFlYkFyOVhR?=
 =?utf-8?B?TFgxZFhYM2hDZWUwNXNRT2hJdnA3ZmVPVXJhOWxSZFhDNjBWWEt5VVMwaEZC?=
 =?utf-8?B?L0xwQjdrUGFXb09mcEZXbVRqM29DUVVyYThOTUsxbGd3T0V2QjhBb1hXUW43?=
 =?utf-8?B?SW1oL0ttb3hnaitKZ3J4ZW9wcFcwU2dCTklkSjhTdlJ4WUhGKzQ5cVh2b2RY?=
 =?utf-8?B?bTFYd1Fwc3hoRjFGUm81SkJ0eVRJbHJFTWxvT05vY3BsazJjSE5Qdi9CVUhF?=
 =?utf-8?Q?NR+YEdUbUSaZvB68yAqvNlIYz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b022752-8d80-4595-4a12-08de27467bb6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:34:41.2911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv1a8TOz6O2SKlRBsFN9hjjBJT+J3F9jLqZmyal2o+9p9VEX6htHv/m1lNBSN8/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

On 11/18/25 17:56, Timur Kristóf wrote:
> PRT = Partially Resident Texture (aka. sparse residency)
> PTE = Page Table Entry
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..1270e2c42ec6 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -149,9 +149,15 @@ we have a dedicated glossary for Display Core at
>      PPLib
>        PowerPlay Library - PowerPlay is the power management component.
>  
> +    PRT
> +      Partially Resident Texture (also known as sparse residency)
> +
>      PSP
>          Platform Security Processor
>  
> +    PTE
> +      Page Table Entry
> +

While at it maybe also add PDE - Page Directory Entry

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>      RB
>        Render Backends. Some people called it ROPs.
>  

