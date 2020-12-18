Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8579C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 21:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708B923B54
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 21:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708B923B54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1886B88052;
	Fri, 18 Dec 2020 21:54:43 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E623489650
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 21:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofI8jcdPDchq7qEdRLE4e2tPTjNLmXP6coEuIo2jfveoqXuXb8P0+JMZ5frSrktc6nsRdWp3SJUESmYmJ7zxk6BMjSR2rKBIZU3PomuuKGmjyyGHzx9j1MWaEPOQfGVillbInbs8HJGXHEpGrz4fqGmJ+7Troa7/EiADP9iej8qsArUJWP7pbZ1Ov5+iuaQEX+eOiImBTP67yJr6dHEpd0d71SVMxTC8zkjsgOmaBpXblVDbJSnne5kRUOnsmsGAQjl0gMwQj1siaYAA2xDMl4VMaof+Z9jRKZw8NJ7Z/Jojd9pH36Ckh9JcWSk93Er8NCUwF8B+0oF2N/x1I+lPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyRQsWuD4XYgbhdqyCiltJmAd6sA2wehy8DsHcbhCwI=;
 b=Nhv9gJ921+pICdYGj4nzkovDD0sO3bYLpsLD492e/wc+8VXjAMnxWsYJwqH3jJlfy2OULR/a37MmhtjQxnYVX+xJe58mHDZi9cOjmbqUtJ1KlUW99O+Uak1Pl+xLRmMrwuRzskh2m0FCrkxCfrSWIWtHjQMNdcNUO9223kLkKI2C1KRywa2K6dtiNTXdX78RNGor9ZG+W6z5JfwhgzCpuVKJuBLumHCK9bQjUVCaD6iKA2KQYXl19LMMXjt23o2cAasfVB60EGO5odcBWniscBGjYey1SfkgUEnjy7CGIw3VprdRpyVo/tSAGmB+Rrq8h+WUczdm29nnetS3nOHBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyRQsWuD4XYgbhdqyCiltJmAd6sA2wehy8DsHcbhCwI=;
 b=QnDsfPoKEFMRSXGw6AEeJElNbyD3LEEqi4rAjuzQE4vm/FxrkO08Uu+NInwtlNBiBBt7Re5yp7NiPS/rbGU6N5sk23zK9eJMYf5uN/+BQ3E2HiIQ7s4VRcB1CL1cSdpnEvEMQyIlVSIxhPoKAnAJEGOZHy+zBDe391GlTugHipw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 21:54:35 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9010:5e67:f33b:4dd2]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9010:5e67:f33b:4dd2%8]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 21:54:35 +0000
Subject: Re: [PATCH] drm/amdkfd: check both client id and src id in interrupt
 handlers
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201218213416.61131-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <79d80ede-4562-d3b1-8e85-51d27027afa9@amd.com>
Date: Fri, 18 Dec 2020 16:54:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201218213416.61131-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 21:54:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b52a64d-6060-4a81-94b3-08d8a39f8274
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2514154425B50793B965251192C30@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsWjGZxXEi0BGkQNrznpRZmLQRM6BLLgxo7TGtLq/eGGVyMvo1ikIb62S44kLCLxKV5DGn4WZfEw0ki7Wr89ToWpOrMfMeomNu9LSc9XSVg776if7dSEBnwUV35AiYUTyPOKbf/sJNfSQTd0vVlUv2fQorX3M2IAcc+fvIZacYLUp8myzb6S6mcn+4I2GYcbo3Z3ucnolZYsGWCW1QP0npFGxd+7E5z1RIXH/hCG49tJ0/Vj30UFURumWQkzLFFn25nazbguPsNB7JBUK5WfbL9gypVEY1j1rRgWUkKZ3NhfbiKZjdt2XnLVBBCc9tVx/rO9pakugBpTEXxkjg7+4J1w55KncIyiYbwcf1M6vNdMsE+x71EzaSlHSqoXFA8tyu2ztbvSfOofTvYI1a7rZHpZpaxaVehrGz9zrk/2uITKGPSLX0Ej/uR7afCVZswre19tPvACmn2ibHKXhaK7ZMMlsQH6NspoeuSlj3GSEa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(44832011)(66476007)(2616005)(956004)(16576012)(316002)(31696002)(4001150100001)(8676002)(4326008)(52116002)(186003)(2906002)(36756003)(8936002)(86362001)(66556008)(31686004)(5660300002)(6486002)(16526019)(66946007)(26005)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0RsWUNoa3JCNjFWdUlYMmNmN1NRWDJoOGM2R2NlVXlOcDJRa1JvZUUvSW52?=
 =?utf-8?B?TmJHT0RUNE9HMWZ3aHQvS2xHWEQ0RFBRVmIzY1phQjBvVnpQWXJkZWV3dERr?=
 =?utf-8?B?cmF3c3lTMXM4NXZSb2dmSHpORzVvZm9hZ0lpNGs0ZWJtS05lUGJKWWFRRWI4?=
 =?utf-8?B?VXdhbUpQeWYzSnA3blJlTTE4WjNRNm5nODVKMUoyY0VwSXRnQ0QzenA0c1Bz?=
 =?utf-8?B?SG81MzR1VzdkUkErMW83Uk5YTUR5TGFoVDE0aWFHc09Yazl0VFppZi9Tdm1W?=
 =?utf-8?B?U09TOUNjSiswLzlIdEFXNzlwWmMyaTJmekRUMWJFVmI5OTUrMmhkejQ3dkFC?=
 =?utf-8?B?NVhDT3B1V0NwODM5MW1aSWF0S1JhbnFBRXo4VVY0OVZYS1J6aXRPRHBBcU0x?=
 =?utf-8?B?ZGFYUjNzMzhxUERRRkdpZE1oWEtGRkM3eFdJVnZDU1k4dzB0WEgrbnlwa1hV?=
 =?utf-8?B?bzQzcWswYVpqSUdjUDVxSzlzSTJhSCs2S1N6bkx2aGM1cHlicE84eVZYbnJF?=
 =?utf-8?B?a3dJQytyL0huOHYrelBRbHRkcTNrVHl1RUFPQ2JadEN3VTlnREd0SCt3M3Iv?=
 =?utf-8?B?YUdzSlAwTWZ4MFJRaWkvMlN0RUtoeXM2Q1pUMks3bnYxVVhyc1ZCckozTHVT?=
 =?utf-8?B?OUZGcFI3NHp5ODhrN3l1NlduQ3Uwd2pVeDE0bnR6VHJDdDVLZklYUUMwK1Y1?=
 =?utf-8?B?emNwd2VsZ3BUU0ZXREw0cDFpMkxUZjBreWE2QkVGaUplRHR2R0F5QWpmdmhD?=
 =?utf-8?B?S0IrUUFKNHg3RnlVREp5VnRRNnJ2WDhZNFU1UnRDYUFFcmoxNGNJZm01eVdx?=
 =?utf-8?B?MllCcDJQZGRvUEZWVHVnL2dBdEZFLzFSd1FXNFRDdUh4ajFQRGpHNVNHbHlS?=
 =?utf-8?B?dGkzN3ZoSkNXZE8rQlI4b0QvMW8vL3A5eG1EQVo0Ujh5S0x5ZEZLTFI3Y2xy?=
 =?utf-8?B?R2x0UFpyRnVTVW1pd29TWGp3ZDVmbnU2emtuNFdyMlhxRU80TGkyVVBRbXRT?=
 =?utf-8?B?ODZkU3hxMlF2a3NweGgvWE82N0dsKy9vWEJMMERQbzVvTjVlWFBvSlhSV1JU?=
 =?utf-8?B?SVJFVlpJZlB3T3FCSEZLZ2h4MnV1VzIzUXI3S1NaT3pGQzdwMDlZem1MS3JG?=
 =?utf-8?B?TDBjeGxRQ1pFa3VBS04wWEVwNHFqVDZNZHp2bVIvSzFYM0JmN1k1c2pBWVJS?=
 =?utf-8?B?OUhmaTVBcTFSSGMyZkRHTDY1dUJCRFJHZE1BWjVnRjJjc0VvUmFhcTYvZkJv?=
 =?utf-8?B?UXllSWJMdFdMdFpIRlFqYy9WeEVnbWlFcjhiT1Nlb3R3NFhweWRLYmxaNVJ1?=
 =?utf-8?Q?dQOEOtj8eauBJ4LD8fqixWvzAwjSlPozAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 21:54:35.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b52a64d-6060-4a81-94b3-08d8a39f8274
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQx2TfIKSCu2jBi2HQC6vKo8iEg0DaoqwCdeJALJfB5eIp3SKZJdbYluk8qssA9YWVfildEoJTGmX27eRy+XLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-12-18 um 4:34 p.m. schrieb Alex Deucher:
> We can have the same src ids for different client ids so make sure to
> check both the client id and the source id when handling interrupts.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Looks reasonable to me. Does this fix a real problem, e.g. KFD
intercepting an interrupt meant for another client?

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 46 ++++++++++++++-----
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 241bd6ff79f4..0ca0327a39e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -44,6 +44,21 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>  	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>  
> +	/* Only handle clients we care about */
> +	if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA0 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA1 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA2 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA3 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA4 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA5 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA6 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
> +	    client_id != SOC15_IH_CLIENTID_VMC &&
> +	    client_id != SOC15_IH_CLIENTID_VMC1 &&
> +	    client_id != SOC15_IH_CLIENTID_UTCL2)
> +		return false;
> +
>  	/* This is a known issue for gfx9. Under non HWS, pasid is not set
>  	 * in the interrupt payload, so we need to find out the pasid on our
>  	 * own.
> @@ -96,17 +111,26 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>  	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
>  
> -	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
> -		kfd_signal_event_interrupt(pasid, context_id, 32);
> -	else if (source_id == SOC15_INTSRC_SDMA_TRAP)
> -		kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
> -	else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
> -		kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
> -	else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> -		kfd_signal_hw_exception_event(pasid);
> -	else if (client_id == SOC15_IH_CLIENTID_VMC ||
> -		client_id == SOC15_IH_CLIENTID_VMC1 ||
> -		 client_id == SOC15_IH_CLIENTID_UTCL2) {
> +	if (client_id == SOC15_IH_CLIENTID_GRBM_CP) {
> +		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
> +			kfd_signal_event_interrupt(pasid, context_id, 32);
> +		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
> +			kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
> +		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> +			kfd_signal_hw_exception_event(pasid);
> +	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA3 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA4 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA7) {
> +		if (source_id == SOC15_INTSRC_SDMA_TRAP)
> +			kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
> +	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
> +		   client_id == SOC15_IH_CLIENTID_VMC1 ||
> +		   client_id == SOC15_IH_CLIENTID_UTCL2) {
>  		struct kfd_vm_fault_info info = {0};
>  		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
