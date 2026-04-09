Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC935EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D7F10E7E9;
	Thu,  9 Apr 2026 12:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x5XFdA6+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEE510E7E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlltHMZfDSUnkWSmX/+JgzylC4ogSf0rKFi3POXjdz5l+AjeiLLSCvkxDnvNBC0ZkRJlr/q06IKkI+IOwxcTdQZLoQvsCBmpufFiEoG9h1brd/3L93G8wBAKMwIsCvifRc4tTcst4Jiorhoq9NbW6ph+ZF0yzckh7U/lIzF0kZG9/Ulp96qUlrd+aKuDP0HeK03COil9pKSRkwSAET9wJs7ef74laXvKEbE4yY2O7XOmJagfpE5Tk/9gyENZjyAJgLkJz10oMV8p6c1Ea253hVeysR2zzV/KZNtBcF+O63h91VvMRppR02/ZUNpcMw2NbYIM6W+Hq5kqbXdpls+YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxyLQMJZb3HAkRkFR/ENvVxv/3/5DgOQw4jRvJIwstg=;
 b=DaB7Rm0WtFdpqgvqR7idvORJSA8uh/bcnH/MgYqaysJ7yK6U9hAEiPCpw9xZLjwqKB2kZxojj1HFW/GUwXgAtNefMaHcrFrJUGnJFlMurXB3W+mOuTCT0LBji+9zbyAplUE4Gbj9uRihhJHktQBMkGTyiG1zKzK2FW/zpb89B9EEoDMW5cu5OGit7w+NbXcfotmW3D3vR+FYlUxNPT+CXYnVCiCHbguKzwAPWwTyOneec9SQg/3iUvPZWbMYmqAGrAO7AcSJFkvK79J1VB5O0kCMIG4dYlS41yAzDQA5k3bOpausM44sT7HysQjlK8W7P8v3tMv2xUXSiFESTtbmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxyLQMJZb3HAkRkFR/ENvVxv/3/5DgOQw4jRvJIwstg=;
 b=x5XFdA6+neFg88nf540eij6wjtrv/IaZe0VZC+fktampbnl8slt8HfA12BUJA5205wb4Vt42uosA5xGZ7zRAmUiXS+nuvM+NarD+oJKzj4Fw2dCQktRoTWXlQWT2txQWdhXmovBevWFwyRKOX16AN7C3E7n7vm4FsxdiZMA7V+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:43:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 12:43:39 +0000
Message-ID: <605e49ac-8543-44da-9e34-b8d5f7d98052@amd.com>
Date: Thu, 9 Apr 2026 18:13:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] drm/amdgpu/userq: hold reservation lock in caller
 of amdgpu_userq_input_va_validate
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-5-sunil.khatri@amd.com>
 <cd688c50-ca2d-4a24-923f-fa280bdd7c3f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <cd688c50-ca2d-4a24-923f-fa280bdd7c3f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 46de4724-965c-4232-f52c-08de9635a004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: vZCrZtrVrurGP9qFN4mq8jSGlk1735asSpEfVUkKMnzejkAtRh1Fq23hEiyP1SBtWlr2rRQjRlpprRMYaJ2uOFo4AF2KTXazI9rlBJCmcSrFBcx2fkF5MXIrZGEGYz9zg843WIXFilof2PFh3GdrcM+YOodeijcBX5Ftd8hn5HmlpFTiC73rxoiH47iVXlnG1tx6h7ySZ8rQh+Ct6grEN4+atuWr2wnpwqo5nNDy5gfKNaVrsrndVLxrHieZ+k3gOHWZKQQKwBN6QK+vDjQku+ftOGQWTEHI/ESuq4OPMdceZ1f8EuQlUVtxZQ4qYienjCLWK5tS+i18KYj3aGzJB1O4LFQ5Fc9pSpBIHi5TVYVzwHDGUW7JzEOge/d38bWYEZ2u/ZCzp0RFfTYckVp+dLJ23HmCU/cAuYu9f4OJthF3sMZGaizC/fMhDRz0v8qTG8UjbS0SJ/99W6qXu4URsE9Scroy/NGr0RQxNgHnLR67aKmToq1OPzQKUeqV5kOxG3kvsG3myCDqV0OMQbzFomlYqF/hkubOySfXVutWysHdgL9WGSphNJK/U/Q/3a/lEQIfIZiDXcc54yIuFdoZwaJh019aRbzAiP//QQzQDOIqq3JTNopu5xCXGZH8WaJkCrRUPikA7JOXNoCzNFRNC1zXF/ozU2uVRKgnW/E+1uG06mNbWumuUSMFhaW8XaA0XYoGrCYHeB3q3X02yzKLOk0rwxZeaC5//WRL53MS6l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVwS2dia0h2ODZhS3p0RndJbzFSd3BwQUU5eXZGTXF1ZGI4SkdrbHNCZE1J?=
 =?utf-8?B?UDFXbFdZTEt6Q3BlMTFhZlRjSkp2RlZSYzBDeHpSL2g5d016ak51RnBlKzRa?=
 =?utf-8?B?VkdvaE5FdDR3dE96aGdmZjlZdXFDWFZkME5VNE15RjNmTE9hcktXNExrcUVI?=
 =?utf-8?B?MzJrWFZ2RnF0Y0RuUkNIQ29DSUVaaXhjdzM2TWR4MVpFeE14ODFKaGhQVG9X?=
 =?utf-8?B?d0xHSUNFZk13TEkvNXdqWDNjaXJNaHZlbHRwQm9HYXowWDVjd2M1YmVMV0ow?=
 =?utf-8?B?TjZFSGpaY3dtRGhkcVBZK3FoejJRcXZsQkFudVNnMHh6M2hiT0lCaWJiRmxG?=
 =?utf-8?B?RkRrNTRNTVN5VVhhbzl2cXl0NHUra3VodDJ5YlhJMk1vbzROZ1FBYjhSOG9t?=
 =?utf-8?B?cE1NQ2hyeGNxd2ZFOEd4YU91U3dJanI4bVBPVENKMFlmQlBVSXg5eUQvSm9r?=
 =?utf-8?B?MjB4MWdZVldnMWluNXFwK0JGcHNDNERFY1FLdlFUdkZMRC9EZEZMWi82dTQ3?=
 =?utf-8?B?OWRkb3o4QjlFZXJWRWd1NWxvck5SNUdwOVdadUQzckJRYkJkS3BzbFlNeUZ5?=
 =?utf-8?B?d0V5YlUweU43N2dkdTJQVXAvb2U3elhLQ2pMd0F0NzEvVEY1NUp4azI5NmJH?=
 =?utf-8?B?ZjA2Q3ovdldiSlE5MHEvSnN3UXN0clMvdWRnY3dvZGV4Wm9QdzBMYkZrMzZC?=
 =?utf-8?B?dlgwMnlrZHF1NURpV3BPOUZhc3hEdk55UDhCYUVlZkxyNWhGaE05U1JhZjBi?=
 =?utf-8?B?TUJnMWtTZ3h0dTFtU21xaHN4YXBVZkpSZ1FPUHRwaVdGR3V3cWRnSjR4Q2Fh?=
 =?utf-8?B?cW5wOFNGdThEN21TemNLZDR1aEhPbFRrRjQ1ZTExQ3JSQkZ4QWZYZGs4TU92?=
 =?utf-8?B?ZDZ5ajlGQW52UkJ4NW1GV2UvYk4wc1p6YlFJcCsyWkFMQ3J0T0lYeCsxNEI1?=
 =?utf-8?B?SDE3bG9sMlQyaURTeDNTdVZydEcwSGF4d2RtUXBtV0ZncjJLTWk0a3ZVbER1?=
 =?utf-8?B?VDB4elFNVUFneVBGZDU0VE5JMUpFVW1yODNiM09HQk5IUkkzMStKMUZBeVhj?=
 =?utf-8?B?eWlHZHhWUXhaSzRZMjhVbUd0OXoxUkJ0UFZkYkhreEtkSlFPSnpVOS9vUWpR?=
 =?utf-8?B?ajVhMjFzc0Q2bFZWR0xCWmFJVHpNalN4WFhiVEhmdXlJRmtCR2RLVk5TR2Nn?=
 =?utf-8?B?bWJ3Q2lvbHFYckR1bW9NV0djS0x5TlNzVGRLbVZrTnFqSjdXVHMxMzQybC9U?=
 =?utf-8?B?d1FOWTk4ekNuTXdmRmpuWFB5RkFWNWJoRUN2YlpzQU9lTVFwZDQvK0lhWVkv?=
 =?utf-8?B?RHRLZnZESTM4N1h3cGdPSDNSMGhlYUpYcUdHZk1WZ0NQVjNVSyt2TTBseGor?=
 =?utf-8?B?MnZTWlplSC9YQ1l6dnJhQ2xIKysxVEsxQTdPR1YrMjhWaWIxcEY1RVB5TGJr?=
 =?utf-8?B?ZU9YQjFFRTJyZk5jb1kybGZJcTJBOXQ3c0thQWhjYUNHZDJsVjh6cFdQT0RZ?=
 =?utf-8?B?VzkxbFVoczdHWnJ0aW0waGRyZHBleW1WRjRWUHg0NWZtNHhFQXgyejlxeW9L?=
 =?utf-8?B?QklEeUVzcHFKakhQT1NxYm0zUGwzUDdHSmJaRFllMCt2RUZYOEE5cExtMVdS?=
 =?utf-8?B?OFpPT2F1R2xXOHcxdHF0Um9xS1NCREFhbjAxakFZUWQrZmI1dkFEa3RuN24r?=
 =?utf-8?B?NEtwVW53S3ZIK1VXd2pZaCtiRjdkcDFzM3Y0VC9jWlJuZEh3V21od1pSd0U2?=
 =?utf-8?B?VlZTWVQrY1pwY29oVGtSdFBuOXhJTnVTbmN0MWhsc3VGVUVOVFVsUVZ0NUE0?=
 =?utf-8?B?SWQ5VCtRandrNFRHMGo2MzlnTHN1VkorWitQaW5oTWVXOXpPZVFOTy9CM2Rh?=
 =?utf-8?B?K2RvZGNSZ0hCd2dSaHdlR213a0JUTVRwSG9uSUlWY2VCSDMxOWIrdFovMmg4?=
 =?utf-8?B?L29QcUJzaTNFcVRzQWplSEZBaE85Smx1ZitLcnh5QVV2d3VlKzIrQnB1Uk1I?=
 =?utf-8?B?cE92U2p2ZXNIODdNTGNBblU1WHZ3ejhPamgxbFU3eUUrcnRBek44WG9laUwv?=
 =?utf-8?B?K1c2QmIxYWhQdXFKRGh0Z2taTGM4KzVWRGFkcVFBVUVJTXRmRFNyUTZKMk5X?=
 =?utf-8?B?dHRHSVN1c3M4Q3hCSE5TSnZ1dnBsZ1RUaHY3Rmh6TnlIaFhGU3dHOGF3Rlk3?=
 =?utf-8?B?eXJYUit5cWxQNHEzNlRES2F3MXJIOUNzM2NsSlVQSGJkRGMxSkFZNEdhRFFx?=
 =?utf-8?B?MXQ5d2JmckltTDlWYnhtSzJ4L2N0SDRUYzZjQ2lOaXBhMnZCQTR1L1JWUndR?=
 =?utf-8?B?UmVjOG5RZHd2OHVGOC84VlY3azZ2U2JLU21DeU9KTHoraytDN0VwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46de4724-965c-4232-f52c-08de9635a004
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:43:39.8271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+Yoa0OguIodMN1EVXc+FLPm4bqjVzjp5HUydNlhqGr1cfDPhDFl9xDU9FtBWgHx47Vc9vejzhJQj+t+ThUpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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


On 09-04-2026 05:32 pm, Christian König wrote:
> On 4/9/26 10:33, Sunil Khatri wrote:
>> Caller should hold the reservation lock for root.bo in func
>> amdgpu_userq_input_va_validate.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 18 ++++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 23 ++++++++++++++++++++++
>>   2 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 1b81ce49d408..333bd84e7619 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -239,13 +239,12 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>   	u64 size;
>>   	int r = 0;
>>   
>> +	/* Caller must hold vm->root.bo reservation */
>> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>> +
>>   	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>>   	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>>   
>> -	r = amdgpu_bo_reserve(vm->root.bo, false);
>> -	if (r)
>> -		return r;
>> -
>>   	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>>   	if (!va_map) {
>>   		r = -EINVAL;
>> @@ -255,13 +254,11 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>   	if (user_addr >= va_map->start  &&
>>   	    va_map->last - user_addr + 1 >= size) {
>>   		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
>> -		amdgpu_bo_unreserve(vm->root.bo);
>>   		return 0;
>>   	}
>>   
>>   	r = -EINVAL;
>>   out_err:
>> -	amdgpu_bo_unreserve(vm->root.bo);
>>   	return r;
>>   }
>>   
>> @@ -773,13 +770,20 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	db_info.doorbell_offset = args->in.doorbell_offset;
>>   
>>   	queue->userq_mgr = uq_mgr;
>> +
>>   	/* Validate the userq virtual address.*/
>> +	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>> +	if (r)
>> +		goto free_queue;
>> +
>>   	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>>   		r = -EINVAL;
>> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>   		goto clean_mapping;
>>   	}
>> +	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>   
>>   	/* Convert relative doorbell offset into absolute doorbell index */
>>   	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>> @@ -864,7 +868,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>   		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>   	}
>> -
>> +free_queue:
>>   	kfree(queue);
>>   	return r;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 527cf2f14691..f7e00169c0be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -322,12 +322,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			goto free_mqd;
>>   		}
>>   
>> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>> +		if (r) {
>> +			kfree(compute_mqd);
>> +			goto free_mqd;
>> +		}
>>   		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
>>   						   2048);
>>   		if (r) {
>> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			kfree(compute_mqd);
>>   			goto free_mqd;
>>   		}
>> +		amdgpu_bo_unreserve(queue->vm->root.bo);
> That can be done before the "if (r)", so that we don't need it inside the if any more.
Sure Noted.
>
>>   
>>   		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>>   		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>> @@ -365,18 +372,27 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   		userq_props->tmz_queue =
>>   			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>>   
>> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> Acquiring and releasing the VM lock multiple times is a really bad idea, but cleaning that up can come later.
>
> Apart from the nit pick above the patch looks good to me.

Sure Noted. Let me send the v2 of all the patches.

regards
Sunil khatri

>
> Regards,
> Christian.
>
>> +		if (r) {
>> +			kfree(mqd_gfx_v11);
>> +			goto free_mqd;
>> +		}
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
>>   						   shadow_info.shadow_size);
>>   		if (r) {
>> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			kfree(mqd_gfx_v11);
>>   			goto free_mqd;
>>   		}
>> +
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
>>   						   shadow_info.csa_size);
>>   		if (r) {
>> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			kfree(mqd_gfx_v11);
>>   			goto free_mqd;
>>   		}
>> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>>   
>>   		kfree(mqd_gfx_v11);
>>   	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>> @@ -394,12 +410,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			r = -ENOMEM;
>>   			goto free_mqd;
>>   		}
>> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>> +		if (r) {
>> +			kfree(mqd_sdma_v11);
>> +			goto free_mqd;
>> +		}
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
>>   						   32);
>>   		if (r) {
>> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			kfree(mqd_sdma_v11);
>>   			goto free_mqd;
>>   		}
>> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>>   
>>   		userq_props->csa_addr = mqd_sdma_v11->csa_va;
>>   		kfree(mqd_sdma_v11);
