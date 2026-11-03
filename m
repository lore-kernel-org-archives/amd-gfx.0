Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4777606A7BD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ir53l6w9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D41210E5B2;
	Tue,  3 Nov 2026 15:14:31 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1C10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 15:14:24 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-33bb5afa736so576021eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 07:14:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718864; cv=none;
 d=google.com; s=arc-20260327;
 b=lDiWcWqiza7iBWUcFmpC0KHu75IF7gVv4Lg+9F30ynt1qTn3+rhyN+lRLOBrsLoH8w
 c+Ir41v0zGtRT28zqKUo/njcYQj4mgtBAF/UFMSnF6OsofqMnRngRm+mlbTiik+RDl8c
 Z0NO0E72EB3iAUDSGULXwPrnQtiEWpFGG3X6f5fbrXnHdjfb4BNnWB597JZ5DhGYE8Tq
 COK6+OruSeP1eh8JN82x0LCuAOWwwITC9z+wql54c6yLMPz2aAMrRzbUhJGmgrujKUmh
 bpAR8Ur7Sn/gqzb6KrswZIa8Yudgo8MIdZKTCjVN99HwkZo8P2iwFjRambtHYlLeFos/
 Ia+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 fh=/cl6099kjSaq8hy7Z3qcaJagD8teqMoabGPSnfUfLeU=;
 b=jSMRwrM4Oy2l9k5h4yLxJLP4ga7o9tLpuHR/Jv26Pj0GAJEBJapUDuQshL03KAzqle
 n9qBA53DmgxTh8zvdox3D+PRQL44p33VTssZwBeabnP02JyNLfCKl23urvu+E4LZOsGN
 +fKzJrvN43M+H2MRLoBCk/ByATVZUTf4SKCXZ+qJPGKqLwYcuvyDatsY/Jk7DxE02bbp
 NhbOnokheHC1fwZz7jjlmnP3w0Gf1FCUSxPhsSMI7C055BHG73Fy39uuArOu2ykx+TyP
 2HaCCIahk1fAasO0GkogYvnlJB71dAowehYjENerM+/RXI/F0xCXfFoRO9y4m6rzBpcX
 tRoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793718864; x=1794323664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 b=ir53l6w9/hqWQJc+72c2dXNaE9fUOqD5yk1jC5i3ajNN+3A59OHRmDYHjpkzavn5p6
 abl2VEblxBaLmfxiBMdD3YwSKkkBQNhtDTgMDqrqR9AkkTpJTWr2LZnvFnYWXFys5zXm
 bQEF9xOBj+b5eIsC2C0soeytrJ+mjAxvtYXEySLybvTKkx9ZVxq0SOAA0hQEiN/BOrhr
 /6pL7nZAKoBUZ2nCPT1VN84nB3YKuzw+Xft/Vhnh5/9Ql48kW5QWmOHvjtyuAq7SbYbg
 tcH27bN00ayFJ34fYZIgKqsL2LaR4eBoJOj7a9xav163oaGt4Enuc1d2oXsn6o69Zeuc
 93Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718864; x=1794323664;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 b=1L/erCH3wNJhvNSAsfE/+JptuxynIP0Il7hY+kUG0sXaiRV6r21a2aPqkR7zBFa8Wv
 6fqaonhKBG7F4ATyvOl/AbAHTvKNSrH5A/S33grGZeG48R7z7i6Uraf2qLWC1xd7vvfC
 /0ukNSVi74GH2xys8lQXXWnCYQYtNWb/xpJDlfxiVrTEkmBmA8l+cH6Y14dGc7r68FFE
 3N0FKhXASgAT2fMK8a1VQlYG1LXGLibjjsTB1pwu6fkBcbvrd6pBGQ5WuEkuvo40jy+n
 MrsOerkUob8So3hKfUaXGtazlIX/GWCQESx4nNcpP1aiXOKB5Wl5nGVM+rO3jphC/07Z
 x1wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+Hcp+RwwWA2ZejsHdnVnh5CbdUj+VzmAWyK+lOQ7glYD6Fi0yknHJ9ylD+shJnq3ZEygBlHSd@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iFI3GVGnLQGPPU6+pnuxCGrXzU3JtqCmAo53ztryzpkCnEecb
 43Pkc8W/oTMBUudU3MwPfL48tqmaVyJPhD6NjQG/MdTScGOjBsbZoXozV3aG1NBnYjla6K5ySH7
 pdB98oUkctsqgB6ST0vTjbdeG4xBE5zc=
X-Gm-Gg: AYBFou3PlcwTjZSdxKOQElEUveAMjuP94vnhFytOV4YMddC30n2sPbUTkP8rSfzmjhA
 6+eP573akvxF5tP9irEKD2UsTD/v4ZJZf5CMng6VucJZlB0UfzkIoMoS+eoTmlH+S3o2nVCMZkS
 fejde8BQ4gtfg6sy7GKvrnfpBRkjZ470DsxQdzChuv5wGM6cDSq852Ne9WtYUfrq/yLKzdsYIXd
 umin0E1ps00vj+q7c5qwPA4wavSBdzD3pF3TOgm5WnZexQxBh9ovzpl+Zovcy/yq5q49ULYJYPN
 jKHTKQ8RC2fO+0Hhev40HzbcwHSeC+FbzQ8yYs1dTQHuXGQhF8H+HmToMmbYMEucWuIECzJMBpE
 FwMv3v2x1FNjYGzwScdCHGYYBUTUta8r2UjuD0D/ukGQksoZjnzqXCKYfNiOU9nsj/LwQacrOIh
 9y6dBhgz+g9Zj2UU60WUU8zOGR+VH/JkHLTGLUzV40bNw6
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr33315927c88.2.1793718864045; Tue, 03 Nov 2026
 07:14:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 10:14:12 -0500
X-Gm-Features: AclHuK8SYp_M16l6qppN00rSt898kW3_A2MyXrVqqWgCCOaDEzcq5A-8Uxrek04
Message-ID: <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dev@deq.rocks, 
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, kenneth.feng@amd.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 10:01=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > It is the same issue.  I don't want two fixes for the same issue. I
> > just sent an updated version of this patch expanded to cover more
> > macs.
> >
> > Alex
>
> How is the problems same exactly?, Does initializing UCLK later change th=
e
> PPTable?, and as said this is not even a solution for iMacs, so why are w=
e
> still trying to upstream this?, and btw initializing UCLK later with 5K,
> makes it not initialize at all, so the patch is just wrong.

I asked around internally with the windows team about this issue and
was told macs needed to enable UCLK DPM later, but no one was aware of
any uclk dpm patching.

Alex
