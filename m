Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B230606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Loe3YdWj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982710E41E;
	Mon, 23 Nov 2026 19:34:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD7C10E41E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 19:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C52941F25;
 Mon, 23 Nov 2026 19:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7891F000C0;
 Mon, 23 Nov 2026 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795462445;
 bh=M42rtRif4dGwX7QeaEBWp8ntTVTmhc/2SVJqjTFyX+8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Loe3YdWjQY9XsWlGzKHN5qYsBXLNEOvIokKk3nhT7MDOa+2JkfoeR4SDJXukLhWt/
 tmtPiGgVxLUpzyAKZCvXUsU/R8LcRvGghKyWsdr14x2MNLFtFWwFPhDwM4Rz1TNjrm
 emWoW6jUrHuVh0XS8f6gK9xv64mmEdWK8MJK8lMOlArKDO+GZJ3FVoA/T3yYdEb6y2
 mh8/eM90I275wz/pgEvNN2IESoBWugmwrVBRMdEMkC/0x7sw+zMmF83E7O/IG3wlLg
 0ReY1B6Deotru4wpBzSFFfJWbcEdnIxncQ50jVIUk68qX6J1ZrdUnF2sDBJPVjvNcF
 CUGyb4RjAmU+A==
Message-ID: <sashiko-outbox-229943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU
 restore
To: "David Francis" <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123192532.2062064-1-David.Francis@amd.com>
References: <20261123192532.2062064-1-David.Francis@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:34:04 +0000
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
- [Critical] drm/amdkfd: missing bounds check in
  kfd_criu_restore_queue() [1]
--

commit b6c60f35cb12af1932936a6a6d849d52fd98120b
Author: David Francis <David.Francis@amd.com>

drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore

This commit scales the expected mqd_size check in kfd_criu_restore_queue()
by the number of XCCs on the device.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index b68e884b1c37a..2b86d359c4065 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1041,7 +1041,8 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>  		goto exit;
>  	}
> =20
> -	if (q_data->mqd_size !=3D mqd_size_from_queue_type(pdd->dev->dqm, q_dat=
a->type)) {
> +	if (q_data->mqd_size !=3D mqd_size_from_queue_type(pdd->dev->dqm, q_dat=
a->type) *
> +			NUM_XCC(pdd->dev->xcc_mask)) {
>  		ret =3D -EINVAL;
>  		goto exit;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can an unvalidated
q_data->priority cause an out-of-bounds read of pipe_priority_map[]
[1]?

kfd_criu_restore_queue() checks q_data->type and q_data->mqd_size after
copy_from_user(), then set_queue_properties_from_criu() copies
q_data->priority into qp.priority without checking it against
KFD_MAX_QUEUE_PRIORITY (15):

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:set_queue_properties=
_from_criu() {
	qp->is_interop =3D false;
	qp->queue_percent =3D q_data->q_percent;
	qp->priority =3D q_data->priority;
	...
}

When pqm_create_queue() invokes the hardware-specific update_mqd() ->
set_priority() path, qp.priority indexes directly into the 16-element
pipe_priority_map[] array and writes the result into the MQD, which can
crash the kernel or leak out-of-bounds kernel memory through a
userspace-mapped MQD.

[1] https://sashiko.dev/#/bug/linux-ce93c1d0-79a1-4b46-89c1-185592185549

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123192532.2062=
064-1-David.Francis@amd.com?part=3D1
