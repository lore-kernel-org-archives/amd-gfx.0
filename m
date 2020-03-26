Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B766C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094732070A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZoQieZrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094732070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA26C6E922;
	Thu, 26 Mar 2020 20:53:58 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992DC6E922
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARleBgvn2zdCq/kbrQyhDHjjVes2VhEf+qSD1KNSOv6pTUAv7wVxZb44Ls+laJTQzwdW3/SY2HX3shRaRRd5mknIsao0zuEAbpiBxm+ru9qLZHmXuURIoPwBZM3WrZYupJ3xwnONbpAFdZZojS7plUR8Ut6waP3IOFib3dFmrubabc50bM2iajE/y5K5hKOFIp3jvOqtkxmmrptTs/zGuvLfKOGJvmQbg+/59LWCW1AJ7WAjxp4fqxzy36U5cJq1CGH9/Uh5CCmp2/CkZK16UBneS/mPebvhnDd2QKU9SSpTEe4ZdwqcA/5vB8rXtYNalGXJmnxC502b4JUHTa0qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50qGuBFKXAxlWM8LUzglfYOnABVO1ycZdarAfWExet8=;
 b=dmRUS01BQOTJ9CJeT0RQLFA3b4hpfHSAmE1abTc08bddAOBHL3UwAGdMDXLqerFDrg67ldeenJ9LVmCYb9wX0xkWmLyFDLias81T9mFfMw6zGr9l63Ha5GpVNQ5JgfxPAfPQClQA169hzkicnwZh2/fFjxqe1kfOoyWBeRBWHLNhjOxXfZm7tO2kS1vbC7RpY6fOc7jwEJe4yzzJFhddm/IZQV36J2L9TJsgUFFnKyJaJsvjgaNbd98hnzSSOf7AUfvVB4vftv+CMmOhPuUf85U7LGmZ2oufsOqDZHtTg4mxYG4AmJh8E9zJx+m90dsv2GSoVSzDsj8cJ07CbBS/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50qGuBFKXAxlWM8LUzglfYOnABVO1ycZdarAfWExet8=;
 b=ZoQieZrmlBuHWJZYKifQaVeFpxVYM1rK04CqcVq8w0bHnpsBb7JiRvCuj/VzVTWY8+4EhOLVEr3feCndpNaav3H7deLV2p4e+wDm4Q/1XPQaxRgtxyxMkLyyZn0pSkS6rGDEvYYeD+sat41WDMVs4BgbUdTSU3oTZ1U56PQRQpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Thu, 26 Mar
 2020 20:53:55 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2835.021; Thu, 26 Mar 2020
 20:53:55 +0000
Subject: Re: [PATCH] drm/amdkfd: Provide SMI events watch
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <1584467823-31170-1-git-send-email-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ee4dc24e-4d47-7c8b-af23-788e90d234da@amd.com>
Date: Thu, 26 Mar 2020 16:53:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <1584467823-31170-1-git-send-email-Amber.Lin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.81] (165.204.55.211) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Thu, 26 Mar 2020 20:53:55 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4b47949-87a4-4416-bb16-08d7d1c7cc5b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:|SN1PR12MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB251099774AE801630AB7FEE592CF0@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(66556008)(66476007)(6486002)(31696002)(2616005)(956004)(16576012)(66946007)(8676002)(30864003)(316002)(478600001)(52116002)(36756003)(44832011)(81166006)(8936002)(86362001)(81156014)(2906002)(16526019)(5660300002)(26005)(31686004)(53546011)(33964004)(186003)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2510;
 H:SN1PR12MB2414.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HK8hcR0u3+nqnheRNdrLcZ4rvmStDVjcNHd8B2NLoPObqeceaBviEMPfkustIzeew+aW18m51BlGgWBJ+ioevvSn81uF8pXnIPz0uLkv6qSoQemeBnH2xrX+0HzEYtnc+bO2/RPBPoKgAfk+kVZyo7lqHdSZVIpxS87UUMNkFXO/UIxVSWA4JqWgLRlsQx8q3ut675ACEEdD4TlsR42rMYcFrneiznEdOx2TwY5DDf56XGO3BTGh3KJq0ugmwISigkqZ8OgdTvuRgOe5LW02HN+L0y8fK2eMqoe2Otq1hCPH5evQ1GNT+SehG7jgfqK050bRT086U28Hj/sE8fl+KY/7+2+xnTkBAsp643RfDV5Uz+zx5YP4n7uZqm8FNJWby2TFDY/Rl19dDpii15ylk7+e/DCX8aAW+V2vro1EBSgoatGOI1MtgBch4SR5tuSy
X-MS-Exchange-AntiSpam-MessageData: ooP02ptZLr4M/Bs0xZTjaRih0bAPdLuckeTPrk2wvp6m42BjZZUBfKFyNibxyuhG8cOkCyZ6gMLjkVcDeZtSeOQnpPt5WMQbCxFPNdHpnK25mwCs6O3gRDojj6zO/XMDihc4drT8MGyCgbYd0+OwTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b47949-87a4-4416-bb16-08d7d1c7cc5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:53:55.6383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvwx91ItFssCUDYG633qvA2y3cz1TeR54AUux8bKDdJ1dCnd8EdjkHylIMwk6GIDYXwMVbfixFjw/pbAfLiOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
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
Content-Type: multipart/mixed; boundary="===============1470175546=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1470175546==
Content-Type: multipart/alternative;
 boundary="------------631443699BB1BE99F16E697D"
Content-Language: en-US

--------------631443699BB1BE99F16E697D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amber,

I see that this is based on the debugger event code. Jon and I are just 
working through some issues with that code. The lessons from that will 
need to be applied to this as well. But I think we can define your API 
to simplify this a bit.

The basic problem is, that we have one Fifo in the kfd_device, but 
potentially multiple file descriptors referring to it. For the event 
interface I think we can enforce only a single file descriptor per 
device. If there is already one, your register call can fail. See more 
comments inline.

On 2020-03-17 13:57, Amber Lin wrote:
> When the compute is malfunctioning or performance drops, the system admin
> will use SMI (System Management Interface) tool to monitor/diagnostic what
> went wrong. This patch provides an event watch interface for the user
> space to register events they are interested. After the event is
> registered, the user can use annoymous file descriptor's pull function

pull -> poll


> with wait-time specified to wait for the event to happen. Once the event
> happens, the user can use read() to retrieve information related to the
> event.
>
> VM fault event is done in this patch.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/Makefile              |   3 +-
>   drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  38 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  10 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 143 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  41 +++++++
>   include/uapi/linux/kfd_ioctl.h                   |  27 ++++-
>   9 files changed, 265 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 6147462..cc98b4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -53,7 +53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>   		$(AMDKFD_PATH)/kfd_int_process_v9.o \
>   		$(AMDKFD_PATH)/kfd_dbgdev.o \
>   		$(AMDKFD_PATH)/kfd_dbgmgr.o \
> -		$(AMDKFD_PATH)/kfd_crat.o
> +		$(AMDKFD_PATH)/kfd_crat.o \
> +		$(AMDKFD_PATH)/kfd_smi_events.o
>   
>   ifneq ($(CONFIG_AMD_IOMMU_V2),)
>   AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba9..24b4717 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -24,6 +24,7 @@
>   #include "kfd_events.h"
>   #include "cik_int.h"
>   #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>   
>   static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>   					const uint32_t *ih_ring_entry,
> @@ -107,6 +108,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
>   		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
>   		struct kfd_vm_fault_info info;
>   
> +		kfd_smi_event_update_vmfault(dev, pasid);
>   		kfd_process_vm_fault(dev->dqm, pasid);
>   
>   		memset(&info, 0, sizeof(info));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f8fa03a..8e92956 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -39,6 +39,7 @@
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_dbgmgr.h"
>   #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>   
>   static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>   static int kfd_open(struct inode *, struct file *);
> @@ -1243,6 +1244,40 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>   	return ret;
>   }
>   
> +/* Handle requests for watching SMI events */
> +static int kfd_ioctl_smi_events(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_smi_events_args *args = data;
> +	struct kfd_dev *dev;
> +	int ret = 0;
> +
> +	dev = kfd_device_by_id(args->gpu_id);
> +	if (!dev)
> +		return -EINVAL;
> +
> +	switch (args->op) {
> +	case KFD_SMI_EVENTS_REGISTER:
> +		ret = kfd_smi_event_register(dev, args->events);
> +		if (ret >= 0) {
> +			/* When the registration is successful, it returns the
> +			 * annoymous inode. Pass it to the user in data1
> +			 */
> +			args->data1 = ret;
> +			ret = 0;

You could return the file descriptor as the return value. On success it 
returns a positive fd. On failure it returns a negative error code.


> +		}
> +		break;
> +	case KFD_SMI_EVENTS_UNREGISTER:
> +		kfd_smi_event_unregister(dev, args->events);

Register seems to do two things: create a file descriptor, and subscribe 
to specific events. This unregister function only affects the 
subscription but not the file descriptor. I'd suggest a cleaner API:

  * Register: creates the file descriptor
  * Subscribe: enables/disables subscription to specific events

The unregistration is done implicitly by closing the file descriptor, so 
there is no explicit ioctl API call for this.


> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>   {
>   	struct kfd_local_mem_info mem_info;
> @@ -1827,6 +1862,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
>   			kfd_ioctl_alloc_queue_gws, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
> +			kfd_ioctl_smi_events, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7866cd06..450368c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -532,6 +532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>   	kfd->device_info = device_info;
>   	kfd->pdev = pdev;
>   	kfd->init_complete = false;
> +	kfd->smi_events.events = 0;
>   	kfd->kfd2kgd = f2g;
>   	atomic_set(&kfd->compute_profile, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75e..151e83e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -24,6 +24,7 @@
>   #include "kfd_events.h"
>   #include "soc15_int.h"
>   #include "kfd_device_queue_manager.h"
> +#include "kfd_smi_events.h"
>   
>   static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>   					const uint32_t *ih_ring_entry,
> @@ -117,6 +118,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		info.prot_read  = ring_id & 0x10;
>   		info.prot_write = ring_id & 0x20;
>   
> +		kfd_smi_event_update_vmfault(dev, pasid);
>   		kfd_process_vm_fault(dev->dqm, pasid);
>   		kfd_signal_vm_fault_event(dev, pasid, &info);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 43b888b..fdb51de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -223,6 +223,13 @@ struct kfd_vmid_info {
>   	uint32_t vmid_num_kfd;
>   };
>   
> +struct kfd_smi_events {
> +	uint64_t events;
> +	struct kfifo fifo;
> +	wait_queue_head_t wait_queue;
> +	uint32_t max_events;
> +};
> +
>   struct kfd_dev {
>   	struct kgd_dev *kgd;
>   
> @@ -309,6 +316,9 @@ struct kfd_dev {
>   
>   	/* Global GWS resource shared b/t processes*/
>   	void *gws;
> +
> +	/* if this device is in SMI events watch */
> +	struct kfd_smi_events smi_events;
>   };
>   
>   enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> new file mode 100644
> index 0000000..ba9d036
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/poll.h>
> +#include <linux/wait.h>
> +#include <linux/anon_inodes.h>
> +#include <uapi/linux/kfd_ioctl.h>
> +#include "amdgpu_vm.h"
> +#include "kfd_priv.h"
> +#include "kfd_smi_events.h"
> +
> +static DEFINE_MUTEX(kfd_smi_mutex);
> +
> +struct mutex *kfd_get_smi_mutex(void)
> +{
> +	return &kfd_smi_mutex;
> +}
> +
> +static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
> +static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
> +static int kfd_smi_ev_release(struct inode *, struct file *);
> +
> +static const char kfd_smi_name[] = "kfd_smi_ev";
> +
> +static const struct file_operations kfd_smi_ev_fops = {
> +	.owner = THIS_MODULE,
> +	.poll = kfd_smi_ev_poll,
> +	.read = kfd_smi_ev_read,
> +	.release = kfd_smi_ev_release
> +};
> +
> +static __poll_t kfd_smi_ev_poll(struct file *filep,
> +				struct poll_table_struct *wait)
> +{
> +	struct kfd_dev *dev = filep->private_data;
> +	struct kfd_smi_events *ev = &dev->smi_events;
> +
> +	__poll_t mask = 0;
> +
> +	poll_wait(filep, &ev->wait_queue, wait);
> +	mask |= !kfifo_is_empty(&ev->fifo) ? POLLIN | POLLRDNORM : mask;
> +
> +	return mask;
> +}
> +
> +static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
> +			       size_t size, loff_t *offset)
> +{
> +	int ret, copied = 0;
> +	struct kfd_dev *dev = filep->private_data;
> +
> +	ret = kfifo_to_user(&dev->smi_events.fifo, user, size, &copied);
> +	if (ret || !copied) {
> +		pr_debug("kfd smi-events: Fail to read fd (%i) (%i)\n",
> +				ret, copied);
> +		return ret ? ret : -EAGAIN;
> +	}
> +
> +	return copied;
> +}
> +
> +static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> +{
> +	struct kfd_dev *dev = filep->private_data;
> +
> +	kfifo_free(&dev->smi_events.fifo);
> +	return 0;
> +}
> +
> +void kfd_smi_event_update_vmfault(struct kfd_dev *kdev, uint16_t pasid)
> +{
> +	struct kfd_smi_vmfault_fifo fifo_out;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
> +	struct amdgpu_task_info task_info;
> +
> +	if (!kdev->smi_events.events)
> +		return;

This condition is redundant.


> +
> +	if (!(kdev->smi_events.events & KFD_SMI_EV_VMFAULT))
> +		return;
> +
> +	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> +	amdgpu_vm_get_task_info(adev, pasid, &task_info);
> +
> +	fifo_out.group = 0;
> +	fifo_out.event = KFD_SMI_EV_VMFAULT;
> +	fifo_out.gpu_id = kdev->id;
> +	fifo_out.pid = task_info.pid;
> +	strcpy(fifo_out.task_name, task_info.task_name);
> +	kfifo_in(&kdev->smi_events.fifo, &fifo_out, sizeof(fifo_out));
> +	wake_up_all(&kdev->smi_events.wait_queue);
> +}
> +
> +void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events)
> +{
> +	mutex_lock(kfd_get_smi_mutex());
> +	dev->smi_events.events &= ~events;
> +	mutex_unlock(kfd_get_smi_mutex());
> +}
> +
> +int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events)
> +{
> +	int ret;
> +
> +	mutex_lock(kfd_get_smi_mutex());
> +	dev->smi_events.events |= events;
> +	mutex_unlock(kfd_get_smi_mutex());
> +
> +	/* We use the lower 32 bits for now. Each bit represents one event. If
> +	 * featured events are increased to more than 32, we'll use the upper
> +	 * bits as groups so the total number of events can be up to 32*32.
> +	 */
> +	dev->smi_events.max_events = 32;

I don't understand the explanation above. It seems to refer to the event 
subscription mechanism. But you use this as the size of the fifo. That's 
the size in bytes. Your struct kfd_smi_vmfault_fifo is bigger than that, 
so even a single entry will overflow your FIFO queue.


> +	ret = kfifo_alloc(&dev->smi_events.fifo, dev->smi_events.max_events,
> +			 GFP_KERNEL);
> +	if (ret) {
> +		pr_err("fail to allocate kfifo\n");
> +		return ret;
> +	}
> +	init_waitqueue_head(&dev->smi_events.wait_queue);
> +
> +	return anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops,
> +				(void *)dev, 0);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> new file mode 100644
> index 0000000..2e320d3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef KFD_SMI_EVENTS_H_INCLUDED
> +#define KFD_SMI_EVENTS_H_INCLUDED
> +
> +int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events);
> +void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events);
> +void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
> +
> +/* All FIFO must start with "uint32_t group" and "uint32_t event" so the user
> + * can read the first 8 bytes to determine the next read length.

Note about terminology: FIFO refers to a fifo queue. I think you're 
using it to describe an entry or record in the FIFO.

I don't know why you need to split group and event? The event mask is 
only 64-bit, so there can be no more than 64 events.

> + */
> +struct kfd_smi_vmfault_fifo {
> +	uint32_t group;
> +	uint32_t event;
> +	unsigned int gpu_id;

The gpu_id is redundant because the file descriptor used to read the 
events is associated with a kfd_dev (GPU). If you want to have a single 
fifo, you should change the register API to not require a gpu_id and the 
fifo should be global, not a member of the kfd_dev.


> +	pid_t pid;
> +	char task_name[TASK_COMM_LEN];
> +};

This needs to be part of the user API because usermode needs to parse 
this structure. So it should be defined in kfd_ioctl.h. In your proposed 
API I think the size of the FIFO entry is implied by the event type. It 
would be cleaner to separate the FIFO entries into a header and payload. 
The header would be the same for all events and doesn't need to be 
duplicated in each event structure. It would contain the event type and 
size (to allow variable size events). The payload would depend on the 
event type.


> +
> +#endif
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 4f66764..6ce7c69 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -442,6 +442,28 @@ struct kfd_ioctl_import_dmabuf_args {
>   	__u32 dmabuf_fd;	/* to KFD */
>   };
>   
> +/*
> + * KFD SMI(System Management Interface) events
> + */
> +enum kfd_smi_events_op {
> +	KFD_SMI_EVENTS_REGISTER = 1,
> +	KFD_SMI_EVENTS_UNREGISTER
> +};
> +
> +/* Event ID (mask) */
> +#define KFD_SMI_EV_VMFAULT     0x00000001
> +
> +struct kfd_ioctl_smi_events_args {
> +	__u32 op;       /* to KFD */
> +	/* upper 32 bits: group. lower 32 bits: event IDs */
> +	__u64 events;   /* to KFD */
> +	__u32 gpu_id;   /* to KFD */
> +	pid_t pid;      /* to KFD */
> +	__u32 data1;    /* from KFD */
> +	__u32 data2;
> +	__u32 data3;

This looks like you copied it from the debug API.  pid, data1-3 are not 
used by your API. I think gpu_id should not be used either if you want 
the event FIFO to be global.

Regards,
   Felix


> +};
> +
>   /* Register offset inside the remapped mmio page
>    */
>   enum kfd_mmio_remap {
> @@ -546,7 +568,10 @@ enum kfd_mmio_remap {
>   #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
>   		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>   
> +#define AMDKFD_IOC_SMI_EVENTS			\
> +		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x1F
> +#define AMDKFD_COMMAND_END		0x20
>   
>   #endif

--------------631443699BB1BE99F16E697D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Amber,</p>
    <p>I see that this is based on the debugger event code. Jon and I
      are just working through some issues with that code. The lessons
      from that will need to be applied to this as well. But I think we
      can define your API to simplify this a bit.</p>
    <p>The basic problem is, that we have one Fifo in the kfd_device,
      but potentially multiple file descriptors referring to it. For the
      event interface I think we can enforce only a single file
      descriptor per device. If there is already one, your register call
      can fail. See more comments inline.<br>
    </p>
    <div class="moz-cite-prefix">On 2020-03-17 13:57, Amber Lin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">When the compute is malfunctioning or performance drops, the system admin
will use SMI (System Management Interface) tool to monitor/diagnostic what
went wrong. This patch provides an event watch interface for the user
space to register events they are interested. After the event is
registered, the user can use annoymous file descriptor's pull function</pre>
    </blockquote>
    <p>pull -&gt; poll<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
with wait-time specified to wait for the event to happen. Once the event
happens, the user can use read() to retrieve information related to the
event.

VM fault event is done in this patch.

Signed-off-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/Makefile              |   3 &#43;-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  38 &#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   1 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  10 &#43;&#43;
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 143 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  41 &#43;&#43;&#43;&#43;&#43;&#43;&#43;
 include/uapi/linux/kfd_ioctl.h                   |  27 &#43;&#43;&#43;&#43;-
 9 files changed, 265 insertions(&#43;), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 6147462..cc98b4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,7 &#43;53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
-		$(AMDKFD_PATH)/kfd_crat.o
&#43;		$(AMDKFD_PATH)/kfd_crat.o \
&#43;		$(AMDKFD_PATH)/kfd_smi_events.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES &#43;= $(AMDKFD_PATH)/kfd_iommu.o
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 9f59ba9..24b4717 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -24,6 &#43;24,7 @@
 #include &quot;kfd_events.h&quot;
 #include &quot;cik_int.h&quot;
 #include &quot;amdgpu_amdkfd.h&quot;
&#43;#include &quot;kfd_smi_events.h&quot;
 
 static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -107,6 &#43;108,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 		ihre-&gt;source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
 		struct kfd_vm_fault_info info;
 
&#43;		kfd_smi_event_update_vmfault(dev, pasid);
 		kfd_process_vm_fault(dev-&gt;dqm, pasid);
 
 		memset(&amp;info, 0, sizeof(info));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a..8e92956 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 &#43;39,7 @@
 #include &quot;kfd_device_queue_manager.h&quot;
 #include &quot;kfd_dbgmgr.h&quot;
 #include &quot;amdgpu_amdkfd.h&quot;
&#43;#include &quot;kfd_smi_events.h&quot;
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1243,6 &#43;1244,40 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	return ret;
 }
 
&#43;/* Handle requests for watching SMI events */
&#43;static int kfd_ioctl_smi_events(struct file *filep,
&#43;				struct kfd_process *p, void *data)
&#43;{
&#43;	struct kfd_ioctl_smi_events_args *args = data;
&#43;	struct kfd_dev *dev;
&#43;	int ret = 0;
&#43;
&#43;	dev = kfd_device_by_id(args-&gt;gpu_id);
&#43;	if (!dev)
&#43;		return -EINVAL;
&#43;
&#43;	switch (args-&gt;op) {
&#43;	case KFD_SMI_EVENTS_REGISTER:
&#43;		ret = kfd_smi_event_register(dev, args-&gt;events);
&#43;		if (ret &gt;= 0) {
&#43;			/* When the registration is successful, it returns the
&#43;			 * annoymous inode. Pass it to the user in data1
&#43;			 */
&#43;			args-&gt;data1 = ret;
&#43;			ret = 0;</pre>
    </blockquote>
    <p>You could return the file descriptor as the return value. On
      success it returns a positive fd. On failure it returns a negative
      error code.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;		}
&#43;		break;
&#43;	case KFD_SMI_EVENTS_UNREGISTER:
&#43;		kfd_smi_event_unregister(dev, args-&gt;events);</pre>
    </blockquote>
    <p>Register seems to do two things: create a file descriptor, and
      subscribe to specific events. This unregister function only
      affects the subscription but not the file descriptor. I'd suggest
      a cleaner API:</p>
    <ul>
      <li>Register: creates the file descriptor</li>
      <li>Subscribe: enables/disables subscription to specific events<br>
      </li>
    </ul>
    <p>The unregistration is done implicitly by closing the file
      descriptor, so there is no explicit ioctl API call for this.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;		break;
&#43;	default:
&#43;		ret = -EINVAL;
&#43;		break;
&#43;	}
&#43;
&#43;	return ret;
&#43;}
&#43;
 bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 {
 	struct kfd_local_mem_info mem_info;
@@ -1827,6 &#43;1862,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
&#43;
&#43;	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
&#43;			kfd_ioctl_smi_events, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7866cd06..450368c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -532,6 &#43;532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	kfd-&gt;device_info = device_info;
 	kfd-&gt;pdev = pdev;
 	kfd-&gt;init_complete = false;
&#43;	kfd-&gt;smi_events.events = 0;
 	kfd-&gt;kfd2kgd = f2g;
 	atomic_set(&amp;kfd-&gt;compute_profile, 0);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75e..151e83e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -24,6 &#43;24,7 @@
 #include &quot;kfd_events.h&quot;
 #include &quot;soc15_int.h&quot;
 #include &quot;kfd_device_queue_manager.h&quot;
&#43;#include &quot;kfd_smi_events.h&quot;
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -117,6 &#43;118,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_read  = ring_id &amp; 0x10;
 		info.prot_write = ring_id &amp; 0x20;
 
&#43;		kfd_smi_event_update_vmfault(dev, pasid);
 		kfd_process_vm_fault(dev-&gt;dqm, pasid);
 		kfd_signal_vm_fault_event(dev, pasid, &amp;info);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b..fdb51de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -223,6 &#43;223,13 @@ struct kfd_vmid_info {
 	uint32_t vmid_num_kfd;
 };
 
&#43;struct kfd_smi_events {
&#43;	uint64_t events;
&#43;	struct kfifo fifo;
&#43;	wait_queue_head_t wait_queue;
&#43;	uint32_t max_events;
&#43;};
&#43;
 struct kfd_dev {
 	struct kgd_dev *kgd;
 
@@ -309,6 &#43;316,9 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
&#43;
&#43;	/* if this device is in SMI events watch */
&#43;	struct kfd_smi_events smi_events;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
new file mode 100644
index 0000000..ba9d036
--- /dev/null
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 &#43;1,143 @@
&#43;/*
&#43; * Copyright 2020 Advanced Micro Devices, Inc.
&#43; *
&#43; * Permission is hereby granted, free of charge, to any person obtaining a
&#43; * copy of this software and associated documentation files (the &quot;Software&quot;),
&#43; * to deal in the Software without restriction, including without limitation
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublicense,
&#43; * and/or sell copies of the Software, and to permit persons to whom the
&#43; * Software is furnished to do so, subject to the following conditions:
&#43; *
&#43; * The above copyright notice and this permission notice shall be included in
&#43; * all copies or substantial portions of the Software.
&#43; *
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
&#43; * OTHER DEALINGS IN THE SOFTWARE.
&#43; */
&#43;
&#43;#include &lt;linux/poll.h&gt;
&#43;#include &lt;linux/wait.h&gt;
&#43;#include &lt;linux/anon_inodes.h&gt;
&#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;
&#43;#include &quot;amdgpu_vm.h&quot;
&#43;#include &quot;kfd_priv.h&quot;
&#43;#include &quot;kfd_smi_events.h&quot;
&#43;
&#43;static DEFINE_MUTEX(kfd_smi_mutex);
&#43;
&#43;struct mutex *kfd_get_smi_mutex(void)
&#43;{
&#43;	return &amp;kfd_smi_mutex;
&#43;}
&#43;
&#43;static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
&#43;static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
&#43;static int kfd_smi_ev_release(struct inode *, struct file *);
&#43;
&#43;static const char kfd_smi_name[] = &quot;kfd_smi_ev&quot;;
&#43;
&#43;static const struct file_operations kfd_smi_ev_fops = {
&#43;	.owner = THIS_MODULE,
&#43;	.poll = kfd_smi_ev_poll,
&#43;	.read = kfd_smi_ev_read,
&#43;	.release = kfd_smi_ev_release
&#43;};
&#43;
&#43;static __poll_t kfd_smi_ev_poll(struct file *filep,
&#43;				struct poll_table_struct *wait)
&#43;{
&#43;	struct kfd_dev *dev = filep-&gt;private_data;
&#43;	struct kfd_smi_events *ev = &amp;dev-&gt;smi_events;
&#43;
&#43;	__poll_t mask = 0;
&#43;
&#43;	poll_wait(filep, &amp;ev-&gt;wait_queue, wait);
&#43;	mask |= !kfifo_is_empty(&amp;ev-&gt;fifo) ? POLLIN | POLLRDNORM : mask;
&#43;
&#43;	return mask;
&#43;}
&#43;
&#43;static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
&#43;			       size_t size, loff_t *offset)
&#43;{
&#43;	int ret, copied = 0;
&#43;	struct kfd_dev *dev = filep-&gt;private_data;
&#43;
&#43;	ret = kfifo_to_user(&amp;dev-&gt;smi_events.fifo, user, size, &amp;copied);
&#43;	if (ret || !copied) {
&#43;		pr_debug(&quot;kfd smi-events: Fail to read fd (%i) (%i)\n&quot;,
&#43;				ret, copied);
&#43;		return ret ? ret : -EAGAIN;
&#43;	}
&#43;
&#43;	return copied;
&#43;}
&#43;
&#43;static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
&#43;{
&#43;	struct kfd_dev *dev = filep-&gt;private_data;
&#43;
&#43;	kfifo_free(&amp;dev-&gt;smi_events.fifo);
&#43;	return 0;
&#43;}
&#43;
&#43;void kfd_smi_event_update_vmfault(struct kfd_dev *kdev, uint16_t pasid)
&#43;{
&#43;	struct kfd_smi_vmfault_fifo fifo_out;
&#43;	struct amdgpu_device *adev = (struct amdgpu_device *)kdev-&gt;kgd;
&#43;	struct amdgpu_task_info task_info;
&#43;
&#43;	if (!kdev-&gt;smi_events.events)
&#43;		return;</pre>
    </blockquote>
    <p>This condition is redundant.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;
&#43;	if (!(kdev-&gt;smi_events.events &amp; KFD_SMI_EV_VMFAULT))
&#43;		return;
&#43;
&#43;	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
&#43;	amdgpu_vm_get_task_info(adev, pasid, &amp;task_info);
&#43;
&#43;	fifo_out.group = 0;
&#43;	fifo_out.event = KFD_SMI_EV_VMFAULT;
&#43;	fifo_out.gpu_id = kdev-&gt;id;
&#43;	fifo_out.pid = task_info.pid;
&#43;	strcpy(fifo_out.task_name, task_info.task_name);
&#43;	kfifo_in(&amp;kdev-&gt;smi_events.fifo, &amp;fifo_out, sizeof(fifo_out));
&#43;	wake_up_all(&amp;kdev-&gt;smi_events.wait_queue);
&#43;}
&#43;
&#43;void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events)
&#43;{
&#43;	mutex_lock(kfd_get_smi_mutex());
&#43;	dev-&gt;smi_events.events &amp;= ~events;
&#43;	mutex_unlock(kfd_get_smi_mutex());
&#43;}
&#43;
&#43;int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events)
&#43;{
&#43;	int ret;
&#43;
&#43;	mutex_lock(kfd_get_smi_mutex());
&#43;	dev-&gt;smi_events.events |= events;
&#43;	mutex_unlock(kfd_get_smi_mutex());
&#43;
&#43;	/* We use the lower 32 bits for now. Each bit represents one event. If
&#43;	 * featured events are increased to more than 32, we'll use the upper
&#43;	 * bits as groups so the total number of events can be up to 32*32.
&#43;	 */
&#43;	dev-&gt;smi_events.max_events = 32;</pre>
    </blockquote>
    <p>I don't understand the explanation above. It seems to refer to
      the event subscription mechanism. But you use this as the size of
      the fifo. That's the size in bytes. Your struct
      kfd_smi_vmfault_fifo is bigger than that, so even a single entry
      will overflow your FIFO queue.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;	ret = kfifo_alloc(&amp;dev-&gt;smi_events.fifo, dev-&gt;smi_events.max_events,
&#43;			 GFP_KERNEL);
&#43;	if (ret) {
&#43;		pr_err(&quot;fail to allocate kfifo\n&quot;);
&#43;		return ret;
&#43;	}
&#43;	init_waitqueue_head(&amp;dev-&gt;smi_events.wait_queue);
&#43;
&#43;	return anon_inode_getfd(kfd_smi_name, &amp;kfd_smi_ev_fops,
&#43;				(void *)dev, 0);
&#43;}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
new file mode 100644
index 0000000..2e320d3
--- /dev/null
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -0,0 &#43;1,41 @@
&#43;/*
&#43; * Copyright 2020 Advanced Micro Devices, Inc.
&#43; *
&#43; * Permission is hereby granted, free of charge, to any person obtaining a
&#43; * copy of this software and associated documentation files (the &quot;Software&quot;),
&#43; * to deal in the Software without restriction, including without limitation
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublicense,
&#43; * and/or sell copies of the Software, and to permit persons to whom the
&#43; * Software is furnished to do so, subject to the following conditions:
&#43; *
&#43; * The above copyright notice and this permission notice shall be included in
&#43; * all copies or substantial portions of the Software.
&#43; *
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
&#43; * OTHER DEALINGS IN THE SOFTWARE.
&#43; */
&#43;
&#43;#ifndef KFD_SMI_EVENTS_H_INCLUDED
&#43;#define KFD_SMI_EVENTS_H_INCLUDED
&#43;
&#43;int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events);
&#43;void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events);
&#43;void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
&#43;
&#43;/* All FIFO must start with &quot;uint32_t group&quot; and &quot;uint32_t event&quot; so the user
&#43; * can read the first 8 bytes to determine the next read length.</pre>
    </blockquote>
    <p>Note about terminology: FIFO refers to a fifo queue. I think
      you're using it to describe an entry or record in the FIFO.<br>
    </p>
    <p>I don't know why you need to split group and event? The event
      mask is only 64-bit, so there can be no more than 64 events.<br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43; */
&#43;struct kfd_smi_vmfault_fifo {
&#43;	uint32_t group;
&#43;	uint32_t event;
&#43;	unsigned int gpu_id;</pre>
    </blockquote>
    <p>The gpu_id is redundant because the file descriptor used to read
      the events is associated with a kfd_dev (GPU). If you want to have
      a single fifo, you should change the register API to not require a
      gpu_id and the fifo should be global, not a member of the kfd_dev.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;	pid_t pid;
&#43;	char task_name[TASK_COMM_LEN];
&#43;};</pre>
    </blockquote>
    <p>This needs to be part of the user API because usermode needs to
      parse this structure. So it should be defined in kfd_ioctl.h. In
      your proposed API I think the size of the FIFO entry is implied by
      the event type. It would be cleaner to separate the FIFO entries
      into a header and payload. The header would be the same for all
      events and doesn't need to be duplicated in each event structure.
      It would contain the event type and size (to allow variable size
      events). The payload would depend on the event type.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;
&#43;#endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..6ce7c69 100644
--- a/include/uapi/linux/kfd_ioctl.h
&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 &#43;442,28 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
&#43;/*
&#43; * KFD SMI(System Management Interface) events
&#43; */
&#43;enum kfd_smi_events_op {
&#43;	KFD_SMI_EVENTS_REGISTER = 1,
&#43;	KFD_SMI_EVENTS_UNREGISTER
&#43;};
&#43;
&#43;/* Event ID (mask) */
&#43;#define KFD_SMI_EV_VMFAULT     0x00000001
&#43;
&#43;struct kfd_ioctl_smi_events_args {
&#43;	__u32 op;       /* to KFD */
&#43;	/* upper 32 bits: group. lower 32 bits: event IDs */
&#43;	__u64 events;   /* to KFD */
&#43;	__u32 gpu_id;   /* to KFD */
&#43;	pid_t pid;      /* to KFD */
&#43;	__u32 data1;    /* from KFD */
&#43;	__u32 data2;
&#43;	__u32 data3;</pre>
    </blockquote>
    <p>This looks like you copied it from the debug API.&nbsp; pid, data1-3
      are not used by your API. I think gpu_id should not be used either
      if you want the event FIFO to be global.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1584467823-31170-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;};
&#43;
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 &#43;568,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
 		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
 
&#43;#define AMDKFD_IOC_SMI_EVENTS			\
&#43;		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
&#43;
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x1F
&#43;#define AMDKFD_COMMAND_END		0x20
 
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------631443699BB1BE99F16E697D--

--===============1470175546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1470175546==--
