Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC1606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=sPfFgFWS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1D610F755;
	Tue, 24 Nov 2026 15:54:55 +0000 (UTC)
Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94D310E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 09:47:36 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=LF0q2K3tyOr7KGO2AG5QfLveDcN/YDA1xdf/RlJ8cxA=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795513654; v=1; x=1796118454;
 b=sPfFgFWSZ/DLKmxtyQGKLVTm+OtDZnY04H7mSHJnGuFt6x6TC+fIZyDjugWoF3q9aTm9XYG1
 z1vNAL3YLazW/6rXCHsL1VLkczwBclR66FyQbZXqhLXRym9wiR94gnOxV9G26b6EzVw/2dhmnQZ
 S2hPiN1O/fJxZ/QiSxKBgY1OG1qvpXRivY347kQLFxt3qKAp3EQ1zD7OtUG/IHCH6RGkbed+J3I
 AxJA8gYUwiSe9nQ9nsbCepSLIDxnODrahZf2ENs4m1n4qJZOITL3lOXbR7hq6Nq9VR1+jO9WjYZ
 gD6KVngjsGtH3vfHPgH1fEr/8eoYsuAl41ctVRgUPFQTA==
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 45a6dc87a3d4f534;
 Tue, 24 Nov 2026 09:46:31 +0000
X-Mizu-Trace-ID: 45a6dc87a3d4f534
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 17:46:25 +0800
From: Weijie Yuan <wy@wyuan.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/amd/display: document two members of dc.h
Message-ID: <awVc8RAMO75SFkxV@wyuan.org>
References: <20261123122226.4101191-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123122226.4101191-1-takano32@gmail.com>
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 12:22:24PM +0000, TAKANO Mitsuhiro wrote:
> Two undocumented members in dc.h, both reported by kernel-doc: the union in
> dc_probe_status has no description of its own, and the comment of
> mpc_color_caps does not mention max_gamut_remap_coeff.  Both patches only
> add comment text, so no build was run.
> 
> The diff is unchanged from the previous posting.  As Weijie Yuan suggested,
> the AI disclosure moved out of the commit message: it is now below the ---
> in each patch, and it is also in this cover letter.

Tested on my local machine, the warnings disappear.

Tested-by: Weijie Yuan <wy@wyuan.org>

Thanks. Jon would be happy about this, I guess. ;-)
