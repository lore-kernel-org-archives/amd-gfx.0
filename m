Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C8223B51
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C8223B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080CC6E570;
	Mon, 22 Jun 2020 07:16:55 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46616E113;
 Sat, 20 Jun 2020 13:21:45 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.75,258,1589234400"; d="scan'208";a="455762553"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2020 15:21:43 +0200
Date: Sat, 20 Jun 2020 15:21:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] drm/amd: Fix memory leak according to error branch
In-Reply-To: <119b7d8c-b164-ef23-84cc-4904d34ac023@web.de>
Message-ID: <alpine.DEB.2.22.394.2006201520590.2918@hadrien>
References: <119b7d8c-b164-ef23-84cc-4904d34ac023@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1522092164-1592659303=:2918"
X-Mailman-Approved-At: Mon, 22 Jun 2020 07:16:51 +0000
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
Cc: opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
 Bernard Zhao <bernard@vivo.com>,
 =?ISO-8859-15?Q?Felix_K=FChling?= <Felix.Kuehling@amd.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1522092164-1592659303=:2918
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 20 Jun 2020, Markus Elfring wrote:

> > The function kobject_init_and_add alloc memory like:
> > kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> > ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> > ->kmalloc_slab, in err branch this memory not free. If use
> > kmemleak, this path maybe catched.
> > These changes are to add kobject_put in kobject_init_and_add
> > failed branch, fix potential memleak.
> …
> > Changes since V2:
> > *remove duplicate kobject_put in kfd_procfs_init.
>
> Under which circumstances are going to improve this change description accordingly?

Bernard, please update the log message as well.  The mail you sent was
much more clear, but mail just gets lost over time.  The log message
itself should be improved.

julia

>
> Would you like to add the tag “Fixes” to the commit message?
>
> Regards,
> Markus
>
--8323329-1522092164-1592659303=:2918
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--8323329-1522092164-1592659303=:2918--
