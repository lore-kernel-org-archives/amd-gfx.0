Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EC606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t3BUAZHC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEF01123D1;
	Thu, 19 Nov 2026 13:24:22 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B571123E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDlebqC7+3XrUOpoZ4PT9AisILmIhk3mUZB88wfe5VA368KtF/3qo2L32f50THNiw3z+eVCoUeBeBMvaxQlllUSoRREgo06IsGCui91r3mnkD31lTn4WUNnEHtGGkv4aFJH2dX16tgqWjrX3vDGpWKBUch8a+rKgg0Aui957jLQVw5f9BTd5AqbDuL6I8P0tK5TcVix3w1qdntpZWoeDKukW7ra0a10axvrULCMaEHjQGFzhzPpou8HpbrXC+2Pmo6kN92LnbcADcB50WSqO70Gb4Yhkn6bqQix6GzhGtgayJ7UCceksqXSh1PWYcciDA1Nr/+qb9QQW9zZXnuHC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ6SaqWUZmNUCWobw5V54vhdhu8hdn1PTfiphKWBymI=;
 b=ggddbOw4VZq6cXArYhrngcYVWLHx9AKxdQFiY2hP+naPT3cVLG/YLEBZ4UOeL4PmmSMbPhaSOeVGyVO4OxhBgiDq209ADmqv37I6mGq3+mjTgQsZFFxnEcc2wtAUj0/aJ9o78ypEmw3y+44SjGo3am4OTTVoaEmvJGHIu+cgLHF4yQ9CJYBkArGrJCduQeK+4k8ck7qnamLXSznNccNFaGNdPjNLoLFT8punO5xdjT7C8BTu4DhhikzDmQMw3/PxR6kP4UQNom86P2gJiTji9Amedye5XWGy3dN2Yh3/77N1z+iNfuqxIrB+Vb3/Zg1qf5wGKr+Mk5OOxd8G/Cd0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ6SaqWUZmNUCWobw5V54vhdhu8hdn1PTfiphKWBymI=;
 b=t3BUAZHCLCgaSTAqDvfYSPu8VXLOeB/Eb597Z533iLuyAczE2bln7lSmEgxKXhXZhbQ8538RiMz3rKy9gVuKFjNxEeT+fvIsfzY6v9DYj/OkqGZQ49RLFQcCR8EjWGtZA3/pMqo+DORlmZes6kVhs4WBxGMLuHLJI8rgqD56MoQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.10; Thu, 19 Nov 2026 13:24:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:24:13 +0000
Message-ID: <b4cea1aa-9709-4ca3-8c86-c3b74ec1d4a3@amd.com>
Date: Thu, 19 Nov 2026 14:24:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for
 handle_fault
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-4-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb698a0-113d-417d-d0c2-08df4640672c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|56012099006|261022105027099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NRjZPnpY65vhvTuCvgPJWsSVsaUahuWUkPWWdjgY0CvUxmveb10PWbJAaMV6FfbXA6Zgr2OCVrjmatSstq4sdKwamrQs6Av1FHokErY2Fz764KlrYAn/qRnrAQDZjU6Ojzdgdieo3vNOlExHrA1ydlCvWrharoKzspY3GQtMG3eTIy7WQ1N4BW5GENy3PXs2NBzK3uPJ28c8VfTBz8FUqPNuUwzBKD3h81RK8s68tdT6Gq6uCjMdaDA4h6OBePBBtDtBlu2sje6IHbnPv411LQNR23rihxgbrHCkb+ryCo3tXqJtQvUvcwuerGTxiK8cuCeokr2NUF9Gwob6bCd2kH4Yi9qlMuQmuCnYPpvs9DfDglmRB0ZXCgO0LwO8CUpZcNIDv0EU5nNvdHtk6ZH2arRHRigopWlX2WMSyBPpWe6206Z7c/55dw7YGJmzX9MP+ye2Lbq1DF3T1ydLN0pFQ+ss0DMziY97Nl8/2wwUb1fJve53H/ITZYq9+bIiG232jmJ+NTGrr3/CB9pCW7yBc6Z2N2Qd+tHIAQ0IGUPGJ1Gknnu1uejYRmS4iWjw1eww/GcuTgP6YOkCuPYhFeAJRqZooun0iXmzefcHDszTCmcES+J01owH8kopj0rDuOFtO3vO5evH4rX6pr441tdv0p1yuDjiGstSLqnX+HO0rhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmc5Nkk3SGJyWFk3VUdyOEhjWU5uN09HbEhRSG82NjNFZGN0djFvWElBK29H?=
 =?utf-8?B?VnRxQVFOeDhQU3Z4eTVaazRoZnNHRklmTEhnUFdIM2syN3FZZ2xtMnRuVnI3?=
 =?utf-8?B?L0dXODI5b2trZnFKNGg3bk1OZGxUejBuZzBaNENSeFVjaG05SzBnU25lYXhF?=
 =?utf-8?B?aVREQS9FK0p0Z0hkS29rMnoxdnpXWFdjbUxiUW00SjUzT3J5bTh1WldzcEVz?=
 =?utf-8?B?dEJxSk9xdEZMOUNjTER2ZE5CeC8yZHYreVdpaGJrb1BaRnl5VVhJUHd4WFJm?=
 =?utf-8?B?RUVzbFpZNXFIc1Z3N2hoT25ncXVWQUZkUDBPNkJ5SkhRN2FKM0xsRlB6Vzk3?=
 =?utf-8?B?T3RwaC95dkhrWWJ0NnY3Y2k1NlNCdndUTHF4STVScS9KVWp4ME5kUHJTcDJU?=
 =?utf-8?B?Q1BPUHQrKzJVclIxQzBteHd0Y1JWMzgyYkZ2dU5XNEFZWk5xNVAzL2djaitY?=
 =?utf-8?B?R0JQd1dMbk9JYlRCdjJWc2xwdXI5Rnl4bG1zVk9Kem5seGRYa1ZqY0NuU2Jl?=
 =?utf-8?B?bTZVeUR6anM3OTl5c1RZdTNLTTh1aTAyL2Z3b3lFZGRPQWVKNkxqczhpUzdU?=
 =?utf-8?B?N1VNcThiZktReGJKWUpZdVdiN0NIZG9TVEVaN296S2tVc1Z2Vk1KdjdMVmJK?=
 =?utf-8?B?bTd2Rk1Ub1V0ckxoR2FBT1ZyTUE4QjIzLzRwbWhvVk5RV3dXblFLS1NCV2dz?=
 =?utf-8?B?VldZMUFZWHlXbUpOTXR3SWVPQnVrRTc2b1VGNERVNjN2UStRTkdvVExjSVky?=
 =?utf-8?B?bERlbC96WWRUcEpQN0ltYlhXTTExOWlFdUNGcG5jWUNLcVczS0E3ZUZxN0dS?=
 =?utf-8?B?ZHMwdmRiRDVIaHdSeDFWYW8zVDBaVnpremNiSXZyWDdVWTE4a1dzK2NMUEhD?=
 =?utf-8?B?T2NmOEppMlJHdENXQ2llUi9hODU2SGpHZndtbEQveGlhenl2S1EyMEljNVFS?=
 =?utf-8?B?TUgrRXJETnBUT21rQmdNUnNPZUdxUkw5OVRBTEpuZWxveFJ2S09BcVdLRG5S?=
 =?utf-8?B?MEpZUmNza3FaMHVyYWgrenVFU3NmYlBIU0ZtSG1FMTA2cHpjSzRlS2tWOVY0?=
 =?utf-8?B?Q3UzaWVmQm9XeThRaDZtUjRLbnBsUGppdUJjZGh6Rk5sSnlaNyt6YTFYYTN6?=
 =?utf-8?B?cHRUYWlQZjNoUGZuR0FIZU9QL1ZuUU1YT0RuVmFhb2d6VERZVXYxVTlONDVa?=
 =?utf-8?B?TTVwWktsOFdiUmk1YW9pYy9hVlhmWFZQVFpFOUV5d1l1ZnZFeHFNY25VS3Jm?=
 =?utf-8?B?SlRIbThvcWlIYmlpc1ZqQjF4MS9lQ25XOUFZeWszWUNzZmRCN04zUGYrd1Qx?=
 =?utf-8?B?UExXV3JPN2dVK25GR1dBN1NPZkF6NUdBckt4aW5XSWVlOE5PMGRPbkhKQUNo?=
 =?utf-8?B?VXkrb0M5YUE2VGJBMWU3bFpSWDBkL3FNdUJuaDVsUzFPWXc1TjFIUUdnTDR3?=
 =?utf-8?B?V3BzcG1IbExzUmhGMmJiR0FkVllGajFYYWZIRkIvbkdMdHVudWgzcDZZYWd5?=
 =?utf-8?B?V1F0b0YyZkg3V2Ixcm13UThSbEdhQjNGWW5wU1pMRmtQbUtoaDBKUGkyUE5l?=
 =?utf-8?B?bHUxMkYxa0V0SWI0blBqRjVRSytOS3dNOGhiazZQTWllSHEySkVqNFBrQmln?=
 =?utf-8?B?YnlhL1M1MUJpQnByOUJ1UXAyZkdxYVVVbHVKUVlJdnpORG1KRlV6cDNNeG50?=
 =?utf-8?B?OW51SVdCRjdFenlwRWd4TEFMUTR4L0l1MVlqSUR5TUZFZmdVZmlrQnJPMCtU?=
 =?utf-8?B?c1EvL1gwUWszeCtqQ0FWYnRHR2pQN2o1Q3dpMlhaaC9hRHU1cEJ1ZFRyWDE3?=
 =?utf-8?B?K3Uranp5SHk2MWkxQnNSYjhWRytnYjMyY3d4Z3BBZGo3djJ2R1FsYUFHYWVy?=
 =?utf-8?B?L2IyQnZTejRta0lDTFFUYWdjMnFpNForMGpzMmhvVkwrVmVQbmM1ZU1YSVM5?=
 =?utf-8?B?VUU1TktvbkVFNU4wa1dXS1RmbHhoaWwveDBwczdSSHZ6NEJ5RnlTRW1QWTN1?=
 =?utf-8?B?czRDd0pBYmM5RTNHdjdlWnJmeVg4S1FDQWVGcm9iWng4cFFzN3E5eEliWDJ0?=
 =?utf-8?B?Vnp4WGNZYWo2ZHRMSG5nM2JjMnBxaDREVUdjUzk2RkN6d3ArVjg4MVZsWjlm?=
 =?utf-8?B?Tko2VnlZUVV1SjJ1U1Y3RmVvcUZqY1llSDlrL280OGVtbDZmVkJXQjluQm1o?=
 =?utf-8?B?Ync1cEdyQ2tySDRZVmp4QjFHcEV0dXM3MXpMNXNyL3lNWW02b1lBSGF2L2dQ?=
 =?utf-8?B?dGx1cFFkT1hBQVpyZUhxdTZvZG9wTkl2VlNpUDV4VGkzREdOUjArM0lrS3Zk?=
 =?utf-8?Q?u4T0bh4AeGVAQAjVmB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb698a0-113d-417d-d0c2-08df4640672c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:24:13.6327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRnCsvEQVw+JBkcXcK/oukriP6ZUkaQZbysNNzzTbtHvTuLRNPaTeAirXZgvfkes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

On 11/18/26 19:52, Benjamin Cheng wrote:
> Reserving 1 hasn't been enough here for a while (last_unlocked was never
> considered originally).

Again completely unnecessary. The fault handling can't use a TLB fence.

Regards,
Christian.

> 
> Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
> Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6d8d639e5986..f4a836594e7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3186,7 +3186,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  		value = 0;
>  	}
>  
> -	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
> +	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, AMDGPU_VM_UPDATE_FENCES);
>  	if (r) {
>  		pr_debug("failed %d to reserve fence slot\n", r);
>  		goto error_unlock;

