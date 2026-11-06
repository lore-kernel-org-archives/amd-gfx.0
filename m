Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF2606D81E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6+7eQpk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFE9112F08;
	Fri,  6 Nov 2026 16:36:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58185112F08
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 16:36:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABDFA601BF;
 Fri,  6 Nov 2026 16:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BFF1F008A1;
 Fri,  6 Nov 2026 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793982969;
 bh=U8pLwdBHjGgkVA5afjjneYz6Dlzd6Ty07xbMRu7DXxM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U6+7eQpkHzA/GnqnyKReO9whEYykUdkCs3AH73zt4ZUOLuc5iVlfNgxZ/NWQVCIa4
 J5iLkbyd6vANBrQ995+K9K9M4rK5XSAMn6+OVwonmb+a2zeiERPtCB6tIOQX3ql7Lj
 EjzCvVI4Mw1gfWC0v3DScHjQaMQ3k9JWsBNKEJLh7aeb3Zx3YbHi5BOBxFMhLOLPTv
 4ducG3pvGmHaZoGbtDjPl0Qia8Zbb9SUkIygCgsQOTmqclaFWNxAVNZXoODp8kiaDi
 AiICLyitbqAfA/Mvf+6fxEFd+7yA/UwahK+I0Xq6IAJoWMtQDV71L09on5/uD+deLh
 8y3mVPhdYUH9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Honglei Huang <honghuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Trace <tracekotae@gmail.com>
Subject: Re: [REGRESSION 6.18.y] Please backport 342981fff328 ("drm/amdgpu:
 drop retry loop in amdgpu_hmm_range_get_pages")
Date: Fri,  6 Nov 2026 11:35:47 -0500
Message-ID: <2026-11-06-1-daily-reply-0012-amdgpu-hmm-retry@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105192503.228363-1-tracekotae@gmail.com>
References: <20261105192503.228363-1-tracekotae@gmail.com>
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

> please consider upstream commit 342981fff328 ("drm/amdgpu: drop retry loop
> in amdgpu_hmm_range_get_pages") for 6.18.y, 6.12.y and 6.6.y.

Queued for 6.18 and 6.12, thanks. 6.6 does not have the -EBUSY to -EAGAIN
translation in amdgpu_hmm_range_get_pages() and the surrounding code differs,
so it would need its own backport.

-- 
Thanks,
Sasha
