Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161A9C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 04:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A39110E111;
	Mon, 10 Aug 2026 04:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2aZUrTV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CD910E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 04:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3HOCLOoyqnR5Dw/foM6cXumBtXIs8a2h5wdJPphR/egMMPQBCnv7fO+/Ghv4N0QJCHOxCRmJpPNTkT0TtxjwhCd8fxY3HLZaGsZWq1IbVy5QO8lfdh3iKqwjwyg4U4aUbKtWpfYiuzJf+ROjLONLxBfrTb8NvgQKlc82NWbJPNm8xdv3afIrlP++oor+6RUYlRjqMSCA4lLpHh7WDSuIOG7RPs+gvhsd3Yevc2CVyQNYJnF+RnWH7TXW5Dn+WfDnFX+m7FzQskZNGrT5AbNxEso5Yli4SshwydkcJ3FSHnYNHSZS7sEM98xx+ymBSmjr6yYmbFiMlIL+IaMXGfAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7daUaHapU+5fdgtCwHZT1APC3TAx/zEZiL2AB5VeFI=;
 b=r4Uwj+VEV7Ed5/+t24nQb30dpbW8nmKk3uZKn1rVB631P0wWSy1xUHyWGpKcH45qmOOGSrBye9zlcMJRnWgJ2Eu9dLxqDhwPCwLGR2nEQ4McwCf2C4YVw0p2zZhZPLE2M2LdC7eQIw0BLCV3F5ghovolA4v0r+Gkv8dStwtxeEawZQKkaaM+mJMnrrQ+xlM/xIA/oikqGoAdCASZCVCExXd4Dvoaop3gC/B1dQOcKy6D3KISHhg7r4kBfRh0Lf5kUUugnb0w0X9H1opI/L+6DEj/Frw2pjayJXzL8ODoPw3wakGZIxXPL2qlT4g1yNAbF42ZW6mFE8noGHmDtbnGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7daUaHapU+5fdgtCwHZT1APC3TAx/zEZiL2AB5VeFI=;
 b=P2aZUrTVnAVuSiLpb4KSqY0+ESa5tTA2UAYtj7Cu3IhXlK5KB0J6KPjShrRINB29QrXF40bwXGdWBcgL/X9jiRmTFIVafZ7KeyJowQmZ8SO0XMHlzyUEYk0YmdzoUigolvPhc3mp/FuW2gko8mX46jXE7vb0VbAGa1qDDFPIcQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Mon, 10 Aug
 2026 04:27:29 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:27:29 +0000
Message-ID: <6ec8e6a6-8aa5-43cc-a4d4-e296555e6d8f@amd.com>
Date: Mon, 10 Aug 2026 09:57:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix uninitialized clk and is_fine_grained in
 smu_v15_0_set_single_dpm_table
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Asad Kamal <asad.kamal@amd.com>
References: <20260810040251.3819078-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260810040251.3819078-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9f65d6-3a82-424c-0b74-08def697b02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5+1aY4rKZpD4tmbHkVbOxY+CoDCWb5KZpCPAUFoLzS7I9XTPve/CcdhscpfrX9ewQUWIl4T32Ths1rutMfZKSMHqOEBigB+abxdtZ8AWYmsbhjJrciteAcfVHCzyS5HQvb8HwtdvGhQl7Kk2ACmGerkt+HC+q7gtk/hEhDhB+B0ms1unrL3kb588KRMIQoy2V6fkLUYL6Qrp+7F7xnR9AEuEEVK2DMU5qDsmfIr4znJIQRZT2qp6hmCjFDjmsZFTWzeSe6YqrkBuVkOKFr3lfhLIDaINfIVteINTdZABG6LiPnkxCWkWcWmQsQ4jfi/E4dJRPzZ6kaOcVt2f18fGZpk7qdCR/tPyvr0xgzAQMNJnIEioryQBJ9DvwPaHyfEcz54ajQ71rDDb/E5VunD11YnJh28CsuRGmk048WwmIKM9bs3qIuHF5At1cxLakg/B9vMyy6napNbn/B2GtmtkbC2YrtD3P1cXZGsCN4ayin6JPxfKRwixev2VXxShWwj+cm+hjPgBLyXrNWAYuDh4SQ+Ud+23+ftBmpwRX8BMAR8/vsyEgWkMEA0u0clxpLDJVSuFBMPvSpopXvSoNpmID5ejAQYXrmthRz6f2MLMXv93UuMmabuTXDr25AwHGOhCazv4sWgZWxpCwYQny/T7+ACNPEu0tSl66KTqffvvq+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2xEVlJLdmY2TStONmFiVzB1VmFkQ200d0xzaTZxSkRXbDlVanhqOHJ6ZjhD?=
 =?utf-8?B?SE1zaFJycHFLeHZYa1Z3SGpyUHVCYkJYUzlvbFhIYVFFc3Y2NUVHb2p2ZjA0?=
 =?utf-8?B?eEdnVE16SFdPTjlTQnJpbUlKdzJzNXAvR2pFeXE4U2VhL05peFNTYWdhVnJS?=
 =?utf-8?B?ZjdZV1pDNmlqcGNLUm44RlNyTG5uTmdHOVF5RGpuSzcwOVFSZVp5NmdFWHFZ?=
 =?utf-8?B?SzBLMmVkZjdlSVN1WWQ2Z2ROWHM2YTA3QmFFTUgrYmlqcWRUOThreENlWEdn?=
 =?utf-8?B?VUJ2cktaa3UrSEg4dDR0bUpQQ2xDUHR4NnYxSTRUTGxRYVNNTUpqRVdWZWRt?=
 =?utf-8?B?Y2RUeXVXcTNqZ1Y2bGlXL2tQVHJqRGllUGxySi84d0UrSmVEaGZMMXRKVTlr?=
 =?utf-8?B?UlliSVNONjZXSHdyS0NjVzVsdS9TaG9rOTZibWpndWtoN01JUzdQTDRuSEdV?=
 =?utf-8?B?c0NORmFsbG5Vd2RscEM5aGdaZEFCeEk3Q0MycFJSV2k4aDlPVXpwUHI0eGZv?=
 =?utf-8?B?ajRBMiszOWhWSllxY2dwV0pTSmdkcnhUalVrYlF4VDFSQ0dOSFpNMnpkY1cr?=
 =?utf-8?B?blBPT2JiTUxNZGF3ZG9PVlBTcXlmK1hLNmNQYklVeTJlNTlzblhvWklmb0FR?=
 =?utf-8?B?UldtelIvcWduOXU2OHZtU3RGd2NaQURsSjBabGNVVkFQeE9ySlhRaHZza3g4?=
 =?utf-8?B?M0xEL2IyYUxpTnFEL01La1Mra3hLelBhME1iOHlndjBKVmsxQWlXRGZzd2hO?=
 =?utf-8?B?QVhSOUQrbmlHTFBSTmc1S1ZIRGI1VkFHRlNpNjhNTjh2S2RJazAxU2hobnRJ?=
 =?utf-8?B?R2xnVlpzTGF0U0d5VmE3MG9VMU5WdjU1ek1kQi82M2lIQTNrc09qSXlIL3V1?=
 =?utf-8?B?OVRGSzJ5QkNVempUdEZvMDFrR0thL0tyV0hzd0g1TkhOOURBZnlQZDZJa1Vn?=
 =?utf-8?B?TTVVVTY1enRjZWJoaUR3WllKVkVVMHJRWEFWWTFaSnM2cEJLTFg2YXhwQVE1?=
 =?utf-8?B?UlRLV1pqTGFjRGtrbDBMN1RFNzhrNmI3NjhONUZoa3QrNGhGRmhmV0o4cmlQ?=
 =?utf-8?B?VjlqNmxPWkdrdTRZZGNmd3BOMXhqdkJBQTFzYkRBVTAzemFEdzVORUNiL3Jo?=
 =?utf-8?B?QmlzK0xXQmU5d0RDQ1kvZisxak1kL2g1bkVXS3BZdUlQbGlPMWZHKzhGelds?=
 =?utf-8?B?eWpia2ZsRVNzem9uOHhYd0E4MlQ3Njk2WlZnVXQxTkhQQTZZdzJDeTI1RUhs?=
 =?utf-8?B?RWpxWjFIVjdzeDNsNzFiZ0VOSGFZenFHcFN6NjQ0aXkwdExhQTFDbURDUm92?=
 =?utf-8?B?a2lReTBWMXU3WXlWU0VtMGlSR1F1K3JZNzJUR1d5QjI4NlpzcThxTXB1VWIy?=
 =?utf-8?B?RVczQklYNVl1enNnY3VnN0pJbDV2Y1BiV09mQk9pSGhTWmVwZGNvQklhN2hy?=
 =?utf-8?B?RFNMNUY1UDJSRUd5bGpFRCtMWDNKWUV4NUsvNyticVVqNUZneHVmeHJFc29R?=
 =?utf-8?B?dUxNQTgxYk5LMmg1UXJyTWM3RllNZ1dReUtZdjg0N1A3blpMd0QyWGpLUGdn?=
 =?utf-8?B?WkhwVGF3cHA1MndyTUU4YWlpOUg5ek1iL2x4V0xGYmZ4dGFVdjVoSE13Rndv?=
 =?utf-8?B?ZHFGL3NkUjMvdXJOeG1peDFjY3FzV01vSDR3ZmM1Z0lSV2ZwVTZ1VFh3TWkx?=
 =?utf-8?B?ZjByWUtYVUY1TDNsYUhqd2g2RUlQL0RCRmNsekNWMVY3bnBxejVidDRPUkM1?=
 =?utf-8?B?d3lFMVdPTjVkd2lyeG9XZzV5cURROXhwUzMweUVJY3p5TUd2V3BpQVRib0dM?=
 =?utf-8?B?aFJNeVQ1b1NHOGs4STNpT0RobnBVb3NUemRBZDVuY2c5Q0laQmNMZlIxTGl6?=
 =?utf-8?B?TUZ5VEV1VzZhZllLUkE3a00zU1M4Y3pIQjRoa1hQSWhwWjAwYytya0UzMkVV?=
 =?utf-8?B?SzZRYW1LM3hLMkVtbG90TmNJNzl0S2FMT1VMRE5QeFk5a1I4WStQUWRRQ2N5?=
 =?utf-8?B?aGZsTk5QZnl3K2lkbExpS2JOM09Ka3lrZFRhcjhHdzNTV3UwT3VXN0dsSmx5?=
 =?utf-8?B?RzliUlY1YXdwWnpLUjgvaFRlMTZQVTRaRGYvMmFxcGlDdnNEWEhkUTVPa3JP?=
 =?utf-8?B?ZGRXbnhUVHZ6THF6OUZXbXFiNzE1WlVUd0RvQnp1QUN4YWlwMkhmQ09SQ0xu?=
 =?utf-8?B?K3V2aHdSb1A0QlVuemZQLzRXWFBHSGhFQnU0UDBPSG9sd3FaUi9PKzRiY0pi?=
 =?utf-8?B?UDhWVUorMXplOFA4LzBHOUVRQ3VEOWdGMFAvNHhJT0phQUpwODNsRGhweEJX?=
 =?utf-8?Q?4ipm02V+xyAGJIa54a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f65d6-3a82-424c-0b74-08def697b02e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:27:29.3929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7dUM57OVr9tnJsdO5yrOKT/6x0xSKED/399b5QmLOTEaP7T+o8j5O04kPGLCncZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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



On 10-Aug-26 9:32 AM, Srinivasan Shanmugam wrote:
> smu_v15_0_set_single_dpm_table() queries fine-grained DPM status and
> per-level frequencies from SMU; when DPM is disabled both callees
> smu_v15_0_get_fine_grained_status() and
> smu_v15_0_get_dpm_freq_by_index() return 0 without writing their output
> arguments, leaving is_fine_grained and clk uninitialized before use.
> Initialize both to zero to reflect the correct no-op semantics when DPM
> is disabled.
> 
> Fixes: f7bee962d92a ("drm/amd/pm: Update dpm table structs for smu_v15_0")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Asad Kamal <asad.kamal@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index f1182305d707..29f444aea73a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1249,8 +1249,8 @@ int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
>   				   struct smu_dpm_table *single_dpm_table)

This function looks like a carry over from previous versions and is not 
used anywhere. Better to remove this.

Thanks,
Lijo

>   {
>   	int ret = 0;
> -	uint32_t clk;
> -	bool is_fine_grained;
> +	u32 clk = 0;
> +	bool is_fine_grained = false;
>   	int i;
>   
>   	ret = smu_v15_0_get_dpm_level_count(smu,

