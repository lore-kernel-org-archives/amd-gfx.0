Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 23:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F006052B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 23:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11F006052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962716EC91;
	Mon,  1 Nov 2021 23:36:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C5D6EC91
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 23:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5jYSs390kDe4cHi5P3W1rpWOgHYUQL9HEPbmj24DY63SdLmvaW0Vy+uydt3Vqu+XvgdaG/MyROm7UI3UxD7g/kCZ8TINhfGQRZcpUyWJj7VNce2WVqfAnCGDTc8a3RNcHTSjIr4H2g0aqS+HIBCTSP0NDZ+rDS7XtWFBRUIY49al4EtARsCDt9MSkK+4aCkoMjEShL/MuIXARVGOtngU9zvlAr1TGn2sxifRodN4XKXFuuKmo7wb6/NMwIKq90mATM4hSYgOUJPC0i4GigV3urMX3tRUcWEV4zgOPHZSG3N3v64f00FqiT6KSi5w40D5yA8GlFscrdZuBlLCA/bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+t8jY6sCjbHABhRAdjakvl6FZfgsem1Ck3PzcMXr84=;
 b=RiHixaiVcBX9MdmPbWYEWkchdJbaMosQPFdd22sp13qdzswsuH59MruUO6vSBmttbHu8q3igOAS6Gm80XHHiYEMHonnR1cfAMRCQdgoAIBUrxor7o8sQITpnV0em28sAGv+23+ofTUL9u+Ww1HUBzslUuh1h/UFlvwBEbAkBvGHfvyAS93aUkmTopZhbfkBawHNBqeu3K6vv7YAE0S81upZl3L59lIs1+mEM8pdaZaVnlcdcj4gvvmuChNJE9GyyXO+ngOFGWlxr0NVxHl5B+C0+C81u0kYiYRtS5jSiIVsLR+TZ0cRbXtzHE9KROqwQxIgu9rnRreWMmmEWoc+gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+t8jY6sCjbHABhRAdjakvl6FZfgsem1Ck3PzcMXr84=;
 b=H75wYY4g30a05+iTENffc7FtddSHyVYvIXtX0tpLlTnlb5jEj70Eh65nDUIbbbwqq9TMK9Hxy7X6Cuhc2Yiqgg6a/C4ewc3BcWg8f6Sf5ETqpVJnpPeiBHWVDa3clDpkQLp9duh8aee2bVEUnIN7583CmsSaITQlXsyGeGcfexE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 1 Nov
 2021 23:36:04 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 23:36:04 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Add sysfs bitfields and enums to uAPI
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20210913212320.2470858-1-Felix.Kuehling@amd.com>
Message-ID: <84c21637-6e5d-37ab-0fcf-23ed489154ef@amd.com>
Date: Mon, 1 Nov 2021 19:36:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913212320.2470858-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 23:36:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81edb24f-6362-4cd5-bb0a-08d99d905e99
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29394D912EB7F388DDF8C4D0928A9@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NFsduPNBLcxbNR70qbuAznHYCD212S5W0B/DCdnQst2wLtvlmztTJc2pc0LvwPQra2FEjg4BW+tTI0pLkbhohKut1FUpdPJO9IKe70VsVdtOcdLbC9I5sPVEaQrribWtMMpM4cn8dfYrPLph7cEnCycUpYcJSUop4fgw9HlXkf2BEuHeZ7dSJiccV5LPDZRhW20veuxnZ6VpM7z1MudAy+tr1zOG4Rs6WhGTHf/gpA69vztCGMypG0G7hXBu98kTLYL5tB598Mm9EcSp1Ptg/yrGeITwx6P/BKPkuZMteFSOCk9E4cYBvS7JIV30JdVM6Cn1M/gHJv96Wr7mA9K2ew4FrI/umVABTKL9vDp7byVgp4/zfdDKTszBgvEhiLTJZbnrwH2m6G3/9qKeREdSg7gfMJT2Jcjy9hd9PcAB07J9H8zpLQ+7uzsxXQixncsOxKDwYK2/MkFGT0nHpKW+1vWjTpm81dvbAxYNxxDg7NjQayE54XKx9KN/dRUbNzHy69L9MnzxGiuRX0HxTexHREC2fGNzPisN/2nT4ZxCH1zg6AOOAZ8+YF2lT+gTpC51PbSylPwqSl46m+Zf8c4Tlo3ZWBja6wHFl5DRy5JDPoqSNlCAv1xt4I4og+QM+IWzuNCr6B4ccyg7tXZcJbr69iPUy+j41W9aI/0KJO1TQCSOPFs29uDK3wbcsqJbIGllWZR/QthJ/VudsIUu2vsitI5q7B22HmbFuhRrCqBzSfoRTftfMoKQgQYHJppFGVo3Br4jruZYsgUm1q7EZ7yJqTNrG2bjzYwCi917PAijzEUTv4PXdmxdEhEm3Z6fAbRAqiHHLyPQlaFLn/Lu8fVRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(956004)(186003)(86362001)(83380400001)(2906002)(31696002)(44832011)(36756003)(5660300002)(508600001)(6916009)(2616005)(38100700002)(966005)(31686004)(26005)(8936002)(66556008)(66476007)(8676002)(66946007)(16576012)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdldENTSGMyQ1ZFQnFuNXdnQXZQbmFWejk2S0NqTE1DV0w0em8zajJUR1hS?=
 =?utf-8?B?T1JUbWNnQ3FTT0lDOVpCT3psZDNEYmFZL0pqNEpqaWQ5ZllTRWloWnNWUGRy?=
 =?utf-8?B?dndNdGNXY3E2M0FxZlJVZSsyMnlidnJDa2xKcStrcGdoYkRnVFhJWVcxZW02?=
 =?utf-8?B?bCtyRy9raGt2bEZqRi9qaDNHbWJkOUhNSTlpUVkreS9LSGQrRnptSnpzejQy?=
 =?utf-8?B?YkpiNTBMMGo0SW9LbzFLUGp3REU5MWtKWFlIT1A5NGhDOXQ0bkVXMEg1dk85?=
 =?utf-8?B?MVk3djBPeEhjRitLSmI4WnlZRFAxdTBaeXBJanZIUitZTjAvVE02VkJKVlVp?=
 =?utf-8?B?YXlUaFBrdlZMRzM5OWlTN3NnQ0Rnc1RLY1dBSW8vWXo5a2pPODNWdWtYUlJi?=
 =?utf-8?B?Y2NRV3NrV2RpY041Qkp1QUk4NVdpSFVWWXE0Y0w1dVRTTTcvcitRSExCZDRi?=
 =?utf-8?B?TVpKTmlPR0gzcVM1RmEzaU5wTC8yOEpJQlUzVUMxS2FaM0RrSmRUYWRuaDdn?=
 =?utf-8?B?TmZRTlo0L1NPak15TTlqZk1UK241Z2ZUK09QS2Fndk16Szc1a1J5cFMxR1FD?=
 =?utf-8?B?RVpYenNDSWE1b1dQdlBVbm5RenJzdTg0bU10OVVJUjU4cjBIZTlwTS9ONU1D?=
 =?utf-8?B?TWRORXBKSzFFNGZnL1M4SXVwWDhHVTBuaUwrMjRRd0E5V1NRWmRxaG9qUGly?=
 =?utf-8?B?MGl3ME8ycVA2cVY0TTFtbG93Ky9mMW80QmE3SWtDb1B3NEgweGhaTml1VXRK?=
 =?utf-8?B?bmViUlNNcWMyNWsvYWZoeEJNbDFJSUtqUjhLZjNPczNlWVRwQVE5T05Wbk9y?=
 =?utf-8?B?S2JIdmNKdVN3cDBzL1ladFFQY0NjM3hsRWE0OW12Z2RkM1dHbVpDdGsyQ1Iw?=
 =?utf-8?B?TFhoQ3MwL1FtK3d4QlpDMTZFU25ab1ZJcU42NG1jTTZwUkl2TWV3WjRaeWZl?=
 =?utf-8?B?N2EwYytwbksrRGVST2xMc2FRbHU5dG9FNGJqQmR6MG1OZEJqWk9PNitNdWxV?=
 =?utf-8?B?TnB0TTBqcFRmSnlhM2ZVdjEzZTE2a1ZlQmVNNTIvalR1WjN6MjZIUVBuWkR3?=
 =?utf-8?B?N1A5aGMwSi9MMHltbDAzVnBFRnNNTjR3WjlLWGZjVVpiMTlGZUlQSENBMkZz?=
 =?utf-8?B?ckp0eEJXaHE3MzRSRjRheC9LL2ZRbWpLUGdSYjFaTHI3U3Awc0dmRnV1S3N1?=
 =?utf-8?B?SDBSckF1aThDcWZQaHlhdXRkMjN6TGl2dVRNc3ZpSGI2cXNUak4wQmkxTUhu?=
 =?utf-8?B?NEZ4aGd2eWlxUTRWU1NQVnFyeVJSUjFhSy9TSm9ZVE9PbFNtcmpOUmc3ZUVj?=
 =?utf-8?B?V1pwR0srL3RUVVJQQ3ZPNE9nTjlodnl6RU0wK0xqZHB4Z1hYN0pTdXpGands?=
 =?utf-8?B?dzlVbmYycHIrYmxjSmQ2NnJDZEVnYy9DUE02R2Q5ekRnSG9Cczdmd3VlRUlk?=
 =?utf-8?B?ck5xSXJ1YXppbTYxd0NZbFNyYzBMaEF4ZEViUHNwZ2xWTUFSVlpvdXpha2py?=
 =?utf-8?B?UzR1bG5vUkZnTHhKZ2FkWjl0U2c5djByek5JK3dSY3hFdGVKRmVtRWR0TXI4?=
 =?utf-8?B?VmdzMFdjVjhHQWx0S1JsRmVRc21Wa1B5dmo5NVNnSWdhNjFvdXRETFhUSVVX?=
 =?utf-8?B?ajdGcDdTaWNxazhpdGVHVk5RbzdINlJTRU9kaTV6QmNRYmdUM1ltcVBDYTlJ?=
 =?utf-8?B?bDRLY3NJeGJBL21FM3ljazJlMGRINzlzVWcrZVlZdDl4bC9GbVpoZCtacEtX?=
 =?utf-8?B?SWFXTncveDhwMzE5UXZBY29WaTZ2aHBQdGZRRjZRc3MxdmU5YU1lcWJWb0Iv?=
 =?utf-8?B?VXFOMWNNSVJhdWErWWhwQUlVY2dmdVFvQXRRRURnWGtEM1A1Qk1QY2owdlJX?=
 =?utf-8?B?a3lIeWdSMytoN3hIVDhZcXpVaUZDNDF4Q3E3YjFJVFc4NnhFeGRXR3JablFt?=
 =?utf-8?B?STE4Z0lmYW01QzFucjA2ZVR6U2I2YmZSOG9GckR6dDcwZFVuOUVLYjVya2JU?=
 =?utf-8?B?eS9BRGhZWEszUktOVzBnS2pVVzJWNFFZcEVkUGNHNnlpT09JRUkyQUVNTTRX?=
 =?utf-8?B?bWdzVlZYOG5NSExWZFVseUdjZDVJM1d5emsvUnAzME1CZlBoZ3NGMlVaeDZr?=
 =?utf-8?B?SWhqVDlFdGgwNk9MMU5IKzJ5bkRVZTI2Y2hyRmR6dW8vbThod1hTdUwxYzlZ?=
 =?utf-8?Q?HjbZgHjHYnmShpuhY0xDWu4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81edb24f-6362-4cd5-bb0a-08d99d905e99
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 23:36:03.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+1PfownJWa2ef3s30sgv3md0PoRziXEGCH9hpX1VQp+V64dSvJXvVqbdj+EYXHYCNlvrVvtBTJfLDaEfPp5xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
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

Ping.

Am 2021-09-13 um 5:23 p.m. schrieb Felix Kuehling:
> These bits are de-facto part of the uAPI, so declare them in a uAPI header.
>
> The corresponding bit-fields and enums in user mode are defined in
> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/blob/master/include/hsakmttypes.h
>
> HSA_CAP_...           -> HSA_CAPABILITY
> HSA_MEM_HEAP_TYPE_... -> HSA_HEAPTYPE
> HSA_MEM_FLAGS_...     -> HSA_MEMORYPROPERTY
> HSA_CACHE_TYPE_...    -> HsaCacheType
> HSA_IOLINK_TYPE_...   -> HSA_IOLINKTYPE
> HSA_IOLINK_FLAGS_...  -> HSA_LINKPROPERTY
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  MAINTAINERS                               |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  46 +--------
>  include/uapi/linux/kfd_sysfs.h            | 108 ++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 45 deletions(-)
>  create mode 100644 include/uapi/linux/kfd_sysfs.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84cd16694640..7554ec928ee2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -930,6 +930,7 @@ F:	drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>  F:	drivers/gpu/drm/amd/include/v9_structs.h
>  F:	drivers/gpu/drm/amd/include/vi_structs.h
>  F:	include/uapi/linux/kfd_ioctl.h
> +F:	include/uapi/linux/kfd_sysfs.h
>  
>  AMD SPI DRIVER
>  M:	Sanjay R Mehta <sanju.mehta@amd.com>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index a8db017c9b8e..f0cc59d2fd5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -25,38 +25,11 @@
>  
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/kfd_sysfs.h>
>  #include "kfd_crat.h"
>  
>  #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
>  
> -#define HSA_CAP_HOT_PLUGGABLE			0x00000001
> -#define HSA_CAP_ATS_PRESENT			0x00000002
> -#define HSA_CAP_SHARED_WITH_GRAPHICS		0x00000004
> -#define HSA_CAP_QUEUE_SIZE_POW2			0x00000008
> -#define HSA_CAP_QUEUE_SIZE_32BIT		0x00000010
> -#define HSA_CAP_QUEUE_IDLE_EVENT		0x00000020
> -#define HSA_CAP_VA_LIMIT			0x00000040
> -#define HSA_CAP_WATCH_POINTS_SUPPORTED		0x00000080
> -#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK	0x00000f00
> -#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
> -#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
> -#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
> -
> -#define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
> -#define HSA_CAP_DOORBELL_TYPE_1_0		0x1
> -#define HSA_CAP_DOORBELL_TYPE_2_0		0x2
> -#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
> -
> -#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000 /* Old buggy user mode depends on this being 0 */
> -#define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
> -#define HSA_CAP_RASEVENTNOTIFY			0x00200000
> -#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
> -#define HSA_CAP_ASIC_REVISION_SHIFT		22
> -#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
> -#define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
> -#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
> -#define HSA_CAP_RESERVED			0xe00f8000
> -
>  struct kfd_node_properties {
>  	uint64_t hive_id;
>  	uint32_t cpu_cores_count;
> @@ -93,17 +66,6 @@ struct kfd_node_properties {
>  	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
>  };
>  
> -#define HSA_MEM_HEAP_TYPE_SYSTEM	0
> -#define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
> -#define HSA_MEM_HEAP_TYPE_FB_PRIVATE	2
> -#define HSA_MEM_HEAP_TYPE_GPU_GDS	3
> -#define HSA_MEM_HEAP_TYPE_GPU_LDS	4
> -#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH	5
> -
> -#define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
> -#define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
> -#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
> -
>  struct kfd_mem_properties {
>  	struct list_head	list;
>  	uint32_t		heap_type;
> @@ -116,12 +78,6 @@ struct kfd_mem_properties {
>  	struct attribute	attr;
>  };
>  
> -#define HSA_CACHE_TYPE_DATA		0x00000001
> -#define HSA_CACHE_TYPE_INSTRUCTION	0x00000002
> -#define HSA_CACHE_TYPE_CPU		0x00000004
> -#define HSA_CACHE_TYPE_HSACU		0x00000008
> -#define HSA_CACHE_TYPE_RESERVED		0xfffffff0
> -
>  struct kfd_cache_properties {
>  	struct list_head	list;
>  	uint32_t		processor_id_low;
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
> new file mode 100644
> index 000000000000..e1fb78b4bf09
> --- /dev/null
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef KFD_SYSFS_H_INCLUDED
> +#define KFD_SYSFS_H_INCLUDED
> +
> +/* Capability bits in node properties */
> +#define HSA_CAP_HOT_PLUGGABLE			0x00000001
> +#define HSA_CAP_ATS_PRESENT			0x00000002
> +#define HSA_CAP_SHARED_WITH_GRAPHICS		0x00000004
> +#define HSA_CAP_QUEUE_SIZE_POW2			0x00000008
> +#define HSA_CAP_QUEUE_SIZE_32BIT		0x00000010
> +#define HSA_CAP_QUEUE_IDLE_EVENT		0x00000020
> +#define HSA_CAP_VA_LIMIT			0x00000040
> +#define HSA_CAP_WATCH_POINTS_SUPPORTED		0x00000080
> +#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK	0x00000f00
> +#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
> +#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
> +#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
> +
> +#define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
> +#define HSA_CAP_DOORBELL_TYPE_1_0		0x1
> +#define HSA_CAP_DOORBELL_TYPE_2_0		0x2
> +#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
> +
> +/* Old buggy user mode depends on this being 0 */
> +#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000
> +
> +#define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
> +#define HSA_CAP_RASEVENTNOTIFY			0x00200000
> +#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
> +#define HSA_CAP_ASIC_REVISION_SHIFT		22
> +#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
> +#define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
> +#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
> +#define HSA_CAP_RESERVED			0xe00f8000
> +
> +/* Heap types in memory properties */
> +#define HSA_MEM_HEAP_TYPE_SYSTEM	0
> +#define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
> +#define HSA_MEM_HEAP_TYPE_FB_PRIVATE	2
> +#define HSA_MEM_HEAP_TYPE_GPU_GDS	3
> +#define HSA_MEM_HEAP_TYPE_GPU_LDS	4
> +#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH	5
> +
> +/* Flag bits in memory properties */
> +#define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
> +#define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
> +#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
> +
> +/* Cache types in cache properties */
> +#define HSA_CACHE_TYPE_DATA		0x00000001
> +#define HSA_CACHE_TYPE_INSTRUCTION	0x00000002
> +#define HSA_CACHE_TYPE_CPU		0x00000004
> +#define HSA_CACHE_TYPE_HSACU		0x00000008
> +#define HSA_CACHE_TYPE_RESERVED		0xfffffff0
> +
> +/* Link types in IO link properties (matches CRAT link types) */
> +#define HSA_IOLINK_TYPE_UNDEFINED	0
> +#define HSA_IOLINK_TYPE_HYPERTRANSPORT	1
> +#define HSA_IOLINK_TYPE_PCIEXPRESS	2
> +#define HSA_IOLINK_TYPE_AMBA		3
> +#define HSA_IOLINK_TYPE_MIPI		4
> +#define HSA_IOLINK_TYPE_QPI_1_1	5
> +#define HSA_IOLINK_TYPE_RESERVED1	6
> +#define HSA_IOLINK_TYPE_RESERVED2	7
> +#define HSA_IOLINK_TYPE_RAPID_IO	8
> +#define HSA_IOLINK_TYPE_INFINIBAND	9
> +#define HSA_IOLINK_TYPE_RESERVED3	10
> +#define HSA_IOLINK_TYPE_XGMI		11
> +#define HSA_IOLINK_TYPE_XGOP		12
> +#define HSA_IOLINK_TYPE_GZ		13
> +#define HSA_IOLINK_TYPE_ETHERNET_RDMA	14
> +#define HSA_IOLINK_TYPE_RDMA_OTHER	15
> +#define HSA_IOLINK_TYPE_OTHER		16
> +
> +/* Flag bits in IO link properties (matches CRAT flags, excluding the
> + * bi-directional flag, which is not offially part of the CRAT spec, and
> + * only used internally in KFD)
> + */
> +#define HSA_IOLINK_FLAGS_ENABLED		(1 << 0)
> +#define HSA_IOLINK_FLAGS_NON_COHERENT		(1 << 1)
> +#define HSA_IOLINK_FLAGS_NO_ATOMICS_32_BIT	(1 << 2)
> +#define HSA_IOLINK_FLAGS_NO_ATOMICS_64_BIT	(1 << 3)
> +#define HSA_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA	(1 << 4)
> +#define HSA_IOLINK_FLAGS_RESERVED		0xffffffe0
> +
> +#endif
