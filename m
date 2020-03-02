Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC33C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA5A22B48
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="znc/9ipA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA5A22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E132D6E869;
	Mon,  2 Mar 2020 21:51:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840FF6E869
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwXId1M4gAwfj2cvTfUN3w9LxAQqMheH7SaattwslkGraJVb9WY9dMhPjeYRI1c2ZfobJAaa5DFyooU847i5AWTJynUiXIkrFiyUVisX5q0pmLQvMD0pFn1dalLoXWG6i+2ovZMer+HFJeQj7YzD3CK8ymC1e8FSodwhNiq/e2WQKH0+gR22nGtzbbjsuzD7bGfZWZq+zxnKyVZhtKSdWuD4Fn0bY4q1RkSah9LHEnAioKXpkfw9teUfuaTnCqwIJRLvXDgG/MI0x2RLKEytG1jkbxOTAHrcuV8IzmUZxRtyTsUuvFJ9swmMh65E7n/mUUA/CEzNlQbP363bLaF/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx17KAd7b3q48zPE+enmVNJTY3nxapPAg2oNt3m6gZw=;
 b=YUpefg9gM/Kfuhhk1fCLIJZU4pECEuSnj+nmNwtHR4WooS+0y8rgENMemozlbmNy87ATUt5TKiyh0XHAEDQdSubHlJLHKBWlvsy3B2GPb94sOrkiFFb7w5KFLJRVlZIy+28WHojuEk9cZSDz64yShJVDVGeJSfCj438qQI5ITQZcNIG2cupTd/UYyB9xT4W9Hhbig/2oMNrqsXIU9IgPXy/BDnEwcU9iaBGL6s52snWydBn/anqTl2oSz92ZjH6nWmm5Zg598KcqoI4rwKVFZgfIPe6dJcemXz8oAMhkTxL1z35g9hfqIZQPdqRlAsRjllqx14Aspq9TA1DSoNnkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx17KAd7b3q48zPE+enmVNJTY3nxapPAg2oNt3m6gZw=;
 b=znc/9ipAhUw5NRk3eDOKEC8TRA2pIGCohtb5f/Kth878FS0ReYvo0fQ+kGsnml+xVevaVVRvjzchzbGHmLDl89/utElLasThp7XNPXG0F0ITp3wCbwU4OHAV1scITDAyM0d1MEuz6+cs6I8mCtQ+2vg7FGf4ppE8i/DOWy+HILY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1903.namprd12.prod.outlook.com (2603:10b6:300:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 21:51:09 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:51:09 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
 <1d915089-6545-5292-5fc1-bc289ed07ca0@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <bb763c0e-dcaa-3625-1a38-1158808a574e@amd.com>
Date: Mon, 2 Mar 2020 16:51:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <1d915089-6545-5292-5fc1-bc289ed07ca0@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 21:51:08 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26db67ef-e0d2-45e8-cd6e-08d7bef3d0d9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1903:|MWHPR12MB1903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1903FD1D90B2BD3BEAC05BFBEAE70@MWHPR12MB1903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(189003)(199004)(26005)(36756003)(16526019)(186003)(6486002)(956004)(2616005)(4326008)(478600001)(966005)(66946007)(2906002)(16576012)(8936002)(316002)(31686004)(53546011)(86362001)(66556008)(5660300002)(66476007)(52116002)(8676002)(81166006)(81156014)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1903;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoLXADxSK63zFyh4Zy3G4HFj0fZpv847Cb5E3rkMEMi1ZS0SM5xQE87dnmKyWiiEsX4Q+2ZlDR10jjVUgh5vI0tF4bcDdaUEu3eK4biLD3tBb9IPv9G2G9Zt/P8r+IB2AN3Q2NZxztlb7vf6z5txmeDGRpJfMvC1vHdInljzJjJ9yiSrag08mDbKPdIaqDOt0rrG9qOp2ur9XsOKFJ9fpDt3u6Ad3S9zAM1BGKquDt8UV2SqAesO55KfLKUh4yAygq8JaToRVK0iQArsaaOx7GMAjDSDVCpjc02nXWGSwBybZi4dvlI4Kuj5zN6KO0HgkcLuo0Qr3rl78eYCm/49bsvxwj+3o+JTH2ZqCOMPCDu1+BPoQMZGIhOvsTBwGOFES9DVPDzVmlaUXYcvtQVI8wYChs0IaQ3tWPwxTpnUXpRZhOa75Y0qHEU0vvQo1SmqaB/vJo/KEiF3na839RaNVlGy/neAwk7+rkiTJpUGseFM1o9NluLCHWtOnibNLpWDdxFMma/wNlcj1yvUYYtG9g==
X-MS-Exchange-AntiSpam-MessageData: XG5yvjIvkZ+T6g5s8hMs8t1acQTqZiFXNaUDu5QdRVwnSql14FJNLkE7hRHbiEjs7B1EDkAjRye9fFHR7cOqqqxqqOUzH03MUxlwzBTyVoHm41k4Zz4DNOJ/Wa2Ub4XTV7Ra5Vs9ekJSzXaRAr4ngw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db67ef-e0d2-45e8-cd6e-08d7bef3d0d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:51:08.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw0OzYZKhT93DqWpisHhuGwkdK/GuDSW5zObJqk0OprxRPLv1LyRabVGRJAAcGsuVRVMNQlGy395SLMV2R3lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1903
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


On 3/2/20 4:19 PM, Luben Tuikov wrote:
> On 2020-03-02 2:24 p.m., Andrey Grodzovsky wrote:
>> Add the programming sequence.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> index 8ab3bf3..621b99c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>>   /* memory training timeout define */
>>   #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>   
>> +/* USBC PD FW version retrieval command */
>> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>> +
>>   static int psp_v11_0_init_microcode(struct psp_context *psp)
>>   {
>>   	struct amdgpu_device *adev = psp->adev;
>> @@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>>   		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>>   }
>>   
>> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +	uint32_t reg_status;
>> +	int ret;
>> +
>> +	/* Write lower 32-bit address of the PD Controller FW */
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +			     0x80000000, 0x80000000, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	 // Fireup interrupt so PSP can pick up the lower address
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
>> +
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +			     0x80000000, 0x80000000, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	 // Fireup interrupt so PSP can pick up the upper address
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>> +
>> +	/* FW load takes long time */
>> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +					     0x80000000, 0x80000000, false))
> 1. The LKCS wants a space after a keyword, "while" and before the opening parenthesis.
>     https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces
>
> 2. I'd rather include a polling limit in this loop, so that if the PSP goes haywire,
>     we don't spend too long (forever) here. Also, I'd convert this loop into
>     a do-while loop, and let the "while" check for the polling limit, while in the body
>     of the loop, we receive the status from psp_wait_for() and decide whether
>     to continue or "break".
>
>> +		msleep(1000);
> That's a rather large timeout given that "psp_wait_for()" polls every micro-second
> for 100 microseconds.


The download from PSP to USBC chip over I2C takes between 20s - 40s 
depending on the PD FW file size to download, only at the end of this 
time interval will the PSP respond by setting mmMP0_SMN_C2PMSG_35 to 
0x80000000, psp_wait_for is using udelay which is busy wait and so to 
avoid blocking the CPU for to much time during this long 20-40s wait i 
prefer the 1s interval between each busy wait of psp_wait_for


>
> And also note that you poll immediately after writing to MP0_SMN_C2PMSG_35, i.e.
> you don't give the PSP any time to process the timeout.


What do you mean here - why I need to give PSP any time here before 
starting the wait loop ?


> I'd rather do
> something like this:
>
> 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> 	usleep(100);  <-- Or some optimal timeout which gives the PSP FW ample time to react and process the interrupt.


React to what ? The next time PSP will react will be when the I2C 
download finish or an error will happen and this will be caught during 
the next cycle of psp_wait_for

Andrey


> 	do {
> 		res = psp_wait_for(psp, ...);
> 		if (res == 0)
> 			break;
> 	while (++polling_limit < POLLING_LIMIT);
>
> The advantage here is that if you hit the polling limit and
> a subsequent read of the address is not what you want,
> you know for sure that the PSP is stuck.
>
>> +
>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> +
>> +	if ((reg_status & 0xFFFF) != 0) {
>> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>> +				reg_status & 0xFFFF);
> Perhaps you want to say "%04X" so the field width is always 4 hexadecimal chars.
>
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +
>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
>> +
>> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +				     0x80000000, 0x80000000, false))
> Space after a keyword ("while") and before "(".
>
> Same sentiment as above:
> After writing the interrupt, wait some nominal time for the PSP to react,
> then psp_wait_for() in a do-while loop also with a polling limit.
>
> Regards,
> Luben
>
>> +		msleep(1);
>> +
>> +	*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct psp_funcs psp_v11_0_funcs = {
>>   	.init_microcode = psp_v11_0_init_microcode,
>>   	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
>> @@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
