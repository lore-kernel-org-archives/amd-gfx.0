Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA23C43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 13:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DF910E985;
	Mon,  6 Jul 2026 13:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N1VLd5Nq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414B310E1B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 13:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMEH7VKhoqU9Hhg2FPNL8WikPNIlNs3w29kaowQtLE/KymLtNWk6gEnDwsdOVp0jyc3pAzyP1NA3dt2wdm3/nWK7wTTwOjQ45CHTvAX1d5Z5LRR08bunGy+By/Bboe8wY3SOp1gL5t/F9BDk/u0dPWVFPiqBVrnBePYSrnFmKWh5NR40cDWofFAZ9g6/JtJG+6JuOcDPk9PzgvWzS4KeYabzd6eWkkb/ki/7kxxUavQuJYHCZG0ePVXwpq1WC0qIFZ8/miZAnL1u8hJvNP+mAUvX2ECXBclEhvC3mHtmbH6u27f2lk+wBPvDlbxJR4DGHp8WwAwOSP4Zxz3stP65EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKMK5+vtwVuGmUoEiBEFC54fu1YLwqw0PuEJmbGx2FE=;
 b=rPr1MzZRNyp38lYDPDyUQIA3KQFtmPoiJKox97bTwpzbCJzhroChBTnmZefZDCR64fuEvCUdQYmpehiWiQf7KP8eYjuJjRSx4bjDI+A+zuEOTq09SzeauOEBIFwcfaZsr579e8iQySfqsR+5O2wnXRmCLroPC7GboLX5mcnOQJRMQOyJYH47KJYD+dOr7cIUYo7TSgoq7VpDrtNv+YL0tglA6Nxxv+EfQ7HbGbptuhKbZcix8Q8XrJzhlIzRpAcidbzyzbvrMZi5zK4m2eQjPHPM/7U0GbXMu5BAAVF52Aj+ejvl8beRBRDyvDUuLjjodjfhyWcxezRmLs0HVUCDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKMK5+vtwVuGmUoEiBEFC54fu1YLwqw0PuEJmbGx2FE=;
 b=N1VLd5Nqc/I0wD8PdRLQ/mPjgMDO82PvVJom1wwu5qbHarv1acyxBioDFiPn9XPUXyeFI8eCw9stPtiadCvNF1Hxpvpf4fyGx15z2TIKSvh3LfZ2L8NXibwy+yVKMBUcVC8xZUAixf+it9Xmr7VQp1NPhRZlb6twB0DYVucYk8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 13:00:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 13:00:45 +0000
Message-ID: <d14e081f-d0b0-41b9-adf2-f7a914449812@amd.com>
Date: Mon, 6 Jul 2026 15:00:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix lifetime issue of
 amdgpu_vm_get_task_info_pasid()
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260706125856.634904-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260706125856.634904-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: d5641892-e6a7-4c74-3fc8-08dedb5e97ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sOCNsC+4Hv6tMwBLKfllvmcilchrE2wcxvD3gLitLFbIcbsncoMIYbX/VYAcBPVYJQjv8svqMiJmWqi8aY9RaXaqmA6pJu/Qh+BNc05z23pMcnuLz0UVlIS0x4MzLvMJH9MCgFJWlsEv1Qj8rPDvEklsB5wfRhbarCE7PsisPhkyZ7f84o99RPj0APgyMpIl+GJ3YM6I9K/X8xzEXDJ13HRhlg/SByflOZupAqgCJFX1RdiLBp3F2Oc0Sp+g1YapcYSb0zrulHlc2MSDsRMxM/dYmqQeY5WlvQoI5l1wbHnxTMJhR5ZwW7ajxhzlm6RtYHxsHXECXUEtqweLEjHDE0bSx2nY+DYgVPQdxD8iubbHyecoDrj/kbQt2llAsT2AISwRC10Ge+2d34kPsOI+rZI/3IHwFMhaWZRHHokJNF41EubveolVQPlFJH23+UHkn1i+1jJ8pqQthKosFm3Opq7dUMiCTmsZtwqkSy/UPxdCRgdye4WT6fwM77pdm+4WJirEmk5uSSpb3RiLC6YuQYEYL5ftq6RfdtNgo7XDatJsCxPnMcCHVimArU0xfYWFZKopxoaqvpNUSbC5IE7Zl5rp/E+d5odWiUzepLfLmGDFmuMHI+0sFEVo0BTn4ugzKRTfVWNgBiZOOtg13Jzy79hd4K4dYtBAexCCwFBYy74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJDVWFSTEJwaXR3SWFYeGNDTm1lRFMyVHlPTFRvVUpCTGVidWdIVGNVZXo3?=
 =?utf-8?B?enM3VWZSd24waHZiU29WSTI5Si9KUU16R0dISWUxODlYNEh1MjBzRlNyRXM4?=
 =?utf-8?B?bGxEQ3I1bURRT3pwajNQZHMzcXRPUG9TNWYzR0o5M0JEVGhIQ0FJWWthUWkx?=
 =?utf-8?B?QWlyd251VXFCQlg2ckZRcXk1TVB0a3FKUGNPb0VHYXBqUlZBbE1wYk9oUGpS?=
 =?utf-8?B?QzdGNDFtaXJwU0xMclVWUCtzK1IrSzJDQzA4RWp1di9iQVQ0cE9Way9MRDRQ?=
 =?utf-8?B?c0hGUHdINGhNWGRhSXRjdEJVNS9QSGNUa0tIdTNvMm5SUlVteGw4ZXZJZS9a?=
 =?utf-8?B?ZlJ2QnZ4bGxjZWwweFZGaXhaZVBBT2NpaDBteHA2bDZGak5iSndNYlZrY2hX?=
 =?utf-8?B?RVlTYlVvQzhONndGWGw4SXVUeFM4eVFlMTlzZFJQdFZScXA0RjBqT2h6eE1R?=
 =?utf-8?B?K01Hc2JNeVZIbFdaQXZXa0llTW9INWM2QjZoekVONlo1QnhyUE1BQTVrMFRO?=
 =?utf-8?B?eXFCd0h0ZDhZbU14WXVJL2tOajJuTzJjbnRtazBld3I4c2FWUnQzYisyYjQ4?=
 =?utf-8?B?NytDWWVqeVcyUzdEdjZFUGRNQnNtSmJMZkJUeVN0aE1oTTg5YkFZTEhqaUFm?=
 =?utf-8?B?cUVNRXBnS3UzbEdnek4zRGt2NEozc20wVjJmNFBsVkV2bXR0Y25YT25BdHVj?=
 =?utf-8?B?c0lPVmNoV3BrODN2VVl1ZXFQWHpoSzFFTTRueGZYUlE4L0N0TWkxcmIwMHBB?=
 =?utf-8?B?QzBzZmtlY2FBMUtwb2hkc3l2Qm0zL2NpUTR5Yk9CT0hveHdqdDhNVmVVVlYv?=
 =?utf-8?B?bkVXRmlwajNtZUFHRXc4TzMvSnBXSWJSeUc1K3JPLzZZa2ZOTVprWnVFRHBm?=
 =?utf-8?B?SmV3RGxDQWpPZnNMOW1PL2ppTHppT2JSUkVZR2NrME0wTkdmSkxzYnBlREU3?=
 =?utf-8?B?R3FMT0NubEh1bzdPL1FROTZ6a0dDSjA0K1ZTQ2tLeEtCTmhEaUE1ZThqYUdP?=
 =?utf-8?B?dmp4VkcwSTdqcEsrRU1ZbGRtbGxwK2NRYVl3aVYvU01zVkFjT2lqZmV1aGlU?=
 =?utf-8?B?eWh4czluZ3VJSmpPTVNIZEdRYzYvZnJCL0NFU0Z5ZC9hNXNpbTQyWnczSHRZ?=
 =?utf-8?B?bmN0VDBDRzhpNDNMT2ozTzA3anFseTVZK0lndWtlMjBLU0VWaFBOQ3FNcUw0?=
 =?utf-8?B?cnZUb3QxSEpPU1hVZHZKQXpTKzhoS3MvQWZPQXRSNGZTSHg5YVVhcGFSL3hm?=
 =?utf-8?B?QW5GYUkwajF0UGRWcDQvaWRmRnZlTldyMFdRcExRQUtRaTZDMFM4Vnk0ZTFU?=
 =?utf-8?B?WHNpWnpiRU50enNWdVpLZ3R0K2w4ckZnWElESjFNRzlTZDRKd0thQnRpY1dw?=
 =?utf-8?B?bGpEUmErczc2ejNXWENGNy9oQzdGcTlraWxlWFp2NHl6N2gzMWloQXlTRm9U?=
 =?utf-8?B?ak96NTRkNU5Ha21mZGVNb3VoeFlKTm4ySU5BYjkzRHJBM3V4VHkvOFV2dHkz?=
 =?utf-8?B?djRvdjRXNDlhZnhpVkpRbytwTGplVnFJS09EUFIxWEdlbWNCaU1jbFhCRG5q?=
 =?utf-8?B?b0R4aWI5dEdNcnYzT3VTODFGUkdhM0JlT1BJc3ZjNHBsdXY5NWZlNXJzOThW?=
 =?utf-8?B?OWRZTXBqL3VzVTMrMGVhMkk0Y25JcnVjUG9kOCtiZkFXM3d0ekljL0sybS9K?=
 =?utf-8?B?VDBtSFpabXdhWlRqcnZUd2FLSXZBb1FaM3U4aWVDbDhnMThvWmdVcFZvVnAz?=
 =?utf-8?B?YnRXNFpIMGVsQVpsR1UzYlNqMWNMdjFoeGRYL1hqVjlOS1FUQ1JRbnJCUFc2?=
 =?utf-8?B?aUdKQVBDYlE5VlQ4UFlFZVgwUk5ERlJoR1E1N2R4SHRNWmxSMWxvTjExakRG?=
 =?utf-8?B?NlZWeVRVbWpZSDU3ajNCNStDRGVTdytFRm85UXp6THhSaE1BZWlObEM3NWIy?=
 =?utf-8?B?ODdJWjErTXFqRHJjcFJ2Ty9kT3RSS0M0SGxycnlmOFNVUGZKRTBEbitUYk55?=
 =?utf-8?B?UmgweGtnK2M0VDZrSVZ0UFhmK2E2OHhVSnFvUkxtaThzcVdPaUhJVUpmMWhM?=
 =?utf-8?B?TUYyRTBKTG1FWkdocDlTTFZpaS9ZbVlIRVVSTWFXWWNCa2dUR1U5eDQwVzJY?=
 =?utf-8?B?RkRxY2QrVVNTMEJXSVI5LzU1VlZVVVJ3S1lxdWVuY2gzUmplTkJUekovK3lF?=
 =?utf-8?B?QlArNzNlMUlyL0hSWUJ1M1pkUXlPeGxnTXhiYThWckczWEN3N0M1ZVFvUW1p?=
 =?utf-8?B?WGNLc0ZmUUJGcVZsK0tvR040eG43Y081NDJOSHVFTkRPQTRoSjYwTExwVFZS?=
 =?utf-8?Q?D6y0K2zvpKsNYvd6WZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5641892-e6a7-4c74-3fc8-08dedb5e97ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:00:45.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2LZfFKNmE48XzM2qgoPZDXunyxObnBnYHaqZ+6mQ/q1LwT5+9kwaZpd4rm2c5/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

On 7/6/26 14:58, Shahyan Soltani wrote:
> The vm pointer returned from amdgpu_vm_get_vm_from_pasid() is only
> valid while the lock is still being held. Once xa_unlock_irqrestore is
> called and returned, the pointer is no longer under lock and is subject
> to modification. Since, the caller still dereferences vm->task_info in
> amdgpu_vm_get_task_info_vm() after the lock is removed, this causes a
> use after unlock problem.
> 
> Remove the lifetime issue present in amdgpu_vm_get_task_info_pasid()
> through removing the amdgpu_vm_get_vm_from_pasid() function from
> amdgpu_vm.c and making the relevant code inline to hold the lock while
> it is still in use.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 32719f31b6c9..180d694323e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2460,19 +2460,6 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
>  	kfree(ti);
>  }
>  
> -static inline struct amdgpu_vm *
> -amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
> -{
> -	struct amdgpu_vm *vm;
> -	unsigned long flags;
> -
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> -
> -	return vm;
> -}
> -
>  /**
>   * amdgpu_vm_put_task_info - reference down the vm task_info ptr
>   *
> @@ -2519,8 +2506,16 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
>  struct amdgpu_task_info *
>  amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>  {
> -	return amdgpu_vm_get_task_info_vm(
> -			amdgpu_vm_get_vm_from_pasid(adev, pasid));
> +	struct amdgpu_task_info *ti;
> +	struct amdgpu_vm *vm;
> +	unsigned long flags;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
> +	ti = amdgpu_vm_get_task_info_vm(vm);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +
> +	return ti;
>  }
>  
>  static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)

