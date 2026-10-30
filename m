Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1D606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GV8LfWoN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1D1129DF;
	Fri, 30 Oct 2026 21:15:52 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EF71129DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 21:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3FSR25ZHXFnFxBgFLCxjdKa68rueRvNy7fEwoiuZGS2XdqdNPl+FCbwXW9u/d7MwTSCmDl93D6ciEbBTIwCRzC6EEfOAqt5iqQM+Qbb6ws53L7Fih5sU/BbpsjuH6/JjM3JnpelSra9zMUtgBFbrCTMkPuwoN/yQZz//EwVNADk0ZYYkbO+9+1vQ/QJZUfYZBXF9d4Kw2YGNHePteABcP4++3aSbFiNORwXJcu1ygitnz1kiSBOXVbXlj2gcL7sHm+H+A2zSNBKDjI+wlaHGjRiWDgO/OA4r9dFbIeOTCKO4/1jsrn9ghr0OWn+h3+kfspAeCYctXu0zVdCbDW/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ieE12hAsHuC6XOk6WzJxlUW/d3dXnk9jBI2iv0WCZQ=;
 b=hqk7Kq0wfeFkFFOa4xo+x4bW80PkKD3mBuRyXodLlZ4L0HW1f7+m8NxfcZRqxaZ1tBLLUfRvqxg7otb2F0iAuS7xVYoQmBAiYmBcWQ6H+FnaQZTghZ2SdHbX0q9DC46WTSwR1ckOgYr8nwFAMNtOkVid1iDusowigT7THfBI4rEPZZ0gUQscJyx2l1TZpN+ZeueAEiefbP7IRQ1jBLks/OIpTpFOhVwV7N6Iac+fvd3N2E39twJ9jJM+a+om0/4Ot7ZlcpkG6QUnjT4rStfxyK0DJl2GSk/MieK4vhSz6JhDutc0SL4nbym/tEs+Egz9//nkKb7Qi5vPmHKP22DslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ieE12hAsHuC6XOk6WzJxlUW/d3dXnk9jBI2iv0WCZQ=;
 b=GV8LfWoNK2z8qDixmRceRhIy7RCsnPhYasWCNyxa/+C2NzT0scDnwhkKICainKlwub39z8cnrnvK7c3UPp04zGrf+52+zK1OFC4klhDT5JvoCA0iolxGALpptBxPgdis273B529CqsA7L6DhDE/oY8+H1eOYyaRdN05Iqw4pEYc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS5PR12MB004700.namprd12.prod.outlook.com
 (2603:10b6:8:47c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:15:44 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:15:44 +0000
Message-ID: <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
Date: Fri, 30 Oct 2026 17:15:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-2-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261030140550.2524662-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0066.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS5PR12MB004700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1963e835-70bf-4b8a-fa69-08df36caf59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: kK338B67SlLrqwOKj9j4CwUjZMohjbxBImKdehwx5icQHXrSn/6hlReGAdfFfbOACQzhu8uuCDx2Y86qZ4F32A1iK0rs0OcxWKAf1Hm8rNGwewQF0hWhBn/+LvXvtf9GKv5vOgifu61IMEIY/ruztaNVuqHq+xMg5VbMthutM2bgiPH8FHrrSco+Xcf6V2yMyQVEqCKk9YqG+CBaI0dKSIRybQNm3llEyOwOCpg5Nf8QperhhPv8Mx7ZYCejdRsbre+uyoE16EYoRp4uZA+cxwS4PQcE78iRNfZt+QoJ8507vgIR7r5oKe5KsLLDsmxvELf1OrLNi/zvZIu9X747TP3NIC1DVX9cXRRtlXhV9eMoYaYqBSyMUmKN+JivLbsCXdd5cob6jfPO1GhtKVIUKooTBNEEJn7ZTYjq7dzy/CC6SUikgqHHGTLtgkGMYyoIEjGybJKatt5mv3njVQ+nl51mO6W6ud8U9Avt+74r4g74cA5t8JTAgvOyrr63avY98AoYfolPN3zlv1h8T/F7x+7u4b32mEAqdvb7i/STGBlxT4iQT9jck3kKhBIPgEty5whEkwzCBf2uIlSkJdFhuEhkU/Q/9atMi1miXeVaTgw4jFaa6AebjEGn9uo0MvJk6P0erSZWY7uqVvbUru9FaPiXhEa0wuprwWrqUzgwcEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3FDQWM5STNDa1lteXdYcDl6NXZPZWtpSHhsU2ZSck5hQVpvQmtrcVc2TUJz?=
 =?utf-8?B?WHRpcHR5Mk5ieFdnSDNKaEdXZitvby9qQXFQLzYya0NKQ203TTkvb0JSVElC?=
 =?utf-8?B?djgvZ3NEa2tDMlg3ZU9jWDVRMyt2VjU4cWVUbWZ0cEcwRjdzeDlpajV4MVVk?=
 =?utf-8?B?QzZXYjkxZkZ5ZGxOMjRzQzNRMmFET1UvUW4zME9FOURud2lNZjB6cEVNZWtM?=
 =?utf-8?B?emdkeWRMNithU1liUFhKVmdEcWM4QldhTUxJQmhyS1Aza09aT3NhLzFWL0Ir?=
 =?utf-8?B?YSttdTA0R1RsR1pSVU5uZE1GOXcxWkVySUt0ejg4NmxNMmJjL1NmcXVUN1hv?=
 =?utf-8?B?RW1LcTdTa2FCenErNWIyY0lYK0g4TFN5Zm8rYmxaSE8ycElFL2Y3ancwR3Vi?=
 =?utf-8?B?aVppRVNxN2tWdjl0M2h3WVVwVzkzRGNmVmUrOE90V3E1TWIxK0ErbWQ3S1ZW?=
 =?utf-8?B?MjZyblZhZHBNOHNWVUlzZXVmL2x6dThiYjZVcjdWK1JJa2NRYmRFa3l2OTVC?=
 =?utf-8?B?WDN1TkprRVFScHZDTkZFM1Uxbm9oeXhqdFQySWsyVTdLdmZUSUhoaWRXclUr?=
 =?utf-8?B?QlhEbGdMQ00wQnU0SXNraHpRa1cxVlBFbGdlU29lTUdUYThOR0xyWm9OR0d4?=
 =?utf-8?B?WWkzMUM0ZlF6WmdSdDBvTHdTNDhISWtBdnhkbU1nY050YnNDdkNlMVEvdGJP?=
 =?utf-8?B?ODBjMW44SmlpQXdFbFNkYXk2RWR6Q2F5Y0d4M0lpQStzT215d1dOUUplSWhQ?=
 =?utf-8?B?MHlkbWVucEdqWHlZaVN5WS9IU3NrSmNqV2hUSWQ3aWdKUlJCT2JqdWpSTkor?=
 =?utf-8?B?TTl0VEdPNWFiaXZnU1FRN0NSVExwSjI4MkVhTUJOb0dUL1JWeUh1ekJGa3c3?=
 =?utf-8?B?UDdSOGVGRGJ5Vm1UdnBnNUlYbmFFbG9yd21wTlpiL3RJeGEySUNjQXljOHI2?=
 =?utf-8?B?bXpabUxEcjhDbUY3ZkJrMDVkT1BLRW15emlqTGdJUnNVdGFHbTU2NWkrcVNQ?=
 =?utf-8?B?dmg4dVo4RjEwVXBZM3BWZFhoWHRhZDAwZmR3Z2pBbVVMcUViZFhUNlJEWWJa?=
 =?utf-8?B?T1RzR0tWVy9ZNjVMR0trc3ZiSHdiaDVpSE1jclkrN1QyN0o4Y3Evc3lERWdC?=
 =?utf-8?B?dGZUV25MQnVnZFIzTnFhMkRLZG0wVzU0RG9rTTlpR0FZNWxteGZtYUNuTjNI?=
 =?utf-8?B?SlR1U1lMMnNJSVFGenlwZHZtOFFmc2pKVjJoUk1kTk1pSlAwdFdUajFLdXUx?=
 =?utf-8?B?Y0ZZNTV6enBLY2k3OFd5WCtqZWxDVzN1aHhkQzk5aEZJN1RGZUR2aSs1bUIz?=
 =?utf-8?B?ZjcvN2hQMFluY1E0NHcrWi9rMGlkY09pVFoweEJGUWxzQ1BXaTVwU3I4MnZ0?=
 =?utf-8?B?QlRnRnNrR3lWQ0FSaS9KWnI1V3ZuaktvNkFMeldFR0lPaWwvdXh1NUsva2Iz?=
 =?utf-8?B?cDQxTFhJOWFYbEIvZGRQRGJ4WXdYVDJCKzBJcTEzVVFRSmxkWnBHNnM3UVp1?=
 =?utf-8?B?enlzKy90b1JFY3hrc0phcHRWNFVRdTh5R2djaUREUEVCM3ZaMlRFYzNIei9W?=
 =?utf-8?B?QW0yZkJseWNpRm5ZcFVmaWVqRG9LV3dBTTJncm95U2liTXEyVW5OVnA3cmx6?=
 =?utf-8?B?V1lNUUpLZmd4bWxCbHNqM2lodTlycm9FcXlVTFdCRGNORDZza1FyUHkzampN?=
 =?utf-8?B?Qk9leUxVd25uaEFnZmcwM2N0ZEVTbUxobFdCZEduSWxzcTNvNklXa0Y5aXlR?=
 =?utf-8?B?MnBWRUI1eHJFLzI5WVFMKzE4UWoraTFaNjd4VnIxWk51Q3RSWGpBckFCZWhM?=
 =?utf-8?B?UjR4eTFuSG1ycVdyUm1XZVEybmlQazVoMlVnTFFYTk54RjMyL3lxaXRwS2VT?=
 =?utf-8?B?VlpPRWcwRG4rWE5ick9veFZTL3lRZElBYkRDQ2hLUFZBdTM5VnB0U2kzQThT?=
 =?utf-8?B?Q0sxelp0RFc1eHpRNVkxZWF3akNEdUd2MHZMQzZpNjhRK2ZsM0N2bEh5NnJN?=
 =?utf-8?B?STdObFZuMGdRdXd6NVpaUlN5L1R4S2NjMzZONHpoaTEvNEVwQWIrUmloMEJX?=
 =?utf-8?B?MkFPeFQwRTgvS0hUUU1TcGxyZ1d0UEtoTUxKaEdpQVgyaVAwWlZxUnpkSjRv?=
 =?utf-8?B?VjJuL0ZjbkxubFhCY1BWcExKWDJYNGFqV2pWQzJ1OHUvQnBLbVEzUC83NE5Y?=
 =?utf-8?B?OUZQK0xpRnVMRGZNVnVWTE9yWHovRjZpSk02eS92WEM3Q1lvbGNzMnVuVWpR?=
 =?utf-8?B?c25FbkJjZ1FicW84bmk5RXVwanVrVnRkUG9yTFZZalFlMjhkdVJHMWFSNnRk?=
 =?utf-8?B?T2xNRU1SNEx2VW9ib21BUXVqR2pWZEtMQU1aL2VKeFFOUVNwblRvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1963e835-70bf-4b8a-fa69-08df36caf59b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:15:44.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaVjJSva6hDZp+iX3XBhq+++ZkD6aFdpN0Oi2EqlEaQgXY+nPEMaHkmJ73cssKk17Rai9bmOK74YfdYPqsqS2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB004700
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

On 2026-10-30 10:05, David Francis wrote:
> CRIU queue restore doesn't acquire the bo buffers in the same way
> normal queue creation does. In normal queue creation, the driver
> gets an additional reference on the queue's underlying buffers
> that lasts until the queue is destroyed; this prevents the
> queue's buffers from being removed from underneath it.
>
> Acquire them, but don't get the svm bo. SVM isn't yet fully
> restored by this point in CRIU and so there's no svm range to get.
> This will be addressed in the next patch.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>   4 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6c710e4a5220c..d8233337b8d5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> -	err = kfd_queue_acquire_buffers(pdd, &q_properties);
> +	err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
>   	if (err) {
>   		pr_debug("failed to acquire user queue buffers\n");
>   		goto err_acquire_queue_buf;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f0ce5fc4a138f..eb4d35a42e917 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>   			 u64 expected_size);
>   void kfd_queue_buffer_put(struct amdgpu_bo **bo);
> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>   int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 4c4a3a8587f46..509529af2dc3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
>   }
>   
>   static void set_queue_properties_from_criu(struct queue_properties *qp,
> -					  struct kfd_criu_queue_priv_data *q_data)
> +					   struct kfd_criu_queue_priv_data *q_data,
> +					   struct kfd_process_device *pdd)
>   {
> +	struct kfd_topology_device *topo_dev;
> +	uint32_t num_xcc = NUM_XCC(pdd->dev->xcc_mask);
> +
> +	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +
>   	qp->is_interop = false;
>   	qp->queue_percent = q_data->q_percent;
>   	qp->priority = q_data->priority;
> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>   	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
>   	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
>   	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
> +
> +	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
> +		if (q_data->ctl_stack_size)
> +			qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
> +		else if (topo_dev)
> +			qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;

I'm curious what this case is needed for. In what circumstances would a 
CRIU checkpoint contain 0 ctl_stack_size? And is that's the case, 
wouldn't that break restore anyway?

Other than that, this patch looks good to me.

Regards,
   Felix


> +	} else {
> +		qp->ctl_stack_size = q_data->ctl_stack_size;
> +	}
> +
>   	qp->type = q_data->type;
>   	qp->format = q_data->format;
>   }
> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	}
>   
>   	memset(&qp, 0, sizeof(qp));
> -	set_queue_properties_from_criu(&qp, q_data);
> +	set_queue_properties_from_criu(&qp, q_data, pdd);
> +
> +	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_size) {
> +		pr_err("Failed to determine ctl_stack_size for compute queue\n");
> +		ret = -EINVAL;
> +		goto exit;
> +	}
>   
>   	/* Per-XCC control stack size from topology, as create-queue requires */
>   	if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> +	ret = kfd_queue_acquire_buffers(pdd, &qp, true);
> +	if (ret) {
> +		pr_err("Failed to acquire user queue buffers err:%d\n", ret);
> +		goto exit;
> +	}
> +
>   	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
> +		kfd_queue_unref_bo_vas(pdd, &qp);
> +		kfd_queue_release_buffers(pdd, &qp);
>   		goto exit;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 6010a5d7a7eb9..18d24ddb455eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties *properties)
>   	kfd_queue_buffer_put(&properties->cwsr_bo);
>   }
>   
> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
>   {
>   	struct kfd_topology_device *topo_dev;
>   	u64 expected_queue_size;
> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> +	/* CRIU svm buffers are restored at a later stage than queues. They'll be in
> +	 * before the queue is actually used, so no risk here
> +	 */
> +	if (is_criu)
> +		return 0;
> +
>   	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
>   				       total_cwsr_size);
>   	if (err)
