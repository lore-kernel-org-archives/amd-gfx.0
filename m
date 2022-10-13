Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10448C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 04:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB42210E092;
	Thu, 13 Oct 2022 04:14:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E612910E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 04:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0GPo33gqnkdCIK2kZ0hkhbqP7KSBBzg9lkOcnl+VqS7uqsMkiljL1dQ3iX0+lhCue2wdw+hsaYSlzMlsTWY0Ctl75mSf3WDvCFAKV9JvVMsW5NE9e7RxOtEgO08YxbrpRbL2H9jhYacOuXrqZNmi7HZRCKHz1aNbmpjN28LxTZG0EKgEVKToCJTpFW2tbwBRqnRrujWHRfm9wzVN6ByVZsF/BH1vOsljdawHvKN+MwKERqlEUqPnhUNyEk/jy7DzpueD9g1tTFEVg/C3Z6ZcNr2hy2adHw1mgR0kiZlZTNQl2+YSVmuax371Oyzl225cD7e7slIMi9vT89iFdt7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80koDLU9lZZG8vCpSWbl3mInBHcQi8DYdV1/VxpK9vE=;
 b=H0/fIgNBvpuRJtCscN5eadwrIliP5IhKca5psI3gW9ojRxsI8ZjLU00XD83t4gH4BcaB1luflFkh8Lg9VgZVzy+ECz+AH7S76AdMSxxfJKGRkHe9QgxPElQNDNH0vSXuwhDVX/NokNM1QbPPmwbP/rROG0u+6oObr3E5ZJrSl74eKJpnQGLaYGfrzVsGB371MNyKXfccKLz7DYYaBW9kBFnpLYVKsDqRdEAuUcUiPl09RFpp4dMtjqCauA3mVbfBhC0OmZoJJ4SaOIBnJjjm7mQ6LSVXTfIvVli9g1ThEJacrGaWUaXE5SXCth+9TqrUh14Cy/nriaQoB+l5hVJc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80koDLU9lZZG8vCpSWbl3mInBHcQi8DYdV1/VxpK9vE=;
 b=mMn+zcb321fw4bXReKWuTrE6NahXW50/uuIwm5tjQe90ouXby9MqHeQ/P0WTbHk3nn2EKmsGq6DH3oA3MjDybFLx0NaEn09XulYBcNxCIM8iJI1BJ8ClOhLzVrcUfbWUeYjyH0Apc+2SASmc5idn3R+AHrWliGQRssxOSC42iHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 13 Oct
 2022 04:14:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821%6]) with mapi id 15.20.5676.030; Thu, 13 Oct 2022
 04:14:37 +0000
Message-ID: <b0888073-7636-bc8e-11df-eb6b32c0e8ac@amd.com>
Date: Thu, 13 Oct 2022 09:44:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu reset
 scenario
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221013013141.75369-1-evan.quan@amd.com>
 <20221013013141.75369-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221013013141.75369-3-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 450c808c-028b-4e97-af18-08daacd170bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vOdh+KdgntVclNhSF+JdqGiKP4TZhzWIvytThZR189xXzISaziwpGnjNdzU812vGUbxKfiNWu2s2MEzg4ea+d9EAHcuE+5JdAQDPBwGaONfNco7jLU2XZbyq37OtNIadAKzaPaHqOHwyZ47sIhkNYPxAHXJURKEQBqxZsTdg9U8pYs8oh6O1QiDKMfIf+RgkXMNTogeEB+I3P8faxGjBSB/D+QanehN3koWUNZglna/6SKBEzeQTEwMhLEzuFQzig0wThhcaNoV7ySc+nDbllvuCqK/3UHosMPzbD2e1HFIwMBeq/U+sKY2zV5RzgYN+GwpM7QhohzZfi6oU0q6DxaGoRD9lRWZOuLGV0wlzVTcUFkwWIMMN05soSKza34MEiJgpf+D2zQxToqOeKBh/rvdKCwOEmwUGrAtuJQdCCvTwHZQcNGuNIou2IXFxwRtxDsjsMV+Lb+Yz2BavrEBNA54fBPp+1Dy0m40cZMX1ZeTmzhFijGEwm5PG9SlMetAt2sOuYYqxmUMkg9m4m5+hkH+vsKTQJLMi1wB1J6lkn4pRWgtrwtcluGzLXlI+mvITZY5Xb5SxHtM3+UGTCsM2qyRqUcg9LeHVsqq/cYTrhYBgpy+CArIUkS0AghlOIl1VgiPq8DUSYfWdgHX0fdvfqQWWFzYw3gTaZzbWEMk+BrIdViin7xy+K/eAl8K7Oh5fDPeN1LrOOZ253wRmAB+qFi6KsFwqltCIIfZ+KvDbVE/N1veTOSM3fJKtXeQMH+2L3wXrRyR4MF7rvPmTIdT9Q9UoJYO8uvVBQsnP5Vnt9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(316002)(36756003)(478600001)(8676002)(53546011)(38100700002)(5660300002)(66476007)(26005)(6506007)(66946007)(2616005)(31696002)(66556008)(31686004)(186003)(2906002)(6512007)(6666004)(6486002)(4326008)(8936002)(86362001)(41300700001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNtR1RyeERqWVRNVU5qZmQ2M1ZZd0p6RDBHVkMxdGNYMkhaUGlMdU90TGVk?=
 =?utf-8?B?aitQeGhCc3dKMEcreVBqdjkrUXpaUE9TeFV5dHluK1BHajkwcXkrSEQwejA0?=
 =?utf-8?B?am9sMEJRZlA3ZFdzUThHajVoZllEcEdGR2kzNVdhVUtnRHo3QmJrcUE1R0Qv?=
 =?utf-8?B?RGxGdXVpNEtaZHRlbmRsSmRzQW5rNEw5eFpyVjlhbytzZi9DKzNjeFZNSlJi?=
 =?utf-8?B?S2lpeU9tUEEyNEgyZ3QzMzhlb0Z0VVh3R2pKNnkzZHlwOXlsdlhNNmxtNElS?=
 =?utf-8?B?WDRtaHB4bkRtMUlJaUhDUFU0aHlzZ1hyeHZkYStHK0RpQUY4UTNrdDREMzBM?=
 =?utf-8?B?MFZTVmEvYnM2RWY2RHpCRXY4Q0FKaExiNE91QWFqY2phL1NqMlBGcHdIaHFS?=
 =?utf-8?B?QWVsTDFVdWlpVDRTcStsU011QWlXOElZaTRsSkpaYXk1SUdvbzJrNGZ2c2E5?=
 =?utf-8?B?OGVRaDN5Sk9FTVUxb1FWYXhISmNmVTlTcTJJeHJZekxhMEFaRjNXTEtZTW5p?=
 =?utf-8?B?TENaWE1TYXpCQ1VlOHpjZ3lQY2ZKdzNGN0RybTBKb0FRekZjeDJWOHd1ODRR?=
 =?utf-8?B?OERsWFNYSTNCWjNPYVRLOTFZeHdhQ0pCRVB0dkZRRGlDVjMyV3dFclduNmFa?=
 =?utf-8?B?bmM4YnNBbkg0WldseVRGLy91R3hLZmVQbDJlWkRwVFJ0aCtJaG9GbGcxOWhh?=
 =?utf-8?B?Z2VvNDNqdWpONnJHS3A1ckptc1RrK3F1Y05mMjlaTHRKQ3hHUVJNb1RxNnR3?=
 =?utf-8?B?MWJjRTA2T1ZPQkJCNHVZRUxKZExSVFZBUG9qdWlOOFVhRnJPSTNoSEZ2Q0Qy?=
 =?utf-8?B?RDVZazB0djJKYytRQ21PODZvS3I4Tm5ZNURMazd0N0FxT2JpeFRiUmVSR1ZY?=
 =?utf-8?B?d3d3b0FRU2xlZ21PajcxbmdSY0lYUVppdHFDc1NwbnplUnFVMGZFakVnZStK?=
 =?utf-8?B?N0FNWDlxdEh5MU9pWmxiQVBDUiszekROOFZQWkw1cXlLMkVHY3JlT2pwRmdO?=
 =?utf-8?B?YldwVG9maWN0Ym9UcU1qdDVkOU42WkdlekFHeW5hTnFGak1RRTJJekdMNmVz?=
 =?utf-8?B?QmRoZ2lpaExDWi9mQUd1SWpYMkZvczN1M3pLOGNnMHFxcEEwTlVMWFBTZ3I4?=
 =?utf-8?B?a01MOEpacE9LaWxoU1RxbnRWNnd1VTVQcUhVMThiUkYweSt6eUlaNWlwQ25B?=
 =?utf-8?B?YVUvNm95RXpmNWtsZ2VXaVVtRGg0UWRWNVJCRjljNzV2QVc3TXNSbjNaYlNo?=
 =?utf-8?B?WHR0N0hFMEg2dGJhUmdLakhUQ0xlU080dHhORUdQbFQvZVhQeTlaZFJWd0Jv?=
 =?utf-8?B?Q0xKcXFoWUpiRWRoMzVQa21oY3lqcTJNeldJelJhZHNKcWREZHVqUitwK1Rt?=
 =?utf-8?B?UU1yQ3hjalQwT2N3Z3pKZnQwTnJ3ZXo0VlZrc2FnUEVySlpDSkdCWmh0T1ZG?=
 =?utf-8?B?RVNZTG5UajIra3h5a3M0SVJ0RmwxcTBRTHphMmRoWFMvRXMybGFKMUlHTzZy?=
 =?utf-8?B?MURGemhlRkRmbTBXTkJXM2ZZa2t5QVZ0d09KbHB4VFdzTnVBU1Q2TzJhRmFT?=
 =?utf-8?B?V2pIZFhnYWJEOXVnTlNRVFBxMUJVNTNCSWNRSytmdDI5YkhkVmgyaytzeTAw?=
 =?utf-8?B?N2dxTWdaWnI2UnFQRUEzWU1CKzZKZVNXUmxWK2diek9hV3BGUURNM3NaNVV4?=
 =?utf-8?B?NHdIOXZweStXYU93ZndTMkduR2lrOEV3a2poclNLRXV0U3Y4aUNKbmFGU29L?=
 =?utf-8?B?WjFHZEpIbHl0RWFITXVtMWZqU0gwV2dCUitlSGszSGtscWFtYS9sSDlkNHVs?=
 =?utf-8?B?UlUwWnRaL3BKZU4vVVJNQ0wrUVpjTkdlMDNxUDZhNHhJbTNQdVYxenoxdnNm?=
 =?utf-8?B?aFdvK0w2RU1OdnREVjFOUjZTUWZlN3VUQkxPNDFMZ3FzbDhOb0pySXkwNU94?=
 =?utf-8?B?TEUzWHRpL1dqQk1TYU04bHE3MXVxM09kL3ptVXF6L2dEeWtkREhyNEtFWHdJ?=
 =?utf-8?B?VFFPVEdITUtsWXRzZFNodE1aWDd0S29NNGpzR0J1dGVQQUxXTkw0WlJCLzAy?=
 =?utf-8?B?M0J0QTVDQ2MyemU3YkRZVFVnY0hDWklBWlBQc3RzcHNmSFp5KzdHSUxNVDR5?=
 =?utf-8?Q?GEgvOsZ+A1yggihCPUtwDfVhn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450c808c-028b-4e97-af18-08daacd170bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 04:14:36.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WyM7Ks6yXaDz7yjEsSNup+UrIqU2W4qTcM0AtzkRtxRp7/yO82/PmCg8AFd4azI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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
Cc: Alexander.Deucher@amd.com, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/13/2022 7:01 AM, Evan Quan wrote:
> Suggested by PMFW team and same as what did for gfxoff feature.
> This can address some Mode1Reset failures observed on SMU13.0.0.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Change-Id: Ieb4e204c49abd405b1dce559c2ff75bb3887b6f9
> --
> v1->v2:
>    - revise the code comments(Alex)
>    - limit this to SMU13.0.0 and 13.0.7
> v2->v3:
>    - make this happen before display suspending

A better thing would be do
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 8 ++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 7 +++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 +++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ab8f970b2849..874bf623f394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2928,6 +2928,14 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
> +	/*
> +	 * Per PMFW team's suggestion, driver needs to handle gfxoff
> +	 * and df cstate features disablement for gpu reset(e.g. Mode1Reset)
> +	 * scenario. Add the missing df cstate disablement here.
> +	 */
> +	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> +		dev_warn(adev->dev, "Failed to disallow df cstate");
> +

If it's only related to display, you could move this right after below 
line so that headless systems don't need to take care of this. That will 
avoid any special handling needed for Aldebaran/Arcuturus also.

                if (adev->ip_blocks[i].version->type != 
AMD_IP_BLOCK_TYPE_DCE)
                         continue;

Thanks,
Lijo

>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 445005571f76..7d34f40460eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2245,6 +2245,13 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
>   	uint32_t smu_version;
>   	int ret;
>   
> +	/*
> +	 * Arcturus does not need the cstate disablement
> +	 * prerequisite for gpu reset.
> +	 */
> +	if (amdgpu_in_reset(adev) || adev->in_suspend)
> +		return 0;
> +
>   	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>   	if (ret) {
>   		dev_err(smu->adev->dev, "Failed to get smu version!\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 619aee51b123..93a0f7f6a34e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1640,6 +1640,13 @@ static bool aldebaran_is_baco_supported(struct smu_context *smu)
>   static int aldebaran_set_df_cstate(struct smu_context *smu,
>   				   enum pp_df_cstate state)
>   {
> +	/*
> +	 * Aldebaran does not need the cstate disablement
> +	 * prerequisite for gpu reset.
> +	 */
> +	if (amdgpu_in_reset(adev) || adev->in_suspend)
> +		return 0;
> +
>   	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
>   }
>   
