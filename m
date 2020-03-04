Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34346C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022E52166E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PxpDPnIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022E52166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5743B89AEE;
	Wed,  4 Mar 2020 16:05:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD7189AEE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRCgWzBh5g8SA9wXMbZX3V/NrHJgpGpMO0rieLA/ojpELRgdfIVTrNSQdz2rxB4Y7IJyTxHEIvBhjmSQWm6UhJdMZ+c6mQ0OVoHB+nHCHB51tbcK+HLfr/EhJBKKPYirysnHmUFUvBarPpKccYHoCOO+ZDyhrCqwZSn2Nmi2ag+gyC51rEoQRfW9NjeqTqnH1m31rY9gxRW09jinMwhdywAkfTGHY98GCPTK//VQn+DSYY8FB1TkA+qLmX9ftKQ36aYdXigk01xcUx90p5dMdVtU6iBVIpk+zkd2E+bLpRBjO/zaopZ+5uJVLlCUSyZfEMxw2rjVFaCJIAT9sxVVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onNwMeKdXH0QoIyJC4VORPH/1oVn0+yViN0byn3uex0=;
 b=WBdXUAJz4AZdeypI4W3znPR2vXnGmxXdVtYYssEiyRsgZnIeeF2uOvS/e9LF9VTl9jTyw/0sfl1lFQ4ojEtxk4/kTEbNzc7jJqna88X/HeGMyB9ZKtsdIbQdNRFdk8jNnzpv1HRu1V69NDmmQiMywDP807TYHBedpa/JhkkF5Z31/F2H6MygxcB9TMbLIoNwA5iHayOBmgWLltOXdHDGE1vjUlGNABMUfn/2GcpP+PbvZtBiUc7/rwbbO6ALGabdXD+Y93TTK+vAolsorbhTLqlNw0b8uW/kdYtdLD2SEAxxxGM7hbqCaeu74XsPJ2vJ4mp/yRBYNeVKXMYJHqP5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onNwMeKdXH0QoIyJC4VORPH/1oVn0+yViN0byn3uex0=;
 b=PxpDPnImOXInffNgxtGUWPDW8zPmM5kDciQZMPJ2X0IciVnCBJE5demysSJporjtZvfIrk4wMW7zuid44se4/bTES03CQ7NG9agzo7NSThdfUjr232Pn5jBg4ZXIozMt4iHNLk/wLXzimYERsaszkyTbn7w2bwd/JEq2okLJmzY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:05:17 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:05:17 +0000
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583272929-1038-3-git-send-email-andrey.grodzovsky@amd.com>
 <10df5e71-716d-eb03-e6d5-1cfdee770286@amd.com>
 <5eb70380-b84e-6e1b-9bac-5af216adcf28@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <0133bde0-37ec-d7af-a4c9-9df91b1d465f@amd.com>
Date: Wed, 4 Mar 2020 11:05:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <5eb70380-b84e-6e1b-9bac-5af216adcf28@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:05:16 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0e3517a-d46c-404f-e6b7-08d7c055d4b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:|DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37407065D66DEFC8D200A47399E50@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(2906002)(86362001)(52116002)(8676002)(2616005)(81156014)(26005)(81166006)(31696002)(16526019)(956004)(8936002)(53546011)(44832011)(186003)(66946007)(4326008)(66476007)(16576012)(66556008)(36756003)(478600001)(6486002)(5660300002)(31686004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3740;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wha3wic1IeeQIcVWlp2/5PiTSG4uEHZ57F8OGjbZ0DXyyPfIb/uR+nufNIG8JkoJunU8A6zgmSpUWYaEbXTPjAPg3/+k/V7kV6P86pd3mgq/ISpTYT540WL7Xm3jo45Gbn6EF/4c0guJR8svKdWQzMgQcK4QSEvs25QITjyVGgKrMH7zPIU2JIC3mkOAZTv/oZ3ZDmGFZQMbvxH8qNl5LdE/GFklQopLrlGccWoQdO3AVIF7Mvu4mlYCIM/GdYuzNdbVCG8//2/k/i+SU5fOOhjBfQ2jAnO3+pzgQ2qDvhmmAdvtMOWNUgf9Ko562kFZbWXF/mBvnCLCvbvBNlQfJd0joBNxVZzq0SWNNefxmueQYkI+Ul8ue5C6UZ2xrDdMp3JIsRywPr8zWG8Z1XPGajrgtCkQ9vHxU9S5dt/Yw82f3McBQBOWtRFuW8iJ97j5
X-MS-Exchange-AntiSpam-MessageData: wgGzr8E4A5mDJo4dEk8xRwY4n7jTbUc3woPoPPWEu7w/MONMNTG2PMqdAR9KI3riZpeH1pPL685ZgF9e24i9dIhI52/i3viI74DJ8+T4LJUs1LF95SxLwG6Foev3Ov6JnPOwheOclu4JLOmxhZrzSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e3517a-d46c-404f-e6b7-08d7c055d4b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:05:17.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbsWdZGmQVuJktF5yMGcSyGSvUPSMjHKDFbiUlA897NbzxjdwI+HQoOB4CS6q07A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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

On 2020-03-04 10:56, Andrey Grodzovsky wrote:
> 
> On 3/3/20 6:14 PM, Luben Tuikov wrote:
>> On 2020-03-03 17:02, Andrey Grodzovsky wrote:
>>> Add the programming sequence.
>>>
>>> v2:
>>> Change donwload wait loop to more efficient.
>>> Move C2PMSG_CMD_GFX_USB_PD_FW_VER defintion
>>>
>>> v3: Fix lack of loop counter increment typo
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 82 +++++++++++++++++++++++++++++++++
>>>   2 files changed, 85 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>> index 36b6579..a44fd60 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>> @@ -31,6 +31,9 @@
>>>   #define GFX_CMD_RESERVED_MASK       0x7FF00000
>>>   #define GFX_CMD_RESPONSE_MASK       0x80000000
>>>   
>>> +/* USBC PD FW version retrieval command */
>>> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>>> +
>>>   /* TEE Gfx Command IDs for the register interface.
>>>   *  Command ID must be between 0x00010000 and 0x000F0000.
>>>   */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> index 8ab3bf3..3db1c0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>>>   /* memory training timeout define */
>>>   #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>>   
>>> +/* For large FW files the time to complete can be very long */
>>> +#define USBC_PD_POLLING_LIMIT_S 240
>>> +
>>>   static int psp_v11_0_init_microcode(struct psp_context *psp)
>>>   {
>>>   	struct amdgpu_device *adev = psp->adev;
>>> @@ -1109,6 +1112,83 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>>>   		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>>>   }
>>>   
>>> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
>>> +{
>>> +	struct amdgpu_device *adev = psp->adev;
>>> +	uint32_t reg_status;
>>> +	int ret, i = 0;
>>> +
>>> +	/* Write lower 32-bit address of the PD Controller FW */
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +			     0x80000000, 0x80000000, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Fireup interrupt so PSP can pick up the lower address */
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +			     0x80000000, 0x80000000, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>>> +
>>> +	if ((reg_status & 0xFFFF) != 0) {
>>> +		DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>>> +				reg_status & 0xFFFF);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	/* Write upper 32-bit address of the PD Controller FW */
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
>>> +
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +			     0x80000000, 0x80000000, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Fireup interrupt so PSP can pick up the upper address */
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>>> +
>>> +	/* FW load takes very long time */
>>> +	do {
>>> +		msleep(1000);
>>> +		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>>> +
>>> +		if (reg_status & 0x80000000)
>>> +			goto done;
>>> +
>>> +	} while(i++ < USBC_PD_POLLING_LIMIT_S);
>> 1. The LKCS wants a space after a keyword ("while") and before parenthesis "(".
>>
>> 2. In do-while loops, you want to pre-increment, in order to account for the
>>     already executed iteration of the loop, since the check is done _after_
>>     the loop executes, in contrast to "for" and "while" loops. So you'll need
>>     to do this:
>>
>>     } while (++i < USBC_PD_POLLING_LIMIT_S);
>>
>>> +
>>> +	return -ETIME;
>>> +done:
>>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> 3. You had _just_ read the register, right before the goto jump.
>>     You do not need to read it again. (Else a race would exist,
>>     and you'd need to poll, _again_.) You shouldn't have to
>>     read it again.
> 
> 
> Just went with AlexJ over the relevant PSP code - seems you are right, 
> both the completion bit (31) and result status bits (bits 0-15) are set 
> within a single statement and hence the last read inside the loop should 
> be enough. Will fix,
> 
> Still, I don't see a race in the original code - just a superfluous 
> register read.

There is no race in the original code. I said "would exist",
as I knew it doesn't. I knew bit 31 and the address are updated
in one go, else there would've been a race and you'd have to poll
again. But since you don't, they are updated in one go and no polling
needs to be and no race exist: therefore you don't need to read
the register again.

Thanks in advance for fixing those three issues. Let's see the fixed
version of the patch.

Regards,
Luben

> 
> Andrey
> 
> 
>>
>>> +
>>> +	if ((reg_status & 0xFFFF) != 0) {
>>> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
>>> +				reg_status & 0xFFFF);
>>> +		return -EIO;
>>> +	}
>> With those fixed, this patch is,
>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>>
>> Regards,
>> Luben
>>
>>
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
>>> +{
>>> +	struct amdgpu_device *adev = psp->adev;
>>> +	int ret;
>>> +
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
>>> +
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +				     0x80000000, 0x80000000, false);
>>> +	if (!ret)
>>> +		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>   static const struct psp_funcs psp_v11_0_funcs = {
>>>   	.init_microcode = psp_v11_0_init_microcode,
>>>   	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
>>> @@ -1133,6 +1213,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
>>>   	.mem_training = psp_v11_0_memory_training,
>>>   	.ring_get_wptr = psp_v11_0_ring_get_wptr,
>>>   	.ring_set_wptr = psp_v11_0_ring_set_wptr,
>>> +	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
>>> +	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
>>>   };
>>>   
>>>   void psp_v11_0_set_psp_funcs(struct psp_context *psp)
>>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
