Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE419C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7EC207C4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 21:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BoezF1Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7EC207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A996E045;
	Thu, 23 Jul 2020 21:41:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BA06E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 21:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewbphk7TAtxxvhB2JGd3yWO2/ZZTGSa9xVT2g+XJHhq736Aho4ATTNGLGkAdRkQKeTkXAW5EzVXW/D6WuKLpzlCDrpVYaA0YOTlXMPkiSIesYVEZDlfaKZdaS8hth0DLZVb27z6oTGKV4/HN0EqxBulcvzUYyfrpVhokBF/fo7MK93fty7OKTx0saxnBK2QEVeuY3v/ABw5F5WBurUaoxvb2Zmq6CqP6kDro1A56s0w5khnoN4Eni9tliBq8rNBQOEnLrT10hdr9sUImKI2BKUQQo61O8X+XcglMmXZaCuVpGgTT464cmkAMiD7ZD/tfmxVtkfc7RCglNqPXLHxfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9stK91429H36WjG7SiS7MQ6CUezanXsyhx7PVWN8Z8=;
 b=kAzUH01URTtKJZhHd3WzsH1PnQ/IQrOCCL/n2ng7V+qvPNvkAANCrClVgeeKKfxxg1z5j1z5rHmIBeIUgCNmOXuJQXhi52qWtnhGrnaRyDx5QbHT/ly8AOM8ZnucBNIVWpO6xTpfWYSBM39ABfnkAzL/Yhf7YUJtHHV7bQFGkcHHuwNU4NWoCxX5TO4b2JOgwaPgf8PNj+ajNZTVf6fx+PgMMQWitah6/Pgy17JR1GmcOjlgMi9w9BKcsVdn720KN6yva6e4/a0RneM5PsCDl8Vjq4XGD2tcakYittOillzsEyjEltQfIl7GUIX0JVaU2G8s9xNoNbDcgKPLHDHI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9stK91429H36WjG7SiS7MQ6CUezanXsyhx7PVWN8Z8=;
 b=BoezF1QkHGzShBN+NqoL9QfPWwzw02etJjGfLRCUT+ho8bx054nTEwub0GXB9TmjUzQPm7oO0L+g/fOrpCZKgR6PARclpU8jQVqLBwCI/NIlFBK5lvudsjMp+VMFrzIOLQNvOBRr+QwgxaiE1Ig4aP69eaZgRKppqd87QA2oT9Y=
Received: from MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 21:41:17 +0000
Received: from MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63]) by MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63%3]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 21:41:17 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
Thread-Topic: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
Thread-Index: AQHWYEJrgg7ed9+j8UumSgkqsUd+eqkVr5wAgAACEXA=
Date: Thu, 23 Jul 2020 21:41:17 +0000
Message-ID: <MN2PR12MB42726B7B157DC5A66A4EE4ECEE760@MN2PR12MB4272.namprd12.prod.outlook.com>
References: <20200722160851.22437-1-mukul.joshi@amd.com>
 <942bcb77-da1c-de91-c1d8-10757401954e@amd.com>
In-Reply-To: <942bcb77-da1c-de91-c1d8-10757401954e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-23T21:41:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=74d4ac3d-04fb-4bf2-a035-0000ace392df;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-23T21:41:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9a0a3d07-c619-4c11-b993-00008d66e35e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.140.198.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f91bdef7-08b8-4bc1-61cc-08d82f51215a
x-ms-traffictypediagnostic: MN2PR12MB3757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37575DADE6096B9A2F1E7DABEE760@MN2PR12MB3757.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekF2ZXb3LoRn0Q5ypjTuTKpXsJ+QkVNhEF94x0DRUVWd9lj2jllpgjQyJcAvsrix45HhEZ44CDG0usU/imCTmVQ0fU9692mTvpCWRKTrbk9c/BSNEzAVwt3qe+FAMiBEfXo1IWgoIyESHO7xTIaK68iYAKyjEWrawyPiJW6W866SaD4o/Y8J4q4c9Cbv0rcZRW6dy+nittLQWkEY1kJdJfH/hutYdwbKzYP0zQrFXrNoBGSQvw8y+h8gwiuuh/s5lgqY8GvOFMGq0lkYm9rd8mU1pn1I0xNu0mTqSedWN7EJHBmm4gbxWX0d1JnvwEhf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4272.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(53546011)(55016002)(26005)(4326008)(66476007)(86362001)(7696005)(478600001)(6506007)(5660300002)(9686003)(66446008)(64756008)(33656002)(8676002)(8936002)(110136005)(52536014)(316002)(66946007)(76116006)(71200400001)(2906002)(186003)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2cCamQY8WwbDjC3ELQWBctqCWgDZQw8WtySvht5jC/0UsDN506ZBk21fJoKm0k/i+nejmMnI7CbL4ogRb8GEogVkfYt7eD2JVW9dTn4zqX4rZMSaoUF0CeSOi/fshoAohzzUvH53jojdve3qUnIZIEv54uLpyVrPAVKdB1J2oQYkI1DqTBtN/x82AYBmGj4bfNePljFGahSkLG/ywbkZgeay0I0OFLbVbMwLUVHKKGdo+jUSCylCFtVi6UR8uUZZbuMv8I5568uDcg7UvWkLxJ9vqDsyl06AlKgWCiu7YbcJVowJQjilE77Ti+pVDhPBopo6PEdXPY50p5nGfZp+4pKCVNv12NQbiVY0aCNLgv0A0WT5ISR2YGMV6wZ2Ohx4VOrK8rhj1cFqK3iUI93tgrDlFiZ/dxUr9LXYZ9V404v83mEQtCRS8Tfl8/0tlVm1Jg/buSNwBkqtLTW9Capk2cA8y7UBysocAHxbO6as6ePmgffP8q6+4DVhlEYkU8/G
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91bdef7-08b8-4bc1-61cc-08d82f51215a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 21:41:17.0447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOkq9kvk97CidlQAFxK5DtzcQjuyCGP3QjLbRFP5UCzhs/tO/boGW7fnMpEqyn6pux4wX65YjKIxyZLbYs07LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Lin, Amber <Amber.Lin@amd.com> 
Sent: Thursday, July 23, 2020 5:27 PM
To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event



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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1b865fed74ca..19e4658756d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -755,4 +755,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
>   {
>   }
> +
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t 
> +throttle_bitmask) { }
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3f2b695cf19e..e8b0258aae24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -269,5 +269,6 @@ int kgd2kfd_resume_mm(struct mm_struct *mm);
>   int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>   					       struct dma_fence *fence);
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t 
> +throttle_bitmask);
>   
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */ diff --git 
> a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
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
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t 
> +throttle_bitmask) {
> +	if (kfd)
> +		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask); }
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS diff 
> --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
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
gpu_id is not needed. The user calls ioctl with GPU specified and KFD returns an anonymous fd. Read from this anon_fd already identify the GPU.

I agree with you. But I would prefer to keep gpu_id in the SMI event message. The benefit is it explicitly identifies the GPU sending the message. This way user-space doesn't need to maintain an internal mapping of anon_fd to gpu_id.

Regards,
Mukul

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
> +	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, 
> +len); }
> +
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd; @@ 
> -156,7 +206,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
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
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd) diff --git 
> a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index a9cb218fef96..15537b2cccb5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -25,5 +25,7 @@
>   
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t 
> pasid);
> +void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> +					     uint32_t throttle_bitmask);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c 
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b197dcaed064..52b52cbb90e2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -639,6 +639,7 @@ static int smu_sw_init(void *handle)
>   	mutex_init(&smu->message_lock);
>   
>   	INIT_WORK(&smu->throttling_logging_work, 
> smu_throttling_logging_work_fn);
> +	atomic64_set(&smu->throttle_int_counter, 0);
>   	smu->watermarks_bitmap = 0;
>   	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>   	smu->default_power_profile_mode = 
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c 
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 9b68760dd35b..eb3a57593f69 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2251,6 +2251,7 @@ static void 
> arcturus_log_thermal_throttling_event(struct smu_context *smu)
>   
>   	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
>   			log_buf);
> +	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
>   }
>   
>   static const struct pptable_funcs arcturus_ppt_funcs = { diff --git 
> a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h 
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
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
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c 
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
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
> diff --git a/include/uapi/linux/kfd_ioctl.h 
> b/include/uapi/linux/kfd_ioctl.h index f738c3b53f4e..df6c7a43aadc 
> 100644
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
