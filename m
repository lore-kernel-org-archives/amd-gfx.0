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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA6EC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D6B2067C
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fOu1I4cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D6B2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A854D6E418;
	Mon, 31 Aug 2020 21:05:55 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163126E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 21:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDlAZ0p9IZ5yu38nuKujodp88GEU4P0uSYfkyL4uaeF15DmzGNwHlSnneipo0AlrCMVuT17NsUdAxhs3nI7AjhngK23WuniHT51w4x4pRFYSUYJnTaE0Go5teDT4p9lp+tLZKc07TN7bdBMv63Aww/Kf++228p5fQ78iqybqxIgo+iI6KYgZgybkjGn3bwy0vQAgW5sRtm06funp5+oF6cnb7Qx1UxwPs5NZ6Q8kvh3JWLErMgBABNvojHWZhKv322nJB1U7TVaW6P47ejUSQqM7xZJobwKK+sBcuK0/1xANC+xMcmKn3hLvHQvYr0AfPi9Ci/BHpLc/M1bfPA/Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGCmec7zJ5bXTofCUpo8QSVq6SztJrkCIABUnPSu6fs=;
 b=nrTwpd/46YRoP01rSirA1uQ/uHUkHRI7AVA0H/Nq1Z7kJiPBo4FTkWOWk3prX2NKrUVKIrK2rapCJQjcCz8B0oREXlqfKKXuqeALlm5+F0h9f3fITzqUqNgEb74yOfGdQnxLxf8xVQjlMFTdDOgk873ZAFxr1+xToqYduhWB0IaQOoIldRSbKCzoXAo59DGhUJBqyugjplbxw5xDPhuTVXK3dl3wlCLH6AUn0E9A4fFngw21J7n9WNFYAmhCXLWzvMNYFsNczK8pfOVjTIusxMMeHEb8NG7XFY4EG6slJQhhUyb5xBqSbmL/MSPIabYoc1fdfYEWUbyqE6+PhRpabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGCmec7zJ5bXTofCUpo8QSVq6SztJrkCIABUnPSu6fs=;
 b=fOu1I4cSTUhRn4rqF9j45PWCeQ3MT8XwKnGWlOMaQDbeuW+H/DZlPNbLZIm3mBv+UMdN25OJTbj+IcMDl6hFEBlWtZQG4P33rIofscjdTQkeLzu/QFR+UpjFgxyYvX0L1V7DZeS1y1YFz2jX3RPdghwVEv3tT+b01E8m4PzYwRk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 21:05:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 21:05:52 +0000
Subject: Re: [PATCH v3 5/8] drm/amdgpu: Fix consecutive DPC recovery failures.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598889049-28321-6-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7f867417-4287-9aea-a939-38dc9947940c@amd.com>
Date: Mon, 31 Aug 2020 17:05:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <1598889049-28321-6-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 21:05:51 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77d3c352-7596-44ac-6e60-08d84df1a4ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26175849C9CBB593BA7A8E1399510@DM6PR12MB2617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2TltpIaogWlOYM+NAOge5fNv3AI46rgrzmTaDoDLhvdwtWz4ykw9zvThCUmMpCvALCsPv/5iP+q9f9b1TOTt+zBN751Z//OLfuW9AmYI8VY3GaCHlJDDixJKwnEzZXsYFgjenXe2dil0fNON6Hpbs6kX/qEbT316MIsuEW/RTcMztdHpx5x+e9/XBOli816ieMqnSnKrbNTpapa2Hr94DvKdTv5qmnl4bjeuxzc+VtNwYRqorHdH3QO51A+h4Ztbji9g3ZlIb+SlTlvFiO4ZL4yBEWDQHxCDVBiBgi3/PhRfTuBIfWEGbZfsY4XSxn1rZarAI+nx5iqlDoFQYCasBPXeL1Eueazkh+Rpa4Txc02lmD9/Wge+2/JkUpC+MYD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(8936002)(83380400001)(31696002)(16576012)(5660300002)(316002)(186003)(66946007)(8676002)(52116002)(2906002)(478600001)(4326008)(956004)(2616005)(36756003)(86362001)(53546011)(66556008)(31686004)(44832011)(6486002)(66476007)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ArRq9JRQ09+wYriWGXEhEz93q02H0IHQ30bE9sCBL1SshX3t/p4445QgHCDVZ4aCa7wMSXD0j9XsXoSEc0+9LsDNHLaCdZ4SwJn8O1JIapXHAuGM5Ae2M/GXjA+gCqUQQiZ8+Jc5DvfqAr3MGlWrGXPmcg6E5dExrNvfynevEp8qU6gJ3jdes8q2am6zsJJb3/11sslEvAUFRuGIGrEm8hknIUjIEG3jJXFk/NBSmfaWEKpciAlsWfJB/8ChoxjnMr7/zzfrSUABiSEocmBqGJwE17DwIkP74Azdbar9VGK0NcvOS23X9nr+9juzxCqLZhGPK70yV3UrGjzsEa0FOxQfPPfSCWmUlMNNphwcpAgbx2tCDpmriEFFqRn5hFw59Opd7OS3ONoOuk2X3b1pEVa/mTOQjeh5IzkwtW2dSMmBzM7XmMCivVVoPPjnUSsJ8cPTMQhN0h6eum3ZNstcaVcob6ER9lU7kGsXMgHm7c6F3or73TS8YB0bXFvDes+5IzkmZHehhkic0BHCjiELik5WKNjiK/ysFC70tQgfUqr6K5AWW7mgcCYfTM3WgwOB/ud0Bc6jL5nwxnQwsPm0GLyH05FwhWpC2pt6W68if+0G/84cOJuFptlIpVLrRTPgWsSC4tju9dDHv8J41h6KPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3c352-7596-44ac-6e60-08d84df1a4ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 21:05:52.0174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJUYSqDOn6545OC9HrJylGSe2NvmyoszzskVTYfd/m//Z36ZPnFnhmMt5mhwOySd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
> Cache the PCI state on boot and before each case were we might
> loose it.

Typo: "were" --> "where".

> 
> v2: Add pci_restore_state while caching the PCI state to avoid
> breaking PCI core logic for stuff like suspend/resume.
> 
> v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
> to avoid superflous restores during GPU resets and suspend/resumes.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 ++++++++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>  5 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cac51e8..5e74db6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,7 +992,9 @@ struct amdgpu_device {
>  	atomic_t			throttling_logging_enabled;
>  	struct ratelimit_state		throttling_logging_rs;
>  	uint32_t			ras_features;
> +
>  	bool                            in_pci_err_recovery;
> +	struct pci_saved_state          *pci_state;
>  };
>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>  pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>  void amdgpu_pci_resume(struct pci_dev *pdev);
>  
> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> +
> +

Unnecessary extra line added.

Regards,
Luben

>  
>  #include "amdgpu_object.h"
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4a009ca..0329b43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1282,7 +1282,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>  		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>  
>  		pci_set_power_state(dev->pdev, PCI_D0);
> -		pci_restore_state(dev->pdev);
> +		amdgpu_device_load_pci_state(dev->pdev);
>  		r = pci_enable_device(dev->pdev);
>  		if (r)
>  			DRM_WARN("pci_enable_device failed (%d)\n", r);
> @@ -1295,7 +1295,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>  		drm_kms_helper_poll_disable(dev);
>  		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>  		amdgpu_device_suspend(dev, true);
> -		pci_save_state(dev->pdev);
> +		amdgpu_device_cache_pci_state(dev->pdev);
>  		/* Shut down the device */
>  		pci_disable_device(dev->pdev);
>  		pci_set_power_state(dev->pdev, PCI_D3cold);
> @@ -3400,6 +3400,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>  
> +	/* Have stored pci confspace at hand for restore in sudden PCI error */
> +	if (amdgpu_device_cache_pci_state(adev->pdev))
> +		pci_restore_state(pdev);
> +
>  	return 0;
>  
>  failed:
> @@ -3426,6 +3430,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>  	flush_delayed_work(&adev->delayed_init_work);
>  	adev->shutdown = true;
>  
> +	kfree(adev->pci_state);
> +
>  	/* make sure IB test finished before entering exclusive mode
>  	 * to avoid preemption on IB test
>  	 * */
> @@ -4850,7 +4856,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  	/* wait for asic to come out of reset */
>  	msleep(500);
>  
> -	pci_restore_state(pdev);
> +	amdgpu_device_load_pci_state(pdev);
>  
>  	/* confirm  ASIC came out of reset */
>  	for (i = 0; i < adev->usec_timeout; i++) {
> @@ -4930,6 +4936,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  out:
>  
>  	if (!r) {
> +		if (amdgpu_device_cache_pci_state(adev->pdev))
> +			pci_restore_state(adev->pdev);
> +
>  		DRM_INFO("PCIe error recovery succeeded\n");
>  	} else {
>  		DRM_ERROR("PCIe error recovery failed, err:%d", r);
> @@ -4969,3 +4978,50 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  
>  	amdgpu_device_unlock_adev(adev);
>  }
> +
> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	r = pci_save_state(pdev);
> +	if (!r) {
> +		kfree(adev->pci_state);
> +
> +		adev->pci_state = pci_store_saved_state(pdev);
> +
> +		if (!adev->pci_state) {
> +			DRM_ERROR("Failed to store PCI saved state");
> +			return false;
> +		}
> +	} else {
> +		DRM_WARN("Failed to save PCI state, err:%d\n", r);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	if (!adev->pci_state)
> +		return false;
> +
> +	r = pci_load_saved_state(pdev, adev->pci_state);
> +
> +	if (!r) {
> +		pci_restore_state(pdev);
> +	} else {
> +		DRM_WARN("Failed to load PCI state, err:%d\n", r);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4bbcc70..7a6482a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  		if (amdgpu_is_atpx_hybrid()) {
>  			pci_ignore_hotplug(pdev);
>  		} else {
> -			pci_save_state(pdev);
> +			amdgpu_device_cache_pci_state(pdev);
>  			pci_disable_device(pdev);
>  			pci_ignore_hotplug(pdev);
>  			pci_set_power_state(pdev, PCI_D3cold);
> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  			pci_set_master(pdev);
>  		} else {
>  			pci_set_power_state(pdev, PCI_D0);
> -			pci_restore_state(pdev);
> +			amdgpu_device_load_pci_state(pdev);
>  			ret = pci_enable_device(pdev);
>  			if (ret)
>  				return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 4d14023..0ec6603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>  	/* disable BM */
>  	pci_clear_master(adev->pdev);
>  
> -	pci_save_state(adev->pdev);
> +	amdgpu_device_cache_pci_state(adev->pdev);
>  
>  	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>  		dev_info(adev->dev, "GPU smu mode1 reset\n");
> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>  
>  	if (ret)
>  		dev_err(adev->dev, "GPU mode1 reset failed\n");
> -	pci_restore_state(adev->pdev);
> +	amdgpu_device_load_pci_state(adev->pdev);
>  
>  	/* wait for asic to come out of reset */
>  	for (i = 0; i < adev->usec_timeout; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 2f93c47..ddd55e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
>  	/* disable BM */
>  	pci_clear_master(adev->pdev);
>  
> -	pci_save_state(adev->pdev);
> +	amdgpu_device_cache_pci_state(adev->pdev);
>  
>  	ret = psp_gpu_reset(adev);
>  	if (ret)
>  		dev_err(adev->dev, "GPU mode1 reset failed\n");
>  
> -	pci_restore_state(adev->pdev);
> +	amdgpu_device_load_pci_state(adev->pdev);
>  
>  	/* wait for asic to come out of reset */
>  	for (i = 0; i < adev->usec_timeout; i++) {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
