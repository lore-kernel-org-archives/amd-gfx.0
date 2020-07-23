Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38423C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37CB20768
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 22:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Abnl2kww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37CB20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E3A6E215;
	Thu, 23 Jul 2020 22:06:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A270E6E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 22:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsjcqhcGZujEcDEgRZ/uKkSePRhEfFddCdkJ7euH/lwUfhAgkrEzpmv1iOEOlJD1bg72vEfK2+dJZ0IegepvDywyLULQOlCtVdIbV6qe7o/if1zTymsACQC7jfhMru1MaN49LGLX8UmuRskFD9gxNUj9FSwRlBpnyg6GAEbHr+EhOkT53ikpSBadPxkcIKfsRnHoA0qtMSF7t9Kk8Em16QgsVoCgtX0RgzLdJW2EnW4yXJp/MlZxVgzU2oe6JAMSeSLPX2TYWuRFsXWjJAY80dfnso7dktOSZl5fiJu5BD+iK/R7yzvc/LUqsdS9G+g29OWW7CS2RBUkBRA/0bQkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPfdSBqCw44Mr0VTma4v7Ou7DScSUIMJxClBdbumc9Y=;
 b=SW+iTkrcjKFA1o0vbUZ14nUnhLAQ+ihfHeQikH6boluI+q/v/w2f2iuUBObfPAwsgykiRaLAzfoNdlfp7z1/6wGp+LTmG2sQaiqy81V7B7ColEj81oQb8wg/HL/6I0098d5Klac39C508wL9RrhC7KCp9gxV8g5nmz59PvS9dQvjMVvtkNOZCMC80ojxhj70RCuGOfmZQzUxvgQA/gBkniBUK1oXE0cZOlAUr5Xda0egfokIhBMBsZWAWohhKdPawWtU6KyV1g7VU5Nce/mbxvjg0QMHmnvuKTiJhrLhh9sQy893JgCr0Xx4P+f00DW221A8L8jJ3miywVA07qn5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPfdSBqCw44Mr0VTma4v7Ou7DScSUIMJxClBdbumc9Y=;
 b=Abnl2kwwUp+hkrqgutUFR1C1wqjIKZLfWYvx1JPpb9ldMRyvUWhd9dw6w7cjrYNEEu69gDSJbmr2OKOZ3V1K2yE3+AAZJHYgFbA3HahWY3lGfgfo42f6vzSCZ0178rupAoDWAHe5C06TdB2c9g4hNiULtwBSDBjzaqEdxsnjo58=
Received: from CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 by CH2PR12MB3704.namprd12.prod.outlook.com (2603:10b6:610:21::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 22:05:58 +0000
Received: from CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::d5db:81e4:c1c3:841f]) by CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::d5db:81e4:c1c3:841f%6]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 22:05:58 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
Thread-Topic: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
Thread-Index: AQHWYEJrgg7ed9+j8UumSgkqsUd+eqkVr5wAgAACEXCAAAZzgIAAAgHg
Date: Thu, 23 Jul 2020 22:05:58 +0000
Message-ID: <CH2PR12MB426485CF587FF91537F658D1EE760@CH2PR12MB4264.namprd12.prod.outlook.com>
References: <20200722160851.22437-1-mukul.joshi@amd.com>
 <942bcb77-da1c-de91-c1d8-10757401954e@amd.com>
 <MN2PR12MB42726B7B157DC5A66A4EE4ECEE760@MN2PR12MB4272.namprd12.prod.outlook.com>
 <652bc6be-435f-49dc-0274-80563cd44db8@amd.com>
In-Reply-To: <652bc6be-435f-49dc-0274-80563cd44db8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-23T22:05:52Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=785d783e-94f4-4f9c-af7f-0000271e1237;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-23T22:05:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5903ab84-b76a-49ac-84a6-000024cc32cd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5421c2b9-e70a-4033-d5b8-08d82f549425
x-ms-traffictypediagnostic: CH2PR12MB3704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3704D633319F62BBA656607BEE760@CH2PR12MB3704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzGXBMXs7pq5c1vjcMfDtShoYjPvGi2v1cpZFZVAeDXHZhUzjq7873zDRItmU0stPDlfBN3uTAq8DUbKVTY7xRjRoUzfzk+kyLsnFbf/He8jSIinOAMwNjCyN5Z8rjMCYMtQtCBNkD42idDXr7ZMz3vFbJKJypww720XlW1fua8P4jNwzKfqmzevtrM4pLM1dtVnwM8d5ud9J4/i6Ni00hgkuqoYuWIFLxYQWOPYlQx0FnXDNW9QLEkKChWF6dVpprWIRvl4cRji58aE2ce8IyS/ozQAL+EKhlM+QDt1K6QIXJ9hSw/SMetVtpv2C2/H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(4326008)(83380400001)(110136005)(55016002)(8676002)(478600001)(7696005)(30864003)(8936002)(5660300002)(33656002)(9686003)(316002)(71200400001)(2906002)(6506007)(53546011)(52536014)(86362001)(66946007)(26005)(76116006)(66476007)(66556008)(186003)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hijp2/Y/uY1vRPkHMFfm141HeoaOXeSSD8XnLZvb6sMIiSC/tXVeVSTRt76nWVttXRfnqQKSfh0UeDyA86Nc8On6UymLOdVh4f3Ja04M6bV669xUdY8j8lsKTbbQfhHFAI3vxjRtl1+HFJvH9vni+F6JNAqSZVsLs6Fp7Ap4LbjleCeq6yrufAxd9Bm//HvMp2SwKqkRhYVGJQYscyWkld9mCXeZ/5XBCYjfcvPdaisKsh92ZpS7Ps+21WyVMyPb+vqLdSq/dcAp1xGNrQKwV//jvwy65Io6b7IllstHAbXG3d932nwVuMorTimZEtgStJpavZiBJOKMxd72yIvJQsmBHupRh5wjKnRFCqLJbKBufBzx7Do2eDGEpRyMIhjxYvANTxW8fV5NxzoDdPXC1NuoeW8IX+pa4SX3sOd3ncx7Z9zcdf6Y0seoUm2iGF1ElfOx7oDzkqaRy4eJ8jPckVtpLCBm8CGyLNhZ9dZh7TuxGRF4q1A4EExLRCfiBRv6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5421c2b9-e70a-4033-d5b8-08d82f549425
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 22:05:58.0906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niQMm7eMOMlZ1Ghy+LgHkFIEWLpdeY5H9ceXm+ZPFIgxsde8m0gkfBOyxt/H8FT1tJcE+Cz0DXH8j93fzkDMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3704
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
Sent: Thursday, July 23, 2020 5:58 PM
To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event



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
>> +					     uint32_t throttle_bitmask) {
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
>> +	/*
>> +	 * ThermalThrottle msg = gpu_id(4):throttle_bitmask(4):
> gpu_id is not needed. The user calls ioctl with GPU specified and KFD returns an anonymous fd. Read from this anon_fd already identify the GPU.
>
> I agree with you. But I would prefer to keep gpu_id in the SMI event message. The benefit is it explicitly identifies the GPU sending the message. This way user-space doesn't need to maintain an internal mapping of anon_fd to gpu_id.
We want to keep the message as short as possible so the 1K kfifo can contain more events in case multiple events rush in and the user doesn't consume fast enough. For the same reason vmfault event doesn't log gpu_id. On the user side, the user shouldn't need to do the anon_fd/gpu_id convert. That information should be already in their structure. Instead of reading/parsing the message, the user reads from their structure.

MJ> OK that makes sense. I can remove the gpu_id from the message.

Regards,
Mukul

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
>>    	if (list_empty(&dev->smi_clients)) @@ -171,22 +220,7 @@ void 
>> kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
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
>>    int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd) diff 
>> --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
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
>>    static const struct pptable_funcs arcturus_ppt_funcs = { diff 
>> --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
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
