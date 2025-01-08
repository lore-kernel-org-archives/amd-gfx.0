Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E6AE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0BE10E8F4;
	Wed,  8 Jan 2025 16:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/bjYa8g";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA9610E8F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzhViFm9Od9MaVCMKQP+no6XXLEfhgzgQ+gk4T37ginCOTx2zrLzCdhznQ/5vLBX5tbaB2L2BL5VJB6GphiwAfE9UnqthzSuA/PXPB5zpkQto6LLW8jOuA3nEUKfYiOsU9bG9mV1pzGdAQa6R11b5pa3ddjtCIJsYKU53YI5WlUKjGP7GgLkn3LVGNqGsBmtfv7XWrD/j56hNhOOF7xrSIAVbREBL4egqiwyxpEgxT6suzq8nXbCJxao4IcN5H8qZYRfhP6sFFqxpY/G12sWqECCWNI2VCDWtOSJoHGorDKZvnDo6QVC8UbaIqjFsv4nSe1hsSdMxCEshlvK5HouJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qtIjTjq21DKrNfhsBSuC/zf27F9IkoK3lnh+bWSKpU=;
 b=Rwk9F5tIz740LlxRT5duBRKHBd3eFsicfo7bzRjGqda3vNKg5wx128Ehatu1M8zVipg2fEq7e6C8uteyx7Q0fplECtELWvAsQU/T/LVpu8xxCqXMhCF99m1/tPKRX+tUyR+sby14gQ3G2d4Itov1Uu8Kn386ckv6VH6iH3/RaN5MeFiZI45VrwSYEy1DsFI+zmFqjqWyiKfwVaiDQY+FjA/d82G4a/deqv2G4T3oQiYURvZxf2qwIfEe7akfCOdIgOxBiLhyxbDwhtlgzR1chqvsIPUNUbHiMi5inVIF2LW06uhc7E444dxkMhvQI5BrebCFu6u3WrC1h6kg5rUAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qtIjTjq21DKrNfhsBSuC/zf27F9IkoK3lnh+bWSKpU=;
 b=l/bjYa8gzlQH0dYAzL1emZdy0TSatoilQ1DpsHlfWjFkgRo16jfkqwWKlHdOMU5EErkJI0fQKa4QweCAbmI9Z7Kn4nzDeXxmCAnVnuWHFubQobr3QXQyELRUYmzn0rMthrni8VIXIbsjoJEyOr71aNcm3B33SVAQzQSIWql5uKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 16:03:38 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 16:03:38 +0000
Content-Type: multipart/alternative;
 boundary="------------uCIpr0P7vxXbk2js8dF8c9qB"
Message-ID: <6be53620-6a98-4dce-aa49-fc5b913fc57e@amd.com>
Date: Wed, 8 Jan 2025 17:03:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add db size and offset range for VCN and
 VPE
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, veerabadhran.gopalakrishnan@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, christian.koenig@amd.com
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
 <20250106164530.763188-4-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250106164530.763188-4-saleemkhan.jamadar@amd.com>
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac6bd0b-bc61-4a1a-a9ac-08dd2ffe0390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUd1TS84T3RGQnFJMEpoSWwrZ29adkNtMm1Qb0ltczlWMDZ6d2VlS1JmZExE?=
 =?utf-8?B?a25BMXY3RzRrTHdQNk1lSDU0UmQzREd5ay9nSzVTUkRPZE1nYjlqMkxHK1or?=
 =?utf-8?B?b1R0UW1kcXFYUS9JeTdzOVlyUWwxNExsSGtMSWQxWEg2YVdGTGIzMndwZ3lv?=
 =?utf-8?B?ajR0aG9hSU5VYmxYamlHdFNFTEVRQzJqR3ZRdHZxdWZ2VXBUUzlMeE5YZzBt?=
 =?utf-8?B?c2lOYnFvYk5nM28xWVVwRlQwUnJTOGloSWg2VFpQSzZZWXhkVHZzOS9XQmxE?=
 =?utf-8?B?UTJqb2hnamtrQXZRVnAxd2xmNi9oTWxjQ3hkSDJHTzlZVzdadS9GUEM0d1dJ?=
 =?utf-8?B?UHFOa0dNalJpWm1zT1ZYVGtaK2YzNlRuSmdFMDhTbmhlbjhZZmhPUHRsUXVj?=
 =?utf-8?B?T0VKVUY2NlQ1SGMxazBIaUtjYlh2dGdJYmFQL2dKUWNzVjlBV241NUd6MjBa?=
 =?utf-8?B?V0tlOG1yVjhsZEJsT1hybkdnTXNnWXZ2OGg1d1pEVENxckpZUDRCcnUyR2RL?=
 =?utf-8?B?THRDUkVDZkl6K0luclJzejE0V0RxWVlCTDBRcFdXdjJkcE5UU1JEYVEzVVpX?=
 =?utf-8?B?WE9mNGlrc3BaUGt6eDJpbmNZRDhXRXFLblBHL1RaSk5SN0VTMHRSNU1lVzls?=
 =?utf-8?B?Z2dRUmdTRUJwSDVhTHZBL0FmUjhVY0ZtdjFUL1hTY1JuV0xLc1FLLzFyeHRa?=
 =?utf-8?B?MGJvMGJMeEtxSU1Db0MvenFXYWdSUndEbzYyaWE4Si9LaEFCQzVkcm9tRFNi?=
 =?utf-8?B?ZHJHc2pRMU8xUDNvV3AzYU5NNStlWDJCa0ZUUnlwWElhdWtNNlhkdFM3YVd6?=
 =?utf-8?B?OTgzSWFEWUVjLzJEWVNQMEhoRmJsbmh1NnVVODNRcU5IVnlKaHpZRkRXV2xz?=
 =?utf-8?B?bmlSeWJVcWlQQTFjY2JyMXBhTGR6aCtFSWVpUjZHWThKdTVVMFB3LzFsVk4v?=
 =?utf-8?B?dWZnNUdOMmhpU2JQWWoyT3lpRTY2enI2RkN2K3RpMUpSSllJNU9hbGpoa0dX?=
 =?utf-8?B?Q1NITlpERlRFRm94MGRJL0RQYStpVEw5ZjRVekQzM1g4OWFVZ1NnMndsUjhR?=
 =?utf-8?B?NWhIWHlZQ3l6bmxNRC94Yjd3RThMOHhTRFZ1emJ4ZjUrbWwyaEtRYlNIOGdW?=
 =?utf-8?B?elpNQ213SWgweWpvSi9sUE0wcUxJZzBWanNDV1EwNnNhcThsd0JsV2ltcDR6?=
 =?utf-8?B?WXVBZi9ueE9xeHEvaUdrbE9YYTBiSS9DYW1hZzF6c0QvMmhwZnBrWGpKcWJr?=
 =?utf-8?B?aWxRMzZoTWJEOG8wbVhlK0FTWnBzT2JHMndoa0ZOWFBwQVJ6WWwyK1M5SWxF?=
 =?utf-8?B?L250ckx2cDRCT0JmTFE0M01BRHJrOURuZkJaSzhoN3JRZmRlcjBKeDRrQS91?=
 =?utf-8?B?OTRjSnp1dzROTGhsQUtGK1JWd0U4YkFZd3RrY3JUcUwwaFU3bis1d3VndERE?=
 =?utf-8?B?SnpKYTJnZ3JJaW1QSlVkbjlINDhKbGZsSjRVdHhkem1XSUczZ0RCTWlndTNQ?=
 =?utf-8?B?WGtXUUVNTU1EVStoazRuVUZSV21nTFBPKzBzRkFDYThLdVQ1WXgwazdSdmk2?=
 =?utf-8?B?K3UzZW8rUHJ1dFlFaElTN2RYQzhjdmVCWGlCZERxRXllN3NRTHRUSDA1NHUy?=
 =?utf-8?B?bWhQZzlSeE9rUlBSdUc3c09NaXZTZ2pjNjRDcXR5QjdXQWJUbW8xQm84c09t?=
 =?utf-8?B?RE51aWhnQjlRWUpyeFlncFVMbzQ2M25SaTdHaFZhNGd4TEUvVXp2U29YYjlV?=
 =?utf-8?B?Sm13K1luMjJvODBnbWlXM2c2clg5VGZrYm9hc29TSjBNZmlRWGZTWUR4d29X?=
 =?utf-8?B?a2l1aUhuWVNsRkRsNEJhU09wbVdQMUlMdEI2UXJhMFJQdVp2WnB3d3BYOG1F?=
 =?utf-8?Q?X6MG1qj3cHL7J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndhN0hsbi9CU3dkSHlCcWpxQnlMWWtXU21kSTlIUVpnL1kwOVByRUk3Mkx3?=
 =?utf-8?B?a01SRmlJTGdsejl0YVRQdGFocGlveG96ekx3Sy8zc29JWlVocmlmNUJVek5R?=
 =?utf-8?B?Z1pDMlNTY1J1dlFhOHRtVVFvaFdhcmdLd0w5VVNZY2xvd1VhSUVEc0tURVNK?=
 =?utf-8?B?MEdiaHBFT3pUdG5zL2ZCbFhZckpCMDJCdk41bmU5eWJMcWNiNUhMRHVGdFBq?=
 =?utf-8?B?TlNOUHlRR3VYUC9YMnNFWUJNbkluenBpb1h1eStJUEpKb0dHNk1sSW1jUmlG?=
 =?utf-8?B?YUZpSVNhZVQxQ3lGbDhOUXkxUnNIS1BuaEhmTG1VTWtRY24wa3R1RURZKysv?=
 =?utf-8?B?MU9hcGY1TEhVS1d5YVVEcUsyUGhZMjFOTUF5L1NZOXJ5MHE4K1N2by9tbHEw?=
 =?utf-8?B?TzVPeWJ0T2RsSWQ0RnJUc1YxRWZSd1M4a0FjK1loN2NMY3dmU0lHVHYvc1VI?=
 =?utf-8?B?VWpjZUZ2NWhiYng1OE9sNzhDelhZRVNyYllaSjFCWFdHdnA4TytWTFlDdUdv?=
 =?utf-8?B?UStTR1MwNDNibUI0K05HMzZmWmxrQ1dIZXlRQWxrQnJmSGxzcUpZRExXTWdZ?=
 =?utf-8?B?R2JZcDN2K3pTU1JjZ2VZM245d05kaXE1cE9yWi9uczVYcmlDY3lQSWs4WFpP?=
 =?utf-8?B?MlRyZmNRTVRpWkdNdDIvMnlUM0U4MlczNy9HV2hYMG1UZW9pbUpUbFBTY25s?=
 =?utf-8?B?M21FRlZ2VGpDWC9GQnhyNGVxeHFYNW1iMTRVMmNPYTdLRWxoVUVtRHp1a2xq?=
 =?utf-8?B?eUp4ZTc1S01ydTAybHpOY0JkamtzWExpUTZGMXMrb1BOekhDcENwVE02aUIv?=
 =?utf-8?B?RVFQV3FTSm5NRStZRXRuNWpqU3VibmRTUHQ2SCtTUFU5Vk1EY3RWdlhTRlRR?=
 =?utf-8?B?Wng0MFlrYUErcmwva2x5d2xqWWVhSEZHK0ZIcDNDSm1tSGJOREZYZHpZSVJi?=
 =?utf-8?B?cWJqZWpaYThWeTFXWHBOdm1YZ3c0Yk4xcTdXMklkeEFnd0dpNWJDUHZoSUVW?=
 =?utf-8?B?aG9YOEJMQWhwZFQvRjZhSmZsSUYxWmpLS3pGeCt1eHVDNm1TMjFHR2hwT3Vh?=
 =?utf-8?B?ZjV1cXR5S2VhajRRU3JNKzUyTXYvK1ZtTFFZRTJyZEJxcURzQVF5RUtiSXJp?=
 =?utf-8?B?QVlTWE01UnZZNzNjTHE5bkNPcWNYUStoNm5NTTg3OEJIZW5CdHVyMncyM3A5?=
 =?utf-8?B?dHh3SmVBY20vYnlYcFhmRTNmcmJVK2RIWjhwT0p2Nm54dTVLT0tvRHVOVjVD?=
 =?utf-8?B?bzcvbFlhUkZZN1FpdGQ3eVdLbXEvUC9vQU14OXRJYjZsakwyVUhtc0VzMjNL?=
 =?utf-8?B?UjN0cW5USHFrbmk4d21uRjIrSWsxU2FEREg5UUpDVlQwam5xckllR013NE9v?=
 =?utf-8?B?L3pBN2x3VVJHdS9aek02RERMUGhubDYwUXdkVE5zTnBHdXZSeUhKYXVMbW9y?=
 =?utf-8?B?QTZiaGJqdmY0N1dSWmJHRGtrZG9OOHM0MEZKWW9SQ0x5U3R5dmR4aThwMDd0?=
 =?utf-8?B?UHNrejFibTVmaU1BU3IyRXVPYk1BclZYVkhsNHFyaUdLamY5RDJ3bXU1TTBP?=
 =?utf-8?B?eWJXdEQ0RlJudFdqSWJNWmdMSS9NY1dnU1I5c0FidWxIei8vQUgrL245TzNp?=
 =?utf-8?B?bUFkcm5Kc3QxeXZUdmphVTR0Qks3SVNwSmQxWEFmNTZydU44WGVWWW1rZjc4?=
 =?utf-8?B?cXV6YTlQMHVmcFhLelVMVTl4ZHRCTTNiSnNrOHpHemhyeVY5TUppMTNtK3pY?=
 =?utf-8?B?VWVUME5zNGlUN3hnQXNUOTB4T1ZKNUJMTlkzeFltWGFXZSs5ZWIwUGdxbmh0?=
 =?utf-8?B?dENubzZQbW1BekFWVmdBSmlFNmpXcExJVkZldFBYVnQxUXpaZ3JJL2VldmNO?=
 =?utf-8?B?SENTUEJyaUdZQXU0MEJJL2JZbXM1MlJYbXlhUE5SKzV3Y0NZZzN4Nis4NHB3?=
 =?utf-8?B?eE1ZbXE2aHNOSW5sM2x2Zjc1Vjlja3FEUE9CT1hRQkUzU1VObERUU1JpVHVM?=
 =?utf-8?B?VFZNZHl6N2dvQnJsdDVZQXNsWk1OMGdpMGpBOXNrbWFmUTVmL3VKZXBtZjJM?=
 =?utf-8?B?Ym9QS2xkT1J5a1hVSVErOC9UL0dvbVFKbi9GZGN0UW90RkhRbzdDaExlRkEv?=
 =?utf-8?Q?H+ANtRl6iS4PNj+O9JfZMBNzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac6bd0b-bc61-4a1a-a9ac-08dd2ffe0390
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:03:38.8135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++2vIQYd5Xa7VxLFZPYIBKv/lTdD+obdeHgohHLdyDUm7f/CfN8pznlcluHo86n/HpfDz4VQh9NspsfOoEM+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
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

--------------uCIpr0P7vxXbk2js8dF8c9qB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/01/2025 17:45, Saleemkhan Jamadar wrote:
> VCN and VPE have different offset range, update the doorbell
> offset range repsectively.
> Doorbell size for VCN and VPE is 32bit.
>
> Signed-off-by: Saleemkhan Jamadar<saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 769154223e2d..8c9a2f42116c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -222,6 +222,21 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   	}
>   
>   	db_size = sizeof(u64);
> +	switch (db_info->queue_type) {
> +		case AMDGPU_HW_IP_VCN_ENC:
> +			db_size = sizeof(u32);
> +			db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
> +		break;
Please check on alignment with switch(case), checkpatch will get this 
one as well.
> +
> +		case AMDGPU_HW_IP_VPE:
> +			db_size = sizeof(u32);
> +			db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
> +		break;
> +
> +		default:
> +			/* FixMe : handle this after userqs are enabled for suported IPs */

Now I think you can add cases for GFX and SDMA IPs as well, set size to 
U64 and then return -EINVAL in case of IP not recognized (default).

- Shashank

> +	}
> +
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>   					     db_info->doorbell_offset, db_size);
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
--------------uCIpr0P7vxXbk2js8dF8c9qB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/01/2025 17:45, Saleemkhan Jamadar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250106164530.763188-4-saleemkhan.jamadar@amd.com">
      <pre wrap="" class="moz-quote-pre">VCN and VPE have different offset range, update the doorbell
offset range repsectively.
Doorbell size for VCN and VPE is 32bit.

Signed-off-by: Saleemkhan Jamadar <a class="moz-txt-link-rfc2396E" href="mailto:saleemkhan.jamadar@amd.com">&lt;saleemkhan.jamadar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 769154223e2d..8c9a2f42116c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -222,6 +222,21 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	db_size = sizeof(u64);
+	switch (db_info-&gt;queue_type) {
+		case AMDGPU_HW_IP_VCN_ENC:
+			db_size = sizeof(u32);
+			db_info-&gt;doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 &lt;&lt; 1;
+		break;</pre>
    </blockquote>
    Please check on alignment with switch(case), checkpatch will get
    this one as well. <br>
    <blockquote type="cite" cite="mid:20250106164530.763188-4-saleemkhan.jamadar@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+		case AMDGPU_HW_IP_VPE:
+			db_size = sizeof(u32);
+			db_info-&gt;doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE &lt;&lt; 1;
+		break;
+
+		default:
+			/* FixMe : handle this after userqs are enabled for suported IPs */</pre>
    </blockquote>
    <p>Now I think you can add cases for GFX and SDMA IPs as well, set
      size to U64 and then return -<span style="white-space: pre-wrap">EINVAL in case of IP not recognized</span>
      (default).</p>
    <p>- Shashank<br>
    </p>
    <blockquote type="cite" cite="mid:20250106164530.763188-4-saleemkhan.jamadar@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr-&gt;adev, db_obj-&gt;obj,
 					     db_info-&gt;doorbell_offset, db_size);
 	DRM_DEBUG_DRIVER(&quot;[Usermode queues] doorbell index=%lld\n&quot;, index);
</pre>
    </blockquote>
  </body>
</html>

--------------uCIpr0P7vxXbk2js8dF8c9qB--
