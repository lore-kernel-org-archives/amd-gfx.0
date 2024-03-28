Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D8C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 10:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6496A10EAF9;
	Thu, 28 Mar 2024 10:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ZhB51QX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B6E10EFE1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 10:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPoYSmNnMNZPJFBZhXoNJUEgDtY4eYSlprJym0N40TxLngVGb6FT9kxDaltqIH912AEHAN/6OykJrQ7oCK3wScrDtn1CyATTFqpqKUPB8sbHr/HijtxMWE0bgDib4o+RgqW9a97ceUrIdV+lAh4iqf+oRIXa7h/5gp1w+Vd/T3eQ5tEP/XLxyNjS6CkMpE7K/5Usd9XccK/MASw0ibcoRwEJD9ahaYZzbfEFz1/yE3Nllu2Eo7BN/KBEBdbohf3u7OfYxK+mBw+/el/4QlTKgXXyKrQSKyYau9ILsThnEl4BRSgeReM9prJUdkdcF9UPebxpT2tqtKFFdkR1Ls7+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbzavzjJpJBF5+vCnbv7JgyxeQO4RzDqv0c48YJ/mck=;
 b=jGM9CTcyxUIsAAuWV5vwbIgTcxRcd5gLriW9WO/CY07eup35Tplg//ig6IvzH2x7kZqhbfoI5f9GWZQxIxvtQvBvcJWJxk6xAUCu24i1apPH3Jvrn5RBRq83bcCIrLCtPt3JaJg0eTV49ML9f0K3Ai3Q9eAWp58ygcJoZHUZoGhnhyKJo8zAbb/ZlY7s3BiceUeR0RlCZoHRFd67NBqhLqEYwVV3iQKIt6MinHgbybahgwanSO1Yi3/ryQl+N4p94mxq6PmWbtNIfvDwJqKxMadlgy3ynmxNZBshg3qOwZmlqkRctyDSUgQtzJNiTWP5LHUAj4yyQIrGraq8KL/Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbzavzjJpJBF5+vCnbv7JgyxeQO4RzDqv0c48YJ/mck=;
 b=2ZhB51QXAxemakcYYx/MDaa4OVGuznMgquq+SiehXLWyLmQGO+4ZGDe1/AdxFrLrgVLf8Q/VZyY5dGmL5fEeozdbpPmaWqv+IJCCMsl3XwWMLMGoDs1KsoYwtRd+Ktfz2dY1VlX+Cm0sdQETQj1ihI+t33qn8AobkL8ZZ/iNA2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 10:32:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 10:32:24 +0000
Message-ID: <93b939ae-a97a-4065-ad80-de6297bb6c53@amd.com>
Date: Thu, 28 Mar 2024 16:02:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Add a new runtime mode definition
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240327111009.2994297-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240327111009.2994297-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ada8a0-5d55-45d9-c52b-08dc4f125b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa1kkspv720WC6ViLfrRZcCgg3ILiGLpU8j8mGFgAeGDg1C2ZjZQ9VVVX8nzX12zpPYYIEd/j4K9Zz+fYozG1qRvRY03D7QUgE2GUAXHlmNnOwiKD7Ded2D/1GhWWKssZuiSkjogg0rrs5vgpdamb85QW0M8MmzA/OnLOrvgpiQjeut30L2JGsfABK5OlwJRkzgFI8ulx/LLVogRvpsvetROCQSKkhq0k7SiIZe5Kk2eObKIySaMiq8whEFw//psu0vA1vgc16YhFt4NTN4bZ9wTTaFvsGTPuINiq/rbKXjSvFwGq34Rqpuu7Evgp5zL3QCqsqWbCio9GdxBOVCWR2LqsVBqUV3t9E5heFcEROLG0mAt/iEzJYM6OezEy6yN1A9XU5OTO0VDWPBzX+4mGuk8BHC+l34njoasgKAiqfZewIOWrhvqIrf8rFhC1MdLVw7oOw6Yx781KbEzukD1mCEnsPaEiaNVetsdotk9X/bPo4E+BuqXi1k1p5bTNAQl4xTSnTDRIhbZTrspgIgYKL3v8o22tEbu3tXW/2fNWstH3coI+nf5u9IFxZJmX58fcX27+2RBfHi5gF7SGAawL8HzQtzvKYVQqq2ZSet18s9HgG6FgG7Cz4UEwj6b+QA29MeJN3JrCVtY4JrXiNT5pw8HYN0Ff1jYDaSc166cHCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3UvVHVmZ0FXU3IzSnk0d1A3U29TZFc3WnNFOHFLQ0lJWk1mdjB3KytuN1BK?=
 =?utf-8?B?NEZMeWdoUmlCRmZVTThZZnBmZ0dkbXE4bnNobDBZOHRFdWFyMWQ0QVV3Wldm?=
 =?utf-8?B?Um1Qa0NLb0dMMnZmMWdSZXVPVGNZUlREWWtTS1FHbkdrY08vRm0wT1FzUjFC?=
 =?utf-8?B?VnVFWUxaem9nUklBTEczMCtOQVdzR3l1VGR1UWJMNlNhUjNKYldWUzR6T2s2?=
 =?utf-8?B?Q3h4RklJV1BmbFZQOVhUN3dYU0Z2VGtDOVhIbUVNV0VRUDAwbldkcDRMQy9j?=
 =?utf-8?B?a25CdXRYODNhS1oyRGpyM1IwSzhjdVV5ZFRyVXM1Tklyb3BVUFdDTjJXN3Qw?=
 =?utf-8?B?RzE3V0pVeTdZUW1GdmJJeGxOV0VYcDlwU1d0R29zQWpDalVOZWJGTERHcWxv?=
 =?utf-8?B?YWI5MDZEQ2MxVGI5VVJ2a0JwYndoWHlBOGJKVkU4N1RuTnh2cWxpdGNscWVO?=
 =?utf-8?B?Z2VwVEF6OVlWYVdYQjF3cURsTFNRK25XYzZKNFlObUdCWkZCV1dISmZZekta?=
 =?utf-8?B?Y2xhdmZaWGNuY0Q5Y1ZORW1wN0pXYTZKc3FtaWp3STM5QzRWZWgreXA3dUZY?=
 =?utf-8?B?ZXdaczgvWDNtZUc0Y2dqMjU5Wnd4V0RTYjdnN3dVTnh5Ni9YcnEwOEFxZDRs?=
 =?utf-8?B?dDVRRWFucVo2dHpSNmV5OTN3bEo4NC9oeFh0dDJqQjJvam9kNlJrc2dHc1NS?=
 =?utf-8?B?b2x5d2IzeS83VVZ0K2MrcndOcWtYazhBU1FPU3pPcHlrMEN3c0RFUkV3Rmlj?=
 =?utf-8?B?ZEJwRXBYWlhlMFh4U3JCMGFqVUNYNTFGSUNpUStTS1VZSzhhWEpBK1pRSGRM?=
 =?utf-8?B?M3h1NmFZZUFBcE5qSlMwalhVUXQ2cHJleG5NWVJXNTV2WURORkdTeWxXQnZZ?=
 =?utf-8?B?THJlcnJKVWI1MURIbWFHR3FHVTU3TkdKQUFFQzdycysxWjdCME1nMVZwWlRq?=
 =?utf-8?B?QXdEMi91NmJxbG5tQUZId25DUG5FMGoxTWdWeHhqRmV3eUxnaGpCdG01c05R?=
 =?utf-8?B?YnJMNnAwMzV5T1VQQ1ZhZHU3K3VHRHltbjJqbnpqMXJWb2xMZEUxTTI2ZjBq?=
 =?utf-8?B?RHNEb2grUmo0RGpWcEJJZy8raWZTenU1RE5oNmdNd0k1VDZsUWdBSTdSUDBM?=
 =?utf-8?B?eVJrRGpNa0hQWDc3ajJDbDlnWEliSHBweUtPelRZeFQ3dXhjUCtOeDJIMS85?=
 =?utf-8?B?OGJzSkdZazVSYlNzWmlIU1VJbEZCbjNyS2VEV240bytETjN5RVhxbGpHemNm?=
 =?utf-8?B?dmFrclV6M3BiTzBlZGl5dXUrNUxpVmtGYWREQ2x3QktpdTdobEU5TnJCVmQx?=
 =?utf-8?B?VHRNeWFNNHBBU1RSRlZFSlJkNDVIUGxpU1JYYnNGMWZhY3E5YUYrRzUwK3R2?=
 =?utf-8?B?NkM4V05pY1lMTHprM1I0YzBCWTJXekFJanFTRXdPT2drLzFraGFseno3cjdv?=
 =?utf-8?B?NW13OGJDNDZEWWduUGozVmxmeTR6WFc0S0F5dEs5cUJIWTdnLzRSeFg5OGs5?=
 =?utf-8?B?cXhBaUZKbXg5WTJyUUVBYUZCYkFWTjhmbThnVkxRMnc1ekQ1S25TaDR5WDVC?=
 =?utf-8?B?Ry9YRm92RSsrQkhHZWIrNXBSTVZLOUxyQkR5Zk9sWWc5cEh0QnBxZ1FEWkZM?=
 =?utf-8?B?Y1FiRU12L1ZCT0UvS3Z6djdIa21OUVNsWkFLelJrUEsxQnJXdjVnb2xhakNp?=
 =?utf-8?B?VVFGNkhTNUZ6WEY3NGM2aEx5N0RxcmdJUnM1TStUcnV2VHVReVFJSW90aWZ2?=
 =?utf-8?B?YnExVHhBNWgrNFZwRXZudkI5VlU5SFI1OXJqL2VtRHdyUkEyVk8vRkZRY1ZM?=
 =?utf-8?B?YURJWWdnVVd5VnZkZWM2YzNrYzFrV2VRcTRQWjVNOHBTS0F2dndSRkpmZEZx?=
 =?utf-8?B?aUExM2hLRXZ4YjVtN0xQbHQ2Q1k1cCtObWtQaEhodCtGUHNWOFdLRGsxQ0dS?=
 =?utf-8?B?R3c5aTNKQ2RkZk1Ga0ZZMHdHU281eXhQS3EwM0JpcytUcTRrSC9VZlAvMzJK?=
 =?utf-8?B?RUdoTS9nWVJMcENoNXFXZlNzVlRubHRaSDc1cHVOYUdUNStFMkpGWXdUYU1X?=
 =?utf-8?B?R2Rab2FWbHhCSi83dWRsa2JJOXd4U28wOTkyUjIvN2w4QS9Dd3Jrdy9ZRExk?=
 =?utf-8?Q?IymtNRpOqOYQu3Y/QSP0adm3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ada8a0-5d55-45d9-c52b-08dc4f125b6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:32:24.5259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3V5AM4lRS8fCpZqvVxUUvMm+Z70LCIHmqnv//rt0BFsNjqjKyZLXniVsBWs/IE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
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



On 3/27/2024 4:40 PM, Ma Jun wrote:
> Add a new runtime pm mode AMDGPU_RUNPM_BAMACO
> and related macro definition
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Series is

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 621200e0823f..e6cad9f7aaeb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -50,8 +50,12 @@ enum amdgpu_runpm_mode {
>  	AMDGPU_RUNPM_PX,
>  	AMDGPU_RUNPM_BOCO,
>  	AMDGPU_RUNPM_BACO,
> +	AMDGPU_RUNPM_BAMACO,
>  };
>  
> +#define BACO_SUPPORT (1<<0)
> +#define MACO_SUPPORT (1<<1)
> +
>  struct amdgpu_ps {
>  	u32 caps; /* vbios flags */
>  	u32 class; /* vbios flags */
