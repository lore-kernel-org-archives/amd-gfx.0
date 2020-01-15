Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF8C33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4BA24655
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uLOiQqjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4BA24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282B16E830;
	Wed, 15 Jan 2020 02:56:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF726E830
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 02:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHu08qkuF519gJFGwGZPY9JNNdcGJQANPQp1wIUUF2WwCo8bk/1lZjBi9zfRYJSxbGl66gZFuE6VYWr+LEmaqL/C2gBS9brHBpcuC9+uWqmrv1j4FkpYzu1hBYzs2irSPgU7BIZLWTm9ycfSDf2UZaIEZk2+95HERcxhOH7bHqaOmCSzmvQi4kQ5PVcMnvkyvpvm+2+evbTpJDDn3f6ehKxqvE6iapDW0550zr3qjr7wokL0Fy3B5WoiCe5v0zbI4BmIXWpeHi7oZAesgm4VipovYBbfLH485kn2WY8MBe19v09F19/wWznhn+/bMPU1bw1xAWLpk6/oVGjfMg8cEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYX01OJNWbPGuGz6BhT4MXgLhPd2vaT0H/NMOiebbLE=;
 b=cmLT67RNi29nGEzzty6c4ZYf+BLc0RXfjFSvzVwSqouudKvdV9smiLFAnFXSkTCNxRk4lfuqFkvdYu3ywK7sjhidJXsdpE5SA8Vc8g0TiYu2JWLXEKox1Tax3cj94NMwgpL4mr1EVkAQYPSjgoEZ6xrlSzAe3lJnJc/VhaQUKZ4p5e8ImIaT+m4J/YWRe7rY9wZMIL4YZTL7QGNC9sqhyCZrXk/rBReezUPVTyLJ2wIJs+5YEEzYYilNZIY+qhyNzRlpuKqfqAk5kP6LELneosMPRHEwGe0KaIw48WJARRvErZEibO7m2NS6TBkzRxjRC16WxPIMf7dbFL1NAw2m8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYX01OJNWbPGuGz6BhT4MXgLhPd2vaT0H/NMOiebbLE=;
 b=uLOiQqjDNyHXFEM2l2E98Yk9o9eryZkeH6o2+ASkGrzbwMcJdYT7SWKYfRpOpKr1eDqS3dTD9wmSOL9KORmwci1n2oed+uljRFNti2xgjjd6S5ve1Vzo2HSrn1HwxQbF0hDV+U3VJYOwz4mPeHzkaIAjvcWaU9WLGaMEo7QGAk0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from BN8PR12MB3300.namprd12.prod.outlook.com (20.179.66.160) by
 BN8PR12MB3012.namprd12.prod.outlook.com (20.178.209.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 02:56:05 +0000
Received: from BN8PR12MB3300.namprd12.prod.outlook.com
 ([fe80::846f:2b61:2803:e80]) by BN8PR12MB3300.namprd12.prod.outlook.com
 ([fe80::846f:2b61:2803:e80%5]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 02:56:05 +0000
Date: Wed, 15 Jan 2020 10:55:57 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: only set cp active field for kiq queue
Message-ID: <20200115025556.GA6788@jenkins-Celadon-RN>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <20200114093640.GA20112@jenkins-Celadon-RN>
 <e9462ca9-ffe9-0bf6-8fa2-881c40f24bef@amd.com>
Content-Disposition: inline
In-Reply-To: <e9462ca9-ffe9-0bf6-8fa2-881c40f24bef@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To BN8PR12MB3300.namprd12.prod.outlook.com
 (2603:10b6:408:6a::32)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 15 Jan 2020 02:56:03 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d0dfde8-4d47-436c-dfcd-08d7996676c0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3012:|BN8PR12MB3012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30126334D8C55F3419214A2FEC370@BN8PR12MB3012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(8936002)(6636002)(316002)(8676002)(4326008)(9686003)(66476007)(55016002)(81156014)(81166006)(956004)(66556008)(86362001)(1076003)(66946007)(5660300002)(54906003)(53546011)(33656002)(2906002)(6666004)(478600001)(33716001)(52116002)(16526019)(186003)(6862004)(26005)(6496006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3012;
 H:BN8PR12MB3300.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJctdC205/9j/zAOX5H2Shwg2tLvtvH/phNaiOWYMRl4JyrjFrW+2df2YeLxtHxpU4iZiT1dUOZgHiQ+U6+jhyYNn4OPx78agK+gLVZlbGcrjmdiDQwvODY1ohe9kBUhgmpi/PZEJ2ju688Emfltee4fuj8msJ0rR9OiGBUxfIJh8MOkW8clZSIf7qUthuVy/KesjUqSP8YK0xxpvKFmWR3FTiEm99Tc3VxV0ycmvjUQKqPbW4Afkjju5JZ4IQMXkzgVf50MPTWJRfOrRk5eB+d3YGNPHdDOzxiaj8ECSSw9eLsbgJtuupDvhe8UxPwltSEXXAlYDei5YZSLLQ7/Rm6k9Yb9GI7b5Yv5bgRfWkBpXVBXvOsjcRPalipuxYViQyIy7YVtDhkkNaB3WJZ/OydzjmRB94tktfesTz/nEig7i+yozOJ61T4kHSN2UUxm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0dfde8-4d47-436c-dfcd-08d7996676c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 02:56:05.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4z05LWwdD3UJL4ZzGMW/IECkHCl1kFzzNEXoeavpzpKUiIBiFYdMdXl8psJ11VtMSYkBKrYTDKdQo34x+aRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3012
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 14, 2020 at 11:30:15PM +0800, Kuehling, Felix wrote:
> Patch 1 is
> =

> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> =

> Patches 2 and 3 should be squashed. In that case they are
> =

> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> =

> Patches 4 and 5 need to be tested. I think you mentioned GFX10 worked =

> (patch 4) but GFX8 was failing (patch 5). Have you found the problem? I =

> haven't seen any update to the patch.

Yes, GFX8 (patch5) failed with the page fault, I am still looking at this
issue. For other patches (verified good), I have pushed into drm-next.

Thanks,
Ray

> =

> Regards,
>  =A0 Felix
> =

> On 2020-01-14 4:36, Huang Rui wrote:
> > Ping~
> >
> > On Fri, Jan 10, 2020 at 02:37:09PM +0800, Huang, Ray wrote:
> >> The mec ucode will set the CP_HQD_ACTIVE bit while the queue is mapped=
 by
> >> MAP_QUEUES packet. So we only need set cp active field for kiq queue.
> >>
> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++--
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 7 +++++--
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 7 +++++--
> >>   3 files changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c
> >> index 5b05334..22c69d8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> @@ -3323,8 +3323,11 @@ static int gfx_v10_0_compute_mqd_init(struct am=
dgpu_ring *ring)
> >>   	tmp =3D REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
> >>   	mqd->cp_hqd_ib_control =3D tmp;
> >>   =

> >> -	/* activate the queue */
> >> -	mqd->cp_hqd_active =3D 1;
> >> +	/* map_queues packet doesn't need activate the queue,
> >> +	 * so only kiq need set this field.
> >> +	 */
> >> +	if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >> +		mqd->cp_hqd_active =3D 1;
> >>   =

> >>   	return 0;
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c
> >> index 8b9f440..306ee61 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> @@ -4558,8 +4558,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring=
 *ring)
> >>   	mqd->cp_hqd_eop_wptr_mem =3D RREG32(mmCP_HQD_EOP_WPTR_MEM);
> >>   	mqd->cp_hqd_eop_dones =3D RREG32(mmCP_HQD_EOP_DONES);
> >>   =

> >> -	/* activate the queue */
> >> -	mqd->cp_hqd_active =3D 1;
> >> +	/* map_queues packet doesn't need activate the queue,
> >> +	 * so only kiq need set this field.
> >> +	 */
> >> +	if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >> +		mqd->cp_hqd_active =3D 1;
> >>   =

> >>   	return 0;
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c
> >> index 45328f9..e29818b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> @@ -3313,8 +3313,11 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring=
 *ring)
> >>   	tmp =3D REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
> >>   	mqd->cp_hqd_ib_control =3D tmp;
> >>   =

> >> -	/* activate the queue */
> >> -	mqd->cp_hqd_active =3D 1;
> >> +	/* map_queues packet doesn't need activate the queue,
> >> +	 * so only kiq need set this field.
> >> +	 */
> >> +	if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >> +		mqd->cp_hqd_active =3D 1;
> >>   =

> >>   	return 0;
> >>   }
> >> -- =

> >> 2.7.4
> >>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
