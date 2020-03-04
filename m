Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED24C3F2D9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638B622522
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PcR26Oup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638B622522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174566E081;
	Wed,  4 Mar 2020 16:26:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AAF6E081
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqnbTuaJkmZKz/7VVCvA6oC9hKSNmTCI6AxSdnIlUqOri5uzqSrdkoYJoCc4dAFTyIXzPDs6CDd4cXxCROz2Zn37LSsO9Cs20eYNRsKLobedp8Xdoz3gvXqoelf0gS0Bx+e2f9+Eic2R5dRIooY4Ztbmkhv79wImzIaCXuQ/kmmAkjsxuamO53KOy7+k153Q9v7oXHJOhs8SHXO8GY4wyU8dPPdrmDnU86uUTeJpN7VjhROd07PuQzXioRvoyTuvlW9L9G1hJAKbWdkrJ2z+yVMiA/y9fo3HkVa0N6BZ6P8C1ZYp/vgamcGTZL+yOxCwWjn+2Ym/nMbhA4JWW6u+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jKm0hy3rSoDQk52ZQ9rdBM8SS/Ztv9UN7h5Gb20MI=;
 b=SiWKdkGpNotkKBAyOif1jpjdKk7W2M+kAcRnRzZ8mNerbDGr5515PLyRQv2aZLAEyAWt6/npG17Ie3iaVmMEk/BrtoeZ8HravP1gSgjjqoJdnSU7BvPQnePei9b1okzqPzH0aR0RvdYXyB/CxLSLuIHfEb+9q8qAzQJnPUGxAxWuXuwNoXt6zXgII+2LYGHrPmfhx+kuJUswkLlpZ0oCL+f4z0+v16S5I63EB4ROZcOnmTbxO3PlSSsormqFiX0Vf6fkERrCKIwIMngkoH4LdhBPi1Iyo7nHcZkj/bfgqELQQWR6K205AxT597erS1pLY+RS1wfxrVTvFNkJl7qx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jKm0hy3rSoDQk52ZQ9rdBM8SS/Ztv9UN7h5Gb20MI=;
 b=PcR26OupjpUbwxR9C+uUOOfeJQwtWCjhgkVwqX4IQXbugcAwyAKzFkgWs13XTmDbO2vU5kkNPcKwTmCmLF5zyfE3WMYNDA4U3O8TqBRJ2u8NXD8aiDuwjK+2oAHiHj9pgd1K8zw665qbWstulQklG0SeZYiHqGKTRMiB50UcccU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:26:49 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:26:49 +0000
Subject: Re: [PATCH v4 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583339021-12298-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <754521bd-d56e-3cc4-fd7f-4ff93e99988a@amd.com>
Date: Wed, 4 Mar 2020 11:26:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583339021-12298-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:26:48 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a466d54a-af27-4fb5-baeb-08d7c058d6d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:|DM6PR12MB3564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3564E1EA02A15102110A106999E50@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2616005)(956004)(66946007)(5660300002)(81156014)(86362001)(8936002)(16576012)(478600001)(52116002)(66556008)(2906002)(81166006)(36756003)(31696002)(66476007)(53546011)(316002)(6486002)(8676002)(4326008)(26005)(16526019)(186003)(31686004)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3564;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+nKiFs5NrIpjfSSh7FRXMmJv1ZLCb2nNfvCL9JcuxNvEl/7g84DSe9aKzrgZ8yfkjmOK3G4IVG6aX0Pt2euj+63TNC/RsXxaosgjcjKRKA4zsxtn9ygdCPep4ZAO9Lqj5/fnRqrUQaqSPVj5a+Ia+Oh0c93n4qzUlTKXK0e1yjymhYm2iSwoSdNKh1Ny/hPeEPn9b+LUj62Sk7djdoAN8yX+e7oELvCs7gIVL4p9iUCJG2HXhBAL9VC59PkPvqW18+iDbcZnx2qdJys6WKs+/0yp7rv9zG26GoMBLPjmCdW0YDR6Z4VsQH2np0n6V58stZda7Cn3LpW8qF2pMTeLdSy4xQ4GMI6VlP7UoirEK502F/kFUl/EsGjVwe24utejTLtp8RYJZ4djKHGMLccfgGhUSQ9LodWFfwXKRChDB4OPTITUQMbYaQz7MoqXIkF
X-MS-Exchange-AntiSpam-MessageData: v1iZubd5KRsA9yj3jMUc0Rw+ggrGiSoRv442Aabo0dQR6mQxMJRucRrJtCD1L4AviGUgVXLF+VwI3Hdqx/RaW1gC7Z3Vf1QzX672bHE7zPBPpsi+xGxJ5A6c/kDnegZCnpz8p/Jjn1JCl1UlzbSbkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a466d54a-af27-4fb5-baeb-08d7c058d6d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:26:49.1624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuvkQtTnDBReKJxBshosfN7Y4dOVnsDGQ2slOJnYFMmcgetK+Xag55p1II4DVA2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-03-04 11:23, Andrey Grodzovsky wrote:
> Add the programming sequence.
> 
> v2:
> Change donwload wait loop to more efficient.
> Move C2PMSG_CMD_GFX_USB_PD_FW_VER defintion
> 
> v3: Fix lack of loop counter increment typo
> 
> v4: Remove superflous status reg read
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 81 +++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> index 36b6579..a44fd60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> @@ -31,6 +31,9 @@
>  #define GFX_CMD_RESERVED_MASK       0x7FF00000
>  #define GFX_CMD_RESPONSE_MASK       0x80000000
>  
> +/* USBC PD FW version retrieval command */
> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
> +
>  /* TEE Gfx Command IDs for the register interface.
>  *  Command ID must be between 0x00010000 and 0x000F0000.
>  */
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 8ab3bf3..67dd9d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>  
> +/* For large FW files the time to complete can be very long */
> +#define USBC_PD_POLLING_LIMIT_S 240
> +
>  static int psp_v11_0_init_microcode(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
> @@ -1109,6 +1112,82 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>  		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>  }
>  
> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	uint32_t reg_status;
> +	int ret, i = 0;
> +
> +	/* Write lower 32-bit address of the PD Controller FW */
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +			     0x80000000, 0x80000000, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Fireup interrupt so PSP can pick up the lower address */
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +			     0x80000000, 0x80000000, false);
> +	if (ret)
> +		return ret;
> +
> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +	if ((reg_status & 0xFFFF) != 0) {
> +		DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
> +				reg_status & 0xFFFF);
> +		return -EIO;
> +	}
> +
> +	/* Write upper 32-bit address of the PD Controller FW */
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
> +
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +			     0x80000000, 0x80000000, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Fireup interrupt so PSP can pick up the upper address */
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> +
> +	/* FW load takes very long time */
> +	do {
> +		msleep(1000);
> +		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +		if (reg_status & 0x80000000)
> +			goto done;
> +
> +	} while (++i < USBC_PD_POLLING_LIMIT_S);
> +
> +	return -ETIME;
> +done:
> +
> +	if ((reg_status & 0xFFFF) != 0) {
> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
> +				reg_status & 0xFFFF);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	int ret;
> +
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
> +
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +				     0x80000000, 0x80000000, false);
> +	if (!ret)
> +		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
> +
> +	return ret;
> +}
> +
>  static const struct psp_funcs psp_v11_0_funcs = {
>  	.init_microcode = psp_v11_0_init_microcode,
>  	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
> @@ -1133,6 +1212,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
>  	.mem_training = psp_v11_0_memory_training,
>  	.ring_get_wptr = psp_v11_0_ring_get_wptr,
>  	.ring_set_wptr = psp_v11_0_ring_set_wptr,
> +	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
> +	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
>  };
>  
>  void psp_v11_0_set_psp_funcs(struct psp_context *psp)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
