Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB1EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01C210EC22;
	Fri, 11 Apr 2025 16:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5zy84FT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBAC10EC27
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5aMSC250qw7V8RCPsWJuj2l+y1fi2XFzaQF36nPGFOK+Jth8ybJoSrhtjIYyu0vRZJYwZenhNjmemnYjiQ5xgaGs7L1MeCR/8Ga/dJ0IOpFbOSblX8PhFCW1K3V7pNuyer//X+aGWA4k1gRp3OmM9WelbcbWgw+b6OKXS31An0VljfesPr62TsHKMQ9ZyVSRmro+lrLF67veCGvGDZ7mL/JR6uwTPwhwutE2VIaok4jWSgYLmusaGHvUwttxZH0gutj8GnSe0ZfGZDu7ksYMTOJHXFtCF48m6h+DZ1QXxO4H2ANFBxmRbrUaXnJ65TdJMN15CysvMrtH6NWzq65Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4npjWlTRGG7OlFHl26sJWruq19G8a+YaEKzKuXskeQ=;
 b=DtLcyKmkGJccWaMsfjHPY3QHFZDsfJdl2G3NdlBRuOTjgo3zQLiZtnfZBFJlDPuFqmOsw/15SRxaFFubNoUL0z/AaREMMHgANu4HRJdP34+g/sEE/QbVuyK1VUTSpraTf0jZLqVm6BP4NxZAp0EhiisvqeWnVd9k54ipv3NUoHyWhKZW2EOaguQiwSZanSoNkvhjYDfQSf1vXKS0OK6kzq43FZp39AMQkzUkizxdhofu6rk+jATSNbGD4U3zUkNbfN2FilAfwOhnon064/bXevc4uVeNC11f836AdpeuGSVOeCTWQIULUQn2yXNeYpRgchGVfs/EK2BYtpJjUS7nhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4npjWlTRGG7OlFHl26sJWruq19G8a+YaEKzKuXskeQ=;
 b=r5zy84FT7lj3Ax/RZ0+WsmHtTlFdtJxewUaiopU2P0pNI/IDYQnWDu+ZcAwwHjeyHkJLhQIIgNYfRNl74U1BTvxnwfZ7AQkPmXgyHOdRO0UfNu+9VngsvLXj96MG+oJl6nmEltH1Wh2/Ho+z+Pq7EOpZBVX0+n3en2RuZCkQUuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 16:34:55 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:34:55 +0000
Message-ID: <0df795ae-1953-4346-846f-c49d05b3215f@amd.com>
Date: Fri, 11 Apr 2025 22:04:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq/mes: remove unused header
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181800.2303400-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181800.2303400-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 18faf6b3-b3a5-4298-01d1-08dd7916caae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHduUFJnajFxaGNXdFZPbDNWUXdyRkIwT0V0UjRPRnM2U1RLRWV2Q2RxQnlV?=
 =?utf-8?B?SEkydnVMVGhDRU1FTklHQmZ1M042MU5Kd043MDY4SVFKZ0dURk91SjRoZ0xL?=
 =?utf-8?B?SS9VNktvNVgwU0xYRTl3aVJXMHRJR00zcVBSbzRlMTJWdlpyNlhLVjhQeEpN?=
 =?utf-8?B?a29EN0tjdVBlSE5YbFZkbXFwYVhVTTJmU0RJaTRSRUVMTjlwNG9MODc5enNF?=
 =?utf-8?B?eDlmOGN2V3Yzc0VNb21zc205VHRNeDhkV1B4QUVhdlphWlFDZk10UHNzVWc2?=
 =?utf-8?B?ZUcza215QTliTzEzSWFuN3dBSVk3Yi9RMUVybklWQWlkeEM1a2Y5LzJ0YW5a?=
 =?utf-8?B?bURaWlY1ZjZ4K3crKzg1QnoyT1A1SE1vQ2NNM1dRc1VXaGxYWEY1UGErekNi?=
 =?utf-8?B?THQxMHdaYktEREJ0V0tFWDhRVjlxSkFMOEhYQ3hwclpQNlY1VENmRkNsTkFB?=
 =?utf-8?B?MDVkbXhNOXJxb3VkRFh5RmtyZm9mRmx3YkdTKzB4WHZRZ1N0SFJxdUxvUlIv?=
 =?utf-8?B?ZXRGM3k0Z3BjYk5zZFpLdjdGTUhCZ1lKbkhtaXdnZWE5ZE1WZ1IzMStqQ0N0?=
 =?utf-8?B?MVkvcVFvT3M3Z1JIVlVSWGppTnk1SlYzY2l5WDBTbU9jSWJvY2lOcWtBNmhK?=
 =?utf-8?B?TThLR0xkcHFhU1o0eHNjeEdmRGF2WDZRQ1FvOHFzVmJWcngvUllRMTdwNG9Z?=
 =?utf-8?B?THZ2bU5CM2ErcHFXN3hHK2xWcTdpWWxKbmJ4dEViSnZ4QVlTWDNoamRHTjky?=
 =?utf-8?B?VndENUEyNDl5RkVKNHdpQ0V5RXo1QkVxd21QYk1sN1RHMzBNYkRhb1lxQnd5?=
 =?utf-8?B?eHNLT3BsMDBJdEJJdngxL1Jrck93TWxiQ2c2SE05cHc1UGV2dXNSS05STm9P?=
 =?utf-8?B?YlIvTTJQREtZOHpSU2xnK2QxMzBCd20yS216b25aLzNIYmlSRkFPZUtzS28v?=
 =?utf-8?B?NlY1U0Q2ZDR4b1RGR2cxTTRhMTRhSGhGYTBIbmpaYklFQUk3S2JjL2NtbUpT?=
 =?utf-8?B?YjE1QzBkRGZxMG9YQi9ET2FCZ0hwdWdTZVd3VWhqM3JSa1ZCcFkxdFJZMmR5?=
 =?utf-8?B?L04wcnRpL2RSTWJSSWJrdmdFaUlFYmptNU1TN1lrcUtYZjR2SnI0MEZxT0JC?=
 =?utf-8?B?SHZUOWlhYTJvS3lTTFBnZHN4ZisxZjF4TW5HMkRMVS9QbjBEZ0orUGNKS2NR?=
 =?utf-8?B?UlhwNHBhNllsbTFJVk1MQ3ZVSHhzNlRES0NVK3FuSmZFRFJRY3BsWkRFUVIv?=
 =?utf-8?B?NFRRaW52aEhEZFpXY2MzSUpBL1JYSjh0eHpkK3JYaFZsL2tIcG5aNVZNRFVU?=
 =?utf-8?B?d2lZSDd6Y2s5OW0ycDhwaXNWWmt2Tm9kQ2RpaG0xRTJ6MXJJTStpYmI3SXdL?=
 =?utf-8?B?dmdiMEF0Yjcza3hBM2xnUTVnbVh2akZLVGtnMXhsQ1pYT1B0UWdoclhDZS93?=
 =?utf-8?B?WlA2ZWNEVzUyclNxN0RYTENzTE5WaWJEY3dleEl3MlJZd0JBM0JqSnJieWdt?=
 =?utf-8?B?QWFsK1dLV3dLU1Jyc1VuTzl2dFJXTUR2a3JNNWdZS293eUhaM3h2dGkwUlps?=
 =?utf-8?B?K0NCUEwzZUlIK0YwYXZ2dXRtWFdmdVpSWW5yQUJLT2FYVjdEdHA1eStXTm5h?=
 =?utf-8?B?OXlKVEJ2VUF1MnNQMFZYNlFrZHBMY3E1dWRlcjdkbWV0U1B6L2U1L0xvR0Iy?=
 =?utf-8?B?elB2ZXBETlRSaHNUNFZobVUvUTZRcVFyVm5YMEVtUFNjazdNaFFYempzMEgy?=
 =?utf-8?B?SDZtWkhScEZUNGxqYW5rSWpuQnpEZ2hrdGhCQmc2MGZJLzE1cGF5YXp3Z3Nx?=
 =?utf-8?B?L1NGTTdwaVRKT3l0WVhhSTlaQkhuc2tXejRhUzJoc1BCaW1sZGIvblV5SnUv?=
 =?utf-8?B?RTl4TTlVYkx5QkhDSjZ3djY3RkNjR29PUmVwM0VMS0wwbCt1a2x3aTExM0tF?=
 =?utf-8?Q?JCg7I4Ug5oA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVlWHgzUW1xdDNpaUs3Mmp6WDVqcnZxL2E5TkNoUnVGVXo0KzVRMjl3Vys0?=
 =?utf-8?B?ZkVNSWtiWWFmL2xiQUZyVnhlNU91aTl4dU1DV1RicHNicWtrMDREU3M4eFlL?=
 =?utf-8?B?dGlvRGpOb0xMd28rdXQvUGRNSnRHdjZ6djNsYi92ZzJzUDRwdjJLMGJ3dEVZ?=
 =?utf-8?B?UmZxdkorVmtzT0RMYStlaU9MR0FqZk5LMUVRaFZRV3pYZllqbGNCanFHbnZ2?=
 =?utf-8?B?ODZWa0RjZG1RcE9nOTdQa3UvOU00bjlOOHJUN0ZrSlZ4bHh2R0FaM1FmUS80?=
 =?utf-8?B?U0g4eTZ1TnhsbVluV0pYNWEwYlIyVi9QZlNHMVlxcXVyRlVXbFJtMFA4OHVs?=
 =?utf-8?B?UkdqVURzTkNQekxzbktGVjFkdUYrK1RwZ0kvYldXOS9NZ3hEMWU4NkcxcllR?=
 =?utf-8?B?R1lVQXNoZEthcmlHSmIxT2F1RWd2dnBEUWZGdWdVcjJVRXZjV29qajlOSkU1?=
 =?utf-8?B?MkV1RmdXWWtRVllWNS9WSnBVaW5sY3BVWEd3OHZRZGZ6bVExaHY5cE1UZUhr?=
 =?utf-8?B?VUtJM1grRDR1U1JUaGlCKzFFTHdTak5xbEhFSzU1SWRRWS9mV0tETFpaN09W?=
 =?utf-8?B?eEoyZmR6SFNFdnRSWXNmN3dka3V3SU1wVmZBc2JGaUNsWCtJQ1hTVjJUZm0v?=
 =?utf-8?B?cnhjVVFQWmQ2T0RVem9IZWNhVkxId1YycTFKWHhxSFc5UDVvYUQzT2pveVpl?=
 =?utf-8?B?T1RQZjlTSGFpN3RvZVcxV2I4cHI2WTJJSkhsU0twNDRIeDlWOHNteGMwd3gz?=
 =?utf-8?B?VDVhN3dIUExVQ1ZqYWN3VWI1SW1xZ1FSVUVhUkVoZmhjSFU1TVRxdzROZDlS?=
 =?utf-8?B?djNHSExOc3RSTDBjZmVGMFhwMFQ3aTFhY0Z1QUlBeThpQzVWSUVJME5IZHNK?=
 =?utf-8?B?SFhLME5Fb2VvZUhXWU9HVzdHTHFhbjZJUHFZRTAxVDNNRThYUFhuWGZ4TDlD?=
 =?utf-8?B?RE1RTk1ZODhkb1BVMU93WjI0THozeFkzUXhLSFZZRFd3MjdSVXNEdUFyREs4?=
 =?utf-8?B?WXI2Q0JqT2VuVVhydWVTaFN3ZjQ5cGlrYWlNWUpwSW11VEwyWlNUVjl1bTMw?=
 =?utf-8?B?bGpWbC9vSktUbTVrYWtZNXpqR0xndnQrd25BQVhaRE5iSmsyakh6RjB6U0tE?=
 =?utf-8?B?eDRuU2hHTjR4UHdrZnJzN0poZC9TUldrOGFIeW1JR3ZRL2xBc0cyNUVtaFQz?=
 =?utf-8?B?RWxsVm11WUlYM1IvdlZUdngxbUl2TEdlTnhBMzBQemlVdnNxRlI2UkNBT0R5?=
 =?utf-8?B?aEViQkg2Z1YzM0xDUkluS25XRzd2RHBTeGdYektlUkt0RWZNT1ZCaWlGa3R6?=
 =?utf-8?B?NmRPZnZ0ekM5R2RISVhRNGFZcTRWbzRBeXU2LzRHSkZKSkNTbnpXVXhOUVJk?=
 =?utf-8?B?c09zUHBMVEJid1l1ZjJIWW9wSEFoeUZvOHJsZGN4Nis5NUhsczhMcytna3Zj?=
 =?utf-8?B?L0g1bTErK0U1YlZHRjRrQ3RJNjAzcDJNZlI5bEFDUHdMMGpITXJKQVpCc21U?=
 =?utf-8?B?clMrMmFuU0xGSExEM1FkN2tTWXBrT0pzbDRKRDdyQUpuTTg1VkRTaDFYMjdD?=
 =?utf-8?B?NzlVdXNPWTdVbVpQVVI5SkRMQnc1VjY4KzdMbXN6ZUJlR1hmcUUxb29ZTU1W?=
 =?utf-8?B?bWdMYUg3QUFoQXo0NWhiOGRaRUZZSnYzOUxSUWdKdGdCUlBKV2pUUGFoa0xk?=
 =?utf-8?B?MUJueklhMjF1cUFjL0lSd1NTclpaVjlpMzc1eFZ4RUh3TFVwN3djcXk2R3BZ?=
 =?utf-8?B?TEZVTmhYb0F1T2xUcFU3cXk3WHZqbVh2NC9KSmJ2NURDM056RkpFRTdqRUxx?=
 =?utf-8?B?d2FWd3dGWkxlNWpPKzU0K1J3aCt2NjlkWVpSdEVoL3BvdmhvZ3BwdXRxR0cv?=
 =?utf-8?B?amplbHRQZDhHSVk5OHZwTm1mR2s1TDU1T1BBYW5Ick8wQzhJQktlaDUyVTlO?=
 =?utf-8?B?cGZiamxhb0V4UVBPRUpsMTlGOTFIa21XaTNnN0lFdWQ2a2pRN2hPbUdyMXJG?=
 =?utf-8?B?S1p3VzlEZkFadnFKL2VTd2ZZRHArNmNsU2NPaFZmUmtQRnN6MnBMYUdwMU9X?=
 =?utf-8?B?UFNtVGdVVGRkRVJyVm9SZDFGMENRY0NYNXJKZDNGalQxY3duRFZ1UjdWQnBu?=
 =?utf-8?Q?J7CgMVGU43+LCQ21pqruNWzbM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18faf6b3-b3a5-4298-01d1-08dd7916caae
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:34:55.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsDKulIKutFneFDocfjD9jRiNUijOfa0Limr/bSorTGsybswde+woVWfI23BFNAFP0mC67Diz1HY6cnGyQ/3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 11:48 PM, Alex Deucher wrote:
> This is unused so remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index abd32415d7343..e3c3fc160b799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -25,7 +25,6 @@
>   #include "amdgpu_gfx.h"
>   #include "mes_userqueue.h"
>   #include "amdgpu_userq_fence.h"
> -#include "v11_structs.h"
>   #include <linux/pm_runtime.h>
>   
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
