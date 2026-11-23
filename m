Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A237606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCCsIRUA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A218D10E165;
	Mon, 23 Nov 2026 07:38:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B4010E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:38:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1713A612B9;
 Mon, 23 Nov 2026 07:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCEC1F000C4;
 Mon, 23 Nov 2026 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795419481;
 bh=tUVTdBEvY+JZmR4XVnMUbu7qxTNG7tms7ARAes8HZqc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=iCCsIRUA4yQ4o9kYRqJuAR4PhPGgX6iHRchTjGEqLK5Ji9TIHz1WnWimPY6OQVWi6
 606QD4WN8+GNUAat6YKVGWUyNfZ8fev7e8EnIDOK9DkJlHI3UsWItD7YDd1Hlg3jxP
 uE94tNSD91O350OSy4JIffUr2IbS9UJOwG36G0lMlYZ4Df0O8l6/oYEU8Q4hQhb91a
 Y8wu/AdRXhknbxY5gylm2qAML8z7wSQYu3dZzxV3WnEU9v/t/G2v5m4mcsOt7F2Vwc
 YTXURf9i+SYjMM0YwpI1KO2vG6IsQwPBNbd8jaUsjWI3gOMcbKBB4cgmIRtq8QbgJE
 yIl8FrbrcOHEg==
Message-ID: <sashiko-outbox-228826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdkfd: fix deadlock between profiler_lock and
 dqm->lock
To: "Perry Yuan" <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123072247.3612981-2-perry.yuan@amd.com>
References: <20261123072247.3612981-1-perry.yuan@amd.com>
 <20261123072247.3612981-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:38:01 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/amdkfd: race in kfd_process_profiler_release() disabling
  perfcount
--

commit 887c47d311618fed50bfb8220d55513cc2a5a998
Author: Perry Yuan <perry.yuan@amd.com>

drm/amdkfd: fix deadlock between profiler_lock and dqm->lock

This commit moves the set_perfcount() call in kfd_process_profiler_release()
outside kfd->profiler_lock to avoid an ABBA lock inversion with dqm->lock.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6663718fb83ce..b63535eda02b3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1178,12 +1178,17 @@ static void kfd_process_free_outstanding_kfd_bos(=
struct kfd_process *p)
> =20
>  static void kfd_process_profiler_release(struct kfd_process *p, struct k=
fd_process_device *pdd)
>  {
> +	bool release =3D false;
> +
>  	mutex_lock(&pdd->dev->kfd->profiler_lock);
>  	if (pdd->dev->kfd->profiler_process =3D=3D p) {
> -		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>  		pdd->dev->kfd->profiler_process =3D NULL;
> +		release =3D true;
>  	}
>  	mutex_unlock(&pdd->dev->kfd->profiler_lock);
> +
> +	if (release)
> +		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>  }
> =20
>  static void kfd_process_destroy_pdds(struct kfd_process *p)

[Severity: Medium]
Can clearing profiler_process and dropping profiler_lock before calling
set_perfcount(pdd->qpd.dqm, 0) race with a new profiler session?

CPU0                                  CPU1
kfd_process_profiler_release()
  mutex_lock(&kfd->profiler_lock)
  kfd->profiler_process =3D NULL
  mutex_unlock(&kfd->profiler_lock)
                                      kfd_profiler_pmc()
                                        profile_lock_device(..., 1)
                                          mutex_lock(&kfd->profiler_lock)
                                          kfd->profiler_process =3D new_p
                                          mutex_unlock(&kfd->profiler_lock)
                                        dqm->ops.set_perfcount(dqm, 1)
  dqm->ops.set_perfcount(dqm, 0)
    <-- disables perfcount for new_p

Once profiler_process is cleared and profiler_lock is released, another
process calling kfd_profiler_pmc() can claim profiler_process and enable
perfcount, only for the exiting process to overwrite it back to 0 across the
device's queues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123072247.3612=
981-1-perry.yuan@amd.com?part=3D2
