Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76583C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 22:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFF410E09C;
	Thu, 24 Nov 2022 22:04:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0590210E09C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 22:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX1ltO3eUG+LUbHzF2LPwdXaBoqEcEAfG/9+PQTrkUi8cm4i3EcoWMw8VP+eJUHicKuSRG2aw8bxfXp3PtMrrDl/KyWnDJuP3wtPKLM3Yf2qHDPFxhP5wkTH2p22NOLRzAL8gIg3q1wmLJAVgJeX4Dc7FeS3qFO5MnVJw54l28my2/OyfDEwjqSh9AZDo5jcxKGYG5SdDW/OxkafpGGNTAVfSaJWpfTVO1i7t1vTtPSM7mMHJAe6bpG5ZICIEMpfzV8/G2YJyzFSRUJ3lYhW0ZfmVsxAgNTVV9Iazn6wA18cHEzO+jKdp73SiD/bi90bYxIF2apeJkkz9nMJ//i8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eJpMdghwoqFo7FTtuPUgqUzeq4N9kPLGQY1Yo3+lE0=;
 b=mqP4HKOKQKPuSR2HM/+5lsReRb6DUssWuLhMT1/EHXUoItuGnhXewpRoVetLfd2rGkV6Nba4DLJZuipRdxYPe/STyZ25S1UpTNf+0DdzgBtRKd+1aolxdsllniYZ2ft1a7Q3292rKVL+9P0Fc+HYwsOs+tg4jqaWXaKfHUl5G7Y08EZEhsGp8ETsdn4dYgqLdo9b++QJsFggmQ2CN0L9xABdO/ggsE0TOJJ2iEttx/goNBCO9x62iYThdNST5Hy9jsg+bS7sLBt83Q/QlC7dITiPHCgXXMgvYHaFSgd1YjYfYt0Ulv872anyHMMzoAdRMwY+MtGek++oPe4VwuDfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eJpMdghwoqFo7FTtuPUgqUzeq4N9kPLGQY1Yo3+lE0=;
 b=2fFOI0zs6AhSPnB61BC2eDex8jUiFTlxgfdcUrMdvH1qVNkfJT0StoCpml5IFXy0wvAq0R2DQQ7wjV5bqdAbitYwOWK9biBWmTeKdVCW77z+oJyuMvkXKeS0beLBuo/j2r8+T9dEzbtDLwdrW1rry7irkTHylC3gE4do42No/Ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 22:04:09 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::5eeb:3e6f:7509:b20b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::5eeb:3e6f:7509:b20b%12]) with mapi id 15.20.5857.019; Thu, 24 Nov
 2022 22:04:07 +0000
Content-Type: multipart/alternative;
 boundary="------------H3f89ISPCK2B66sMRHRS7aX7"
Message-ID: <f3a3c6e9-1664-459a-d615-78d22b9799c9@amd.com>
Date: Thu, 24 Nov 2022 17:04:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20221124211956.264282-1-luben.tuikov@amd.com>
X-ClientProxiedBy: BL1PR13CA0415.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::30) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a67a582-ff5c-4415-b0ca-08dace67ceeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaFxxKri/PZVCS9fZzBItqBslTuGhivJMcXwx5NFp91QjUt5dH0dzEmMnHgT0O4YwfLyOWQW5SlbuLIJBgAgOQM0hu5Qs8y8rUhsemoUuMP3vv58ywXSp5ZLq+kP40CB1ESolLc7u0K2TNlFnYP/Q95atMkKEeRgiinwR8tH3ZiZX/yEapFyzAKnxyZhd+VHkHCJUKgFpdbTG13dDwNeGKlC6Y2Rjd0wNW8P8QfXgnZk9Lg654eV0CNvcxNJEKav6qCmmhbMqb05Ehb93akt9mtuEh2kQO7Y0siSnMZQlkOy+i1fj81b26huxoSV8FCTF+m+DH67yoUYMm25zok7I8CYYPvmLug0f6Opl6lF8HdJMPwPMUVesmkDn9/7JhHXydo+c3yPHoj/0nIgNIWHNmtwG7fTcSOM1E45wX1cvHtZr3d0naeMCiuv88iYBSh8v1/HZptvUierGfXW7KgszpAaPSv0Wh2F3cUaermA7tu1jBOSomPrxQ3YYf7Rf9YoR97gJ7M34Jb57B5ErB6oecgQHkbpgyqlxdQgrcM+nhtuHHP7BGQIivU6zQmzpnLhopHP9B6Hfh32sFHkcZFb0QBABwrlhzXeXnYMdhXvFicnOTE+C7E9QFjFkHrl1OnL9lou5eTdBWXGqsmisFQPylWiFLlRF7Td1sx6DnHKvG7UTYoU51FWL3o4siMH+0Gh9cj0x5OPpErw5rWXJCzePgkMMc/mymOeuI2M0rsWFZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(36756003)(31696002)(36916002)(6486002)(54906003)(110136005)(33964004)(6506007)(26005)(6512007)(53546011)(478600001)(66476007)(5660300002)(8936002)(4326008)(66946007)(4001150100001)(41300700001)(316002)(8676002)(66556008)(2906002)(38100700002)(2616005)(186003)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpEb2Jlc1MwV1FneTZ0MjRIS2FvYmFSSU5NRWZ2VFZUbFV1OTdVVkF3QllP?=
 =?utf-8?B?bkg3a01mN0x1WmY3Uzg3UEdySkRlNlJkM3VJbXBDMXFPRW9QRGFsb2lBYTBr?=
 =?utf-8?B?TmtqK0ZHV0t5RzhLd3d6NkdUQ2NUa2p3Wmp2RkI4ZGhPL1o5YUN1RWVCNnRy?=
 =?utf-8?B?TlI5a0xaYmdDZ1JNaTVvZWhXWm51ZWRqK29YODhwYmxSOXo4TTdpaHJUN01l?=
 =?utf-8?B?Y0s2Z0tkTGdPM2JzWkhIdmJjVVQ3T2JEQk02ZTBjbUpHaVlCdlNWWDVqRW53?=
 =?utf-8?B?akhaZWY3TGpUTWFEZjV6Ky9hMllUOS9kTGZUN1NYVUFOWmFXZlRBUWRIU21U?=
 =?utf-8?B?T3BiY0hvc2RtVkJvS0Vhb2pXQzdReFdUZGdLMmZKY0tVM2s0andJcVFBcVZN?=
 =?utf-8?B?TmttRmVxNmxUS3dQQnlSdzhzZ3NSQWVjV3ZnWFhwTnREdDNRem9URnJSMjBY?=
 =?utf-8?B?R3hlNlhhcUk5WEI5clFOK2NROEE3MDN3NWNPYnhDcFlKVHFoSTdYOHNPWnZ4?=
 =?utf-8?B?SUlxa0E0c0VEbXJVeVZRVEdHMTlhTE9RN2RpejhFZVFnMmZ3K2lSamZxWUg5?=
 =?utf-8?B?Mk4yY1BCbTZxalMzcGFBRXlVK0Z3Mys4RTRab0owZ0RGL0NOczJ4WlljamJ6?=
 =?utf-8?B?Wk1ISnVRUzJUNk5MWmhGSmFuTXl1eFRpWHVmdDB0MjJDTU50U29NbGlobm5U?=
 =?utf-8?B?dGV5Z3A1YXpVVzJKdisvS2RvV1hOc1I0L0JSQ2dPU3pPODZjR09xV2x2RkNP?=
 =?utf-8?B?aElrVWM3aHJUMjVTM2xnU0czNDUxWHp0WVhiQ0dTRkNMN25JSXltcDV4OWFQ?=
 =?utf-8?B?WW5QZXZGdW0xdGNaZVoreTViNWFnRTlPd1hwN0UrQW54d1YwcUpsNDhjblRz?=
 =?utf-8?B?MDNLcG5YNGxlK0ZwazdQcWFTUUtuTW1YUTRERVVHYnpBc3NJTUxDRG5NYllN?=
 =?utf-8?B?WGQ5UllMdHVSRjNUYi9OemFQTjdzYTNHSnNjVytsd25yWUdqOEo5WTkyQ1VR?=
 =?utf-8?B?UVBqUVZ4U3RRelpiamdhUHNLaVdaVUhHcUJtZjZLSW5OTGZ5aVpHdzFRQzJI?=
 =?utf-8?B?bVk3NVVuYWp0T0hLZWlJOWdIbS95NHFaV0k1d2VNbitFTk1oQmxRR1Y0blU2?=
 =?utf-8?B?Uk1vb2hITTQ3MjZSWjZVa1J1Y1RpbGRyelp0dDlqZmpUbnczS3ViL3d1WElX?=
 =?utf-8?B?c3l6NlhUSlRYMWVzL0hxUHBIcEQwRzI0L2pCNVB2SVA0YlNONXRTNUs4Zm9R?=
 =?utf-8?B?dkhKcXV6enBGelh0SGxkVzBNaHFvZ05ZSHZkU2luSkE3SU84bFUyVXFiRWNm?=
 =?utf-8?B?eFdwNnMzbEJFbUczeEozelNsUmpyakhLNk9OMzFFSlI5QkJzTWZ4K04rRFBk?=
 =?utf-8?B?ZlgzVjNpN3U4WGJDeWdjVWZoOU1sSWlaclJGY3VubEZsLzJDOURvT0w5UUR5?=
 =?utf-8?B?UXJ1c1JRUWxlVHBDS3BubWdleFVZYnpHaHZHSExpZzNQRFJNWEZ0STJGYk5s?=
 =?utf-8?B?akUvTGxoZlRobTM2YituS1gvOVdCNEsweXNsSklRTFlZMi8wZVk2R0VicWsw?=
 =?utf-8?B?TXJMaXVsU3hMRUxOUC9rVmVtL1VRVUJSdGlSR0dLdzArSjdVbU5UV0p6bm1R?=
 =?utf-8?B?YlIrekRPdERXOGkwZnlwTFh6ZzlqeFljRWFPelVKTEkwUFNFcjgrYjVKaFd2?=
 =?utf-8?B?enFOOVJ4dVFaWU9OKzg3QVhaTUJiUFFOWjZLMkpTVnNHekFUU1FBTnZXQTIv?=
 =?utf-8?B?K3RaUkZNSDNkNmk0YXQ2UHNHOWRFc0tJbFRmUTUxY3Q0Z3VRV0JkNTVjVDZT?=
 =?utf-8?B?alpwZW1RakdYWXd1anRSRFhWNEVIOTJGTUhLWmkyVEl4NkRhNEkwYTN1UFVa?=
 =?utf-8?B?L2FrcDNpeTl1WnFSTkIxd1dZdFM1V2JzNlZsdkszM2FVMnZRRTdqUk5XT1V3?=
 =?utf-8?B?Vi9teHA5cUloRnFsWFZhVGFhaElYM0FtVnczYi9xVGJicnladHRiaGNxL1pv?=
 =?utf-8?B?bkdNTWFJTGtkWHNyRmRxOUtaNDhDTFdoNGxjUno1WGkwY0h6Z3hmSmdLV3Nu?=
 =?utf-8?B?cmZkL2l1TUxHSm4vNTBJcSsvVWtjL0doUUhqc05XSkFqek1JSmgvMllqb1Y0?=
 =?utf-8?Q?BW3n+YCJifYRNI0dEBv8OkEb4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a67a582-ff5c-4415-b0ca-08dace67ceeb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 22:04:07.6571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHiznnsa83t7PqSpx7/CutCykYq6COSjmiUXUQV+gRhI3sLArhJ6pSwY19KkF2oO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------H3f89ISPCK2B66sMRHRS7aX7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2022-11-24 16:19, Luben Tuikov wrote:
> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>
> Cc: James Zhu<James.Zhu@amd.com>
> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
> Signed-off-by: Luben Tuikov<luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	hmm_range->dev_private_owner = owner;
>   
>   	do {
> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
> +		hmm_range->end = min_t(typeof(hmm_range->end),
> +				       hmm_range->start + MAX_WALK_BYTE,
> +				       end);
>   
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
>   		/* Assuming 512MB takes maxmium 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
> -			HMM_RANGE_DEFAULT_TIMEOUT;
> +		timeout = max_t(typeof(timeout),
> +				(hmm_range->end - hmm_range->start) >> 29,
> +				1ULL);
> +		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>   		timeout = jiffies + msecs_to_jiffies(timeout);
>   
>   retry:
>
> base-commit: d5e8f4912061ad2e577b4909556e1364e2c2018e
> prerequisite-patch-id: 6024d0c36cae3e4a995a8fcf787b91f511a37486
--------------H3f89ISPCK2B66sMRHRS7aX7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2022-11-24 16:19, Luben Tuikov
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20221124211956.264282-1-luben.tuikov@amd.com">
      <pre class="moz-quote-pre" wrap="">Fix minmax compilation error by using min_t()/max_t(), of the assignment type.

Cc: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Fixes: 58170a7a002ad6 (&quot;drm/amdgpu: fix stall on CPU when allocate large system memory&quot;)
Signed-off-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 8a2e5716d8dba2..d22d14b0ef0c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range-&gt;dev_private_owner = owner;
 
 	do {
-		hmm_range-&gt;end = min(hmm_range-&gt;start + MAX_WALK_BYTE, end);
+		hmm_range-&gt;end = min_t(typeof(hmm_range-&gt;end),
+				       hmm_range-&gt;start + MAX_WALK_BYTE,
+				       end);
 
 		pr_debug(&quot;hmm range: start = 0x%lx, end = 0x%lx&quot;,
 			hmm_range-&gt;start, hmm_range-&gt;end);
 
 		/* Assuming 512MB takes maxmium 1 second to fault page address */
-		timeout = max((hmm_range-&gt;end - hmm_range-&gt;start) &gt;&gt; 29, 1ULL) *
-			HMM_RANGE_DEFAULT_TIMEOUT;
+		timeout = max_t(typeof(timeout),
+				(hmm_range-&gt;end - hmm_range-&gt;start) &gt;&gt; 29,
+				1ULL);
+		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
 retry:

base-commit: d5e8f4912061ad2e577b4909556e1364e2c2018e
prerequisite-patch-id: 6024d0c36cae3e4a995a8fcf787b91f511a37486
</pre>
    </blockquote>
  </body>
</html>

--------------H3f89ISPCK2B66sMRHRS7aX7--
