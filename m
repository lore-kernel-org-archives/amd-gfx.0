Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B59C282DD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 23:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B282072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MyVlHCQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B282072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026776E156;
	Tue,  7 Jan 2020 23:01:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B116E14C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 23:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMnpLu48uuhcPhPBpznyq+JtEvA1h9yPzm190+z6a/OQpVmdSAxAwwdReBhOESObjAEfA2uUbkRGfvyG3Ewl9ZN8DgMsqPFf6eG/pNHQgf1BvGR4z/nue29dtzbsrvgICQaYAv6Wh+RXwMLV8zelGCnqWmjr68N9ctCpaiV/Ae3el1m6XC3dokoYOLkNo54wdbKIp23C4l9zGcFhtnMxlPhBcMvh/NFR7R1MznoIDjgOFgzt8YPyldJvJPRbzKu/Qm9hgHGr+d6iAriaUTbsW9KzB81yiIiAAq7DduyL+Ypk1bpB1j4ftNnsyj3VT5CwwhX1Sib5ofxsEVQW+yN7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNVoa80pIyS8mbjid1ivBPsysGFtqamyU8NGoiFW9+Q=;
 b=SdvzgNHjAuUfL2utS9f5P8jmlOfxRHx66FEoZmaJ2yEKAKwgylPJ8FMJRm8NTfU4BCElNZ+QqeG+YSk/iwuv53SKC+7+VAgEstEiztONh0qdJKdVwZyY9QN8QU5gkAKt2d0UmtE6z2BdAVjstOx5/2MmWR2E+53NkQFzju9VQ+JgL4E1b5xDEN4wedIkeVtjXqSYIaTelQA+O/KMBEWHstRfmkc9dwxooOZkTpWuwsyUz959GqnUQL9E4XI2LHdrAKqaMKLny9tnaCfY+PBuNSTx7uiCeMVcDTvqjneLMqj4iizq6YQsW20QLOwa5KWuQHV+PNyx4q4ezj0pnU8xRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNVoa80pIyS8mbjid1ivBPsysGFtqamyU8NGoiFW9+Q=;
 b=MyVlHCQ76rI1YWw3ZStVflnNdcfLw8UCTdJKYa7WmmHvVR5b5VJjZZcqQvIvEK1gF/19wmT0BVpMzwyo9w8Ga61+iAK0eotg95ScdFvdsMT8/W727CBbQlMebmaj8SRnQbIPfACzNnxRgNpKVlA/EBA+ZVi06CZZMWgRItZqcUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (10.174.106.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 7 Jan 2020 23:01:18 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 23:01:18 +0000
Subject: Re: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200107212209.20688-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a545135d-e484-edd2-f412-f62553e96bc5@amd.com>
Date: Tue, 7 Jan 2020 18:01:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200107212209.20688-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Tue, 7 Jan 2020 23:01:18 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0f92d17-8fc9-4533-5586-08d793c58177
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:|DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185DF068A106A39BD763DB3923F0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(26005)(2616005)(66946007)(66556008)(66476007)(53546011)(52116002)(478600001)(956004)(31696002)(16526019)(186003)(86362001)(5660300002)(2906002)(81156014)(316002)(81166006)(16576012)(8676002)(6486002)(36756003)(8936002)(44832011)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0185;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPCrqO3hr/GTn/CJ86A0KrVavOtB/p+ZpmFH6k6JyGZjOL/uFC6QzNpzZ5XxEO9aXskTMqyEZEGf+1AekBHRZBzW40RgQoptbr+RzL+w4hX9Lsl+oVaLomcKHQb0BYe8XMvG1mAQ5/1rFKMeA8p3PZaDmCBV45IB+gIq/cKLBCcyT/zDtomCCSEB26QdzUjSRHpIWoOreoPQ86DnKQLEIs6Cmzmr9SA6HgNMha97r3FXK6TorNb2qYeKNMQ+JSXVpbz/d6MEFwsET3G26itwDpg9JNn832KHQE5jHaspGO5xZ7CRsnP6LSF0S93GBo7Zy+BmbnBnBXpZoGWiqBe/rHw2gpLWI/4eqybYkOXXUdwPBuKalUBPrbBBlHcr1foq6j7xdNBjh7YJ5tY3siubfjGB5lnb/dmleR84TEAVVK3gObN4QGYI5JxHvjaKitcK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f92d17-8fc9-4533-5586-08d793c58177
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 23:01:18.8015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pakf3oLAZh2lRgNjXwUoBYC5KerPOLxTAP/Yy7HGTT2iXVPJaGaQjTEInRj8F+aXAYiqsy9DcKXV3EsF3VVv7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-07 16:22, Yong Zhao wrote:
> The SOC15_REG_OFFSET() macro needs to dereference adev->reg_offset[IP]
> pointer, which is NULL when there are fewer than 8 sdma engines. Avoid
> that by not initializing the array regardless.
>
> Change-Id: Iabae9bff7546b344720905d5d4a5cfc066a79d25
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 65 ++++++++++++-------
>   1 file changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 3c119407dc34..2b26925623eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -71,32 +71,53 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
>   				unsigned int engine_id,
>   				unsigned int queue_id)
>   {
> -	uint32_t sdma_engine_reg_base[8] = {
> -		SOC15_REG_OFFSET(SDMA0, 0,
> -				 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA1, 0,
> -				 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA2, 0,
> -				 mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA3, 0,
> -				 mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA4, 0,
> -				 mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA5, 0,
> -				 mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA6, 0,
> -				 mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA7, 0,
> -				 mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL
> -	};
> -
> -	uint32_t retval = sdma_engine_reg_base[engine_id]
> +	uint32_t sdma_engine_reg_base;
> +	uint32_t sdma_rlc_reg_offset;
> +
> +	switch (engine_id) {
> +	case 0:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
> +				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
> +		break;
> +	case 1:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
> +				mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL;
> +		break;
> +	case 2:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA2, 0,
> +				mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
> +		break;
> +	case 3:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA3, 0,
> +				mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL;
> +		break;
> +	case 4:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA4, 0,
> +				mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL;
> +		break;
> +	case 5:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA5, 0,
> +				mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL;
> +		break;
> +	case 6:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA6, 0,
> +				mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL;
> +		break;
> +	case 7:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA7, 0,
> +				mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	sdma_rlc_reg_offset = sdma_engine_reg_base
>   		+ queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
>   
>   	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
> -			queue_id, retval);
> +			queue_id, sdma_rlc_reg_offset);
>   
> -	return retval;
> +	return sdma_rlc_reg_offset;
>   }
>   
>   static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
