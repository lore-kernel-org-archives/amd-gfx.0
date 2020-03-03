Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF82C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AA520870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="edV6vwXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AA520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A546E97A;
	Tue,  3 Mar 2020 23:14:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7586E97A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqkM1fGY2AD1zr+8rgt5c2FjqkfVjomLUdA3+7+aLD57o6dnye0Nm1htmZPyhh+ecvEUoW3usueH476eU2HCDY3nlxJnNQptw8kko4IWiTHmz4H6UfbBtMa2kqRZUQIbOCCZkOAFJILaHb55SmoTNlwVKzhUi4qNYVDP+nFSCiLw5hmlthyqw+flKQZuaQJO8YqZsVXcF6tIA/PaDgGuLK533IWI8PcLck3DtmfxSYJTFwCIGAuOGI/7fFy2X7GphYz8JFPhjO+JArWeyF5vPvvj1r6AwQs2Bl0yW1N9ddyHPC5z5YI1x29jmcWH/m4hJAk7qCanNVzZs/Z1ktpbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgvWj24nLj9+knyEuuVbEMfwqIjgNwpbxGm9oVnqZrE=;
 b=MOhUoDDiGTnUMZkt2Y+RJXSugJ06ST/t8odYil3WB85HEwwRHFDr4l9oV6FMIG02kDuluwgQ78Z9ei2rYHQrvs2r8dHL2yqVcg8+4C5Rr2SmcFduOFf4OiwDGVaePFFSWWKiw+h/DLMs+gcbFwHEWKmemSkLYq0Zs0M/iTlGOPVk9cHNnC0OF+kzJJ3tZa3GT8CRfgfUPXztN4czt1ueO8Tc2ldw626TLT5/elHdua53QgGvkKkRXrvREeEbQ8bBRD9TOfDLou115rYwKothUVzaXpG6U341zE37fO3zCMTgXlJ/wJDo1/DkgcJFet0dlipMjgTVBqbF73VEQuHkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgvWj24nLj9+knyEuuVbEMfwqIjgNwpbxGm9oVnqZrE=;
 b=edV6vwXEGrntf16b3R/0TwfhY6ZqMzJEKVu5NiPpEVzXjni0BeBzgq2ePraSrLN+8DYKv9F/g6NilHiRS3ubDVSiT8Yk8BqQiaoVXJxhhyPvjz+xJ/u8IoLdEjUljUGVAgi6OxxYtJh9ON+kkgwFL7b0OYbtTvaChprwCWASakE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6SPR01MB0031.namprd12.prod.outlook.com (2603:10b6:5:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 23:14:20 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:14:20 +0000
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583272929-1038-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <10df5e71-716d-eb03-e6d5-1cfdee770286@amd.com>
Date: Tue, 3 Mar 2020 18:14:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583272929-1038-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Tue, 3 Mar 2020 23:14:20 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2001a84c-cfd2-45e0-5504-08d7bfc89ab6
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0031:|DM6SPR01MB0031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6SPR01MB0031BAB6F37BEF26BE06C30399E40@DM6SPR01MB0031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(26005)(16526019)(186003)(2906002)(2616005)(8936002)(956004)(44832011)(316002)(478600001)(16576012)(52116002)(36756003)(81166006)(8676002)(81156014)(6486002)(31696002)(66556008)(66946007)(66476007)(5660300002)(53546011)(86362001)(4326008)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6SPR01MB0031;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzpatCg3yOgQQSOxS+beCHKUhRdPrSVeRAf6mC9pCnPCUAKP0+D53ufQEci1Wf4fl1czapXCFOZv9BFrKbBoeF0LPZfMUfhzdARxE+wxLFugvXKAY4dD2e0Ojh/Yc6a1tO9QcFwK6lLFPp90cHWIepf2Mt7iWaEV4g6eE0Ilrzh605CWa6K2GMnq0AXx9wxdB/r5EnbOygnSZgyZ6QWb/fa9Ax7xI43pmADCVNUrXntuFGqpN6lyXyJCW8GNF1VoAYonA/2RIlsou0FaBg0GjBeCiehKC1oHRalgF/Wm+yDAKy7qwcF0nAAuYun8F163qa0R2CZfzdyM7VHepIqBinJnIq7KUtC9D+VZVFG5s4XfY3BUkDF9W+VOXDPSrYXAPB+vEfdBCgkEs7CrotYMxEs02b+6XKuOo5L0CSDOVxMsYiJZKj5ImVR3wxjnecUa
X-MS-Exchange-AntiSpam-MessageData: SAP0H8gSEGPZ3IBVqa+ZcJ0A6upGuokJQIlAEan4+hnPTWqy1RttBriGXfk8ekMewJP7U5xHagxdjYXZ7nb9RqybGTTC42lBHvh9JiG1brbhzvdr058iPk0wUcYsrkfKiNTDKTT/8j97i62uQO2mGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2001a84c-cfd2-45e0-5504-08d7bfc89ab6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:14:20.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNRDTWgh+Az77jDnp3ZMT6AEvXbyV7+ZBNRSFZRKTPbiervTE0vcxFND3mLCk280
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0031
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

On 2020-03-03 17:02, Andrey Grodzovsky wrote:
> Add the programming sequence.
> 
> v2:
> Change donwload wait loop to more efficient.
> Move C2PMSG_CMD_GFX_USB_PD_FW_VER defintion
> 
> v3: Fix lack of loop counter increment typo
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 82 +++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
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
> index 8ab3bf3..3db1c0d 100644
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
> @@ -1109,6 +1112,83 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
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
> +	} while(i++ < USBC_PD_POLLING_LIMIT_S);

1. The LKCS wants a space after a keyword ("while") and before parenthesis "(".

2. In do-while loops, you want to pre-increment, in order to account for the
   already executed iteration of the loop, since the check is done _after_
   the loop executes, in contrast to "for" and "while" loops. So you'll need
   to do this:

   } while (++i < USBC_PD_POLLING_LIMIT_S);

> +
> +	return -ETIME;
> +done:
> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);

3. You had _just_ read the register, right before the goto jump.
   You do not need to read it again. (Else a race would exist,
   and you'd need to poll, _again_.) You shouldn't have to
   read it again.

> +
> +	if ((reg_status & 0xFFFF) != 0) {
> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
> +				reg_status & 0xFFFF);
> +		return -EIO;
> +	}

With those fixed, this patch is,
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben



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
> @@ -1133,6 +1213,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
