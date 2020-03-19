Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77349C4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 15:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D3A20775
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JdnGXYwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D3A20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F41E6E178;
	Thu, 19 Mar 2020 15:35:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07E36E178
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 15:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It63OcVNb16Cx3pPuKLUt3lVc7U3jFsGfbNNy5qS2Tsd/PHHi82OKJWGlgHrK6DiDybs9j9mHUBPqc06ONu/93NRQPJepQclt+9YglDdh122wqLERBSaa1LIcBQPD6LZI60Gmzh5mFMZIp8uEZiSofC+UZMod5CKWOPYAzhk4q4FtfYxc6OiWeXC5C0uc6y5FF/eh/TjbGRxomJoQfiS5HrSCA4XcKaHzyXcQHW32++hMGtugxHb9KxnpnctnKR3UBOl57rrK203aU4MaC1s20yNf+MUHmzGJGbHp8l54VnNA46F6Q6pBB4sSQWHLWbthWvPZjPM85xr4c4SJoyCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG3mXYxt7gZAjlw0amFEcmO7Q4VyXewtyworzF16B6c=;
 b=i+wTiJmfd/euL1ZO6++favr54CfD4wRMrdB2H2TcmleL3uYmNkKn51wWYwF6UJ0DZTIlbVW50cqcULjQNr3cWsrPbdGtquxzAIJY801TTtWyIODrcQuHQNFe/CHuWa0cECZgBE/+7RaftH0m4oKucr6N0B0h2inCAYdATKr5VZ2oQ0QHxmAderB9QlOvzEPrVDuC9rX1Gme2KelVyld7HIl/blixWMkx+Hkeyqht3uIHt4EUuZm8HdVx7bEngiyOn3zd1iZK9So3bSFuEde/PDULI8bKs6fg4Oi1CpstgcwcLrSHeiD7PqzYpRsXyT+bUdkjWNIWxk7nPtzQomLdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG3mXYxt7gZAjlw0amFEcmO7Q4VyXewtyworzF16B6c=;
 b=JdnGXYwRQwfM7wwriH/BaLmMpEOJcolInH5+/+Rd3Q3pZPq/RRei/+ENHunRCN+VmWl3YXO9h43yDKHO26undWlh1XWHOwMfEG88wR3d8GwsclUkLcYlGUn5FK8YoV0PChcUBpwA+nxTuFxR4UKwJPrTPvq3utjmH8n83JvJfis=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 19 Mar
 2020 15:35:07 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::e4c2:1335:df65:2dbf]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::e4c2:1335:df65:2dbf%3]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 15:35:07 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200318233801.11866-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <1bc46651-ff1f-fcd0-cd9a-bdd01fcf75c7@amd.com>
Date: Thu, 19 Mar 2020 11:34:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200318233801.11866-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 15:35:06 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0047076a-d3a3-4306-91b4-08d7cc1b1a05
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:|MN2PR12MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41922E8064AAF64CD8BCB723E6F40@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(956004)(53546011)(52116002)(6486002)(81166006)(8936002)(16576012)(66556008)(8676002)(66946007)(81156014)(31696002)(31686004)(66476007)(316002)(2906002)(36756003)(2616005)(26005)(186003)(16526019)(6666004)(5660300002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4192;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58Nqwvs/66bPZfJc6uTH/ChwiyPAmoBssvB8N0Y2OMQzFehbMNjmyeozH6nQ5wld1edB+11RyzX9aX8kRh5O28azjTZUUpMDhwFiiS+fMEVjuiCrEk5qnUACFvhUCmE1mww1H0+kWtCDaOupA2X50vsSzAKMbehQkYJNIakiKH5tLnQRTPJCH+rk/NLcaVumJJDhgR1CIvGLhRla9UkemiRwfBhw1zBfZvdRtMMW2EpOjWi2jn7KWpHnEp2wvwJEYEiwWbXaRav+J9SXoSzwEp+JnujCuTZQD3UpwPLJ/T7eqzg5mmR3UpFnG5LuP0ifx1PbtY1w6SgZ4mkhRmI+KsJT9oO5OnSuRch3LHWZhm6zaZhDKm0UxHqu4FoNY782/YFSP5Z4WuDnuIYATVXclC/1S07KJALofJ1rBjolrZSlTMAnlxK14Lg7+HPHckpj
X-MS-Exchange-AntiSpam-MessageData: B8VwhlyrAFF/CO02p7moh/h3d//P2MS5Mheju8f4vGSX3vrdXIaCxrbf54ZVBmio4eTAxcAaf9hxRnq/A0vYZ8uU3RJzfMT767B8K14OpSJZfzSEwiCxLvv6GsAdwVQWrmKWeNxUnF9+qOnuBAzoyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0047076a-d3a3-4306-91b4-08d7cc1b1a05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 15:35:07.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TobC2tbLvAsLJrhO8qnzyZL2e8nHlO6D7hoBBu96l0FuzKWNbMVTv7sRqoTXZPmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

Can we do similar setting for vg10 to fix infinite retry?

Philip

On 2020-03-18 7:38 p.m., Alex Sierra wrote:
> [Why]
> Previously these registers were set to 0. This was causing an
> infinite retry on the UTCL1 RB, preventing higher priority RB such as paging RB.
>
> [How]
> Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs on Arcturus.
>
> Change-Id: I8a6d9b89ea115fb51ff694493c88b8972d6248a5
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index fc664ec6b5fd..94328162b6f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -222,27 +222,35 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
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
> @@ -2011,7 +2019,6 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
>   				      struct amdgpu_iv_entry *entry)
>   {
>   	uint32_t instance;
> -
>   	DRM_DEBUG("IH: SDMA trap\n");
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>   	switch (entry->ring_id) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
