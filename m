Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCD606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kdslC3pz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF1010EA81;
	Mon, 19 Oct 2026 18:28:16 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AAA10EA81
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 18:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP5QeX1pBW+2uKsjVcRHLcvnSSyZm9gtYM4n/0u5b8eqIg2MK7AJfsvPCzoDeg5O6C7VFvbo/aRnZrjds7qRzZMlLTaJijNaZLkNqGvCEy7/8O4k8o/hq9LogIkf8O4hIZMhNnRrgMu63DSMLkHRwDc1ZY7aPQGLjCSuJl6V/38NX+POjBK0zsmDKWSgwruoq/clQDXP5w3BItgxscvWC3Io7CuhfQAXYPpX+AO9OOtIFIEZ2+T6tKdA1vR9ZBOPcXtQ1CaWWSTyOsZ2h1UEDU7xaU4UklvcQXISjNY2B+iVnEob471FckfUvpWEIUcerTaUX5X/OvknXvvcy9cRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7gVTgl2jyah3rMZYsoPSur12N0en0ueBBwh09TgSeI=;
 b=ySO01imi74IoZ909Zk/QquG3fG9CxHjTPD4TJ45smC2HZoRcGOc30m4snChtMdLME1ysGiOd+0xh5qxTmtRmfuK14Xb+EQCVJbCPNYXZh/j5r1SwGTVgYRG1ot1tAfH0coz/DX8pU199RMNBXHiAuD1gkc3xJucQPUao2hsiJiPuN8CBI6WcM94LvfpZwjM28vDSeAkoyj8ylGdOTUS+cDjEjfdg/HfOQtsTm9+CNAi0lFEcZEWGb7oWz1kWKyAj/N+Vn+y2vPg6Gi029tZkMw1+OAJgoAkYyk80nyHTpCKSV1z5RmiJg0rqfA3A+yTni1NDFJIQNyFDydbgbIVrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7gVTgl2jyah3rMZYsoPSur12N0en0ueBBwh09TgSeI=;
 b=kdslC3pzT3SCEYFML0SMlfp9vLYQukqLIKZfmxY1vI5bBEpt9CA0zRSupMS/3AW3eeHoI5xduIOL3t+PfEQRil2gEinF07ePFkQkOgfkoaVSyt4D7rvsrsr+Milpp4N57GZDZXV4/t54H5BCcpI+uoT1JGFsTTR6G/B2jvgeQWI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by PH8PR12MB999298.namprd12.prod.outlook.com
 (2603:10b6:510:40b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 18:28:07 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 18:28:07 +0000
Message-ID: <2f4716c8-8a3d-42db-ab55-cb42145f9707@amd.com>
Date: Mon, 19 Oct 2026 14:27:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Enable SDMA IB processing
To: Yongqiang Sun <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261019175807.970192-1-Yongqiang.Sun@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261019175807.970192-1-Yongqiang.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|PH8PR12MB999298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aeb7989-6031-46e3-c698-08df2e0eb888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GTqLrNZ092s5p04oWb+jm4aJe9H3kfGl0lug/q/YAl18+RaKpJX15k3N9igsLJX9tC1/XPtfTFmIw+rTamj/J/UekkCxxl9z32Rp55cdNxXYv7MiORHXN+xJc/lCYt2lueD0J+BqkWhIEcFdqFIGlQUDlIVl8fZ/PXX+OZVn2OF4UrhLT6FI3mByQLWDervS4Wt8iQ02xqyAufePB0S+041rwZZxAxqfU3HvfKM+jbHUGIFkV+RjfOYpiGEa12pGk9C/NxwT9D9oB2H+vjLU2ResriG9s3BuafYAeD3TsuX6myz4hhFzODRxMFymEdFEh2gdTXNoxQWqG0IyeFg+rGP4V2E7qLTGXqMoCR1k9CyM8AZkB8zb82Nc2NLWwfQalZS5lpsitzQ5dPeyhbP2JZwaUwFGKJkOlNH6xrPxABkaso5oPo27BQQgVzh3ooYL6656ht8t7g64WHv/Gax85S8Esn8GjT0AWz021M9ZtRVtNeVLZHChH4MAcwgY+FZPfyZr6zTpAz2IZB0sir/bQqA5UpFxDVkvFCeD0UwFhNuPLrM0Z1UZejAiJi24kx5yVGPXGbY4hyArWA7v0FkIiwkL3ThNs09VoGtrgwEShHZKCzJtRTBs4AyNsrDpMEtgUYTs46XUHRtuGVassxnXe/Lak26XLXlZGAlbVHm5g+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtKWjNuclFMVUpCNHViZFRZZTdGUFVnRTgwcFQ5a0QvRUNUekg4Qm1oUGp6?=
 =?utf-8?B?eVk5VXZpYXowc2I1NTRVYWVzRWNtaG96a0FSdVRzNS9xRk1TdFk4d0prL1JK?=
 =?utf-8?B?OFc4aExNZlhXalVzaitsOHpIeTIweHdQM3I5VDRlSzQxVmt1YTFnNCtDM1BY?=
 =?utf-8?B?WkkzUndQOU04UWFpMVFYUUJLVnZMdG1nUnEvU2pRRmRwWkdmNERqSy9lVDJS?=
 =?utf-8?B?M0dxYVloYVljVm1IcUNUd0ZvSnlVOG1aT25VUlRna3F4L29UcFNkTmVMbHJ0?=
 =?utf-8?B?cy9Ja25SV3BQUjVJREZPS3hROEM2UlRyWFN0WUV4QTgySTNGUlZqdTRVbytx?=
 =?utf-8?B?NGpHQlRnc25Ua0R2ZzBKVEIyQ1lwUk1xejBGZ2QyM1gweVVaRGVTNFI1aGhj?=
 =?utf-8?B?OTRrT3ZaSE5CODZwMWZYYnB0QnNJcDBmeXdTSVgxNklaYmMvVnYvR1lmT09O?=
 =?utf-8?B?ck5IcVp6K1dPdEJsQU0zVG9ZQWtDcnBrTXg4MGsraTN1UXZZaWVWNzZXVzl1?=
 =?utf-8?B?OUVydmtFQlZUUVhGS05admtDcTBSeUZycG1GTFVldkdNVGFiTlNqOU54ZWVi?=
 =?utf-8?B?REZIUzhoS3g0RmcySU93aHFjb21OVzVoa0tBN25JUlhLTUpDb3M4dlVwZy9O?=
 =?utf-8?B?N0tBdjVEOUljWEhmc1dIeVZmTlJYaXUwQ2hjdzNOZnFiUXVUZ2lQbXZHVzBG?=
 =?utf-8?B?aUNkM1ZOa2NXQWlIODYxZUcvZWlGeFAzN2E3NXVzY1R4ZmVRTGNKNUVjbTBP?=
 =?utf-8?B?MmlVNW1vSFRkVEtHUERKT1BwWU1aUy9xb2Z4QWZkZW5GMnIyZEQ5cHNCVEE3?=
 =?utf-8?B?RmRUUm1GbWswcmxuTVdBN3FBdzRDV1RQUHVYYzhOOWtLRVE5V044S1J2VTdZ?=
 =?utf-8?B?WmpXWW0zVm5kaHE4QnZCajVpMFozdUxEMDNZbzNmOGFhdzgwT3VXQmpkNHlF?=
 =?utf-8?B?SmVjSXEwRkNoTDIzU2RYaHVlTTVlYnM3MlpNVlNhUk5PL0c0Q0pMeDBBQ2R3?=
 =?utf-8?B?UG9RTkNJUHBXejdUTFpYMU5tRWRtRFo3RnJ3U2ZIR0lkYkpvM1JpZlEyNGRo?=
 =?utf-8?B?MTh3dHFLMVZKWWpERXlXTVRLQnJyVXN6elY5NVN3NGUxQ3B2akpHUkZzUEpF?=
 =?utf-8?B?N0lpd1VPNndSc0d3Y20yRlZLYjVHZ0NjNnNLNld5dDN5anpZaUd2cEdEV1gz?=
 =?utf-8?B?U3JudHBjQ2dpdnpNc1Rab3I0QkZvSXBuVnhqOEJCenZwZW0zN0gvOGJ5L2lO?=
 =?utf-8?B?TVlmdVdVbWw4eWh1bnhLb2JpRjFPS1FOMHZhL3dPZSttTTNUTjl5U08wMGlr?=
 =?utf-8?B?ZUJGdVFoUUJEN2VzdXFRUXlRQlJYSDZVcDhhRWl2dEtxcnp6ZFd3UVFSMXA4?=
 =?utf-8?B?ZGo3b2xNaEZvNncwQW04YzFyMTdzSTFQMmh0R0JIWloxZzk2Nkd0YmNmM3hO?=
 =?utf-8?B?U2wrVXVRQlNTMVpvSW5NeTUrSXY4RkZoc2RqQkxsMHh4bWZOTDhFVnp4NWdi?=
 =?utf-8?B?ZUk0c1hsMEU0R0NvcWtGUG9PYzlCNCtQTXVtOHFzdXNpV2NDbnFLM21hY2w0?=
 =?utf-8?B?ajRFUVN0TnlXWnVtbkZmMmZqcmlHYWhxNzhQb3A4ZE5xNkk1N2NSQXRUTGNJ?=
 =?utf-8?B?aEtGRWZIS1loZXlCS0RQUWZ4bGYxdEp4MExLRFpSL3ZWRG1McFhuZC9LRTg4?=
 =?utf-8?B?blFMTVNXNzRaZkZrQjRRM200VkhFOGhqNElOcEdwZ2hTWGE4VTljL0Fvbm5Z?=
 =?utf-8?B?eWR2bHptM240cFlBUGc3OTIrNmw5cysyQW0wL3cwdUtHUEc0QnpRc0J3QllD?=
 =?utf-8?B?bXBuQ1RCV0NSa2FQOFNnRkcrZWd6RnM2b1VHc3phN2F6WnFCTFR2RFYzc2o2?=
 =?utf-8?B?UGoyR09PNGJzS3dwWGs2NUhLajExVFd1ZjBFUm1EUDMvZ2ttRzFhSlhxM2Rm?=
 =?utf-8?B?MlRFWEdIbW9wOE9PZ0MycUVISkFTM1ExbHd3dEdGajl2TW9lSG9rOUdWNi9m?=
 =?utf-8?B?RW9QcjgrNVB3UUtORDl4dFp1NWd2ejlVYWlvdDFNbkFwVThWNnl2NnFPdG9R?=
 =?utf-8?B?VkF2NWUrVnNNclBmcmllOUdoTWFSR1RJSHVNM3l0bkNPczZWK1prL3gwc1Vq?=
 =?utf-8?B?NUN3OGZONitTcUVyNUlwcnBYekphWlRpZmhrczJuYjhFc0pVL3lYZEg3VWsv?=
 =?utf-8?B?YWNVRjd3UkR3QXhqTHpPOE13WEhOV1FSK0hpcjQ4NDlxMi83czVVcEc5SGZU?=
 =?utf-8?B?SE5wNHovNlFCdlJmajFOTW8wRGpweUUveUJ1WUJhdGpsU3JzdnU3N2k5VjQz?=
 =?utf-8?B?bG1ucFRKaEJJaGxoNUNZME83RlM4RllDQ2xkZmh1aUp4WWlaSEdOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeb7989-6031-46e3-c698-08df2e0eb888
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 18:28:07.1727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWPzX+JhrsgbSqXnUpc7iQC4SvsKHGsK+FEYxdtzmKafSsuc4tzBcr3xUrTBY1yZUHzU8zsHlhzNjdnapI+93Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999298
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 1:58 PM, Yongqiang Sun wrote:
> SDMA MQDs leave IB_ENABLE clear,
> causing INDIRECT packets to be ignored.
>
> Set IB_ENABLE while retaining SWITCH_INSIDE_IB.

This is not entirely true. We are enabling SWITCH_INSIDE_IB for GFX 10
and GFX 11 in the patch.

Maybe you can update the commit heading + description as:

"drm/amdkfd: Enable IB execution for user-mode SDMA queues

update_mqd_sdma() never sets IB_ENABLE in the SDMA queue IB_CNTL,
so INDIRECT packets submitted on user-mode SDMA queues are not executed.

Set IB_ENABLE on all MQD versions. On gfx10 and gfx11, also set
SWITCH_INSIDE_IB, which was previously only set on gfx9 and gfx12,
so that a long-running IB can be preempted."

With that fixed, this patch is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |  7 +++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  7 +++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 11 ++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  8 +++++---
>  5 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 4f8a8a1a6186..25f5a2cf02ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -396,6 +396,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdma_queue_id = q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  
> +	/* Enable IB execution; allow context switch inside an IB so one
> +	 * queue cannot starve the engine.
> +	 */
> +	m->sdmax_rlcx_ib_cntl |=
> +		SDMA0_RLC0_IB_CNTL__IB_ENABLE_MASK |
> +		SDMA0_RLC0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index bf015dc5b868..a1eecdf63b0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -478,6 +478,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdma_queue_id = q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  
> +	/* Enable IB execution; allow context switch inside an IB so one
> +	 * queue cannot starve the engine.
> +	 */
> +	m->sdmax_rlcx_ib_cntl |=
> +		SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +		SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031caf..e0574fa325c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -353,11 +353,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  
> -	/* Allow context switch so we don't cross-process starve with a massive
> -	* command buffer of long-running SDMA commands
> -	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
> -	*/
> -	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	/* Enable IB execution; allow context switch inside an IB so one
> +	 * queue cannot starve the engine.
> +	 */
> +	m->sdmax_rlcx_ib_cntl |=
> +		SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +		SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 2bbf5e63f615..04e1575dfe76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -457,11 +457,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  
>  	m->sdmax_queuen_dummy_reg1 = 1;
>  
> -	/* Allow context switch so we don't cross-process starve with a massive
> -	* command buffer of long-running SDMA commands
> -	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
> -	*/
> -	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	/* Enable IB execution; allow context switch inside an IB so one
> +	 * queue cannot starve the engine.
> +	 */
> +	m->sdmax_queuen_ib_cntl |=
> +		SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +		SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 6e6bc1ec0b64..80df86f7c4d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -569,10 +569,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdma_engine_id = q->sdma_engine_id;
>  	m->sdma_queue_id = q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
> -	/* Allow context switch so we don't cross-process starve with a massive
> -	 * command buffer of long-running SDMA commands
> +	/* Enable IB execution; allow context switch inside an IB so one
> +	 * queue cannot starve the engine.
>  	 */
> -	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	m->sdmax_rlcx_ib_cntl |=
> +		SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK |
> +		SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
