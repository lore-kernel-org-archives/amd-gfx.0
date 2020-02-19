Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFBC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44221D56
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HhgCYmtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A906EB6D;
	Wed, 19 Feb 2020 11:27:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C416EB77
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLnDm75znrzl3HLWfY6yVZLC3GFXv7meoYDVon8O/ss8rEq9ThveSZzsnyn3FnS9L2c3qdUbKPGnIqUNBsnYkD5ug65WKXcrNYX0lJL26dDupnfm8plXyLXsn3BFRjuGDBNCcX8ef5+7G2crYLVkU0XR1MICRClmd4OcZMd16iTpkLdlBp7baN08VzARteBSKH651KJAewwsw/xggTe73iNcC48t19DbLD2XSQF8+tcWD4xC2v5vjxkZdu9Br4sDlrU8oDEzfWNiNZBUXWNNVsCtG++xC5rniSroCnhSbU9Xa92iLlpt4/h5OKsksE9laCezztxkyUqez7UOUl4eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFBaHnH4tYjfPRAcYdYt+Ak/d7NKtvupopcFlTZ3U9k=;
 b=nconHt3pDOmOxC9Wp/YVzHTDZd9AqQJtn/Z1H7wfusnydFTCZPNvS1FX90833DMLWixtf74h51+26Ou+QAvM3LLYzR/CLZdV+GxjGmozW9pwRytEucEJuA78+/h4+ooQyLA2NmpwepY+UVWPtQp5a1xVGhK5DS7vFYii67YjpB4DJwixG76XJKmaRNxP0NSQQg5zr8xx9W8T4D19s46Ei+McX6sEpRo5ebJFzVmIuHkI70WeX+OQkszd88fVVQB3LkUK+plTkcVyJ6pU7ZiOvOC5aSS3nAEbwF00R55qeCp8l06RgkPFqgftWyCMP4WdhIbs2VvdkZXJfOJ9m4oENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFBaHnH4tYjfPRAcYdYt+Ak/d7NKtvupopcFlTZ3U9k=;
 b=HhgCYmtrfR2KQAl8xXWfLXG1m9En6OCrg8gzqTRy9KmJIYWl1bK4T0lzk7m4CxoM2Tms+qOdEjrE4g3+cBtI1R5rbWKFvcXIJ+Mx10iOXka0a+lTKr55+ApVMb+f+Ay12CjEZselQu0x2j22hi86NpYH178UT5l/fp2fX+KvpaA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3280.namprd12.prod.outlook.com (20.179.81.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 11:27:25 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 11:27:25 +0000
Date: Wed, 19 Feb 2020 19:27:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
Message-ID: <20200219112714.GA20998@jenkins-Celadon-RN>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
 <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
 <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
Content-Disposition: inline
In-Reply-To: <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 11:27:23 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea02db96-74c6-481a-c1d2-08d7b52eb17f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:|MN2PR12MB3280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32803080A639942A48322115EC100@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(956004)(52116002)(316002)(6496006)(9686003)(2906002)(16526019)(55016002)(53546011)(478600001)(26005)(186003)(33716001)(86362001)(6666004)(6636002)(1076003)(8936002)(81166006)(66574012)(8676002)(81156014)(4326008)(66556008)(66476007)(66946007)(5660300002)(6862004)(33656002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3280;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqlh/coDAyJ2xBIvM5+GOQJvYHuqQcT+K9ZeXBrKzYULu05isY0WdwKtSYUBm2VnsQ7rS1hnA5tgewBLmJ9EsPNBlvRSk8LzWAwNUbCDXW5eC10yLH1nQH49vxCM3CiTX8HZ8sBHT9jf+PAuQn+yByP3X6Xq6YTPCqQYLz/PIaSzjTajQH/nqOmhq0KdBxZ5kl8odAGiuZtdPHrODVh0bh73qzg3FO4NvBOJ4lfiLQas1svsJC2ZRtLLb3BVJqLTcfYtex+aycKr2MA5MZOXoD8neYt18LJW/2k1lB61cUCVyE3D7wKju+RpRWs7T0YLfEy58E8t6ZH64RPOXnSCehgk7/aJn68CEteZzt9xhKo1TNQZTYXZDwU2nhFfgfaLq41oRuA4T1i5e18UJlX6aF/wmovv+QEhRNiVRVNqTvSxIC5l4kk1h0TJNWIvil87
X-MS-Exchange-AntiSpam-MessageData: yqRcVJ+jVAISpGkMQ5YSM9HlEH3A0rNDHXgNk3m7FodYrxclOi5RqCxWLQpjl43kGLgtG5Dnwmt2Ytha4AdjQc4xBxRHotu3JljpiMFXYeQw0LmR3022OwEd9ugIfBfi3S50UMGkN4Lgdg4/f85pLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02db96-74c6-481a-c1d2-08d7b52eb17f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 11:27:25.1385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMYrbMr1RMDt2vr2ByCo9sqbxUfqxkuBPl1oEKmT06RkhFTbsHTBuCbf6siYhEAHa9zsNItE1gojGr8SJM904g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
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
Cc: Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 18, 2020 at 04:46:21PM -0500, Luben Tuikov wrote:
> On 2020-02-17 10:08 a.m., Christian K=F6nig wrote:
> > Am 17.02.20 um 15:44 schrieb Alex Deucher:
> >> On Fri, Feb 14, 2020 at 7:17 PM Luben Tuikov <luben.tuikov@amd.com> wr=
ote:
> >>> Add a AMDGPU_GEM_CREATE_MASK and use it to check
> >>> for valid/invalid GEM create flags coming in from
> >>> userspace.
> >>>
> >>> Fix a bug in checking whether TMZ is supported at
> >>> GEM create time.
> >>>
> >>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
> >>>   include/uapi/drm/amdgpu_drm.h           |  2 ++
> >>>   2 files changed, 4 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gem.c
> >>> index b51a060c637d..74bb79e64fa3 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> @@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *=
dev, void *data,
> >>>          int r;
> >>>
> >>>          /* reject invalid gem flags */
> >>> -       if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> >>> -                     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> >>> -                     AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> >>> -                     AMDGPU_GEM_CREATE_VRAM_CLEARED |
> >>> -                     AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
> >>> -                     AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> >>> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
> >>> -
> >> I'd rather keep the list explicit so no one ends up forgetting to
> >> update the mask the next time new flags are added.
> > =

> > Additional to that this patch is bogus.
> =

> So the only "additional" thing you're contributing to the review of
> this patch is calling it "bogus". Characterizing the patch with an adject=
ive
> as "bogus" is very disturbing. What's next?
> =

> > =

> > We intentionally filter out the flags here which userspace is allowed t=
o =

> > specify in the GEM interface, but after this patch we would allow all =

> > flags to be specified.
> =

> I thought that that could be the case. But in your review why not
> recommend we have a mask to check user-settable flags? So the
> actual flags are collected and visible in one place and well
> understood that that is what is being checked and well-defined
> by a macro with an appropriate name?
> =

> Why did NO ONE comment on the bug fix below? No one.
> =


I missed the bugfix patch before, sorry. (There are many patches from
amd-gfx one day, if you didn't cc me, the mail may be missed). So I found
the issue after sync up with drm-next and then give the fix. Hope you can
understand and don't take it to heart.

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
