Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0924C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9536C20732
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bd7xG8Cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9536C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7496E156;
	Fri, 20 Mar 2020 14:41:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AEC6E156
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nipKBi0Rq1viF6V2WfaOeI3dz3As8pYEeGvpVpyvJFF4a1c3g1g9RpT/kMNDBSAFfVJxsqbvQx8U2hPDN/l1oMM4HpevXw6npOJpiQD8sUzus8semWd3fRenEC7OFvgz+hVl4je0JhAzUe/2qvdU4JI+WpfATV3r95xl1XHkLyeEXbOSxYu695adhPKWaNUu6ek6GNxgyhBVxdkVmXtjCQNldY7x0+hQbyl/XW9ixhh1j26cFX0ODD/t3A43w4EtLD7YHeimTbsx1zgDaMQ/fWiXQbiAL0G82ZM6qsY3/bVpi3BZxhs67u7xz++2a9S2sdFv+JWE2rkB8fD+XOycmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGeBQQTdK3pR86tRY+n8xN/upfJily9OhYZPRN3OI+c=;
 b=OEjzMOgn1XwBR3LaQSyYC6jkFaUjYcDWmOdsGds8sQUyiQXBxZGDfEQSycWC/cuT9leRgb4+TdXfvZu7MsH4G2XK6Kk/9uzfDhdsT1m39cKnrwjCsSfgmXg584whMYSY04LuzPf1HMD9QlzneBJzP5z0AjZyGXVVrhKcNkv1/cqXY0QbufH/8/pabppEFRwZccPko5J0IKst0pJ20e6krOPKHR4vURo2lKV5GEY+eujpxdXSNVgjcEXQn7GpwtUw4IKqZI0dZ5hqYHEMpN+DVyUjohQM5OMDogHKLYhzIkFml/dllIm7/edF/K6ojBlXcMAYa6TjpamAho02Of2vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGeBQQTdK3pR86tRY+n8xN/upfJily9OhYZPRN3OI+c=;
 b=bd7xG8CfNfVw0S8LBKosV7/elJe4JKE4IhslB1YhCfMOyCvuFjJekNu/ddDqyoPd0y/PA4k/6ZNxxqJDYcwlhioUfhzNzgqyLagq/x7ICry8nBUN+GxguCEzATKSboJH8xzEjfT9e1NcR0NjjjKvqZCrYuIoFty7m+XEKp7i74o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0044.namprd12.prod.outlook.com (2603:10b6:4:54::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 14:41:32 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 14:41:32 +0000
Subject: Re: [PATCH] drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200320002754.15133-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3efa7926-e6ee-f6d9-a75a-9d048a9d4587@amd.com>
Date: Fri, 20 Mar 2020 10:41:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200320002754.15133-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Fri, 20 Mar 2020 14:41:32 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 908f1bb2-7215-48ed-d1b5-08d7ccdcc881
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0044:|DM5PR1201MB0044:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00442419A53B0CAB9081071592F50@DM5PR1201MB0044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(2616005)(16526019)(16576012)(86362001)(478600001)(186003)(31686004)(2906002)(316002)(6486002)(66556008)(66476007)(5660300002)(66946007)(8676002)(53546011)(81156014)(31696002)(44832011)(956004)(8936002)(81166006)(52116002)(26005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0044;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQREMbXnh5exHAofO/gblZ8ilr4U1C3RJZEpT9u2T+iLjP2M/o70S75pJmVQ0V2m01T+d+y5R5OQ4Q2K4GYrCHPiTzNtN7oj426q2etk6/bSDhUIj0nz73eJ4zWyB1b6NhTqulvFomd61gaKWHPHHU7o3/c2T5eHyzAinDWCCx8oQfqewtaS3Nr+Zn0wCSNp/LmM9YC75ppPcQ5luYmqeGxgeCASEwRbFOnyrvV9+Pj5nACALKIslX7hAtRSav2mxnJVxaLehbqKrNKLmDgbP/zII+J7BYO6jRu3W6L86qNkNN7WIBnRYk4ijftlTpGk+mYG1do8fmi8N/9tGlEygZUpvmU5Pm/m3pNb8kPE548EqUfIBpUlzH6EfHkt9gQCNyeZ02t6JFUMFyfXYMW5mBh9Vr8sB/Y1VFzFjAFUhLRJWGeaoRThcBS5NZyZ0U48
X-MS-Exchange-AntiSpam-MessageData: kZUuS074g4oRRMPtaL/6kwA8hege7l/XXiEpAqfA1PcF8EE8bzQfjRIRQuX+w1fAZfgSD3HDE9UwpYJbe9vIqKg45klHJlX+QMy/iFMNeMjUpRkp+11HAtxmWXJos/LUzVjmWRGEqGPu2/qc194KFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908f1bb2-7215-48ed-d1b5-08d7ccdcc881
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:41:32.7415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsviDHEKs1FFsTaLt7q0mpL6/xy1ElcDF22a2AIUB9O+BNthkYesN5lGL+S61GQirjBRbZM1yXC1xrrGsAArhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0044
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

On 2020-03-19 20:27, Alex Sierra wrote:
> [Why]
> Previously these registers were set to 0. This was causing an
> infinite retry on the UTCL1 RB, preventing higher priority RB such as paging RB.
>
> [How]
> Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs on Arcturus.

Please update this description because the patch is no longer limited to 
Arcturus.

One more comment inline. With those fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index fc664ec6b5fd..09c08906046f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -115,17 +115,21 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
>   static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
>   	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
> +	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
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
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
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
> +	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
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
> @@ -2011,7 +2025,6 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
>   				      struct amdgpu_iv_entry *entry)
>   {
>   	uint32_t instance;
> -

This is an unrelated whitespace change. And I think this would cause 
checkpatch.pl to complain (missing blank line after declarations).


>   	DRM_DEBUG("IH: SDMA trap\n");
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>   	switch (entry->ring_id) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
