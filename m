Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CBC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 00:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766BE20659
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 00:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wxct/T4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766BE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B521B6E2A0;
	Thu, 14 May 2020 00:52:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1856E29D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 00:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBGJ0bsZWk/0V6ukmIJ0m5f5tYBmkMIPf3cJkf670f/wNSX40JOmcpy9ZbwcyOgxidDh9+JxTe3t8uj/GLRs1ffrUZnfsdvCVJ6CwUGo0dPYZiPPRtnNe2zzqwWO4rDxJcQY0PoDvhX/V5yt4/Mtm804OBGFphSUwV+VZ1TJ4pzjKRJOkJVKrDvIIfmBA6u2UHxo4P7JjAIKKDnUVoCWZmVzLFtM2ItB96k5auQr3BRGJ4UkX6wxDtJ3+oU7qdUBnLIdcXUE9zmc30VXqHbGBAhzwIOJaJH8QytL7T4Zlw5ExuvabsEfe6k5YteG1tw8A+kTC3BVSRd+4ePlH8mYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFPDamhJhfpqXmd0KCjYWd1QaZBRbdXPgplpxJs3YT8=;
 b=JjQl0WcbyLo/ZWzTOg8UKx30ie2Cb4OYwV3/3+YYD77stCrzHUbXV/EsBc7BsgCjr/zbu3ulsWwQaNB9p7r8X03u4LgulxHNIUABVijUnj9qs1yaP0Da3MFsKptnLG8ON7r0T+Rs205JVcVHrHB+Q5UN6etqZmVxUjgH0djxWk6F0RI7hlFiYvBY0GyBUao+BdQiWyNQ3rPExOwtvCMg9WcZmhdXSriOYTLWWIPvNJgYh3j6Z8pJkA5DoQVo3saIG4dWvmyZ3BH3GGqkHooCTfoNdFRs56q8nAzNZuCiegRXW1pb5F9dPh8E7lgbSPtruAnx1osrOAgVJD9hgQ4oEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFPDamhJhfpqXmd0KCjYWd1QaZBRbdXPgplpxJs3YT8=;
 b=Wxct/T4WneGf94j9SZ+Pkn8Z/m3iz0mGKiW9xcuyhPyHb7aenNwO5gQ/ovkApcWsgcx15c01fvJQ3F/77J5ZSkL+Kk67A1CeBfKFjj2fHirDCTz57GMhTpz/OdY8P4uABPuDyE60XhqFS63rB7+XXt7tm77BwYq2/F4vu+Bc1Sw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 14 May
 2020 00:52:10 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 00:52:10 +0000
Subject: Re: [PATCH] drm/amdkfd: Provide SMI events watch
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <1589398877-28344-1-git-send-email-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d5552eda-ffd5-c733-f5de-a5a1842df1d0@amd.com>
Date: Wed, 13 May 2020 20:52:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1589398877-28344-1-git-send-email-Amber.Lin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::21) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 00:52:09 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99215027-aea1-46fd-e402-08d7f7a10890
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:|SN1PR12MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB251067A21534606EA6446AA192BC0@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMW2drxYQB0Watd4dHiZP4McRRp69z8Nl9GVdzQGsBy0uP+eJ/NNJgDxv1RP6fFl4Yz4+jFZo7mqUKK9528sExXAlI4n4lWhQZfW6eK9glhSLysRjz5khBreJN5DH7rjQ9EDgs/3KwxJ/5RCTXO9Pu/RKJLheCzYbNcAq4iymtL6vG8Z2fsA//DaA4TJNTsCIZBD61MSkbrBcikuyolMcXtjKmMJtfmChTLprVUJzIWSmaV2mGQBVu1HYgU9xzC8TMhXWd7i12KV6mE/uzWv/CB4k/n0oYUJ95l22NvpJnQOeAY1LEkc6hLYEIkEt3QbjaycdTg3kRyTy9VFC18OVnydhswGTeNsVTuY9najrho6dpxsB+cmfiZ4WeEJXKIWX9aycMsYfkK03h3ibUJN9fVV2TGgwvIPBruQGxaDO6oKEpoMddr50aQSU70F9qVasTUWqEnzw4Rn6FDyx7ryvDdKvbw8YM5xZ5tkktOinmltXhDIXyxqo2L8/wNrEHUE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(31686004)(316002)(86362001)(2616005)(66556008)(44832011)(31696002)(30864003)(66476007)(16576012)(66946007)(956004)(52116002)(8676002)(36756003)(186003)(6486002)(478600001)(16526019)(8936002)(5660300002)(26005)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fn70vcCzLuzBlKbO7ABFX27wxD3krXLAqToTOHTsqDhInR2ZdTNt1aEwc2e4Pe1YU3tfcvaEBlx0tQFWag2Ga3j9JjWnQvEwqK7scLa0pnu46N14A/S9dgLEqtgLa2FdONlISD9D+dvtsPDNZ74ac+Qjq0fIw0CsCt53Iq/wrnOTYx+WVG5lv+0OgyIj6KJ6nlvmV+ubXqCqUjigZdsZFQOuuvNVtJA21bDCoEYBVblSL+/n7iZ8kLQET33NjRKoJO+Injmm4PrwAesTTeFJKZ07CjXUFK7PSZmw2BrOQmdT6+CZ5WrTyBR5S9nS1yff2xTT6t6lcKcR5EQV0yQSWsrVxxK0JJuo1AQZTW12hLt7H8/cSiPQ2cmY1GSV5FJ6Dp7fESe10ILCM6OxQcfuqHB678UuNNXdc3UgnQ66vsc0JLg+UV6wKhZ6hLJyyQDn9SIL8n0KaXvA9mKk6qrNkWZqnjtigeXxT8jzZ5ZIHUxFqqNo1hz9cmY3j8Rn7SkL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99215027-aea1-46fd-e402-08d7f7a10890
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 00:52:10.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IflUZ5iWog2caERq2odaI4ZnTdP79mNwtXXVJknR+hzFHiaDUgkHOp+BqkAkpyKuZ8gkRybUa68ooclhE/heMg==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-05-13 um 3:41 p.m. schrieb Amber Lin:
> When the compute is malfunctioning or performance drops, the system admin
> will use SMI (System Management Interface) tool to monitor/diagnostic what
> went wrong. This patch provides an event watch interface for the user
> space to register devices and subscribe events they are interested. After
> registered, the user can use annoymous file descriptor's poll function
> with wait-time specified and wait for events to happen. Once an event
> happens, the user can use read() to retrieve information related to the
> event.
>
> VM fault event is done in this patch.
>
> v2: - remove UNREGISTER and add event ENABLE/DISABLE
>     - correct kfifo usage
>     - move event message API to kfd_ioctl.h
> v3: send the event msg in text than in binary
> v4: support multiple clients
> v5: move events enablement from ioctl to fd write
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/Makefile              |   1 +
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  18 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   7 +
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |   4 +
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 214 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  29 +++
>  include/uapi/linux/kfd_ioctl.h                   |  16 +-
>  9 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 6147462..e1e4115 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -53,6 +53,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>  		$(AMDKFD_PATH)/kfd_int_process_v9.o \
>  		$(AMDKFD_PATH)/kfd_dbgdev.o \
>  		$(AMDKFD_PATH)/kfd_dbgmgr.o \
> +		$(AMDKFD_PATH)/kfd_smi_events.o \
>  		$(AMDKFD_PATH)/kfd_crat.o
>  
>  ifneq ($(CONFIG_AMD_IOMMU_V2),)
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba9..24b4717 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "cik_int.h"
>  #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>  
>  static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>  					const uint32_t *ih_ring_entry,
> @@ -107,6 +108,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
>  		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
>  		struct kfd_vm_fault_info info;
>  
> +		kfd_smi_event_update_vmfault(dev, pasid);
>  		kfd_process_vm_fault(dev->dqm, pasid);
>  
>  		memset(&info, 0, sizeof(info));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf0017f..e9b96ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -39,6 +39,7 @@
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_dbgmgr.h"
>  #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>  
>  static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>  static int kfd_open(struct inode *, struct file *);
> @@ -1740,6 +1741,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  	return r;
>  }
>  
> +/* Handle requests for watching SMI events */
> +static int kfd_ioctl_smi_events(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_smi_events_args *args = data;
> +	struct kfd_dev *dev;
> +
> +	dev = kfd_device_by_id(args->gpuid);
> +	if (!dev)
> +		return -EINVAL;
> +
> +	return kfd_smi_event_open(dev, &args->anon_fd);
> +}
> +
>  #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>  	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>  			    .cmd_drv = 0, .name = #ioctl}
> @@ -1835,6 +1850,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>  
>  	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
>  			kfd_ioctl_alloc_queue_gws, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
> +			kfd_ioctl_smi_events, 0),
>  };
>  
>  #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0491ab2..2c030c2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -586,6 +586,11 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  	return ret;
>  }
>  
> +static void kfd_smi_init(struct kfd_dev *dev) {
> +	INIT_LIST_HEAD(&dev->smi_clients);
> +	spin_lock_init(&dev->smi_lock);
> +}
> +
>  bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  			 struct drm_device *ddev,
>  			 const struct kgd2kfd_shared_resources *gpu_resources)
> @@ -700,6 +705,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  		goto kfd_topology_add_device_error;
>  	}
>  
> +	kfd_smi_init(kfd);
> +
>  	kfd->init_complete = true;
>  	dev_info(kfd_device, "added device %x:%x\n", kfd->pdev->vendor,
>  		 kfd->pdev->device);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75e..151e83e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "soc15_int.h"
>  #include "kfd_device_queue_manager.h"
> +#include "kfd_smi_events.h"
>  
>  static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  					const uint32_t *ih_ring_entry,
> @@ -117,6 +118,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  		info.prot_read  = ring_id & 0x10;
>  		info.prot_write = ring_id & 0x20;
>  
> +		kfd_smi_event_update_vmfault(dev, pasid);
>  		kfd_process_vm_fault(dev->dqm, pasid);
>  		kfd_signal_vm_fault_event(dev, pasid, &info);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index cde5e4c..f70f789 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -309,6 +309,10 @@ struct kfd_dev {
>  
>  	/* Global GWS resource shared b/t processes*/
>  	void *gws;
> +
> +	/* Clients watching SMI events */
> +	struct list_head smi_clients;
> +	spinlock_t smi_lock;
>  };
>  
>  enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> new file mode 100644
> index 0000000..f5fd18e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -0,0 +1,214 @@
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
> +struct kfd_smi_client {
> +	struct list_head list;
> +	struct kfifo fifo;
> +	wait_queue_head_t wait_queue;
> +	/* events enabled */
> +	uint64_t events;
> +	struct kfd_dev *dev;
> +	spinlock_t lock;
> +};
> +
> +#define MAX_KFIFO_SIZE	1024
> +
> +static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
> +static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
> +static ssize_t kfd_smi_ev_write(struct file *, const char __user *, size_t,
> +				loff_t *);
> +static int kfd_smi_ev_release(struct inode *, struct file *);
> +
> +static const char kfd_smi_name[] = "kfd_smi_ev";
> +
> +static const struct file_operations kfd_smi_ev_fops = {
> +	.owner = THIS_MODULE,
> +	.poll = kfd_smi_ev_poll,
> +	.read = kfd_smi_ev_read,
> +	.write = kfd_smi_ev_write,
> +	.release = kfd_smi_ev_release
> +};
> +
> +static __poll_t kfd_smi_ev_poll(struct file *filep,
> +				struct poll_table_struct *wait)
> +{
> +	__poll_t mask;
> +	struct kfd_smi_client *client = filep->private_data;
> +
> +	poll_wait(filep, &client->wait_queue, wait);
> +
> +	spin_lock(&client->lock);
> +	mask = kfifo_is_empty(&client->fifo) ? 0 : POLLIN | POLLRDNORM;
> +	spin_unlock(&client->lock);
> +
> +	return mask;
> +}
> +
> +static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
> +			       size_t size, loff_t *offset)
> +{
> +	int ret;
> +	size_t to_copy;
> +	struct kfd_smi_client *client = filep->private_data;
> +	unsigned char buf[MAX_KFIFO_SIZE];
> +
> +	BUILD_BUG_ON(MAX_KFIFO_SIZE > 1024);
> +
> +	/* kfifo_to_user can sleep so we can't use spinlock protection around
> +	 * it. Instead, we kfifo out as spinlocked then copy them to the user.
> +	 */
> +	spin_lock(&client->lock);
> +	to_copy = kfifo_len(&client->fifo);
> +	if (!to_copy) {
> +		spin_unlock(&client->lock);
> +		return -EAGAIN;
> +	}
> +	to_copy = min3(size, sizeof(buf), to_copy);
> +	ret = kfifo_out(&client->fifo, buf, to_copy);
> +	spin_unlock(&client->lock);
> +	if (ret <= 0)
> +		return -EAGAIN;
> +
> +	ret = copy_to_user(user, buf, to_copy);
> +	if (ret)
> +		return -EFAULT;
> +
> +	return to_copy;
> +}
> +
> +static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
> +				size_t size, loff_t *offset)
> +{
> +	struct kfd_smi_client *client = filep->private_data;
> +	uint64_t events;
> +
> +	if (!access_ok(user, size) || size < sizeof(events))
> +		return -EFAULT;
> +	if (copy_from_user(&events, user, sizeof(events)))
> +		return -EFAULT;
> +
> +	WRITE_ONCE(client->events, events);
> +
> +	return sizeof(events);
> +}
> +
> +static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> +{
> +	struct kfd_smi_client *client = filep->private_data;
> +	struct kfd_dev *dev = client->dev;
> +
> +	spin_lock(&dev->smi_lock);
> +	list_del_rcu(&client->list);
> +	spin_unlock(&dev->smi_lock);
> +
> +	synchronize_rcu();
> +	kfifo_free(&client->fifo);
> +	kfree(client);
> +
> +	return 0;
> +}
> +
> +void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
> +	struct amdgpu_task_info task_info;
> +	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
> +	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
> +	 */
> +	char fifo_in[43];
> +	struct kfd_smi_client *client;
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> +	amdgpu_vm_get_task_info(adev, pasid, &task_info);
> +	/* Report VM faults from user applications, not retry from kernel */
> +	if (!task_info.pid)
> +		return;
> +
> +	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
> +		task_info.pid, task_info.task_name);
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> +		if (!(READ_ONCE(client->events) & KFD_SMI_EVENT_VMFAULT))
> +			continue;
> +		spin_lock(&client->lock);
> +		if (kfifo_avail(&client->fifo) >= len) {
> +			kfifo_in(&client->fifo, fifo_in, len);
> +			wake_up_all(&client->wait_queue);
> +		}
> +		else
> +			pr_debug("smi_event(vmfault): no space left\n");
> +		spin_unlock(&client->lock);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> +{
> +	struct kfd_smi_client *client;
> +	int ret;
> +
> +	client = kzalloc(sizeof(struct kfd_smi_client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&client->list);
> +
> +	ret = kfifo_alloc(&client->fifo, MAX_KFIFO_SIZE, GFP_KERNEL);
> +	if (ret) {
> +		kfree(client);
> +		return ret;
> +	}
> +
> +	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
> +			       O_RDWR);
> +	if (ret < 0) {
> +		kfifo_free(&client->fifo);
> +		kfree(client);
> +		return ret;
> +	}
> +	*fd = ret;
> +
> +	init_waitqueue_head(&client->wait_queue);
> +	spin_lock_init(&client->lock);
> +	client->events = 0;
> +	client->dev = dev;
> +
> +	spin_lock(&dev->smi_lock);
> +	list_add_rcu(&client->list, &dev->smi_clients);
> +	spin_unlock(&dev->smi_lock);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> new file mode 100644
> index 0000000..a9cb218
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -0,0 +1,29 @@
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
> +int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
> +void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
> +
> +#endif
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index b6be623..733c183 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -442,6 +442,17 @@ struct kfd_ioctl_import_dmabuf_args {
>  	__u32 dmabuf_fd;	/* to KFD */
>  };
>  
> +/*
> + * KFD SMI(System Management Interface) events
> + */
> +/* Event type (defined by bitmask) */
> +#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
> +
> +struct kfd_ioctl_smi_events_args {
> +	__u32 gpuid;	/* to KFD */
> +	__u32 anon_fd;	/* from KFD */
> +};
> +
>  /* Register offset inside the remapped mmio page
>   */
>  enum kfd_mmio_remap {
> @@ -546,7 +557,10 @@ enum kfd_mmio_remap {
>  #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
>  		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>  
> +#define AMDKFD_IOC_SMI_EVENTS			\
> +		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
> +
>  #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x1F
> +#define AMDKFD_COMMAND_END		0x20
>  
>  #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
