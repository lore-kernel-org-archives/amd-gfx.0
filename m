Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A4606A330
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5jzjDD3r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D968310E6FC;
	Wed, 18 Nov 2026 19:48:16 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4955710E6FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWP1SwvHb4bRFFvqYEcf6xWI0MfrZe3C3/GdsgvPusNW9bR13fVfON4DKXsPRCcNOb5y575tOHfmcyGC9B2SbWP1FLHnv0djXV6IKPpvlhvE3r84o11VkN0bb/7u/qvMKC+HXKRGGRYyexRH2ma+Wf+1E3oDyX/o0R0196vhJtM5s+tpjJV4u/cP71yvYHRXvgn+Q1Z74B46HeYmPEBmZ0Dub/NUCsfMQMW6Ui/QdbLzM9v3JM63zsYGhf5aClqH17W1+hrjygc2bI9aE0mVhVg1NlwwY7cDs+mPVbk/JGbsbrC9+BNNLu/Qq6PAy0WEuRv6yq8yhxKZycEjQTQTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV2KOV252qRKyIJ8coBm7cc6CEMrG5XNXBi8E9XkO8A=;
 b=JSbUMPbQU7fdUCq5UL6V/96qPP5FXQjyWtOeFipZbK3CbrWv4wrfshHvZUWP5fDL1Jiz9DQUSozsDk82lGMjm2bzU+gdZZ60qdwEd2KBPhr59mIPVj7CEgj40DgoA+N/TkNK9X7pvpXAhqdu4S1MKGdXZCEwFkVY7iy320np8gdtFvgj+jW0WpirOFY0mKBbWAlq96q0deYGXTuqaZpGdPAK7wFSmp+f9xrNqbYQpQEnN7BurNLICJMZMFALeqcdD71JaAHzX7YT2fLwmBhpFnEltUeps/woyZnLkTgo1VFaGF1pz7jpkjUUOkRe8t2rnkkvt+N4tD/mCswELP3enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV2KOV252qRKyIJ8coBm7cc6CEMrG5XNXBi8E9XkO8A=;
 b=5jzjDD3rPcmm70eJJW4+dU8CeE5XLsVB8fIkURbaCigcBjrKMt6ktERJqmybtGVjt1h70dmq3HK0v7EykX3x5K7rzb3qggo1uJFL+fiyyyvBNvLwvyJAEmRi76knBlJQxfgqZKF54Pp2oPsgD0cNtM5WYt0GAZDLUmFPz1En8+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SA1PR12MB9489.namprd12.prod.outlook.com
 (2603:10b6:806:45c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:48:06 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:48:06 +0000
Message-ID: <7f8b929b-f1b2-4214-ba7a-f6f597427ff4@amd.com>
Date: Wed, 18 Nov 2026 14:48:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Disable XNACK retry on GFX12.1
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20261118192946.228131-1-kent.russell@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261118192946.228131-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::17) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f1dcb7-d070-4020-defb-08df45acdd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QIqiJMFxKFaRZcflxyYLHZAhDsFlsi7P2scywz8cAhHV4ePMSn/cWbDR3bG/0tGSdDsJ1XhvvKNbxgZROhjA4kOzg0HJxEedM1UI1zohUEFHj21dYF/GX9izaMkNkNUTKLpVHIKo52U/FjnWOlORn7FQsahHN/OYZg2CP+KWF8Q7XOBxPKbPa6NA4F7OJXpa1BwKgV4xrumBRRSnWc4hBjD+HBE/Es5jUY2GMC23+Id2cdp2PGjFakx92VL+LerbLNqCVhB0eT9qd4lMIo2yQJLknV/1NGzqBaDQvlGffI2YuJ3eFnwzjhU78+aVcGaluq70GKimFuKasacoHBvMn5kkGEsSkKHmNQnajG+St39BPmaJj+88UQ7NgLb7V0wSHnbQqfx/rsF/NPtpX0aKNlOQVkuaBQlHfj8t1hJ2ASNtJx0aV79hGx8Ehdj6Fs/E9SEGhCPN/DyvZSaRCXEp4mXheU/dw+QtNP/MUD76OnvRNci/B1SwMCh3RIJ+Pbet9RYL73XnecjacpcazdBgkOVDmlqyf9nUe8JB6XtQq23nMoV+LLYEXJ8EodJObOXoJhNEH0/6KY6Gh2t28iSqSqST/rDnZFKzcQAoPMxnXKuzXI0Aqt9kpj3spGv3vUbr6ac5rA7bEWQnyAVjrhYmOKVrHhCQQgI9/doZ3n2hUO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjRJNnladm1LSUZucEViMmZNb0xQeiszY04xbWhJeGNpdEpJKzVtWW1EMGFH?=
 =?utf-8?B?TW96VjlxMmhpOFBJdFVOQ1pJbnlFai9xYWE5U0haNHJQZmdPb1hxWVpveXAv?=
 =?utf-8?B?NVU2aHVxZFZEcmhEN2RNOEdmMFRRckc1MXppUTc1VG0yVzRJNzZxZjhSTWhn?=
 =?utf-8?B?U3FzVXFPb0JjQVdzRnFZbko5U2dRNmkyUk5WN3Vja2gvbXh2aTdZUWk0bzA3?=
 =?utf-8?B?RC9aUm1GOTk2RmJ0RExreUVMdzFZYWNteGJKUVc0UncvaGw3djROT1c4N29R?=
 =?utf-8?B?cmlVSzNvcjFQUDBrMlJSWlFUM2hWU0JtUTJmWVc2WWxEcUNpSThKTjByVEMx?=
 =?utf-8?B?K21pR0s2aG1xRWZRT3ZPTExUWjRRZ3V0c1ZFdG5abGNVclo1amQwdE1HRHQw?=
 =?utf-8?B?Nk1CZFRtZHNQeWNSd1ozYjA2MysyRjlHMXpZQzZOTXZEMGVnd1NvN1BwaUow?=
 =?utf-8?B?RkJDUUYvRjVPVERkZkswYXNkMkw4N3hmTE44Q25qZ00vQlAyUzluNnpoZjJr?=
 =?utf-8?B?Vm10c2dIdjIwTkVhY0VZT2o0bDB2Rll4WXNMd0hYYkZWM0pOME9PZTJXemJD?=
 =?utf-8?B?RTlHZlNkUE9nRnJjLyswWTd3eHcyT1lHbnZ1c0NVT20wd3VKaXYwQWx6c0hy?=
 =?utf-8?B?Z2YvRHVaQWlGWkd2enZoWERrOTVKSXQ5THJoY2o1VzUxVHE5Ym5ValBvYTVz?=
 =?utf-8?B?OWszSXJqWVNsQ01SWEdvUXNvUmR0dk1MSmVEb2NJVGdJQWUvQlRXMkZ3Wnc1?=
 =?utf-8?B?MFF1aGJQa0lKeVFvYSsrSVpwNksyT2xJUDJGNkY2RElENlBxSFk3MVNTL3RO?=
 =?utf-8?B?TzNuVGhzSGhVUkg3aEgvdWwzS05GZjJRRXJqR2dLWVA0TW43WXZEZ0d2cWZC?=
 =?utf-8?B?TGZHWXlGcFpubG9MeTZkakdlSHlJUlErRDJ0dnF6MU8zZGhzVHNvZEVPQzJG?=
 =?utf-8?B?ZElpWmxJd2pSVnZWRTc0YWtST0hZb2tDWmlLMCtTT2hqQVd4WXY2aGFkTTJm?=
 =?utf-8?B?RS9ZUW5iZWpzbTdJR0t6RnBNM3Bac0JhbFZXVWhTcmdZZi8yR1pXUENKUXkw?=
 =?utf-8?B?di9pajRlU0tpUXBkV3RwUE1Bc2tXejFvSENSUjFxVzVhS3BYSWdhTVlEZ2o3?=
 =?utf-8?B?V0J1ZU1sMC9OU2RxdmlvODlISXJkaUU1WlBJTTJVdEFDZXEzRHltYjZ6d3pS?=
 =?utf-8?B?RVZhNWwrQWJYcU9ab1pIekhrVUZpUkx4OGxaSHpTSTJ5eTd1U0w1T29VUGhu?=
 =?utf-8?B?elQ5MzZHeW5EVUpMOG5BZnhHVmxDNnErb3FMLzZHTm9HQ0w2VDJRNUUyc2Rw?=
 =?utf-8?B?YUMrdXJCNDZreWxYbVdiR1ZPUXUzaEJJZkhZSDM2NzBYQzBUdFlBZEZzTWM3?=
 =?utf-8?B?MWltSS9xelk2UnNaRlZOSUZhZXZsNjJVeU9VMStTLzJicUtteTFpcFMrd3Ns?=
 =?utf-8?B?TWNnSy9XbnlwLzNwWW5nS3QrS1IrVnl1eFMvU28rWkFDeTZXMWlBRnd0NU5T?=
 =?utf-8?B?eHY0aUpzUDc1c3AvdUhmcjhOT1NNaWZhY1VNWmhkUm56US9lbHg5bFRUSDVT?=
 =?utf-8?B?c0g5NEROOUJvVEVSZHJmWXUzZUR1YUt3c0ZHaU5vU3JtUzlYb0VKVEgxNGx4?=
 =?utf-8?B?MEZXU0p0NzFwZ29LdThXbi90cFZkM1huNG9iTlgzTGpFaVRna1J5TDF3Skxk?=
 =?utf-8?B?UEp6MFY5c1BGY1l2ZjZXWjlmSVh4dHNUdEZ4cllZTkhCb1loSlRRT1Q5dkN5?=
 =?utf-8?B?c1RXLzVWcmhRb0Q0UGFYSlg0TWwxYm1mb2tHMTFldXF0dktGTXVKcThmSEZu?=
 =?utf-8?B?bVpxZHVWT212Q2V0MUNOSHlqdWZWbHFUQ1daNzJIYjl3QTFZbHVMbmVYYzQw?=
 =?utf-8?B?N05RVXFCWjRFU0lmdUVoOFpabUxPcWZDRERjblBUdWZaU1kzSjd1dGpMTGxu?=
 =?utf-8?B?VW40MjdzaHhOSUQ2ZFhTZkMvL0cwcjBSUFBydGZzUmtaK0lpRWIxNUVQcGV4?=
 =?utf-8?B?ejRyT3lPRENJOWpnc0tSOC80eS9neC8zK2g0UW5WcFFWTGg0SDE4eW1uQVdn?=
 =?utf-8?B?SE9MdGdFM3ZpY0pOTkQvM2JYcEF2T0VwQWgrZXc2YTFqTUJLT3UrSXl6KzBN?=
 =?utf-8?B?WWkzYlBtZ2h5dUJWSFV5R2hKMDNLMnIxWWtIQVN5Y28ydFJPajhidGtXMCta?=
 =?utf-8?B?Zmw5OTZZeVJYVzJlN3k5WGtuMzNhajNkS0gwVjFjVjNZUWhleFMzYjRlVWhL?=
 =?utf-8?B?cjBqMTdUQkRHdThncTFLMkVuOTJRQlV2YWRHVEpjZVBkQjZjMzQ4MTZ2Tjhy?=
 =?utf-8?B?NUhqOE9RcUN1V1crZDNFQ05jTzBqb2JJSnh3bUFyK0dOK3dhd2tiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f1dcb7-d070-4020-defb-08df45acdd7a
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:48:06.3982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK4iZ9lSbcV7xlGBrx4GgMvDCNLrLiNaXO0Bl0ifQ6UFa58PLb15Y59ItSd1eCuQC6ZFskAgr/fXdjy3+R7Pmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/18/2026 2:29 PM, Kent Russell wrote:
> This feature cannot be properly supported, so disable it both on the
> amdgpu side and the amdkfd side.
>
> v2: Remove dead code (thanks Sashiko-bot)
> v3: Remove unneeded extra check (thanks Mukul/Philip)
> v4: Remove dead code (thanks Mukul)
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         | 17 +++++++----------
>  .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
>  3 files changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 08d3ff61edcc..d0ede277aa85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  		gmc->noretry = 1;
>  	else
>  		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
> +
> +	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
> +	if (gc_ver == IP_VERSION(12, 1, 0)) {
> +		if (amdgpu_noretry == 0)
> +			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
> +		gmc->noretry = 1;
> +	}
>  }
>  
>  void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 56439c9f8e17..9761c84da943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
>  {
>  	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
>  
> -	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
> -	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
> -		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	/* XNACK cannot be enabled for GFX12.1 */
> +	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>  
>  	return sh_mem_config;
>  }
> @@ -1567,14 +1566,12 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  
>  static void gfx_v12_1_xcc_xnack_set_chicken_bits(struct amdgpu_device *adev, int xcc_id)
>  {
> -	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack */
> +	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack

Minor nit-pick: Maybe fix up the comment here, from "is used a chicken
bit" to "is used as a chicken bit".

With that fixed,

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


> +	 * Since xnack is disabled for GFX12.1, set it to 0 unconditionally
> +	 */
>  	mutex_lock(&adev->srbm_mutex);
> -	if (!adev->gmc.noretry) {
> -		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
> -				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x1);
> -	} else
> -		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
> -				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x0);
> +	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
> +			      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x0);
>  	mutex_unlock(&adev->srbm_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> index 525989371378..63ba13a60b98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> @@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  	struct kfd_process_device *pdd;
>  	struct amdgpu_device *adev = dqm->dev->adev;
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	bool xnack_enabled;
>  
>  	pdd = qpd_to_pdd(qpd);
>  	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
> @@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  		qpd->sh_mem_ape1_base = 0;
>  	}
>  
> -	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
> -			pdd->process->xnack_enabled :
> -			!pdd->dev->kfd->noretry;
> -
> -	if (!xnack_enabled) {
> -		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> -		qpd->vm_cntx_cntl &=
> -			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	} else {
> -		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
> -		qpd->vm_cntx_cntl |=
> -			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	}
> +	/* XNACK cannot be enabled for gfx12.1 */
> +	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	qpd->vm_cntx_cntl &=
> +		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>  
>  	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
>  
