Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80001C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 10:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB9510E199;
	Wed, 29 Nov 2023 10:55:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C830310E199
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 10:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Yp+QX5v+mW+gqN5UIVKIRXugC3/llcMfrG/KnY13/HDlHtWn2WG3bVcIkOIWxorUfdC2WTQ0br4GvoWoZd5PZ8qzCDBIAeDsDyMz5tx5unQ0QhrtFa8Lx4NSXEDAQIWc+VvYhkc/RS0ZF3Pmt+ZXzg1k6LYz7uCgdxGAhnYJLeh2bsEGitB9nbf4k2fWXGiUR22xvgbLb8QSDUlnFcPi17xJdgi6bTDnUUOKPrfJocWeKynldXFq2VISvm0BHGsK9dt5stz2i3iiFYDnkKzfSx/kS5O4K3Dw+EdJlph4PB1xrr+h70vmnIwAfNfxzmxeZNmHAzRSfbEOC0K+wSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eIsoVLTSO8fw803LcAf71uA2gPbxhk8ZYq6wH/2gaQ=;
 b=DXZBsYyMCXfmvqL9qyDC6YHuNi+gI5mRCY7o6OeNOHXxhnar04dhey/fUMYi5xc6zJRd8RcQsyZezmPDQDXLQoOdRfVd4MiS+7/sgFEvDIAQdaYLOfFHn8gHTABKehqkye6kNlD7uhrhN3Ud/Ns2tH9kqJzRWhUMx488Ym5ZTYGVdYwjIUPZkB8EeSIL5zCHXM5pw4RwvopZuJ1Lhsl0A8/qBs6Zxn7x1zYqMyb9hkjT9ANx0g4oPSUjfqLp3Qzl1ig34fRNsDajYE05WTTNsVpFPVrTAdpRcJZS5Vv2tdZ6W5Js3pAT8oreY+WhWd6gapdMZVTJr2qpOu12fQ0ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eIsoVLTSO8fw803LcAf71uA2gPbxhk8ZYq6wH/2gaQ=;
 b=aau3144V0BSK2WGjMbEbEpgTBykPfM82KRXghe2mFB8RWfyP+/aC2uqhv2Y6VX2m5y7r5LSpPZr0TnSk7mS+Or9DFOpj1uwSwvFSE/RqFqlde3BBmEOZWju7opvtCNlx5PkVaHz1MXyxYFXtnF5D3fqJQ4yNBMLvqnyNMA8XeC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 10:55:26 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 10:55:25 +0000
Message-ID: <4d960e3f-8356-4533-bb66-fa569c215a77@amd.com>
Date: Wed, 29 Nov 2023 16:25:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd: Introduce new enum for BAMACO
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231128185238.187381-1-mario.limonciello@amd.com>
 <20231128185238.187381-3-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231128185238.187381-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c0ac44-8beb-4aa5-52aa-08dbf0c9b13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agAlcafruBUyrQr8G2W2p0UGwUxPPwgdsZ132NWshF61ciekGHCVkFefk8RvMuEFKPe1cQ1iaLPryakmdmUWdUNkzC/sdQ4VWRDzPfLVYURVWn1RJPVVINED8dPiLZ8ZMCgSNgiukztK2vDSVUMY8sFb5nyJlzk1EWzTXYlHH6vUS1fmYy1VX7enEDdDOqRrIiBXBg9nURNkAJzTIVfLCGy2Ur+Pzv4QUgDu+SwMr6t11EGPy/C/9RWhWoHhfSmSKSfOFCtF+B3KJ2iPGc5LUe+wr8fuqJ5bqi3Lhpny7aH3o/dh7KtDT68DbaPIOgIjZs5EQxxlyX1qiCgEwS3gYQFfyM50sihwDIzcFPyCMViJ2mQtgYc9dOkLEW1SmIpAZ/DMK7BUjLo4VbV/K6Q0uPS1gZ+lk+LMWTelPHhdMWAMp/TCIPcg2z2k1ql20XdmaoAlijb4oL1YFozrhlJlf7/YjEHNcaAPdyrblHp4xIAWZuZxusVWyGViXXlXW5OrPjS+mdOgl1DZdRK9ldqI/ScTU/UHMq3CIHoPXllBhMcwhmsB+R9zCNyyvHNShebio3aTH7ModO88DuU2CnxrfG7y+EDSEVG7wdGn882lPBRPsUDWWFQ9096j9P0/24xTS/OZ2wA4qFUW2xfmdaTIyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(2616005)(66476007)(66946007)(66556008)(316002)(2906002)(4326008)(8676002)(8936002)(5660300002)(86362001)(31696002)(41300700001)(6506007)(6666004)(36756003)(6512007)(53546011)(478600001)(6486002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBTcks5RElRMHB1elFzL09rTkNrTnpBY1NjREFFZnh5T2t0S01JbGh5NVdG?=
 =?utf-8?B?eE9uQVptOC9vNFZjZ01lUXcxVmRKVmNITk1FRGlQb1RCdFFlSVR4WTQzVFJv?=
 =?utf-8?B?ZHFrb0lKL3lYSXRyNys0UVFXeWJlTHdmSVY4Y01XbHRQQ2tscjVDMnkwLzRB?=
 =?utf-8?B?ZDdMSC9Ea0VoYnpTMTRtTFZvMkJPL0xHNjJlVllTanh4aXZKVEI3UGZoaGNh?=
 =?utf-8?B?UU9PcUlPNUJnR29IR0Q5L0VKa2syU0VpQzNmeFpCUnVsdkphL0hoTE1LKzBF?=
 =?utf-8?B?T0kwUEFTbkJOckpKSDFCMG9GdGRMQkQ2ZDBHOFdlTzNzZ1F2UDZCdUZ0YnQ2?=
 =?utf-8?B?b0djelJmc2ZlY2NLRHFyYWpzQTNlUnBWd3JnRnBNbXFUV01qN3JQajJHZTc5?=
 =?utf-8?B?eU4rNW9OYWZQV1VmTHc4L3BKSUw0bTlzSGYyWU5UYWtIMkNtRXdET0oyT0hz?=
 =?utf-8?B?OEswTDFtUU41bVhYV01tb3gxa0dSR1o5Qk1XQzcybXF0WG1wdDVCamlQNkZO?=
 =?utf-8?B?MFBpTDlRNmdacXB3NThaWU5OVGhRTGhIMlAyNjdOU3NGR3RkbFB6Q1BXRjMv?=
 =?utf-8?B?WDhYSGk3UDM3OU42Z3l3VS9oVGNtLzVOLzRJV1U1bDBRYVZoWXZkZDA2MXZQ?=
 =?utf-8?B?ajJEeU5WRHdVQ0w4cEtBQkpYcCt1RW9VdklRUHZwN1NIaHlKMEEzZzNKUE5v?=
 =?utf-8?B?SDIzM1BZSmU5bDZyMytwbExqVnFTdXphazVycVhSMmJ2QlhDeWh4S3JXK0Vq?=
 =?utf-8?B?cGw4cE1UUVRKTld4QTcvSG1RdDloUGpZdmhzZEdZRkMzTFdZcngzd0l3MTFu?=
 =?utf-8?B?bTR4NlBqZzNUdWRxbngzSmlUa2cwS2JDOXlvbDlkZWJaVnh6enVzQ0RiMjB4?=
 =?utf-8?B?a0FYeUFjRlV1Z1JpQUV0SFRESHNnU1dHTDE3MVVrVlVOQTdDYkM0emozWStV?=
 =?utf-8?B?aDdTc1d1NUZhbDllYWR3RmZiSmhDdDRSbGR6OWZ3VzZOdzZRYWhxYTJ6eUl5?=
 =?utf-8?B?cjBDWGVZN1d6MTRQY21OMjZ4cFQ0VnEzSHVXc1cxdE5pcjM3T1JnRm1ENXE5?=
 =?utf-8?B?NmNPZlJQdENXcTNoNk5ZZDRFaGRHakdRazJSU2lDWUxmR051SGdHSDRlTzNn?=
 =?utf-8?B?ZVlpTU9lR0VhUHdYbzVrbEVxV0IwS3VwREhaL3hteFEwckZFR3ZhV3FRWHdW?=
 =?utf-8?B?bC9uZmphTENadytoZzN3Smt5R3hySy9BNXc0cGJHa2J2TEk1VjVFTC9yN2lv?=
 =?utf-8?B?K3FZdTcwd2E1K2RNN1BUbFlpUWc1TTJMaG4xWmhlR090akc0ZHJzelN3bmUz?=
 =?utf-8?B?alhTTXEvbTFSQ3ZUVnFPQVNDSy9VOGt6cnpBMlgvRFJhVE0waElTWmxCd2pK?=
 =?utf-8?B?S2EvY0hwRGpDcFJLZ0xKRzMreThDUGdGbUJFZmQ4WjQzVUVIRWhOYjNLVGFX?=
 =?utf-8?B?UmJNSjZ1UHRXR0RDdVFKclBmSlcyaTl6OUVLdUQzK2Y0M1pHRGNnb2E0OWlD?=
 =?utf-8?B?STF0OFkzdmNHV3hxNXp0UHIwdUNOTXRpa05ZdjNocnNyQkpkTzYvUVQvcnF5?=
 =?utf-8?B?K2IzSDdPeWhjNWFHV3M4eVZWU08xdldWVUhUM2ZrRUU3SHloU0VoSGhtSnRk?=
 =?utf-8?B?VGI0cmlDZDlXcm9DMDBPSER5Vlk3aEJ3enZWZGpBMUtXNkhHQXVjSHM1ZW1n?=
 =?utf-8?B?YUFXZWRsSm9nT2VYakdsTlhNZHFOclZwcDQwRUNQOFpRZGM5bUgzeElPRjJT?=
 =?utf-8?B?N3NSdHU4K3VvZHdUNDUyNnZZOVRUbkJBOGRDVUpKcGhkT0FhZHpRMDZ3ZWxk?=
 =?utf-8?B?RjRzZjZocjZLNnEySlVud3pTTmU3TDFwdklZeWtYUnQzUmY3ZldLSEpYQnhk?=
 =?utf-8?B?N1k2THVWQlVQYlNHRzFWQjJNa1I1RFErcENQSHlWeEFmb2taWk9CR1pqTXZY?=
 =?utf-8?B?TFdJUStheVdlb1R4aXBMSWpwOVNFNkxkZStLRnBWTE1CZ0swbENLYUU0T0Qy?=
 =?utf-8?B?bm1iTTNvL1VnYmx5dkRENTd3bzJEMlRvREcvRENzR2tuT1pKdjF6Q2tMMENz?=
 =?utf-8?B?MmZDWGJBZG1WUlpKcklQRkNYMHZGUXBmcHhuTzVIQ2Y0RUJ1S2dveSs5bDc0?=
 =?utf-8?Q?Bm36Yk4OwHZ5bpVEPoNTUzd06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c0ac44-8beb-4aa5-52aa-08dbf0c9b13f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:55:25.9072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPkdc0/4BWdWI32WohtyvJlVCTmJcINViu31jCCchlEF9aLxFlDex4bXjZ+8/tYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
Cc: Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/29/2023 12:22 AM, Mario Limonciello wrote:
> Rather than plumbing module parameter deep into IP declare BAMACO
> runpm mode at amdgpu_driver_set_runtime_pm_mode() and then detect
> this mode in consumers.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c        | 2 +-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +++--
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 29381da08fd5..c6c87ab71d94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -143,7 +143,7 @@ static void amdgpu_driver_set_runtime_pm_mode(struct amdgpu_device *adev)
>   	case 2:
>   		// TODO: adjust plumbing to be able to pull PP table to check MACO support as well
>   		if (amdgpu_device_supports_baco(dev))
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
>   		else
>   			dev_err(adev->dev, "BAMACO is not supported on this ASIC\n");
>   		return;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index d76b0a60db44..3434c31b434b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -50,6 +50,7 @@ enum amdgpu_runpm_mode {
>   	AMDGPU_RUNPM_PX,
>   	AMDGPU_RUNPM_BOCO,
>   	AMDGPU_RUNPM_BACO,
> +	AMDGPU_RUNPM_BAMACO,
>   };
>   
>   struct amdgpu_ps {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5a314d0316c1..64c8783b4118 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1597,7 +1597,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
>   		case IP_VERSION(11, 0, 11):
>   		case IP_VERSION(11, 0, 12):
>   		case IP_VERSION(11, 0, 13):
> -			if (amdgpu_runtime_pm == 2)
> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
>   				ret = smu_cmn_send_smc_msg_with_param(smu,
>   								      SMU_MSG_EnterBaco,
>   								      D3HOT_BAMACO_SEQUENCE,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 3c595ac897d6..b77763d6c72f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2259,7 +2259,8 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
>   	if (state == SMU_BACO_STATE_ENTER) {
>   		ret = smu_cmn_send_smc_msg_with_param(smu,
>   						      SMU_MSG_EnterBaco,
> -						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
> +						      (smu_baco->maco_support &&
> +						      adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?

This also doesn't work as per the legacy logic. In legacy logic, BAMACO 
is given preference if supported or if BACO is not forced when both are 
supported. As per the new logic, BAMACO is preferred only if forced 
through module param.

Thanks,
Lijo
>   						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
>   						      NULL);
>   	} else {
> @@ -2288,7 +2289,7 @@ int smu_v13_0_baco_enter(struct smu_context *smu)
>   
>   	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
>   		return smu_v13_0_baco_set_armd3_sequence(smu,
> -				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
> +				(smu_baco->maco_support && adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
>   					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
>   	} else {
>   		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);

