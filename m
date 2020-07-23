Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F78C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BD4206F4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e5YYIJJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BD4206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E936E486;
	Thu, 23 Jul 2020 21:27:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2269B6E486
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 21:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgqgptb3JiMykqgYmsNFvacX2OtxniSRaHDuCfjt+pkNfRSdSTUzghPdRAf1G1N8H9J3NcRjwpTzv64H3okDF+8uST+4UYAe56l8x6qCMhOSdhuocBsc18f8AGc03OWQP3CNtek+QV3WYtMyAsf6ICHVHD+eiM7ngL109Hf6sUxNtrWi+PN45M8wMB6sxgzhyBJL92+1QWMWB6JyF5/BTu/I5sxp7U/61i3yHnwj4a+X2jpOgDNCjvJPMH426wjh8LZ2rRpUFVcUFlzh7r09YhBwZA9gdkXcXii9L0y+c3axlJhUJSRc0JB+vHsrQ+sYPLW9ZJyfcY1I+iBQkJyYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwGQ4Db5WU1otXH3wmCemxHFmVP+Oh5QwBBQROSTgaU=;
 b=RS0FKVVf716c/2kBmwPVywNX+2KWD1VpJbW8SbpdvHiLJxUqshGNw8BaCqE608lE1LfMJmvkbElxpmOM4Uc4L7GrlIaSeYI/JyDTiI/oW8UDFJB0AyxGZLoDNmFhCjZ7xUQCbQuQPq3AtWyvYu3u5UhnZkXgG391ynZTOZ0weXdJTgXWCeF2xnHWXvw6QPrZQoLX1fuBsrzj9ca8WIbu43RmdO/XAZglClZHL58USWg+MU4J5Q3etQcrXlFtxnxOJNgjRU6G0C7R2oY0p5iKIrlEmAIzRncHwjio7bJV0FZdvjESk1wMOzIMgxUvXefCOKDE/1pEljKWUuHWm6sZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwGQ4Db5WU1otXH3wmCemxHFmVP+Oh5QwBBQROSTgaU=;
 b=e5YYIJJicjz3Iw/2kMAQOo/Qj9Smtd9MbTnj5WqofQWEfYlr5VwVYQd0u61ikSHrHB3zWZVy+cCMcbcq0SRDcZkFyU0G4MYINivUDLEEZ9ZO/uvSQJFAuMjKgRgG4lXs3//u96kQFP/5J/tHkSG8s/yAi+kpNTH5HV4G/q7P89Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3374.namprd12.prod.outlook.com (2603:10b6:208:c9::17)
 by MN2PR12MB3645.namprd12.prod.outlook.com (2603:10b6:208:cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 21:27:32 +0000
Received: from MN2PR12MB3374.namprd12.prod.outlook.com
 ([fe80::8d68:4fd3:413f:cbeb]) by MN2PR12MB3374.namprd12.prod.outlook.com
 ([fe80::8d68:4fd3:413f:cbeb%4]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 21:27:32 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200722160851.22437-1-mukul.joshi@amd.com>
From: Amber Lin <Amber.Lin@amd.com>
Message-ID: <942bcb77-da1c-de91-c1d8-10757401954e@amd.com>
Date: Thu, 23 Jul 2020 17:27:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722160851.22437-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MN2PR12MB3374.namprd12.prod.outlook.com
 (2603:10b6:208:c9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.38.185] (165.204.54.211) by
 YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 21:27:31 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96363708-e849-420f-4c39-08d82f4f356d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3645:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3645884BBAF7D0019F920AD8E1760@MN2PR12MB3645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNBTKsm5qRSQlkyrWgda9bOKXYRK4bVbWlrV9R5Lch3ZfnM+lV5WHwSiILsLnJa6fLpW7HDAYO5imJna0q2Lb8qJVYutBBnUkcy2qSiPnMUa631yVM0CtJOdC4NhGxbCSuXC+dNkHB4gyeGDJOBVv3hvsARrCzUsOjzRQ2OXKUs1lLV4BbTx7SCPDWs9jlMDCJrcDLsqdzbdKLs2/HHtukQYevGRsbIfYVshuTfHGI52pVv7g2j+4mX75Yygk1Y/9poGhpuerXdhPy4/s8euYZS54/1iGIoOqDbCfizEgATrCqYTpmjMW7rn8i660Uaja41kXr2PoVpQTVt4ZfMebGwicU6ienTXJzo4h9Of1eth1QvTtKAh6YYdTQPyC1g8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(316002)(2616005)(5660300002)(8676002)(956004)(66476007)(66556008)(8936002)(66946007)(4326008)(52116002)(16526019)(86362001)(186003)(478600001)(36756003)(6666004)(53546011)(31696002)(2906002)(26005)(6486002)(16576012)(31686004)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AN8u7wxzOiB2nqyFG9hbWroN/EmRw+yn0S20r8jlpgCw4iCcgqffTv2GhxSeXSlOZ/14ekBzHqaUPArL6WngAZV6+wlHOmVExOAOy89ZqeDbbHxYLe4iomBMUciiIlFOYB7veBKwX60/JNUKcmh+VXy7pwFZfpxB0fOuPcJl/4xI/D8FM7NUjHUvWHD0nFnQ3N6uuEAJ+msqb6L+AM/GATy8AwO0AWTmvznjRXErIAFfz4376yWh5qKwM9MB1TlHgvZx5Zs7sHJ67eVdRrBTnP/pbgGhATI1uwdjGWK+aIhvpmGb3EwhtYHVus044+yOgjuw3B4d3QCJXUw97g0BP0L+UZ/5ynMbk6DXTzC47sJ22LeCG0pC/hCm8xkKb3h+EWLRB5IXdLJZ1itlDip5YSuGwoaQAKBbsVXxf7FhjQyT4SjkoxIjo14g/aipjo9b0oJ5IAexa+hjeHvLtj9IvhBP+/cT092xk5ovRKCpFwNxiGbYPu5SvRm+3nPcjd1+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96363708-e849-420f-4c39-08d82f4f356d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 21:27:31.9921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhfrX4p4fzxxXekT2piplIQSLsvNozAJdZiGarIbXq5lwZKDYsePvraot1V+k1Tb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3645
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-07-22 12:08 p.m., Mukul Joshi wrote:
> Add support for reporting thermal throttling events through SMI.
> Also, add a counter to count the number of throttling interrupts
> observed and report the count in the SMI event message.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 68 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
>   drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
>   .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>   drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 ++
>   include/uapi/linux/kfd_ioctl.h                |  3 +-
>   10 files changed, 75 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1b865fed74ca..19e4658756d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -755,4 +755,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
>   {
>   }
> +
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> +{
> +}
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3f2b695cf19e..e8b0258aae24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -269,5 +269,6 @@ int kgd2kfd_resume_mm(struct mm_struct *mm);
>   int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>   					       struct dma_fence *fence);
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
>   
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4bfedaab183f..d5e790f046b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -29,6 +29,7 @@
>   #include "cwsr_trap_handler.h"
>   #include "kfd_iommu.h"
>   #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>   
>   #define MQD_SIZE_ALIGNED 768
>   
> @@ -1245,6 +1246,12 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
>   	WARN_ONCE(count < 0, "Compute profile ref. count error");
>   }
>   
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> +{
> +	if (kfd)
> +		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 7b348bf9df21..00c90b47155b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -24,6 +24,7 @@
>   #include <linux/wait.h>
>   #include <linux/anon_inodes.h>
>   #include <uapi/linux/kfd_ioctl.h>
> +#include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "kfd_priv.h"
>   #include "kfd_smi_events.h"
> @@ -148,6 +149,55 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>   	return 0;
>   }
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
> +	 * ThermalThrottle msg = gpu_id(4):throttle_bitmask(4):
gpu_id is not needed. The user calls ioctl with GPU specified and KFD 
returns an anonymous fd. Read from this anon_fd already identify the GPU.
> +	 * 			 thermal_interrupt_count(8):
> +	 * 16 bytes event + 1 byte space + 4 bytes gpu_id + 1 byte : +
> +	 * 4 byte throttle_bitmask + 1 byte : +
> +	 * 8 byte thermal_interupt_counter + 1 byte \n = 36
> +	 */
> +	char fifo_in[36];
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	len = snprintf(fifo_in, 36, "%x %x:%x:%llx\n",
> +		       KFD_SMI_EVENT_THERMAL_THROTTLE,
> +		       dev->id, throttle_bitmask,
> +		       atomic64_read(&adev->smu.throttle_int_counter));
> +
> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
> +}
> +
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
> @@ -156,7 +206,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
>   	 */
>   	char fifo_in[43];
> -	struct kfd_smi_client *client;
>   	int len;
>   
>   	if (list_empty(&dev->smi_clients))
> @@ -171,22 +220,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
>   		task_info.pid, task_info.task_name);
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
>   }
>   
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index a9cb218fef96..15537b2cccb5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -25,5 +25,7 @@
>   
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> +					     uint32_t throttle_bitmask);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b197dcaed064..52b52cbb90e2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -639,6 +639,7 @@ static int smu_sw_init(void *handle)
>   	mutex_init(&smu->message_lock);
>   
>   	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
> +	atomic64_set(&smu->throttle_int_counter, 0);
>   	smu->watermarks_bitmap = 0;
>   	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>   	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 9b68760dd35b..eb3a57593f69 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2251,6 +2251,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
>   
>   	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
>   			log_buf);
> +	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
>   }
>   
>   static const struct pptable_funcs arcturus_ppt_funcs = {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 896b443f1ce8..18ba421c59bd 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -446,6 +446,7 @@ struct smu_context
>   	bool dc_controlled_by_gpio;
>   
>   	struct work_struct throttling_logging_work;
> +	atomic64_t throttle_int_counter;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index fd82402065e6..a9453ec01619 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1311,6 +1311,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
>   				break;
>   			case 0x7:
> +				/*
> +				 * Increment the throttle interrupt counter
> +				 */
> +				atomic64_inc(&smu->throttle_int_counter);
> +
>   				if (!atomic_read(&adev->throttling_logging_enabled))
>   					return 0;
>   
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f738c3b53f4e..df6c7a43aadc 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -450,7 +450,8 @@ struct kfd_ioctl_import_dmabuf_args {
>    * KFD SMI(System Management Interface) events
>    */
>   /* Event type (defined by bitmask) */
> -#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
> +#define KFD_SMI_EVENT_VMFAULT			0x0000000000000001
> +#define KFD_SMI_EVENT_THERMAL_THROTTLE		0x0000000000000002
>   
>   struct kfd_ioctl_smi_events_args {
>   	__u32 gpuid;	/* to KFD */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
