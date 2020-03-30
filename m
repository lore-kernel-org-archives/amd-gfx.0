Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21194C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2145206F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SMuX/hrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2145206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B34B6E41F;
	Mon, 30 Mar 2020 15:18:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8996E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 15:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ+L6t99e54cRFIDTsOdQSVUsXAE5QaGp2x6xW2UgT8PKy2k6SkOTJj3FNByBdhbJUMPe81f3/q91s7usUElI1/x8ZVTZ2Ga9W6YQMpPr8n8TGazbwU2DkM3Fhd363x2MQ4Xz+Y57alXpF9oX2DjTx8IQKrsj93cN1zal5p3EZj0jbsPAeIClLY9oRXG4pSEj19hYaINCv5ydIoUFMq5DFs1KBp6ccwZnIaM1UWWZrEbHfEBwXR2oN5826xi81nPEK2ST+m9JiUlUzJZCnB0SQQMzryJFkNnIh0XE2kbFYSrIjfPdzV8af1G855W1jqTj2r+3q4JV2X+kWmIX1LECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBiRjMpHM+JMtHHb6dmX6CSuK/U/+XpGq/PUiCIlt8w=;
 b=DevANv9e8gAQheXduJrsoCNoyc7paeEjLz2Dy6Rxd7LKq4vsptm24cNio2eyxWj10iSOdegAwnLMcry/UscUcU9EDY/igM3jFPc/wWQoIFNacs8L4uP7/8KHwSDmQEKFdOBbsQwocnM44LFU1+LwIi5ygLN/adHOi7wJUYJpSfV1d2ffT6ibC2X4aQhe+T1VQjbBSndtRkLxO0D0dqO5Rx9EZtptrhC7VrJgLblAQieCABdIQ5dWU2ChGU1kjV5gXfAe+NpcgMB0W0BaefMrMHHLfKdUGr/JgW97Ghi2xQdClYXK/SkHPpE80i807fSiJqBoRNOw/FkrMTmct/b8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBiRjMpHM+JMtHHb6dmX6CSuK/U/+XpGq/PUiCIlt8w=;
 b=SMuX/hrE58u+BAakdSZk+U8svGwuKxBr2FRfuoKJiqGUukjxALjlkwaUfe/g9GoQ3baRhy0BcU0jvHev21jjCRjuv1g+pZRNg3dFdfOH22eRYkE/ukVqsNrhuNGv/MN/fO/ASfBhhJexubVKpQ12IE57R2WSnRUDOg6UbSlZCnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3559.namprd12.prod.outlook.com (2603:10b6:a03:d9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.23; Mon, 30 Mar
 2020 15:18:22 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Mon, 30 Mar 2020
 15:18:22 +0000
Subject: Re: [PATCH] drm/amd/display: add basic atomic check for cursor plane
To: Simon Ser <contact@emersion.fr>
References: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
 <83db678a-a5d2-cf64-65f0-8fece62b2fbd@amd.com>
 <7EkixViMkOWZ8AEOpjSPCtfus4Fq2LWBmsk71_0nAC00BVKDIg7iao_0I2PIQp9Z3_jrQ5cglhuYKkq5CQnuLRunzg4pirlkY6hH3At1gww=@emersion.fr>
 <8d67af72-a3c0-65a7-2115-5f068ccbfc23@amd.com>
 <B9sWqLzmtdeSGNQnGEhg8RkGpHRGD0eRxKboCjMgkhR5ZVtLdlEIzoKBWfFnnX0p4Dvl8Chdd68eKpXTtccnAA4a2xeHq2cnHHqg0sv6zGc=@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <c35a8999-f46d-f410-729f-249646d1e36c@amd.com>
Date: Mon, 30 Mar 2020 11:18:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <B9sWqLzmtdeSGNQnGEhg8RkGpHRGD0eRxKboCjMgkhR5ZVtLdlEIzoKBWfFnnX0p4Dvl8Chdd68eKpXTtccnAA4a2xeHq2cnHHqg0sv6zGc=@emersion.fr>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Mon, 30 Mar 2020 15:18:20 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fab84859-a2c7-4478-f801-08d7d4bd9563
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:|BYAPR12MB3559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB355905D1EFEF7E3D7D992573ECCB0@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(6916009)(31696002)(2616005)(86362001)(26005)(4326008)(31686004)(2906002)(54906003)(186003)(478600001)(16526019)(52116002)(956004)(316002)(5660300002)(81156014)(36756003)(8936002)(6486002)(66946007)(16576012)(53546011)(81166006)(66476007)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/8xqQRnF/ZwD5zjfkGs7tpFOkzsO7+ej+jg6KyqMzL8HjU+T1rdkzT69/G6iGXYzvRZBtFZY1fr85XwL5vfrU7OEj3NsY0Yzjm+sMsZCi7FMiEIjw+xgXBeRT3+WNT1rnkdysAAC4lNqjmpCdhZTDgeAhWpf+r0rcyPXkDd1NTePwGdWCt3OMK8yqhsU1SdKGhUUedK5NCPJiCbjmCNnOjogeEq1lQ4Wm/YmgcPt+NbkGMKuG68HSxsDwu+5D76bWgRawgxG3TzoxoKp6JkRIUNb/5uRDKUr+Obbqw3nrpwVk7ri4UPDcBa4YAe5QGawUlaECq5/tn8Mlhu+sqmstTSp0QImSjn/klTR9CBpzoOy+oDyV04ougmB81E3NTEiCmoHdP6VtnzlP24nyaABaYeUWzkPpbSpjKM5VttSqLzQK/0u9kLK3Dp+y2MqpM7
X-MS-Exchange-AntiSpam-MessageData: /XHkowGB++Jo2AIWtXL9IBsoQoY1J/tIedyRJ2bcWpE1U53XaQ0OGBI2gfoCO0+ld37tGWLuSl6eydYPNM0YC3VToG+dWY37vHQvlI+r41I1XHpWU8pGjB9C0RLa3iuP5xFa2u0SdtjEftqqjkwO9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab84859-a2c7-4478-f801-08d7d4bd9563
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:18:21.9287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsfZa67+SJ7R6VmiDA3uw82UVn2Aan4QI5f3jpp1hmCrNepuDx2xwNQhyCbSmsur9G7UPRXrvYFY+T8Tj5qQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Roman Gilg <subdiff@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-30 9:13 a.m., Simon Ser wrote:
> On Monday, March 30, 2020 3:11 PM, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:
> 
>> On 2020-03-30 9:02 a.m., Simon Ser wrote:
>>
>>> On Monday, March 30, 2020 2:59 PM, Kazlauskas, Nicholas nicholas.kazlauskas@amd.com wrote:
>>>
>>>> We've been doing these checks for position before but I don't think we
>>>> really need them. DC should be disabling the cursor when we ask for a
>>>> position completely off the screen.
>>>> I think that's better than rejecting the commit entirely at least.
>>>
>>> I agree DC should be disabling the cursor in this case, however that's
>>> not yet implemented right? I think implementing this feature is
>>> orthogonal and should be done in a separate patch.
>>> This patch simply copies over the cursor checks in the atomic check
>>> function.
>>
>> It's implemented on DCN but I don't remember if we're doing it on DCE.
>>
>> I guess the drop can be in a separate patch.
>>
>> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> Thanks for the review. I'll try to figure out whether we can drop this
> check (from both the atomic check and the other existing check).
> 

Oh, this was actually the checks for crtc_w/crtc_h. Not the x/y, my bad.

We probably can't drop this from here, but we can drop it from 
get_cursor_position after this patch - since it's now in the atomic check.

Thanks,
Nicholas Kazlauskas
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
