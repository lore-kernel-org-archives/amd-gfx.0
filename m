Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC3CC982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D1510EC65;
	Thu, 17 Sep 2026 08:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ucxpefgp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DA210EC65
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 08:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmTBzlx4KmgboEy3x7hld78rSgNm37b088kIopK/zBLAQ3tuK6AXyiI1lbZW4AW/a23Nrv4doMjnz9mP2tvxEm9V0AlA/023Q5u4LBG9P1Kl5MLwTL77J9ASIuRUlkoLsGsUddbfMaEjByl8Z0PQZLS+9mtJWYSIUVwTbBUV0c583LScMOhIB9kq41VK0GC9HnOfF9VyFT2UFqvki00C6G0cBfV9E9lWWapKGSAqwzU5b6ytcS/VKgidy+qk+9XcM6P9sEbG7Od/y4cymHgxMkh/kg3304Mdy167R/NNm2pOvtSwYGSGx4Go9AxR/8UBM72nqCXQtUPuN1qoliEhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PgGi+wCNeAsr6NJ5PR0fYef4XaG0mjizx+I1t9o7yg=;
 b=FsJPNnq867qxwKMJ54cX8A2MKUv/55TMhSkYo9AtgfN+9xge/KamiaNn49rXC4Dgd+91emkx+3PMDelW8HuG4WKGhL1zPZ7t5c34g40t6W/ub2tF4221Ywgw9DRCyM/zimHXBscSlCHgIImEpBjJs7n16j5AFOwgOH2ZceXxfGZbJLd5+x0JJ2tm34/PN5bEOJG7l7tUO6vVRJ62PM4dvO5cPTw4Acgcm957t/zKrU4DYKd5Eh1cywQ4hGF4AkIc3YixLZor7WPT52aINw4uYQ8qyts4GIT5UNmhGB49PSpK3uj17mhcoUnTOWYCz0/rcRNetbVPmz3skZpf/Crc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PgGi+wCNeAsr6NJ5PR0fYef4XaG0mjizx+I1t9o7yg=;
 b=UcxpefgpbmrkzHC+07vZnDqtSk66coz8k3b0y/sY8S79dgRa4AoYvWcG6AiOXy9lU+IuPzzQxoEcLnjaQPvlIQgGJ+bEy+mO9kj97BB+SNmjXtu/pPmm+fhRigflbeeOGWfUpnuFFpSBYIj9aJ73fNEd7A5bKDRKdtOqk6ZPZXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:19:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:19:30 +0000
Message-ID: <a1a90f4d-4a38-4c0b-8f35-5496c527173b@amd.com>
Date: Thu, 17 Sep 2026 10:19:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for
 GMC v12.1
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
References: <20260916225549.282123-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260916225549.282123-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: be29abf7-b814-4ff2-88ee-08df14946566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rgYWIl4+v5j+TjI2w1woE2gkB3np0y/wnQ3WNRD06Tr8S+0JWKZfeFwGxnY6yeyCAdTu7+5OHjdWDTKyFkMVir5jAYbVyvdEUnREKS2Tf3AUIPMvCCggKnoDqBNfjvhdvAurDOx8NglAkiE0DpWSW7k2ULJWeYxN3U6inc7qKsnxmbAsdw1yiBGqgvtzHSG2G8Opu4JLH1no7B3/eQaoSVOvuSEPxP05xWpcKqKo8m3SYnNtl1HOjSIgXJFEeG5zjWg3CtjiagUAUZhN5uHwdFhU25RTPBhQ7lNyEjy1YbSiCj/FjP6KIoQbV+SAkrpgS5f8kgw/Ph6krigmVI4tgYTktj7CD0arXyVFpFmAB3obIIWNwC/SvTxnt1mCSqVe43b0L/6uNPSAVJvRLYCR5id4HghAeVAcNtcYe4jLFyCB3KYRpVG0Ov0/PbOSphUVgRjbQDnhck67WEaL7ZzZSM7fjVz5mKCGNZNi/3wxii4eIhCupmBoA8xfKy2AJZhHFsQTf4BhPwjiQ4GdpdPAztWHv0rAMzr6yPJbXwQ1kR6XQEaMDiNRhFYGMzYlDeUGnJ/doNB4GpUAciEWOaWZmjzDb7hAX8108zEunMxNTSWFjpclKwIA0YG+zynVLqJ0w+ysCPCLBR9YLhlDxm6Kvp47AYYp04GxB/ARfK3Ks/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTk2WHRXSnE0RG4wZDAyejdka2RoS0FRYVNFZERmVUZBNkxyT1pHcFJIcHZj?=
 =?utf-8?B?dUliMTlRMHFKb3ZjbGVDV0ZndDQ4VDRzWndpODdHbG1WN1JqS2lxSHo3NHc1?=
 =?utf-8?B?bDEwR2FLeWFPVGVMVGJ1dHZkWUhKNW5YL2p5UStheUU3eThTTmNTNUNNaW5G?=
 =?utf-8?B?dmpURHdTWk1QRU1RdDkrVGc2NnVyck9QNzFWUjQ2ampwSzZHN2N2UDVxY0h6?=
 =?utf-8?B?T0VDK0xmc2g1Y1B0OGxwVkN6ZkhlQmZmNFFtOWVYL0ZRSFVNQU1TY3NieG1i?=
 =?utf-8?B?VVdYTTluU09YaTB6cWlCdXQ2OWszbW1pL3lJWlIrVTZJSWJkM3VqMDE2RG4r?=
 =?utf-8?B?WGwzbG1FZEJzWnQ5MXgxZkRtbTdGSndWWDRNRnpJdHdaRkRlRnNCeGFJRW56?=
 =?utf-8?B?M2RIUXNscE5FUWF5SlFlOTFZUmJPRTVmSmtFeng1V3pVZEwzdUVMY0tTRysv?=
 =?utf-8?B?blhuNUdQVktKQ1pkamJaTko1RWRpclhpSU91N3FET01NUFkxQ2YzMzRvWWV2?=
 =?utf-8?B?eGpaaUpVVVBaMlJBaGhSVnViQ28xNEg1TDQvNm5FeGRsQ3B2cGVpd1cxMnZC?=
 =?utf-8?B?aGtIZUl6aFFlZXExNmVLVXo2V3dFUnJXR1pUcm1BOGIzUXk2ajR4R0RXWWQ0?=
 =?utf-8?B?UjZ6ZG93Sk1Zbk8rQ2VNWjNxUCs2b2c1dXNreGl2VEV0NE1kNDBxZXdib1pG?=
 =?utf-8?B?UCtCZE44MUx4dDNlQ2ZES2NLUzlxZUpmY29CV2RRbDlESFQ1MVNwYVlLd2Yw?=
 =?utf-8?B?RVU5R0ViWUk2RG83Z29lZXRQOVRFM1BkMWtrRStIL212S2FFbnh6alpobjV0?=
 =?utf-8?B?MFNTMUYxVTM4WDdvU2ptNHdHMnY3Ti9sbklaSDZibHFHVi9NMHR1KzV0U0xU?=
 =?utf-8?B?b2NyYkdhajg4b2QrWThNSHJ5RTdUQVRpRmJMY01KVUtRbGRVRUxSUXhENjEr?=
 =?utf-8?B?aHBZQytnaW03OGwwY2ZXMWt4aDhralR5QnRHZW1nQmNjRnBFaWJ6OVRPa1lx?=
 =?utf-8?B?RTJ3SkdMNEJiVVdBN0oyZ1Q1TzV6TEFEaVhmZUlMYldOYjUyR3pEV1pUMmt0?=
 =?utf-8?B?T21CU2t2cCttRjZib2hmWlJuVWxuQk5WdkdRYUY5Ny9mYlJtcDNWVHNzVDhj?=
 =?utf-8?B?NUEvV0JLQTcvaS9Cek5VemNjVjAyTTIza096TFFhRXg0ZmkySENPQVlsMk5k?=
 =?utf-8?B?RTF0Y3JmdEZYcnByTTBYVnJRWFN1MS9nWnN2TWQrM1g3NTd4b0t1aWsyT2dK?=
 =?utf-8?B?NjdzQTdmclVWQUlteVhEUmpVbDFVb20reUwwQi91QitEbnFnbHJMQkxFRkNK?=
 =?utf-8?B?VzdwVytJaG9sTVRVdHB6ci9ncEk5ODE4U3FPQ3ZsZ29XK3ZrK21XRU5HVWNt?=
 =?utf-8?B?MCsxYXpkZ2xYYWpRSzZ2eGpIbmE1VGJsM0ZKSlVKTnllNmlaelI4OVNpZk1O?=
 =?utf-8?B?VWFubkd0SUJBQlVuajJzMVFDSXNhbGNTN3B2SkZlY0Z6Q1JhWFNVUWo2TDhJ?=
 =?utf-8?B?MmIxczYzQnBjMDNGcDQxbGhQOFYwZWg2YmI1bDFHNXN3K24xZWowdG5Bc0RB?=
 =?utf-8?B?M0JLZm5aMHVsMnFkNEVlTWRMaDRvbGZmd0owQ28wMXVCMGVPdTRUc1lhbVE2?=
 =?utf-8?B?WEw4Uk9DejZUeDFocTd1c1lRbHdjenFvOFVkRk56NUp2UFZzM1NMTWlXZC9h?=
 =?utf-8?B?T2duK1ZYUmRpUFoxdjdvVlE2T1B6ZnBsTEZsUjdHL3NGL2NvMzdCTXloMXla?=
 =?utf-8?B?R280YUd1T1FQaHZWQnZwb0dUOEl2TEdTUXNMQkdIMGhlZzhndGJSU3EzTEZP?=
 =?utf-8?B?Mkw3Kzg1VEI5SW9yMXIvRnpGbC9qeDVHb1VMS20vQmtDQmVCMnhHNERPMFl0?=
 =?utf-8?B?NmNtMWd5UmZFM1djT1g4eHdtbWVIM1IxbEp2TjBCdTR4M2MrWXUzZmFKZmNm?=
 =?utf-8?B?cDlXTkxGTE1MMmJrRk41MTNTWnVibmhxaVpUdWRXRzdWd1AySjZ1Slg1YVU2?=
 =?utf-8?B?RXNEU3oyM1RFdmpReHluUkNBM0xtMWpmYUlzdnR1UE9HSmVqNm1Cblc2WmVt?=
 =?utf-8?B?akY0ZjBiTFhUM2taRjQwRWtrcVFDTHA0ZXpVS2dkWEhmK0Q1elU3SVpudktX?=
 =?utf-8?B?SXZYLzZEUlMvRS83aEwxOHNIcytyOTRMRUZtcE9tTSt0OTV4YkxsOCt1TnIx?=
 =?utf-8?B?Y2N0Y0JXYnQwS0FXZS9iQlE2bk1WdHBISWs4WjFyQXVDTjdxNVJFS2ZWQ3d4?=
 =?utf-8?B?ekFySjBleHNiaHgyaC9IWXIweUxSSytUbjl5Wm12YzNKajZObDRhQ2dDbXhq?=
 =?utf-8?Q?2DFmYaxln68L78AzYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be29abf7-b814-4ff2-88ee-08df14946566
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:19:30.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZpgEDILm+49YAjLfPVO1nBmehCsEGqp5HtweECbcOnTOrXLr+HN9ZyFwzrSwtMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4
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

On 9/17/26 00:55, Timur Kristóf wrote:
> Use the same helper for GMC v12.1 that is used by other
> GMC IP block versions.
> 
> No functional changes intended. Just code cleanup.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 45 ++++----------------------
>  1 file changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 3349e8bc1c20..cfc46f912d47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -131,7 +131,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
>  	struct amdgpu_vmhub *hub;
>  	uint32_t cam_index = 0;
>  	const char *hub_name;
> -	int ret, xcc_id = 0;
> +	int xcc_id = 0;
>  	uint32_t status = 0, status_hi = 0;
>  	const char *die_name;
>  	char die_name_buf[32];
> @@ -164,44 +164,13 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
>  	hub = &adev->vmhub[vmhub];
>  
>  	if (retry_fault) {
> -		if (adev->irq.retry_cam_enabled) {
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> -
> -			cam_index = entry->src_data[3] & 0x3ff;
> -
> -			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -							addr, entry->timestamp, write_fault);
> -			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> -			if (ret)
> -				return 1;
> -		} else {
> -			/* Process it onyl if it's the first fault for this address */
> -			if (entry->ih != &adev->irq.ih_soft &&
> -				amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -							 entry->timestamp))
> -				return 1;
> -
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> +		cam_index = entry->src_data[3] & 0x3ff;
>  
> -			/* Try to handle the recoverable page faults by filling page
> -			 * tables
> -			 */
> -			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						   addr, entry->timestamp, write_fault))
> -				return 1;
> -		}
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, node_id,
> +							write_fault);
> +		/* Returning 1 here also prevents sending the IV to the KFD */
> +		if (ret == 1)
> +			return 1;
>  	}
>  
>  	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))

