Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6CACC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E822810E774;
	Tue, 13 Oct 2026 08:03:34 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B752010E774
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyxD86UjPJ/tLyOBddg0pgjVkD5M/9suLGfykEI1MN/e6uWhn6yR7OuCVomR4iUHniXpppjlisR0ibTV7ncpeU1w8hbStcKDxVTjpZCkxbYzrWJRb9Fh0CegSl0BcXxLea+c4yZE/1foL3P05nosQIaw24SfuO6THluIc110RfsZzZ41Qa6p3qg3KsjOhg9EVwRlETQGuGwzWFcSnycFx1krhHv8QifUPFkSNwpZUbJNz1Zd4xoq7iJSwBjkBOzG2wrWc9TiDKhZXVpoQIXdn96FSG33jejA4IR2POfuuyQiliOfa3tWe7TZ8e8z+B+SPgZALKl7fqFSbM6DAjf72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8I0WGUdxVlhdX5oRTRedStZDB2ku8E3IQfDbuSzSqY=;
 b=hxGswktgkw6PkAhYyvYVMFa4QFxlo8ffhV375FxObxqZtDeu3kJFhHrES1TA/46SGIiYmN4esDFlFSKnVrfPplMzrfTyRKic24wfIgPxN8BY+PGbng+Bx9qNprqsG07seMCLcGwdzbJ5lKrFoIYvIDx9diNWiW4doQ5/JFmoaZRGOnk+ckFGWScp5jopfxDSd/xBpsnuVN7+lb5bAM8twPw03XqJvDSKUGjJRmKEy1joWP1RLgVM6sbvn9LqJ+4LNS5hSgp5FFbSZHw2NHfcBqqyulHNVHSK7YUphA4h3aMY1evWAnPIum0JipoUiOT13+21EePjxbaiRhuUOVjYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8I0WGUdxVlhdX5oRTRedStZDB2ku8E3IQfDbuSzSqY=;
 b=fWtu5lzNMig+bznuAp218m0gbU34biea3VKWY5g3IjyMMms2hsibkghmFlCjqGywQkijKNuef1TEwEGiX1UPAY0iWwTGA5KURl/WEYyURqsvYqPk6gGxlKgwSnEr+uHorELGqiqL9De7OHoUHcvukFEWxMdZKmxQFdGKYmHDuQo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:03:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 08:03:26 +0000
Message-ID: <392f9fcb-a91c-4a32-9c84-fa5f8581e275@amd.com>
Date: Tue, 13 Oct 2026 10:03:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] drm/amdgpu: remove the unused ring parameter
 from update_spm_vmid()
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013075644.775162-1-sunil.khatri@amd.com>
 <20261013075644.775162-12-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013075644.775162-12-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: cbed039a-a6c7-413a-ef53-08df29007580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M5dJA/jLPCSiuQ9cYaxKQxD2ZOiizpnVDaZqIx7hfSae4VPc80nFjyJ3FJ7+xJpExPm6wZXMbA8Jwl8fZ90dkBOpqLwSH/nRvvynYMpUDUTUu+1UNP0rCZdus0jWF5m7bEter+edvcQtidKseGt8yVs/u70Z1l8Qz9/cgZHFugARFO0tcloX6naLVTZgj+Qndsij2dRAzU0sciCGRkASHyv+P4+/4oqAmRyflk86efMSPrJRw/Xef9bmO2XtWpxmVdDU8ZUpteDN6+quuYOitSfQHHrxgX8S7b3hltHS1QQYb8wOFbk+033am1lwP1WkBI2DVMOcyXlRH8QVygHcMotIF0JYl+mcF8fchkaLwghMLPIGfYGaNi2NzEbkqoK8BCOeiAPi7Y9KA5A+AtOOyq3/6dhzgMahCH3C80J4Y/IyPPeyTHO8EMFnfL4o5SCQkXNJtN/6aaZf6dWWVcArB9mOD89wBgfbgnexNz3wBg1pE8PTo4W+nKJFHHaoCaU4UjVdl8vjL4Xhu2zgYIcc5hT5lbbQG8bmzr+Kpmp0TYgpG63k6KSlSNBSenp2H6GyxFCN879qc+DzOWQ9YQQQhAwwX1SK2IB2zgH7Hupx5D0NySOgQ7Nflp2hpzWhH3cGvmbZOiwMKahWFZHcROUvdabiUt8nz6u9CT6cCHia2QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNQMmh5UVQ2T0FzQTFucUxMTXlZOTUyQ0FlNENzbkF5SXVSUVQ0b0NsZWhp?=
 =?utf-8?B?OTN6Ykt2Q1puOXAvbHpkZkNENWc0YnN1T1RmZ1pIZithRXJUdDJCc0Rza2g3?=
 =?utf-8?B?MnExSkJKbERuaEVDcHBUdnkvMXc2TVYxVVc2SktISjJhaVJKVjVXanJnK2NI?=
 =?utf-8?B?K3NiWmM4VXQ4c1I4b0xwVWxYd3RUZU5GOUg2TjdJVWFBeHAxS1NtK0VSRHpS?=
 =?utf-8?B?UWpNWFhyTFZnVDF2K1k3alQzTlJOeFpPem1UUDRXMzRiSmFmcTR5RUJ3Zlhq?=
 =?utf-8?B?ZWZKTm54Q2w2WkttYjNENzJYamhCTHp1NjZpMGJrV2hYOTBYU1NRZkdhc3Mz?=
 =?utf-8?B?M0h2WWEydS8vWSs1anZpaFFLM2FTMDdIUUpNUkJPLzUrRStWcDF1RnF2ZEd4?=
 =?utf-8?B?TklyTUxac2R1alp0MUUxWThOUitxNFgyRnhzY3B2LzZmbG5ZeVkxaDkvS2Fy?=
 =?utf-8?B?T096ck5jdjQvTDBuVjlQNXpObS9pM3BlWG8zOWRZRWFMZWp2NXV1ZGx2V1kx?=
 =?utf-8?B?dTNhc3FGV3A3cGt0MVpmZ2VKc3dRVklhM3lHdWZRMEJGUlVuTjEvMGRZSDhJ?=
 =?utf-8?B?VlJTMVBOeFFHMUlKMEkremFOQjFTUTlmdkRHYzMvQWNOYkV1MmowVVM1VmJL?=
 =?utf-8?B?QkVNZWhvcE44eUc4Yk9YVndZWlIyY2t6ZUlXT2YzS0IzSVdjMTRSamRhT0Qz?=
 =?utf-8?B?OGUrZGJNR3NLV2FJQXFnSi9USFhFZktQR08wQzYxaU9TdUdiTVZnaXhyNmFQ?=
 =?utf-8?B?SnYwV1lHSCtvV0FMNHI3cStUMGxhRXFNaU9Ec0kvblJDYmJ4STZ6b2JnaU95?=
 =?utf-8?B?eHFDYUY2Z05rZ1JDOXBNNmRhc0pqaVRtUE9jM0FDbXludjhEb1dNT3J0L3l6?=
 =?utf-8?B?aGI1VkJXUndNaWNZVmx5SHRiVkphVTB4Ni8rSUJNL3lnREpvcXFQaUZrenI4?=
 =?utf-8?B?dGQ0VFo4d1VhaVFlQkV1R1VHWjY2RnNYRExRSks4c2RKL3FtNlNVdzlVb1A0?=
 =?utf-8?B?c0o4UkxZdE5hKzR3Yk12T01hVXM2RjQ2WXpqc0NFTWFWZWFMMHBxeHdwbUJK?=
 =?utf-8?B?OGUyQ0tNdDhjNEdlMFZ3MVZtOWtnbEF6dzFZMHhIeFNoSGZieW5CbE02L0xv?=
 =?utf-8?B?cG1tN1lKVE1tZS84WWR5RTRKMUprU1VPOHY4Q2VHSTBrVTR3b2x3SkJGaENy?=
 =?utf-8?B?Z3g1NTNDOEJmSjZEdjFCQ3BIME5ONnZXSEd3Z1FLSWxIM2NZQ2RBdlN5WURH?=
 =?utf-8?B?MmltRFBBZGpNUXVnaGVIR21mLzdpK291dU1jVlhQUGxNZURBay9QZEk0NU14?=
 =?utf-8?B?cVpRRmFiVFZJWENZZXk5emxXNVg5TTFCNTZhNjErZWN2VzcvS3YzSWt6cmtC?=
 =?utf-8?B?bjFGYXV3S2pWQ0xQcXFtd3ZJTU1DR3JHTnNhWVZiRUY4NjYwMVgxUnlwa1lm?=
 =?utf-8?B?N1ViczcrTTl2bmJHbSthR216Z0gzWTRFWUpxOFJGcXBDZUQ3dVNsNGdmQ2pp?=
 =?utf-8?B?NTdjOXZnRXBIejZ0WGNOVXZHYWZxdW5uWGp6N21HWHd1WXZYZllvcDcxejlO?=
 =?utf-8?B?VnE0NWM0V1dtUHZzRlpDK1Y4d2VyWmF6UTJmL1FoQnlmSnI3ZkhTenRoRTNi?=
 =?utf-8?B?UVRVMTV6Qm1IRWRFWUVsOGQxMnd5Y3N0S0VQR1gzOFFCbkRFQ21TZURoWlNi?=
 =?utf-8?B?c1BETTQ0UklJT0lSOHNVTWFITGI5bVpEaGp6UXR0a0lLMjJNbHlyTzEwWVQx?=
 =?utf-8?B?aU11bXk3ZWRiWTU4cTR3ZUl0bE9oTmxOc0ErZzVISThXdzNPQ2psOTRKaTYr?=
 =?utf-8?B?RGN3dnpVbGgxNmlUTk1hdEVlSkczckRuUTV3VXovc2lZODFPamZnektoendj?=
 =?utf-8?B?RHlnSXNtckcraTFBMFRmTmovUm9DTU15d25jMjVxQ3A0NS9mNE9DbUUzRWtp?=
 =?utf-8?B?QU9COS91dlNzU2E4bVlhUWdIMjRzNHVNdXBWVm5KL1IrQ2NpeHU1SU04ZkI1?=
 =?utf-8?B?VWFvem03Rlh1UGxaeGNDaWVwWVBrYXhLTVFEMXBqT2lOWHVDMUExd1BieUdl?=
 =?utf-8?B?YnpXWkUrZE5acW9mTVkzdTZqOU9STldOTEFCQUJXaWJoSVhCbWMyQUhZM1lm?=
 =?utf-8?B?TWhaUStJNDV5aHY4YVJzTGQ0UkV5amJtRHhuM090aUZ4b1lhWHExQ094c2hs?=
 =?utf-8?B?T1Y2ZjNzQXM2MnlZRkhVQ3dkdEt5TU5pWGsxR1dDZ2xCUnpNU1NlbEpkd094?=
 =?utf-8?B?bXNreWh0R2pWSWFVNG5RZlZXd1JMbEwyeFAzZzFyRm42MHFwdFJvRFF4Mmtv?=
 =?utf-8?Q?Cs24gJtolv6pCcJP8H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbed039a-a6c7-413a-ef53-08df29007580
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:03:26.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAVGmJZODf5BINuk/iBW1DyFQ5rln3XmLd3G9aQO0avQH8nb5aDX2vOGCxpK9CdF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

On 10/13/26 09:56, Sunil Khatri wrote:
> Every remaining caller of adev->gfx.rlc.funcs->update_spm_vmid() passes
> NULL for ring, since the only callers that ever passed a real ring
> were removed earlier in this series. Drop the parameter, and the
> dead SR-IOV one-VF ring-replay code in gfx_v11_0/gfx_v12_0/gfx_v12_1
> that only ran when ring was non-NULL.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Good that we have this removed, the implementations in gfx11 and gfx12 where totally buggy and could crash if one application uses SPM immediately after another stopped using it.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 12 ++----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 11 +----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 15 +++------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 ++--
>  9 files changed, 15 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index 2ae2c1d0f702b..e38a8ea02c520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
>  	void (*reset)(struct amdgpu_device *adev);
>  	void (*start)(struct amdgpu_device *adev);
>  	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
> -			struct amdgpu_ring *ring, unsigned vmid);
> +			unsigned int vmid);
>  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fce651d9bc613..b6f61f4a08e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8320,7 +8320,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		struct amdgpu_ring *ring, unsigned int vmid)
> +		unsigned int vmid)
>  {
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1f2ad47adb9fe..315dfd806d56f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -5748,7 +5748,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		struct amdgpu_ring *ring, unsigned vmid)
> +		unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;
>  
> @@ -5769,14 +5769,6 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
>  			WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
>  	}
>  	amdgpu_gfx_off_ctrl(adev, true);
> -
> -	if (ring
> -		&& amdgpu_sriov_is_pp_one_vf(adev)
> -		&& (pre_data != data)
> -		&& ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
> -			|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
> -		amdgpu_ring_emit_wreg(ring, reg, data);
> -	}
>  }
>  
>  static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 72ceb113689e8..d82e7f115b7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -4075,7 +4075,6 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> -				      struct amdgpu_ring *ring,
>  				      unsigned vmid)
>  {
>  	u32 reg, data;
> @@ -4093,14 +4092,6 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>  		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
>  	else
>  		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
> -
> -	if (ring
> -	    && amdgpu_sriov_is_pp_one_vf(adev)
> -	    && ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
> -		|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
> -		uint32_t reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> -		amdgpu_ring_emit_wreg(ring, reg, data);
> -	}
>  }
>  
>  static const struct amdgpu_rlc_funcs gfx_v12_0_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index b44f5ec68714d..147bed75261c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -214,7 +214,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>  	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -				      struct amdgpu_ring *ring, unsigned vmid);
> +				      unsigned int vmid);
>  
>  static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				   int mem_space, int opt, uint32_t addr0,
> @@ -1861,7 +1861,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* init spm vmid with 0xf */
> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		gfx_v12_1_xcc_init_csb(adev, xcc_id);
> @@ -2918,8 +2918,7 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> -				      struct amdgpu_ring *ring,
> -				      unsigned vmid)
> +				      unsigned int vmid)
>  {
>  	u32 reg, data;
>  
> @@ -2936,14 +2935,6 @@ static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>  		WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
>  	else
>  		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
> -
> -	if (ring
> -	    && amdgpu_sriov_is_pp_one_vf(adev)
> -	    && ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
> -		|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
> -		uint32_t reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
> -		amdgpu_ring_emit_wreg(ring, reg, data);
> -	}
>  }
>  
>  static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 91ce21425126f..dd00be109d7cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -3479,7 +3479,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		struct amdgpu_ring *ring, unsigned vmid)
> +		unsigned int vmid)
>  {
>  	u32 data;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 479480e39fe47..c9268cc5715b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -5491,7 +5491,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
>  }
>  
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		struct amdgpu_ring *ring, unsigned vmid)
> +		unsigned int vmid)
>  {
>  	u32 data;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 8afcdb54a0f56..75d1bbdb421ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5225,7 +5225,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		struct amdgpu_ring *ring, unsigned int vmid)
> +		unsigned int vmid)
>  {
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 1d1973fd8f677..0ffdef21df0ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -1607,7 +1607,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
> +					      int inst, unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;
>  

