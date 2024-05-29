Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6526FC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A701C10E25B;
	Wed, 29 May 2024 06:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPIsFli4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7D210E31B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiRBMtC55ruQzdNpBLRJ+ijuj5KBp9yC9v2pyFJemEtpchLAAIIP36aMh4aVABZEe/876J7cQwiNGvJgPdwLbFD8fgQPN1pqyONgotouXFp0lrupi6fUhlvJmYiQI8G5Zy3QzFEVca40Hek0akXFf0aajQ+v2AlVKHEfS9X5BL8zncmobp6NPTjs8HDe6H/JYUOfZAisLGoI2Gjxv5+XK56PypFbKt0AAGlSUsSNwW4yfVqzl1DT/4Bda+56sg8yCVmmb3ZEYyJkGxBpofRUfiu10qsQsbYr6TXETEQ8DlSQSRd4xJQBy+bcM/IfkxNrliBuWaxdd/cH9Ydvz6636Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo+J15u7ce/qy7L5mzzOPUQ5WF0gl4GsMJezdX1EcqA=;
 b=JZDUr1bN9YFmqjRD2eP+SFL0H3JQMYGZtkD7qLpEJ0WYFVVuyco/0SGqohp3GUp4vdGO0hAiKf+2bKjbO0gwm2CoIMN3PdWp5Z9bPPUx9Of1orn56nYo28l5jBwdQBJIs82P40WIYfEIJ/RjQfYU7DZ1iqBIcbu20nsQiH58Jd5LPTl8aOrgLsVt4io7dNjJgwEF+OjczVnWpwO12imy4scX5OoaOiD7q1lFUvwrGSPBNAKTNQ+2mA6Sl22epXGztwt2srLj+cZ/JQrdJfpMq1RiHT6+rvoi7o7e+0kQwjPGPOhLQPDWVbkzTwJLr1bQStnqFBW6YSQtZEhLNFTJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo+J15u7ce/qy7L5mzzOPUQ5WF0gl4GsMJezdX1EcqA=;
 b=zPIsFli4g0TvPUmsmNEKgRNeP9EgG8emY/OwVBQW8eZ4dIDUA3JsuLJLH4+9Pjjwz2M3zhW0UQIisYCkuDM0yeyKW+jdYxKPsWo09WbOK8TpI4B87o6Gs91KjQyA8RMWx3CShxCE1P1Q0/lKBV1ftHq4/2mBE3tgT9fjxetsb88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:49:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:49:45 +0000
Message-ID: <329e7ed7-c039-407b-916c-7a15e8a51f46@amd.com>
Date: Wed, 29 May 2024 08:49:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] drm/amdgpu: fix locking scope when flushing tlb
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-9-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-9-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3da497-ba5c-426d-b7f7-08dc7fab869b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW1Udmd5NzN6RlE3dGkwVkIrLzBEVnFlbDlKTWk0YjFRK1JyS0FnWW9uUG1z?=
 =?utf-8?B?N1RTSmdQK2I1b05TVzhLSVpnblNRT3p2S2ZFK0NFTlBsMmUyS1NXdmw1M1R0?=
 =?utf-8?B?MlM0WkFzUlZqRDN6M2l3YjRpRWtjd1NDSCt1cTdhcytzRUNuSmV6aXNjL1RU?=
 =?utf-8?B?VTVJS2hINUltR01qdVExVkc3c1U0VGZROS8wYWRhbW9qV1NpeUhqbHRLY3NP?=
 =?utf-8?B?Kzc2anlkRllBVzNUUURRZ2JYczFFUjhJUjAwRTRjNHJyZGVpVVZNbmVmUnJo?=
 =?utf-8?B?SWRzaUxIRDNnelBFKys4dzFabk9UQVVkOWk2TXNkQlQ3Z3BWTFZBeFZCeHIv?=
 =?utf-8?B?YmhyeTA4TjRLdytsNzhRWWZHbUJOTDIwSzcveVhwQXZTMHE1SVZ0U0FBaGVr?=
 =?utf-8?B?Zkk0ZXh5K0NlY0srQzc4WFpKOCtkbjFCU1c5WTZHdTh4Q3M0bS9yNUFScFR5?=
 =?utf-8?B?SlNuL0U3Z0YxUGlQRGJYOW1kVi9CNW1WRzFESnpqeHZDM0lHYm9VYm5jVDRO?=
 =?utf-8?B?YjZhUzFVd2o5SllqNnNRVjBhaHNpSXlQRHArY2Q1bGdmWlJUcm9qc1I1ODM3?=
 =?utf-8?B?blM1a3F0MnkycEpOemFNNnlnMW95dEFWTmtxU2VTNnZGRktibWIvSjdQL2t2?=
 =?utf-8?B?TVZHSEFROUhGQ0R4ZlVPMW5sSlpqdkFkdVBJN2lrM2NPVzlsWjZmZHdjWmhl?=
 =?utf-8?B?NGZ2NDdyU3BlOXpVY1J0a05VaExxRTJIdWx1Ymp3OHU1MXBiUnRQT0hBMDNZ?=
 =?utf-8?B?NUREQVNOSWpTSVUybi9nSWlwSXJoVnd2eEFoaHFvVWc2cTVNVkxWZnRkc3d0?=
 =?utf-8?B?ajczeEVFQTNURnhsTldwN0NHOEJTWm1VRFc4ZnBnZ0htdUxldzFCdUhSdTRD?=
 =?utf-8?B?ZDFoaFllekZ4YWxDT0cvZE55c0FMQ2JiM3FBanZkZ01MRzI4RlkzZ3IwYWRG?=
 =?utf-8?B?MUpwWTJzYlprTnNlNExUdFQ5aGg3TFFJR2s1OXkzZE5nZDZWczBzWk5Ha2w5?=
 =?utf-8?B?dEMyMjdhVjNrZXJJbE1BTWFqa3ZpZnFld1ZTbTBuUmtUcTdpQVFSaDRlQVZT?=
 =?utf-8?B?YVFidy9UVWVvR2tPQ00zODdxY09vZWpvNm8zcDZ3dlh1NFI4cy9McStjVEpU?=
 =?utf-8?B?REZHdlFWMW9lcnk1WStLU3cweFQrclBCY0MvZWlEakV0dC84WWhjSzlBYlY0?=
 =?utf-8?B?eXBNK1NWQUZzRWVKbmoxV2xHMzVPWDl2blJUVk1Bc3dwejBJS3BYaDcxSzU0?=
 =?utf-8?B?Q2VzUFVORERKODdaUDR5MFBpNnozSjhTekxCY29pWnEzUmRBejl6R1dBbDQ0?=
 =?utf-8?B?dDM1Z3E0Qk54SXY0bzlZbURXd3Y0bDE2dTROY0dLZVdNcWMyRjNVd2IzVWFX?=
 =?utf-8?B?NUF0cTR3ZUorY0FUZFhxSE5IakxlcGdubmF1R2pqK3ZYK0ZsME9SV3lEcHR5?=
 =?utf-8?B?d3IxQkIzY2lMcjRTcnY0ckdOcnU5TVlwS2diOWJYaHhJZ1Ezd2ZyVlNTNVh1?=
 =?utf-8?B?VHFCREFYb1NMK0ozRTJVaTVhOCtmRjNJeHFDVXlMWmg4RnhVMm93ZG9hSSs1?=
 =?utf-8?B?TXJaYkVkYmx3di9xQ3J3UzBTOEk3cGIxelEzOTFaT25oU0hodXYxUzhBREpu?=
 =?utf-8?B?bGt5RVVzZTlBanJHT2VEQURINjhMNlhCQ3gwYjRCVmZCNUVRc1ZhLzB2MVM0?=
 =?utf-8?B?UjRpRTIybjJIOWpGMUMzM2lPMVp3b3J5NnJMMFNqVFRNK09NUmVJUk5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZpTWN2OWZvdXYyVEwxdUtNYWxyNHVwUFhQUXRSV0xySzNpaloyOVBFakZz?=
 =?utf-8?B?N2w2U1kwNXloMk11STU5a1NhNU9ncjJIMllmd3NDa0ltUHp6S2Z2eDhpRm5P?=
 =?utf-8?B?eG10S2puVk1qVVN3VDE2dGN4dFRFQ1lUeUQ0SVhvaXQydmlOcGxNUXdaMjVj?=
 =?utf-8?B?dXpRcTVNUHZXRVBxbDVzL0gzNVJjdCtUYW1pcDFBekY4cVhYRXZsZHIzZE5W?=
 =?utf-8?B?RkF5cVNuZUZJQ09WWi9FZzlTVUFHT3BBQTJWajY2bWdHTWlLOWEvYlExaThh?=
 =?utf-8?B?NDY3ZGdZWjhNNTdmUEIwWlk2cG11QlVvemhicm1QaXpueTVBVXd6aTM2d3Z3?=
 =?utf-8?B?M1cwd2wvTit4YTc4ZWpBUmdVQ0JqaFQ4VktQWXVKVVJFNFpmZ1gyS2w1Wmxh?=
 =?utf-8?B?QnJyWm9Fd3F2endwVTlCQ1ZlTUFzUFJib1J0OElhb21xcFRjeWI0VXJKYzl0?=
 =?utf-8?B?U2pxbEdyU0ZnQVEyUEpsVldpZ3ZCYTZnN285bVRGbXB5cE9wbVM0MHlzTmtQ?=
 =?utf-8?B?NmxGMDFNUENXUENodTFpYm5hR3Vvc2xMSEZNTzh3K1MzYUlMV3Npd0h3dGs0?=
 =?utf-8?B?TWdzaTR5RkNnN1lWdkNiaTUvOU90c1dNRGdLOFlmazIydjlHSHpjSFFDL1NB?=
 =?utf-8?B?blJYMEl1dk9BT0lxdHQ5b1ZodndPWVF2NWozOVlDSWZDQkFIVW5WQmJqREpO?=
 =?utf-8?B?OXFpT1VzeFNKeGhFQ3h5S1lGWkxDcS9oY0lQc1U1RjlaSEhzd3BJOXNzRmZ4?=
 =?utf-8?B?NWFVUFQ1d2pmVDJaTVYzcTdwVmhtMlhDZmYrdjdJUkYzVmJlSTlhU0hLdTZX?=
 =?utf-8?B?azBtMkx0cTFleTB0cEE1WmZkcEprNDcxSEd1c1o3Y2VxK09kYS9vNzVUWENp?=
 =?utf-8?B?SklsQVplVGQ4bnJKZzFoY0lHdTBTdzFCaUpsVHNsYWF1dUtVMXNidVJkWE1j?=
 =?utf-8?B?R0xUL3dEREFOV1FoUmhDeDhQZzEvek8xNDlpUHo3RnpKbFdNZnNJUlY0MnEz?=
 =?utf-8?B?V2FzbVFoUGU2bU40bjZWU0RLOXRZY1VZallCOUJIeDB5VEVWckFWWVVVak5k?=
 =?utf-8?B?SlREN1JHVmI2Rnk1Z1RQSjBjTGxUZWF3Zy92dVNmN3BydEtIdmxSdlBkTFdi?=
 =?utf-8?B?WXNVaWR6TmJ5a29QNkk5WEk3ZGdVakg2emVDQUxaUnplR3BZcFMxT2dTZXg4?=
 =?utf-8?B?cEtkOFpFY2NiNk1JNDdVNDErWUh4bU1TQ2hKWHdBK2cvUFE3cW5RZ2gzbFIv?=
 =?utf-8?B?U3lVdWVJTFM5aGdHQkhWRmo1YkhyYTNjOXJwbTR2OGlmbm9hamhqUWR4T2NR?=
 =?utf-8?B?N2ZWYkVRNFUvaGRhb084RUduNEVKZ2hGdXV0WjR1YTVpd2NGV2k0SUtycDI0?=
 =?utf-8?B?d3M1cDNrcGNUSGNxMnQ3RmVDZDMvcE1DODU0ekJDdGNxTDhBYkxzR0ZxdXJL?=
 =?utf-8?B?U080d3diTldzOXU5U0RIeXFDakhlN2IzcWpIcURuc2ttWEUwaVF3TVoyVGN4?=
 =?utf-8?B?L09Zck4xR0ZmdnZsb0h4MVZnOWZjVWIrZlNYQVkzVzdzaC9PMWxMSmVqeTdV?=
 =?utf-8?B?R0FyNUwrbUNsOGNNNGxZSFJPQTAwQWR6UjhESEZyeGtxRzNYdVZiWFJwaU1E?=
 =?utf-8?B?cXBGU0tpRndmVnFxeXVaVEtaN1IxYXVuL2prdDhWNzFYZzB2eGVadmV4UVdN?=
 =?utf-8?B?UHpZV05MQncrdmNVRll2SFJzTHJzalRqTG83ZGZxOG9BaWJRN2ExNVZtbGF0?=
 =?utf-8?B?dlB4clBoT2dkdUpCdC9RenZxREdXaDBsMU0zRzNHTVhFTXFaZ2RQNVFxNmtW?=
 =?utf-8?B?dHkvUUI2Q2FnN25Ga1o0Mk1IR0FvOWRvbWpoeEJXaitXWWxRSFFJRlZManFP?=
 =?utf-8?B?MlkrM0Y4a29Qa1dOc2FILzB2am1IWEpFdVk4SXpoS1NmOFNtdVFPMEhuS3kw?=
 =?utf-8?B?ZE44bFBjRVBySkkzT21jdjRBeVRQalk3K1Fhb2tYdjNadDkwS3AzVmFsajVU?=
 =?utf-8?B?L2Q5MHhFMXRmcDdpQnRiWXNIYWd5Uy94dVg2U0x3emgwdTBCb2NRV1V4VEZo?=
 =?utf-8?B?MS85Q01BVWRUaXFFSjNpc250eTkwR2NSM1lFZEhIMDJBTkh6T2V4UmV5ck5q?=
 =?utf-8?Q?2RTlVMhYbxUVb+lr1oHSMwcCo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3da497-ba5c-426d-b7f7-08dc7fab869b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:49:45.6684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9uK7zZBz8vtc3vgwq4KIDEA3G5GnsItvOpgWMFAdo85anVSMV/gABRX4KUqBdW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> Which method is used to flush tlb does not depend on whether a reset is
> in progress or not. We should skip flush altogether if the GPU will get
> reset. So put both path under reset_domain read lock.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Maybe add CC: stable?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++------------
>   1 file changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 603c0738fd03..4edd10b10a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -684,12 +684,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>   	unsigned int ndw;
> -	signed long r;
> +	int r;
>   	uint32_t seq;
>   
> -	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> -	    !down_read_trylock(&adev->reset_domain->sem)) {
> +	/*
> +	 * A GPU reset should flush all TLBs anyway, so no need to do
> +	 * this while one is ongoing.
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
>   
> +	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
>   		if (adev->gmc.flush_tlb_needs_extra_type_2)
>   			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>   								 2, all_hub,
> @@ -703,43 +708,40 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>   							 flush_type, all_hub,
>   							 inst);
> -		return 0;
> -	}
> +		r = 0;
> +	} else {
> +		/* 2 dwords flush + 8 dwords fence */
> +		ndw = kiq->pmf->invalidate_tlbs_size + 8;
>   
> -	/* 2 dwords flush + 8 dwords fence */
> -	ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +		if (adev->gmc.flush_tlb_needs_extra_type_2)
> +			ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -	if (adev->gmc.flush_tlb_needs_extra_type_2)
> -		ndw += kiq->pmf->invalidate_tlbs_size;
> +		if (adev->gmc.flush_tlb_needs_extra_type_0)
> +			ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -	if (adev->gmc.flush_tlb_needs_extra_type_0)
> -		ndw += kiq->pmf->invalidate_tlbs_size;
> +		spin_lock(&adev->gfx.kiq[inst].ring_lock);
> +		amdgpu_ring_alloc(ring, ndw);
> +		if (adev->gmc.flush_tlb_needs_extra_type_2)
> +			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
>   
> -	spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -	amdgpu_ring_alloc(ring, ndw);
> -	if (adev->gmc.flush_tlb_needs_extra_type_2)
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
>   
> -	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +		if (r) {
> +			amdgpu_ring_undo(ring);
> +			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +			goto error_unlock_reset;
> +		}
>   
> -	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> -	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -	if (r) {
> -		amdgpu_ring_undo(ring);
> +		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -		goto error_unlock_reset;
> -	}
> -
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> -	if (r < 1) {
> -		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> -		r = -ETIME;
> -		goto error_unlock_reset;
> +		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
> +			dev_err(adev->dev, "timeout waiting for kiq fence\n");
> +			r = -ETIME;
> +		}
>   	}
> -	r = 0;
>   
>   error_unlock_reset:
>   	up_read(&adev->reset_domain->sem);

