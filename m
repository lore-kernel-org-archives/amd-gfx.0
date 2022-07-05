Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B2BC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 18:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C2D113E9E;
	Tue,  5 Jul 2022 18:48:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F84113E7F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 18:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX8fJ0XgPBy/a1BisEZ0GkKNSJsekDBvrOcgcZP1T3Kybfmpv+vRYwSURxjMh7dN2lf1Dzza+TSqMVJ+M8Yig2Ld9hnoY+LM4w2IHC2iIlVARhFN8kjfQLUbmSD+HOn+/sTJEuEiA1L5z98XqAvHcjd2adoF/og6mwIU76CbTBPuKkiMrdhlojSYiPmfCwEeibe0+4NoTPwsnvkmm5wiVC3rvP9LTFpvceCqdigcWgPYqcFNSu5EP50uiGtEPgVC0DMR5cEV61v1RVUVf+SGaSnz4dNukJb3n4CEfO6cyfgKe8+C23O75np8zJv6KePYrLjEr6UoKPks1PD8js6AQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruLNTsuNW0rja3hgkto550pu7n6YPPaKPwYjC2hZhSQ=;
 b=GgH6vHL6Xc7aM2DrlsuJM0pXphW7GkUrzQ0YGTlyYbck3+eQYLOfb3BYxWxl9xEUGh42mirKtg7TJbO9J2eUkYPJt3n86cCgHX6EwpxPvtl2qtkgoWbl71HL5oM8nQsOCVSB7xX81RHXu1YW7IqrualVLzjxBx6XR+8PDXIrWRYW2mDiHRKsoTZrQi84uFgYxuR+DgcbbsrNb6ncH7thSq6TBS/l25fJbzDTxA9Mjne66WHQA+ZZ/iYQ+f/s80yTJm4C5KovDoNLi3tyrjSNFTQ6itSUEf8npCzYCFUxEUFRuKYQnpCJUynS6AT0C1GxdjY9W2h3TVvAKrNMSc2/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruLNTsuNW0rja3hgkto550pu7n6YPPaKPwYjC2hZhSQ=;
 b=TnP6l1tQE0/ycJe3mueM0rk8X8tzHaD7PdqjLuj5TxETcL9ysXX6x3t3tskQXEDxXBLrAuaDGTPPfjWCm4s5YhUFnuhx5yjdoaYugBQNqIHvwAOpav9xyO/ryFst5Mj/G6d+/O218RuMS+KThi+HMCTpinciRN0mAMLP/btFTIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 18:48:22 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 18:48:22 +0000
Message-ID: <2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com>
Date: Tue, 5 Jul 2022 14:48:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Remove queue sysfs and doorbell after
 unmapping
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20220611010334.23401-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220611010334.23401-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::25) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab558b0d-5280-430c-583c-08da5eb6ef76
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5KHexp+bNy63/d1PJPBnPiVorBhPZZXx0qQidWKqal5ocdFj+D0bhtrVGTH9vJdtU4+rB9tZea8GhA+QZAHF4fKwdnEYdFLX9GN/+C/Rp4Runk+OeNt3vsum4TSG0iCIL+mLvEjJiFodyEJ7G7xL7rrDeDiACf2uQrc6OKJydLmZsCKpx5F0BmFkpBFLFbIo18mGgdmV+WPS4C2iXn+ddKquljJpfQn8UM3M6QO6CU03+qB5+Ah7FZjbgnJZZ7kr2HFb4S8P8CQr4gbIbiXHkFf4oJClOCY5nAjlfpCIaNVA01h1xTxPLcFKwr0r0J/lkMz+eBwPXkJRuMgteqItx8FdoB19m++yuLMGmkDQ56jXv0qAO5JYxi56jIyr7o67jl6OYOukINeASdHePMoW2o4nP9NLaPbFmQ9B9sYnQCfBUtBlCzWMLRM9Z8DhXjoU0IO4Wq1SbJwEP6C4IWTaISmPKQi8c2IYuMYPXVH81RZwbcEjHAXEVW6ZnCQh9AlVdIdXhBEawwO+34pEKHKhvg/8n4nxMQW6kvaaz6PRM99B8P9mHF97tprBYp6dc6xqgfYnGzuAxQUkO+qUWBesgJIeIjHfZK2BClWJ9kkQ0bBJh/M2Vs4hUcw+GK6iqybbsQ3xGtambbxjYZJYO2d9/CvxbiwceA2Yt9Y4N15dVXZyFkNwjgMGk/4LhSBOAEyoL4U7718zVwKaQzR39wErfbvY/XB1yN1Eu2V3i8OOI1thdXhkk3Yxu8TTH4hmKYAP/sxdZnrNgJmGZkhEwlkhrJjQlLET+KUcPDExUmDElJg3da+OKlsts873EctqZ+INocE7uYFMrbAA2N/Kb/5umlRLlQ14qwNii2b0uFJ9Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(38100700002)(31686004)(66556008)(8676002)(41300700001)(2906002)(36756003)(186003)(83380400001)(66476007)(5660300002)(44832011)(8936002)(26005)(6862004)(2616005)(53546011)(36916002)(6506007)(86362001)(6486002)(66946007)(478600001)(6512007)(6636002)(37006003)(316002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRVVUtZRmN1bW9OS1pFbS80YU0yR3phSSt6Y2cyQ0kzWko0dnU5b1dFY1Qv?=
 =?utf-8?B?SU9RdDJqbXZKb3ZOTjVkMzNKcXREcDVaRHM5WVdqK05DdjIyTmc3b2EydXFE?=
 =?utf-8?B?VjNLRnBvZU9vWkJSTUFaeENjR0R3ZjI2SXlXeVFBVEcxSXVkcm1RbVpuVUxW?=
 =?utf-8?B?TUtOQTlGcDEwYzVxUk5nSFdaRlcyeFBJMzk3VTJmRkZNYWtjRkZvMmNGQ0Z0?=
 =?utf-8?B?UjhYS000V1RLanByR0NWVXEvajQ1RkludU5PM1pZMVRtOTF6TmtKTXA2MDYr?=
 =?utf-8?B?OHVONjQ2T0kwRldmSmJ5bHhnR0ZDYmN0cEhjU2NQa1NHS3Y0Zlp6a0ZoR3pH?=
 =?utf-8?B?ZFR0d1c3cldHVE5qV1RwMitFVDduZkdoNnVSNEo3b3piMmViVUZHMlJCb01S?=
 =?utf-8?B?NW9JWnlYaW9TdGRLUFdhTnF5ZmlKWUVhUjJCS3VMOU1scHZDS2p6djcranl0?=
 =?utf-8?B?VXJtdVQ5M2x4a2RZNlNPT1liUUptMzNGNit6bmhoK0tvM0xDQThubjJxUC9B?=
 =?utf-8?B?cnBrampzVk1HMnE3NDNiTjBFZjdsZFhnWlMydjJXa3JiOC9PUlFTNllOZ0RN?=
 =?utf-8?B?aEZsS1htdnljd0YzcUs0M2U0VXcwemo5TUZFL2ljZzhDZE9CMGY0bTViaS9D?=
 =?utf-8?B?T3lSSm9jWGx0c3U2Z1lFdjJyNys0Z2ZjWWQvbTVjOHJjSUNDRVROcCtzd0E3?=
 =?utf-8?B?MTJSdkx6Y0pmazJWaWhXbFltSVl5ZXhyQ2VaVVhtdFBjNERtczlGWXFkTVMr?=
 =?utf-8?B?eHpadEtxTVpvelZ3S0xibWNyUzZ1b1M3eUQ4WlJrK3pvUXEzUVBTRnhsUStE?=
 =?utf-8?B?ZGlqVW5HdnZ2NFREY2lzcVU5WHVORTgxK1ZrWm03VGNwNnI5UlpqOVRmQnor?=
 =?utf-8?B?RG9hM3FKOUYxNzZCc2dzMUZTTFZ4K21JQXR3SzdlNFpzMjJEa1ZaUWNrYXBU?=
 =?utf-8?B?eHRPQXFpWFRySkJXYktZMi96SFIwRDJBY1E4Ukt5WE8vM081T2UxdXJCdlVS?=
 =?utf-8?B?YjA0S1pMWWdRT0JiUFAydDE5VG8vVmRrelRBeGlDNWpSV0o0WnF2ODVmR0Fj?=
 =?utf-8?B?azYvNnNZVEc0MitHdlQ4SVRFV0tmd3pBblZHSDloUmhlRUxiRSt5U3BsTmEy?=
 =?utf-8?B?SW5WU2gyQUg2dWZua2xFYlJ4bUdDd21WTGJYalZaSjJkQjRuUEZMdW56Z29v?=
 =?utf-8?B?aXF6WkJ4dUJvMFVmTGU2dGFSV1dWUnZvZmJKSEFiMVlIeXdoNzBIRjJFRlpX?=
 =?utf-8?B?L3cvdGJWeUZSRkJrcjA5RFFKQjVGNDJiQm15aDZIem8yL0JKOUF6SVMxL1ZN?=
 =?utf-8?B?QUlYd1pxNFJOZGZEL0JTS2FuY0FiNjVQM0l3NnQ1VDFJQzF5WXZ6TEtnMXlw?=
 =?utf-8?B?NjV5bEwyajdHTHM5OEdhc0J4RGxjNHJzek5jTmcyaFU0b01tQk51WHRQaDdQ?=
 =?utf-8?B?STFjZVFTUjFLVEthbGdMZXQweUxOVWtTZmZ4RVZkN0ZGalNHTHhSK2dwYW1h?=
 =?utf-8?B?ODVmMmxuK1dJVEJjQVF4d04zZ2U2dGd1YjRoMTY1bnlhUzhncHF5NFg1U2xT?=
 =?utf-8?B?WDFCYUNhcnZJS0o0Z3RkSlBWSXMyV0s5QkczamVBVzl4R2dJLzAxWlh1NFlP?=
 =?utf-8?B?c2hxdDVzTDZXb0hvenZUTmZRbmVuLzR2aDlkYVQ4b0Mxd1dtd0MzUXBHaTFY?=
 =?utf-8?B?WlJVSWU0VWJvNkdhQmQ1M2lsU1IrRmtFOEg1MFpOaXFCY0lIL1phbEluMk9i?=
 =?utf-8?B?U1pQT1d5WWpDUHdoRDg0MCs3WEhhYkd4REdQZlVVeDZpTzhzaUYwZTlOY0tj?=
 =?utf-8?B?TW51TDQvQVZjUGh2Y21qQXBOcHhKRTU0L1pwdVZaS2xxTWRVVTJ2L3Axanl1?=
 =?utf-8?B?azI2MnBGZ0lUMmE0YlM4OTNGTTF1V0JFTUZWd2trUnlOejBGM2JvZFNzc0RG?=
 =?utf-8?B?cVd6Y1dxUlVlTUJ0Z2Fzc3l4eE94bUVUVUNsSzY5OTRpV2F5RTJFaytVZEly?=
 =?utf-8?B?dlNUeEF0cXpPWVh1NFVIaVQ0eXIvR2NTV0M1WVk1N20vZEdUZEFsZ3JJVWVY?=
 =?utf-8?B?VEJxQXRqV2Ywa0p2b0hWa3FRQ1QvbVBjTGtjVjhnS0VXRm9kRnV0ZVdxZWRt?=
 =?utf-8?Q?cOd6s819ym7n7o0LAfe5Ziqhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab558b0d-5280-430c-583c-08da5eb6ef76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:48:22.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vAEXh7VbQXRRarslzfk8intNTZ80TznXDv2FUvDsBLpLiDdgH2cCjBTtVqtk7pQbjH9I5rUcVG6crhcKBmG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
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

On 2022-06-10 21:03, Philip Yang wrote:
> If destroying/unmapping queue failed, application may destroy queue
> again, cause below kernel warning backtrace.
>
> For outstanding queues, either applications forget to destroy or failed
> to destroy, kfd_process_notifier_release will remove queue sysfs
> objects, kfd_process_wq_release will free queue doorbell.
>
>   refcount_t: underflow; use-after-free.
>   WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
>    Call Trace:
>     kobject_put+0xd6/0x1a0
>     kfd_procfs_del_queue+0x27/0x30 [amdgpu]
>     pqm_destroy_queue+0xeb/0x240 [amdgpu]
>     kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
>     kfd_ioctl+0x27d/0x500 [amdgpu]
>     do_syscall_64+0x35/0x80
>
>   WARNING: CPU: 2 PID: 3053 at drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
>    Call Trace:
>     deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
>     destroy_queue_cpsch+0xb3/0x270 [amdgpu]
>     pqm_destroy_queue+0x108/0x240 [amdgpu]
>     kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
>     kfd_ioctl+0x27d/0x500 [amdgpu]
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e1797657b04c..1c519514ca1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1876,8 +1876,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   			q->properties.type)];
>   
> -	deallocate_doorbell(qpd, q);
> -
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>   		deallocate_sdma_queue(dqm, q);
> @@ -1898,6 +1896,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   		}
>   	}
>   
> +	deallocate_doorbell(qpd, q);
> +

I'm not sure what this change is meant to do. I don't see an early 
return in this function, so deallocate_doorbell will always be executed 
either way.


>   	/*
>   	 * Unconditionally decrement this counter, regardless of the queue's
>   	 * type
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index dc00484ff484..99f2a6412201 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -419,7 +419,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	}
>   
>   	if (pqn->q) {
> -		kfd_procfs_del_queue(pqn->q);
>   		dqm = pqn->q->device->dqm;
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>   		if (retval) {
> @@ -439,6 +438,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		if (dev->shared_resources.enable_mes)
>   			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>   						   pqn->q->gang_ctx_bo);
> +		kfd_procfs_del_queue(pqn->q);

This part makes sense.

Regards,
   Felix


>   		uninit_queue(pqn->q);
>   	}
>   
