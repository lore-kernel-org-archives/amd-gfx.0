Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14DBC11F6A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9891461DC4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9891461DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3160E890F5;
	Tue, 29 Jun 2021 14:54:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE146E8A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 14:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akLGtf4ycwb2CyguZnhhMd1eT6tykE7vDYZqiGMs1WXZBZhxj3RRaWN9FXl//Bw0gcyzjnmbAW6uywvGv4HMzOxfYwW6Vnv3RzoAhP3Y15JX1V/1FgtXCkzUzhTl5Xywt+IWWggRRP+IYKySicj3fNnikX6p5fLaonc98kBWSma6u6fQR6VaNo3hHtbNV2NtWqzNglOo0v78cIUGeOOLqpingNpIaXeHKmXJd5g23Lw6J1eU7p2tx60kbm8EuIYIys0yl/DpUb5wG/m9UzR6c4OrH+WxC6yNCiu1EgSHdrDkHj8sNb0GW04VqK5XtDjwDrQs+4yqHg1mFjsVaCKY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MftGs+t9b5BZkdSJiFk6bqhGuUTyrDccq8VASzXlJs4=;
 b=VlOT68Z2dACmZnExXX1C3ne5Rzk8tA3KhEe5yuYce7KWbDXcW7+T8Wj8duuP1LhBlHrB1edAF21C1pNkQ5c9R6wqjWM3FDcyBdnbi5QUx0GU6SPN2VKWIhPXR7VpOqmIUv2uFbI1lQ0NQhAMW24qzs0k0kCbVRXS+ASsclOUym+xIiiFS3oAf6B/5/X4NttxO7I6LoO/4J7HdoAgvxvdQqxuDoJRwlQBw8p1x63K1gXUonmDGfcfklcenzpRJZk6O0+gG0LO8TtxFDrqYR1RnNYMM/TKdbnRoxGmJZ595yPWLl0ckkKg57HzfanlT9VNiKyd/m6gcnRxllpD4Vh//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MftGs+t9b5BZkdSJiFk6bqhGuUTyrDccq8VASzXlJs4=;
 b=IsR8RE4Kp5XWmRWYC4XATqAQhruognbwWp3U+pSJWf3iMWq7rLZOBWK+4LKHbEWzP6Sjn4ausG+MWUiLcFetmDAiMfO1yMqsbfVYiZF3i7LEa1VmXOzkcUL3GCA6UkNt6BtlxTrq9d4tZAIwO/Ws/xhwq0nu4mYaklE80KJNwCA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 14:54:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4264.019; Tue, 29 Jun 2021
 14:54:01 +0000
Subject: Re: [PATCH] drm/amdgpu: add license to umc_8_7_0_sh_mask.h
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629141419.279179-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <63daff09-e20c-cbbf-babb-a1cde86bfeb7@amd.com>
Date: Tue, 29 Jun 2021 10:53:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629141419.279179-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 14:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ceb303e-ae93-4488-f92f-08d93b0dbb67
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427DC685B4D88D29B3AE3D98C029@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkjxRfsQKM7a+4+h2vmh/Vk9KerRUYg9wCQfv5BAMjdn/YhmhuQnnso91fpMuyohHdMMEAuSaRq23jPNLpmFOCWCcVhqj1fvpF9730PsLKmTXmIerM8iS3xVNnvNoc7AtpjCst/AKfvRlvMTHRHQ9nr5L9rQnJs5mZRU5MeVW3qF2HxhB/Pe5Z6wWwEHC+tZEUkLqnECVjT0RPvyuREFIQnwTkY7BYkhOEDw2f77YP+CG7O8lBAM12Ly3s106P/HZpA/+eNMxvd34xk9QM+StUPEpPNNTTNZKnmiTMIIhNCSIjTVAAgTYfn5Zf3y4OdWabdW0zXOxHpSpiVQduRDUEPljMgyE/1/YJvAW1GHGetIWyZqvMcMeTv7MzaNwzoGV/EVBIcYrek+MDUNBngh67jlfsVf02PDP3VYixY6KcnkrHZOZ8MuUHm9rVjspZnbFq0fciHDyXSYrPRZ3QHvIVH/pK3GxNTRYUUunk/Kyxu8ZWGEF2pcw5SKekro1w8WDkUUzLQXlaaM1hPPMfyHnZ7Md6ZinE9PvLg5g7CAkYFaBkWaQC/Ilp6egy2cNAnQ7i0+dnVhxtgYI3jFfcyQHgLZyfhmA0eAaV92LKVQK2+Zuuz1imbG/JdpQ7K7hmaWzPopAyFji47vaTY/PfJRMBx+yJ7OHyQJQabwxU5+UvCL9yzVl0vam3yuUZIa7CNYsoVGGJpCh5ellaxkTNZ2dQ+E4/TPmOUDvwSfFuyirXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(44832011)(31696002)(86362001)(956004)(5660300002)(38100700002)(16576012)(6486002)(26005)(8676002)(53546011)(2906002)(16526019)(186003)(316002)(2616005)(8936002)(6666004)(36756003)(66946007)(66556008)(478600001)(66476007)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFNdmcxTlBPRTdpSmdBQk8vS0VPUG8vRGZSZEZuY1QzZm9pRUlmQ1o0NmdJ?=
 =?utf-8?B?VEF0SnlQMU1LMkl3Y3NqU0RJZ2tXT0loZENXcUxMemQvaE9TNElEVHk2Nnlm?=
 =?utf-8?B?Q1hZb2RtVTZHbERiR1o1emVGaU5tOUZQN0RPWlM2dDI3U05sSFR0UnZQZ1RD?=
 =?utf-8?B?U25NdUsyT1JRc3NyY3czWVBldFk0WXBOS25Gcnd5bktwNkFOZ3dRemQ2REJo?=
 =?utf-8?B?cjJ1WER5eG5CMzdGRk5vWDR1MmpxVWVhZFZJRkVTV013enl3Sm1sV0RReDlM?=
 =?utf-8?B?cVMzQWxnWUNsZERsZGZhVS9QTHFNeGdacVE1NDg1ZVhSbFRjQ2tKNlpqSVdY?=
 =?utf-8?B?VzV3bVhGaFZzcmFpWlFTd0lveGlXVFM0Ym1rZXpkZlJmeklvd1lEMU1PeW9s?=
 =?utf-8?B?YWMybEVoWmprbEdETXQ3K3ZicW5NWHFPcDNlUHI0SnE1bTBkYW13Y3JmTG1T?=
 =?utf-8?B?czRXQlNFcHFCODNSd21SR0JMT2cvMVBGVWhaNUFqdXI5ak9YN04xc1lDbjFJ?=
 =?utf-8?B?N1hWOXFoSTA2U2UydkxSNXl3Tm9uNG41alROMmFIaVZaSUd6ZWk2YXhjOWk3?=
 =?utf-8?B?SlRvaVdYbUdmVjB0T2IrN2RNRmZ0VFljbEpobVE0WFZQdFB5U1c3OXg4VXJy?=
 =?utf-8?B?R0xtblVZeEhqK2JFaU5KaTdYc3FRQmpIMEVsTEt0YWI2UDBFY2cxMk40TUZs?=
 =?utf-8?B?SmZuOE9vUW8wY3NyVkVqYXJMWTlySUJDM3ZIWUdlZkxpckFHMWNmNUNoWXZF?=
 =?utf-8?B?L1p2cVUrNXBnb3RtMkZoY0VmRjJWUW1VY3hiQ1VQcXd3dmtpM0Rxd0ZEVlRo?=
 =?utf-8?B?Ry8wSDRWYWlsQ25QWUh1Q20ycXNXN2h0endMR3BkbEtMNUY4V2R5N2t4d2J3?=
 =?utf-8?B?TW9GeFNka3BReUFQV1dIaEVFS0pOZmFySTBjYlpReEJwUm9sU0ZUQ1F6Q0Q5?=
 =?utf-8?B?NEJyd3g2TzVNU3NBdTdPOWdyUzJBR0V1eTg5ZGhhdVlyNnJ4VnVwVFdQbUJQ?=
 =?utf-8?B?YkJIOGZ3UURMRHp3S3Rrc2ZCcHM2WHlWazNueit1M1JJTjRPczYwdkplQXcv?=
 =?utf-8?B?Y1pvV3RtOEFUWlhhQ3dvVUJUVXM0RU5tRlJuSTlUVXBtdmtuZDBnNmdaVURZ?=
 =?utf-8?B?bnV1S0hnR2JMRy8zMDJaN1lkSWxyU21QelV0WTJMZFBlY0hNcCszV2hTVkIz?=
 =?utf-8?B?YVZKM3BDZ0tqWjlLVmVjQVZRNlVwVzJKcFloSmFpQjNCeFA3c0hvY1VtcFBh?=
 =?utf-8?B?K2FKTVcwK1JWTnlEQ2pNMkFaMlhDTCt5SHhVUVZ2NkVlQWtkSU9KdVY0TytU?=
 =?utf-8?B?VGI1RVFZTXgwblNwcjYxRmpJRGMrNjlXdGVSRjZXcmJuT2xnTS9DTkY3TmFM?=
 =?utf-8?B?YW1Qd1hqNmd4TUJZdkxsaVRZc3cvc0NjaXFoQVRBWER2aS9ycFZJUjRZZlRS?=
 =?utf-8?B?SXpvVDRabFBJQnJ0SnVWeFptd1lva0ZWQWZMS3lCOHQ1Rm1nZW9CVlJsY0ox?=
 =?utf-8?B?N2Y5K3hJRTRYUDJRcy9tOVlWSjh6Z0xCOWI2RURkcmZublFkT1JXM0FqeVN3?=
 =?utf-8?B?K0tYVDQ5SGgyM3lhYWtYQ1FEUXAxeTRSb0JtNkpKTzZYbENTOTllRkRwWm4y?=
 =?utf-8?B?VXRiZ3BSd2JjVzFtdlpQNnNrV0R3NjJZalZjSVJvc0psSkdkZGliVTdhVWFI?=
 =?utf-8?B?cXFCK29iOS9pT2xJSGV4WTVrRSt6QTdjekxhK3l4aTc2a1NTVzBEQUhGM3Vp?=
 =?utf-8?Q?nmjw+P1n4Oexhz05WtDoJ1fIEcTu2rFGQZfbFGX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceb303e-ae93-4488-f92f-08d93b0dbb67
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 14:54:01.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq3BfxCvlanbwPpAJ46wKsQyBo+tWa067b6x/nvnl8a5ZPbw0uqv4Dtxi15HkleKq03QMTAK4X1QWfac9A1F9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-29 10:14 a.m., Alex Deucher wrote:
> Was missing. Add it.
> 
> Fixes: 6b36fa6143f6ca ("drm/amdgpu: add umc v8_7_0 IP headers")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../include/asic_reg/umc/umc_8_7_0_sh_mask.h  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> index d5ef91d3c391..20329da53b0a 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> @@ -1,3 +1,24 @@
> +/*
> + * Copyright (C) 2020  Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
>  #ifndef _umc_8_7_0_SH_MASK_HEADER
>  #define _umc_8_7_0_SH_MASK_HEADER
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
