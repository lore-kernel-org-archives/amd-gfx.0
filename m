Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C64EC4320A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D884460FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D884460FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608F06E101;
	Wed, 11 Aug 2021 09:47:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5ED6E101
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 09:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuTN8X1WM0Ga0KBJCqxc8gjIgu4w+a+CntttcEbjVaD5eDACAOm42VSlwhnhl6lQCshh1aAhefHYDLjKM99SmWH+9FU8KsA24U5LKdt3SyFEfw9pci5kHADBP/XAIp2VAgD+r6n1HOtqX7GYIB5htS4HGLPxRUQOGaGReW3s6x39pTsmGwD1NQMWwrgsy64c2rc3imVFxjQu1r4LATPbgcNsJsPUk3GR0oHOgpMAugWs9ksQS5mdekrCq5irj6M5RNS61M1oqDTrF5QvVzuPaiP9YmM1kMjsv6MErwbyjvtUiKjhIZnHh7jAjMSK+U/y/pOIE/xEfmO+q9l8qYIfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11clsf1My69x8n76p1I8mYKdWdQv4OmxUfsKbuURzYw=;
 b=HA/edMu+fBqyN857Nyv+HnIBIqHtFYKxzkFsUNhdGBHx4ux/yglUoWUnA/w8q4VCXoxFer2V7Yb6eg7X2D68djcrIGIsIBpUEetmOlgBhQN92bdoYBej3e4kjyeQtLAbYzgxkM7bVD3nfPjY+oATQiS6+mtudPQhxl1OH4C9UnAAseaX/0Ly+DSKczKyuCdSa705iROjreEqfrwuW3fcEpwZwChaTUML/GFIZs6Fn7v9d+Q2QaH0iUkNiYWlpr7NpCjTJHiRtTN8MmbhlImefdDT3yTj2iohR8FC1i/LHyFbG9+A7lJNQMXCPQ1VEilDQFtNLOCeAM4TJRIw8zTxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11clsf1My69x8n76p1I8mYKdWdQv4OmxUfsKbuURzYw=;
 b=lE7IhJmTCtuXzbWaGcaw81yUbIJ26ROhQf+CBEBzXFSAgkZicxadxn2Q2CG74vu9VioA570XEXXoumc+/4+tA8GRixsmbGDXCMViC5f4XXFOPrqWrdJQArK1prpE0mhiBe4OkVrCITOUHsI3wCj/ZUgSzBz5q+0t2Ydb6TPpMCw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 11 Aug
 2021 09:47:41 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:47:41 +0000
Subject: Re: [PATCH 5/5] drm/amd/pm: change pp_dpm_sclk/mclk/fclk attribute is
 RO for aldebaran
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
 <20210811083323.1084225-5-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <a90deb95-6ab2-d1cd-b290-5cf1347b7c73@amd.com>
Date: Wed, 11 Aug 2021 15:17:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811083323.1084225-5-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::19) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15 via Frontend Transport; Wed, 11 Aug 2021 09:47:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46900f3a-cd6e-4721-8164-08d95cad0fc0
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5553333BE62A6E6B4E76A43A97F89@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr4UECMhPK6Bn6M12Is6HRMygcCyAmRT+1nvFeR2Dl/CUWkPf/6WdO6S4g1x/WNTr8Xp/tt2JfOzEP5a1qA3n1mlWKqmJAfZgSFULRbmO0pNXM+bdYkU1LvZnHX1H38LelEJppjK6AjdcxHboqNuu5bYdoh6/LUIQkKZwy3UN3fbkS3noq3JVaawHa+Mgjo3uEB7YbIT7htxRm6OYT6EW5H6gaLEzLMEP1vIVSVaBPHW7EpdF11JAuvq5k9KjnG+qqDa8DWW2KWrRNepxZyNvyCjmjg4slNTikmiDlz2kx1sDZ+S4bmZv81BNlMLJh8GtQRBEbMSHS5JhL8cyZLVctaBsDjW0+7mmJbrZzGrsQrgApgLVG4t4wSfFZJUuyLBDsHQ5ckN6rTYcMez0kJkFCcr4P3dsqzhf2O9WddDyBh8NF/gUiLUazR/ykH57afFlZp4t5l2AYV8FDG5L8Az+AcArRSZHTGqDdclLOkQ5nY6vx7wDlhJaufPttQR6+EEK0J4SllX5P4iMr9lRFGVehxH++y1UQyNx7hIjFu/1mQh2SGpniAVe3Ko5GvvGovpgu8yuFhAEKawQSBW42vEMIs8vNGlimS7dohnNeY2IOl15rIqcreZCppG6pmU9JBJZ2QigYgm7l4O0tEelMbnIut8D9gQZHdp3e3to9MXEnYKPyQiEBHDwyoqjzokifIkhS3ri3LEUHWk6IX7RCNUG7GmndQmm8frNrcrpDFfoT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(8676002)(36756003)(66946007)(4326008)(66556008)(38100700002)(316002)(53546011)(6666004)(26005)(508600001)(16576012)(2906002)(31686004)(186003)(2616005)(956004)(86362001)(83380400001)(66476007)(5660300002)(6486002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW8vRXc1ZE5wOUxwRHBOZkR0b21vcmFNSVRMWlk0K0pMbWFDckp2eHpOSE1D?=
 =?utf-8?B?M0ZwaE83VDA2M1R0RUdLWEs0SllhR2c4MExxaW4reHJrbjhCNUlLUjZZTDNv?=
 =?utf-8?B?b0QwdHJxMkZxYVdzUVpxbzFnQkNrclJIejNXbGgrQmdySlF4UFlYMHo5STZW?=
 =?utf-8?B?dklid1RxVldpa2g3OEVwRkNpVmUyZ01Rc1B2Y3k4Ym5wVDlRWDFqZWdrMFJV?=
 =?utf-8?B?TXdxU1M4YkRSb3FITTZ4dnlHSnRPcHlzWTBmRWNmUXBWcWV6WjhoaTU2N1hH?=
 =?utf-8?B?YmdKMW4ybGkrZFlrYjRVdnpNRTB5V01tT0dVUXphRmdFcHJZemtLSVlzRDFB?=
 =?utf-8?B?VWowaWZvOHowZkZMcWE5Wm9kK2ltZThFVEFtbktLMU5PNzE0QkpDOXROcTNR?=
 =?utf-8?B?cXM3azI2UUZiQldITGQ1RXRHZnFiNzBxRnM4d3RIZE0rOGVqNEN2UmVqT2Uv?=
 =?utf-8?B?TGVmY0M1SmlLSzBaR3dCNGFlMEQ4OGVCWWMyd2R4S2JlQm5MUkU4dmxOU0t4?=
 =?utf-8?B?NzVyU0pWZXlNMEV4OXloelVXQnBIYm5KOGF5RkNJdXpHUHRMN3krenExczl5?=
 =?utf-8?B?NUE2MW9UNmVTaFVrL3NOaE9rdHQyZDV2NkxRakJSZnVlY1dYcXJJdEtOb0tO?=
 =?utf-8?B?eElmbmdud21IM2xQNUZMdnZNWkswRlc0SllnVUQrME5LMkN3dWlHK3BTS2JV?=
 =?utf-8?B?UVpqR0Q2dm5MNDN5cHg2QWtaczZjQTU1cUswSlUrMXdYcU1jM2xCdVNObVU1?=
 =?utf-8?B?eGhmYklGaFB0RkczT2g3Wmt2MDB6ckErNDl5K1FPS3IxTE9XbWZmNXAvSUM0?=
 =?utf-8?B?T3RZRlBoUUpVL043TmhBcTBtQzFSV24zQ1NuYlhsWk53YTlwZ0V2OElvTExT?=
 =?utf-8?B?TW04RUZNOWJFUlE5N2IzSnhvVkxpTUsybllVUWZKRHlQck10Q2ErSGRMamZj?=
 =?utf-8?B?MmpqVzdLQzhVVzBDd2Q2ZkxIYktpWkhlRVNFZnhYeHJsRkxZVmRuRDVXQUtN?=
 =?utf-8?B?b3lrRFlPZVYzRHpEWWF2OStNM3o2aEU2WmVIT0lRakJkNDJhem1VdXhoRWM3?=
 =?utf-8?B?amUwZ25PaWNUMEdOTEFzOTl0QXUyMnl1ZXJKeUJsNjlUQ1Nab2E4ckFDdXBH?=
 =?utf-8?B?bENWeVhiTGlqcDBBMGQ1clo2dERDaWFDaTlVV2tIamVnMmc2S2lDcGFjLy9k?=
 =?utf-8?B?dXFCOHJRT3pKVFVGRWZpaWNON1ZQaFNTdi9IbGtpWnNHMkNtZHUzcDllWTdJ?=
 =?utf-8?B?Y0czcmRPUm4xVDNDeWdNaGtudzNHYXBzV2hmL09pVlc0MDNwY2pTNHZOcDVu?=
 =?utf-8?B?MTk3aTFPME9pUmhkaEI4K2NOMlRFQmljSHp1UGNZcG5DQ3B2VTlsV1FoQmlo?=
 =?utf-8?B?WGgzMStERDFkUyt2aml6TzNUcC8raVRzbnJ4WmJxdUJaRG9wWjdmUkhSRjhJ?=
 =?utf-8?B?Z0pKN094amJMMitIZFBsc0tkRDFVdVZ2dE1MZUk2a0xXOFBhOFFDdkJHQk5o?=
 =?utf-8?B?N2F1M3hJOE1wc0FzRU1vb0hTSEFFbjllU1lWblRHZjBwTEROK0VHVGRQVFBG?=
 =?utf-8?B?TDNma3pRaUwvTDJLbGgvc1lIR3hHZXhXMnVweW1UakJ5MUJGaVUzS0JrMWFy?=
 =?utf-8?B?QnJEZVE0bWMra3FEeitkNHA5VnhiQUlyMy9YS1pFVU1oUERJem9QWmNSYm1G?=
 =?utf-8?B?eXUxQWRuNG5OODFWWEx2MDc1dHpnR2huQzZYejBHQ0dmQVJLbnZzYVZ4OEZr?=
 =?utf-8?Q?CR6ak/r7g12x0aBjyXEQ/2zXX9c+W/SaNSTVAZx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46900f3a-cd6e-4721-8164-08d95cad0fc0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 09:47:41.4122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2LJ+0JsTwu+WTQ0XX673W/HBWYHozKJXP8I3LBwocpb/pF1/ZmY8gu848/KqclK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 8/11/2021 2:03 PM, Kevin Wang wrote:
> the following clock is only support voltage DPM, change attribute to RO:
> 1. pp_dpm_sclk
> 2. pp_dpm_mclk
> 3. pp_dpm_fclk
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 769f58d5ae1a..f894b34418df 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2094,14 +2094,19 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	}
>   
> -	if (asic_type == CHIP_ARCTURUS) {
> -		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
> +	switch (asic_type) {
> +	case CHIP_ARCTURUS:
> +	case CHIP_ALDEBARAN:
> +		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
>   		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>   		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>   		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>   			dev_attr->attr.mode &= ~S_IWUGO;
>   			dev_attr->store = NULL;
>   		}
> +		break;
> +	default:
> +		break;
>   	}
>   
>   	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> 
