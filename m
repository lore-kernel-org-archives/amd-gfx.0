Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347FC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 14:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FFE95023;
	Tue, 26 Jul 2022 14:03:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98160950A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 14:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHk2M1Oy76nCk6xg/lM1SIgwdkZF9pRQkXNAZTjN0tTny64X+mwI2fC/tVIO7PcOJxARjkKQgYR09K8b3vREJ3cv70JeFZP59I96FkZunLvo7bnUJRQG09aLdhfn4/m8TYHx/m31tfuLgpp0xf0LMTtgTLlySd9fJ5gBANgHVYGubUwINO8LRMktKn0D7B5ynR+isxr+uA/PJ5jhOnwwTK6l+3BjktOiogUF/Pr3zQo3wWhg362M6CWGeGVzHOFVKtwltAgtrT7ELrERTw8K1DbRyOu8aAMcSjTWm5oQagqbCp5BWdohMj1o/iAxpQe0OYUuBy/E1ddU/bvxd3vJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eOY/kasWUd0QK6rFfqqhnYiHFcKefy1kvGz/GztB/8=;
 b=C5Zyjjfgk9gFCRKRwAl+0Jg/GdgFNgqgVHZv+jAb3DDXlLGIC+yIo+HY8vCi47G/pz26hjvrAF8jWHx8EUhlKtr8UPVPxQGtNH/n2T5N8aEEFLx+Y3l1IPtOQOKYNGID9VONfn6u/yqrS/8f+GoicCzj+auOkWDGvpZPTh58nm0/NwXQayxaAMfmb44zEfyfQx2ndxPyoosI1EKAstfa5J5BvzEIK4ua296U0Tvg9Hb9rJab+jYGNJcQkBoX9Pb3IZtBk5ZvwhqGEzc5J8Lb1N5YDb/So0Gy+c5Om4urlnniLb5eCXd4CVSQqtaEYEkUWpx91ZKP5dcrDOqTwh33vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eOY/kasWUd0QK6rFfqqhnYiHFcKefy1kvGz/GztB/8=;
 b=tIUgRMhZRb0qvSOsVntlVwU9n1JGutN4MhI9F/MJqI6+69IQqfjWhJZXfHqWP1l61DTcGCM6vjheiVlDIcOwq3Gt8080+hyMDMS00yMuT2MFD23Z/btB8XnkKED/XgDcxCJIgpwMPSCuN600svrcqwAA5ItbZVsK/onQGit31TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3208.namprd12.prod.outlook.com (2603:10b6:a03:13b::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 14:03:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:03:28 +0000
Message-ID: <007650e0-30e2-88c1-66fe-a942a481515f@amd.com>
Date: Tue, 26 Jul 2022 10:03:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: fix kgd_mem memory leak when importing dmabuf
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220726111513.2215655-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220726111513.2215655-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d99a6b-ee44-4cc3-4f24-08da6f0f9dc0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2UZKjpNLn/zQNgEtZzzNK3G6iau6W02MqWcmYJH4D4v7QetgV7wuab4nOcsRC+FQo6KsiN9nPwDh9yKVlvctjOFOVLQbLgxzj27bzw0CkUFs3+UIhahVxeLOB3wKCK8U9moOvvb+fWRPbDpfi8SyTCMtO1JdU7hAowJRxozNBsKPQZ5LxXqmh+Mq4cfkygn5DJApfnLw2b6suH5eo9B2vFeDr8bLajNweNDUYnnCr/z5+PS1iZ/jMXKJ6FKzmQI1LzMAWb7gH+opRSLFUthErxod6nLJdtLuF/st3rgRCauJTU/jUG0wdTMgol+T6pbeRg/JidfuLMY0nHKaq8L+Wi9nEDO2OQPULzK29AGEeV4s1Y2BjFSYqSVapSm62KyF9o5uO2+Za3l1xTbnjifca/DiQSGx8eRWJHe++ktYQ3LLxkl6rSm0xQw36UM7LxNetzIxVJkCH5QKCQmouJHkoNsZWH97h7xqY92bgJBvP44ciSA062vWgQeLXPU5FEBIeC546QJCTMJFtjlW1uVI41rrXADSkCwmR/uF4EGDdjio0pV6CNahY60/Exl2KBoAbaTobmh61dyhb+nfqKwuqNt1+5phHPTBl4J87dlG7GKrH7A4Gck3loz9IbO4ccySy4rmar+viUhhhsywVCfa/6BCaHWG0sFz06J0cu94lgPu9d5iNWyne2zFxJz5AQkavIiR1YYNR2V1AtGovzJDVym8no2vVYG1/LXFIdJZLeQRFBp06Z78uxsjdsogB3EAqSDVTEXSMmG8e7hZmzdl6GRwD4bBD1tDPm2LdyzASS4O3Vy1UI9vL6IskTkEZd9Fta8X3qViq0vN9zxKtYTRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(31696002)(8936002)(66946007)(2906002)(66556008)(44832011)(6512007)(5660300002)(26005)(6486002)(66476007)(41300700001)(6506007)(38100700002)(186003)(8676002)(316002)(478600001)(31686004)(36756003)(83380400001)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JwRWxvemIzNEN6RERUdlAwV2JWREs4RHpITkhHRi9DdXl3azF2WjlCSkF3?=
 =?utf-8?B?QWdBa2VMSlpGbXNGQkdrV1RFT0ZsSGZCUGRhVzE5aWIwbC9PWE9MaVJZdGFD?=
 =?utf-8?B?eXhyRkk0bkRnazhHNjZLZkxXdmtxZTNwRFBOelFveldwVUVtMzBOcWhGWjR1?=
 =?utf-8?B?empPZkdBNG5KeTdpVHR3ZnFFeFFuajZWa2FuU3VuS3ZoZVZ0UjlYTGVBRHkw?=
 =?utf-8?B?NDZFcVNrNkk5eXcvZGlLSFdudDNkcGZOaVoxTmpZaDhMQTEyN0dEalVWeHlB?=
 =?utf-8?B?bzFzMmlqdEhRY01vcDZCSytOWUI0YlFLRUxoRTVVV2NGWkNRc0hHQ0tldFJy?=
 =?utf-8?B?dHhLdlFybllQck4wZVJuN2doUVRvcVR3cWtiMkt4dzBzblVUdTZMaTRCRzBM?=
 =?utf-8?B?Vy9xWEJ6OGp5Qm94MjZCRU53Szcrb3BTS0JvZzBBbTdMc3JmYnBISnliREFG?=
 =?utf-8?B?b3hSTk9GUEtLNm40WlRJMUo2YXRJcTFNUWJVRlhxSU90c3h2aW8zdTRKL0lJ?=
 =?utf-8?B?SEFWdlBDTHlTclZHeFpTbkFZeW1uYXVHUGRueU40eTE4YVZoS3M0VC82VHpH?=
 =?utf-8?B?UjF6Y3pKeXg4SldDSXJ2enJHbUNJb1NkU0l4clhkRHBvUnYvZk8veUhESVNN?=
 =?utf-8?B?Y1JISktIRDhiclU4QlNZQXV0aFBNTjQwQXl1MmtGNExlLzdqWlVwUWNvYlQz?=
 =?utf-8?B?T1dkczBYemg1WHZ2VG5UYks0dlZTWFJ5Z1V0cnVscm9BZHhqSlF0WHVWOUNN?=
 =?utf-8?B?R1BmdW82Ry92eWUrNm5YTlBxbWl6VkRrejNyVEZWdjQ3K3FmRWh3MzNwVVAz?=
 =?utf-8?B?UGE0amZtblBnUVNxTEl1ZXFGeG4xQVRkNU1lL0trMWw3TmpKcnpic1pFQnhC?=
 =?utf-8?B?U0pPMm0xNHRjSVN2c0NxM2xmQ3huNUJGUXdRclFXUm5KS25ucW5CQzhDVU40?=
 =?utf-8?B?Z2krRnBJMzhhY1NtMDdPYi9iZ1pEYzFNK2NPakdhL25SS0Jxbk13ZWlGQUF5?=
 =?utf-8?B?dkd1VUFJcGFZby9OVGNyRnI0RG16aStDV1JXUFFsK1BlMzhpcXNFY0l6b2lL?=
 =?utf-8?B?aUZyUm9aZGM1eWlGaVBZZWMvaHNMcEx5dnpMN1F6VU1YRFZLLzRhcVBKU2F1?=
 =?utf-8?B?SDJsYmE4bEJBUDdMV2dlZWVXWFFzMEduZFJUUmtmaHVPUFNLY2VDY1BIQnhE?=
 =?utf-8?B?ZUx5SXF1a05EZmhFNEJlNTE0S2F5dUhFVEJmbGZCTWQrWkVOdlRBZ1JzNVRC?=
 =?utf-8?B?aWlUNHh4QmE1Q3V6SXJLNDFwRjVOMEpyUzlQSDduU0pWclV5N1BsMHV4ajVH?=
 =?utf-8?B?ZlRJUkQ3K0NvdGVXOFJldjdkSExXUWFaOWJNSXc1eDgybTd0RGtmM3g1Mk5O?=
 =?utf-8?B?TDVISFlBMkErUXBFaWtuS1NEbHpMalJLY2FSdnJEK2lpZ0FZenFDSXRSOU5p?=
 =?utf-8?B?M3FncDBlNTk2NlhBNXpmYXpKQUhUK21SSkJJTjA2MVhQTkRjdWQyMUtuSjh4?=
 =?utf-8?B?Y2hFUzRpUHNjMGVzT0ttKzRmc2EvUXVYbks3TG9kZDFsUnhKNmNVVWdTRXYy?=
 =?utf-8?B?STFSY1B4NGJDWTM4VmZ5a3UxWVdKOEpqZ0V2eTgvTG8wWXpFUTRuT0ptei9C?=
 =?utf-8?B?ajlkVWhqQUp5U1dGR1VqLzZvMDVXMEJ5ZkJydHNGTUZzOC9EWTlCREozZU9u?=
 =?utf-8?B?UE16Q3UwQlFTdEp0ZnJId25lUWcwUjZWTlV0cEc1eGV4UEpoRk1DZGNib3Z3?=
 =?utf-8?B?SnRKNnBUYUd1QnFKM0tTN3VFaFRwK1dZWEw5STZ0Zys2K0hkVTJLYk4zUnQx?=
 =?utf-8?B?VEFlMWJFQ0R5YU9VWC82RGtheWJLNEVsdFpUKzMvL3lRNS9LMW02dnJYZGVB?=
 =?utf-8?B?QWRwb2VPa3M4NENmeFlJNldPVE1BNHFWYXBDOXJpdW5YdGdNZ0VrMTlFc0N0?=
 =?utf-8?B?SVFubjJ1aGhrN2hZdkpxdFZ0QVhvTXNkYmpIcGRRVkI2Q1kyU2JlYlk2Unlo?=
 =?utf-8?B?Y2wyb3pyRUxZOEY0b25ldVNTbGpXVWZ2VVBRMzhpbmhReFpNZWZYcWZvMkYz?=
 =?utf-8?B?ZERGbW42T01FNTUvUnUrdTl5YmdETVFmSlpMQkVjVktFaHFabnVObWpxR0ls?=
 =?utf-8?Q?syMRRtWOTjS8KS4p3MP7q7QG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d99a6b-ee44-4cc3-4f24-08da6f0f9dc0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 14:03:28.9414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXcuA4WoSEnTqC/Yuq5Yvv152DV8cVKhoTn2l+kVnzkvoybrV3uGOPWbSTREt+z0NrzNVQICgQnQ6YEEH6c/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
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

Am 2022-07-26 um 07:15 schrieb Lang Yu:
> The kgd_mem memory allocated in amdgpu_amdkfd_gpuvm_import_dmabuf()
> is not freed properly.
>
> Explicitly free it in amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
> under condition "mem->bo->kfd_bo != mem".
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Some suggestions inline to make the code more readable. Other than that, 
the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6bba6961eee7..086bed40cf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1803,6 +1803,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		uint64_t *size)
>   {
>   	struct amdkfd_process_info *process_info = mem->process_info;
> +	struct kgd_mem *tmp_mem = mem->bo->kfd_bo;

Right, you need this because using mem after drm_gem_object_put would be 
a potential use-after-free. Instead of saving this pointer with some 
obscure variable name, you could just save a bool with a more meaningful 
name. E.g.:

	bool use_release_notifier = (mem->bo->kfd_bo == mem);

This way you have the entire condition in one place, and the variable 
name explains the meaning.


>   	unsigned long bo_size = mem->bo->tbo.base.size;
>   	struct kfd_mem_attachment *entry, *tmp;
>   	struct bo_vm_reservation_context ctx;
> @@ -1895,6 +1896,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	 */
>   	drm_gem_object_put(&mem->bo->tbo.base);
>   
> +	/*
> +	 * For kgd_mem allocated in amdgpu_amdkfd_gpuvm_import_dmabuf(),
> +	 * explicitly free it here.
> +	 */
> +	if (mem != tmp_mem)

	if (!use_release_notifier)
		kfree(mem);

Regards,
   Felix


> +		kfree(mem);
> +
>   	return ret;
>   }
>   
