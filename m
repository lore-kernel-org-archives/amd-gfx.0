Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BC820658
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uEp3RZOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C136E8E4;
	Thu, 30 Jan 2020 19:08:55 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D386E8E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 19:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0ierOkZVjgfLZHQxIZyHoZC3xkzGgituUs+/UEtI6ZlLBa2/sm7ukPtaMjA71bTSKoYuMOYWFKpy8sl/h0L7Jt3BjkfAQsVLQUPMSihGDVtfFEFkQmkidAkj125hpd94RDZB8xso7RY3fPUTxLzrsXQ2FZ7K2JeBsYTC8PTfHoXwmDKNy31UvMlgu4M5oAx09njSQQj/bjKVLl+oKnMyPuS8/KzC/bFraLz5sM9PTDgB8cVh4Mk8QBCqn0Q14Z6H+2lCzD1mrbe4XtXcZxJF6UlVkn2Q8a30fcc3BjlREkgRxkfTmULkiANol18Hr0lQDN4rU34bG7Nna+/T/XdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOafc4YFFt/MfMdYSdU94TND4KTufOJWxdBsIU58IzI=;
 b=TCaXuHWqloG6SU7rrlGrzy0oB9daOv9HaZD0H8Zfo41axz/sWs/lT/c8aAukJMYo4d9S8/EQKmuLzQ0CDXJuzdQGh7Wa7Qs1K8162W65Tg7OHaH3h9KpYFbxDpg2siH2cHWmbXTEX1CEs72QJpSaG6pzric2Mcp6qkXnRG9o9sm6Muc1mhdHT7dFMc2mW2utclba07efxPMHQeLvS5hkwN5XzHIPpR4URO0a2SPwNBpHw/t5IwjsGZCTuz71Aqfi/AQvOsaM5Iv21LadCQ4hNbGAvz7jIsZefH96G8daiRPGC3RZIPd0v8n2TYv3nc4mf5JoAm51rG0Tl4ZDZEid/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOafc4YFFt/MfMdYSdU94TND4KTufOJWxdBsIU58IzI=;
 b=uEp3RZOvRrZzSs+mtKEBiuCdwFYLLG76EfvTtSz53mZJ0VHSIoJbpbFlImdwX3DSzjIKhA+Id/jOsdRvUFA/w1EfxH4O2CG/tbOy/ttbQWIE3CrkhmPhz2xh5h4RDVNP1nUOVc5rbB0NYj97JmEOTzA74t4oc4i4VFWGM2iaBpg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2527.namprd12.prod.outlook.com (52.132.193.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 19:08:52 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 19:08:52 +0000
Subject: Re: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-6-rajneesh.bhardwaj@amd.com>
 <BL0PR12MB2580399D1AA3C66566D7C95F800A0@BL0PR12MB2580.namprd12.prod.outlook.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <721bb5f7-ee65-86d5-29bf-41ab917bd43d@amd.com>
Date: Thu, 30 Jan 2020 14:08:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <BL0PR12MB2580399D1AA3C66566D7C95F800A0@BL0PR12MB2580.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from [172.27.232.179] (165.204.55.251) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend
 Transport; Thu, 30 Jan 2020 19:08:51 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36db4899-99be-4634-ad0a-08d7a5b7d840
X-MS-TrafficTypeDiagnostic: SN1PR12MB2527:|SN1PR12MB2527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25277481862D053B8D752312FE040@SN1PR12MB2527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(2616005)(956004)(66476007)(66946007)(66556008)(16576012)(316002)(4326008)(8676002)(2906002)(81156014)(81166006)(110136005)(30864003)(5660300002)(8936002)(52116002)(31686004)(966005)(53546011)(54906003)(36756003)(478600001)(186003)(16526019)(26005)(86362001)(45080400002)(31696002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2527;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMYZl6GLnO5D1FIwev9jQxt9wUBqEeo+fGWXtQhNm/Un31mbXx/AxewI6UltzySlqVZ6GvMAORbAFhl4RTTZGfNRtv7Xl4sxBSiC5CDM1OTavAmg2Tqv4q5xHR/xMy6j11qLQK5lWZDfl3Lt7ulARw8c8GOhXidiuHEm4q7w4p+a3H3z6Bawa6idLUgciPNsJfFAhd7TGLTMes1LePhq/8Jh52Zo6ALJGR2quky0QzbqGotjbtw4ADtLGymdVy30HpGD7EFyORdBCXy+9QOrzINBFkjGh1XQdoSrhCHFSL/P4ItY5CGjgJrNgfziu3m01x/S2n9KqbtZIPdl+2TAQFECQ0zLGeXiiR3gXJzjg/O5aw8C0o8RTP5Twp/VTNnDC/U5M2POKgBhCMSmECXtttNg7G0ZbCT/1YKptyx3urphuHSvT9TEam/pX/OCPCDeq2JuL9kF+Ld3dQTOviuQ9SKM0LqX5Mj2chocgWHMEbQsgOCm7RiKiVESqkjW8U3bQnI1kWwjP7vcoKUfqr3hDA==
X-MS-Exchange-AntiSpam-MessageData: ckYhsuWaRCeU1kQp7p5HLxcGKTh78809/dLzCk0icJOpoEPyHp/bIGXgenYSClE1P2s4/UHa3F9y6w2fOUpNt7304NxOUHolri9YY+zjTvE/ksp51w3QUUVowg/I7Z7M71FQ1NMGZ+81W6/me6oS3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db4899-99be-4634-ad0a-08d7a5b7d840
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 19:08:52.4178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRQ6w6jJN1yF3DNBZkl53w4dKPTN0aJIvW4ZZyO+RxVkweE0wlfYOXiwkjsh/hUYW6WyqVwTUZ5PCV14sBnsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2527
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/28/2020 3:09 PM, Zeng, Oak wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
> Regards,
> Oak
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rajneesh Bhardwaj
> Sent: Monday, January 27, 2020 8:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
> Subject: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
>
> So far the kfd driver implemented same routines for runtime and system wide suspend and resume (s2idle or mem). During system wide suspend the kfd aquires an atomic lock that prevents any more user processes to create queues and interact with kfd driver and amd gpu. This mechanism created problem when amdgpu device is runtime suspended with BACO enabled. Any application that relies on kfd driver fails to load because the driver reports a locked kfd device since gpu is runtime suspended.
>
> However, in an ideal case, when gpu is runtime  suspended the kfd driver should be able to:
>
>   - auto resume amdgpu driver whenever a client requests compute service
>   - prevent runtime suspend for amdgpu  while kfd is in use
>
> This change refactors the amdgpu and amdkfd drivers to support BACO and runtime runtime power management.
> [Oak] two runtime above


Thanks, will fix it.


>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +++---  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
>   6 files changed, 51 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 8609287620ea..314c4a2a0354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);  }
>   
> -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
> [Oak] then name run_pm is a little bit confusing. Maybe system_wide_pm or none_runtime_pm?
>   {
>   	if (adev->kfd.dev)
> -		kgd2kfd_suspend(adev->kfd.dev);
> +		kgd2kfd_suspend(adev->kfd.dev, run_pm);
>   }
>   
> -int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>   {
>   	int r = 0;
>   
>   	if (adev->kfd.dev)
> -		r = kgd2kfd_resume(adev->kfd.dev);
> +		r = kgd2kfd_resume(adev->kfd.dev, run_pm);
>   
>   	return r;
>   }
> @@ -713,11 +713,11 @@ void kgd2kfd_exit(void)  {  }
>   
> -void kgd2kfd_suspend(struct kfd_dev *kfd)
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   {
>   }
>   
> -int kgd2kfd_resume(struct kfd_dev *kfd)
> +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   {
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 0fa898d30207..3dce4a51e522 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -123,8 +123,8 @@ struct amdkfd_process_info {  int amdgpu_amdkfd_init(void);  void amdgpu_amdkfd_fini(void);
>   
> -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev); -int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   			const void *ih_ring_entry);
>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -250,8 +250,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   			 struct drm_device *ddev,
>   			 const struct kgd2kfd_shared_resources *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd); -void kgd2kfd_suspend(struct kfd_dev *kfd); -int kgd2kfd_resume(struct kfd_dev *kfd);
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm); int
> +kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd);  int kgd2kfd_post_reset(struct kfd_dev *kfd);  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d9e5eac182d3..787d49e9f4de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3314,7 +3314,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   		}
>   	}
>   
> -	amdgpu_amdkfd_suspend(adev);
> +	amdgpu_amdkfd_suspend(adev, fbcon);
>   
>   	amdgpu_ras_suspend(adev);
>   
> @@ -3398,7 +3398,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   			}
>   		}
>   	}
> -	r = amdgpu_amdkfd_resume(adev);
> +	r = amdgpu_amdkfd_resume(adev, fbcon);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 2a9e40131735..e9f00c3a067a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -23,6 +23,7 @@
>   #include <linux/bsearch.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_pm4_headers_vi.h"
> @@ -710,7 +711,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void kgd2kfd_device_exit(struct kfd_dev *kfd)  {
>   	if (kfd->init_complete) {
> -		kgd2kfd_suspend(kfd);
> +		kgd2kfd_suspend(kfd, true);
>   		device_queue_manager_uninit(kfd->dqm);
>   		kfd_interrupt_exit(kfd);
>   		kfd_topology_remove_device(kfd);
> @@ -731,7 +732,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   
>   	kfd->dqm->ops.pre_reset(kfd->dqm);
>   
> -	kgd2kfd_suspend(kfd);
> +	kgd2kfd_suspend(kfd, true);
>   
>   	kfd_signal_reset_event(kfd);
>   	return 0;
> @@ -765,21 +766,24 @@ bool kfd_is_locked(void)
>   	return  (atomic_read(&kfd_locked) > 0);  }
>   
> -void kgd2kfd_suspend(struct kfd_dev *kfd)
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   {
>   	if (!kfd->init_complete)
>   		return;
>   
> -	/* For first KFD device suspend all the KFD processes */
> -	if (atomic_inc_return(&kfd_locked) == 1)
> -		kfd_suspend_all_processes();
> +	/* for runtime suspend, skip locking kfd */
> +	if (run_pm) {
> +		/* For first KFD device suspend all the KFD processes */
> +		if (atomic_inc_return(&kfd_locked) == 1)
> +			kfd_suspend_all_processes();
> +	}
>   
> +	pm_runtime_set_autosuspend_delay(kfd->ddev->dev, 5000);
> [Oak]: why this is necessary? This timeout value has already been set in driver load. See amdgpu_driver_load_kms
>   	kfd->dqm->ops.stop(kfd->dqm);
> -
>   	kfd_iommu_suspend(kfd);
>   }
>   
> -int kgd2kfd_resume(struct kfd_dev *kfd)
> +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   {
>   	int ret, count;
>   
> @@ -790,10 +794,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
>   	if (ret)
>   		return ret;
>   
> -	count = atomic_dec_return(&kfd_locked);
> -	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> -	if (count == 0)
> -		ret = kfd_resume_all_processes();
> +	/* for runtime resume, skip unlocking kfd */
> +	if (run_pm) {
> +		count = atomic_dec_return(&kfd_locked);
> +		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> +		if (count == 0)
> +			ret = kfd_resume_all_processes();
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 8d871514671e..6301d77ed3d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -25,6 +25,7 @@
>   #include <linux/slab.h>
>   #include <linux/pci.h>
>   #include <linux/amd-iommu.h>
> +#include <linux/pm_runtime.h>
>   #include "kfd_priv.h"
>   #include "kfd_dbgmgr.h"
>   #include "kfd_topology.h"
> @@ -134,8 +135,10 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
>   	struct kfd_process_device *pdd;
>   
>   	list_for_each_entry(pdd, &p->per_device_data, per_device_list)
> -		if (pdd->bound == PDD_BOUND)
> +		if (pdd->bound == PDD_BOUND) {
>   			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
> +			pm_runtime_set_autosuspend_delay(pdd->dev->ddev->dev, 5000);
> [Oak] This only set the timeout. The correction function to call is pm_runtime_put_autosuspend?
> I think it is better to call it at the end of kfd_process_wq_release directly and call pm_runtime_mark_last_busy first.
> +		}
>   }
>   
>   /* Callback for process shutdown invoked by the IOMMU driver */ diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 25b90f70aecd..d19d5e97405c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -31,6 +31,7 @@
>   #include <linux/compat.h>
>   #include <linux/mman.h>
>   #include <linux/file.h>
> +#include <linux/pm_runtime.h>
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu.h"
>   
> @@ -843,15 +844,27 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	err = pm_runtime_get_sync(dev->ddev->dev);
> +	pm_runtime_set_autosuspend_delay(dev->ddev->dev, 60000);
> [Oak]: The second call is not necessary
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
>   	err = kfd_iommu_bind_process_to_device(pdd);
>   	if (err)
> -		return ERR_PTR(err);
> +		goto out;
>   
>   	err = kfd_process_device_init_vm(pdd, NULL);
>   	if (err)
> -		return ERR_PTR(err);
> +		goto out;
>   
> -	return pdd;
> +out:
> +	pm_runtime_mark_last_busy(dev->ddev->dev);
> +	pm_runtime_put_autosuspend(dev->ddev->dev);
> +
> +	if (!err)
> +		return pdd;
> +	else
> +		return ERR_PTR(err);
>   }
>   
>   struct kfd_process_device *kfd_get_first_process_device_data(
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7Ce57e1eeb5fd74b5d8dea08d7a391a089%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637157718236258423&amp;sdata=zqM5YTz7qofPZjG3PmWKbHQ4sMMZjol1IlzaNTwQtcw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
