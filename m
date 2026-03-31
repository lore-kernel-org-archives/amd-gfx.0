Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54934109B487
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4335E10E942;
	Tue, 31 Mar 2026 14:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfwrA9fI";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A166810E942
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:55:33 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-56ba10b5f70so291431e0c.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968932; cv=none;
 d=google.com; s=arc-20240605;
 b=gN+UUXGLAWMeV/hJN2lJiXI/eTZNW3uNUiugYBpkBBv0Toq0NTir9CEzkabYJAPgAw
 l2J94Tww5mu4UsYpCfsP/7VEb0ZD0wKA3aXPjdyoo98XVAJ/tjQWIhfNh99inN641PCK
 wj8Jn086VQYI4X9g0JWvctY3fbxbXAzxs/vTFtywmJP2+VYrp/FvbhOBce3vKO2YTnGx
 lVnUBwLr2CGbMN9fpQ3bQXAdxdvJfmCNBvYci7IMYxQBPx8lCxclbEgs/MKIQIkIHrHd
 Xa4zKYHK/qGV6SqM35AFIQk5jqJqYd7R0DXekERYaoLENZredEOifv7o5urs4+lNY/ju
 z7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 fh=tH37BvykxlL/eqQ1ODqKhiCVU6G9fzfOPXP76UFeWlE=;
 b=GPLvBlop5lgiRG/n32IQjpxxGmbRcglD6m/Q8hECgWE/oA+2VERuxBjkF/2uGqxouC
 4opciUCWK4kq60T0MnIxGSQmA5+9AxGOnpfjYcPzhu9HosfD3lYkN/qH0FI9N63b1siW
 dFrk6pQH4j3GKpkd4kyrOY1aDqpNliNovia3ix+eyHpys9FkBv/MazRbp7u6iY7hDcw0
 2hodr6/i4EzE8jiyDTRNCWz+Nffy2gsogfsbEuGDZriuN12W4wk1IMSmtP6tPohVV9TH
 ACF6BxqPZmgdv0w1lk6cBwbtWeLeX3/X4RVkHfXOyv0BWu04y6vaQzQiOdDojOf0RpVu
 0BWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774968932; x=1775573732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 b=nfwrA9fIlGFs28aFdVXr7U+FF7AOvfbOT18eb8nxjLmf+znRX2YY4leXqsXEqQmcs1
 uoNoO45YqYd/6PV6M+Ziled4iCIDWPfJVTQxpvEtjzwHipmNyF6jH1JFshfoLQhPb0ZB
 zSloQTblht7MZDFecAyHB5GnU5ACUn6XsuW4WyZEyx8N5HEBjGUcAZ7iTHpNVrz6y1n2
 sN5ZuUCWPk/icpFT4buOu/fSsMurfngzO6uJ5EbXVUwzaXPA/2v6HEk4FJzruMoXkG2/
 /wXKUWOotvdM2rBezdLe3EZ53YRV1Y4pNf+qj73rqTnpChCusiWlUUvoNJmPQFb/WnTz
 ZOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968932; x=1775573732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 b=nMkOdH4/fFmirx2+Oyml9q8e2Rmed+w4WDUvrrGL7ED/IVezdPNpJr5dntpJOUiO9l
 29oq3n2H0tNn35VETLUkiq4Fzdo2d4rym6I+sHuoi7iRZeuxmH+U3xjfWvWU7pDNtrfa
 e0+o/u4ztlHEE6Jt8zkl9mcxPre56p7xvVGA3ax15SmkSFvCaL26fPGQRv5YqmU2+gM5
 C+pSrXmEhnSriqQ5H7BUeaaUZG3MZg3rHgqsVzfluuhGku/m8P/7/E4KGbJSP+vKlfOu
 bkU5qVOFYCUT8PjzAIYvcZl7gsZePrS4wTDn8SLdDF1BD69EQA1QyMY/ngOonJSbKRUb
 Modw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWynipSppc7r7HIKnRE64TYikHvxA4e4JjfL/y0y9ChitMKPRWN7P6Ta+3Blpd6H4tpORGdGc4Y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOWH7Dps4LIiMfjPuDlUziVF5puYBkvcMiTuS7Z8dA746zSngT
 CmC5o50PNo2n5ZLfBuFqBXZss+cVi5nFCdyqvQ+IL++6kSbqoT1z0ZhK8+lWMli0zENeTf0jtm0
 mhtE9bZeyFAwm1Asfb1BGfwET2F5/h7w=
X-Gm-Gg: ATEYQzyhrTHKqwz2WsWQxmSsKgA4Whgkgdxo1v6Ljyq3YqyE0k7oCbkFpv1skhhxbIB
 0kIH+1MvwUoK1vg8FMyct+/fW0Jq8gyK9jBNWP29la61bRr6n8b8y3QYuu2aSEDQjjzQQ82gCZF
 fU/L/teicsEkPzqN6+PITXXt5GiPWlTZgR4yS74AmFCN3K7OpkW9MTMUBfYVlCeIj8+zbgRj0mK
 TUyNkbv9FHhAxfHv27AWTpBUbwOOZjc0/hA1cApk+ltQhh9O/WxfT0jj7xE8czJdh4peNKdn+IH
 M9Lci9rM80VGZxlnl0rLp0VyaZn0pmK5RILTULaIcKhooXUVFXRj0EXd1aFlWnmlDeJU7wwfztq
 pbyz7
X-Received: by 2002:a05:6102:21ba:b0:602:7589:6536 with SMTP id
 ada2fe7eead31-604f8fd7c24mr2235805137.2.1774968932353; Tue, 31 Mar 2026
 07:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-2-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-2-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:55:20 -0400
X-Gm-Features: AQROBzAlliLpxduaovQB73KEGle6JGM5wuLvaBXl7gbMww3qmuvTovlmipmFmVE
Message-ID: <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Wed, Dec 24, 2025 at 10:06=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This patch continues the effort to refactor workqueue APIs, which has beg=
un
> with the changes introducing new workqueues and a new alloc_workqueue fla=
g:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The point of the refactoring is to eventually alter the default behavior =
of
> workqueues to become unbound by default so that their workload placement =
is
> optimized by the scheduler.
>
> Before that to happen after a careful review and conversion of each indiv=
idual
> case, workqueue users must be converted to the better named new workqueue=
s with
> no intended behaviour changes:
>
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
>
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can b=
e
> removed in the future.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd=
/amdgpu/aldebaran.c
> index daa7b23bc775..a7bc65099755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -179,7 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,
>         list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>                 /* For XGMI run all resets in parallel to speed up the pr=
ocess */
>                 if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                       if (!queue_work(system_unbound_wq,
> +                       if (!queue_work(system_dfl_wq,
>                                         &tmp_adev->reset_cntl->reset_work=
))
>                                 r =3D -EALREADY;
>                 } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 12201b8e99b3..2ee416c36ca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6173,7 +6173,7 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>                 list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
>                         /* For XGMI run all resets in parallel to speed u=
p the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                               if (!queue_work(system_unbound_wq,
> +                               if (!queue_work(system_dfl_wq,
>                                                 &tmp_adev->xgmi_reset_wor=
k))
>                                         r =3D -EALREADY;
>                         } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 28c4ad62f50e..9c4631608526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -116,7 +116,7 @@ static int amdgpu_reset_xgmi_reset_on_init_perform_re=
set(
>         /* Mode1 reset needs to be triggered on all devices together */
>         list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>                 /* For XGMI run all resets in parallel to speed up the pr=
ocess */
> -               if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_=
work))
> +               if (!queue_work(system_dfl_wq, &tmp_adev->xgmi_reset_work=
))
>                         r =3D -EALREADY;
>                 if (r) {
>                         dev_err(tmp_adev->dev,
> --
> 2.52.0
>
