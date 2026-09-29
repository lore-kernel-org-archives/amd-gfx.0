Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E30CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 09:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F59710EDB8;
	Tue, 29 Sep 2026 09:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0bSxyYB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C796110EDB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 09:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B32tD2CavBpxvteqs0uP0cHCeNVHVd2/sM1Xj6wZjCfEdb82PZwUVvCrebJ4jzCGt1q8/r4lZEZWIRGHFSmUc5ZhuCN3LN3MajeMX3FNr08IbHxfCK24aUlTyVCZpQdCNCAx1tPagr0WFeoIjr2j5K6jfU7ICxhimeD1oYI2Z5tCJQKX4WfXnmZLkIIlLlX6mZPMnj6n7A8Mc1zfxIY+nnZmfG5VdhzHDfneDa+nXKJdXkXaS+Nox4ebpWZhMxfvqcNeOVQC5I4Z1Ruwl+89RMUNxZKZw2CQQMMx9+Q/n/Rf7wXfBjG1XJxuY1eZhe26uY7C+kqzt4FMgzsviPVZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF6o1b9EmHlwwFmHsd6S2lV/e3u6eBi6sVKFDvsVbsA=;
 b=cn5emAnfroGotILgBmPkVPMZIQWqlnsjU9NbppoX/ty3JN5squIcATNoouw/8GiphM2DVhlCyhhp9n01f/UP2rU4ZA18FsvHBbgiqmHv5j3paWpEy/u80QOZg1n2IERascX70jQbWKibmnUUFvmzvTYtquBl1HreEiEB4FOayjodgW877503pALOg7nD2CGgBffcaTvootiUQtou7lquWYEfQx3eylUJRbb6KXMVEv2kmOOZHE/cubAoJyWLPdwxbFX/Q3m8CdEIe/btYfO3b+0TmP1gC7N0rP29EsgsyLUnnx4bTmhuvFVIgCbVs5LqCJNHHg79IixqyQBMDuActw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF6o1b9EmHlwwFmHsd6S2lV/e3u6eBi6sVKFDvsVbsA=;
 b=F0bSxyYBmukaJQTB0nslVKtYdQg3UD+B6kqsiGQWmtrnPPkeMKJSRXuHTXMmVB+wx4yzybnKOjWjq9VKDyST2UePnTOaPHjRJrPcfCUIPfwuMTQ0Fk/Z3IVFJXWQRuLYafI1jQI91/P8Jf787r1lgOjvID75jfVuZvcbklM7ilQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:05:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:05:45 +0000
Message-ID: <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
Date: Tue, 29 Sep 2026 11:05:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260929022540.122318-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: d36ac199-9d91-40af-f62e-08df1e08d8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ji+eZsNCQ6Oa2uUj7teSsLJN9CFfn+OHy2hY41rKvV2NCOUEGnH7pmmzCA/RnqQGEgY1X3JNwz+1s4UC/jHIrK+Qvs9toX1a06Q8eTrwiWXz59d3oQ3+1LCNUkdxd3mK3WvOo8vgvRraHNydJs5tA6ozi4RkkLOFxNexWbhRYYgfNJvSh1QyynGcri6svv8jU8G3Kw6EmTa8Aj91Ya/UOhXW0w4RaZRe+tVMCKjteu5bWHocJhOk0yP3xHzbLh8LMnOjnABsdmQoVMJlM7UapnabYyGFjH1UvuiqLiu1LKIOvuL4uHOnOvDUD4g6ybLwhF1LK+Jo8nq3wd2gkXJoWDNpGV1Jj7+emADevHjh3al2Nq8qOU2BGojc0vDQekYL+qYLHqPbfAYXuUz3DntVWQG7EIIeAieMMTVcYAnjKZf/HtSlDsP1gpqsotuFgjRtBmcA4A20ESHdkALfhOk3X9HGKDW5zihixTJmjwRceX9aqWe/NrLyO7ueNHtMSi5D7MStoS/ZiFjrWaLZlZbozmrEvgfLoAxqn1Q0w6oZnrY7RrXijR9d/72Oqpe62eZ3dCUnAL4aNvguoXGogImwj+FRMEeanDPUxFAy45id+KU+qvROo08s4kBNcw4JMUdgEb4XjB/QA+cMU1hI/B7V7DE4NpBqAJs/Xo2APNq452A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldLdVp6emhsMjZPallvQi9BcVhKbG8weDZNWnExYUtPTkc3V2pjQmZYdi85?=
 =?utf-8?B?a0dNZXVyaVJaeG56K0pCcGRra0FieDQvS005T3B0S0dhN0ZweFhJbkdadmJM?=
 =?utf-8?B?UkVFRWxYRkNyUjJoRkNrRExGUWxJZ3l3M3VHNHdlNzhzKzU0MDlVa2o1b1Fw?=
 =?utf-8?B?Slh3MVdkRkt5c29GZ0hTNkRGck1Ga1BkTnNmaUdzSGNOSDVOVGQxU2E1MDEw?=
 =?utf-8?B?b1JweTlDYUY2QjNCeUhjNGdzY0NGVmZPK0dvSmhzTUhZVGQ0Z0l4eGxRQXNj?=
 =?utf-8?B?VHMvdSs4aEh4dTNweEc0MWIxUWhTZm4zMUpqNTRYZHdGRzdrZmJIWG5HZkFM?=
 =?utf-8?B?MDh0QXVkOWwyZGl4UksvMGh2YVVrZFFvU1I0NWQ5YkhNWC9kYmRuS05ERURt?=
 =?utf-8?B?OXhZcFVQQ2NFNFVQZVBmaUJ1RW1vZnlRRC9mMklPNlh3SHhsa29Ea21td29R?=
 =?utf-8?B?bVZIZHQzMkhQMDk2SHFTRHZ5NkJrOVE2QkFMUXpmL3BiUXpDQ0hWY2ljYVNt?=
 =?utf-8?B?SjIwY1UzbWFET292SVh2VXlkNTlQQ0JHQnJDVDNidXZ1T2xPaEJkZnY1SG9z?=
 =?utf-8?B?MzVhN2daejEyTzNpOXJKbGp1OFJSMSs1SUc1RmVaSmc0blg5cVFxWXgwdTFC?=
 =?utf-8?B?TTcvRzFXZEpWV09vYkZjRWcxWHE0czBqNjNpZ2paWmM1dWZTeFMrWGY4R25K?=
 =?utf-8?B?bmNWK0N5MDk1V3JqYmJmUW1CUXhaNXdGTkYrdmFrVGIzTHBxQ2pTZnJtc3hU?=
 =?utf-8?B?cGV6ZGdOMlRxZzZlZDhzSHprSFFzcEZvVjRQQjRSbnBIRlZaZ3pGRVJmSDRr?=
 =?utf-8?B?NFNOUGd1LzNtVjdDMkk2aEZrL29JRlIzVUxkZWFwNDBzSXRSRnoybHBZSVZX?=
 =?utf-8?B?NGVrbHQ1ZkEzcjRWSWZrUXc0dHlpTDBHQTBtRjBPWWJ2c0ZMOXBGTFFsT0JB?=
 =?utf-8?B?SS9WcHlTdDQvbkpMdnZ1NjNQV0FtbkpqOUtkOVB5citlemlreFA4OE82S0Ns?=
 =?utf-8?B?UE4xemtiR0JCQy9ya0FZUFRBMXZRZlNOWktJV1UxM1B2UERKTldMb0UzVmlX?=
 =?utf-8?B?eEJ2eEQxUC9sNVZPZzVuRysxckIxWkF3WnVKbDdMMjlFMEgweExPb3lFL0F3?=
 =?utf-8?B?M3RTTEFhMXF5cDVNTVJjamF5ZXdwY2ZDOUpxNkRkK0pMNXJtSkdkOC9zVTBZ?=
 =?utf-8?B?SGR1aVhxaEpxRytWOUFycFhuOTVjc24zTG5HVXZBQXBaUVdjU1pUQVpHZXFY?=
 =?utf-8?B?RC9vUVE1YlYrOUxLOXYxWUFEeUl1R2IzdmpxUndMdnJEUzRmZzFqWUUxWlRm?=
 =?utf-8?B?NGZuR29RQlZMWjJHVURZcy9oMm5mdjZIanE1QkhkSHBKeERKQmo1TFpsdmc5?=
 =?utf-8?B?Z3lhSlJlY2YxRklpb0VNMHRPM2hiUDJyKzN5VUNxSUZCRjA0TS9WdjByVzIy?=
 =?utf-8?B?M0s3eDFrU01oSXlycytUQTBxZEhwSXdGN0lOZlJ6YkZ1UHMwZzBMK3AyT3RZ?=
 =?utf-8?B?VnJhTktJYnFRSGVaTmVxQmtmMnQydGp6NjV0Q1ZjRUNqWDdXVnpMZ3dRN003?=
 =?utf-8?B?em9hNTBCQTRhNktadjJqN2ZPUnFmRUFCZ3licWdZaUJmZmM0aVdNRG5KUHVD?=
 =?utf-8?B?UjhiQzZpdVZrL2hWc3pENUxZWU82RnFRa1p5YzYwVWFNK0l3bTFSYTVtT2Ft?=
 =?utf-8?B?UkJ6Kzh4ZUtodWgrQmRXSGN5NkE0NnJuNHVRbmpXbS8yTndDQTVIZUptR04z?=
 =?utf-8?B?VmpTM1p6VFVybnBjUlY2dmk5VDc5Q1hlZ1hYbzFETzc2K0Jvd1ZBN211RzA2?=
 =?utf-8?B?aFM0T1lwSHJ3NnNlOUo2ZVpHekpTMGtXSUYyZENVbTlYSk9zRzcwM25LZDIx?=
 =?utf-8?B?bG80Tzh6WXhTU1o4bUZORFQyT1VjUXg2RktpaDVYQnJ2ZnRIWWJxQmJlSkhX?=
 =?utf-8?B?Nk9NcVpxSDUzTjY4TElhZjZCdGFIU0xCOVo3NlNBRENveTlFZzhHZE5SSzJP?=
 =?utf-8?B?dUdVdkdPNUFIT0g4aThLZFAvaC9kNGUvVTlwWUp6eFhveFRzQVNoVDJpYlpj?=
 =?utf-8?B?YnlCMVV5NFdJSDNFeTNIK0lYK1o4MTcxeWtKUTRBV3RvazNybndySlcxSS9a?=
 =?utf-8?B?NmYzcmZ4VWk0ZUh3YUxrR2dGSHdwZHVyalhoYmJKM28yMUxNU1NlanNvN3R4?=
 =?utf-8?B?MVlaNkhOZGxQUlpOVWJvVlIvNnFrN05XdmtZQmZsSmpIbVNHd0c0bzZRQ282?=
 =?utf-8?B?WnJ6b0RiSVBxZ1MzNTczVjNkekd0SlF0WEJUUkZQcVIwck9BVmIyaURuK21J?=
 =?utf-8?Q?XThhdA/wFZjH/oXg1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ac199-9d91-40af-f62e-08df1e08d8a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:05:45.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAT3WV931+8KFeJ1MTw5VL8hy4Cqaa2N7J3z2GuIZJfAOfPjZ4XzqnZTIfmNWOYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

On 9/29/26 04:25, Yifan Zhang wrote:
> block GPU PCI bar access during mode1 reset on gfx12, to resolve
> the random mode1 reset hang issue.

Interesting idea, that is much simpler than trying to mess with CPU page tables in the GPU reset path.

The only downside I can see is that we now drop VRAM and doorbell writes, but I think that won't matter since VRAM is lost by a mode1 reset anyway.

MMIO writes are dropped as well which means that we can also drop the no_hw_access flag.

And BTW the SMU code should absolutely *NOT* touch that no_hw_access flag in any way. Who added that there?

Regards,
Christian.

> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 072d9c4e202d..25b9085ead71 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct smu_context *smu,
>  
>  static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
>  {
> +	struct amdgpu_device *adev = smu->adev;
> +	u16 saved_cmd, cmd;
>  	int ret = 0;
>  
>  	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
> -	if (!ret) {
> -		if (amdgpu_emu_mode == 1) {
> -			msleep(50000);
> -		} else {
> -			/* disable mmio access while doing mode 1 reset*/
> -			smu->adev->no_hw_access = true;
> -			/* ensure no_hw_access is globally visible before any MMIO */
> -			smp_mb();
> -			msleep(1000);
> -		}
> +	if (ret)
> +		return ret;
> +
> +	pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> +	cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
> +	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> +
> +	if (amdgpu_emu_mode == 1) {
> +		msleep(50000);
> +	} else {
> +		/* disable mmio access while doing mode 1 reset*/
> +		smu->adev->no_hw_access = true;
> +		/* ensure no_hw_access is globally visible before any MMIO */
> +		smp_mb();
> +		msleep(1000);
>  	}
>  
> +	pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> +
>  	return ret;
>  }
>  

