Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDBCC27C7A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 06:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60AF10E1B2;
	Thu, 17 Aug 2023 06:42:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C04F10E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 06:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVdu94qEZS6Zt1NV7oLmkFwBCRb4T+XDYx8CpSxZhAdi/718FGGqzDrihWJPB3K67UYEqLN08ZgCV8EXNvfOg7/r9oJ/7a1Y1ozLCjdppSpnPBfHT/10VmlOF3s2lAN7Bp5YAFa8+oHfIeHXv3zIozO+A17IXYIAFQGh1JckvWDdtTWbGiS8VVVd+0io3zBak8olTGjm/l325nw/FjzesSVsB2enm/grY5CpAuQeg1EaX7dFRujOWuMlM7JKHQ8RYJMzHi6POKGiSkThOyCW/DOeqQNLnOnZeQGi7cq0EGWHN/IKI/9puqUy3GzDKzZRmj97+38SEldAzQ57SsdO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls5ZuhcEgo1C+pbBqOEgwxkHAFWP7w8+GJ7GiOtJjZM=;
 b=R6T0PDiytpAJ+XUpwXkZTxe3AWE+EBuAK6cGtsY1Z9srL6eSUOrFZIaagSrcUohnauxHjgKHrCKNqbMZ+xU3HLx0Wx47q7jf8PPWqJ02C4aZ1+Z7VO5CZOhM8N3VAH7ZUZu0XZb16iVBx0nlOL04s/KAQSsjmvvvfeXoNo64jpj/SGmPxoLZpRvK4bO6WJUA+TDn6BVgumIp2dn7JVXV/1rtAy+BysREV8SHadj3q5BSEplUgiBOg9FZLSLToTAlOILpyP8vYSKVnkKq4X9pc6OUgkaFB6bDImRM0MLjdGOEdI5C7v3FbGtByW68XYKt1hXgiUYnHheWJCEXa1nufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls5ZuhcEgo1C+pbBqOEgwxkHAFWP7w8+GJ7GiOtJjZM=;
 b=oePZEAQq/OJWuZO+IkhPOwrF2rgLG7TrX68RX30y0hSff16BsLzg2d1Na2VUokYlKyySuDQaqlPsVsT7t5f5LweD9mX7J+S8grGiQc3qPLLPG1RCwEySFPKZV1tIwWnWrhUUSfdS4Z2+PQ4xc0rGEo4JGnvJQeXHYGqdc17LXek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 06:42:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 06:42:09 +0000
Message-ID: <288d5540-1613-c6e5-5da4-9970a13d54dc@amd.com>
Date: Thu, 17 Aug 2023 12:11:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amdgpu: update mall info v2 from discovery
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230817033254.26780-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230817033254.26780-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: ec113a22-6a34-42cd-76c9-08db9eed1421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXTk/SVLAxLCtwN9l4B2yCaNAt7L7PeQBhoQy5VxcUamGmsOOHX57V5CDIkuJeuftuyhfmRZf5f4aoKpXMeoMSRmvKjgSwayHBypalexehQWQ2ls4nIemw8qR5VzfGB/RrU/rHuDuIdqZm3VuP4M3OsMn4e4iT2UgmonikTOXjM+X4SxtTETP18AS/NwY2oKodJqXx4bkXl8PCewqUvRhnjqQI9N+HzEg9Zz72vXOsBYxjTvVoeryhCl8lG9qLdJM+IyIzfDkWdM0o78no1LwKXFbgIiEXHMtmn2w07AWg/s8G/YJW9ZYnUL8ssiVGnfftR6OedYBHvFv+0MAu3UsTV6MDUvptPRBgX2QfQrOBbppbm2etTEf01CMLVDfnoQMHqC7QrZc4vYbF5+mg/eW6FTkB/0+QLijGeH6jF6Z9DuymYMlJPYpIV58ZBwxGLU8rM/WyGEZCe5VBXu37CuJR6mGSsdufvFv/VgQokNK4oXdjdGXcpZIa/bCi4ZtEjjSvSuasGmdlPS9w8azh3LCNrZgmEzLooYArKw6ctw1u5yf2usDuKiIbI3uWM7pA6JuuA9kkCApvDig0CIhqJ1pJjxtbeMxwhODxHaARw1BK8AIecKDB2WbLpRhfeTLj95p0dT3Jt3TYvvb9e8QjVWuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(66556008)(66946007)(66476007)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(83380400001)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czMrMVlWWjlBb0QxaGdTVFNxSXNXdlFUSDhlRS9tL2RPVTgxS2NDTW02anlP?=
 =?utf-8?B?UHNyWFl5RXFNYkRVa1E5VHJXYnZzMlI5L2pvbHBXYUNScUlJSDNCUUUva1BX?=
 =?utf-8?B?NE81WUc2c0xqdVlrUDVXZ0pLYlhQYkw0WVJyazNBWjkrUDRMdEozZVUwc0xR?=
 =?utf-8?B?dHhxcUNyYXlkNzVkcmlZMlVSV1MzeG12T2VtK1BHbkNmbGJWSjB4ZGovY3FL?=
 =?utf-8?B?eCtYVjRBbzhGdGZXSjMwbG8rb2UvM1N4RTV0cjlvQzBhakxQTEp2RFFkdnZs?=
 =?utf-8?B?bjJIRHk1d0ptK1ZDWjR6MGRLc29vS0Yyc3lqckZMOUdGbnVZUTlPOXlnVUIw?=
 =?utf-8?B?QnNWT2w3WngzTmVMVGNWVFNrWU9LT0pXQ05JVkhCaGNXTHZCL1MrM0lEK2Rr?=
 =?utf-8?B?OXovV2lhWmhHV1IzV1R0TlZNQTBkRitxRzVPaFB5bGtLMFZ4b2ZrS1NhYkoz?=
 =?utf-8?B?NVYxMkYxTGthSzgwcjVtREZnMUgyNC9FZ0lERHN2ajRRaC8rcTJtR0FFY0RP?=
 =?utf-8?B?RXN0YStEMFRycDhYNnBuQWpwZTNvZFZRWjNhRFBnV3UwUmRBR0t6MWxqV3dN?=
 =?utf-8?B?eTVEek1zbnNKSFlmdTRoT0gxQ1R4eW9hSnRmdGVqeEdXVW1ueWQ3ajNEY2JZ?=
 =?utf-8?B?T05CQlVsTjl3VU1JVmVveW4xRlc3QkluR1hxalBjem9ILzEyNERRQ2tPTTJD?=
 =?utf-8?B?RUNtdFVGRGhVaHlTUHVWaHY1aEd3RXdYZnc4R1dRU2xOQlZsMTdhbGk1TGZq?=
 =?utf-8?B?K2JSdSsvSDRVYTdXYmRjWVV4VzZRUy93QnZ1QVJESEI4dWtGQ2VPQlBhbWhJ?=
 =?utf-8?B?emJ3S2t2ei9vV0JpYjVUdDlXQXJ4VjloRnpFQTh5VldISWZxMHF4UVlvejRW?=
 =?utf-8?B?cjBZbnVZZFpiWiswVENPYXpqS05uVm04Zy9Hb2VPdnVOTUlueTdtaWd0SVdS?=
 =?utf-8?B?RmFFV3AzMnFyeVZieS9ZQkpnQVZzU2JJZ0Q2UVFQSUZMVEhUZEQybW1OOGt0?=
 =?utf-8?B?bDF3cm5SV2wzUW5pMmhKdWJiQjZoT2VZcWFhZmVrQmV5YlFscE9FMlU2aDAr?=
 =?utf-8?B?T1V4WVkwbExWeXh1ZVYvejE1S0kwYXg3c2NjOUNSb0dNbUlVSTh6SEE3WlQ0?=
 =?utf-8?B?YUJ1ckVMTXNHRTBTMERkK3NkU09kakdOdmQ5MEhjOTBYMlBoanlWaFUzZHdp?=
 =?utf-8?B?UVhBbkR0eFhyYjdjWU1EL2UxSlFkeFdGYUxnMyszb3c1dWh0T2tIUU1IRWU2?=
 =?utf-8?B?cnhjZklvaEY4ZHpFVHU2U0NRM1BPRnBnNWJJcEpWZ3lJeEs1NVMzeG02VjI2?=
 =?utf-8?B?Y0V2TnBWczlNS1JrL3lFZ1pBVHFzdVRKaStXamxFTkMvUHlqdlhyMjB0UzVY?=
 =?utf-8?B?TDVMNU1pVzlEQXBHNVpyM3FXQnh3QkhkUXppYlF3MHFOLzl4dUJVM2gxZXRC?=
 =?utf-8?B?REhleVRjN2szYXFKMzJPZklHZFJLWmYrWXJKdXp5enZLYU1YVEs5U2VML2Ft?=
 =?utf-8?B?L1hLMmJTelBDNFFoS0dacXo2azZWR0lyYXVPSkdrSVpUT3RKTUtPMTNiN2hD?=
 =?utf-8?B?ei9scHZCSXh5M2ZzQ005bDc5NFhaemphS3BWcUFRY3VLRnl4RFEyV3VadVNq?=
 =?utf-8?B?SkhGQk9nd1hJR3pqd2hUWHhtRlpkcFBZUkNlUGNFenlWVUpsQ29QZDl0dDhK?=
 =?utf-8?B?VlRrWCtjZkNOdnpVanhtRFhKdGdyazE0VGw2NlorV2FmQTdUZ2NWbzV6U0Nv?=
 =?utf-8?B?bWVXdWo3VkhWaFR3a0sybG91VDZjQlNXbk1zVW5yYUMzOTYrQVdsK1p5RXNs?=
 =?utf-8?B?OGg2L0FacUZHYWJIY01aa0Z3MU5sam5IWHVJMzZ5VkV5WHQvV3g5am5rUmNO?=
 =?utf-8?B?WUlvM0hGNEpYR05uV1RWNy9DRzhLOFZFWVd5WlNvc0JwdWU4YjdsMnRoMFJX?=
 =?utf-8?B?YXNEMXJxbXdOMkZBVGNTOVorK1FqbU9vMGdIbVBXMDRGb3dDTTI3NDk3eDhn?=
 =?utf-8?B?cWxlMXc0OGV4R1FhZUM0UUErbDFDVVZkNGYxYjJYOUJmQ3ZWMWxGUEFTZCt4?=
 =?utf-8?B?VkFQVHZMbWJ2aEhKdEpkd2g4UkRPRHEzMXVSWlp2UWwrYlFxUENrL3lPT1Bu?=
 =?utf-8?Q?nkjbHRyP/U6co/A7vWS9kZ5am?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec113a22-6a34-42cd-76c9-08db9eed1421
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:42:08.9032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ygHi+SxkwNykX0FxkQix/2Dcke0ygFlC3Aj0rfZuuZNPc90UwnHF69cXF7gdy1z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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
Cc: Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/17/2023 9:02 AM, Le Ma wrote:
> Mall info v2 is introduced in ip discovery
> 
> Change-Id: Ia2e49e7679c578065f85059a077fc08c9f84615c
> Signed-off-by: Le Ma <le.ma@amd.com>
> Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
>   drivers/gpu/drm/amd/include/discovery.h       | 8 +++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 9d8d08daca57..f4cd43ce251b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1478,6 +1478,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>   
>   union mall_info {
>   	struct mall_info_v1_0 v1;
> +	struct mall_info_v2_0 v2;
>   };
>   
>   static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
> @@ -1518,6 +1519,10 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
>   		adev->gmc.mall_size = mall_size;
>   		adev->gmc.m_half_use = half_use;
>   		break;
> +	case 2:
> +		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
> +		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
> +		break;
>   	default:
>   		dev_err(adev->dev,
>   			"Unhandled MALL info table %d.%d\n",
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
> index f43e29722ef7..b9884e576f98 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -30,7 +30,7 @@
>   #define GC_TABLE_ID                     0x4347
>   #define HARVEST_TABLE_SIGNATURE         0x56524148
>   #define VCN_INFO_TABLE_ID               0x004E4356
> -#define MALL_INFO_TABLE_ID              0x4D414C4C
> +#define MALL_INFO_TABLE_ID              0x4C4C414D
>   
>   typedef enum
>   {
> @@ -312,6 +312,12 @@ struct mall_info_v1_0 {
>   	uint32_t reserved[5];
>   };
>   
> +struct mall_info_v2_0 {
> +	struct mall_info_header header;
> +	uint32_t mall_size_per_umc;
> +	uint32_t reserved[8];
> +};
> +
>   #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
>   
>   struct vcn_info_header {
