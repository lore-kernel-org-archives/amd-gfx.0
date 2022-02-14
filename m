Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1360C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 04:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D28B10E1FE;
	Mon, 14 Feb 2022 04:04:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0703D10E19D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 04:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7dbfqntcJJ8QV72BwdVHrNjAZ4SNy9jVzIKthdIWX92Ypvsoc0MsOuK9jjs+1ztiC4ERoitfPh2ekyGWnntzDutOL8UKihGww85LG0WmCbvQqItrzs34sjfDDKXMqJEMvHdcBMnqnLqkTKgmn9++NVhVmzI1p1InMABdwkFmil5z+GHxyCIPdj0VPcZgVc+ARsfIK9UXDY2JWa0a3TGWItZgm5bAMgho1QN7CEwODpqM3n1bLXLK94mSExGOckBporySRgLdkf5yyPlT1TJTQIViqAy3jIrrS5/D2QP0ryIUOwvHEfOfnAU5Odr7cMrlu9/mI8wCbNGbT3pFj+M8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmd92jJ8kzognys4v3ZtxeeVBrRJXltBo5YcPW4ZqNQ=;
 b=QiBQfFoGqpPxwuRuu/i+AXkt9ZLD0f6nvtojSU+EiZQRvB1k1N6ZU/nADzp+l8O0nRJCBJs7aL44N30Xy8s6Ip3EzW4gzyIJ/RDWL4uyATvKwsVU8Llxb/JreSnUv/XLQS6sdbhhOEjB5pAD+50jNeoji2lyXJ7TXNK8BKovpYglyYp3tFgY0pHJX7QONp9i3t9+gK50elEPrVnSwCLNzG4UbN3L9J7fktfkdHzQZ/+YTpPuYUEda0eOMNwvPJJvsXuOuNsncOzEAAxa3IVZmZyTQPgneGaBhFYaACLYyor56snZSl5PZ2B86O+ep0JREQLKKGXwOP0dKQbdyOZetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmd92jJ8kzognys4v3ZtxeeVBrRJXltBo5YcPW4ZqNQ=;
 b=IACyfIrw19qNH9f4j/MfHOzxBP/nQ0lrOncvE7lVYaf87OUK6wvYXrKsExaaw6j63morz4cwDPW88A/P1fWj5lCPE06xFRJCuc/eOB5FYlnwrpob6o1iiE2TWDIlTeNKe1SLKGJpiPQyGvp451ghskxQki/2uvTnBa1e3qagugI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 04:04:32 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::18e9:a59b:dd5e:c819]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::18e9:a59b:dd5e:c819%6]) with mapi id 15.20.4975.014; Mon, 14 Feb 2022
 04:04:32 +0000
Message-ID: <80a49c9c-77f6-5047-6584-da24f49596f7@amd.com>
Date: Mon, 14 Feb 2022 09:34:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 07/12] drm/amd/pm: correct the checks for granting gpu
 reset APIs
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211075209.894833-1-evan.quan@amd.com>
 <20220211075209.894833-7-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220211075209.894833-7-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::13) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e60a012c-9127-4eb4-c9d2-08d9ef6f1ad4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802170A01A822937686511B97339@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSw3G0MDXMzjI/5MdL8j7CHB4tdhBvufDmT9F8uqwaXwN/rcpbW2p0Zo7IPxzH/N1iTAKZT0e6k2SWRGA/YjcHkkXdh4kzPFyNyOD8eke8obVZ01gcsTsCEFK/3j4rhTVD5kOSSsOSIvUROQ9N0+ROJI3LgTPGPK4qf9pocfF5anSZwn4WDRpEt6xB/iqU+IJqQQM7VfFWyLlmHxAgdM10kEDEkzatswkwDiERgQ/V6O7hJzVMyKi/HSCMP6UdJTkvwtUqChPJRFmH3TWlNeo13ZjkXlmZ7RCrDOspSk8SC8BTFs6OzGURE4fF59pzzjRH/iyDfzeeOVXUPD+qqSkvMMPm7NxmkzLkk8stn2/k98ZeH3mcKXjwDQ6TCr9aBZ8qg4Ri9IpU10zsCxra654a6W2GPtTXbUD9c1yXV7gjKGJhd3mKRXFEKzeU/tMCKa+4lDBDGukgEDrT0U+DYyvnLcGyThowcHvEWxuRwO4cgCxpZSuwsb3hGxlk0ZbYFSBT5l6Qu3UrAePPxJ3a/EdjDlqWHheZsfuBnXgp6UkWaCUennVkW1Uf6nWROu1r3mGTxlpUW5NrXzJBj2M447xhH0YTKo33Dtp1AYQMwIzC6rz1Ka4lFercw42YmdACqE6ADdmHE+ntfNbgtnVbpNnzXKEx2zv5ro7OtzxEBjp8eigZZq30TXw2zs9ziGuqYZAmXtTKEDcCpq5zAAiogsDO3JNBZHYf9oUZxFOuKQbYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(508600001)(66946007)(66556008)(6486002)(6506007)(186003)(66476007)(316002)(5660300002)(36756003)(8676002)(2906002)(6512007)(31686004)(26005)(2616005)(86362001)(83380400001)(31696002)(38100700002)(53546011)(6666004)(8936002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGt3ZTN4M3lkSHh4bTFDOFpRWXg4VVl2TGxMTkNlTE0wV20vWFIrenVsOEc5?=
 =?utf-8?B?ZDNZTEEySkFHQW5XRWhOYTFoWUk4aWtLMnErR2tHMTJac2QvcVB3NlMrdVQ2?=
 =?utf-8?B?L012b0F1OEIrTlp1SElnK1RVeFl6RHgxaGx3WWcyNjJ4OGE1NUsvMFZVZlpj?=
 =?utf-8?B?UFk3dUFBS1J2cEVDNitqeVRSNk4wQTlkK3MrMjFKdENSMnBJU2ZvbXNJdlVI?=
 =?utf-8?B?VXBNTFlaRzBaY25MeEJQY1Z2Y3pUNDhZdlZzZmpPQjdPcUNzUUxha3poSFdI?=
 =?utf-8?B?QktpVUJrc3RMczRFYStUSHVRbUhtaUNITkRPMmdHWHhDVStHZmlRMEdBSDE5?=
 =?utf-8?B?NWNMTXdramxybnhKSnMza0daQnM0V2J4azgzQXRNTS9ncnF2YnlibnhCOE5K?=
 =?utf-8?B?SVc2azFtZkdpM2xPMk1qVThBUFgxRUdaSTV6UUJmb3dxZVI4dXBoOUNKRFhz?=
 =?utf-8?B?Rlp2Nm81UzA0ODUwYml4OHl0VklmVVVEcW5lSExCeVBaN3A1RTJtdXVKNWtV?=
 =?utf-8?B?VlpFQVRZT3lUdnI1alJMVjVoR3lJWEZFY0dQUG9sa2RIbWFuK0J1MVNxbWlU?=
 =?utf-8?B?SGh6ZHNsRXQvbFN6dHVNSE1DSnRhVGNyL3IrK1ZUd2ZPVk8rQ2dldHllMFFN?=
 =?utf-8?B?bW9DYnBTL2NTU3FxZnVNTWdKVmdqdWRMWWIzZnZiUFEwMC9SMUQwSG1ndTU4?=
 =?utf-8?B?Zi96dUUvVVlGVGR3Y0hjQ3Zmem51cUdQbW5YUXpJeGZESzlGdDUrZkVFOVI0?=
 =?utf-8?B?aURrMEtkQXhPYmdkMGpEVlMzTGNhUUhhczBUcjZ0M1hoZlBPZU1WOU11Uk1R?=
 =?utf-8?B?akF5MzRicno1dW1mTFZwMGlqN2xKSmMrdlIxbDEzeS9URC9xb3Bqc3BiaUlO?=
 =?utf-8?B?ZmNHTm1NUW1wNklyRDVwRFFDTFd1NzJDamZhdlhYWi85Nm5Xc1N2WXQ1Uk9m?=
 =?utf-8?B?TlFCclVTUE5lSlBCdkVZOC9Za25mS3dFUVBnMEdHUXJiakg3TWgrNjdOQUJk?=
 =?utf-8?B?a2VHd1NXRjBjeW9kRzlidGRRU0gvMXN5RFZ2a09mb0hNM01RTk85Q25STHdk?=
 =?utf-8?B?ejZ2Z2puK3R3bWMzMFg3MnprSUYzOFhuTE5KWHJWbWNYTmtpeUl2a0h5WTZj?=
 =?utf-8?B?bnMrcHFmQzNqOWVPRkgvcUNrSThuandZNHZYM2ZVUWtRc0R3UmhId0czb0kr?=
 =?utf-8?B?VVNrc3hnY29NclZNL0ViTkx0RE50MkJHRHJWUndaN1JQcWx1OVV0d3g4ak4v?=
 =?utf-8?B?M1JIaTB4czdqRHJ6dnJxNmx5bUxOTjJlRWlmckNka2MzRXdyRmhCU0o1aVpt?=
 =?utf-8?B?ajhFMnJieUxlaVRHU3I2bHlJYi9od2JOSUlaZHp6eURWY1kzSmc1bTF2V1Jt?=
 =?utf-8?B?bUY2RmhIdWxIOC9RZ3hDYk9KT3BIV0phcGlVNlRySEFqK0pqZXM0VVNUSDVv?=
 =?utf-8?B?UFdIMHBIaEtvN1RQL0RWd2kwSlBac3lyd3ZRcHE2cE9QMUxXTDJaTExMT1hV?=
 =?utf-8?B?SVdCNjd1eHMwVmN1TzZGQTNsT0pyRkpYRVp4L2lucGxJYkluaXRQRFZQY3Yz?=
 =?utf-8?B?aGMxN1hzRUMyTHhXS01PRlM4dk5uVWgvT09NUlUvaVh5dHp2ZjhudmcxdzdB?=
 =?utf-8?B?V2RQMGdtdUpZUGlFa0I4ZkVJckFLNTZ6RkpzRzVGWlZoZnFDbHREZGxOR3ky?=
 =?utf-8?B?a2tvM3NkbTZ3Rjk1RnVndWExVmY0TnRsazRxS3Fsa0hML2IrczArUENTcExy?=
 =?utf-8?B?TWEvZkVXdG5QdGkvY2laK1o2dThvMlBPRDEvQU9TTUxsVEpZT2NuSTFYaldN?=
 =?utf-8?B?U25JZTJpM1FCakpwTkpSRStRZ01kc1NuUElNS3Iyc2NmMGovTXNzOGtIU0Ew?=
 =?utf-8?B?S2lXWUpVMlFhaEhXbUVYMlNMR25oVUdHOUJvdHRvTENJRHBhRjB2SWhYQXVh?=
 =?utf-8?B?bFJRU1dMVmIwdEVTRFc1a09LT1JXclJxNWxhUERlVzNnRTJGWGt0V0NnREl5?=
 =?utf-8?B?VDA0L3E2dDdZeTFuZ3g4b2ZrNDFYMGpBbzZLcFBYRmVPamFPSGFtMmVNU21D?=
 =?utf-8?B?WlJRempiU2xna2dBUFVOcVdCVmtCRkxmRXlGSENVTTVXd0tkRmZGUWVJVjVm?=
 =?utf-8?Q?wABQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60a012c-9127-4eb4-c9d2-08d9ef6f1ad4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:04:32.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBKFY/OIXOm3p9MQ9IjVaG5hYeX+2zsP6LsMQnLhpIbzoaeK8pAI+4khbrit1LLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
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
Cc: Alexander.Deucher@amd.com, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/11/2022 1:22 PM, Evan Quan wrote:
> Those gpu reset APIs can be granted when:
>    - System is up and dpm features are enabled.
>    - System is under resuming and dpm features are not yet enabled.
>      Under such scenario, the PMFW is already alive and can support
>      those gpu reset functionalities.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I8c2f07138921eb53a2bd7fb94f9b3622af0eacf8
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 34 +++++++++++++++
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 42 +++++++++++++++----
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  1 +
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 17 ++++++++
>   drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 32 +++++++-------
>   7 files changed, 101 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a4c267f15959..892648a4a353 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -409,6 +409,7 @@ struct amd_pm_funcs {
>   				   struct dpm_clocks *clock_table);
>   	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
>   	void (*pm_compute_clocks)(void *handle);
> +	bool (*is_smc_alive)(void *handle);
>   };
>   
>   struct metrics_table_header {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index b46ae0063047..5f1d3342f87b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -120,12 +120,25 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   	return ret;
>   }
>   
> +static bool amdgpu_dpm_is_smc_alive(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs || !pp_funcs->is_smc_alive)
> +		return false;
> +
> +	return pp_funcs->is_smc_alive;
> +}
> +
>   int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> @@ -145,6 +158,9 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> @@ -164,6 +180,9 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>   	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (pp_funcs && pp_funcs->set_mp1_state) {
>   		mutex_lock(&adev->pm.mutex);
>   
> @@ -184,6 +203,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   	bool baco_cap;
>   	int ret = 0;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return false;
> +
>   	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>   		return false;
>   
> @@ -203,6 +225,9 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
>   		return -ENOENT;
>   
> @@ -221,6 +246,9 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> @@ -244,6 +272,9 @@ bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>   	struct smu_context *smu = adev->powerplay.pp_handle;
>   	bool support_mode1_reset = false;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return false;
> +
>   	if (is_support_sw_smu(adev)) {
>   		mutex_lock(&adev->pm.mutex);
>   		support_mode1_reset = smu_mode1_reset_is_support(smu);
> @@ -258,6 +289,9 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
>   	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = -EOPNOTSUPP;
>   
> +	if (!amdgpu_dpm_is_smc_alive(adev))
> +		return -EOPNOTSUPP;
> +
>   	if (is_support_sw_smu(adev)) {
>   		mutex_lock(&adev->pm.mutex);
>   		ret = smu_mode1_reset(smu);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index bba923cfe08c..4c709f7bcd51 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -844,9 +844,6 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
>   	if (!hwmgr)
>   		return -EINVAL;
>   
> -	if (!hwmgr->pm_en)
> -		return 0;
> -
>   	if (hwmgr->hwmgr_func->set_mp1_state)
>   		return hwmgr->hwmgr_func->set_mp1_state(hwmgr, mp1_state);
>   
> @@ -1305,8 +1302,7 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
>   	if (!hwmgr)
>   		return -EINVAL;
>   
> -	if (!(hwmgr->not_vf && amdgpu_dpm) ||
> -		!hwmgr->hwmgr_func->get_asic_baco_capability)
> +	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
>   		return 0;
>   
>   	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
> @@ -1321,7 +1317,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
>   	if (!hwmgr)
>   		return -EINVAL;
>   
> -	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
> +	if (!hwmgr->hwmgr_func->get_asic_baco_state)
>   		return 0;
>   
>   	hwmgr->hwmgr_func->get_asic_baco_state(hwmgr, (enum BACO_STATE *)state);
> @@ -1336,8 +1332,7 @@ static int pp_set_asic_baco_state(void *handle, int state)
>   	if (!hwmgr)
>   		return -EINVAL;
>   
> -	if (!(hwmgr->not_vf && amdgpu_dpm) ||
> -		!hwmgr->hwmgr_func->set_asic_baco_state)
> +	if (!hwmgr->hwmgr_func->set_asic_baco_state)
>   		return 0;
>   
>   	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)state);
> @@ -1379,7 +1374,7 @@ static int pp_asic_reset_mode_2(void *handle)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   
> -	if (!hwmgr || !hwmgr->pm_en)
> +	if (!hwmgr)
>   		return -EINVAL;
>   
>   	if (hwmgr->hwmgr_func->asic_reset == NULL) {
> @@ -1517,6 +1512,34 @@ static void pp_pm_compute_clocks(void *handle)
>   			      NULL);
>   }
>   
> +/* MP Apertures */
> +#define MP1_Public					0x03b00000
> +#define smnMP1_FIRMWARE_FLAGS				0x3010028
> +#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK	0x00000001L
> +
> +static bool pp_is_smc_alive(void *handle)
> +{
> +	struct pp_hwmgr *hwmgr = handle;
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	uint32_t mp1_fw_flags;
> +
> +	/*
> +	 * If some ASIC(e.g. smu7/smu8) needs special handling for
> +	 * checking smc alive, it should have its own implementation
> +	 * for ->is_smc_alive.
> +	 */
> +	if (hwmgr->hwmgr_func->is_smc_alive)
> +		return hwmgr->hwmgr_func->is_smc_alive(hwmgr);
> +
> +	mp1_fw_flags = RREG32_PCIE(MP1_Public |
> +				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
> +

The flags check doesn't tell whether PMFW is hung or not. It is a 
minimal thing that is set after PMFW boot. To call the API this 
condition is necessary in an implicit way. Driver always check this on 
boot, if not driver aborts smu init.

So better thing is to go ahead and send the message without any check, 
it will tell the result whether PMFW is really working or not.

In short this API is not needed.

Thanks,
Lijo

> +	if (mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
> +		return true;
> +
> +	return false;
> +}
> +
>   static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.load_firmware = pp_dpm_load_fw,
>   	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
> @@ -1582,4 +1605,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.gfx_state_change_set = pp_gfx_state_change_set,
>   	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
>   	.pm_compute_clocks = pp_pm_compute_clocks,
> +	.is_smc_alive = pp_is_smc_alive,
>   };
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index a1e11037831a..118039b96524 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5735,6 +5735,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
>   	.get_asic_baco_state = smu7_baco_get_state,
>   	.set_asic_baco_state = smu7_baco_set_state,
>   	.power_off_asic = smu7_power_off_asic,
> +	.is_smc_alive = smu7_is_smc_ram_running,
>   };
>   
>   uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b50fd4a4a3d1..fc4d58329f6d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -2015,6 +2015,22 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   	}
>   }
>   
> +#define ixMP1_FIRMWARE_FLAGS					0x3008210
> +#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK		0x00000001L
> +
> +static bool smu8_is_smc_running(struct pp_hwmgr *hwmgr)
> +{
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	uint32_t mp1_fw_flags;
> +
> +	mp1_fw_flags = RREG32_SMC(ixMP1_FIRMWARE_FLAGS);
> +
> +	if (mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
> +		return true;
> +
> +	return false;
> +}
> +
>   static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
>   	.backend_init = smu8_hwmgr_backend_init,
>   	.backend_fini = smu8_hwmgr_backend_fini,
> @@ -2047,6 +2063,7 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
>   	.dynamic_state_management_disable = smu8_disable_dpm_tasks,
>   	.notify_cac_buffer_info = smu8_notify_cac_buffer_info,
>   	.get_thermal_temperature_range = smu8_get_thermal_temperature_range,
> +	.is_smc_alive = smu8_is_smc_running,
>   };
>   
>   int smu8_init_function_pointers(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 4f7f2f455301..790fc387752c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -364,6 +364,7 @@ struct pp_hwmgr_func {
>   					bool disable);
>   	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
>   	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
> +	bool (*is_smc_alive)(struct pp_hwmgr *hwmgr);
>   };
>   
>   struct pp_table_func {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8b8feaf7aa0e..27a453fb4db7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1845,9 +1845,6 @@ static int smu_set_mp1_state(void *handle,
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled)
> -		return -EOPNOTSUPP;
> -
>   	if (smu->ppt_funcs &&
>   	    smu->ppt_funcs->set_mp1_state)
>   		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
> @@ -2513,9 +2510,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
>   
>   	*cap = false;
>   
> -	if (!smu->pm_enabled)
> -		return 0;
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
>   		*cap = smu->ppt_funcs->baco_is_support(smu);
>   
> @@ -2527,9 +2521,6 @@ static int smu_baco_set_state(void *handle, int state)
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled)
> -		return -EOPNOTSUPP;
> -
>   	if (state == 0) {
>   		if (smu->ppt_funcs->baco_exit)
>   			ret = smu->ppt_funcs->baco_exit(smu);
> @@ -2551,9 +2542,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
>   {
>   	bool ret = false;
>   
> -	if (!smu->pm_enabled)
> -		return false;
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
>   		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
>   
> @@ -2564,9 +2552,6 @@ int smu_mode1_reset(struct smu_context *smu)
>   {
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled)
> -		return -EOPNOTSUPP;
> -
>   	if (smu->ppt_funcs->mode1_reset)
>   		ret = smu->ppt_funcs->mode1_reset(smu);
>   
> @@ -2578,9 +2563,6 @@ static int smu_mode2_reset(void *handle)
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled)
> -		return -EOPNOTSUPP;
> -
>   	if (smu->ppt_funcs->mode2_reset)
>   		ret = smu->ppt_funcs->mode2_reset(smu);
>   
> @@ -2712,6 +2694,19 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   	return 0;
>   }
>   
> +static bool smu_is_smc_alive(void *handle)
> +{
> +	struct smu_context *smu = handle;
> +
> +	if (!smu->ppt_funcs->check_fw_status)
> +		return false;
> +
> +	if (!smu->ppt_funcs->check_fw_status(smu))
> +		return true;
> +
> +	return false;
> +}
> +
>   static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	/* export for sysfs */
>   	.set_fan_control_mode    = smu_set_fan_control_mode,
> @@ -2765,6 +2760,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.get_uclk_dpm_states              = smu_get_uclk_dpm_states,
>   	.get_dpm_clock_table              = smu_get_dpm_clock_table,
>   	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
> +	.is_smc_alive = smu_is_smc_alive,
>   };
>   
>   int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
> 
