Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CF3C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 16:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F78610E34F;
	Mon,  6 Nov 2023 16:20:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB8310E34F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 16:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPlpITFOL9hWGkwNRWBbVHPLCOHLeOx1n40iNQCBhoZDzkXvlsaey5kCk+iKolNrHEljoXHYnh6gi0tnML8WJH82qYiFfuNo5U+9MY0keWbDW4bm27w4lHRf3BAj2ILsnmbhP74cUH7ie+TKwk8lQfViFE+1OrOd8hKXgP9l1zIx5zb9nRmt/bd0wfYr0cfMisJ0HIPoiwgNkjaL79floicDHvW+MW+C8cn+7k0bGr6doU46lORs9fgBkTKRa3PPzVz7FJtGvfvxPFtTfTzbTdZHHZCmhS7iiG54GwJjPqQToLzAFBFTJqIUoXA0l+QNC+DfP6nVwm3Ldo4NMu9pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/CIePwuBY/7eWbLmhWTZZ932B3/KoQ4EYcOD+IYhCE=;
 b=dXu1uXN0jo1ZQlfxVznRQCi10b8O6v1D5dJd89AmBoIQYNXCppyXt2++Z6YKtOVtYF4ugdQVO0gvvmiLgxHP4FWrFML2+Whcxy/CicmTZQnmrPmmYxdX66Oo93xKaeZaUXpOyYzhTQviypCyuh/7o2z9SJZzay3wflt+rTfIizAL7oc30Qlyju8KNtKTTPD1BWnPJceBPrQLknIi4cWDVujWL+PPJvdsmQKTophhxeWtncjoi4SUsjhBB2Rcbh+hkZd9OejQtcgm7Cyec3w52L2WgyhIclDlqouRrX+o74hFpyiexYVDSW7aq+rM/Hn9Z5QeGxeP/ZoTNoDMP6Vxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/CIePwuBY/7eWbLmhWTZZ932B3/KoQ4EYcOD+IYhCE=;
 b=ZB2cpUCrQtUcowIwpW6hDr4Eg1Y3Btcs0b/COFGoFtVhsW1oxFe/Z2IM0LlAVuO0sAN2l9BhyQp/D8mhzzahk9+g968ncAuvLKL/OnMRLQah1xx5EYb9+oiT2iHgpF1Ujz+Jxb7vxnKW8xU+7Qv07N/99Z9aNd7dZ5XRdJxkA28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:20:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 16:20:34 +0000
Message-ID: <4a49e3ea-6efb-4f37-8121-e1d7c5302e7b@amd.com>
Date: Mon, 6 Nov 2023 11:20:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Content-Language: en-US
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231106104007.3938395-1-zhenguo.yin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231106104007.3938395-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcafaab-b773-49bf-0f1e-08dbdee44dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGfOJRDprTrOlIzhB9Nu/SmJN4hqhkH/T/WqpsNPwgyO/wUS7JA5P7l+Pi6rLnp9yoLa8l9DZnWsDTjKcRcvw8VLE99AJRvYYkdjSOez6YT0n7v3Vrjf2YRgeq6gU4QwHDSoZx1vbjTvu1xb/zLnzH+Th4MoYs4pQ3vr1iuQKzSrK3yZK1srRgmqMGkzvSpocA9vClxn4qmhBiVVVdG2DbpCi+HFfkmRX3piRkH94p01DIkCMb9FNl6WGkK8/SbDV2QFm8KqLnnQkwaErpsBv97twKNG7Efu0iSZ+x5UD2xQrBqNhLFBCew3aOP/VDJNZ34dGOMSLb82L5fjJ3O/JY5ldZ9KS5HBl9zv160VM3noD5UMNKONJBc/LHJ3NYw4BbpjySa7iGad/QhipBlqk4iUhuM7k0roGTVLwe5mb8/u3+2G+xZGukMrGMyuaPqoRki8BZVcXG1MEUxpuT0r1DBao7e/l4DCik+oVBEmAw6TwbSIVsBovnLS7BEQwa4RH5v3KqS0P/GMIHuf5d3lDXW+KFBU8SApAgul3P/IlY46uNBcmftzxkwq/HJpWBBfFSkoRwbdjHMdTIjc26WFsu85z6lXEvxZ035lfZRxYdzCXEpgLN1kn0PBm72zB5iFeSdXlvUJAfqdjrK6ePrLdsNyJddNVNKPW0gEw0hGEDDuFuF+uqU5jSU7oj4S/AYg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(316002)(38100700002)(53546011)(478600001)(6486002)(6506007)(26005)(66556008)(6512007)(66476007)(66946007)(2616005)(5660300002)(2906002)(8676002)(36756003)(4326008)(44832011)(31696002)(41300700001)(86362001)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFRcmtJZWpaZ1hZK0hWYkxLRXhuNlRQa2JKUlNQVVE5S3lubktUUXREa1Ev?=
 =?utf-8?B?cjgxRnYwWjBmSVN1SGZFeXJYTUFubzhJRnBzYzU4aUx6THJzOHZSMGdCenNN?=
 =?utf-8?B?VzhGT3A0Yi9NQkJ5UnJuQzk0bG92TGhsYUNwdndLVndLYy9rMDBMUkQ5Y003?=
 =?utf-8?B?U2RiSElGVHA2QkVjZDlTYk4yK1NJeWRmZVNTSXJQZnVTbXNEV05wTlc3eS9X?=
 =?utf-8?B?a2pCWjhkVjF6NTN1cWYwY01tQk5VNXhWZEZGanpUeGR2UzRIa3l4TDB1amxE?=
 =?utf-8?B?eExBYWRFQ3RKQ0NBd3diUWdtODBnNktBaEMyQkt5T0VxTmVYSUxMQWt3NCsz?=
 =?utf-8?B?cjE3c2tPSWRGVTZMNmdFZlc0eGd1OFE4RUxTN3FsOVJNV0xVdTZrRTJzcXhS?=
 =?utf-8?B?RWZ5L1lFWGFzdnZwamVqY2NaejdSTXo2V052L1plTWRkWHBKUDlISUVMUnZm?=
 =?utf-8?B?dnREb3lqazJaMWI5SWZPYnhqdzZtRVdlUGJtNDY4YmU0ZGJvd05jSUpSamFr?=
 =?utf-8?B?WlljVDAxTDNrR3JCcWFvdzB0cDJqTFZrU0J1dkp6QXBIRy9YcjZmZVRiNzE0?=
 =?utf-8?B?N2duZlVxYjZpcXhRb0hna1h6MGZ1dkU2bTlWZFp2dTNoU0h0OEZvaHBWaUwy?=
 =?utf-8?B?RmRtUkRza1Vhb0w0cVBHaHoyQUQyelBTdisrWUtKU2xDby9INkZYL2FaYWNz?=
 =?utf-8?B?VGNzODRUU0RmUUdQTUtyQVVDZmRYZXJBSWoxQjViM1hEWThReU8xRXlTVXhk?=
 =?utf-8?B?MUFyTzlDWWg3VjBRaHgyY1hCNUdIUnVTTHVNTTRvR1pNaGdxbkoyQmQybU9M?=
 =?utf-8?B?ZitwRTVlZkFDU2lIalNUQmUrK3hqbkxQQ0ludjJ3c0NKdGxFRXdLL3p4aTFl?=
 =?utf-8?B?QW9wZTVyZFpSTFhxZ2I2Y0pYMnZjb0lNNUNENytVUGo2TFZDRVVsbENSc2cy?=
 =?utf-8?B?L2pKWjRXNWVNeFdaZU01amVxV3lYLy8wNVgyMEwrVWp6SkIzRlk4VWdmT0oz?=
 =?utf-8?B?R3ZWREVrS2Y2WUJqdUp1Q0dFcFJicE1hOElGWHdyR0phY1oyeVJ5cWpaMnBo?=
 =?utf-8?B?clFvWUo2MmQ1NTl3a3hsS2YrNHVmQ2h0bnl2blNRek56QTAzdEZVRXdTcHBT?=
 =?utf-8?B?Z0VQbVh4c0RJb2J3UUppRWJZTDM3d1pReUM5M1pmZmg2Mkw2bE9ac0xJWW1n?=
 =?utf-8?B?YzMzeDgxaUp4cWtWT3Z5T0hCUHMrV3RNSHJBZlByVE1BUXh6VEhybkN2RjVl?=
 =?utf-8?B?U2NqS29rN2Z2ZXN6SDZuTFMyMFFRdDAxajJzTDZrd1dBZkpBM0hnM1RIdHJN?=
 =?utf-8?B?dWk3anZJekkxM21TUVFuVmh3SnFjd1VFaWtmSW1aS1I5ZXI5QjhEbVdaUXho?=
 =?utf-8?B?MG12b0diOGpPbExDMWtUUTdOWG1mdHFlWS9xTCtFMEkxeHpNYm9SUFpsYzB5?=
 =?utf-8?B?dDF1R2RTbEFFZnh2emVOUkJLMjRmWEVCeFlBTHBmNzBDcVRVQjYzNlB5ZWh3?=
 =?utf-8?B?SkFxZDZibXAvUWlVNFE3NHUwdm5ZKzh2NWdubnRtYUpTRjZ0MUpQODRQUXBD?=
 =?utf-8?B?TmZCWXhDd3dWQWRHNGJET1F0WTd0aVNNVldnKzdMN0lBcGxWOU5oalU0am9w?=
 =?utf-8?B?Skx4b0g2Z2xQNC9kODhjMEJxVUg0OHZwaTlaUDlNMTMwbDZKcHRKMzA4L0Yx?=
 =?utf-8?B?TGdrL3ZHMWo2b0d3amV6dWI5QkVUUVd5L0h5RWRkYWFnSDEvQmpCTlQxd2tn?=
 =?utf-8?B?cEZ1WlJxTmtYeWI5Sllzd2pvZ3pzUVlaRlhOWVRrMGhYVzVsdGo5VlBxMmcv?=
 =?utf-8?B?Y3dobmN6TDVpeExKY1dBaThybjJtalJsa0k2eEIzcWVycnFra3NhazBrbk5J?=
 =?utf-8?B?UWg4NVZiZk9oVm4vSHczNUcrTXZ4K0tFZ3JUa3lvOXB2MVY5VWRvU2hZb2M4?=
 =?utf-8?B?WTdxV0xFdS9VKzJKNW1XRlpmbGVVbHM1N3BDKzQzZU10UXFtNkEvRXhmY0hX?=
 =?utf-8?B?NVFXRWtxTTdOTFB5OEx3dXZyUVVhaE40bTVZd3hZL1dSeFZzdU1sNUlpa01p?=
 =?utf-8?B?Mit4NFZwUEZtOTBYMjlHRnpaOStQelBpTHBnSnFDenpEZTR2U3JGMEFNY3o1?=
 =?utf-8?Q?lXpmOTRa1cuGV66YxKXjbF6+S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcafaab-b773-49bf-0f1e-08dbdee44dd9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:20:34.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuW8xA1kJAl9EI1Rnyg0PEBbM2gVmxde+U5AbX76LgdiF+R+BA5xbCK3IiUWrgbU6DSoKvoI/VUJzp0B3S3vPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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
Cc: chong.li@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-06 5:40, ZhenGuo Yin wrote:
> [Why]
> There will be a warning trace when cleaning up the gtt
> drm_mm allocator during unloading driver since gang_ctx_bo
> and wptr_bo do not get freed.

This isn't just a problem with module unloading, but a more general 
memory leak. pqm_uninit runs not during module unload, but during every 
ROCm process termination.


>
> [How]
> Free gang_ctx_bo and wptr_bo in pqm_uninit.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 77649392e233..fdb03b08df72 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -179,6 +179,14 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   		    !pqn->q->device->kfd->shared_resources.enable_mes)
>   			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
>   				pqn->q->gws);
> +
> +		if (pqn->q->device->kfd->shared_resources.enable_mes) {
> +			amdgpu_amdkfd_free_gtt_mem(pqn->q->device->kfd->adev,
> +						   pqn->q->gang_ctx_bo);
> +			if (pqn->q->wptr_bo)
> +				amdgpu_amdkfd_free_gtt_mem(pqn->q->device->kfd->adev, pqn->q->wptr_bo);
> +		}

It looks like we're duplicating more and more code from 
pqm_destroy_queue here. I wonder if we should have a common helper 
function for freeing a queue's resources that could get used in both places.

Regards,
   Felix


> +
>   		kfd_procfs_del_queue(pqn->q);
>   		uninit_queue(pqn->q);
>   		list_del(&pqn->process_queue_list);
