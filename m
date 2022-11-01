Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40891C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 19:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D3D10E074;
	Tue,  1 Nov 2022 19:17:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CB310E074
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 19:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm5sjOaSX7rfn7r/vyQc3Yh6Bj/Flv/FJGfew3E8A4JmhX/8swuy+7ZZLngAQ0qxdyUzkilDTseXgVFKSwMM6tK+JofTDfsxqDvuHmJ8p/4TifgwZooCtqDOhMfatRevztcj4V4HKmIOX751CqSXwxGaRfZrqTZ57sdPhQ2WE80ntWEUardXYuvsI1x93VtIIIS8pyOKfuBub+PgL5y/TtYK0wTqMgPdrFDMtz8hQPANXuP6/htyRGwtopvRXXmWYBRRLwDI0MdoGCm/DkFCVCBpMhzktXhqIX6NYU2tjpkDXO/LdKiLIHsQ/LJ1qgX1dxFlWbfC5/vrerTTDl2shA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVtzU9kUeNVUC5y6CT89qivckESYrNbjgB1A+ujfDlM=;
 b=eSdbFFwq+2/eHB24SGGcQRgKJnELLIk0ihikRyI+70lPedgorwUuKqFNgTKDQc4YRKu0DVon+L6JF/PWZWukYzU1CVky9fWiKBlBRheGaRQFARU3tuYD8AxhawNg7MOUne5Sh9/xD8QTN+16HQKljUF+3k6wocdRVj8ySYool42C1F+PxEO7h0SuKg/Iwh1BkQFB8ybIsTFOxEH2YOvLL2e/kEMDEPX4W5KHXQwvEkUsaCd2K7Myx5jyFFOZohSVSNtnlz0Zo5toug5mGg+UcUDq+F1Bz4wf56+2EgVc0NKbR5FNQhycOc0HFNBxKS96IZUikZJApSJx1UPnKVFjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVtzU9kUeNVUC5y6CT89qivckESYrNbjgB1A+ujfDlM=;
 b=kzitwZeCphbSllsQKvqSHe/0Sru/U7GRLxxNOCn6ZXN2Jn+kNp4COgMPaDsEyycH+/WpJyf85TwXjnqeRP4rBwA5TXR+ndWuhlxvxgFx0+cUcQkT3JhAkS8RawuhsEw7njSI1jMOFYVTbU1Yuhgz7TT5VpV5437M3RR+DxAULdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Tue, 1 Nov
 2022 19:17:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 19:17:00 +0000
Message-ID: <9a73be43-e373-cd65-51c6-19db30e2d1e8@amd.com>
Date: Tue, 1 Nov 2022 15:16:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] drm/amdgpu: extend halt_if_hws_hang to MES
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221101144621.375662-1-Graham.Sider@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221101144621.375662-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: a2286dfa-83f7-4d2c-0318-08dabc3da6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vB7gc9e++gXEgtPFDGT/Y42yhBY0k2bbNmw51J9DtIHWxyuzsh6P+8m4YtsmdEg+qWVRNooUP862WhoESoKcbjk8UErgzUuqgTZ20i18EAT6haRtjHIq6BbykmhKDYT0HTXX1u8eo5/hA/4ApBbdk0MJnT+ENXzt6bv+of2EfyhkUGF6KkU19/PmdHQui2i7GOD76Z32as9Hzu/0h288lEjPWgoPJXBCXwktY7SlBEBBCJcpCV4l5Rg10R+JRTzuT8hKmk58pzVZQHARbx+VqlUQS+Ikbd4N8/3b3u+d0Tp1VM7ycf80Q7uYMWXS3Uc1QunLl82Tm1dOzsulhcrdgd5BmTx3SuwYM8S6A+oMsedDl3HRVsbMJHk0/ePHEnVRkxQtQTEz3e6QQg4tld6B636KzmBNZUpYhQg+QoqY7p8bBQtolxJkrUeVSquslOYwyWjlRUqrWKnoTBuCI6dlnI2YIAZ8jfUPlmzGOphxJVSdV/bXVlJzOrOhXu76ccY2DRFjECm2+XlrPm5agSfDdcsQ7yYeQd0JpWwsJlYyi8kLSWLbCUFICz++YkPUO4FgidRoy5LFClfTtXuZF2UWxHaHI3IbELO8+yJ6+XtS/27M2TNbxJYJBbzf8ezhQQcrcvL2rM47u8GXD6w9/ap11A6fM1NxhJBGo9b0pcvES9EUshXkWWXz3vIIEZrNFbNjPibYNWM0F4P/HDKEWmcz+HQfICB3Dw6EuGLH+MxavQ6dh093+2GbK/aTmfzCTa+n5wVHDBOCJEUtflG61qSd2retWp+nhlcEj0V9QhtHX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(66556008)(66476007)(316002)(83380400001)(31686004)(6486002)(53546011)(36916002)(6506007)(8676002)(66946007)(478600001)(26005)(41300700001)(6512007)(44832011)(8936002)(5660300002)(2616005)(186003)(2906002)(86362001)(36756003)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpVRXFzSlZYU3hzTHBwOFpoMU42RVhpRjJXMUdTUEhpRVFaZW00bXRMVHo5?=
 =?utf-8?B?ZnY4WFh6UmwvMld5WVFibnNlQzVKdTRJZzdRc1BGK3lLZ3E2SGdoK1YyL3cz?=
 =?utf-8?B?ajR2M3JRc1E1TmdHYlUxQlVOZlNvRXBIUGpQdTYxaDFveXFRQkxnYnNsQTBu?=
 =?utf-8?B?dlFDRmZTckxLZ203QTdKOHpmNGx4WjRjY0cwNllDejljY3NHNjYzUEZldFNa?=
 =?utf-8?B?YmdRMVJ6aTFTekU0amluR242ZU5hZ0MyMTVac0dzN0U3TlR3UlhnZ096Z09j?=
 =?utf-8?B?VitlenVFaFRxdFNsZEZPQ25zK0xFbUZmTk9zeXFjdW1SOWR5aERIRnNwVllm?=
 =?utf-8?B?ekFPU09jRVYzZmplaWFYRXB5SnAwekxpd0RBczVoOGhQVjVubmVvQ1JOQThN?=
 =?utf-8?B?RnE1Sk9CU2dDYTVFK1EwMzZhbzFBenR3Qi93SWRZaEY0U2RSSVpWM0hzTGZ0?=
 =?utf-8?B?d05pU3o3MGp2amhZVGRkV01JWDNTd2o4QXRuNG9qYTJGQjdMVWN5SGVCaU5H?=
 =?utf-8?B?OTdWeEQ3K2pDNFB5Sk5tbGsvOFpxSnhrcFZvWDk4d0c5QkNSUkFzQUcwU2lk?=
 =?utf-8?B?YXFXTTFBbDRaTEgvcEs0Q0RQV2VOVG5IcjkwcmU2VWZjSnhpVUVEd2MrME1m?=
 =?utf-8?B?TFlQVFkrdDdJVjlLQ2xLMDVTdzh2RVlIVmlqNndxOHNwemU0bmJmTEo0UnZi?=
 =?utf-8?B?WDhhZ2Vxakl2VTVJREV0WnlnaExpaEkxVmM5NjlDeUxTUjJ3b1ZicXNYZXNY?=
 =?utf-8?B?QUh1a3dVRjJFV09SbXg0dXV2WW5pWWRTSTd5RnlVenVTazBpeG4ya0I5NVNI?=
 =?utf-8?B?UTRkZ3NnUjhtcFFxOUZmcmhCUEc1UVdtVXBUWjFoUWxRZWE1T2FJaFZWeXpu?=
 =?utf-8?B?NHFIUjgvdWNYZUh2ZTd3YTN5ZW9FbXVCalpxT3Flc0wzVU5Yais1RXF4VU1n?=
 =?utf-8?B?MmVQanZTaklaVzR4QjRIKzNtZldPRXhhRk1seUFNZFVCK2p2L1BZVlV2VDkz?=
 =?utf-8?B?YnEweCtEeTgwQmpHZ3NRM1RWeDU1bW85SlhNWjVmVVVsN094cnlQd3l6ak5E?=
 =?utf-8?B?UXlLRGQzaHAvS2ZPOTduWkVtUGVNYnJrY0M2K2R5N2RhZXJZZGY2Y2pGa2hl?=
 =?utf-8?B?alRETXRFdCtPTjlrQzhWRlhvNU95LzV5TWxFekIrU1lKb2NhU2JaRnlzY2ho?=
 =?utf-8?B?bDAwb1pVYzRIM2VFeW5zWFlJcHZ6MXhUN2RCdkpidzZlam9wQkZFdEJSZVlD?=
 =?utf-8?B?MEJiUlp4ZmFleTJCNmo0UzRqek5FaGcvYzhYZmRBcWZja3R6cmx3U0R4clpP?=
 =?utf-8?B?ZlAxVlY0T3pkUXRIRllFdDVJaE0wdzNqOTVrbmxOWm1GcWdqRXY5bFlicGYv?=
 =?utf-8?B?SzRtTXJMNzh4czlVUFl6Tnh4aGluRkNZWnBuMHRaU2dZS2tGVmJBcFNGZTBK?=
 =?utf-8?B?YkhtdUwvQ3lZaXQvVm1oM2xqRG5tNjJuWWUrb3UyL3c5by84WXl3N2ZoSGdy?=
 =?utf-8?B?L0dDYmFTUjlyYnlnT0Y4QVltQ1NXWno4N202S0k5eTRSaDlJNFFBN3VzSlhN?=
 =?utf-8?B?REpJL3RHNFBjdnJJUVVKUy9EMXpNYWhHMTVSQkVJMm0vcEg2LzFtcU93eURx?=
 =?utf-8?B?MEFERS93NUp0aFR3eitnVHlGM005b2Vib3Y4cUtmRDBwY3lOQ1ZEY251MkZs?=
 =?utf-8?B?Mnkwb01lazd3N1pBWHlaUk5JWkVIOHRzNHFYSmtmMTN6OGlrdnR6RDhKNkk1?=
 =?utf-8?B?b3lkckNXZjBOa3E1dkdKNnNRWHVmWG03QWx3d1pkREkwS2pqUkJ4V2RSeDZ4?=
 =?utf-8?B?bWZKQ1FoTUFXWnZPZWdQK0RaV05kdnl0d1VkdWlxVG4zTE04bDN6dGg5c3hB?=
 =?utf-8?B?L25Rd3E4bEFDNnNuOGYyc0xPbE1WbVVnYkpod2xub1F1Wk1VTDhiREE3eTF6?=
 =?utf-8?B?cU1iMzRXc1Rsdy9jVVFNS0NNanJxWC81L0tzOXRiQS9PcmszT3pBOWo0Y2FG?=
 =?utf-8?B?eHEyNkw5Y0FGM2ZvcmdWdkR6VHI3d0k5QXJPd2hieGdBQmdXQXJYUGxZRUIv?=
 =?utf-8?B?UFh6aUlDdjRBaDRadnIxaVQzOHExVmQzbVhmRGgveW9iZ3dxRlA0LzI3bTFS?=
 =?utf-8?Q?Q6moDy7V7QQmkuV2JJVVxxxrL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2286dfa-83f7-4d2c-0318-08dabc3da6c4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:17:00.4643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJwJo/e2mEtyBxLtVGL3wqmiVQ+BxDf6LvmbEBkAFWjkKB4IjAyKHKwxDlAj6hz1zDdKVCyGPj1/c5pd6A+b4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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

On 2022-11-01 10:46, Graham Sider wrote:
> Hang on MES timeout if halt_if_hws_hang is set to 1.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
>   3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e6ddf05c23c..9999c18e7d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -219,10 +219,12 @@ extern int amdgpu_use_xgmi_p2p;
>   extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
> +extern int halt_if_hws_hang;
>   #else
>   static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
>   static const bool __maybe_unused no_system_mem_limit;
> +static const int __maybe_unused halt_if_hws_hang;
>   #endif
>   #ifdef CONFIG_HSA_AMD_P2P
>   extern bool pcie_p2p;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 1abdf8b7ab50..614394118a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -121,6 +121,10 @@ static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	if (r < 1) {
>   		DRM_ERROR("MES failed to response msg=%d\n",
>   			  x_pkt->header.opcode);
> +
> +		while (halt_if_hws_hang)
> +			schedule();
> +
>   		return -ETIMEDOUT;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 27a330f51c7d..7bfe862aa83e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -129,6 +129,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	if (r < 1) {
>   		DRM_ERROR("MES failed to response msg=%d\n",
>   			  x_pkt->header.opcode);
> +
> +		while (halt_if_hws_hang)
> +			schedule();
> +
>   		return -ETIMEDOUT;
>   	}
>   
