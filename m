Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4DC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C85021569
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fGkuFAAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C85021569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B486EE04;
	Tue, 21 Jan 2020 17:43:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF1F6EE04
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqxhXmrECkDWRntdedF95O3hoxN5oySEeNtfCgt9CDxrD5+p6E2D+UQfmVYVRbeu26YLdL0Ua78iCAgZ8WGZzMnf4NIgDs30cLB22A3vMLvGbWv0xVEveQFamMYswUNo7MI3xGm41gCi5m+SYlGWG1OoOQtx2m4fycLlELmjfG60OVVthVtzFQ6WdTJzhUDxZCn+X1Sq++aXfOYb/Dur+p5absXqKVs9s2SC9JM5RgaLMgr3pV16EO3+g8eoiNLqkLJvCD/v0AlYXsgOoIg3WkbmruaDe8lkEw7i4dqwmLxZNfeZcRIcQrj5U86lbfGSeZNsxoTAAikPUQHr5MV9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSL5rAb+mlZz51y5PAwj5hitIelJXz5VSoBjX/qb40o=;
 b=LFNkM0t347NobHAagKIrNXPAm0NZbpmVPCAg/BPqdi4t4aciA8XcbqhWb8Cn6MFLVtdFsRbE5QNzo/qA/weAN4e7qpfq9oTzTarqXJl+k2m7V2QGlG8jl9JKb0aRK0JfVf0MK+J4Z3ffo6kZ0cjNbCffybRpoeBwkhewLIe4bK1x9iaLS/870BcIKTLiH8LtJasINvMTCGInBiRlvuyoJvBrnECOlE5IJsVDoktqQ/HPdkhUK4sa3SvGSmgOL9GBxYeVA/qYGS3e7/b7pwcSya8dDkik0L4NkSga0qbwkN5VDbqqGNwHc8kXTRRkvjM5PF+J+SFa0XSYkk7mvgp8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSL5rAb+mlZz51y5PAwj5hitIelJXz5VSoBjX/qb40o=;
 b=fGkuFAAdx64dXQQJFHqsHg0djWBYkb6DyeaFGa3fBnGJczgmj1UgXkqe7z5pWRxYYnorVhChOg3bQJb2fYTbNFYa4zpZvfXzLJyaCnukOXJTGvgJg5weR4RX/9dXgm7QqmZp3Tf3g4qS+2ZJeYzi8RngH0RIm/AYe9RpTSL+E00=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2649.namprd12.prod.outlook.com (20.176.116.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 17:43:06 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:43:06 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
Date: Tue, 21 Jan 2020 12:43:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 17:43:06 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7166acc5-6300-4111-a3f3-08d79e995f7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:|DM6PR12MB2649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26497CE411CBEE561F5609A9E50D0@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(53546011)(86362001)(8936002)(316002)(31686004)(26005)(31696002)(66476007)(81156014)(8676002)(66556008)(81166006)(16526019)(16576012)(186003)(66946007)(4326008)(956004)(2616005)(6486002)(478600001)(2906002)(5660300002)(36916002)(44832011)(36756003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2649;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ+JXuczdn14+53f8lrupJek1hm0OhKNgyAGaMlXmX6UN7Psx9wGbR7qVSlFilyBl5b1HFUUqxP5FdMBRhn00HWiaZ2+3o8bcmlra/TlaBp87RHb8U/OM/buFT2MuBVFwoif5yMYBNXfoTcPD9PU2ZCanlX/9Hh/2ej8zcDvXSIU7goX6S1OQcuDWN76sNDrdODRR/iikJqGw+oBVB49O+7XrtdQwVohvnDZ6sSv1+dEUR7b8JxZmxHChG5vQQoqAuIiBtsUudPFXAuiuRze1fbwgo6rY4Dkms05B+Y5IKrY4cjSgsnw2wwbtyoMqyyVNrb2fFuG2UNQTih3WHTUzHphvlGsgWygrJ7tJseapQ/rH/6oikXcp0cHIGwN6RuOoxoQMkJY8Sn10vefG0x316oYywlZm9LlvGnZj7hC+EG3BdZA7/YLLz3CpdzX5tiN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166acc5-6300-4111-a3f3-08d79e995f7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:43:06.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByuowUI6Roe/OqfUdL1O9u1SrgclGiGGCjpepsHQ1rjav32AWn6b+O/NJe6GZ6MK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-01-21 11:19 a.m., James Zhu wrote:
> Use inst_idx relacing inst in SOC15_DPG_MODE macro
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 60fe3c4..98c1893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -65,23 +65,23 @@
>   /* 1 second timeout */
>   #define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
>   
> -#define RREG32_SOC15_DPG_MODE(ip, inst, reg, mask, sram_sel) 				\
> -	({	WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
> -		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
> +#define RREG32_SOC15_DPG_MODE(ip, inst_idx, reg, mask, sram_sel) 			\
> +	({	WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
> +		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_CTL, 				\

I have only seen you are using inst_idx to replace inst, havn't you? 
this is not necessary, because we are using inst as the idx.

Leo



>   			UVD_DPG_LMA_CTL__MASK_EN_MASK | 				\
> -			((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) 	\
> +			((adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg) 	\
>   			<< UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT) | 			\
>   			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
> -		RREG32_SOC15(ip, inst, mmUVD_DPG_LMA_DATA); 				\
> +		RREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA); 			\
>   	})
>   
> -#define WREG32_SOC15_DPG_MODE(ip, inst, reg, value, mask, sram_sel) 			\
> +#define WREG32_SOC15_DPG_MODE(ip, inst_idx, reg, value, mask, sram_sel) 		\
>   	do { 										\
> -		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_DATA, value); 			\
> -		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
> -		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
> +		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA, value); 			\
> +		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
> +		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_CTL, 				\
>   			UVD_DPG_LMA_CTL__READ_WRITE_MASK | 				\
> -			((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) 	\
> +			((adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg) 	\
>   			<< UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT) | 			\
>   			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
>   	} while (0)
> @@ -111,7 +111,7 @@
>   
>   #define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
>   	({											\
> -		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
> +		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 					\
>   			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
>   			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
>   			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
