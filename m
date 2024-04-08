Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D15CD1296
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01144112215;
	Mon,  8 Apr 2024 07:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swbZXrZA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B4F112218
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 07:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKqnoDdgqpBHiAXGn+7x5kTaR9K8OCS9Tlaf5w/zd1omEmFjHJkemK06q1wcbjGBDwtNk01GmtkNRpQQ8HSMF32gvEhuU/or/V5dkWKnxsKjgCYSN8NvhbZUSca1oUr61+FG+z+O/sCAUJnXepHEBS4W8Ir1VSBdeXbpSnoaoQcdqAMMoSmQKqVlKLk6ALcMOQ7nboSgABZxXsKI7GSuzhnX1l3Z0oA70LsI6Y76rk59OjHivtFGdrwk9qpjaMwfrts1HJEXUEFV5318QRWWNbqCxiGiDS5r/NTmFaubrb8IE2ZLXTuKvLkFhvB97WeX6JILbnpm93nBGw3gQugvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIZV7QASMOowHV0dP/KtuFnBXRSl0KNsVAi/aG7ePV8=;
 b=R1PMC4Ww0rL1j89KEhw0XliA2EHiC9Rn9q8rn/dEwULotbnAP8/+lyJW5j2zcwtQV87ML8nvoSEMiHMZZeCXKB/IqxHFq0e6gFI5cNqoWrn8a48WRz+jyW6Y2NUwna0PJ+lg23sV6bD55MmMBwdYGjysMyX7pMKllhS2GQEg7moCHmX+AziTmFKXCrBReRp9cZUy0AelgbeN5NRCNLCsYnkytrt2nAtcVQXYk8tfYuyWD4yaguaYGM2D0EPEVoOcnVOb+dpZXtq/HfWm226u1oYSf50TpEFyPAPLuXP/MpnbFfRz9fiK8mD8D1rXEcIiHFLe9ws7uPD09hfvrWQzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIZV7QASMOowHV0dP/KtuFnBXRSl0KNsVAi/aG7ePV8=;
 b=swbZXrZAoHjhwCpuu2OCm/+rAzRbYr0ErLFt/xeL7gmEET1fmYMuIUCFpJ4EIjn/+lz4+g/nZpZq1OgEGo3OsKYqtIMFa/NYMmf1xjMgiq5kvvWYVenHsgIBRJJfuNgsJLriW3Qk6Q93rhLDcE99ViKmM83u9e2DPUOdFDzCzp0=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Mon, 8 Apr
 2024 07:55:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:55:22 +0000
Message-ID: <0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com>
Date: Mon, 8 Apr 2024 09:55:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: make sure VM is ready for updating operations
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
References: <20240407045236.3487634-1-Lang.Yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240407045236.3487634-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAi57d3hLov/dFD4BwuufvBdR1Ve9DSF/DKYweQyuVe/ehouz1SD8jR1/VE69QYq8ske3Yx6zqwfWMPQhLb7qCVJiehuL6Hh9morYwENLU4yaj1xuIwM2lLUcNARpba6zuyJR2maOKNbW+hUi5ps2f/H13PJfl0NTs9esNkp7dVHvVZuszgMBc/qdFuN/bdj83Dsrr//shz0cChamMmYyOUMFtxb4qmVPiiQTPSVBp1nV9kZ++M6evjfCgAaIbOF5iDCmG2PSlARV2389trJ8t59Gpl+O6BTN8yCGbfbaP2/V1Ya6cyDL1lRuMbVWY9lWVmmXc/hCbkwSNPu+HnfH3XgR5+YurA1wVfoxWzAdLzvAkt20MjpMzuXeXR7fIN6zr5KQE2s+Q/DnWsr+L3EFMUtb67wLRY5wcThGpOLf6mkp26qZ4J+6RvDbVinZHXqUV5X1rYb2S+5lCB40gILsAAaAOO9TH/87kcNdEGbjoKBoYoqP6fHBMlHvqK/ut27/eXADL99hOml6GqpxQV5EFk5ci1kd8ALj0ELqRlwWjxtOfzBN7LNUSve3B18v6OEd0afZ3VV35yhtuglX0Ss8Auv15NLzvt0AbGSg3LIWz7PNZ4IfwKvqOb7jZZXNZzB9Ei1x0crE085gtXFcGEcgA7/QYIHKgSzwPDWar8hHJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2pjdDVmYUFPMGNJTUlMUVRSRTYrMDZHUlRDYmZ0RnJVVytVQzJ6ZTdQSzFj?=
 =?utf-8?B?eUIyVnE1VW1LbGwxRFh3UlV6Tzl0ZmdhVlNwTk40SjRPYUJaQ3V6bGkyQTV6?=
 =?utf-8?B?RHA3QWFPNzllQ3F1dGNqWTRiVjdjUWRGYjM3akFxMTQ1c0g0cWRLeE9BR0Vt?=
 =?utf-8?B?ZlBIU3RtSkM4VjAzNDdPOHVvMk9kY3pEZHJlM1ArQU9aWnBsZzNpOHZSK0Zs?=
 =?utf-8?B?NlI4bjE3Z0xzaGZGZGJ0ZzF6TXFwYzZ3UTM5WDczWkxGcnpkY0xjdGdqQ1Fp?=
 =?utf-8?B?R1VZUThiSThRODRzdHlBRzUrZy9EclNHVzRFblR3Ym9zZTJjazdMMklmaXZp?=
 =?utf-8?B?Q1NQVENMUkFtV0VSaklkRWsrSjU5UmhNcmZ0bWV5UmMvdWhSVGNtVDRQN2RW?=
 =?utf-8?B?c0ZJSFRVMzNPL0hXNDgvV2JGR2RMRVd3VW5tMmt3R205ck9wcjdDU3VMdmJ1?=
 =?utf-8?B?TzdvYkhldCtNRnVyT214NWozR005S2ZMenAwb2MyK0dveFEzUjFOSUN4clo4?=
 =?utf-8?B?dUgweitnNFQrUjdkQi9YWUd3aWhYNnB3YWpGNGZpODdPSzJEaXFsa1Y0SG9h?=
 =?utf-8?B?WFFWcXlobkpzN2Z6djF6UTBIT0J0dU9yb2dqajRYODM1Z2dPY2VhQlpaNDI4?=
 =?utf-8?B?MEtVYThzajc2SVc1NE9Bb0RXaGk3M0trVmRuelpENDB0NFlKU2VwaVlKNGlI?=
 =?utf-8?B?MnBCLzJCay9EcU1VcTNqeTJQaFNFK3cxQ0diTkZUcXgxdktUUkl3Qmx1Z0V4?=
 =?utf-8?B?aERDaWF0elZ6NEFXYWIxNG5aWlEzNmtBSUlNcXFJc09ST3d4TGdlRWtaVjMx?=
 =?utf-8?B?UVgyUmhhY2lUYXR2aDdBQ2FjS3FWVkwyQi8zYi9jYTBPM3RrQkZrZG82cTRq?=
 =?utf-8?B?K1lZNnZIK3E2TjRpdkc2SWRpdndIRnBJYmh3a21sYkxScGhFclBHc0tRYXNq?=
 =?utf-8?B?OUloRmh5VFJ3TTFGMHYzM05BN0dpZFVoVGFJcUlqcERGN3B1QjBNRS9MZkFY?=
 =?utf-8?B?S0VWWS9acFNHY2J4dmhjeVBNU1BNZzE3V3l4UFFSM2VGdnpXZVpIWFp2YWlU?=
 =?utf-8?B?WFgwcXpCWkxWMnh6U3ZQYXlNeDJHeTlkUkcwYWF5Mkg0K3VaMWNCYWNqMG16?=
 =?utf-8?B?VVgrZ094aS83blRibGZ0QUd0M3dtN3d2VWNtMkpaQmhzQzh4bmptZFB1Wlhi?=
 =?utf-8?B?TjZHc1JzdjNsclloVDc5bU5yU2xvUEFCSm1MSVAvSkErbWRiK3c2MnI5QlVN?=
 =?utf-8?B?STRFcThqdEVyWURDMCttM0YzbytodWxaM1NQUFZZdkM5WlJwc2tIZE9wQzVG?=
 =?utf-8?B?UDcvYUtIc01hOHE5MEptTWNTRDd5aThzS3pmclAwT3RVOSt5OVlqVkxhU09q?=
 =?utf-8?B?akdnaHNUakpQK3Vqbk9CcjlhZmp6NzkrN0drd0d3TzVTeVdPeHJIa1VsUWww?=
 =?utf-8?B?M3JpQm10ZlNIZ2dFdE45TndDeG15OUpubkJxdDdqaWZnNHNuVVA5UFlYWlhY?=
 =?utf-8?B?VG1CbUNObncyQ0lmSDdJcE5FYTZISFNUejVYVDNHbjhuQzZreW84aTBpdTAy?=
 =?utf-8?B?QVM1NDVmbHZKUUlVSEtocFNDd0dHWWlFMTFSMUNuaFp3RW1aQkhROEVaOFpD?=
 =?utf-8?B?Q3FIUGkxcTR2VmViRUJPZWo3TUFiSUs2a2NQUVEyWDlMM0RaMVBOSGlaUnRE?=
 =?utf-8?B?UkJSMTBRNEp0bWZQYWpIUnJEczRKWThqaWpMK1RuTzBTRTVwcjlhUkU4bmRx?=
 =?utf-8?B?Y3RjMi90a0NuT2xpQ0JxMmZ1OE56VDlWZllzeUhJQ29WdCtnVUxaYmh1RVJh?=
 =?utf-8?B?enNFbVhqYXNFSXY5U0RFUFFKbTBPaXZGdEJjT2puS3g1cnE1cGp0ZWRqTmQ0?=
 =?utf-8?B?ZHhtL2RDWHoyc3Nqd3dQVjZ0NFh4a25zbkxZRGNuU3RXUVVtQ2Y2UWZ1SzRH?=
 =?utf-8?B?Qlo5dFVNblZtRDJsMzQ5dGRscTA5MHJHbHVOQmNGUHBUZ0szdUlsemZFamtO?=
 =?utf-8?B?ZDNMamVLdW1YaUl0QjArNjlqZVowVGNYR2NTUjY1TVhPRUxSRzNkOFJocTNE?=
 =?utf-8?B?MFlQK1JKRnR6VlhFelBFY2NFcGVNU0pEVjNDS3NNZzhvVE44TS9QSGtrRVF2?=
 =?utf-8?Q?D4BS76pDQdmzbkYDakpPVedc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57d2e40-d829-456c-ec81-08dc57a13dc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:55:21.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrQ3FeJVhwR+kNssAiDU0hit+vduA7rzC1THNb22+1WYsgvDQhJGARii8EWqhfqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

Am 07.04.24 um 06:52 schrieb Lang Yu:
> When VM is in evicting state, amdgpu_vm_update_range would return -EBUSY.
> Then restore_process_worker runs into a dead loop.
>
> Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")

Mhm, while it would be good to have this case handled as error it should 
never occur in practice since we should have validated the VM before 
validating the DMA-bufs.

@Felix isn't that something we have taken care of?

Regards,
Christian.


>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..8c71fe07807a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2900,6 +2900,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   
>   	amdgpu_sync_create(&sync_obj);
>   
> +	ret = process_validate_vms(process_info, NULL);
> +	if (ret) {
> +		pr_debug("Validating VMs failed, ret: %d\n", ret);
> +		goto validate_map_fail;
> +	}
> +
>   	/* Validate BOs and map them to GPUVM (update VM page tables). */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
>   			    validate_list) {

