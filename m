Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CECC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA6613A5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17BA6613A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788B189AC6;
	Mon, 23 Aug 2021 18:29:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AD689AC6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 18:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsMM4nvXdQx5bfV22TBSUjycnNaZdoiidXOxWycMOI8ykykrSMNfz6m+L93MkqiZ/C9B5Wh8KwhLMa9/y2bi0vOHgW223IhBNg4S++FXCvDGMhEQ3G4xESQ29KfpXIcZl0dcZ1oth+0G0dP1usKNMSSsRLVprN2uiHtIxZJ4zrTSLZLcG/FYPxUQS9bLmXab6ranJbBtmDN/UJdNJ7R7XSrmmj/tmMOnakFoXb6zZPyPXH5xBYlaCBnBPTn4T29/rxlUSzAnkuJ3bvE0X6M5sKGmAEJr7HovflbR1q3Lq2S8/Tn9sYuW8ES4JoxW8RsIR9fbiycM8WiYScZcUGUDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaP9KceSYXUf2/+3imppTZGmDmeT5lyk+6QgZtBEkgg=;
 b=KW8Npvj8LzvXij3TFnkZ3EFwXLDrbUHz8pK/VGx5KuM7TzVweHc6xj13C2SGOVblJLQxx0MuMy0mu7FP3jX/efa6VvDpPhvUTmWna6sk8Ns+zliC6413jtQo4TUDOBdwwuYSm4j4+120jAFSZIacjcK0DUR7NIyyxW3HonhepZVqQR3O3kH/FsBsCLry21FIGdK7if5DNj7UvTb/xgRAgAqefzyGbQSfKIxrsI45Jg88qiqJiLnLqUAH1ZpA1i7tFKEIYxMP7/U7nQ9dKRzA+PuzVMWLwvbEoLK4zLccNSerVbvlpzw0RKEPx50Rw5UvQUay0m+grsTUEo3mcZOKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaP9KceSYXUf2/+3imppTZGmDmeT5lyk+6QgZtBEkgg=;
 b=dQ87z/zzuW+E4h7RUCIXIFp3fg+chGLExPpvZrVyi4PDl0gChC3n/peVIxjMfAJmkRw+b0UYgBQJPkW8ZMhX6KlPclZy6ZkJu+LbAhbtvODby/uU6q0kcmcX0m9Hm3mVZt4pKFTkqZFDuAxwaQXwSWbEalP1gqejm/luP4qOI1E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:29:25 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:29:25 +0000
Subject: Re: [PATCH 09/18] drm/amdkfd: CRIU add queues support
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rajneesh.bhardwaj@amd.com
References: <20210819133713.4168-1-david.yatsin@amd.com>
 <20210819133713.4168-10-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <81f93ef2-99c2-c21c-75e4-fa10ded5ca7d@amd.com>
Date: Mon, 23 Aug 2021 14:29:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819133713.4168-10-david.yatsin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:29:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b19c902-03a6-44fa-6686-08d96663ef8c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52908CCFA441E9B9D7411E0D92C49@BN9PR12MB5290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lqXx/X11EW51Io4QiqZB7eRldmYCZjfL3uZ9ztAKKdmb7IKzpLZuutyAxThcqSayVbMQXEvt6WVe998nWJJJA9NzP+JBIP9w3Q7ipJu0e8CNKOOJ9yRcGpJc1VV1bhVjlcwUEMXwahEO3yrBa8fbW0kyGJMk6Xh97dKwyHnZJlytqSzpANZ/Q9ta6tMkCHAIpMJubzoHX7MJuqSXM25fn/ELh0oTC9E2r61tFx3yZZ6T4UFM2DtwARD8XPbPrvHQhqJVv9fGM4kYJ9PJChEB65i1EoUuE2hEErfzet7fbMDSSmiAzo+sWxSwNYhygSTTdZhB8CD9FapNhz0W73TIDihn3eOA0eBmClySWOYcvoQDSylXm/Fri7hZGkIJzukkBC86/8gowRcpDpQDk1oZx0YaxuDHvaaCgyluCawY3IoTj60PDRBAwvepeE+GolCWQmEIgL6kfA1I1DDvZmu3jX420QIPuMAAmigqlogPY11uTufC1RaR3pB9eDIAGlPinkwGuanic8grlbUQrMF/y4qFfnuUWNt2fmBkWWq5UkREISJJ7qfIQaz+IJxvY6BD/ed8Gbn/bJ9ZxnCam4j952QSyBT8RbKC+6AtxZ7Ai1i48yASyiV6fW/2msQ01O0YIFhO0e5ZEIxfUXI59Wfb/F9yDO82ZMGqgKdswvu6ftgcQGw+IPyGM/BxhPzbw3gUdfk1tIyVx7uECDwj8eAu2wsn++Kd3WX/NhvHd1eBYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(66556008)(66476007)(44832011)(83380400001)(36756003)(30864003)(2906002)(66946007)(31686004)(478600001)(26005)(6486002)(8936002)(956004)(2616005)(316002)(38100700002)(16576012)(31696002)(8676002)(5660300002)(86362001)(4326008)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENWSmNxbGcvNGlHL3JaUkJ0a29XQXZUMGl0U2dia01ITzhQNlB5dDRTU1Fq?=
 =?utf-8?B?Y1NLQUkrU3dFbkhteDlldGJ1VE1BWGthV01STG9ZVUNxbXBtTk9Mc0xKcmVJ?=
 =?utf-8?B?dm54L2RXVDF6VVgxNWl0VTJhNGc5OEx3RTRhVEZLbWNtSkdJdHNUNGVsbzFi?=
 =?utf-8?B?YUU5T29XRTdzWXdwK2pGQ2hUVnd5S1NmYkNkYzYzeitKZDhBc3pkMWJ6UnhY?=
 =?utf-8?B?ejlPdVczTG13MW5uREF3a29VcEhXKzhNdHI3blBFNmNwOFU5WFd5T29RUW0w?=
 =?utf-8?B?Wkllc0IwZndrQldwNnVxN0hOSlpJaXhwTnNXQWpWYi8xNUdSTWtxdUJFSjNz?=
 =?utf-8?B?TUlGRDBzMmhLb0thTE5vbS91ejh4Zm96ZmxGWVdzK0V3TEU0bndxNm4yQjZ3?=
 =?utf-8?B?Q0ZtYWh4UUxjYzZUdWVseEc4SFo4UEJUZmRPL3JWcjFYU0E5eFZ6L0VnN3Rm?=
 =?utf-8?B?V2RKRlJCUy9FbFJCN0V4bld2dTEzbXArWk1MNlhJdDhDQ1ZieThST2FGTndl?=
 =?utf-8?B?S29wYjFmUHBPaHdHOTNQTjJDSk9LS294K3ZtVlY1eTNSTzhlUUhSSmhpcGJJ?=
 =?utf-8?B?TllEUlJBbGo2ZENzb245dkVSNFZEdGhqVDY2WHN6bDJjOXJlNEo1ektkZldr?=
 =?utf-8?B?NXNzdWtUSG1jSnVoenVDZW8wcVRnbzZuQTZBdnd3WEpMR2VDSWxhUHpBSGdL?=
 =?utf-8?B?YUl4NEdjYURrOGVpM1hjUzJmWHVRWW1STGVxa0RNMXloRnF6T1ozY2RDTkIy?=
 =?utf-8?B?UzBpVjVYRlRXajUzZVkwVHNpb2g4aWUyZzduNE9TbXdxK3Z0VDk1c1NSbk5p?=
 =?utf-8?B?UU5rMFdub2xsQW45NFNCSkFoZitpUUREblRaRkRQOGxVVUh3b3E1YnVZbHJL?=
 =?utf-8?B?dE1VMzc3Vmk0QXJEcS9pRzZab0F1ckZrZGs3RUJmRTFLQkNwekJBWWluNjZQ?=
 =?utf-8?B?NkU5TnpJVU9kNnlnVmxSZUdsY0xsNnQ5STdxazhaVjRTYlNLL1Y2dTFxMjI4?=
 =?utf-8?B?L2RUdkdhNFNsdk9DbFVHcjQ5eERwekttM0xWUDlpMmVsQ2s2QUlzL2tFNytW?=
 =?utf-8?B?RWRzWmpXQXozSVNwM1FyNDJieGtlMzQ0QzZ2MldiRWZ1QnliNWJVZXI5cm12?=
 =?utf-8?B?WlRUSEsyaGtTOGRHbGIvODRDajBkMm9CbFhQcWRHb1N3Y3hhUGdEUFB3aG9B?=
 =?utf-8?B?Nll2T0xFcmhiN1d1L2QxN1oyUWIvZ0M3SXRZZ2cxQWNvK0ZrNzliQWdtTUVp?=
 =?utf-8?B?bysxM1BCUzZxWnNhazVJTGVVOTU4dTJuN3FERXZRcHl5R3ZNczU0b0Vva29M?=
 =?utf-8?B?L1lJVDBwTFd3VFhubjR6QXR6cEQyb2M1M3d6MkNqSXdCc0VuTThGRTVyaVRW?=
 =?utf-8?B?VGhqQ1ZpSkVkSFRUU1ZZQ2FKd2N6QVVRMGRFR3NPb25GNFhUUzV1YlRGdFRU?=
 =?utf-8?B?c2w0SmI4RDNEYStYSnU5Nm4yWVhHSEJCdjU5UXpMY3ArNzByczk2SlZBN3Bu?=
 =?utf-8?B?VnBKcE1JZ3hDY1V1R1pndFdJcGg4eWpLa2xNcjhVZ1FnenVkcFZwbDBkVWNn?=
 =?utf-8?B?dzN4V0hYZzA2aVVReHRYUXc0QkJNVHoxMGRZUXE3RXlBaHlxc28rSllvdDJS?=
 =?utf-8?B?dWEvQkl2NGpPaXlxY3BTYmlMTlRHSFdkY0NuUkd5VW5wVTJ4cTJOb2E0cWRM?=
 =?utf-8?B?TTdBSU1MeXJNT05KTjllVXBBQnBiOVFaMk1iaDUra1QxZVRvRjVQWHBxVHhQ?=
 =?utf-8?Q?9jqq0PvupZq8lMHFJkcf2hDSBrW/0hsT2OTId65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b19c902-03a6-44fa-6686-08d96663ef8c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:29:25.7641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIFvzl6sXg3TlpfdT4DgSWzt0WNrei6Z8yf9Cv3qNAQVk/8Y34TP26aGyJiVMDYPQagISlR4LM+o7hv3lemQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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

kfd_chardev.c contains the ioctl API, but not the whole implementation
of everything. I think it would make sense to move the criu_dump_queue*
functions into kfd_process_queue_manager.c.

Regards,
  Felix


Am 2021-08-19 um 9:37 a.m. schrieb David Yat Sin:
> Add support to existing CRIU ioctl's to save number of queues and queue
> properties for each queue during checkpoint and re-create queues on
> restore.
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 380 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  22 +-
>  2 files changed, 400 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 24e5c53261f5..6f1c9fb8d46c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1965,6 +1965,213 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
>  	return ret;
>  }
>  
> +static void get_queue_data_sizes(struct kfd_process_device *pdd,
> +				struct queue *q,
> +				uint32_t *cu_mask_size)
> +{
> +	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
> +}
> +
> +int get_process_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t *q_data_sizes)
> +{
> +	u32 data_sizes = 0;
> +	u32 q_index = 0;
> +	struct queue *q;
> +	int i;
> +
> +	/* Run over all PDDs of the process */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
> +			if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> +				q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> +				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> +				u32 cu_mask_size;
> +
> +				get_queue_data_sizes(pdd, q, &cu_mask_size);
> +
> +				data_sizes += cu_mask_size;
> +				q_index++;
> +			} else {
> +				pr_err("Unsupported queue type (%d)\n", q->properties.type);
> +				return -EOPNOTSUPP;
> +			}
> +		}
> +	}
> +	*num_queues = q_index;
> +	*q_data_sizes = data_sizes;
> +
> +	return 0;
> +}
> +
> +static void criu_dump_queue(struct kfd_process_device *pdd,
> +			   struct queue *q,
> +			   struct kfd_criu_queue_bucket *q_bucket,
> +			   void *private_data)
> +{
> +	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
> +	uint8_t *cu_mask;
> +
> +	cu_mask = (void *)(q_data + 1);
> +
> +	q_bucket->gpu_id = pdd->dev->id;
> +	q_data->type = q->properties.type;
> +	q_data->format = q->properties.format;
> +	q_data->q_id =  q->properties.queue_id;
> +	q_data->q_address = q->properties.queue_address;
> +	q_data->q_size = q->properties.queue_size;
> +	q_data->priority = q->properties.priority;
> +	q_data->q_percent = q->properties.queue_percent;
> +	q_data->read_ptr_addr = (uint64_t)q->properties.read_ptr;
> +	q_data->write_ptr_addr = (uint64_t)q->properties.write_ptr;
> +	q_data->doorbell_id = q->doorbell_id;
> +
> +	q_data->sdma_id = q->sdma_id;
> +
> +	q_data->eop_ring_buffer_address =
> +		q->properties.eop_ring_buffer_address;
> +
> +	q_data->eop_ring_buffer_size = q->properties.eop_ring_buffer_size;
> +
> +	q_data->ctx_save_restore_area_address =
> +		q->properties.ctx_save_restore_area_address;
> +
> +	q_data->ctx_save_restore_area_size =
> +		q->properties.ctx_save_restore_area_size;
> +
> +	if (q_data->cu_mask_size)
> +		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
> +
> +	pr_debug("Dumping Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
> +}
> +
> +static int criu_dump_queues_device(struct kfd_process_device *pdd,
> +				unsigned int *q_index,
> +				unsigned int max_num_queues,
> +				struct kfd_criu_queue_bucket *q_buckets,
> +				uint8_t *user_priv_data,
> +				uint64_t *queues_priv_data_offset)
> +{
> +	struct queue *q;
> +	uint8_t *q_private_data = NULL; /* Local buffer to store individual queue private data */
> +	unsigned int q_private_data_size = 0;
> +	int ret = 0;
> +
> +	list_for_each_entry(q, &pdd->qpd.queues_list, list) {
> +		struct kfd_criu_queue_bucket q_bucket;
> +		struct kfd_criu_queue_priv_data *q_data;
> +		uint64_t q_data_size;
> +		uint32_t cu_mask_size;
> +
> +		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
> +			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
> +			q->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI) {
> +
> +			pr_err("Unsupported queue type (%d)\n", q->properties.type);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		memset(&q_bucket, 0, sizeof(q_bucket));
> +
> +		get_queue_data_sizes(pdd, q, &cu_mask_size);
> +
> +		q_data_size = sizeof(*q_data) + cu_mask_size;
> +
> +		/* Increase local buffer space if needed */
> +		if (q_private_data_size < q_data_size) {
> +			kfree(q_private_data);
> +
> +			q_private_data = kzalloc(q_data_size, GFP_KERNEL);
> +			if (!q_private_data) {
> +				ret = -ENOMEM;
> +				break;
> +			}
> +			q_private_data_size = q_data_size;
> +		}
> +
> +		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
> +
> +		q_data->cu_mask_size = cu_mask_size;
> +
> +		criu_dump_queue(pdd, q, &q_bucket, q_data);
> +
> +		q_bucket.priv_data_offset = *queues_priv_data_offset;
> +		q_bucket.priv_data_size = q_data_size;
> +
> +		ret = copy_to_user((void __user *) (user_priv_data + q_bucket.priv_data_offset),
> +				q_private_data, q_bucket.priv_data_size);
> +		if (ret) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		*queues_priv_data_offset += q_data_size;
> +
> +		ret = copy_to_user((void __user *)&q_buckets[*q_index],
> +					&q_bucket, sizeof(q_bucket));
> +		if (ret) {
> +			pr_err("Failed to copy queue information to user\n");
> +			ret = -EFAULT;
> +			break;
> +		}
> +		*q_index = *q_index + 1;
> +	}
> +
> +	kfree(q_private_data);
> +
> +	return ret;
> +}
> +
> +static int criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
> +{
> +	struct kfd_criu_queue_bucket *queue_buckets;
> +	uint32_t num_queues, queue_extra_data_sizes;
> +	uint64_t queues_priv_data_offset = 0;
> +	int ret = 0, pdd_index, q_index = 0;
> +	void *private_data; /* Pointer to first private data in userspace */
> +
> +	ret = get_process_queue_info(p, &num_queues, &queue_extra_data_sizes);
> +	if (ret)
> +		return ret;
> +
> +	if (args->num_objects != num_queues) {
> +		pr_err("Mismatch with number of queues (current:%d user:%lld)\n",
> +							num_queues, args->num_objects);
> +		return -EINVAL;
> +	}
> +
> +	if (args->objects_size != queue_extra_data_sizes +
> +				  (num_queues * (sizeof(*queue_buckets) +
> +						 sizeof(struct kfd_criu_queue_priv_data)))) {
> +		pr_err("Invalid objects size for queues\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Queue private data size for each queue can vary in size as it also includes cu_mask, mqd
> +	 * and ctl_stack. First queue private data starts after all queue_buckets
> +	 */
> +
> +	queue_buckets = (struct kfd_criu_queue_bucket *)args->objects;
> +	private_data = (void *)(queue_buckets + args->num_objects);
> +
> +	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
> +		struct kfd_process_device *pdd = p->pdds[pdd_index];
> +
> +		/* criu_dump_queues_device will copy data to user */
> +		ret = criu_dump_queues_device(pdd,
> +					      &q_index,
> +					      args->num_objects,
> +					      queue_buckets,
> +					      private_data,
> +					      &queues_priv_data_offset);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int kfd_ioctl_criu_dumper(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
> @@ -2000,6 +2207,8 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
>  		ret = criu_dump_bos(p, args);
>  		break;
>  	case KFD_CRIU_OBJECT_TYPE_QUEUE:
> +		ret = criu_dump_queues(p, args);
> +		break;
>  	case KFD_CRIU_OBJECT_TYPE_EVENT:
>  	case KFD_CRIU_OBJECT_TYPE_DEVICE:
>  	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
> @@ -2274,6 +2483,163 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
>  	return ret;
>  }
>  
> +static int set_queue_properties_from_criu(struct queue_properties *qp,
> +					  struct kfd_criu_queue_bucket *q_bucket,
> +					  struct kfd_criu_queue_priv_data *q_data,
> +					  void *cu_mask)
> +{
> +	qp->is_interop = false;
> +	qp->is_gws = q_data->is_gws;
> +	qp->queue_percent = q_data->q_percent;
> +	qp->priority = q_data->priority;
> +	qp->queue_address = q_data->q_address;
> +	qp->queue_size = q_data->q_size;
> +	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
> +	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
> +	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
> +	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
> +	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
> +	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
> +	qp->ctl_stack_size = q_data->ctl_stack_size;
> +	qp->type = q_data->type;
> +	qp->format = q_data->format;
> +
> +	if (q_data->cu_mask_size) {
> +		qp->cu_mask = kzalloc(q_data->cu_mask_size, GFP_KERNEL);
> +		if (!qp->cu_mask)
> +			return -ENOMEM;
> +
> +		/* CU mask is stored after q_data */
> +		memcpy(qp->cu_mask, cu_mask, q_data->cu_mask_size);
> +		qp->cu_mask_count = (q_data->cu_mask_size / sizeof(uint32_t)) * 32;
> +	}
> +
> +	return 0;
> +}
> +
> +static int criu_restore_queue(struct kfd_process *p,
> +			      struct kfd_dev *dev,
> +			      struct kfd_process_device *pdd,
> +			      struct kfd_criu_queue_bucket *q_bucket,
> +			      void *private_data)
> +{
> +	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
> +	uint8_t *cu_mask, *mqd, *ctl_stack;
> +	struct queue_properties qp;
> +	unsigned int queue_id;
> +	int ret = 0;
> +
> +	pr_debug("Restoring Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
> +
> +	/* data stored in this order: cu_mask, mqd, ctl_stack */
> +	cu_mask = (void *)(q_data + 1);
> +	mqd = cu_mask + q_data->cu_mask_size;
> +	ctl_stack = mqd + q_data->mqd_size;
> +
> +	memset(&qp, 0, sizeof(qp));
> +	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
> +	if (ret)
> +		goto err_create_queue;
> +
> +	print_queue_properties(&qp);
> +
> +	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
> +	if (ret) {
> +		pr_err("Failed to create new queue err:%d\n", ret);
> +		ret = -EINVAL;
> +		goto err_create_queue;
> +	}
> +
> +	pr_debug("Queue id %d was restored successfully\n", queue_id);
> +
> +	return 0;
> +err_create_queue:
> +	kfree(qp.cu_mask);
> +
> +	return ret;
> +}
> +
> +static int criu_restore_queues(struct kfd_process *p,
> +			       struct kfd_ioctl_criu_restorer_args *args)
> +{
> +	int ret = 0, i;
> +	struct kfd_criu_queue_bucket *user_buckets;
> +	uint8_t *all_private_data; /* Pointer to first private data in userspace */
> +	uint8_t *q_private_data = NULL; /* Local buffer for individual queue private data */
> +	unsigned int q_private_data_size = 0;
> +
> +	user_buckets = (struct kfd_criu_queue_bucket *)args->objects;
> +	all_private_data = (void *)(user_buckets + args->num_objects);
> +
> +	/*
> +	 * This process will not have any queues at this point, but we are
> +	 * setting all the dqm's for this process to evicted state.
> +	 */
> +	kfd_process_evict_queues(p);
> +
> +	for (i = 0; i < args->num_objects; i++) {
> +		struct kfd_process_device *pdd;
> +		struct kfd_dev *dev;
> +		struct kfd_criu_queue_bucket q_bucket;
> +
> +		ret = copy_from_user(&q_bucket, (void __user *)&user_buckets[i],
> +				sizeof(struct kfd_criu_queue_bucket));
> +
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +
> +		/* Increase local buffer space if needed */
> +		if (q_bucket.priv_data_size > q_private_data_size) {
> +			kfree(q_private_data);
> +
> +			q_private_data = kmalloc(q_bucket.priv_data_size, GFP_KERNEL);
> +			if (!q_private_data) {
> +				ret = -ENOMEM;
> +				goto exit;
> +			}
> +			q_private_data_size = q_bucket.priv_data_size;
> +		}
> +
> +		ret = copy_from_user(q_private_data,
> +				(void __user *) (all_private_data + q_bucket.priv_data_offset),
> +				q_bucket.priv_data_size);
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +
> +		dev = kfd_device_by_id(q_bucket.gpu_id);
> +		if (!dev) {
> +			pr_err("Could not get kfd_dev from gpu_id = 0x%x\n",
> +			q_bucket.gpu_id);
> +
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		pdd = kfd_get_process_device_data(dev, p);
> +		if (!pdd) {
> +			pr_err("Failed to get pdd\n");
> +			ret = -EFAULT;
> +			return ret;
> +		}
> +
> +		ret = criu_restore_queue(p, dev, pdd, &q_bucket, q_private_data);
> +		if (ret) {
> +			pr_err("Failed to restore queue (%d)\n", ret);
> +			goto exit;
> +		}
> +
> +	}
> +
> +exit:
> +	kfree(q_private_data);
> +
> +	return ret;
> +}
> +
>  static int kfd_ioctl_criu_restorer(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
> @@ -2293,6 +2659,8 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
>  		ret = criu_restore_bos(p, args);
>  		break;
>  	case KFD_CRIU_OBJECT_TYPE_QUEUE:
> +		ret = criu_restore_queues(p, args);
> +		break;
>  	case KFD_CRIU_OBJECT_TYPE_EVENT:
>  	case KFD_CRIU_OBJECT_TYPE_DEVICE:
>  	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
> @@ -2368,6 +2736,7 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
>  	struct kfd_ioctl_criu_process_info_args *args = data;
> +	uint32_t queues_extra_data_size;
>  	int ret = 0;
>  
>  	pr_debug("Inside %s\n", __func__);
> @@ -2387,7 +2756,16 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
>  	args->total_bos = get_process_num_bos(p);
>  	args->bos_priv_data_size = args->total_bos * sizeof(struct kfd_criu_bo_priv_data);
>  
> -	dev_dbg(kfd_device, "Num of bos:%llu\n", args->total_bos);
> +	ret = get_process_queue_info(p, &args->total_queues, &queues_extra_data_size);
> +	if (ret)
> +		goto err_unlock;
> +
> +	args->queues_priv_data_size = queues_extra_data_size +
> +				(args->total_queues * sizeof(struct kfd_criu_queue_priv_data));
> +
> +	dev_dbg(kfd_device, "Num of bos:%llu queues:%u\n",
> +				args->total_bos,
> +				args->total_queues);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0b8165729cde..4b4808b191f2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1044,7 +1044,27 @@ struct kfd_criu_svm_range_priv_data {
>  };
>  
>  struct kfd_criu_queue_priv_data {
> -	uint64_t reserved;
> +	uint64_t q_address;
> +	uint64_t q_size;
> +	uint64_t read_ptr_addr;
> +	uint64_t write_ptr_addr;
> +	uint64_t doorbell_off;
> +	uint64_t eop_ring_buffer_address;
> +	uint64_t ctx_save_restore_area_address;
> +	uint32_t gpu_id;
> +	uint32_t type;
> +	uint32_t format;
> +	uint32_t q_id;
> +	uint32_t priority;
> +	uint32_t q_percent;
> +	uint32_t doorbell_id;
> +	uint32_t is_gws;
> +	uint32_t sdma_id;
> +	uint32_t eop_ring_buffer_size;
> +	uint32_t ctx_save_restore_area_size;
> +	uint32_t ctl_stack_size;
> +	uint32_t cu_mask_size;
> +	uint32_t mqd_size;
>  };
>  
>  struct kfd_criu_event_priv_data {
