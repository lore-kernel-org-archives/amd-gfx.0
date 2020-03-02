Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46679C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E603420873
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mrMHUbpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E603420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B383A6E845;
	Mon,  2 Mar 2020 21:19:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3F06E845
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8PteHqMbilzUCU0kdIAOT+17xGKe3iPkDfaC6DiWzb923m8bU7n10q/i30czSGcYRtisHB0pIMILfo9SzieMPObqLBn7Gf6mhzBH0aINDnSqngppw0WLRc+SthLx9gzVuMKweS2qXBGXdta7G2jvvir7mriFB17/BhXN7kbpbwfNlhwm9U2I2yA+WHL34/5tVRE5JaPh1L45edbYWKUbP6VSXx3UE1r3lGyJ2iRWOyKBNZRzytv7IGeiq0b8oKPvKw7n92zvzZz28QfF0KtJaE/HywBx+dnnsSZjnMMM/yRcxgsZP09ygt4fgYWxsSO2/LH0QtkkkeIHfgxgOc5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0pFwEVw+ALpG8OcFefh0XrxjNr0S0OkVqQhu3pO3b8=;
 b=WJZX0cOKobhYBdiWP6AcuxzcY2E1U2QMYJ2iH1eYrTTUEhqN4mFy/MlzZ3eD6+S9XiV31FgIX8LcPJQDZE6fIBjskVBGF0nbnwJw6DOQNSVDIP6y/0W5+Zgh1f3+TyjPC8AAMwtG22Ya/lTMk0ELmvGWTAASHS9M4mgr4sMDzuPkeS3yX4t+eJ6Sh+A4mcRXIDrSEAKHF5EvcaiLTF6sXuMqFhNbq6fzQjxZ59Y3vFI2vLimPHKF0VJNCZpxc/f4uuW/kvPQfPSbneYmOcCFyPdrCvRs1ZUQnV4Ew0Ec/leDhaMZLPHcjZpmoCKFGaRP+Rnt1hhSgHpB/W15ge0XAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0pFwEVw+ALpG8OcFefh0XrxjNr0S0OkVqQhu3pO3b8=;
 b=mrMHUbpE1bHW6fC55RbmdGA5wQLZyi9Lz3gYPp+jKGV1Iq8xXy2gUSgAsphFLXFqM+RvoEwEz+c0gUTuzOAILNHrjKudVOl3u40EyNW8C+SAUVY1ZpVWuoMOFJ1UsrWwyMAnEgdkrA/4dYCzjvOLsux7QHAZqteiljGz7gBmqRY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 21:19:25 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:19:25 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <1d915089-6545-5292-5fc1-bc289ed07ca0@amd.com>
Date: Mon, 2 Mar 2020 16:19:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:19:25 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69d9bf3e-ca47-486e-7f98-08d7beef625c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:|DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265C4E7D523B23CE32AF20C99E70@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(31686004)(478600001)(86362001)(5660300002)(4326008)(36756003)(316002)(2906002)(44832011)(8936002)(81166006)(81156014)(8676002)(966005)(6486002)(31696002)(956004)(2616005)(6512007)(66476007)(66556008)(52116002)(16526019)(66946007)(53546011)(26005)(186003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4265;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fElBZ0F2B9qriSE7j2nkVoFUJdprbTcQYbBe3BUeSMGP9LEfJpBWPeXFJATp7hMUTh7FqayTA1JRTdpA/YSYvRgH1YK0OEQIDpHzwi7OIgUmeWVctGsfOwdPZYt8QkJFrMz59U39vm1AR09ahAwxSZifbnu6GQxInC8Kw3T//Q7o6cpVUCM5lNg7/+kLxO7uWxEHGT++q6CHETF4//XmnIES9AFE6uJhWZx4mMUAgBK7XdT+6zNxgD5+h3fa0/0Tg8MOf9hHmguHzhpyRaF42cuxIixDaT1CsTsQtBKj7VczLzD1Jc683N+Fg5c0ZvPUOvZj4bctqGiFgRguZ8UJkiW5Meuoo5gYpP+x17lQZNNxfq7QsS2MFc2h+Q4SlCd2YFgRmvrgL9Qu6wstt7TSxGfNoeVYqMKnGXKYj5CnkUCEr5w7PSPAeZetrojAo3OZZCyOsThbEfth8xPr9WNdRIFHEaoyditwBafNTA3iMDzCmTKqUg1TsNRB1+/K6UyQBKnbM2Zm0QdRVHGJAs989g==
X-MS-Exchange-AntiSpam-MessageData: Wa+ykvtv6sdal6wijNMU7qQ1FOqDR1dx1TX4oDrzW1ABN+Uy7PB3ZdeptdQxqlI4HNxMuZPzxY16ZF+IO1poaxd7JVNYJs3/iERd2GPpWqcznvKHXI+ITyGDQnzEfPM5BGqo81RKwGMzpephTwiBPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d9bf3e-ca47-486e-7f98-08d7beef625c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:19:25.4004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr3DcOmN9IMjcfrj/x6lUoqbZRqoMjvCOhvG/zK6jA2+O/FO44EN9Q12FI2JikCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
> +	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> +
> +	/* FW load takes long time */
> +	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +					     0x80000000, 0x80000000, false))

1. The LKCS wants a space after a keyword, "while" and before the opening parenthesis.
   https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces

2. I'd rather include a polling limit in this loop, so that if the PSP goes haywire,
   we don't spend too long (forever) here. Also, I'd convert this loop into
   a do-while loop, and let the "while" check for the polling limit, while in the body
   of the loop, we receive the status from psp_wait_for() and decide whether
   to continue or "break".

> +		msleep(1000);

That's a rather large timeout given that "psp_wait_for()" polls every micro-second
for 100 microseconds.

And also note that you poll immediately after writing to MP0_SMN_C2PMSG_35, i.e.
you don't give the PSP any time to process the timeout. I'd rather do
something like this:

	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
	usleep(100);  <-- Or some optimal timeout which gives the PSP FW ample time to react and process the interrupt.
	do {
		res = psp_wait_for(psp, ...);
		if (res == 0)
			break;
	while (++polling_limit < POLLING_LIMIT);

The advantage here is that if you hit the polling limit and
a subsequent read of the address is not what you want,
you know for sure that the PSP is stuck.

> +
> +	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +	if ((reg_status & 0xFFFF) != 0) {
> +		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
> +				reg_status & 0xFFFF);

Perhaps you want to say "%04X" so the field width is always 4 hexadecimal chars.

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

Space after a keyword ("while") and before "(".

Same sentiment as above:
After writing the interrupt, wait some nominal time for the PSP to react,
then psp_wait_for() in a do-while loop also with a polling limit.

Regards,
Luben

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
