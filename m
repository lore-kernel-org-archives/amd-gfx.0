Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF436C77B72
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 09:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698BC10E3BD;
	Mon, 17 Apr 2023 09:44:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1DA10E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 09:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRTxjsBqspDgKU3W4TqVYl8xbunFHL9drawr418Xp4s0XWqz7TjakjyAVrNi7ppzStkylQlRcJSvvLvdynjZxCoXJxr5wFqSOFjzu0hQ6mT2WGSIx2+uyZdhQ9IPLcxIhj7yp6GCidJ3WF6CWtT8CNmS6WMyotQ7mFFovuOd5ZzOPgA3QU/4uSYZdAv03T5YifGrxHlqEhSEIuul/cSxATs+CPLPxw0LqE9DT9yJf4Ar28LScyygchi5DqIl82HbL1Yb+3tEIpMOZPsLRse9q+dFrh8Ln3SLxAOPN99ttBdX3uXvFyDowNI7njUN85/xYmMryktn1ZFrHvxr0r3Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDdB41wmM55rXOvLaFGJEuHKtRcNNMJ9xAeV6dByd8c=;
 b=aDo/F205S+JodlAPGEbGN38/Wf76Opj+KSXa/rv8VfHoP7h7hcruGb280PHD8IjCoFbOXJ89cC1Zmr1CMD/9OvDFBg4glmxLaOKywPaE8U0606vSgYklHD2YVfr7zjiJcVfPPl4ce8em8ZSwcYLoq203q28+Vr5HLRHYUFWWqnYwXQ3+nNa1ww8J3SxiT0B6AKACkySWLUcAUKaNqP86P7dyPLu4oag1aRfpZze1d+TUhtoR/ySEsBxdj0j3zefTSaRe6ffTtuSGXpFgYaQlnSOpleNZ0oF3OeXJI4VDdQKT8+19b6QWx+RcgcDcutp44vfGioPUj1kJKIxNiL3T6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDdB41wmM55rXOvLaFGJEuHKtRcNNMJ9xAeV6dByd8c=;
 b=O+AnBgWPQvH0A91OUtKd/W+cpauNMD/syLBJpIVWMWMq86UkFV/yS/33BjwaPxspJj6qI5bpKAFvQAxpjVSjLPckJiIioftD9WXM0rqUXtSQYuRhmPXGRrtktAS6qFK7NK7lv+BzcYZUHFk3obQzCi4+fmBteYnpZI7cazRSqsI=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 09:43:54 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::99) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 09:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.19 via Frontend Transport; Mon, 17 Apr 2023 09:43:54 +0000
Received: from [10.65.158.62] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 04:43:53 -0500
Message-ID: <c72555f5-f0e3-a322-f794-05355e68ee2c@amd.com>
Date: Mon, 17 Apr 2023 17:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amdgpu: release gpu full access after
 "amdgpu_device_ip_late_init"
To: <amd-gfx@lists.freedesktop.org>
References: <20230414084159.95965-1-chongli2@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <20230414084159.95965-1-chongli2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 07184fd2-e219-42b4-2a22-08db3f28421c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AYDMv3RIKqceuEtxtuWo17bwK7Kkabx1REJy3Cp4GIXubNkbFPyBpP5LTc4dIiM60pQaDxO1+UVIjGPhh3pGcHEHU7f02xl/UtTrRXdiba3xkZiLEbQraeANBM/4a4Hcc3Cmo85x/nHZfWwAJzZUh63VuzC2Ov7FfEM7KLDI9EWis4V+ONaYQhb1rEC07DIjov9xQ+P+KCQf+X+hWC7lmtRcj7JAeVgLz7KTG864WjBfLEPMMbc9R/+LKec3Bv0Iw0rAinKCGWlEdoVFjrAdI6irTdb583yCBiWJKtl+4N2dsYG0aCwXH85scJg8ltmWPrPQb9FYggGImExpGkmwaE/RSSkCuO69ltYSuH7KnrOGELNovH+xLoo+uxTKIJdFth5saIvth5NvcvbnA2FNUFCfSEccLz1NVjurg7h0YM5k0X31chAYMvkIhHpMIofJvqsidZ4S6IcdhpsTVBjZAXcNKdDEwFpvUPa+BYk2kAFxJ8C06hUNGb9NCnlJq1Il8V+Kl2XCq839MHkYHfczOM5v1rWAgu1yHwmOk2oUty4KuPicDhKydEJgfcQHgWQGaXhN4xCfPzpnBmwhsCSm3FUWnfEGwajHuvgoXK/dduHmxQ7pbFZxWFTfBcJTKPeuFArWW+4uughFDsdFOHi5fLpk+DIRJOG6nNJ+0aDYIlg8SMG8Qp10mLn1MpqpFpZ+jWowYjtPSMbub9WPlIOO3AuGoHnc5ZwbliqESF3oxhscJuiyli2t2jJrL3nlqmqkkZo1TtcqZL26gSu45STLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(70586007)(2616005)(336012)(426003)(70206006)(82740400003)(83380400001)(478600001)(16526019)(6666004)(16576012)(53546011)(26005)(186003)(31686004)(36756003)(316002)(5660300002)(82310400005)(81166007)(41300700001)(356005)(2906002)(8936002)(40460700003)(31696002)(6916009)(8676002)(40480700001)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:43:54.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07184fd2-e219-42b4-2a22-08db3f28421c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: JingWen.Chen2@amd.com

On 4/14/23 4:41 PM, Chong Li wrote:
> [WHY]
>  Function "amdgpu_irq_update()" called by "amdgpu_device_ip_late_init()" is an atomic context.
>  We shouldn't access registers through KIQ since "msleep()" may be called in "amdgpu_kiq_rreg()".
>
> [HOW]
>  Move function "amdgpu_virt_release_full_gpu()" after function "amdgpu_device_ip_late_init()",
>  to ensure that registers be accessed through RLCG instead of KIQ.
>
> Call Trace:
>   <TASK>
>   show_stack+0x52/0x69
>   dump_stack_lvl+0x49/0x6d
>   dump_stack+0x10/0x18
>   __schedule_bug.cold+0x4f/0x6b
>   __schedule+0x473/0x5d0
>   ? __wake_up_klogd.part.0+0x40/0x70
>   ? vprintk_emit+0xbe/0x1f0
>   schedule+0x68/0x110
>   schedule_timeout+0x87/0x160
>   ? timer_migration_handler+0xa0/0xa0
>   msleep+0x2d/0x50
>   amdgpu_kiq_rreg+0x18d/0x1f0 [amdgpu]
>   amdgpu_device_rreg.part.0+0x59/0xd0 [amdgpu]
>   amdgpu_device_rreg+0x3a/0x50 [amdgpu]
>   amdgpu_sriov_rreg+0x3c/0xb0 [amdgpu]
>   gfx_v10_0_set_gfx_eop_interrupt_state.constprop.0+0x16c/0x190 [amdgpu]
>   gfx_v10_0_set_eop_interrupt_state+0xa5/0xb0 [amdgpu]
>   amdgpu_irq_update+0x53/0x80 [amdgpu]
>   amdgpu_irq_get+0x7c/0xb0 [amdgpu]
>   amdgpu_fence_driver_hw_init+0x58/0x90 [amdgpu]
>   amdgpu_device_init.cold+0x16b7/0x2022 [amdgpu]
>
> Signed-off-by: Chong Li <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++----------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 051b9e231cf4..ee21a99ab4d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2538,8 +2538,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	amdgpu_fru_get_product_info(adev);
>  
>  init_failed:
> -	if (amdgpu_sriov_vf(adev))
> -		amdgpu_virt_release_full_gpu(adev, true);
>  
>  	return r;
>  }
> @@ -3856,18 +3854,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	r = amdgpu_device_ip_init(adev);
>  	if (r) {
> -		/* failed in exclusive mode due to timeout */
> -		if (amdgpu_sriov_vf(adev) &&
> -		    !amdgpu_sriov_runtime(adev) &&
> -		    amdgpu_virt_mmio_blocked(adev) &&
> -		    !amdgpu_virt_wait_reset(adev)) {
> -			dev_err(adev->dev, "VF exclusive mode timeout\n");
> -			/* Don't send request since VF is inactive. */
> -			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> -			adev->virt.ops = NULL;
> -			r = -EAGAIN;
> -			goto release_ras_con;
> -		}
>  		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
>  		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
>  		goto release_ras_con;
> @@ -3936,8 +3922,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>  	}
>  
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev)) {
> +		amdgpu_virt_release_full_gpu(adev, true);
>  		flush_delayed_work(&adev->delayed_init_work);
> +	}
>  
>  	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
>  	if (r)
> @@ -3977,6 +3965,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  release_ras_con:
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_release_full_gpu(adev, true);
> +
> +	/* failed in exclusive mode due to timeout */
> +	if (amdgpu_sriov_vf(adev) &&
> +		!amdgpu_sriov_runtime(adev) &&
> +		amdgpu_virt_mmio_blocked(adev) &&
> +		!amdgpu_virt_wait_reset(adev)) {
> +		dev_err(adev->dev, "VF exclusive mode timeout\n");
> +		/* Don't send request since VF is inactive. */
> +		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +		adev->virt.ops = NULL;
> +		r = -EAGAIN;
> +	}
>  	amdgpu_release_ras_context(adev);
>  
>  failed:
