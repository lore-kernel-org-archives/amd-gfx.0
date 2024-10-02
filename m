Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6FACF31B9
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 20:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E32A10E78A;
	Wed,  2 Oct 2024 20:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ufUpkTm1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3D610E78A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 20:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJIRduHU1rZVT5dJ3E9uhwIPtazGfpPjKAW9AfZP2iULEqckNuigQ4CYyV0dENSsjffarr93wQ2votuJ8Fh7VnUWVk8FSk59fc/DmHSF0s2VIvMsz0G33caJ5it15bBlnuGTpJAqJpEJIiXmgDe4Hxo144i2recmgC5CEVUKzg7JxCMU6nwBr/gP/7ZL2dcso1wXfIJpQJ55Wta1Wp624u5zHDX44n0PuOKoe0AhSWTbD1AnJuSvUKLz3I/CV9i4W4jA4r+13SgN/4c47Xyxe3DsvT2lynU2TMKv0ra3rR0JV3DlFxsm+3/F8ViuBTL7GSoP9Ld1I4jrnT2usyniFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PorEkNXzAcTIEjTEIpp4G/HNOolR6H0hwTLxtZYsnS4=;
 b=Fr4pWkwGctYokKDw4Xgr+TWUoHWM7mAaxEyCzY+BA/+0/K+CNJpYuXm9oE2AzER0bIdAGafmb6piWlPDv180ehwzImCoOZ0re1n0qOTyqDNr7Klr1QMNgelEkhQTsov6W+j7tPUpfP8sQ7jOJYJkx3LuLs0Pro+sQSOb9CGBvTt+a6IUI/7scLGcVCerV/mZbsYCQ7F2ApvSquh5Ma3MABwoIjvNGE3qqkgZBVJn2YwsRiBsn+UJTejpetHasVVe5FWbYXrUd/cCV9fpg/2lX6o4r8Uadsgain4mR8Nt4sIJKZwOryGUMlHFC1pVmawhof3YtkOkrbMZlaPxPbSD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PorEkNXzAcTIEjTEIpp4G/HNOolR6H0hwTLxtZYsnS4=;
 b=ufUpkTm1OExuuQYd85z23YWLhY//fRcoSU3tGHssXIvPaVxCuNPrO4C7qx3l+d7x9B9kt1rQTwb8U+vKmft7+WIKc0DqC/RQMJJqSEcgd9sm5D/JX8R6lcAVlaPELBYD4UlREKzR+oQQbr5etkEKLAvz0oU5dMPkKuHrxCt3I5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 20:22:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:22:42 +0000
Message-ID: <b990a173-ca65-4860-81ee-66838f58c03e@amd.com>
Date: Wed, 2 Oct 2024 16:22:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240930063512.22516-1-lang.yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240930063512.22516-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0450.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 210da142-3dd4-4ec1-8001-08dce31ff7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUZMRmY4Mlk5MUIvQmR3UWVPZHFlWFQvcEcxRUVRV3B2VE92ZEVXSU8yUm84?=
 =?utf-8?B?R1Z0VWFTQkdrdll3UFN6SFBnajhCV2pabUpab3p4ZDMyR1lDV0VwVDFxeTRT?=
 =?utf-8?B?U1hTak11djdHVHk4aytkcGpZa3BmRkVpbk92QUNSa3RqaVlvMjVTaUZpcVlt?=
 =?utf-8?B?aWN1MEdXQzI0YVpyZGhBWFFseGN6dXRoY0JuOXEwN2FXQ2JSYkxUbU5aSFE5?=
 =?utf-8?B?Mk9FWDZya2N5M2VEK0hGSERSdGRCNytiamxwSUFBbG0xL2lHUTJZUjRDRzFl?=
 =?utf-8?B?eDVIbG5aNktzbU5xdzJBaTFPRTk5RkU0aHJ3NXV4VmZzZlcwdTVpL2ZqSGZM?=
 =?utf-8?B?NDlFeGR3ckw4aW5wVitUUEFXdXhqNk11VUd4N3JVblFqUi9JU0pqSWJjbkxn?=
 =?utf-8?B?ZS8xL1ZuVnVNMFhlbHFZY2cwQUFYSzhjNXBwbjdLZDUzSDNLY3l1Q3IyV0RN?=
 =?utf-8?B?Si9SWFFxVWZGb29Mekt6bHhKaUYvc3l3QUdaTzl1T1RFN0JESW9xNTRoOURK?=
 =?utf-8?B?U2JXWDE5R0ROT0pkci9LcVIvRCt0SEkwY1lOdE1VQk80WUY1eFZIeHlMdEtq?=
 =?utf-8?B?VHBJOFBFZUVQc1NrVGRsMXRHNGRrNHp3UjRRVEZSalI4dUgxS3QySzVvSCtJ?=
 =?utf-8?B?blhwc3Z3ckxncVdMZnFxZm9Scjk5SDRSTkE0djc5d3NZa1dVVG9vaXVXUWZJ?=
 =?utf-8?B?cHVzOXhrUXAvR2NEMWs4eFJjQkhSK1BPODlhR2Y2VGk2aUdwMmpFaTJKL1pV?=
 =?utf-8?B?M1dhckpMTVQwNGsyOGltcmVIdmRES2tuMzVIMlRBSUQvRGJKK2EwcnF6R3Z0?=
 =?utf-8?B?bXU4UnpEZG9vNHJyRmpUVEg1bkh2Q2I0SlEraVhVK3p2aDV6RnRQZEV6cEZF?=
 =?utf-8?B?WHJxTlpvQVNzeEt5MTI3L0Vhcm01K0d4aTJDUy9GaVV3VU1kdFhlbkZVZ1lh?=
 =?utf-8?B?NmdQOTRJckVNdEhYdkRZcHRHNldyYStrRDJ4NU9qV2RJU1ZFVHdqYWowL1N1?=
 =?utf-8?B?NzNsRWUyTTllRm12V09VSTd1SkRIbng0eWtRdTl3WnI3OE5scy9rWWs1ejRq?=
 =?utf-8?B?M1Vxa2FBS2N1S3BidE9PdVhxWUZrbVdTVm9ZSTBobU85NkZKU05WS0NjOTdi?=
 =?utf-8?B?aEVpaHdLMmMrWFJXNXZEOTQwTThSWTVpOFUwWHFMc0ROYUZoSUJRYmV1WlVL?=
 =?utf-8?B?RTI2ajNMN0U1cTZsamtybnBRcGZjMERUTG1sMWhIYUNxK3RnWWNqMWs1cFIw?=
 =?utf-8?B?MUQ0YlVqaWNpeER1YlVnTmJSTFVQNlN4SlVGbnFwaVVDRkRHOWE5TnlBb1Q2?=
 =?utf-8?B?U0VHOTlJZGhtdHJmcXpaTk5LUHJxWEI2Qnd1RHdTemxhbVBJTGdTUFo0MElH?=
 =?utf-8?B?ZFJ3R0hOZ3pZQ1RwOTZzWHFncmRVRm1VUmZTNHpOU0E2NmpTK1RuMloxdGk1?=
 =?utf-8?B?TXlSdlE4am5xZmVUbEhwdjdURHhDa3d5MHdTVTBnaUhlYXd1ZWNPZ3AwN2dE?=
 =?utf-8?B?a0VqU1RhWmx4bTVYNURjMG1sZUdFbmtTbUJmYzBRQTJFeGxoRFA4QXJOQ05Z?=
 =?utf-8?B?NlVacUNYaVh5TVV5cWpHTVRmbnVKR1F3ZVBsQXZuYyszRlNTZmFTNHBJZHor?=
 =?utf-8?B?U3BRN0tkUUdFeWgwWWJ5eUI5U1VLLzV2bFV4R1h4cVpMQW10NllGdC9wRDVL?=
 =?utf-8?B?a1NZYlJmK0hlVFhGVGNnb2djdzhWRENtUlpTcWtkd0ZySjV5Q3V3NWJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVHR0RSaXJRSEIzUzhQb3lBYWtRdHlscjdnNVcwVmY2Qm9NVEFrU0RuejBv?=
 =?utf-8?B?Q29zemMyWnh1UGd4c0l4TlJpVWovcUp1OW5iS0pDb2dNZ0pLL2V5aEFla2F6?=
 =?utf-8?B?MHZFeUVvdzcxdVpvb1J5MnlmWVhucWdzaGdFclJSeUZ3c1A2SmUwOU16cC9P?=
 =?utf-8?B?TmNNVDlxWmVyaU9MdEhRTVhzL09Ga0xOMXRlb2pKVWhqenlvMFcyOW5FeHZ4?=
 =?utf-8?B?WmdyaXVCblJTMmEwZ2ZtejJUQ1BZbU04R0ZTVW5TM3NZRVFxZ0JLaDR6L1lz?=
 =?utf-8?B?aFZSWnpiV0NPTHM2RVk4L2lVeDZnMnNpd1diRHpFMFl3WS9na0xKTDNTUEJQ?=
 =?utf-8?B?SkFiSGs5ckdyQlVBT05vU0FpZThRZEJRVUZFaUFhRC9UNS9YbktCbmFtMTJK?=
 =?utf-8?B?cnd4SGlsOHJpbnZmeE1jb0Y2c0NLeVhFTWNKMVlvUkVmVWdhYlR2TGpYdTNM?=
 =?utf-8?B?V0xaTzF5bDBVZmFZWFBnNG83UWhKSGkxaENvRHRoK0pKNGFnTGphd0dob3Jy?=
 =?utf-8?B?dDdYOWpzR2Nwbmd3YmIzbzJpcDFMZEppREh6cXlaK2djQVFBZmxnSEVJbTBD?=
 =?utf-8?B?NHZCZzRyelVCTE1NUHNBbkxlcW1wMm1uazdsSFdtWUEwWnk4aXhQYTh6QUxI?=
 =?utf-8?B?Z1FwMmIxUVhzVFBKTnNOOThmWGlPTG9PYzFzOVV5NEpjN0haQ1VreEFNY1pk?=
 =?utf-8?B?SG40TFVDajIwUTRyclBjSzU5d050TXpIcWVRc3JYN0J2bzBkdVdpRmN2QmJJ?=
 =?utf-8?B?d002UnFNRHpjOHVYak9QWFZKcFczaWJFQlowSVdQUGZzeFpSa2s1aUVCQkZ4?=
 =?utf-8?B?WUxYeVlxU1QrOWJQaW5hVVhsbEV6bU1ycmRtNCtsL3JpRnFJV09BT1I3aU9n?=
 =?utf-8?B?RDl3cFRHVVVJUWd3dXNvY2o0bHFKNlQ0azhSOWNyVFAwOHNWWWIxM2dGRWQr?=
 =?utf-8?B?S29KcDgyZzhUdUhvcXZQeG14OVBzMnpQak1KSUd5UmVmcjVWRFlLMFN1OWYw?=
 =?utf-8?B?K2NTdzkyZm4yMHloRDVBQlVoQUFJcFBwVitLWEJSUVJRN054ZWJyV0QvUWd3?=
 =?utf-8?B?N3Jka3ViNFZOalY5MkttaUM4TXhFSm5iM2p6aHZhTUcxZVZqVWU4aDRtMFg5?=
 =?utf-8?B?UTRucmE0K3kvK3hSc2NwbnAydW1HbFhreDFybzUyWDZqKzFjbUFkZjJEUE11?=
 =?utf-8?B?bkN3QWc1bzYrUEZrRzErbWxBLytVV2U3RDllWjExeDFaV0NibFhrb2lFd05k?=
 =?utf-8?B?SkliTVl5UkJ6dVZadXluMEM4QlFrTmpDd2xRS0xjQ1VINFowVUNhSlR2U0Rx?=
 =?utf-8?B?enp2S29lYmFabUlVTjZ2Y0xnUHJKbTdNSVJlRHg3aFRVdURhczhPMVJPZ01B?=
 =?utf-8?B?UzhlSEgrVDgwbE1ZdmVFTFhPM3BtZ0J4NGE5OGxMd0JaK3VzYTExQXFTQ1Q4?=
 =?utf-8?B?TUFhNzFRYWJvRFhzQ0JwblB0OUJhN3ZKSTJxbG9KSmN4cWljSWw2bmcvSEov?=
 =?utf-8?B?ZmJycHVhS0tMOFZkb3VEQVZ4bEZoUEEwdXBKQ1JGT0xrOWVnWXlJbGM1RDlY?=
 =?utf-8?B?SXhSTU5VWDdqc2puc0c5QVBNWUZhZzJwUEk0clQ4VXczTXhpY1ZCUmRRMGR1?=
 =?utf-8?B?WE1COHNGZ0ZLbkVvS2hkSnRLb3FnTTFibHd3RkxlaFFaRWJnSUtva3VwOTVU?=
 =?utf-8?B?NEdNNHdFa2svNmliMndiSGU2RDBsYmJRaDR6WWlLMzU3dndkN3g5T0RHcmJp?=
 =?utf-8?B?MHZCamdMQ2pXZ2E1aFNEb2o0SFJ4VmFkZkFtd0RHTVNkQzJLdnJtdVR5Sm1l?=
 =?utf-8?B?cit0SXFpeFFUSDdpTHRzUlVVcnJxNjZiNG5INlFHYnNJbnBHYVo1Yjl4OTBv?=
 =?utf-8?B?UzdDSHlVemd0aWxFc1B0eU4zUFlsblY2U2lWaTRORzdaTVlMWW5LZzZHMUo4?=
 =?utf-8?B?S1hsSkpISHA3VjYwTjFKc3hXVXVsNEtIMVRsWUNmeU9PbkxYbWZFS0UyMWg2?=
 =?utf-8?B?VGZMZHp5U3Zjem13cDdGbHQycVp1MTBndFJPanl0ZzhObWNYS0pSd0s5SjBy?=
 =?utf-8?B?b3ppa1M1U1ozb3RyamdGUTRWSjZmdE9aOGl4YXI0MzJ0VUZzQlNtN2twcTZx?=
 =?utf-8?Q?uSvmPMNWtvehSgxWsb+yZlVh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210da142-3dd4-4ec1-8001-08dce31ff7db
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:22:42.3059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqJcqGtvVh6uzoSMng2+SrELVSxb0q97jq98yekW+azo+x3CRhiw8NFo9sRwPk2QtkZoLfx//uiorYfaeYiuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On 2024-09-30 02:35, Lang Yu wrote:
> Only creating a new reference for each process instead of each VM.
>
> Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..fa572ba7f9fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1439,8 +1439,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	list_add_tail(&vm->vm_list_node,
>   			&(vm->process_info->vm_list_head));
>   	vm->process_info->n_vms++;
> -
> -	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
> +	if (ef)
> +		*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
>   	mutex_unlock(&vm->process_info->lock);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..d665ecdcd12f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1702,12 +1702,15 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   
>   	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>   						     &p->kgd_process_info,
> -						     &ef);
> +						     p->ef ? NULL : &ef);
>   	if (ret) {
>   		dev_err(dev->adev->dev, "Failed to create process VM object\n");
>   		return ret;
>   	}
> -	RCU_INIT_POINTER(p->ef, ef);
> +
> +	if (!p->ef)
> +		RCU_INIT_POINTER(p->ef, ef);
> +
>   	pdd->drm_priv = drm_file->private_data;
>   
>   	ret = kfd_process_device_reserve_ib_mem(pdd);
