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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373CDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03AA206E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4PtRPpVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03AA206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F836E0B9;
	Thu, 23 Jul 2020 21:58:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5676E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 21:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDpUWV5SlQLpaQCyL8JwDwNMRKV62efrmhoA57KZG01Q8uxCwaBTkEVz7iTYT5YJLFI6OLtsbm8SAdv8YsKS1f0wKqboHMcY6z0E0D6WHwSwATNSeXdiZ4mnRiF0YXmUNOd8hSYTOBCgXa1lEtz6WSH/R2bYRGDO9sRtNlAWCuqqBVGzzN5nm10dXwSsrNxLo/A9L7Ipwu4H/uCUqfkSVGBitRflQlLkIwrF34ym4gREvG8eVuo7esKSYvIJ9PfWNW7xEmy5ltdza9d9hnWqr6p2lbTVW8uXDtlWfcRcQ6JW3IZ6bq9JARc0ljRKK5wApB7yHKlIu4LyppXU5Y+ZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRhP1ijuiDH7BC52NjaLuoLyr+RJruLVfgzDmwVcrw4=;
 b=N7V4Redovii7dRIbxxdWv5Ddp8Ka83TFDzk3PgzH0JfZWkhc1NhNAUoAEM5wUBlk4PT2S6uMUhUb4HR/yuL94Onv9EzP1yyuMa5YSilFoXxzoPyq9fN2rdSB5KldTRhmD/qHmzYA7byF8CqxFEXKrSMF9/bnhk9+OoyYDZ4I26F4aHzbUVJMxklK+6ElNQbWFzclUHjQ8SWPi4S/pBzWmaTDLedbRJWrzKmeweHQB3Q2k7rY9GapSbmbmQsUzM+/q8e4HMSvIturLkAjL/tnovEfAMQbI0E1Lc7QsFZOHnZGxfoBDopqjK5oUWOELRCqzjgKPljzZIdGeJpmrx/yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRhP1ijuiDH7BC52NjaLuoLyr+RJruLVfgzDmwVcrw4=;
 b=4PtRPpVt1uQDSjEINfmkIrbmy9IQNbB/9GDsMNGOJmpF76x/3drERRsS2E99SoJQ8FShRjzub/w3NwxG63J3NZQ/l4mdjjuDe0NaoOUr0aXiZ0JV/1zfUyL4XDKI8n7I1bp/+Ai5HW5NvJAIyKbGhtoVOuGXNRmGqdyjNgpKj90=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3374.namprd12.prod.outlook.com (2603:10b6:208:c9::17)
 by MN2PR12MB3406.namprd12.prod.outlook.com (2603:10b6:208:c9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 21:58:01 +0000
Received: from MN2PR12MB3374.namprd12.prod.outlook.com
 ([fe80::8d68:4fd3:413f:cbeb]) by MN2PR12MB3374.namprd12.prod.outlook.com
 ([fe80::8d68:4fd3:413f:cbeb%4]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 21:58:01 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200722160851.22437-1-mukul.joshi@amd.com>
 <942bcb77-da1c-de91-c1d8-10757401954e@amd.com>
 <MN2PR12MB42726B7B157DC5A66A4EE4ECEE760@MN2PR12MB4272.namprd12.prod.outlook.com>
From: Amber Lin <Amber.Lin@amd.com>
Message-ID: <652bc6be-435f-49dc-0274-80563cd44db8@amd.com>
Date: Thu, 23 Jul 2020 17:57:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB42726B7B157DC5A66A4EE4ECEE760@MN2PR12MB4272.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To MN2PR12MB3374.namprd12.prod.outlook.com
 (2603:10b6:208:c9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.38.185] (165.204.54.211) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Thu, 23 Jul 2020 21:58:00 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b95c5f65-38cb-492b-77ae-08d82f5377e2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34060026FE7FFA154C8E9AEFE1760@MN2PR12MB3406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qED9fkRnhZGPGBsXHwkTMSqcKeLmMnkJGpmPPyCISbU3GqiJYkxKKysHvKWKFG+B2X088pcZdS2uiFeNVR7lOMj85doT4RryRyhVQbuKIMFNp7h4zj0+deXlX2hTw2wVGInYlGEaSF5++j/qigPC4dwZrzOFydmJYD5Q4Ohh/f+6PgyABC5XTKhMR6Z3k1p0uEFAHF/zpOpx82Cov1czGyGkWHlO8xbhbaOaExrHd1SI+j38yYFjpTogorUxqLN4KwCHg5aA6mIeVhZ/Hcej7UpLRCd3uzpa9YIiHcjCsQtj/R3yo43OzQDbvyd46ImGv96ReJ8S1XJwVcIH6G6mFd6SzhCXfb1coPsIPEwFivapekrJxsUrDRZy/ZjUD7Qw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(66476007)(66556008)(5660300002)(66946007)(478600001)(30864003)(83380400001)(6666004)(52116002)(86362001)(31686004)(110136005)(6486002)(16526019)(8676002)(186003)(8936002)(316002)(16576012)(2616005)(36756003)(31696002)(2906002)(53546011)(956004)(4326008)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s0jeuIEzHZ08lWeZd8yMd+laSbE3Nv5zMaLmVg4eT1n09Ivf+ROjPY0bImWPZdcUL5FMa0HGGE57VZLZMxFMwwOCrCbnP9PZvxcXxWrP7HZ4Pi1ej1eFDybAWpoMLDQGpEF/3+SuIleToEv0u8e4mezRsS3kH9IJCuFOIQ1q2HBGCzwh+QG0k0gATpzois+5lE87mDQut++fFDOA621CfU4B8dIlNpAMZh7OPZrJRfndJ5Jao3sc0/oleWCgEwSHo8cNBaSgYKViyQAB1cbIS4qv0tRFtM4+A2V5iLLlUBNzCCCVdfKh2wQHYXIqjBqDfyY7lSaet94kN2Fa2Qc2VeI+UZGNwOTUojN+V5iablzaMMB51Sq3TGj1/tTqudDZqQQukCAPuMfn80FvBYwEZKv7Y82Mk0CnD1EhkzQjrmtFE86NXgEbNYdVjFKmg2sD7UD/5Mc0L0zhWuhKGFrMzOT/sK73bWP081ZpG6ja0rGSrrNrJh7qmlbziIa4u8cy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c5f65-38cb-492b-77ae-08d82f5377e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 21:58:01.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch6Xa0Wq9sbHrf+c8A7/W4fPvzYOve6QT3hbKer7psVYZF4ygpn2RYGpC+ch09c+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3406
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-07-23 5:41 p.m., Joshi, Mukul wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Thursday, July 23, 2020 5:27 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
>
>
>
> On 2020-07-22 12:08 p.m., Mukul Joshi wrote:
>> Add support for reporting thermal throttling events through SMI.
>> Also, add a counter to count the number of throttling interrupts
>> observed and report the count in the SMI event message.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  4 ++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 ++
>>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 68 ++++++++++++++-----
>>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
>>    drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
>>    drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
>>    .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>>    drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 ++
>>    include/uapi/linux/kfd_ioctl.h                |  3 +-
>>    10 files changed, 75 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 1b865fed74ca..19e4658756d8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -755,4 +755,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>>    void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
>>    {
>>    }
>> +
>> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t
>> +throttle_bitmask) { }
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 3f2b695cf19e..e8b0258aae24 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -269,5 +269,6 @@ int kgd2kfd_resume_mm(struct mm_struct *mm);
>>    int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>>    					       struct dma_fence *fence);
>>    void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
>> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t
>> +throttle_bitmask);
>>    
>>    #endif /* AMDGPU_AMDKFD_H_INCLUDED */ diff --git
>> a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 4bfedaab183f..d5e790f046b4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -29,6 +29,7 @@
>>    #include "cwsr_trap_handler.h"
>>    #include "kfd_iommu.h"
>>    #include "amdgpu_amdkfd.h"
>> +#include "kfd_smi_events.h"
>>    
>>    #define MQD_SIZE_ALIGNED 768
>>    
>> @@ -1245,6 +1246,12 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
>>    	WARN_ONCE(count < 0, "Compute profile ref. count error");
>>    }
>>    
>> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t
>> +throttle_bitmask) {
>> +	if (kfd)
>> +		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask); }
>> +
>>    #if defined(CONFIG_DEBUG_FS)
>>    
>>    /* This function will send a package to HIQ to hang the HWS diff
>> --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> index 7b348bf9df21..00c90b47155b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -24,6 +24,7 @@
>>    #include <linux/wait.h>
>>    #include <linux/anon_inodes.h>
>>    #include <uapi/linux/kfd_ioctl.h>
>> +#include "amdgpu.h"
>>    #include "amdgpu_vm.h"
>>    #include "kfd_priv.h"
>>    #include "kfd_smi_events.h"
>> @@ -148,6 +149,55 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>>    	return 0;
>>    }
>>    
>> +static void add_event_to_kfifo(struct kfd_dev *dev, unsigned long long smi_event,
>> +			      char *event_msg, int len)
>> +{
>> +	struct kfd_smi_client *client;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
>> +		if (!(READ_ONCE(client->events) & smi_event))
>> +			continue;
>> +		spin_lock(&client->lock);
>> +		if (kfifo_avail(&client->fifo) >= len) {
>> +			kfifo_in(&client->fifo, event_msg, len);
>> +			wake_up_all(&client->wait_queue);
>> +		} else {
>> +			pr_debug("smi_event(EventID: %llu): no space left\n",
>> +					smi_event);
>> +		}
>> +		spin_unlock(&client->lock);
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
>> +
>> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>> +					     uint32_t throttle_bitmask)
>> +{
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
>> +	/*
>> +	 * ThermalThrottle msg = gpu_id(4):throttle_bitmask(4):
> gpu_id is not needed. The user calls ioctl with GPU specified and KFD returns an anonymous fd. Read from this anon_fd already identify the GPU.
>
> I agree with you. But I would prefer to keep gpu_id in the SMI event message. The benefit is it explicitly identifies the GPU sending the message. This way user-space doesn't need to maintain an internal mapping of anon_fd to gpu_id.
We want to keep the message as short as possible so the 1K kfifo can 
contain more events in case multiple events rush in and the user doesn't 
consume fast enough. For the same reason vmfault event doesn't log 
gpu_id. On the user side, the user shouldn't need to do the 
anon_fd/gpu_id convert. That information should be already in their 
structure. Instead of reading/parsing the message, the user reads from 
their structure.
>
> Regards,
> Mukul
>
>> +	 * 			 thermal_interrupt_count(8):
>> +	 * 16 bytes event + 1 byte space + 4 bytes gpu_id + 1 byte : +
>> +	 * 4 byte throttle_bitmask + 1 byte : +
>> +	 * 8 byte thermal_interupt_counter + 1 byte \n = 36
>> +	 */
>> +	char fifo_in[36];
>> +	int len;
>> +
>> +	if (list_empty(&dev->smi_clients))
>> +		return;
>> +
>> +	len = snprintf(fifo_in, 36, "%x %x:%x:%llx\n",
>> +		       KFD_SMI_EVENT_THERMAL_THROTTLE,
>> +		       dev->id, throttle_bitmask,
>> +		       atomic64_read(&adev->smu.throttle_int_counter));
>> +
>> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in,
>> +len); }
>> +
>>    void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>>    {
>>    	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd; @@
>> -156,7 +206,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>>    	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
>>    	 */
>>    	char fifo_in[43];
>> -	struct kfd_smi_client *client;
>>    	int len;
>>    
>>    	if (list_empty(&dev->smi_clients))
>> @@ -171,22 +220,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>>    	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
>>    		task_info.pid, task_info.task_name);
>>    
>> -	rcu_read_lock();
>> -
>> -	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
>> -		if (!(READ_ONCE(client->events) & KFD_SMI_EVENT_VMFAULT))
>> -			continue;
>> -		spin_lock(&client->lock);
>> -		if (kfifo_avail(&client->fifo) >= len) {
>> -			kfifo_in(&client->fifo, fifo_in, len);
>> -			wake_up_all(&client->wait_queue);
>> -		}
>> -		else
>> -			pr_debug("smi_event(vmfault): no space left\n");
>> -		spin_unlock(&client->lock);
>> -	}
>> -
>> -	rcu_read_unlock();
>> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>>    }
>>    
>>    int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd) diff --git
>> a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> index a9cb218fef96..15537b2cccb5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> @@ -25,5 +25,7 @@
>>    
>>    int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
>>    void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t
>> pasid);
>> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>> +					     uint32_t throttle_bitmask);
>>    
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> index b197dcaed064..52b52cbb90e2 100644
>> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> @@ -639,6 +639,7 @@ static int smu_sw_init(void *handle)
>>    	mutex_init(&smu->message_lock);
>>    
>>    	INIT_WORK(&smu->throttling_logging_work,
>> smu_throttling_logging_work_fn);
>> +	atomic64_set(&smu->throttle_int_counter, 0);
>>    	smu->watermarks_bitmap = 0;
>>    	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>    	smu->default_power_profile_mode =
>> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> index 9b68760dd35b..eb3a57593f69 100644
>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> @@ -2251,6 +2251,7 @@ static void
>> arcturus_log_thermal_throttling_event(struct smu_context *smu)
>>    
>>    	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
>>    			log_buf);
>> +	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
>>    }
>>    
>>    static const struct pptable_funcs arcturus_ppt_funcs = { diff --git
>> a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
>> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
>> index 896b443f1ce8..18ba421c59bd 100644
>> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
>> @@ -446,6 +446,7 @@ struct smu_context
>>    	bool dc_controlled_by_gpio;
>>    
>>    	struct work_struct throttling_logging_work;
>> +	atomic64_t throttle_int_counter;
>>    };
>>    
>>    struct i2c_adapter;
>> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
>> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
>> index fd82402065e6..a9453ec01619 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
>> @@ -1311,6 +1311,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>    				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
>>    				break;
>>    			case 0x7:
>> +				/*
>> +				 * Increment the throttle interrupt counter
>> +				 */
>> +				atomic64_inc(&smu->throttle_int_counter);
>> +
>>    				if (!atomic_read(&adev->throttling_logging_enabled))
>>    					return 0;
>>    
>> diff --git a/include/uapi/linux/kfd_ioctl.h
>> b/include/uapi/linux/kfd_ioctl.h index f738c3b53f4e..df6c7a43aadc
>> 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -450,7 +450,8 @@ struct kfd_ioctl_import_dmabuf_args {
>>     * KFD SMI(System Management Interface) events
>>     */
>>    /* Event type (defined by bitmask) */
>> -#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
>> +#define KFD_SMI_EVENT_VMFAULT			0x0000000000000001
>> +#define KFD_SMI_EVENT_THERMAL_THROTTLE		0x0000000000000002
>>    
>>    struct kfd_ioctl_smi_events_args {
>>    	__u32 gpuid;	/* to KFD */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
