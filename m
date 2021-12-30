Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C9DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Dec 2021 10:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F90210E338;
	Thu, 30 Dec 2021 10:01:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C6F10E338
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 10:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfV0i9y76u2crDMycKXvAoZNOJBly0GPeratSKlRwt2Ea2MjbLZh2caNkZbYhk8DFpUatwVw3LXnng7JPc4K3h1XWR2Xlyfdcx3LG6eyXCUopKTUnZXSX5du33Q2jBE5dSleU+0/KJ04elQ3k/qlTJMbhH2/CX5UjUEcz53VcLjRatdOHp/WoiCZgBFoTy+sCaILbfqcYLnlEqiOUmaGllpxov8PMVHhQ2FJQXNfWMoAPHbCL+KVRl7Xx1DXJue4iBzU8HjoCZNflRe+SfyZVq1UngGv8oKPNC6HHqWQH0DsADwRvCWiBqrrhibBK1nCROWJiZWx30tuxtDmVqvySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C9rUKeAgX5/dzVSx74xWDp5SsjAZFgVqvG4PwBHSlY=;
 b=jPgOUfuAqEoVNELRE28Ij3n+/G85s7f4RnIl5lUSw0FfbqM08kxkN8DkBcCr/XpiZcnjGb6KdHynAHxd/PnctWSkZGXuasCtNTWecUKkTfLj1HQZ9Ridv5sZ0RTsOV3ffEeEntuxc4rzFVy4tKvG6hDE54fY3DppNy28DTSjdMjbw2b2V9H886IwxJOztr11Sthben+aJ+rXn53WMwgFjqnt9Wmc6rcmr/6PFnqqrbPG7l5v8siZZajN7mf0kn1bB21yuiGTPBGDtsLgwJ1+Echm1X8za6VBeotslcfF6MDtM3QTLqf+edlz36IePGHgGsUsymv75dIt6sEcYRcOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C9rUKeAgX5/dzVSx74xWDp5SsjAZFgVqvG4PwBHSlY=;
 b=oq9kgGrsXVb0+7APDmK+1QxzSSAExwRvXWJgcKxizET7tosVj+nxOgBOcn5Nfzy6YpyDPtmne5dpiaOdDIvVU78x5TQtlxdaNV7Z1NeH5A1UVrNg2Hb94TOoWaAJyxhzK0u2N1LnXJ6/8Dh4vGsf73VIboLNETwKMayDg/BVS+o=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 10:01:21 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b0) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Thu, 30 Dec 2021 10:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Thu, 30 Dec 2021 10:01:21 +0000
Received: from [10.65.96.204] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 30 Dec
 2021 04:01:19 -0600
Subject: Re: [PATCH] drm/amdgpu: add dummy event6 for vega10
To: James Yao <yiqing.yao@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20211229103804.2159014-1-yiqing.yao@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <850ea4a6-f1cc-2543-7039-0d3f765b7273@amd.com>
Date: Thu, 30 Dec 2021 18:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211229103804.2159014-1-yiqing.yao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecfc6a23-f164-488e-6173-08d9cb7b54c7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2704:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27048D34A6211D15835EB096B7459@SN6PR12MB2704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7LEzmOOtJaeA3xLpGfz6vTf9su3bvsJDIBiBZK+gT4Y2wE4enDZNAVSSE+vzhzyPWFN4aADp382XI70ZwvxBemNXoQXNh0HI6dD/TCNZxf5rEJYskqp/Xn2tdVI2ymJcE1IhcxD+x7VBZA8um4sOnCCORJJkWIFAQviZJy8pvnGX0vTMCi77l3hipDVpj+zagWkJrOok4cBo7dstyzoRrIhhCBC7I/CCTqSgP+POQ2Zh3LLx8L/1AbwnKsZSmoJ6eNx/gwn6PpcVDQ3zjIFn4tWP6/0MMP/3YJprnRNt3faN9BXY4j5n2CWtrpE1ZxE0jEy61Mj0eHLkjxlhWgHTt/bebod7dOeK3LEnozy5Xxzqg9PKhynnRj9W0/0ZwHvTreb5coS/mXsr65J4863pgwx8Ts8jsTDCOxcoRVXEYmIRrYHKCc/f35leHkEnv5CqsL2b0EGV9LhIrwWnIgER2YT+JBgxsJtCMi0wCmPN5Iwu2dUQX+Tkr3+rKwszpN0nJ9t3E0mJOMsrO52Nfe9++cpX2Tdn1ztFCLgbwi/6VapjupVDT1G9Jhhfkm60NxguvxyZuVGCL50BwNXiCFg7YBm7TT3CcxKNroAuwDnWn1cOL8b4tdUUokJoKYE640IYotx4xJ0wOK+ZDBGQvzb0bBKK/VlIoBBj2ciFDtc6WYe8uedUNKvzCNrLUcvp4WJSAlHdjey4N6iGFG/dXmLcZBfOmkIXqH88debVQIwXVW4ecgpH1JNcf61KKPHOh7kHEq2Ix1uiHgKHI9+DE6teDWGmazakKGFzAMEi9xacjLZDP+9gNna1qXHAiG6pk1wxz33FVGrX63lvYczGuaWkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(83380400001)(47076005)(31696002)(316002)(81166007)(2616005)(2906002)(36756003)(70206006)(82310400004)(508600001)(40460700001)(426003)(70586007)(36860700001)(356005)(186003)(16526019)(8676002)(26005)(8936002)(336012)(31686004)(110136005)(5660300002)(16576012)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 10:01:21.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfc6a23-f164-488e-6173-08d9cb7b54c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
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

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>

On 2021/12/29 下午6:38, James Yao wrote:
> [why]
> Malicious mailbox event1 fails driver loading on vega10.
> An dummy event6 prevent driver from taking response from malicious event1 as its own.
>
> [how]
> On vega10, send a mailbox event6 before sending event1.
>
> Signed-off-by: James Yao <yiqing.yao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  2 ++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index f8e574cc0e22..d9509c3482e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -727,6 +727,10 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>  			vi_set_virt_ops(adev);
>  			break;
>  		case CHIP_VEGA10:
> +			soc15_set_virt_ops(adev);
> +			/* send a dummy GPU_INIT_DATA request to host on vega10 */
> +			amdgpu_virt_request_init_data(adev);
> +			break;
>  		case CHIP_VEGA20:
>  		case CHIP_ARCTURUS:
>  		case CHIP_ALDEBARAN:
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 0077e738db31..56da5ab82987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -180,6 +180,11 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>  				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
>  					mmBIF_BX_PF0_MAILBOX_MSGBUF_RCV_DW2));
>  		}
> +	} else if (req == IDH_REQ_GPU_INIT_DATA){
> +		/* Dummy REQ_GPU_INIT_DATA handling */
> +		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
> +		/* version set to 0 since dummy */
> +		adev->virt.req_init_data_ver = 0;	
>  	}
>  
>  	return 0;
> @@ -381,10 +386,16 @@ void xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev)
>  	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>  }
>  
> +static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
> +{
> +	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
>  	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
>  	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
>  	.reset_gpu = xgpu_ai_request_reset,
>  	.wait_reset = NULL,
>  	.trans_msg = xgpu_ai_mailbox_trans_msg,
> +	.req_init_data  = xgpu_ai_request_init_data,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index f9aa4d0bb638..fa7e13e0459e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -35,6 +35,7 @@ enum idh_request {
>  	IDH_REQ_GPU_FINI_ACCESS,
>  	IDH_REL_GPU_FINI_ACCESS,
>  	IDH_REQ_GPU_RESET_ACCESS,
> +	IDH_REQ_GPU_INIT_DATA,
>  
>  	IDH_LOG_VF_ERROR       = 200,
>  	IDH_READY_TO_RESET 	= 201,
> @@ -48,6 +49,7 @@ enum idh_event {
>  	IDH_SUCCESS,
>  	IDH_FAIL,
>  	IDH_QUERY_ALIVE,
> +	IDH_REQ_GPU_INIT_DATA_READY,
>  
>  	IDH_TEXT_MESSAGE = 255,
>  };
