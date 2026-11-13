Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211E606A32E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyuWs0Gf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2560510E807;
	Fri, 13 Nov 2026 15:05:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6D810E807
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:05:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD41C41622;
 Fri, 13 Nov 2026 15:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DF81F000C4;
 Fri, 13 Nov 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794582348;
 bh=vznAgsK457Luf7HXa+1Pg75Q92WIClVmYJyIEI+z+6g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=DyuWs0GfU30q63twgXPzj/q6frbYw5QxhOukRv1kXD4JtrPNb9aSc5zFAxsh+Crsw
 uSQfEBOVab13Ayv5b0bCG98ioB54ykEcHX6OuCtNqNJK6iXL4mh9EILvVGpCHVsTFM
 TLZEFSUavVemhcsOGbCcxADtNFg0GgiztVMpcLcllCxWF3P0GCE2Mgd8pHCon7jKga
 Poa4ysyx+GIoykP1tJbozfzVnB2QNO/MaUqAnJrfj8WUaOsKYi/YJqZMXIKe5h6EFn
 rA45o60u2LWl/hIuyXsRv65hS6ieiLrhHma1JR82h4VTbdvREVraDlaLYGcnCGhtju
 +HU++QHOhNI5A==
Message-ID: <sashiko-outbox-213050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/amdgpu: align the sysvm GART start to 8GB
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-6-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-6-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:05:48 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdgpu: missing Fixes trailer for sysvm GART 8GB alignment
  fix
--

commit ac03025c9ec955f71abbea2e6a6172fcff3e1a6c
Author: Zhigang Luo <Zhigang.Luo@amd.com>

> drm/amdgpu: align the sysvm GART start to 8GB
>
> PDB0 block size 12 covers one 8GB entry. A GART start aligned only to
> 4GB can land in the middle of that entry. Align the sysvm GART start
> to 8GB, and use SZ_4G and SZ_8G in place of the local size constants.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

[Severity: Low]
This fixes the 4GB GART start alignment in amdgpu_gmc_sysvm_location().
Should this include:

  Fixes: 2f405eb45c55 ("drm/amdgpu: enable pdb0 for hibernation on SRIOV")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D6
