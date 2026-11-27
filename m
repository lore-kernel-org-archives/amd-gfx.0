Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC0606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc6oKiOP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E30112E06;
	Fri, 27 Nov 2026 22:08:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D0910EA36
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 22:07:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60A6661286;
 Fri, 27 Nov 2026 22:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036081F000C1;
 Fri, 27 Nov 2026 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795817276;
 bh=C/aF7F9pk391De3mOlmIyo1zWltEbhwqaQoLX2Uxkhs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Fc6oKiOPa57RNfhfNt8c8MZyCZifXw/MI7nB+fP+ehi5V9LCQhGxW5r9h+zpN2hr1
 BwSOj9nDsTgXfYF3PcYS61CaXzmxk098N81d1OE0ukxM5ZglOizswlImdComcI0tIm
 kpL/UWP3mposr/2+f2MXmCV1cO/LmOpwkvbsirekTs0zpbdIc2TlSQZQNLDLhXZZFB
 7f17Lp4lTx6vBGQYNH9eQexINAtIL5fs0yKBJFhqv7XyZf2N+4xIPo+jaI3biQ/MsF
 fkq8W1DkNMAZmhhtXZ8yIXh9pd9ORUUy2AWWDQ608EYZvdPxsRFbndUGLgESFdkTih
 S8AQGOdhBReVw==
Message-ID: <sashiko-outbox-238320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: refuse XNACK for a secondary context
To: "Yongqiang Sun" <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261127214544.1058794-1-Yongqiang.Sun@amd.com>
References: <20261127214544.1058794-1-Yongqiang.Sun@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:07:55 +0000
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
- [Medium] drm/amdkfd: missing primary context check in
  criu_restore_process()
--

commit 03c779d2c6f68cc91d9f9a720f82e6527cf327df
Author: Yongqiang Sun <Yongqiang.Sun@amd.com>

drm/amdkfd: refuse XNACK for a secondary context

This commit disables XNACK by default for non-primary KFD contexts,
rejects enabling XNACK via AMDKFD_IOC_SET_XNACK_MODE on them, and drops
retry page faults arriving for non-primary contexts in
svm_range_restore_pages().

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 5a7f4f0cd0ce7..1aa2b8480bffc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1775,7 +1775,9 @@ static int kfd_ioctl_set_xnack_mode(struct file *fi=
lep,
>  		if (p->xnack_enabled =3D=3D args->xnack_enabled)
>  			goto out_unlock;
> =20
> -		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
> +		if (args->xnack_enabled &&
> +		    (p->context_id !=3D KFD_CONTEXT_ID_PRIMARY ||
> +		     !kfd_process_xnack_mode(p, true))) {
>  			r =3D -EPERM;
>  			goto out_unlock;
>  		}

[Severity: Medium]
Should criu_restore_process() also reject enabling XNACK when
p->context_id !=3D KFD_CONTEXT_ID_PRIMARY (or should that check live in
kfd_process_xnack_mode())?

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:criu_restore_process() {
    ...
	if (process_priv.xnack_mode && !kfd_process_xnack_mode(p, true)) {
		pr_err("xnack mode cannot be set\n");
		ret =3D -EPERM;
		goto exit;
	} else {
		pr_debug("set xnack mode: %d\n", process_priv.xnack_mode);
		p->xnack_enabled =3D process_priv.xnack_mode;
	}
    ...
}

Invoking AMDKFD_IOC_CRIU_OP (KFD_CRIU_OP_RESTORE) with
process_priv.xnack_mode !=3D 0 on a secondary context still sets
p->xnack_enabled =3D true.  On per-process XNACK GPUs, update_qpd_v9() and
update_qpd_v12_1() then program the secondary context with hardware page-
fault retry enabled while svm_range_restore_pages() rejects its retry
faults with -EFAULT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127214544.1058=
794-1-Yongqiang.Sun@amd.com?part=3D1
