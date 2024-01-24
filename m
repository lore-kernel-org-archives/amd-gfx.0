Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC3EC48260
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A21110F7A4;
	Wed, 24 Jan 2024 17:15:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B2110F79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtLLCHTYVaH+Ck/klIWkmhrR4tLCl5ated05KnfyGP9PGCqjCDmZbYFiOTbCCFR67JWXaqNRpfruCCebV2Cz9giapyjQmSPyHeBMtKwVpmt2blZ9zusjWCBSkIxAtd82hoCJEhV/mzBHO267R50XQRYPRM/gK8B0v5z+s7BjfHuclbLrAPtWR+by2daAS8eGdA/hjQIp0JMF8eS/BjqL4vdjrdi//xq6VQAlCNY0SNjgHCz2ftukPrYpklHpNUySyHBXanxh4wR7pktibFVT7DxS/lrMtbh75RdmhKWnLZdUud4Yl93w/gdtv03xw2kdGWl/u4y1weOG676l35iHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgRQ0WSg39GtrGDeBvVQeMYt+/4DKG1d7XjeIJn505c=;
 b=E2PMoiYtbsErR7a0wWUeUzHjqBzl3UsJxR+45OqS3x9vMy8+9tMc+YVS7XbSZ4WzcANYXCJe6KPUS1XEliVQiDqD1IhZdzrhtsklY0Wl0ITbS/l9dlj4eFMeoT6H8tNYkpe72+sQZTQi1Va6M3M3SPi0NH4KQl0TBVPaZR1uZ/MQrc1y3tH6se1H/mmbFPv1W0vnen0cYszWv/VFMgnv8YuzdC9TYy0SvD77g79ySpfYaNifD/j6XhIxFFoBdBlqGzbiA5v4wxiZSY8RNNnCeCHZNvS75zEAM05UM63cgIPd0qDhUVgztVOajxarb3yR3Rc8KdpS5RNXr7x7Jjzq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgRQ0WSg39GtrGDeBvVQeMYt+/4DKG1d7XjeIJn505c=;
 b=nTtD7Iz7w6htSlvJBnJ8GairZPeY+kXf9MUsGRvPwrsE/oJLbY/RKean/DtryUkUpS/rQw3Rh53nek+eBjNY/WPU6f2ApM3/rOClFzoX6Nd1U9Wq4fV7ts4n2MK42SyPpNF9evbvg4wabgvgU+nQtFkucdJkUuytxWV0mH/vVIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 17:15:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.039; Wed, 24 Jan 2024
 17:15:25 +0000
Message-ID: <b2a5d889-a36a-4099-b2f4-c09d2f31b520@amd.com>
Date: Wed, 24 Jan 2024 11:15:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: Disable ips before dc interrupt
 setting
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Aurabindo.Pillai@amd.com, li.ma@amd.com
References: <20240124170906.901841-1-Roman.Li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240124170906.901841-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8955ef-e1d0-4274-b9eb-08dc1d000e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qx5kTQJYJmTOyYp0lkjJWwPU22lQ5Yi0OBXSv12R4IebG2ogrA9MQuqBQ50MEZqs94DoQ6m0Nk086b7SXqb6WMYzBFHEjbNKOKwlNXJRdM1PSMdwf5vt7vXqa1tsnrLIOjbMZqdeE2J8nsPe8BwczpUT9WS38qaPpqsmn8QezdhD7l5bU4gf1WKa0HP9A1avR4FuOoVlTBXv+Am7c8dAQbZBUUlRjx7zj/h7Q2vAZ/KuqNH4cEVUCK7F9ncwr/fjsx51jqPaAEJpad19BQQiCWfT/+ODLuwqKwsptTJsVEBGNYS22eKgKUX+NVO/rGzSqizv6eYevRKy6OAaP0v7zGXrmeWS9fOXNiw0+1OjFPO6L3qoQPY97mVkANw9bSFPc4cJQtu3CNoRxNVIhgrDSiGIUnVFqR+atRm0apaVx8KquNa5p+gwdxg65IF9wkBGLN0QJdR5hpdOA0SZUMFljnR72o2Qr0qO4YPnnhH7J064c91JQZazQ2531vclmi2BVElNbVBiQnM8mg7XfIcNZLsp6Ejpxs7ZtIFKGzeI4eS+3vmHVjn4yEI8NOcmDay+80EjWSSVZ2R8nLlhv3SMTlkyFWqm6K2P6iP/CJeDsp8jl2hpQCG1yPOTvGhq8j4anET163QHYRzIWfRnu9MDQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(478600001)(8676002)(53546011)(6512007)(41300700001)(6506007)(6666004)(36756003)(2616005)(66476007)(66946007)(5660300002)(6636002)(66556008)(316002)(4326008)(2906002)(44832011)(31696002)(38100700002)(86362001)(8936002)(83380400001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJaZHBzczAyOHc3MHBVNUw4bk1KL0ZwcXhMclBGN3luZ0NwY0NNY3FBZ2t1?=
 =?utf-8?B?L3lhZy9KNjF5clR3UllzZUxKZ0s4d3lhZUY4TU5YSGZqNU1Obk52WlNIUHJz?=
 =?utf-8?B?enJUM2V2MWlidFU5L2kybjFMNE8yWGRnQm5SSGFiRm5FUGozYzhkOVppSVpm?=
 =?utf-8?B?Zk1nVXMrQ251SHVwWWk0NFAwTVQwc1BLRHI5bGpHcGt2M0dzd0NJdTNDQUlW?=
 =?utf-8?B?akhEcFJBZUVWVWU0NytQQXo3bkZ2dG1OaGVJNmxlQWdjek9NNWd0N2JWamNN?=
 =?utf-8?B?NUZVc1ZTWHVJT2tqbUM4eVd6ZmdseXRPbC81ZnV0Smg0S1BjYURMWElpbFYr?=
 =?utf-8?B?Y2d6bWhZUnRIbDNCNmNCclc1OGlJMG1VenBwcURSaEU4SnBHY3BXSHlvK3pC?=
 =?utf-8?B?TFRHaTlEL3JQNFBjcVc2dmt0ck1raTJUTXJaYmhBVSt0VklwWUFNWGZKbzJs?=
 =?utf-8?B?SmxhaGdrK1loN1VrZ3YyYmlaUW9pV3o4VHNCdS8xaGNQTHZkRFZ3OFIvYXNm?=
 =?utf-8?B?emtmeGJyKzd4ZXpZczFYRnRPM1JIWTVJb2JKaE1Sb1pWdFdPcEpjWm82UDRF?=
 =?utf-8?B?M3plOW94bGxJZUVwT3BwRmU0S0psV1dIM1AvWUxUWEoxZDBqRDJNQVREaVhR?=
 =?utf-8?B?TVQ0aEsyRHhOdXI5TkRZQUdLekE3anVybnBvNkRpUjlTTlRRc2xudUpxZFZi?=
 =?utf-8?B?VlhrOEwzVXV5UlBod0tzUm9SeXdmNjFMWGU2MFJqYlhNdWFoODF5bkVldmhU?=
 =?utf-8?B?TUNFbFpXelUxSi9Rek4vTm05UjVPMEFMV21wbzdzVWd4VEplcWxLT3h0cnJG?=
 =?utf-8?B?cmVVNWU0VlVvSWMvbXlBWWcrS0lDVElqTzdaR0FoQVY5TjJFWFlQRUZZaDN0?=
 =?utf-8?B?MzJNYnEyVG5RNCs2ZVk5YXcwVk9vZjZDM2VHemx3cFdMMlY0R29Md0xHYkxI?=
 =?utf-8?B?UHppaFRnVXpxSlhmdFRzOUdQRnlWdWp5QmNmWVlsRFFEdjdzbXgwZjNRWXVP?=
 =?utf-8?B?djFSWEttVEx2cU9aNDVWUWdxc2tlSmJ6bGFtbDdQR2kvUlptUzdaZVQyaXFW?=
 =?utf-8?B?OWVTMDRhU050WFVWQmNZakk1bVVxUkVsZ3Q3cXExei9uVk5Bdy9ZZ1BVdnZ1?=
 =?utf-8?B?bDdISEFpZWZxSDFoWVJhV1FaS2NDeWlZRHVEdnFvNHhVdjJiSmwrcDVCUThO?=
 =?utf-8?B?ZlVIMXhPUjdKd0FhbGlqRFcrZ0xmUkRQZ0luNUk0U0NYMThlcC9yWDltbjZ2?=
 =?utf-8?B?LytLemZ1R2p3Nyt6OVlvbUVSQzA5VksrSGUyenNzUmo4L2xORmVYSEhsTFdQ?=
 =?utf-8?B?bHNxRTllWlJjRmxET1dhYlZaZkZDMWFpcUxaMXhNaFpiTVUrcU1IQlc0aEFp?=
 =?utf-8?B?eWh3dG9nVXE1NjZoVXN4RzA1MGZNeE01bGNOWlJLclZTcVR2aHgzblRtK1pY?=
 =?utf-8?B?MG16N1pJeVJSa2JhSEg4TSsvMmFXRCs0clVxQW9IK3pvL0VmT0REanIvNEp3?=
 =?utf-8?B?VTc1VE1MSzdYZ1Q5K1BLSUxQS0hSMDNibnpPY2UxSjFiUzJHRlBhWVNRTlds?=
 =?utf-8?B?bG5DdEd1YlhiNmFKOWxuTGZWN3lkZU55UGVUTHMvVGJ4RlE5ZmRwcUhkMWpX?=
 =?utf-8?B?ak5naXNNN2J4MDFUTzhvVmtJUmQwcDRCbXhDd2l6VXRDTEhiMkJpZnc0VURn?=
 =?utf-8?B?NG9XYzN4dzQwdStGOVBWK0tQczAwNGh2SCtQYkF1b2RsaGJ1QjZ2bmRBdHd6?=
 =?utf-8?B?NktGakV5UE1iVlhVakFGeHFEaGhMRjM5MFF3TGZHaVlBUWFjVFh4em82bEcw?=
 =?utf-8?B?OHlITnBIWlZRZ0N2K2ZXSnl6ZXZlUlI0N2xNNW5sSWxRdEpNLzBHL2wzaC81?=
 =?utf-8?B?dFZka1NIeXFGWVFDdjAyUVRzTkpMdW1VK2l1bWRIN0VEV281ZEVDYUQvV1hO?=
 =?utf-8?B?R25ub2JLSUJMZm1DNFBLcnpXTXRvMDFvRFJ6RE41SkFHd3VWcjBjckpacnpK?=
 =?utf-8?B?cTJFVEdoSXRmNS9CdjQ1NlJOK3A5cXMvRFdQUnJydjJIRHFGeGJCM0pSTUFU?=
 =?utf-8?B?b0RxendGMHR2bi9SSW9qbDllOGdvajArdThqMkhqNHVSQWJGem41RStnRE5Z?=
 =?utf-8?Q?/iq4GzuqGcecSuGv7klDfxFrW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8955ef-e1d0-4274-b9eb-08dc1d000e19
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:15:25.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDrpm7ve9tJ4zQZ9D+vgcvl0v0I/W9gfD5hkaqeutzh6ZJIOyzYlVcpL7GwM3Dr9pURwT+j0YRf6SfXMOcjELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/2024 11:09, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> While in IPS2 an access to dcn registers is not allowed.
> If interrupt results in dc call, we should disable IPS.
> 
> [How]
> Safeguard register access in IPS2 by disabling idle optimization
> before calling dc interrupt setting api.
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 58b880acb087..3390f0d8420a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -711,7 +711,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
>   {
>   	bool st;
>   	enum dc_irq_source irq_source;
> -
> +	struct dc *dc = adev->dm.dc;
>   	struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc_id];
>   
>   	if (!acrtc) {
> @@ -729,6 +729,9 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
>   
>   	st = (state == AMDGPU_IRQ_STATE_ENABLE);
>   
> +	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
> +		dc_allow_idle_optimizations(dc, false);
> +
>   	dc_interrupt_set(adev->dm.dc, irq_source, st);
>   	return 0;
>   }

