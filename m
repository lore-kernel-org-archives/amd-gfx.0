Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74EBC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03410E0A4;
	Wed, 31 May 2023 14:42:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA2010E0A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmSB1WsGsHkATbrMXudqVR8xXapHuzH8Ek8h6Tq8Vnp8xmFiiqIhuOTJqA0QrPOdh5Mai0HbreftCpEtzppcaZIuGTttHtygTaL1fW4HyyHDP5HFjGLlOf5mmV8lf4VQVaeiNfaZvUi/GvB2xAeQX4nNdt/GJThQd62E5kIzar9ax3OAdSNfUgHkkpGyI2WLEVsrWPpWBzFv0XOkU9X0zz+pPnqJj5LCxNBr/vGWGqs7HhUsFRXF8pD5Hp3XKez+31HqCPZRjy2YFSRtivnEmxqjRf8EMrSm3YqfseL5KLJRlIqK4+bDxDl9KzTYK4d3cDM8qEc+kivMIYghATxA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIfHcfik0Y9IUhNlXUdqjM1P8Oxo1NJUKzZXypAzlw0=;
 b=k0KoiiVusbrj7qIPbGHqVtR1n5GnIV4C2jt0PjrKKHxkzSmIvkrmf/xo1I2/wWCqEf4+eQ4GRwGdg2cq0uSIz8h9CnQtyZBedtI1ISckAZ0b9BsQ15n2eMw3zWmLBl4Gq0AxHWHsAdBQ9sF+FYQxEKckKA1sceiF9XMUwAjZxb7Fzg+N5QDzCzfE5rZ+bCzuhM2uSfMJ2jfVqamiBttEGh5beknLJjKxCTkHL5Gk/dN+8EdvMkdxgK24gr7BoLpezccg7uGvDbCQIDkaOtfa+JGIXUmBtElkRLCgnDy4/WFBohi5SbdLeY1xwjsxXkMD53PQ8Z/z9P/5gZyCcXeY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIfHcfik0Y9IUhNlXUdqjM1P8Oxo1NJUKzZXypAzlw0=;
 b=wMJ0r97ZquPq3lHVXnJm8E0/MffMkg6jV1BBNT2pGA+uVvr4SGQtwxchV2NPWUSiNiGx1+aqt6lf9uYMc+UvIghnUuEzA/OhJ3B225/TeztZvJ4DexrAKTg6+9E/bDqzzHZjH66NTToeUdsWWpj0m70xkT1XGuM5Krhuw8lcgB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:41:56 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:41:56 +0000
Message-ID: <1ccae500-8ee8-dd21-e4fc-413f5833e917@amd.com>
Date: Wed, 31 May 2023 10:41:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Correct kdoc formatting for
 DCN32_CRB_SEGMENT_SIZE_KB in dcn32_hubbub.c
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230531035236.3229523-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230531035236.3229523-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::28) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a4d3a3-96af-4b8e-9542-08db61e52e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmOuJUii+Dmp/nChGlL+3PKOwVl+7y1KO4U+CEnUkoifozWMmmbcnBtrFOnwG1T8QRpZKPJ4gO/NC1IzJPA+SRXLee7qYi6bfBEUN41WIFkks0L9KMqA63EruSeTvAzVdDSFQGaAReuqqjX+4RzqL5guYLWeJb0HARVwu5XXlorWz6tSmCwctQeuqtZWRcAh3yOmKN59DlK9Y/Onj+D6VcykMJzI6TX6ehzvkm9mov3nRbxopnhfqVHFTixYW7gY8/acVweYYRvBHCOokJOTfhrXAHL/S50/jT3M7fABNeH8Nb2vYyAwbbhNTHn91noo/iTLY0rBuviCqv9wh+W5JsSWofzGI89tXlUwKFxttoE6ee2pU9cxba4u7etn+Ge9C7kpVj53ZvcKISG/NNFYpF1hRvHpHv0B4yruwomf7Yva/Lf9LjTL2Uq+rmzTMGKVkbB+/QIF6klnrFOx4nYRQG892Z9OZDBFyTTdFcdf6jdvqL6ERt9M/z3ofWcibyOj5dlMZu6cbIyn7lmvf9eHTddmzRNUBYNN8z916tUlvhUFNIyzR/JfnKsTJWq2r30RyjXbjY0kpbo2FB4UCWbfDWHYau1lphvuh1ZyBbMT0Lun5RcB5BUsRGLeBuAApuO+m6sDS8TGLTaqiJvB0USQlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(186003)(41300700001)(38100700002)(2616005)(31686004)(83380400001)(6666004)(53546011)(6512007)(6486002)(26005)(6506007)(478600001)(110136005)(66476007)(6636002)(4326008)(66946007)(66556008)(316002)(5660300002)(8936002)(8676002)(44832011)(2906002)(31696002)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNEcm9mZUYrOVQrQlYwNDFuK2ZNNExiYmQ1REhlSTB5a09OS2Q3TXBwVWtH?=
 =?utf-8?B?M05HOWVxb0kwVGhmcWY4OFRsMzhnVDZEeHU2bk5BVnR5aGN2UlB5bWplOFRL?=
 =?utf-8?B?VW9sRFkwcmVBL2p6RDNWbXdpK01ibUNORGQ5b0VRS2pDdDJUenMwZXB0V3BZ?=
 =?utf-8?B?MmtDdTl0My9wSUI2dHA4bEgxNUJ5WnNyaVNLY0ErdXVTT1RRR0Zsd1hrYXpC?=
 =?utf-8?B?TW5lTkc5NEF0L2o1b2lxaTFJQytzc2lrWENKRTRESjIzNytuU3J3SFpRbXBi?=
 =?utf-8?B?bUp3aXlrYzRBc2VaMUVQVml4Kzlpemp5ZzBLakVMT3MzNVU4V05BbTlYV2s4?=
 =?utf-8?B?NlpLTGhaYjBQeUkwQ0wzZWczTkZydkxEWlJzemhNT01HVzVLazF5dlVsSDc1?=
 =?utf-8?B?WVg4SEV2dTJxVXRXMVRIbGpwWVBCcHBpbHdRUlMzV0hpVE1nRjZkT3orZFlt?=
 =?utf-8?B?ell1THVtMjhkaGVsTWlGaUJoSllQTnRrYnU0VXhEd0xoSnJXZzkxTWk5aUNj?=
 =?utf-8?B?T2twVnMyNGlueFNSdFFTTUNMOUR6eWg0MEhMNXA4eFozdDlxalYvdWRTQ0Ir?=
 =?utf-8?B?cjg2YkdFZ3RsRXBjc3djRkVmQlBobnp1VEhnc2dZUk5uQ0dvRDVmT0JlNUov?=
 =?utf-8?B?SVlMNkxqOVBqUDVaWDRtMStrZ3hPamdyZTl0NjJ0MWR5ZnV3OUVRbXR1cUNH?=
 =?utf-8?B?UnBLUnNtOXJFZkxZZlJ0SzZoOEplbW16UmswUFltRW9TWnRxWXd3MDNGOEpr?=
 =?utf-8?B?Nms3MEJGbndoV0cxY0lEVExXN2hrYURhQ3JuQXh2aHVTeUNDQ1NHcW03eXZH?=
 =?utf-8?B?ZnAvT01mWk1OU1JCdDJIZEt1cTgyV05NZGVGYUh6QnJkbHdFT3FyZnQvYmFB?=
 =?utf-8?B?NUxkVHBEempvVGtIQmdURDBhTnkrdEN0ZDZjeE1DbnpwclFyTm03WGdpNmJr?=
 =?utf-8?B?SDdiQkRKUko1MGVBODVEeWxmeFBsd2lPUUp1c210RThSdDNvdlljY0E1TG5s?=
 =?utf-8?B?TFFPQ1VrSFBKUkJ1aG5JMmVkZ0s0ZGZIK2ZNU3d2aEZMWnF6UzJsUzRvVjVF?=
 =?utf-8?B?Rm5kZFlEZVhSSS8yY1RjQzRpZTNXZDRON0ZCeEpjTjlML0s1cnNhNEFUYmFa?=
 =?utf-8?B?OG9GWm8rUk54MDVoQWg3MUhUQkl0d0lDbm52UHdCaEM2L0x3R1lGVE1pMWdY?=
 =?utf-8?B?MjJrT1hRVW1WcmVpd3pzdjhmTHh2RlRERENrWjJidzNGbjNKYXpFQUNTZ1Vv?=
 =?utf-8?B?S2ZVSmFzY1JQQmtSNFZFSlB4UElBWjV4UEZMVExVUGtzb2dnZlhEK0M3RWIr?=
 =?utf-8?B?RnA3ZTJrb0tDQlhHUTNBV0hkWFl5OFB3UGdEaDlnVFRUZWVNcVVQUXZlb3Ny?=
 =?utf-8?B?QjhoZ3hSb1lrNHVOUERwVDhWb2hZRnhxZDZEcEtuYUlwSkxuZE02eGFPNi9a?=
 =?utf-8?B?eTFvcE5kUmNGZzd1ZGdGMVlQeS9oZi9hR0RrQUF4dmlDa2RNMTkrNmFqdDZX?=
 =?utf-8?B?MTltWDA3cE12MUdNbXQzQmtNbmxQL1BGaFQwM0pEVG9uS1U5ZzgwOWJvSzN4?=
 =?utf-8?B?R1lkbmxiRkZrNXR6UlNLa1ZRUnRxblJaV2ZBdElxM1hkRHVsZnpoZDZ4M2Nu?=
 =?utf-8?B?MFJ2VllBUU4vcEpnN2paMkh2VTg2V1VOOXYxQ29taWdsZ1hiTGlTQ0ZVS1hV?=
 =?utf-8?B?V1FCVlIvZDZtdUo4TGV5dHFJZGo4UERjMytEMkMrYVFWLzZPUlJ4N0txeHl2?=
 =?utf-8?B?VmxUTExRTUlaMjBjaGE5NU04d1NsZk9MY3FjNncrcWhodVExRVNkYkU3WVVX?=
 =?utf-8?B?MkNqTkZkZklmeGM4SmhrR1VUV1p5dnJpNDdsZDRUMi8xU1dFYUxiblc2eEpT?=
 =?utf-8?B?MFNQYUU3bnZYN3FaVHBYcm9LNmc4RU5RcnZGUnQxV1ZXK0dxbTRtdG5PamZy?=
 =?utf-8?B?dUhFNzB4SHJ5R2tOSE0yMVVPTFJiSGpuTGNxMExHendnU3lMRGZXenlCanhG?=
 =?utf-8?B?bmFyblYwc3hLcUlFbk9nRzJJdnVuVWx5dHUzOFo4RzIweWhXM3ViS2FRL0hy?=
 =?utf-8?B?N3V3Z3FoZW1LVFVkRVAwNlZUSWUwSjFCK0ZVRGRaNlJJc1d2U0RXT09CNnA3?=
 =?utf-8?Q?XnXJtMiPWYlEndC6kF7lXpecD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a4d3a3-96af-4b8e-9542-08db61e52e81
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:41:56.0589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKTy3EwOBanFOLnUDmAPZUm6xXhYGtrtZoaEahOPuh7BW/Jh9bHn6QlYWkhE3A5061JZa7VcVqHkG0w7ypff1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/30/23 23:52, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:45: warning: Cannot understand  * @DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
>  on line 45 - I thought it was a doc line
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
> index eb08ccc38e79..a18b9c0c5709 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
> @@ -42,8 +42,8 @@
>  	hubbub2->shifts->field_name, hubbub2->masks->field_name
>  
>  /**
> - * @DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
> - * DCN32
> + * DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
> + *                            DCN32

I think the length limit was increased to 120 characters, so you could put it in the same line itself. But with or without it fixed, the patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

>   */
>  #define DCN32_CRB_SEGMENT_SIZE_KB 64
>  
