Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015E606C444
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qgkDvdOZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E96810FE9A;
	Wed,  4 Nov 2026 19:51:29 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAA810FE98
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv3AKM7SH0TC/2XBdD0euPO4w+W5ouRAIhw1vkGUJHVi6+4GoUV35hkmR1fxa8hqSrvTw3FCanWqXjsPyTjz5jG48lxE4Z8zbN8FgWQB+xLaxx6UHnBdRu7Jl2fXWUgsr0DtdSrX5XFrHnLex+DoU9MqAcREqpqtMJm114A8sJMA4DC1iRhwsuf6vUUQcnM7guwOd+1tdgFFMZpPytNytpu44LJ7LuDh6O0+TIIOVjhAp5QYRJE/NHsYNjkdQ708Tb3n0Da3JfIYHR2tEOXb2/C+Go8sVH1MMiiAMkkY12yzYzEMyXIGKUcJQgxKdaNQCB4Z/ZxQWY6jOyePJIX98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOck5A56O/gtJOGoOplgAG6PKfo9xaPctqL+/GEd350=;
 b=qDENnO6+VFO5P7jvbiDwMnN1aiQkcKdGJesBg+eJzV8v8CzDrd6sKfRYzuJ/bvlswJ7cK7MC/Ue7Q/HvxnUM5E0FA8FvUk30+1MGHw8Dbd0OClxO6N1+xLh1WcwwYa79c308Ebnzi8btppo6J/2vIg8hGK+Ma4tKBqR/yNRhu9AHgJm764XrdwutqDrfTkES+7wPw6KFWyzRlcJ2QRgM8Wz6Ow9RWV7Fxm99Z22YETR1QqO2JpzfBC3qumFwwdiRYTJWbn6Y5/LfWNW05fPIn8e712JFjxIBZe56hWKo2oBg45ClakxW0AlhqYjBzT6HswJDBJTF5RmSw62U0deqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOck5A56O/gtJOGoOplgAG6PKfo9xaPctqL+/GEd350=;
 b=qgkDvdOZbuwqecxUfoRUvQ+IhitTn0jMOcr4olD7AdmMgWAHAoABQ3aaUL7UqpTRhLXNKvE+bgh20qdGBMy4sbZXlzfAYFgkeHoAJdnhwVArlEZXWfaRd91KCB+9Ddt1wcvVjxtaD/IWvxjMRXfQ6I+305DULa4jgW3KY/CFwjc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 19:51:14 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 19:51:14 +0000
Message-ID: <05d0a2b7-9469-4c05-b8da-c25ed86feff4@amd.com>
Date: Wed, 4 Nov 2026 14:51:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261104155203.3826257-1-David.Francis@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261104155203.3826257-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::28) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 822bc758-e393-44cb-a084-08df3aacfbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: DGirfYYKtO1BNYRN14JprE7kBEvcO0VJ4UQLsdAMpyoM2Mr6kIQF8n3eUkU9BWdqdCM1EAqegS8X9ji5Bx6syUHvHExWnAy6ZGnzyC4T8YAZXrkBw0XJMFTDWSjyfXWQfFhIsEqjIVs7IWhDwFspishXjV2vnTaBE9xpN+8bTKc9Hurh/JopA+kOvPOA/yQIBVYmGqGOnEMYg+JLNk4KS5GK804sZYHi2qmcNSqJXWsIQLsmXnARLUseqWCLWd81NaohfaeVFChSPLwUQxBCp6BOKM3uzjSl0jSE+lX18bqqjuv+eN2pRIzFDu+08xmV64v1RbpbOaQomm3IjxNPwEduogVwmHBGp321SHfi/ZhA2gaZAxKDlzroCnHY5SE2N5WmUbwsNewzPx6QS1nsyZDtwu5XTWM5tpE1fDmAn85tvBpmiupLdfmfh2R1hQStTS77c/Y7UzjsHtH53enppcJsruSgyTScgspPejFDdxZo1Ef1R5SdSKHFLN+OfnL5X1/z7OfldI2xTcpWYlj6uafOB60dTfpIMq/1iTCTJaUBN64UyUd4OO5kI7aWdOUGZS0MhNl9TY1ypYX96bPCCZroK0rFpsk7nN0pkxpLWgcMw0IeXu+a7E2h1aRvwSAGSSxWj6vAEcMkvKoz7vXh6UODhzyqmw6sQMuZgjdNkL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNnV1d3S2h1SU9EemtMOTdnYXdiaFZzc2VqbTUzU0dNVW9uZ2tTZFd6RHgw?=
 =?utf-8?B?aC81ak0zNFhMTjZaWGoxMWttaTdoRnRzSkxYd3MxWDZZdTJPRXlad1c3V0dP?=
 =?utf-8?B?VmltWDlZYVp0ZVBjaStvL3NMMGh2UjEySzhFcnM5VjJoZ0FCL0IvbHU3N3A4?=
 =?utf-8?B?YlJWOFNFMVdTanlybjBwWXRmQlFOQlFzSTgyODRRcVhwdDZxQ3ZVbTFSOUhR?=
 =?utf-8?B?enpRbllKODd1dDNVdDkvVHFkOUEyS2M1dUFXbm1xWlViMXY4V1B4WUs2MVJK?=
 =?utf-8?B?ODFERHBEc0YzaUtWVkFsdjFOR2hNWFlWMEdCdXNFMGc1WWtOSGkweVYwYmVQ?=
 =?utf-8?B?eTYzSzVUR0crSGdveE5SaGx2eG1BWVdpaXF3eXB5VjBmZzZGYnVib2lPb25r?=
 =?utf-8?B?SmI5ZlJMaytiQlBid0xjRGNKZk12b1V3UEh0YUNuVjhhRmFhMGpNckJXczdk?=
 =?utf-8?B?K1F0bXovUGhMSlRWZThPNlQ1MGU3TFNmVE5NUElDRktuVFVzVlpvcVNtczcv?=
 =?utf-8?B?SDhSWThCa3hGKzV5WWtpMm5GSmw3aHJBcWViZElZT0pLRkdPc0Z6c2NYZkJy?=
 =?utf-8?B?VFI2NytpSTF3eHJSYzdYb2JMR1NNbTVDRXlqVGx0eXBCSHJWSUt1azFSSnIv?=
 =?utf-8?B?eEkwRyt0c25UZXVuL0llMGczUXJqTnFPWFl1SnYvdm5SaExpM0d5Z2NjcHVL?=
 =?utf-8?B?bm91ZjJFcndIUEZTeTRwckRQR3BFMnZhYzBwRjNJQjB3aXJuMjRnS3YxV2Vn?=
 =?utf-8?B?VUdnREhKZFBsM2tBQTR3MmFKa0NVSjM4Vks1bjhRczVwNjQrVHRkTEZMNDZX?=
 =?utf-8?B?LzlINE9IK2dpMW9MMGNFZk11UXlsVThtUm92WDFMdTFSTURkSEZXdWRLZEV0?=
 =?utf-8?B?UDZGcGl4cmJ0OVBuSzNIWnJwakp2ZUxDVURaZllhSDhJckQ1bXl4QWxWeHNu?=
 =?utf-8?B?akRTYTN4U3k0VmZ0OXE2dFB3NU5ieGFkcFZiNlZoVHJTQjM2K1JESmtvMFFi?=
 =?utf-8?B?Vlh2V3RXZXIyMXRRbVdoNW4rQ01FdlFqeGJ5cTJWSC9mcS9YcDVqVHByelUv?=
 =?utf-8?B?bjU5MitZRGNaeU9KOUFUOXJZOXJuajNvYlBCZXNPQ0hpY3BvOUJjaHZpNXFZ?=
 =?utf-8?B?N29kSEFrSlBDaS9jV2ZpRUJ0d1FwZW1kekxvcWRLMnRrS3VPS3ZBNUNvdzJM?=
 =?utf-8?B?eGpxK0R6anoyNFJSRjhaN3VzWWZYRU1iSGltanhZdmVQVk5kNnk1Y2lLTEtn?=
 =?utf-8?B?ZDc2NlZ3blh3dU5ibXRXVGhscW9YMHlpekdJN0Z5TDhOeE1sYWhtbmNQdWJp?=
 =?utf-8?B?S2JHUnpSTVRxc3k4VldHN28vZGN1OXhaV1JXU3h4QXpsSm1OSXhKZlFVMkxF?=
 =?utf-8?B?OFpqdStGM01HUlhlUWlJdTlmS283cEZqQjVFQ1gvSW5OMXFRcld5bjR3a3gr?=
 =?utf-8?B?SUZyZUVXRnFRSko0MnlsbEZaVmRuRDlBU0FjWEIycmI0NUtLYnZvOW1Zdldp?=
 =?utf-8?B?MkhLOWRnTVhqd3FMTnVzSy90WTZNT2RoTDNQcFpKNlN4ZlJrMUFRZnYxTFhy?=
 =?utf-8?B?anplR1g0dk9KUHpHeGRhdElNbE1FTXVYazBtR0p4bWlpRHo5S0owMlNGOEhV?=
 =?utf-8?B?d3Y1UVhwd3hxTDBIb2UzbnF1bG9uYUJiUnAxTzhsWHBOcXp6SWFCMmUxQkdH?=
 =?utf-8?B?aWEwTHd1WFkzQlIwK1A5MjVtWWQ2NnliWHdzeDlXT1NsdjFFdzdFb1ZYUWk1?=
 =?utf-8?B?VHllZFhObGlMRzNTZGt1UkZuZVVINm1NODhZV1pEbDFOaWg4TGp4NkQvenJV?=
 =?utf-8?B?ZVlOb1QyVVZJTzFvd3pMbDduZGF0TDJVUFBzakl4V2p1VWJYOHgvZHJxUVFN?=
 =?utf-8?B?cWttUWxralo0SlNnRUUrV01CVmtnUStBMU1aQS9rczRZUkZxRUdqdDkvRnZk?=
 =?utf-8?B?blBhc2Nadm1McERtR2RVSEdMNkJMR2IvWVJLd2w0YmpCd1VUb3prZnhib0p1?=
 =?utf-8?B?eXRLYmlBMzNlTW9GVUt0UzU4UGE3UG1zQnBSb0F1QU1QYWVENHFPdzBpS3Js?=
 =?utf-8?B?aWVRWCt0UUNBcDh6dmRHakpvenRJYXpyRGJFdmRLUkpIZXB3OG5vb1hEa1NT?=
 =?utf-8?B?allPUDJkNnFwbldsWFkxeVpUSE9JclljSVNQZXl3UzlBN0JHd2FXb2V6bzZU?=
 =?utf-8?B?SElGT0ZheC9rSTFUS0JXZFY5d25kbld0ZU1Kb2h0M25QWjVRUHJQMHVCVmFS?=
 =?utf-8?B?MnJxZWZlN3N3U0U0RVcwTjNuenFRMlRoT0dGQndFMUJwZUVRM294VS83cjRN?=
 =?utf-8?B?OWhpMjU3M2pRM005eXkyd3c0bHdzVHA3bWVIK2J6SkRxaG5EdTJ1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822bc758-e393-44cb-a084-08df3aacfbd1
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 19:51:14.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBX+DzO0pQNmIxPc3z5hKJ078Iob6Ej70eoLiadXv/icPijwD2GoGCvxvf0JQdrTuDbiZY/EtXL2MpgrcV3sQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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


On 2026-11-04 10:52, David Francis wrote:
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
> v2: Don't use checkpoint ctl_stack_size
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c                 | 8 +++++++-
>   4 files changed, 17 insertions(+), 3 deletions(-)
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
> index 4c4a3a8587f46..6e19be9e89f57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1095,9 +1095,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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

I think kfd_queue_release_buffers also needs another parameter to tell 
it not to handle SVM. Otherwise it will call kfd_queue_buffer_svm_put 
and try to decrement queue refcounts in pranges that weren't incremented.

Regards,
   Felix


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
