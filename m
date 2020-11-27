Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E4C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 08:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19533221FD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tajIewrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19533221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBC86E9C7;
	Fri, 27 Nov 2020 08:40:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52B36E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 08:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0RR2gXTQjT2Ql4TEgGnGallMXvbJ6uWptAhEeQFweURTKJ7S02hbOXLhDKAr46ptsdzUYO9CdqZa4ItPSoRL8oJ6o3cOOpL5CiYgmt8vYRtXvn+kx8sSO837DN2SIGgQB+1Ldct1AHvT8ghnnPBreQpOqwtUu4iBcQlpRMAluOISurtuRWKXvOgtN8UkSJAtXeXuWbtpOKJ+19cmmwpDUHMcVTOKT/hk3ITBRw2IOoWqUUFhLzUtW7+dTiFTSIIGKMRch9g/pcN5dVVqf6K8A2Kn5857ZkvmmpsXJ7/VcoI9utWPZdDi7IzqMtYD68Hslo+PQDpYea4Wu0PxXJzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geE3HXD+amh3BMP83FKTUGgehaKHFaKc177dRdHiZiw=;
 b=KF4oYKcJ253RlUY0HhAf+mI2gft58orZKYVgNYD5D4pRhFuykwG2VwFhnA6YY09h9eTuFdKwhu2zkpCj4QNycAlNNjoMXd+XPWTPqsxJ71Jc68eyWthciRxaLRw4ciz9BudYTy+arncAmORzlRSX8L5Woj7GL94y4N9MbYhw/dCiW/kPw083lfUEtnxCopRAJmdSgbG1Ipt2z6AH0RHDsDHAo+jXzha1yVo0wMTcKhGmFIO8cr00c+2TGhWNtvt6mpvdcKoMJNKBbJ28vGGuUTLdFpWVWrvnMF9968yuve1gU2mHvGxp2EfXQ356vRu7qmqbhM2DKD8+reTz9Z1KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geE3HXD+amh3BMP83FKTUGgehaKHFaKc177dRdHiZiw=;
 b=tajIewrJEySl0PPdCJ058p6vhUd4YdbEhiRf5Lj0+1e4R0mPN8lYqMayDR38LTXs76WZM4RvQrovzd4NccAdiV44x8elgxgLVm90psnzaMezMih3Dd20ouYYxnEWxtr5nGcYZNloFe+27T47O977lHsTuleasAqptvsZLd+wK5w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Fri, 27 Nov
 2020 08:40:16 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3589.032; Fri, 27 Nov 2020
 08:40:16 +0000
Date: Fri, 27 Nov 2020 16:42:30 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Set doorbell range for gfx ring
Message-ID: <20201127084230.GA605160@hr-amd>
References: <20201127080907.12337-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201127080907.12337-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR0401CA0008.apcprd04.prod.outlook.com (2603:1096:202:2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 08:40:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2b2d9aa-e475-4808-477a-08d892b01019
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB185343965F7021AA9EA1B89AECF80@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7oDtwUmKFOdJ23wrjK4kwYhpgCdPwOb6IOICdERmoXqCFwqI3l7PEq8mMgJjAHv+PxhCAeA89wA/N/oIZ6axyMSZ6aTeASRmEvTw9ZoPv2z/IWhk1HrLcu3OEQyJD8gEKCvVEpkry1hsnWkq8fXPCsTwA+42pNaxwBADYHuxWhKqMyQcy4NaCEgjsaZMY6VsIX2as658Crizt6MCecJ1r1FUOp/uCgewu8c9Fw6sBEOF+P5CRvmqCGfZdrX6scPmP4qepegNC5sBzJFr8sL3gjIgjYV6meW5tp7gGeMwfeCh0gWZi44dKO86rifcB0ZWn/coeYSVALr9K7FF69wIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(316002)(54906003)(86362001)(186003)(2906002)(26005)(16526019)(6666004)(83380400001)(1076003)(8936002)(478600001)(33656002)(6496006)(6636002)(4326008)(8676002)(33716001)(9686003)(52116002)(956004)(5660300002)(6862004)(55016002)(66476007)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q8b9b0TKfH1M2a9mrMw10Fcm4pLmwfRGN1X0FrewQksjssmmocfnGZzlvXe4?=
 =?us-ascii?Q?KaYkuN+jVHoeXJlHcXQKhYzCy3Y3p7nOJM/y4DzRR9EDWU+4qkhJCPZa6UpD?=
 =?us-ascii?Q?nBa+K4VUvjSzA4ak76esVTq3JL2bmzINqNQdD8Owfaxr6hUGzZK4llc+B5fq?=
 =?us-ascii?Q?H5/oetDpsjheNpK4CyZOOBUyWqHNZuosp9N/D70Mtnc5xZ1/r1sSydwkkrCN?=
 =?us-ascii?Q?qLKKW6HeBAhH7yZWdcGnwxOBVS/VYASgUoEmx6bt6gJLwnzHe594NRjC4Ney?=
 =?us-ascii?Q?29MbtWEUissZ/D/Dik4lSFaxGasO3pE7mKr75LCKv79T/OcMcV6wr3zkj4QU?=
 =?us-ascii?Q?YQOhO8GpMujdf4FPlh5m2lY6nPn/sobTUT+VYKbB5XACRKlIdWJBZLwVSkax?=
 =?us-ascii?Q?PAtLTAk3XeyThN5WMLXbOkZvCSmzojfUw8z36nMbQm3mne4aH/FsmgxDyYqp?=
 =?us-ascii?Q?7yat9MKY0pInoJhLMB5ebhYs7ZXerg4djpIsLrogCDukZ7lY9DMi5kbrf58g?=
 =?us-ascii?Q?AmKhTM+YKvilzn2Zdq2HK9I3lkkq4OecYm4/aGZu5hQ9taKRRV7vSlwA9aJh?=
 =?us-ascii?Q?HLoVYJ6aanJUVJSwqXA4yo0yJTkEx/ttMuNTr0YslhP7VjdcI4vqSb/COLPJ?=
 =?us-ascii?Q?1nTGIhXsMNnvX9oHu/Hf2X78Bh4pc+F0NDnj4rpNJsM+St/kG297F3kIZp/A?=
 =?us-ascii?Q?+GBQf4GhCY6Ui98y8BCDNYp4k4vVYv+QxXhv/LfBnkSqDeTjWzW+Y37uatYT?=
 =?us-ascii?Q?WiL/kmKfbPJg+aME4WWLa7CujZXrAwmknIpgRz3kgAgFi27Pd63wlt0jcuzx?=
 =?us-ascii?Q?hYdOkjA94owCGzh4OjbcMB451vLOz9c72tn+PhPKSUfE93sWFB5Ea/YLk3Er?=
 =?us-ascii?Q?ZRu6jONovirTcty4Zd01H9z1gKv/RvZFK/RUOeYE+0R5i/gsBky7Myg2dYxx?=
 =?us-ascii?Q?6xcQSw2Hqcz+TIkRieEK2dPRnyFP1s7w07VeFXUC9ptj7VKEht+PucLy/Fn6?=
 =?us-ascii?Q?qPQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b2d9aa-e475-4808-477a-08d892b01019
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 08:40:16.0434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnE7psgeGXhyeO+Zd3nRwNsMyMM41SBEsSRQPd0GSViB1AD0jhavc2fn0teIlCs66rxfo6xwEzPG8cRUPFmbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
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
Cc: "Kamliya, Prakash" <Prakash.Kamliya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 27, 2020 at 04:09:07PM +0800, Su, Jinzhou (Joe) wrote:
> If there are 2 gfx rings, the doorbell lower range of second ring
> will override the first ring.
> 
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ffbda6680a68..f33e54b01d3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6357,8 +6357,11 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
>  				    DOORBELL_EN, 0);
>  	mqd->cp_rb_doorbell_control = tmp;
>  
> -	/* set doorbell range */
> -	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
> +	/*if there are 2 gfx rings, set the lower doorbell range of the first ring,
> +	 *otherwise the range of the second ring will override the first ring */
> +	if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)

Maybe you can compare if ring->name is "gfx_0.0.0" here.

Anyway, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> +		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
> +
>  	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>  	ring->wptr = 0;
>  	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
