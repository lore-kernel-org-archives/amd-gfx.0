Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E5FC54EEB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 17:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E98D20714
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BhKqX+ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F106E39E;
	Mon, 23 Mar 2020 17:35:00 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20077.outbound.protection.outlook.com [40.107.2.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5DA6E388;
 Mon, 23 Mar 2020 17:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF+FvWWg7baxIez2CjaOvP0rE51kWuKNOa3vA5Cpq8qMp1bHNbZMS5CWtMdIz7Wvsz+fVtSiWS2CELbadasDn17ZCsQavukd6vqg01XbH2fznSIUqy/BpQdQRjeCa3lf1+0iSqFXQB3ArS2h38eKpN9g+ItVnGtthq/887HryrkrI4zU9xHTpYS4tjxrPDUDagN8XRcb7MG1CmUVDXRLQX8a6kmkBxrUWZcri2n9jycBeFRJ5YMeMXzutdRVsoVAm7B1+rSB/35Q1Yd9c+bzMS1RcQKvsZQgMDLoVYEQglM+Cg7BiucFHRnsq+FXqiQ509Cche/+nABh/Zbekp/tFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aYGZtgxLWnMS9+t8vXikz+DnCYM/pEgWjcDgeOIR9I=;
 b=IQEK1KPP893f9aoX+yxhZm+YMdvKIVlvm4eoi/H7Fg5kVoq8ad9+plQCLMNkrewwCtEDuzA7RJelbKA/HQ+UKIhInGNpwND1FXbT6ZkBvNPMUZbfoUSsvYafQ7CG6aRA55/f1x8HnBvcccu8fAgCl6hUeIGZVopisYkEoWfhQCQF60oerKG7QfRv1ygV3W3uS+1scKivb8j/jOf5KLIiAZDQPsipt38szq8vvaCKlJIY7+S+MGGPcfD7WQmlH9/Qpb4AAnHBCSUgrtBfwMOMVPwtEl0oswOuQ9TK5fsTDi/FSN8IjRl9pMV6dU8hh8k+oFe8sML7ZpzQrSYr5i99+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aYGZtgxLWnMS9+t8vXikz+DnCYM/pEgWjcDgeOIR9I=;
 b=BhKqX+tahxRFzcFFialwwWvqXgIylQ65GxEeEDpdbU2tjldgeq6s6l1TfTKXOhorHNmQxul1APSMrhmB1Nd4Rkh5fclPB0PUU7sRx4KC9ZL2z6FGR27Gu0bdC4l4B9rf7GyCd/J2l4dUXr/ybW96XMkHS5Mp7K5+3FwmK36Ms0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4975.eurprd05.prod.outlook.com (20.177.51.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Mon, 23 Mar 2020 17:24:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 17:24:30 +0000
Date: Mon, 23 Mar 2020 14:24:27 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH hmm 3/6] mm/hmm: remove unused code and tidy comments
Message-ID: <20200323172427.GZ13183@mellanox.com>
References: <20200320164905.21722-1-jgg@ziepe.ca>
 <20200320164905.21722-4-jgg@ziepe.ca>
 <20200321083902.GC28695@lst.de>
Content-Disposition: inline
In-Reply-To: <20200321083902.GC28695@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by
 BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Mon, 23 Mar 2020 17:24:30 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)	(envelope-from
 <jgg@mellanox.com>)	id 1jGQoN-0006bW-2j; Mon, 23 Mar 2020 14:24:27 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec563947-3605-4a87-f07f-08d7cf4f0bfc
X-MS-TrafficTypeDiagnostic: VI1PR05MB4975:
X-Microsoft-Antispam-PRVS: <VI1PR05MB49752C5808723D5C4B5A038FCFF00@VI1PR05MB4975.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(2616005)(52116002)(66556008)(66946007)(66476007)(186003)(26005)(86362001)(4326008)(1076003)(2906002)(36756003)(5660300002)(6916009)(81166006)(81156014)(8676002)(9786002)(9746002)(8936002)(478600001)(33656002)(4744005)(54906003)(316002)(24400500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4975;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOFiHOrM8NQmECJ2EKP3GCMUVKBl7til0THfn8XCrprvWVP4hsTOY4FmISkTIizkNDMedvZyinG2rX6602gNlEzV8gO9T/9thP85Mk1ooo7h2LRaFNThynX0OIvBHxIYzE+2bsVodD2IUqqPqGjWxmckt41t6ZtvlR5vZ6tks7FfAmMgqEq+2okUY0DIFushKzDVbEJD/dmjdfVeFW6Em9Mzy56N+wveyk7blczfpyuo92syU+A/5iTmxDpcti0iUoe8ME6ragWiCl3vT0E9g8zbDO5qKi6OnXafMuA66ubDZ6TCAV3wKP1E/6XdMLt0g55jJGrqJOWpBOvA8U2mEqgPSoAU8CPyjB5a/QpdyClvsdVFAqAhGB8LgppcBiCVcT+lJoB/dczcxvhLedn0l6t2+Kv7u5uAQ4TZZeeQGJqpckLh8w3YbPxd41rSSeLvwxJSmP+gKlU3AAMJ5J+FBetIwdtLePq+8O/XkbIjJnsXrWhJhRfVRlmS5WkPMtEO
X-MS-Exchange-AntiSpam-MessageData: PhjtyFT8N4JaK77KxdbDI3TiM+SnSAlw3iDyhdK9lekggkJP4Ro/b7cbGzX/X5ld8/ZzLQDtbUIVN61SRqOCUduguKsyDJDsMmQEwUD4oLam/ULLWrynb1Zbc7h21qfRovHkWyCdcrTu/mbTFRLsWw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec563947-3605-4a87-f07f-08d7cf4f0bfc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 17:24:30.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoeIR6lpz8lEM6qZKwhsi5RjiLkLmt/9lOg/80PaSDhKDdkOoqoK1g0uc+XCYTAizPLRxFKgvucCThTmESgAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4975
X-Mailman-Approved-At: Mon, 23 Mar 2020 17:34:57 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Mar 21, 2020 at 09:39:02AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 20, 2020 at 01:49:02PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Delete several functions that are never called, fix some desync between
> > comments and structure content, remove an unused ret, and move one
> > function only used by hmm.c into hmm.c
> 
> This looks good:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

You mean Reviewed-by?
 
> Btw, the top of file comment in include/linux/hmm.h really needs some
> work as well.  In fact I think it should be mostly removed with any
> remaining useful bit moved to Documentation/vm/hmm.rst.

Okay, in v2 I'll just deleted the top, the only thing in this file now
is hmm_range_fault() and it can be adaquately described by its
kdoc comments.

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
