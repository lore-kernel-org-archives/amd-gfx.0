Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2910CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E9C10E0A6;
	Tue, 13 Oct 2026 14:22:41 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F53310E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GttfcrqntdgRa7wqPm+Ioc9I4+jMhR1RUP3aVNyPySLMntEKvoMJDAL9H5HKkR+Ae9iPb9JrPl9ONV0rCABpKphbd5syqtfx5YXq9Zcxui1S8Qg/iKYM3BMnz4BY+qvppoOGMozIAt0/PDqh+QxAudb7srL4WTARpCzsBmz4zkpEw8k483ySOfE5e6LZPjjBL399oYOxcNZYj+DBF6rXE3PYU1PHQv38b/fxxm8rB4AtMM68J9d9ug6JsVFArb5l0865QNHjBxKtUEIj7KrR6odmiSVini7CKgXlnOin1TybD/1lJk+a/1FHhzK/MPPpv84S8Qg7AU6OYyB4jZwRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7vHZabG75zrU0BxzRptYbsoINQD8+n5qfB06h7+Yt4=;
 b=LY8Wnkb7PINXz7+QeIjoUMUv3gWr2rXwjLaiuIVMc72pVmok9Kz8c0OYpHKxozkvMZ8F8YlJZZnhIdxSNv0ysbJjBI++W0UnXffC4nkT1bEX7YaUoeF8yp/ms7P4rRVBdHdVbMdKOyaordgJSXl7CaVwzBQsI/AaIVPGzxgMl6iNVOvdxI1fo8akIWHN1cmfY6HYCSSRI+RINEDiDZE5LyE5IBd4ZGfg14qwx9Rs671u5MaFxUt6rnbIF4SmIOQRFxsWSb90elTgPNiQM0VPtIeab0BHpLSV990PHL7pjsg8Gdxj2s3kzZN4N44JdmWDnH5kA4fXykMx4Jbdl0tGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7vHZabG75zrU0BxzRptYbsoINQD8+n5qfB06h7+Yt4=;
 b=aAzvQJdFsE65zdGCA8qVVJMEPGvoNe14BcyuKncRPweTgig0Irr9LRucWfRDmVntp1Vl0xUaSSxtZOCfGcA7/QYOKMFtjjZmNO3hr812dY0erQup3ggw+XpPXJGXoyqq1A0U4oQeMN5HPO7axeaC5elRRfJiNWgM8h1I2yu3usY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Tue, 13 Oct
 2026 14:22:32 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 14:22:32 +0000
Message-ID: <1304f553-a3e2-44b7-932f-f184ab3d3665@amd.com>
Date: Tue, 13 Oct 2026 10:22:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/evf: skip BOs no longer in the VM
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261013141357.1907194-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261013141357.1907194-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::20) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e308d8-8af5-4db7-80ea-08df29356b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|261009223027099003|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: pjH+4dAbqFOPGsrUIDKy5JdPoEqSKuXyaVYsG6ydhpRhH9kOT48JRclRSAi7PBPJ2hYJipvLXRXrx20ANH0ziaOZi3NDu+be1YScTVxJPxxIm1xp1XRSrTp9pM2h4rgohbSnlwFbXMfwzrZkGY3RHvDegvBtYiLpEXe5wZK89Yy7EYToxi70Zh3gCgllc5B3lY9hvr6Ehq8bGvUg7jHmXu5ub7MmsUyp4QQbmrQcw5gFEJgkca1dnFB0ZJMENbM/AU1mInb5Pi09T50xE8cVVr23GW5JACCidERVSdX4FFhHy+WHMaZOgu0dYvnRzFFgSifh0ujaL0LvzSNZ85pBYPj+KTwCsRAZMbE3v6J6O3WrnQXspRmzQwLpuFrOvXREjwctx5l8eHMiN9Eb8X0Y2FEhucOeUGzQMgRAFsinQtz30toqjUkVpKLWaaSSf7gryLb2wXijNysI1QP12uf6CRTHUdLrxlJdDd6lvDhBF5yMkucCkEvdI/KyCxuoQngdBf9XC3Uw0kdTDQ3DW3TnfVVK0m4lv4zz5Uh2egYv0JvNU8OyZZbaj1+D/DaUuIBpsjYS74rMgzsq43pXehlJOstgNZvuEK14zAEl8oqu9QpOOvT4NXXYWJtv5PrfaqLMOOquSm5kShzc7ijRLJhgSNqxhTdz6Ms86UWEB29noPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(261009223027099003)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1qR0Q1VjVIWCtDbkt4anIrTHZBMlk4N09lM3hxN2pQZnpHeTRtSHA0WVdk?=
 =?utf-8?B?TTlxZXhJZWZ5cEZNMFFYcjNiY0dEOTZ0MnE1Tk8vZ0pmaklxM2dZMEYyTGt4?=
 =?utf-8?B?bFdNbWwxNTNkd1Ezb25Gd0RXVCtaa2hITVRyREFhczhWckFhRmMyVkdiSWor?=
 =?utf-8?B?RzhPTWYycmpuaWVuYjY5dk9hRTcreG9YWkl3TWk5OVA3aXVsYnphUnZmN2lU?=
 =?utf-8?B?aWRvcEVybnZKdGpzVHBDdWl5NmRDMzlsTXZDQTJseUZTZHBYM2dib1o1Z2RS?=
 =?utf-8?B?bWN3MGo1YmFPT1RWSmNuWnlISzk4ZmV3TUhQZHA0cXFncXVXTXpGRXpVWTlm?=
 =?utf-8?B?UWxDZ0xHL2RXR25kMnAxaVVCelpSU0ZEeVhmdkdwTHA3UEJEbE1WenVrUlhM?=
 =?utf-8?B?Z3ByWW1Cc0Z1ZFRrejRNM1NpYm16ZFN4RytwWk5ZdHpRaEpnb1JPaFVaVW4r?=
 =?utf-8?B?TUxYRUM0dzk3VTcyWk9lSzhFY1pEM05KcnU5cUVKbnZMdURVc0U3WHpDbVhM?=
 =?utf-8?B?N1hXUjFMUWhsdnRKbjBOazl0akNtWG1ack5Hd0FUUFhtNkYwTCt1U0F2SE1p?=
 =?utf-8?B?ZStxN2JWd1ZDeXQ1a0pOMkhtOUdLbGl6UzRZc1VWVTI1RkVadTJ0NGhQWjQw?=
 =?utf-8?B?S0RWWWRhQ1RhMlIvdDd1M2tDcXpRc29UQWIxMDFrSFY0OW5kWmNidFhoTE0w?=
 =?utf-8?B?YVZTWURDZVFyRWFDZTNCVXRERVIvN1lNUHJkWXI3NWprVVBnSy9DeWtJZVp6?=
 =?utf-8?B?eFRhSGRkYWtaR2d5R2ZWQnFzVTdEU0hBUElFZ3lPZEtxdXlUUGxRYjBUcXNG?=
 =?utf-8?B?enQyZUl0dzd0ZVBUalVnbGp5ekJYbmVLeERjZ2xvSTZtZmg1S3hrWFdDckxY?=
 =?utf-8?B?eDNjRnAwTkdQNDFQQUV6KzNBY2I5TmVxQzRZTXFLZFBLZjR5ejIrcU5NdUxO?=
 =?utf-8?B?Q3NreWZLbzVjMEJ6UWtJdGxLNEhXV1ZBbmxCK05lOFZwMnlYQXRicWQ5Ylhq?=
 =?utf-8?B?ZmZqVnZzeGY3d08zbEwyMlIvRWVmL3dhekZuQURHL05pYytyMms0VXAvY1RD?=
 =?utf-8?B?M2NXWHpFOER0RXQraGdTNCtoU1NSaXdObHJPTEVOVHZxV3psbXViZXVCKyt2?=
 =?utf-8?B?WGZaakJodGcxTFF1YlQxYmFiWlp4MGx6RzlpRHBoUjZyMkRET05NRFF5TDFC?=
 =?utf-8?B?TGlhajZ6SWc1QUcxMXpHK2FXSGZVb1IwbEVQeHNEdzJJR2x4WXRPN2ZSRXd3?=
 =?utf-8?B?Tk9qSXhla2owRUpzMVVaTmo2cGpLSTVhOFZWTllweUpvSVJ2bEErcmtnWEZ4?=
 =?utf-8?B?YklsYVdCcEdSMFROMzNMR1VqdlJ3MysybjFEVUxSWXRHV0N6d2U4TEVTRzVi?=
 =?utf-8?B?d20rUnY1eWZOTmFYbHY0YUZLWis4VXplWjF1VGNIRHR1OFlEczE4WkFzRVRP?=
 =?utf-8?B?Uk1hWWZuMkZPcHpCbURsZlBVa3ZtOEFNc3kxMWdPTCtYWk1kcTVtd0craWgz?=
 =?utf-8?B?cnhuWm1uWUlLTm1GZWJRK2pEQ3lPdHZNUXNzZVJJYytYS2xoVDR0NUhmTnpZ?=
 =?utf-8?B?RjI5ZHo2c0RZeUdaYlBna2crcVFKNzVQcXpnMnhuNEFPWkhhR3R0anZIK0xR?=
 =?utf-8?B?NkZBbGxoQ2VocVhJQkhHVUN4VlVBUzY3VlhiZG90bjd3c2lZeWdTZjFTa29O?=
 =?utf-8?B?T1JVaDNwVktqc1JJL0RLVjI1dm5tenNPdjRRMGNwRDhnK0JxZEhSTWtOS0JD?=
 =?utf-8?B?RU1yUFIvNEl6eWVqNEZBR0ZhbTIvSXFUNlpLT2hOYWpNUkxiL0l1c2E2VTB0?=
 =?utf-8?B?aHlxOUNKcUt4T3pKZDJCRDY2enpFR1hFSnpwTWNmL0FSdWxwM2Y1QnFhZ1Vm?=
 =?utf-8?B?djRIQm52L2pDVkJsZUl1a2JJQnZyQWkvR1RGT2ErcnErQ3pwdVM4cGRTOE90?=
 =?utf-8?B?VTJlYzZmMFBQNWNST2JTRU00dzd4VGdGdlNvc1VnNTRhNU1Hd1pkK2xCRU5G?=
 =?utf-8?B?SDhyRE1lWWdZaFBMdHErOTgrRXV6WGlYZXhZMmd3eWVkc0hkY2FwbjZ3ZUY5?=
 =?utf-8?B?SUVVOFdzbUZ6bVZQYTRpNHRVTHBic2FKZDhiOHlHUy9vbmpERTRyQWFKU1Ri?=
 =?utf-8?B?RmxtRkMycjBaWE5OZlRIZmtoUzk5dnYxMkpVajVJSWFSWlBremZBMm04TGM2?=
 =?utf-8?B?UjVvbnMvRHBUdlU4c3F5OExPbXEwNzhBQUZkL1U5RWloWHhWRjdUUm9qQVFs?=
 =?utf-8?B?RDRJL0xhYjJaWk9lWlU4R2I0amxRZkRqd2szZU1FM3JPdzFma2taMEh6NFEv?=
 =?utf-8?B?dTNUZ0pSeitMMHdrcUNrL2s1ck1XTXQ1QkhrOUl4TVhhVnlzOTBmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e308d8-8af5-4db7-80ea-08df29356b33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:22:32.0495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xQni9cxJ570KmyHdNGN34RQASrkVXWc19nHfsRYYkvQY1BNm8OCyc54wl51FCA6KR/Deb1aYrK3mEWvNU8KIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

On 2026-10-13 10:13, Benjamin Cheng wrote:
> If the eviction fence restore gets triggered while a BO unmap is
Sorry, this should be s/eviction fence restore/userq vm restore/
> happening, the attempt to lock the BO for restore will fail. On retry,
> drm_exec locks the contended BO first, but it is not actually required
> to be locked, and the eviction fence should not be attached to such a
> BO.
>
> If the BO was freed, this extra lock will cause BUG_ON to fire in
> dma_resv_add_fence, since the gem object and its resv lists are freed
> already.
>
> drm_exec::prelocked remains set only if the object was locked on retry
> but not actually requested to be locked, so use that to detect this
> case and skip it.
>
> Fixes: 2cd7284ba54b ("drm/amdgpu: completely rework eviction fence handling v2")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index a0802012de49..1e119173564b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -145,6 +145,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	/* And add it to all existing BOs */
>  	drm_exec_for_each_locked_object(exec, index, obj) {
>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +		/* A BO may be locked after it has been dropped from the VM due
> +		 * to how drm_exec treats contention. */
> +		if (obj == exec->prelocked)
> +			continue;
>  
>  		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>  	}
