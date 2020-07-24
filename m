Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D615C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 03:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9A20771
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 03:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01uQGqjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9A20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B610189E9B;
	Fri, 24 Jul 2020 03:28:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0899789E9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 03:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5mH+8G/6k4xKX/fCJX1whke9rZGd2TleXOVQ4/cIFGGTRXhYe68hWtXIn3/+ryxUKt7anOoAFE1PCdVZ+LHC3AW21HIiLp9z+uHvE7W92xI7M+XP/nJPDQF7DPJ0TIVBrtfppY4k1t3OPhF2TdorX2nzZoiQ0tq5818b9OPcqhUd1Bt8TWuNB+v6uCh2QXUcz4mMHChZsJNQCjpFB1w1BG2dwWNhaCvMtyJa0iNPUfesvD4+YLorrEJhFO856ylq8HO3V5XmQqoQ2yKdCMnPXTyy74ZLA+syFD4QMhjLH5M+UsLakEHFhXGAp56UG4zXRBt8VkDP4fdoVbNnNizXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yqLuJIoos1RBlR7scDDnwS8f8aMDrtf/GYQ3w47y2k=;
 b=MNTigeXkzMfL26TbF7b6vfgLiUqEthzuygBTnIJpx3gx8a1jyvT58LoEqEjpEI83+yY4VbtR0p90H19dhuMIYkJENrqd5nrIN0nBmN6EDEZe8jBzBzS11uwqQr3OD7/AsdRg4deOMkA8hCbtrQWboeYAwWsVyqUxOsis1H4zGqTl22AyRXc2eJ7GwVvBABq0RRW12BqvCn2U/g5ZbnF5JVL11819UKF3kkiglwmT7CZontyPzl8rE5BKqkSivlomvARNslhrQM8K5AKlOaYfLgI5GPtwHnpgPbAHAJgz+Ee9vR7wsIslplxhvb9ugM+kGeHINqLJEjirl42Paju/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yqLuJIoos1RBlR7scDDnwS8f8aMDrtf/GYQ3w47y2k=;
 b=01uQGqjK8L+7oesHnr+z3nB2M8WvfGSKbz0Az2zbxlQcdIduwVPuzMl1QxosDC68e3u4bTkhiYTyBelZFnNVDO3Gy7bR40/N+LoTPRNcfBPQfDlWYQLmIyQA6zo1HdpljHNDVoj7fAvIAz3Y4Wr+eegQi2ArkiGnYlvpD+vnqOc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 03:28:18 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d%7]) with mapi id 15.20.3216.020; Fri, 24 Jul 2020
 03:28:18 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Add thermal throttling SMI event
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200724032054.31115-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8a148566-a08e-8de3-9206-5d08a3868850@amd.com>
Date: Thu, 23 Jul 2020 23:28:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200724032054.31115-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.61.76) by
 YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 03:28:17 +0000
X-Originating-IP: [142.117.61.76]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 907091f9-7e15-4470-48e0-08d82f819b6a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767BD1AE29DCB7486D5410692770@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qfl+iTBWIbVBbvMtwP+RkJGyi116wAP0GKGS7p5MJB9TqAGsk9qHu+sgm+X6uW8I7q1VHD7Rfk7vbbgRC2RL5RXNaNkDsbp96YvkRfEtINzEY3M+MV0BJrTPY0nlfbVdyKE/wxD61/pTClP1p+yrv6rkPENPyBAD4X0CoE4lFKeKYXJzKAU+pZDAMqbqR2Yr768EzzmSbSgRae0f9K4t/6ft4pMbrItRnVYhzoynB2oT90iBmsasHO73zvgBRdwx3SwOEW/7yeKAw3FSoTC/GBS1SMtSgFg4pzS+cHZFbTBPx755BnvGrr7M9JdQnPAHG7I6dXoL7faLPp5NIsYZEX6xz6af2ZB1KVV8mVT/Yh2Z9Qwt3EMSghPMzO9LRjJT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(2906002)(186003)(31686004)(16526019)(66946007)(83380400001)(66556008)(478600001)(31696002)(44832011)(5660300002)(2616005)(956004)(52116002)(26005)(66476007)(8676002)(316002)(8936002)(16576012)(6486002)(86362001)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sgNyhHujzX3gmDLu26DUCu2EqmSuSHCOtm9rMn+tVIZxP5KINky3VOiiuB8DVl+sBQRJ3YQeU357Tm7UJSONnB/r2qvz2VhFe7KgpuwlG3gKp6oXFE/kY0lcRFaR5OgRYSIPA58JdQZZNcvrNbIwDxiR5wfCKdg74FPKihGnyhkGubDcun5mV3ojNL/Mw+k7BugFlY6HqDRhlIIVfD4nS4LmDkJtuYpYyPflyjmQkW2XOPBabuAdKDfjtol/ay2jOKY/ft53H3dV+mg9rCWxZtrFH1g/YZO0D3QxR0Zpbmna8nM20lig0PmqGvns/sjI/p0IidkuYLSAMVZJfBl916NkNp95pmLOQ4k5kMe+WYxHuy8Y2l/oP/jA19pOjhsWJaqIcqBhmjNxMjleRBqY9MZUH7Ke0GS2ujy3b/WA496p9sXmfcF7H0aE8AXln9+ZMmr3ptkJAmUeNiYqXFnZ0uB5p4mJg8BxSNni2Uwf1xFEy+5K8+m0lSJ363JjMYri
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907091f9-7e15-4470-48e0-08d82f819b6a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 03:28:17.8735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LvAA+z+J3Ntilb6/esXMZ9JaUewzpvwjEP3TtaINPyHDekwrczhz143S8BIqAQ5zAIcNS6B37YHZl5JEobYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
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

Am 2020-07-23 um 11:20 p.m. schrieb Mukul Joshi:
> Add support for reporting thermal throttling events through SMI.
> Also, add a counter to count the number of throttling interrupts
> observed and report the count in the SMI event message.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 67 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 ++
>  include/uapi/linux/kfd_ioctl.h                |  3 +-
>  10 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1b865fed74ca..19e4658756d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -755,4 +755,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
>  {
>  }
> +
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> +{
> +}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3f2b695cf19e..e8b0258aae24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -269,5 +269,6 @@ int kgd2kfd_resume_mm(struct mm_struct *mm);
>  int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>  					       struct dma_fence *fence);
>  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
>  
>  #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4bfedaab183f..d5e790f046b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -29,6 +29,7 @@
>  #include "cwsr_trap_handler.h"
>  #include "kfd_iommu.h"
>  #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>  
>  #define MQD_SIZE_ALIGNED 768
>  
> @@ -1245,6 +1246,12 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
>  	WARN_ONCE(count < 0, "Compute profile ref. count error");
>  }
>  
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> +{
> +	if (kfd)
> +		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>  
>  /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 7b348bf9df21..86c2c3e97944 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -24,6 +24,7 @@
>  #include <linux/wait.h>
>  #include <linux/anon_inodes.h>
>  #include <uapi/linux/kfd_ioctl.h>
> +#include "amdgpu.h"
>  #include "amdgpu_vm.h"
>  #include "kfd_priv.h"
>  #include "kfd_smi_events.h"
> @@ -148,6 +149,54 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> +static void add_event_to_kfifo(struct kfd_dev *dev, unsigned long long smi_event,
> +			      char *event_msg, int len)
> +{
> +	struct kfd_smi_client *client;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> +		if (!(READ_ONCE(client->events) & smi_event))
> +			continue;
> +		spin_lock(&client->lock);
> +		if (kfifo_avail(&client->fifo) >= len) {
> +			kfifo_in(&client->fifo, event_msg, len);
> +			wake_up_all(&client->wait_queue);
> +		} else {
> +			pr_debug("smi_event(EventID: %llu): no space left\n",
> +					smi_event);
> +		}
> +		spin_unlock(&client->lock);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> +					     uint32_t throttle_bitmask)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
> +	/*
> +	 * ThermalThrottle msg = throttle_bitmask(8):
> +	 * 			 thermal_interrupt_count(16):
> +	 * 16 bytes event + 1 byte space + 8 byte throttle_bitmask +
> +	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
> +	 * 1 byte \0 = 44
> +	 */
> +	char fifo_in[44];
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	len = snprintf(fifo_in, 44, "%x %x:%llx\n",
> +		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
> +		       atomic64_read(&adev->smu.throttle_int_counter));
> +
> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
> +}
> +
>  void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
> @@ -156,7 +205,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>  	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
>  	 */
>  	char fifo_in[43];
> -	struct kfd_smi_client *client;
>  	int len;
>  
>  	if (list_empty(&dev->smi_clients))
> @@ -171,22 +219,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>  	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
>  		task_info.pid, task_info.task_name);
>  
> -	rcu_read_lock();
> -
> -	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> -		if (!(READ_ONCE(client->events) & KFD_SMI_EVENT_VMFAULT))
> -			continue;
> -		spin_lock(&client->lock);
> -		if (kfifo_avail(&client->fifo) >= len) {
> -			kfifo_in(&client->fifo, fifo_in, len);
> -			wake_up_all(&client->wait_queue);
> -		}
> -		else
> -			pr_debug("smi_event(vmfault): no space left\n");
> -		spin_unlock(&client->lock);
> -	}
> -
> -	rcu_read_unlock();
> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>  }
>  
>  int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index a9cb218fef96..15537b2cccb5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -25,5 +25,7 @@
>  
>  int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
>  void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> +					     uint32_t throttle_bitmask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 727cb9fd4aee..23a830d267e2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -640,6 +640,7 @@ static int smu_sw_init(void *handle)
>  	mutex_init(&smu->message_lock);
>  
>  	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
> +	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
>  	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 3b9182c8c53f..f13979687b9e 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2251,6 +2251,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
>  
>  	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
>  			log_buf);
> +	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
>  }
>  
>  static const struct pptable_funcs arcturus_ppt_funcs = {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 28312d6dc187..b57b10406390 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -446,6 +446,7 @@ struct smu_context
>  	bool dc_controlled_by_gpio;
>  
>  	struct work_struct throttling_logging_work;
> +	atomic64_t throttle_int_counter;
>  };
>  
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index fd82402065e6..a9453ec01619 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1311,6 +1311,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>  				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
>  				break;
>  			case 0x7:
> +				/*
> +				 * Increment the throttle interrupt counter
> +				 */
> +				atomic64_inc(&smu->throttle_int_counter);
> +
>  				if (!atomic_read(&adev->throttling_logging_enabled))
>  					return 0;
>  
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f738c3b53f4e..df6c7a43aadc 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -450,7 +450,8 @@ struct kfd_ioctl_import_dmabuf_args {
>   * KFD SMI(System Management Interface) events
>   */
>  /* Event type (defined by bitmask) */
> -#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
> +#define KFD_SMI_EVENT_VMFAULT			0x0000000000000001
> +#define KFD_SMI_EVENT_THERMAL_THROTTLE		0x0000000000000002
>  
>  struct kfd_ioctl_smi_events_args {
>  	__u32 gpuid;	/* to KFD */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
