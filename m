Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13449C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 21:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC49822527
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 21:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZC75ccX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC49822527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7705E6EB78;
	Mon, 27 Jan 2020 21:39:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA33A6EB78
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 21:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gojb1biZRfYBNpqcMtHdIN9VtQLZOYU0KZ7Y3mGkEuJUrkXZ0eaG0+4AI+/0S2OlIS3jMs2DyBRzezsvyDTskkXE+nmhZ8SpMLZtrZbZUVFN+ioBoYQbX7JgeRJMKCIs9AKnPKVARss1hOjs2j6Zb+d6iAz2luZmxgNIRo+M7/OcEPp+e059BVjwaHaoGNgr95T89C7KZJmxhLvRooPJUKpmnuP/ejV66T7dGyrPMN2tuAERDF/2Y7LALoaF4aL/32bGYU+Zw1d6cI7Wu7fKGOTI+D+LrAvi5Y7XyweBV2pOjHGYBpxlpey7pQXq0GFwvRkA+D/bLlg02QU3SpMjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCGXoP5RgYVO7n6mnS+sk7XCxE2zBNYk7kT3/USxWWc=;
 b=NDOA3UnEXhTJN+mrTKrjiI+2KOxkUhda8cYeW4pDVgVoR1MBEBJTHGxdvEm6GM2SNSNJ+NDTu+pdwTk9rlhDvy7aK6sAAWhpkPMePcw9Zb0kSojoMzxROLl3eFbvveWGNjWQJ37inrkY3AEt4Z3nawuojv57fWpdrKqT0tKZH+93zBNcVZT1/QERaRmPlYrF6kcgbSpRQK3oQt8AbudoMtNghIOdpci1mXtiajhVbA2T8IeoDIRmwS8jgrqwOOzSlIVDHyXyKbSyB8PcN2im+oycRZIhhHb04jPPMmEy2ZnvLO92DQUslvXVUtB47vN8cEcJrRufA3lO24vSnrutug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCGXoP5RgYVO7n6mnS+sk7XCxE2zBNYk7kT3/USxWWc=;
 b=wZC75ccXZfePcyaZL2tkCGtjFOst2yhEdH1HVEEMy377QKf8EKFg31JXWPao/XT0wLxbHFsGw78jF6VtjSmz06W2XKKXDebSPdBEbZ79JzqNZRPVKX2/RpYDBFP0EH43SMRGADtVPq1JqQgdFNWjt82yiikNln3CWaxfrng5Bc4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0124.namprd12.prod.outlook.com (10.174.108.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 21:39:42 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 21:39:42 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Enable DISABLE_BARRIER_WAITCNT for Arcturus
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200124233756.217565-1-Joseph.Greathouse@amd.com>
 <20200124234512.217961-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a83b0833-2570-f85d-f27f-f4a1ad87d199@amd.com>
Date: Mon, 27 Jan 2020 16:39:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200124234512.217961-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Mon, 27 Jan 2020 21:39:42 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adce5a51-c3ed-418d-43f0-08d7a3716b30
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0124:|DM5PR1201MB0124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0124D43D352856043D64C9A2920B0@DM5PR1201MB0124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(66946007)(66476007)(66556008)(36756003)(86362001)(6486002)(2616005)(2906002)(316002)(36916002)(8676002)(81166006)(81156014)(8936002)(26005)(16576012)(5660300002)(186003)(478600001)(31686004)(16526019)(53546011)(52116002)(44832011)(956004)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0124;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6FeqT5F8dQclPw+yj2et2Vkz1Lh5Uqr7rTqhaFXdwbzKTelFPK1woGh1KX1OENxhLyCq5zyjlC9f4sLcZi4bFdmue7b5G6iBlYWqjSEnEQpZnGMVS1BMppNczsz86zRy6IsldK+rXGBzShiw1GSyZDKgqsi62qr1V+BZK7yYyGDwEE8b4TQBC2VlTMNXanKpcD/4na77KIcn/u2EKwvS5baIqgTL1SbCzeRh9vPD0BW7qS123MPHZMJbjMyKnH2xj1YeaGWiDOhqlt0tnNYF8kRoTmLVKNtJXwnDGSBzOD2UHCvPrn0wYFIvdl8m/E8MAV8tLY/pTB8SxtnL+jQ9PkXL6a+EKE8rnuZx40L3fBbP6nMQTH+9ZTxXQ3RyzG/raUJ9jzH7Aka/iiGnwyJMBjvhCztQyRd431l+FUhN8DucshglQkg3tn3vhD1fozL
X-MS-Exchange-AntiSpam-MessageData: l1hoZXzlmg7LpPvOBpbGUYM8PEeB9Cwub0PxukAKe2NRNDhvZlv1MpihPN38gxXuUxTTDJbX7y6cDvW0ahlq3x5kvIjKup/rqsQv04RFM19/yrjGSLzMHIev16t+pvt7+XneeneTUC0IYaQkx8Oj+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adce5a51-c3ed-418d-43f0-08d7a3716b30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 21:39:42.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om2mkwLFWaaj6t3950T3w80BiI4Vil02CIkPM77XApvHUC12dk5H7TQ4xGdulX0a8YIrsk5QmFJ7xECPMxUnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0124
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

On 2020-01-24 6:45 p.m., Joseph Greathouse wrote:
> In previous gfx9 parts, S_BARRIER shader instructions are implicitly
> S_WAITCNT 0 instructions as well. This setting turns off that
> mechanism in Arcturus and beyond. With this, shaders must follow
> the ISA guide insofar as putting in explicit S_WAITCNT operations
> even after an S_BARRIER.
>
> v2: Fix patch title to list component
>
> Change-Id: I4f80d6bc0c795b62e1f71bbd09d063b7f75249fd
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 17 +++++++++++++++++
>   .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h    |  6 ++++--
>   2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 67ea6a9e13d9..ddde19f9d601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2441,6 +2441,22 @@ static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
> +{
> +	uint32_t tmp;
> +
> +	switch (adev->asic_type) {
> +	case CHIP_ARCTURUS:
> +		tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
> +		tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
> +					DISABLE_BARRIER_WAITCNT, 1);
> +		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
> +		break;
> +	default:
> +		break;
> +	};
> +}
> +
>   static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
>   {
>   	u32 tmp;
> @@ -2486,6 +2502,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
>   
>   	gfx_v9_0_init_compute_vmid(adev);
>   	gfx_v9_0_init_gds_vmid(adev);
> +	gfx_v9_0_init_sq_config(adev);
>   }
>   
>   static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> index c9e3f6d849a8..ea316d8dcb37 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> @@ -2060,7 +2060,8 @@
>   
>   // addressBlock: gc_sqdec
>   //SQ_CONFIG
> -#define SQ_CONFIG__UNUSED__SHIFT                                                                              0x0
> +#define SQ_CONFIG__DISABLE_BARRIER_WAITCNT__SHIFT                                                             0x0
> +#define SQ_CONFIG__UNUSED__SHIFT                                                                              0x1
>   #define SQ_CONFIG__OVERRIDE_ALU_BUSY__SHIFT                                                                   0x7
>   #define SQ_CONFIG__DEBUG_EN__SHIFT                                                                            0x8
>   #define SQ_CONFIG__DEBUG_SINGLE_MEMOP__SHIFT                                                                  0x9
> @@ -2079,7 +2080,8 @@
>   #define SQ_CONFIG__DISABLE_SP_REDUNDANT_THREAD_GATING__SHIFT                                                  0x1d
>   #define SQ_CONFIG__DISABLE_FLAT_SOFT_CLAUSE__SHIFT                                                            0x1e
>   #define SQ_CONFIG__DISABLE_MIMG_SOFT_CLAUSE__SHIFT                                                            0x1f
> -#define SQ_CONFIG__UNUSED_MASK                                                                                0x0000007FL
> +#define SQ_CONFIG__DISABLE_BARRIER_WAITCNT_MASK                                                               0x00000001L
> +#define SQ_CONFIG__UNUSED_MASK                                                                                0x0000007EL
>   #define SQ_CONFIG__OVERRIDE_ALU_BUSY_MASK                                                                     0x00000080L
>   #define SQ_CONFIG__DEBUG_EN_MASK                                                                              0x00000100L
>   #define SQ_CONFIG__DEBUG_SINGLE_MEMOP_MASK                                                                    0x00000200L
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
