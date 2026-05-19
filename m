Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8348ACD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F6010E2A2;
	Tue, 19 May 2026 14:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7DRkpSI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AB710E2A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8Tc3Ah0lAKUejFVfdUczSuCrSTvTsD2Y4k8mPqQLlpBwYNIfJ3t6mcBrad7F2YpfCCLZ6Olw79IkVQQyAwFlOslv9UXKW1nm/dUSBFGD0Ge5M3RzGSXfhBnJcE4lHKyQc4I+2Sn0KU5x5pFX4VZlMjntzRxOnvNTGLoS3AAL5EKsEI+Ef7iIIpS0XAckq2W2xgryUh42q6HoVMRdhx/DflqUdnP95R/N7deJaQCPFt4wCUaNT9BVwIaKPoHpYaEfhu6F8MNHfRJZDT9r9xE20o647vuJwwqN76ims4jU1H3saGXzJ/+0YUAbrCN4EEjBWY+eAOjT63FDr8Z/HvInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05mGXuIGVwj4OI5wHNdq1tnb3uHgeeCo7IX8bu2Cpmw=;
 b=fCPZdqLeBXAZezzPekkgPYfdlQfhfUVuR0dezUHE4FpbUW1ra5pqRdBwPuL6ODH4nj5hi+HlQcJFb4jNBZg3ljYUWMLpiwCcAh8Xbss/0HpoxVypTQOjQrK1rqjJFVEtEqBs9AqHLVvDAcAb60V5z2jzIscawVk3II9vTBaE6DwudPN9C9O1tSKqzOmkGkMj8zIx8ZBgw/omllMdIysCjI8sZGrCgoh9Aejk/LjVbg3YR2aDmeGPCgpel8sjtzqH8rmYskPlbzWvgh/Dex83cYIRwH1ekZoi/FP62XCx0zztDgSzkRiZfvN8sMtkj8X9MIVUc70cVGCxrX4RJDeptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05mGXuIGVwj4OI5wHNdq1tnb3uHgeeCo7IX8bu2Cpmw=;
 b=J7DRkpSI0DWlRnZK8aN5Z+nKH8EpUm40dVQgU75iKzG1WXVbSecXQ3eyq34DH/wGeuiRdTOYcOVdLoN+SivJg2rp8UzvKI8KOVEi/2DsY+kTuo0s55xUW+TgOlfzszrehP0VjxfJ89qJGgRgkmq66DmCUDQu71M74i6zKAAQ864=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 14:00:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 14:00:46 +0000
Message-ID: <7f4ef091-9b0a-487d-a79e-b4846c82382c@amd.com>
Date: Tue, 19 May 2026 16:00:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] drm/amdgpu/userq: make sure queue is valid in the
 hang_detect_work
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-7-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-7-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f78b82-c566-4d2d-c17c-08deb5af0668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|11063799006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: FNj5C2i5VeLaPUx5ti99OX1IQ0/chNM8hGjNBv4X7CSiZbNmlc8Ct/rhSXKzAjlxyQBjysDLvG58kkzWdoffiJNrlidJwRzR/gD1h9xXfZv99dEncdjaqcIDyP5Kk7UsAfpu9lYY0CVb3IXo4n0aYuGvNlZrqQZlA/KzeU4oqzLOxSkRqtXExOlS8Jcuqhy5UMH+nNn+dSeoe2NvLz9DFaobh0d+4EVZYXXj0dq/pc75OKGSCO8gf6/1dEoZKcLkMIJVKwXxqvxvBSJLMOTmMbwqPs1vaU+3mcCr+BD2m/njW5phwDbRAGoVC75yQ5k/uwFifTYDhjTRheGp2m49PQwwJas+bUI0p4VzFu+FTJAcEuOPAPY/ISqBdmI1qVM1y6YdH8W4iL9t9b1sxjHL4MYCxJOSWjNUWwoKRSH0h+WT1sAmtr7I72t10kdjkcwPebfypeZxFejcStuy1QMK5e5bfzywIfpV6zsTnxmSv/equ95U0lR8wI6MaGYopz6X2o9Hp0knCv9If/IoFgcUoaeXfmoBCF4vDVipKyxhoLh3QXoGMQqbaZWb5yi17cL6n8kAi0mz3GvJjELknLEaWMEFFaFvw10GEs4vuDFJf0uHw+8zozfaZa7hA4kVQHBEZb5NcB420Ent6gEtLMckDvn+8e6l+ipDV+Ec9+j6+hE529WfMswsHTUL+Dg3kJXK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(11063799006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxqWTRqUExqdHpjdjNya2EzOUcrWTBoRTcwVDBVeHNCdVhQdFJ2VU5jTkUr?=
 =?utf-8?B?YlVJRlpySWxRRUVHTmVld1R0SUNuRzdGVHE4VXo2a05CUHE0cElZNWZJcitM?=
 =?utf-8?B?ME1aYUllMXFoTy8xK0lPRk9rSm9raXUwb1crMzgxZmNqMEhjSTNXZFJTNERQ?=
 =?utf-8?B?WnBQTElQNi9VbktoR2x1L0dIQXpjWXVDaUZONUdNS3l6STNoSzN1dkcrNTll?=
 =?utf-8?B?S2hETTd2VW8xdmVFSlVPNWVDbytld0VvRVd2NWNIWFM1eUlDZW02RWErR3Vi?=
 =?utf-8?B?YjlnVDkyZzl4UmZUZUUvLy9hR0FsYURpUG1XZXpvZ1U5R2pIak55Nk1xOUx0?=
 =?utf-8?B?Snk1ak1FVVdqZWNkdXpYY2g5L2FuRzF0TVlKL1ZsZURYNW05elhZdzZaYWdU?=
 =?utf-8?B?QkpQQlkzbmZQbWF3V0hCcW0vN3d3dXAzU295cEt4MzkzdmJCR25xbEpvZEl4?=
 =?utf-8?B?NlN6T0lqbDVqMjBDUFZQOU91eUtxbkpIQUNFRWxXRHpJOGdUOWFyajcyOE95?=
 =?utf-8?B?WG9pWC8xYk5XTklqYXdrb1pmeEJEb1IxeFNZb3NGRDJRT3FueEJ3Z2tvdmsx?=
 =?utf-8?B?b3d1TlZDd2xDclBnUUpZOEZmeHJEc0QvSHZBUXp4WkVxV2luVGg0aEhneEdY?=
 =?utf-8?B?NGpSZTU4S0VTWmdyT3M1WlB5dkUzSkVZaXRkODFnazgzWmt5ZzNJRGEyT0xs?=
 =?utf-8?B?dmpSeE1UbjV5eWNiWHduOU10MWNqZDJxWkI5b0xZNjZKQkRmR0UyZGliTDZ5?=
 =?utf-8?B?Qm85cC9MRHErVkZkRThsTEU2Mlo3bVhidGREaWZDQ0M3a0tNb2xoNEpUZzRj?=
 =?utf-8?B?VndEVlllMjJlTkxianNGTlYxeUhxS3lORW1LeGJnUVZqSk1KOGg3Rm1YWVR0?=
 =?utf-8?B?MG5uSVh5eFpCY0UvdStQWjdUT1ZrSnFKY1VOVTc0QXJtdS94SjZ0Zk5ibm5o?=
 =?utf-8?B?ZGJmQno5SnZMOFhMK1l6dHdyWk1SdUs2ZFFNMFREUkZlaWNIV0RLOGk2ZXdP?=
 =?utf-8?B?YjREZ2FydUpoWU5pUGxQZnRFUnFvWEpjUlRWQ3gwL2o1RldIVGZPbkdQcFVy?=
 =?utf-8?B?ektKaEFlbTBnbmNpZW95NmxJSmQvMjlJS2ZyWm8yd3E4ald3Z21KbkF5ejdo?=
 =?utf-8?B?dWh2cW5OK3RCdE5KOWZiR2p0cllTNlhJanBzZGdQVUxJeHp5d3RQQjR6Rlhh?=
 =?utf-8?B?THhPY2xvdkdtU1dVOGFvdjhGa0Z4N0tLdENvQjZORmNWZ1hqTTJsTE1ER0JU?=
 =?utf-8?B?R2QwZHQycXpiTjNlV2g5ektjK0d0MnZNQ3lkTkRJTUZQRlFnQXpPM2I1S2RB?=
 =?utf-8?B?aUc0NGU5QU1zWUhvVUN2S0xGQVY3ZDV2VFhKdG1kbzJPelkrNmJxYlNJKzNX?=
 =?utf-8?B?RzE3clgzSnlWLytaR1FnWU41VXFSa3JneXc5d2ZGbUZ4alNqKzN0Ym1pUTh5?=
 =?utf-8?B?ODBXTkRialBocmdkeTRYdDB3TklWNm5pM3FMWnNFNitONnlORGI2UjU1bi9u?=
 =?utf-8?B?VmxnekdPY2RadFd0VmFZcmNJU1ZVZU53UjR0UGZzTFFFV1ZMSnlwN2NLN0xZ?=
 =?utf-8?B?d2pvQldtNFZkQ0JoeTg0emdmZXpDOUwvdEp6NmlZYnF5ZUpZQ1E2WG55YVJN?=
 =?utf-8?B?UVI4RVRMcllENDZlYWYvMGFjdWJBM0FvY2VlT21VQm9VN3JiakZka3pJaWhp?=
 =?utf-8?B?cW9qTnNKVkVXNy9WbFBEM3ZpSTlWSnc2dmFkNThNeVgxSXlRUlJtMW4rdTRL?=
 =?utf-8?B?Uko3RWlObkxmZjRuR3RvSWE2MW11bllUQzczZE4wY3FMK2ZNUHkvOUlFdkxY?=
 =?utf-8?B?d2F3dlpPRnBZWHJNazh5WTN2bVNKMnhjQ3ZJWHB5QUhVUUZkTEY0aGtnOElN?=
 =?utf-8?B?ZlA1bThWZkFia3Z5QzNpWE1UY1YzR0s2bDFiRjZkZmdwVnE0NEprYUQxdnBT?=
 =?utf-8?B?L3MyUi9wUVAremsyT1NLMTZKcFQ2ZExVSU94VmFwb3RLLzF0ajNDbitVQWpi?=
 =?utf-8?B?ZFNMOUZHbVg5Zkd4WiswSHZGRVFtREtZeXZEZzhPeG43VXN2Qk1sNCtGS1FR?=
 =?utf-8?B?RmZ4YU1oVHg4cEFGMjBzTTZsUUw0SlZTLzdPTFF1YjZVci8wRzI3Ylc4SWVw?=
 =?utf-8?B?bTl5NEVqNExaMmFKUnhITyswWlJhM1ZMSFVjYzdlYlpRYXdyM3dVSGVTTWND?=
 =?utf-8?B?L01YekxoTDh4a2VVYjRkdnZwRFczekxtZE1LY0RzZG1pR21MYWRIRFplMGkv?=
 =?utf-8?B?MFhTUFUrQ1FSZHZRQVFxZlhIT21DVDNxMzR4Y2NGUldvVzYzVlFJSjNYbjFr?=
 =?utf-8?Q?a/wnzRz4T+9wKBT85p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f78b82-c566-4d2d-c17c-08deb5af0668
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:00:46.8405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O9T6KG7+QJEnPCyNFcAKGVSepyn02F1/shTBId5g6NNz57mD66SnCowWclFJ9XR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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



On 5/19/26 13:18, Sunil Khatri wrote:
> Thread 1: Running amdgpu_userq_destroy which eventually remove
> the queue from door bell and set userq_mgr = NULL.
> 
> Thread2: An interrupt might have scheduled the hang_detect_work
> which still need userq_mgr to be valid but could get an NULL
> ptrs.
> 
> To fix that make sure we cancel the hang_detect_work again before
> setting userq_mgr to NULL.
> 
> Along with that we also need all the queue va to remain valid till
> we could be running anything on the queue and hence moving the
> userq_va post hang_detect handler is cancelled.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c8f7bb23e2c3..7354c51ae83d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -427,8 +427,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
> -	queue->userq_mgr = NULL;
> -	list_del(&queue->userq_va_list);
>  
>  	up_read(&adev->reset_domain->sem);
>  }
> @@ -619,11 +617,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
> -
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> -	amdgpu_bo_unreserve(vm->root.bo);
> -
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	amdgpu_userq_wait_for_last_fence(queue);
>  
> @@ -635,6 +628,14 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
> +	/* This is case an interrupt was fired and a hang detection work is pending */

Typo in comment, but I think you can drop it complete. Comments should explain why and not what.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	cancel_delayed_work_sync(&queue->hang_detect_work);
> +	amdgpu_bo_reserve(vm->root.bo, true);
> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	list_del(&queue->userq_va_list);
> +	queue->userq_mgr = NULL;
> +
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	amdgpu_bo_unpin(queue->db_obj.obj);
>  	amdgpu_bo_unreserve(queue->db_obj.obj);

