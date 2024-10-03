Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99768CF34AD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 21:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAC310E25C;
	Thu,  3 Oct 2024 21:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ztzV/rRT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ABC10E25C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 21:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZuFdoihRHJ62I5vNPjlzayBBpnNFbvYwl2lkXCnWfn1xXLbMtxMjOF+T9yMo/OrwwqiJ1pCHhXSwpRo0v31W2oC+1w1WitnIYs1XySmi5fGmPRkEoZvI9NlaSwM4bqk7wc4sQWf7WtY/uGxNute29NP3noaDcGqGjxrENHxBf0Pi9q1Tlj47uyQ2BWVvK8IneecoMBN8SZcQ0fFNYoysoqD4vHaiBbpuUSfFjKY8zoXZBgPOhNXd/he/wo3gGIWmLpEtHuA3XePxOrwv3WRHx+STsfDG5ILxx5d6ovQjey2TE+0J025q+BvrzjXccmZn4sRKzC9RmfRd18gLjsqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN0i52+5HSkyMaF9D7LG9TmjYtk3DD/INQI8K7B3DuE=;
 b=QAjGlfqSmitmTPUC/5tm/IaENRsytplpsXYRbxAKJVm8O1/i8B98iP5ANx5h3g3mCHBcaBy+wZ/LrAYN8yIaAjQL4m9dXysmaJYMrXirH3q4rpHlQkusDIRFkCRkhMdSb+hkISboPPK1m7vnEFc0+o3lvklxSafXhC9pP5BNRN2PPTIxYi8EfncGPdVlrfRCeUbps2w472j03kP4biVGuf4YF1+3MT3zu9blWYbosnLO4gd8AgqzmrIBXmBlx1/L88xbyLZLYNvsCK2/zo+W6XW7t9Oo6VyEf6ajpeR8WlTLC52iNjufGVcFDISI5QTSkNdHi2f+6+342tYKWJn0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN0i52+5HSkyMaF9D7LG9TmjYtk3DD/INQI8K7B3DuE=;
 b=ztzV/rRTV794g/Jj8cqqBJDTZakIatUXtxi1gGa8JxigCOgDXUzotbddMUAM7y/IxB1mTdGJoMoeujFrBS+V+TzrCC1Fv47PJl2ephTMn56Q3KS0SmW2YgypyA47DifkjKQ0LeIPQISudyWpZAh69XrY0xWjsTEFv0ozUfP7LBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 21:11:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 21:11:44 +0000
Message-ID: <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
Date: Thu, 3 Oct 2024 17:11:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241003205526.35748-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d23cc69-a3a3-4f02-fe1b-08dce3effc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3FKZHIvbUhqd1F3dFBCSXJmWHZlQVM0TUlUQWN2UHFjeHBlZDdnQnJlWDRJ?=
 =?utf-8?B?TjE1VHNJeFpwbmk2TURQMWtFc2lSdE5tVDZOUllUZFR4N0FtZFVCcUxPNnNL?=
 =?utf-8?B?dmt2eDBCWHZBVm1BZ1FyVGFacFh5SEgvQ1RveGI0bkwwYzFlaGo1b2dHSFpl?=
 =?utf-8?B?QTQycll4S0lIbXJ4bk0vOHk0V1BzL2xDclNpVHBWRG9nV3BiYUVVTDBhbFF3?=
 =?utf-8?B?dENVQ3psMmM0eGVKL3laamVQVEpzL1IzQjVSVW40ZWpNbk42L1NCS0RCdnBB?=
 =?utf-8?B?SVBXNVhwV0FvRVlJSjJpb3B6S2ZrOC9vVnRhK0hWV3lySThBaXR4azV5QjdT?=
 =?utf-8?B?MHFrUWg0MTFKVUZiaWJBTlJsSitzUkcrcTBtK3F0T1JSZzZQbGphL2k3cmts?=
 =?utf-8?B?VllPRWdNY0NDV2lZd3VzTFdjNk84QVdaWWpkTEZkam5VREJ0SzNHZ1hRRm9v?=
 =?utf-8?B?cktpS05wbVkrblBFdXJtNW1mQkgzaFJUdVNRUTIwK3RjZzVTcGdNQjhJYVB0?=
 =?utf-8?B?QVNIYkRSem1FQzd1cjBXVURpL2ZZVzRDb2VEWUw3NC9zNzdWVGc5WXlqcVZS?=
 =?utf-8?B?QnRqSHZnREo3UW9RTDhaZys3eHlqdzJWOE5SazRsbjI5OUk1NVBiVjU0M1I3?=
 =?utf-8?B?UFdIbGFPSXhyMVNBTStyeGE4Q3JTdmluY1ZXdEdnSXI3UHVPZnl6RjJYV1h1?=
 =?utf-8?B?QnA4MHV0aEs3cDR1dzNzOVdEUG16emRUeTlrM1J5M1d0QWpoRW5RL3h2eG1t?=
 =?utf-8?B?bjJGdDRNT1lmZk1CR0RnMGc5cXYwN1dmTmYwTDJXc25FOVBDekFlcjh2ZnJ1?=
 =?utf-8?B?dC9NUDRobEEyVHpWS2poUVAxRFBNY004OUhhdGVVTW1XOEo1LzRvNjZPYUVB?=
 =?utf-8?B?VDlpYXFRdUlIdy9IcXplTXFRb0tJendINU9WVy9LeGlmQ1k2VnFDK2FlZUZh?=
 =?utf-8?B?dmNHd0FIUTB2SW51ZHczOFlvNEZZMFVueHA2MTlHMXQwWldLQTFrcUd3aWdY?=
 =?utf-8?B?T0YzVXdqRGxvRURqRFhsd29mcTRhQVMzRGVkU2lFaHR3dVBhVkMwdmhrbnF2?=
 =?utf-8?B?SWN1RDBtdE8zRnQ2dmZaVXV3WkJPb0xXSGdmMGtFNzIyVGljTDBXNlhpNUFw?=
 =?utf-8?B?K05yR3dITnc0bmo2Uk9jS0JlN0NEUSt3ang2SFRGN3RsOUJUZm0wOGhwaE8z?=
 =?utf-8?B?eThMZFUxMFlIN0krMFRZOHIrZXlNSTExcG5FdVBhdDRJYXBSWHRhWEdpSzNB?=
 =?utf-8?B?VnBidy9OSUUwM1VIZVYvMER1WFNtNEZScDhoaXZtRVlpbkFidDNCQ3MrTHht?=
 =?utf-8?B?RlBqR3FRVTFmd3ZwYjcwZE85SDR0MDQ5dUtTdmVHM1k3blhCVVh0U29CRFVx?=
 =?utf-8?B?OTZvOTIwT3RnK2t6UU80OHVobzloYXlRR0x3UjRFSVNCb0dubmIrbmlob1JV?=
 =?utf-8?B?ZHRqbGNkQmtnekVPd1A4WFZmTmxpUDkwVmdqZFRkZ29HT3BTRGdWd1hDbUpU?=
 =?utf-8?B?aEQ2SG1SZkYxcitsa2RIVUZoMFZ2bllXaDNCWlp2Uld0cEpFcjlIR21mSUhx?=
 =?utf-8?B?aUdUMGtKYXd6Q2V6VWFTTzI4ZmFETHRDZk10bFlNM29IWG1wZTZvUWozMEpG?=
 =?utf-8?B?WDZ0QVpkZGdrL1NTaW1GYmwyaTBld1dmU0pCVmZJR015ZnVQYzR1WSt5K3FJ?=
 =?utf-8?B?TFRLbFZTMFIzZ3Zxa1VGTFZHZ3h0UENHa1l2emtOeFUweTAyelhBZjl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRiNG1IVXV6Ynk5RnZkMXRJSXF3UWlOdi9kMkRuN1EyZU9BRU0zUXREMDFH?=
 =?utf-8?B?ellweVMwMXhHRURHdllaMXNNNFNyem5TV2R2RmNIbG52UXFKRFZhK1VHOG8w?=
 =?utf-8?B?bUZ6NzhaQnFkYTFKdWZBNXpwNW5VVmx6bEtCdjVnVE9HQ0FCQTF6YVZsZ3N6?=
 =?utf-8?B?dDc1c0h6VzM2VTZUcGQrZUlFN1QyblN2cnZqU2pJcXBZVm55Um9KK0hJTXNr?=
 =?utf-8?B?K1ZTN1ZONGZVYVhURlJpV056OHZGaUdwa2F4cXlLUEZHa2NZc0dDYVdTUlBh?=
 =?utf-8?B?cWZXUk1BTDZ0T2VtZ3BhR0tXc0NMNzVkdWUrNUxuNGZrOWRxa2NKRDd4R3da?=
 =?utf-8?B?QTM3RHV0N1o5T0FJVEVLdkZPMGxuUzhnVnRqeGMwZ0J5L0dRMTcrSDQ4eHY4?=
 =?utf-8?B?bXVQNStXM2FDY0F4YXN0MWdKN3FKbjB4VFN5L01VaTQ0eU95Y3pvRnljTEJ3?=
 =?utf-8?B?UVRaQ3Y3b3NZYVNmZGdTN3JXdEFEeHBuRENYSXB0ODk5RkQzYkhIWGxTeVg2?=
 =?utf-8?B?d2ExaEZIcmtMK0UvWCtxazRscGIvTVgwcEhsbUdKeXhVMC9QdUJOTk9lb01H?=
 =?utf-8?B?SmhvZHFCWVd3NFA4d1pYaTBHQWg3UmUzVVNSOUtTRk9Vdm41ZU5veFBsbHNk?=
 =?utf-8?B?Zmx3dUxTRWU1aVNLYzA4VGlpK1BuNzNaK095ajFrWndiblhFa09UUFdQYW9F?=
 =?utf-8?B?K1FCZFEwNnBTN0dGV2FSbUpNWFFDK0U2aXZ2ei8rczl3b3dtRkNYdlNiWkN3?=
 =?utf-8?B?Y2xVT2dwemlhL1I3VzBXYU9ZajMvUjczSTVUTGFQNmN4TUF2TWYvc3gwK0Rz?=
 =?utf-8?B?U09SZUhUbThJQXRFWlc2TTJEV2R5Zlc5QjkyTGVseHkwY1laQUxBWC9vQmM4?=
 =?utf-8?B?TmdZR3Z4TU4wdnAvRkFEUmFJTE1TQktrRUJVTkJPNnRBa081NHdGMGZLeldC?=
 =?utf-8?B?QjJsajdvMnZFVTVJUE85UVFDTzNaTVBjZENMcmJKRFJ3SDN5U09mdkxPVWF5?=
 =?utf-8?B?b09iTTh1UVZwQ1BPNUVVTzFKaFBBVEFqTVRBdnBOUlFmWXV0VVNWY0pBakJ4?=
 =?utf-8?B?R01YVUthaVJyTElWcFZvQ1BYUmhmMXNuZTUrWGJhVHg1M3RVeFFQWTdkUldi?=
 =?utf-8?B?Vi8xWkdIL1o5ZzMxUzF2ekhSVmNtbHBCQjc1c1IvVHA0R0d5QUxkQ3R6aTlN?=
 =?utf-8?B?NlJpeWM0UXJvMDhlT2VISGVDeFBQK25VZVdnVGh6WG00N2xhTElmcWhucHpH?=
 =?utf-8?B?R1BKNkxMWENOWGk2dEFLNnVKMFRuNUZLbTlzZWEwZDNUVWJReFNhUjlaY1Nj?=
 =?utf-8?B?ejlFY0hrTy9EUUd1Z0pxaHROUlV4NG45SG1EZlFWanljU2ZVWnhid1ZOOXhp?=
 =?utf-8?B?cFdxVCt3cENrTHJqOWVvUk85d0dvS3hCSDk0SlFCc1FNamlXcUFMeCtsMWwy?=
 =?utf-8?B?b1ZpMitnRE1SOEw2VDc1SlBnWTk2Qk8rOEYzem5VNjk1Z1Jndm92YnpNbHdV?=
 =?utf-8?B?anFDbGFrNGl4SUNra2M5VGFnRzZKZnZ0cTN2dDlUUVVJVU9WWFhRT2diTWdv?=
 =?utf-8?B?SVBMeUgyK2hmajU3N08yckdtMGNFeWZlSnBOSlVXanpaZWZPMkxwdU55MlJ3?=
 =?utf-8?B?eXg0dDhwSGVRRGxSVEtWdjhQd2NwU0cxaHdodHFrZ3A1Vm8rbVdCTFI4Zmp0?=
 =?utf-8?B?ZG1qZVJPakh0a0x6dE5ES05xNTg0YnZvQXM1aHVwVmIycFpJQkNwczVDUHA1?=
 =?utf-8?B?Ny9MYnpwYlh3cm1ENTlkRkJ5ZW1URnRRMjBJcUl5Z2F6dDIvTE0rNlYwQU1K?=
 =?utf-8?B?bnlYWjY3dWwvMDR2S0JnSVgxSkYzVGxPMTFMaDJPRW0vQXROMktyNGhuRjc4?=
 =?utf-8?B?V2dqZzJvT3V2QmgwbUp5WVpNWGFUb0N2UHAweXZUQjNHRkcyaHlFK3VMQjht?=
 =?utf-8?B?bldmZHFtdXFMYmdobmpiQWo1d3AxcDdZWjZ6MGprQ3NxcnFrZXBaczJxUVJw?=
 =?utf-8?B?OWliSnRlUkVZbkdIL3hIbzI2RjZRbGp1UWJKWEh0WDI4RHgyL2U4TGVTY3Vi?=
 =?utf-8?B?VjJNU2xHQWFja1Zid2tOR3NCOHJ6Qzg5cEtjc1BsWmR3Zk5EZ00zTXNzemZT?=
 =?utf-8?Q?bDQ2gbDkwA8bWUzQn0FNjYk4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d23cc69-a3a3-4f02-fe1b-08dce3effc0f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:11:44.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tS3x4Mo0mYCn9VQ4HaRADaPBVE3R4yTnSy332Qa5Uqo6qDHZNLKm4Woa8m01IXFVQnXhbtVVFLcEW3bBH1dFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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


On 2024-10-03 16:55, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When kfd process has been terminated not restore userptr buffer after mmu notifier invalidates a range.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..1df0926b63b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   		/* First eviction, stop the queues */
>   		r = kgd2kfd_quiesce_mm(mni->mm,
>   				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
> -		if (r)
> +
> +		if (r && r != -ESRCH)
>   			pr_err("Failed to quiesce KFD\n");
> -		queue_delayed_work(system_freezable_wq,
> -			&process_info->restore_userptr_work,
> -			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +
> +		if (!r || r != -ESRCH) {

This condition is always true.

Regards,
   Felix


> +			queue_delayed_work(system_freezable_wq,
> +				&process_info->restore_userptr_work,
> +				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +		}
>   	}
>   	mutex_unlock(&process_info->notifier_lock);
>   
