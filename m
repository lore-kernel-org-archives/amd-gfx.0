Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB8CC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 21:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCBC2080A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 21:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GTsc9R0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCBC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2DE6E542;
	Mon,  6 Jan 2020 21:39:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEEA6E542
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 21:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA/QE0FmBmNk+uKcsTxXy05dNQ7iOklTLT/0Ua3t6DrkY38EWur5ovO007Cbdm4MecNSFLyRZk2vkN6aqNNNqfID4yV2LHg3lluZOGfbldlgVDmEsiYHtNKdT5OtSrioXtJqP0QEzSL38NG7BW2FuVQXWdLKTt3rsgv9hn49jeecjLAlbodJQN2vLIleXeie7jbAnEzFCLk52JJRzGQZVhcqK0OLLxxc2PZe79OrlXE2EJB78U+CzOOdQgWJVNtejnZj9UVdkt20jeTKRwyJG+Kzj/EzTsdp0qSJHZredvys/khGz0RQVyXXZxnlVHHMFWTlPgfJy77qEnzADoUDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq0/BCiKNkjctECIRlREXg5epgR6siTbXMVOlqHFvl0=;
 b=FA2s+jsFYg8lJIjDndA3h+Rhn5Qz7ciPz/WjAfY+vse4++1ytMKwLTsMcbdPXf8SMexXLn8K1Gnj9ZP+3g8K5nGNw+LjK2SeXbNveNM5diETgvhJ7x2WajB20ysItxBEn2+mdzcv2sujGZrJ0m+8Ew7D6naCNE9O7Hpqc3cC+/N2N8RlceEUrAgQfpMNpdbDZ1HNaPflHiktkeJlsgPKWHcrHbimbOPhr6Kx77EkTLFRK2PuQKOUM7DGj2LZw8UBEFE7vXziL1tytxiqOsMQhZdy2RKh6TaBcpd1xt8lltOILHDyL8pwREc/Oq/Y1aFhYygy60zhzvXDKeIL+FGq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq0/BCiKNkjctECIRlREXg5epgR6siTbXMVOlqHFvl0=;
 b=GTsc9R0ujsumonf0Lou0o2cPMf0VKDPaGbpGoPudnbDE1AQZNOu8p2GvvgVQNU3kfO58HlCK+1BSZ8I0uJMp2MaMtISd+dBfeWRZ/dcokSEJwX6PcSYfiiAgoF5wUJGLqx6bJhWJX1jsc0wxBWmB8mZYkZ0t8ALZUKoOrpmT8Bc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2552.namprd12.prod.outlook.com (10.172.87.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Mon, 6 Jan 2020 21:39:43 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 21:39:43 +0000
Subject: Re: [PATCH] Revert "drm/amdgpu: Set no-retry as default."
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200106204553.917237-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <699db33c-83b6-121e-082c-c62da24261c5@amd.com>
Date: Mon, 6 Jan 2020 16:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200106204553.917237-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 21:39:43 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1feb9f74-9bbd-43ec-fd3c-08d792f0f11a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2552:|DM5PR1201MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2552BCE4124A66B40186E4EA923C0@DM5PR1201MB2552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(189003)(81156014)(8676002)(81166006)(44832011)(6636002)(6486002)(66946007)(66556008)(66476007)(31696002)(26005)(52116002)(6862004)(5660300002)(86362001)(966005)(956004)(31686004)(16526019)(316002)(37006003)(36756003)(8936002)(16576012)(53546011)(36916002)(186003)(2906002)(2616005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2552;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tS6JdBWEnoGcMkVHddbvCfOG46JkygFO8w+86UtIKbbO2r/Pgv2wwLzM7cQvvZ9ZcAmHIbJ1ygToCS2baYeTZ5qUvEOyWjXPKggb8mH05lRKrtpSGwFGEvbabm8CprAm1Lc9NJaEAfEnJNVjPBUzxb6EB/QOfFt20eMz1vPtqy0+93mBx2q39otwd3ctS1whV8O3O7CrTooPZaXo7UVlL92mqEi7dty5GnJJzSgysgc3nWTmNB7VNcGa9VGIyvTdZstSF7pwci/+Fksclfn8LcSt1x/2FMYSlSH3dIZe/qoS7lNpf+7jddwzZ7Gtf/thymSF2zGBmix5VdEVr9mapScPJLkrZQm4eR+gm8AblNAgQT2b+QwGA5BL7f8sHmr3dB03JelWH/CkaiOJuLQt5yO8Gh2JlzDTJjQJEHDCxMIdQeN8MVGLH8tCmwgCVoeGjnvgxIkk9J+ZXnStTcHuPCPpTUShNtgRhXTwKQNnPxbW1GFcRJGzBig5/BWS+tDZv8cOidvNj0Fn+hh3C4S1nw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb9f74-9bbd-43ec-fd3c-08d792f0f11a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 21:39:43.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+Mi1mMcei0Ai4yKvFx5bamfXpzOfQpi7jE2Kug3jRb/7+NCO60MMCGf2s1Q1bcIL51C6jKG5/XdFfuhuQORPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2552
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

On 2020-01-06 3:45 p.m., Alex Deucher wrote:
> This reverts commit 51bfac71cade386966791a8db87a5912781d249f.
>
> This causes stability issues on some raven boards.  Revert
> for now until a proper fix is completed.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/934
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=206017
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0ffc9447b573..3036ec883fb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -142,7 +142,7 @@ int amdgpu_async_gfx_ring = 1;
>   int amdgpu_mcbp = 0;
>   int amdgpu_discovery = -1;
>   int amdgpu_mes = 0;
> -int amdgpu_noretry = 1;
> +int amdgpu_noretry;
>   int amdgpu_force_asic_type = -1;
>   
>   struct amdgpu_mgpu_info mgpu_info = {
> @@ -588,7 +588,7 @@ MODULE_PARM_DESC(mes,
>   module_param_named(mes, amdgpu_mes, int, 0444);
>   
>   MODULE_PARM_DESC(noretry,
> -	"Disable retry faults (0 = retry enabled, 1 = retry disabled (default))");
> +	"Disable retry faults (0 = retry enabled (default), 1 = retry disabled)");
>   module_param_named(noretry, amdgpu_noretry, int, 0644);
>   
>   /**
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
