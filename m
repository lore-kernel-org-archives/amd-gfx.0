Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454ECDD1D2
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 19:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58AB10E0D6;
	Fri, 27 Sep 2024 19:48:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0N2qswJH";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA8A10E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 19:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osar0Js+jGr8Ru//kwy6eCmIJGZru4HegdsESQg/y8su7OI8oh6aDwClkcIa1zXj/yGW0LLOhMHfoN9UeAmZfd7D6Ssp0TSXrj4avjqEVeuayWP6AhhM0e0cAspISa8ps1Ymq1nG19pUnCylAhr1dLD6ZkczuXe8KjkP3Qd4S6Hlws9qcXtATuQS7BMER0UuINEu0QdMtghMrsrA+abrNpb4tnobm+FFgPXSnxshZoLXcZ7YUl7wJy4t5lg3h7auPfMA2VTAuhdYxYO0+J/fW9fkHRA58ZBDRM5GVP4ET5RhGIOqm+8WGssiv/kmUDxcfxLeWBNm7mTB1xKe3UKngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR4NHZjSvORM9dKHxMVH9fA/xSFQSdVaG+0qhlLNcmQ=;
 b=HZm6zOm0Tj5sKgz5GCe6y7tDUipA7Knf1O6M+Vywnyx1Y7eiPrHFBVCF8rQIui8r5WfrrdYZnbjlZebpqMrYolktfwhL/D4rxqwucqbHhjlZfzuUAGWweOsNAfZfvTAEDAzIf9MiL/gCKItUEVH2YoH8QONCSw3bxGeFYnp0O0h12QQedkhsLa48Azosy+ZTiPzN5rsI3jcwb3dOBAvqIgOuapSK+9u6jN9YepgV1oX1AvwaIK1xbY1feNXRtQ6iUQNRSw6A4hfj+tNX1YfJrpXfh4PywnzbOaJ/A4+/D/c4UBXlCFAbWgZWXEFF7lciMgZN5Da4I6V24i7nP3OPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR4NHZjSvORM9dKHxMVH9fA/xSFQSdVaG+0qhlLNcmQ=;
 b=0N2qswJHdUGuc6DOBzGLXwiZMaEUsp4RRboJXN8Lx5HEtsTlUBEVI22duKbKBFu38nPL3CUC9XbjCLRNnHR73C6Bqev7d1vTX1aljgWvkmZjz703D25Uwv+wDm6J8LEVhUYyUv7EB8p1nHIXJ329ck7w2krRXvH9Nvzw/Y75uZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 19:48:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 19:48:31 +0000
Message-ID: <17d5ceeb-96e5-424a-a213-2932a57a0dfd@amd.com>
Date: Fri, 27 Sep 2024 15:48:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix an eviction fence leak
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240927103605.136921-1-lang.yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240927103605.136921-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cee6211-0bca-43ca-8946-08dcdf2d5d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJkYlJVZGtBMDRXTGxYOGhQR1VBbjF5SUZ2dFhyajhpSjVJRElBZUNuMWhu?=
 =?utf-8?B?QmEycW10S2ZxMVk0WmhYaDZQTk8vV3R2WHdyTGVhaXdtWXYwZktWOHZqWmdB?=
 =?utf-8?B?cVlVNm1mYXpqbXVSNGJ5eVNiK2ZBNE4yRVRYVFZLVmwwUEZGRUF2UnJVUytX?=
 =?utf-8?B?TmpBZUk0ak9iMWZiWWFpUVBuQ2lFaVg2NmpVbTlteTdLc3didC9IWnA0K2dt?=
 =?utf-8?B?QnFLM2xNMEowYVNXVksvVXMxZTZDOG9RWEhpc0lKZXdmUnMyUDh6UVp6cXVL?=
 =?utf-8?B?M1M5dWZXa2tWV1daTGZLMnZHbWtHc1lkYzJhNytycTd1VUtJZE1WZzhZd2Jp?=
 =?utf-8?B?NE5JTGpvWCtPNThtZm9XVHFGT2h1T2laYUhsUjA5cXZkVnUvQVNKZ1BYNWxT?=
 =?utf-8?B?RVAvLzdWSkhQaUMreFhTTTFySGVPRG1wWEpaNEpnZFFxeDhRMUw1S1NwUSt1?=
 =?utf-8?B?RDl3N2hkQ2dYQUNZLzNFVGMxZGFUNFVTbGFHbkd1bU9YVU1VUGNLc21lbzln?=
 =?utf-8?B?cEFxYWsrY214UkdZR2FSYnBDNWNINUJoVGNIWTM3LzJYNkhFSGQ0M0FISEho?=
 =?utf-8?B?RjVvVGpGck1ZSW9ySUtPTXJJQ3lTai9VeUpsOWdQaUpUWGpvbGxVYllJTndQ?=
 =?utf-8?B?QTdkeEJqRDhNZTBudlhzbkpGdGhWd2paQUNsWUpiZEZzaG0yTjhyQVE4Zmx2?=
 =?utf-8?B?UVlrdHFaY1lhQlBUZTZTU293VTg0dE4zd2ZMZVM3ZGlaOStQSnVDL1FTUnE3?=
 =?utf-8?B?K1ptYXNhNW1LSHY3OUFqUEJSRS9KdWRDU1Z3OXcvQUtkbHV3Z0hpejdZQ1pR?=
 =?utf-8?B?cG11Z05Za3kvMXp0RzA5VytuaFdzazFoekRsdHF3WHNpZ0FUV2pHYzh2Znls?=
 =?utf-8?B?clFDNStsMmY1TWNBRG5HbGQvdXVVaDJsZlZtR2g3WlducmFDV0FsUThDWDJL?=
 =?utf-8?B?cW9HS1dVbjB4VnFkdG4xM29kOGNneU8vRWNvcWM0M3JYWlNMSVFZa0RLUkdt?=
 =?utf-8?B?eHBqY2lJb0J0VUR1aGpSOGpZcjgzOW02NWxuUkFYd2Z4QktLdklZYlRXRXpW?=
 =?utf-8?B?RWxqTCtMMWZKTHJoTUNvV0JLTDJ4ZU1VTFhCQ0JsZEc3ZHZobFJTd2QyYzVn?=
 =?utf-8?B?clpzY1drOVV0dWFmTDNRRktWL21MWjM0bmJXY09ucGhHVmVXNnpady9QaE03?=
 =?utf-8?B?QmdBV0l1OWdPSjMrRW12a3ZpQnIwVTlYMjJwUWp3ZkRydWlIRGtWYkNwQVNU?=
 =?utf-8?B?UTkvU01nK0V1dTlqbXM1SUdYWUcvY3FRaUFUenVPUmp2d1Y5SnNNYy9JRy9t?=
 =?utf-8?B?R1FmRHQ5bFh4TkpEOStUMlhYRlZBdmd4NGl3ajJpbDJDeUFhWXRrNE51YzRT?=
 =?utf-8?B?dmkvbnEyU2txSy9DdUxFOGIwY2M3NWlZcTNkZDlxT0NzV1grYkVkcWlSa0hP?=
 =?utf-8?B?aFBqcks4VXNIR0RzRUM0aW05MnNpVlZCNUUrQVNraTN6dFFXZzFtNUxJZ3Zv?=
 =?utf-8?B?SEpOZ09DNzhTbTQ0bXQ0NEFycjM2Yk15aENlSEIxbXZTc1RHTkswUDEvMHVn?=
 =?utf-8?B?bVFCSUZWOE40TUpYRi8zVjg5RlkwYWhKYkExb3J4NFIyMWZsQ1hjSkl0V2FC?=
 =?utf-8?B?UGdUTHNtdUNiYzc5QmhnMTRiZDRQK2JIK1ZvcVJlbmFGSGZpUEJhZGVxOXA5?=
 =?utf-8?B?MmZlckNsVVp2c0FsekJrUCtEL1JJTHp2bytlclBtV2M2V1NhdUM2S3F5b3hh?=
 =?utf-8?B?RDFydmVVSTdNbHhuWVRKa2pVNTlLdGxMK0FGVnduZVhvRkIxTWhuVEtWcENK?=
 =?utf-8?B?TVlEekxTMDBBVGdrekpzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtzNzQyb1dKTzEraDVnd1V3enBrY1RQK0lNajNZYVFsMVlKUVlHaHFkdXBB?=
 =?utf-8?B?TTdWUGRLZnZMYmhxY28wVitMODN3U2RheFpxOXNYWFpOUCtnd0pmUHRSdmRq?=
 =?utf-8?B?QXNjYnd6cjVqV0hpcyt0QjF1V1RiZ1VTd0NyVzUyYThwOUU4K0E5VEpJMkpt?=
 =?utf-8?B?VnVOTDVOWXd0WTE4YXBlb0tkZ1VldG0rOTBWRnNHeUhzeWJnbU1Way9WOVVG?=
 =?utf-8?B?a0QxOXVYSlkvZXlLTEF6UEdiVEVSelJsWis2cVJjNmE1REg3a05HaUlNWEw5?=
 =?utf-8?B?UFgrbzdhYWN0T0ZLZWVVcmErRnIzdnFaN2tjOEUrd2RpZndTdy8wYXJkcGhL?=
 =?utf-8?B?UjhvTWRINHRWd2FTTjhjVDZuYm1TZGM5SjNOYk9JVlBkb1dzaHNrdUdzMG0z?=
 =?utf-8?B?YjgxZ0grM01vNTJsWWh5OU5rU0x4Qi91NGVRTUNPbTE3Q1MrRXRJRmJSMEhU?=
 =?utf-8?B?N1FsYThRVTBFU2syTVhVdFRwTW9zenZjbEZSVlRxenl2Ym5UZFhERTYvTGNI?=
 =?utf-8?B?Ukp3TjZNTjdrM05STURUcHRGbnF3cXNaZkhvM21nV2krdU5xUUkwcFFyZUZz?=
 =?utf-8?B?dnFMdzdGVXdQSnRYS0RZa083YmF6bWRSYkxhSURPbFBPcVRFM0ZobkMwTyt6?=
 =?utf-8?B?ajBzUlJtT0RWcDEwVStvb3Rmdm92TXFOWnZZOCtkNjB0bGpueERkUlZzMVdl?=
 =?utf-8?B?SmxtY29TNmdISGxYOExCaE95eTZCekFpWDI3cUhTWTlWUFQrYzRTSk9DNEJq?=
 =?utf-8?B?MmhEdUpLd3NKbVo2cEtGaTZPRlRsV1VsSmhMTmZvU24wTnVieHQ3V3lET2VD?=
 =?utf-8?B?Y0E1cnFJQks4NDU0UkRqWVdhMmFtc1RtbVpJSXdTRElUWXl1ckdGOE9teG5u?=
 =?utf-8?B?eFd3KzhOV0xSMDZjZmg3Zk5YMDV5dDdGVC84MXVLK09UbnB2ajRVSHViQ2Fn?=
 =?utf-8?B?WDNEZ1k1R0pvUE1kVlFpUm85SThtRUlxS2pLN1ZsNlJXNWJTaDVURVoyQkhT?=
 =?utf-8?B?TDNaNTFTRW4yV2NDeWw4N1RpZDgxRXg1ZGV4cHg2Sm9UbTJaZ0RBMUpZRXkr?=
 =?utf-8?B?QjZLUEY2K21Pd1dBS29ZUFlBdEZQOU1rY3k4Q1BNbjdTSXNJRUJHeEhnUXEw?=
 =?utf-8?B?UjNXSEVZMW5YZ0o3ZWtQaGUwRDA5S2d6b2VlVWdPNUxaYVZKQzVRM0pwL2M3?=
 =?utf-8?B?VnZxQ0NMc3BDbzVoaVk2bFBPMGpIOS9DSm9haFp4MjdGMFhHNGF2T0hOWHZN?=
 =?utf-8?B?eWNsdXE3NnhVejlZblYweE9iZ2FhZWNiMHJybGpHRXExTHZTQ0tvUFZ3Zmwr?=
 =?utf-8?B?MS8wb0xxOHB3cUhlM21GMkZlUExuSFN2aS91VkV2d1dZNCtsZEFWOElobUJ2?=
 =?utf-8?B?RDJrN1RqOFIyUkw0b2ZrWXRDeHRBbzFtZDRXK01EeUVKcENRMTd0c2tZSUFJ?=
 =?utf-8?B?M25QVEFIYjRBcm9hRURNLzFvTGMxdUNQTjhXUll6eVVYdFRybTlOTWQvekpq?=
 =?utf-8?B?bms0NWpNQTZXSmx5eGhMU0JYS1V5SGxFOWtrdmdsN3M1TnNSSVVtRmhmOFlO?=
 =?utf-8?B?N0VpdWhtcmVwVnB0WHRkb2JWQytBVXZxVmVzYnVGaWM1TFB1c25TZndpMGcw?=
 =?utf-8?B?R2FBVmFJdkM1OGZPbW1iWFl2Q0J0dDErQS9MM3d1cldrcFJQa3pOdUdmbFNT?=
 =?utf-8?B?TjduazREb2pmV2kxOGlRbGN4WHhFVVRXcGp5VmRuS1Nub2I1c1J5TDVrS2J1?=
 =?utf-8?B?RVU4UDd0R3VRREYxbUx2cld4cmNCcDlPNHZNQm1pNU9sZ0ZXa0NJTVgxb2ZN?=
 =?utf-8?B?YWhPc3k5YlFleStxNm14cnQvV0lkbEZlKzkxaC9FQWJCTGlEbkMyTEREWGFt?=
 =?utf-8?B?TkFscGdpWEVETCtzMlBUNktZUVRuL0FtUmRCZkpXWUdlQVZIWjY5Z3FSVmRv?=
 =?utf-8?B?bDJaTVEwSDQwVlk5clA2YkVnaVF0L2I0cER2OStVc1krdjhTM2pYQlRENlpZ?=
 =?utf-8?B?MnBHOTI2RmkyUnhqYi8xTnpjbW9tc2hWb3hUTm1hMG1wd3ZJdUlyMFNjeDk5?=
 =?utf-8?B?NnZ0MFRVd1ZzeWlRNzNIVGRuc0JBL201Y0tuZG1lMCtaVkozcmJFejhRYVZa?=
 =?utf-8?Q?pMnWF0I5PJ4OEUqP7JOnTBZT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cee6211-0bca-43ca-8946-08dcdf2d5d9d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 19:48:31.7915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q79cX3lZ1e5/anHRwd2f8Mq4APQJppT393vYUHXbEmXK+iN/c6FWUvIqr9Xi7D1lmz4wTjthLk8HW9U+46FrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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


On 2024-09-27 06:36, Lang Yu wrote:
> dma_fence_get/put() should be called balanced in
> init_kfd_vm() and amdgpu_amdkfd_gpuvm_destroy_cb().

I don't think that's correct. The reference taken in init_kfd_vm is 
returned to the caller of amdgpu_amdkfd_gpuvm_acquire_process_vm, which 
gets stored in the kfd_process structure. I think it's that caller's 
responsibility to drop their reference. I think the real problem is, 
that we're creating a new reference for each VM, but the kfd_process 
structure is only one per process. So the RCU_INIT_POINTER(p->ef, ef); 
in kfd_process_device_init_vm leaks the previous references.

Since we only need to get the eviction fence reference when creating the 
first VM, I suggest this fix in kfd_process_device_init_vm:

          ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
                                                       &p->kgd_process_info,
-                                                     &ef);
+                                                     p->ef ? NULL : &ef);

And in init_kfd_vm:

          if (ef)
-        *ef = dma_fence_get(&vm->process_info->eviction_fence->base);
+                *ef = dma_fence_get(&vm->process_info->eviction_fence->base);

Regards,
   Felix


>
> Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..c3a4f8d297f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1586,6 +1586,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   
>   	/* Update process info */
>   	mutex_lock(&process_info->lock);
> +	dma_fence_put(&process_info->eviction_fence->base);
>   	process_info->n_vms--;
>   	list_del(&vm->vm_list_node);
>   	mutex_unlock(&process_info->lock);
> @@ -1598,7 +1599,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   		WARN_ON(!list_empty(&process_info->userptr_valid_list));
>   		WARN_ON(!list_empty(&process_info->userptr_inval_list));
>   
> -		dma_fence_put(&process_info->eviction_fence->base);
>   		cancel_delayed_work_sync(&process_info->restore_userptr_work);
>   		put_pid(process_info->pid);
>   		mutex_destroy(&process_info->lock);
