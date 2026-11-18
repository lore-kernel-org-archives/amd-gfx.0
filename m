Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99027606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVND3sst
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72EE10E103;
	Wed, 18 Nov 2026 06:06:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582B610E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 06:06:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF55C61908;
 Wed, 18 Nov 2026 06:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0B21F000C5;
 Wed, 18 Nov 2026 06:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794981987;
 bh=xwLXgQ7wyv4wFTi4+R4hHTcGi2J34PH1sX0JzKiOmGc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WVND3ssto/BsHMLNfdpXvCmBTU+CvvD6LpeKS+cLtA9rTGmOVGXf/pyPLoBTwok+w
 dEc7i4tsn1EjxveqnGsMkAF4P03toBRiPvlkjm9vtLA1ioVZ3etF009ILz58zjp8/Q
 2LISQ4z6L8XYfFdpxKlWrprOSn9d1AwxZsO/dj7EcV3q4SituRYtfTT0MI3hKqVBxX
 X72cr30DQhMcERPgja6PGnhAPJhqOVqxbJ8UP1BL9+uR/NMUQCw8GBYHvKYmmyJ69K
 SbO5S02PYR1fFYE6eduHtAve4Q3vEalOTsTAjociBcs48VoWDn447qoy6L05eY4M7t
 vfwdiLRHFH3QQ==
Message-ID: <sashiko-outbox-220202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdkfd: return the memory violation data to the
 debugger
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118055009.3005630-2-Jesse.Zhang@amd.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
 <20261118055009.3005630-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:06:27 +0000
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
- [Critical] drm/amdkfd: use-after-free in kfd_process_destroy_pdds()
  [1]
--

commit 27e966c319a74439c4a48d13a51742cea89473d5
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdkfd: return the memory violation data to the debugger

This commit records the size of GPU VM fault exception data in
kfd_dbg_ev_raise() and frees vm_fault_exc_data when destroying the process
device.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..16131fdc55468 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1253,6 +1253,7 @@ static void kfd_process_destroy_pdds(struct kfd_pro=
cess *p)
>  		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
>  		mutex_destroy(&pdd->doorbell_mutex);
> =20
> +		kfree(pdd->vm_fault_exc_data);
>  		kfree(pdd);
>  		p->pdds[i] =3D NULL;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can
kfd_process_destroy_pdds() dereference freed pdd->dev and pdd->dev->kfd
memory [1] during device teardown?

When a KFD process exits, it is removed from kfd_processes_table before its
release work runs on kfd_process_wq.  If kgd2kfd_teardown_processes() runs
after the last process is removed from kfd_processes_table, it returns early
and skips waiting for kfd_processes_count to reach zero:

drivers/gpu/drm/amd/amdkfd/kfd_device.c:kgd2kfd_teardown_processes() {
	...
	mutex_lock(&kfd_processes_mutex);

	if (hash_empty(kfd_processes_table)) {
		mutex_unlock(&kfd_processes_mutex);
		return;
	}
	...
	mutex_unlock(&kfd_processes_mutex);

	/* wait all kfd processes use adev terminate */
	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
		cond_resched();
}

CPU0                                  CPU1 (kworker)
kgd2kfd_teardown_processes()
  if (hash_empty(kfd_processes_table))
    return;
<device teardown frees kfd_node/kfd_dev>
                                      kfd_process_wq_release()
                                        kfd_process_destroy_pdds()
                                          atomic_dec(&pdd->dev->kfd->...);
                                            <-- use-after-free

[1] https://sashiko.dev/#/bug/linux-89a2e0c3-8eea-4d17-956c-8aac02272705

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118055009.3005=
630-1-Jesse.Zhang@amd.com?part=3D2
