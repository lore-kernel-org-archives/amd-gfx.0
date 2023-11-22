Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3859C61D9B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 19:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8018B10E0CB;
	Wed, 22 Nov 2023 19:12:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2AD10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 19:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nol1FmaVsqN1tfsVEI6dwJNiqSmEE8Mb8b653Da4u7QP+dIwgGuQHoehsCDpkiFNGkNU//fyedh7bs1lHK4SmcbvGJ21DfF02Nmvg2nrhhfF6RaECmRL1RvMrLVXO0olmveIPQsS/OlHO3v0+1rX/G+z/SqewWvSCr5kqsCk+zrUVG4Xo6YurI2EWOtZGp+XrmulZru82X4aKNO5B0iNMr0rjLz0shK3DKRYxV5gjX5lU3ZtrnDwSI7cEGt0ey5S5Y31vcb+3nx90pg99opgB6LHpYiIiVVQYJ0BWOKbDha7rkao20Xq9TthIfds4HUFmmFBuvQl9WGohgSyajgxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPVKt7z0oKSuOs28y3PGdb/rLkQKlwqO2qD5ziwdWa4=;
 b=PQczgTHr4D+pYfer2aCcyzb1kTUr1Mq1OjiBoBUZXGUOvweG7hW0+ER8nEvhhh/f8+lRUtdtT3g46Kgch4e9n8Wvn6fNjxGoeu5erxZsvuzaQHapX6RTRy/rYcPicIdO0SLiV5M3z8ybT/6/1Zcbc43vhlrvbZE00tMwLcqUpuhX/liDwe6guNMQUimOuo6Yw5q6+yZxmgf2k4aPBICEkPshfny9iDeK8trE3uyUfiNPQ/2j2/0c0AyvnUUOTnuwJhgCXQmlbUGu94HzSbZuNuQX+UsCN+eKuJv2KH0/ABZXc5Nu54fESiQuIN4iDB/HbVwatbZDa5e+wbd6XH/hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPVKt7z0oKSuOs28y3PGdb/rLkQKlwqO2qD5ziwdWa4=;
 b=ww0UagHpStwx2pu40FkTejwPWE9rtmqYdzMNfxUlwLDbEOTYKJIsUt9Ax8MpvuDAYJRX+bJAF7I6RMP+nJEKxq5IA6lDnfspqyyO/TnATe/XxCgvl4bw/oe1R9Gt5r3/OWjLxl3f2YDHcWh4hWrSSh4xnPFksJ4/H7uL4WyRAk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 19:12:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 19:12:37 +0000
Message-ID: <b507719a-48f2-45f9-851c-646b34311122@amd.com>
Date: Wed, 22 Nov 2023 14:12:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Content-Language: en-US
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231120071731.4128025-1-zhenguo.yin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231120071731.4128025-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: b03b033a-9849-465f-fc1e-08dbeb8efd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gETSaVdl9HKjnVrBxx44hlhnSdq+U0RxaghhqaRt/DoFKPmpiX3/xHHAaFCnZpOAl6UbD5MJUfZOaxjaQbyUE071zRYx6X5vsWK84X8Z3c5OmoOEhJbW9IBb/Rb2QwrDjXSundkmh8TNACvg8Pza6COUtWdHx+iudidpubQavnl1DDE0FnVKXQNewSKpWQFa7/K1NKwVlZu6alVWOSAPFyLbeaNlENbsImwLLKaBYOltF1y8hTvBHaGhXOtO7cfC2ocGMIA1YQiE5jEkRqKPs5Db/4vNGNuQe9q45qZG8ZeMLBvpmfHCKoexwDi9cif4HUWgv/2Ac19/ZUoW2WmL2cfKKWK+BMWOKwrX5KcfuNZ0IVldEmB7Trchtz9QeHqMZ84haeSSBCiPqC0IOFUZxoAHIVYM2QaaoVeoVv2WkIUmolAk1kA4lZ9tpaTSBh13mm3rQeKUU/PsjICTMz7OCqinuri2oSwJsGQ3JMPMBbjhwhx+dt/NUJjLxEaLffliOYH2nnQXBMLWY8K34Ecpr9xt4pqFT4sWsfo0ULso6O7oGtjtpmjbLGSEnVNCuklvShcI/l76Ceh00HnB73vYLxntjAahTUSOgwiweWD6LmDA0rp821ZOovfFds6xAE1/643WXym/4iCHTRhsDM19Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66476007)(316002)(66556008)(66946007)(26005)(41300700001)(8676002)(36756003)(38100700002)(44832011)(8936002)(4001150100001)(86362001)(2906002)(31696002)(5660300002)(6486002)(83380400001)(6512007)(478600001)(31686004)(53546011)(6506007)(36916002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2kva0ZJY0pvSUl0cHJtSkZhaFFsTHVuVjJiZ0xIdGtpaFM3YmhHa2RHMVVF?=
 =?utf-8?B?bHVIc1RCRmdKQysxTUhSa2xUYmN1MkdwT0U2M3lJTHNQTWdhajJvbmtVSXdy?=
 =?utf-8?B?SWptcW9rbkFqYUEwUkpMTUdhZjVkeTdJOFhxSEhXS0xnd3RSczg2WjBrOFZN?=
 =?utf-8?B?QWEzSk15Ky9pWEVOZ0JqZkxJUFYvYzk1OVB2TDRIbnFnMjZGZXNwZ2szNmFF?=
 =?utf-8?B?R0JXRWh0TWNBVm4wN3BFdlpKcVpnYjIxSDFhN0JsaEhpTGkxMG9VZ2JsVmlZ?=
 =?utf-8?B?Q0J2aVNjQXYySFlBTHJta0R5clVZTXhraWxGeGZmRVNOa0E0aDFXOEtnaVJP?=
 =?utf-8?B?NVNkSkRwL2tZZUhjZ0F6ZG55UEd1cTE3Z2JTcVNtR3FWdldGVjJDK0VvQjZ1?=
 =?utf-8?B?TUt3bmtSU1ZhK3BPS0xsT1ZRRHRpQXNvZ3NyK1l1aVQvYkNTM1BFbTRRWDMw?=
 =?utf-8?B?a2JrenpQM0s5Z2FtTnMxQzBtM1l5WW8xM2VvNWt4RHhZM2Q3RFovbnU5L3Rv?=
 =?utf-8?B?MlFHaWNEZjg4TDUyUjFIS2JuVFF6YkU1RXBJUlRnMHVlUTdFUXE2SENBN1ZI?=
 =?utf-8?B?V094T2hhR1FaM0cxam1rSkVaYUZrVm5pUDBZVkFLV0pxb1c0eCtKa1VSMEVK?=
 =?utf-8?B?dG03RGNsdlkxV25FSnZvRlFMSWljUTdwWU8yQzhiSnI4V3BIRlp6YzFQdlNS?=
 =?utf-8?B?c1J4MFVha253OXVBN0pBS0RZQmJSNWtTZUtFcm1nN2F6b0UxM1dUdWhMVm5X?=
 =?utf-8?B?R08vUXVkeC9vY095N25aOCtqZ1huRFBtTXlPbHNoSHB0WmxNdDA1YWZMVFRF?=
 =?utf-8?B?Q0pHU05lTy9YTkNKQS9sa3dPamlGZnBWS2RSdkdmbU42TW1Ed1NzODcxMUlt?=
 =?utf-8?B?VlhLOVpHVENWMWFQUEUzM1J3K1RiTlJnd2hQSElBL05WNi8zU0VhV1hDVFNC?=
 =?utf-8?B?Z09qOXpXbFpYOU5kenN5dXhDajU5RVlWSHFJR3dDOWlVZW83cy9veGNDdjYx?=
 =?utf-8?B?cjVHVXg1UDFhdG5qTVJTTXBOZUJnWVhQSlBHSFc3YWlJU2tMeE5wUk9WcmZx?=
 =?utf-8?B?SkpsMXpSdzlxNlFUTU1nclFZMGJmYlRqUmlIMmw4VDRiTjhuTEc2V0FSRjUy?=
 =?utf-8?B?a293ZG9iYkduKzBPb3RjZXFuYTRtSElHMUtKV3RNQUJKUGxiZVVTamVucHFa?=
 =?utf-8?B?KzRlVS9ZQVRjT3Vic1MrZk1GTDFydHloM3F2QWhncWJPdkdZc2VOYklveXZk?=
 =?utf-8?B?akhrdTJaRkdHdEVoSTlYaWFVWGZlaVVacWFTaGFXSmxzcWl4aXhiazJzNXdE?=
 =?utf-8?B?R0N0eUh4YzR6R0tDdFVYSkxNdDB4MlBMRDMwRmREeE9MaEsvWDYwcWhvNkow?=
 =?utf-8?B?aGo1YVZHNzQ5ZTVBRTI1THVqVVJDZ1Q3dG90REh4KzI5Rk1hdzhQRE5ZaGpj?=
 =?utf-8?B?aDBoTStYVjBvSVdXZG5FR2JUR0FrdkFGOFlBZjBKTGo3R3hPdU9CSkRkK1h0?=
 =?utf-8?B?TUs1OEhCeUVMM0M5djFsK3pHM09ydW9lUmZCYXJsdXdJS0xmVi9oQmRxQm5j?=
 =?utf-8?B?T29abzlPM1NLUHNYZjgxYzVUS0RoMFlaeFpueUpwVTNxbXM0ZElnTURCS2tt?=
 =?utf-8?B?Y3ovUW1BcWlHc1QyclRaUldoNy9aYlBPT3FHaER5dzg5TEdLblk0bHVrMkhC?=
 =?utf-8?B?VmNzQzBKNDdWaEVBS0x0RCtBU291QkJselRadGlQOGRMVWx4UkRFbzZkbkw5?=
 =?utf-8?B?UERJUGpXM2RQLzZBWmt5L3FFcU0zU3ExV0U5UnFOK0czZkkrdFlTMTFzZjg4?=
 =?utf-8?B?SVBPakc2QlNVV0RhWGcwSWlsVzFrUXNOUEdlSGcvZEV6LzFNbm4wUG1teC8r?=
 =?utf-8?B?dVgrbGNlOWRQaHZ3RWhWckFQVHRoU0ZiSUVVNUIrMThVaG53OHE3TG0yVjM2?=
 =?utf-8?B?Q2FsYkxWK0xsUnVDMWJHMDlLOXM2VW9tVGFhSStyUE9UWVN4aGJBRSs0ZE4x?=
 =?utf-8?B?QjFrVjB2N2ZjaUp6QXYyY3RncncxZnZtQmpObGI0d0EzeXFGYWJCd0Z5NkJE?=
 =?utf-8?B?TXJCUXB2R1oxbnZVSm9xc1JBT1VLWWVCYXlxOTR1OEJ4eVVmM2VaT0E1NHhR?=
 =?utf-8?Q?UFhUInQe7SNORhPUkQ7obytgv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b033a-9849-465f-fc1e-08dbeb8efd7c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:12:37.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYs/P4OMS8iNX49MSJNsAde3N+CBM9q+s8bfNpelXXfIx8akzEPWinbyudFk1ZDZXywY2M9Zkj9uuLr3YreHmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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


On 2023-11-20 02:17, ZhenGuo Yin wrote:
> [Why]
> Memory leaks of gang_ctx_bo and wptr_bo.
>
> [How]
> Free gang_ctx_bo and wptr_bo in pqm_uninit.
>
> v2: add a common function pqm_clean_queue_resource to
> free queue's resources.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 46 ++++++++++---------
>   1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 77649392e233..b027485fbe66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -169,16 +169,34 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
>   	return 0;
>   }
>   
> +static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
> +				     struct process_queue_node *pqn)
> +{
> +	struct kfd_node *dev;
> +
> +	dev = pqn->q->device;
> +	if (pqn->q->gws) {
> +		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +		    !dev->kfd->shared_resources.enable_mes)
> +			amdgpu_amdkfd_remove_gws_from_process(
> +				pqm->process->kgd_process_info, pqn->q->gws);

I think it would make sense to also set pdd->qpd.num_gws = 0 here.


> +	}
> +
> +	if (dev->kfd->shared_resources.enable_mes) {
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
> +		if (pqn->q->wptr_bo)
> +			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +	}
> +}
> +
>   void pqm_uninit(struct process_queue_manager *pqm)
>   {
>   	struct process_queue_node *pqn, *next;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q && pqn->q->gws &&
> -		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> -		    !pqn->q->device->kfd->shared_resources.enable_mes)
> -			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
> -				pqn->q->gws);
> +		if (pqn->q)
> +			pqm_clean_queue_resource(pqm, pqn);
> +
>   		kfd_procfs_del_queue(pqn->q);
>   		uninit_queue(pqn->q);
>   		list_del(&pqn->process_queue_list);
> @@ -461,22 +479,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   				goto err_destroy_queue;
>   		}
>   
> -		if (pqn->q->gws) {
> -			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> -			    !dev->kfd->shared_resources.enable_mes)
> -				amdgpu_amdkfd_remove_gws_from_process(
> -						pqm->process->kgd_process_info,
> -						pqn->q->gws);
> -			pdd->qpd.num_gws = 0;
> -		}
> -
> -		if (dev->kfd->shared_resources.enable_mes) {
> -			amdgpu_amdkfd_free_gtt_mem(dev->adev,
> -						   pqn->q->gang_ctx_bo);
> -			if (pqn->q->wptr_bo)
> -				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> -
> -		}
> +		pqm_clean_queue_resource(pqm, pqn);
> +		pdd->qpd.num_gws = 0;

This is incorrect. We should only set pdd->qpd.num_gws = 0 if we are 
destroying the GWS queue. That's why it's better to do this above, so 
you don't need to duplicate these conditions.

Regards,
   Felix


>   		uninit_queue(pqn->q);
>   	}
>   
