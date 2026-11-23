Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CE606A32E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=vMrD7IR0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E4410E749;
	Mon, 23 Nov 2026 08:30:16 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 04:26:05 UTC
Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07FF10E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 04:26:05 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=xxZ7A6ARsfw5U5c4K3zdosZhEZzO/c/7t/gvu6JAhj0=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795407964; v=1; x=1796012764;
 b=vMrD7IR0YZIwExO/so5m5e8eVmAG3oXS7zYqhlJeJZMuNab5kDBsorwi1VnNuDpcPylznUti
 NOJuPa/jWFGFT0xUf52yb4eIo3nRfE9//re188/6W8KrIhFg0hItQVeCk26E7cZLAfuI0dEGxk2
 jqr4KxQSn2OBB25KM/HWicRTVjhLhEh/YSCHz6jBuQIrgOCIAATeoG5Th9qpUC9wdREPeyswagh
 0HgQxtuE6Scyjc9sczmNmx92Dc+r/LGY6vON6MtrXNhhymM+zEfonytEyVwW8fM/BXauram8cif
 wEdq8nGpewB8DbmwtuTfhr5OevGvswv5Vf1LEv+5RVFvg==
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 53e2255c13b2d2f8;
 Mon, 23 Nov 2026 04:19:59 +0000
X-Mizu-Trace-ID: 53e2255c13b2d2f8
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 12:19:55 +0800
From: Weijie Yuan <wy@wyuan.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Document the union in dc_probe_status
Message-ID: <awO-665NEGdZtq1z@wyuan.org>
References: <20261121041427.1743954-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121041427.1743954-1-takano32@gmail.com>
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:30:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 04:14:26AM +0000, TAKANO Mitsuhiro wrote:
> The members of the union in dc_probe_status are described one by one as
> @u.bandwidth_mbps and so on, but the union itself has no description, so
> kernel-doc reports:
> 
>   dc.h:2225 struct member 'u' not described in
>   'dc_probe_status'
> 
> Describe it, saying that the member holding the result depends on the
> probe type.
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran kernel-doc on the file with and without the change.

The disclosure is appreciated but better put it ..

> Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---

.. here.

Thanks for doing this.

>  drivers/gpu/drm/amd/display/dc/dc.h | 1 +
>  1 file changed, 1 insertion(+)
