Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EE9C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52327892CA;
	Mon,  3 Apr 2023 13:33:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBC610E475
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 13:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGMhNx+Lq7PrBqAwNUvbTaNusDhA99OGFogk8ZQ9CTQpgRhiekzJZdo4d3fKbNaToZmjLaIqeqiTiPSdEQ/Z+22tyzyGcrr1q0Ob/9JdjPI3WPZxxB/kzi/hDMICjI4cClC2rewlVr5KE37MgcsKgXcFfqbW/h1slUqM2mehHY0gycsnCYq+rKbGy4q4DP5Ax529mrDkxA2HrqdW3deNemr6iEgc+qgzfCJISKBIF0I5QePdD7KDL06pwC5oQKcYCSfcK8ZsCElwAKkB6XnCs/85Xi9LaMDz558um+jgsyax4T4JQgN7mB3/9C/TmVbfmAirBImiBmllxzRkqTUd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtTYo/YHLoHYIpjiglvwvOs7RUyooOI8dQHBRhfT7Y8=;
 b=JvbW6BjZEEAOf/UGfBGhagmfqVxi3ZIcT6FtevW2B6uIOhweC1iziweqvkQ339FOKTEtETauvxZDp7wfYWJ97hViXRTHVR5t2xqohzXSb5hXE6pOrHwOHa4OE0Zc2JydhAlVh3Prn04GXeUv/nwulnbNgGMwS4y9C6vSyFjsLsEXyFas6h1kZ4Zfl05Xj1wE2mKyClzOewTfV/qN6ifGXcyIQCvUDSfxRG24476DoKOVGjL/a527u7sYxBR6Y17IkvzxpzjFLradBraJrSJOY5cpG2aRYSboS/ucJW80+tJPobxeDrwGTipkxj7l+cG2n2TDMIKJdIkE68md/f6hPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtTYo/YHLoHYIpjiglvwvOs7RUyooOI8dQHBRhfT7Y8=;
 b=RAQGKnX3UW06pyadsZNpjcK1G/ov6e02WS0VarcB/5XAx526tJVr7xfMdto5b7oObZs6z1tGHoxcsvARSk/PFUzYaEyE3Z7GA4Jm9pGDD321JYlGPO7JMIapZ2bwKeD/bIbur4iwh/tnhCTD14zaHCuBvYMvhNPm0evd6T4rziU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 13:33:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::313d:28ac:3dd9:269]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::313d:28ac:3dd9:269%9]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 13:33:11 +0000
Message-ID: <0dd2627a-d5c0-5e8a-4eb2-c719633605b2@amd.com>
Date: Mon, 3 Apr 2023 09:33:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amd: Fix an out of bounds error in BIOS parser
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230402220832.17792-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230402220832.17792-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c7eb9e-c08a-4783-5e34-08db3447f83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5fdDJm68mxUYSmvvTKoQ0yCQKZLo0drvsGLNseM4KvSn+0JdNRaXAuiR0+wDXROEh8hdAOXbKGZWb48c2SFodZPRn6hgpGrtSUaI5w6DGp/rQkuOqfydspISQ5N8BTJX6rWvD2TvKFtzPQaGjHPyl8iplD0LI2LU51Vx4iC7fzcpw4G/mbyjt9u1vfQewA2xNpJR5IqW7XerrTHo5uEwh28ymq9b5SSPRowNNgLuQd7I6j/GObVkP2YhDhq62Wv4IIc5QoNLQqyc2ZSdjiG904C8FX5ga9bQ1vg0WJQHQT/AgOV5gJHQQrTNhGEgCbwZPBRUScqYwgoQLINY538GmDPlzsZ2rG+1L4oXW95WBp2UCwQWEbXrT8pClj6bPjODRSeeKF6u6XfkDCZJgMiXmh6326ssGkzBfofYw6N8wYMCY2VvtYZPwTz+zZFCFr1fyNsPpM/mAhhTca9wRe9NsTjMvKIxTZKoPauZBfpRdNt8ejrZ7loXQ8dbEA2lzhO5IztVNfY0e6w9rJjY7PsCDQgBlEgc7YWK4FxaQup+Ero+CqWcaVayhzgzJpguWHSU6q3rzSAMGvY3jXZnivQL1Q/uchHLA7YtK+iiyO76TOuwgogKARKv9MOAVbGKMKcNMKl6a1/JGuJb37rNFHpXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(31696002)(86362001)(36756003)(83380400001)(316002)(41300700001)(66946007)(4326008)(6486002)(66476007)(966005)(8676002)(66556008)(478600001)(8936002)(2906002)(44832011)(5660300002)(38100700002)(186003)(6666004)(6512007)(53546011)(6506007)(26005)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJhUkMwcVlVKzZmS290d01MbTZrTlBHbVRwYnM1cC9yaUsrMm9INjdMNmRN?=
 =?utf-8?B?RWJoTWxEcWF6UUF4azJJNnFMM2k4Y2Q0SElPUmdJSWQwUXNBRHpMT3g0eUJS?=
 =?utf-8?B?WllWditmMEZqRm1INHVySnVrditQQi9ZYkxEUEFoOEJLNGJLS1BJTEhBTUU3?=
 =?utf-8?B?WnpMQmMvdzFFZE9RMkJtaFFpeGJMd1ZDNHhYOGJEa2U2UW5IYUlEaE0rNU9s?=
 =?utf-8?B?Q3g5bmZ4eDdmc1NLazRTcGlabHZ2NzliUlUyRjVJWjQ2RUp4cHBsaDAvSU5G?=
 =?utf-8?B?VUxBNEhYWXluZGNDVloyYjBXcjdYRm80WVRFYlJ4SVJmamQ5M1BYOHNTM2FP?=
 =?utf-8?B?UlNtYm8zTWNsNi85cmNkQ2g4UzJ1WlVkMWNydnp3a1FzVGp5enFzZUtCNVRk?=
 =?utf-8?B?MStiUTRqeGIwc3RLY2g4YVBEcXhDcHpLOE9xRlJTbzg5czFLbEoxVVpwWGJR?=
 =?utf-8?B?aGZQMkhHZUFKaFVNM3pSZGduOUdGZUs5Wjh5UWN1UHNwTE4rRDR0WVV0NFg3?=
 =?utf-8?B?U0hhTEZzM25hb1g4eHp6ODJKZExjNWlienl5TVV2YzVTLzNUTW5MamxzSUpn?=
 =?utf-8?B?R2NIaHRjMEpkMUtBL2pseFB0TnB5KzN6M3drVmRsZkd4QkhtZ2sycml1WHBV?=
 =?utf-8?B?L1lYeW1oQ21sOXYvOWxSRkkwSU82RjdHN2ZEbnJ1NVhraVVDbEs0dFNKa3p0?=
 =?utf-8?B?M1pLS1VOMklKZWlZeThIZ1ZnWVpxV2cwMFVVNWpITitxSWMrVmFJN1dFRi9m?=
 =?utf-8?B?aVF4dmFlbWI2ZnVzOW1hSUNFMVFOa2JBZHpBTGp2ODVoMFRSemlYZXdlU0lU?=
 =?utf-8?B?bndmdFBydmtWbE45b3hQNGd1dFRBOGE1M2hJbnJTQldSdWVGeER0THNaNS84?=
 =?utf-8?B?bnFyNk5temRkNjhnVnlkNGxKQ3V2aDlTT2UzTHh2SUY4aWhGZlNNSGNhd0p6?=
 =?utf-8?B?dG9ROXQ3Mlpqc3BIK01zK3BvMTJZdTdOSVg5UDZLd0pmZXBjVmljcVdyOHBo?=
 =?utf-8?B?ekRta3VpK0kxZUxnNGtHdEh3R2UrbDdBbjdRN3hPb24vUlZYcVM2RmgzTGlY?=
 =?utf-8?B?NHJFZ1NPc3AzYmV5bnZ3Q0NHbmtoaWwyMTlnWkM1cG5JeFpWZElxNzVuT1o4?=
 =?utf-8?B?TEpLeitFNFVkd2hLU3dJUk4reC9YbGFWMUdKVmR2R01XRjh0eUJKd1I1VHFw?=
 =?utf-8?B?bHJ0R1VHcnBtZEszMW9BQzZiMHVRZlovWWVZS3NwOFphYUhhTE4yT3RoeDRD?=
 =?utf-8?B?OE03VHB2R2lRdWNsakJiditWMWloL2ZSaE5FVGhLZkNjSTI4N3pFamJyazdu?=
 =?utf-8?B?ckg5SDBXdHhoSEJNZmppWnQrRXp0WFh5aThHSVhFSTZpUS9GVjdHUEQzR0FV?=
 =?utf-8?B?aHd0UkFNK2FHc21TNmkxMnZsSjI4UTN0SUhBQ0JHUUV5TVpXdUVJcmExNWJs?=
 =?utf-8?B?cjc4Mzl0NnFjbTdjWE5id0dEUzgxQkpGUEJNSUlDTjBoajc3T2ZHVDNQVHl6?=
 =?utf-8?B?cFQwMWc0cXcxVmdya084aWpmMjFvSUxuMFJLU2JpZm94WG9WVWczK1JSYjJF?=
 =?utf-8?B?QjRjdlZBbTduekdqQnFxdVBsTFk0VkFYRHczUUZJcTVVcDIxZnk4TlVyVkoy?=
 =?utf-8?B?SmlCdmFmRTdVNTRxYWV5NERQRjg0bi8yS3hvRE9mb3IvUDdzNXdHTGJBcVZL?=
 =?utf-8?B?OXVyWDE5dEJXYUdSemhkbDBhSGo1VkZIdTY0V0FoeUc0ZXhQb3JSbWJLWGVQ?=
 =?utf-8?B?TWRnQzhuV2lWUFVBWkFQTTNlc01SamRNeVIzWm1NVkVUeW15UmVjTzlXSFht?=
 =?utf-8?B?YXZSamJjalY5ZDhRbXdRMm1hcHViUlUrM2Y3dGl6Uk1HK21SN1l0R1pJVUs1?=
 =?utf-8?B?MllwU0VOMDRxWG1hRUlUUVdMYWpMMHhKYnIwanBjQVRMdFVjV3pTSS9Fc0ZL?=
 =?utf-8?B?U2doUWhINjRjMFNLZDBjbkQrbUU1cWs2QkM4SWd4azRkVjk2aFY4QUhoS25k?=
 =?utf-8?B?Umtwb2w2VFpMMXY4aFBOWWhyQVlOb3EvcllkdVRCUWRTc3JQVmNOWDNZSVoz?=
 =?utf-8?B?bHZpaEJmUUZTR1JmNEUxOXJUY1V0WWR1YWpwbEJGRS82VjIra3lzN2ZBK3Mz?=
 =?utf-8?Q?u3e6axCv7/uUNeK7V8KukcxcL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c7eb9e-c08a-4783-5e34-08db3447f83e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 13:33:11.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQOfKquQaTGJmDBde5PQ/oPCpGdYDZLCH+dxwwfu1Smm14SV8HYcHBSg+zTLACxG/2R7OwsP+4836Gc9n+QHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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
Cc: erhard_f@mailbox.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/2/23 18:08, Mario Limonciello wrote:
> The array is hardcoded to 8 in atomfirmware.h, but firmware provides
> a bigger one sometimes. Deferencing the larger array causes an out
> of bounds error.
> 
> commit 4fc1ba4aa589 ("drm/amd/display: fix array index out of bound error
> in bios parser") fixed some of this, but there are two other cases
> not covered by it.  Fix those as well.
> 
> Reported-by: erhard_f@mailbox.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214853
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2473
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index e381de2429fa..ae3783a7d7f4 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -515,11 +515,8 @@ static enum bp_result get_gpio_i2c_info(
>  	info->i2c_slave_address = record->i2c_slave_addr;
>  
>  	/* TODO: check how to get register offset for en, Y, etc. */
> -	info->gpio_info.clk_a_register_index =
> -			le16_to_cpu(
> -			header->gpio_pin[table_index].data_a_reg_index);
> -	info->gpio_info.clk_a_shift =
> -			header->gpio_pin[table_index].gpio_bitshift;
> +	info->gpio_info.clk_a_register_index = le16_to_cpu(pin->data_a_reg_index);
> +	info->gpio_info.clk_a_shift = pin->gpio_bitshift;
>  
>  	return BP_RESULT_OK;
>  }

