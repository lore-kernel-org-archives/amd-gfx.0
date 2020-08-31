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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F6C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 20:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07232064B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lv75vgjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07232064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128EE6E525;
	Mon, 31 Aug 2020 20:47:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD0D6E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 20:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXBBAE274EScdOEeOd8+ljQ5Ooyf/b+n0hv6HzmVgNu+v1vv0xuCz/XFBdRwLnv4lsTY4V6bs6snDF6rswcq5t9jAmsL6XHrbL2rLEtowTQS7RqQvFkkQ6gwQadN4BKNpL/buFJ48/Fs0td0VvXD7j51H4lS7Aw7vjJM7Pj/pYqQCR7yPAigRZCrTGqkTIY0LI9y08Fz/MOAVPhbKuGsROlwQDF6antHtA7GpF+DFCZ9uVUq9M50u4xPEKENepQp/TbSq3Ddo3uuRmw8Y4Fu0kFLV+KrwhqdYEMFvZQxQPypQbW3ODh5+YBzcAA7XZtsskncwjLqK3WYmQxGzrC/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd/AoSwZuDc7qpeHrSYKhPhWpoHIBIOvKPVAiJCJWHw=;
 b=ixZ6RjHUT4k9DET/VKz04zgqzkJ6OMNXcY0is/hFzEn1TEukDRfAQXPYz2lN3pqta/mbV5ZvbcAF71EIotGa7Wli2dQyrrbz9eM6B9bMKbVL245zNX8gEXpkFlxyP8Kviv+yMZd1iCsKaUmuX3yXfVMlTux0/9Dds8Zxfm5vqIWY70FUyZBfLs9lhdhBnYjS+iDqFNMwqfDaVpVKvKtpYcgVNfWCPaxlAe932yZ3hymvEO20AereJ41PHK7Wb8sD99T2yuxOuvAUwFTBRAUDsAuKQ9XMiXyrq4fyyghFGPsYXbATQhlr4zP5A3LbaOaGluBpfZ5dIhkL8jTDpnF2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd/AoSwZuDc7qpeHrSYKhPhWpoHIBIOvKPVAiJCJWHw=;
 b=Lv75vgjWo0GEjh3cB30MLQLjn3QEPRQozQETdM0O0O0DMJCJ501BGILl75hGO0NomReYSVEOh9lUDzXcKdakaFdVgrED+I80Od+niLjD7lHVJDDyhWIfKmb9l9oK4vG1mA9ZtJ9pBT23ugW3jUYEHzSiCEcjekh4UiFXdi/Eoz8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 20:47:44 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 20:47:44 +0000
Subject: Re: [PATCH v3 1/8] drm/amdgpu: Implement DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598889049-28321-2-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <4547f8a5-5662-6821-6e88-d74c9d687e78@amd.com>
Date: Mon, 31 Aug 2020 16:47:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <1598889049-28321-2-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 20:47:43 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32905c5e-f45b-4d75-e4d7-08d84def1c39
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012104A7600B7BF86166795A99510@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wb6oH+eC6Hs4VK3U02ILj8qsj4iEpIhD+kDdRE4WKc+SVreya1oqg7DT6yfElCQZ8Rb7CPxplquMmlw59Cj42sue+wIp4NwGCeiuRX//OPWIkpKIlbE32KxhwbSQcWvYVgwQGN6sMSvGe7KxFmgMH8kZpHf5xAmM8RfWpqcm0ws61bOafTkwWThXG+P0QjS1IqWTiQajl3W1ON+RN7FlHA/0WTaccxGZb0i631ItseqCh6NpWxQFuE3lXm0YmJpm83rQ23rwQCcyRSrlBOYGPF35CMkTD2ThGvHgrKbBmFSOTLbt67Cstoz1y4l5t32/ok0jD/dvAdcOza2FAXwjS4wHpxCOqAy0q7lKKr07caGGicmTvTuQn0ioY8RXT62e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(36756003)(2906002)(316002)(8936002)(2616005)(8676002)(956004)(16576012)(4326008)(478600001)(52116002)(31686004)(5660300002)(83380400001)(44832011)(86362001)(66556008)(66476007)(53546011)(66946007)(186003)(6486002)(31696002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bP/R86MIP9CgWdD5nFrI6yfSMZpWvutOU9acFHek53OeyIMthFrX6RW0D/E9+eDhFFlk6gYzeFsweIr4STFtb0qjNkCRqUT3/z2KyZF4lkbFIXIU2mzUqbecNFGCB3DVAXSP1XAg+dLuD126oR3bSOlc19L04LHk+dK8lpPJq5GNc3622ubzkUdHYye+IAzyc0ZhQmSFE2giwr30jSIT+3rz15QvfXq6JkJZ1arUmUw3pkgPvpjPTg32sSbV7eExWeuYFidS0850EnZ0b3MMeTHoViVeegbWy/v/He+YzMVAtMCwh+1y97VpirEclR5AQj/F25M1n7j5GZPZYHVbtlKWTAzvU8k/zSKj3+df4YZ4AEcR6sNd1jrgaW7g9gJlorZZbVHbESO1xvnDXzNbBTB4fTIS/PXYaWgzi6gM+7r0KsJwnA0aaNamTU3mKonD35qBF4YLD1GXDux+eqdmGOJC1S8E74dKEi4olm7ASdFcRrii14W7uehF4kepPo3CBzU6YWLip+PMHM5/0cfKTvDgGRTC84aaOlhYk0I3tKb+zfJtIu/vljt14fwACdfjQM+HVgfdeqAOUhNKvUaOGRa0EHmxBTqlmsJp9DZ1rOrXKr2MG8Jh3jTp343sdTpWV98jZmmqRPlc3xd6kK5WHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32905c5e-f45b-4d75-e4d7-08d84def1c39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 20:47:44.1442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqBmQvpWmsndJ1L25Rs/Jvsf1/a/69AURmkf+I2puA+/zrrVe+tG6Q6VsGVR4E7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-31 11:50 a.m., Andrey Grodzovsky wrote:
> Add DPC handlers with basic recovery functionality.
> 
> v2: remove pci_save_state to avoid breaking suspend/resume
> v3: Fix style comments
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 162 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>  3 files changed, 179 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49ea9fa..3399242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -49,6 +49,8 @@
>  #include <linux/rbtree.h>
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
> +#include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_bo_driver.h>
> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>  
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> +					   pci_channel_state_t state);
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> +void amdgpu_pci_resume(struct pci_dev *pdev);
> +
> +
>  #include "amdgpu_object.h"

checkpatch.pl reports too many extra empty lines added,
like the one above and a few below.

Regards,
Luben

>  
>  /* used by df_v3_6.c and amdgpu_pmu.c */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a948ed..67d61a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2989,6 +2989,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>  	NULL
>  };
>  
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3207,6 +3208,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	pci_enable_pcie_error_reporting(adev->ddev.pdev);
> +
> +
>  	/* Post card if necessary */
>  	if (amdgpu_device_need_post(adev)) {
>  		if (!adev->bios) {
> @@ -4701,3 +4705,161 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>  
>  	return 0;
>  }
> +
> +/**
> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
> + * @pdev: PCI device struct
> + * @state: PCI channel state
> + *
> + * Description: Called when a PCI error is detected.
> + *
> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
> + */
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		/* Fatal error, prepare for slot reset */
> +		amdgpu_device_lock_adev(adev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	case pci_channel_io_perm_failure:
> +		/* Permanent error, prepare for device removal */
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
> + * @pdev: pointer to PCI device
> + */
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
> +{
> +
> +	DRM_INFO("PCI error: mmio enabled callback!!\n");
> +
> +	/* TODO - dump whatever for debugging purposes */
> +
> +	/* This called only if amdgpu_pci_error_detected returns
> +	 * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
> +	 * works, no need to reset slot.
> +	 */
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/**
> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
> + * @pdev: PCI device struct
> + *
> + * Description: This routine is called by the pci error recovery
> + * code after the PCI slot has been reset, just before we
> + * should resume normal operations.
> + */
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +	bool vram_lost;
> +
> +	DRM_INFO("PCI error: slot reset callback!!\n");
> +
> +	pci_restore_state(pdev);
> +
> +	r = amdgpu_device_ip_suspend(adev);
> +	if (r)
> +		goto out;
> +
> +
> +	/* post card */
> +	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_ip_resume_phase1(adev);
> +	if (r)
> +		goto out;
> +
> +	vram_lost = amdgpu_device_check_vram_lost(adev);
> +	if (vram_lost) {
> +		DRM_INFO("VRAM is lost due to GPU reset!\n");
> +		amdgpu_inc_vram_lost(adev);
> +	}
> +
> +	r = amdgpu_gtt_mgr_recover(
> +		&adev->mman.bdev.man[TTM_PL_TT]);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_fw_loading(adev);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_device_ip_resume_phase2(adev);
> +	if (r)
> +		goto out;
> +
> +	if (vram_lost)
> +		amdgpu_device_fill_reset_magic(adev);
> +
> +	/*
> +	 * Add this ASIC as tracked as reset was already
> +	 * complete successfully.
> +	 */
> +	amdgpu_register_gpu_instance(adev);
> +
> +	r = amdgpu_device_ip_late_init(adev);
> +	if (r)
> +		goto out;
> +
> +	amdgpu_fbdev_set_suspend(adev, 0);
> +
> +	/* must succeed. */
> +	amdgpu_ras_resume(adev);
> +
> +
> +	amdgpu_irq_gpu_reset_resume_helper(adev);
> +	r = amdgpu_ib_ring_tests(adev);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_recover_vram(adev);
> +
> +out:
> +
> +	if (!r) {
> +		DRM_INFO("PCIe error recovery succeeded\n");
> +	} else {
> +		DRM_ERROR("PCIe error recovery failed, err:%d", r);
> +		amdgpu_device_unlock_adev(adev);
> +	}
> +
> +	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/**
> + * amdgpu_pci_resume() - resume normal ops after PCI reset
> + * @pdev: pointer to PCI device
> + *
> + * Called when the error recovery driver tells us that its
> + * OK to resume normal operation. Use completion to allow
> + * halted scsi ops to resume.
> + */
> +void amdgpu_pci_resume(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	amdgpu_device_unlock_adev(adev);
> +
> +	DRM_INFO("PCI error: resume callback!!\n");
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d984c6a..4bbcc70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -31,7 +31,6 @@
>  #include <drm/drm_pciids.h>
>  #include <linux/console.h>
>  #include <linux/module.h>
> -#include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
>  #include <drm/drm_probe_helper.h>
> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
>  	.patchlevel = KMS_DRIVER_PATCHLEVEL,
>  };
>  
> +static struct pci_error_handlers amdgpu_pci_err_handler = {
> +	.error_detected	= amdgpu_pci_error_detected,
> +	.mmio_enabled	= amdgpu_pci_mmio_enabled,
> +	.slot_reset	= amdgpu_pci_slot_reset,
> +	.resume		= amdgpu_pci_resume,
> +};
> +
>  static struct pci_driver amdgpu_kms_pci_driver = {
>  	.name = DRIVER_NAME,
>  	.id_table = pciidlist,
> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>  	.remove = amdgpu_pci_remove,
>  	.shutdown = amdgpu_pci_shutdown,
>  	.driver.pm = &amdgpu_pm_ops,
> +	.err_handler = &amdgpu_pci_err_handler,
>  };
>  
>  static int __init amdgpu_init(void)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
