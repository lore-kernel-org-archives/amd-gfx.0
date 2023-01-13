Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23694C3DA78
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 21:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A615D10E246;
	Fri, 13 Jan 2023 21:44:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC4910E246
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 21:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef6rRjuc2w1oV/TbhOmUp/zcF7n5dLEDHp3nrEbWhufbDFh9mZpDE37clvYgLfXZThNteZWknIaHmzWcVSsyCZUWodpkn/ZGh0uXVCul+w3TRg4miuiAmpB0sSIuI7q30O8gp7XdvW5TbHZhDlJGqSm3cewRHgEH9sGwggVXg8F7WvrNPTg9hfa4GCNt3GKXRO3IyA9qU3feEGnkhrJUkE3fSeK6rFXTDejVDE3fqGBrkq+qyOMg0SA01H8LPMknX/WxLCs3IOBy7dYpq5SSTaEPaR2m+If6RyNIs8CKUVGPUvcHa3UTGryk5q0899ZgzfFOwh9Ksp2wlxUQGYVHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlBPzYlPyzbMHSpy4Cw4W6TFd6cSXVfLYcb35BFDfG4=;
 b=HxuuF/b4o3OS10NupGKTNAzl0B+eHadfvO0FKOuMUeF+5vKwYW5Z4Bmh/LbQvAp+tq+l+ZSPsAMky/6NsObhpvR6Vm/uh7CTQH1bX677psItYuUMs1nXueF24t7U0PJ0kNMA9I6dyeHEdwd2VOZMfJyaSmQtFY3FWeA/OFwUHcZAYLEammrQYpAyhVB5KdRHLuOx09TszWBo3bhdaidJdj637/uGXiZjMdYV6eJ6nIKTappVKjh4f+5NtUFGr7FK0wXvUN2LWrBv/ZfLKlLsbDMAIVLlZX5kNziJ3GmXyYbv3IHsIEkB9y+BmbvPBrWYGllVsWZl3ztzTBUSSb9rAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlBPzYlPyzbMHSpy4Cw4W6TFd6cSXVfLYcb35BFDfG4=;
 b=TMYdt+AAMAe2TxzahXgz7gs1y6c2hJV/X8yhMC6TLDlHd4hljAIZkEwlg345UolfTvFo7aG+ly4J2eeEuRvJZXEkRac85OnpsqV3jpicXIWkHG1SH/rVjNjD+KprmiJJi0CFeejkyf5wt+65gPgyrMe2VeJ1DwK358Adlw0Y32Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 21:44:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 21:44:07 +0000
Message-ID: <cfe9c792-0361-bab0-2a02-ca2f50b57b94@amd.com>
Date: Fri, 13 Jan 2023 16:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Support process XNACK mode dynamic change
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230112211829.20095-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230112211829.20095-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0067.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d442147-06e7-44f8-8cb7-08daf5af4c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nc04b6Difd/1YLK+qtsXD7hkOBOj2Ot99teZTG0pojFyRqwscA9SKEjrIQQ/b1JH7SStKTYJMexa2xDqFtvqggPC+W5uzbqe7NrqNdlUFzH0Agbqnz6Z9ws6bviUWocyHxYp5tbUz955Qy80H1H0P6xacVU0YoKsmEzAEeRJ0f9xaizp31rxDi9dELaaXYTFZwboXx1HszIWn0M7k6FFPNzW2KBpqMN+oMwJbUgmXG1BpYP3hAj+gUV8LtFscXB3BqABir1TkgubTSK+ihEt+6OEqBN8y+xjwDjjTeSVOBLd1oSt1C4ywRlumj62P5wM/Bo19I0uXgGOBUm2p5ZlYiTHkLOwoCSBG+UwFzU/Kt/7tsc8jhrw3iPXYeG0mAsZHpaDIMJh9oPHXbwhdh+3Lfz6/CfU7Wtjnz/YKma2ajZQLxI3bKdrzNaZ0TXZygjw9mhDXWZtt6kByHbGmIIuNUniHV8la9+xeemCHR1m76vsVlprNX8TFEBF5sVbyBBdt469hRm28GFBDH7RPWBeg0wdRPDaqJX6u4P4e0i05nUdbLIwwI+tBLLU9hltIOE3jGZGJ9FjFDcJy/gd3XokhZf3AbvoLk58Xt95jtZj94OKk+Nf1aICRp646ZcfMI2qgAaRcXnNSxexq5WO5WJlHD3HVE0cjx2Am3WJdruhUKjq4yu8GRj/kGpS0je27OeaStNuaW9/VGEWXxoeu5UGcyXA0zbILfSvSCC0gWMriZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(66946007)(66476007)(66556008)(8676002)(316002)(36916002)(2906002)(8936002)(26005)(5660300002)(41300700001)(83380400001)(53546011)(36756003)(31696002)(478600001)(6486002)(6506007)(2616005)(38100700002)(6512007)(186003)(44832011)(31686004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1ETjRDOTJNSExsN3BhT01QME1kbUtNVXdWVlV1cE1GekJBeTd4VHRNMmM1?=
 =?utf-8?B?UW9hcXRQVlVJQ0tid1F4OTZWa1FmUGljUUtHUzdPN0x2MFZhS1ZZd3grQkZz?=
 =?utf-8?B?WmYwcDQwQzRmSGZQZmVUMEpKelNiWWlrK05jOWNFc3ByV1FCbU54aEFtUktl?=
 =?utf-8?B?NngvK0MzeWZMNS9VQ3h6SUlqN1FmS1FiNjNhaFkwR01uU2xRT245TUxFbUtT?=
 =?utf-8?B?d3NTV29YeW8wMHBVV1RtRFNQSk5ZUkNMT2tRenU2Z0p4Ly9UTE55Y2JmYWFx?=
 =?utf-8?B?ZUVvdmV1UUlqTUtHb2hjQjJ0NGR0L25IMDVKMlJJQ0FmbWFqZC9sc2laK3Yx?=
 =?utf-8?B?NEhBYkx2b1VZbEdLcjcrQWhWU0tCckRUMStEWnRyR2d0b3VIU0JvbmRPNEVo?=
 =?utf-8?B?VTBQR1BNZmlkTXFENEFIU1J1SjVwaVErcDBKVy8vaXNoZUhKRTljL2hsKzk2?=
 =?utf-8?B?cVV6cjdScWR6L0REUU1aNkVzWTFyMTJGQ0JEVXhtaURodmdhUTQ3YnNpa1BW?=
 =?utf-8?B?aFZPU1Fmdkx2R3RSYXJncTYrakhSeU9xYUVqbGs3b2pUODAydFpIVzJyQWFG?=
 =?utf-8?B?akUxbW5taE8vOEVZY3BBZnMrbHpqa21lMVZFNEgwcGlLb0tKOGxlcEFESnh4?=
 =?utf-8?B?WHc1S0JYdEp0NzJrVEhIczZRc2NiSXpUY3RyaTBaVUc1Z3k1TnplK3VmbWdL?=
 =?utf-8?B?dVJrUzRoODBzN29WMU9SV3RLNlp4SDRPLzdCa1g5UGczZFJsbHBYQk5kcWNR?=
 =?utf-8?B?UDlBKzNkVkJYVU43MGdObEF6MGVCR0wvUWRwV3NhVHFkYXE4Q3VKNWVjWU9o?=
 =?utf-8?B?TTc3UXU1MDRpS094Rlp3cXRuR1VXSTBFbW1zVFJHMVFIQjdaamV6Y3RhdU5k?=
 =?utf-8?B?OFRlSWFaVmNSTDVHU05XeXBCZFRPSkVUTmxpcWV0VmxNVzBVVVdYTER5U2M3?=
 =?utf-8?B?NlVzaEZ4NXJ0OFAwSUpUV3hpRTZUNTY1TTM5RGlTU3pLQll5UXlqVzZnRWlS?=
 =?utf-8?B?NXlQc3J0Y1J6dzJRSTVTOWp1Y2NiSjRnSmZpZk9IVUw5ZmptRXdnNWxZZVNx?=
 =?utf-8?B?QWgzZWVYQWF1SjFPdDhzWm9pM1gwTjFOc29hTUVLVG1FdTNBbnkyRGJyRzhk?=
 =?utf-8?B?YlJmK09zZDYwUXdxR1hFVkpqVDNlZzk3eFJsVXA5djNhalVodWhhMVJ6ZUdV?=
 =?utf-8?B?RTF4Slp0NVljOEtJd3F2R29YemJyNndNWUpkMkNKaVJrQTI1TEh1aUpHVzJw?=
 =?utf-8?B?MWZEU2gwYVZIQlYyYUFBSXNtTEcyMVl3NmhZckJqTWlIMzdRZ3QzUTh3UjVY?=
 =?utf-8?B?cmtxT2d0czJmeFYwN1pMUk1ERWt6YXArcElabHhndTk3MHZrc1h0TzVZaENL?=
 =?utf-8?B?R21lNU1BS3UvVnlHUkZlK0VtZXNsUHRlZGFJeDdhWkU1cjZQNTF5UUFDUjB4?=
 =?utf-8?B?T2R0b0JKcTI1M1pSVUFhcVJRa3ZvcFBJK2FZdDJVaDRhT2lDRi9zT3B2aGxx?=
 =?utf-8?B?QjZUSXRvQnBjMC9wemY2NXJKeW5VWklRNkVrZmZZYXhXelQzTGpQdW5IT1Zh?=
 =?utf-8?B?NEgwWW9zUXBoc21rcDJ5aWJkSVpYNG5jcDRKM3dmYjVxTEUreW05ZWRHS2lu?=
 =?utf-8?B?aEdsekl1NEkzUExYZU5HWDZnenFkTkp1MWpiRnZHME5wV2pYWGU5VjBUUFMv?=
 =?utf-8?B?TTdTMUpyVDhxWklieDQ5MDl5U1VoVVBiS3dWOXN1U1hkTENZWWpWa296aTZV?=
 =?utf-8?B?dzdDMWpYbVNhZE5wVXQ1TDlmYktxLzF6cjRndUpNM0pUaXpYOEZpaHJXbldr?=
 =?utf-8?B?QzNQdHkwRDFJWENwdCtnbUlueTZmSkhRNlRBVVZxU0l1NjN2b3FNai9GV0hz?=
 =?utf-8?B?RWxiUFhucFBkZVQ3d2VkQmE5cHpOVmE1SCtINWVvZ0c4YlJJMlVYYmhYUkVW?=
 =?utf-8?B?d1FhbWJWTGRjNS9UY0JIcWNuSDRaMU5JT1NSaUlib3VoRXJmcWFJMDJTUXlu?=
 =?utf-8?B?WUVFaGJVY1NBdVlMZzUwb3ZZemNOaURLVVdWWG1kVGRrbUx1ZkJ2ZnpEY1pK?=
 =?utf-8?B?VDdKUU9JTEpWV3EvZDlJb0JDZmlBdzJrTE5ySzdNN2RQVjlRa0k1OWNRd0tY?=
 =?utf-8?Q?JtUr49OZjb/U3qXr/eFGOeenG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d442147-06e7-44f8-8cb7-08daf5af4c3d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 21:44:07.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d3n7WcgDhGdSrxYff3fUwJEoQvfMqGz0YPMnAGRCGsnUE//S2m7WP67/7oprj/kwpYPcxLcr44QOVhSwt0E0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

On 2023-01-12 16:18, Philip Yang wrote:
> Update queue qpd is done for the first queue creation of the process,
> if the device support XNACK mode per process, update qpd setup
> sh_mem_config based on the process XNACK mode, to support the process
> destory all queues, change XNACK mode, and then create queues.
>
> Add helper macro KFD_SUPPORT_XNACK_PER_PROCESS to remove duplicate code
> and add new ASICs support in future.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../amd/amdkfd/kfd_device_queue_manager_v9.c  | 27 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
>   3 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index d119070956fb..8b2dd2670ab7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -59,30 +59,27 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>   
>   	/* check if sh_mem_config register already configured */
>   	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +		qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>   					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>   
> -		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2)) {
> -			/* Aldebaran can safely support different XNACK modes
> -			 * per process
> -			 */
> -			if (!pdd->process->xnack_enabled)
> -				qpd->sh_mem_config |=
> -					1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> -		} else if (dqm->dev->noretry &&
> -			   !dqm->dev->use_iommu_v2) {
> -			qpd->sh_mem_config |=
> -				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> -		}
> +		if (dqm->dev->noretry && !dqm->dev->use_iommu_v2)
> +			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>   
>   		qpd->sh_mem_ape1_limit = 0;
>   		qpd->sh_mem_ape1_base = 0;
>   	}
>   
> +	if (KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev)) {
> +		if (!pdd->process->xnack_enabled)
> +			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +		else
> +			qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
> +	}
> +
>   	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
>   
> -	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
> +	pr_debug("sh_mem_bases 0x%X sh_mem_config 0x%X\n", qpd->sh_mem_bases,
> +		 qpd->sh_mem_config);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 552c3ac85a13..bfa30d12406b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -206,6 +206,8 @@ enum cache_policy {
>   
>   #define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
>   #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
> +#define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
> +		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
>   
>   struct kfd_event_interrupt_class {
>   	bool (*interrupt_isr)(struct kfd_dev *dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 71db24fefe05..72df6286e240 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1330,7 +1330,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>   		 * per-process XNACK mode selection. But let the dev->noretry
>   		 * setting still influence the default XNACK mode.
>   		 */
> -		if (supported && KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
> +		if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev))
>   			continue;
>   
>   		/* GFXv10 and later GPUs do not support shader preemption
