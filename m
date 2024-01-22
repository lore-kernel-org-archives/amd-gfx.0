Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B7C47DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 20:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB8310E7D5;
	Mon, 22 Jan 2024 20:02:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA49C10E673
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 20:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au2qgN5cz1bOMQNNNPCThBOR5q4NqSKNL7Ly1Ir4b5FCfjjmRNCySna19bAphgOsNd8c1qCZdo3QONQZNtAt+S8gyLVAxrWbsu+vwpQgyOo3qWr+K2YrsJnplV9W6NkTHzCfcZj6mKMNmIL7h4N0MovRi7Bg432B7sJK0ML9aEWRqL39pqGZSJ8ljp+VLOugzRggtVJ3ckv813wL5P5Y3YGX0Om4jDacjjtexAViWpCdvxhkdhraUMPl7F8H7lN8DzmhmTQlq5qBGOn3yZSXeEaKom2KlQn0Qxjf0I7iYsQXsDkdoFci2wA8twPG3/C0aORrMPtHdpyoFonghqgqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxrNBWjiC5NF5JP2bpR4m91aRUE7YAOmrW/D5+onvVo=;
 b=obsQjG2DZsW1GTEqLw41nV6N3zovf1SH7ztgQvpDZ75fJYH+XeUefROqUGzZytCTuQWpkRkqmJDame2eKgClXRg+uGR2FOolQ6ati9oLXxBQAunQaazBAWPXb5dOthiAwVIlbwxRNEL1r8sKWaQHfCMEiTHvh4JdgLZIKLw0jFfx9yae/SJIcZZIfC9Im88+CcbEc7OmCRQ9qk8UXtZJKXbHBNCeR6AUpYiijW2eX85UyX0Eveh9IwmMFlbh4KeyBV/0tyTLRXN7AImE0AnLLve6gq0YFYLUhRWxOApEbdSm/RJqAAIVV5wN3Q2s+ZEUf2lSlSblaesdNFrFywpDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxrNBWjiC5NF5JP2bpR4m91aRUE7YAOmrW/D5+onvVo=;
 b=vnmwwEiTC/xJDYUURr5CUKr68/dzrMQEWaccern8HvbUmvGAQmy/n80WjrYHuYyS+BLtjh6Uhjg+lrpWa0H6ARooHuPz/RSc+oHODdmL6I9OxCZ2w/d6VQnkEh9GniVpVSVQtvsIjCxyD/LYbEJNvfYgvP6vnSBYwF+bt9z8X5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 20:01:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 20:01:54 +0000
Content-Type: multipart/alternative;
 boundary="------------MjxoqavTa9YlFlU2iu5EpUcv"
Message-ID: <60b6ec1d-0e5d-4785-b917-8f6d3bac1755@amd.com>
Date: Mon, 22 Jan 2024 15:01:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add cache line sizes to KFD topology
To: amd-gfx@lists.freedesktop.org,
 "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
References: <20240120022118.2648843-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240120022118.2648843-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: YQZPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e83384-a68f-42e2-3bf3-08dc1b84fb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfHL2D0DNYQ8gSzUOgl20mUVAwX3QQGZfQIjnp66WkVM3+xPC8AbErp067+Ix5Rly5f3SJzcVkLfwaRdXyIa3z4tD4i7VguCEtjUw03F8dWRVgAEf1LfXyrHgBR4A6dwMg+anTfHPSr6DRLzNb9RJKlYc8Dh6dQjck3zOgQSi8gQIBrpryWReaJJdsDgYUk1UlSNQO4vd5d39Jqi9sp438ryGRibww1pMPnpGpagRxB5Z26pEljraJhF0FffahABRDS6p4nJln6wLUNxMRHBB03GDza4R9TR1UBA9ms/y/9GT2LtzNmmVCLJC3XWF6UPuifuCDxQrQYty7o5j3LIb1fXkp9OhNaUXkTZc6DNRivuFc2mqYqOtpyzhwvbYU8QdmSWzI2e58L2dmpPtO1ieCos1ggxCnUTgZ9o4Gj1i8SP3X931RPEBV/oOOliwc01/wopg6B3LhioMCHc4/du1F8khY96AvmtKa7j4qR2IbdfRxZy1f8rWJ5EtCsDBTSEMlvX2WGHOhPxi5tW0mC0USKL/3OWdq8ayny/XJliWbxfCiC84Gmj0hLcDw3mXxZ9hsDhg7cmMxRa2UJRVr+TVQ9ISWEy5F3LM8KbtlUKyHBSv2UZ9W5N/LTS9uvRv4265V5YauE4NHVpEPvookwpnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(44832011)(6862004)(83380400001)(41300700001)(8676002)(8936002)(31696002)(38100700002)(2906002)(36756003)(30864003)(86362001)(6486002)(5660300002)(6512007)(6506007)(53546011)(316002)(66476007)(66556008)(37006003)(6636002)(33964004)(66946007)(2616005)(31686004)(478600001)(26005)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1PY3JSODl0UmFtLzh5M0o0VDZWdVFSbGkzWUFWd2VDOVNadzlJaGlBa3JT?=
 =?utf-8?B?d0hycnJkN2xBc1FYdkdBQ1M4YVM5L25naFd0bzA3dDhKeVpKREMrQ3RRUi85?=
 =?utf-8?B?aDhJOXpUKzB1bXVWengycmZEdEFaZzlKOGdjYUw4T1djdVREeTExN3gzTW9m?=
 =?utf-8?B?UFczM3VPekNZV3NzYk1LQ0N2UzVFUENwbE9NQTF6Z3AzR0hQeXNCK0c5SS8y?=
 =?utf-8?B?SzIxQzJpUjFMWDIxWjFRSCtZaVNEcHFUVHFZT1BSSHlVclp4bFMzNWw0VDdU?=
 =?utf-8?B?UzBlT0k4MGxIRVZBWFhaYkJxdmZjWmp3VlJPdE1lVFVRYmY5UFlBKzFXMVJC?=
 =?utf-8?B?d294V0dmVGtkd2U2MHFYR2VLZi9UQzhITkxaTllEcjdiSXR3UTdjbmxXdUpw?=
 =?utf-8?B?Sm5ld2lnREpka0d6ME5KWVlzSS9uL2loaGIvQXlWdEk2U0F6aTYvU0pscnpN?=
 =?utf-8?B?LzdvT3hWTUFmWlpLanMyVUc4OWFZSmRCMm5JdEpKK3hjM0tGYXV5NEtVQXh4?=
 =?utf-8?B?VWlPdjJxQ21hRzdoUW92SEJ2Ym1PVUVmQTZkYzZsYWZMZnp5dGNtcDdYSWxB?=
 =?utf-8?B?ME53dmNxQ1pNK01pbUh0UlJIKzBxYjRuQkhqeERLMkNkSTRCa3lYUEdQM2tP?=
 =?utf-8?B?V3ZSd01leEdxUlNOR0l3Q1FlRWEyMXptcjlFR0I3QWMxeHJxS0dGNE92Mzgr?=
 =?utf-8?B?Kzc4U1RqU1M0RHBjRS9obWorTitmM3lIVCswQk9tdXBkNHJxS0hoSEc5Z2dq?=
 =?utf-8?B?OGYvREc2dnJDRGJRNEwxcDd1YnVQRjJtbExLUHlmaHNFL1Bua0lVU1BMaWww?=
 =?utf-8?B?cktUdit5Sm14cDhZdFF6cDVuM1JWUm9hRE03SjM2RTgvTjVKTHJZaCtoQ2lU?=
 =?utf-8?B?MHg4Y3dibklNelIzNk5QU3VwZGpOVDdGY05ZeVNzVVZtNFlJU0QvTnlMWWhR?=
 =?utf-8?B?czhraGhUNUNXdDlZaVZCZ09Td1dWM1ZCU0FQWW5yTHZZU3FmZFRWS2JmTEVh?=
 =?utf-8?B?RGxORklGTFl5YXVTSXdkazk0bjNsdGdpcFNhMTdocFNneU5JUTVPR1J5UTJZ?=
 =?utf-8?B?eE1XZVNiZHhVVEN0a1lLOFpBNEhucFZoOGd3THpQa0J1Umc2dkl4azJZdXJG?=
 =?utf-8?B?ZmdjWjMybjFYbG01Lys0KytZL3BpNHBzWUNFeEUvdTBMRUtDc1FpTWdQMFZw?=
 =?utf-8?B?SlhSWDNwcy9yb2Rxd0NBU1RYWGk0a29EMG41R1RhTUl1UVNocTNiN21RWWY3?=
 =?utf-8?B?N29tZldVM3B5MTIrQ1d0bldJNlJzNTRPZzBYOHZsME01bDdzWWw5QTVLczNB?=
 =?utf-8?B?Vm9hUWtWUmgyOWdPY01acVBzZXdwemJUR0lVVXVRcDhyRUNreW9xYW14VWpM?=
 =?utf-8?B?eGN4VGxNWWZ2NUJhamFRT09vT0hnUlc1Y1hhRVEvMTZzWTgyV0k5OHFPMVFv?=
 =?utf-8?B?Z0ZxTjlyTDN1UHo0TmE4cVVqSG1kSVlXaUxTc2xuMEpEbDVuWGxoTFU4aWpB?=
 =?utf-8?B?aTBFMytibS9lZVArMGk4eWZhZjg5U0dac216U3U2UEQ0U08ycTVMVGlralJC?=
 =?utf-8?B?ck1BQmV6SEFlN2ZneVlmRUFrdUcxWEUxalVVcTlLNklsSVNKM09wMFBVZTdw?=
 =?utf-8?B?MS93SWo5bUtzaGVOVTgzNG5LS1FUM3FmNGh4cXR1ZW12VWNVTE83OFVPQytl?=
 =?utf-8?B?ZFUvSXk2WDBXRFBUSjg1SHdZMGpDNWVPMTBrZXBXSURpZHVRTFpyUy81enla?=
 =?utf-8?B?bis5eE1uWkxIbGlySFMyWmpDU0VXcUZoNE0vTWJVaGpCY0RtQlJkQjJQaXM4?=
 =?utf-8?B?dEY4UlNRZHgwMjlqa0ZsMFdGSnFsRnFwZHhsVFdiUk9LNHNKcHpGdGdVU0ZM?=
 =?utf-8?B?azRVRll6MW5oenJVclY3TThUa1RwL1Voak5XOGVYQ1EwNE9IVCs0cDYxMzdG?=
 =?utf-8?B?dFpRSTFxdVFiYTlUM2dLR2FWdzlJZGFkM3BPOUY3bHBFQUx6Zi9kZ0w0TTlt?=
 =?utf-8?B?Tzc2SHIwaW5sTHBueUI1TW41Tm1RaUgweHFJQ3BKSUIvQkhZWk5YQnlTMVlX?=
 =?utf-8?B?TjgxWWNhdUxQSVBvM0w0TEdSVHpEVUFZem92Yjd0VHpHMXNaREZjb0x3d0R1?=
 =?utf-8?Q?bgs3rHZfG7oj+OGt47PO014ky?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e83384-a68f-42e2-3bf3-08dc1b84fb4a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 20:01:54.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU+AGcvOoc8v/9A2x6M9ugVtIRNrWv+ml5PtHMfS3BFPh/PEFAVn/oNe52W3htc+JO2petkD5WTAMvsOGnLd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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

--------------MjxoqavTa9YlFlU2iu5EpUcv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-19 21:21, Joseph Greathouse wrote:
> The KFD topology includes cache line size, but we have not been
> filling that information out unless we are parsing a CRAT table.
> Fill in this information for the devices where we have cache
> information structs, and pipe this information to the topology
> sysfs files.
>
> Signed-off-by: Joseph Greathouse<Joseph.Greathouse@amd.com>

Looks good to me in general. I can't be sure about the correctness of 
the information. Some observations:

  * Cache line sizes seem to be 64 or 128
  * On GFXv9 parts cache line sizes are 64, except on Aldebaran, L2 data
    cache lines are 128
  * On various Navis, most cache lines are 128 except L1 scalar data and
    instruction caches as well as L3 cache
  * You fixed L1 scalar data and instruction cache sizes for Carrizo.
    Was that intentional?

If that sounds correct and how it's meant to be, you can add my

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 93 ++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
>   3 files changed, 94 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index cd8e459201f1..002b08fa632f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -55,6 +55,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -64,6 +65,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>   		/* Scalar L1 Instruction Cache (in SQC module) per bank */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -73,6 +75,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>   		/* Scalar L1 Data Cache (in SQC module) per bank */
>   		.cache_size = 8,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -88,6 +91,7 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -95,8 +99,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>   	},
>   	{
>   		/* Scalar L1 Instruction Cache (in SQC module) per bank */
> -		.cache_size = 8,
> +		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -104,8 +109,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>   	},
>   	{
>   		/* Scalar L1 Data Cache (in SQC module) per bank. */
> -		.cache_size = 4,
> +		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -135,6 +141,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -144,6 +151,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -153,6 +161,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -162,6 +171,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 4096,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -174,6 +184,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -183,6 +194,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -192,6 +204,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -201,6 +214,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 1024,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -213,6 +227,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -222,6 +237,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -231,6 +247,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -240,6 +257,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 1024,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -252,6 +270,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -261,6 +280,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -270,6 +290,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -279,6 +300,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 2048,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -291,6 +313,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -300,6 +323,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -309,6 +333,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -318,6 +343,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 8192,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -330,6 +356,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -339,6 +366,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -348,6 +376,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -357,6 +386,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 8192,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -369,6 +399,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -378,6 +409,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -387,6 +419,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -396,6 +429,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -405,6 +439,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 4096,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -417,6 +452,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -426,6 +462,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -435,6 +472,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -444,6 +482,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -453,6 +492,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 1024,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -465,6 +505,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -474,6 +515,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -483,6 +525,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -492,6 +535,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -501,6 +545,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 2048,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -513,6 +558,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -522,6 +568,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -531,6 +578,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -540,6 +588,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -549,6 +598,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 4096,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -558,6 +608,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>   		/* L3 Data Cache per GPU */
>   		.cache_size = 128*1024,
>   		.cache_level = 3,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -570,6 +621,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -579,6 +631,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -588,6 +641,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -597,6 +651,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -606,6 +661,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 3072,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -615,6 +671,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>   		/* L3 Data Cache per GPU */
>   		.cache_size = 96*1024,
>   		.cache_level = 3,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -627,6 +684,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -636,6 +694,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -645,6 +704,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -654,6 +714,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -663,6 +724,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 2048,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -672,6 +734,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>   		/* L3 Data Cache per GPU */
>   		.cache_size = 32*1024,
>   		.cache_level = 3,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -684,6 +747,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -693,6 +757,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -702,6 +767,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -711,6 +777,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -720,6 +787,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 1024,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -729,6 +797,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>   		/* L3 Data Cache per GPU */
>   		.cache_size = 16*1024,
>   		.cache_level = 3,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -741,6 +810,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -750,6 +820,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -759,6 +830,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -768,6 +840,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -777,6 +850,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 2048,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -789,6 +863,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -798,6 +873,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -807,6 +883,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -816,6 +893,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -825,6 +903,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 256,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -837,6 +916,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   			  CRAT_CACHE_FLAGS_DATA_CACHE |
>   			  CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -846,6 +926,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   			  CRAT_CACHE_FLAGS_INST_CACHE |
>   			  CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -855,6 +936,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   			  CRAT_CACHE_FLAGS_DATA_CACHE |
>   			  CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -864,6 +946,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   			  CRAT_CACHE_FLAGS_DATA_CACHE |
>   			  CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -873,6 +956,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 256,
>   		.cache_level = 2,
> +		.cache_line_size = 128,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   			  CRAT_CACHE_FLAGS_DATA_CACHE |
>   			  CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -885,6 +969,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
>   		/* TCP L1 Cache per CU */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -894,6 +979,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
>   		/* Scalar L1 Instruction Cache per SQC */
>   		.cache_size = 32,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_INST_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -903,6 +989,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
>   		/* Scalar L1 Data Cache per SQC */
>   		.cache_size = 16,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -912,6 +999,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
>   		/* GL1 Data Cache per SA */
>   		.cache_size = 128,
>   		.cache_level = 1,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -921,6 +1009,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
>   		/* L2 Data Cache per GPU (Total Tex Cache) */
>   		.cache_size = 2048,
>   		.cache_level = 2,
> +		.cache_line_size = 64,
>   		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>   				CRAT_CACHE_FLAGS_DATA_CACHE |
>   				CRAT_CACHE_FLAGS_SIMD_CACHE),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index 74c2d7a0d628..300634b9f668 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -303,6 +303,7 @@ struct kfd_node;
>   struct kfd_gpu_cache_info {
>   	uint32_t	cache_size;
>   	uint32_t	cache_level;
> +	uint32_t	cache_line_size;
>   	uint32_t	flags;
>   	/* Indicates how many Compute Units share this cache
>   	 * within a SA. Value = 1 indicates the cache is not shared
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 83024c6bdd50..3df2a8ad86fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1564,6 +1564,7 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
>   		pcache->processor_id_low = cu_processor_id + (first_active_cu - 1);
>   		pcache->cache_level = pcache_info[cache_type].cache_level;
>   		pcache->cache_size = pcache_info[cache_type].cache_size;
> +		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
>   
>   		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
>   			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
> @@ -1632,6 +1633,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   		pcache->processor_id_low = cu_processor_id
>   					+ (first_active_cu - 1);
>   		pcache->cache_level = pcache_info[cache_type].cache_level;
> +		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
>   
>   		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3))
>   			mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
--------------MjxoqavTa9YlFlU2iu5EpUcv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-01-19 21:21, Joseph Greathouse
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240120022118.2648843-1-Joseph.Greathouse@amd.com">
      <pre class="moz-quote-pre" wrap="">The KFD topology includes cache line size, but we have not been
filling that information out unless we are parsing a CRAT table.
Fill in this information for the devices where we have cache
information structs, and pipe this information to the topology
sysfs files.

Signed-off-by: Joseph Greathouse <a class="moz-txt-link-rfc2396E" href="mailto:Joseph.Greathouse@amd.com">&lt;Joseph.Greathouse@amd.com&gt;</a></pre>
    </blockquote>
    <p>Looks good to me in general. I can't be sure about the
      correctness of the information. Some observations:</p>
    <ul>
      <li>Cache line sizes seem to be 64 or 128</li>
      <li>On GFXv9 parts cache line sizes are 64, except on Aldebaran,
        L2 data cache lines are 128</li>
      <li>On various Navis, most cache lines are 128 except L1 scalar
        data and instruction caches as well as L3 cache</li>
      <li>You fixed L1 scalar data and instruction cache sizes for
        Carrizo. Was that intentional?<br>
      </li>
    </ul>
    <p>If that sounds correct and how it's meant to be, you can add my</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240120022118.2648843-1-Joseph.Greathouse@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 93 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cd8e459201f1..002b08fa632f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -55,6 +55,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -64,6 +65,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* Scalar L1 Instruction Cache (in SQC module) per bank */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -73,6 +75,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* Scalar L1 Data Cache (in SQC module) per bank */
 		.cache_size = 8,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -88,6 +91,7 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -95,8 +99,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 	},
 	{
 		/* Scalar L1 Instruction Cache (in SQC module) per bank */
-		.cache_size = 8,
+		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -104,8 +109,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 	},
 	{
 		/* Scalar L1 Data Cache (in SQC module) per bank. */
-		.cache_size = 4,
+		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -135,6 +141,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -144,6 +151,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -153,6 +161,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -162,6 +171,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -174,6 +184,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -183,6 +194,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -192,6 +204,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -201,6 +214,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -213,6 +227,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -222,6 +237,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -231,6 +247,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -240,6 +257,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -252,6 +270,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -261,6 +280,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -270,6 +290,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -279,6 +300,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -291,6 +313,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -300,6 +323,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -309,6 +333,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -318,6 +343,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 8192,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -330,6 +356,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -339,6 +366,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -348,6 +376,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -357,6 +386,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 8192,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -369,6 +399,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -378,6 +409,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -387,6 +419,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -396,6 +429,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -405,6 +439,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -417,6 +452,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -426,6 +462,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -435,6 +472,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -444,6 +482,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -453,6 +492,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -465,6 +505,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -474,6 +515,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -483,6 +525,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -492,6 +535,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -501,6 +545,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -513,6 +558,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -522,6 +568,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -531,6 +578,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -540,6 +588,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -549,6 +598,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -558,6 +608,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 128*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -570,6 +621,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -579,6 +631,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -588,6 +641,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -597,6 +651,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -606,6 +661,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 3072,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -615,6 +671,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 96*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -627,6 +684,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -636,6 +694,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -645,6 +704,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -654,6 +714,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -663,6 +724,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -672,6 +734,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 32*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -684,6 +747,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -693,6 +757,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -702,6 +767,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -711,6 +777,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -720,6 +787,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -729,6 +797,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 16*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -741,6 +810,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -750,6 +820,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -759,6 +830,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -768,6 +840,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -777,6 +850,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -789,6 +863,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -798,6 +873,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -807,6 +883,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -816,6 +893,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -825,6 +903,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 256,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -837,6 +916,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -846,6 +926,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_INST_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -855,6 +936,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -864,6 +946,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -873,6 +956,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 256,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -885,6 +969,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -894,6 +979,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -903,6 +989,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -912,6 +999,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -921,6 +1009,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 74c2d7a0d628..300634b9f668 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -303,6 +303,7 @@ struct kfd_node;
 struct kfd_gpu_cache_info {
 	uint32_t	cache_size;
 	uint32_t	cache_level;
+	uint32_t	cache_line_size;
 	uint32_t	flags;
 	/* Indicates how many Compute Units share this cache
 	 * within a SA. Value = 1 indicates the cache is not shared
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 83024c6bdd50..3df2a8ad86fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1564,6 +1564,7 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 		pcache-&gt;processor_id_low = cu_processor_id + (first_active_cu - 1);
 		pcache-&gt;cache_level = pcache_info[cache_type].cache_level;
 		pcache-&gt;cache_size = pcache_info[cache_type].cache_size;
+		pcache-&gt;cacheline_size = pcache_info[cache_type].cache_line_size;
 
 		if (pcache_info[cache_type].flags &amp; CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache-&gt;cache_type |= HSA_CACHE_TYPE_DATA;
@@ -1632,6 +1633,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache-&gt;processor_id_low = cu_processor_id
 					+ (first_active_cu - 1);
 		pcache-&gt;cache_level = pcache_info[cache_type].cache_level;
+		pcache-&gt;cacheline_size = pcache_info[cache_type].cache_line_size;
 
 		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3))
 			mode = adev-&gt;gmc.gmc_funcs-&gt;query_mem_partition_mode(adev);
</pre>
    </blockquote>
  </body>
</html>

--------------MjxoqavTa9YlFlU2iu5EpUcv--
