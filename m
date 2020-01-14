Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E7C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1453024655
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R52dFR4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1453024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0EB6E027;
	Tue, 14 Jan 2020 19:06:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA506E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 19:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABHTLBvPgR9+sHADdn8pO8sXMVEQS7zszBetPICyNUpnEcZgMLaPuf8D59HddPgbdFOF8VcCEl6kDLxedeYEKn7+PDo5E05up0hCHYGWNR4IA7d5WpeGscIy2knlVxy2mN/Irnl6yF3WofaAIcVcDYAt8pR1WDmkCF2+rdCRJW0JnaLUsBYsdJE4tlCu3uTn6JoWwf+uaAVN0Q/fuQgCsDZwBGhpGY6K6mdQF5NFvwObsSTJI+Fg23KjRjpSpKThFGc1wU1YiM0LiyiZNeT4+OPuPQMhuNAQBUQwZY2gzPhCIE3MGrppBkbj6s8T/xBYfMyE/bOCUd5xsDFK2+1zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9k2FFoLYcreCxjCcq7J4ld0SLzk11rwwZPrPQF5Do=;
 b=l8SiFau7Q+gYFQzfYmxsh7nEU2ZgzYW4/u26zIRro6WDvd2SqtNLYHFCM1ETo05E0m/iR3ro2FZKUuKNApt4gAvKiFEOt13cUlkzile4GLf8O7XrU5S/1jiGMAPEi7SGP+c8fSBqrQq4cAJWi5GzhfrGZOVareVSEj57mSZHQRU+n7rkGArjvDhXofUikoY8YD8/gw/NhZJS0xMJQWu1OUUYd0WR6K4pn2L0rPlLB0MEElQtIj2PDFzUBxfvzPvjtuJwzIW1UT/2rfVrcfS1buroKZlcKG0E88lE/C0zSZ5IEqFLiXmebz67ZAIzC+lVdWq7kKgFiy29VjjBX+9/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9k2FFoLYcreCxjCcq7J4ld0SLzk11rwwZPrPQF5Do=;
 b=R52dFR4/asCby/1AsoupqWlUdDHYSBpQPsQfuaaDX5+rzlbO969m0R9+Qk82/EPKA5vv661oeKYpVPwm2WqxrGIchfflE0/844S4ud9DF0dhKeNvMePUIkouhHHZEHRcqD/xMVSGgedPA2zegCLiQoAKIt/VyqCDnpCbLxKKH3k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2777.namprd12.prod.outlook.com (20.176.114.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 19:06:11 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 19:06:11 +0000
Subject: Re: [PATCH 2/6] drm/amdgpu/vcn2.5: add direct SRAM read and write
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
 <1579024702-27996-3-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <b5c0a2c0-dd11-b511-c5b9-d066c34842a8@amd.com>
Date: Tue, 14 Jan 2020 14:06:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1579024702-27996-3-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Tue, 14 Jan 2020 19:06:10 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eede4a67-2679-4a06-8891-08d79924d166
X-MS-TrafficTypeDiagnostic: DM6PR12MB2777:|DM6PR12MB2777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2777BD420CB19B7FB03ECA7FE5340@DM6PR12MB2777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(8936002)(5660300002)(66556008)(31696002)(6486002)(4326008)(478600001)(66946007)(66476007)(2906002)(53546011)(44832011)(36756003)(2616005)(52116002)(26005)(81156014)(8676002)(16526019)(31686004)(86362001)(16576012)(81166006)(36916002)(956004)(316002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2777;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/U5ne3jmJYUMjAgAk6VfWqifHz5Gd9uKwoF/rzJ75a/uDXv53Xh2C5ekm8LbZQ14SThzaZghX81SYx5aMODV/P+mBE849rrfz3TUsM3y3RvOaDhD7FoyY8qDk0DS1v1a08vt/MfMsx07zASPRjJ0wj2ZoSYWWXP7LJ81nIeNsKFNAlF4kowk4m1YnPm6zpQcsXhPhEPYRzBDQUMI4Ahh/UvXbQp9VJa1S5BAU71yGJWS2XkrcC7NNENqU/K1BhvKwFudaqAl6goKrOoiHlI+s9O+M9ff5tLvIT36WJjXurTQMYUORuA1mpeRKAeKamwVz4kivL6zTmi0CDYwfJDdAdta+CxoNOH9uyAJd0fTADuUBJ0HAbZ4HG8O/aAA63r+Ja5tCREufvnu1T2mW+T6Y5gOnFBBpwAI/nJKRDA44XNwNIYtyLDLemg5wdm661N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eede4a67-2679-4a06-8891-08d79924d166
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 19:06:10.9933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4MmTEV/FqQF+mQxysDEI9svMAKiYTuaxgSZ1hKm9m2/D0XTcnC6d1/dl71dMSr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
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

I think you can avoid the duplication, instead adding instance to 
"RREG32(WREG)_SOC15_DPG_MODE_2_0(offset, mask_en) ", just like adding 
instance to other part of the code.

Regards,

Leo


On 2020-01-14 12:58 p.m., James Zhu wrote:
> Add direct SRAM read and write MACRO for vcn2.5
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 26c6623..d3d75ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -127,6 +127,24 @@
>   		} 										\
>   	} while (0)
>   
> +#define RREG32_SOC15_DPG_MODE_2_5(inst_idx, offset, mask_en) 						\
> +	({											\
> +		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
> +			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
> +			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
> +			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
> +		RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA);					\
> +	})
> +
> +#define WREG32_SOC15_DPG_MODE_2_5(inst_idx, offset, value, mask_en, indirect)				\
> +	do {											\
> +		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
> +		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
> +			(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
> +			 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
> +			 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
> +	} while (0)
> +
>   enum engine_status_constants {
>   	UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON = 0x2AAAA0,
>   	UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON_2_0 = 0xAAAA0,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
