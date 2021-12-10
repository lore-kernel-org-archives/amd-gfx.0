Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 07:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D153810E33D;
	Fri, 10 Dec 2021 07:49:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E900810E33D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 07:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVkT/7DxuKC44W+zlHYnhdqhXtwo8q8nHpT4RAQvjCce5cum/x4oroSpGOafLBPtDfASCxzVTUzi1No33zOqP7N2ZPcIid/KZ4Hk3kP7csS+GcbJ51mT2WRYeZ28RW6N/K7J8njcTcHmhaDY6HAnRdHE2cIvVYaNs/yGH4lT1y6/CuyoivRQ9qmfBoi70hOK0GxoNntTInbeSQUHqV2+wJwICHZX6swDo+syd7nvPxADD1PK1MeA9td91Wpa64NNSWszNrIxReT9ZJHZotsB2W/3zOYbwZc+absY8dtnTpjEiT8CQyfKmpHf3pOIm2CQ/gfvXk+8B1xEH7zDT96Aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpPcvNoYqy4wau2VimUraZ9Pv6JJ/i1M5I2Kdj9LSGc=;
 b=kCiPoUwjUXLGcX3ykQcb9a1sIDI47MUZwWyqPxcMkn7FBaD+kDjvIvM5OkXqU29WgeM9G2YnF1TAYVpF+bRC0bZR51JzDqARQUXk/YrLLrxBo/jb1a1FQWA5lsN9aseaOKYBj1SvzD025xm2ED9XFWqbt5tfa9IzKYJsgqMIWDnIfl0z7eQ9b6CH2qXR14wT0fc4SzN+KfUREQCcufzvOe2qCu4TqxpEGSNSA/vsCGDMLxGbaYY0CWXxHFRM5KxOR6C+LDG8M+/YKivBFN+LIeeCr+TKXsXXTnkSGdKVxcXAhisbYIRF9TJ8V2hYh7liEoK7hE1bu2JJl96oS4l8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpPcvNoYqy4wau2VimUraZ9Pv6JJ/i1M5I2Kdj9LSGc=;
 b=tDO4DcrAjqNXOznZvc3KKH5tTG5Dp26gTc35+1riRzFIOdpqUkkdCK0rYeh8+FsQm1vDSZNtCqGEXfxXVYRu0RYDrn1hs+/Efly65QVn/NFTuGdwgVKLXdnWG1EywAPSfrytqDCvoE6SHs3xa4BRZedry+JyZMjGTxc8qZXbmTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.19; Fri, 10 Dec 2021 07:49:35 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 07:49:35 +0000
Date: Fri, 10 Dec 2021 15:49:24 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Message-ID: <YbMGhLUP/X6/GcZu@lang-desktop>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
 <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbK8lwgodK5VutKA@lang-desktop>
 <DM6PR12MB2619F67E8A6A3D230A5D6E52E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbLHyOypWV8FV0oc@lang-desktop>
 <c6151df9-1b12-e985-22df-bfd6ea32f582@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6151df9-1b12-e985-22df-bfd6ea32f582@amd.com>
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b3286c-6dce-458e-6d37-08d9bbb19c02
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404667AF854948498C7146AFB719@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IX3R0JWE/zCIpVqPEcnnW7aT7kvSLWaoBQK+A/LBkBWPJgojiuhU29s2VnoAFogqQ6SuuE9yaCbpEiYthTy4IqWgnPF4SJl+DHlp12QjnXBuL6V9+wjjOfNLEqRZ317rXWhM5Dic8+Opon3Su5TXJcDG4Bw66szqSVS7ltLICpLR9XBzhPbzYnFTSZfLeso5g9zJE0MLJaS3PMcj9+YFUKRsEm9SNXTzy3eZiTmYQ4v0VC1Y/5bYOceJsUe+B02OAPgyQhSUNuGAHifetgvHDozeLYPWYK8WgDc0KLpidB0uEG9BFXCrmtD3GuFGDJpFvrxcGc2lvEk+YyOxCetCLhJ+BqFQmAXaNAxamknZvL4YXQQ+ZeshegTBCCxhkoP0BhWNkl3STZh4mOy9jsrH/cX1hpogCGY2VZftlwjwM4gMSur7NOH1LNVEoMG4oWGRSQdD8Ly4YsWxG2q4Ry4uEZ7ZB06LdxywqpqAAyg5FrgkAbQsPLif2Yd9tx7L8hz2DAAfDEx258lZMdNzysAZFex9GuiC2aPgDxwlfOKWfBxluzfOSQX4VtvdMRTdDMwtyFcB8HUUVjT+9A1bmpctj7Cv9D5Exe/INVGZYo7jxodbznLra01h9iYtfmlXkq5w4TCGTRAKeE4ju0pUbPdUyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(26005)(508600001)(186003)(8676002)(8936002)(83380400001)(316002)(6506007)(5660300002)(54906003)(53546011)(6636002)(6666004)(2906002)(6862004)(6512007)(66476007)(4326008)(9686003)(38100700002)(66556008)(33716001)(86362001)(6486002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwKVu5GuP44hWeZ+UnE0rwkFkdxVN3MxXKRZEqUrm1l8hBNhBXKQuvoL1abm?=
 =?us-ascii?Q?Ot4hzWhJ6E91jXf0vyq2L3iHY7MN1GI+8N0T+bW0t5C50yuV2/T6t/PXfl5S?=
 =?us-ascii?Q?h67dJMaZ7mJXLX/XFcASoX0vGfsZXHaP7b7enq3Tx3BvZepdfCZ2gHweQD6E?=
 =?us-ascii?Q?kPetS8BYhAJWMclYJd+KNnUlP8WvLbJB8Pp7OnDrZTobzHqnBxv4ySBvljFU?=
 =?us-ascii?Q?Y9PVkPziAMr8sIa5B9UPL/QDhH5PvxXw9+OI/lk74/aZ9EbpCxIkhcaMZO63?=
 =?us-ascii?Q?8MED7NBfsOQzLkU1Q9SDNnx8cv4LycJXo2ZxMNiGLhHyvMJuOTftkCOygiqm?=
 =?us-ascii?Q?WAy7KcxagmxO2kl/32rtwx/E7cesDWXFjKqx79FcrpD4omKkcVzBN89KI4Fy?=
 =?us-ascii?Q?MwmNgRLpPxBHAXtYxQ3jJOM7wALit5XvcS2+R0mIMrKHH63hZlkBryfMYFD7?=
 =?us-ascii?Q?2XUVFavMTpL5dVCbuwLj5oyeVDW10js0DW+NkT6TH1L1FY7eWzUikBEKjj7f?=
 =?us-ascii?Q?pWQFRuqlkE14j3NBs/OL/6gnm5/woM8kojk62qPYKTmSwsQPx+9mUtx67JuM?=
 =?us-ascii?Q?+awuRZsgU1fl9QqpO+m7GiLze8atnrTw1uSvJVkUdFBfYq+MllFNKrgL4mcq?=
 =?us-ascii?Q?SMszyha4fD5FojZYX+l9JJDZIx6FypXLh4dhIM8YVStMxKmTfF+w9Jq1zYHX?=
 =?us-ascii?Q?tbufBA1A7LeDGxbmqMm6s6JHqiN9iZiytjx6i4AfThC6Xowosg6Ph+Bt+bzR?=
 =?us-ascii?Q?x3eXrA6siKSRk3/uAez9V9+4GTnyjcx9DDGC8ce8sdlFP5EC61/R4ipkgzeD?=
 =?us-ascii?Q?yQ08vAEi3AK4Lesfdw8aR7IWXh1H6cumMZAc4xEIlSydVB6jI+w6aB5fldpI?=
 =?us-ascii?Q?YrSlXKoyBLjsfqKVs1dn4mqhZ0yyYyBui3s0UbHYeDIXRerBJ8Doh9cGtrh2?=
 =?us-ascii?Q?vsjtCPjJu2njfuVKJdbbu8QvqawOqum50VKGrozRx7+r1Qnx5vNirh7zaoXN?=
 =?us-ascii?Q?N5yBV7mSJkT+ovpMF74liZF0eURPZJOUziqv6yL6hLpNlNlGVyEUXfToXDAk?=
 =?us-ascii?Q?B7KlJxCLolqtE0NpolL2WibVFbzzw2zdZmU1cIgySDIg2jx6VzF4rkYXpAAZ?=
 =?us-ascii?Q?JdHyqrug8Yib0eE+Y9DyTZLaRkSLprVR4BMbP4oFJHq64UAbHQUPbKR/quEj?=
 =?us-ascii?Q?dEIboM8GCHTSHihKZpl0MCZOSy1EIVMaIbttH2Jj5OWHTQ8nMb5zWMRlxck2?=
 =?us-ascii?Q?C1w7GA1KeFUSkQAcIURUNWMdAhKaQA7dHCXpaCFNxOs8eWdcmpjd36m6R+0I?=
 =?us-ascii?Q?nHgcOmsr+VQXnINiuIimMeo7JX+S664wYD7DzXqzCEBPMhdMIpNfuDwsRXfb?=
 =?us-ascii?Q?MM97ivSO2kNZP2TNbi8N1yWXThPsd7ZXJiQzbiiKsmJzCKjLwuvnBxxWRx7X?=
 =?us-ascii?Q?cHIymoQ5gCHqqFWEZRaWaHpJeLRzOtfqOk7UnANij66q26Ia7zR3fWAOypg4?=
 =?us-ascii?Q?zRFI3mcEXUt8reloelDXoi9d8j+sbM9qblq3/OI018f7Ktau/hwGxcb4dISe?=
 =?us-ascii?Q?Ahb5GLMTrMe2wHgyX5yF42ScYRuWpQ54gMm+6emYr9LxkWmvekPm3vbNmVXW?=
 =?us-ascii?Q?lkMcyKfteEKAieKPGmjPKQk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b3286c-6dce-458e-6d37-08d9bbb19c02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 07:49:35.4479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylDch2Ivc3Q+WDNWXHVH61qKzD6CzMLmeGbP2BV85ZvXfu+ckPyZ+ZYxfVc2WKdS+gaKrHBDX+P8Yv0IS8pxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/10/ , Christian KKKnig wrote:
> Am 10.12.21 um 04:21 schrieb Lang Yu:
> > On 12/10/ , Quan, Evan wrote:
> > > [AMD Official Use Only]
> > > 
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Yu, Lang <Lang.Yu@amd.com>
> > > > Sent: Friday, December 10, 2021 10:34 AM
> > > > To: Quan, Evan <Evan.Quan@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
> > > > <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang,
> > > > Ray <Ray.Huang@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > > > 
> > > > On 12/10/ , Quan, Evan wrote:
> > > > > [AMD Official Use Only]
> > > > > 
> > > > > 
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > > > Lang Yu
> > > > > > Sent: Thursday, December 9, 2021 4:49 PM
> > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
> > > > > > <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> > > > > > Alexander <Alexander.Deucher@amd.com>; Yu, Lang
> > > > <Lang.Yu@amd.com>;
> > > > > > Koenig, Christian <Christian.Koenig@amd.com>
> > > > > > Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > > > > > 
> > > > > > SMU firmware guys expect the driver maintains error context and
> > > > > > doesn't interact with SMU any more when SMU errors occurred.
> > > > > > That will aid in debugging SMU firmware issues.
> > > > > > 
> > > > > > Add SMU debug option support for this request, it can be enabled or
> > > > > > disabled via amdgpu_smu_debug debugfs file.
> > > > > > When enabled, it brings hardware to a kind of halt state so that no
> > > > > > one can touch it any more in the envent of SMU errors.
> > > > > > 
> > > > > > Currently, dirver interacts with SMU via sending messages.
> > > > > > And threre are three ways to sending messages to SMU.
> > > > > > Handle them respectively as following:
> > > > > > 
> > > > > > 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
> > > > > > 
> > > > > >    Halt on any error.
> > > > > > 
> > > > > > 2,
> > > > smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> > > > > > for longer timeout cases
> > > > > > 
> > > > > >    Halt on errors apart from ETIME. Otherwise this way won't work.
> > > > > > 
> > > > > > 3, smu_cmn_send_msg_without_waiting() for no waiting cases
> > > > > > 
> > > > > >    Halt on errors apart from ETIME. Otherwise second way won't work.
> > > > > > 
> > > > > > After halting, use BUG() to explicitly notify users.
> > > > > > 
> > > > > > == Command Guide ==
> > > > > > 
> > > > > > 1, enable SMU debug option
> > > > > > 
> > > > > >   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > > > > > 
> > > > > > 2, disable SMU debug option
> > > > > > 
> > > > > >   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > > > > > 
> > > > > > v4:
> > > > > >   - Set to halt state instead of a simple hang.(Christian)
> > > > > > 
> > > > > > v3:
> > > > > >   - Use debugfs_create_bool().(Christian)
> > > > > >   - Put variable into smu_context struct.
> > > > > >   - Don't resend command when timeout.
> > > > > > 
> > > > > > v2:
> > > > > >   - Resend command when timeout.(Lijo)
> > > > > >   - Use debugfs file instead of module parameter.
> > > > > > 
> > > > > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > > > > ---
> > > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
> > > > > >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
> > > > > >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
> > > > > > +++++++++++++++++++-
> > > > > >   3 files changed, 27 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > index 164d6a9e9fbb..86cd888c7822 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct
> > > > amdgpu_device
> > > > > > *adev)
> > > > > >   	if (!debugfs_initialized())
> > > > > >   		return 0;
> > > > > > 
> > > > > > +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> > > > > > +				  &adev->smu.smu_debug_mode);
> > > > > > +
> > > > > >   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
> > > > > >   				  &fops_ib_preempt);
> > > > > >   	if (IS_ERR(ent)) {
> > > > > > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > > > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > > > index f738f7dc20c9..50dbf5594a9d 100644
> > > > > > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > > > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > > > > @@ -569,6 +569,11 @@ struct smu_context
> > > > > >   	struct smu_user_dpm_profile user_dpm_profile;
> > > > > > 
> > > > > >   	struct stb_context stb_context;
> > > > > > +	/*
> > > > > > +	 * When enabled, it makes SMU errors fatal.
> > > > > > +	 * (0 = disabled (default), 1 = enabled)
> > > > > > +	 */
> > > > > > +	bool smu_debug_mode;
> > > > > [Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that
> > > > in future we can add support for other debug features.
> > > > > >   };
> > > > OK.
> > > > 
> > > > > >   struct i2c_adapter;
> > > > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > > > index 048ca1673863..84016d22c075 100644
> > > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > > > > @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
> > > > > > smu_context *smu,
> > > > > >   	__smu_cmn_send_msg(smu, msg_index, param);
> > > > > >   	res = 0;
> > > > > >   Out:
> > > > > > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > > > > > +		amdgpu_device_halt(smu->adev);
> > > > > > +		BUG();
> > > > > [Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and
> > > > Andrey can share you more insights about that.
> > > > > Do we still need the "BUG()" then?
> > > > The BUG() is used to explicitly notify users something went wrong.
> > > > Otherwise userspace may not know immediately.
> > > > FW guys request this in ticket.
> > > [Quan, Evan] Won't drm_dev_unplug() and pci_disable_device() used in amdgpu_device_halt throw some errors(on user's further attempt to communicate with our driver)?
> > > Also if the purpose is to raise user's concern, WARN() may be a more gentle way?
> >  From my testing and observation, it depends on what the driver will do next.
> > Probably trigger a page fault. If we don't connect a monitor but SSH access.
> > We don't know what happended until something like a page fault is triggered.
> > 
> > But here what I want to do is throwing the error immediately to userspace.
> > If using WARN(), the user need to poll dmesg to see if something went wrong.
> 
> I agree with Evan as well. Please use WARN() or WARN_ON() here instead.
> 
> BUG() and BUG_ON() is only allowed when you prevent further data corruption
> by intentionally crashing the kernel thread. But that is really invasive
> because for example locks are not necessarily dropped and so can crash the
> whole system.

Ok, will use WARN().

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lang
> > 
> > > BR
> > > Evan
> > > > Regards,
> > > > Lang
> > > > 
> > > > > BR
> > > > > Evan
> > > > > > +	}
> > > > > > +
> > > > > >   	return res;
> > > > > >   }
> > > > > > 
> > > > > > @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
> > > > > > smu_context *smu,
> > > > > >   int smu_cmn_wait_for_response(struct smu_context *smu)  {
> > > > > >   	u32 reg;
> > > > > > +	int res;
> > > > > > 
> > > > > >   	reg = __smu_cmn_poll_stat(smu);
> > > > > > -	return __smu_cmn_reg2errno(smu, reg);
> > > > > > +	res = __smu_cmn_reg2errno(smu, reg);
> > > > > > +
> > > > > > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > > > > > +		amdgpu_device_halt(smu->adev);
> > > > > > +		BUG();
> > > > > > +	}
> > > > > > +
> > > > > > +	return res;
> > > > > >   }
> > > > > > 
> > > > > >   /**
> > > > > > @@ -357,6 +370,11 @@ int
> > > > smu_cmn_send_smc_msg_with_param(struct
> > > > > > smu_context *smu,
> > > > > >   	if (read_arg)
> > > > > >   		smu_cmn_read_arg(smu, read_arg);
> > > > > >   Out:
> > > > > > +	if (unlikely(smu->smu_debug_mode) && res) {
> > > > > > +		amdgpu_device_halt(smu->adev);
> > > > > > +		BUG();
> > > > > > +	}
> > > > > > +
> > > > > >   	mutex_unlock(&smu->message_lock);
> > > > > >   	return res;
> > > > > >   }
> > > > > > --
> > > > > > 2.25.1
> 
