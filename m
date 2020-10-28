Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3699C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4F7246CB
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mV4DH59O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4F7246CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6C06EC8E;
	Wed, 28 Oct 2020 11:49:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D613A6EC8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 11:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rgpay54Wg+F4kYZCcobDLV3eFFNYDT6+qZuHAgscm0+Y0LQ+C2J1TteUXHh/qxebfdwnZVRsgN0LfFbM3ffWn8VAu1V9tqPKvu3JjCbQk1467BOpDGhmPX59j0DQ+Q/0BpFxUivFzReAkxw8RbYOwIVI0DIms4wzKvG/uGE+m3/eKgtaEto3CevxeBdx4e4Q9HtG4ucGsdLAaebY42PNmB5UdvMH4cabEMfyrS/TMsK1kefGPaEXAjuEnAwS9z04sOnbg7X/6k1jP3MqLCoxni14hY7LDZJQcFIaUSqAM9YC7XvwA29yhKc22eLB0FvWAbuWYCI/jM0hqfPyTPza7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xChBN0cogf5BzWi6o+6FLn9axIbQ/yWNejpcHzS1JOs=;
 b=mkUC1q8kUOWrFkHgCKfTv3nW5cvqCpIZoQ6meeovXw9vgRIl8Rrff/ynGK9Eo31ws9kkP3/APOcFzocOCvffUVFkf8JMjaZg9poBN5PwgZgc7GWGmHuDwgU5O0HJ6NCH0Baqc14ueCerJNHk1D8TND9N8Hees+g/LK+sIEylL8n3gQq7l/Shaa9YMr9kZVYdCr5omi/GBbXfTCoU9Bbx2AL6KK8BgnLoiI6ZdRkxbsdlAMnvta81gdoAbPS9RBvipuRjcBLKulhZmOQhfldiMEsDESB8r65gUxL0x3no0LeSOfOv3CGRU1DkCqjQKZWGNu/hnm6xtHRe4OSTH6HFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xChBN0cogf5BzWi6o+6FLn9axIbQ/yWNejpcHzS1JOs=;
 b=mV4DH59OvbhEnrZhAshK1pAX7sLe4BY7DfIOCpQptYtVyfBnepZ/jiOPJYeqFeix57g3XTEm4J7ZDwJSr4E69SKya1Qoijk8IB2YgyqSi28nJziGLOP729wcvyEfLV83HFbk0SpHpwQPQSfFzNVQmr1JOchVXuH099kYnq7YUGs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 11:49:27 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Wed, 28 Oct
 2020 11:49:27 +0000
Date: Wed, 28 Oct 2020 19:49:43 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] amdgpu:Add flag for updating MGCG on GFX10
Message-ID: <20201028114943.GC1767271@hr-amd>
References: <20201028101236.2941-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201028101236.2941-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK0PR01CA0064.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Wed, 28 Oct 2020 11:49:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3169e53b-c3ea-4da6-9317-08d87b3785e4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0048E68B8CCAD33E959968C3EC170@MWHPR1201MB0048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT8Z3g8ynC0wshHMsc7f88vdYU5O2DyeIqM4lpzyXrot2pBXWtJfE9KrIP+GNtCr247mlq/ahemEvr5B3r9ZHasirt6ml4OeVvEU/eb8crJqzj40RjKHnf4rZK5Jb9fYxob/ishdk6RPKesSLlR9tGk5iAGi0AkrK0vPvapkDN7tKAX4wGNPx3DM7QSGLFkFE6l+KkDe3ueUzofrG2KTMblUCFQ/O0eNODV7sdpt4/1d1ojqT7POQvX5eUWrbjJoR/wYmm3ltlAYzMPrstfOJNlpGOgPBXD5AFmiJnureQeVfGA6yh8sVnirPaPjltiMYJQUDSWRbJNhophpIrZ8FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66946007)(66556008)(33716001)(8936002)(66476007)(478600001)(8676002)(9686003)(5660300002)(1076003)(33656002)(4326008)(316002)(2906002)(83380400001)(186003)(6666004)(6862004)(86362001)(6636002)(6496006)(956004)(26005)(55016002)(16526019)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BsGaGMH+V4lhoi7HRcCVJ+g4oPwoBzvYoec7FrIZaaK8/lHlLRcmpkPWlX5+L6ArvsVki93v9O03R58FUgsMi7WF7Xvt1paExiQQ/hBwtPqNBnW6i/tHfXwucaN7DKv9CcGx9hpT7e8uOiN4HVfNlloer26CTz3/k4tdbw0A+JJite6oqSfvvRGz8oFBDuCH1/XxFwrBtFaW2J+FhJ37wGLg3bh+8NS1J5Qi3JSZXM6x8kM2yifU54lsdAf6KeSN7biqK2i7RMa3a33Ox9nWfhu1hPQTUBXpz85EnFQGTig0wCxY1TeN5qre/HgEVWUf1TuB953oKEdef2BjI5/ExOC6cXzdZF2BDMsaqdw9lhWGdR6g8sLaDdlA9aW32t8QKQFgd9Z/yD0bCj7wshl5GkOCkvwsowMbPb41kZRt8ZuHRtFeuPDTTt8REOSfkVvQZCiqWd6NEUauU9NsxeJzIzpSE4sySK4bH1oqeIhMSuOw7tPBCxIWCKGwlrzLP8GmkdOFwodsySKeGqKwnFSXrMOxpKdQclbB3fO3nU7OC+A49PQ8TfYdzQOw5n9u2xGavnFffJLrw2vci8F/6Am+edaCavkkN1VfnpaIqE9j9uHnDl96EcQ1xy7iWvsAjSnq8ppYZ9jCSRvxWGAVDQLGnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3169e53b-c3ea-4da6-9317-08d87b3785e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 11:49:27.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2TQStOFR3ZSLZOd0yXjTEEK+Y207n7dPTVYOmExZMZ5hQkfHu2e9Cl3wn6CDz0aYbyBz9/gmnIjAIG2RB6FdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 28, 2020 at 06:12:36PM +0800, Su, Jinzhou (Joe) wrote:
> Add RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK
> 
> Change-Id: I4c1cc30bec81953d29c86d0fd9b5d7cff15a8cb0
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 3256d6b368c8..e4c69125805d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7520,6 +7520,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
>  		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
> +			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
>  			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
>  			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
>  			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
