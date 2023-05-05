Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584CDC77B7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 08:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9B410E5AE;
	Fri,  5 May 2023 08:59:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3012C10E5AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 08:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ota9cdgwWuzHJ/vDyougTHP0kynFfX0tCLM8+f9OnfEqL+8Wd1VQorx7SjlN5fVII8+iNcbalxYNtYjy4rABFpQ9V8eKItA7onpqlvn9biv02MPeklflxTzkzuIDCKC+gwyRS/O+qoXtLldZWbNH9lR5dD3Qcn7iHIgwl9M/z1MSngp8xf5KycRAPP6sE5spbWyaeTqSAK45uhONWqAJRhyx95nhGFnH9ELYXbXvKO9U7SbmvR+Bi/nFjMVeEwKjMr079fOQKK0UnXKJ2vsTK7Mp7JqnTFf68vD5QTFHjos2xqzbM/zd/rYam9bcR7hP9BhkTWbzqc3EEstDljYr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2emkjHNmEzkK/KOhO82/7UaZAZQFXmtlGdlDep/Gcg=;
 b=ktBTuDAhEJIqO+4cUHmRvl9NQJRbIYld68Ld6k5VblgONDt0wakGBWwmRsBwaj0EBKHqXCgu6UG4vxztKs3cBo0gPuyFpu4wzqZaWsKtSnaa4Tto130X5LW6XenzsPzUP3BnQUjuAw6iRotPXxNV/ihNvaen9gSSlZn/EqMtQr06DXo9GgpF0UyyFoKGjfUOZLjLdF2fANEKXzsM8BOWQQYSp+y8VNVVV5BiNd2hC7wiTM9q1j6yn0FeaB8kaOTc+uXS5clka1+bZ7GwAAXrZha57gRVpym0cLAuzclGyOOxI+Hm9SV3SVGJwAJHVCqz8FHLQz1YSG039JecL0SV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2emkjHNmEzkK/KOhO82/7UaZAZQFXmtlGdlDep/Gcg=;
 b=1JZLYFDzh0U+0R6dKjRLnID6S+ogoNU4PhskgA7FkJ+LxByhab0gAOQDeHHZUz3mppFDx2WgcYeAk6g5gXA8KSN5ezMAPVrBHu6laSNX6s+OGSv9iNdZLb0EiFvlJn/d4tBmjvIy4EHCRSvhIwgnh2YcQ+0H0fyuAkjTAh4noJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 08:59:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:59:48 +0000
Message-ID: <c2c1d11b-e81f-eeab-68bc-042282d4918b@amd.com>
Date: Fri, 5 May 2023 14:29:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 christian.koenig@amd.com, xinhui.pan@amd.com
References: <20230505082414.1194477-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230505082414.1194477-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: b281d97c-b047-4059-195e-08db4d471403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWIzm1n0PBIBBrPm/hIUHPUz+AaRujJHSqz2t+HewGTzmldPsrfe478f8JiRPwnaz8YQIvwFuGrERCLxLqQ2RSQGApBoxaCL/D1BpG2y/TCFWHnSY07cgWGKP9TYJURLeP/t+FatZzaNKDmQdkB5a4aZ3KViw9uK1cY7yNUMHH8Pz39EgpP/RWtGz09P3So8OEcfzcb1TPXhRnDoePD7h6mBSinoJgTE8zakMsTFPKLgJD5kGwvmpbAuhmF+KNYCu6C4n1xTTffJn0jTJWfVYapUTBYf9TSWNf4e4fDcfQsarbBVLTuy2X0ecCgva3kOxvSsdDGtKLmA2hsy9w0rMVakNhx8g4OomNSs3eRXtZutBSFM/J5OCuY7dwiVbxc0J05G+A5N0mE33jS1ciYw4iAQRmRi085/ogpUDP2jvcA2njsT5w37psDjbd7Skr6mlEH97OesZ0asvxUPcjiVk+5Zs8fbYPJRyL0I1cQIEiGBAP31r0AiA76YPnBLzz8mB/7CAXvWMMUqDkf+woVCOW8Sz2+MzdUdvaslRfSQ2Bj6MpdOn29nbc/ay8eB30vIK78xPISdEQWCQB/vCbJte5iHaKiw15Bd2lCCQ4FfrxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(41300700001)(478600001)(66476007)(66556008)(66946007)(6636002)(53546011)(6666004)(316002)(6486002)(31686004)(8936002)(966005)(5660300002)(6506007)(31696002)(38100700002)(86362001)(26005)(6512007)(8676002)(2616005)(2906002)(83380400001)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUQyUG03eStKQUdRMjYrSGtPRFIvQlB3Ym1JeEcrbTY3eDQ2QlU0OGNabFlK?=
 =?utf-8?B?MUVUcENvTjZrdFVnSFQvbWFDM2lSZ2x5TW9WaXVWczcwMnd5QTMxU0s3SHZo?=
 =?utf-8?B?MW5YL0FaOVVxbXVtTFBlQUl5dVBzcnM4QUpLSERtc1paYVU1T25IenFCTFlB?=
 =?utf-8?B?Q0c4bzhWM1VyY1hhcXZyT1lYSWF1L2pCdUt2S2dsUWZrN1dzUzAzSDRvMWNn?=
 =?utf-8?B?aUt3enBadG0vY2RXOWFQc2F1TU1sY21jQmZuUUg0OHdjZlJTNWdDTTYxMEtD?=
 =?utf-8?B?WHpwRFVJTy9YSnlkYWpiUWFpdDlyTFZmN2dVaGE2ZE1hUzM5NUx1UHpObXl2?=
 =?utf-8?B?WUVmeitiSDBhMVdZMkRHdjdQYUZTWU1hTWFmYWF3UXFmWXUvYUF3NFMvdG1q?=
 =?utf-8?B?ZnFsODFDWnh2TmU5YXZJZXNvRFZRTDZWV2JOdXk1aFZwRUlBZXRXWi9VaStK?=
 =?utf-8?B?T3hCQXpHYlpoeitIaGRuUHJnUVRHVThXdUFteUxVcHEvZEwzOWxsY0lISWNF?=
 =?utf-8?B?NUY3UjNmdTY2aWJ4THZIMTJFRjNxand6eURBWnd3bXdqMVI0b2xhSUp5T1NJ?=
 =?utf-8?B?SmtNejBiazBMOUYyY2FUWHdmRFRWOWNieUt4NmRRZklEMDhMazA0d0o0akdY?=
 =?utf-8?B?bDB4MjlaY0tCYXdtSXR3WnZXU2M3VmpUNzdGbFFza0U2cmF6U1BlSk81czlF?=
 =?utf-8?B?NElRQUZqNzZWUFdCa2JvL21PRmM5QThLSFhsaWN5aU1ySmlwVzBrczVGd0I1?=
 =?utf-8?B?OE9tRHc5bzlrd1QzYWpodHpPdkdXMzY3bWtESlM4WU9LdDRhb1JZQXdYNU94?=
 =?utf-8?B?ek9SWWJmc3UzQ0htTG9MQ21lYzZ1ajN4eHM3U1BwR3RHcmtBVFJwL1NBSDJU?=
 =?utf-8?B?SzBxeEhUZ2c4R2JtelJtK3ZmYlVnWk1sd1N2NG9nU0hCRXBKWlZySW1nbEZU?=
 =?utf-8?B?Q2szV1labWFSTkJqTHZEUVNBSFlHNGhlaW1MeTJWSlJ2Q0RabnZBQWhUbDFm?=
 =?utf-8?B?ajNOVzNnbFEzSG81RnpXNE9aV0Qra0ZmMnMxSGplSG5paC9wQk9vSk1zbldw?=
 =?utf-8?B?clBGT3ovT0ltSm1MdktZLzA5bVh3ZW1WMWNxSUg3dXdBNVpPUWVYUnEyVkV6?=
 =?utf-8?B?eFdueGFSdEUxUU9HVUJSMGU2MmQzMWpDS1J0cXV5MXk1L01ZcFJlVFpwdll6?=
 =?utf-8?B?QTBMdHhuMXh4UFdkWE5pamlkRmlEU2hTOGZZRjRHcmdEQ0J6allrRWdqV3M3?=
 =?utf-8?B?NS9WYUQ2SGhuOUZKZ2cwaGVpWVltNlY1V095Qmt0ZHRsYWVMUzZQVENhdGgr?=
 =?utf-8?B?MmZYTjFFeG5KcW4rK3hReGI1dVZZQnB4Vmw4M2ZJcGVsR0FPaFA5ZkgvVndY?=
 =?utf-8?B?WVU0TW9jNTFKc2pKWDlpbGRWcDNpalUwcDUzSmErdEJ3TlpaNHZXVWtYUDhp?=
 =?utf-8?B?UHJ2TUo0UVllQklXb25qY0tPLzQrME1uSGtQQmIrZUZOR1BsN1RQSnd2WFVh?=
 =?utf-8?B?Qkl3d2dnYnJrMUxxN0xKZ21TdWVycXhCVmdwalN4MCsreU1TQXIvTEpZbzI4?=
 =?utf-8?B?bUFlYnpmM3hwdTN2UWpoVjJSaXdSQ1hJaWZPbHMxaTNrTE4wS1Vwb2F1ZDVm?=
 =?utf-8?B?VmlZSmFCMHV4aDlGaWFCRDJFbmZQZnNYRVFLR3B6dlB5S1NXMHlZVFlEQS9z?=
 =?utf-8?B?TFNzWHIzTWI0NzJvOUhES3FOamtEc3dsUGw3UWkzQWwwbXN3QjBMUjg2Mng4?=
 =?utf-8?B?MTNLeThiZFM1cGJ6Y0JkMzF2WXlvck9OdGl2VUVIaFJRRHFOQnpnN1VWVEE4?=
 =?utf-8?B?QWdScEtsRkpXU21jNEhNNk5pdFJLYUx1YkQ3dTAybUVMYisrbjFSTXNaY09F?=
 =?utf-8?B?Y2htczVDUXJWUm93ZVdOc2tTMnpkc21IM3huR1N1bFVqZU5GVjdMU0tmQytC?=
 =?utf-8?B?SXk0ZHN2UUdnZmkwMG02M3BScXl4OWorTE1BdUhpeHhpSVFIcUZNUnE1WmFG?=
 =?utf-8?B?MVh2TFY5ZFFaWll5MGxUUGRVa3V2QkY2QWNkdmgrWmo4MEdDWmxqcjlDYlph?=
 =?utf-8?B?U0FtaERlV1RjcHFTRGFURFdzMWNmUDJmTlBGYlZab0g5aUI1THVtSGVBWkRh?=
 =?utf-8?Q?AKfyDH/NwHECmvrnQJ3HCDx05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b281d97c-b047-4059-195e-08db4d471403
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:59:48.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LEYdxuRUpLi87uP3p5OWKNT67gGxYgDsRH2RZjiJ1yKZPopM/XFZ851K41PkCVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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



On 5/5/2023 1:54 PM, Guchun Chen wrote:
> amdgpu_dpm_is_overdrive_supported is a common API across all
> asics, so we should cast pp_handle into correct structure
> under different power frameworks.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
> Fixes: ebfc253335af("drm/amd/pm: do not expose the smu_context structure used internally in power")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f0068df2d073..ae45abeab5b5 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1455,13 +1455,15 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>   
>   int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>   {
> -	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> -	struct smu_context *smu = adev->powerplay.pp_handle;
> -
> -	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
> -	    (is_support_sw_smu(adev) && smu->is_apu) ||
> -		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> -		return true;
> +	if (is_support_sw_smu(adev)) {
> +		struct smu_context *smu = adev->powerplay.pp_handle;
> +		if (smu->od_enabled || smu->is_apu)
> +	

Minor change - return (smu->od_enabled || smu->is_apu); and similar 
below for the other check also.

Anyway,

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

		return true;
> +	} else {
> +		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +		if (hwmgr->od_enabled)
> +			return true;
> +	}
>   
>   	return false;
>   }
