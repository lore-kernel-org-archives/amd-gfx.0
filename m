Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EFFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D35E10E491;
	Thu,  9 Dec 2021 16:53:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20E589FFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 12:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5GzxgFMuILxY8n0uN1EJlIsnDgP/pC+uoYkVvioPLNhwcKYh2XCdYvmfc5lD7mDpwuS9AsC8dbtWX0zyM4ufBPIkfSsye9x6dgzGn2jSOijihIqzFzdlcbD2fpER/3wgwSmPo6SBgpQ5oP2m2Nz3CK6hi2FrME7re43FBP2+4naxwS7yX4+vuUx1rSA4oABQk6j3BXSwLJl6v2GSw0BOghi58ORXQusSOvFYw4YJBLDDYF+0O6HiGc9DRRMEtfJ1mmMC+1F8VsMnFoNFQ35cQvJw0vozNcnvFTRTcUrqJdtIBNJACiEU4FiHUwEqOt+rMArcNZrFWZJAZ4/PDeS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwibcy071/s9SMXTHmz3v2gGZaCxlUuLr4+NvOUgrxw=;
 b=CPQ/2McTRdQVUi7QODn5wQFuZhCe6EqXOGTJRbY+GQoLEzP3KiES8dl9DxN03xPSNMDxVQg5wiq2Xt5THk5239Y6XVK7QkNsEqXDmxInRdXEp3FiLHVyXVedhyJKJGxUtcDY9QeHz005UH+YqmZvNppKPXxiyuqQuAIfbd4su3/aa7qtnlBOnCDfjIaWMPa6L8ZLf+nRGj3J2uRIo9cLhDB57FT6/ss9yYwHZ+g0pE9bqfuSqPn6rzvRnIIK5RqifvIp62GzZ+xszAK5H0TtFKIXIy1JHpxAP0FGtAw7IYzKubYCl8eQJbpQa6iqc/uR7U7S4ilmftigzmfJ/lTMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwibcy071/s9SMXTHmz3v2gGZaCxlUuLr4+NvOUgrxw=;
 b=uEyZZduU00KX2pJSndqxfcQJos7v/3cjs8RR1KDGjRcTbNebCZG6fXD56nJ4UUN3YvrhIM3bRpP6jexRs0Dhiwrl4W+WgXuUeYLK3YboIsV4xaMggUSl19sb5LBTUUSrcND0V1J99rjzuWpecY6SnUZLhasa+6ElPjjePKcnpPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 12:32:13 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 12:32:13 +0000
Message-ID: <f0efa623-0521-67ad-3a66-daa4f6a9ba97@amd.com>
Date: Thu, 9 Dec 2021 18:02:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 09/17] drm/amd/pm: optimize the
 amdgpu_pm_compute_clocks() implementations
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-9-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-9-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0109.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::25)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9f819f-088f-4b08-ad78-08d9bb0fed64
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB280930903A3B5832971955C897709@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOnI6nLDJbyqvkqMrkRjaTAp3ek8eOvsOE9CDT4kCQ1NW7pooxNznHEMr8GeApo46y51ySMvKZClyvrq1obnHJelIZyztNppTrCksY1VEB07PeF3s2lZNiqMeogPwF0TJt4vT3giqcU48K+NBQ3JZNum5awQ00hGhXN+mYiVSsC4HsyJ54MD8wN5DVyPPIREY9FiTtdVjGq+Oqbj6xiF2IE24ZPwXwnWYguFuea1SGrcQ6Gd6doDYJacE343mx6vIsMm4oXtyMxB1O5A+tAe1qeVp7n+P4qcX/koEErJu3Jfw89Mr9L0tioPe1KeVJVFrBhSGcRJw42jwR3JUOC/wgqDTMEwFPKJiBI/M5yOsdF2I4l+jW1btMnF2M1gFiCXeO4oe/5mBjhrXYQJX9kfcvJ6tpfVJVf5F/+G+30vFg/Y+s9IQCoqw7W2l3EljVvcMfZeTYv38hQt9IOZcoMFyziKWRCGqCaoLxRPfQyhbm0DWLtjln7ZXyg6d+c2xCewSHIAWu+4mDoiV/gEhikSKXzSSNS7EJakoBBM2ToO0o/PWMBENO0UbZZS1mJTZN0jKLn5Cy3r4gMrh2BrbR2SCetT61tJ1bEYUVUJCOHYzGDcwYBRe5USsHqs2/uHfmELfJt9qFmb9DE9Gbo+WGKYmBOFXOcTkteRY3EUAgoO6mkQU+KmhZVCHoaPrssaon27PG9VjwLC/fd3S9I48Uit9XF1sqHxNzOoVqLX19pnOzWbpr1E/OOoPg9zx1FSMAD5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(8676002)(2616005)(6512007)(6666004)(26005)(4326008)(5660300002)(8936002)(38100700002)(31696002)(83380400001)(186003)(30864003)(36756003)(86362001)(508600001)(66946007)(66476007)(31686004)(66556008)(316002)(6486002)(53546011)(6506007)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0xhZ0FLN0dsRG9ZUFRoeEg2a1dYenIwRnFOa1NINjFKTFZFcWRadEtES1Q4?=
 =?utf-8?B?V1F3aTR6UVdWbnpmd3lHNFBPMVBOK0VlMUsybTRRbFNLVllKYk8zS0ZhcFN1?=
 =?utf-8?B?aUhpeE04NUx1Y2lCNis2dHVNSDdLU3JWTUMwOEJQTUJsKzBRaHo4TlRHUjB4?=
 =?utf-8?B?ZWlVdDduVkFyS2dyZWZkSklLSWtLVWE3bEF3QzFOaUE1Q2ZUM2tsQjIxbWFB?=
 =?utf-8?B?dkU0OFp1WmR2MDBBdlF6TmhLN1oyalRxVnVFVXd4elllM1FQYVljMDJEMjNC?=
 =?utf-8?B?bHJBNi9qMFlndEoxaDJGSEdHRExiUmNKb2MxV0h4Wlg3eTJkcXdCMS9mQnNW?=
 =?utf-8?B?MTg4UUtQalJMeWdEWGVSbmhxRWVqaWhURWd4ODE4L0JQUnNmUk8vZ2V6TkxP?=
 =?utf-8?B?ZWcxbTBxMndsallQY3FyMHRObUZOTnRqTnFjNXkvcmdNSkZMVzZhVkRoVXJS?=
 =?utf-8?B?cWpGdi94YmQ4eGpURHZwMUppSW15M0lBR0dRK3FHU0NmaG5RcERKTlcvbWFR?=
 =?utf-8?B?a3o2WTRDRzAzQ29xQmxsenNOTWVWdUdWYVlSQmk5M0FuNVoycUx1SGFzdzJJ?=
 =?utf-8?B?cVc4MHZkV2lUTzNHZmlXVG1vd0EzUEZ2Mk4vZTZPTlFqRzJnY2dER2pVUHRG?=
 =?utf-8?B?L09MOGJLOWxHNHZjU254L0htSTRUWDVQNHNtY0xUQWlqeGJjakFqb0xHdUJ3?=
 =?utf-8?B?WSt2ZFhmL2l3cmo5RWs2UDhKWkJjQW1JYXdXcVdEeTBSN3huMWxNeDhEYVc3?=
 =?utf-8?B?ZjU5T29kYmsvZEp3ZFc1Q2RqQVdJa1pTTzZBVjkvNVlPakdBMngrOHBCdkg0?=
 =?utf-8?B?YjhTUGVNUCtHc2lzS0haMHJ6MzZHRXRGWFgwQjlrRDVubDBhRzdSY0VNWXE2?=
 =?utf-8?B?OUMvTGtkZFYvcHE0b0ZLOWN6WDdvOTA5NnVmanpadkladi9xNnZQY2pLcnNK?=
 =?utf-8?B?OUhQQnZoaVBGa1luMTBubkFlOG91YUFPMmJwWGl6bXpHcGhzcTc1bE85ZUxh?=
 =?utf-8?B?cDY0LysxZGxQN2gydEJVQWhFdjVtbnk5Q3NVem50aGJuMWorTG9TMWpMdzZT?=
 =?utf-8?B?MnNxWnR2RTNMTHRIcE1lSlRJN3RZcnRTTFg1NWt3ZHliMW8rbTAxWStDdnBh?=
 =?utf-8?B?V0h6eEtEdFBleTU5U0xIT2hiYUgweFNvL3lWc2wrUTRmZndKSTlKNVhKdjMv?=
 =?utf-8?B?U0xLQTgwY3hVR1lZV1NvZTJ5Rnh5Tm5iVU1TczhKVnFLcDJpbjlhcVJNQzhH?=
 =?utf-8?B?a0hHdVJpMkRaQjc3dHl5M1YwK0pmQVB1Sjc5dytKejhuL002ZERPR2huakFs?=
 =?utf-8?B?M0toZDZnUXVQUkhGRm9ZQmFMSnNkNUFPSGZuZlp1ZVM2dklaWE5QVGhGUGlM?=
 =?utf-8?B?dnNCWlEwNEIvajZHT0Mwd0Vzc1ZXbVY4Qi96b2pkdU5sVkJZMGdvb01DZEhk?=
 =?utf-8?B?L2dCdnl4bHRQU0ZZOTNoaHdDSFFibkFIby9YUXA4TnIybSt3VnltVVZIaFow?=
 =?utf-8?B?YitYT1ZUWUF3UUZZWmdRRzRiazYyelFwR0ZiOHBMZTVqUWFIL3ZMMzV6WjY2?=
 =?utf-8?B?VnVJWGFZeE05MkhrRTFnekc4Q1ZUbVFhTFlQendOUmtOU1dVb3FpVElTeG9X?=
 =?utf-8?B?Ti9FUWpCdGZyTjIwSThNNVZVRkgrYVBRUnJQQTRtWU5xR09qdXJCaFVxSURI?=
 =?utf-8?B?UWZ0QUZmeVhWSGQzaTVkMmRaT1NvWlJtd1lrM1dxMWtNaytHaElZbTF6eHRZ?=
 =?utf-8?B?d0hCdFBRQ0FQSEJwbWVhdVhxTFExR0RLTDZ5djRlM2FhOTdFMkk5Z2VENlY2?=
 =?utf-8?B?cE5mYkhqMEZuMkY5dkpubzNVUlZ3K3dpT1pDUlY2QmdrdURqWTYxZUlLdEJs?=
 =?utf-8?B?SXcyUDFCMXZORXVkUlROWXVZN1VyQUdHa09MVmNyUGZqa2VIOXRrTDd6RDhL?=
 =?utf-8?B?VUNVRFFxbVo0a213N0dueHpEOEJBR0lGYlh2VTltSU4vWlRlRFhGbEJKUlk3?=
 =?utf-8?B?M1l1TnllTzV3S09YRFV6Q3RLbkJZVFFtYWx4UUFpUjVnQWloU2d0eGF3SGcx?=
 =?utf-8?B?VUlWdm9RcTFPKzhQRGVZdDRVU29DYTNHS2JPMk5NL1YvclhsQjVnWFJ0YzU1?=
 =?utf-8?Q?sCj8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f819f-088f-4b08-ad78-08d9bb0fed64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:32:13.5055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nTdB7G9MIIWhZSaQz7mEH6TtZ27eSawn8qNic7ehDiHOkzDV0HxvsJXQTrPK55D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> Drop cross callings and multi-function APIs. Also avoid exposing
> internal implementations details.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I55e5ab3da6a70482f5f5d8c256eed2f754feae20
> --
> v1->v2:
>    - add back the adev->pm.dpm_enabled check(Lijo)
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +-
>   drivers/gpu/drm/amd/pm/Makefile               |   2 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 225 +++---------------
>   drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |  94 ++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   2 -
>   .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  32 +++
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  39 ++-
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |   6 +-
>   drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c |  60 ++++-
>   drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h |   3 +-
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     |  41 +++-
>   11 files changed, 296 insertions(+), 210 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
>   create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index cdf724dcf832..7919e96e772b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -404,7 +404,7 @@ struct amd_pm_funcs {
>   	int (*get_dpm_clock_table)(void *handle,
>   				   struct dpm_clocks *clock_table);
>   	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
> -	int (*change_power_state)(void *handle);
> +	void (*pm_compute_clocks)(void *handle);
>   };
>   
>   struct metrics_table_header {
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> index 8cf6eff1ea93..d35ffde387f1 100644
> --- a/drivers/gpu/drm/amd/pm/Makefile
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -40,7 +40,7 @@ AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>   
>   include $(AMD_PM)
>   
> -PM_MGR = amdgpu_dpm.o amdgpu_pm.o
> +PM_MGR = amdgpu_dpm.o amdgpu_pm.o amdgpu_dpm_internal.o
>   
>   AMD_PM_POWER = $(addprefix $(AMD_PM_PATH)/,$(PM_MGR))
>   
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index fe6bf5d950c2..952fd865db13 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -37,73 +37,6 @@
>   #define amdgpu_dpm_enable_bapm(adev, e) \
>   		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
>   
> -static void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> -{
> -	struct drm_device *ddev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -
> -	adev->pm.dpm.new_active_crtcs = 0;
> -	adev->pm.dpm.new_active_crtc_count = 0;
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc,
> -				    &ddev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (amdgpu_crtc->enabled) {
> -				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
> -				adev->pm.dpm.new_active_crtc_count++;
> -			}
> -		}
> -	}
> -}
> -
> -u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	u32 vblank_in_pixels;
> -	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
> -
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> -				vblank_in_pixels =
> -					amdgpu_crtc->hw_mode.crtc_htotal *
> -					(amdgpu_crtc->hw_mode.crtc_vblank_end -
> -					amdgpu_crtc->hw_mode.crtc_vdisplay +
> -					(amdgpu_crtc->v_border * 2));
> -
> -				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
> -				break;
> -			}
> -		}
> -	}
> -
> -	return vblank_time_us;
> -}
> -
> -static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	u32 vrefresh = 0;
> -
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> -				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
> -				break;
> -			}
> -		}
> -	}
> -
> -	return vrefresh;
> -}
> -
>   int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> @@ -432,115 +365,38 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   	return ret;
>   }
>   
> -void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> -{
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device,
> -			     pm.dpm.thermal.work);
> -	/* switch to the thermal state */
> -	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> -	int temp, size = sizeof(temp);
> -
> -	if (!adev->pm.dpm_enabled)
> -		return;
> -
> -	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
> -				    (void *)&temp, &size)) {
> -		if (temp < adev->pm.dpm.thermal.min_temp)
> -			/* switch back the user state */
> -			dpm_state = adev->pm.dpm.user_state;
> -	} else {
> -		if (adev->pm.dpm.thermal.high_to_low)
> -			/* switch back the user state */
> -			dpm_state = adev->pm.dpm.user_state;
> -	}
> -	mutex_lock(&adev->pm.mutex);
> -	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> -		adev->pm.dpm.thermal_active = true;
> -	else
> -		adev->pm.dpm.thermal_active = false;
> -	adev->pm.dpm.state = dpm_state;
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	amdgpu_dpm_compute_clocks(adev);
> -}
> -
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   {
> -	int i = 0;
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
>   	if (!adev->pm.dpm_enabled)
>   		return;
>   
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
> +	if (!pp_funcs->pm_compute_clocks)
> +		return;
>   
> -	if ((adev->family == AMDGPU_FAMILY_SI) ||
> -	     (adev->family == AMDGPU_FAMILY_KV)) {
> -		mutex_lock(&adev->pm.mutex);
> -		amdgpu_dpm_get_active_displays(adev);
> -		adev->powerplay.pp_funcs->change_power_state(adev->powerplay.pp_handle);
> -		mutex_unlock(&adev->pm.mutex);
> -	} else {
> -		if (!amdgpu_device_has_dc_support(adev)) {
> -			mutex_lock(&adev->pm.mutex);
> -			amdgpu_dpm_get_active_displays(adev);
> -			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> -			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> -			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> -			/* we have issues with mclk switching with
> -			 * refresh rates over 120 hz on the non-DC code.
> -			 */
> -			if (adev->pm.pm_display_cfg.vrefresh > 120)
> -				adev->pm.pm_display_cfg.min_vblank_time = 0;
> -			if (adev->powerplay.pp_funcs->display_configuration_change)
> -				adev->powerplay.pp_funcs->display_configuration_change(
> -							adev->powerplay.pp_handle,
> -							&adev->pm.pm_display_cfg);
> -			mutex_unlock(&adev->pm.mutex);
> -		}
> -		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
> -	}
> +	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>   }
>   
>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> -	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> -		}
> -		mutex_unlock(&adev->pm.mutex);
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>   
> -		amdgpu_dpm_compute_clocks(adev);
> -	} else {
> -		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> -		if (ret)
> -			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> -				  enable ? "enable" : "disable", ret);
> -
> -		/* enable/disable Low Memory PState for UVD (4k videos) */
> -		if (adev->asic_type == CHIP_STONEY &&
> -			adev->uvd.decode_image_width >= WIDTH_4K) {
> -			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> -
> -			if (hwmgr && hwmgr->hwmgr_func &&
> -			    hwmgr->hwmgr_func->update_nbdpm_pstate)
> -				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> -								       !enable,
> -								       true);
> -		}
> +	/* enable/disable Low Memory PState for UVD (4k videos) */
> +	if (adev->asic_type == CHIP_STONEY &&
> +		adev->uvd.decode_image_width >= WIDTH_4K) {
> +		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +
> +		if (hwmgr && hwmgr->hwmgr_func &&
> +		    hwmgr->hwmgr_func->update_nbdpm_pstate)
> +			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> +							       !enable,
> +							       true);
>   	}
>   }
>   
> @@ -548,24 +404,10 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> -	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> -		}
> -		mutex_unlock(&adev->pm.mutex);
> -
> -		amdgpu_dpm_compute_clocks(adev);
> -	} else {
> -		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> -		if (ret)
> -			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> -				  enable ? "enable" : "disable", ret);
> -	}
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>   }
>   
>   void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
> @@ -727,10 +569,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   {
>   	adev->pm.dpm.user_state = state;
>   
> -	if (adev->powerplay.pp_funcs->dispatch_tasks)
> -		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -	else
> -		amdgpu_dpm_compute_clocks(adev);

Where is this handled now?

> +	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state); >   }
>   
>   enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> @@ -900,12 +739,9 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   
>   	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>   
> -	if (amdgpu_dpm_dispatch_task(adev,
> -				     AMD_PP_TASK_READJUST_POWER_STATE,
> -				     NULL) == -EOPNOTSUPP) {
> -		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -		amdgpu_dpm_compute_clocks(adev);

As per the earlier logic, it changes back to boot state clocks if it 
couldn't set the clocks. Where is this done now? Same for mclk also.

Thanks,
Lijo

> -	}
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	return 0;
>   }
> @@ -929,12 +765,9 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>   
>   	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>   
> -	if (amdgpu_dpm_dispatch_task(adev,
> -				     AMD_PP_TASK_READJUST_POWER_STATE,
> -				     NULL) == -EOPNOTSUPP) {
> -		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -		amdgpu_dpm_compute_clocks(adev);
> -	}
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> new file mode 100644
> index 000000000000..ba5f6413412d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> @@ -0,0 +1,94 @@
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
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_display.h"
> +#include "hwmgr.h"
> +#include "amdgpu_smu.h"
> +
> +void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +
> +	adev->pm.dpm.new_active_crtcs = 0;
> +	adev->pm.dpm.new_active_crtc_count = 0;
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc,
> +				    &ddev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (amdgpu_crtc->enabled) {
> +				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
> +				adev->pm.dpm.new_active_crtc_count++;
> +			}
> +		}
> +	}
> +}
> +
> +u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u32 vblank_in_pixels;
> +	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
> +
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> +				vblank_in_pixels =
> +					amdgpu_crtc->hw_mode.crtc_htotal *
> +					(amdgpu_crtc->hw_mode.crtc_vblank_end -
> +					amdgpu_crtc->hw_mode.crtc_vdisplay +
> +					(amdgpu_crtc->v_border * 2));
> +
> +				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return vblank_time_us;
> +}
> +
> +u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u32 vrefresh = 0;
> +
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> +				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return vrefresh;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index b7841a989d59..b0791e855ad3 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -420,8 +420,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
>   int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>   			   void *data, uint32_t *size);
>   
> -void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
> -
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
>   void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> new file mode 100644
> index 000000000000..5c2a89f0d5d5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> @@ -0,0 +1,32 @@
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
> + *
> + */
> +#ifndef __AMDGPU_DPM_INTERNAL_H__
> +#define __AMDGPU_DPM_INTERNAL_H__
> +
> +void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
> +
> +u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
> +
> +u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 20cb234d5061..d57d5c28c013 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -31,7 +31,8 @@
>   #include "power_state.h"
>   #include "amdgpu.h"
>   #include "hwmgr.h"
> -
> +#include "amdgpu_dpm_internal.h"
> +#include "amdgpu_display.h"
>   
>   static const struct amd_pm_funcs pp_dpm_funcs;
>   
> @@ -1678,6 +1679,41 @@ static int pp_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   	return 0;
>   }
>   
> +static void pp_pm_compute_clocks(void *handle)
> +{
> +	struct pp_hwmgr *hwmgr = handle;
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	int i = 0;
> +
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
> +	if (!amdgpu_device_has_dc_support(adev)) {
> +		amdgpu_dpm_get_active_displays(adev);
> +		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> +		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> +		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> +		/* we have issues with mclk switching with
> +		 * refresh rates over 120 hz on the non-DC code.
> +		 */
> +		if (adev->pm.pm_display_cfg.vrefresh > 120)
> +			adev->pm.pm_display_cfg.min_vblank_time = 0;
> +
> +		pp_display_configuration_change(handle,
> +						&adev->pm.pm_display_cfg);
> +	}
> +
> +	pp_dpm_dispatch_tasks(handle,
> +			      AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
> +			      NULL);
> +}
> +
>   static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.load_firmware = pp_dpm_load_fw,
>   	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
> @@ -1742,4 +1778,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.get_gpu_metrics = pp_get_gpu_metrics,
>   	.gfx_state_change_set = pp_gfx_state_change_set,
>   	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
> +	.pm_compute_clocks = pp_pm_compute_clocks,
>   };
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index eed89835231c..72824ef61edd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -3088,7 +3088,7 @@ static int kv_dpm_hw_init(void *handle)
>   	else
>   		adev->pm.dpm_enabled = true;
>   	mutex_unlock(&adev->pm.mutex);
> -	amdgpu_dpm_compute_clocks(adev);
> +	amdgpu_legacy_dpm_compute_clocks(adev);
>   	return ret;
>   }
>   
> @@ -3136,7 +3136,7 @@ static int kv_dpm_resume(void *handle)
>   			adev->pm.dpm_enabled = true;
>   		mutex_unlock(&adev->pm.mutex);
>   		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_compute_clocks(adev);
> +			amdgpu_legacy_dpm_compute_clocks(adev);
>   	}
>   	return 0;
>   }
> @@ -3390,7 +3390,7 @@ static const struct amd_pm_funcs kv_dpm_funcs = {
>   	.get_vce_clock_state = amdgpu_get_vce_clock_state,
>   	.check_state_equal = kv_check_state_equal,
>   	.read_sensor = &kv_dpm_read_sensor,
> -	.change_power_state = amdgpu_dpm_change_power_state_locked,
> +	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
>   };
>   
>   static const struct amdgpu_irq_src_funcs kv_dpm_irq_funcs = {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> index 67c84b7ad8e7..3c6ee493e410 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> @@ -26,6 +26,8 @@
>   #include "atom.h"
>   #include "amd_pcie.h"
>   #include "legacy_dpm.h"
> +#include "amdgpu_dpm_internal.h"
> +#include "amdgpu_display.h"
>   
>   #define amdgpu_dpm_pre_set_power_state(adev) \
>   		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
> @@ -949,9 +951,8 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>   	return NULL;
>   }
>   
> -int amdgpu_dpm_change_power_state_locked(void *handle)
> +static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ps *ps;
>   	enum amd_pm_state_type dpm_state;
>   	int ret;
> @@ -1022,3 +1023,58 @@ int amdgpu_dpm_change_power_state_locked(void *handle)
>   
>   	return 0;
>   }
> +
> +void amdgpu_legacy_dpm_compute_clocks(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i = 0;
> +
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
> +	amdgpu_dpm_get_active_displays(adev);
> +
> +	amdgpu_dpm_change_power_state_locked(adev);
> +}
> +
> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device,
> +			     pm.dpm.thermal.work);
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	/* switch to the thermal state */
> +	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> +	int temp, size = sizeof(temp);
> +
> +	if (!adev->pm.dpm_enabled)
> +		return;
> +
> +	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
> +				   AMDGPU_PP_SENSOR_GPU_TEMP,
> +				   (void *)&temp,
> +				   &size)) {
> +		if (temp < adev->pm.dpm.thermal.min_temp)
> +			/* switch back the user state */
> +			dpm_state = adev->pm.dpm.user_state;
> +	} else {
> +		if (adev->pm.dpm.thermal.high_to_low)
> +			/* switch back the user state */
> +			dpm_state = adev->pm.dpm.user_state;
> +	}
> +
> +	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> +		adev->pm.dpm.thermal_active = true;
> +	else
> +		adev->pm.dpm.thermal_active = false;
> +
> +	adev->pm.dpm.state = dpm_state;
> +
> +	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> index 7ac30f1aed20..93bd3973330c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> @@ -32,6 +32,7 @@ int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
>   void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
>   void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
>   struct amd_vce_state* amdgpu_get_vce_clock_state(void *handle, u32 idx);
> -int amdgpu_dpm_change_power_state_locked(void *handle);
>   void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
> +void amdgpu_legacy_dpm_compute_clocks(void *handle);
> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 35d287903aea..e3b58249c6f4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -3891,6 +3891,40 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>   }
>   #endif
>   
> +static int si_set_powergating_by_smu(void *handle,
> +				     uint32_t block_type,
> +				     bool gate)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	switch (block_type) {
> +	case AMD_IP_BLOCK_TYPE_UVD:
> +		if (!gate) {
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +		} else {
> +			adev->pm.dpm.uvd_active = false;
> +		}
> +
> +		amdgpu_legacy_dpm_compute_clocks(handle);
> +		break;
> +	case AMD_IP_BLOCK_TYPE_VCE:
> +		if (!gate) {
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +		} else {
> +			adev->pm.dpm.vce_active = false;
> +		}
> +
> +		amdgpu_legacy_dpm_compute_clocks(handle);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>   static int si_set_sw_state(struct amdgpu_device *adev)
>   {
>   	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -7801,7 +7835,7 @@ static int si_dpm_hw_init(void *handle)
>   	else
>   		adev->pm.dpm_enabled = true;
>   	mutex_unlock(&adev->pm.mutex);
> -	amdgpu_dpm_compute_clocks(adev);
> +	amdgpu_legacy_dpm_compute_clocks(adev);
>   	return ret;
>   }
>   
> @@ -7849,7 +7883,7 @@ static int si_dpm_resume(void *handle)
>   			adev->pm.dpm_enabled = true;
>   		mutex_unlock(&adev->pm.mutex);
>   		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_compute_clocks(adev);
> +			amdgpu_legacy_dpm_compute_clocks(adev);
>   	}
>   	return 0;
>   }
> @@ -8094,6 +8128,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.print_power_state = &si_dpm_print_power_state,
>   	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>   	.force_performance_level = &si_dpm_force_performance_level,
> +	.set_powergating_by_smu = &si_set_powergating_by_smu,
>   	.vblank_too_short = &si_dpm_vblank_too_short,
>   	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>   	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> @@ -8102,7 +8137,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.check_state_equal = &si_check_state_equal,
>   	.get_vce_clock_state = amdgpu_get_vce_clock_state,
>   	.read_sensor = &si_dpm_read_sensor,
> -	.change_power_state = amdgpu_dpm_change_power_state_locked,
> +	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
>   };
>   
>   static const struct amdgpu_irq_src_funcs si_dpm_irq_funcs = {
> 
