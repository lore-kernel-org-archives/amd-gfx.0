Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30400C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ED890D88;
	Mon, 25 Jul 2022 21:19:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FE290D88
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvPgiGKspqgoDXhzY+uzp8f5pAaxzWZXbzlxF+ZnzwMqN5Q5d2XuvJUrRN0vRVcrnHg5qIxGeDYfKkF1NuIbePvwaFSgnOqyouQl/SfKmC4jaE99s5KCJIp5tW6J/q9fqsxCwcylaYZAO+TrWwOQfaArpDk/kqenT++2OXZRmga048DJytyI7Q7DhuYhYfTu2uePMYCRti5BF/vsQDo+5DNADjo9lA01398CFhStc44+kU9h+aO9em0XfhkBCd5T3E5rDiOKit3/4+9EvzyaI/UbA2ScTbjsLQubjL3jwHMLSO5baiaptP6w7DR8WshFyOw1OYa+j4Gmh6RfP7kUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrwvurE5gdUtFvRvQwcXiZJQC5maqcekkQuInAbIzA4=;
 b=JRAG8S5TJ88n1gm3Z1kWY7ykH7P+Xt4vB9/rw6zkr/dWdC9QC02zc0ewbxuVRxWC8Y1SX3IPSsBMWiZUYisvOyBiy+M/EO4zsDekGwn9APktR/ceSZud4iVWx2Mq3SIalIBRdqcJSDgsH1SrXpKdvFFV90FulZIA3DBVjEVlUPqyIO4vgBxqWNrguUGx8oDRyBVX2r8dCJlPT7LeYm4MqkSdSjASKYOn6f+E7M/jdvo0fzGFUEFAhTbXvIWG6v1aL25gUIBMVdeq6Xo6ddmDj4b2lD0XFmntnIzZIPgeqY6b1iLhwy4bU1V0SaYF3AAmQ+H5iaDYNF7HnMNiNQTSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrwvurE5gdUtFvRvQwcXiZJQC5maqcekkQuInAbIzA4=;
 b=tiIXzK3I8sVJE9ZLlj48MERjj2CwDMupQsABnTjYFT9xzgrZjRZsRXC7WEZB0KRc9D9JinJMI73E7KBgTru7wbgJHjd0ubZxyolNL7xIs6yRayJW2woh3aBGzGk9+USb4G3TMUD+fCCye7etQimt1Z2avt0XVpg+kZbPjifPlOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:19:34 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:19:34 +0000
Message-ID: <fbc20b21-8653-b162-fae1-76b8ba5cc3c4@amd.com>
Date: Mon, 25 Jul 2022 17:19:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] drm/amdgpu: revert context to stop engine before
 mode2 reset
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-4-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220722073403.5171-4-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eec6e3e-5894-4d40-9f92-08da6e835f16
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXpEkz2WLoJ7BBnCDyVFrHjtqAzp0fHWgmtNKZSyFrnZv6T7ZcS5LWVtKC8hGdAcF95ZTRZhezwnFn+fosxAyPlEh4WWiBXcsk3Hb/2qdIlIln8w+06fDdcMqEajNWEpD7Jjcx4Q+lIlenUaeXJ4TRHMDgf+FzPJ5JrSyHG1YRvhJB0O3GRgsXNPj62lvtrvI3EvqAYZGd5tJpXkwXiwmlE0+PLJiHxgcrXLBZf52B+Fn74kEdMKIARJgIHr6SQ4DEkaRG2+B0w06k8e7xtudeAWnJ0rs+7RBd88CUuWV5Q/JKC4g2ogtaqB13Z08QFfSbusUQJYHYIxofiYSJQwSziAh6q7EBZZTY+Sr05Z68Vu+56wD8DesWZrsWiPCraGBE/9sjf2PfAG+tWSJWIFJxDJKL/FqBD7EQvxRNB/HQKICNwySfIO1+EMTw/4sK8mm4tscw5/RPnWtUbbf3/taXyiuwDnGmZZhT9W5z7WtJdds5RVtcy5VBZBqEQCpV98pqgPXPBbh5Co3uXyo/AH7HNkVB20cyoxToKICy80lxaviPman0mBGnAS9sXSso2LfMLUHZGHbFPrDkur56pr9JFVwLMHh2LQtMgpxI+lipdUtz7K5r6nCCD04Riy/gPNx7b21VTv1O//D+zww410W7gmuhu7DZ3Ab0grp7cEL0jdUXvszFgXadJ98kQaLMWWZrsdKZ0XL6y+AMxXHwT903sa0Gcwc/1jDojx8OHQjNsn0t0cXLFq1BWzxsx3GRPMResV1So+fkqE5LfMMU8XxG+Y2rdnCHgC1rzSAMizacEut5Ki000nIx4ZzrZnfW3AWjj2Aajpmm+WNIlHLGc1WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(6486002)(478600001)(41300700001)(316002)(2906002)(66946007)(8676002)(66556008)(66476007)(5660300002)(44832011)(4326008)(8936002)(83380400001)(31686004)(186003)(38100700002)(2616005)(53546011)(6506007)(36756003)(6512007)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZsKzlhUmpiWi9XVXJaOXlubTBlcm5qSW1mNE1laEpWbm8rMmR5TDFzOTVF?=
 =?utf-8?B?cGtvN3ZzZ2dBSEZxNDMxd1ZFQmx3UndQajdwdXJ0c3BJcTZmOTlQS0t0MThw?=
 =?utf-8?B?dUczWmg3NWdKQTFxcmw3SVcyS2VEc0FFaEhCYnYxd1pQMjNhdnFyQVZQL0Ey?=
 =?utf-8?B?dWttVERjRGRuNHQxYW1HZXVNUDJwUlF2SDE1V0JDMVY0aVlNVTVtUW95NlU5?=
 =?utf-8?B?UkVGMTJkY0pGMzNyeGc2RTZ3Zml5YVZ0ZHg2S0N2VldtR0VCeEtmQVZRb3Ns?=
 =?utf-8?B?R2xjdTBLRkFlZGtYelcrQUZoeDk0bDAxbFltaVZyK0RMMW8zcm9UTzREWGh1?=
 =?utf-8?B?MjZTL3JVNU5GWFdJbjhtdG9aOWVRcjFoK05kRUVSeXZNZ3J2TTZUZXZobzVF?=
 =?utf-8?B?aXRuL1gvSHdOV1BsOC9mTnVpOUZvaDFabVZVcE0wWjZXTkJWa1JLeFJXUXJP?=
 =?utf-8?B?Z1FNcDlrNW4zODV6T3U2WC9IWVdxbEVpbU1OdW9KUHF4THFRM3oxVDlyRVNr?=
 =?utf-8?B?M1BDOUhtRGl3L0hYS3BrdlIyS3NyTGE3TFdEdUE4MmFZSWRQMDZia3JncjZK?=
 =?utf-8?B?T3BPWGtZZ2NJNFphSzl3NUpMZzFyMERlV1RCTjdoN0JhcXhCRHFqYUVvOE0x?=
 =?utf-8?B?TVlxOE55NGFzNmdJL0l5U21zanRYNnF4Y0diSXhYUm5BM0RhbVZIV3VzSGZn?=
 =?utf-8?B?blM2VG1wMjZWbUxTYXVLQnlwZVFteFpTa0JlNVNaaXlyTldWZVcxbWEzY3pC?=
 =?utf-8?B?Skp5WEswWjJ0SExuaHIvbkp1bGtuNnZqTml4bkxYdFo3RUREbHZqbXMrS3FF?=
 =?utf-8?B?dkNpYUlBbjU3Q211M1dydCsxTWdtWVdLd2hybnA2a1U5K3lWRzRwRXNwakIx?=
 =?utf-8?B?V1VnR3NIMzc5ZjdCd1BnM0JKb0ZoQ2ltNVFqazBqckIwcE81cU0zczIyWWZ4?=
 =?utf-8?B?R1B5a2cyamdwWGoxV1p4aXl5ZHZGclg3TlVOdkFvYkdpZjdrMjErR3BaVHZL?=
 =?utf-8?B?d2JLck5wUCtzekkyMHpSN05VNFNwSzEwNi9MeU5XODR2d3dvUmpCdUkrVDQx?=
 =?utf-8?B?cnJpT1dTV0UyeXBHaHdlaUtmMWhKeVA0M21VUEdDaEc1S3J5TzJUcHBnZzRH?=
 =?utf-8?B?RGtqRlQ5REZ6NjFnd3YzWjNPbGR2V25kdUprcVNVc3FGa056NitWS2gwamRy?=
 =?utf-8?B?bEg5NDVDQWdUZHVpckNjc2VpOGl3RzUrWm5WNmtRY0ZiNHF3WGU1SitVbW0z?=
 =?utf-8?B?ZTR1NmMwUmJoc3VuUFVDNW9HVG9lSTdoaGZCUEZ0bEtrTWQrZE5CbUIxUUF2?=
 =?utf-8?B?a2xVQStHa0d6ZndGdTBVQ0FBcVN3WFpJdlRSTkluOXNnOE1mdnZEWVFqL3Rj?=
 =?utf-8?B?UC9JNXA2RjN1cVRZbGk0OTVOdDRuT1JtZHdvTG5wTlAzNjJaWGxpM0lGQWpw?=
 =?utf-8?B?SUc1TTFML0NEc0F4cWUwY2dGVFhFRFBhWXJyZW5YQ3VtWG56MjMzRkVFeTl5?=
 =?utf-8?B?Q2tMNkFNSHkwd2VIYVpFbG1MMlZjckdzVzFETkxlY2hUQVdzVEVGbnRYR2Q5?=
 =?utf-8?B?QXBGUzR4bU14TXdPeUt4eE95S0tjVWJvRmpoODB1cmY0cXBsTEJ0V1BhVzRH?=
 =?utf-8?B?UnRwSitPL2tlRzBFcm9TcnByYTNYNFhCMTJtYmF0Z2dwY0VzVCtsNkNUWGpn?=
 =?utf-8?B?UnFtQWRPS1ZVVHFXV3hXTkZmYURxakRlOWQ0bFBOdnZlWGt0OTdDUGJRZitm?=
 =?utf-8?B?dU13M2VlVXk0OXM4ZmpHczFENHJzT1ltRHFvSUhzSi9LUUc3ZUJheXpTV1hE?=
 =?utf-8?B?T3hqUTBUQlYrMUdidnlwUFFmRHN6aENFdFloRW9oZmNHamRSVXNDUDNFUE1j?=
 =?utf-8?B?RmMzcGx3MEdSR1JqcXZPSkVjdWFDLyt5OTVmNFloWmp1MTljNVFCa0w2SEs5?=
 =?utf-8?B?SGkvcUtqQ1dSZXZuMWRNNW9kODQ1RXYvWHRsU2pKM2xxWFFjOTVpQVJ2eGla?=
 =?utf-8?B?bHFiZ0ZITGw5YkdsQm56Yk43bzd4ZXdMb1Nxa0dtQzN5ZVBKbGxxbGNYWlk3?=
 =?utf-8?B?WU56NGRDTnRVSFVJRVhPWXpGWFVWNTA5TlliZGIzSXVaOFltUzB4dkp0VjRy?=
 =?utf-8?B?clRVN2ZMQjB5L2RKZWhEVWNieGh1eGYya2MyNFdJUlJWQXVDaEsvSWZsSkd6?=
 =?utf-8?Q?7ji3JLM/HeIzQ9ai/jUAeL8C72dZUGDlCWVtIpahthGW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eec6e3e-5894-4d40-9f92-08da6e835f16
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:19:34.2685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OphehC1CIhT7hdLT+K17vlJJ6pSJmkIqc0ewGGwrkRrebxHh/2LVzx8V4QSvQEpKYFcAoeesfqIY8vIEw3CWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-22 03:34, Victor Zhao wrote:

> For some hang caused by slow tests, engine cannot be stopped which
> may cause resume failure after reset. In this case, force halt
> engine by reverting context addresses


Can you maybe explain a bit more what exactly you mean by slow test and
why engine cannot be stopped in this case ?

Andrey


>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 36 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
>   4 files changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5498fda8617f..833dc5e224d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5037,6 +5037,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>   
>   			/* set guilty */
>   			drm_sched_increase_karma(s_job);
> +			amdgpu_reset_prepare_hwcontext(adev, reset_context);
>   retry:
>   			/* do hw reset */
>   			if (amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> index f8036f2b100e..c7b44aeb671b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> @@ -37,6 +37,7 @@ struct amdgpu_gfxhub_funcs {
>   	void (*utcl2_harvest)(struct amdgpu_device *adev);
>   	void (*mode2_save_regs)(struct amdgpu_device *adev);
>   	void (*mode2_restore_regs)(struct amdgpu_device *adev);
> +	void (*halt)(struct amdgpu_device *adev);
>   };
>   
>   struct amdgpu_gfxhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 51cf8acd2d79..8cf53e039c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -646,6 +646,41 @@ static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
>   }
>   
> +static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> +	int i;
> +	uint32_t tmp;
> +	int time = 1000;
> +
> +	gfxhub_v2_1_set_fault_enable_default(adev, false);
> +
> +	for (i = 0; i <= 14; i++) {
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> +				    i * hub->ctx_addr_distance, ~0);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
> +				    i * hub->ctx_addr_distance, ~0);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
> +				    i * hub->ctx_addr_distance,
> +				    0);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
> +				    i * hub->ctx_addr_distance,
> +				    0);
> +	}
> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
> +	while ((tmp & (GRBM_STATUS2__EA_BUSY_MASK |
> +		      GRBM_STATUS2__EA_LINK_BUSY_MASK)) != 0 &&
> +	       time) {
> +		udelay(100);
> +		time--;
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
> +	}
> +
> +	if (!time) {
> +		DRM_WARN("failed to wait for GRBM(EA) idle\n");
> +	}
> +}
> +
>   const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>   	.get_fb_location = gfxhub_v2_1_get_fb_location,
>   	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
> @@ -658,4 +693,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>   	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
>   	.mode2_save_regs = gfxhub_v2_1_save_regs,
>   	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
> +	.halt = gfxhub_v2_1_halt,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 51a5b68f77d3..fead7251292f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -97,6 +97,8 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->gfxhub.funcs->mode2_save_regs)
>   			adev->gfxhub.funcs->mode2_save_regs(adev);
> +		if (adev->gfxhub.funcs->halt)
> +			adev->gfxhub.funcs->halt(adev);
>   		r = sienna_cichlid_mode2_suspend_ip(adev);
>   	}
>   
