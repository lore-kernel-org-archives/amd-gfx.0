Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CE2EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 18:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3006C10E673;
	Fri, 16 Jun 2023 18:16:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CDE10E673
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 18:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESR1L7rtXHJF4JzyhH6xzW2YN7imd+5UAbQXOXTGXbic6Q+PQLu68WF1dekmQlU20lAqzt180GC2OlmLDeZI33i4egbrtq0ISyJxpNUA4jLLVcwrlhdefSpE7l608FhKdBnfvwnls+q9c5Y9Ck8lE8zU1/dBE8anzxbQC2YdzaRIPyL+/FTSK1K3PZvBlMvMYL7HW/X43QTd4mYo1dCaGfOdZTA/ZgVVi7tpKS1sK72vSV1OkIk54+oi4smZqfkDTUA01RsOeCdJCmLjNztG8L+HdwefhUfAYqVxDponV6A8KtdnVVx/TcxgeLxx0EjhiXH7LPftVbeUHTl07mrGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz5O+WRIMZ97Cqav8bp/cESK1Bu2dcdZzoJN91C1+UA=;
 b=mSZevMSjF39UPcq9SXEA+pxGLheK1frcM57f4s/6IXWkK2zrK9OFGB9CYBrWKxM8DS6YxDdheKpCB/LDpowSS+IC2w0ZP1HVv9/chDEPl3zVwCSKDD4zDsrj/BBt5KLq3nZ/n4hcdngwAclo5jTBgiGwKAyZXMjGLmLbBpWE6ftDJJ9yKPOdbe7PEUG8zA7elstE4W12aKCgtFynHutx+tM5FKlsqrcjUWqnopT0VLMhxCbODbb6vzENepyz6zOrOmo904v8qQgmOt2e0ITT5zdmukNk/AAYJLz4acaCw1mLXLuCiy672SdJxtD7ao1GRvKU5dOTcjaeRpoqGfGt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz5O+WRIMZ97Cqav8bp/cESK1Bu2dcdZzoJN91C1+UA=;
 b=MRVNw3vdmmt26b67d/Aip1TkYRzcSKomxKu4j8FPh0/GBXqD1Wwq9+5TfMF6EUzMocP7dMgsuXsBGBZ9hzyZOaosvMEZoZRlTxAJlVfIcZBX4XpWen+I+FEpCRBh1n7hUtVLulRdiT3vgepC7ZEHyrOJRAQ4co3+v88OWahyApk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 18:16:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:16:01 +0000
Message-ID: <16b97dda-527e-ef18-c189-d8a7f98267d1@amd.com>
Date: Fri, 16 Jun 2023 14:15:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Enable GWS on GFX9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230616175929.1269698-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230616175929.1269698-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7af1e4-0c7c-4969-6ea4-08db6e95bd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aCGl55e1jzmVp+ShfNsMklaMN/3NuZvldKu0ZfieR+V7shd9VrZCn+RmW/sHWltUc9YSaVU55QBz6rx98QEWVIQfbtD5RNffrd1/7t20jDCJBcvVkt1Dt3gjRTxcXVCSNw2WuYVYKbhfyOOZ6V3jJOTJ9a2dhiyCgKIY4no8isnp4XYRKWj+OdmoeVF6tV6RMp2u6uOGM+5O3rVJA4pXV2VT3QyaYBkrpwrevtx2+mPF4MVaUZ/bbDrnNjs3nuliQwyIG8WXhKyiH9XT7Br7TJhXuVqxtDduVLUT0M8kYAEt6+GWk3Z5dKBcRFdo76S4iBbw+KySAJYpo6uxd68sOTa4JiRqWTN3mRSgos2gxFh1hXtizdN5ZOmP8e99FNg2loaKc3VAFN8I5N805qe8PprqGUWRB5g56eVZLAGL8yb0E6vlEG38SkOSel7/9V2qyK4I2a3kbCnZe2GiwViYtw0GB2dVgUQdW1YyKIPCvzVg+uKYJsCB6P4JkyBy51pbMWaEWs06Y7/vHOLSPaiOfdJeRybAJAqXGEGkbVY6EkKRq37VFegdHwnpEejzIVuP0Y4T0a+Z4c8f5S3t6TGVbmt+3fRNNnHotyMvWQk2jLzvvtEtIolYqTuWVT7NjyI0E7MrkRL2TegLK2ZznFbcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(26005)(6506007)(6666004)(186003)(478600001)(6512007)(53546011)(44832011)(31696002)(86362001)(36916002)(6486002)(31686004)(66476007)(66946007)(66556008)(316002)(2906002)(8676002)(83380400001)(8936002)(5660300002)(41300700001)(36756003)(2616005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFwY0l1WTZSTm5PQWZGL1E3QmZvSGpxQ0czTGFhUytlcllKeEZXMUF0ZnZw?=
 =?utf-8?B?eEI1OXNuMmVYMkQ2K0ZWemRGZUhaRGpqRUFOVGxjT20rM09vN3hSUDFrYlZL?=
 =?utf-8?B?QiszNStZWi9MbVpxQXo2Wmw2ZkdnVDUvUThTZkJicTU4OFArZzIzSHFZUEta?=
 =?utf-8?B?Z2VEaVVOb1JVbExrQnEzZlpwL1dGRmxNSmlMTWRBTGhocEM1WEVUSUpsZlph?=
 =?utf-8?B?RkFqYTRMUDFGZ2orVmxVVEVlQ2tRd2VkTFMzTVFveU14WTlBS1lDQWlsdHhV?=
 =?utf-8?B?ZmZNOWxHRTcwR2IwZnVTaWt5Qkc5d3pSY2xIUnNYYzBwWGhHYytZTmY3aHpM?=
 =?utf-8?B?aVR2THhYYUJKaEM2TmFScnNCVXRGbmE5cXk0cDR0M1B1YnJ1Zit4RjMzbFVi?=
 =?utf-8?B?bjlzdFN2bGtKbVltSEtZbWRwSGJMbWpDQVZIVTdjZnNxYTNKVll1YUgxTExT?=
 =?utf-8?B?THlpTlkxQUFNdnRTNnBHWDA0V1BValprV21aSlU2d3hMVEFteDg4WUVyUUEz?=
 =?utf-8?B?ZFBndlNLOGJLZTBRc3BPUFY1cXVQRkpjMmZwdUZzcG9QN2lXWEEyTG41MTN4?=
 =?utf-8?B?SW9wT2k1Q1ZnbHIxaTdGWkZYQXNCdUlnREVrL21naEZTWVB3SGMrR3BBMHFX?=
 =?utf-8?B?N01BVkFsTGg5UGV2RWN6YURhSXhxc3IzRGhvWFRJZWFIZWpHTWZyM0JpUGF0?=
 =?utf-8?B?cE9NcGJyZVgyOUtlS2pyRUhJWXJXbEg2VzJtZ0pZNlpUd1c0ODFzK2FoMUV4?=
 =?utf-8?B?dzdxbHl1K09ISERJdG5XQSttYzB6MlUyTnVzUmp5d3F0dy9LNEZFYnpLVVJG?=
 =?utf-8?B?QTd2VnZka0hlSVhva2txR1M4dU92aklWYXNBVGFqTktTVytHRHNpcm9XMy9P?=
 =?utf-8?B?K1p1OVkvOURMU2lJT2t1eDRhZEl5Q0xnUWwwWXNHMHhxWFJqNVBYQW5aaW0v?=
 =?utf-8?B?SmdsK2F1SjMxeE5sOTgxY3hEdnh5ZG1ZZDdSRjV1NVFmTUZ6aE5BNmd2UGk5?=
 =?utf-8?B?RkprZ3BuZVY5SWNpMEpGUjdmUi9wNEk4OWdJUHBmM0Yyd0hhamwvMjRHS0l2?=
 =?utf-8?B?NDFrWEU1MVhjN1d0eDAyOVhqTTc0SDNweGMySnRmNTZ6NVBETzVEZFhWYkxM?=
 =?utf-8?B?NU1FaFhNMlNkRGNXdExLOC9xRzdQNXFYVkR6THFxc1Ziakk2UUozS21TZG1v?=
 =?utf-8?B?cStucHN6YlhQN0RmRE1SOUI5a3FUZ0VLaUdOYis1TXNmZHdackJrM2RDNzE4?=
 =?utf-8?B?YmZPamlNdmQzVlZSQzQ2dkhFZUN4MWIzcThJOGV3aXFTcDk0M2EyV1I4aHJJ?=
 =?utf-8?B?VmxUNG9lOXNrVmEydDVOdDlkc2p0Rktxa0s3R0RCMXJENk9IazZpbXc5ek1K?=
 =?utf-8?B?eWJ2czRIYVI0SnJ6dmY4bHVWaHZFV3MyL0Z3cFI4TTk3M0ZLZkd4Vm1TSktw?=
 =?utf-8?B?VFhweVh5WHh4REQ0Qkp2NWtHU3p6R2dKQURWUXRLWEZZL1BrU0tHRXpSb3Mv?=
 =?utf-8?B?V3Jnem1UNFNZMDJzbTRNcVdKRFNDbjJ5Sk1Mb0VKLzRLZzR4NklweTN1U3pa?=
 =?utf-8?B?T3pudG11VFJxUDVkMDFITTBQdEEvMjU2ZmttWlhmVDFCeXhQVXlVSGIvTVFZ?=
 =?utf-8?B?alg5ZFM5Q0dSalFoRW53b0dKYzFzY0RTOXBrYitTMmlxTkhyTXZKQXZTZFY0?=
 =?utf-8?B?VWtBTmhHUS9SdS9JQWpiRGdNUlBENGxzTTBoRFAvbHBtNnZOMTJYQUE1Q3Jn?=
 =?utf-8?B?T0hUWUs4NzNpU2JIY3lDSER0aFNqZVQvYktlbHkvSllQOEk3d1QyQ0tScFJv?=
 =?utf-8?B?QXBQaUpUZUhUN0VXOTZyYTJOMGJ6ekVIV3AzcDY2emtoS3lDK3dQa0wxWFRz?=
 =?utf-8?B?SVVRRWVTVE1aRVJrblcwSFJMSSszZXloTGVDUlBBcGlXL01vMFV3RjdvNGc5?=
 =?utf-8?B?cmRnU0NML2RseEJoV0xoVGJFd2x4Nk81L3ZrbWErNUFyQjNlK2tRd0JYSGZz?=
 =?utf-8?B?anF3U09JQzNBK1dtRjFxMWJqeXptb1B6QnA5aWIwWWdhN3hxOEUvbmpMSDhJ?=
 =?utf-8?B?MVBWWWNsUjVUUGZTY3hudnMvUkZ3SUUxTXprUitUZHVTVkEwYTRUZmVMSHZ0?=
 =?utf-8?Q?5KfGCCjtz+0wiCCVN66SiNbNs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7af1e4-0c7c-4969-6ea4-08db6e95bd83
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:16:01.3047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsmYaB1ujQHsloPFDh+5jcr6d8XYqjw0gITi0o1KXajV9fS3kL4yJ/1IzNhtrYGi2i/H7qZ9OY7lAMtbgXgeYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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


On 2023-06-16 13:59, Mukul Joshi wrote:
> Enable GWS capable queue creation for forward
> progress gaurantee on GFX 9.4.3.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 31 ++++++++++++-------
>   2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9d4abfd8b55e..226d2dd7fa49 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -518,6 +518,7 @@ static int kfd_gws_init(struct kfd_node *node)
>   			&& kfd->mec2_fw_version >= 0x30)   ||
>   		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 2)
>   			&& kfd->mec2_fw_version >= 0x28) ||
> +		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
>   		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
>   			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
>   			&& kfd->mec2_fw_version >= 0x6b))))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9ad1a2186a24..9a091d8f9aaf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -123,16 +123,20 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	if (!gws && pdd->qpd.num_gws == 0)
>   		return -EINVAL;
>   
> -	if (gws)
> -		ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
> -			gws, &mem);
> -	else
> -		ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
> -			pqn->q->gws);
> -	if (unlikely(ret))
> -		return ret;
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
> +		if (gws)
> +			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
> +				gws, &mem);
> +		else
> +			ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
> +				pqn->q->gws);
> +		if (unlikely(ret))
> +			return ret;
> +		pqn->q->gws = mem;
> +	} else {
> +		pqn->q->gws = ERR_PTR(-ENOMEM);

I think this needs to be

	pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;

Regards,
   Felix


> +	}
>   
> -	pqn->q->gws = mem;
>   	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> @@ -164,7 +168,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   	struct process_queue_node *pqn, *next;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q && pqn->q->gws)
> +		if (pqn->q && pqn->q->gws &&
> +		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
>   			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
>   				pqn->q->gws);
>   		kfd_procfs_del_queue(pqn->q);
> @@ -446,8 +451,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		}
>   
>   		if (pqn->q->gws) {
> -			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
> -				pqn->q->gws);
> +			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +				amdgpu_amdkfd_remove_gws_from_process(
> +						pqm->process->kgd_process_info,
> +						pqn->q->gws);
>   			pdd->qpd.num_gws = 0;
>   		}
>   
