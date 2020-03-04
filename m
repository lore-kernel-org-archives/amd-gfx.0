Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4264C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849BB2166E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P+HqfZxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849BB2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5F66E02C;
	Wed,  4 Mar 2020 15:56:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4228898FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbsG0eYBFS1hnNE9Xy4wwPWOUtCEDG1tc6kWCoJom8d+7SquXyTE7kKYzaVtEDgkhzH8PA4/F9/4i5f41Q312LhMhaLAtwg0Q18yhQ/CVavNngrGS7up/hnVlgA/aBbkoyGaQTT4O0Em6hniWxRUzn3PaRuKDqbXzGGNhpHCcNoDVz6QKqia9we+QtxHJHJqjNQ8tsGtNFevwTPXUyY1t9g+IEBCjxUk9oAimhUyobZTo9l0N0uKJHzjQjTcn85dTUjLo6OqAVCeg8Cn5SbIcooGXCB4MFYTeHmSKpxtmqn0UQaEPgORhcv4bvXr2NXVSERDlIMqeEikfOqyfe+K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94fids7aUtOr9HRZgPc+M3c3xIVeQOEK0BSqeLeI+X8=;
 b=HE7cnoc2nDH23qluV78LroklSgWaiVOIyTwumfFP9N91GYZT0vg234eKaafINlg6gUVD3a+EAOJkeBJwLpr9aMjn5rZ4FpyC4R5l7lD9icy01xRysYn+MNBwyZ9SMHczL3TBqlyQ+hzfbgQo3MH/Xi8v6yWwTKFQovwbn3bUpByWMdWWs9z5fuBfp3xZGbV0ZgqDyFWxWZU9TfP/XO0SHy4GWVfGbu9N3fAkm9ElMCyoZnSTEk9DYwTTgXV8uPw2y2e+uMWHU3OElzyXpS4QkCUyzAlvHfXpqsQI5HBhFfun/PRkZ1+yl6JMRB/5YxOn2cq8P2BQyOxZwZRrLl44VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94fids7aUtOr9HRZgPc+M3c3xIVeQOEK0BSqeLeI+X8=;
 b=P+HqfZxUApJYqfrndwtkgWMSCxvNgYCtbODb8oG6vJwRd01lk1UiJ76CVBXjJNpTqT+iUsCtfh7TJXYODfpN0sXsirh2OHC4kUHcLzV2Jl0x6C2IsFFPkIR7xUM5dZURH2axvr5/Bwt/6qeToD1BjWH3UKDRLpB6By2DsiEFkQA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 15:56:23 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 15:56:23 +0000
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583272929-1038-3-git-send-email-andrey.grodzovsky@amd.com>
 <10df5e71-716d-eb03-e6d5-1cfdee770286@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <5eb70380-b84e-6e1b-9bac-5af216adcf28@amd.com>
Date: Wed, 4 Mar 2020 10:56:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <10df5e71-716d-eb03-e6d5-1cfdee770286@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Wed, 4 Mar 2020 15:56:22 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d2f5452-40b6-4ee0-e372-08d7c05496ac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:|MWHPR12MB1214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12143665A70AA0514998D84EEAE50@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(956004)(478600001)(52116002)(2616005)(86362001)(316002)(16576012)(53546011)(4326008)(66476007)(66946007)(8676002)(5660300002)(16526019)(81166006)(186003)(66556008)(8936002)(26005)(31686004)(31696002)(81156014)(36756003)(6486002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1214;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgSlzA9zdpDhVh9A5CYw7cLZI6caKCqDe4nuitaa6xYYHCYRo2O0qeJyVcQzhKjzPiJANvr0aBnrmyExP7KeRH+8/Y3koF7+Zoe+rDAO/Bhs0qFycdkid2NGxks6BUmlBP+5poCueQr6wMxuWGD/cfY+8OLcjuGtZbJ6Bl9+6SZKudU4AOriI8mr0Y+hW9FT9I6uyhe6YoWouvTQuOWVQz2Mpy2U9rNLt1ikpIiTtZVqk517fRy50SysH+JNojAgn0oIQfsauJEXn31NwBPuzAz6MY8q1hjFnBtIfCS3ZPotzL7W5hA2c5fXvTUOM6/wGTBy4nSeTEcsEufdSO8pvCSnyqv4w+0zU6O8JKaMzLgXvxKPH3zuKrubiIbusW9RpgoaI0ADiUngXrJIxJISxn6UCuDUX8yI2mCR17oYuxd5+Vw1tbInkcXAh6idYMdc
X-MS-Exchange-AntiSpam-MessageData: n/vyhp9RUaFDlP1gOCRzENGRAn8WuKi4WMkgBLkQuUbKYWOKK13Lob9s2/cBiNiBH9ezIjIFyXhaitvmGVT2rm3lDORx+vRFVNEXMaqRK+K2jQeUks0BpHLAvZ5O0oNxmsPwXw0JEJrFABPQJtfHMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2f5452-40b6-4ee0-e372-08d7c05496ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 15:56:23.6302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnKOEmmkI0om1hzY1JWwp4JiJfDi2c3DFoxyKyZQ0yd/XMvkWe5uiWTxl+fy8xJa6cxnbtjwVOUA5Mnjy/OcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/3/20 6:14 PM, Luben Tuikov wrote:
> On 2020-03-03 17:02, Andrey Grodzovsky wrote:
>> Add the programming sequence.
>>
>> v2:
>> Change donwload wait loop to more efficient.
>> Move C2PMSG_CMD_GFX_USB_PD_FW_VER defintion
>>
>> v3: Fix lack of loop counter increment typo
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 82 +++++++++++++++++++++++++++++++++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>> index 36b6579..a44fd60 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>> @@ -31,6 +31,9 @@
>>   #define GFX_CMD_RESERVED_MASK       0x7FF00000
>>   #define GFX_CMD_RESPONSE_MASK       0x80000000
>>   
>> +/* USBC PD FW version retrieval command */
>> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>> +
>>   /* TEE Gfx Command IDs for the register interface.
>>   *  Command ID must be between 0x00010000 and 0x000F0000.
>>   */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> index 8ab3bf3..3db1c0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>>   /* memory training timeout define */
>>   #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>   
>> +/* For large FW files the time to complete can be very long */
>> +#define USBC_PD_POLLING_LIMIT_S 240
>> +
>>   static int psp_v11_0_init_microcode(struct psp_context *psp)
>>   {
>>   	struct amdgpu_device *adev = psp->adev;
>> @@ -1109,6 +1112,83 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>>   		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>>   }
>>   
>> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +	uint32_t reg_status;
>> +	int ret, i = 0;
>> +
>> +	/* Write lower 32-bit address of the PD Controller FW */
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +			     0x80000000, 0x80000000, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Fireup interrupt so PSP can pick up the lower address */
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +			     0x80000000, 0x80000000, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> +
>> +	if ((reg_status & 0xFFFF) != 0) {
>> +		DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>> +				reg_status & 0xFFFF);
>> +		return -EIO;
>> +	}
>> +
>> +	/* Write upper 32-bit address of the PD Controller FW */
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
>> +
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +			     0x80000000, 0x80000000, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Fireup interrupt so PSP can pick up the upper address */
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>> +
>> +	/* FW load takes very long time */
>> +	do {
>> +		msleep(1000);
>> +		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> +
>> +		if (reg_status & 0x80000000)
>> +			goto done;
>> +
>> +	} while(i++ < USBC_PD_POLLING_LIMIT_S);
> 1. The LKCS wants a space after a keyword ("while") and before parenthesis "(".
>
> 2. In do-while loops, you want to pre-increment, in order to account for the
>     already executed iteration of the loop, since the check is done _after_
>     the loop executes, in contrast to "for" and "while" loops. So you'll need
>     to do this:
>
>     } while (++i < USBC_PD_POLLING_LIMIT_S);
>
>> +
>> +	return -ETIME;
>> +done:
>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> 3. You had _just_ read the register, right before the goto jump.
>     You do not need to read it again. (Else a race would exist,
>     and you'd need to poll, _again_.) You shouldn't have to
>     read it again.


Just went with AlexJ over the relevant PSP code - seems you are right, 
both the completion bit (31) and result status bits (bits 0-15) are set 
within a single statement and hence the last read inside the loop should 
be enough. Will fix,

Still, I don't see a race in the original code - just a superfluous 
register read.

Andrey


>
>> +
>> +	if ((reg_status & 0xFFFF) != 0) {
>> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
>> +				reg_status & 0xFFFF);
>> +		return -EIO;
>> +	}
> With those fixed, this patch is,
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
>
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +	int ret;
>> +
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
>> +
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +				     0x80000000, 0x80000000, false);
>> +	if (!ret)
>> +		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
>> +
>> +	return ret;
>> +}
>> +
>>   static const struct psp_funcs psp_v11_0_funcs = {
>>   	.init_microcode = psp_v11_0_init_microcode,
>>   	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
>> @@ -1133,6 +1213,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
>>   	.mem_training = psp_v11_0_memory_training,
>>   	.ring_get_wptr = psp_v11_0_ring_get_wptr,
>>   	.ring_set_wptr = psp_v11_0_ring_set_wptr,
>> +	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
>> +	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
>>   };
>>   
>>   void psp_v11_0_set_psp_funcs(struct psp_context *psp)
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
