Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6552FC2D0E5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C4A20733
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SQnA7oxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C4A20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39B289FD3;
	Mon, 30 Mar 2020 13:11:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C48589FD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 13:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTMWTJh23oidlIUOIxaBxz8XPi4f1Cj4eDC0sMSaHgisGaayqsZ+IEIuMxHoOTraxD9Rbeiven2ZUJRMt+QOrKeCSP5pKWjiaTdtm2uBP6appXv7ASYTHATM3H+/po+R0b+2h04hf7bo8ufFqIjCWIf9iRpeu74q/VkeSkJfwm4TvuFhWfwGOt3uXwKKjVpWRnj0EF+ZCohWaqHhzcIvktN3/r4Bn4mGUAE+BERd4D1jzWtzPS+UdveJbs6DznvMt/k3j+yZVfXUnVcLYHseYV5Cx25wV84Gqmb34U17u2RZzLNBGwcLn6z2uCB42Fun02LGeiH9Iy8B2s4ldLMT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1ucDvEcuPanf+6A3jNjSeG7nLbodzPU0nz6RjA95LM=;
 b=XpDM/DDYxJgDBBF7PCnfB7Y40eeGoGWiNvOX/FVyCXqwjePijUXQrYC2zlOWzYA3m8vHrw2aueHlKP9qi0LfWEYo9HgbIHJbq2/GGFCtYVoU15rg4rmwjH0ZSbXdB0p2hWhzaZt+A6CBaC3I0KHWn1m4Q9pn9pcICpNC1VsIuKmjiZAAn9L/1Q/DZScrnZiUD+a7QpU0LDg1taahsHNvEgQXEDlXOgIcPnPm8GiiZYLP/bNeaqUHuJDQa7qnKvKVwMcrthH2Pu2amren9CioN3j0tqLTI1ay0U9zprwyYp8UhDPzfiPurB8t8VTdApEW3gTa3moMaEUgk/mBhGWA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1ucDvEcuPanf+6A3jNjSeG7nLbodzPU0nz6RjA95LM=;
 b=SQnA7oxDEynab8+wBK4wTmna2zNPKDfWPpNM3LsZGweIXS20rCrRsjgNC9RrVHnylpx11Jxxa2p5LA6nzJEvgpu6PxV85w++OK59ZWYpVDuNESk6LUXZGR96g0n6Jb9YGLEH29bRZxpUh/OzEjskNDO/4HklvPzpkhEXvqz+0eg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 13:11:20 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Mon, 30 Mar 2020
 13:11:20 +0000
Subject: Re: [PATCH] drm/amd/display: add basic atomic check for cursor plane
To: Simon Ser <contact@emersion.fr>
References: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
 <83db678a-a5d2-cf64-65f0-8fece62b2fbd@amd.com>
 <7EkixViMkOWZ8AEOpjSPCtfus4Fq2LWBmsk71_0nAC00BVKDIg7iao_0I2PIQp9Z3_jrQ5cglhuYKkq5CQnuLRunzg4pirlkY6hH3At1gww=@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <8d67af72-a3c0-65a7-2115-5f068ccbfc23@amd.com>
Date: Mon, 30 Mar 2020 09:11:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <7EkixViMkOWZ8AEOpjSPCtfus4Fq2LWBmsk71_0nAC00BVKDIg7iao_0I2PIQp9Z3_jrQ5cglhuYKkq5CQnuLRunzg4pirlkY6hH3At1gww=@emersion.fr>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.38.12] (165.204.54.211) by
 YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Mon, 30 Mar 2020 13:11:19 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ebf0f50-d626-42cb-6694-08d7d4abd6ae
X-MS-TrafficTypeDiagnostic: BYAPR12MB2886:|BYAPR12MB2886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2886F24E7A94DB7F615891A3ECCB0@BYAPR12MB2886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(16526019)(53546011)(6916009)(186003)(5660300002)(86362001)(52116002)(4326008)(31686004)(4744005)(31696002)(26005)(2616005)(66946007)(316002)(956004)(8936002)(66476007)(66556008)(2906002)(81156014)(8676002)(36756003)(478600001)(81166006)(16576012)(54906003)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flXxCQRD1yysWJ3ta09my+lSc1/z7V0jbUsUQ4deSO8DsnrQoLrw6firbemhCCUbbHBlrgtab4vfXTWxVYw1ojl4NRYAUIRTCX3ktpT2sbUT+2tNjtmDp/GN2V1GkfbZNKRopqRNWfoYcmgj1MK1a89Hf5YwAyTmT6s2b+pdAaoWY/4UgH1oOr+pAZZ9TKLxe7SbMVPtzAH0rkjFGHwMw3+xOvSIdDIMxqluOEYbOloWBTvgkpPOhR4u1AfGMur2yQRB1/H0gAHjU+quoerJ98Na/L8C/XdveOyyocK3/eqYAgWOyUNdZUShZmhijuCItu0yQTr6y7ShB8mSg9pO1XGLjsOTW76iRyjSlTiKAVBFTCOwc2Zs1oXownk0KQaY3ZMZL+mxOIggYT2MLZf2f8Dtk11hqV8vuB3r+ONIS87I1aqOcmbLmg7F7mf4k1LV
X-MS-Exchange-AntiSpam-MessageData: Gg4ZWASl0zvXQ0ojw+fl4HwQLVZ2SIBILsJ1xJNBdhIgBNJPkQtPRaUklBd4BMPjCt/SEzGFNIaBZXBneKJ5vguguWg9K7l95Gkz5Xt8oXpqjJrByY+57uGBHhdNRFWOOGWUJpPpNyHJgiYHulk+Ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebf0f50-d626-42cb-6694-08d7d4abd6ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 13:11:20.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmSzZSzJ/L4X+ud4nTUWwGLyQhUstq7pqUkwbxLzPJFqHJnZd0+2msY2HFei5S00ieGy2cHceCxA9ppl85XcMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
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

On 2020-03-30 9:02 a.m., Simon Ser wrote:
> On Monday, March 30, 2020 2:59 PM, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:
> 
>> We've been doing these checks for position before but I don't think we
>> really need them. DC should be disabling the cursor when we ask for a
>> position completely off the screen.
>>
>> I think that's better than rejecting the commit entirely at least.
> 
> I agree DC should be disabling the cursor in this case, however that's
> not yet implemented right? I think implementing this feature is
> orthogonal and should be done in a separate patch.
> 
> This patch simply copies over the cursor checks in the atomic check
> function.
> 

It's implemented on DCN but I don't remember if we're doing it on DCE.

I guess the drop can be in a separate patch.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
