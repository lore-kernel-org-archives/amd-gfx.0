Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF14606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAy5D7oR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C5C10F596;
	Tue, 27 Oct 2026 15:22:36 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A34810F596
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:22:29 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-7c05859ec4dso210951137.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114548; cv=none;
 d=google.com; s=arc-20260327;
 b=XKaE3qlNmVzj6o4bC8j6UMkOf6Tvsck/mrxq2Lb0kCzRdlRdED/qRc7c7iXeOF3mYS
 G7b4UAymdIUi2HqyME7OsgAhhBraVJ+v+Cy8tRNFiU7a9aAb2Kt9EM5c40rQlfjkFYf5
 lq55zY0ofieBuS+SRwodpcSIJhBHexEIlL9UFJeD5t6pI8CsQy2y2h9gydRyhUP3x3Sn
 pijM5ZOs5+2HqAhvx+VFJ2Yp6lwHKxIKRAkSl1q0kTZ+OF0Qc6uiHT3kohExdz6U6Jt/
 3HuvgXItU1tpUMgPFAtfurbOwosIEJZA37Ey4nsJr9/3roxqlXOLdAgufz5JoSXdwo1w
 V+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 fh=6hiF2Pd7EzSem52PRj84aYw81uxFv/VUc7vM+2ypo1U=;
 b=aiwbZicjmWlSH+L866rHnHKpF+iz2PWXh8Z+L6A1bqZT8ZScZa3/u4mpmYIwFB71h+
 HGpqDbP/ue39iT7zIPO+O4LfXhGCImQF3YhOhahHkKvTTeZ0Nii7PRtLZs1Tuidf8Jo4
 5A910vcGX8P2DZGsdo9UvideIx2JDUJopHN+qcE+dLx1LFG0Bhxblbw7XzIEsdIiu1s7
 wKBDi75yXO5p++m8HssTySnki8T0JvbMHw/PUSqemeUxK7bsLqCM5PSy3ikIHzx+CZ8R
 /T4NxLTqA0D5PVnm44/yK7DfPvxJbkM+8om292vk3hbFx4nAA8xyVv+wKLrAeMNWV2F1
 hNBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793114548; x=1793719348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 b=FAy5D7oRF9k9sY5C6/vK2lVsfISUyVziIwCWz5bBgyJuDiKNKniqMWEOmTiTnQhwpe
 r4EO0Sf9TXU9LY0DQd1Uc+UrKXvuvwPKXobV0VEloen6y2fNJj3L4YFw9NsUNahWtFQq
 2DrztvLUC042BOgetWZsre/AAvBv4cEbVmh+DctAIq/PYEMxLV5v0/qdW8z3t+JvlF+o
 4pxXBrJcnOMl4TfmwBzxJkjSTXr2Jb9zZmrA/hOgO2O41/tmYuzXdwzwVsqPp+d8Lx8N
 qNyDTCy/UpWPwvtwp8r0rGIZMPQ0YX/jZS293UJSNI/tq1K6QeSbNaFfqJoQm1VvIUGi
 HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114548; x=1793719348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 b=Zwb9QtKByNGO5r53txn2Vdj7SFXIU9vxLcDx1zOvvrLk11QxMEi2VMdbR5hoHriBJG
 OJ5F9vuvTzyjG4y3Z6jKHSWdHDuJmEDm3d1XsIziuUWxDvSWM2BvqZ6IABcOcaPSw4rR
 p0eBqpB3ie/ypmpHab1ILoEU4tP/btfqQ8q3tdM2Ff3KSqaeOAVnhmw1lJqxu32udkbz
 RZhvSzdzt9N2TkaAhAP92RCyTnIUA5ZzMo8/h04z/Q3clsOJEm+E2XtQZJYreHWdckbc
 B39+0qUCt2ybgfRCKKQi27cEIHKEn46xBCRHdsZ0YlUaPoIVNke1LLMYCp4/uT/z4/WU
 uNAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZBkmVnYEZoVt/sAe3a83q7JBLfWHITyPMQsYWIuLo01Y4NUqoUfV2e+fNcLJtyKj/M9RWRFx0@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/sN0ltTGXEB+iZFP3NzPHwyl+0VFPr5VKgbYAuqJDKFxWJh7Z
 ohHbilYEq92aaBKlnI/kCJ0AC+bautp1SBK3FIivI1vQUwbsHbWY+TIjhVFk/akxl03KdmHStIY
 lN19uUzyB7AuzLDCzUYorGOdmZ+x12aw=
X-Gm-Gg: AYBFou3CeWrZ9vShIWT0GwL3Z3cqN6Mdzhmtw1M9BfJREQ8tepKRJ+Ha5B7ls0ljVwF
 UZmmyZBxU/U+xDKV2e9N++ZaYi9KQV6qL5a9QAVG1/C6ZjGZCv2euQjYlsdzlh6c0hr2wjhdfzN
 bvtCpGQgtEg+fY/JC0e12jRtFCdeQ0sUR3CUVjNdXAsJYIb8MvY6GLv6ZxY32rlABU6i8yWDEJo
 5TFab9oGrGXa9FXjra+WN462yYd6pF7bWEXlRrM5V5CmN1I//dINwaHdRRn4tpPRETkhXrhuTzC
 vxU8OFZ9LI2TzkQkJVkejFwymrg775vISP9QFbpT5Lx+T7ISKviXNf6L3iPoeWd6XcIfkOvaSpZ
 1wtx8oziRJfhcFrjtIUP3Te6BDhjHi1L6vABwaWAEuYrC2lpuXzAuoZVbI2ghED7YqsKQKSmrq+
 UoZfmLG8EcS420y2bdKeopSbk=
X-Received: by 2002:a05:6102:3250:10b0:7cc:174b:f7ca with SMTP id
 ada2fe7eead31-7ce5c6ba0dfmr4003174137.0.1793114548478; Tue, 27 Oct 2026
 08:22:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
 <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 11:22:15 -0400
X-Gm-Features: AclHuK-Adz3pXhRznVuw9H0EI3Am4aff3rHKztB_BB4zRj3ojyCoORRQiP8JW0I
Message-ID: <CADnq5_PYSbB-Ges6vVgNcR4ZjYH4TxLZeAShifdV9uuH8swQzA@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bp@alien8.de, 
 christian.koenig@amd.com, dave.hansen@linux.intel.com, dev@deq.rocks, 
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com, 
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com, 
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 4:29=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > You can drop this.  Nothing about this is GMUX specific.
>
> I agree, but there needs to be another variable. Using pm_runtime_suspend=
ed
> or using any other pm function will not work, as amdgpu_pmops_runtime_res=
ume
> also requires hardware access and even though hardware is accessable by t=
hen
> pm core will show that its runtime suspended.
>

I guess the runpm code doesn't update the status until after
resume/suspend?  If so, call it something like runpm_active.

Alex
