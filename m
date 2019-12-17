Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC49C2D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEDB2146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mAqVgWaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEDB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9351C89A8B;
	Tue, 17 Dec 2019 20:50:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39B389A8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 20:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjWdnl1b8GJAsQ6NRU9BRu+hbedoB2VYm6YKfiA7oQOPj/09i7GhN/4X6jRGyWqR9PdQ/ZNYO0e5LaMyptxQZ96g0pY3b+iyBqsqcR6BZ4cW7GFz6ibmi13i69bf95cjDRDnRvmgPuQb913vQryxvOTmfA8+Zpo22VH9PuO3W5hutYtEKkyPx8fYH50zhNUtmpYVz3a3ynrcYrob1DtuqaWkojyowwW/wYVJMiW7jOhJ38UXQUIIPYjSbUXeyNUCEHso6x3vnP+bwxxLMsCIcavtlt0VylcTI0/gzECkmIMhXmk74jTrJ1hlm02BC3J2Ot+8jyOoGAHxleeZbx0zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuEeB54qQiHix0+uP7xKPIjzg8TcDWUkeuvA6eT7b1k=;
 b=YyWd6VP30uoAJt4mTT77ooRaWfEoyMEOw+qiONTEdVMwZijcpKT+Hn8RaueV9zE6iVDOSdH/9f1MALUWvfQVepNGYXINw7Wq4qzeO5EYUgDZa08Ut6p+dD0O2dhkeY1m3/2Xp3J8H5lR6LSOPVJ7QZ9xlyIQEMXEs5VZq+XpxMyvITS1vnO+IqbQywrNfv7cdBCP/A4S2UIKdbAOhiCMaVba4ZyLXVAWAhoSwbiZtk883fT0JbW+XRmqnrY7c4C6RxR5WawQxMiw/mfu0uIreVwkMxtjO56odHrSv4izCcGPyFoEAeua86QFtgve9uM2cF9N2S/0alCxorCAz84Jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuEeB54qQiHix0+uP7xKPIjzg8TcDWUkeuvA6eT7b1k=;
 b=mAqVgWaATRl+NRKw4T1qDzyuM5lQkF2kHBKaerQP1FiGM91cWQWk8xG0mA+8Rl8TDxjkhFLXP4wrmY5Hug3I1h+Ka06L5cHxBx25MfDlwyYZveCBXZ0NcfPME3FQb5OiRpcbYT4AebFL4ZOlFUsussumFzAuKyKPRx93KkOO5h8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3461.namprd12.prod.outlook.com (20.178.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 20:50:05 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 20:50:05 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/display: include delay.h
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191217204707.2258744-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <ba02cdd4-5138-7f86-1d53-6819938b58dc@amd.com>
Date: Tue, 17 Dec 2019 15:50:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191217204707.2258744-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a8b5393-2d0e-4853-ac9d-08d78332b1b4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3461:|BYAPR12MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3461BF1738F458042CF1B368EC500@BYAPR12MB3461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(54094003)(189003)(199004)(8936002)(66556008)(66476007)(2906002)(478600001)(5660300002)(66946007)(31696002)(4326008)(26005)(86362001)(52116002)(2616005)(316002)(6512007)(4001150100001)(6486002)(186003)(6666004)(36756003)(31686004)(8676002)(53546011)(81156014)(81166006)(6506007)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3461;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfpQ9Prnie/uh6zh48TQorC08fqPb7MphtZjHhauDpUusacEizTsqzko0chnEQaxax0EWw/NAkgQ6nXiLRVz4g/t/8oqnjcEWEJwtvM1wNrSBHsg+fy9ev6AAinc1fS7yhr9ernCNObMnvLRfrsO031vfLabF7tRajrrDFBMzXSrH0mAz0ZHZFjHkIImBrYTVmmgUYAD630wtghYdQnG1je5KY1vdHnBPPkYlyXj/cyov7U7e0MgCYeq8hu7l7nCUGZQ5AZnkffu2IvwCsfAiZqwwNkwUi6PDDc5vxKofrRA4EYDdfw7XeTAhFoQkrvHe4YnQcu4kpEEyVIyYVyfGLdAjSWl0CW9tqmHR6EhYntvVw1a6C/K4mKmJK/nfeuCTm0qMRC6tQ7Mptzwbt09KlIHOB9LAH7qC7OfWNR8Z1UeDX/eZmTT+xislAOu/OuPragA4GnixqJ8H18thQmj+YCP/14QnFR85Y7fGJStnvHGof+7IJWXgK5B3ZI7nMMH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8b5393-2d0e-4853-ac9d-08d78332b1b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 20:50:05.1484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmVrBq0IogwdntDh8kTbjXwREgwstc9k21o0fU9rEMBo+NBNcWgH0xDbTbqCA+6CMoQgQJDO/+t3WCBu0vNlqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
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

On 2019-12-17 3:47 p.m., Alex Deucher wrote:
> For udelay.  This is needed for some platforms.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazluaskas@amd.om>

I wonder if it makes more sense to include this in os_types.h to avoid 
these errors in the future.

Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> index 110c8620907b..bcbc0b8a9aa0 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> @@ -23,6 +23,8 @@
>    *
>    */
>   
> +#include <linux/delay.h>
> +
>   #include "hdcp.h"
>   
>   static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp *hdcp)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
