Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90813C3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 16:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63AC10E113;
	Thu,  5 Jan 2023 16:12:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC8110E113
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 16:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzwdryTa/2qWZRZGXveZvOy8mmeeF2q3fVba5VNwwhzGMRug56Zt4jzPneOm0GJnwArFZ7aWGniKKLIPlqWmJcn3qIWrBvv4MBsxbAz2y7QY9ZOFp2CmdkpD/FRHsYam7DunEklUq+Z9U7FvRk4PiW05WJYoi7cc1lNUaVtw6VouRgC6/wsmQn3Qjk/muDnv3/7jwRMsgDaQHunseU8mYR3kvSGcGFeQ5xBNDm/HYKzgcB7ORc3czlpK8+liorameScg+vzep8+hNX4Zqkvbw80dr4LpVBUcm13wFZ4K3ERWZ8kFnMELzAq3H9Jy0JxCqmlfhffv3j/6lya9E7lt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL+gjlUnOywBmHOdP5FCEqiaEkXLgwmP21PzxB/7LX0=;
 b=YYDG7pcZJDI+slTNOB+kMnTcrhnEuITKSkKa1vIG1fdo9ypkeQMIZx+axv+Ocv8HvupMJr+6Wln+wmcMujcw6hOCLo1hTQT+/FXL2rb2XGXC7bFoCXkHBu0gm3CFe+eGXxWRO7ogiM9Xz6vuPA+wT3EbJJBeCtyqOvpep0XsBw/24joxMuaglm8EgEeQo+jEF7Bbv9/WdMG3C4sSdOFDuNGOOJD8+OvW9xYn2EyvmwbclMYEqZGlw5asRY+U1U2/zPagopivwLJaQ1LQGCim93jcswNcNpWfBAReDFt5dU8muac1L7wEXoGd9uJBgWdZZhDCgOQCA3LWpNDjMvd1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL+gjlUnOywBmHOdP5FCEqiaEkXLgwmP21PzxB/7LX0=;
 b=Db4pNT2dbskpcu8tlFP8Nt/T7KCoJoq7PqnSCXcfiL/Bqq7y0kmQDt0fTQRvWMGheIaI+xWE3huZncjyhVvvEMtIQt+p632oS8Oui0oVZXgzKLunbGuJR3aQt8yw1K0P6KeQyG5JaNfG/tKzErgoAIpSQNATtvIwGq6jJBguCT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 16:12:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:12:13 +0000
Message-ID: <7f990e92-e30c-86c7-0d8a-555bfbeb5eb3@amd.com>
Date: Thu, 5 Jan 2023 11:12:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drm/amdgpu: fix missing dma_fence_put in error path
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230105111703.52695-1-christian.koenig@amd.com>
 <20230105111703.52695-2-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230105111703.52695-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e29fdd-4555-4ea9-da30-08daef379b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa1wB4uln/ptpWdCHJFdAOWgvk84OaC51qIZJnZkVRHj9nwf4z5Oo/c5DEH3zTG73lOeERTOkUacNLZV+ExasIi1XZ3SEyPlztGk9RF6gLLKZbnr5qG5mYWpS8Jsp9VKiO0wB0/u5d7QRXqLNC0O+JAm6Nu0e6dkx+mZL4G0DCDRFnMrhZrH/JfZgTR9ee7EzfDIPfaxGjtYlM/rlIiAhTcMEm54LYL3N33tcxCCxKPRAQw6/yIKW/cKYmLwmQwWnpKvtHDa4ly4vHrgYghuPb9EjKo/L2h0lp86a2OUvLCV7zq3E47vXSphFzIbxSU9ADRrpYMriN41XmKp17IZdWXwZxksa2KMwkZ1eSB4zecg0gNS/5yGfrYN1tscFFgVFnmso4yRE0kvBSDBEPF2ocZVXyeYBYGKQSUFUP3YAgIpA2IJNC86e1FJsgJE74ZhEeMx8evCHwAvJwie1vo2MYyt2HnS4QNDqbvCr4+bOJhdVWGKv9ZRz2KT8xCEXhYx/qMJYEIqUCjLdplUK4zPhV3+F5WULJes/YvTkWTWA3ngP5tlp/rWIEqIxuE4ScnFPc5cd9wIp8vTPpaEL3Icqubv6DGn7f2AvWOBftp+9zw4dCdESJTNDYWhn3U6j+IjgBqHYlHrm4nlLXdeKcF/jcaB7oZSiW8nJAUdImPhpvVSJT3WYeeZ3Qc9KtFbfVISgfhwFmlGQiTnfu94V9ye0kqZz7J9BcG3zRxlYYLEY6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(83380400001)(66574015)(6512007)(186003)(26005)(6506007)(86362001)(31696002)(36756003)(2616005)(53546011)(38100700002)(8676002)(8936002)(31686004)(41300700001)(4744005)(5660300002)(2906002)(44832011)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkYvZWRKaGx0cnFSV2EzZS9BRUovTFF2dGN0Yi9zYkd4R293Tm1XRVVEMTJl?=
 =?utf-8?B?OTFQN3FJeUlEL0lnUFVBdzRzRDNXRGtWU2kzU280aGRtNE9ENE41enBaa1lU?=
 =?utf-8?B?SVdUaithK21lNU9yNWFPbGZBSS93dXlhcmYranZpQlhtWlJJQTVrbGY5dTZP?=
 =?utf-8?B?bVBvamo1WDZhelg3TG1tQzZONUFhU1E1RGpySUJEdFFjV21qbE93QTVkMXM2?=
 =?utf-8?B?UjIyOGUwYTJaUVVuQVFEMU5NMHhaNnprSXZOSEEvSWVBNElBTHJMblAyQ3Fx?=
 =?utf-8?B?cnpieXo5SVY3akRBRFJ0ai9GU1FsTCswTXVQc0I5dkFIQUpiVThaUU1pUlFE?=
 =?utf-8?B?dSt1ZmtSWkRpVkZuNW1jV01Td0piS2RwdTNsOEx4cENVQlJGSzhlRC9IRE5F?=
 =?utf-8?B?cnRhV2diRlVFNE50N01GUk44YlQrZkJZSHhWVUV6ZkpXNGhYR1pFTk9GYjNP?=
 =?utf-8?B?OVVuOXJ3bDJhd2pTcjlXSlJJY05RNTRrSzJZMHF6eGdsMUp0Y0JPZXRzbnNO?=
 =?utf-8?B?cExSZjFaWjh0U1FlMkMza080MXVuVExjTmE5SHNwMUJ2NFNCbFZDYWdxMHRN?=
 =?utf-8?B?WWI5eWc1N2k3Qm9sTjgrOFQ3QWVqNlNUWXBJVkZ3cjFyczI5dmxYSWZXVS90?=
 =?utf-8?B?QXl0aml3Z0VacWdWTCt6ZUhockdidXRoWnpjQlAyVVdlbXdXQ3d6REppTnVv?=
 =?utf-8?B?MEt3eUp5M2IwUGZwUmkxTWVGWkgySFl4VmpuSHZFc3ZOUnlKd0pQYzljTnFW?=
 =?utf-8?B?SVdyQTVmQVBSWEtwNG5EK3kxTzlTakRRZlo0dHcwanJ0cTRjWXNrTXJ1RUZB?=
 =?utf-8?B?RkxOOFFTY1Bob3BvNUpxZkVBMUp2NGhQTS9YVjRLUERYL0k4WHU4bXU0R25W?=
 =?utf-8?B?eHNCNGYwK3R3bDl3RnJ2cFE4NXlCTHUxQkNoVVF5cXo4K3lCUzFDZnkyR1Fi?=
 =?utf-8?B?L2dWYUl5KzAvUEgvZVROenlBZ3hZMG5WaU1KK1pVMWJVNWNMNG5Tc1UzT3pt?=
 =?utf-8?B?cys1RlhEUWJLQVhlcmU5VkRtSjJzbTJJc1d5dmc5VWFDODVNYlhTYVdhamh2?=
 =?utf-8?B?K2JzVzJjSEFYZml5eWZ0UmMzNnAzUUVnQUs4TjBWaU5BMGdzajFSbXREUXZ5?=
 =?utf-8?B?MjlmdkVCWW93T0tJMFVGU3JiQS9zc24yMTlVbHNyazJnd3NuVEpMdjBLQjJL?=
 =?utf-8?B?NEZ5YlAzWmRsbjZZbERidVVLbkdnTUJFWmlKdzdDdlg5dGVCY2JkQjM1R2l2?=
 =?utf-8?B?TjN1cVJkbFlzVGtNNzFYdERBOTRkbzlPempqWkhQRForaVdqYkloSnhZaGFs?=
 =?utf-8?B?Z0wwdWxodklzQk96eUZpRGZPbU4vREpxSStyRFNFWjNzbkxlYnV2QUZDaFZ3?=
 =?utf-8?B?SlBkVk8vbS9aRkM4dHJzcERYV1huNE5aSDZkVm9sUGZTcFRuRHZFRUVOa0Ns?=
 =?utf-8?B?TTY1dHBaZHViWkN6aS9NZ2c2ZmNSWUNJMHkxcHNlL002MkcyMG1paU5jdm9E?=
 =?utf-8?B?MW9uc2ZMM3ZjWjd1TGh5SU5MRTlBTTg3cWxGbzdYbWlwZmhmVUpudlcwSUE3?=
 =?utf-8?B?Rm5IN0d0YXhzL0NmcHJCeWNnTjdsU1hOcXVCcXpNRmFMUWJjTk10OE1ia1NZ?=
 =?utf-8?B?Z25NajM0RmVWTEF0RGNMY1ZDUnZZbE14bXFOSm5WOEkrVDJIdExhZjZCZElP?=
 =?utf-8?B?bDRBbzdwSUEvTTlCLzloVitYdVZ6Mmg2RFUrT2dGK00xV21UckdsQ25memRh?=
 =?utf-8?B?Sjc4ZnBRa0V5aHhrQTlPTXc2Y1FaQmVlMlMzQ2xrZFlCeVBmaUJUVnlJN3Vy?=
 =?utf-8?B?dGNKa2VvMXk1UDlwR2txbjVDWjN3VXVoT3pIS2lRb0k1TDVnZFVVRGJTMzdy?=
 =?utf-8?B?UnlaaWViditZUkUvdUY1bXJIL0NlM3AyMktlckE1SDJHY3JvNnFnQ2xqWEJm?=
 =?utf-8?B?K2hWb0h1WmQ3aHVHdkswRzRaOFgxQzVjdEFOblZxS2JzeFpqSTJYUUhHenpV?=
 =?utf-8?B?bTdNbDhtcGNYeGltSFBRUXp6L2tJMFhkZUtPOGNWL3pBVUIwZG1GeHNsSDdK?=
 =?utf-8?B?cmozYnh5Y3U3VTl4QVpCejBDNDd3OFBWbDFTSFhWc2ZjSERRUm81VFh6dEFL?=
 =?utf-8?Q?TyXPYynYnb8GPGgcThs6miRGT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e29fdd-4555-4ea9-da30-08daef379b0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:12:13.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQufemtJQaTZQhDsBiBbXeLYX8LwOkqBJc6cV64Qtpu57kkUuy+6N7TAC1TTKxAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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

Series is:

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-01-05 06:17, Christian König wrote:
> When the fence can't be added we need to drop the reference.
> 
> Suggested-by: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index bac7976975bd..dcd8c066bc1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -391,8 +391,10 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
>  
>  		dma_fence_get(f);
>  		r = drm_sched_job_add_dependency(&job->base, f);
> -		if (r)
> +		if (r) {
> +			dma_fence_put(f);
>  			return r;
> +		}
>  	}
>  	return 0;
>  }

