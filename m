Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15563C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19A5208C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W+u9Asyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19A5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C346E02A;
	Mon,  2 Mar 2020 21:30:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE126E02A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdXBh8Fbj1rxuWRGfBOHA8x+HMLoyVVa8xyd1Ay42lQ+dvMXLWENH+A0BVDwZdRFMtd4H6wH/nBxrWqt0UHjwSgPC9/qutXOnIt9CXgGkA0Ea3U7XPIDlFSwTmg6YLSKkjLpaL1HcQbD5b4+ZlrkhQ6SYMWk7kWq6TqLBYFeq14Zvake3wVxt9kU+Drzy/PhbwsDIuDA9l1c7vMDaf46XM35jxM35fwHZv0AHX/KHeEJGsihr8Yy2ZjhNpsWpVvhJ8pwAw1JHchPZD2KgFZT0W/DXGZuYZvFr9JB/Xb+iwM923kBOQ1hB0uNQMLtAEsIRumKRBvsjuDA8e3kZiOvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymwPnXaq5zfaQ758HcBR39cSvoPFey1Pkn8C4ralvOc=;
 b=jzCqJBL2ko67WAGIig6MDe1foax4Aw/v81QqUHjS/KDuKlhlAAv0yGJtJFtCY5GOvapeaNUV3sR3aorbERlb297PGvxGnZzOeswWEOWXG1GhFdOE+qLigQMal66obxXdfL1C8AR9Hf9OK/kIpdQGnsTZZiFc2fB330z81xnmGTzSXVYaRgRf/hjf8ZMVAz5bH3RaqbwvZuJNUYJEOt2W9HnnzjEt9LC5t3XT0vqnT21iHExsuNMRhuVwiD21t1gKGH0PnvFerqt6rtgYlcTzOflNgreDfthssbFNevSNH//C/0yuuxkqghvGqdsved1ppJ5SmfxhoclAcX7uSgf93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymwPnXaq5zfaQ758HcBR39cSvoPFey1Pkn8C4ralvOc=;
 b=W+u9AsyzJQvbWe92JjBV2Kdq0UCKmrea2oD7QoEJ0108pNBUHlpZzWsR2Q4ODJ/3jrPOQ/ec1aBx21CZlJ642k9j0+vVdsFgu66EWdlOP/wtwTIzjt2gfKLTzx/W3fdfAunkHyQB+Vrjt2QhH7ph5FVLXHmB0RHhN59rV9ySqqQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 21:30:02 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:30:02 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <d75a6b44-3f42-9537-9860-225ea41c34d5@amd.com>
Date: Mon, 2 Mar 2020 16:30:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 21:30:02 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 311486fd-490f-4892-f2a5-08d7bef0de4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:|DM6PR12MB3770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37704CF9DD85F9A5498C48D099E70@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(66946007)(66476007)(4326008)(66556008)(36756003)(2906002)(86362001)(478600001)(6512007)(8676002)(6506007)(53546011)(44832011)(6486002)(8936002)(81166006)(5660300002)(52116002)(81156014)(316002)(956004)(31696002)(2616005)(16526019)(186003)(31686004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3770;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLXV4qOHWD/4kBSi5u8sonCz1dr+ycmk5tMUAjMJQ+rx2tTTUmmDV21XudzCHRf78Tr8ooRe7ducgQiGDJeldlV39LBIoTb6TMib1oGE6Y1mrx4l/VoiegNEPOdXQKIBsgcXsxNNi3fu7c6p0Id78VB4wHWCis13NsmSxv0jsFO0KXXL1MtGe0BRAO6O2xdJDN0+JBHmbE1CgF6CK+jcgF1qiXPo6jlzTKoh6llx+HxtD7deGhdvZhT+Tj0oXJRdpYy1TvxPIXNiyA6r7bVYdZBONN5RloE+VpH/XYTBFDKrMymCbYq42PI7ytK327kxVJw1YWJ9p5tK2vGr7jUL+xDP8jf9TkSVLZ+JvPB9foowhogkVuR95mfykEyvkKyPKOhhKjxJLZTY3/L/qFCE/x+TAW+1O7ycyv2YmDiexdPwl6Sbe5og8YIF4ce45+S3
X-MS-Exchange-AntiSpam-MessageData: +lJyqW5HcJLkP1FeRn7e4n1xeqvUs0zN0BBOETmLdoH97m0X/XKZVdFQCLcvYgZ2CNJ5h6X5wAsTAbN9iC1htf1jOL4cjDCf27h44TegkfJUAf7mvClZ62UMgPVrGvifmKb+nfKFoZeUqhENz2HsZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311486fd-490f-4892-f2a5-08d7bef0de4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:30:02.8458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKy4+3cwWrfXRV8nUbPyFlUywsGzTvXQrCnwcXXqAqICqVx12sQPWDFSTaWu4hIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

On 2020-03-02 2:24 p.m., Andrey Grodzovsky wrote:
> Add the programming sequence.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 8ab3bf3..621b99c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>  
> +/* USBC PD FW version retrieval command */
> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
> +
>  static int psp_v11_0_init_microcode(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
> @@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>  		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>  }
>  
> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	uint32_t reg_status;
> +	int ret;
> +
> +	/* Write lower 32-bit address of the PD Controller FW */
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +			     0x80000000, 0x80000000, false);
> +	if (ret)
> +		return ret;
> +
> +	 // Fireup interrupt so PSP can pick up the lower address

C++ comment?

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
> +
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +			     0x80000000, 0x80000000, false);
> +	if (ret)
> +		return ret;
> +
> +	 // Fireup interrupt so PSP can pick up the upper address

C++ comment?

> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> +
> +	/* FW load takes long time */
> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +					     0x80000000, 0x80000000, false))
> +		msleep(1000);
> +
> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +	if ((reg_status & 0xFFFF) != 0) {
> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
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
> +
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
> +
> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +				     0x80000000, 0x80000000, false))
> +		msleep(1);
> +
> +	*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
> +
> +	return 0;
> +}
> +
>  static const struct psp_funcs psp_v11_0_funcs = {
>  	.init_microcode = psp_v11_0_init_microcode,
>  	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
> @@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
