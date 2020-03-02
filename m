Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFFC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8814621739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t3AicE1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8814621739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2826E4BB;
	Mon,  2 Mar 2020 23:04:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6CA6E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 23:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8/PGjC1zJ8b4vppcc6lA2Hv3lS/S9f3PQah/DZan/4CqwD/js3K/6Mgs1OBkMqFQDa2534XneY0ulby2cGJ/+FX8/Wm3LF7Hmn3StPmTT8V8uaq63BgzKpR+7+lWCLEXjuNmPAbOOKvsF+xri3I9kx6lmIwZm9azyfDsk7ECCdObJY3isRwtJ0uQmDGpQbd0Wv/57ORV0ZFBB5jbHIDNHWaFr8UzHAyAKvRio/j+ccSg++2ioGbJS/MmUPJgBiuk5QYSFVFIQ0KsNktoCaY+AaNN6nrR6UfwjbTWnyMrbIlrqq8l6n52ZdeqkuSbT+scLJkfZEsY1nb5MJCJEGHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxaTpe0LKc6UjojBnznMTtnjBxa84FHp+dozoOODJjI=;
 b=liFtmgO2FQbxw9mmfVyjxF6lhIwxuJMGFnBbb1yXh7UWW4KGC3PfvDWTkOV6PgmmJIvhss0U6EbbWoRcMsJvyI5AyN6IhL9WpmTHXCpNueJX6kEkX5/7dQ6kLmfE2i5pLZOydbjn9MWBh3spR64nhsVduqPtNMMHDGH1Z2amiNJu379LdmNJnEfsrkUFY5xm9BtHcESEbXL8Fb/Za9ssQHKi6HmDIuCpG8EohxvgDIBoPMUwF7OmSdrWhbl1c20F30Yfr8YueMxbxVgZz8vnKWnLDgIvyXKYigsFFGMQXXzUZ5bFVN15HTx7nz90ut5mQU5KzI4GxBSnjjqT7RUv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxaTpe0LKc6UjojBnznMTtnjBxa84FHp+dozoOODJjI=;
 b=t3AicE1M4vEfAAREGfDisNiioKmY2W4opjOYF8GH8rU0N/c2tPJnbyq0Z7fu/1lDvYHtmXxk7vGQ1wgOBzXrv43GBrxqm+2dOpXZVT+shqvWx0mk4PPhX+o/4MC7gjN6LDSO8U2UHiT0GAZOUnCLPAQ6dKcbntrdekT7fEmNDys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 23:04:36 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 23:04:36 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
 <1d915089-6545-5292-5fc1-bc289ed07ca0@amd.com>
 <bb763c0e-dcaa-3625-1a38-1158808a574e@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <4321e27c-444a-210c-629f-219a70cd9cbc@amd.com>
Date: Mon, 2 Mar 2020 18:04:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <bb763c0e-dcaa-3625-1a38-1158808a574e@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 23:04:36 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78d96a6f-a1f7-4945-61d3-08d7befe13f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4185:|DM6PR12MB4185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB418543DB95E8B3ED584CA67C99E70@DM6PR12MB4185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(5660300002)(2906002)(316002)(36756003)(66946007)(31686004)(52116002)(66556008)(6506007)(66476007)(478600001)(44832011)(26005)(186003)(6512007)(16526019)(8676002)(31696002)(86362001)(8936002)(4326008)(81166006)(81156014)(966005)(956004)(2616005)(53546011)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4185;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9gpDlxnA4Ob3zdHrIwh+5j3YyRZBD7sprVBIrxBI//H8CY/YvFkohZ5UZMtl4Nb56xtbFnYVG0WMJlhGK0pvEMLVQ1Mlij9zIXIciJjBVoEuquvto6xw/mQdXfLznALiIzfSs+myOon+w2wXY4En+iyqLrNY6UO4z6uyHSmmTCkd4mS/a/nY84EdWSd5Wn5sfm4qyZM3X/tADwR/MxahJ8O2XEL4LbMuUS24gxkWLaMgi8/3TAw4R/3NYC/6HHHqBY6qnJPYDpNKj3FdLtT0yFWmkTYQL91iYG2F0TUKEeD4F5SjyCRm3IUg36kNdSdOlaXiXgQ3Jasybb+OwLvcvD1pgFa+pJgwrbP9j2Nef5PrXm2SQZ92l/JAjQZoaO3/6ABAkEWyvRGSTvJJsrnQCnjjuG54lF98OzwcWtL2u8NgOpGhVcy8qHg3sdZk4To8B7aWEvcI9qb3B1bZT5zwYCmAFGwxazB/YZBLelkmD/IyRoFgejJHZQI9BcqyjX+4SsuHyy9h9y9FmEjRzwbTQ==
X-MS-Exchange-AntiSpam-MessageData: KCwDwqYN9lnE1FOBY+sxn4glmHSlNEG/m3ALRePkmzyG5saMBtT3rdW57zedrAzRyOL/qDSZ8QWy5dIiV5kn20gxiWYgYiq9XrN43ufLPsnleKCeyrRdHyWPezsq5bJ4EfyLj8gZmqIpiQ+xB3xqHg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d96a6f-a1f7-4945-61d3-08d7befe13f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 23:04:36.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhPFweJnEADTtjC2W26CS+bu0WcQGAm9cBfLbL7YpBbuCOlu8FP+16ecH1POXQ2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

On 2020-03-02 4:51 p.m., Andrey Grodzovsky wrote:
> 
> On 3/2/20 4:19 PM, Luben Tuikov wrote:
>> On 2020-03-02 2:24 p.m., Andrey Grodzovsky wrote:
>>> Add the programming sequence.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> index 8ab3bf3..621b99c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>>>   /* memory training timeout define */
>>>   #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>>   
>>> +/* USBC PD FW version retrieval command */
>>> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>>> +
>>>   static int psp_v11_0_init_microcode(struct psp_context *psp)
>>>   {
>>>   	struct amdgpu_device *adev = psp->adev;
>>> @@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>>>   		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>>>   }
>>>   
>>> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
>>> +{
>>> +	struct amdgpu_device *adev = psp->adev;
>>> +	uint32_t reg_status;
>>> +	int ret;
>>> +
>>> +	/* Write lower 32-bit address of the PD Controller FW */
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +			     0x80000000, 0x80000000, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	 // Fireup interrupt so PSP can pick up the lower address
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
>>> +
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +			     0x80000000, 0x80000000, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	 // Fireup interrupt so PSP can pick up the upper address
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>>> +
>>> +	/* FW load takes long time */
>>> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +					     0x80000000, 0x80000000, false))
>> 1. The LKCS wants a space after a keyword, "while" and before the opening parenthesis.
>>     https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces
>>
>> 2. I'd rather include a polling limit in this loop, so that if the PSP goes haywire,
>>     we don't spend too long (forever) here. Also, I'd convert this loop into
>>     a do-while loop, and let the "while" check for the polling limit, while in the body
>>     of the loop, we receive the status from psp_wait_for() and decide whether
>>     to continue or "break".
>>
>>> +		msleep(1000);
>> That's a rather large timeout given that "psp_wait_for()" polls every micro-second
>> for 100 microseconds.
> 
> 
> The download from PSP to USBC chip over I2C takes between 20s - 40s 
> depending on the PD FW file size to download, only at the end of this 
> time interval will the PSP respond by setting mmMP0_SMN_C2PMSG_35 to 
> 0x80000000, psp_wait_for is using udelay which is busy wait and so to 
> avoid blocking the CPU for to much time during this long 20-40s wait i 
> prefer the 1s interval between each busy wait of psp_wait_for
> 
> 
>>
>> And also note that you poll immediately after writing to MP0_SMN_C2PMSG_35, i.e.
>> you don't give the PSP any time to process the timeout.
> 
> 
> What do you mean here - why I need to give PSP any time here before 
> starting the wait loop ?

Because nothing would've been done in 0 or near-0 time. Effectively
you do WREG() immediately followed by a busy loop of RREG() (from psp_wait_for())
and there is no point in that busy loop.

> 
> 
>> I'd rather do
>> something like this:
>>
>> 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>> 	usleep(100);  <-- Or some optimal timeout which gives the PSP FW ample time to react and process the interrupt.
> 
> 
> React to what ? The next time PSP will react will be when the I2C 
> download finish or an error will happen and this will be caught during 
> the next cycle of psp_wait_for

Since you're waiting 1 second (msleep(1000)), it'd be better
to wait 1 second immediately after telling the PSP to load the firmware,
and after that point in time, start polling for status.

I'd also suggest not using psp_wait_for() as it does a busy loop for
100,000 polls waiting 1 us in between--not very interactive-OS-friendly.

I'd suggest the following code:

	...

	/* Fire up the interrupt so that PSP can pick up
	 * the upper address.
	 */
	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
A:	msleep(500);
	for (poll_count = 0; poll_count < USBC_PD_POLLING_LIMIT; poll_count++) {
B:		msleep(500);
		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
		if ((reg_status & 0x80000000) == 0x80000000)
			break;
	}

	if ((reg_status & 0xFFFF) != 0) {
		DRM_ERROR("Upper address load failed: "
			  "MP0_SMN_C2PMSG_35.Bits[15:0]: %04X ...\n",
			  reg_status & 0xFFFF);
		return -EIO;
	}

	return 0;
}

This way you wait 1 second after telling the PSP to download
the firmware and before you poll the first time, but 500 ms
polling for status every polling loop, after that.

Note that you can eliminate timeout A and add it to
timeout B, if you don't want to have different timeout
times for work-being-done and for polling-status. Or,
you can increase A and decrease B.

Note also that the above avoids,
1. the busy loop in psp_wait_for(), and
2. an extraneous read after the loop to check for status.

Regards,
Luben

> 
> Andrey
> 
> 
>> 	do {
>> 		res = psp_wait_for(psp, ...);
>> 		if (res == 0)
>> 			break;
>> 	while (++polling_limit < POLLING_LIMIT);
>>
>> The advantage here is that if you hit the polling limit and
>> a subsequent read of the address is not what you want,
>> you know for sure that the PSP is stuck.
>>
>>> +
>>> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>>> +
>>> +	if ((reg_status & 0xFFFF) != 0) {
>>> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>>> +				reg_status & 0xFFFF);
>> Perhaps you want to say "%04X" so the field width is always 4 hexadecimal chars.
>>
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
>>> +{
>>> +	struct amdgpu_device *adev = psp->adev;
>>> +
>>> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
>>> +
>>> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>>> +				     0x80000000, 0x80000000, false))
>> Space after a keyword ("while") and before "(".
>>
>> Same sentiment as above:
>> After writing the interrupt, wait some nominal time for the PSP to react,
>> then psp_wait_for() in a do-while loop also with a polling limit.
>>
>> Regards,
>> Luben
>>
>>> +		msleep(1);
>>> +
>>> +	*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct psp_funcs psp_v11_0_funcs = {
>>>   	.init_microcode = psp_v11_0_init_microcode,
>>>   	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
>>> @@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
