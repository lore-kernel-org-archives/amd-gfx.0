Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BAEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 14:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9722076C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EBI4DEIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9722076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA506E8EE;
	Wed, 12 Aug 2020 14:52:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76DC6E8EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 14:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk5dLY0ZDLtNhBWx9JmG0AgO4wFR7TQmNQnWahRxOCfont5SSLk8XCPZ5yW4E2+ub2AeHTQNeP9lcPiYCOdwJsVoeWzqM/vMTREPOsljcukX+W07b1LFldZBDhyBfcnNtERWkZYnZfryWkUq0NyTM2sR0jL5n8My/IBa95E5zxO6+KREE71MC1Tv6lpLm4+naWM28mxaGw+Z1uywzJ5NZa7+wck2QbLp9slMAAl1ksF0rEq5HTmGK/tE4kZxGUv1IWmq8mZfL1UOWktM/lgmZmp94UKDo9ZFMsGldBiokxO3Rmc4bKtrlMRqGUi01cKLb9fFpqVK/lvYW1fYZLNWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2E0bQ6OgnYHRb7MWR4OG2ZZfSx2cSEjDm2lQ5e7FLA=;
 b=irRSwrgUlILO/X68iSDgJPlc4NVzBundiJJtlMqKB/jN4WhnhbMM9KwBnJRAOpLeAoMEnQZJ5xkL420OMHCWmQSH/jojChzPkc1rtmFkt2RQq7H5fDDlE77I8VeGJS62C1WnNiInG//kDRtvehttYIvj+jMdAtRzMmFiQ4gY0bfWGIQLmOIh+qGNwqXkxH80HoBj3bFxDy2VJZGU5uELNtyqNKjHfiTpo5wNFs/uKurIy3OYgFtd7QhP7Nvc3zXLA/H/hhbwqNQTxg3OGVAjlmSfgWiegDU8UHjJnJBfVb2U6wXPRTp0ARr9UlvzqbRsJEyapSvkbgFZoaI5R1FHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2E0bQ6OgnYHRb7MWR4OG2ZZfSx2cSEjDm2lQ5e7FLA=;
 b=EBI4DEISXgeGeOKoDoTHj2r15cYh9D96x0ojWfJHsKFV6v5Lt7zlwY5shiv2GPcImWRUCmmd8BxowR2SGQXVQrsgaLuBJrckE6zafCqO4hXa8FcWYYwVcVSJApgqrgZDHDk1V6CHOV4js62I7xIcT1O7/Aj5YvSPS+5SpS1SLQ4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Wed, 12 Aug 2020 14:52:22 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%3]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 14:52:22 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200811133053.71123-1-nirmoy.das@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
Date: Wed, 12 Aug 2020 10:52:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200811133053.71123-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 14:52:22 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8962948d-c754-4bee-5559-08d83ecf51ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212F9E20170A488AE27693DEA420@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWNRAebmtdyVeElr7RFticYkNlWehx75MPokI/LYfZ+1eZOBi6Q2RjJ9M74S+g6JyCVNaSgQYnah2KWq06E+9q3SG3tCfwsqhtHgxb969LPNz0w87c385BB/jj2BWEv2To+eMRKqt3Mh9y43Bi8hun3Svs/+O6uPrZrYmj3i5dcEu1lW13txUxRzzLJ9TYqVs3u6LyRkck0YeZyy4qOxIGIMBoB/wb5VEiAQMRbk/43NqT/aNDKqqg7I0ryR6juOsbkM4/VV5OOXsWeqqy7QNjUZVkTlzcWYOA6DJAKHTFEIZssoq0BRljjslIbGVkkE7a49RSUvRQ2kok6IvL17dBqqhlS7tFTYVZkb/kQ0j334MbNnMIrLGmFdUoCG1aijPLUYAJ9aqIPvf+cfVH8TipyyLIKZnVXzyx1lf532Yl+dU/TYAGqoCocWFYazb5q/JLCrimHEuircCsP5vmYYNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(6486002)(316002)(36756003)(2616005)(16526019)(66556008)(66946007)(8936002)(66476007)(26005)(186003)(8676002)(53546011)(956004)(86362001)(52116002)(16576012)(4326008)(966005)(31696002)(478600001)(5660300002)(83380400001)(31686004)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tb5992soF67SYpQti86IoJ3UKyj0g+tie8b/lC201AgRuRbqWNs+my0UFMYPeJEJSmmHvJ/tXEak+jHuQ7fpKz2io3ERAqshlWotlmlnX1cEEUmEa3zU2Vj5vmqX7PgTQgeIpCipP1+yrAOemhzVNV3J7mhOKLehSxfAbY69zSDjeAxwmMAfJn+l/jiCPD0YL2rQZHFDK4nom3gL2OfWPaxbQavUvgymMbWCdTs1+YCFcsKdEuHoau3UdKUc1OtZV0Sv6Ptu4+qVO2I5zAxpFJK+j3KbyE9My0fMwi0T/zz1fRaPuy4cpmGlcPFDM9SOgXYTMZNg3oFXlPEdcCDbPm406u6sD4/Pxb8ap2ukQKmoX2x4nv0uQYHF0Jk6kbK8ylMHatOZIjqWX5UkcrkPiT46+lR2oKMoq2M8AjQQajlUFGDqA3fKG415D5Uuq93As1BoMDLp0iyIUY928rG5/PVAp9yxmMx5GscHE+3EFSfubR7RzUdbprPOfSVdMMRbEC1LUEgvOSRJ9pXiCxh54KqXdK/unhPAbNcmFAvQLlzRZl4ajxZHwDz+oLAvQTC3SZw5IIAjx0EFdIkIbJN+8zzi6lyZeLCSRh2TZl2/LQaPCowIgzeLLIfgjUJFo9xI8ycUy3bjIAzX3RtPq787EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8962948d-c754-4bee-5559-08d83ecf51ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 14:52:22.4416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV0SOzsdQUnflbLFs3b+sZlSAB0HOq8mTqqAh82JTl1uNsLVDDJNkZVDsnhWePhoqgdtFIf5Po1BhzWhVN001A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/11/20 9:30 AM, Nirmoy Das wrote:
> This patch will ignore non-fatal errors and try to
> stop amdgpu's sw stack on fatal errors.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 56 ++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c1219af2e7d6..2b9ede3000ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -35,6 +35,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/vga_switcheroo.h>
>   #include <drm/drm_probe_helper.h>
> +#include <drm/drm_atomic_helper.h>
>   #include <linux/mmu_notifier.h>
>   
>   #include "amdgpu.h"
> @@ -1516,6 +1517,58 @@ static struct drm_driver kms_driver = {
>   	.patchlevel = KMS_DRIVER_PATCHLEVEL,
>   };
>   
> +static pci_ers_result_t amdgpu_pci_err_detected(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = dev->dev_private;
> +	int i;
> +	int ret = PCI_ERS_RESULT_DISCONNECT;
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		ret = PCI_ERS_RESULT_CAN_RECOVER;
> +		break;
> +	default:
> +		/* Disable power management */
> +		adev->runpm = 0;
> +		/* Suspend all IO operations */
> +		amdgpu_fbdev_set_suspend(adev, 1);
> +		cancel_delayed_work_sync(&adev->delayed_init_work);
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = adev->rings[i];
> +
> +			if (!ring || !ring->sched.thread)
> +				continue;
> +
> +			amdgpu_job_stop_all_jobs_on_sched(&ring->sched);


You need to call drm_sched_stop first before calling this

> +		}
> +
> +		if (adev->mode_info.mode_config_initialized) {
> +			if (!amdgpu_device_has_dc_support(adev))
> +				drm_helper_force_disable_all(adev->ddev);
> +			else
> +				drm_atomic_helper_shutdown(adev->ddev);
> +		}
> +
> +		amdgpu_fence_driver_fini(adev);
> +		amdgpu_fbdev_fini(adev);
> +		/* Try to close drm device to stop applications
> +		 * from opening dri files for further IO operations.
> +		 * TODO: This will throw warning as ttm is not
> +		 * cleaned perperly */
> +		drm_dev_fini(dev);


I think user mode applications might still hold reference to the drm device 
through through drm_dev_get either by directly opening
the device file or indirectly through importing DMA buff, if so when the last of 
them terminate drm_dev_put->drm_dev_release->...->drm_dev_fini
might get called again causing use after free e.t.c issues. Maybe better to call 
here drm_dev_put then and so drm_dev_fini will get called when this
last user client releases his reference.

Also a general question - in my work on DPC recovery feature which tries to 
recover after PCIe error - once the PCI error has happened MMIO registers become
unaccessible for r/w as the PCI link is dead until after the PCI link is reset 
by the DPC driver (see 
https://www.kernel.org/doc/html/latest/PCI/pci-error-recovery.html section 6.1.4).
Your case is to try and gracefully to close the drm device once fatal error 
happened, didn't you encounter errors or warnings when accessing HW registers 
during any of the operations
above ?

Andrey


> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct pci_error_handlers amdgpu_err_handler = {
> +       .error_detected = amdgpu_pci_err_detected,
> +};
> +
> +
>   static struct pci_driver amdgpu_kms_pci_driver = {
>   	.name = DRIVER_NAME,
>   	.id_table = pciidlist,
> @@ -1523,10 +1576,9 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>   	.remove = amdgpu_pci_remove,
>   	.shutdown = amdgpu_pci_shutdown,
>   	.driver.pm = &amdgpu_pm_ops,
> +	.err_handler = &amdgpu_err_handler,
>   };
>   
> -
> -
>   static int __init amdgpu_init(void)
>   {
>   	int r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
