Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0615C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2005206F1
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WvxsDsgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2005206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2786EA86;
	Fri, 27 Mar 2020 19:53:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2126EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh6oSwNw5EBudvkoAwXEw+oALGffeHVhfCVw9QZedilQp67iTOhVMm6zY/h/djYsQt0gkwVZXILokI4ezVo+quwPZRVw+LoeeAG8ISgCW8MeSO+W67bvDg7up5hCdDhF+sTVvLurhOBo/DbRXX+kPUl0TTeBRHHlyM6nm/6aBjGrQHtlKsGYKyEiYnpuayDXO1VNcBAsy/kjUVkwf/iEAlCf9iB6KnjHWhAmqD4s/hjavXxDYovibVvkj+IH5fQe1B3bC37jstUnsj02BRyxzjIfb8YSnB1oSUnLnFnJry9XHflEQkveCopqjkf2J5O+ZUxVcjdeF4v0qaKio39mAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53uhrrFfJnmY87UggF5njhMSz0vPzD1mTCsWP2pV+xU=;
 b=kMQGgRtvbLkD+6hvoTHIo2iO/cYXlHLtr+0GXysVMkj94kG4G4bc6z6RE5Xrjwjsa7kjhYj3xSZig4HcX1aeaEvwidfGMmrAxelDHiRR15Zo3Qj0Be+xObWR3vAhZUcVUiV76DeRnQdEeS4J/BnmEMgGnrXTnUfdUFMwn7wCviH0B0JjWMsntUB26jJoqKbHIiHd+DcatRpbszMe/LJlKen1pBpqDwDfcvYVUKcIUqwtzAdZqGGlofxwFRTef+HGN4R0EQXKjwZIpmVtLGs2QhiQlWT1e7MMKYMa6k+ov53gCAh1E+2FhMBeDCeo8UBPtG4AAf1D+8zR6vHR8vKKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53uhrrFfJnmY87UggF5njhMSz0vPzD1mTCsWP2pV+xU=;
 b=WvxsDsgRjap4SoP1dn4WDFWlYsLXRnOFu+wc5ZwN56A/Dmn8+ZdAiK58O3QvEqmeJZ3NGfUDM9hcR9kUyp1kySzC041hik/o/nrFwAjI6APxLgoj8Y73/XLOn+FNjyhwH+Kn6BqNw5wyW07+VeNH6Fy+3WdcQHEZzsJXVFG8sbA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 19:53:42 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 19:53:42 +0000
Subject: Re: [PATCH] drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200327193137.8099-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5a2a3764-d4fa-b283-bf57-6cb4e63a4500@amd.com>
Date: Fri, 27 Mar 2020 15:53:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200327193137.8099-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.81] (165.204.55.211) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 19:53:41 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e076af64-1297-4227-3dd6-08d7d2888cf6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:|SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542B77103DF7E0DE9E8BC8592CC0@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(5660300002)(31696002)(16576012)(66556008)(66946007)(8936002)(36756003)(316002)(16526019)(26005)(186003)(86362001)(2906002)(6486002)(81166006)(81156014)(8676002)(53546011)(478600001)(66476007)(956004)(44832011)(52116002)(2616005)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2542;
 H:SN1PR12MB2414.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T69f4UENgp4yffisyoy22bWCZbhO5GEPBPkj0o8zKy5jKANNhDS9vtxj7EHBbBvXg2VwovlNXu7ZAMIzwOKwG3/EqdVsHbe6HEG1Rm0G3biuweOxQOWvOKRAG3ztIZh2/25T47D8ogjK01kyuv5RMv9nCzECx0cSOpHpC1FirzkHzcEus7g7vkGcspTQclZt7funxM2sKVW8iReA4vJ7f07dwud8ZVH9ycPNuFZz2qKTZnbBQRY3L0tHDcH2a7VLnoFgiCkwWnBbfemFiF6T5jFEho4A4nC44ZZeMBT4PriHs6BTEWmUPk+9LbqlZYaMU4+NiKBe4+3QLhnEpF+TjOcXtBrSHbXnkpUOl7jX8Pa6MgUZtA+T4F0uamDEEf3iKvQVEOcfl5VCnIAwmSIUM5zthZvJ5a43/0npyxM7qUmccfTjNlAswXYdXi55/YRA
X-MS-Exchange-AntiSpam-MessageData: EU3zQ2DzygtLs0+oOkdFtdqPNBtrW6L3jW/zDBsbzW37x2apaHqU+okz8wNXNmJbogvN8x/VwD6z2HhOhQsy/LaByVyjXgKW+Acr2CzmNuMzFijNDX1gVjAEx2WsAfJ0MnDYaHfooHv0TVWhQhSrYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e076af64-1297-4227-3dd6-08d7d2888cf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:53:42.0736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbjWLtusU3l9JBdAHVW0iLiMl2rOeMtvwM16/g0M1XlV2jCtr0tTiwTz9q9jgGn8myt73t3KgUCpo/R81SFmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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

On 2020-03-27 15:31, Alex Sierra wrote:
> [Why]
> Previously these registers were set to 0. This was causing an
> infinite retry on the UTCL1 RB, preventing higher priority RB such as paging RB.
>
> [How]
> Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs on Vega10, Vega12,
> Vega20 and Arcturus.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 646e43c205b8..55ae4e6c4939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -115,17 +115,21 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
>   static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
> -	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002)
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   };
>   
>   static const struct soc15_reg_golden golden_settings_sdma_vg12[] = {
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
> -	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001)
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   };
>   
>   static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
> @@ -174,6 +178,7 @@ static const struct soc15_reg_golden golden_settings_sdma0_4_2[] =
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC7_RB_RPTR_ADDR_LO, 0xfffffffd, 0x00000001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   };
>   
>   static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
> @@ -203,6 +208,7 @@ static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC7_RB_RPTR_ADDR_LO, 0xfffffffd, 0x00000001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_PAGE, 0x000003ff, 0x000003c0),
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   };
>   
>   static const struct soc15_reg_golden golden_settings_sdma_rv1[] =
> @@ -222,27 +228,35 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
>   	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
>   	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
> -	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002)
> +	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_UTCL1_TIMEOUT, 0xffffffff, 0x00010001)
>   };
>   
>   static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
