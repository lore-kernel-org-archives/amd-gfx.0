Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7711C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 20:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ED82088E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 20:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ksw1eN44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ED82088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299586E23D;
	Tue, 26 May 2020 20:07:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB4A6E23D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 20:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5/g/STJ6Nuv+NMOTuq74ZJZD7uYdK0oOMY4ObtU+O/SmEiH0MA1zshoiDLl+/y1WQdwHTgf36l1k3yL8XsGlhtDhjJ+9QKugtFmweJjZ3J40odedi+AMvw6+2fYolYpBWdr/fJ21Kbqc8/IzG4aNaL2wxNXUDd4/Jg10Qn6SKIuBZyvPdvGYKoDCGiY8O58Lfam/tTdV9sbK6HaxeQIIIepb45b5Ojwlrw+QoLWqXqFSfrhJGqduApsC6+tcV0OxlIlrnfjLxXpNHYLkLGM2ZvoFhHuQrxMvnomqXonri7hNmqcJFWs/9ltqt5sxZ9I0/Ur98UW7AvfCyIf6xfXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE3W2nxn85JnTFqjbABDwz0A4XUlaRTm3SQrGer4K5s=;
 b=kPwsZfN7mAy2ZdsSjvkL30vJeLgxATVH79uDAIV1ljpocKA02Lrd61RBG9Ubn6k5URyazCjpHRFqdEyfdUYi2CS2Rm0oLV+yCPFNbObJa+AU3ZUqMgjQyFYRmLQGFE+6LUwbrFAJfBjZY15XLIQZ6Znbr4HJi5aABkKBKg9jSJmsHA9fHwtyo7IUxiJr7E/2HpaaOqcl1q7vYcZTHNgmjf4MjNAwac5r+42bgT0ZPwg0N8k9OwUU8u5ZJBl/UdD1thuwD3WqDqjrJGf6z8E1OjFEHxW4lSSn8oXI/kKXlTPXNQsyk5yO0Rqr8dHe6qPiLFVovMtnjsCkEyt+pKo67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE3W2nxn85JnTFqjbABDwz0A4XUlaRTm3SQrGer4K5s=;
 b=Ksw1eN44JvXDlVX1xDxIoE2MQjaO9HrV7LMvhy8F8lcIPjE4oxD7NglWZDdqLCY4NmrjjK+eBdYvWYLaykTpAK82hXC7Iy6IdLqFOyp8hOOkhpdF0eiPcVoi24En8hLnDwofRQK5imYlB2lXx9GCfU41ietM9cpTMsqJveF2AyU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 20:07:33 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 20:07:33 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Track SDMA utilization per process
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200526172659.8537-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c09b3ec7-7fba-f61e-b114-ed5e447ef789@amd.com>
Date: Tue, 26 May 2020 16:07:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200526172659.8537-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 20:07:33 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd58476d-98b0-4d20-a080-08d801b06d6e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575AA80839B17939AA9BC0A92B00@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sU+DmUPnSoWa7FXJaulN3SuB1RPpKrotGxbJl5yDHIsono66YKTaFJz6IakWJwMdFT6qrImQLL8J9e/K5lAI6Dx97swPZIIDuYva+h/Zjy3Fc6QJoAxsz4N4sRI4CF9GgYtYSm+ei5pcm/c968wcTDWBgjnP0IYZSNuVOlZMg0+owUAvFjph5k99qVf2IB5TUeAdqgNH1UVlTuYIAQ9stTPMGXU08nqLrIh2WpIZL6KtpWCOoXGF4JU5F/4J4zXbtaKP1RWsUoIODmPKQP3X4CdkMCyjMf4QCeCn9Q6fzrkovHvvrVRnMiLM5cZsqSuptHlkMO8Y2VLEQZQNx6MOPftcSFiEiUcVbcmtDU6Afl5mWfCcKkgEX2fkZwKLa1P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(16526019)(186003)(5660300002)(36756003)(26005)(86362001)(31696002)(478600001)(52116002)(30864003)(66476007)(66556008)(66946007)(316002)(16576012)(44832011)(956004)(2616005)(31686004)(2906002)(8676002)(8936002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +XqiEFBC2fxeNuD+g1AUKMFcDTq4VX986pOg7Az4seSJBuFRcCMGULPeZJT0QBeiVx920FZ5cEoleGhviTrsYVk8jqFbRTMpMUwT/WNRBz/ZXs4n3zxGwEa8tA6kStcc3XUXXgye5IWrzX+WZP8jyplarHEMCJe862NttDafzkRMOdzOQ+7yCSM5/C5nP9llHkBaJNXqZykDZiVGN3AfASOoa0NwMU32mup0JylyYGmvDJ3YQTYTXyMfe3TzFgJ1TUExOKnlde+bsAu9F7F3on4gqosqOFuxV1tUuRPRP43mBjhYp01Q/VIpFMPmjBtCG0dAa4tNDE3dKaVlaFxof9YsidmyIHXZfXkNuSzvIzXcGfIghIB3SpP6YxZ4CyCyKND07oZkVPI3+djWaqQ7dMCXeqkReFrhA0h8zawg3TBhc0UyzjfQH6EPrEu2tpLqtGoK88jub2kYyO0wFPe1iab4qPea7N69EI/zHuY75nWmE8KZqDYzJ4grhqb+QjV3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58476d-98b0-4d20-a080-08d801b06d6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 20:07:33.6452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms/RfVgp+VTXrQFyjll8n/ISWx3j6hG/r3Zuvv9r18BKwwnnUXtXa2MU0LUHq74SqWhHHRDXezGlD3pLHUeyQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-05-26 um 1:26 p.m. schrieb Mukul Joshi:
> Track SDMA usage on a per process basis and report it through sysfs.
> The value in the sysfs file indicates the amount of time SDMA has
> been in-use by this process since the creation of the process.
> This value is in microsecond granularity.
>
> v2:
> - Remove unnecessary checks for pdd is kfd_procfs_show().
> - Make counter part of the kfd_sdma_activity_handler_workarea
>   structure.
>
> v3:
> - Remove READ_ONCE/WRITE_ONCE while updating acitivty

Typo: activity


>   counter.
> - Add updation of past acitivt counter under dqm_lock.

Typo: activity

Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  57 ++++++++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  16 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 137 ++++++++++++++++--
>  4 files changed, 198 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9c4867abeff..6293017bd5bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -153,6 +153,52 @@ void decrement_queue_count(struct device_queue_manager *dqm,
>  		dqm->active_cp_queue_count--;
>  }
>  
> +int read_sdma_queue_counter(struct queue *q, uint64_t *val)
> +{
> +	int ret;
> +	uint64_t tmp = 0;
> +
> +	if (!q || !val)
> +		return -EINVAL;
> +	/*
> +	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
> +	 */
> +	if (!access_ok((const void __user *)((uint64_t)q->properties.read_ptr +
> +					sizeof(uint64_t)), sizeof(uint64_t))) {
> +		pr_err("Can't access sdma queue activity counter\n");
> +		return -EFAULT;
> +	}
> +
> +	ret = get_user(tmp, (uint64_t *)((uint64_t)(q->properties.read_ptr) +
> +						    sizeof(uint64_t)));
> +	if (!ret) {
> +		*val = tmp;
> +	}
> +
> +	return ret;
> +}
> +
> +static int update_sdma_queue_past_activity_stats(struct kfd_process_device *pdd,
> +						 struct queue *q)
> +{
> +	int ret;
> +	uint64_t val = 0;
> +
> +	if (!pdd)
> +		return -ENODEV;
> +
> +	ret = read_sdma_queue_counter(q, &val);
> +	if (ret) {
> +		pr_err("Failed to read SDMA queue counter for queue: %d\n",
> +				q->properties.queue_id);
> +		return ret;
> +	}
> +
> +	pdd->sdma_past_activity_counter += val;
> +
> +	return ret;
> +}
> +
>  static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
>  {
>  	struct kfd_dev *dev = qpd->dqm->dev;
> @@ -487,6 +533,12 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>  	if (retval == -ETIME)
>  		qpd->reset_wavefronts = true;
>  
> +	/* Get the SDMA queue stats */
> +        if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
> +            (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> +                update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
> +        }
> +
>  	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>  
>  	list_del(&q->list);
> @@ -1468,6 +1520,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>  		}
>  	}
>  
> +	/* Get the SDMA queue stats */
> +	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
> +	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> +		update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
> +	}
>  	/*
>  	 * Unconditionally decrement this counter, regardless of the queue's
>  	 * type
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 4afa015c69b1..894bcf877f9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -251,4 +251,6 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
>  	mutex_unlock(&dqm->lock_hidden);
>  }
>  
> +int read_sdma_queue_counter(struct queue *q, uint64_t *val);
> +
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f70f789c3cb3..fae139b77c0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -633,7 +633,14 @@ enum kfd_pdd_bound {
>  	PDD_BOUND_SUSPENDED,
>  };
>  
> -#define MAX_VRAM_FILENAME_LEN 11
> +#define MAX_SYSFS_FILENAME_LEN 11
> +
> +/*
> + * SDMA counter runs at 100MHz frequency.
> + * We display SDMA activity in microsecond granularity in sysfs.
> + * As a result, the divisor is 100.
> + */
> +#define SDMA_ACTIVITY_DIVISOR  100
>  
>  /* Data that is per-process-per device. */
>  struct kfd_process_device {
> @@ -681,7 +688,12 @@ struct kfd_process_device {
>  	/* VRAM usage */
>  	uint64_t vram_usage;
>  	struct attribute attr_vram;
> -	char vram_filename[MAX_VRAM_FILENAME_LEN];
> +	char vram_filename[MAX_SYSFS_FILENAME_LEN];
> +
> +	/* SDMA activity tracking */
> +	uint64_t sdma_past_activity_counter;
> +	struct attribute attr_sdma;
> +	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
>  };
>  
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d27221ddcdeb..db010c5da144 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/task.h>
> +#include <linux/mmu_context.h>
>  #include <linux/slab.h>
>  #include <linux/amd-iommu.h>
>  #include <linux/notifier.h>
> @@ -76,6 +77,74 @@ struct kfd_procfs_tree {
>  
>  static struct kfd_procfs_tree procfs;
>  
> +/*
> + * Structure for SDMA activity tracking
> + */
> +struct kfd_sdma_activity_handler_workarea {
> +	struct work_struct sdma_activity_work;
> +	struct kfd_process_device *pdd;
> +	uint64_t sdma_activity_counter;
> +};
> +
> +static void kfd_sdma_activity_worker(struct work_struct *work)
> +{
> +	struct kfd_sdma_activity_handler_workarea *workarea;
> +	struct kfd_process_device *pdd;
> +	uint64_t val;
> +	struct mm_struct *mm;
> +	struct queue *q;
> +	struct qcm_process_device *qpd;
> +	struct device_queue_manager *dqm;
> +	int ret = 0;
> +
> +	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
> +				sdma_activity_work);
> +	if (!workarea)
> +		return;
> +
> +	pdd = workarea->pdd;
> +	dqm = pdd->dev->dqm;
> +	qpd = &pdd->qpd;
> +
> +	if (!pdd || !dqm || !qpd)
> +		return;
> +
> +	mm = get_task_mm(pdd->process->lead_thread);
> +	if (!mm) {
> +		return;
> +	}
> +
> +	use_mm(mm);
> +
> +	dqm_lock(dqm);
> +
> +	/*
> +	 * Total SDMA activity is current SDMA activity + past SDMA activity
> +	 */
> +	workarea->sdma_activity_counter = pdd->sdma_past_activity_counter;
> +
> +	/*
> +	 * Get the current activity counters for all active SDMA queues
> +	 */
> +	list_for_each_entry(q, &qpd->queues_list, list) {
> +		if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
> +		    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> +			val = 0;
> +			ret = read_sdma_queue_counter(q, &val);
> +			if (ret)
> +				pr_debug("Failed to read SDMA queue active "
> +					 "counter for queue id: %d",
> +					 q->properties.queue_id);
> +			else
> +				workarea->sdma_activity_counter += val;
> +		}
> +	}
> +
> +	dqm_unlock(dqm);
> +	unuse_mm(mm);
> +	mmput(mm);
> +}
> +
>  static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  			       char *buffer)
>  {
> @@ -87,8 +156,24 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>  		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>  							      attr_vram);
> -		if (pdd)
> -			return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
> +		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
> +	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
> +		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
> +							      attr_sdma);
> +		struct kfd_sdma_activity_handler_workarea sdma_activity_work_handler;
> +
> +		INIT_WORK(&sdma_activity_work_handler.sdma_activity_work,
> +					kfd_sdma_activity_worker);
> +
> +		sdma_activity_work_handler.pdd = pdd;
> +
> +		schedule_work(&sdma_activity_work_handler.sdma_activity_work);
> +
> +		flush_work(&sdma_activity_work_handler.sdma_activity_work);
> +
> +		return snprintf(buffer, PAGE_SIZE, "%llu\n",
> +				(sdma_activity_work_handler.sdma_activity_counter)/
> +				 SDMA_ACTIVITY_DIVISOR);
>  	} else {
>  		pr_err("Invalid attribute");
>  		return -EINVAL;
> @@ -210,7 +295,24 @@ int kfd_procfs_add_queue(struct queue *q)
>  	return 0;
>  }
>  
> -int kfd_procfs_add_vram_usage(struct kfd_process *p)
> +static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
> +				 char *name)
> +{
> +	int ret = 0;
> +
> +	if (!p || !attr || !name)
> +		return -EINVAL;
> +
> +	attr->name = name;
> +	attr->mode = KFD_SYSFS_FILE_MODE;
> +	sysfs_attr_init(attr);
> +
> +	ret = sysfs_create_file(p->kobj, attr);
> +
> +	return ret;
> +}
> +
> +int kfd_procfs_add_sysfs_files(struct kfd_process *p)
>  {
>  	int ret = 0;
>  	struct kfd_process_device *pdd;
> @@ -221,17 +323,25 @@ int kfd_procfs_add_vram_usage(struct kfd_process *p)
>  	if (!p->kobj)
>  		return -EFAULT;
>  
> -	/* Create proc/<pid>/vram_<gpuid> file for each GPU */
> +	/*
> +	 * Create sysfs files for each GPU:
> +	 * - proc/<pid>/vram_<gpuid>
> +	 * - proc/<pid>/sdma_<gpuid>
> +	 */
>  	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
> -		snprintf(pdd->vram_filename, MAX_VRAM_FILENAME_LEN, "vram_%u",
> +		snprintf(pdd->vram_filename, MAX_SYSFS_FILENAME_LEN, "vram_%u",
>  			 pdd->dev->id);
> -		pdd->attr_vram.name = pdd->vram_filename;
> -		pdd->attr_vram.mode = KFD_SYSFS_FILE_MODE;
> -		sysfs_attr_init(&pdd->attr_vram);
> -		ret = sysfs_create_file(p->kobj, &pdd->attr_vram);
> +		ret = kfd_sysfs_create_file(p, &pdd->attr_vram, pdd->vram_filename);
>  		if (ret)
>  			pr_warn("Creating vram usage for gpu id %d failed",
>  				(int)pdd->dev->id);
> +
> +		snprintf(pdd->sdma_filename, MAX_SYSFS_FILENAME_LEN, "sdma_%u",
> +			 pdd->dev->id);
> +		ret = kfd_sysfs_create_file(p, &pdd->attr_sdma, pdd->sdma_filename);
> +		if (ret)
> +			pr_warn("Creating sdma usage for gpu id %d failed",
> +				(int)pdd->dev->id);
>  	}
>  
>  	return ret;
> @@ -444,9 +554,9 @@ struct kfd_process *kfd_create_process(struct file *filep)
>  		if (!process->kobj_queues)
>  			pr_warn("Creating KFD proc/queues folder failed");
>  
> -		ret = kfd_procfs_add_vram_usage(process);
> +		ret = kfd_procfs_add_sysfs_files(process);
>  		if (ret)
> -			pr_warn("Creating vram usage file for pid %d failed",
> +			pr_warn("Creating sysfs usage file for pid %d failed",
>  				(int)process->lead_thread->pid);
>  	}
>  out:
> @@ -597,8 +707,10 @@ static void kfd_process_wq_release(struct work_struct *work)
>  		kobject_put(p->kobj_queues);
>  		p->kobj_queues = NULL;
>  
> -		list_for_each_entry(pdd, &p->per_device_data, per_device_list)
> +		list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
>  			sysfs_remove_file(p->kobj, &pdd->attr_vram);
> +			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
> +		}
>  
>  		kobject_del(p->kobj);
>  		kobject_put(p->kobj);
> @@ -906,6 +1018,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>  	pdd->already_dequeued = false;
>  	pdd->runtime_inuse = false;
>  	pdd->vram_usage = 0;
> +	pdd->sdma_past_activity_counter = 0;
>  	list_add(&pdd->per_device_list, &p->per_device_data);
>  
>  	/* Init idr used for memory handle translation */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
