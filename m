Return-Path: <SRS0=m/vD=CH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD93C433E6
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB27C20838
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sRavTMWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB27C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807A66E09C;
	Sat, 29 Aug 2020 02:07:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693CD6E09C
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2020 02:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go7MXN/PqIXvvZZBFqL+2IDRnNe5vOGOQkM2JpCOMf9ugZ3F07WLoQxdnEiOE9zCD+H1oKiL5c6FswDNJRzMykXhuhPxWKkMU+SArS4MlW38tGUWnsIkgFOnpACstpr/4iBymvXZF9SMenSWTF4HaXh52AZ+pRicmOFmQUSKqZ3dLmk74KmFsSYuST9BB2F0b+qMB8utP3AP5o94YVozXbhj0HF/kRb9wfEXFOIedNdeAnV9jIGkUedM5O9Bi6uDteuNky7pt+UuSNAgMdfqn1nl3BaiqAJaq8CbUW216g0/bmA0eO2zNAr8jKoZ++F4qrvYC6waUPxRIMX2Opew1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kapY8VhHQE5uB2O24wmFDovJ7JTdvcsvPJjxC6LHs0=;
 b=SDmmN24spAgcUe3QUIJja4FISJqiF8skxTjod5otCPbBI62Tvl54Eajqhk8XoXrTAG0jTetejg9w8lPRBkM/hsMqTevPhZMohsgDKKghH0O0Hzd5F6nLHGs3Qsa7M6aSRvN4+ozlziv6CSKTGU7aTFPHN6b5/Oacv4hEdP8XzbCiwNhGPN1GnphPNJrvgCjc5ndu0bfYt6VXALocVLeOBbcC60JMrKa3N3wJ/yrJ0HZeAnxnQz6QaovVIEPuhhsaYNpiWf04AypM4MzUif+S6CoEpObMyIM/SAO6ZdEov+phYosYbBVBoKoLHUOXLB6HkaKuDF36mYE7lmRX3wOyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kapY8VhHQE5uB2O24wmFDovJ7JTdvcsvPJjxC6LHs0=;
 b=sRavTMWEQQQFKu2OkFON2s66grbuIs2TorObvyWrGiNrO7Ofxfl+wj9PUiIxc0NVgBZA8xnH+LvLrh7/VgRFETCBxoiMpac4v2fAEJu6jRv8FyTEPtkcBUzOk473MJ8mt/fl32n+WWahHfTXOuNPXh0I+5KQ/J3G2VqNUBcwSaE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 29 Aug
 2020 02:07:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3305.033; Sat, 29 Aug 2020
 02:07:33 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <629145d5-6acd-c838-6b80-8f110fce3c73@amd.com>
Date: Fri, 28 Aug 2020 22:07:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 02:07:33 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b5ad452-d0b9-4bbd-517d-08d84bc04af5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986F58A54201AF126CC754C99530@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZSjPwnckrPd1sNfjg2nDyhw/WlVvNWLm47G9ry300rzDVKecg4fijKiCpRlZ09Fglr1WdHPxSCGfvNhSwvL4Wap/OXrEscKMOEL9AA2OgfaU2HWORUn5Nn5yu4OEZ3JkJn9jbDlptcLyq2Ev420y3NxIZ7B4leZ8LtVqCJJ35wqgGa+6TPKOJdx5AxDDzhn08ARMfS7bnrQcaDZKnxYR9vfgEzM9WSpLYsRcyBz0EPQU7GWcjncHe9SHn0nnMhfpzYogOWSamomC1B/I704Vde/0vE+4IkCtBjtoeRJb/O34Znyzu4jsm9rgi80s0C1HwSY6+cyoIdY1vp652QBLRX6fmfaOZPxemwVRuypBN3s+agVmCbmf91/176Nrm/V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(83380400001)(36756003)(2906002)(53546011)(186003)(16576012)(31686004)(8676002)(26005)(8936002)(52116002)(956004)(2616005)(31696002)(30864003)(316002)(66556008)(478600001)(66946007)(66476007)(4326008)(6486002)(5660300002)(44832011)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5ZlmCrNqyP0G3dkgzjhds+5EsRoPXs4cLVc2qFF11+pF2E8Y0+4EQjH7z4+FHfWn0Q4PX/8hQIbItL7t5FCd6o9lp0UXO9mbdXqy0oC2PeoqR8Bg26HIrAxNZD+zBwxG80SVb8qyhSaM/d21wyGPuqwdxYAYv9T5TSNOwYN+16D2QWWWLQhqEIr/ze4NsV0rd0hYZb2U9/+QqSBO0pXHpA6n8W7VSj5IIsq5M+l93nyko/xP87iHpfJVAlLlgXqroAfuCRqdttyZvWFc4REa00UcCLbBOjZRb6zd4YMRtJAM9v8puv1uE1G/O1kJW5mD8g+fhgJtZ7jdVRWq6mhJWkTrlg/y1a6MNyHGRrNrXo6RHs5qyhcH+pbJYrm1Ke0RCJJEmmPKY5yDVm92loJzZ9NOJXbrkz3wTykdEfVtrFbLINb5SzBz80t/AFnnz0zoT8QM4+ZFhbW8rS+8B3fNf+qphX7rlgzdSAJ3ce/JuaRHVrBz1Z5JvRX0R6A92xorrh+59RaQYGKAr5JGx61GcRk7XbP3S7jD2eqrCr2jUv9Xc2oKvuA6vzxf7AowDICOtD0qs1KuEyErj+EWVkKW8g5PuZXcw5fre1qt5W+F3187F6o06kRo1hyr4USWSQOJp8FZclNWi9rpWi2v7baAWw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ad452-d0b9-4bbd-517d-08d84bc04af5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 02:07:33.7399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2vbZDLs9AAfN5prO3HBV/sZ76xNuhW7vBuicZtMLqAnucKKYBcKnjvEAUbxp+0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-26 10:46, Andrey Grodzovsky wrote:
> Add DPC handlers with basic recovery functionality.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>  3 files changed, 196 insertions(+), 3 deletions(-)
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
>  
>  /* used by df_v3_6.c and amdgpu_pmu.c */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a948ed..84f8d14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   *
>   * Returns the 8 bit value from the offset specified.
>   */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> +{
> +
>  	if (offset < adev->rmmio_size)
>  		return (readb(adev->rmmio + offset));
>  	BUG();
> @@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>   *
>   * Writes the value specified to the offset specified.
>   */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> +{
> +
>  	if (offset < adev->rmmio_size)
>  		writeb(value, adev->rmmio + offset);
>  	else
> @@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>  
>  void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>  {
> +
>  	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>  
>  	if ((reg * 4) < adev->rmmio_size)
> @@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  		    uint32_t acc_flags)
>  {
> +
>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>  		return amdgpu_kiq_wreg(adev, reg, v);
>  
> @@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   */
>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>  {
> +
>  	if ((reg * 4) < adev->rio_mem_size)
>  		iowrite32(v, adev->rio_mem + (reg * 4));
>  	else {
> @@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   */
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  {
> +
>  	if (index < adev->doorbell.num_doorbells) {
>  		return readl(adev->doorbell.ptr + index);
>  	} else {
> @@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  {
> +
>  	if (index < adev->doorbell.num_doorbells) {
>  		writel(v, adev->doorbell.ptr + index);
>  	} else {
> @@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   */
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  {
> +
>  	if (index < adev->doorbell.num_doorbells) {
>  		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>  	} else {
> @@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  {
> +
>  	if (index < adev->doorbell.num_doorbells) {
>  		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>  	} else {
> @@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>  	NULL
>  };
>  
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	pci_enable_pcie_error_reporting(adev->ddev.pdev);
> +
> +
>  	/* Post card if necessary */
>  	if (amdgpu_device_need_post(adev)) {
>  		if (!adev->bios) {
> @@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>  
> +	if (pci_save_state(pdev))
> +		DRM_ERROR("Failed to save PCI state!!\n");
> +
>  	return 0;
>  
>  failed:
> @@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
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
> +	case pci_channel_io_frozen: {
> +		/* Fatal error, prepare for slot reset */
> +
> +		amdgpu_device_lock_adev(adev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	}
> +	case pci_channel_io_perm_failure:
> +		/* Permanent error, prepare for device removal */
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}

Perhaps an empty line before the "return".

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
> +	if (!r)
> +		DRM_INFO("PCIe error recovery succeeded\n");
> +	else {
> +		DRM_ERROR("PCIe error recovery failed, err:%d", r);
> +		amdgpu_device_unlock_adev(adev);
> +	}

Add braces around the "if ()" if you're going to add them
around the "else".

It's a good idea to run patches through checkpatch.pl--as
a general guidance--sometimes it finds good things.

Regards,
Luben

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
