Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE4DC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2445207FD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L4/DfTuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2445207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61508928B;
	Mon, 13 Jan 2020 16:24:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD448928B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHcP463ja8n1ct8z51zG4RIyaMNMg6hkZUJcwmBJSUYn9CMGdJY8yHy5tvIJBW8ZqS5YXZYy+BsulE0qH2oWUx/O4IqEmb8csxwMJRXJnonfJQ4cJBHYAtp4m97lzoj1v4HtdNN+jzMd2xuCddKCv2wH1Jibq/5itZ7gCFe9dIA121g8sQguqfElZXQ3pWsFsg3Li1xobXWHZWojTlnMtA26OAgm9OPBN7XqCuIo6LZNGbHE8LKt7qpQTgvYwJh9t4X6FJv4O30CGnnkKO5RV6G4Ou4M7gJvDnrVpcVIwKKI54MytIUQtObJK6RLNTPhydJkGWe2vk7EnY4urqOoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw/key5hmfhvlwKyisicHh9tkaEs8Fbo61N4a39TROE=;
 b=F4abrK6ZWhJODPxxNdp86e+hnGhf/1pey/9sjGcmX4sprePXHem7O4+j4AQN0eqfYeATjaCgDVLlK+W3+zf/AidykxLfPcXyg7MU7qFWzlJBABRzOznjz5queprgVDaOjGn5FD60JOYLk3ItKKhy1MJEB4NCySLyjZpraBEO1r8oiwyj8JtreRrgoGF+cQGMXRPL3PosXyy2EMgYtR1LtkrxcwPwZ43xHxqsJSTdfpu4s0uVUKJylAyKNAgbC1IxP9AuWPgnxvoliHWOlZ505Eb+D5ZWYFmAw66WVHiW6xmcgAYt88SqK3G9O5nfmnHm6guTaddlstqrHN4j/QvpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw/key5hmfhvlwKyisicHh9tkaEs8Fbo61N4a39TROE=;
 b=L4/DfTuGKHaZUsuUqlOkJ5xqePhsjV68yjYJjyQVXDSuX+ILtrQcQjdG5EJnAHMoefA0VWPpydEf1lDe2GK0iBmuM6auHcrjehX6Ngeb4ryuixpFLQZats174oIJZdDO6Q1774kurz2HRu2ClDclFHToh94awWqOaOuD84CXL78=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2491.namprd12.prod.outlook.com (10.172.91.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Mon, 13 Jan 2020 16:23:57 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:23:57 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in get_sdma_rlc_reg_offset
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200109045141.635589-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1324a3d0-ec1b-45e6-6fca-97d3e071e881@amd.com>
Date: Mon, 13 Jan 2020 11:23:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200109045141.635589-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Mon, 13 Jan 2020 16:23:57 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3aace3f7-efbf-4e2a-7942-08d79844fd5d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:|DM5PR1201MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491450DF0C20768C6767AC192350@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(26005)(31686004)(186003)(36916002)(8676002)(2906002)(81156014)(86362001)(81166006)(316002)(16576012)(5660300002)(53546011)(16526019)(36756003)(52116002)(37006003)(6862004)(66556008)(66476007)(66946007)(956004)(6486002)(8936002)(31696002)(44832011)(6636002)(478600001)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2491;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwwDM6Cf6q/QuOmsqw7tfvauuxtH9NzQgy8IylfJxsdXKTdOZy0wKV9GnQf8W4M65JtrMOmGvbyzQxAZz3gk+iafObU2bFd9iwuf9h6/eOcy+41TA2wmwHpaoxLssS+gDAc0xYEBcPwKYKrzZn/d7aHY7NXbmgRwudJAKAeOmEqoiVSRilhGkZWR88ipaF74DNvPCQGAZignOtaJj2b8bCP4UG5Cu62q0XseaJ74iYX3bHBk10/Lo18Rvfk3wpOK4s2NdiSVBardaBsPfMZ8FWaqHz/8yarV/KlSzQ3SNzgwSHtzlAzis4vp/TQAWFgtUmIsza3Jb2171JTtDTexWSU/s6KytvsWPFVxCxDC+J+aW+vmXdjfzlzz0qOjjrSjYNL1P3t4iDtYFSl9lebLgnhUSimbPfwg0G0WAff2Cpj/OHoJYekabZxMLVTcBkWm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aace3f7-efbf-4e2a-7942-08d79844fd5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:23:57.5202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMUpYK4qcVUaY4qqtw+tv/rpC8Eo6i5F7G2dSLZ+8Lhbe9LkmknkdTN4UMyh8pVqNeOWVaq6RkcswmFTV7846A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

On 2020-01-08 11:51 p.m., Alex Deucher wrote:
> If a user specifies a non-existant sdma instance,
> warn and return the offset for instance 0.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 2b26925623eb..1f9c6ef7567e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -75,6 +75,11 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
>   	uint32_t sdma_rlc_reg_offset;
>   
>   	switch (engine_id) {
> +	default:
> +		dev_warn(adev->dev,
> +			 "Invalid sdma engine id (%d), using engine id 0\n",
> +			 engine_id);
> +		/* fall through */
>   	case 0:
>   		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
>   				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
> @@ -107,8 +112,6 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
>   		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA7, 0,
>   				mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL;
>   		break;
> -	default:
> -		break;
>   	}
>   
>   	sdma_rlc_reg_offset = sdma_engine_reg_base
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
