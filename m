Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C4CC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 07:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D8E10F1E8;
	Thu,  2 Jul 2026 07:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j64eAxpJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F1610F1E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 07:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6BW6agS7mCcRG1E5i+KrX7EsX1Wq26oR7x22Hd6YGI+yhvuubA1gMlZQ87edPyyeH/0HNkKVXvVT/LCy8xQWCSLf6rffydID/6iZqal7oEvlecuGcju2lztkutsJb5jov7KfhhCGF8xs6DHhY2QFpg9cRWSc8dmdC1OIyKjQlzSy8z9Jvyn+Knl+oJhAg3G+r1u2OIccNqryO13uweNrHxkNspqplQJMwGCj439Fpebqm9WsY4YBJBtXZBMx98vGohvyV+EI7WlzhvqgRFqyufY6iuZUmBiEkTn+UhVm/j54XcB3VSiFD8fWEaivPKYpIhPUNlUyhWvldR8ZlTDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLhLRs+RXShtwy5K090FTlJpRYxliX1S/FH2SnssZL0=;
 b=tLh5ykSqqaD6vlV4YKmacHWANQ3JwJUfIE8R1BRHWq9ZC8ILnuxvIsFCdhFaKATEbjVtwCN8oTvXrRFUYSPhJ5rpqC+DtgLwxvLstZDZelZmjeFN8WN5l+Ed7yoAK32SEzwqPWqKgG398XNVmqlSqQmN70u6qcs9DKI6KQ1eamJqYUXmilqsqTf/VpGTnM5Fpdc7bWip53EMJvWenJ9PQEmbyOz4K9JCCdm90vWsHvD8nP9vaPYHCz7kH+hJIWB/9cr+eRrZumAafqlqj7Wm5XWH5vKorSaKUQExfOuE80ijZ6inn+qjQYofEc3/h9jKltXZt9wKvDyspK6jrQvI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLhLRs+RXShtwy5K090FTlJpRYxliX1S/FH2SnssZL0=;
 b=j64eAxpJBpWHAOTKCjOi++aM5vKbHFa5MiE0E2hBGhzhvID1nCDX4qboWXj55ssV0GYEA4WiQR8nGRMlHKD8ehmh5roUhkGuSN1tU1UdHsL5t9tid3EX/aRHZTGRxKpI1LdvxLCFsLtbzUKkr/XLhFQJuQJjS7YOVF4itKQaCqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:59:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:59:05 +0000
Message-ID: <2995c497-ce60-4274-93a8-80b027190c87@amd.com>
Date: Thu, 2 Jul 2026 09:58:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drm/amdgpu: Respect noretry flag for retry faults
 on GFX12.1
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee19f53-6838-4887-4775-08ded80fc948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|921020|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MsmrRiIh9oeY6oACaxdYVt5hr1rgw7F5R1aJ2OztIpbb24JQpgEMXKKwRwpm201tF0g2koXTu4N1QCTXnqSQ+ro86GWz+YcYvDxf212aM+nhpcg5Bv8N6k+0jjEjEXw1eBK2XIG3aucgLRGvL4ZQYmdh2Ebsj4Iof8EJCdHLj/Xj70bC6g+dqARxNc2f9nSsXUlrQk8GABG6nxP7+NKlU9dFCi+lsWbrBgMDF54e2wEnUgsKzYGmNV2youPf40opfmf4llpLqJgDy+x+xYwE3ifLCw+xLUpskMqqtWmLqPT5jrYnr/50Gc36D+E/421zAV7ny3c5UkWoiUU9JwF5jlgqTqW3A01JBHb+M0EO2rbSRPq+egd6PHfldi/trRP/2L4ljKCjWCJDmWlG06NYFsn2kwH5wTDe0roAI/9vfoeIiEPQSWmfcmXYfrbpESXEkBzTkO3bCzcDnYMBN+NKMNQkFiIUcObYIrjodkbyy+vaeU2l0q7UN948nQDhgmJDdPUvYxT3kqKeK/MfOsBKIZUxJGYAampQY20B4tN4EhZk+niTA54i9eMuAa6vGi30zLrHeNLd2p22GUiR6J1/OPmVi9ee/f3KmErsV9dNUrNpmm8tWP8t+lGTBuFNdfHxdAwzVx/E294fCewdoCLIVGlxt018WI+odMETmmOGeizMaVV4+6lvCUMfBYfG569w+K9kGRtKbiR5mBvVQw0JfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpxOXFHV1hvWXpIQ05sMkdWU3V0S3VNWWZLWVB4a2JLejVUQ09Lelpobk9Y?=
 =?utf-8?B?QWJGS2U5aGM2NjZIL09ncVprTlF2UFh6eCtKK0dXRUVOa2I2NXc2YVlXZUhq?=
 =?utf-8?B?UU1zWVJhUFhWTnBFOCtBLzJKMEZ0ekVQVlo4emhNOU0zeWw0SE1DWmhKemp0?=
 =?utf-8?B?dmltTk1KUTZOWHZNS1VVQ280SWJ4ODZzd1NRZTNMSGFhMTBTUDZUVUFWYUUy?=
 =?utf-8?B?VCt2bmd4L1ArQTlGUnBIY2hZUEIrcnJhZHVzNjFvL0JaUkFjdW9oTmFYSWVN?=
 =?utf-8?B?M0VRUFFBUDM4SUN2dDJnbUE4YUtaMElPTjE4VkViL01kU3ZnYjJ3dFJiQWNj?=
 =?utf-8?B?MGk2NVhHTG9MSkU1eXFzS05YTUgxbFpCbVZ4QThwSnpFaE0wK2dQbHRTQWd1?=
 =?utf-8?B?NW5zbDNWMG1OM2c4NTRXMTFiYmp6bFlTRHBGMmtWYm8yb0F4NDJ4aU1iVzA5?=
 =?utf-8?B?c3BybjE3NVRwTm1BRHNIT2thdEU2d3BSTExiR3puV2t0MzNtS1FoWkV5dmUr?=
 =?utf-8?B?RUx5Q3I2UE8xT09BbjQrTXBlTlRHczFldFFNOVFtS0xlTnk1ck1xVFU4bFdj?=
 =?utf-8?B?T3dFNHNJMnNOVkJiYWpRbkVORVFadFRReVFsOCtSdlF5dzZmSHVGdnBublJD?=
 =?utf-8?B?NXRjQVhDeHJFNEtUNFFTdWM2cWZrdlpjcHlRbWlFRVllSFQ3TkhLOXBQdzNW?=
 =?utf-8?B?c0JSMFFrM3hqYVhsanE1U3hXb2I4RW83UXRTVWhMcVVVc0Jkd2tzY3duWlNW?=
 =?utf-8?B?clgxM2JINEs2VU1wWitOK0FERWg4QTROeGpaSzczS011eHVscnJxZmV2bXN3?=
 =?utf-8?B?K0lLMlRrNUpvS2lycjhqOVJBY1hxem9LVnJKMHJWVCtlTjVORTgzei83QUo1?=
 =?utf-8?B?SWtVUTQrT3RvSkk5S0xaUUh3YitsNmwvYnp5K0k3WjdCb3NlbjVLbFNRdnJw?=
 =?utf-8?B?Sk5IUHNmd21HYUtVT1liRHlYcDFoeVAwYm53bmxmNklYclV2ZmdSTUhJM3V1?=
 =?utf-8?B?eUVYbTI5S2ZUMFZOd1MyK2tEa0h1R1E5d1hYakdrdkVjd3BlMzFWNm9QcElR?=
 =?utf-8?B?cFlkVFZSK3JaZzAvb2VyWXBlM3pmelM4ekpyZTdHYkM4WnliOHpyWkdEWkJm?=
 =?utf-8?B?NFN5QUtqZ1dRckR1QWJTYXp3VktMZ0dtNThKZEtSSExkZVVlMVpUMTZSakEv?=
 =?utf-8?B?amxsRGtIOUprOXhFakdseE05QWtuN0N2MzYxUlcway8wQWZGbmY4RzFpYkRp?=
 =?utf-8?B?ajFsTDV1Y25QWFhQWWxPakdMajRPdlY0d1Y4Yi90YWQ2MU9PN2ZpWDA2eTdu?=
 =?utf-8?B?NS96MXlJN3paMFpGbG5rbUxUQVVBS2o2ZHpjK0dlRmJjOGdqTElKbFdpcmdu?=
 =?utf-8?B?Yng2QWVhTlNpTElVOWI1ditxcFhnVW1CN1JaOExhSjRieUNyZEgxTndOaStX?=
 =?utf-8?B?eFk0SXBjMnFlcU5EQjNTVWlLc01mdXBvWE94STkwQm9WaW9KMHUwdlEyTVc5?=
 =?utf-8?B?US92QlhuQ0lDU0J0SUduVWlEbG8xQXdLZXR3alZ3dlhyTWIrT2pwMHpBRUJB?=
 =?utf-8?B?RmtFd2xtcmFLWVJTNklLdEsxeXF1SEJiVmh1c2dndDYxbWlzbytQMXVYdlh5?=
 =?utf-8?B?UHdlc2ZyVUZxK2hBNy95SkRXT2QycFlScGh2WWNSVXdYUVhLclkyT1ZZYUFB?=
 =?utf-8?B?OEdVNHl3QnBGMnNTdGFGVGd2ZkN2VjlDc09QMEwyVDRFcHVsalp2ZlE3WUJT?=
 =?utf-8?B?cVJzdVZLL3QvU2NVN1hmTDFyMGRWMTFnSlkvVnJMcXNzLzQrcnEwSWhINXFj?=
 =?utf-8?B?ZVVIZGJFYlNEYkJIV1FVV3h2WVU0Q2xRdTdUTlprdzZSUCs3THE3dkJzQ05K?=
 =?utf-8?B?alRkOVlxN1NSV2hrVlgvS2pjSytDVERWN0sxUFg0dC9JMDhuZGtSSzYyQ1Np?=
 =?utf-8?B?bjZ3UDNIbW5CelFOWUdvSlVKekI2UG1LZ01aUmZKbWtET2J2SXRiejAzSXZR?=
 =?utf-8?B?VVZsZldoTmw2ZkwxS1BhcnhQRUNubTN1clRVZmdKQ0twM0QvVWh0MmYyWVlH?=
 =?utf-8?B?SzlFa2oyQlRsbW5xTkNocjk5NExMRTFxUXBHc1JUMktQMlhXVnAxWm1JcWgx?=
 =?utf-8?B?cWYvZEpWZWJoS2VMTEZwY3prTlNBK2pPa2NHTEZVdTV3K1BNbG1YV2JJZ3RF?=
 =?utf-8?B?TjJMRGFCSlpXRUF5b1QzUkRhVUJueHJTY1JEQzhxNVNFZ0F6SENwNHFNUGxK?=
 =?utf-8?B?eUo3Z2FGZDJjWmxBUjRkL3pYYzI0WUE1OENta1FKejdmd3RUU0Z4NnAwRUQ5?=
 =?utf-8?Q?nH3+MAjNfX1tTEGmLW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee19f53-6838-4887-4775-08ded80fc948
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:59:04.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbPcYUNZ5vc6wCP+flU4kgeI6zwFv3i2nyCZCsXYOPZbjIbsArlbID8eVAg4cUY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

On 7/1/26 18:17, Timur Kristóf wrote:
> When retry faults are disabled (amdgpu.noretry=1),
> the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.
> 
> Note that retry faults are enabled by default on GFX12.1
> so this just fixes the case when they are explicitly disabled.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 4c2fd1e6616e..0cada13d92a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -243,7 +243,7 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
>  		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>  				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
> +				    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>  		WREG32_SOC15(GC, GET_INST(GC, i),
>  			     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  	}
> @@ -447,7 +447,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  			/* Send no-retry XNACK on fault to suppress VM fault storm */
>  			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>  					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -					    1);
> +					    !adev->gmc.noretry);
>  			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_CONTEXT1_CNTL,
>  					    i * hub->ctx_distance, tmp);
>  			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 49b7f16a941f..f2c549737e02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -320,7 +320,7 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
>  		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
>  				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
> -				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
> +				    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>  		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
>  			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  	}

