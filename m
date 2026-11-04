Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA2606B2C2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JOYi3L81
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949DB10FE93;
	Wed,  4 Nov 2026 19:49:13 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B36110FE96
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Sag7Qq7C6WVYTJX+hols2T+a3/LXzbVdbAYOvptQ//Bl6J91U8ZTPKkPP0n1Y7PTGkxx/ICGQf3jzTZh6OVaBaMHVjt+uWhe0RIbTl1FWUpt0/veHudDN/CiBN+9Go5jpICu9UZjdQDwN8QxmA4P5I+it7UCLhYUcDqcBlE9TPbLlkn2MMMu8EgHTRyzcAjU2QQDS812ryJIWEdtCcAniJXBiH0wzVDzIcSdxoCkenqsQvpSDfA2aA+fFtU8WGhNto+AO1rnAkg/dSiJyWOscLN/tsFqYqimWa3BmuDhC9LkjbpiNLwYwz4pfQbCvgIckLKim2EE/0useVrWYonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX+PPubv1mocblhLTSEpSV9mltsuh5YvLj/7ASWthmY=;
 b=wALbyLSXvBrYZM/eT8BgE9VySYWBNkfNgEVUJG0I1BhULyf6+0xv00lyNpNdwVt65Qw6kc+iNBuJmieQwhM6F3A1o5yC2TXodpZBl21dnzeC1wY1TONt8cvI732YsQtQlAbgm/qTE77rmugyq3WvH6rYPZAMJvdXN23Wn5W1NwunqpfRcihSoHOc1xrC90f+vkCZdETTrrUH5WdoEeg94Z6ByKL4RyCDfKgX7lAm023ijDts8s6DDo1qdtpNJTPy/TaW0Aby39d3be1k9cmrs6FGD6uXo2EXNCgRZCibhOaHynJdAVnYEH+gfKlKkegkjhgyyeMt6qQY71LWl3Edyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX+PPubv1mocblhLTSEpSV9mltsuh5YvLj/7ASWthmY=;
 b=JOYi3L81vjuYfJt59TBB+NYMmpaKh2UuRJjsImKFtl0Ix9pX5SnjoX5GUPpiy4BT1LSs5pm7bHXwhIwg8H2crF2lQ5j++dqZ3ZEEXvh+W3JzKVqoKzmA8VxGnORHdILb8ZsGw/lnygLsMHNLWif6oDDBIjsRIr7nn+xNrDWTbtc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV1PR12MB999303.namprd12.prod.outlook.com
 (2603:10b6:408:2cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 19:49:04 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 19:49:04 +0000
Message-ID: <2aa224ef-a7d9-4c8a-aadd-ccf42f351a1d@amd.com>
Date: Wed, 4 Nov 2026 14:49:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdkfd: Acquire cwsr buffer during CRIU resume
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261104155203.3826257-1-David.Francis@amd.com>
 <20261104155203.3826257-2-David.Francis@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261104155203.3826257-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::14) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV1PR12MB999303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a10e317-4349-4b55-b77d-08df3aacae12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|4143699003|261102123227099003|11063799006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: dgWtfPrxTEyNHKPCe9jcHNqm10L7Zd7v0M5C/+nMlcHQ4CbnRBI7Ii8eQS7GYivdsWNyc93LaTGNflf9VBUm8CzeHuYqmnCm/YNVfM/PsvCv2pOJTwIu4VNBgc1oShTh64WhZip0esK8f3b+j9nZdMHbk6ZiCgKfEB92H3KqONmZsvf4Vc7odQmhwYli/LaAUtNKKcvYphZqc5qXUjmcxFojz5IsFunDvQk0CdKKO0R03KAgdFZRG3XzkdRrpei8y+8sO2n6ecYxYGX2jA4RcTUYbUzmVhkhXNbsi4Q1Jk6QXX7TtQLazgNcJ+az4kWc7RAX0GDDk/AbT1EReuXe2C5EdaR/1l+Xo/tRq7DDyCz2hvmdm/+Ng5nsP8G8xbapQxD8+99K+WpkF16yhetNvzEMqw2AYOTSqvFZ9x4SrQIomCFr+oWpSnYJQ+5zhPbQpFIwciCFqK/hB82X5ici9IkKQw9vNy2qMc/ScrJhc9Wl8wVkfJVPW0TQN9GAmjXrhxJCKol7Tg69o5RiI9h4cCschfifaQkZ74HT8tMFPfbC2J0w8I59vVVs3wwzWGAV8AX0KEN8fBbkblTI2zpV5AhTPa9TwuoYDRb5lqICm1eE99AVTunKesxjYZduO1yWR3REuE3x3DeudJSlpv/nLK1UiZfwZUPABned2+uj+TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(261102123227099003)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lYU2dhMmxZSjhwbkx4SHVZSkpwaTlEckNHSlVPcGRCRlBWZGk2Y1hMYnU5?=
 =?utf-8?B?K25XZVVvK0NVWmtKOU5BbEdYRzlGcGhaejVXZ0lMYmcrSUVCMzhKVGtpNlMw?=
 =?utf-8?B?ZXZueWh3WW12bWVCUkFhNzlJU090TFNGdzUyUTVJVFNIeTBIRTZPWllLTVRY?=
 =?utf-8?B?Q2U3aEdGODJLbk0rb0tpaHprTmxDZ3hwaUhWYzVTaTBpTUlXVEh6ZFBEdkg1?=
 =?utf-8?B?RzRlQjJiVDZnT1lGNUNwd2MzWXlpY0pTaXhWSnRaV0FSM3QvaUpORTIxb0x6?=
 =?utf-8?B?ZHA4ei85SGxscHpqY2tkSUdFNnR1ZDJOdGJKaWRHVWdobGRXalRDaC8xcURS?=
 =?utf-8?B?YVdHbERVRTBvUi8wbi9xY2pESFhma1RmRzRlK29LWlZCT3hqMmZ6NzNPRFNL?=
 =?utf-8?B?QTR6QnEzTCt0VkVUQlVJNzJMRnQyRWpzeldSMlg3cVJ2bmdEZEN3MmxXcDY4?=
 =?utf-8?B?MmluM3JsZk51Y1ZWc0RSYjJSVHE2RXZCS2Z3UzlwaDFVT3FTeXlBVkxaaXZG?=
 =?utf-8?B?TWZ2VHJMUTVCb3dRRmorMmVoaUZqbFltSmFyNzFRd1k2a2ZmVnNPVjF6VjRt?=
 =?utf-8?B?a2VyMW9sTmhNLzFQV1ZEdEpQNFJMMUUvMFpJNDNoRFIySzJWWFVqK3dkcE9N?=
 =?utf-8?B?a3RmNzc3SUszaTE5NzVTZExTZTBUelBwM3BvcnFYbnY0R2d1YkdxMUFQMk9F?=
 =?utf-8?B?cWYyQm9ocFY1bEtYU2swMDFkbXNnZ3A1NThnWXZpTGc3bVNGUDNGaTMyS2o2?=
 =?utf-8?B?TlNQeW54ZjhSV0hzQUszK1pvdHh2Tk44ekVSazZyeHJDb1BYWFZWWkdpWEp0?=
 =?utf-8?B?cldiOFViVEY4TjY4b25DelpiZlBKS1JiWWVBTE5Xc2Q5cExCL1hsUmNZdG1W?=
 =?utf-8?B?c0lNTHVyOWZXZ3JwK1AwM3B1eDNzMndsYXNQUFJGQ01Ga3RNR3pnVy9qV2Zr?=
 =?utf-8?B?NmpQcW1vaFIzajE2WWlwcGl1V1RFenJoazRmcG5CdzRuNXROQTBZNHkxVHNV?=
 =?utf-8?B?eFVmT2l0cllqc1Rrc3dUNDNtOEtUYWtMSUxSclVwdkZwenVKM3UzN2pweVlJ?=
 =?utf-8?B?SGJNVWlJTkNTRzNKTmlWRngrZ1NLdjdiVE9SZEk3SFA1TnB6dUhtSngwUW52?=
 =?utf-8?B?NXhtRTA4NzN1SjluT1NYL1ZLU2RCTkNaMjB3bHVFUVc1ZVA3Q0VRT1JpRE1J?=
 =?utf-8?B?YlljVGdOTG9uSUpaSVpBbnFPWVJGMUtuQmttQ0N0a3IrUkszZzRPa212ZWNw?=
 =?utf-8?B?ZXpTOXFzdnJHbFFuemp0aHlzeUdVYlFZd3dSN0Rlbmt4VjFVWDFsVHpoRXRM?=
 =?utf-8?B?QS8wSWx1S2FuV1I4cVA0TmZyYmpNdVNRWU5Iczd6QklvcVNLUFExRjJvTGh2?=
 =?utf-8?B?Ym80b2R4OERKaStYQ1Zteko2WGdjbm1OeEZySUJneHhxRWZOdjRqQVJxaVdN?=
 =?utf-8?B?QWVFWXZUNFNLNGU2NVllYlpMNmFqTnFSUDZFUzhKQVpxYlVnYzJYSk9ySjVQ?=
 =?utf-8?B?NXByWlI2YXVNMXZhTlkyS203TFh5cXJFVzRUTHB1OXhYcmpDdUVlRUU2bG85?=
 =?utf-8?B?emdzdlJVL29ZN2g0VGtFbzFESFZuNDFLYVZTTDZrOUJMYjQzdGQ3V0xFVVAy?=
 =?utf-8?B?bVduRThwWFM5di94VmpBWjJiQ0JXcUY3UHN5dDI3VitKQzMrOUtXeitFK2c5?=
 =?utf-8?B?OU4yUDg0MUxOb0I2UGROT2xaaHZiN1IvbjNadUErZVIwY2ZBcHRFTG9SL2Nz?=
 =?utf-8?B?YWg1WmVsMzNvdUV6YTNQdUZTdjQ4WlU3clpZa1Nha1h5dlBtYTVJaGlZWnJT?=
 =?utf-8?B?OStpb1hRUHZHREphd1RFS3F0QVcrWlZBMVhaenl2UmMrRmdLV2NBSFlaR0Vr?=
 =?utf-8?B?cmNYalJDajNRTytFMTlIQWUveFNnKzZzbGNOcWhqVVpyTkYzaHlWVk1TM1RJ?=
 =?utf-8?B?aG5XNElWcjMvaXgwOVZ5UlM5OFJuS2pic2RCY2RNbnluNTcxNGI0ckNxUlJQ?=
 =?utf-8?B?dXJPbHMxMjBjcXhtckovbUVneUdJRzROSCtQdFVVdTFYc3UxVE1aQnhkOWtD?=
 =?utf-8?B?cHBWay9GQnJ3T1ZYOFRxWnlxNVlEMk5vYUZ0VklCUUpSS2x6NkVkNlRVaW85?=
 =?utf-8?B?ODE1aE9rb2d3VGQxMFY1c1JvTDBmcDNrVHltMy93d1dPL3EzNHJrc2tpdi9x?=
 =?utf-8?B?OW9Gd08yR2w1ZnRTT3Q2c2w5WFh4RDlkQXJiS210bzBRUmpJSTg0MDc2ZUU2?=
 =?utf-8?B?ejlyRVZPRkxFSmJCSHREbzhLVStlKytDNGxFUklLY25QVEp4Sm13YWJ6SXlC?=
 =?utf-8?B?emRSUXJ2blFNRkJiSnJJcW5xeU52aGsreDRMUEVMOExmMmFYOGs2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a10e317-4349-4b55-b77d-08df3aacae12
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 19:49:04.0366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 981ZJtfi0hA5uQo7UB0CIDCUWxeJqYCac+SgXgGl3Y6rhuhldgJR7iK/pXZwllPq2DuHivlrL+a09uaKOHX9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999303
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
> In normal kfd queue create, a reference to the cwsr svm range
> is acquired so that this buffer is not freed from underneath the
> queue. We weren't doing that.
>
> After svm ranges are restored in RESUME phase of CRIU, go through
> all the queues and acquire a reference to the cwsr.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 28 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +--
>   4 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d8233337b8d5e..6094a6dfdd90b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2861,6 +2861,8 @@ static int criu_resume(struct file *filep,
>   		goto exit;
>   	}
>   
> +	kfd_criu_resume_queues(target);
> +
>   	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
>   	if (ret)
>   		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index eb4d35a42e917..a502dc2f3c8a0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1371,6 +1371,8 @@ int kfd_criu_restore_event(struct file *devkfd,
>   			   uint8_t __user *user_priv_data,
>   			   uint64_t *priv_data_offset,
>   			   uint64_t max_priv_data_size);
> +
> +int kfd_criu_resume_queues(struct kfd_process *p);
>   /* CRIU - End */
>   
>   /* Queue Context Management */
> @@ -1387,6 +1389,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>   int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>   			   struct queue_properties *properties);
>   void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		struct kfd_node *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6e19be9e89f57..90e6cbb9cd2b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1124,6 +1124,34 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	return ret;
>   }
>   
> +int kfd_criu_resume_queues(struct kfd_process *p)
> +{
> +	int ret, i;
> +	u64 total_cwsr_size;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct kfd_topology_device *topo_dev;
> +		struct queue *q;
> +
> +		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +
> +		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
> +			total_cwsr_size = q->properties.ctx_save_restore_area_size +
> +					  topo_dev->node_props.debug_memory_size;
> +			total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);

Compared to kfd_queue_acquire_buffers this is missing a multiplication 
with the number of XCCs in the compute partition. With that fixed, this 
patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +
> +			ret = kfd_queue_buffer_svm_get(pdd, q->properties.ctx_save_restore_area_address,
> +						       total_cwsr_size);
> +			if (ret)
> +				return ret;
> +		}
> +
> +	}
> +
> +	return 0;
> +}
> +
>   int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
>   				  unsigned int qid,
>   				  uint32_t *mqd_size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 18d24ddb455eb..78de556da056c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	struct kfd_process *p = pdd->process;
>   	struct list_head update_list;
> @@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
>   }
>   #else
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	return -EINVAL;
>   }
