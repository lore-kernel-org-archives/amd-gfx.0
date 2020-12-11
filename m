Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42917C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 05:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2C923E25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 05:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2C923E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678406E55C;
	Fri, 11 Dec 2020 05:10:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBF76E55C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 05:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fixizwzqLPfSeWMM1peOwbQx8AQPdVjx9vXQcpGF4aYgmgUu2CemeLt89HnYAbFD54Hr4BkBWq4ekFUx+vrVjoogOUgDYxnrFOk99cLS3y1v/2dLEYueFB9+JDohbNMwaUKIpbd8aGeQA85BajBl+OQA9Tmg1HD3qwOvNM3fKWwrU4xk0wYbp/am+9v+DNuA36MqfnCRQcHumJZScwamqBrFQGxJQ+r47iMJYGiN159YPqIqF5Vdjb3/UXQj3mRKrVy7gsYgUjKjQK82DkojikrzS0N0Z7vCfKZmEvyrOsdeN6nL7FlcCpV4dZwWZLK70y3zf9/Fch0tAJ+FmJXzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KKjV3pl/gsn+NNtvi+VH49s4gm5gNuaVFQWmW+K6z0=;
 b=a5uIhHve71lu6YA+2iYyQzSHx47x/ic0FBlKTfELXWiFB6eQ/hR9uPNkd06ScxMBRe0FCfsuCoYYXCiFLjRh52/HadqzXurzGTpKs54cSRVPXWXouSv+ALA0sSTV7NZ3AJsnYVB0vwhI19rn+3/AgPPESOa6z4Mvq5KODaAPF/LFfwT/kfoIpD0wO9R71n8de+I6djiO71uuvoGnrF+VUV9M7eWYJAsymzyUyUY+juQpL0lRrTWHzezjCx+Og4LEEYeFuH8mE9W495wKolaX9Vd/C+v+wfJtIw436te19EFf2pwtOCb8nmJHYuZNylwr8M5L8dRRKmd/rB72Dl9fOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KKjV3pl/gsn+NNtvi+VH49s4gm5gNuaVFQWmW+K6z0=;
 b=PAADBLPpt5JlOew3iQ/uUiuYGWEF0fYl9V6opCTCeq3AZkhiO2l8pWHlEdjyT57xRUtWEHZ8KJ/pWy/3sdzh/MyrVdelyRE601RhYTyNNmJNlNfeXmNeGkQW7QbCH0RIDV20ZwD/EUfwret/8CZyiCUq40aaxglw9z5gJBVS53E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Fri, 11 Dec
 2020 05:10:44 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68%7]) with mapi id 15.20.3654.017; Fri, 11 Dec 2020
 05:10:44 +0000
Subject: Re: [PATCH v2 1/3] drm/amd/display: Add module parameter for freesync
 video mode
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210184823.285415-1-aurabindo.pillai@amd.com>
 <20201210184823.285415-2-aurabindo.pillai@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <9747f447-50d5-0a70-0866-85efcd69046c@amd.com>
Date: Fri, 11 Dec 2020 10:40:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201210184823.285415-2-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MAXPR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::26) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MAXPR0101CA0064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 05:10:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc982dcf-7cf8-4f51-4f53-08d89d931d32
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB377850010F585714DF62C548F2CA0@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmlncYwLCiM0x+nabR+I0+ItSKiUuYlNYUOzb/asLDIRs80llpB5kUhvh9IEM5VCkZBYmhrLtlIq7rG7XmM0j71KZ8lpQYDtSEzQbfsa7JFXHFasOulGfMevSP8awU8/p7l3A4lJz+RnjyOQJBQPglW6RjAmAqhsFVLXUEweSl47mTTpyAhv7Wk42I51RjXZxcUK9FDQ1hThHrtSEHVp9ZYj5iP69v9btVB9C5udlFofYtZCJGYIQpHQ548JW4LF5aqHeONUZgUN2q2N2GwF9ESZ38mNOhj2dqFKxWN8re/lTPGhlKOG3NAFlBVtJVmhlbL93l908WuYbkL/a6/sXsF6TtIgWxMW9dOCLd8Rw7CffKOwauFGJwchf+IKQwRpYRqQic01UC0OJ2nxTc00jJpNT66xwZVLJpzA7njS8yfLTfPb4sxozulSDl8PvxfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(31696002)(83380400001)(16576012)(8936002)(31686004)(66476007)(66556008)(34490700003)(956004)(6666004)(44832011)(2616005)(86362001)(8676002)(508600001)(4326008)(6486002)(1006002)(5660300002)(55236004)(52116002)(16526019)(2906002)(36756003)(186003)(26005)(53546011)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clZiVHFjSWprV3o2Qlk1OWpBZXRvazRlU0xOUzJZLzRSMHdkRE9pVzl4Nm1h?=
 =?utf-8?B?TlpMdlZ5c3BCTWpsbklkUkUxNHF4WVE2NjZqRXpTMURtK0owNDdUQ3VQZFhl?=
 =?utf-8?B?SEZWblZzTjdRMTVZWDFKUzQyYjlaZHpYV2loZjVqSTVwNTFIOG5XaEFYc0Mv?=
 =?utf-8?B?QkFuV285NUQ4UVdLZGdERExqaG5SUlc3NFY1UlIva0IxK1Z2Z0RJRDRlNlpW?=
 =?utf-8?B?U3lwL251Q1F4T1ZWMmpRMFBPUkkvbSt6NGx2eGkzdHdoN09Mem54TCszcEZj?=
 =?utf-8?B?amI5ZmdlaXRIQmc0dGsxendaMTRLVEk4TWhlU2NyZDFCTThDTkgvL0dxb0lE?=
 =?utf-8?B?clpxTWlDNEZRdi82aURrKzZ4ZjhCRDNIQThYcWd6MGg3Q1hRNVZ6YmlSSFlq?=
 =?utf-8?B?ZUkxNWpPcW0wemR5b2RCbUUvbFBLbEpxaldUOElKY2IyaXBNcENGWlU3cWxp?=
 =?utf-8?B?TmVJNGR0aVBzaC8zVE5ROUxHMThuQWF6NEkxUU5ieGQ1WVI1akZ1N2hBR1lN?=
 =?utf-8?B?VW9OelJTWEZpcjUzdjkrU0JOUVQrV1ZGVTYxVXkvYXJMZk5BWnhoN0pLMStT?=
 =?utf-8?B?TWNnVWs4QXpPUmxvd21SaHZHM0ZlTlpmS2RnVWEvaWFGZ3dxQXNnZGgxUXk1?=
 =?utf-8?B?QTNMMjlYTDRoU2dOQUZsQW90aXJNemRpL3JaTC9ObFVZMGpDSkQ2NXgwVVRl?=
 =?utf-8?B?RmQ0aWF6RXlzUEMweldGQmtKL3laUVlxVUUrZ3l3dm81bW41dWVwNS81Zlp5?=
 =?utf-8?B?VWF4NEptaE94RE9xUjZnTVJNYURhTG0zZHZnQVUyTVJ1WTJWSUhuODJGTlJO?=
 =?utf-8?B?QVFpemVXanBQbG5xNGxHbWllc2Q3LzAxTGowaWVRaWhEUUg3UU80b1ZEYWJF?=
 =?utf-8?B?UkNWSlJjQ213Q2R1RWxndHdib2RWTUp6dWZRV05iTmh2MUp3TjAvd1U4aUFG?=
 =?utf-8?B?QlBDZHpBenBDWXZRSDJNY1Zza0NZOCtRL2FOaE5XWjBNWWNuS3VqK0VuRnQ3?=
 =?utf-8?B?MndtU2trOHkrc1lrT2tVTjduMi9pR0VzQ21zK3ZFclFPY3hQZGNsUFVCT1lw?=
 =?utf-8?B?OWFuVDFVdnBoa2RVbnRlaGFpYUttRDV3ZWErRkZxUU5nZDhrcnFCOGUxd25H?=
 =?utf-8?B?WEV3R09OQXZ2RHlEZG1WbkFqcnBjVEFFeUk1c1B0RmRxTUloRVRYRTZxZEFR?=
 =?utf-8?B?dy93NDhaVWE3akxHNDhrb1RuMEwzdFdxdVI1aGxRMHcwNm1UaTRoemhqL0RH?=
 =?utf-8?B?Y2p2aWdvNkpBcDVhY3pPUzJOcE0relRHOVJzYjJ3L2FJWCsxQmZBYS80TVVp?=
 =?utf-8?Q?IIffaGLCskhk9uZtgkzRpHhNiQvYqZExvN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 05:10:44.7795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: dc982dcf-7cf8-4f51-4f53-08d89d931d32
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipGd3JO/ZBZAbw6/UG+4d1+akj4TUaD9u9KPZsuHH76NHmhFGHae0kFs4M88SClLf9tFfkW8e1df0KfWpXIc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, wayne.lin@amd.com,
 alexander.deucher@amd.com, Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LGTM,

Please feel free to use

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>


Regards

Shashank

On 11/12/20 12:18 am, Aurabindo Pillai wrote:
> [Why&How]
> Adds a module parameter to enable experimental freesync video mode modeset
> optimization. Enabling this mode allows the driver to skip a full modeset when
> freesync compatible modes are requested by the userspace. This paramters also
> adds some standard modes based on the connected monitor's VRR range.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 83ac06a3ec05..efbfee93c359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -177,6 +177,7 @@ extern int amdgpu_gpu_recovery;
>  extern int amdgpu_emu_mode;
>  extern uint amdgpu_smu_memory_pool_size;
>  extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_exp_freesync_vid_mode;
>  extern uint amdgpu_dc_debug_mask;
>  extern uint amdgpu_dm_abm_level;
>  extern struct amdgpu_mgpu_info mgpu_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b2a1dd7581bf..ece51ecd53d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -158,6 +158,7 @@ int amdgpu_mes;
>  int amdgpu_noretry = -1;
>  int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz;
> +uint amdgpu_exp_freesync_vid_mode;
>  int amdgpu_reset_method = -1; /* auto */
>  int amdgpu_num_kcq = -1;
>  
> @@ -786,6 +787,17 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
>  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
>  module_param_named(tmz, amdgpu_tmz, int, 0444);
>  
> +/**
> + * DOC: experimental_freesync_video (uint)
> + * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
> + * when setting a freesync supported mode for which full modeset is not needed.
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	experimental_freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
> +module_param_named(experimental_freesync_video, amdgpu_exp_freesync_vid_mode, uint, 0444);
> +
>  /**
>   * DOC: reset_method (int)
>   * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
