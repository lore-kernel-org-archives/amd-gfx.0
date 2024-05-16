Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46888C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBECB10E343;
	Thu, 16 May 2024 19:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rK4QSd3a";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1F310E343
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWWRCRswsZdih/1D7qRxZPbtqTSeJi7bq2Mf5/+fhABekdDckby/c86psrwq6nDjmLS1fntLOVRdCpeqBOCvEHqBLuOd5N3lIaKGNzDtLOyLkIrJPYlyxd8JveM2gjjOJfiTnR3C6k03eEJQiu5dmAVIftxIMveR4N/C8vFuFvkFpEBfFjPJxfqpGze9w+29jlbG7peAnIdx1dhIFiJlXv7YM8Uh5cYE0bxQQxl2vdski/zzE0jk+sQZu+tlxot8xMSDFT+sZdTqQ0Pd96Hry1q/iBlGIIiUl5ZoC2TgD1YvxRiI+WnBN3K/bHwbvdskpgisFqhF9DdURLRVIoQYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmEkk9baT1SDC1W0keznUxWwbupIeygmphyDjmOqHyE=;
 b=B6zWO/aOexHOTV975i2bQaYzf7fZTWBmtevSqtRV/gn/rhmsJLPNfxjiIAKvk1jttPQFrVWx7tEDXWZYSC7urd+SxEa51yk8GBRl0H+9MHe9BfNYIR6ou9mzJre+DogCU4M0tmd/2dKBpVVwjGf3h1pIDVrITLB31v/ijmOJgRb9dIQsmgs7LhpazlGe/1LxjTQjrUMY/jTHDoM15RC7sEoL1MQ9YZSeJMFG/w9ZhEtB/6RJOOTRaCamVrn4BGlz+g9zYSIU/ncP+1yNJ4l/vFuoU+M3oRUcNx0Tt4SCDFW5Q/PqS5d78mo2gmBAs2FrYIPnW/ybelkN3HTGy6NExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmEkk9baT1SDC1W0keznUxWwbupIeygmphyDjmOqHyE=;
 b=rK4QSd3axkvVlNDlRVAwbPPWsH3WWhQP4hf3PhOD09NEOCp2TZkfk/19SSOBymEAW7L8RDJDC2vK8BUfKcCFIEyXNdO4GjkToUpQWws1YohhHi1hilqaAEELdmOWO/RTBsuCGAtd7EY8dTeNWt7PMTGneEcFvy54/8I1Y6O3+ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Thu, 16 May
 2024 19:33:36 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 19:33:32 +0000
Message-ID: <83a2812f-a13f-4c90-a323-37514ca58776@amd.com>
Date: Thu, 16 May 2024 15:33:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] drm/amd/display: Fix POWERPC_64 compilation
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 wayne.lin@amd.com, agustin.gutierrez@amd.com, chiahsuan.chung@amd.com,
 jerry.zuo@amd.com
References: <20240516192647.1522729-1-Roman.Li@amd.com>
 <20240516192647.1522729-24-Roman.Li@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240516192647.1522729-24-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::28)
 To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: dc936c81-2d60-4bd3-03bb-08dc75df11cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkVQZzNBdS9TNU43Ly8rSW9JQXpDQ0pRODcxYjdvVW56R3ZWWjRuYitjN2RY?=
 =?utf-8?B?U0Z1QWNPWTljVlhJUnFFcjE0VWxzQkE4cWZiQ1BKQm9iRWluS3lVS25JbTZr?=
 =?utf-8?B?M2NoTEo0ZXhKZGswc0R4aWZUc0pvWmNIMFFjTUExamJtQ2d3cy9xTXdGZ3hM?=
 =?utf-8?B?by80V3NaQzd1RE9UTnRROVNPV0FmVTlmaGE4alFOVlROeDZJZkIwdWpDcnhw?=
 =?utf-8?B?UjNPVEVOSnZ0UUFRSlhpSjNUY3AzemxuWnR4WlBhaUNUOXUrRWt1SHVzWkhT?=
 =?utf-8?B?eFN0MXlQbVJmOENRNVFCU1laaTlHMCtjS1FWRm1ZU3MzY2JkUWdITnk3bGRr?=
 =?utf-8?B?a0NidjJyUTVyeDdiUXQ3TkY1cko3RlI5QmNTdWNBUTlLb0l5LytHclRDQ210?=
 =?utf-8?B?M0hqZFlpcHBYak55MTFmRkMxZ2VFQ2JyU1NIbWJlS25UVFFXQUlGMUVqb2NW?=
 =?utf-8?B?dHp4K0NjSHNOMGJaeTA2MDArUE9iR0hub1cySFVFY0hzMzBnSmJzZkczQytx?=
 =?utf-8?B?VFhTeG4wcy9YRXJJZ3FHSFoxQ2ZKczlIY0djTFA5dTdjeUdTL1h5V0N6ZHVt?=
 =?utf-8?B?R1ZtTXpWWjFtekhqV1AzOGcwV3ZvWGVMSlEzSXcybnR4a1hYa0Q4Zzl5bnFo?=
 =?utf-8?B?ZzhFZWRFNy9UVGYvVHR6amY2N0NLZkZISlppWW95MGFscVh0UHpzNVlBTHRo?=
 =?utf-8?B?bUdQZXpUL1pJYjNIbHd0MXFzS05KZTdmNDM1SHpGKzVqSzB1NER0YjJvT1Vy?=
 =?utf-8?B?dktpWDZOT2FOMEJkUnBIa3M0a2dzaGYxMlVlTGhVamVFanphVHBsaW9haXlI?=
 =?utf-8?B?Qlc5WER2TXJkY1BkYjRBMkZKenQ2YVh4VnFCZEN4VHVTbHdrcWxlbEo3Q0dJ?=
 =?utf-8?B?SHdOTlR4R3BaNTN4S3ludHE2bGxtR3kxaUtHc1Z5cVdmZlh6SzA2ZElkenZh?=
 =?utf-8?B?N3Q2UW9BWVV0Q29yK05HSU9aOGtjcDdHeFV2TlgyNC82cG1pS2ttL09iNHFH?=
 =?utf-8?B?bm9EdUROOG51RHZ6SnJBK2hKZ21LLzhmWEJkWUo4UlBIWWEwbktXOFpTbWov?=
 =?utf-8?B?c3h4eW53QURwc2JZMCtleTJnNmJVRlBNajZvOHBiVXRlYmh3NXF3WElueVZH?=
 =?utf-8?B?b2hVek1HU0NwcjF3Zi85aUZDaVZGdWlZSmFDSXVlY21OVEY1QTRVSWRJSEZq?=
 =?utf-8?B?b3gxM0pGdDU1SzhidnJTQld0NktmLzN5OWUzQXNkbGxFYy9LNmVrS2RQbVBC?=
 =?utf-8?B?VEdoUlBsRXZKQ2xwRGZjVnU4RThhSzFPbWRDQUFiK1RDOERHMnFuakRZV1g2?=
 =?utf-8?B?aUE0Qm1PQ29rS1V6aTNuOUl6Ym1JSXVYVk4zNHNnTk9YcWFKK2ZodW5ReGlY?=
 =?utf-8?B?OEVmZTY0UFV3TUlrV0k1Vk5Zc0tDdTJQaWtVd1pPSjVlVC9ZNzBwckowNUx0?=
 =?utf-8?B?eTd1Y0Jpd0lnZ0JIUGZSSnR4ZXZEc25iUUk2MlZmOWFXWUFxYUt4ZDdsUk01?=
 =?utf-8?B?YzR1Q0JuTDQxSDduV2RZSXdZQ1dYVVo5bldOSHBiZzFBZ0w1NGJNT2Vjd0lR?=
 =?utf-8?B?Mnk3VW14ZlI5ZCsxdGtSQWdvcGx2UjNNVWxnYTVmRmJBbGVrRko4UU1wWTMr?=
 =?utf-8?B?eXFtaStaazFLMEdycGxEZUdlWmVRMVJhUHZQMldLSnNtVEoyNTU1V3BjNmJ5?=
 =?utf-8?B?bFdnMmx3WGJzUDRHRDhkOWd3a2hhdzlHd3JqcEhYU216b1J4UFZ2dExnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHcwY2NkUVdyTVlubk1hUXJZdzJhRmhUd1pERklFNDZPdkwxdFc2UHJYcDRP?=
 =?utf-8?B?TFlFTE5CYzkwWldOUHBYU0txaFVWWm53TTUyU01YUDROblMxdzlSYnpYL1d1?=
 =?utf-8?B?K0tUNTNLVmw0WkJRWktvRVlFQS83anQzMDNjMlM5RUp4VlBkM1hRdjljSzZt?=
 =?utf-8?B?a0RVdFRHaUpsMzM5NFJlWHd4SDg2dWdtZ3J2ekdsTHczc3QwOUE0dzNIcVJN?=
 =?utf-8?B?WHBpekhWcDh6NVJZVFZuWWg4UDV0bkRXYUtWSGFFQVdOLzgwVFI0endQeVkz?=
 =?utf-8?B?L041ZEw3SHQ5TjVRYjJMWlBLZUU0MmxFQ0lSenpYbGg2aWtkZWtXbE90VTdE?=
 =?utf-8?B?Qm9UMEFUQlZrbkpzU1BMZnFHb1FsVHNJaHgzc01EM0xpaTg5NldidnE0ald4?=
 =?utf-8?B?WElXMzJYY0dNL1lUZEVEK0hZbytORzBBbHB1c2JjdW1CQmExalJFd2xSSUxF?=
 =?utf-8?B?enMxUlAxQ2IrS3VsWEl3ZmRYenJyLzlDbW5NN1BnOVNBSnRaR1pNZzgzNFRj?=
 =?utf-8?B?WEF4UGlpYU1oSE5EV2E2Y0Fkb0NNbzF6UGkvbGNwcG5keTRvOEc4WFlzWEl0?=
 =?utf-8?B?U0hIWUs1MVlmNXR0eU4zTGtwbitvbExpTkIrKzZ0NTVHclBqWTlMeHhPNnFP?=
 =?utf-8?B?SWZZdFZ0Y0lnTnhHQm9PcTlxR09SNTRKNmlpelFkZ2tnVytBQ1dvbFdWbVQz?=
 =?utf-8?B?QTJMSGdiaU5nVEdQZnJJdVk5d1BFUTVTZGpwSHZaOWhTRHRvRHNHMVpUQ3dy?=
 =?utf-8?B?QmRmSFNQbHQ1OUgxcXNOU2hTdHMxSG9kTkF6emN4OFQ4U3laZUlIdzVHRHFk?=
 =?utf-8?B?U2kra2RCSVk3SVRUTTJPT3hqVHc4ZjVxSVVyNXB0RGJ1b3VsUWVuREpSSG1E?=
 =?utf-8?B?d1ZDYVdzWDFjOW9nWjg1MGQvaS9tQUx4aEtEd2lRMzdqT1Q3R3hicnVJdzFJ?=
 =?utf-8?B?MHE2cnBUK0JzS0Z4MURVUHJRbURhdFdRVmpZR0NXa2psa3doM2ZlY0xwYkJK?=
 =?utf-8?B?Sk02M0E5S2lLUjZ4Q21JK0pyblJtL1d0QlNaWlpmZm54Q1dvcjBlVGlCY0Jn?=
 =?utf-8?B?OUIvL1ppU1FvaDF1d21aZ2U0T3BpcU9FWHpycHg5SXBnSzhyeVRXbnhmOWJo?=
 =?utf-8?B?WFpzanI0QXBodWFOTDFoeVJ5UWdOdFRheEVYTEhPSHd1UWtLUGVVcTcwc0hl?=
 =?utf-8?B?U25FOXpVdkR1OHVmL0NmTnF0bFNTNlZadXRkZ2FzRnlZREJyNndWVllVNXBk?=
 =?utf-8?B?NDg0SnVIdmdxNkI0ZFRPUGV1NmVaUEFlN200cUlKQzZ5Ukx3eGpZbjdlYVpj?=
 =?utf-8?B?ZTR6WU0yNTFkTmoxQnVHQzNNUTBDUEhZdmszMnA0c0ZiSFk5cDQ4U1VjdG9P?=
 =?utf-8?B?N0xod3dJYkphM1RKTW1YdDllTVhmcjJVZjZCZXB2Z2c0RFR5aDJqQk9OOEZt?=
 =?utf-8?B?Y2lHOUdVRGxaWkRhQ3d6WWt5NTZxdENnU2EreFRFVmVrTmhVNjNONi9PVmNV?=
 =?utf-8?B?WS8xOXZidm9DaklqRnpkRTBOaFBMbFBTVmRZdHhJSGtabGN2a3k3K2c0S1JI?=
 =?utf-8?B?M2txcVVvR0ZIMjBrNjdDSVhoaFh3TCt3ZS9QSXNkcHdWZldBVW85Tnh4WFFI?=
 =?utf-8?B?Sjl4Y1RFQXlLc1Q5WDJwdVoyMHVtNS9xOUd2d0tDTU8yY2lsQkEzR004WCs5?=
 =?utf-8?B?VmtoQUxJcnIrTnU5am1oNURpbUFxZGpuVS9WOWhWSzFhUkhJNnRCSm1PZkh4?=
 =?utf-8?B?QmlnTnArWFFTZy9VbWtNQytIbTE4Rk5LK1IxV3NYTWR0alM5UGVwNjN6WS8v?=
 =?utf-8?B?R3NJYTRvaGk5TkRzZnhkZkY2UmRpZFl0cFI4bGJaL2RUaDN3N0RNeTMxMlNB?=
 =?utf-8?B?UzZEdzBMQUNzcm1YazFVK1pPSzBTYkNBVkxISHA0NU9lOHJML3JHZmxqZzBw?=
 =?utf-8?B?bWQ5UkZEQkF1OUdJeGx2K0QyWDVXYUxpV2RyNnhVRkE3cjM1aFc1bjBKQlpa?=
 =?utf-8?B?SHB0Q1FXZ0FTVFg1dkVqeHVhVGpaQStrVWswT2RmbW4xdy9iNzY4TGhZNTE2?=
 =?utf-8?B?UGF5Q2xDa2EwOFVBMFVBV1RNVTBGL2FRZGpBNStRdVlzS3V2cW9XRjUrbGJ5?=
 =?utf-8?Q?6zsolSJF3tUBNrF3UaKnsADVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc936c81-2d60-4bd3-03bb-08dc75df11cc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:33:31.8275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvHPHUcdhMwKSqcTPML5g5ZQy5QOHRVyEd1LuKS9oxkOViZj8pEQ5YXC9TIgyhdmEEm+VvxWvnT0slfrigNDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/16/24 3:26 PM, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> Compilation errors while compiling without CONFIG_DRM_AMD_DC_FP:
> "undefined reference to `dc_bandwidth_in_kbps_from_timing'"
> 
> [How]
> Fix Makefile to move dsc files out of DC_FP guard.
> 
> Fixes: 50253f5d9ff4 ("drm/amd/display: Add misc DC changes for DCN401")
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index 66ea5f104019..94883c4e4c61 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -29,6 +29,7 @@ DSC_DCN401 += dcn401_dsc.o
>   
>   AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn401/,$(DSC_DCN401))
>   
> +endif
>   
>   DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
>   
> @@ -36,4 +37,3 @@ AMD_DAL_DSC = $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))
>   
>   AMD_DISPLAY_FILES += $(AMD_DAL_DSC)
>   
> -endif

-- 
--

Thanks & Regards,
Aurabindo Pillai
