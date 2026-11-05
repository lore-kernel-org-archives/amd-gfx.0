Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D329606A32D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYlPkkl1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2679110E952;
	Thu,  5 Nov 2026 18:39:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430C610E952
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 18:39:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 521DA60145;
 Thu,  5 Nov 2026 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D83F1F00919;
 Thu,  5 Nov 2026 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793903970;
 bh=WIttHt8MLH2jTSzYQheQYAwliFTwRr5jOJrAPBStUTY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fYlPkkl1UWp59eaHviUuKF0kvPT5meJXMhgf5goGnST46E1uOji7Gbhn4sF7UTOj7
 j0iFaO8HEq/rX7rvs4CYGBP1EyFnNtMAaMkD2BRzpeiC2hj9KuuIbDWco4OeNG3gKJ
 zojeAc6iRaQokNryQGrs8UZQRH3nc4ml9ukaP/4x6/NS89DnuS+9+YAAlVZqkBi6qy
 XorXmPg7njmlU55bYAMcyMqkrzZNvuRGRYyph4Fk5Hz9/WMRuz0e0tC64q2OQgCNi1
 DzKripSPhOsXSZH5wp74mJkvhdleSEj9wo1wnHzA9hakbGaCoaz6IeISIf1T/3pKsB
 X8ojoJJMasX2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
 harry.wentland@amd.com, Wang Jiang <jiangwang@kylinos.cn>
Subject: Re: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Date: Thu,  5 Nov 2026 13:39:13 -0500
Message-ID: <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105090543.930342-1-jiangwang@kylinos.cn>
References: None<20261105090543.930342-1-jiangwang@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Restrict the pre-update call to DCN, matching mainline behaviour.  The
> full mainline rework does not backport cleanly; this is the minimal
> equivalent for 5.15.y.

This is a stable-only fix with no mainline equivalent, so I need an ack from
the AMD display maintainers before I can queue it for 5.15.

Alex, Nicholas, could you take a look?

-- 
Thanks,
Sasha
