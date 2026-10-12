Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA412CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 13:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584A710F0F6;
	Mon, 12 Oct 2026 13:16:25 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A9210F0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 13:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI29vGb/R0eaFu68jXqZFR707IWJV2+LFceYhv+97pqZl6K0/oRDrlJNxAmLzQ4G3sM8j9FSJelm93AYewHKKJy6+athCXcHnFdcCw+7w4DAWT08uQrKqQwq3A3RB0Ro9Q1tSLl93m20NFGEQoKkLoWr8v9VmkZ6Mw8N8EStFmfDnOemXMIU8p04RJIwnX7ZTOIbHTkvOMztrfpIW1q+O24qK3ux6Qw7TnJZguQGrmen6tn3lu5LJTi+pmkzP6EFB4MJRvovSyN2dm5a7k6Z1ZDwaTsdCiSf4h3RMMuFrD67w1zSP4HaCBNoN/Sg1EwWmtC7Al3fS+Z+W0M9D21bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NuwMPYdWHdUAumJBb5ZMZEiLRsB68VGSy5AodBtC80=;
 b=HWl28Kqinv0WnJogmziqWmHv7KYS+dNn1MRYEQwmEXDmyliOcKTemOIxHuaOwDVXuieURNC2+DwN7Dzkp09S0Ti/zoslC+crIB9OIyWkbcIHKrA2hbcbh2YsDMDtlCk8qzFe6jz39vgTZ46QuF1MyaVB7UHyp2E+xvwarnjMa7eU16SG5cbG65HNuSOfNsZtNt5kGAMi8yhnLDkEwfXPN3hg1OROscnmvCCdGlFWiy4/KoPcwQ6CzwoFAg4r22sYc9KPm349w/kTPTqsFjqedfYL4udwpJYS3wInc0hNRf4L49AHBerZlRVRSijMPPaUnpOVtpBLPe1IgB8bYs/bkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NuwMPYdWHdUAumJBb5ZMZEiLRsB68VGSy5AodBtC80=;
 b=DKo/03qyeyjsoy7IXvjkJCSFpq7i5bSUwzki5lfuL031qQyYyM0wP31UfhUef1kcA8ZKBStAreGgewhdfxGz8/jM39Wb78jSsk0FH6hsAGqPqa2npLN0dTFLGlnVqH4F98OLECsllQkS7SttcN5yTQ+2/fGxUjUa0WXJzmbzLgg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:14:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:14:10 +0000
Message-ID: <deebd5da-c01f-4a7c-88c8-f47201646f2a@amd.com>
Date: Mon, 12 Oct 2026 15:14:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu: Add CWSR userspace interfaces
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdfd948-2e63-48f8-2dd1-08df2862b437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|260925021911599003|260925021311599003|260925022911599003|3023799007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2sguxe9cql2O2GzBixXf7Q1UU+kja9v6H38K0hz67jLZzM+0nt6w2dE2hhBhNEaTiD+QYEyN72J0j4bYGl0EuF0gidohPkR+fEp4C0BzezarEvBsfYjkIUbxc8/lpB2a20ipnAiH3XcwRbtVMnfJBVrkNSjjcvn6fwMw+xxeU2shE9PPB5OxUhdfnbuwUZI8ra95/X9Dkst8M7i1YU1xvylw6/hWqz65TVGSaoXwStVGs6VtOMKo8xrn4NWg1hCZxM4BaBkwNR2Wg596UMEWqyJajVGPOSZvzbw8g52GD6XbHcNc4ngwKxLicISJ2E2evffPeoaO6/OKRoJprF9bZu6bAm2TV0Tv0Q49QQoyibi2qMeHPDkAVjbsnXbmlDDM/GAvLFNoLSNqAo7DsLA1oTllNHPvtUh1TEwpsobpUAT5mRosuBnJJAYKZbIpUIf5D0r92coiOsyMA3jO/rihnk4ahyeF+EgDIoE4urQL0v6CH9KXmdlx1KVBJEBPeauAADWrx+Hzy/jpViIWbNL4EfNPb8bVwLbSVULJl7AY9kEv20Dl1DhzOmVvzC53TKuh+Yn+5cai05SOlaYwUHkoereWrnJpz0C8VxwlerMRYvKgsvpk9ZPJdI23XAWUJHQ8KNjnnzhrx+YMOaDOvuaX/KaNCeAom4tVAA/0GczsxOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(260925021911599003)(260925021311599003)(260925022911599003)(3023799007)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czc3ZEZNVDF0UnRJRFB1MS9GaWZsWERSTEpXMWRpVlhtYXZVY094VnVaV2N1?=
 =?utf-8?B?RjJPRDFoYnN3MjdSbk4wWks3YmJPOVY3Q0RDOHQ4dkZ1MHdpZktheG5FYVJU?=
 =?utf-8?B?bDlnT29kNmJ2UGlxTVlLckd4Q1NvM3I5c2dZd2ZyUXJ0YkFMeXZQZ3JNYWcw?=
 =?utf-8?B?MTJtWXlvYTU1em9rQ3ZtQ0tKRDdpc2dxNDFSTGFkSjNmMGQ0b1ROcGpsV1V4?=
 =?utf-8?B?b25BMGlqVm1iNmJBZXlqQWE1VWlTakZIRUI3UUpGNGVKYUxCOW8rNmN2aEJX?=
 =?utf-8?B?cUJra0t6VEx4WG5pbE1na1NHRUh3UmRxUERyR0d6WmxIV1Q3eHR5RmdjVzFs?=
 =?utf-8?B?L0FTc2VnWEduRWZUWk4wai92elZaS0dPcFlROERMYTNncDVqYkJNM0I3eGlR?=
 =?utf-8?B?cjk5WHhhMHRHTCt6NVpmUW1lV3F0M1VMS29hV1c3K3Z6K0Z4b2FxZ1ZtYU5h?=
 =?utf-8?B?TnFJRG1mWCtGbTBHM0RtR3lCckp4YjlYZDF0YjBaVHR0dlpQN2RVL0o3ajMx?=
 =?utf-8?B?Q2xmMEVqZGc1S3VVM0l5QmpvMVlOY0xuT2haS1U1SktsOWM0Z1RyMG1YZ2lR?=
 =?utf-8?B?alo5REo4NXZ3Y1hNcnFpMmk2d3VFSDhJamxkMXhXMytzajhxbkQ5ZFJtR25v?=
 =?utf-8?B?OWRPNU9sbDRPNGFlWjdza1JxVlF6cWc4Qjdlblc2UGFLTEJkd0xXSlVXTmVk?=
 =?utf-8?B?Vy9iV2JvMzFhR0dGNXhkYVZ5OHRYNUMxdEVJTnBwVE9Rd21sZXRoUUdkZlBC?=
 =?utf-8?B?MVFjbGZsNFQvSm5iQ0hjUGM3eHZNTU8wRXpyUTJwdlh1cFZGMmVCUnozU1Ba?=
 =?utf-8?B?bkpMOTFEWFVreE9wQ3JYdHVPbXc4VnR6SzdoUkg0Qko2RlVnSzhZYjdjY3dP?=
 =?utf-8?B?dnR3bG9USGFtdlduQUl3SGxSbjNIcUk5QlFNZzZTTzVnTWZGM3FoNjQ1ZTNH?=
 =?utf-8?B?NkZ4QzRldEJkeGtNYS83Y0hLanltVUpLK1dLQWhCQkNoWUxqeHNNM3dvM0Z4?=
 =?utf-8?B?WVZLYkNzdGxMQVNES20xaGFoRUhsSW03VXFwZWRUYk84K1hjaHlmVjR2RCsz?=
 =?utf-8?B?UStQd1NTTkE3ejE4c3BIUUZMeUhiU1dCMlBML25lUXJRVWtrOTlDWlFadjhi?=
 =?utf-8?B?eTNHSDhWSFh1d0lNRjAzSlRxMTk5WmRkdDdNM2gyV09ZZHJHT25NL0NLclp1?=
 =?utf-8?B?a1JIa284Z1lqbmx2V3FrcUtjMkNkdXdyMGdtMmV3K3JkVzBiUHppZHhIS29N?=
 =?utf-8?B?ckp0bzRqaEdPOHA5T0hBbDV4TVhyalFFd21FVEhEL1hWck91ZjFHd2YyS1VH?=
 =?utf-8?B?T1g2a3BlSTdFTVljUzZRRm1GT1d4SFcvdVZmcG9wNnJJSjBOU0pSdjJmVGNB?=
 =?utf-8?B?MHZjSng1ais5UW14K3dBZ1U1MjI3UE5MVW9xQXZGZkV5VytRV1MvNEU5K3dp?=
 =?utf-8?B?Rmk1VW1VOTYrdUhpZVFjZTJub1BHYjZMSEtMb241S1pvZk9JNm41amxyb0Jz?=
 =?utf-8?B?NEJrOEVTVmtJL1Raa2ptU1N3VlhKbkI4U210dzhESlRTYlVuSjljNWplNnhS?=
 =?utf-8?B?MHB2QmlUc1RtZmNseTgxMk9OckpBR0hVRUY1YjUxZUxwdFNrLzdJWUlSeisv?=
 =?utf-8?B?OFVEbkhlcmVZVEhZeTFzRXlneWUxcDZZOHNtSnpLQTJ3dXFwYWczbnVGUFBY?=
 =?utf-8?B?YXlGOTFYLzR0aEV1c1V5aW1xNFRVcURpeFQ3SlRwM2VIRElWVE8rMUNZM0FO?=
 =?utf-8?B?VjhJUnJxTUZyU2kyV09VYkxxb2RyM1ozdGt1T2tKZFR0QkpkL1VqL2RpU0Ji?=
 =?utf-8?B?UndDKy9YVUxwcSsyUHNLeHJjS1NZNS9NUU9xSG9PN0c2YlpJUStEZGpPUWs2?=
 =?utf-8?B?VDNoQldBMDBWUkxZcEl5aTZPUmhkS0pDMERmdVJ3QTE5SVlETWRwUzl3dlVu?=
 =?utf-8?B?ak9Lbk9YUjkyOVMveEJLY3pua0xQNnkxN0xuSTZsM1JMWlVYV2V0dWhoTDFB?=
 =?utf-8?B?QytDY1NrWTB1NTBBSkZyQ2xVWHJ0ZWFjYi81S1pHMUR4SkpnMVFtNzF5UHFP?=
 =?utf-8?B?d3RzQzcyanVSRm0vMEVaaTlUalM5dzZtTHZ0dXBxM2orVDFsNlFCNW5nYXls?=
 =?utf-8?B?RkpDZ2xpR3RaLzZBekRtL3N0TG0wRVBYdXYwejdvNnJkekJZQm1BREdUaXhQ?=
 =?utf-8?B?Yk5qN1FrWTR0RG9pdklqdmtIdzBZUklHVVhUUnJSWlNweW9hZmg4OW5KM0ls?=
 =?utf-8?B?aGVGRnl6bFhRcURxRzNNZTFmQkpGMVQ2cXNpeUMrME5nSzNIWHN0d2lkYnBZ?=
 =?utf-8?Q?tz7RAeGOPhr40g523b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdfd948-2e63-48f8-2dd1-08df2862b437
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:14:10.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC2KtauLIMiUKyrfPgvoLv91GTw7oNHezIb5evDSM/e0vyv1IPma6ab30QOjxWQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Add an ioctl to return the size information required for CWSR regions.
> 
> Add CWSR parameters to the user queue ioctl so userspace can provide
> the GPU virtual address and allocated size of the save/restore buffer.
> The parameters are supported for user compute queues.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 21 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++----
>  include/uapi/drm/amdgpu_drm.h              | 27 ++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f3945b3988d8..147c0bd02731 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1429,6 +1429,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  			return -EINVAL;
>  		}
>  	}
> +	case AMDGPU_INFO_CWSR: {
> +		struct drm_amdgpu_info_cwsr cwsr_info;
> +		int num_xcc, r;
> +
> +		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> +		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +			return -EOPNOTSUPP;
> +		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +		cwsr_info.ctl_stack_size =
> +			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +		cwsr_info.dbg_mem_size =
> +			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> +		cwsr_info.min_save_area_size =
> +			amdgpu_cwsr_size_needed(adev, num_xcc);
> +		r = copy_to_user(out, &cwsr_info,
> +				 min((size_t)size, sizeof(cwsr_info))) ?
> +			    -EFAULT :
> +			    0;
> +		return r;
> +	}
> +
>  	default:
>  		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 3b7a1479fbf7..5311e1ad0201 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -461,11 +461,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>  							 fpriv->xcp_id);
>  			cwsr_params.ctx_save_area_address =
> -				userq_props->ctx_save_area_addr;
> +				compute_mqd->ctx_save_area_va;
>  			cwsr_params.cwsr_sz =
> -				userq_props->ctx_save_area_size;
> -			userq_props->ctl_stack_size =
> -				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +				compute_mqd->ctx_save_area_size;
>  
>  			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>  			if (r) {
> @@ -480,6 +478,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  				kfree(compute_mqd);
>  				goto free_mqd;
>  			}
> +
> +			userq_props->ctx_save_area_addr =
> +				compute_mqd->ctx_save_area_va;
> +			userq_props->ctx_save_area_size =
> +				compute_mqd->ctx_save_area_size;
> +			userq_props->ctl_stack_size =
> +				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
>  		}
>  
>  		kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 29009f6aabde..9317018330ec 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -470,6 +470,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>  	 * to get the size.
>  	 */
>  	__u64   eop_va;
> +	/**
> +	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
> +	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
> +	 * to get the size. This includes control stack, wave context and debugger memory.
> +	 */
> +	__u64 ctx_save_area_va;
> +	/**
> +	 * @ctx_save_area_size: Total size (in bytes) allocated for save/restore buffer.
> +	 * Use AMDGPU_INFO IOCTL to get the size.
> +	 */
> +	__u32 ctx_save_area_size;
>  };
>  
>  /* userq signal/wait ioctl */
> @@ -1289,6 +1300,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT			0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS			0x24
> +/* query CWSR size and alignment */
> +#define AMDGPU_INFO_CWSR			0x25
>  
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
> @@ -1668,6 +1681,20 @@ struct drm_amdgpu_info_uq_metadata {
>  	};
>  };
>  
> +/**
> + * struct drm_amdgpu_info_cwsr - cwsr information
> + *
> + * Gives cwsr related size details. User needs to allocate buffer based on this.
> + */
> +struct drm_amdgpu_info_cwsr {
> +	/* Control stack size */
> +	__u32 ctl_stack_size;
> +	/* Debug memory area size */
> +	__u32 dbg_mem_size;
> +	/* Minimum save area size required */
> +	__u32 min_save_area_size;
> +};
> +
>  /*
>   * Supported GPU families
>   */

