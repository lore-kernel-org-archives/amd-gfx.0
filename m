Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71FC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135D120730
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l3Jl5pAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135D120730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EFA6ED81;
	Thu, 16 Jan 2020 15:03:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D72E6ED81
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKwjKj/c1wQZ4s9tgM7xWgtMgdo5s04t056wvXyqQYDYjQgtZuUjLJ8J9teQwmZDP4eKiHlSyGzU5JLlB+a235gtlXkdZAsGokEL5btaooiMRNwthaxv9Od8jXHxITBrnZQNF5vrRW0od0y3OFEQ3bC/nrEJIdV5LTTlFf+v4YBugTFpdNcwOt5ODAO5HC6eG+tzOc1TmayyZo0TmsvhQpBXSn0/Ezg5lG1m/W/Fi76NotTHLTnqwMsYeCnytwZft1GPH6uKiXlwkTkbQ4w1BbJJycd7sxknaKHKtKMLpRFV2QSrTWZW7ri9f5V4OeE5Asqa4aDJUkVFywenkGBEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsuZl5ZSoG1ybjVPnI4no2tEJL0om0b4/4sr+P5g+nA=;
 b=kr83CEYP5SeiVCLmIylNMLYQ0z6FA9F83MUrABNugicL6983HMBX1+PWx5guP26GtHfRg03rgwhoIDe/Yyr43ttqaL8hPE+CzrORZM0zneQ+yizcz8bLnj1nSA1Qh2ZyTTzDcYIyc1FjmIcO/in+qETmotU2yV8ZDXjiWsGQN6oCfJYH1d7enWWUJ2VUeySTHg3oBOTmKCpoIW267xluvTG8S75mqRv57mtMCYL5ey8mHMRBz1hUBRm3ooYicOMtxCCWGFzfNJPAIGe8zecN5CJm+pptSITP2jTwl+o87BXwpmt7yLAheEzfOx/52bKEjxNQPQosZ6YlJnNu/aAg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsuZl5ZSoG1ybjVPnI4no2tEJL0om0b4/4sr+P5g+nA=;
 b=l3Jl5pAuFrVcq9qSfjRmWgZmkpcKJ3p9+8EmJK71svhxTnDeNsvOpizppu1QTnI4eJ6eeclWVcmwUp+RkekVcjYf/yn6cDFFrUMhMUXU8FcT8Ts3UUULBZvv52T/3ERDRFY7N8fbbpaLxwk/LNHNV6oD/LMTCRQ/8WUuEYYiMtc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2728.namprd12.prod.outlook.com (20.177.125.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 15:03:16 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 15:03:16 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix the instance loop and build warning
To: amd-gfx@lists.freedesktop.org
References: <20200116004508.26678-1-leo.liu@amd.com>
 <20200116004508.26678-2-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <3093425f-d18a-d7bb-0cd7-81dc6920c7a7@amd.com>
Date: Thu, 16 Jan 2020 10:03:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200116004508.26678-2-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 15:03:15 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb8585ca-96bd-485f-c920-08d79a953715
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27281E13643FB58F06633E6DE4360@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(2906002)(31686004)(6486002)(36916002)(52116002)(478600001)(5660300002)(8936002)(53546011)(36756003)(31696002)(26005)(186003)(81166006)(81156014)(66946007)(16526019)(66476007)(66556008)(956004)(2616005)(8676002)(316002)(16576012)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2728;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytE8lMl3MPEsbnL4g2XHhxb30Z/sKNL3/JJWBAdq40x9ACS80E1sOuhe0tb/4sQIYqZVuTkpVkiwzOpSR7aDRD6H08XV9JjIK7HSabsA6H6sF1PHytgSlnuOrg9QCLK0snpc/28Bopj7EnrKjQNJjSRujXCsbMD6wu8uqLxITDGOokbo5PMa0XQLrRo605QIU7JaFlWhdsM3kZOkk45SWGg1WEJ1lkP908JDy6BlX0f+yAOWrSzwL9Loi28zwVv9MLsY86Z452NUj71DfPwaPfbEgq3jkwJg7WdTVuMGdeRSn8v8I4JE/5wkhKDYLU6Fm9kT66yWX7lvF7CfnvxVMnMxlpLj4eyE6raR6DqEHlrWr1Jo45OHS+U8LT+HP4hzdfv4HLnlfVdJgsdKSJAglRvu4fe4cM9Rqg7FqRP4ZD6A0JSHve1GCUGnjWsABB+m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8585ca-96bd-485f-c920-08d79a953715
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 15:03:16.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EspQUKA0wR7lfsCKKq+INjbvPcMXmPgbb8fGfo3kk03EqHoRJynJKthnhc97vuY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series

James

On 2020-01-15 7:45 p.m., Leo Liu wrote:
> Fixes: 8ae1e132 "drm/amdgpu/vcn: support multiple instance direct SRAM read and write"
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index ab51f0e9539c..f96464e2c157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -193,9 +193,9 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
>   		if (adev->vcn.indirect_sram) {
> -			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
> -						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
> -						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
> +			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
> +						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
> +						  (void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
>   		}
>   		kvfree(adev->vcn.inst[j].saved_bo);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
