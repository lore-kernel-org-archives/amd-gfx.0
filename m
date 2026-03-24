Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729EBF532ED
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 08:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B94D10E5FF;
	Tue, 24 Mar 2026 08:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A5kRjyt5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD8E10E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 08:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+nPy4hirG2tBr2pSwxMNNTaWkxn//FPFdPQNi/6UxcYM9osEyiFJd645KIzsVLnyf+dSmK+aUzizq4Z6gEsizGB2Z851q6p8nRQGNFySgYsIVPwMHVB0zT2lNXsjU+Onacrj0pcrFOjDgcwVmXmQCem9Hl+zKTskgBw45if3FUbJSf8hZnOY9sQ2TZK21cn/eDuz7bzIvwBy2NgV7CnnM3IhaOv2TaZMDRoRSwlFEdb/DoogRjoHobSU/o0oc4+Vkjfqmjhyi9P6YgB6yF5nqsEwbsFzKQJfZAE9a4RBUfiMDNM2auXd8VtpxZL5AOGSK9uV01StXasIFbsuqj53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cees9R0Yi8nErKSjmM49CTXTeEBljOwHjG4c+xg8dds=;
 b=D9K7yL5UEZZr5RxMmVS6Ll1aUl8tGG1l4Gx8Y3bYX58htpAjhww4OpVyV3pS1qf+Tw1tkZ8/fFSEcRhlI3FAl+XGFlwUaagWq+echYmZjgsWGa5/DnuiugxFHpqFxLRSJqpwhI7yoVxa7Y2gHdMW+Qptq84TglRrBv81TWC21xBuC6dGU38ASmMoUdgSCWvNiHEAq38vRr3Y1CZSyAeWJ+q+ERi0r3QLjd3Mk8icV/hMiXk16KHPgB/TGP0KRn+nJSgPDBAOBqoXDlpkD+7AKY0s4LdTpCTDKBUQvCNi0xkAi0hPB9/Mc/gSaXscnzB7pzMgejZqs5hdRpz3WsJ/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cees9R0Yi8nErKSjmM49CTXTeEBljOwHjG4c+xg8dds=;
 b=A5kRjyt59KLuWkkZkH9D5kFcQATDjw4TIJGW2uv1ucHd8t+wMmkyj0zkI/Z3vhGQzEbY9XWHhOagH048ybVfhXVS+kENrIY6PPrnp+rliQmlIVKEWiEeXum0JMdPX4c3XKporWeF0+fsMcAeWGUL/NYmnyYwldKp5BGgLfeERng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:43:27 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 08:43:27 +0000
Message-ID: <012104f3-ed70-41e8-aaae-5ce1979b9b11@amd.com>
Date: Tue, 24 Mar 2026 14:13:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: flush coredump work before HW teardown
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260324073817.662295-1-Jesse.Zhang@amd.com>
 <20260324073817.662295-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260324073817.662295-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: e42b7640-dd9d-4560-8ba4-08de89816aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: R1AIUkcDivqh/yyRxMFIUPr1TDZDGET1Z+97+SEloqmr/+fHZAia9HgfmXJs8C59yLJHiE5RiFySkMx01s/dZv3SVZHBqY++R6TRTOEOsIQCj4V/Ijt4g2ys6/naJKFjarjSDCEoqd4P9pUnaAxkTDrqOE3xt4A7DPGfAOYaWtfaigpY4K2RNlC18HIgkPeaRMwC/6HZ0eBQ2gBCgnEfyqx/Ky3ake5vXVgEHMpKsLo6zfjfrQJKE52vzyCoprPMQIJ2l4A73s4cIh4FazzNaW6jgCPJvo3BzUXNUlrsmDt0+q1viBF3ZpFL2duSgd+UG90zdC8fDYhvSbuRQkRWo104AeYACS4HtJdjTjlS5mvAE8DrUVeEvFemTNqXWAwws0Z2VlSAbxaWPcPfjurlZprpAwbMAAO5uTOgiV/VRbKeiSBOdVXT1YWOSKVGzVv1kwFZWEOlOswuhoRSN5zFL7tqh/rWH/uMdSLlXUNd02z/0WiSU6KudyzfTTCJmdMtXmmfjfLx+t994k6HhEwfbtQXVvUK0guvi/dHcTSSuK0N48wyuHly2cq4w7pYbkXIopsWdzxjMCGD6OmzD/UJm2S/3T3ONsUlxy7Av8bgIsmFI2uSpejrASUp268drWIKGHOXsZEWc0EMBfyQz10L9EdxIOu3+neQoz8mi2kSOGMLYU6pu8/kpHI0C1iGlKUgjrXTySo5UAMuoIf2Fn8wJoIrBL7tKYoSSlUet599SXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZuNUQ4bGdxNml4SEVhTlBlS05Hb2tWUFdoMWw4VmJSZFY1Zy9mWEVFNlBq?=
 =?utf-8?B?Tmh5VkRzcENvZzNLYlBEQ0NrMUxKQmxudUpaL3U4SVR6Sy81d3VsaDBNcDNi?=
 =?utf-8?B?WUVZUFNqZXNXVC9ic29EYW5zcTFYSVAvdEpMNWhaekFRY3ZIMWNWSjYwQXlT?=
 =?utf-8?B?TXU3aDYrZmwwMmhXZzR0cDZkWGtyUWlxc05UZFM1NmtRMXczaElCOEx3U0hZ?=
 =?utf-8?B?bTFDYVN0UWVickg0bENnUG9PdXVsWWhxUml4VWNvUmRxUVN6STRua1ppcGpv?=
 =?utf-8?B?MUIwandvNys2Q0xmeHdCSkZrdEFRWU5jZ1N6dTc1SmZiRUg1RHNLMkJJREg0?=
 =?utf-8?B?eWdncmE4cURIcXhoK0ZkTU5CelFWTlprTklWdGhQc3F0MlQzLzgwc3o4ZU8z?=
 =?utf-8?B?Ylp4cmFpWGNYZlZBVG94VVd6Tm1jMmRnb0l3MVMyZG5lb1hXdWZWYXBBVms1?=
 =?utf-8?B?MXdBTGs5NG11Z05SMzRBM2F6WHpRNkRCdkN1NGxqUmMzVXpZVUd2NGdwdlZN?=
 =?utf-8?B?YmVjTHNvUVJoMXVCNXdiUWhtUCtEOTg0anlkVENwN01malhKUTZpallkMC9P?=
 =?utf-8?B?L3NoY2h4elMvc05Dd1d6T3VreEUwbVZGOWZFbXlFL1ZmeitOTHJNeGRNL2Ry?=
 =?utf-8?B?OEo0L1BjLzhHVUxXM3kydGVNNm5mK2djZDA1R1A3ZUtvT3djWjZzbjJISmE2?=
 =?utf-8?B?d3FvZS9uZTVDM1kyeWxyVW9YMDNoMDNjTTFLNzlEREhpYlBhSkpXOEVtM3Iv?=
 =?utf-8?B?WFB0c29CTmZCM21lRkJLS3ZSR0plTFB0L0oxR3ZWUXZqVXNkeERCeGo0cGli?=
 =?utf-8?B?bEFzdk9iWTN3QjZuZXZscXVxaldKOGxPQU51d2xldk0wZXN4SFdkQ3pYc0c1?=
 =?utf-8?B?Y2l3aEFTbHlkNGhFVlEvZWxvOUZxNEZhQ01YS3pqVFgzLzd5L1A5UnB3ZXVZ?=
 =?utf-8?B?czk2RkJWeHUySGlyNWdYc2h3cWF3eTh5TElwa0dCRkNNS3dKblNHZGtYazlL?=
 =?utf-8?B?bEVNNU8yZGlidTJGNFpEQjJBaDBsZlI1NGpoN2hTOUpYbG5TR0pXM01DQzQy?=
 =?utf-8?B?VHFVVDdVNFJaMmtmVlNXNmFvaENaR2xnc1BQY2NWMjhGYmZUdjN1SFVlbE5q?=
 =?utf-8?B?RkFoNXlweHVOaEFlUmhHU2syeXFsbTNVYm82bHVzS2Vjb3Rldloza01OUVk3?=
 =?utf-8?B?SGR2QnI1eFBpRWdpc0hnWEdTeVVEaUJmSzlpS1BzN0ZEVjdDZUQ3V1M0QmxW?=
 =?utf-8?B?RmtqbEVWdmREMkdmenBBamxnUFVvWVhMNmVTZ0hJY0kyc045MFZGSHhqeElw?=
 =?utf-8?B?VWc2NlR0R3VKZ3g2WHV5TlFhUWlteXdheVNERi9BZGM5dDQ5VTNwMzVTeWdV?=
 =?utf-8?B?TWFIYkd6b0lIM1d0Y1o3blNZdGJYU09LYlMzdzRnTmNwMFJwM1JHWEU5d29w?=
 =?utf-8?B?UmQyMjEwNHJzbHpUVU1sQUQyYmZHT1hmMU50dUczMVc1Z3cyUC9tRGJ2dXN6?=
 =?utf-8?B?NDZqaStqcjhjUHpBZHE2OUhmRHdicFphcTlMNlJSY0NGY0o1dktvTnorak5v?=
 =?utf-8?B?OXh3MzQ2d3hyc3RKTEU5RjJnaFhweXdnc2xVUldRdWxUVXgvb1ZiNFIxdjZy?=
 =?utf-8?B?enFhZDVyc2RnV0hHSXVFeW9PS2ptSmZsSUtwOGRZRkpYMGhjQ0pMbEJoQXZ1?=
 =?utf-8?B?dUpEMUo1WFVIb0l5VWkxR1drTEFFN1ZCb2EzanNmbjdGdEthelgrNGRXY2Rx?=
 =?utf-8?B?ODQxbWhpL1VnV3k0KzFSK216K2ZMN3ZRMW5aN2ErVVRkUWdsa1I3OXkzMFZQ?=
 =?utf-8?B?VnRaUmtYKytqOXdtQjF0M1pSMGxFLzVGUkhSUXlOTHBXUHlrSzBQdWpPSFRY?=
 =?utf-8?B?TTZNMHV6TzJCQ2x1bTUreGx4VFVWRUhrUEU3a3gxdXptVEVvUVZvLzVHY0Fm?=
 =?utf-8?B?WkxOcTE4OTJQclQ0RFpZOUptR2kzN3Byb3dMR2pkTHNWSERoQUcybWhlZGtq?=
 =?utf-8?B?VUEvMGh2WWE5ZnpmUHV6Yi9PelJTek9PSDBVTmdOSXgzUHVOQk9OSm9FZWhm?=
 =?utf-8?B?WWtaTU9aOEZJekRWQkdGVXZtOHpXVzVxblV6ZE90SVFoZG9pK1prazJNNjMr?=
 =?utf-8?B?UzI1Z3IwYVNnS0YzN0xudTFwUDZXQWlBakh2NlZLazkwUWwzaXZPdDlBVmJr?=
 =?utf-8?B?MnJwcjFnRUtPSXNEekE5bE9abXl3aGlhL0ZrcWZ1djRlRnNPbGdHMG9OMUZv?=
 =?utf-8?B?RWdIcDJnVGJnOXY0ckdwMGxOVTVZYjFuNWE4dWVHWmZPQmZRcmNHTktYRzRX?=
 =?utf-8?B?VDFmcUNFMTdFOHVvYTdLVGhSblVCZHNEUStEUTJRMWlOenNxUEJ5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42b7640-dd9d-4560-8ba4-08de89816aeb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:43:27.4630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoC+hRdetvt6HN5FR67gpkPe9LjqEGJ/wMKzr5mZYCGAcbPmhPml5ceTZei27JcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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



On 24-Mar-26 1:07 PM, Jesse Zhang wrote:
> In amdgpu_device_fini_hw(), deferred coredump formatting work may still
> be pending when hardware and IP components are being torn down. Since
> the work may access device registers and memory that will be freed or
> powered off, it must be completed before proceeding.
> 
> Add a flush_work() call for adev->coredump_work, guarded by
> CONFIG_DEV_COREDUMP, to ensure any pending coredump work finishes
> before the device enters the early IP fini stage.
> 
> This avoids potential use-after-free or accessing hardware resources
> that are no longer available.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

One minor comment below, regardless -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fbe553c38583..2a7c5a233673 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4225,6 +4225,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	if (pci_dev_is_disconnected(adev->pdev))
>   		amdgpu_amdkfd_device_fini_sw(adev);
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +	/* Finish deferred coredump formatting before HW/IP teardown. */
> +	flush_work(&adev->coredump_work);
> +#endif
> +

This may be wrapped inside amdgpu_coredump_fini() corresponding to 
init() and thus it stays within amdgpu_dev_coredump.h/c file.

Thanks,
Lijo
>   	amdgpu_device_ip_fini_early(adev);
>   
>   	amdgpu_irq_fini_hw(adev);

