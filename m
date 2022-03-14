Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D38C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 09:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA7D10E37B;
	Mon, 14 Mar 2022 09:23:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D91710E37B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 09:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkMU9FfFhCOqSnJxrkjktlVqTVABYARBefmjBO9CeFuHFu9d5oufOQ6hMQqtrdpnN06c3Vwq5dJS/jUoK3ZJ9dJ61VRy1qhm8e+qfTmpWTIxs2FpSsQKufARnDw0oJPxv/vHvdcqT19ByGvdsK2yi9D8B9dSsQ/Z0cGfp/BlGU7bKyUFPBEsHQThNNfnIzzL1BoKn7ayTQ/jI/xp6PYJVMcyow5BFr1/b6pgwp9dH/XqYrQ1Z1eT+hfNcdEBY1qQK/ekSazh+eXT59uKw/BfhynLVrPsn052Q+GMEFBaGYArza3RxHf4qRf2+xSB36eANS6RvFucMtwKmBiC6wlcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEBLdy67x9y8ekOJZhVSs1Ot1pgBIZnoTlNF+Nt1EW0=;
 b=dpxd15Acp1Zz5MZp2YqogBD0zR2h3HCHzYNu53/sdZCiiFzTDzDYZj7rTNth7O6rVrYtZD/NMTCDNBSy32P0dH07PbyZKoPNHDQGQrNKuE7TIIUK8QPilQcsCCY+oWO+9y739pDAxjcozpXPwTayHskM3M8p12Y1ZWyT2vqHoAe+j433wkLteunJjg+5TuOv0Dc36zw4f34YIKLHePXPASX9KD2ngltbJ5frugAK9tdIvuW4Ibk92nKLXT9Bedio6e08PondybzYmZ/Xv3mAEetgCz13YKduw2n+QaVS82mOy/TWpKhoBuW1Ir3wXNCjOwXNW99/spdzkuUVN2lcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEBLdy67x9y8ekOJZhVSs1Ot1pgBIZnoTlNF+Nt1EW0=;
 b=4Wr9PtD+dSSrsU346PZY4Cp5R6xLmKIH5GDZ7+KZylo/rJb0mLII5CpfToV6LalYy5fwhvrxDR10FbOj1RWWRhoZ4OEL5dCHQQONdjvNH99+jRSsJG2QQP0ek4G1ST+/15cPu1OC2lkDEoG6rtnop20ittSNFX/l+v3WkrKLixA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CY4PR1201MB0264.namprd12.prod.outlook.com (2603:10b6:910:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 09:23:11 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:23:11 +0000
Date: Mon, 14 Mar 2022 17:22:59 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reject secure submission on rings which
 don't support it
Message-ID: <Yi8Jc5BRPe0bGZlW@lang-desktop>
References: <20220314024648.2201565-1-Lang.Yu@amd.com>
 <6b9a2eed-b6b8-f0ea-0254-dc07f39d62f6@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b9a2eed-b6b8-f0ea-0254-dc07f39d62f6@gmail.com>
X-ClientProxiedBy: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1e0d6f-c884-4591-d1ff-08da059c4235
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0264:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0264FA707F2AADF44FF1D488FB0F9@CY4PR1201MB0264.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce1ki4Jr+BKXTz+ECAaCzP1aLYd14A0SpUvolwXQuNRtUX+nzVDMqNf1LC7EkIInXkS6vnXur9d89XYtlaZaEWv6QqUh8/bMu0N6N4TeKaULx96pVtcXjBhwehgWuhTUSeBgZsIIxF+dFv5bnA2X5G0QPw83I0U8ZCURLdqT+D42YcMpM1n94Dmwns54fUYlTKeO8wXiYCuDkYQ/9mGfcXBqutHXV34PAAkFFJze5GNiPUA/Nf4HNuDVKoPFIoqSjjOny3IImBsJVCcaduV4kZGGMp0+Z/b7Zq1nWuxy5N7yLTY3F5s5zLv1NVWGUV+Vf8NoeCAgI8zu5EHjPnpWJnzmKlSTjyCYnnpJLftad4NTUGgGkh/cG7qBiLM1BODehfWp9kt3OZ/gu/KR54/Duvd0k6YsbQ7PBI4XrU147ecGEEg1KN6p7UN4631+tUGyqjbjzg33btGQU4/5iPktWvWhLD3UYHL9WoBBfpGnC4SO2gXFbUn85Pcxp+YvRrFO0BQT5o0tNW5alcLMLFsvsyLiT/EGB36qWAXyP9Mn8ROOs9MvRKb4x/M0MhprHbnZubDtOta+vUOmuYzgD+tniNupiPLdRg5lbyLT/8r/Wf/gWRDMEQDk6e+qvrbuMSnIbSfGG4VK1VYU5a5qPWt/0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(2906002)(66946007)(5660300002)(66574015)(508600001)(6506007)(8936002)(66476007)(66556008)(38100700002)(83380400001)(26005)(186003)(316002)(8676002)(86362001)(33716001)(54906003)(6486002)(6666004)(4326008)(9686003)(6512007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5h2jAQ9urM3s0x0PMTq8jc4jO6eCShfpMUbzrNaCyKPCgvueNtwYm/oWBa?=
 =?iso-8859-1?Q?GNAord0lDUWg5RSoTSn329+/1Q+grmvctDhP9AJzw8u1p/rVNvL+BP96oC?=
 =?iso-8859-1?Q?CXvnaROTqcv+xkqbW02D2wvv6ZebMw7Z8O6QbgG0zmKXj39IPNiO1ZY6FC?=
 =?iso-8859-1?Q?+dBrGu51sBF0sYRv5yKXom0JrKJ5VW5XmdnEuny6ds+nrcri1fn9ry+eRB?=
 =?iso-8859-1?Q?R774HQWC14Szuecdbvc5FF2LyH6SinWJDo+mdICCOm26uK01XxcxN9+F36?=
 =?iso-8859-1?Q?+lLkNSC5e7jrgnvxdbfdqPm7o/6uXWHDDPEmmsslJYZxroAoZGGBaaQC8A?=
 =?iso-8859-1?Q?Er3MY116WXRlKf+ecBy5GbJLyhfOmTuCbufKcfaftege/4qPzcwPZ5nGTs?=
 =?iso-8859-1?Q?TBHMz0XI7QFW4BO4IAf+X72kYrFJ23mESdjsX4i6fsjr1zCnYGx9eic8c8?=
 =?iso-8859-1?Q?Z7sn3Url9rnVK370yA/D+YCqp6xoIFElsqJwZmSGSuJR4eaggRY99ZJbOf?=
 =?iso-8859-1?Q?kzciAAfzWIAks11Kbg/Akvm+GDj2oIfLGEbOQOIRK4qJmok1m2QObiisC7?=
 =?iso-8859-1?Q?5l6iAIxsnBs+IQgSlhnjxrFqBTIL48j27UIULlPS9k5Syd77sy8PRUsch1?=
 =?iso-8859-1?Q?MgH+zpvFOZk5GHx1JqIEMGkbbLEjx6tq8dfIejEUYGwRgSBWIzIIWvdBDL?=
 =?iso-8859-1?Q?q6hf10i4RxWoxQTtUt70kHSQAWUOvqvrUqqwXJtBnBdCSxlvwHk15FCnN6?=
 =?iso-8859-1?Q?6071zooWB+b5n2foGmRVx1jGNk/7QumhYESiloDUwtVU+oCZxQHesZHYHJ?=
 =?iso-8859-1?Q?fsoEQhwxvQ3ZR0KhAd+sfj2iLYGGZzy5CIb2/bHiPkf060kmYwN3nY/rMY?=
 =?iso-8859-1?Q?Ur6GgmzVnKVgHPCz+zlzvWTgEz/VgFBv1kQDZrEpUXlBiCgVn45200xJKC?=
 =?iso-8859-1?Q?x2Za0n0HWcpgSvcg0HHYYlLpWqUIX2c7zej2h+xnKxn0W9HKLaaUCYEFOS?=
 =?iso-8859-1?Q?eiMUpQiU6gGR4QBbiEwXbJAFRLaoBEkAExjPNBpRFq2O4Cd5TfsYCBUxjt?=
 =?iso-8859-1?Q?G5GQJlD5UDd+QFtQYWUKQm/8WBNf0S6qhvdfR6Z/inLTQjTJr2JiWwh6VX?=
 =?iso-8859-1?Q?WEZ57ewnjUqCxlxA4Uta7smUmy+oEP8GvkP4CtEEZUnBUECO/vc+36ECWC?=
 =?iso-8859-1?Q?v0JkzWG9XP4EtnYDrHcBfgDfchzzwIxutwmRDmGIZdrg6JH4E9lZmOghjG?=
 =?iso-8859-1?Q?XP+bhL8fdRxqLaQ29dqvFy3zbwZTOilxS053vfjoy3YWY5n1xJEw4BYPki?=
 =?iso-8859-1?Q?vg8uSF5/ui2PbCNuT9BdLuAb2+umsYGmh6RYP72CqGlxX82IGQZpVWszIY?=
 =?iso-8859-1?Q?ceLki2/HZ1x55O2HfjTLT6QaUy6iwwLzAS9cwTqi/HgGgm+BmM7KuvXn7O?=
 =?iso-8859-1?Q?IHdQjHsM9LRUcpami9+xcAmmuxCIdFTgS5WQTIz7XO7C8qyMXu7ihX9vvQ?=
 =?iso-8859-1?Q?SKq0gXSWjtcqR2Rzq+vCgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1e0d6f-c884-4591-d1ff-08da059c4235
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 09:23:11.0988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs/Z8eOb67l/44ljUuZ4/ftuCvvMH0hHBSbxfgD/wsXG6GQyNzcVi/QBGKK0956BokVuQ+39Wqco5iSOgiMhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0264
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 03/14/ , Christian König wrote:
> Am 14.03.22 um 03:46 schrieb Lang Yu:
> > Only ring GFX, SDMA and VCN_DEC support secure submission at the moment.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> 
> it would be nicer if we have that as flag in ring->funcs, but that way works
> for now as well.

Okay. I will add a flag in ring->funcs and send another patch. Thanks!

Regards,
Lang

> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Thanks,
> Christian.
> 
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 8 ++++++++
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index bc1297dcdf97..840304691b92 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -166,8 +166,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >   	}
> >   	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
> > -	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> > -		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
> > +	    !amdgpu_ring_secure_submission_supported(ring)) {
> > +		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
> >   		return -EINVAL;
> >   	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index a8bed1b47899..3afe3d60e194 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -363,6 +363,14 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
> >   	ring->count_dw -= count_dw;
> >   }
> > +static inline
> > +bool amdgpu_ring_secure_submission_supported(struct amdgpu_ring *ring)
> > +{
> > +	return (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> > +		ring->funcs->type == AMDGPU_RING_TYPE_SDMA ||
> > +		ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC);
> > +}
> > +
> >   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
> >   void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> 
