Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DFC4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 23:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2D922256
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 23:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B26Se/Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2D922256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996CD6E87A;
	Fri, 13 Nov 2020 23:15:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36F86E87A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 23:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX2WhoCRCJSwKXCxEq2bXr/c3LkO9P/UzOlfbk3DFazaHjEyhuzqwTEv1sjk6JrWRghTExaLg9CvcTT1Z5PC7ODP0bvPda8wie0y7uilwM6pGq0mfAK7r7RaRZBGF/akavgJ5QrnHTyXl4KkyYzSFtKrU4jhsAr7nvUP26U6wn14fym93izxLBb+VOSHzILFE1fnuzv6zNiQx9upri2BUu6TaifCz4Luf6MopCjm4EWybFHSBN5B3z08S83Uzdte6MxJGTOGBW5J4WskiGLIZoLYaCD/HFURdgOua75A5W5SUkY9bMkae6z2G9W13wJ4SFs/62kLjwWYJylO6Q6iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UVj3klHmZgu2iCqPjR+CM//MzSyLk/LD5JbdGvr3vc=;
 b=DRIlZlJYcQ/92ICTz/weey5sjUGLIRSn6Pgzkdb4MrgAZlWQ7mTMULLRtEOki6EQGUnIWq+fZK35GPIkoSG2fHMH6the3m1su3yA77Q57AOKUmg/EJ7e5k3gbxGf0ENtsseOChdBJNFKbl20F0MRxK7i3yq+xJ9LuwqpdRkGJQ1gAXIU52oW6B9gzj7ITsE0z+ylSiwHFpBfqx+wblqWo9TkP7lEp9xK7bcjNV/BzkW8Gn4KKAq86QNxp+CkluJmhGsaVQW5X2RjpJUtuX37G0zFilvaYgykuGTYjQnfrkFpkP7SByr5gc7T3eVDPSQW42zUjQT9/fNvpetUr2Jmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UVj3klHmZgu2iCqPjR+CM//MzSyLk/LD5JbdGvr3vc=;
 b=B26Se/JdByKCfmfm0hUtOkmF2qK6VuJkbe7o3axHmqYZP8gdFvXM2ghp4ZdkgL1nnHCkUXXzuidvBaxKG3qbx8dStOKX4Q6+UosM4H1Ej4lKFfE+Lk/jhKpcjCV9EsQCGqBER+rCZvpxMlsX/CTUJPR30ErYyGwSbCYFy2GARic=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 13 Nov
 2020 23:15:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3541.026; Fri, 13 Nov 2020
 23:15:36 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/powerplay/smu10: drop unused variable
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201113204037.978207-1-alexander.deucher@amd.com>
 <20201113204037.978207-2-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <5919a708-2e30-05a5-7d2d-3af85bcc8e56@amd.com>
Date: Fri, 13 Nov 2020 18:15:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201113204037.978207-2-alexander.deucher@amd.com>
Content-Language: en-GB
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 23:15:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb8383c3-4e24-492c-06d8-08d8882a06f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360D9ACC6D65C45DF7025C899E60@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4Jsn7A68+reHscaymc3UIgTdKBYLnkKKmPGDzY6uw97SiaCAJV5iCoOj2nT0zyF0h6hmWzUwJaebdzBJLDZBYgBG9LXzGilnm6qytC6r6Wit3R5FZXfgfqdERZHsTKXDbAibHH/o3Ao66KITOko7zCHUrrdmjIg53m+EOgGb58nsBLz84BLIMGEfmASIIBDt9MPng+qhy7pruN+K1mIXwXMm/HD1H8KakHIcRGNZEt1pmH6CjqbUr9lkEx4Gw4ssnjRvQ1w2oExa9/dJZJJ0H764nbdO7E1RlVjtUmlLGALtVW7uYhTDcD1tdzTd8LTkJxTBbNdAuhHxMBpLb/vTZIDjF9p7VSd2h2eJ4MKYYPN32leoj09xxlCsyAgMhXb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(186003)(16526019)(44832011)(6486002)(8676002)(4744005)(8936002)(66946007)(66556008)(52116002)(66476007)(4001150100001)(6506007)(53546011)(31686004)(36756003)(26005)(83380400001)(5660300002)(478600001)(956004)(316002)(2616005)(86362001)(2906002)(31696002)(4326008)(6512007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ngFCv4gQ0RchKk4atIyCbwB3XXw6T/BwDCGAfnVuLj8YLL1US0nauIzXMxPKML4Yk1MU2JSfzs9wSNqrJM58AgwcktXJwwRbF95+43B0o7X4ug4YseA47ODUnmrSwSL+IYBjbgBAvwVuIWaA09RexqT14xtVSoy8EGhxqwHbW1PkB6r2LTXu4Nzw/ZUbkmJvkWsH2+js8lvQislGzKSjE5yIkaVr5qW/Qd3G8SJZCIOOZ5qcZ6Z3nrAqRdGphgn5ky2PStPpZx18CZ2jnuBK9QySLkJn3sHr0G686BdLHaVv8uThJjU5/s5qNh/Dgtisml2SWLogC+5zexX0IaVXnUofyzaz30e7F2EFSuLUgGRRlsLTvcBlu8DUp5IEFe0hHMHz6mXGGqclQPzy7wg9pBdt1nTaN4/RRvtKT0Hlfb4yT4pe7lCvcn5axPtpfKAuz8Vg4eY4b1d0zVYpK5udwE18LcbFpHhaWYTyS7iOfC/ngXK7ZUjXzyQ/fmxLKrcS36Y0wFjLFA1oLO3fxWYloBwJw/J678/xbN5JEB61hujeP55aa3NFi3OTG2ctyjjTcvHtg/avPgIV+xie3CVzI6uQfiauaWKRLC9zeRUW/5VDDUc3oEHjKtlcrsIE8Av/92mNACRLqXYG2UMlF2c87Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8383c3-4e24-492c-06d8-08d8882a06f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 23:15:36.4349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au1RTzs3vdZgYXY56x0CDltnVFzStg/hXynMnbwDZZN+FmiMbvho9ydvOKtFv9jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the series:

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-11-13 3:40 p.m., Alex Deucher wrote:
> Never used so drop it.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 50308a5573e4..04226b1544e4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1441,8 +1441,6 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>  
>  static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
>  {
> -	struct amdgpu_device *adev = hwmgr->adev;
> -
>  	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
>  
>  	return 0;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
