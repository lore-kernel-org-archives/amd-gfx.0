Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D05AC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AA010E0BA;
	Fri,  2 Jun 2023 15:19:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879E110E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP7Rrtlfrn3M6UZNGOGw5YFMu4VcejzaC7QUQHZ8MpERNCf956wiy9yxrAj+ZIAKwmgG7zaARjeYpcry28rl/XcrBeV29ylP5wTitpD+ZkvIN+yi+hLFkKsHOGt4+kgmmam1KLkzsaFHRbt5npQ3ul2ZYRvd15GegjPIOEvgI4ih1J64VniMDFz2hLUEl1C07HewzpuMr6Zt7p7YeHilQBWpZ7LFs7B7LZQfuJDOYfPha1vjkOTBMl8A17fG4l3/U+GqPi8GXGU9wbXbQWN2R8SXEo038jJBbaSrxQ+b8R29z9bp7Mjj2vp6NcWAehjfwLans+uVumom4D7r7GcWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDpjXJcZmMBAPeBjj81pU92z7/wfUFCiokkxueU9kSs=;
 b=jo9SvIDV/rg+WxRZ1tDvL+NmKz5egwJJ5NPEP9AE+vKkcI6UBQCzvvOCUFogMAYzSKvvkjVebYSkvdmWIRPdhqyXlL26BaGThSdmfXbPKHE01u2qip0E+hDsgRgC9p8xvohE28JUSaxGBfyoBaIsv8o2tRyXpEUJNYNeunzvXis3L0OekOt1MxVHi9FB+YfQ0PCv2jh0PDn4n2w1WBJnKQkMoS6zyVwka29hytR9nBw0hGo/Z4WGBj8VZ5jBerZHXwrd+O099aAaZMX/0gJbTuOurok3F22slf/lIOHU8F4zEgrD2UKwqgurykQ3iLFAZuGxmcuhSWgAxu4KeG4pkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDpjXJcZmMBAPeBjj81pU92z7/wfUFCiokkxueU9kSs=;
 b=KxU3E7BfPg3a0LLSE+t13CpScx4hi2fw/36U0hHCkSyQ3apYYL8CKxDCS3jQsW6IwfhWbFmq3Zy1Y1cOqRfkau6J5eemRQINDob8J3w1Or7cYrnxHnevQZcLQj8uLRXB3R26VT+USQ4TK11HSo+r7hb/q4Dj59zeKdYcmZvsbuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 15:19:29 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 15:19:29 +0000
Message-ID: <f3c6b729-0fcd-ecec-1880-2af4cae22248@amd.com>
Date: Fri, 2 Jun 2023 09:19:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Add gnu_printf format attribute for
 snprintf_count()
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230530203342.3161018-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230530203342.3161018-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 508c1aa3-2f04-4296-76a5-08db637cc232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrDFHMAzvdutW1ANXjsnDIja24y23BeQ8urOcb8eP9wYbAXI9BB/ZbJSvpB/bV6HUfw0kdhctKssRPNcdKyZjvgj+CEqLSdYHcM2GtcPtnSMZO5vk0ZzvXpLzdOqnnWBq2bZYv1o4W+Ik3Oqn1y23ZJsm3o+2PY6sK5YFLiFmf8FZ29gk5VgS7SZ/EfesMdSGmsdTn7PrlW7W5PZDwkfSY8cuXkpuF5KRCfoNcqywZOuaGg6DlGyd5JOyujnwUX0GrsrKn80U3jeNp36CjnzXbLlXPdF0FJZmbOIvuUw2WBCkw0lxXoRD04kROPV7Aw8fj6Agc4ElR+xrK0h2+h/L6x4tgsH07BIrDwe39mwjK8pmTUILCV8u1al8jwwtIvITUS9xEKa2r3BO6abuPP7uyNgSRnu0AYR1WnQv6q2WRLe0TvbGAIhHS4FqFPdaXlxR0XgGYWyvGh5Ns5HZULIquQgVwCCKoz58pwHvw2fgMpzrm96bjkv6oSFFVXMl4LaJQXwkX+DggC4k5JM9AAdOl4Qj06H5iljb6hDsi8jWySVXthKA6vmRE+YYHI+WCeGq7cQlzI8P/94VbzNaOJTcu6eJkom453XbmMtp1qKv+wSRzZYJXLPJk2ZcM7YcFJfCI/GBAIIJ3DiNjDcCdsxYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(186003)(316002)(6506007)(6486002)(6512007)(53546011)(6666004)(2906002)(8676002)(5660300002)(36756003)(41300700001)(8936002)(38100700002)(31686004)(6916009)(86362001)(31696002)(2616005)(83380400001)(66946007)(478600001)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFhc2ZaMnl5SDJXcDJrd2VBQ29KL3R1SkpxSmpkMVcxbnV3NnBSMXREaXhq?=
 =?utf-8?B?R1NRZ2xmNHpxZnlhSGFrSWxXUlgrNmFWK3BrQjdoLzdIaHA2cThqakNrVTFD?=
 =?utf-8?B?UTlGZjdodEhEOUYrRnlIK0VweTNjMEFBWXhYeHRQZkRMeEhBL0FEemYvWElm?=
 =?utf-8?B?MGt6YUZ4bXI5MENQTjVoRnh0Y21uTTY2T2RIYjdEamxpbUtCWmZEbnNCQk1o?=
 =?utf-8?B?NUwySUkxY2Z6eHNQamY1bms3QW9MRmc1cmxlT3Q0dTZscmN6VWIydGhqY01R?=
 =?utf-8?B?dnNqS0RDMSsyRGhyKzFBZm5adGk3V2ltL2JlR0tpV1E4UE5kT3RDMXBQazV0?=
 =?utf-8?B?a0hBemVGQ00zeXFsM1dKb3d4RVpDeTk5STU3eXhsanVMMnpXN21pTjhNRnoz?=
 =?utf-8?B?SE1tZVFURURKNkFXWXA1TUdBT3NFUVhPdlF0ZW1Gc1FDcWE5N3VocFIwUDhr?=
 =?utf-8?B?TzZuR2Jna0RldzF0ZmdJYjBpM0FzSFY1V2tDVFB3T2xDdXBYQUJZcCt1WnJW?=
 =?utf-8?B?NHBObFdSR1VzcmdYT2hGS0FTMVJlV1EvczZnYkNveFByRndHSTVWdWZ1OXNS?=
 =?utf-8?B?dnlHMTR6UG84ai9WTFR3VkV3TVhFSng4MURQSjFOb1B0S0x5bW40QUlWMDVS?=
 =?utf-8?B?Y0tvVU1EZXhDRHFNYnppQ203NDBoOFZFUWs0SWRWUEp3T3VlS2xNMjg4OE1j?=
 =?utf-8?B?RElrZ2l3UUx4bUNKY2UvNk1YQXRPM1Z5Z0dHLzd3YVFXTDhUcndKZ1ArTGZ5?=
 =?utf-8?B?QzM5OHRZS2pxWXI0YUNMRnM4VFhRakRPZXMzcTlKTDRFM3BnNytIbWk5Z3NG?=
 =?utf-8?B?T0txclNEQVRORjV4dmhML3Q0eDMzZTNPYlZuWDBkd3gyMTc4WXZ3RnJyaXVm?=
 =?utf-8?B?NkUzeTVpcHQyNmUwVDRNbWZCYWdQL1p0TnJqUkU4Y0l2WC9PWjlTaVVYdFZu?=
 =?utf-8?B?aEprdjB1RkE2MWhjSlNPNHZaM3gyNFdpNHdxbzJDRHkzVVpTbzBsRnBsd0dm?=
 =?utf-8?B?QnNQRlozUnUyUGRkckdFVUloL2NEK0wrTVMzN0MvS2x1M1NCMTc1VmpFLzgr?=
 =?utf-8?B?cXRWYjN5RVZuOHpvT1U3WWFzd3ZpSWlPbDhzQ1QxeDN1ZmNXM0F1VHpUd0FB?=
 =?utf-8?B?TXRPL0doWGNMaWhzV0d5eEpuVmJ4UkJwSzNTVGtVb1VZaXpuL1l5N2pHSHU0?=
 =?utf-8?B?a3NZVUJjNkNZdEcxS2tYRjFHRElyeURzUjcybnIyWC8xSldrb3ZsSU15M1dw?=
 =?utf-8?B?MWNndjBGQkhuQTYvV1ZJNkI5VzhoMGF4MDFQTjZjWVEwTjRRZFk5eHNVZHc5?=
 =?utf-8?B?czJ2SEZOUllPVXk5eGNjdUhOMnlsQnhaa0YyL0hTLzh5MkZOVmorMUxKcFRq?=
 =?utf-8?B?QjN1d1Nva2hFUFF4aHYyTjEwem1KaW42T1RYNUhGblBIcU91NDgxSENwdTJO?=
 =?utf-8?B?VTZhRExFTjRlenBjNlZxRWhtRm9wWWY0SlNra3gxYXVkNWVmeDkwMkxtK01C?=
 =?utf-8?B?ZE5jRlJHZEl2LzgyL21hOE85T3pvOWhEaFNqQmtQaUZ5UkJlWWpCNGZ4VTlM?=
 =?utf-8?B?Y1RvVS9WQ2EwYzZjME9mNFAydHYvOFNDNDZQZS8rTkpQMHNSV1N6VzFIcmtl?=
 =?utf-8?B?ZklEQ2orMTduSERrZ293VWFWVFVoVnlpaDZpRHpReGtyb2Vvd3RZQWt5MGxX?=
 =?utf-8?B?NFVLajc4aE8zSHovcXl0dlhZcjJJM2E4SVhFM3MyV0loRWRNQ2xuTVdyM0do?=
 =?utf-8?B?OFFsczFDcDFVWERRK1h4ZFhjME1GaUpjOXlnM25ZdGthZzJSZVBiVjZiUlhq?=
 =?utf-8?B?T0RVa2NKc0NBYnFsV3o1ZStpTkJ1U2xBWFVWbTVDTXpxWXJDOFZzNjMwdFkz?=
 =?utf-8?B?U21xM1ZKc3Nsd2xsSFhhc2VKa283Uk90SnlWVjZTcWRiS3VTa2VvUmlERlI2?=
 =?utf-8?B?VVdmTnNpeFUrQUFJR1NBTzRXdE51SU1PcDJTdHl6TkxhMmlVRnpEcGJWZWR1?=
 =?utf-8?B?aWJrMGo1TWpLbkFiSGR0WjhrVS93Ny9rUmtUajh3Z1lpZlQ2eTN6QjQ5Mjhz?=
 =?utf-8?B?ak1mVyt2empid3RxVDJGTEdxWkcvamtUaHA3SnZaeENVM1pMUkRTUlZMVC8x?=
 =?utf-8?B?WDhUR3FBZnpzV3RXYlMzajlaWW1GY09TSE5DWTRnSlhQOURmTW12TTA4M2tL?=
 =?utf-8?Q?G7VQ6BWFGLPd2s/VrL7gb3Dw/FK09/MQY+FYk3534pgM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508c1aa3-2f04-4296-76a5-08db637cc232
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:19:28.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isTNiHs38o8cGRVVeZ2lQNIxpNsC/9cxQDi/yV+ZfTIO8kRBWlSYnKfYUQWrXFhC4IkzvULG6/PTIw8bISBDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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



On 5/30/23 14:33, Srinivasan Shanmugam wrote:
> Fix the following W=1 kernel build warning:
> 
> display/dc/dcn10/dcn10_hw_sequencer_debug.c: In function ‘snprintf_count’:
> display/dc/dcn10/dcn10_hw_sequencer_debug.c:56:2: warning: function ‘snprintf_count’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Use the __printf() attribute to let the compiler warn if
> invalid format strings are passed in.
> 
> And fix the following checks:
> 
> CHECK: Avoid CamelCase: <pBuf> +unsigned int __printf(3, 4)
> snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
> 
> CHECK: Avoid CamelCase: <bufSize> +unsigned int __printf(3, 4)
> snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c  | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> index a0f8e31d2adc..46a2ebcabd1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> @@ -45,7 +45,8 @@
>   #include "dcn10_cm_common.h"
>   #include "clk_mgr.h"
>   
> -unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
> +__printf(3, 4)
> +unsigned int snprintf_count(char *pbuf, unsigned int bufsize, char *fmt, ...)
>   {
>   	int ret_vsnprintf;
>   	unsigned int chars_printed;
> @@ -53,15 +54,15 @@ unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
>   	va_list args;
>   	va_start(args, fmt);
>   
> -	ret_vsnprintf = vsnprintf(pBuf, bufSize, fmt, args);
> +	ret_vsnprintf = vsnprintf(pbuf, bufsize, fmt, args);
>   
>   	va_end(args);
>   
>   	if (ret_vsnprintf > 0) {
> -		if (ret_vsnprintf < bufSize)
> +		if (ret_vsnprintf < bufsize)
>   			chars_printed = ret_vsnprintf;
>   		else
> -			chars_printed = bufSize - 1;
> +			chars_printed = bufsize - 1;
>   	} else
>   		chars_printed = 0;
>   

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
