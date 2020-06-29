Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D151C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 15:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D545325354
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 15:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n7Ty8g39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D545325354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A13089E39;
	Mon, 29 Jun 2020 15:40:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C4489B57
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 15:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKp1/VaPeI0dHWz8fe+91uwneRRHz9NCycMObOJJ6CiHB3P6k8YJC6nwoV278nImUzgSM/S81R4X3iMKNE/7uCZGaZn6Bh+WxlLiWh9GPeUs07kzCDBYiUzamDjTHesOojz4822OGETZMDFOCeT0fderfwvcPMsGHjGKDTGbcrH9BzjieY5graWO5fc+WTCPO1BU6lBVY7TSkuA47yvdZ0w/NmXn15akcMActIC7Q7nOMQvJ01yKZEl/bFEGCv/GXbLRo3nwIFNoMoaQUvgXrhFae+QtJDM2mjafpPLcqZLFRJPx0UhRKkIvTb+IZv4/lLijYGB1Ejsi5ylM6Y2goA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV63hUMwdB2IA1FZ85Ex1/rZAAcTqM995FzSwvJhdWk=;
 b=hQ2zDuqItzkh9I2yJMkDVwDeNWSRhh0NwhrxEKgVbyCDsi/8f4tuCwabgQdqO78BltDZHhZ1WCg5r1P857hfy7yu8Uh6E7L+GSEdqI9wFpsngZE9bgqeCEzdVjaGv1Vie2LMzEKCwXVdlXU4PJ82MC3iWMAbwximhawMw6PShoxOmkH9zkSksIvKvzCWRUQK4helDK/Su44uu5dGhZrtyNwdPY5zBiUJnMffIoXJ1nOz1XPBcbg5Nq8Dp5CKmhJGaILAb6GK4XoJMWtamzmtnCLMj8ZFUhgPmz65HGRU8UpSbMYY5urBjpS/HEwWBx3RdfKvzmjBja7ata4Ir6kMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV63hUMwdB2IA1FZ85Ex1/rZAAcTqM995FzSwvJhdWk=;
 b=n7Ty8g39akTNmttN9C/mzVFuG4np2WWQ9qGy0khBIRKeZmf0AxlxA0fEvGFVY4RlqKBLgH14nTH0bJLOZL45VXo49IWrZW6A7tvXO0MR32BdsLub4KwuZu7EMWvXCmHp8bTEUmYdoQ1IaXCu44Z8KBbcoXI5aNPHL6Ayq5qQcbQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 15:40:15 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 15:40:15 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: Revalidate bandwidth before
 commiting DC updates"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200629153652.101179-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <0af93aef-1173-58dd-f44a-5e2e36eba17c@amd.com>
Date: Mon, 29 Jun 2020 11:40:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200629153652.101179-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 15:40:14 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da6dcec3-a203-4896-50bc-08d81c42b79c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31926C5FC85EF827243A2D59EC6E0@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6m0/OeTpOTalFSYfUMiFWnLBBeFebia4hW40fq+k80asj4rO+5zDv06p//IbNsOGp/nEF4zx+Qz893Zw7xAknMF8dzepaJhy0wmujEH9KPqYOZWg2+u35FM8tkIzhmwq8u5D1X8Rtblc8vr9ITy5qD7yXCQvRLCodTZG9TS6Wr1F4IXcE73IfRhBid4tAAsagm0pAmM0ShueePpG5rff0QB+mcBc4ByraGjtYCxNhtLjJsX8eRNH0QaL6VmspJI7fufBgd2Q8D+5O1gQIMIE+dINkFmpJdFl0SNCc6+VisW8ZQ7P92ePDf6ZJDiya8SL8Nskr4QGSpMKsbuvknseGxImwaVguodENlBv2CrgTpVHghAtShfUsd/Z5lf6W9xM//XK/GAstXtCMWiJ4JqGC4SfNTC9QyWXpEn2r9zsmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(5660300002)(26005)(186003)(53546011)(16526019)(66476007)(31696002)(86362001)(2906002)(66946007)(66556008)(478600001)(966005)(956004)(8676002)(8936002)(4326008)(31686004)(6666004)(15650500001)(16576012)(316002)(2616005)(36756003)(83380400001)(52116002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5knzhr+HEh0HIRZVh9/ZBUebi6b+I4JwvX63C+cVE+1Q1t/pmdIccINa3MK0De7sStztt6rhpIxNtbMJdo0oGROXeYu+IooXPtjuMrQbdemv+QkyM5NP3M+JmhbSttUrMOh07szePzZdpdwEtt+w/rabeGA5Q3U4mub3Pj0E6CGy4mkevScgWfHglHXJQquA2OrlhTnJ9DzSsR6QN32AuI79eEM1Kcxp5V3yGgXt7XUdMjPlk6HzG1p8hNvZInsHYttudcHmHtbyfCxr63wshXcE/zLjYWggkoQG2kzhTp2Mzg8TktDk80KyvPTTTKj01fvZKPqmUJPOTyo2j5wu/BPIcnpA5lxVH0HCkgimjz0VmDkdejcGwwETNbRc9wpLQVgm0+j4MwCwdL0aozu4rNFGSeM1ZewstYo9PopAWHQa5i3EUUXy9TczBamfHoxDT04RPAY70AU1lIRz83zaE9dUT6m7O79XnvgewNlEbM+TmpR1FEQsaYwfAzF5Y57K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6dcec3-a203-4896-50bc-08d81c42b79c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 15:40:14.9637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JJtCRU8NLYAhmhjR5DDlpRdkPsLRtmvXKzh/MLyitGpiqnT3jIYx8I0LAGNNrY11GLf9KxfQ2F5nBOlD/AZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-29 11:36 a.m., Alex Deucher wrote:
> Seems to cause stability issues for some users.
> 
> This reverts commit a24eaa5c51255b344d5a321f1eeb3205f2775498.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1191
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I don't see the error in their log. How do we know this commit is 
actually causing the issue?

I don't really want to revert this commit because it means that we 
missed rejecting a commit during atomic check, meaning we're either 
going to get underflow on the screen or a pipe hang.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 67402d75e67e..94230bb3195d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2607,12 +2607,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   
>   	copy_stream_update_to_stream(dc, context, stream, stream_update);
>   
> -	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
> -		DC_ERROR("Mode validation failed for stream update!\n");
> -		dc_release_state(context);
> -		return;
> -	}
> -
>   	commit_planes_for_stream(
>   				dc,
>   				srf_updates,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
