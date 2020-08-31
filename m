Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B6DC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4891A20707
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pv0p+rkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4891A20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A0E89248;
	Mon, 31 Aug 2020 14:26:30 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CC489248
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STZ8NcYy5PSIFzYzKBiQehsvBgaoMjW33xEfUlOKrqvG2dM+HOR6piQ3ELkn3yYmj1UIe1v9/a7wz/qpUupSDxR6/RMWee3SvVUQyGEeEYYXPkiUyKR38AQUaLJ+bksO2Hfs4vZ+PexwlTcaz/+p6nLiayQ8NMR3nwrDTJqTTx3PYRb9Er6hgsiNRxO/d9aSRSzT6X08icOF/7vkgg+aWAQKFhSV34yxqaA3kFb82wKUHCkkvCMQhJyV29PAdTWK4zsBXyx+NlHbMq3QcUaD4+rmOObE3T+1xxrSRZB0+iVTqIUzOaYuVz8+gvDcx+zXV4PS9eRvISOA1HE4ZgTqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyQuS74MiivhJ+AMDgwpOtdvnq6BFwaRIAyc6NMTLD0=;
 b=CJqdvWHObFapq3Xqn34fnI20biDf6Rwolwdul0OXKPNhUNUtfe+sXdq6rK7s3OPJserAS9Rx0uuCcZbk/kUaiUFUL5c1qQOPEE41KBr5K/v8ep1dMVp6Jdt7HLmwX+KibsRfiVfqvKEuxrCD69DOqKwVyjAKMzrI1GwIdaZo7+esmBulsrAFB2nuEyx1wHjhlbZ59ltQbn37Dv1ygwkpJXYElybqgbMWABkGlX7FoluTt38V8h3S1bSF9hsYHh+hBuHsWTNtzHQ6iUHtwclfW+H5u2tx2wddRCOKrF4hA3GGIfKS0qdskscSEBaDGERzDdhD0Id4/SowZyDyu2ApxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyQuS74MiivhJ+AMDgwpOtdvnq6BFwaRIAyc6NMTLD0=;
 b=Pv0p+rkgyj4d2iQaVY0lbskeABs0xY+ncutIX+mJtuUOadlT++pkxnJMZwisAHpRS3llGXgw0GyLNTNxWrmVTFQxazoQpGCoiWYtNAe90zXyj8sY7svpaXIo3OfUE+ecFgp7fkhkkc5IFOoZGbFs1BuJc5v7AYQGQAatW0x/UqU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Mon, 31 Aug 2020 14:26:26 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:26:26 +0000
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Implement DPC recovery
To: Alex Deucher <alexdeucher@gmail.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_PEW=4Gkm6WmcYCh2wYOdPF5pas+4pp4=EvueH8wE38dA@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a1e3d48a-c92f-9701-9297-d6a9e9edddba@amd.com>
Date: Mon, 31 Aug 2020 10:26:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_PEW=4Gkm6WmcYCh2wYOdPF5pas+4pp4=EvueH8wE38dA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN1PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:408:e0::15) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:26:25 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95a76f55-a5f7-462a-c72a-08d84db9d837
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28609A88758E76F7A8D97B7EEA510@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEiU+/EdprzW7iVd4L1oqMoSwQGB/rLzsQsmVgM9Ha/sMwZJe/8HdvfCN2VqDJvUO9Cjds5R2y9wu/J5C5zeQ3GwAM0ttQfkSXx3+Kkoyw+WHg3o6QoaDYQU3lA6ylCTSv2+OhJ/lg+FYndm025m22arDVHkmQosW46uG5r+J5NTI+G0X/OT8M0E35U1NO740gUqTDaSJzZeAfc+HGQ2UDdLbO37+wG2dyzB6CHBEQiWLZrt9BXLPVr34oYTuu/FAo/ZUAUUHWqAu1UIouqyEpmjmK8+y9Yi2STPOWPv60zK5GLdzKGWtY2eHkaOcniZUQBEMAKXEDymMjdGFTp0yYVYgKDcxvsr33dTQbj0vkT02+LfjD93pIxMljpwYhBhZmM5cB27oEwqnFywKcwzM/9UEsUMcuTg87u0zqrF0MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(8676002)(66946007)(478600001)(31696002)(316002)(53546011)(66556008)(66476007)(36756003)(52116002)(83380400001)(45080400002)(5660300002)(186003)(86362001)(8936002)(31686004)(966005)(16576012)(54906003)(956004)(4326008)(6486002)(2616005)(2906002)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: q8ik/yxsKeHW2aDOBf07L2wOpnyv1Ieysubo9sWj/PbRQ0GIgj992eY71+y47Z1aWwNW5GO1gKVo68HG4gFudAqI0WUH8JHGFm4+FMjEx5l02zDrJJGQmeUtQI8YGQ3ibHnk4i+1TdZh5p/aMrQnaxceO/VZuq7BrYHe4KjPgBaEv5waX47UzSo+s35yRW5l++yIXFr3OOi/0ltvm5P6o0DZpjg7+CIFGwA3eloVtraX9ZC4xk7yS51sz73WTxvm0cgY5r5Y+DnITHdtlcjGqF7zhBM7OZjuQPnZ8W3jaoiqiVW8VDC/6akjxuDQZfJDdbUy7Bv1l49I6HU1SkgEk3R0wPklo8nwYhPUEVVbJ9i9jr5d7HKVhSlm4issWSJSgSGFVsUYzq/ORUKAI6f3yIuTqRV5wIK89yoXqc3UgJOvZF7lEQ+4rtMt6c6XQT7Oo0iHcFd8FBgZMgr54+k9r2LYnDZGgGfxn31ZgQf64nInpayF52APR354xHomZQvOZfCaAb7H6uCFbCPO+FnbtkdWY+KUFK+lczGUZT9Kv4gLHknkIS8PdGPa8uixjn5KIUetktgv+0aJZJ3b7U7uvPSfQWLTgqroHICRAcGLKJGcjzWr3f5qu+QN0t6GU9z/2iq2kzo4VowB0hu+TuEWcoBeDtTxYk0qidzB5JkRPxZ7Y/2dGuyfk7w2uznHd8VftBfavUP17FPAZww9/vu51w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a76f55-a5f7-462a-c72a-08d84db9d837
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:26:26.6390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYUD1Fx5OOwTk+p8eYUjhjTXwyU3Ug4oqmUyezitd2XSiR5fvS8cEdl7UoYWPT/64HbAHuOiPG8t4y0HP9ETUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 3:23 PM, Alex Deucher wrote:
> On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> Add DPC handlers with basic recovery functionality.
>>
>> v2: remove pci_save_state to avoid breaking suspend/resume
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 169 ++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>>   3 files changed, 184 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 49ea9fa..3399242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -49,6 +49,8 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/hashtable.h>
>>   #include <linux/dma-fence.h>
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>>
>>   #include <drm/ttm/ttm_bo_api.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>>
>> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
>> +                                          pci_channel_state_t state);
>> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>> +void amdgpu_pci_resume(struct pci_dev *pdev);
>> +
>> +
>>   #include "amdgpu_object.h"
>>
>>   /* used by df_v3_6.c and amdgpu_pmu.c */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5a948ed..937f8b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -350,7 +350,8 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    *
>>    * Returns the 8 bit value from the offset specified.
>>    */
>> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>> +{
>>          if (offset < adev->rmmio_size)
>>                  return (readb(adev->rmmio + offset));
>>          BUG();
>> @@ -371,7 +372,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>>    *
>>    * Writes the value specified to the offset specified.
>>    */
>> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
>> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>> +{
>>          if (offset < adev->rmmio_size)
>>                  writeb(value, adev->rmmio + offset);
>>          else
>> @@ -2989,6 +2991,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>>          NULL
>>   };
>>
>> +
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -3207,6 +3210,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                  }
>>          }
>>
>> +       pci_enable_pcie_error_reporting(adev->ddev.pdev);
>> +
>> +
>>          /* Post card if necessary */
>>          if (amdgpu_device_need_post(adev)) {
>>                  if (!adev->bios) {
>> @@ -4701,3 +4707,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>
>>          return 0;
>>   }
>> +
>> +/**
>> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
>> + * @pdev: PCI device struct
>> + * @state: PCI channel state
>> + *
>> + * Description: Called when a PCI error is detected.
>> + *
>> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
>> + */
>> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
>> +{
>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>> +
>> +       DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>> +
>> +       switch (state) {
>> +       case pci_channel_io_normal:
>> +               return PCI_ERS_RESULT_CAN_RECOVER;
>> +       case pci_channel_io_frozen: {
>> +               /* Fatal error, prepare for slot reset */
>> +
>> +               amdgpu_device_lock_adev(adev);
>> +               return PCI_ERS_RESULT_NEED_RESET;
>> +       }
>> +       case pci_channel_io_perm_failure:
>> +               /* Permanent error, prepare for device removal */
>> +               return PCI_ERS_RESULT_DISCONNECT;
>> +       }
>> +       return PCI_ERS_RESULT_NEED_RESET;
>> +}
>> +
>> +/**
>> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
>> + * @pdev: pointer to PCI device
>> + */
>> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
>> +{
>> +
>> +       DRM_INFO("PCI error: mmio enabled callback!!\n");
>> +
>> +       /* TODO - dump whatever for debugging purposes */
>> +
>> +       /* This called only if amdgpu_pci_error_detected returns
>> +        * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
>> +        * works, no need to reset slot.
>> +        */
>> +
>> +       return PCI_ERS_RESULT_RECOVERED;
>> +}
>> +
>> +/**
>> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
>> + * @pdev: PCI device struct
>> + *
>> + * Description: This routine is called by the pci error recovery
>> + * code after the PCI slot has been reset, just before we
>> + * should resume normal operations.
>> + */
>> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>> +       int r;
>> +       bool vram_lost;
>> +
>> +       DRM_INFO("PCI error: slot reset callback!!\n");
>> +
>> +       pci_restore_state(pdev);
>> +
>> +       r = amdgpu_device_ip_suspend(adev);
>> +       if (r)
>> +               goto out;
>> +
>> +
>> +       /* post card */
>> +       r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
>> +       if (r)
>> +               goto out;
>> +
>> +       r = amdgpu_device_ip_resume_phase1(adev);
>> +       if (r)
>> +               goto out;
>> +
>> +       vram_lost = amdgpu_device_check_vram_lost(adev);
>> +       if (vram_lost) {
>> +               DRM_INFO("VRAM is lost due to GPU reset!\n");
>> +               amdgpu_inc_vram_lost(adev);
>> +       }
>> +
>> +       r = amdgpu_gtt_mgr_recover(
>> +               &adev->mman.bdev.man[TTM_PL_TT]);
>> +       if (r)
>> +               goto out;
>> +
>> +       r = amdgpu_device_fw_loading(adev);
>> +       if (r)
>> +               return r;
>> +
>> +       r = amdgpu_device_ip_resume_phase2(adev);
>> +       if (r)
>> +               goto out;
>> +
>> +       if (vram_lost)
>> +               amdgpu_device_fill_reset_magic(adev);
>> +
>> +       /*
>> +        * Add this ASIC as tracked as reset was already
>> +        * complete successfully.
>> +        */
>> +       amdgpu_register_gpu_instance(adev);
>> +
>> +       r = amdgpu_device_ip_late_init(adev);
>> +       if (r)
>> +               goto out;
>> +
>> +       amdgpu_fbdev_set_suspend(adev, 0);
>> +
>> +       /* must succeed. */
>> +       amdgpu_ras_resume(adev);
>> +
>> +
>> +       amdgpu_irq_gpu_reset_resume_helper(adev);
>> +       r = amdgpu_ib_ring_tests(adev);
>> +       if (r)
>> +               goto out;
>> +
>> +       r = amdgpu_device_recover_vram(adev);
>> +
>> +out:
>> +
>> +       if (!r)
>> +               DRM_INFO("PCIe error recovery succeeded\n");
>> +       else {
>> +               DRM_ERROR("PCIe error recovery failed, err:%d", r);
>> +               amdgpu_device_unlock_adev(adev);
>> +       }
>> +
>> +       return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>> +}
>> +
>> +/**
>> + * amdgpu_pci_resume() - resume normal ops after PCI reset
>> + * @pdev: pointer to PCI device
>> + *
>> + * Called when the error recovery driver tells us that its
>> + * OK to resume normal operation. Use completion to allow
>> + * halted scsi ops to resume.
>> + */
>> +void amdgpu_pci_resume(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>> +
>> +       amdgpu_device_unlock_adev(adev);
>> +
>> +       DRM_INFO("PCI error: resume callback!!\n");
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index d984c6a..4bbcc70 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -31,7 +31,6 @@
>>   #include <drm/drm_pciids.h>
>>   #include <linux/console.h>
>>   #include <linux/module.h>
>> -#include <linux/pci.h>
> Is this intended?  Seems unrelated.  I think this should be part of
> the previous patch.
>
> Alex


Which previous patch (it's the first one) ?

Andrey


>
>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/vga_switcheroo.h>
>>   #include <drm/drm_probe_helper.h>
>> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
>>          .patchlevel = KMS_DRIVER_PATCHLEVEL,
>>   };
>>
>> +static struct pci_error_handlers amdgpu_pci_err_handler = {
>> +       .error_detected = amdgpu_pci_error_detected,
>> +       .mmio_enabled   = amdgpu_pci_mmio_enabled,
>> +       .slot_reset     = amdgpu_pci_slot_reset,
>> +       .resume         = amdgpu_pci_resume,
>> +};
>> +
>>   static struct pci_driver amdgpu_kms_pci_driver = {
>>          .name = DRIVER_NAME,
>>          .id_table = pciidlist,
>> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>>          .remove = amdgpu_pci_remove,
>>          .shutdown = amdgpu_pci_shutdown,
>>          .driver.pm = &amdgpu_pm_ops,
>> +       .err_handler = &amdgpu_pci_err_handler,
>>   };
>>
>>   static int __init amdgpu_init(void)
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cc25d1302358c420604b908d84b87e5a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342394332573022&amp;sdata=MvfAEC9Vc7fwkmBvihaTxDswrRJwFhjLWoEmjQKIIPg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
