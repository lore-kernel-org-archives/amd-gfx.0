Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EEDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 22:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49DF64FF4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 22:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49DF64FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D7B6E1D5;
	Thu,  4 Mar 2021 22:46:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A436E1D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 22:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6n/9Cf+RZfmX1uMKngmdhSTJJBNbWWgcd1JfloihR7wUNS3r1Hxe0T9ljfofklR2NeBiZQ80SZ3lH5T5nBRRQ4bSmhPXK2CLnU13+aaPGCUAMBD82Mb8mG7evMEIt90pwE+KwujCINE1OaUbdzPMItl004j6Xz8AexsWuI3F0YqhWMbbYcypRsGzD/rWmvQDaLD8czulQm7/WgzCPZrvpJvfG/Ais/1Qt9zMx3YfgYgV7D3gfZRU6t2FsvmuglObqRcLhz4oBEux+Dd0AgJlrngz2AehscswDFE4T2zQsew7S8ljscqxgy0z7o4v1epHLZKUmJd/THr1Zt+R94TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn21QHF4+3XIrW07hV19wRtIBNXvGPadvI4U1uFA5BA=;
 b=lHj0Z+T46hnszX7ceU10N5gk4cK9rtUaHBW1Tr5eKIWbDrX/VsRPQddSyJcKsMtqzCUlJwG0edbRvpBH/+UPHi/TXS8sl19IP+4OV98d0j0+E+LkH6DCFTrRo1OK7LMFrsI6M84mjrBUleeIuqvMbBtNjZpya6hjD/gfQCEPbTifIWMAmxzkVIL2/abZl3OG8s+dJQ1F7lcXE7Q/kC3+wNqyQ0bVs6ZFcDFEk7ZrXzLGcywPXtQmTzD73SkZG0FLPwUygCLNKqbQ+1e4fEIbP9kkENysVgRt7OHUFFLkPqmzW+FT3Ynbg9h3cFbtgbs5Hi0MmkOkbD1KZD2nSiqLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn21QHF4+3XIrW07hV19wRtIBNXvGPadvI4U1uFA5BA=;
 b=XFt7kRID8H27JCVg+Kou4aPsafAOCnD8MCCgugAsa0G41/ohHRRxwkoKx8cRsR12rPHimsGm0R/jiPKpKHE+0FVuGmkWHJ0pTL94nCPq4TlUUpObLLqfPY9hvrHL2gp13jMOAPnhZhouyVIZxurWky3rDVU6Wsq3TA1GKldEmnU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 4 Mar
 2021 22:45:57 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b%3]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 22:45:57 +0000
Subject: Re: [PATCH] drm/amdgpu: add DMUB trace event IRQ source define
To: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210304194323.3498-1-hanghong.ma@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <262bb985-04f3-3809-100d-acba76b9f074@amd.com>
Date: Thu, 4 Mar 2021 17:45:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210304194323.3498-1-hanghong.ma@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23 via Frontend Transport; Thu, 4 Mar 2021 22:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 425ceb1f-1306-4d50-3671-08d8df5f46d5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB006321CAE7D89C9FAB2A29FC8C979@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3O7tkqTdPtYGlyiwyDr8Z6hVoCB1ER26H0cdqplaGE6ojOO5EnNPj/5V/1i+9EoojaIa3BLEg8XMP8mHNutEyU/aL44dgN0ZsxLXkiH/DPYCZHIk9692alZ+617tkRkQ4l+7UD4Av672uzopnxaabXCXEO1t3hgwDCnJmQc61gzMGcVh9Dk2aSjEb+KCasWCHtj1g7jR9aNv+xYpT6KDGLK59C6281BnVMi2gvTN8eb9UAdIvz+w/SbvgpfxYSKKTaugRas4pgWJF1T9F8IYRwvdiSH1426wZbuiu5ksOUMuHHM7EcOqfB6Fcq0+cuKT+N//6w6h0N4h5iI92U6hrkLzCLa9LvyeO1zagj0hpEBflL2tpxGDJtmmUpzGD3YF2+h0W9Fbq1mDfYJsxcC0i1At9SFhpZRGaFs6N3f2sZgWZrPzWnsg/5ohJ7itNSXblrkcOzGhYdPsQqJeg3ZRiaPxcUNSHL2FInNWT4uvtGMp7lah8QKbMxcdWLe6fwwfI1dO40a0s1rzGdjSVJMCaYorwHTEqPMWNAdG7x5YdkO8sLYTwAmqJrgfMh7yqkNcSGDiQ1/1Zu1BCTrPXmhwuustRWHCAK3tzHiobaEou9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(31696002)(5660300002)(2616005)(26005)(66946007)(956004)(86362001)(44832011)(53546011)(186003)(16576012)(8936002)(8676002)(478600001)(52116002)(16526019)(316002)(6486002)(31686004)(2906002)(4326008)(83380400001)(66556008)(36756003)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3VUTUdPVlhTTmVKSGNUbWxOQ2FGdkphK3VLNTNpU2VpbWpyWWQxcDVNaW55?=
 =?utf-8?B?Y3pQZEJXcjY1UUdmVU9FUERzNDUxVEdyQXdTN2JxWm0rV0xSbE14ZzlxQ0cy?=
 =?utf-8?B?SHRSZ2t4UzNoVUFVVGxtbHhuSW1HTEZUVnpTMnlBL2REQkhOTE1kSEsyUVpp?=
 =?utf-8?B?dE43dXF1QUVGTkswRW1GaVRDUHlCSHNVdW5kWDNBY3pkRnFWclY3R1ZJbzAy?=
 =?utf-8?B?U2dqSmZUd3pjN1lZTzRlZ2N6VjhvSmdxMUF5QUEydU0yUGlqV3lzTmZ4MDhN?=
 =?utf-8?B?K0ZHWkplZFVHajlTUUowcTBaY3NTUnJmRytFUGhaU2s0SklBak9mVmlLbm1u?=
 =?utf-8?B?OTFhTC80WXRZNmVWbDFaRllYdXJrZHZjMG83QnBsUDQ2RWd6QUZFaUhDTm9w?=
 =?utf-8?B?QmcxL2pIWDJaZ3NrSHlYSVVVUThVTEg4OTBqNEJ6NWxKa3dBN1pXQm9oeVNx?=
 =?utf-8?B?YTJwbVpuTEdOMW1TbGFHanptbXlKb0w4SmlkaGN6VVlqdCtDaW5FVkxqUnYy?=
 =?utf-8?B?QVVuN1RSVzNUUjVMTzRFcUx0cVRjVmJyVTNaZzJWdGVZd3FXcmMxNGRjZ0ZI?=
 =?utf-8?B?WTd1TmxiV2dqZHJpUUVsVGM3UWZNR1Z0TWQ4NjZFMmRKeFZ0MlBCcWd4YkNq?=
 =?utf-8?B?ODluR1ZpaXpLTHNuTkRaY3htTGJiODFFcDlxU1BLSnJ1RDQ2MjlhOFIzcGR6?=
 =?utf-8?B?VjVWUCtjQ3kxVjU2L2NTUllmci9pai9RNC9FcUtqU1pUVWtvSlJDSGoxWFVn?=
 =?utf-8?B?ejBnNkx0NlFscFNXVnRHRVBqK29yU3plWmNHK0dseUxjamliRGg1ZnFGSWtr?=
 =?utf-8?B?QUZhckhLT2U1OFM5N29Lb3A4bllPRnh0ajlEaHBSa3pEbjEyS0dsS1pCZm1I?=
 =?utf-8?B?OUtnNGp5Wlg5MVg2c2NrWXJkaUFrTlUrY25hVEdvM2ZuUkl0UFVWbFE0NUh4?=
 =?utf-8?B?OEtIRTdjdHJpU3k5SHBqckEzdkhzYitsWU9peUVPcHIrdEx6MW0rTnNPOXFK?=
 =?utf-8?B?K3JESmhqNW9QaVpTN1l5dHZiRTROK1g0ZFlKMFJFK2RTUGh3aGszcGlEWUpk?=
 =?utf-8?B?TmhSRUYrOGtHL2RiZjJYZDhCQ3VnZkNoNW95d2F2TUV4VG1YNVNpSjlDSHRu?=
 =?utf-8?B?eEJsRUo3T215cVYwdk1CVnI2WW1ueEVVZjFTNnFRZzgrZFNzV2FsbkVqbFY2?=
 =?utf-8?B?NzRIWk5LM0dwaysrNmVobUFLUTFMRVdOTHgrbWZrTUVVWnZsOG9PMU9nZkhs?=
 =?utf-8?B?eTJiZVIrTjh6WlY1aE9KT1gzY0wvSmxLaUdwWjBNczZQVjIrMTdxcFROeldE?=
 =?utf-8?B?YThqS05iRGFsRWZjNnBuSm5rbWtKTGU0a3FXWWl5eThXUDNPR3VwK1pvOXc5?=
 =?utf-8?B?Y1Vmei9aM0tDQWo0ZGdpR1lLSSt1K1lEUHZpaTBaa0RxK3grYTYwR0p0M3NV?=
 =?utf-8?B?dzJaNTZmNUFRNURnME52VXJZU2xUN29PSXR3dGN6NmlvcDlDS1ZCRWtoWmVl?=
 =?utf-8?B?SlErWUc5cFZnV2J5VzY5WXR2MFk3Y2pyUkpkaFpIelV4L2hGeHptQkcxeGJQ?=
 =?utf-8?B?Z2lDejdSUU0vV2l2eFZFZnlESzEyczJlclJmYkl3bUxPcStqMjRhWDIyMjVy?=
 =?utf-8?B?MGVxRUlPakliejRSK1FzSWFKbnBrbW9nMnFtTmZSNkhSM0NJbkhFY3A4U1JL?=
 =?utf-8?B?R0V2TkRtVzU1aW5ubTlMU1pvdld3cjRFTmhOVEhnemNDc2xiakVxUGl5UjJ5?=
 =?utf-8?Q?RrF5SxFM5Xnh/eb1hIc/+9wZHyI/iuTlWFgJIBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ceb1f-1306-4d50-3671-08d8df5f46d5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 22:45:57.8281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5PsZ1H//0gp3N1ui3tp1zG1YfN4NMl8jvX6UIuqgCx1JWAt6qeOdDi2yJ9F/6oNz+HNW2bXdDcTYaSiq8c/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
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
Cc: Rodrigo.Siqueira@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-04 2:43 p.m., Leo (Hanghong) Ma wrote:
> [Why & How]
> We use DMCUB outbox0 interrupt to log DMCUB trace buffer events
> as Linux kernel traces, so need to add some irq source related
> defination in the header files;
> 
> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 +
>   drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1624c2bc8285..f01b75ec6c60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -912,6 +912,7 @@ struct amdgpu_device {
>   	struct amdgpu_irq_src		vupdate_irq;
>   	struct amdgpu_irq_src		pageflip_irq;
>   	struct amdgpu_irq_src		hpd_irq;
> +	struct amdgpu_irq_src		dmub_trace_irq;
>   
>   	/* rings */
>   	u64				fence_context;
> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> index ac9fa3a9bd07..e2bffcae273a 100644
> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> @@ -1130,5 +1130,7 @@
>   #define DCN_1_0__SRCID__HUBP6_FLIP_AWAY_INTERRUPT	0x63	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP6_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
>   #define DCN_1_0__SRCID__HUBP7_FLIP_AWAY_INTERRUPT	0x64	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP7_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
>   
> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
>   
>   #endif // __IRQSRCS_DCN_1_0_H__
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
