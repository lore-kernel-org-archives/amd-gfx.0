Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881BCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 09:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7266010EF8D;
	Wed, 20 May 2026 09:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UWJsVofl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE2010E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWgvQkS/37RnOSbezdFb5SjJrQL6rNEq+Uz5q7ClzZRHTd1XrT/kHNVtyKsfzTmV4udhcXyUBUnvqHvNR16SUvJc8+kR641llgwonhqvExYftu9cTXxwMiYeTbkvqwQNCtIQT+sB8GepCoKozD06g04pjQb41hnaVYOsaopcykgVKA0nzdYvKubItmHRIYCq+am5GgXxDUh8Up0WEq/qIKGczLjKUbeBcuqfUIOCzqsCUOklz+tXlFxdBM70jB1qdF3FetZn7Fyp9l96xU1yZWT+ttPsB3/GrF7rZNUl1LSKAictZcAGec1Dq7eWAAXEa3jH996Q96HRRM2r1aUpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML3vkNV93/BxKQvHcImoiyiep5rbdTQqVM0WMl79j6s=;
 b=HBLfVt+pP9v7PlBgF/sp3rEPCrAvd1Vof8kJyy+lYhjjWOm+c2XlENjDon0nGiXAnE4jFHVOG71oiRtq61Fps3PevRz7ZgkRk9frmUvS4KHmNHcL16ibHDH6j55MOjuIl0J6/KXJBbY0G0NfvlkV4spQi3f2JDFObRBp0f8U7EGJ4BL9D2cgFsL8AiIqI8lkCRJuZgUOcum1p2VCY9TlCNdyek/CnDgSwZliVcj+Vz/Gx5CIXnkZs1ZmXaDh0P/KOwGAkL6M4e0cNiqQwnbCQmV3CPgzK+LV6ZbnrKGziFw8iWSU6HgLjuTOe8K8ON9f5P8TB/Yyhbe7Mw4ttYjdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML3vkNV93/BxKQvHcImoiyiep5rbdTQqVM0WMl79j6s=;
 b=UWJsVofllEHGH1zVR3ron2IzSkS9/RpMmvCqwoqPL9l+o0JB6AgyZANS8Kh3xZD4Xwz05xsExirG/wGLMvZ0FMhjNSTRKhiaYsOlYA37teYTIlcbktUMCPryd91vx+Ns3hyX6OQcJ/6A25YuUeDAncGUYXrvFiH81NPgVnlYHUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:04:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:04:18 +0000
Message-ID: <1ca984e7-0a89-4f35-a914-34116d4d0894@amd.com>
Date: Wed, 20 May 2026 11:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu/userq: refactor mqd_destroy code for
 cleaner cleanup
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
 <20260520025258.1866776-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520025258.1866776-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdbb644-2cff-404e-346f-08deb64ec64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F5igCbsdIGhiQ7VFNrNuUY2Q/nMHVaH0v1X+qcmVWqZq9G/YDMCQSxTTptnb5jAEelk8EMOvVwHFuK6yMg1zNjd6Cl55pMABk2XFng/HHIebGzYZHSIxssorFC5lEyqdpJyd1Qm/eRhn8QXBOf5G89sSRcuOCNbIODN78tbUUeWuPZEE+U5RiB8r4HU+bSfSo/kOYVIensAB7Kq8BoFaimEoE5mntgVqsv5+rIL00PBr7yNgI2u1PrF3NzzvMj2g6wgO4GzKcpo+hFBNQ9BEKR8IbT+2S3GNXUjTsDxcR1+Q+9IbBpVwJjc1Ntjw2CeG+I+tTqyP8w2wo0prXYSGEKyc2lJePu0WsJuhrcNILoi9k2FurTaIG7nYq5EiTVAN7oSQKTZ+Tx9sJ5SJ3NJ8VAJE4/GG/aY/7jwP7GdJxde10CD6phahZEL987+9FrrEB3w1niSU3MOFT3CLqD/MGDFUhPkx3LW7zmm/dr2/8OxScwu3YxF/3HKRP19aadBLXf3OwUcr5GnwTyqQSxGZEF4pNtuUUKxVc/P3Huv2RdWq7+6OO7l3k0b9m5rS5hUlU3FbgsqJEb5rov/KTqFtC1EcooLxAskEGCYMHrpO7qX1AorUdUQX0JI6/6N/2E6aJZqPjCAWYaXYVeu00i2Fp1LPgRHETNnOPQ/SdeE14q3Mph6kdD5gCSNBd5CRg2uc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0d6RUV4cERZaWRxVmFpWXc5U3g0TStISk5yNjIxMmxvWXBCNWM4NGIzbXlm?=
 =?utf-8?B?RmNyYVpPNlNVanNibUYra2lTRDl5d2dIUWV5Mi9ucVZsVDJBU1lLT21MazNY?=
 =?utf-8?B?MjVWZlBDOUFBcm1KTllFMldFNXNucVdFcy83SUlFejFpaGp4cEJSVGJtWjNX?=
 =?utf-8?B?VlcvNjY3Q3ZjemQ2VG9EbFVyY3JIbXNyTk1zblZqN0oxbFBXaVJYSkxLeFo3?=
 =?utf-8?B?empJOXVQN3VSSDM3N0hsYzFseDZkTkE3bUgrOGxSRmZVNE9WdDhyV0wzcm5r?=
 =?utf-8?B?VnRTcnZzWDNjRUNqTjRKMHlnYStSREdDVTZ0blo4UnlrZEFpY040VGRNL0tQ?=
 =?utf-8?B?T1ZxMUVOTGNPNXk1VE95UFpLZWY3ZDBoYWdMQlJYWVgwUjA5dC90Umo0aC8z?=
 =?utf-8?B?STNBN3d4M3FJckRqeEYzUGFuUXZMUXIzMGF6bEpOMDVuSGdTZFM5bFIzbHln?=
 =?utf-8?B?YkNVZlZuQzhxRWVVRnlRM0NZWmdGRm4rRm96VUlGdi9ZdlpVekQrdFkyRWNN?=
 =?utf-8?B?bnF0K0R1UUE0b1FBa0pCS1hOMWVTWjhtSi9KczVxZCtOdnp3MXY2dDBmMVBo?=
 =?utf-8?B?RHl6VEFRREh3aTdWY01RVStxdG5ERjhhcHgyZm44N2lZczdlbk1oSHRGVE1L?=
 =?utf-8?B?QmV3aVJqcjZ3Y2RVZ2lmbVFvMUE1Z0JHV2Y5ZEw1VzdNQzdWeWdXbXJ1ZGJH?=
 =?utf-8?B?SG53OVZsK1lYV2IvUlhXQ21YbUQ2K3dlb012RTNpQnZBUlJXTzlPQW1sUXlC?=
 =?utf-8?B?VmhXMDBIeFFuNVpidlVweHlBOXB6Zno3cDJYbUxrU1hlN2RJbFk3Y21lYzB4?=
 =?utf-8?B?YWtyZTBRRkFtc1FKRWRBdlhqaU4xcjYvMzBXWHMwWTlPcnFZMXVML0ZkV3Zl?=
 =?utf-8?B?SUgwbXlEc0NsM0FVWWJpbFk3dmVQUFd1Ly80SVZkWlVSQTM5M1RpcE9tMThX?=
 =?utf-8?B?SnJUWUdPbkxYdCtDcFRmcG5ERzJCRUpCckZQOTJaem9PRjVkSzVqWmVBZ3hh?=
 =?utf-8?B?cXltWlZtb0FVaVRtSGtlZ3Z2dkdoSnVSRDNXWU8yM3BaaUpGaHRpaHFIVkoy?=
 =?utf-8?B?cmt4eGFCZlllai9jcTlBQXd3a2VNbTBkMHRUZ0lWSnFaZE9XY00zbWxEaXFK?=
 =?utf-8?B?RG91dER4clFuMjZXaEIzZkloQzdIMFlPVFF1dWRnVkJNQk1GWlBsbEF4dW5U?=
 =?utf-8?B?Qy80WHdEVmYvTkcrRkRPSjE5eFNYWjBtQTNjdUl6bURnM1BMbFNoQWhwbU1x?=
 =?utf-8?B?Y1ZMRFp3V1NJZURyRnpGWS9qbElTcnR1U1NLaVY2NXl0YzU3ZkFvSDZ4ZDFT?=
 =?utf-8?B?bU55d2kvRDROLzdlcFFPbml0eHBUQk5lYjI3RFNKc2lhdEVuenZ2RXZwbjRo?=
 =?utf-8?B?N0xUVXpiZjErU25wM0dkV1pWQkNhMlNoZWFHd3hqYlVaMG10TGJzcllJMjZq?=
 =?utf-8?B?OU9ydjZpNzdWK2xOdVB5Qm1jM3pzcXpEMzg1bkthbnpmL29CNVhYczVOMUxI?=
 =?utf-8?B?aktCY0JRRmlTVUtQSVpLQ1FYWlhBRE5VRHJGODMvUmZ5V0lmL0J5cEZVSUFN?=
 =?utf-8?B?LzhHekxMUU1xRC9wZlRaTHlKdCtzMmU1aHJYRnk3TnUvRUpDMWVObzcwNERQ?=
 =?utf-8?B?ZTAvWDAvMUxGRDlQQmVaMXU1ZTdTbmR2QkNkOUU2MUhTY3V0aUtFNHllbEt3?=
 =?utf-8?B?SGloQ2lhdnZJRU04UkFLMysxSFNNTUUxeEtESHdhNzlDaDdqbVlOT2FMenpq?=
 =?utf-8?B?RXpWeGErMWs1QXRkdVdUT0VqL3REWlB3clQyekgrQ3lwRWU1M2VPeTRmeGZm?=
 =?utf-8?B?eXZuV1Y1dDh4cmwybEUxUHFvQUtLMXNXMndhOHRoeW82UHRQQ1A1MU5hVXQ4?=
 =?utf-8?B?bm8rMmdhR3FKWG5SeVNyamlqVnh1U0NZZ1VHNVhYV2FuQ1ZRbjI0aWo2Y0pr?=
 =?utf-8?B?MUgxTk12OW12VkcxUUxwWEtyT1kyVHJTdSszZm83RkNsM2tJbTcxZC9idUdm?=
 =?utf-8?B?U2RXQWpQcmpnbUd1R2psZys0NXJ5Tk5aWWE5Q1VPZFZlZ21tWjl2NmNTRnp0?=
 =?utf-8?B?MmMvcTY1cVg4eWVodEptTElraGQzY2pIU2RpU0YvYWxpVVgvQkd4MkRkc2VQ?=
 =?utf-8?B?bE9sRTRTUEVtb1VxbFpNNFNlNTg0MjhzeXR5bEtlczBDTFIxQmdSY082MVE0?=
 =?utf-8?B?U3VUckxtTmZGbHR6RG9RU3ZzNkxGUUZPZUlIYUVkZkwrRU5wVnh3Wk5nLy9u?=
 =?utf-8?B?bUg1ejV3Q0R3R3BEalBEU2d1S2FyL3FRUmRQMkp5dHF3YURtb3RxZG53M3dK?=
 =?utf-8?Q?SjHu0jbsUduz4xLfEs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdbb644-2cff-404e-346f-08deb64ec64a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:04:18.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAY/wat5Y5/81hLr6xn3fbEepPEAl9O0LfW5xo1wDa30UIA+wsfIOS0EqYcWg5Ou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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

On 5/20/26 04:52, Sunil Khatri wrote:
> Use amdgpu_userq_destroy_object to unpin and unref the queue core
> objects and rearrange the code to achieve that cleanly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 17 +++++------------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 ++-
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 758bf099f0bc..7b86b70129af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -417,12 +417,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>  
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
>  
> -	uq_funcs->mqd_destroy(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	amdgpu_userq_fence_driver_free(queue);
> @@ -611,7 +609,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_vm *vm = &fpriv->vm;
> -
> +	const struct amdgpu_userq_funcs *uq_funcs;
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
> @@ -635,16 +633,11 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	list_del(&queue->userq_va_list);
>  	queue->userq_mgr = NULL;
> +	/* Destroy all the memory associate with the queue */
> +	uq_funcs = adev->userq_funcs[queue->queue_type];
> +	uq_funcs->mqd_destroy(queue);
> +	amdgpu_userq_destroy_object(&queue->db_obj);
>  
> -	amdgpu_bo_reserve(queue->db_obj.obj, true);
> -	amdgpu_bo_unpin(queue->db_obj.obj);
> -	amdgpu_bo_unreserve(queue->db_obj.obj);
> -	amdgpu_bo_unref(&queue->db_obj.obj);
> -
> -	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> -	amdgpu_bo_unpin(queue->wptr_obj.obj);
> -	amdgpu_bo_unreserve(queue->wptr_obj.obj);
> -	amdgpu_bo_unref(&queue->wptr_obj.obj);
>  	kfree(queue);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 69b36ebfe7ac..ea572d924621 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -445,9 +445,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  {
> -	amdgpu_userq_destroy_object(&queue->fw_obj);
>  	kfree(queue->userq_prop);
> +	amdgpu_userq_destroy_object(&queue->fw_obj);
>  	amdgpu_userq_destroy_object(&queue->mqd);
> +	amdgpu_userq_destroy_object(&queue->wptr_obj);

The wptr is not kernel allocated so it shouldn't use amdgpu_userq_destroy_object since that would eventually destroy some kmap which we never created for that object.

Regards,
Christian.

>  }
>  
>  static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)

