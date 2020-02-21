Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002AFC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA05C20656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OeoKmjJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA05C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD6B6F462;
	Fri, 21 Feb 2020 14:44:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55996F462
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 14:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWoC4BRSqg5HDNdvv90aEIzG/biBwYOkelYToHYKPtm382Szj/BG4Nen8oEd15/z0xLrbfY0XlhBNk5wsthPfarbfl+xhmfGmTgcrGjSLsJaHYMHMOHJ7dP/DanUqmtIIjzjO0HtfXEbDJboAjzGKfxT6xvrXjgSfQOVqGH8PucuKjLwOcFV1LrvW1GaKI8RMKSFm1pXOzcFq6TigJK+XzpxzR2STdAbw2ZNBQeSZWwNmAv9nynZ1qs5uA1oTKSAt8ivoM646bkPct3CMsrZe7X1oclw6D/M1tPmYYpQy9xWrcPrUgjVJpQTYMIcpH9TGVnRKoSvNfZmN5hG1kDmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkBdr4plALiETP/ZP5A1lyvU566zoCkEjGwQs2SGe4U=;
 b=GD+yNZuAT475aWGXcI2CM4N76w82Ha0Obi7J9r5iwPfmdg4h0cvgRIOd8JU4k67/ZwAsc2nCYcF5n/fL6WDFUmGywTe9bf0LqzFgzy9UkixWLmHIyBpVJekNi5ADKEfDqCt4Ad9tUm51vKZoI8UJEJn/OwmtTYLNRg/XPbnAdvt3M3lECfKZHgW/pGAZF1k4Yb2Ep3+Q98ZqLbxp2NayESJUrhLAv1XjpK+zIcvOYIsHmbbEBRRm5uUkd7lTfQPtpgk1qkg1u0d/gt6fRkFfqDFQMieL721BHj8tgjw1OKBHW9Scheca50CUtoG3uYZnGJrJpaGpLd6+obdPoT5JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkBdr4plALiETP/ZP5A1lyvU566zoCkEjGwQs2SGe4U=;
 b=OeoKmjJz5zToqibFv2G5OUx0oMrWsMHPHhY4H1ufJBiFGZOlciRFCiSimrqCCoDZPaJrKTvVINXXMpaK09Sh0A07bxpx2vODOaqOnO2bebtpSRuhOAPQlQgKkNti8ST81znXmbKwWZlA00s2+SxRBI0fes/1lZ+ohH3bvIPC3dI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4469.namprd12.prod.outlook.com (20.180.246.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 14:44:16 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 14:44:16 +0000
Date: Fri, 21 Feb 2020 22:44:06 +0800
From: Huang Rui <ray.huang@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
Message-ID: <20200221144405.GG28698@jenkins-Celadon-RN>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <8256dab1-c0d0-fc88-cc3d-1185f42e1671@amd.com>
Content-Disposition: inline
In-Reply-To: <8256dab1-c0d0-fc88-cc3d-1185f42e1671@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 14:44:14 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92869bd4-7007-418c-2d24-08d7b6dc861d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:|MN2PR12MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44698154ADA6AD992CB616C0EC120@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(956004)(8936002)(316002)(1076003)(81166006)(66946007)(81156014)(66476007)(26005)(8676002)(33716001)(186003)(52116002)(54906003)(66556008)(6496006)(53546011)(33656002)(16526019)(55016002)(4326008)(478600001)(9686003)(86362001)(6666004)(6862004)(2906002)(6636002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4469;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC7VSYp8JqjT3LFUhrDHbI8g2Jp5QUffg9zFG+I0jZFyAl1HMqGXjG6sW/vMmO/4F9FbqFePXstf3nD7N5EMRiZR8mxFVLD2VdkPRbIJ7VGexGrxB0Kf2HST1bHwx8Jaj5wnhjFp1Y5KtwJFtPlPvqnPLyPWel/MZT6nlwoV3n+06N+7WLCWZdJFmih+Xm9w9+tGaY2nDpk5IqCynSTBQFoG3uOIZe66hCsgEwCOqJuN9lSn9LQBa9OgVvM0IdsqFcPdzRFwmMeS/W4EBDd5nbN5aZJxaHiGr0LZ5bR3hcERBtzBAuvyAHatGZrRqnjv6vfT9liFVq6B9UO6Hh4YKRVsu+v8gpkkw0IK6uaekuVfgxN2Zatj/rxP31SwrCaVblmSt4y+jumvH9/9ZSpcGlj85SSLZqjT4yIYLyL1TLT+J5vUvntoeF07kwQ/mkze
X-MS-Exchange-AntiSpam-MessageData: h+/1paNupm8niqq/zFllBJvkLhSuy27ahR2ZIMrSDUfxVYZPt1UsY2K67Mdv6vGGxC8VhAezLH42AetCZ3eFJfohyNxvDLagDN1fvygEQlxG3P6UK3KLxjhFHtxdrrS8X5/rBdy53Ky7rZc8cxICnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92869bd4-7007-418c-2d24-08d7b6dc861d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 14:44:15.8851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsyoxtMuiG8wAUvo38TZpqepIDUUMY6qO0fVs0NmsW0+2aUQMiBIsDSUGCVS62+eIrf3DpFIUMi1sQHCUKiSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 21, 2020 at 10:35:33PM +0800, StDenis, Tom wrote:
> =

> On 2020-02-21 9:34 a.m., Huang Rui wrote:
> > On Wed, Feb 19, 2020 at 10:09:46AM -0500, Tom St Denis wrote:
> >> I got some messages after a while:
> >>
> >> [=A0 741.788564] Failed to send Message 8.
> >> [=A0 746.671509] Failed to send Message 8.
> >> [=A0 748.749673] Failed to send Message 2b.
> >> [=A0 759.245414] Failed to send Message 7.
> >> [=A0 763.216902] Failed to send Message 2a.
> >>
> >> Are there any additional locks that should be held?=A0 Because some co=
mmands
> >> like --top or --waves can do a lot of distinct read operations (causin=
g a
> >> lot of enable/disable calls).
> >>
> >> I'm going to sit on this a bit since I don't think the patch is ready =
for
> >> pushing out.
> >>
> > How about use RREG32_KIQ and WREG32_KIQ?
> =

> =

> For all register accesses (in the debugfs read/write method)? Can we use =

> those on all ASICs?

It can be used for all register access, but using KIQ is not as fast as MMI=
O.

So we can check if GFXOFF enabled, then go with KIQ path. Because KIQ can
wake up the GFX to "on" state at runtime.

Thanks,
Ray

> =

> =

> Tom
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
