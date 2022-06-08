Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13BEC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3488710E10D;
	Wed,  8 Jun 2022 09:14:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BCD10E10D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApGxZG6jV8Y9Sq8cXz/98P19RWRZSYXbU7rxbxoSzrrmXvaLEmkeCEAhuww/SeuZL8PXoBmD6GbRon/UCmMd3f1I3kudyFXfRsOGXbimI0vZWia+V+qvmVYCxIKRKlyO07QAg5AuVR7eXz3mpK3CchnkP1kWnASB2m/u8hXFul9MrFTBW98Wca0d7W1HUG+G4qIe6/B+ywyNIIC2zTACoT+eNdFNuoCEg+zvTWyDKUqBCQ/Q3/N1JHo5mQfzubnpNKG+hJ5qJcocPxlXJ2v6YWMF9OeRxCmr02DVnfx0XiidQu4r4Q88n9Tl+tW+jcu1tBGJ/Fycy1Eob07X9vkxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqLWX6gofSx4uoinvaJsJ2vcR97IAOyp17yD4EFlqrI=;
 b=cMxF1IZ6ovTZGfIBuUy7sFroZy5pkLarPPjSyprtSncsKEliGRtyy/yp+jByHC/7bOPccF5st7OfPtEEFBJXfRLa7+6+vCsVO3ebFXGklbuMpJE+Pn6O6WOlqGil9Mu8o2Nse7IBzmjIP/ITKwshKOBjNj9ev0L97UjksfvjqssJ5Bgz+ffZ17rh5mlNPzVuF0f2VKuLEvhh1MRfnAv07X1pqWT68d+VtK5kV+mCl7tJ2slOokqMZhEMkq+fZSoJj/7autdi4dqBCX/ni0rIB2+S7kUEsXE+i+Iqdo8njT0mQyDeTzc+VdIUY1OkvtsfyqIDBHFKA88HixWrviCf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqLWX6gofSx4uoinvaJsJ2vcR97IAOyp17yD4EFlqrI=;
 b=phDR0ij1U6Nhi4f7H5LUrP0ZYkXgniW7DKVq4A6Nx/TYQWOCurTJN7TnDECaF2yE+KZ1W+W2/80lC1CMnviZabduYS0gGSXqaVoDjBivA4TOOSUCSR6cCA9ssHli+Z8ERkVpwcMcm6Rc+HM0/2g4fmt+chllIBCCUOO0UpD7kV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:14:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:14:49 +0000
Message-ID: <5fe4bbed-4c74-ac03-8fda-d9728be4520f@amd.com>
Date: Wed, 8 Jun 2022 14:44:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/5] drm/amd/pm: enable BACO on smu_v13_0_7
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
 <20220608090536.1969621-2-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220608090536.1969621-2-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d020e880-ac00-4ef4-4a14-08da492f568d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5381:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB538189D4B3841E67AE1CE07597A49@BN9PR12MB5381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzbojFcE+/lEtLinW5Twg6O5c+WLj7oPpOdbPujLBWunORZ3TZ1vzPMrv3OiZ++JrSw0RkR1getnigFoVeB5CcMIbAvx6cayVdaX3AHQAMv4z+iR+ddaYbl8PpdyC9ckbD1+TYRsoGQLFGxxgJXPVaYJgt50A8CJCIzv81h3gyiKWSFTAE+55ER6HEnSGx+fsqU+cBTvCZK4Q7Awj9GgiY5VgnV+g6HOG9nL/mFSOa7a1ZuHdDnMcx/p/LDF5j4yLa5+7PUuSOTssWXqQq0xAI5PzFgZBpjr3QaUfGTWm8QRcOLtJaLgTl2StmIEZDZcJ+kKvz2s745KZA3DV8Nj3kbYUoitj7nDW99+FnlVFy+fEFeN3D4HwozsHWeGFllqejC7XS6jc32WDdmhC+Yd4ePua+QL0HMS/umst8HSdNrZqmNL6TorIZMf42AWBWRIhxwhd3BwreEAlhwCkOAK2DuoYc22NVvaxbBfGJz9unWbnNhEIMUlhMYkovK2EEi8ZapIuYHOxtk3nnvIKDLy8HYbih+weJPqZabRvdHuUOLagj68T4uzc68bQ49zA+5EH4baUdarjOZaI8w8XPBDhCG9QF3hPfloDZlH0p6Pg0G36u1LDY/ZP69qG82dAwvfTORCw6TMmXB63q1F/suBMJq0oukJQVEkP1llVM1YM1jaKelyssrQuaZ/ZWRoYG9TNW5EXB8clfnLEqBD0PvronKL88v+58G0+uxnzPp1LdoBiv2SsWz+tacjFU/9uGRX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(6486002)(508600001)(31696002)(83380400001)(86362001)(26005)(38100700002)(2616005)(186003)(316002)(53546011)(6512007)(6506007)(5660300002)(36756003)(2906002)(8936002)(8676002)(66556008)(66946007)(66476007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVMTFlPeG01eUFoWTRCTE4wVFBPMmppUjBPYXU5SzM0THNnOTViekcrRktY?=
 =?utf-8?B?bWVVeXEvYmJobVVTSmFtZU1SaFkrOVY0SnBPRFJXWVYyUEhXL1FVNXk5V0xx?=
 =?utf-8?B?cGZzRmNnc2VlelRTc0lxdzFuM1pWdzFtVk44OWF2UG1BSTBub1d2N3JHQnhx?=
 =?utf-8?B?VU16UE8wWFZDK09EcWFUN3NuRXROeGVrSzlNMUtxSEhPcm9ubGRSdXlUNU5Q?=
 =?utf-8?B?TkYzN1ZXMm9Fd1VCWkM3YzVkb2xVMnJJcVlrcjdaUGpBTVdBYW5DR0lTcXd6?=
 =?utf-8?B?dGVReDVMVExsK05JUG1DKzNGRUJTK3hGUEJVcFlOSGZPbGVQOUJadEV4eC9W?=
 =?utf-8?B?SlpJN3ErMWZvUS84NURicTJBZjhGSVhSOU1XelFzMjBLNkk2NVBOdXJDR0Vu?=
 =?utf-8?B?WUxheDZXdHVybGdORW9CWVdMY2t0cFZrRDJ3QUo5akNlWitJWlovaVRLdFVD?=
 =?utf-8?B?SGF6ejFjRm1tQkUvelJBUFA0R1pUVzZCSWRzOGV3UHp0c2ZZa3E3WWpiN3hJ?=
 =?utf-8?B?S2NscHp6cGN0RVY0MlUxZlF4bTgyQjZYaHpGczFrM0I4UGNkOTBhQ3NoUHdB?=
 =?utf-8?B?N2t2VUhVb1dtM1NnenRTUGlud0hoeEN1OWwzVzYzbWV1c0dvMDVFM3RXYk9T?=
 =?utf-8?B?WC9kbTB5M1ZQWmRUUEVLUHc0TUs2TnZ3ek9UaTkvVG1sVDZRTWFkMm1ydldz?=
 =?utf-8?B?QmtBY1BFS0pNbnR0cEpKY0MzbjN4eEt1Ujg0VUl5ZnE4dFBYaVRHakZFbDBQ?=
 =?utf-8?B?aDBLajdwWENWaGZsc3lpNjdPdXFnQ3N1ajVwcndhY2lrQ05jRGJUeS9vMHFN?=
 =?utf-8?B?c2E4bnhzYzdieXZrM0pLb1Q3SXBtLzZEZjFUazNBRnMyNHBLdndrWTBZeWpR?=
 =?utf-8?B?RzZ3UmZWRE01VUNRSkhtTVB5THZJRGhKYjgvU0VBUVlyRURjSk42T0JCcUpC?=
 =?utf-8?B?Y1FrWFU0bXRRQ3FhZlA3N2pYMjlFaWd2ZERVZkxvcFVpZHlFbEVzcTJIblFp?=
 =?utf-8?B?V3FFT3JzbFFUSmZpN2ZkekFDRXdFcjlncG15MUdvR1VwNU9RdDFyYXRTZWlJ?=
 =?utf-8?B?V2ZGd21vS0hLZmNrdWVGZEd5NndCM2xpazBWT2pmQnlZcm1JbFIrcVlzRTJF?=
 =?utf-8?B?ZUUrYTJqQ0c5T3VzN3ZYc25mNTUxV1gzVHdWZ2V6YnRkdlRBanJPcHd4Z2Rv?=
 =?utf-8?B?SmZxckhCSE5lVVlBdWFNZ09ZYlU0Zy9nT2JoT1hFQjVwSVhMWG4rbSt5cStH?=
 =?utf-8?B?citEa29INy9zTndmQUE0NE0xK1VrZVZvNmFYWW82ajVMRHZFL0R1ekhPbEJD?=
 =?utf-8?B?N3dnK2ZUYmtGMGJFeXRrTDJSblhRSWZ6QUE1Sjh0bjBMNnQ2ZDdhVWdDeU5N?=
 =?utf-8?B?aWluZjVZazExbzg1MFBkQWp2eDhyY1RZWUtHT0tTaGlFaHcrZEpGdW1aYzVK?=
 =?utf-8?B?ZUgrbUk2NFNGOFhMTWdPeGNqSjhLdmJhSTNrS1hPSHloVSt1TTBPbU0vbmNq?=
 =?utf-8?B?UnA0NTRZaUhJZjV6MXhoZ3Urbkh5R08xSFVYUlFFNHAzY0RXTFR6aHpiUmRn?=
 =?utf-8?B?MzBpWU9yL0ZvVjBld1cvYkpudjUxTUhodHFLYVI5TEpDeDVXZm9jQVZFOW9I?=
 =?utf-8?B?eVRacHBhNTdZV3BPSWJpZjBNbVR4d0dTYWV6UElFUllleTdKNHRJZm52M3kz?=
 =?utf-8?B?akFzeWg2ZGVvT1pzdWZhRkFKUDNobWxMWHVSa1JiV3p0TTFHZGVzb0grV2RM?=
 =?utf-8?B?YThKTXEyc3ZSenI4dDMzRkY1R3R4K2ovOVJEblQrdGFnZjFsck91VUtmM1o1?=
 =?utf-8?B?bjl2VHlRR25pQ0tDWEFHZlg1bXNVQnowSk9TYjFxTHpyV2ZtTDZpeVdZNXor?=
 =?utf-8?B?R3BvMFFsUTdiZkpTdmtjVy9uZGlOSWdrQnRacXFPUlhrTzVXT2VyRThKY0pr?=
 =?utf-8?B?Q243WUhIbnp1ODJzaGJKUFZzVm5PcmRvRExzc2Z0SlFxMXlqN0YrUTR2WG9W?=
 =?utf-8?B?dTFWa1VhbzgvVlZHLysxbjBBSnV0ZWdyeEZhbjh6OXZEUGJiYW9mbGlMWGVi?=
 =?utf-8?B?b1QyRm5lTnBiTUtRR2dUbVR4S1crRnVJV1k1ODVFdndIMmlKd0w0aHVqc29R?=
 =?utf-8?B?ZkJvZ2I5Ni90VjJsV2llRGVlZXVzQW93b3JjbFJnVk1NUVFkMVBRYzljUlBu?=
 =?utf-8?B?YjFNR01JRkt2dStsU3p6OWpmMmJxRE0rdzVsd3JKVTRUbWJnM284RW5GRkxj?=
 =?utf-8?B?L2lqeHpFenFFcFpxWm5ZbXlMT3R2cFh0TndFMForZm1WbDVKVHZrM01MNzE3?=
 =?utf-8?B?enVsRkkvN25ZeFFaVkhpaW1ZWHVjdTROdkR0SFl5VWtTbmdFMHpLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d020e880-ac00-4ef4-4a14-08da492f568d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:14:49.3861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RSnthSByMd1YgGTal1uX5FqE+Byc3Q4tMryF3b3dfiphG3QqbcaVRRvqkeZFZw+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
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



On 6/8/2022 2:35 PM, Kenneth Feng wrote:
> enable BACO on smu_v13_0_7
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index fb04d82f66e6..f57710790b8c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1456,6 +1456,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 5):
>   		case IP_VERSION(11, 0, 9):
> +		case IP_VERSION(13, 0, 7):
>   			return 0;
>   		default:
>   			break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 7da42cae5d6e..dc614befcdf5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -97,6 +97,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
>   	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
>   	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
>   	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
> +	MSG_MAP(ExitBaco,           PPSMC_MSG_ExitBaco,        			   0),
>   	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
>   	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
>   	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
> @@ -281,6 +282,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
>   	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
>   	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_PCC_DFLL_BIT);
>   	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
> +	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
>   
>   	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
>   		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
> @@ -1584,6 +1586,11 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>   	.set_tool_table_location = smu_v13_0_set_tool_table_location,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
> +	.baco_is_support = smu_v13_0_baco_is_support,
> +	.baco_get_state = smu_v13_0_baco_get_state,
> +	.baco_set_state = smu_v13_0_baco_set_state,
> +	.baco_enter = smu_v13_0_baco_enter,
> +	.baco_exit = smu_v13_0_baco_exit,

I remember seeing this one -  "drm/amd/pm: drop redundant declarations" 
which drops smu13 baco common functions. Is this in sync with the latest 
source?

Thanks,
Lijo


>   };
>   
>   void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
> 
