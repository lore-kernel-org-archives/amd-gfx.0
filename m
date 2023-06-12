Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C10C7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 18:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E2F10E2E8;
	Mon, 12 Jun 2023 18:15:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F37610E2CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 18:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDxSBcWRvRgNlHuRNDbSmuytFjDyjMprq4/C5eJIul3TgQTKqB2WloOrDaLKUISFyOTMlu1qvZRUVgalz+oxqWDtuNsR5+lnP5W9JFptIGCIYBQwZe0ePhBPpvje3bt+W7KkTWb6LVQGUrSqYZ0b5O2XQMPajKXktjd+i3H3xg1MLl6q1qk3rbz75it9oad5y5RM7rm3Yp9PbpL+KnSDjTpVjd6o7K+uqERPbeAf7WtOSSDKkkyAwKrk3jgY0waORXVCpi74mFr0xLkL94oA8UjN8kNyf6sJJ8PLIMsaOTGiuwfE5B3iU5w+1qpGru5boiF31X97mhoSb6f1fU5Nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEaKx0YY9gc+bpPQqinvbhu9b3Cm0SJoQd0MabYRzEU=;
 b=PqXCaj4de3o2496vef4penRFN/s5oOphvGQcycGr/iaKoUxlb6+MawioTn0LhjJVbybntImdoTAPS7169jPrV6Jn2Nl142+ED6FJKB8zELMNxvTxmaO/s1Hw7UwHrZQeFrcweAuJQpcVsWa03mA5/dAbNI5XDdo5ZjUudWclLFgl5f35LdCgiidYGRfG5phP1g5b8+BZuAnNt8kTapN4ubXbGdHItkMtveBNS+Vlko35P2pnMC5pjFzDrrhLXaQHUfay5+FP12XHjzbNktG/rlsK8vwFLwYrVY8APCB5WaaQcKWMHX4ac9mvg9q2aaDMx5LYW0BOMMbP5i2zG/ZENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEaKx0YY9gc+bpPQqinvbhu9b3Cm0SJoQd0MabYRzEU=;
 b=sfHaDJFPQjQf3iuvhB3T2MUFtrWTeLBUzNNNQUWoW8hOnJU7P3CMlSB3N3ixPDrAer08jZKLV8D7vb4LO6MvP7nmNT/UvLViNJ+e7DTpY5PBW7Rte6GB5ZseuVG83YqL2dcWtZ/kSCSM3iyKo3U4lZbPW4/fbJVWi5SkhxFNEJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 18:15:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 18:15:12 +0000
Message-ID: <fb136b53-ebff-c674-9a6b-e8d4627e818b@amd.com>
Date: Mon, 12 Jun 2023 14:15:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230612162330.668641-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230612162330.668641-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 108570c7-ab5d-40c5-ebec-08db6b70f683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ2rwZq5H6kqr3CIpSUE10zrgjzcWt8Na8rrB+bkpCEYoqbU0BaE+NDCfTD+bdPDvKTFEAs+czrDh4nSx1GHbiSScdvpKgC/uOfA8fSxy0F1K26ur7dkWMk2mUTIHRlJ1PvtR+81tFRLcvBAwo7r+IU/62FoBHL2gfUGrcOa4iiPP+fObNew1VffQhBO3yTPLRWNCIIQNj+x7QmUTyri9biuqzbmYelTIglu/lh5gxPFkKfkzXObAvD8b5yWYUn3G2VTkKOG0qbIacKEFpzAf02MbC6ouI7ROTjdA7Ee8E5kYAT1E+VQczujfW+IcTBSdOFfK2AFaztz3ie262ghqLaxrHlsjhVU8xlZ8pb9hzc+tVYv1I07S0XXZIp7mVSXC8G89X3lzof3cwEnezFqbeW7lT+SSoRyshLqsbfH6dX/CFbSyg2iBvD5P6tDGmbFH1lHO/mQTyiGH6GxcN+9Byk8DL19mD89DtgvY/LXISOSRwp2kTdiI9S33U22uSH2ePfH36ol2g7AsOV9FcL/XCBov81ijii3xDLvd5nEclCplNyV9CRbvdhsti3Ke1bhzUMyO87ZOovPIwn5C35CQ+RqZ6Vk6JHaYQ39kB8C/ihxHJl88iQF23tqnXof94GeO8mHjIvz97KH93+I8SpV1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(6486002)(6666004)(36756003)(83380400001)(2616005)(31696002)(38100700002)(86362001)(6506007)(6512007)(26005)(186003)(15650500001)(2906002)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(31686004)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRQZ2JocithcnBIUlJjSVNTSExSYThFU0dROHExam9PR1N3OWVqMk9xL0tN?=
 =?utf-8?B?aFhaWFA2QUdpbWUzS1YyVWxKMHJIUjQycnFCbUFUYysxb2Q4UVFNNjR5dmtI?=
 =?utf-8?B?ejdqMkl2MXdCRjlyNk9QVDJ1WXRqTkZFM1JGdWZqOE12b2J5SXUzcHlGTkJE?=
 =?utf-8?B?a24rd3BCOGdSa20xeWFwc1RFc3hSMTVvRExXSy95VlZBWW1nSmoxSjJsYkZG?=
 =?utf-8?B?T2x4dEJGSmNPcm52bGVpYVozaXh1SUR6L2gxdWdlVis5V1gxNWxMQzFFRThl?=
 =?utf-8?B?VHpBV0FhUTRZTUxJQ2F5OUEwZ1JaSjhpUkNibk0vVEZ2TG4rYUlFNzFEdXE2?=
 =?utf-8?B?Q2tmdjFMMVhWV1c2dEUydU5xQnV6d3FaQzQycFdyTElvTTJFWVZzNCtuY3Yw?=
 =?utf-8?B?TE1kZGwrUUhsbUYyRUhzM2lGdTVEQzA1b25ibVBkeklRTWE5N3JyaENJcDNy?=
 =?utf-8?B?R2JQSml2V3RTcURQSW9xMUcyczFnQ2RvMG5ITDNZOG5ValJyZVZUcG9GRHBL?=
 =?utf-8?B?RVB3UTZSZEV0eGNuRnJXWUdMSm1Fci9OVHRHT2dPZEFLdTVOVTMvblpTYmN6?=
 =?utf-8?B?UEJUV0NsaGZ5OG5MaFdsNmRnZTZzV3g4TDRjbmp4bzdPS21Ib3BZOHk1Y2dU?=
 =?utf-8?B?bjZ4c1NHNDVJK0k5aE5kU0QwaENDWCtUSHpxL3ViNDh6a1owOS80azRiK2JK?=
 =?utf-8?B?QWNySGtaZlVPTWJQRHh1S0JXYmNZNDg1eEliNkxucHA5OE5aY2FOZ204VlhM?=
 =?utf-8?B?R2pwVTUzZGxXTTllNHFiTFNmckZtcmFPSC8rQm1zbzF2V2E0akJNTG94REVW?=
 =?utf-8?B?U0hFQm5KUE9yUFJadlNOYVo1cnZHQks5T2dtY3ZoQWk0ZCtxK0ZNeVJJM3pT?=
 =?utf-8?B?M0wzcFJaRFE0RjF0L0I0aFlsaytueVJFVUxPY2FqZjIzNTV6QldRUWVwTi9K?=
 =?utf-8?B?TFM1M2R3ZEVvTnM1M0hZcWUwSDVkOW44UWxYNzdiT1BNZmp1aDN1MlNPTnNa?=
 =?utf-8?B?WnQwdG4wZE9RZnlucmxIRmRWR21xQmR3STZVTUlpRFVtMGRLN25TdFVQQTUz?=
 =?utf-8?B?ajNzSEhVUk8rSnI1TWRXR25aUHR3dC9oWGJBRW4xbWswNUY2TGlWME91ZTdG?=
 =?utf-8?B?SE8zU1gvcXN1czZkancyeEtFM0w5Nzc1NG1ua1RwdXIrZUxudTdJbjlPcEwv?=
 =?utf-8?B?eU5iZHpkSmI4dTBLV1dYcW5ZOWxwdXpFUkpCV2drVXFlSWhnL3BQZWdHVlhN?=
 =?utf-8?B?NWdPNTk3T3l6b2ZGOFlCekpVUXpubjM2R0pkRzcwMDNFOU1uVTk1SWZZM0NL?=
 =?utf-8?B?MThXV1ZtUkdWVC81WlZqYlJDQlFJYWRIVlhWWFQyd041dnpkZUlnNFNldVNF?=
 =?utf-8?B?bjZjM293UkFibFg4bmEzVk1kYXJiSE5YNGs0c0dzbFlDNzczdGZ3VzY1eE1m?=
 =?utf-8?B?akI3V3dEZnpXVXhvaGZWNFAzM3JNSStrdVRkQ3pSdGVuTTZVbEV3Y2RKS2RK?=
 =?utf-8?B?d1pyQzdPa3JLM1c2RGZLMG5LaFM0TU5yRndWRG53dDBQZDQ4eTkwcmNvalp1?=
 =?utf-8?B?bmZ4ZVhzYmZkQ2Z3ZVN2WTQ0WEFoYTdEdHVtWE5vNWJueGszNXc2N243ZG1s?=
 =?utf-8?B?UkNFV2VnZWdkOWdnL0w1eE5CdGlKdUIxeS9zbE9zU0c0NkQyZ0VPdVBNWVZj?=
 =?utf-8?B?Y0MxZW9mMEo1STdIUVpFUG5WQ0ZGclN0cklTb2hlVXhYNDM5SkVvM1VCMkdv?=
 =?utf-8?B?aURzWEJrTk1ORThuK0JXZGJWL0RJL1VJWEpGZ0tNejczUDZXY2NtbzRIenFN?=
 =?utf-8?B?Y2dxTHl0ZTFQME9xZG45eXNwMnRFU1g4cWF6Z3FqWi9jSTY1c2lGayt2ODU3?=
 =?utf-8?B?YlFWbS9CVGdsRVIxMjRtU2poczJQaDF5Uk9uQmlnb09DUWZTY2lubHRTeGxH?=
 =?utf-8?B?K0lVK21nUWFPUEtockh4VnhMTThsSFp4ajUxa1BNMzk5NTF1Ky8zY1BHYTdD?=
 =?utf-8?B?aUVsR2lYbGlmYVNPZmU0a0dvVE5qQVdtNEtxZVlPelF5OVV6dFdMNC9xYjdJ?=
 =?utf-8?B?Y2kwSWhUaGg1RVU0ckdCeFEwalRlNWJpZkJhNzlZcnZCUWZJWEowWGJYZ2ZY?=
 =?utf-8?Q?rLyEv7qall/eYCWAx4ckulCgG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108570c7-ab5d-40c5-ebec-08db6b70f683
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:15:12.0622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv11dndL25sxMo0XfSUPTKB7XtFOUbFzNnukY3O5fmKYTxR0VEgjKoomLXUJtLAShxbzkKZq4sqcLdVHKeFaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-06-12 um 12:23 schrieb Mukul Joshi:
> Update the invalid PTE flag setting with TF enabled.
> This is to ensure, in addition to transitioning the
> retry fault to a no-retry fault, it also causes the
> wavefront to enter the trap handler. With the current
> setting, the fault only transitions to a no-retry fault.
> Additionally, have 2 sets of invalid PTE settings, one for
> TF enabled, the other for TF disabled. The setting with
> TF disabled, doesn't work with TF enabled.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Update handling according to Christian's feedback.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 11 +++++++++++
>   5 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 6794edd1d2d2..e5c6b075fbbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -152,6 +152,10 @@ struct amdgpu_gmc_funcs {
>   	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>   				      struct amdgpu_vm *vm,
>   				      uint64_t addr, uint64_t *flags);
> +	/* update no-retry flags */
> +	void (*update_vm_pte_noretry_flags)(struct amdgpu_device *dev,
> +					uint64_t *flags);
> +
>   	/* get the amount of memory used by the vbios for pre-OS console */
>   	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
>   
> @@ -343,6 +347,9 @@ struct amdgpu_gmc {
>   #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
>   	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
>   		((adev), (vm), (addr), (pte_flags))
> +#define amdgpu_gmc_update_vm_pte_noretry_flags(adev, pte_flags)		\
> +	((adev)->gmc.gmc_funcs->update_vm_pte_noretry_flags		\
> +		((adev), (pte_flags)))
>   #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1cb14ea18cd9..ff9db7e5c086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2583,7 +2583,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
> +		flags = AMDGPU_VM_NORETRY_FLAGS;
>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9c85d494f2a2..b81fcb962d8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
>   /* PDE Block Fragment Size for VEGA10 */
>   #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
>   
> +/* Flag combination to set no-retry with TF disabled */
> +#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
> +				AMDGPU_PTE_TF)
>   
> +/* Flag combination to set no-retry with TF enabled */
> +#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
> +				   AMDGPU_PTE_PRT)
>   /* For GFX9 */
>   #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
>   #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index dea1a64be44d..39f1650f6d00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -804,6 +804,9 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		flags |= AMDGPU_PTE_EXECUTABLE;
>   	}
>   
> +	if (adev->gmc.translate_further && level == AMDGPU_VM_PTB)
> +		amdgpu_gmc_update_vm_pte_noretry_flags(adev, &flags);

Don't you need a check that 
((adev)->gmc.gmc_funcs->update_vm_pte_noretry_flags is not NULL? But 
adding a new callback for this may be overkill. Since the 
AMDGPU_VM_NORETRY_FLAGS(_TF) are defined in a non-HW-specific header 
file, you can probably implement the application of those flags in 
amdgpu_vm_pte_update_flags directly.

Regards,
   Felix


> +
>   	/* APUs mapping system memory may need different MTYPEs on different
>   	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>   	 * to be on the same NUMA node.
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3ed286b72cae..aea8e80c3419 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1307,6 +1307,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   					     mapping, flags);
>   }
>   
> +static void gmc_v9_0_update_vm_pte_noretry_flags(struct amdgpu_device *adev,
> +					   uint64_t *flags)
> +{
> +	/* Update no retry flags when TF is enabled */
> +	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
> +		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
> +		*flags |= AMDGPU_VM_NORETRY_FLAGS_TF;
> +	}
> +}
> +
>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   					   struct amdgpu_vm *vm,
>   					   uint64_t addr, uint64_t *flags)
> @@ -1445,6 +1455,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>   	.get_vm_pde = gmc_v9_0_get_vm_pde,
>   	.get_vm_pte = gmc_v9_0_get_vm_pte,
>   	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
> +	.update_vm_pte_noretry_flags = gmc_v9_0_update_vm_pte_noretry_flags,
>   	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>   	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
>   };
