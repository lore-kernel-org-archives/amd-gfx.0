Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D1C98310
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3CF10F388;
	Thu, 24 Sep 2026 07:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTldEr8c";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EAA10F388
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv5L9pqJOzE3dGz2WMGxsjf903kbVXz7SfwTpakCpduEgi7xpKaYNTDtRtGzk93tSTc9eXWWu7JVbOBgf0SFYuELe5/vCUPo1mb6Xi/dNY9PHzHP2WSwtcJnpMs9OjLkqNjt/oa3w7XwP8kIkBIB2be3+J0819feL/3so+yOb4eBiczWW8ml2lVgtqfGa0VUq6iSGBu0oOE3eXW1vR7uzlViFn9Sh8saroXeHk2lYYMXTfJdNDnwacKjzEpaxay9yqlTQLutP1DHmk8djyinl4RtDWj4/WXVzi//5pfRlstNKzgJkL/1MuikGhezOQAIrKie5IbJ+xWEda/05lAuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA/g0XSyQ3pllmLydc8u8hVour9Zl78FZiKKK6rZg6A=;
 b=S7a8hqu54YR1g9pY95BhY8/4VPEDQEQvEnC458sYvwBOn4gRH4dNkIbHbpsnXEtF54Q9Oqie7y+jGrX0STNHhipteXP+Av6HoXZeSl5rChvFiIntotFvyFQ59PEVg151s3Of9WpV7n2GvKRSBSlJc9/HQsyvpdFMzUhXobkXPqkoTaDG9+5DGIYo+q+Quki9tOxRXbD6mFvIJMzc8Vwyz4FKX1HmdH1TwtgHYXuRcGYXqEOCaLcoFkIronUoU/Ezb3Jczql5ghXI4yC4/aTss5UNV+Jw9LD7QwOB2iQhaAPXjWNk5AYC2G2cwYpEZNOKgjDF9RHQo35rQe+lrXD4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA/g0XSyQ3pllmLydc8u8hVour9Zl78FZiKKK6rZg6A=;
 b=yTldEr8cEPZGRBxnJP0MWn9hkBqbb6K7rTfsozuxW4FXquXcJ91R89srYCaJRM2bA08tOlK1f8biHmrYiwsgx0KDMxCj67p+48UDsqBV5aE+0oYaslSOYNq7S4GjSjeTXYfnDEmcK74gKlpUGNF21qk0TNyUuqslGVBVUO4/oTo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:52:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:52:43 +0000
Message-ID: <1acb3ea0-25d2-42b5-96f6-5e8a15c96294@amd.com>
Date: Thu, 24 Sep 2026 09:52:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] drm/amdgpu: handle runtime pm in
 amdgpu_gem_userptr_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-6-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-6-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d7e8d6-d4e1-4f68-d9ef-08df1a10d0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: esZQiwP5DQyL371jnb6aDfVtcF2Bz6S5l+KpjuCSVXloyUsEZeoUZLPWsb8GEkzKAw6xu+FU9pf+0s3Us9vGcMIVEzuFWbbRjvjup6PlNLuayb5cCHMlvgJ0ZDWIkW+kjej729BW6MsSFCfEmaRGKTgJuO180e2S0XC+QZSoX2PGJzdcak2oAM7GT1iB7vzz1WVREOxh9WdeaPFHtBqPnD06ruKl0RaOuWFL98cVT50oNImwS0BQZeljT6mlIFQaxhuqS0rIc6TGIvdb064Vv3IjlfjvjaIQPL5p8a9m4B7jHToUYMu6axhvo1msZQWyXCaQVcOkzFZAvefpLEiK9yfGIOwvQ6WE6dSjEI1rusaayKtwV+SetvUZK+WbL4UkuYsIM6e06jR4p7odUnI7LCN7SnEDNmzXmhWIqO01x5pnxnKVtLDh6YeNOOW8VYEtjuhYGOvHHrNTvA3+k+jWzLzl4wK1Dzy79rTTYA3rR0ol6ptDyQQRwOYmQXfnKvPPhQ3yVKwwDtvHUxhx5HkavwcC+PpgKhSNg5RzHhYk8iIO6pdj2xDeaX0ltiDbcDcEBqiBbKr8E7JOQopqGYbeUpN/wWMN1Lr72OqZj4WdCM8w2ltKVG1O82TZPj6qLlTy5QSlfp0b6qJcT9NFbxD6eJrMOeLnVdrGKFiGQMlD48w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZHVkY4Sm9WdCtDL0MvQy80USt5ZUF2Q3JpNlNZQnBKN0ZPRlNib1ZQMmxB?=
 =?utf-8?B?TkUwaGp0VlIzMVFzblUzSWxWQ25tSDE3bjhUTXBkTnlEZWVtWkNjUmNROGc3?=
 =?utf-8?B?bkpvVUxraVpPNEhWcXU4dlJGTUZYeVQ4dHhYUndqZXNYQUNtREs1N0dNcU5i?=
 =?utf-8?B?OU53S3pNM0Y3U0JQZVQ3UWJGMm1vMHRQSmdZVUswRTk2aWI1ZThPRWdLQm50?=
 =?utf-8?B?cXVFNFc1aW5sOVZaempVRkNwMVJjcms3aW44a3JpK21raFFqSVdMaXdkRStR?=
 =?utf-8?B?TGQ1bkNLL2tZZHFjM1BQbG0wSGp3WFFWU3VKenVocnRKVWd0cHBDRlFhSUtF?=
 =?utf-8?B?TGVpcHlJRWhlODNBUmVJcU1ibWpHaUt6aE1tTUtNeStPV3BlOUJsY09WLzY3?=
 =?utf-8?B?VTlFQzBrSXVOY3phSWJzTEEzQ0drUHd5MGtnVGxxQzFPcnR1MDBXT1hEL1o0?=
 =?utf-8?B?eDdNbGdHdXExMExYOGZSL1owWk0yOCsxcEFvZVk3dlptNllDc1d5SzhOTlhD?=
 =?utf-8?B?L1prd0Ric0I2REFINnpxbFR6c1k2WEN2SkVyaDVZWEJKL0J5dUR0ZGUwdFYz?=
 =?utf-8?B?akxYL1IyZWJXSDVLMHAzaHdWU0xYMWdxZ3czSFB4ZlVmcnRLREMraGcxdnhj?=
 =?utf-8?B?WmZCdUVOQnFFV2RxMm5icm5CNVhCMUNmTHAvbHpHd1Q5RG0xMEJUTCtnSmtU?=
 =?utf-8?B?ZmRseGY4UnRWSU5qcU45dTRJZ0RkUVlsK1cvYmlMUFYxNCtWS25GdmtGWG12?=
 =?utf-8?B?Q1Nhb0FtaHV1V2huN0tzeTdKQ1RUbzBKZUt1eWdaZlZIWGM3SjIrVGdqb2tT?=
 =?utf-8?B?Uzd3bE4xRzNWa2F2MjVwNUllNk56cGJIOUg0NmZtcG1BYkcvSlNqeHRDVjlU?=
 =?utf-8?B?OXJEZHcxMUN5QmwvZW0rN1EyMytlWjV3RklqTHlJdy9GREluTWxZY0xpdmNi?=
 =?utf-8?B?eENneUlSRFg3NkFuVnN3UnVUZW5tZXdlU3kxY003YmR4VkZGTHcvK3VlUzBz?=
 =?utf-8?B?YUllNzRyK0ZnNC9EM2MrQmZvc2tMTVR4cG5PN3c3Y1IzSEdHc1lkTmw1Tklw?=
 =?utf-8?B?bzI0RlVjMGVuNThDMzVybmwwTzZKcTdKSU1rdWwreU1sMVhPVUF5Nm5sUFVk?=
 =?utf-8?B?THBPVEdzdENxTS95Zk1kVklEOTJrOXcwNzVNQWVKSmRKNitjQWtKRmJjbTVh?=
 =?utf-8?B?Nm5WMEhnMjR6c1lhMGQxenVQZVRSYi8wQUl0TFcwWVJJUjliRmt6bTVHYklF?=
 =?utf-8?B?c2dpWVJQb0o5d2w2T1RSTkd5V3M1Skt4eUJKY3E2RVRHSkJuTnBDZFZKeXVt?=
 =?utf-8?B?c3VpQ1RJNStVRHZ0Z0JtM2lWVTFsME5LOUxSN2traFF4NjNDV0IvbytYaEJv?=
 =?utf-8?B?U0FBd20wNEZZSndLd29HMzRCYmgxZlV5ZTVYcTZOZUQ0S1d5VUtNRjZ1RkJi?=
 =?utf-8?B?TFBCejVZWVZnNmtrbEdNeXBlQUsvdTRPSlFGbWJIZWVVSzhteURHVjViSFhh?=
 =?utf-8?B?Zy9MV2w2MDMwOGhhZEdnMDFMek9LQVJFNlhydERWRWFqT2tocE9FTEFiYlVi?=
 =?utf-8?B?K2VEYmhkdlhrUkttd0JNL0JuVTVjS003OTNKU0tvb29GcWd2ZjZmUGIzWmlW?=
 =?utf-8?B?c0g0WFRUUDE0cTdpd1BGUUd6dlBsUkVXeDhlV1I3K2RVQXVvV1U4ZEFlTVpN?=
 =?utf-8?B?bVpTMjNzSkgrUmpIUkFWNFVvQUNTVWlleHlBWlA0WXhmSTZKYnZCclc0U3lz?=
 =?utf-8?B?RHFwbkpTMk9icmVFdk5pM3NYZEtVMjhHVUh4UGZ5R2dRaE92QlcybXpsNm5L?=
 =?utf-8?B?Z2o5SFpOZFZxOWNtTnpJRXllYm9waG56eHFFUVh0OEhxY3BxM2NZWG5oeTZi?=
 =?utf-8?B?T1ZMSVAwM0JDeHBXeVFCSFl4ODNiczlsWStqK0tIVHFUbjRPU1FtRmpQamtr?=
 =?utf-8?B?d2tCUHpHQmMzajVEUndSb2htalJVNHlOazdyWVV3bFBiMGFBYXppN1JFRDhP?=
 =?utf-8?B?S1R6VUd2Qkp3Q0pUcEFhOUJaM1FwL3MvOE9XK2V2c28yNWJYWGRUR2xkeWJm?=
 =?utf-8?B?eCt5bUQwL2xVUlU4Zm5CUTB5M3JIZmRyc3NTOE5PZlVVamZ4UDZWYkZoMjZL?=
 =?utf-8?B?ZzhKY0QyemJ2VFJTeWlWc0QvNm9yZXRZSVVURTdxczU0aVBEb01Odk4zRE5B?=
 =?utf-8?B?NDhwV2FLaThnd2QvMGxxN01WUE5DU0pLbE1nMVF0aUpLWjJGZU13MjNsakpk?=
 =?utf-8?B?Y05TVTQ2S3RFVDhPZHlJUDlEVlNXTVg3bURqb3RBTy80WnI5VDNNU3FWZ2VL?=
 =?utf-8?Q?sVZiTjfpyh9FWczFXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d7e8d6-d4e1-4f68-d9ef-08df1a10d0a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:52:43.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bmn/05oNBRAmMwSZW9M7+67oP8q0EAY9IWwkYZRM/ApYajx5aMk6fauCV4S9Y5Zm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Wake up the GPU while setting up user pages and validating the buffer.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5d2802009cd9..e1760e112ec0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -590,6 +590,11 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  			amdgpu_hmm_range_free(range);
>  			goto release_object;
>  		}
> +
> +		r = pm_runtime_resume_and_get(adev->dev);
> +		if (r < 0)
> +			goto user_pages_done;
> +
>  		r = amdgpu_bo_reserve(bo, true);
>  		if (r)
>  			goto user_pages_done;
> @@ -599,6 +604,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  		amdgpu_bo_unreserve(bo);
> +
> +		pm_runtime_put_autosuspend(adev->dev);
> +
>  		if (r)
>  			goto user_pages_done;
>  	}

