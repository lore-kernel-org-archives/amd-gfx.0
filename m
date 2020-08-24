Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D74C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520A12078D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q4c7wewR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520A12078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5DA6E2D3;
	Mon, 24 Aug 2020 15:27:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0046E2D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 15:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB/dpJMmHOXtJeaD6g5zhyNvbH9/IUkkjK6Fqzos29ITYSicUee7WH1sVxyqdDb8bzlhZVFlBhzSIwXzCIyG6HIM0ByA0k64NSj1uQahGhk+++qPql55Ev9xHHMmeXWdLpWchXCRbF9QX3Wg7wQ7X7x5ZbBCnGkglgdg3E5JkJswAEopwdVxX4toDpWSbeuzj/HSzHpIGb4AfqyEuuGH2IAHdbimY/5R2X5btCZUHHPMsoXi6FfeY3vcl5t55W70B1yhrj580bL4LapsGFWAxf4VLWDMXt0mXaUxmfL2r+7Dp5xTJQS/dJ3/N7EGxXSOKUGCJ5HhwJd2vv4S7jpcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtwQKZuv7kCswKJp/I3p4XeoiFcmEr9CRn2PccSP+W0=;
 b=bgGxCqYbRxnTpMMzTU0TP67QZ3vCDUrshPvyYwQNq8+CjCE1yiM5Wz7DHhpyPaHTXEDQubgKmHZslouqQbIiw4Il4OzINP6LUh3l3wddlO1deqPPWIn1XH6bPusZzZGOnyNmNo1b5UigijX6EHiE8FiZDbegay07GNLEO29lt4msgausRpt7/kZvaMP/SX199/DRRmvRWjyBPoaJJBxVejxMEevN2miqzuMO44nTbUCPkqMlA1SQX9dk2v+AFgU7pvwCCQULHkUzuDa4y/Jl4hb/uuqPE3kCyTMITLpOaZ3hHtHujf4hOq+iy/mYJClCm/Xn8NtH5Q2NvJvFtqyxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtwQKZuv7kCswKJp/I3p4XeoiFcmEr9CRn2PccSP+W0=;
 b=q4c7wewRojV8qPJxSxfemO3M098h1XwWa2uX/+eqWdL/YRrvieWvjsWZqKFjfl84lnQw2QZDQ36Xvy43CzCib1oi/Lfg9Yce1oBhdlj2J4ZTC9kpQYqVLiwQVyJW3U8tkd5q8g0vAs/YYL5847M+dVcOf6mMH6YXrM87GBZK4GU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 15:27:31 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::2:7a78:c54b:7d47]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::2:7a78:c54b:7d47%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 15:27:31 +0000
Subject: Re: [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encoder
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20200824151112.4739-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e24174db-d9ef-169d-b8a7-9b18ae879b53@amd.com>
Date: Mon, 24 Aug 2020 11:27:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200824151112.4739-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 15:27:27 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f734fa26-97cc-46c3-909f-08d8484235ed
X-MS-TrafficTypeDiagnostic: BYAPR12MB3238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32388F26B7564FE83ABDDD9AEC560@BYAPR12MB3238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgWg48rVV+xPSk87gK+VBGHKwwQe+OawGut2Y3Nk4IHfi0cb8bOavWdcX0UK8EFlZDcgCwDFrK/fGySH7UjdeCeuCA5lxmp2UkQTxYXmm/F4wlfFyYCXg50BWJo6NAM2XfKjkNroVzIcbGv5XLIGTTbPMaAmDHUF2rq+65tdYplV9POn8rcsHHRKH/XVv9j+uAtShln5eKuiwEug2sH7j/jVq7D6GXN4f2ph3WWu9g1fJx5wRU6iRKcD38J/weoNnCey+qDP1qylkW2BpXdi02LaOLy4zDCBXnxT4TR3tSiotzeVi7ify0jhAZ1Pi9oGqpSL/mkDL5hSQNXaAnyngBDcyNpX1a88BAWgwxoaMqT5feS1FLBdC3X3hwshCAqz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(31696002)(66556008)(66476007)(2906002)(16576012)(186003)(26005)(316002)(66946007)(478600001)(8936002)(2616005)(956004)(8676002)(86362001)(4326008)(6486002)(31686004)(6636002)(36756003)(52116002)(83380400001)(53546011)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3oWX9sVRmTDn1JOp3ei0+bixpZtRVi0JcW7gnoO0mrjEwaAVuiiwV/TT+1ae5ZY6odrb+W1/sEbGeFMWUcYnPo++LJwdwpCBB59y/Ec540bldFAKCgcRpE3kL799oZWsgHZoIRf5kqq0tjfQ5mYIx4Vo5E3CYf5aVWKuyTAgi5Q5UzHwHuT/6qPxFGqPSGV7993PxZI2I7szlzvnWGpGldIetLQVP4+oV2qX4fUHNxB+AKQK+vioX6uZmCvp/G2ILgq7HAG7VRnC6T4/Ot8H/aVBR8APYobMllKfLqnctq4lDwy8j4Cr7gQB50hrgThHE80OBrWmq2wDjamFuzK/nK+7Q8z4+pEN/4fXo8asaDUPz24Fz+wWpX+PvYZuyquppPEoXIvp56+5WDnJVJ8Fj9qmrrhBkL1uEZOxKs/HhmkSEyuGeogbx8dY324BzFxKTMnRgLnF0HEdc2HkdOxtsoj7TSIcPssgtrPY5fWUzD0gvX4c393VivgdmShZPivIIyN0FSerHxLvW5m/pp+dVq+MNErG36CWh43bkpBpvlqWBVo517e0VN4YCzmUncwNqB7aExJN8n3vNIPUIczFuO+dyQ5ZpKAfZ3SBjCwVUwcK9vjNG+tJYBIihMalpjU0QXaXN0yqTX9frAmDV2J6bQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f734fa26-97cc-46c3-909f-08d8484235ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 15:27:31.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8ns1o1GRdNkKCRulN4Py06GekRnilrHlw90XKE9bZwi9R0RTQCv6VgtxmZgBvxuPzIB2/SS9TcYYD0KDBPKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3238
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
Cc: rodrigo.siqueira@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-24 11:11 a.m., Bhawanpreet Lakha wrote:
> dpcs reg are missing for dcn3 link encoder regs list, so add them.
> 
> Also remove
> DPCSTX_DEBUG_CONFIG and RDPCSTX_DEBUG_CONFIG as they are unused and
> cause compile errors for dcn3
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h | 2 --
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c     | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> index dcbf28dd72d4..864acd695cbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> @@ -231,8 +231,6 @@
>   	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
>   	SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
>   	SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
> -	SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
> -	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
>   	SR(RDPCSTX0_RDPCSTX_SCRATCH)
>   
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 957fc37b971e..8be4f21169d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -491,6 +491,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
>   [id] = {\
>   	LE_DCN3_REG_LIST(id), \
>   	UNIPHY_DCN2_REG_LIST(phyid), \
> +	DPCS_DCN2_REG_LIST(id), \
>   	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
>   }
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
