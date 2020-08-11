Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8812DC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980420716
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lpbay+ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4980420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EC56E512;
	Tue, 11 Aug 2020 14:02:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F04A6E512
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 14:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5ZVRn7C1Yy93/jJaeU6kMNgBdpDhBfgsFq5vOGoBaRos4wVnNOmQ5PregsH6F53C5xNofIQec6vZIZzmn5RI+r97nOkwQchjuVxpFI+D53vFuHecezWLUpQhk9Ph1by9oShXp6s58UNuV5oK4NcWAS1o/FrcCYoyFXIfAvbhFFdf2iKuPLqEWdVe4Op91EI+G1ZtzlsRJU4BHbDSoinRTMy03soAeI3xW/Pby3kQ28YAGlcKcWVkBDJEUTi5M8ihDKntVW0/abfufhR1JdhYghlJrrU4+GlgREMLR6YPTCgi/uaPbL5C1jPnU0GouUXCOUOAfdUKE805Sm54kYymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDl3jvxpcURL+D3NPjNVjaA0V4onnzK13+WO5o4Zs/s=;
 b=KclCFx2afOhIodjLOvggofC4O7/zINmQIVvs5AJXdipb4li0w7sml0gqNAv3flNR5Juo7E8oITFJKgebIwYbLaKNE5d6HmcNGkTZCOHD9Z48gPSvUtErS4pkUqEvNdVa2lIXkYR3PqUxPFCF9z0KIccb2FJ9iR1T9dd0iQuv03gnE4yjRkAaeXGrTi6FU6sH7+7M4BiTZL2M/hxc+XtPCENxJC3xmmEfaVcXaaz6cvR7WpEmmky6rsjBBsNqJ53W2TpHZsem6nJJbl1e9OxggK2QJm00X/sa8hlm7SQQrnC+BWIn3Kc8Y/qrvmw6CSqM7dcn0tDRXHt048oGhry3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDl3jvxpcURL+D3NPjNVjaA0V4onnzK13+WO5o4Zs/s=;
 b=Lpbay+aizVOW59ZuBFyN4tV32NqOnqawL8m7HMAhBvLHlOjqWkctevrzPgiOZKm8zSydAa3rDvPUL6TEuB6vcO8SLDBd4TxqEY/C+ilckq6hwu/UqgKDTeicA0k49QVhASw8/O4CEGNWMSh5q869399lUsnuSt8s14BrmDXgajQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1482.namprd12.prod.outlook.com (2603:10b6:4:a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Tue, 11 Aug 2020 14:02:29 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5%7]) with mapi id 15.20.3283.015; Tue, 11 Aug 2020
 14:02:29 +0000
Subject: Re: [PATCH] drm/amdkfd: fix the wrong sdma instance query for renoir
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200811062716.2927620-1-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9235547f-d1e7-c30d-746d-baa0ab34eee4@amd.com>
Date: Tue, 11 Aug 2020 10:02:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200811062716.2927620-1-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 14:02:28 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93de8f6f-a6bd-4f41-d101-08d83dff2f29
X-MS-TrafficTypeDiagnostic: DM5PR12MB1482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1482D8AED7AEE3990F783EF492450@DM5PR12MB1482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7E9dnewqPg0meu32Xsn6iHboXD7McwtaPqUgPTrVI5LRuAln01JLaecGDckevnhzTVFvGljdhq3rXPfisXfco6RhuQWHfb7sMPrkjbr7Y6uypU0+HHGoqHfXYuRqbasqV0ogeJnZplw/Zl6xafo0AvsXYUMx9Mlp4VtrYQ8PWI+2ynmd4w6b0PJRCgcH25bQEEyhaLvsBTUFEExM78WceevPbeqRXvIqvOnMf8TQhkaM3Li4x2uJvBG3M28hUIv6ItYlmp16I/N2HdpzOeEPwAEv1fxiwrNAeTdfqyiddW69XqT5h/BEPoi3sPb7R5DO3QYRxHaVFr4/+sjHtnU/St2Ioaw/keKV79U1MEDzD1aiFYLUPYWlTPJ9a0YYUX1P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(83380400001)(66946007)(8936002)(31686004)(44832011)(8676002)(66556008)(52116002)(66476007)(956004)(186003)(16526019)(2616005)(26005)(5660300002)(16576012)(2906002)(86362001)(31696002)(36756003)(6486002)(478600001)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4BmUss4fBaxUkz54W3TNs1qpA3smEIcQeld1IMxmbPouU2ZCQX0/+uLo/0S1DNhf57h2Oj0AaJa3MIgqLbVVvFv70+yI8+Zr7c6GZgyeMlForF46O2+K6S0j+bUbca1oYfNzuYHsZVGx4QaxEvPGI97CdQbAMJjZ7pORMdv1Zz/BC93LG5RO7Svp5aOWQNkxl7d21zykrB5pDF7YNYKdKUY62iaoQWo9+NWw/KIr3xvRLn5qGcESw5SPVGpo0NKSg0z6Io3HbH7PqQrBIswBBXayb1jGAYYz9FWSNGEkPOgpTZsqFpBtdeUyPQ7PCGKPpj566wAN7dySY57fUE2YLJBnxB3+NEIDcOS5PIwiarILctIqnebdO9EkadiczRASYVUc6dxBqtkeDYxs3EdaVvsTan82w2u7gOENOxSuISIY3+GluLwqsAzHJ4gbYIIlEmlu173HRzKqF1wtLjTY1yeFy2D+AXWbQhDbMmOl0l8laLd9SLAOqVCd5xgYvHsf89Q/J0TWePnX6lGVy89Q9/qaZh/Lsa00+6nsh2+/m7lvgQbQhXEUw2cuORbVEOOZ8yMDwU1j6zjaXGEgiMQatpYQfbna6VEY+NiKNNjmFROKdr//gUUTGOE7sl5+tfKuqQry2YIi5cUtZGmNCo0bVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93de8f6f-a6bd-4f41-d101-08d83dff2f29
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 14:02:29.1598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSfZXA8pYYYDQxKvatq/LWCS2JNwo6cAnNZxtt/D0ORJZPUPwQ73u5w6v9tFlh4l9kdI69eW7T203bGISmz+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1482
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-08-11 um 2:27 a.m. schrieb Huang Rui:
> Renoir only has one sdma instance, it will get failed once query the
> sdma1 registers. So use switch-case instead of static register array.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 31 +++++++++++++------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 032d3c866280..23ccfe0ad5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -197,19 +197,32 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
>  				unsigned int engine_id,
>  				unsigned int queue_id)
>  {
> -	uint32_t sdma_engine_reg_base[2] = {
> -		SOC15_REG_OFFSET(SDMA0, 0,
> -				 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL,
> -		SOC15_REG_OFFSET(SDMA1, 0,
> -				 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL
> -	};
> -	uint32_t retval = sdma_engine_reg_base[engine_id]
> +	uint32_t sdma_engine_reg_base = 0;
> +	uint32_t sdma_rlc_reg_offset;
> +
> +	switch (engine_id) {
> +	default:
> +		dev_warn(adev->dev,
> +			 "Invalid sdma engine id (%d), using engine id 0\n",
> +			 engine_id);
> +		/* fall through */

We should use "fallthrough;" here. See
2541f95c177dd578098313f92be67fc7f4d8e78f for reference.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	case 0:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
> +				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
> +		break;
> +	case 1:
> +		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
> +				mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
> +		break;
> +	}
> +
> +	sdma_rlc_reg_offset = sdma_engine_reg_base
>  		+ queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
>  
>  	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
> -			queue_id, retval);
> +		 queue_id, sdma_rlc_reg_offset);
>  
> -	return retval;
> +	return sdma_rlc_reg_offset;
>  }
>  
>  static inline struct v9_mqd *get_mqd(void *mqd)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
