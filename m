Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A21606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFTsuAkC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECC010F3A0;
	Tue, 24 Nov 2026 08:56:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0931110F3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 08:56:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFCBC41917;
 Tue, 24 Nov 2026 08:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBC51F000C0;
 Tue, 24 Nov 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795510600;
 bh=lQym4iegcHCHI6RF1PN8t2htK6D4aYkIo3giDA4EpTc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lFTsuAkCTMutuklXJsGw4OlnJ8BttsovCNTgEw+bTX2BTGjMUovo+nZt7SSA2uAEQ
 DE6j9LVeiTwTLNVlj0n3PBIFegeqYzIkyuJXKesfB10qlaH/WeSkWQQwKz1d+D/qdn
 3Nk7mucs07JJhQuMmc9vCMIUWFyOllgPB2Yx29LpCQLmww7He5dOIs1eaJn3PcCV9A
 6ZZ4RlbAd93wYviY507Y2+rHDXGozofknj53YadjY8n5frA59A+Rwifp8SvCoGAIz5
 z4Wz2bsoJP8Q2x8BKf/3omEvBEtBGjFTHx9nllhNNzgWkeF9hb0eUFvRu4JLIgcSiE
 CYWsRB9Thj8HA==
Message-ID: <sashiko-outbox-230755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/amdgpu/userq: don't restore user queues during
 system sleep
To: "Arisa Snowbell" <arisa.snowbell@gmail.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <2ba4e27796fb1777481bd91d8467439a85542a42.1795482456.git.arisa.snowbell@gmail.com>
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
 <2ba4e27796fb1777481bd91d8467439a85542a42.1795482456.git.arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:56:40 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdgpu: infinite retry loop in
  amdgpu_userq_ensure_ev_fence() [1]
--

commit 1073e972cefe081a3547954bcb099da6f1184516
Author: Arisa Snowbell <arisa.snowbell@gmail.com>

drm/amdgpu/userq: don't restore user queues during system sleep

This commit blocks user queue restore work from being scheduled during
system sleep preparation and moves the restore worker to
system_freezable_wq so restores do not race with VRAM eviction.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e8720..7960341f7f84f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c

[ ... ]

> @@ -453,7 +464,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr =
*uq_mgr,
>  		 * Looks like there was no pending resume work,
>  		 * add one now to create a valid eviction fence
>  		 */
> -		schedule_delayed_work(&uq_mgr->resume_work, 0);
> +		amdgpu_userq_queue_restore(uq_mgr);
>  		goto retry;

[Severity: High]
This problem wasn't introduced by this patch, but can
amdgpu_userq_ensure_ev_fence() loop forever [1] if
amdgpu_userq_restore_worker() fails to install a new eviction fence?

When amdgpu_userq_vm_validate_and_restore_queue() fails (for example
with -ENOMEM), amdgpu_userq_restore_worker() exits without replacing
the signaled eviction fence:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_restore_worker() {
    ...
	ret =3D amdgpu_userq_vm_validate_and_restore_queue(uq_mgr);
	if (ret) {
		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore ret=3D%d\n"=
, ret);
		goto put_fence;
	}
    ...
}

amdgpu_userq_ensure_ev_fence() then sees the same signaled fence on the
next iteration and re-queues resume_work in an unkillable loop.

[1] https://sashiko.dev/#/bug/linux-d9fc724f-ccb0-417c-8973-b83fdfc48280

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795482456.gi=
t.arisa.snowbell@gmail.com?part=3D1
